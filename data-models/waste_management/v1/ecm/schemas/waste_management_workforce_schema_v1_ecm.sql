-- Schema for Domain: workforce | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`workforce` COMMENT 'Human capital management for all employees including drivers (CDL holders), technicians, MRF sorters, facility operators, environmental engineers, administrative staff, and management. Manages employee profiles, job assignments, certifications (OSHA, HAZWOPER, DOT medical), CDL tracking, training records, PPE assignments, scheduling, time and attendance, payroll, benefits, performance management, and workforce planning. Integrates with Workday HCM and SAP for labor cost allocation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee. Primary key for the employee master record and the single source of truth for workforce identity across all Waste Management systems.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager or supervisor. Establishes reporting hierarchy for organizational structure, approval workflows, and performance management.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Union member employees should link to the authoritative collective bargaining agreement that governs their employment terms, wages, benefits, and grievance rights. The union_local string field is the ',
    `cdl_class` STRING COMMENT 'Class of Commercial Driver License held by the employee (Class A, B, or C). Determines which vehicle types the driver is authorized to operate. Null or none for non-CDL employees.. Valid values are `class_a|class_b|class_c|none`',
    `cdl_endorsements` STRING COMMENT 'Comma-separated list of CDL endorsements held by the driver (e.g., H for Hazmat, N for Tank Vehicle, T for Double/Triple Trailers). Determines specialized vehicle and cargo authorization.',
    `cdl_expiration_date` DATE COMMENT 'Expiration date of the employees CDL. Critical for compliance monitoring and driver scheduling. Drivers cannot operate commercial vehicles with expired CDL. Null for non-CDL employees.',
    `cdl_license_number` STRING COMMENT 'Commercial Driver License number for employees operating commercial vehicles (ASL, FEL, REL trucks). Required for route drivers and subject to DOT compliance tracking. Null for non-driver employees.. Valid values are `^[A-Z0-9]{8,15}$`',
    `cost_center` STRING COMMENT 'Financial cost center code for labor cost allocation and budgeting. Links employee labor costs to specific business units, facilities, or operational areas in SAP FI/CO.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, retirement planning, and compliance with age-related labor regulations.',
    `department` STRING COMMENT 'Organizational department or functional unit to which the employee is assigned. Used for cost center allocation, reporting hierarchy, and organizational analytics.',
    `dot_medical_card_expiration_date` DATE COMMENT 'Expiration date of the DOT medical examiners certificate. Required for all CDL drivers. Drivers cannot operate commercial vehicles without valid medical certification. Null for non-CDL employees.',
    `eeo_classification` STRING COMMENT 'EEO-1 job category classification for federal reporting. Used for diversity analytics and compliance with EEOC reporting requirements. Examples include Officials and Managers, Professionals, Technicians, Service Workers, Laborers.',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for official business communications, system notifications, and digital identity management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employment_status` STRING COMMENT 'Current employment status of the employee. Determines access rights, payroll processing, benefits eligibility, and workforce planning calculations.. Valid values are `active|inactive|leave|suspended|terminated`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. Determines benefits eligibility, labor cost allocation, scheduling rules, and compliance with labor regulations.. Valid values are `full_time|part_time|seasonal|contractor|temporary|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in official employment records and government-issued identification documents.',
    `flsa_status` STRING COMMENT 'Classification of employee as exempt or non-exempt under FLSA. Determines overtime eligibility, minimum wage requirements, and timekeeping obligations.. Valid values are `exempt|non_exempt`',
    `hazwoper_certification_date` DATE COMMENT 'Date the employee completed HAZWOPER certification training. Used for tracking recertification requirements and compliance audits. Null if not HAZWOPER certified.',
    `hazwoper_certified` BOOLEAN COMMENT 'Indicates whether the employee holds valid HAZWOPER certification for handling hazardous waste. Required for employees working at TSDF facilities or handling hazmat materials.',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by Waste Management. Used for seniority calculations, benefits vesting, anniversary recognition, and tenure analytics.',
    `job_code` STRING COMMENT 'Standardized job classification code used for workforce planning, compensation analysis, and labor cost allocation. Maps to job families and career progression frameworks.. Valid values are `^[A-Z0-9]{4,10}$`',
    `job_family` STRING COMMENT 'Broad occupational category grouping similar roles together. Examples include Operations, Maintenance, Environmental Services, Administrative, Engineering, Management. Used for talent management and succession planning.',
    `job_title` STRING COMMENT 'Official job title or position name for the employee. Reflects role, responsibilities, and organizational hierarchy. Examples include CDL Driver, MRF Sorter, Landfill Operator, Environmental Engineer, Fleet Mechanic.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the employee as recorded in official employment records and government-issued identification documents.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee. May be null if not provided or not applicable.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the employee. Critical for field workforce (drivers, technicians, operators) for real-time dispatch, route communication, and emergency contact.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was last modified. Used for change tracking, audit trails, and data synchronization across systems.',
    `osha_10_certified` BOOLEAN COMMENT 'Indicates whether the employee has completed OSHA 10-hour safety training. Common baseline safety certification for operational employees.',
    `osha_30_certified` BOOLEAN COMMENT 'Indicates whether the employee has completed OSHA 30-hour safety training. Typically required for supervisors, managers, and safety personnel.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employee. Used for salary administration, compensation planning, and internal equity analysis. Confidential business data.. Valid values are `^[A-Z0-9]{2,6}$`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, scheduling communications, and operational coordination.',
    `preferred_name` STRING COMMENT 'Preferred or commonly used name for the employee in day-to-day business operations, communications, and system displays. May differ from legal name.',
    `sap_personnel_number` STRING COMMENT 'Employee personnel number in SAP S/4HANA system. Used for labor cost allocation, time management, and payroll integration across FI/CO modules.. Valid values are `^[0-9]{8}$`',
    `seniority_date` DATE COMMENT 'Date used for calculating seniority for union contracts, layoff protection, vacation accrual, and other seniority-based benefits. May differ from hire date due to breaks in service or transfers.',
    `social_security_number` STRING COMMENT 'U.S. Social Security Number for the employee. Used for tax reporting, payroll processing, benefits administration, and government compliance. Highly sensitive and subject to strict access controls.. Valid values are `^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for offboarding, final payroll processing, benefits termination, and workforce turnover analytics.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Used for turnover analysis, unemployment claims, and workforce planning. Null for active employees.. Valid values are `voluntary|involuntary|retirement|layoff|end_of_contract|death`',
    `union_member` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. Affects labor relations, collective bargaining agreement applicability, dues deduction, and grievance procedures.',
    `work_location` STRING COMMENT 'Primary work location or facility where the employee is based. May be a landfill, MRF, transfer station, fleet maintenance facility, or administrative office.',
    `workday_employee_code` STRING COMMENT 'External employee identifier from Workday HCM system. Used for integration and cross-system reconciliation with the system of record for HR, payroll, and talent management.. Valid values are `^[A-Z0-9]{6,12}$`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all Waste Management employees including CDL drivers (ASL/FEL/REL operators), MRF sorters, landfill operators, hazmat technicians, environmental engineers, fleet mechanics, and administrative staff. Stores personal identity, employment status, job classification, hire date, termination date, employment type (full-time, part-time, seasonal, contractor), EEO classification, seniority date, union membership flag, and Workday HCM employee ID. This is the SSOT for all workforce identity across the enterprise and the anchor entity for all workforce transactions.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`job_position` (
    `job_position_id` BIGINT COMMENT 'Unique identifier for the job position. Primary key for the job position entity.',
    `facility_id` BIGINT COMMENT 'Reference to the primary facility or work location where this position is based (e.g., MRF, landfill, transfer station, district office).',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or cost center where this position is budgeted and organizationally aligned.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the position that this position reports to in the organizational hierarchy. Null for top-level executive positions.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Job positions covered by union agreements should link to the authoritative CBA to ensure pay grades, job classifications, and seniority rules are consistent with negotiated terms. The union_code strin',
    `background_check_level` STRING COMMENT 'Level of pre-employment background screening required for the position. Basic includes criminal history, standard adds employment verification, enhanced adds credit and driving record checks.. Valid values are `none|basic|standard|enhanced`',
    `cdl_class_required` STRING COMMENT 'Specific CDL class required for the position. Class A for combination vehicles over 26,001 lbs; Class B for single vehicles over 26,001 lbs; Class C for vehicles carrying hazardous materials or 16+ passengers.. Valid values are `class_a|class_b|class_c|not_required`',
    `cdl_endorsements_required` STRING COMMENT 'Comma-separated list of required CDL endorsements (e.g., H for Hazardous Materials, N for Tank Vehicles, P for Passenger, T for Double/Triple Trailers). Empty if no endorsements required.',
    `cdl_required_flag` BOOLEAN COMMENT 'Indicates whether a valid Commercial Driver License is required for this position. True for driver roles operating commercial vehicles over 26,001 pounds.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system. Used for audit trail and data lineage.',
    `direct_reports_count` STRING COMMENT 'Number of employees who directly report to this position. Zero for individual contributor roles.',
    `dot_regulated_flag` BOOLEAN COMMENT 'Indicates whether the position is subject to DOT safety regulations including drug and alcohol testing, medical certification, and hours of service requirements.',
    `effective_end_date` DATE COMMENT 'Date when this position definition was closed or superseded. Null for currently active positions.',
    `effective_start_date` DATE COMMENT 'Date when this position definition became effective and available for hiring. Used for position history tracking and workforce planning.',
    `epa_certification_required` STRING COMMENT 'Comma-separated list of required EPA certifications (e.g., EPA Section 608 Refrigerant Handling, EPA Lead-Safe Certified, EPA Asbestos Abatement). Empty if no EPA certifications required.',
    `flsa_classification` STRING COMMENT 'Classification under the Fair Labor Standards Act determining overtime eligibility. Exempt positions are salaried and not eligible for overtime; non-exempt positions are hourly and eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `hazwoper_certification_required` STRING COMMENT 'Level of HAZWOPER training required under OSHA 29 CFR 1910.120 for positions handling hazardous waste. 8-hour for refresher, 24-hour for occasional site workers, 40-hour for regular hazardous waste operations.. Valid values are `hazwoper_8_hour|hazwoper_24_hour|hazwoper_40_hour|not_required`',
    `headcount_authorization` STRING COMMENT 'Number of authorized full-time equivalent (FTE) employees for this position. Used for workforce planning and budget management.',
    `job_family` STRING COMMENT 'Broad categorization of the position into functional job families for workforce planning and talent management. [ENUM-REF-CANDIDATE: operations|maintenance|environmental|administrative|management|safety|customer_service — 7 candidates stripped; promote to reference product]',
    `job_level` STRING COMMENT 'Hierarchical level of the position within the organization structure, used for career progression and compensation planning. [ENUM-REF-CANDIDATE: entry|intermediate|senior|lead|manager|director|executive — 7 candidates stripped; promote to reference product]',
    `last_modified_by` STRING COMMENT 'Username or employee identifier of the person who last modified this position record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last updated. Used for change tracking and data synchronization with SAP and other systems.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for the position. Used for recruiting and candidate screening.. Valid values are `high_school|associate|bachelor|master|doctorate|none`',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for the position. Zero for entry-level positions.',
    `osha_certification_required` STRING COMMENT 'Comma-separated list of required OSHA certifications (e.g., OSHA 10-Hour, OSHA 30-Hour, Confined Space Entry, Lockout/Tagout, Fall Protection). Empty if no OSHA certifications required.',
    `pay_grade` STRING COMMENT 'Compensation grade assigned to the position defining the salary range and benefits tier. Used for internal equity and market benchmarking.. Valid values are `^[A-Z]{1,2}[0-9]{1,2}$`',
    `physical_requirements` STRING COMMENT 'Description of physical demands of the position including lifting requirements, standing/walking duration, exposure to weather, and other physical capabilities needed (e.g., ability to lift 50 lbs, stand for 8+ hours, work in extreme temperatures).',
    `position_code` STRING COMMENT 'Unique business identifier for the position as defined in Workday HCM. Used for external reporting and integration with SAP.. Valid values are `^[A-Z0-9]{6,12}$`',
    `position_description` STRING COMMENT 'Detailed description of the position including key responsibilities, essential functions, and performance expectations. Used for job postings and performance management.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active positions are authorized for hiring; frozen positions are temporarily on hold; closed positions are eliminated; pending approval positions await budget authorization.. Valid values are `active|frozen|closed|pending_approval`',
    `position_title` STRING COMMENT 'Official job title for the position (e.g., Commercial Driver License (CDL) Driver - Automated Side Loader (ASL), Materials Recovery Facility (MRF) Sorter, Landfill Equipment Operator, Environmental Compliance Engineer).',
    `ppe_requirements` STRING COMMENT 'Comma-separated list of required Personal Protective Equipment for the position (e.g., hard hat, safety glasses, steel-toed boots, high-visibility vest, gloves, respirator, hearing protection).',
    `rcra_training_required_flag` BOOLEAN COMMENT 'Indicates whether the position requires RCRA hazardous waste management training for Treatment, Storage, and Disposal Facility (TSDF) operations.',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates whether the position is classified as safety-sensitive requiring enhanced drug and alcohol testing under DOT or company policy. Includes all CDL drivers, equipment operators, and hazardous waste handlers.',
    `shift_type` STRING COMMENT 'Standard shift pattern for the position. Day for regular business hours, night for overnight operations, rotating for positions that alternate shifts, on-call for emergency response roles, flexible for positions with variable schedules.. Valid values are `day|night|rotating|on_call|flexible`',
    `supervisory_flag` BOOLEAN COMMENT 'Indicates whether the position has direct supervisory responsibility for other employees including hiring, performance management, and disciplinary authority.',
    `travel_requirement_percentage` STRING COMMENT 'Percentage of time the position requires travel away from primary work location. 0 for no travel, 100 for full-time travel positions.',
    `union_position_flag` BOOLEAN COMMENT 'Indicates whether the position is covered by a collective bargaining agreement with a labor union.',
    `work_environment` STRING COMMENT 'Primary work environment for the position. Office for administrative roles, field for route drivers and technicians, facility for MRF and landfill operations, mixed for roles with both office and field responsibilities.. Valid values are `office|field|facility|mixed`',
    CONSTRAINT pk_job_position PRIMARY KEY(`job_position_id`)
) COMMENT 'Defines all authorized job positions within Waste Management including CDL driver roles (ASL, FEL, REL operators), MRF sorter, landfill equipment operator, HAZWOPER technician, environmental compliance engineer, fleet mechanic, dispatcher, and management roles. Captures job code, job family, FLSA classification (exempt/non-exempt), pay grade, required CDL class, required certifications, DOT-regulated flag, and headcount authorization. Sourced from Workday HCM position management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit within Waste Managements workforce hierarchy.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who serves as the responsible manager or director for this organizational unit. Used for organizational hierarchy, approval workflows, and accountability reporting.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy, enabling multi-level organizational structure representation from corporate down to facility level.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Organizational units with union representation should link to the authoritative collective bargaining agreement that governs labor relations in that unit. This ensures consistent application of wage s',
    `address_line_1` STRING COMMENT 'Primary street address of the organizational unit location. Used for facility identification, employee assignment, and operational logistics.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, building, or floor number for the organizational unit location.',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to this organizational unit in USD. Used for financial planning, cost control, and performance management. Includes labor, materials, and overhead costs.',
    `city` STRING COMMENT 'City where the organizational unit is located. Used for local labor market analysis and municipal compliance reporting.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the organizational unit operates. Supports multi-national workforce management and country-specific compliance requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for data lineage and audit trail purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for financial transactions and budget reporting for this organizational unit. Typically USD for U.S. operations.. Valid values are `^[A-Z]{3}$`',
    `current_headcount` STRING COMMENT 'Current number of active employees assigned to this organizational unit. Updated based on employee assignments and used for utilization analysis and staffing gap identification.',
    `dot_facility_number` STRING COMMENT 'Department of Transportation facility registration number for organizational units operating commercial motor vehicles. Required for fleet operations and CDL driver management. Null for non-fleet units.. Valid values are `^[A-Z0-9]{6,12}$`',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit ceased operations or when the current configuration ended. Null for currently active units. Used for historical reporting and organizational change tracking.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became operational or when the current configuration became effective. Used for historical workforce analysis and organizational change tracking.',
    `email_address` STRING COMMENT 'Primary email address for the organizational unit. Used for official communications and administrative correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `epa_facility_id` BIGINT COMMENT 'EPA-assigned facility identification number for organizational units that are regulated environmental facilities (landfills, MRFs, WTE plants, hazardous waste facilities). Used for environmental compliance reporting and permit tracking. Null for non-regulated units.',
    `facility_type` STRING COMMENT 'Specific facility classification for facility-level organizational units. MRF (Materials Recovery Facility) for recycling operations, landfill for waste disposal sites, transfer station for waste consolidation points, WTE (Waste-to-Energy) plant for energy conversion facilities, maintenance depot for fleet servicing, administrative office for non-operational locations, or not applicable for non-facility units. [ENUM-REF-CANDIDATE: mrf|landfill|transfer_station|wte_plant|maintenance_depot|administrative_office|not_applicable — 7 candidates stripped; promote to reference product]',
    `geographic_region` STRING COMMENT 'Primary geographic region where the organizational unit operates. Used for regional workforce planning, labor market analysis, and geographic performance reporting. [ENUM-REF-CANDIDATE: northeast|southeast|midwest|southwest|west|northwest|central|national — 8 candidates stripped; promote to reference product]',
    `headcount_capacity` STRING COMMENT 'Maximum number of employees that can be assigned to this organizational unit based on operational requirements, facility capacity, or budget constraints. Used for workforce planning and resource allocation.',
    `is_deleted` BOOLEAN COMMENT 'Soft delete indicator. True if this organizational unit record has been logically deleted but retained for historical reference, false for active records. Used for data retention and historical reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for change tracking, data quality monitoring, and audit trail purposes.',
    `operates_holidays` BOOLEAN COMMENT 'Indicates whether this organizational unit operates on recognized company holidays. True for essential operations (e.g., landfills, emergency response), false for units that close on holidays.',
    `operates_weekends` BOOLEAN COMMENT 'Indicates whether this organizational unit operates on Saturdays and Sundays. True for units with weekend operations (e.g., collection routes, 24/7 facilities), false for standard Monday-Friday operations.',
    `operating_hours_end` STRING COMMENT 'Standard daily end time for operations at this organizational unit in 24-hour HH:MM format. Used for shift scheduling, time and attendance rules, and operational planning.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]$`',
    `operating_hours_start` STRING COMMENT 'Standard daily start time for operations at this organizational unit in 24-hour HH:MM format. Used for shift scheduling, time and attendance rules, and operational planning.. Valid values are `^([0-1][0-9]|2[0-3]):[0-5][0-9]$`',
    `org_unit_status` STRING COMMENT 'Current operational status of the organizational unit. Active units are fully operational, inactive units are temporarily non-operational, planned units are approved but not yet operational, closed units are permanently shut down, and suspended units are temporarily halted pending review.. Valid values are `active|inactive|planned|closed|suspended`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the organizational unit. Used for internal communication and employee contact.. Valid values are `^+?[1-9]d{1,14}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the organizational unit location. Supports geographic analysis and local regulatory compliance.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `rcra_permit_number` STRING COMMENT 'RCRA permit number for organizational units handling hazardous waste. Required for TSDF (Treatment Storage and Disposal Facility) operations. Null for units not handling hazardous waste.. Valid values are `^[A-Z]{2}[0-9]{9,12}$`',
    `safety_zone_classification` STRING COMMENT 'OSHA-based safety risk classification for the organizational unit. Low risk for administrative offices, moderate risk for transfer stations, high risk for MRF and collection operations, hazardous for landfills and hazardous waste facilities. Determines PPE requirements, training protocols, and safety inspection frequency.. Valid values are `low_risk|moderate_risk|high_risk|hazardous`',
    `sap_cost_center_code` STRING COMMENT 'SAP FI/CO cost center code associated with this organizational unit for labor cost allocation, financial reporting, and budget tracking. Enables integration between workforce management and financial systems.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sap_profit_center_code` STRING COMMENT 'SAP FI/CO profit center code for revenue and profitability reporting at the organizational unit level. Used for P&L analysis and performance management.. Valid values are `^[A-Z0-9]{4,10}$`',
    `state_province_code` STRING COMMENT 'Two-letter state or province code where the organizational unit is primarily located. Used for state-level labor law compliance, tax reporting, and regulatory requirements.. Valid values are `^[A-Z]{2}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the organizational unit location (e.g., America/New_York, America/Chicago). Used for shift scheduling, time and attendance, and cross-regional coordination.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `union_representation` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are represented by a labor union. True for unionized units, false for non-union units. Used for labor relations, collective bargaining, and compliance with union agreements.',
    `unit_code` STRING COMMENT 'Business identifier code for the organizational unit used across operational systems and reporting. Typically aligns with SAP organizational unit codes.. Valid values are `^[A-Z0-9]{3,12}$`',
    `unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Northeast Region, Chicago MRF, Southern District).',
    `unit_type` STRING COMMENT 'Classification of the organizational unit within the hierarchy structure. Corporate represents headquarters, region covers geographic areas, district represents operational territories, facility includes MRF/landfill/transfer station/WTE plant locations, department covers functional groups, and cost center represents financial reporting units.. Valid values are `corporate|region|district|facility|department|cost_center`',
    `workday_org_code` STRING COMMENT 'Unique identifier for this organizational unit in the Workday HCM system. Used for integration between lakehouse and source HCM system for employee assignments, payroll, and workforce planning.. Valid values are `^[A-Z0-9_-]{6,30}$`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy for Waste Management workforce including business units, regions, districts, facilities (MRF, landfill, transfer station, WTE plant), and cost centers. Supports labor cost allocation to SAP FI/CO cost centers and enables workforce reporting by operational unit. Captures unit type, parent unit, facility type, geographic region, SAP cost center code, and responsible manager.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`employee_assignment` (
    `employee_assignment_id` BIGINT COMMENT 'Unique identifier for the employee assignment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'The SAP Financial Accounting (FI) cost center code to which labor costs for this assignment are allocated. Used for General Ledger (GL) posting and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `facility_id` BIGINT COMMENT 'Unique identifier for the primary facility where the employee is assigned to work. May reference a landfill, Materials Recovery Facility (MRF), transfer station, Waste-to-Energy (WTE) plant, collection district office, or administrative office.',
    `job_position_id` BIGINT COMMENT 'Unique identifier for the job position to which the employee is assigned. Links to position master data.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Employees are assigned to specific landfill sites for operational planning, shift scheduling, and labor cost allocation. Complements existing facility_id (asset domain) by providing landfill-specific ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Employees assigned to specific service offerings: hazmat technician to medical waste service, CDL driver to roll-off service. Drives crew scheduling, service delivery tracking, labor cost allocation b',
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit (department, division, or business unit) to which the employee is assigned. Used for reporting hierarchy and cost center allocation.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee being assigned. Links to the employee master record in Workday HCM.',
    `route_id` BIGINT COMMENT 'Unique identifier for the collection route assigned to the employee. Applicable for drivers and collection crew members. Null for non-route-based assignments.',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_schedule. Business justification: Employee assignments should link to the authoritative shift schedule definition to ensure consistency in shift timing, rotation patterns, and staffing requirements. The shift_pattern, shift_start_time',
    `assignment_notes` STRING COMMENT 'Free-text field for additional notes or special instructions related to this assignment. May include shift preferences, accommodation requirements, or temporary assignment details.',
    `assignment_reason` STRING COMMENT 'The business reason for creating or modifying this assignment. Used for workforce analytics and organizational change tracking. [ENUM-REF-CANDIDATE: new_hire|promotion|transfer|demotion|reorganization|temporary_coverage|seasonal_demand|return_from_leave — 8 candidates stripped; promote to reference product]',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the employee assignment indicating whether it is currently active, inactive, temporarily suspended, pending approval, or completed.. Valid values are `active|inactive|suspended|pending|completed`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating whether it is the employees primary role, a secondary assignment, temporary coverage, seasonal work, on-call duty, or relief assignment.. Valid values are `primary|secondary|temporary|seasonal|on_call|relief`',
    `cdl_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a valid Commercial Drivers License is required for this assignment. True for driver positions operating vehicles over 26,001 pounds or carrying hazardous materials.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `employment_type` STRING COMMENT 'Classification of the employment relationship for this assignment. Full-time for regular employees, part-time for reduced hours, temporary for fixed-term assignments, seasonal for peak period workers, contractor for non-employee labor.. Valid values are `full_time|part_time|temporary|seasonal|contractor`',
    `end_date` DATE COMMENT 'The date when the employee assignment ends or is scheduled to end. Null for open-ended assignments.',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act indicating whether the position is exempt or non-exempt from overtime pay requirements. Non-exempt positions are eligible for overtime pay.. Valid values are `exempt|non_exempt`',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent value for this assignment, typically 1.00 for full-time, 0.50 for half-time, etc. Used for workforce planning and headcount reporting.',
    `hazmat_endorsement_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a HAZMAT endorsement on the CDL is required for this assignment. True for drivers transporting hazardous waste or materials requiring placarding.',
    `job_code` STRING COMMENT 'The standardized job classification code for this assignment. Examples include codes for Commercial Drivers License (CDL) drivers, MRF sorters, landfill operators, environmental engineers, technicians, and administrative staff.. Valid values are `^[A-Z0-9]{4,12}$`',
    `job_title` STRING COMMENT 'The human-readable job title for this assignment. Examples: CDL Driver - Residential, MRF Sorter, Landfill Equipment Operator, Environmental Compliance Engineer, Fleet Maintenance Technician.',
    `labor_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the employees time allocated to this assignment, expressed as a decimal (e.g., 100.00 for full-time, 50.00 for half-time). Used for split assignments and labor cost allocation to multiple cost centers.',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this assignment record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this assignment record was last modified. Used for audit trail and change tracking.',
    `on_call_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is designated as on-call for this assignment. True indicates the employee must be available for emergency response outside regular shift hours.',
    `osha_training_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether specific OSHA safety training is required for this assignment. True for positions requiring OSHA 10-hour, 30-hour, or specialized training such as HAZWOPER (Hazardous Waste Operations and Emergency Response).',
    `pay_grade` STRING COMMENT 'The compensation grade or band assigned to this position. Used for salary administration and compensation planning. Confidential business data.. Valid values are `^[A-Z0-9]{1,6}$`',
    `ppe_assignment_code` STRING COMMENT 'Code identifying the standard Personal Protective Equipment package assigned to this position. Examples include codes for basic PPE (hard hat, safety vest, gloves), respiratory protection, fall protection, or specialized hazmat suits.. Valid values are `^[A-Z0-9]{2,8}$`',
    `rotation_type` STRING COMMENT 'Indicates the frequency at which the employees shift pattern rotates. None for fixed schedules, weekly/biweekly/monthly for standard rotations, custom for non-standard rotation patterns. Common in 24/7 landfill and WTE operations.. Valid values are `none|weekly|biweekly|monthly|custom`',
    `source_system` STRING COMMENT 'Identifier of the system of record from which this assignment data originated. Typically Workday HCM for HR assignments, SAP for cost center allocations, or manual for ad-hoc assignments.. Valid values are `workday|sap|manual|integration`',
    `source_system_code` STRING COMMENT 'The unique identifier for this assignment record in the source system. Used for data reconciliation and integration troubleshooting.',
    `start_date` DATE COMMENT 'The date when the employee assignment becomes effective. Used for workforce planning and labor cost allocation.',
    `union_code` STRING COMMENT 'Code identifying the labor union to which the employee belongs for this assignment. Null for non-union positions. Used for collective bargaining agreement compliance and labor relations reporting.. Valid values are `^[A-Z0-9]{2,8}$`',
    `work_area_code` STRING COMMENT 'Code identifying the specific work area or zone within a facility where the employee is assigned. Examples include landfill cell designation, MRF sorting line, maintenance bay, or administrative wing.. Valid values are `^[A-Z0-9]{2,8}$`',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this assignment record. Used for audit trail and accountability.',
    CONSTRAINT pk_employee_assignment PRIMARY KEY(`employee_assignment_id`)
) COMMENT 'Tracks the active and historical assignment of employees to specific job positions, org units, facilities, routes, and shift schedules. Captures assignment start/end dates, primary facility (landfill, MRF, transfer station, collection district), assigned route or work area, shift pattern (day/swing/night/split with start/end times, rotation type), days of week, reporting manager, on-call flag, and SAP labor cost allocation split. Enables workforce deployment tracking and 24/7 scheduling for landfill operations, MRF processing, collection routes, and WTE continuous operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`cdl_license` (
    `cdl_license_id` BIGINT COMMENT 'Unique identifier for the CDL license record in the Waste Management system.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this CDL license. Links to the employee master record in Workday HCM.',
    `cdl_class` STRING COMMENT 'The class of CDL license held by the driver. Class A allows operation of combination vehicles over 26,001 lbs GVWR; Class B allows single vehicles over 26,001 lbs; Class C allows vehicles designed to transport 16+ passengers or hazardous materials.. Valid values are `A|B|C`',
    `clearinghouse_query_date` DATE COMMENT 'The date of the most recent query to the FMCSA Drug and Alcohol Clearinghouse for this driver. Employers must query the clearinghouse annually and before hiring to check for drug and alcohol violations.',
    `clearinghouse_status` STRING COMMENT 'The drivers status in the FMCSA Drug and Alcohol Clearinghouse. Clear indicates no violations; violation_pending indicates unresolved violation; violation_resolved indicates completed return-to-duty process; prohibited indicates driver is not eligible to operate CMV.. Valid values are `clear|violation_pending|violation_resolved|prohibited`',
    `compliance_status` STRING COMMENT 'Current compliance status of the CDL license. Compliant indicates all requirements are met; non-compliant indicates missing or expired documentation; expiring_soon indicates renewal needed within 30 days; suspended or revoked indicates license is not valid for operation.. Valid values are `compliant|non_compliant|expiring_soon|suspended|revoked`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDL license record was first created in the Waste Management system. Used for audit trail and data lineage tracking.',
    `dot_medical_certificate_expiration_date` DATE COMMENT 'The expiration date of the drivers DOT medical examiner certificate. Drivers must maintain a valid medical certificate to operate commercial vehicles. Typically valid for 12-24 months depending on health conditions.',
    `driver_qualification_file_complete` BOOLEAN COMMENT 'Boolean flag indicating whether the drivers qualification file contains all required documents per FMCSA regulations (application, MVR, medical certificate, road test, etc.). True indicates complete; False indicates missing documentation.',
    `endorsements` STRING COMMENT 'Comma-separated list of CDL endorsements held by the driver. Common endorsements include H (Hazardous Materials), N (Tank Vehicle), T (Double/Triple Trailers), P (Passenger), S (School Bus). Critical for determining which routes and vehicles the driver is qualified to operate.',
    `expiration_date` DATE COMMENT 'The date the CDL license expires. Drivers must renew before this date to maintain DOT compliance. Typically renewed every 4-8 years depending on state regulations.',
    `fmcsa_registration_number` STRING COMMENT 'The drivers FMCSA registration number used for tracking in the FMCSA Motor Carrier Management Information System (MCMIS). Used for compliance monitoring and safety performance tracking.',
    `hazmat_endorsement_expiration_date` DATE COMMENT 'The expiration date of the HAZMAT endorsement (H endorsement). HAZMAT endorsements require TSA background checks and must be renewed every 5 years. Critical for drivers transporting hazardous waste.',
    `issue_date` DATE COMMENT 'The date the CDL license was originally issued or most recently renewed by the state DMV. Used to calculate license tenure and renewal cycles.',
    `issuing_state` STRING COMMENT 'Two-letter US state code of the state that issued the CDL license (e.g., CA, TX, NY). Required for DOT compliance and interstate commerce verification.. Valid values are `^[A-Z]{2}$`',
    `last_alcohol_test_date` DATE COMMENT 'The date of the drivers most recent alcohol test (random, post-accident, or reasonable suspicion). Used to track testing frequency and compliance with DOT requirements.',
    `last_alcohol_test_result` STRING COMMENT 'The result of the drivers most recent alcohol test. Negative indicates BAC below 0.02; positive indicates BAC at or above 0.02; refused indicates driver declined to test; cancelled indicates test was invalidated.. Valid values are `negative|positive|refused|cancelled`',
    `last_drug_test_date` DATE COMMENT 'The date of the drivers most recent drug test (random, pre-employment, post-accident, or reasonable suspicion). Used to track testing frequency and compliance with DOT requirements.',
    `last_drug_test_result` STRING COMMENT 'The result of the drivers most recent drug test. Negative indicates no substances detected; positive indicates prohibited substances detected; refused indicates driver declined to test; cancelled indicates test was invalidated.. Valid values are `negative|positive|refused|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this CDL license record was last updated in the Waste Management system. Used for audit trail and change tracking.',
    `last_mvr_check_date` DATE COMMENT 'The date of the most recent Motor Vehicle Record check performed for this driver. FMCSA requires annual MVR checks for all CDL holders to monitor driving violations and license status.',
    `last_road_test_date` DATE COMMENT 'The date of the drivers most recent road test or skills evaluation. Required for initial CDL qualification and may be repeated for new vehicle types or after extended absence from driving.',
    `last_road_test_result` STRING COMMENT 'The result of the drivers most recent road test. Passed indicates successful completion; failed indicates did not meet standards; waived indicates test was waived due to prior experience or equivalent certification.. Valid values are `passed|failed|waived`',
    `license_number` STRING COMMENT 'The unique CDL license number issued by the state Department of Motor Vehicles (DMV). This is the primary identifier on the physical license card and is used for DOT compliance verification.',
    `mvr_status` STRING COMMENT 'Summary status of the drivers most recent MVR check. Clear indicates no violations; violations_minor indicates minor infractions; violations_major indicates serious violations (DUI, reckless driving); suspended or revoked indicates license is not valid.. Valid values are `clear|violations_minor|violations_major|suspended|revoked`',
    `notes` STRING COMMENT 'Free-text field for additional notes or comments about the CDL license, such as pending renewals, special circumstances, or compliance issues requiring follow-up.',
    `random_drug_test_pool_status` STRING COMMENT 'Indicates whether the driver is currently enrolled in the DOT-mandated random drug and alcohol testing pool. All CDL holders performing safety-sensitive functions must be enrolled.. Valid values are `enrolled|not_enrolled|suspended`',
    `restrictions` STRING COMMENT 'Comma-separated list of restrictions on the CDL license (e.g., E - No Manual Transmission, L - No Air Brake Equipped Vehicles, O - No Tractor-Trailer, Z - No Full Air Brake). Defines operational limitations for the driver.',
    `self_certification_type` STRING COMMENT 'The type of driving the CDL holder has self-certified to perform. Non-excepted interstate is the most common for waste management drivers operating across state lines and subject to full FMCSA regulations.. Valid values are `non_excepted_interstate|excepted_interstate|non_excepted_intrastate|excepted_intrastate`',
    `serious_violations_count` STRING COMMENT 'The number of serious traffic violations (DUI, reckless driving, leaving the scene of an accident, etc.) recorded on the drivers MVR within the past 3 years. Two or more serious violations may result in disqualification.',
    `total_violations_count` STRING COMMENT 'The total number of traffic violations recorded on the drivers MVR within the past 3 years. Used for safety performance evaluation and driver qualification decisions.',
    `training_completion_date` DATE COMMENT 'The date the driver completed FMCSA-mandated Entry-Level Driver Training (ELDT) from a registered training provider. Required for all CDL applicants as of February 2022.',
    `training_provider_registry_number` STRING COMMENT 'The FMCSA registry number of the training provider that delivered the drivers Entry-Level Driver Training. Used to verify training was completed by an approved provider.',
    `verification_date` DATE COMMENT 'The date the CDL license information was last verified against state DMV records or FMCSA databases. Regular verification ensures data accuracy and compliance.',
    `verified_by` STRING COMMENT 'The name or user ID of the HR or safety staff member who last verified the CDL license information and compliance status. Used for audit trail and accountability.',
    CONSTRAINT pk_cdl_license PRIMARY KEY(`cdl_license_id`)
) COMMENT 'Tracks Commercial Driver License (CDL) credentials for all DOT-regulated drivers at Waste Management. Captures CDL class (A, B, C), endorsements (hazmat, tanker, doubles/triples), issuing state, license number, issue date, expiration date, DOT medical certificate expiration, random drug test pool enrollment status, and compliance status. Critical for DOT compliance and FMCSA regulatory requirements. Sourced from Workday HCM and cross-referenced with DOT FMCSA records.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the certification record. Primary key.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check or security clearance is required to obtain this certification (true for TSA hazmat endorsement, TWIC card) or not (false).',
    `cdl_class` STRING COMMENT 'For CDL certifications, specifies the license class (A, B, or C). Null for non-CDL certifications.. Valid values are `A|B|C`',
    `cdl_endorsement` STRING COMMENT 'For CDL endorsements, specifies the endorsement code (H=Hazmat, N=Tank, P=Passenger, S=School Bus, T=Double/Triple Trailers, X=Hazmat+Tank). Null for non-endorsement certifications.. Valid values are `H|N|P|S|T|X`',
    `certification_code` STRING COMMENT 'Unique alphanumeric code identifying the certification type (e.g., OSHA10, HAZWOPER40, CDL-A).. Valid values are `^[A-Z0-9]{4,20}$`',
    `certification_description` STRING COMMENT 'Detailed description of the certification including its purpose, scope, competencies covered, and business value to Waste Management operations.',
    `certification_name` STRING COMMENT 'Full official name of the certification (e.g., OSHA 10-Hour General Industry, HAZWOPER 40-Hour Initial Training, Commercial Driver License Class A).',
    `certification_status` STRING COMMENT 'Current lifecycle status of this certification in the company catalog: active (currently recognized and tracked), inactive (no longer offered but historical records exist), deprecated (being phased out), or pending_approval (under review for addition to catalog).. Valid values are `active|inactive|deprecated|pending_approval`',
    `certification_type` STRING COMMENT 'Category of the certification distinguishing between licenses, certifications, training completions, endorsements, and permits.. Valid values are `license|certification|training|endorsement|permit`',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or refresher training hours required per renewal period to maintain this certification. Null if no continuing education is required.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost in USD for an employee to obtain this certification, including training fees, exam fees, and application fees. Used for workforce planning and budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this certification was first recognized and added to the company certification catalog.',
    `end_date` DATE COMMENT 'Date when this certification was deprecated or removed from the active catalog. Null if still active.',
    `epa_program` STRING COMMENT 'For EPA certifications, specifies the relevant EPA program or regulation (e.g., RCRAInfo, Section 608 Refrigerant Handling, Asbestos Abatement). Null for non-EPA certifications.',
    `equipment_authorization` STRING COMMENT 'Comma-separated list of equipment types or asset classes that this certification authorizes the holder to operate (e.g., Forklift, Front End Loader, Automated Side Loader, MRF Sorting Line). Null if not equipment-specific.',
    `exam_required` BOOLEAN COMMENT 'Indicates whether an examination is required to obtain this certification (true) or if completion of training is sufficient (false).',
    `facility_type_authorization` STRING COMMENT 'Comma-separated list of facility types this certification authorizes work at (e.g., Landfill, MRF, Transfer Station, TSDF, WTE Facility). Null if not facility-specific.',
    `hazmat_category` STRING COMMENT 'For hazardous materials certifications, specifies the category or class of hazmat covered (e.g., RCRA Hazardous Waste, DOT Hazmat Transportation, EPA Universal Waste). Null for non-hazmat certifications.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this certification is legally or operationally required for specific job roles (true) or is optional/recommended (false).',
    `issuing_body` STRING COMMENT 'Name of the organization or agency that issues and governs this certification (e.g., OSHA, EPA, State DMV, NWRA, SWANA).',
    `issuing_body_type` STRING COMMENT 'Classification of the issuing authority level (federal agency, state agency, local authority, industry association, or internal company certification).. Valid values are `federal|state|local|industry|internal`',
    `job_family` STRING COMMENT 'Primary job family or role category for which this certification is relevant (e.g., Driver, Technician, MRF Sorter, Facility Operator, Environmental Engineer, Safety Officer).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated in the system.',
    `medical_exam_required` BOOLEAN COMMENT 'Indicates whether a medical examination is required to obtain or maintain this certification (true for DOT medical cards, respirator fit testing) or not (false).',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to pass the certification exam. Null if no exam is required or no minimum score is specified.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or exceptions related to this certification (e.g., state-specific variations, grandfathering provisions, reciprocity agreements).',
    `online_training_available` BOOLEAN COMMENT 'Indicates whether this certification can be obtained through online or remote training (true) or requires in-person attendance (false).',
    `osha_standard` STRING COMMENT 'For OSHA certifications, specifies the relevant OSHA standard or regulation (e.g., 29 CFR 1910.120 for HAZWOPER, 29 CFR 1910.146 for Confined Space). Null for non-OSHA certifications.',
    `prerequisite_certifications` STRING COMMENT 'Comma-separated list of certification codes that must be held before this certification can be obtained. Null if no prerequisites exist.',
    `regulatory_mandate` STRING COMMENT 'Identifies the primary regulatory framework that mandates this certification (DOT for commercial driving, OSHA for safety, EPA/RCRA for environmental, state for local requirements, or none if voluntary).. Valid values are `DOT|OSHA|EPA|RCRA|state|none`',
    `renewal_method` STRING COMMENT 'Method required to renew the certification: retraining course, examination, continuing education credits, application submission, or automatic renewal.. Valid values are `retraining|exam|continuing_education|application|automatic`',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal (true) or is valid indefinitely once obtained (false).',
    `training_hours_required` DECIMAL(18,2) COMMENT 'Number of training hours required to obtain this certification initially (e.g., 10 for OSHA 10-Hour, 40 for HAZWOPER 40-Hour). Null if no formal training hours are specified.',
    `training_provider` STRING COMMENT 'Name of the typical or preferred training provider or vendor for this certification (e.g., internal training department, external training company, community college). Null if multiple providers exist.',
    `validity_period_months` STRING COMMENT 'Standard duration in months that this certification remains valid from the date of issuance before renewal is required. Null if certification does not expire.',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Master catalog of all workforce certifications and licenses required or recognized at Waste Management. Includes OSHA 10/30, HAZWOPER 24/40-hour, DOT Hazmat Handler, EPA RCRAInfo, CDL endorsements, first aid/CPR, confined space entry, forklift operator, landfill operator certification, MRF equipment operator, and environmental engineer PE license. Captures certification name, issuing body, validity period, renewal requirements, and whether it is DOT/OSHA/EPA mandated.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`employee_certification` (
    `employee_certification_id` BIGINT COMMENT 'Unique identifier for the employee certification record. Primary key.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: employee_certification is the transactional record of certifications earned by employees. It currently has certification_type_code and certification_name as denormalized strings. The certification pro',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: Employee certifications fulfill compliance training requirements. Linking enables automated compliance verification, audit support demonstrating regulatory training completion, and alerts for expiring',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds this certification. Links to the employee master record in Workday HCM.',
    `certificate_number` STRING COMMENT 'Unique certificate or license number assigned by the issuing organization. Used for verification and audit purposes. May be a CDL number, OSHA card number, or training certificate ID.',
    `certification_level` STRING COMMENT 'Level or grade of the certification (e.g., Class A CDL, OSHA 10-Hour vs 30-Hour, HAZWOPER 24-Hour vs 40-Hour, Forklift Operator Level 1). Indicates scope of authorization.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Active indicates valid and compliant; expired requires renewal; suspended or revoked indicates regulatory action; pending or in_progress indicates training underway.. Valid values are `active|expired|suspended|revoked|pending|in_progress`',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the certification is currently in compliance (True) or non-compliant (False). Non-compliance may trigger work restrictions or mandatory training.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the certification training, examination, and issuance. Used for workforce development budgeting and cost allocation.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage.',
    `document_attachment_path` STRING COMMENT 'File path or URI to the scanned copy of the physical certification document, certificate, or license. Used for audit documentation and regulatory inspections.',
    `endorsements` STRING COMMENT 'Additional endorsements or qualifications associated with the certification (e.g., CDL Hazmat endorsement, Tanker endorsement, Air Brake restriction removal). Comma-separated list.',
    `exam_score` DECIMAL(18,2) COMMENT 'Score or percentage achieved on the certification examination, if applicable. Used to document competency and meet regulatory requirements.',
    `expiration_date` DATE COMMENT 'Date the certification expires and is no longer valid. Critical for compliance tracking and proactive renewal alerts. Null for certifications with no expiration.',
    `instructor_name` STRING COMMENT 'Name of the instructor or trainer who conducted the certification training program.',
    `issue_date` DATE COMMENT 'Date the certification was originally issued to the employee.',
    `issuing_organization` STRING COMMENT 'Name of the organization or authority that issued the certification (e.g., State DMV, OSHA Training Institute, National Safety Council, EPA-approved training provider).',
    `job_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory requirement for the employees current job role (True) or optional/supplemental (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated. Tracks changes to status, verification, or renewal information.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this certification record. Used for audit trail and accountability.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the certification must be renewed to maintain continuous compliance. Used for proactive scheduling of refresher training.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or contextual information about the certification (e.g., renewal pending, awaiting verification, special accommodations granted).',
    `passing_score_required` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to pass the certification examination.',
    `regulatory_authority` STRING COMMENT 'Primary regulatory body or authority governing this certification type (e.g., OSHA, DOT, EPA, State DMV, FMCSA). [ENUM-REF-CANDIDATE: OSHA|DOT|EPA|STATE_DMV|FMCSA|NFPA|ANSI|OTHER — 8 candidates stripped; promote to reference product]',
    `reimbursement_status` STRING COMMENT 'Status of employee reimbursement for certification costs, if applicable. Tracks whether the employee has been reimbursed for out-of-pocket training expenses.. Valid values are `not_applicable|pending|approved|reimbursed|denied`',
    `renewal_date` DATE COMMENT 'Date the certification was last renewed or recertified. Tracks ongoing compliance with periodic renewal requirements.',
    `restrictions` STRING COMMENT 'Any restrictions or limitations placed on the certification (e.g., corrective lenses required, automatic transmission only, daylight driving only). Comma-separated list.',
    `source_system` STRING COMMENT 'System of record from which this certification data originated (e.g., Workday HCM, SAP HCM, manual entry, external training provider import).. Valid values are `WORKDAY|SAP_HCM|MANUAL_ENTRY|EXTERNAL_IMPORT|TRAINING_LMS`',
    `training_completion_date` DATE COMMENT 'Date the employee completed the training course or examination required for this certification.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of training hours completed to earn this certification (e.g., 40 hours for HAZWOPER, 10 hours for OSHA General Industry). Used for compliance documentation and audit trails.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., facility name, city, online platform).',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that delivered the training program leading to this certification.',
    `verification_date` DATE COMMENT 'Date the certification was last verified with the issuing organization or regulatory authority.',
    `verification_status` STRING COMMENT 'Indicates whether the certification has been independently verified with the issuing authority. Critical for audit readiness and regulatory compliance.. Valid values are `verified|unverified|pending_verification|failed_verification`',
    `verified_by` STRING COMMENT 'Name or identifier of the person or system that performed the verification check.',
    CONSTRAINT pk_employee_certification PRIMARY KEY(`employee_certification_id`)
) COMMENT 'Transactional record of each certification earned, maintained, or expired for a Waste Management employee. Captures the employee, certification type, issuing organization, certificate number, issue date, expiration date, renewal date, verification status, and compliance flag. Enables proactive expiration alerts for HAZWOPER, CDL medical cards, and OSHA certifications. Supports regulatory audit trails for EPA, OSHA, and DOT inspections.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course. Primary key.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to workforce.certification. Business justification: Training courses that award certifications should link to the authoritative certification definition to ensure consistency in certification names, issuing bodies, validity periods, and regulatory mand',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: Training courses implement compliance training requirements. Linking enables curriculum mapping to regulatory mandates, gap analysis for training program completeness, and audit documentation showing ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for maintaining and updating this training course. Typically a subject matter expert, training manager, or department head.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Training courses in waste management are often facility-specific (landfill safety protocols, MRF equipment operation, transfer station procedures). Regulatory compliance (OSHA, EPA, RCRA) requires sit',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.service_line. Business justification: Training courses map to service line requirements: hazmat training for industrial services, CDL training for commercial collection. Drives compliance training planning, onboarding curriculum design, a',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or business unit that owns and manages this training course. Used for cost allocation and organizational reporting.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Safety training courses (LOTO, confined space, hazmat) are delivered under specific safety programs. Enables compliance reporting by program and ensures training aligns with program requirements per O',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether the training course requires a formal assessment, test, or examination for completion. True if assessment is mandatory; false if attendance or participation is sufficient.',
    `assessment_type` STRING COMMENT 'Type of assessment used to evaluate employee competency upon course completion. Written exam is paper or digital test; practical demonstration is hands-on skills evaluation; online quiz is digital assessment; skills test is field performance evaluation; observation is supervisor evaluation; none if no assessment required.. Valid values are `written_exam|practical_demonstration|online_quiz|skills_test|observation|none`',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education units (CEUs) or professional development hours awarded upon course completion. Used for professional license maintenance and career development tracking.',
    `cost_per_employee` DECIMAL(18,2) COMMENT 'Direct cost to train one employee in this course, including instructor fees, materials, facility rental, and external vendor charges. Used for training budget planning and cost allocation.',
    `course_category` STRING COMMENT 'High-level classification of the training course type. Safety includes OSHA and HAZWOPER; compliance includes DOT and EPA; technical includes equipment operation; operational includes route management and MRF processes; leadership includes management development; administrative includes software and business processes.. Valid values are `safety|compliance|technical|operational|leadership|administrative`',
    `course_code` STRING COMMENT 'Unique alphanumeric code identifying the training course in the learning management system. Used for registration, scheduling, and transcript tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the training course content, learning objectives, and outcomes. Used for course selection and compliance documentation.',
    `course_materials_description` STRING COMMENT 'Description of training materials, resources, and equipment required for course delivery. Examples: student workbook, safety manual, PPE kit, equipment simulator, online learning platform access.',
    `course_name` STRING COMMENT 'Full descriptive name of the training course as displayed in catalogs and employee portals.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course. Active courses are available for enrollment; inactive courses are temporarily unavailable; under development courses are being created; retired courses are no longer offered; suspended courses are on hold pending review.. Valid values are `active|inactive|under_development|retired|suspended`',
    `course_subcategory` STRING COMMENT 'Detailed classification within the course category. Examples: OSHA 10-Hour, HAZWOPER 40-Hour, CDL Class A, Defensive Driving, MRF Equipment Operation, Landfill Cell Management, Environmental Monitoring, Leadership Development.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_method` STRING COMMENT 'Method by which the training course is delivered to employees. Classroom is instructor-led in-person; online is eLearning; hybrid combines both; on-the-job is hands-on field training; webinar is live virtual; self-paced is asynchronous digital learning.. Valid values are `classroom|online|hybrid|on_the_job|webinar|self_paced`',
    `duration_days` DECIMAL(18,2) COMMENT 'Total calendar days required to complete the training course. Used for multi-day courses and scheduling employee availability.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the training course, measured in hours. Used for scheduling, labor cost planning, and compliance documentation.',
    `effective_end_date` DATE COMMENT 'Date when the training course was retired or discontinued. Null if the course is still active or available. Used for course lifecycle management and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date when the training course became available for employee enrollment and scheduling. Used for course lifecycle management and historical tracking.',
    `instructor_qualification_required` STRING COMMENT 'Qualifications, certifications, or credentials required for instructors who deliver this training course. Examples: Certified Safety Professional, OSHA Authorized Trainer, Subject Matter Expert with 5+ years experience.',
    `language_offered` STRING COMMENT 'Languages in which the training course is available. Comma-separated list of ISO 639-1 language codes. Examples: EN (English), ES (Spanish), FR (French). Used for multilingual workforce training compliance.',
    `last_content_review_date` DATE COMMENT 'Date when the training course content was last reviewed for accuracy, regulatory compliance, and relevance. Used for quality assurance and continuous improvement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the training course record was last updated in the system. Used for audit trail and change tracking.',
    `maximum_class_size` STRING COMMENT 'Maximum number of employees that can be enrolled in a single session of this training course. Used for scheduling, resource planning, and regulatory compliance (e.g., OSHA trainer-to-student ratios).',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to successfully complete the training course and receive certification. Used for assessment validation and compliance documentation.',
    `next_content_review_date` DATE COMMENT 'Scheduled date for the next review of training course content. Used for proactive course maintenance and regulatory compliance validation.',
    `online_learning_platform_url` STRING COMMENT 'Web address or link to the online learning platform where the course is hosted. Used for online and self-paced courses. Null for classroom-only courses.',
    `ppe_required_flag` BOOLEAN COMMENT 'Indicates whether Personal Protective Equipment is required for employees attending this training course. True if PPE is mandatory; false if not required.',
    `ppe_requirements` STRING COMMENT 'Specific PPE items required for employees attending this training course. Examples: hard hat, safety glasses, steel-toed boots, high-visibility vest, gloves, respirator.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before an employee can enroll in this course. Used for learning path sequencing and compliance validation.',
    `recertification_frequency_months` STRING COMMENT 'Number of months between required recertification or refresher training. Common values: 12 (annual), 24 (biennial), 36 (triennial). Null if recertification is not required.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the training course requires periodic recertification or renewal. True if recertification is mandatory; false if one-time completion is sufficient.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the training course is mandated by federal, state, or local regulation. True if required by law or regulation; false if voluntary or company policy.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, standard, or legal requirement that mandates this training. Examples: 29 CFR 1910.120 (HAZWOPER), 49 CFR Part 383 (CDL), 40 CFR Part 258 (Landfill Operations).',
    `target_job_roles` STRING COMMENT 'Comma-separated list of job roles or positions for which this training course is designed or required. Examples: CDL Driver, MRF Sorter, Landfill Operator, Environmental Engineer, Facility Manager, Technician.',
    `vendor_provider_name` STRING COMMENT 'Name of the external training vendor or provider if the course is delivered by a third party. Null if training is delivered internally by Waste Management staff.',
    `version_number` STRING COMMENT 'Version identifier for the training course content. Incremented when course materials, learning objectives, or regulatory requirements are updated. Format: major.minor (e.g., 2.1).. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master catalog of all training courses offered or required at Waste Management. Includes safety training (OSHA, HAZWOPER, PPE use), DOT driver training, defensive driving, MRF equipment operation, landfill operations, hazmat handling, environmental compliance, CDL pre-trip inspection, and leadership development. Captures course code, delivery method (classroom, online, on-the-job), duration hours, required frequency (annual, biennial, one-time), and regulatory mandate reference.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` (
    `workforce_training_record_id` BIGINT COMMENT 'Unique identifier for each training event completion record. Primary key for the workforce training record entity.',
    `training_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.training_requirement. Business justification: Training records demonstrate completion of compliance-mandated training. Linking is critical for regulatory audits (EPA, OSHA, DOT), automated compliance reporting, and tracking which employees have s',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training. Links to the employee master record in Workday HCM.',
    `training_course_id` BIGINT COMMENT 'Unique identifier of the training course or program completed. Links to the training course catalog.',
    `assessment_type` STRING COMMENT 'Type of assessment or evaluation method used to measure training effectiveness and employee competency.. Valid values are `written_exam|practical_test|observation|quiz|simulation|no_assessment`',
    `attempts_count` STRING COMMENT 'Number of attempts the employee made to pass the training assessment. Supports identification of training effectiveness issues.',
    `attendance_status` STRING COMMENT 'Indicates whether the employee attended the scheduled training session. Supports attendance tracking and no-show analysis.. Valid values are `attended|absent|partial|excused|no_show`',
    `certification_expiration_date` DATE COMMENT 'Date on which the certification or credential expires and requires renewal or refresher training. Null for non-expiring certifications.',
    `certification_issued` BOOLEAN COMMENT 'Indicates whether a formal certification or credential was issued upon successful completion of the training (True/False).',
    `certification_number` STRING COMMENT 'Unique certificate or credential number issued upon successful training completion. Null if no certification was issued.',
    `ceu_credits` DECIMAL(18,2) COMMENT 'Number of Continuing Education Unit credits earned for professional certification maintenance. Null if the course does not award CEU credits.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the training course. Used for compliance tracking and certification validity calculations.',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the training was completed, including time zone. Supports audit trail for online and instructor-led training.',
    `compliance_framework` STRING COMMENT 'Regulatory or internal policy framework that mandates or governs this training requirement. Supports compliance reporting and audit readiness. [ENUM-REF-CANDIDATE: osha|dot|epa_rcra|hazwoper|cdl|osha_10|osha_30|confined_space|lockout_tagout|ppe|bloodborne_pathogens|internal_policy — 12 candidates stripped; promote to reference product]',
    `cost_center` STRING COMMENT 'Cost center to which the training expense is allocated. Supports financial reporting and training budget analysis.',
    `course_code` STRING COMMENT 'Business identifier or catalog code for the training course (e.g., HAZWOPER-40, CDL-REFRESHER, OSHA-10).',
    `course_name` STRING COMMENT 'Full descriptive name of the training course or program completed by the employee.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost (e.g., USD, CAD). Supports multi-currency training expense tracking.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered to the employee. Supports analysis of training effectiveness by delivery channel. [ENUM-REF-CANDIDATE: classroom|online|on_the_job|blended|webinar|simulation|field_training|self_paced — 8 candidates stripped; promote to reference product]',
    `department` STRING COMMENT 'Department or business unit to which the employee belonged at the time of training. Supports departmental training compliance reporting.',
    `enrollment_date` DATE COMMENT 'Date on which the employee was enrolled or registered for the training course. Supports lead time analysis and training planning.',
    `instructor_name` STRING COMMENT 'Name of the instructor, facilitator, or training provider who delivered the course. Null for self-paced or automated training.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the training is mandatory for the employees role or job function (True) or optional/elective (False). Supports compliance tracking and workforce planning.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether the training must be repeated on a regular schedule (True) or is a one-time requirement (False). Used to trigger recertification workflows.',
    `job_role` STRING COMMENT 'Job role or position of the employee at the time of training completion (e.g., CDL Driver, MRF Sorter, Environmental Engineer, Facility Operator). Supports role-based training compliance analysis.',
    `next_due_date` DATE COMMENT 'Date by which the employee must complete refresher or recurrent training to maintain compliance. Calculated based on training frequency requirements (e.g., annual HAZWOPER refresher, biennial DOT medical exam).',
    `notes` STRING COMMENT 'Free-text notes or comments about the training event, including special circumstances, accommodations provided, or follow-up actions required.',
    `pass_fail_status` STRING COMMENT 'Outcome of the training event indicating whether the employee successfully passed, failed, or did not complete the course.. Valid values are `pass|fail|incomplete|waived|in_progress`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training course, expressed as a percentage. Used to determine pass/fail status.',
    `record_source` STRING COMMENT 'Source system or platform from which this training record originated (e.g., Workday HCM, external LMS, manual entry). Supports data lineage and integration troubleshooting.',
    `recurrence_frequency_months` STRING COMMENT 'Number of months between required training repetitions for recurring courses (e.g., 12 for annual, 24 for biennial). Null for non-recurring training.',
    `scheduled_date` DATE COMMENT 'Date on which the training session was originally scheduled to occur. May differ from completion_date if rescheduled or completed early/late.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score or grade achieved by the employee on the training assessment, typically expressed as a percentage (0.00 to 100.00). Null if no assessment was administered.',
    `training_category` STRING COMMENT 'High-level classification of the training type. Supports segmentation of training portfolio by business function and regulatory domain. [ENUM-REF-CANDIDATE: safety|compliance|technical|operational|leadership|cdl_qualification|hazmat|environmental|customer_service|equipment_operation — 10 candidates stripped; promote to reference product]',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the training event, including tuition, materials, travel, and instructor fees. Used for training ROI analysis and budget management.',
    `training_duration_days` STRING COMMENT 'Total number of calendar days over which the training was conducted (e.g., 5 for a week-long course, 1 for a single-day session).',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of hours credited for completing the training. Used for compliance reporting (e.g., OSHA annual training hours, DOT driver training hours) and workforce development metrics.',
    `training_location` STRING COMMENT 'Physical location or facility where the training was conducted. Null for online or remote training.',
    `training_provider` STRING COMMENT 'Name of the organization or platform that provided the training (e.g., internal Waste Management Learning Center, external vendor, online platform).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last modified. Supports change tracking and audit compliance.',
    CONSTRAINT pk_workforce_training_record PRIMARY KEY(`workforce_training_record_id`)
) COMMENT 'Transactional record of each training event completed by a Waste Management employee. Captures employee, course, completion date, training delivery method, instructor or platform, pass/fail result, score, hours credited, and next due date for recurring training. Supports OSHA recordkeeping requirements, DOT driver qualification file maintenance, and HAZWOPER annual refresher compliance tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique identifier for the shift schedule record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Shifts planned by service area to match collection routes and customer density. Drives route optimization, labor deployment, and service coverage planning. Essential for operational scheduling and ens',
    `cost_center_id` BIGINT COMMENT 'General Ledger (GL) cost center code for labor cost allocation. Links shift labor costs to specific facilities, routes, or business units.. Valid values are `^[A-Z0-9]{4,12}$`',
    `facility_id` BIGINT COMMENT 'Reference to the facility where this shift schedule applies (landfill, MRF, transfer station, WTE plant, or administrative office).',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Shift schedules for landfill operations are site-specific, driven by permitted operating hours, daily tonnage limits, and site-specific safety requirements. Linking to landfill.site enables staffing p',
    `route_id` BIGINT COMMENT 'Reference to the collection route assigned to this shift schedule, if applicable to route-based operations.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who supervises this shift (shift supervisor, route manager, facility manager).',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Shift schedules for union-covered positions should link to the authoritative CBA to ensure shift differential rates, overtime thresholds, and rotation patterns comply with negotiated terms. The union_',
    `break_duration_minutes` STRING COMMENT 'Total scheduled break time in minutes (lunch, rest breaks) as required by labor regulations and collective bargaining agreements.',
    `cdl_required_flag` BOOLEAN COMMENT 'Indicates whether a valid Commercial Driver License (CDL) is required for employees assigned to this shift. Critical for DOT compliance and driver scheduling.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift schedule record was first created in the system.',
    `days_of_week` STRING COMMENT 'Comma-separated list of days when this shift schedule is active (Mon, Tue, Wed, Thu, Fri, Sat, Sun). Supports 24/7 landfill and WTE operations as well as standard weekday collection schedules.. Valid values are `^(Mon|Tue|Wed|Thu|Fri|Sat|Sun)(,(Mon|Tue|Wed|Thu|Fri|Sat|Sun))*$`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total scheduled duration of the shift in hours, including any paid breaks. Used for labor cost allocation and Department of Transportation (DOT) hours-of-service compliance.',
    `effective_end_date` DATE COMMENT 'Date when this shift schedule expires or is replaced. Null for ongoing schedules. Supports historical tracking of schedule changes.',
    `effective_start_date` DATE COMMENT 'Date when this shift schedule becomes active. Supports seasonal schedule changes and operational adjustments.',
    `end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift in HH:mm format (24-hour clock). Includes expected return time for collection routes.',
    `hazwoper_required_flag` BOOLEAN COMMENT 'Indicates whether HAZWOPER certification is required for this shift, typically for hazardous waste handling operations and emergency response teams.',
    `headcount_capacity` STRING COMMENT 'Maximum number of employees that can be scheduled for this shift based on operational capacity, equipment availability, and safety requirements.',
    `job_classification` STRING COMMENT 'Employee job classification or role applicable to this shift (e.g., CDL Driver, MRF Sorter, Equipment Operator, Environmental Engineer, Facility Manager). Used for skill-based scheduling and labor cost allocation.',
    `minimum_staffing_level` STRING COMMENT 'Minimum number of employees required to operate this shift safely and meet service level agreements (SLAs). Critical for 24/7 landfill and WTE operations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift schedule record was last modified. Supports audit trail and change tracking for labor compliance.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, scheduling constraints, or operational considerations for this shift (e.g., holiday schedule variations, equipment dependencies, training requirements).',
    `osha_certification_required` STRING COMMENT 'Specific OSHA certifications required for this shift (e.g., Forklift Operator, Confined Space Entry, Lockout/Tagout). Comma-separated list if multiple certifications apply.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees on this shift are eligible for overtime pay under Fair Labor Standards Act (FLSA) regulations.',
    `ppe_requirements` STRING COMMENT 'Required Personal Protective Equipment (PPE) for this shift (e.g., hard hat, safety vest, steel-toe boots, respirator, gloves). Used for safety compliance and PPE inventory management.',
    `rotation_pattern` STRING COMMENT 'Description of the rotation pattern for rotating shifts (e.g., 2 weeks day / 2 weeks night, 4 on / 3 off). Null for fixed shifts.',
    `shift_code` STRING COMMENT 'Short alphanumeric code used to identify the shift in scheduling and payroll systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly pay rate for non-standard shifts (swing, night, weekend). Used for payroll calculation and labor cost allocation.',
    `shift_name` STRING COMMENT 'Descriptive name of the shift pattern (Day, Swing, Night, Split, Rotating, On-Call).. Valid values are `Day|Swing|Night|Split|Rotating|On-Call`',
    `shift_priority` STRING COMMENT 'Priority ranking for shift assignment when multiple shifts are available (1 = highest priority). Used in automated scheduling and employee preference matching.',
    `shift_schedule_status` STRING COMMENT 'Current lifecycle status of the shift schedule: Active (in use), Inactive (temporarily not used), Suspended (on hold), Seasonal (used during specific periods), or Archived (historical record).. Valid values are `Active|Inactive|Suspended|Seasonal|Archived`',
    `shift_type` STRING COMMENT 'Classification of the shift pattern: Fixed (same schedule daily), Rotating (alternates between shifts), On-Call (as-needed), Flex (variable hours), or Seasonal (temporary peak periods).. Valid values are `Fixed|Rotating|On-Call|Flex|Seasonal`',
    `start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift in HH:mm format (24-hour clock). For collection routes, this is the dispatch time from the facility.',
    `weather_dependent_flag` BOOLEAN COMMENT 'Indicates whether this shift schedule is subject to weather-related cancellations or modifications (e.g., landfill cover operations, outdoor collection routes).',
    `work_location_type` STRING COMMENT 'Type of work location where this shift operates: Landfill, Materials Recovery Facility (MRF), Transfer Station, Waste-to-Energy (WTE) Plant, Collection Route, Administrative Office, or Maintenance Yard. [ENUM-REF-CANDIDATE: Landfill|MRF|Transfer Station|WTE Plant|Collection Route|Administrative Office|Maintenance Yard — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Defines recurring shift patterns and work schedules for Waste Management operational roles. Captures shift name (Day, Swing, Night, Split), start time, end time, days of week, facility or route assignment, shift type (fixed, rotating, on-call), and applicable employee classifications. Supports scheduling for 24/7 landfill operations, MRF processing shifts, collection route start times, and WTE plant continuous operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for the time entry data product.',
    `cost_center_id` BIGINT COMMENT 'SAP cost center code to which this time entrys labor cost should be allocated. Enables financial reporting by business unit, facility, or operational area.',
    `employee_id` BIGINT COMMENT 'User ID of the person who last modified the time entry record. Used for audit trail and accountability.',
    `facility_id` BIGINT COMMENT 'Identifier for the facility where the employee worked during this time entry. Used for labor cost allocation to landfills, MRFs, transfer stations, or WTE facilities.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Time entries must be allocated to specific landfill sites for labor costing, project accounting, and operational reporting. Complements existing facility_id (asset domain) by providing landfill-specif',
    `pay_period_id` BIGINT COMMENT 'Identifier for the pay period to which this time entry belongs. Used for payroll processing and labor cost allocation.',
    `run_id` BIGINT COMMENT 'Identifier for the payroll run in which this time entry was processed. Used for payroll audit and reconciliation.',
    `primary_time_employee_id` BIGINT COMMENT 'Unique identifier for the employee who recorded this time entry. Links to employee master data in Workday HCM.',
    `route_id` BIGINT COMMENT 'Identifier for the collection route worked by the employee during this time entry. Applicable for drivers and collection crew. Used for route-level labor cost allocation.',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_schedule. Business justification: Time entries should link to the authoritative shift schedule definition to ensure accurate shift differential calculation, overtime threshold application, and labor cost allocation. The shift_type str',
    `work_order_id` BIGINT COMMENT 'Identifier for the work order or maintenance job performed during this time entry. Used for tracking labor hours on specific maintenance, repair, or project tasks.',
    `absence_code` STRING COMMENT 'Code indicating the reason for absence if the employee did not work. Examples include sick leave, vacation, personal time, FMLA, or unpaid leave.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved by the supervisor. Used for audit trail and payroll processing timeline tracking.',
    `break_time_minutes` STRING COMMENT 'Total break time in minutes taken during the shift. Includes meal breaks and rest periods as required by labor regulations and DOT HOS rules.',
    `cdl_hos_compliant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this time entry complies with DOT Hours of Service regulations for CDL drivers. Critical for regulatory compliance and driver safety.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked in or started their shift. Critical for DOT Hours of Service (HOS) compliance for CDL drivers.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The exact date and time when the employee clocked out or ended their shift. Used to calculate total hours worked and ensure DOT HOS compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor cost amount. Typically USD for Waste Management US operations.. Valid values are `^[A-Z]{3}$`',
    `driving_hours` DECIMAL(18,2) COMMENT 'Total hours spent driving during this time entry. Specific to CDL drivers and subject to DOT HOS daily and weekly driving limits.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate where the clock-in or clock-out occurred. Captured from mobile time entry or telematics for location verification.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate where the clock-in or clock-out occurred. Captured from mobile time entry or telematics for location verification.',
    `hazmat_work_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the employee performed hazardous waste handling during this time entry. Requires HAZWOPER certification and triggers additional safety protocols.',
    `hos_violation_code` STRING COMMENT 'Code indicating the specific DOT HOS violation if the time entry is non-compliant. Used for corrective action and regulatory reporting.',
    `job_code` STRING COMMENT 'Code representing the job or position the employee was performing during this time entry. May differ from employees primary job if working in a different capacity.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this time entry including base pay, overtime premium, shift differential, and benefits burden. Used for cost allocation to routes, facilities, and work orders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the time entry. May include explanations for exceptions, corrections, or special circumstances.',
    `off_duty_hours` DECIMAL(18,2) COMMENT 'Total hours the employee was off duty during the 24-hour period. Used for DOT HOS compliance to ensure adequate rest periods.',
    `on_duty_not_driving_hours` DECIMAL(18,2) COMMENT 'Total hours the employee was on duty but not driving. Includes pre-trip inspections, loading, unloading, and administrative tasks. Counts toward DOT HOS on-duty limits.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total number of overtime hours worked during this time entry. Subject to FLSA overtime pay requirements and DOT HOS limits for CDL drivers.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this time entry has been processed in payroll. Prevents duplicate payment and enables payroll reconciliation.',
    `ppe_issued_flag` BOOLEAN COMMENT 'Boolean flag indicating whether required PPE was issued and confirmed for this work shift. Critical for OSHA safety compliance.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total number of regular hours worked during this time entry, excluding overtime. Used for standard payroll calculation and labor cost allocation.',
    `sleeper_berth_hours` DECIMAL(18,2) COMMENT 'Total hours spent in sleeper berth during this time entry. Applicable for long-haul CDL drivers and used for DOT HOS compliance calculations.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the time entry for approval. Used for tracking submission timeliness and workflow analytics.',
    `time_entry_source` STRING COMMENT 'Source system or method by which the time entry was captured. Used for data quality assessment and audit purposes.. Valid values are `manual|biometric|mobile_app|telematics|system_generated`',
    `time_entry_status` STRING COMMENT 'Current workflow status of the time entry record. Tracks approval lifecycle from employee submission through payroll processing.. Valid values are `draft|submitted|approved|rejected|processed|corrected`',
    `time_entry_type` STRING COMMENT 'Classification of the time entry indicating the nature of time worked or absence. Used for payroll, benefits administration, and labor cost reporting. [ENUM-REF-CANDIDATE: regular|overtime|holiday|sick|vacation|bereavement|jury_duty|training — 8 candidates stripped; promote to reference product]',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Used for daily time tracking and attendance reporting.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Captures daily time and attendance records for all Waste Management employees. Records clock-in/clock-out timestamps, regular hours, overtime hours (DOT HOS compliance for CDL drivers), break time, absence codes, facility or route worked, and pay period. Integrates with Workday HCM time tracking and SAP FI/CO for labor cost allocation to collection routes, landfill cells, MRF operations, and WTE facilities. Supports DOT Hours of Service (HOS) compliance for CDL drivers.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`payroll_record` (
    `payroll_record_id` BIGINT COMMENT 'Unique identifier for the payroll record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'SAP cost center code to which labor costs are allocated. Format: CC followed by 6 digits.. Valid values are `^CC[0-9]{6}$`',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee receiving payroll. Links to employee master data in Workday HCM.',
    `tertiary_payroll_approved_by_user_employee_id` BIGINT COMMENT 'User ID of the manager or payroll supervisor who approved this payroll record. 8-character alphanumeric identifier.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was approved for payment.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'One-time or periodic bonus payments including performance bonuses, safety bonuses, and retention bonuses.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission earnings for sales or business development roles.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was first created in the system.',
    `dental_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution for dental insurance coverage deducted from gross pay.',
    `disability_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution for short-term or long-term disability insurance deducted from gross pay.',
    `federal_income_tax` DECIMAL(18,2) COMMENT 'Federal income tax withheld from gross pay based on employee W-4 elections.',
    `garnishment_deduction` DECIMAL(18,2) COMMENT 'Court-ordered wage garnishments for child support, tax levies, or other legal obligations.',
    `gl_account_code` STRING COMMENT 'SAP General Ledger account code for payroll expense posting. 6-digit numeric code.. Valid values are `^[0-9]{6}$`',
    `gross_pay` DECIMAL(18,2) COMMENT 'Total earnings before any deductions, including regular pay, overtime, hazard pay, shift differential, bonuses, and commissions.',
    `hazard_pay` DECIMAL(18,2) COMMENT 'Additional compensation for employees working in hazardous conditions, including HAZWOPER-certified roles and CDL hazmat operations.',
    `life_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution for life insurance coverage deducted from gross pay.',
    `medical_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution for medical insurance coverage deducted from gross pay.',
    `medicare_tax` DECIMAL(18,2) COMMENT 'Medicare tax withheld at 1.45% of gross wages with no wage base limit.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll record was last modified.',
    `net_pay` DECIMAL(18,2) COMMENT 'Take-home pay after all deductions, the amount deposited or paid to the employee.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding adjustments, corrections, or special circumstances for this payroll record.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked during the pay period, typically hours exceeding 40 per week for non-exempt employees.',
    `overtime_pay` DECIMAL(18,2) COMMENT 'Gross earnings from overtime hours, typically calculated at 1.5x the regular rate.',
    `pay_date` DATE COMMENT 'The date on which payment is issued to the employee.',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll record.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll record.',
    `payment_method` STRING COMMENT 'Method by which net pay is delivered to the employee: direct deposit to bank account, paper check, or payroll card.. Valid values are `direct_deposit|paper_check|payroll_card`',
    `payroll_status` STRING COMMENT 'Current processing status of the payroll record: draft (not yet processed), processed (calculated), posted (recorded in GL), paid (funds disbursed), voided (cancelled before payment), reversed (corrected after payment).. Valid values are `draft|processed|posted|paid|voided|reversed`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Total regular hours worked during the pay period, excluding overtime.',
    `regular_pay` DECIMAL(18,2) COMMENT 'Gross earnings from regular hours worked at the employees base rate.',
    `retirement_401k_deduction` DECIMAL(18,2) COMMENT 'Employee pre-tax or Roth contribution to 401(k) retirement plan deducted from gross pay.',
    `retirement_401k_employer_match` DECIMAL(18,2) COMMENT 'Employer matching contribution to employee 401(k) retirement plan.',
    `sap_posting_reference` STRING COMMENT 'SAP document number for the financial posting of this payroll record to the General Ledger. 10-digit numeric reference.. Valid values are `^[0-9]{10}$`',
    `shift_differential` DECIMAL(18,2) COMMENT 'Additional compensation for employees working non-standard shifts (evening, night, weekend).',
    `social_security_tax` DECIMAL(18,2) COMMENT 'Social Security tax withheld at 6.2% of gross wages up to the annual wage base limit.',
    `state_income_tax` DECIMAL(18,2) COMMENT 'State income tax withheld from gross pay based on state tax regulations and employee elections.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all deductions including taxes, benefits, union dues, and garnishments.',
    `union_dues_deduction` DECIMAL(18,2) COMMENT 'Union membership dues deducted from gross pay for employees covered by collective bargaining agreements.',
    `vision_insurance_deduction` DECIMAL(18,2) COMMENT 'Employee contribution for vision insurance coverage deducted from gross pay.',
    CONSTRAINT pk_payroll_record PRIMARY KEY(`payroll_record_id`)
) COMMENT 'Captures payroll processing and benefits enrollment records for each Waste Management employee. Includes gross pay, regular earnings, overtime pay, hazard pay differentials (HAZWOPER, CDL hazmat), shift differentials, benefit plan enrollments (medical, dental, vision, life, disability, 401k), employee/employer contribution amounts, coverage tier, deductions (benefits, garnishments, union dues), net pay, and SAP GL posting reference. Integrates Workday HCM payroll and benefits output with SAP FI/CO for labor cost allocation across operational cost centers.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique identifier for the benefit enrollment record.',
    `benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan in which the employee is enrolled. References the benefit plan catalog.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee enrolling in benefits. Links to the employee master record in Workday HCM.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Union benefit plans are governed by collective bargaining agreements. The union_local_number on benefit_enrollment should link to the authoritative union_agreement record to ensure benefit plan rules,',
    `annual_employee_contribution` DECIMAL(18,2) COMMENT 'Total annual employee contribution amount for this benefit plan in USD. Calculated based on per-period contribution and frequency.',
    `annual_employer_contribution` DECIMAL(18,2) COMMENT 'Total annual employer contribution amount for this benefit plan in USD. Calculated based on per-period contribution and frequency. Used for financial reporting and compliance.',
    `beneficiary_name` STRING COMMENT 'Full legal name of the primary beneficiary designated by the employee for life insurance or retirement benefits. Required for life insurance and 401(k) plans.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of the designated beneficiary to the employee. Used for life insurance and retirement plan beneficiary designation.. Valid values are `spouse|child|parent|sibling|domestic_partner|other`',
    `carrier_confirmation_number` STRING COMMENT 'Confirmation or policy number provided by the insurance carrier or benefit provider upon successful enrollment. Used for reconciliation and member services.',
    `cobra_election_date` DATE COMMENT 'Date on which the employee elected COBRA continuation coverage after a qualifying event. Nullable if COBRA was not elected.',
    `cobra_eligible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this enrollment is eligible for COBRA continuation coverage upon termination of employment. True if the plan qualifies for COBRA; false otherwise.',
    `cobra_end_date` DATE COMMENT 'Date on which COBRA continuation coverage ends. Typically 18 or 36 months after the qualifying event, depending on the event type. Nullable if COBRA is ongoing or was not elected.',
    `contribution_frequency` STRING COMMENT 'The frequency at which employee and employer contributions are deducted or paid. Aligns with the payroll cycle for the employees position.. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee, determining who is covered under the benefit plan (employee only, employee plus spouse, employee plus children, full family, or employee plus domestic partner).. Valid values are `employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit trail and data lineage.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this benefit enrollment. Applicable for family coverage tiers. Used for premium calculation and ACA reporting.',
    `effective_date` DATE COMMENT 'Date on which the benefit coverage becomes active and the employee is eligible to use the benefits. This is the start date of coverage.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount deducted from the employees paycheck per pay period for this benefit plan. Represents the employees share of the premium or contribution cost in USD.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount contributed by Waste Management per pay period for this benefit plan on behalf of the employee. Represents the employers share of the premium or contribution cost in USD.',
    `enrollment_confirmation_sent_date` DATE COMMENT 'Date on which the enrollment confirmation communication was sent to the employee. Used for audit trail and compliance with ERISA disclosure requirements.',
    `enrollment_date` DATE COMMENT 'Date on which the employee elected or enrolled in the benefit plan. This is the date the enrollment decision was made, which may differ from the effective date.',
    `enrollment_event_type` STRING COMMENT 'The triggering event that allowed or required the benefit enrollment. New hire indicates initial enrollment upon employment; annual open enrollment is the yearly election period; qualifying life event (QLE) includes marriage, birth, adoption, or other IRS-defined events; benefit change indicates mid-year plan modification; rehire indicates re-enrollment after returning to employment; leave of absence indicates enrollment during approved leave.. Valid values are `new_hire|annual_open_enrollment|qualifying_life_event|benefit_change|rehire|leave_of_absence`',
    `enrollment_method` STRING COMMENT 'Channel or method through which the employee completed the benefit enrollment. Online portal indicates self-service through Workday; paper form indicates manual submission; phone indicates telephonic enrollment; HR representative indicates assisted enrollment; automatic indicates system-generated enrollment; default indicates passive enrollment into default plan.. Valid values are `online_portal|paper_form|phone|hr_representative|automatic|default`',
    `enrollment_number` STRING COMMENT 'Human-readable enrollment confirmation number generated by Workday HCM for tracking and reference purposes.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the benefit enrollment. Active indicates coverage is in force; pending indicates awaiting approval or effective date; terminated indicates coverage has ended; suspended indicates temporary hold; waived indicates employee declined coverage; cancelled indicates enrollment was voided.. Valid values are `active|pending|terminated|suspended|waived|cancelled`',
    `evidence_of_insurability_required` BOOLEAN COMMENT 'Boolean flag indicating whether the employee must provide evidence of insurability (medical underwriting) for this enrollment. Typically required for supplemental life insurance above guaranteed issue amounts. True if EOI is required; false otherwise.',
    `evidence_of_insurability_status` STRING COMMENT 'Current status of the evidence of insurability review process. Not required if EOI is not needed; pending if submitted and under review; approved if underwriting accepted; denied if underwriting rejected; incomplete if additional information is needed.. Valid values are `not_required|pending|approved|denied|incomplete`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the HR representative or system user who last modified this enrollment record. Used for audit trail and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this enrollment record. Used for audit trail, change tracking, and data lineage.',
    `notes` STRING COMMENT 'Free-text field for HR representatives to capture additional context, special circumstances, or administrative notes related to this enrollment. Used for case management and audit documentation.',
    `plan_year` STRING COMMENT 'Calendar year or fiscal year for which this benefit enrollment is effective. Used for annual reporting, open enrollment tracking, and compliance (e.g., ACA 1095-C reporting).',
    `source_system` STRING COMMENT 'Name of the source system from which this enrollment record originated. Typically Workday HCM for benefit enrollments. Used for data lineage and integration troubleshooting.',
    `termination_date` DATE COMMENT 'Date on which the benefit coverage ends. Nullable for active enrollments. Populated when employee terminates employment, changes plans, or reaches plan end date.',
    `union_local_number` STRING COMMENT 'Identifier for the union local chapter governing this benefit plan, if applicable. Populated only when union_plan_indicator is true. Used for union reporting and compliance.',
    `union_plan_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this enrollment is for a union-negotiated benefit plan. True if the plan is governed by collective bargaining agreement; false otherwise. Relevant for drivers and facility operators covered by union contracts.',
    `waiver_date` DATE COMMENT 'Date on which the employee formally waived or declined the benefit coverage. Populated when enrollment_status is waived.',
    `waiver_reason` STRING COMMENT 'Free-text explanation provided by the employee for waiving or declining benefit coverage. Populated when enrollment_status is waived. Used for compliance documentation and audit purposes.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Tracks employee benefit plan enrollments at Waste Management including medical, dental, vision, life insurance, short/long-term disability, 401(k) with company match, and union benefit plans. Captures plan type, coverage tier (employee only, employee+spouse, family), enrollment date, effective date, termination date, employee contribution amount, and employer contribution amount. Sourced from Workday HCM benefits administration.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review or disciplinary action record.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Performance reviews assess employees against service area metrics: diversion rate achievement, customer satisfaction, route efficiency. Drives performance management, bonus calculation, and territory ',
    `cost_center_id` BIGINT COMMENT 'Cost center code for labor cost allocation associated with the employees position.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or work location where the employee is assigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed or subject to disciplinary action.',
    `tertiary_performance_hr_representative_employee_id` BIGINT COMMENT 'Identifier of the HR representative who reviewed or approved the performance review or disciplinary action.',
    `action_type` STRING COMMENT 'Specific action type for disciplinary records: performance review, verbal warning, written warning, final warning, suspension, or termination.. Valid values are `performance_review|verbal_warning|written_warning|final_warning|suspension|termination`',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee has filed an appeal or grievance regarding the performance review or disciplinary action.',
    `appeal_resolution_date` DATE COMMENT 'Date the appeal or grievance was resolved.',
    `appeal_status` STRING COMMENT 'Current status of the employees appeal or grievance: pending, under review, upheld, overturned, withdrawn, or not applicable.. Valid values are `pending|under_review|upheld|overturned|withdrawn|not_applicable`',
    `attendance_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees attendance and punctuality during the review period.',
    `corrective_action_due_date` DATE COMMENT 'Date by which the employee must complete the required corrective actions.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions required of the employee, including training, performance improvement plan, or behavioral changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review or disciplinary action record was first created in the system.',
    `customer_service_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees customer service performance, including customer feedback and complaint resolution.',
    `department_code` STRING COMMENT 'Code identifying the department or business unit where the employee works.',
    `employee_acknowledgment_date` DATE COMMENT 'Date the employee acknowledged the performance review or disciplinary action.',
    `employee_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged receipt and review of the performance review or disciplinary action document.',
    `employee_comments` STRING COMMENT 'Comments or feedback provided by the employee in response to the performance review or disciplinary action.',
    `job_classification` STRING COMMENT 'Job classification or title of the employee at the time of the review (e.g., Commercial Driver License (CDL) driver, MRF sorter, technician, facility operator).',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Recommended percentage increase for merit-based salary adjustment.',
    `merit_increase_recommended_flag` BOOLEAN COMMENT 'Indicates whether a merit-based salary increase is recommended based on the performance review.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance review or disciplinary action record was last modified.',
    `near_miss_reports_count` STRING COMMENT 'Number of near-miss safety incidents reported by the employee during the review period, demonstrating proactive safety awareness.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the performance review or disciplinary action.',
    `osha_recordable_incidents_count` STRING COMMENT 'Number of OSHA recordable incidents involving the employee during the review period.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned during the review: exceeds expectations, meets expectations, needs improvement, unsatisfactory, or not rated.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating, typically on a scale (e.g., 1.0 to 5.0).',
    `productivity_metric_unit` STRING COMMENT 'Unit of measure for the productivity metric: stops per hour, tons per day, work orders per day, calls per hour, or other role-specific unit.. Valid values are `stops_per_hour|tons_per_day|work_orders_per_day|calls_per_hour|other`',
    `productivity_metric_value` DECIMAL(18,2) COMMENT 'Quantitative productivity metric for the employees role: stops per hour for drivers, Tons Per Day (TPD) for Materials Recovery Facility (MRF) sorters, work orders completed for technicians, or other role-specific measures.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Indicates whether a promotion is recommended based on the performance review.',
    `quality_of_work_score` DECIMAL(18,2) COMMENT 'Score reflecting the quality and accuracy of the employees work output.',
    `review_date` DATE COMMENT 'Date the performance review or disciplinary action was conducted or issued.',
    `review_period_end_date` DATE COMMENT 'End date of the performance period being evaluated.',
    `review_period_start_date` DATE COMMENT 'Start date of the performance period being evaluated.',
    `review_status` STRING COMMENT 'Current status of the performance review or disciplinary action record: draft, submitted, approved, completed, appealed, or archived.. Valid values are `draft|submitted|approved|completed|appealed|archived`',
    `review_type` STRING COMMENT 'Type of performance review or action: annual review, mid-year review, probationary evaluation, project-based review, disciplinary action, or termination review.. Valid values are `annual|mid_year|probationary|project_based|disciplinary|termination`',
    `safety_performance_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees safety performance including Occupational Safety and Health Administration (OSHA) recordable incidents, near-miss reporting, Personal Protective Equipment (PPE) compliance, and adherence to safety protocols.',
    `teamwork_collaboration_score` DECIMAL(18,2) COMMENT 'Score reflecting the employees ability to work effectively with team members and contribute to a collaborative work environment.',
    `union_code` STRING COMMENT 'Code identifying the labor union the employee belongs to, if applicable.',
    `violation_description` STRING COMMENT 'Detailed description of the violation, incident, or performance deficiency that led to the disciplinary action.',
    `violation_type` STRING COMMENT 'Type of violation or deficiency for disciplinary actions: safety violation, attendance violation, conduct violation, performance deficiency, policy violation, Department of Transportation (DOT) violation, or other. [ENUM-REF-CANDIDATE: safety_violation|attendance_violation|conduct_violation|performance_deficiency|policy_violation|dot_violation|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Records all formal performance and conduct actions for Waste Management employees including annual/mid-year reviews, probationary evaluations, and progressive discipline (verbal warnings, written warnings, suspensions, terminations). Captures review period, action type, overall rating, safety performance score (OSHA recordable incidents, near-miss reporting), productivity metrics (stops per hour for drivers, TPD for MRF sorters), violation type if disciplinary, issuing supervisor, employee acknowledgment, appeal status, and merit/corrective action recommendation. Sourced from Workday HCM talent management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record. Primary key for the disciplinary action entity.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the incident occurred or where the employee is assigned. Used for site-level compliance tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who is the subject of the disciplinary action. Links to the employee master record in Workday HCM.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Disciplinary actions frequently result from safety incidents (PPE violations, unsafe acts). Links disciplinary outcomes to triggering incidents for progressive discipline tracking and incident follow-',
    `tertiary_disciplinary_approving_manager_employee_id` BIGINT COMMENT 'Employee identifier of the higher-level manager or HR representative who approved the disciplinary action. Required for suspensions and terminations.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Disciplinary actions for union employees must follow grievance procedures and due process rights defined in the collective bargaining agreement. Linking to the authoritative union_agreement ensures co',
    `acknowledgment_date` DATE COMMENT 'The date on which the employee signed or electronically acknowledged the disciplinary action. Null if employee refused to acknowledge.',
    `action_date` DATE COMMENT 'The date on which the formal disciplinary action was issued or taken. May differ from incident date due to investigation period.',
    `action_number` STRING COMMENT 'Business identifier for the disciplinary action, formatted as DA-YYYYMMDD followed by sequence. Used for external reference and tracking.. Valid values are `^DA-[0-9]{8}$`',
    `action_type` STRING COMMENT 'The type of disciplinary action taken following progressive discipline policy. Escalates from verbal warning through termination based on severity and recurrence.. Valid values are `verbal_warning|written_warning|final_warning|suspension|termination|demotion`',
    `appeal_date` DATE COMMENT 'The date on which the employee filed the appeal or grievance. Null if no appeal was filed. Starts the appeal resolution timeline.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal appeal or grievance of the disciplinary action through HR or union channels.',
    `appeal_outcome` STRING COMMENT 'Description of the final outcome of the appeal or grievance, including any modifications to the original disciplinary action. Null if no appeal or appeal still pending.',
    `appeal_resolution_date` DATE COMMENT 'The date on which the appeal or grievance was resolved. Null if appeal is still pending or no appeal was filed.',
    `appeal_status` STRING COMMENT 'Current status of the appeal or grievance process. Null if no appeal was filed. Tracks resolution progress through HR and union channels.. Valid values are `pending|under_review|upheld|overturned|modified|withdrawn`',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective actions or performance improvement plan required of the employee to avoid further discipline. May include training, counseling, or behavioral expectations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disciplinary action record was first created in the system. Audit trail for record creation.',
    `department_code` STRING COMMENT 'Code identifying the department or functional area where the employee works (e.g., collection operations, MRF, landfill, fleet maintenance). Used for departmental trend analysis.',
    `disciplinary_action_status` STRING COMMENT 'Current lifecycle status of the disciplinary action record. Active actions count toward progressive discipline; expired or overturned actions do not.. Valid values are `active|expired|overturned|superseded`',
    `dot_reportable_flag` BOOLEAN COMMENT 'Indicates whether the violation is reportable to DOT under FMCSR regulations (e.g., positive drug/alcohol test, HOS violation, safety-related termination). Triggers DOT clearinghouse reporting.',
    `eligible_for_rehire_flag` BOOLEAN COMMENT 'Indicates whether the terminated employee is eligible for future rehire. False for terminations involving serious violations (substance abuse, safety, theft). Checked during applicant screening.',
    `employee_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the employee has acknowledged receipt and review of the disciplinary action documentation. Required for progressive discipline documentation.',
    `employee_statement` STRING COMMENT 'Written statement or comments provided by the employee regarding the incident or disciplinary action. Captured for due process and appeal documentation.',
    `expiration_date` DATE COMMENT 'The date on which the disciplinary action expires and is no longer considered active for progressive discipline purposes. Typically 12-24 months from action date per policy.',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up review of employee performance or behavior following the disciplinary action. Used to track corrective action plan compliance.',
    `incident_date` DATE COMMENT 'The date on which the incident or violation that triggered the disciplinary action occurred. Critical for timeline tracking and progressive discipline sequencing.',
    `job_classification` STRING COMMENT 'The employees job classification or title at the time of the incident (e.g., CDL Driver, MRF Sorter, Equipment Operator, Environmental Engineer). Relevant for role-specific violation patterns.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the disciplinary action record was last modified. Audit trail for record updates, including appeal outcomes and status changes.',
    `notes` STRING COMMENT 'Additional notes, context, or administrative comments regarding the disciplinary action. May include legal review notes, HR guidance, or special circumstances.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident that triggered the disciplinary action is OSHA recordable (injury, illness, or fatality). Links disciplinary action to OSHA 300 log entry.',
    `paid_suspension_flag` BOOLEAN COMMENT 'Indicates whether the suspension is paid or unpaid. True for paid suspension (typically during investigation), false for unpaid disciplinary suspension.',
    `severity_level` STRING COMMENT 'Assessment of the severity of the violation based on safety impact, regulatory implications, and business disruption. Influences the appropriate disciplinary response.. Valid values are `minor|moderate|serious|critical`',
    `suspension_days` STRING COMMENT 'Total number of calendar days of suspension. Null for non-suspension actions. Used for progressive discipline tracking and payroll deduction calculation.',
    `suspension_end_date` DATE COMMENT 'The last date of suspension if the action type is suspension. Null for non-suspension actions. Employee is eligible to return to work the following day.',
    `suspension_start_date` DATE COMMENT 'The first date of suspension if the action type is suspension. Null for non-suspension actions. Used for payroll and attendance system integration.',
    `termination_date` DATE COMMENT 'The effective date of employment termination if the action type is termination. Null for non-termination actions. Triggers final payroll and benefits processing.',
    `termination_reason_code` STRING COMMENT 'Standardized code for the reason for termination (e.g., safety violation, substance abuse, job abandonment, performance). Used for unemployment claims and regulatory reporting.',
    `violation_category` STRING COMMENT 'High-level category of the violation that triggered the disciplinary action. Used for trend analysis and compliance reporting.. Valid values are `safety|dot_compliance|attendance|conduct|performance|substance_abuse`',
    `violation_description` STRING COMMENT 'Detailed narrative description of the specific incident or violation, including circumstances, location, witnesses, and any mitigating or aggravating factors. Critical for legal documentation.',
    `violation_type` STRING COMMENT 'Specific type of violation within the category (e.g., HOS violation, PPE non-compliance, unauthorized absence, insubordination, failed drug test). Provides granular detail for root cause analysis.',
    `witness_names` STRING COMMENT 'Names of witnesses to the incident, if any. Comma-separated list. Used for investigation documentation and potential corroboration.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Records formal disciplinary actions taken against Waste Management employees including verbal warnings, written warnings, suspensions, and terminations. Captures incident date, violation type (safety violation, DOT HOS violation, attendance, conduct, substance abuse), action type, action date, issuing supervisor, employee acknowledgment, appeal status, and resolution outcome. Supports progressive discipline tracking and DOT drug/alcohol violation management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` (
    `dot_drug_test_id` BIGINT COMMENT 'Unique identifier for the DOT-mandated drug and alcohol test event. Primary key for the dot_drug_test product.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee (CDL driver or safety-sensitive worker) who underwent the drug test. Links to the employee master record in Workday HCM.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the employee was assigned at the time of the test.',
    `incident_id` BIGINT COMMENT 'Identifier of the safety incident or accident that triggered a post-accident drug test, if applicable. Null for non-post-accident tests.',
    `cdl_license_number` STRING COMMENT 'The CDL license number of the employee at the time of the test. Required for all DOT-regulated drivers.',
    `cdl_state` STRING COMMENT 'State or jurisdiction that issued the employees CDL license.',
    `collection_site_address` STRING COMMENT 'Physical address of the collection site facility.',
    `collection_site_name` STRING COMMENT 'Name of the facility or clinic where the specimen was collected.',
    `collector_name` STRING COMMENT 'Name of the certified specimen collector who performed the collection procedure.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the test event. Compliant indicates the test was conducted and documented per DOT regulations; non-compliant indicates a violation occurred; pending review indicates the status is under evaluation; exempted indicates the employee was exempt from testing.. Valid values are `compliant|non-compliant|pending review|exempted`',
    `concentration_level` STRING COMMENT 'Measured concentration of detected substances in the specimen, typically expressed in ng/mL for drugs or BAC percentage for alcohol.',
    `cost_center_code` STRING COMMENT 'Cost center code to which the test expense is allocated for financial reporting and labor cost tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug test record was first created in the system.',
    `follow_up_testing_plan_flag` BOOLEAN COMMENT 'Indicates whether the employee is subject to a follow-up testing plan as prescribed by the SAP. True if follow-up plan is active; False otherwise.',
    `job_title` STRING COMMENT 'The employees job title or position at the time of the test (e.g., CDL Driver, MRF Sorter, Facility Operator).',
    `laboratory_certification_number` STRING COMMENT 'SAMHSA certification number of the laboratory that performed the analysis, ensuring the lab meets federal standards.',
    `laboratory_name` STRING COMMENT 'Name of the SAMHSA-certified laboratory that analyzed the specimen.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this drug test record was last modified or updated.',
    `mro_contact_phone` STRING COMMENT 'Phone number of the MRO for follow-up or verification inquiries.',
    `mro_name` STRING COMMENT 'Name of the licensed physician (Medical Review Officer) who reviewed and verified the test result.',
    `mro_review_date` DATE COMMENT 'Date on which the MRO completed the review and verification of the test result.',
    `mro_verification_status` STRING COMMENT 'Status of the MRO review process. Verified positive confirms a positive result after medical review; verified negative confirms no prohibited substances; verified refusal confirms employee refusal; pending indicates review in progress; cancelled by MRO indicates the MRO invalidated the test.. Valid values are `verified positive|verified negative|verified refusal|pending|cancelled by mro`',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special circumstances related to the drug test event.',
    `notification_date` DATE COMMENT 'Date on which the employee was notified of the requirement to undergo the drug or alcohol test.',
    `random_pool_selection_date` DATE COMMENT 'Date on which the employee was selected from the random testing pool, if the test type is random. Null for non-random tests.',
    `return_to_duty_clearance_date` DATE COMMENT 'Date on which the employee received clearance to return to safety-sensitive duties following a violation and successful completion of SAP requirements. Null if not applicable.',
    `safety_sensitive_position_flag` BOOLEAN COMMENT 'Indicates whether the employee holds a DOT-defined safety-sensitive position at the time of the test. True if safety-sensitive; False otherwise.',
    `sap_evaluation_status` STRING COMMENT 'Status of the SAP evaluation and treatment process. Not required if no violation occurred; pending if referral made but evaluation not started; in progress if employee is undergoing treatment; completed if SAP has cleared the employee for return-to-duty; not completed if employee has not fulfilled SAP requirements.. Valid values are `not required|pending|in progress|completed|not completed`',
    `sap_reference_code` STRING COMMENT 'Reference identifier linking this drug test record to the corresponding HR event or personnel action in SAP S/4HANA for payroll and labor cost allocation.',
    `sap_referral_date` DATE COMMENT 'Date on which the employee was referred to a Substance Abuse Professional following a violation. Null if no referral was made.',
    `sap_referral_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must be referred to a Substance Abuse Professional (SAP) as a result of the test outcome. True if SAP referral is required; False otherwise.',
    `specimen_code` STRING COMMENT 'Unique identifier assigned to the specimen by the collection site or laboratory to maintain chain of custody and traceability.',
    `specimen_type` STRING COMMENT 'Type of biological specimen collected for the test. Urine is standard for drug tests; breath is standard for alcohol tests; blood, saliva, and hair may be used in specific circumstances.. Valid values are `urine|breath|blood|saliva|hair`',
    `split_specimen_requested_flag` BOOLEAN COMMENT 'Indicates whether the employee requested analysis of the split specimen (Bottle B) after a positive result on the primary specimen (Bottle A). True if requested; False if not requested.',
    `split_specimen_result` STRING COMMENT 'Result of the split specimen analysis if requested. Confirmed means the split specimen also tested positive; not confirmed means the split specimen did not confirm the original positive; not tested means no split specimen test was performed; unavailable means the split specimen was not available for testing.. Valid values are `confirmed|not confirmed|not tested|unavailable`',
    `substances_detected` STRING COMMENT 'List of specific controlled substances or alcohol detected in the specimen if the test result was positive. May include marijuana, cocaine, opiates, amphetamines, PCP, or alcohol.',
    `test_date` DATE COMMENT 'The date on which the drug or alcohol test specimen was collected from the employee.',
    `test_reason_code` STRING COMMENT 'Internal code representing the specific reason or trigger for the test (e.g., annual random pool selection, post-accident protocol, supervisor observation).',
    `test_result` STRING COMMENT 'Final result of the drug or alcohol test. Negative indicates no prohibited substances detected; positive indicates presence of prohibited substances above cutoff levels; refusal indicates employee refused to test; cancelled indicates test was invalidated; invalid indicates specimen could not be tested.. Valid values are `negative|positive|refusal|cancelled|invalid`',
    `test_time` TIMESTAMP COMMENT 'The precise timestamp when the specimen collection occurred, including time zone information.',
    `test_type` STRING COMMENT 'Type of DOT-mandated drug or alcohol test conducted. Pre-employment tests are required before hiring; random tests are unannounced selections from the pool; post-accident tests follow qualifying incidents; reasonable suspicion tests are based on observed behavior; return-to-duty tests are required before reinstatement after a violation; follow-up tests are part of a monitoring program.. Valid values are `pre-employment|random|post-accident|reasonable suspicion|return-to-duty|follow-up`',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether the test result constitutes a DOT drug and alcohol program violation (positive result, refusal, or adulteration). True if violation occurred; False otherwise.',
    `workday_reference_code` STRING COMMENT 'Reference identifier linking this drug test record to the corresponding event or case in Workday HCM for HR tracking and compliance reporting.',
    CONSTRAINT pk_dot_drug_test PRIMARY KEY(`dot_drug_test_id`)
) COMMENT 'Tracks DOT-mandated drug and alcohol testing events for CDL drivers and safety-sensitive employees at Waste Management. Captures test type (pre-employment, random, post-accident, reasonable suspicion, return-to-duty, follow-up), test date, specimen type, laboratory, result (negative, positive, refusal, cancelled), MRO review status, and SAP/Workday reference. Mandatory under DOT 49 CFR Part 382 and FMCSA regulations for all CDL holders.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`job_requisition` (
    `job_requisition_id` BIGINT COMMENT 'Unique identifier for the job requisition record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which the positions labor costs will be allocated.',
    `facility_id` BIGINT COMMENT 'Reference to the facility or location where the position will be based (landfill, MRF, transfer station, office, etc.).',
    `job_position_id` BIGINT COMMENT 'Foreign key linking to workforce.job_position. Business justification: Job requisitions should link to the authoritative job position definition to ensure consistency in job requirements, qualifications, certifications, and compensation. The job_position_code and all req',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Requisitions opened to support new service offerings or service expansion. Drives growth planning, service launch staffing, and capacity expansion. Essential for aligning hiring pipeline with service ',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for this requisition.',
    `tertiary_job_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved the requisition (typically senior manager or HR director).',
    `approval_status` STRING COMMENT 'Approval status of the requisition by management and HR (pending, approved, rejected).. Valid values are `pending|approved|rejected`',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget amount for the position(s) covered by this requisition, typically annual salary or hourly rate budget.',
    `approved_headcount` STRING COMMENT 'Number of positions approved for hire under this requisition.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was approved.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved budget amount (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was first created in the system.',
    `department_code` STRING COMMENT 'Code identifying the department or organizational unit requesting the hire.',
    `education_level_required` STRING COMMENT 'Minimum education level required for the position (high school, associate degree, bachelor degree, master degree, doctorate, or none).. Valid values are `high_school|associate|bachelor|master|doctorate|none`',
    `filled_headcount` STRING COMMENT 'Number of positions that have been filled to date under this requisition.',
    `job_description` STRING COMMENT 'Detailed description of the job responsibilities, duties, and requirements.',
    `minimum_experience_years` STRING COMMENT 'Minimum number of years of relevant work experience required for the position.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was last modified.',
    `notes` STRING COMMENT 'Additional notes or comments about the requisition, hiring requirements, or special considerations.',
    `posting_channel` STRING COMMENT 'Channels where the job requisition is posted (e.g., company website, Indeed, LinkedIn, internal job board).',
    `priority_level` STRING COMMENT 'Priority level for filling this requisition (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `requisition_close_date` DATE COMMENT 'Date when the requisition was closed (filled, cancelled, or otherwise finalized).',
    `requisition_number` STRING COMMENT 'Business identifier for the job requisition, externally visible and used in recruiting workflows and communications.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_open_date` DATE COMMENT 'Date when the requisition was officially opened and made available for recruiting.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the job requisition (draft, open, on-hold, in-review, filled, cancelled, closed). [ENUM-REF-CANDIDATE: draft|open|on_hold|in_review|filled|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Type of requisition indicating the reason for the hire (backfill for departure, new headcount expansion, seasonal demand, temporary project, contractor conversion, internal transfer).. Valid values are `backfill|new_headcount|seasonal|temporary|contractor_conversion|internal_transfer`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum salary or hourly rate for the position.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum salary or hourly rate for the position.',
    `source_system` STRING COMMENT 'Source system from which this requisition record originated (e.g., Workday HCM).',
    `source_system_code` STRING COMMENT 'Unique identifier of this requisition in the source system.',
    `target_start_date` DATE COMMENT 'Desired start date for the new hire(s) to begin employment.',
    `work_location_type` STRING COMMENT 'Type of work location for the position (on-site at facility, field-based routes, remote office, hybrid).. Valid values are `on_site|field|remote|hybrid`',
    CONSTRAINT pk_job_requisition PRIMARY KEY(`job_requisition_id`)
) COMMENT 'Tracks open job requisitions for Waste Management workforce hiring. Captures requisition number, job position, org unit, facility, hiring manager, requisition type (backfill, new headcount, seasonal), required CDL class, required certifications (HAZWOPER, OSHA), target start date, approved headcount budget, requisition status (open, on-hold, filled, cancelled), and source system reference from Workday HCM recruiting module.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` (
    `labor_cost_allocation_id` BIGINT COMMENT 'Unique identifier for the labor cost allocation record.',
    `cost_center_id` BIGINT COMMENT 'SAP FI/CO cost center code to which the labor cost is allocated, representing the organizational unit or operational function.',
    `employee_id` BIGINT COMMENT 'User ID of the person or system process that created the labor cost allocation record.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (landfill, MRF, WTE plant, transfer station) to which labor costs are allocated.',
    `cell_id` BIGINT COMMENT 'Identifier of the specific landfill cell to which labor costs are allocated for cell management and operations.',
    `modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person or system process that last modified the labor cost allocation record.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Labor costs allocated to service offerings for profitability analysis. Drives service line P&L, pricing model validation, and cost-to-serve analysis. Essential for understanding true service profitabi',
    `primary_labor_employee_id` BIGINT COMMENT 'Identifier of the employee whose labor cost is being allocated.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route to which labor costs are allocated, applicable for drivers and collection crew.',
    `activity_type_code` STRING COMMENT 'SAP CO activity type code representing the type of work performed, such as collection, sorting, landfill operations, or maintenance.',
    `allocation_date` DATE COMMENT 'Date when the labor cost allocation was processed and recorded in the financial system.',
    `allocation_method` STRING COMMENT 'Method used to allocate labor costs to the cost object, such as direct assignment, percentage split, driver-based allocation, activity-based costing, or standard rate application.. Valid values are `direct|percentage|driver_based|activity_based|standard_rate`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the employees total labor cost allocated to this specific cost object, used when an employees time is split across multiple cost centers or activities.',
    `allocation_status` STRING COMMENT 'Current status of the labor cost allocation record in the approval and posting workflow.. Valid values are `draft|pending_approval|approved|posted|rejected|reversed`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the labor cost allocation was approved for posting to the financial system.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit (residential collection, commercial collection, recycling, landfill, hazardous waste) for segment reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the labor cost allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor cost amounts. Waste Management primarily operates in USD.. Valid values are `USD`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year to which the labor cost allocation applies.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the labor cost allocation applies for financial reporting and period closing.',
    `gl_account_code` STRING COMMENT 'SAP FI General Ledger account code to which the labor cost is posted for financial reporting.',
    `hazard_pay_amount` DECIMAL(18,2) COMMENT 'Additional pay amount for working in hazardous conditions such as handling hazardous waste or working in confined spaces.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total hours worked by the employee during the pay period that are being allocated to the cost object.',
    `internal_order_number` STRING COMMENT 'SAP FI/CO internal order number used for tracking costs related to specific activities or initiatives.',
    `job_classification` STRING COMMENT 'Job classification or title of the employee whose labor is being allocated, such as CDL driver, MRF sorter, equipment operator, or environmental engineer.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate applied to calculate the labor cost for this allocation, including base wage and loaded costs such as benefits and taxes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the labor cost allocation record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context or explanation for the labor cost allocation, such as special circumstances or adjustments.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked during the pay period.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Labor cost amount for overtime hours worked.',
    `pay_period_end_date` DATE COMMENT 'End date of the pay period for which labor costs are allocated.',
    `pay_period_start_date` DATE COMMENT 'Start date of the pay period for which labor costs are allocated.',
    `profit_center_code` STRING COMMENT 'SAP FI/CO profit center code representing the business unit or segment for EBITDA reporting and profitability analysis.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked during the pay period, excluding overtime.',
    `regular_pay_amount` DECIMAL(18,2) COMMENT 'Labor cost amount for regular hours worked, excluding overtime and premium pay.',
    `sap_posting_reference` STRING COMMENT 'SAP FI/CO document number or posting reference generated when the labor cost allocation is posted to the financial system.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional pay amount for working non-standard shifts such as night, weekend, or holiday shifts.',
    `total_labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost allocated to the cost object, calculated as hours worked multiplied by labor rate.',
    `union_code` STRING COMMENT 'Code identifying the labor union to which the employee belongs, if applicable, for labor cost analysis by union contract.',
    `wbs_element` STRING COMMENT 'SAP PS Work Breakdown Structure element for capital projects to which labor costs are allocated, enabling project cost tracking.',
    `work_order_number` STRING COMMENT 'Work order number to which labor costs are allocated for maintenance, repair, or project activities.',
    CONSTRAINT pk_labor_cost_allocation PRIMARY KEY(`labor_cost_allocation_id`)
) COMMENT 'Records the allocation of employee labor costs to SAP FI/CO cost objects including collection routes, landfill cells, MRF processing lines, WTE facility cost centers, and overhead pools. Captures employee, pay period, hours worked, labor rate, total labor cost, SAP cost center, SAP WBS element (for capital projects), activity type, and allocation percentage. Enables COGS analysis by operational function and supports EBITDA reporting by business unit.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`union_agreement` (
    `union_agreement_id` BIGINT COMMENT 'Unique identifier for the collective bargaining agreement record.',
    `agreement_number` STRING COMMENT 'Unique business identifier or contract number assigned to this collective bargaining agreement for tracking and reference purposes.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the collective bargaining agreement indicating its operational state and validity.. Valid values are `draft|pending_ratification|active|expired|terminated|under_negotiation`',
    `agreement_type` STRING COMMENT 'Classification of the collective bargaining agreement indicating its scope and nature within the labor relations framework.. Valid values are `master|local|supplemental|memorandum_of_understanding|side_letter`',
    `arbitration_provision_flag` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement includes binding arbitration as the final step in the grievance resolution process.',
    `bargaining_unit_size` STRING COMMENT 'Total number of employees represented by this collective bargaining agreement at the time of ratification or most recent count.',
    `base_wage_rate_maximum` DECIMAL(18,2) COMMENT 'Maximum hourly base wage rate in US dollars (USD) for the highest tier or most senior position covered under this agreement.',
    `base_wage_rate_minimum` DECIMAL(18,2) COMMENT 'Minimum hourly base wage rate in US dollars (USD) for the lowest tier or entry-level position covered under this agreement.',
    `cdl_premium_rate` DECIMAL(18,2) COMMENT 'Additional hourly pay rate in US dollars (USD) for employees holding a valid Commercial Driver License (CDL) as defined in the collective bargaining agreement.',
    `covered_job_classifications` STRING COMMENT 'Comma-separated list or description of job classifications, titles, and positions covered under this collective bargaining agreement (e.g., Commercial Driver License (CDL) drivers, Material Recovery Facility (MRF) sorters, equipment operators, facility workers).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collective bargaining agreement record was first created in the system.',
    `document_attachment_path` STRING COMMENT 'File system path or document management system reference to the full signed collective bargaining agreement document and any amendments or side letters.',
    `double_time_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked per day or per week after which double-time rates apply according to the collective bargaining agreement provisions.',
    `effective_date` DATE COMMENT 'Date on which the collective bargaining agreement becomes binding and enforceable for all covered employees and management.',
    `expiration_date` DATE COMMENT 'Date on which the collective bargaining agreement terminates and requires renegotiation or renewal.',
    `grievance_filing_deadline_days` STRING COMMENT 'Maximum number of calendar days after an alleged contract violation within which an employee or union must file a formal grievance to preserve their rights under the collective bargaining agreement.',
    `grievance_procedure_steps` STRING COMMENT 'Total number of formal steps defined in the grievance resolution procedure outlined in the collective bargaining agreement before arbitration.',
    `hazard_pay_rate` DECIMAL(18,2) COMMENT 'Additional hourly pay rate in US dollars (USD) for employees working in hazardous conditions or handling hazardous materials as defined in the collective bargaining agreement.',
    `health_insurance_employer_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of health insurance premium costs that the employer agrees to contribute for covered employees under the collective bargaining agreement.',
    `lead_negotiator_name` STRING COMMENT 'Full name of the primary management representative who led negotiations for this collective bargaining agreement.',
    `management_rights_clause_flag` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement includes a management rights clause reserving certain operational decisions to management discretion.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collective bargaining agreement record was last modified or updated in the system.',
    `negotiation_completion_date` DATE COMMENT 'Date on which negotiations concluded and a tentative agreement was reached between management and union representatives.',
    `negotiation_start_date` DATE COMMENT 'Date on which formal negotiations for this collective bargaining agreement commenced between management and union representatives.',
    `no_strike_clause_flag` BOOLEAN COMMENT 'Indicates whether the collective bargaining agreement includes a no-strike clause prohibiting work stoppages during the term of the agreement.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or contextual information about the collective bargaining agreement not captured in structured fields.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base wage rate for overtime hours worked (e.g., 1.5 for time-and-a-half, 2.0 for double-time) as defined in the collective bargaining agreement.',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked per day or per week after which overtime rates apply according to the collective bargaining agreement provisions.',
    `paid_holidays_count` STRING COMMENT 'Number of paid holidays per year guaranteed to covered employees under the collective bargaining agreement.',
    `paid_time_off_accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which covered employees accrue paid time off hours per hour worked or per pay period as defined in the collective bargaining agreement.',
    `pension_employer_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of employee wages or fixed dollar amount per hour that the employer contributes to the pension plan for covered employees.',
    `pension_plan_type` STRING COMMENT 'Type of retirement pension plan provided to covered employees under the collective bargaining agreement.. Valid values are `defined_benefit|defined_contribution|multi_employer|none`',
    `probationary_period_days` STRING COMMENT 'Number of calendar days that a newly hired employee must complete before gaining full union membership rights and seniority accrual under the collective bargaining agreement.',
    `ratification_date` DATE COMMENT 'Date on which the union membership voted to approve and ratify the collective bargaining agreement.',
    `seniority_system_type` STRING COMMENT 'Type of seniority system defined in the collective bargaining agreement that governs bidding rights, layoff order, recall rights, and shift preferences.. Valid values are `company_wide|facility_based|classification_based|hybrid`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly pay rate in US dollars (USD) for employees working non-standard shifts (evening, night, weekend) as defined in the collective bargaining agreement.',
    `union_dues_deduction_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount or percentage of wages deducted from covered employee paychecks for union membership dues as authorized in the collective bargaining agreement.',
    `union_dues_deduction_frequency` STRING COMMENT 'Frequency at which union dues are deducted from covered employee paychecks as specified in the collective bargaining agreement.. Valid values are `weekly|biweekly|monthly|per_pay_period`',
    `union_local_number` STRING COMMENT 'Local chapter or affiliate number of the union representing the specific bargaining unit (e.g., Local 174, Local 1021).',
    `union_name` STRING COMMENT 'Full legal name of the labor union or labor organization representing the employees (e.g., International Brotherhood of Teamsters, Service Employees International Union, International Union of Operating Engineers).',
    `union_representative_name` STRING COMMENT 'Full name of the primary union representative or business agent who led negotiations for this collective bargaining agreement on behalf of the union membership.',
    `wage_scale_tier_count` STRING COMMENT 'Number of distinct wage scale tiers or pay steps defined in the collective bargaining agreement for covered positions.',
    CONSTRAINT pk_union_agreement PRIMARY KEY(`union_agreement_id`)
) COMMENT 'Master record of collective bargaining agreements (CBAs) and labor relations activity for unionized Waste Management employees including Teamsters (CDL drivers), SEIU (facility workers), and IUOE (equipment operators). Captures union name, local number, agreement effective date, expiration date, covered job classifications, wage scale tiers, overtime rules, seniority provisions, grievance procedure reference, ratification date, and active grievance tracking (filing date, type, CBA article cited, step in procedure, resolution). Drives payroll rules, scheduling constraints, and labor dispute management for covered employees.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`grievance` (
    `grievance_id` BIGINT COMMENT 'Unique identifier for the labor grievance record. Primary key.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or work location where the grievance incident occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the grievant employee who filed the grievance.',
    `grievance_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified the grievance record.',
    `grievance_supervisor_employee_id` BIGINT COMMENT 'Employee identifier of the supervisor or manager involved in or responding to the grievance.',
    `grievance_union_steward_employee_id` BIGINT COMMENT 'Employee identifier of the union steward representing the grievant.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or organizational unit where the grievance incident occurred.',
    `related_grievance_id` BIGINT COMMENT 'Identifier of another grievance that is related to or consolidated with this grievance.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Grievances cite specific CBA articles and must be processed according to the grievance procedure defined in the collective bargaining agreement. Linking to the authoritative union_agreement ensures th',
    `arbitration_date` DATE COMMENT 'Date the arbitration hearing was conducted.',
    `arbitration_decision` STRING COMMENT 'Written decision issued by the arbitrator, including findings and remedies.',
    `arbitration_flag` BOOLEAN COMMENT 'Indicates whether the grievance proceeded to binding arbitration.',
    `arbitrator_name` STRING COMMENT 'Name of the neutral arbitrator assigned to hear the grievance if it proceeded to arbitration.',
    `back_pay_amount` DECIMAL(18,2) COMMENT 'Monetary amount of back pay awarded to the grievant as part of the grievance resolution.',
    `cba_article_cited` STRING COMMENT 'Specific article or section of the collective bargaining agreement cited as the basis for the grievance.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the grievance contains confidential or sensitive information requiring restricted access.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts. Waste Management operates primarily in USD.. Valid values are `USD`',
    `filing_date` DATE COMMENT 'Date the grievance was formally filed by the employee or union representative.',
    `grievance_number` STRING COMMENT 'Externally-known unique grievance tracking number assigned by labor relations or union steward.',
    `grievance_status` STRING COMMENT 'Current lifecycle status of the grievance in the resolution process.. Valid values are `filed|under_review|pending_response|resolved|withdrawn|arbitration`',
    `grievance_type` STRING COMMENT 'Category of the grievance indicating the nature of the complaint.. Valid values are `discipline|scheduling|safety|wage|benefits|working_conditions`',
    `incident_date` DATE COMMENT 'Date of the incident or event that gave rise to the grievance.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident or circumstances that led to the grievance being filed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the grievance record was last updated or modified.',
    `management_response` STRING COMMENT 'Detailed written response from management addressing the grievance claims and proposed resolution.',
    `management_response_date` DATE COMMENT 'Date management formally responded to the grievance.',
    `notes` STRING COMMENT 'Additional notes, comments, or internal observations related to the grievance case.',
    `priority_level` STRING COMMENT 'Priority level assigned to the grievance based on severity, impact, or urgency.. Valid values are `low|medium|high|urgent`',
    `remedy_description` STRING COMMENT 'Description of any remedies awarded to the grievant, such as back pay, reinstatement, or policy changes.',
    `resolution_date` DATE COMMENT 'Date the grievance was formally resolved or closed.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the final resolution, including any remedies, corrective actions, or settlements agreed upon.',
    `resolution_outcome` STRING COMMENT 'Final outcome or decision on the grievance after resolution process completion.. Valid values are `upheld|denied|partially_upheld|settled|withdrawn`',
    `step` STRING COMMENT 'Current step in the multi-step grievance resolution procedure as defined in the CBA.. Valid values are `step_1|step_2|step_3|arbitration`',
    CONSTRAINT pk_grievance PRIMARY KEY(`grievance_id`)
) COMMENT 'Tracks formal labor grievances filed by unionized Waste Management employees under collective bargaining agreements. Captures grievance number, filing date, grievant employee, union steward, grievance type (discipline, scheduling, safety, wage), CBA article cited, step in grievance procedure (Step 1 through arbitration), management response, resolution date, and outcome. Supports labor relations management and CBA compliance tracking.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` (
    `workers_comp_claim_id` BIGINT COMMENT 'Unique identifier for the workers compensation claim record. Primary key.',
    `ehs_incident_id` BIGINT COMMENT 'Identifier linking this workers compensation claim to the corresponding incident record in the Enviance EHS incident management system.',
    `facility_id` BIGINT COMMENT 'Identifier of the Waste Management facility where the injury occurred, if applicable.',
    `medical_case_id` BIGINT COMMENT 'Foreign key linking to safety.medical_case. Business justification: Workers comp claims and medical cases track the same workplace injury through insurance and clinical lenses. Links claim financial data to clinical treatment details for case management and return-to-',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who filed the workers compensation claim.',
    `route_id` BIGINT COMMENT 'Identifier of the collection route where the injury occurred, if the incident happened during route operations.',
    `adjuster_name` STRING COMMENT 'Name of the insurance claims adjuster assigned to evaluate and process the claim.',
    `adjuster_phone` STRING COMMENT 'Contact phone number for the insurance claims adjuster handling the claim.',
    `body_part_affected` STRING COMMENT 'Primary body part or region affected by the occupational injury or illness. [ENUM-REF-CANDIDATE: head|neck|back|shoulder|arm|hand|leg|foot|chest|abdomen|multiple|other — 12 candidates stripped; promote to reference product]',
    `claim_filed_date` DATE COMMENT 'Date when the formal workers compensation claim was filed with the insurer or state authority.',
    `claim_number` STRING COMMENT 'Externally-known unique claim number assigned by the insurer or internal claims management system for tracking and reference.. Valid values are `^WC-[0-9]{8,12}$`',
    `claim_reserve_amount` DECIMAL(18,2) COMMENT 'Financial reserve amount set aside by the insurer to cover anticipated future costs for this claim.',
    `claim_status` STRING COMMENT 'Current lifecycle status of the workers compensation claim indicating its processing stage.. Valid values are `open|under_review|approved|denied|closed|appealed`',
    `corrective_actions` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar injuries or illnesses.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this claim record.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this workers compensation claim record was first created in the system.',
    `incident_location` STRING COMMENT 'Specific location where the injury or illness occurred, such as facility name, route number, or work site address.',
    `indemnity_cost` DECIMAL(18,2) COMMENT 'Total indemnity or wage replacement payments made to the employee for lost time due to the injury or illness.',
    `injury_date` DATE COMMENT 'Date when the occupational injury or illness occurred. This is the principal business event timestamp for the claim.',
    `injury_description` STRING COMMENT 'Detailed narrative description of how the injury or illness occurred, including circumstances, location, and contributing factors.',
    `injury_severity` STRING COMMENT 'Classification of the severity level of the injury or illness based on medical assessment and impact.. Valid values are `minor|moderate|severe|catastrophic|fatal`',
    `injury_type` STRING COMMENT 'Classification of the type of occupational injury or illness sustained by the employee. [ENUM-REF-CANDIDATE: musculoskeletal|laceration|chemical_exposure|vehicle_accident|slip_fall|struck_by_object|caught_in_equipment|burn|respiratory|other — 10 candidates stripped; promote to reference product]',
    `insurer_claim_reference` STRING COMMENT 'Reference number or identifier assigned by the insurance carrier for their internal claim tracking.',
    `insurer_name` STRING COMMENT 'Name of the workers compensation insurance carrier handling the claim.',
    `lost_time_days` STRING COMMENT 'Total number of calendar days the employee was unable to work due to the injury or illness, excluding the day of injury.',
    `lost_time_flag` BOOLEAN COMMENT 'Indicates whether the injury resulted in lost work time beyond the day of injury.',
    `medical_cost` DECIMAL(18,2) COMMENT 'Total medical expenses incurred for treatment of the injury or illness, including hospital, physician, therapy, and medication costs.',
    `medical_facility_name` STRING COMMENT 'Name of the hospital, clinic, or medical facility where treatment was provided.',
    `medical_treatment_type` STRING COMMENT 'Classification of the level of medical treatment provided for the injury or illness.. Valid values are `first_aid|medical_treatment|hospitalization|surgery|ongoing_care|none`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this workers compensation claim record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the workers compensation claim.',
    `osha_case_number` STRING COMMENT 'Case number assigned to this incident in the OSHA 300 log if it is recordable.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the injury or illness meets OSHA criteria for recordability on the OSHA 300 log.',
    `report_date` DATE COMMENT 'Date when the employee or supervisor reported the injury or illness to management.',
    `restricted_duty_days` STRING COMMENT 'Total number of calendar days the employee worked on restricted or light duty due to the injury or illness.',
    `restricted_duty_flag` BOOLEAN COMMENT 'Indicates whether the employee was placed on restricted or light duty as a result of the injury.',
    `return_to_work_date` DATE COMMENT 'Date when the employee returned to full or modified duty following the injury or illness.',
    `return_to_work_status` STRING COMMENT 'Status of the employees return to work, indicating whether they resumed full duties, modified duties, or have not yet returned.. Valid values are `full_duty|light_duty|modified_duty|not_returned|terminated`',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis conducted to identify underlying factors that contributed to the injury or illness.',
    `total_incurred_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the workers compensation claim, including medical expenses, indemnity payments, and administrative costs.',
    `treating_physician_name` STRING COMMENT 'Name of the physician or medical provider who treated the injured employee.',
    `witness_names` STRING COMMENT 'Names of any witnesses who observed the incident or can provide information about the injury circumstances.',
    CONSTRAINT pk_workers_comp_claim PRIMARY KEY(`workers_comp_claim_id`)
) COMMENT 'Tracks workers compensation claims filed by Waste Management employees for occupational injuries and illnesses. Captures claim number, injury date, injury type (musculoskeletal, laceration, chemical exposure, vehicle accident), body part affected, OSHA recordable flag, lost time days, restricted duty days, medical treatment type, claim status, insurer reference, total incurred cost, and return-to-work date. Integrates with OSHA 300 log recordkeeping and Enviance EHS incident management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key for cost_center',
    `department_id` BIGINT COMMENT 'Reference to the department that owns or manages this cost center.',
    `division_id` BIGINT COMMENT 'Reference to the business division to which this cost center belongs.',
    `facility_id` BIGINT COMMENT 'Reference to the physical facility or location associated with this cost center (e.g., landfill site, MRF, transfer station).',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the responsible manager or supervisor for this cost center.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in a hierarchical cost center structure, enabling roll-up reporting.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual or period budget allocation for this cost center in USD.',
    `cost_center_category` STRING COMMENT 'Business function category that the cost center supports within waste management operations.',
    `closure_reason` STRING COMMENT 'Business reason for closing or inactivating the cost center (e.g., Project Completed, Facility Closed, Reorganization).',
    `cost_center_code` STRING COMMENT 'Externally-known unique alphanumeric code for the cost center used in financial reporting and labor allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial amounts associated with this cost center.',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and operational responsibilities.',
    `effective_end_date` DATE COMMENT 'Date when this cost center was closed or became inactive. Null for currently active cost centers.',
    `effective_start_date` DATE COMMENT 'Date when this cost center became active and available for labor and expense allocation.',
    `general_ledger_account_code` STRING COMMENT 'General ledger account code to which labor and expenses for this cost center are posted.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether labor and expenses charged to this cost center are billable to external customers or contracts.',
    `is_capital_project` BOOLEAN COMMENT 'Indicates whether this cost center represents a capital project requiring capitalization of labor and expenses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was last updated or modified.',
    `cost_center_name` STRING COMMENT 'Human-readable name of the cost center (e.g., North Region Collection Operations, MRF Sorting Line 2, Fleet Maintenance).',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the cost center for internal reference.',
    `profit_center_code` STRING COMMENT 'Associated profit center code for revenue-generating cost centers, used in profitability analysis.',
    `region_code` STRING COMMENT 'Geographic region code where the cost center operates (e.g., NE for Northeast, SW for Southwest).',
    `requires_approval` BOOLEAN COMMENT 'Indicates whether time and expense charges to this cost center require managerial approval before posting.',
    `sap_cost_center_reference` STRING COMMENT 'External reference identifier for this cost center in SAP ERP system for labor cost allocation and financial integration.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center indicating whether it is operational and accepting labor charges.',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by its functional role within the organization.',
    `workday_cost_center_reference` STRING COMMENT 'External reference identifier for this cost center in Workday HCM system for integration and reconciliation.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master reference table for cost_center. Referenced by cost_center_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or benefits provider administering this plan. Null for self-insured plans.',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the insurance carrier for this benefit plan. Used for claims processing and carrier communication.',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is eligible for COBRA continuation coverage when an employee experiences a qualifying event such as termination or reduction in hours.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered medical expenses the employee pays after meeting the deductible. For example, 20% means employee pays 20% and plan pays 80%.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specific covered services such as office visits or prescriptions. Typical for medical and dental plans.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Maximum benefit amount or coverage limit provided by the plan. For life insurance, this is the death benefit. For disability, this is the maximum monthly benefit.',
    `coverage_level` STRING COMMENT 'Defines who is covered under the benefit plan: employee only, employee plus spouse, employee plus children, or full family coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount that must be met before the plan begins paying benefits. Applicable primarily to health insurance plans.',
    `dependent_coverage_age_limit` STRING COMMENT 'Maximum age at which dependent children are eligible for coverage under this benefit plan. Typically 26 years for ACA-compliant health plans.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan terminates or is no longer available for new enrollments. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes effective and available for employee enrollment. Marks the beginning of the plans coverage period.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee contributes per pay period for this benefit plan. Null if contribution is percentage-based or employer-paid.',
    `employee_contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of total premium or salary that the employee contributes for this benefit plan. Null if contribution is fixed-dollar or employer-paid.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per pay period for this benefit plan. Used for labor cost allocation and financial reporting.',
    `employer_contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of total premium or salary that the employer contributes for this benefit plan. Used for labor cost allocation and financial reporting.',
    `enrollment_eligibility_rule` STRING COMMENT 'Business rule or criteria defining which employees are eligible to enroll in this benefit plan, such as full-time status, job classification, or tenure requirements.',
    `is_aca_compliant` BOOLEAN COMMENT 'Indicates whether this health benefit plan meets the minimum essential coverage and affordability requirements under the Affordable Care Act.',
    `is_erisa_plan` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to the Employee Retirement Income Security Act (ERISA) regulations and reporting requirements.',
    `is_hsa_eligible` BOOLEAN COMMENT 'Indicates whether this health plan qualifies as a High Deductible Health Plan (HDHP) and is eligible for Health Savings Account (HSA) contributions.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last modified. Used for audit trail and change tracking.',
    `open_enrollment_end_date` DATE COMMENT 'End date of the annual open enrollment period. Changes made during this period become effective at the start of the next plan year.',
    `open_enrollment_start_date` DATE COMMENT 'Start date of the annual open enrollment period when employees can enroll in, change, or cancel benefit plans.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount an employee will pay out-of-pocket for covered services in a plan year. After this limit, the plan pays 100% of covered expenses.',
    `plan_administrator_email` STRING COMMENT 'Email address of the plan administrator for employee inquiries and benefits administration communication.',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or department responsible for administering this benefit plan, handling enrollments, and addressing employee questions.',
    `plan_administrator_phone` STRING COMMENT 'Phone number of the plan administrator for employee inquiries and benefits support.',
    `plan_category` STRING COMMENT 'High-level grouping of benefit plans for reporting and administration purposes. Broader classification than plan type.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications. Used for plan enrollment and payroll deduction processing.',
    `plan_document_url` STRING COMMENT 'URL or file path to the official plan document, Summary Plan Description (SPD), or benefits guide for employee reference.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as displayed to employees during enrollment and on benefit statements.',
    `plan_notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or administrative comments about the benefit plan that do not fit in structured fields.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan indicating whether it is available for employee enrollment and active for coverage.',
    `plan_type` STRING COMMENT 'Category of benefit plan indicating the type of coverage or benefit provided to employees.',
    `plan_year_end_date` DATE COMMENT 'End date of the plan year for benefits administration. Deductibles and out-of-pocket maximums typically reset at the start of the next plan year.',
    `plan_year_start_date` DATE COMMENT 'Start date of the plan year for benefits administration, typically aligned with open enrollment periods and deductible reset dates.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium cost per pay period for this benefit plan, including both employer and employee contributions. Used for budgeting and cost analysis.',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date or eligibility date before they can enroll in this benefit plan. Zero indicates immediate eligibility.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`pay_period` (
    `pay_period_id` BIGINT COMMENT 'Primary key for pay_period',
    `prior_pay_period_id` BIGINT COMMENT 'Self-referencing FK on pay_period (prior_pay_period_id)',
    `approval_deadline_date` DATE COMMENT 'The deadline date by which supervisors must approve timesheets and payroll adjustments for this pay period.',
    `calendar_month` STRING COMMENT 'The calendar month (1-12) in which this pay period primarily falls.',
    `calendar_year` STRING COMMENT 'The calendar year in which this pay period falls (e.g., 2024).',
    `check_date` DATE COMMENT 'The date on which paychecks or direct deposits are issued to employees for this pay period.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this pay period was closed and locked from further time entry or changes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this pay period record was first created in the system.',
    `end_date` DATE COMMENT 'The last calendar date included in this pay period.',
    `finalized_timestamp` TIMESTAMP COMMENT 'The date and time when payroll processing was completed and paychecks were finalized for this pay period.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this pay period belongs.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this pay period belongs (e.g., 2024).',
    `frequency_type` STRING COMMENT 'The frequency at which employees are paid during this period (weekly, bi-weekly, semi-monthly, monthly).',
    `holiday_count` STRING COMMENT 'The number of company-recognized holidays that fall within this pay period.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this pay period is designated for payroll adjustments, corrections, or off-cycle payments (True/False).',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this is the final pay period of the calendar or fiscal year, requiring special year-end processing (True/False).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this pay period record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes or comments about this pay period, such as special processing instructions, holidays, or exceptions.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when this pay period was opened for time entry and payroll processing.',
    `payroll_system_code` STRING COMMENT 'The code or identifier used by the payroll system (Workday HCM, SAP) to reference this pay period.',
    `period_name` STRING COMMENT 'Human-readable name or label for the pay period (e.g., PP01-2024, January 2024 - Period 1).',
    `period_number` STRING COMMENT 'Sequential number of the pay period within the fiscal or calendar year (e.g., 1, 2, 3...26 for bi-weekly).',
    `processing_batch_code` STRING COMMENT 'The batch identifier used during payroll processing for this pay period, linking to payroll run logs.',
    `start_date` DATE COMMENT 'The first calendar date included in this pay period.',
    `pay_period_status` STRING COMMENT 'Current lifecycle status of the pay period (draft, open for time entry, processing payroll, closed, finalized, archived).',
    `time_entry_cutoff_date` DATE COMMENT 'The deadline date by which employees must submit their time and attendance records for this pay period.',
    `total_days_count` STRING COMMENT 'The total number of calendar days in this pay period.',
    `working_days_count` STRING COMMENT 'The number of standard working days (excluding weekends and holidays) within this pay period.',
    CONSTRAINT pk_pay_period PRIMARY KEY(`pay_period_id`)
) COMMENT 'Master reference table for pay_period. Referenced by pay_period_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`department` (
    `department_id` BIGINT COMMENT 'Primary key for department',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track and allocate labor costs, expenses, and budget for this department in the general ledger and enterprise resource planning systems.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this department record was first created in the system.',
    `department_code` STRING COMMENT 'Short alphanumeric code used as a business identifier for the department in operational systems and reporting.',
    `department_type` STRING COMMENT 'Classification of the department by its primary functional area within the waste management organization.',
    `department_description` STRING COMMENT 'Detailed description of the departments purpose, responsibilities, and scope of operations within the organization.',
    `division_id` BIGINT COMMENT 'Reference to the division or business unit to which this department belongs in the broader organizational structure.',
    `effective_end_date` DATE COMMENT 'The date when this department was or will be closed, merged, or otherwise ceased operations. Null for currently active departments.',
    `effective_start_date` DATE COMMENT 'The date when this department was officially established and became operational within the organization.',
    `email_address` STRING COMMENT 'Primary email address for the department used for official correspondence and communication.',
    `headcount_actual` STRING COMMENT 'The current number of filled full-time equivalent positions in the department, reflecting actual staffing levels.',
    `headcount_budgeted` STRING COMMENT 'The approved number of full-time equivalent positions allocated to the department in the current fiscal year budget.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether labor hours from this department can be directly billed to customer contracts or projects, used for revenue recognition and cost allocation.',
    `is_customer_facing` BOOLEAN COMMENT 'Indicates whether employees in this department have direct interaction with customers as part of their primary job responsibilities.',
    `location_id` BIGINT COMMENT 'Reference to the primary physical location or facility where the department is based, such as a landfill, transfer station, materials recovery facility, or administrative office.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the department manager or head, responsible for oversight and decision-making.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this department record was last updated or modified in the system.',
    `department_name` STRING COMMENT 'Full official name of the department as recognized in organizational charts and human resources systems.',
    `parent_department_id` BIGINT COMMENT 'Reference to the parent department in the organizational hierarchy, enabling multi-level departmental structures. Null for top-level departments.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the department used for internal and external communication.',
    `requires_cdl` BOOLEAN COMMENT 'Indicates whether positions in this department require employees to hold a valid Commercial Driver License for operating waste collection vehicles.',
    `requires_hazwoper` BOOLEAN COMMENT 'Indicates whether positions in this department require HAZWOPER certification for handling hazardous waste materials and emergency response situations.',
    `requires_osha_training` BOOLEAN COMMENT 'Indicates whether positions in this department require specific OSHA safety training certifications beyond general workplace safety.',
    `safety_classification` STRING COMMENT 'Classification of the department based on the level of safety risk associated with its operations, used for determining personal protective equipment requirements, training frequency, and insurance premiums.',
    `sap_cost_center` STRING COMMENT 'Cost center identifier for this department in the SAP enterprise resource planning system, used for financial reporting and labor cost allocation.',
    `shift_pattern` STRING COMMENT 'Standard work shift pattern for employees in this department, indicating whether they work day shifts, night shifts, rotating schedules, or around-the-clock operations.',
    `short_name` STRING COMMENT 'Abbreviated or shortened name of the department used in reports, dashboards, and user interfaces where space is limited.',
    `department_status` STRING COMMENT 'Current operational status of the department indicating whether it is actively functioning, temporarily suspended, or planned for future activation.',
    `union_affiliation` STRING COMMENT 'Name of the labor union representing employees in this department, if applicable. Null for non-unionized departments.',
    `workday_department_id` STRING COMMENT 'External identifier for this department in the Workday Human Capital Management system, used for integration and data synchronization.',
    CONSTRAINT pk_department PRIMARY KEY(`department_id`)
) COMMENT 'Master reference table for department. Referenced by department_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`workforce`.`division` (
    `division_id` BIGINT COMMENT 'Primary key for division',
    `address_line_1` STRING COMMENT 'First line of the divisions mailing or physical address (street number and name).',
    `address_line_2` STRING COMMENT 'Second line of the divisions address (suite, building, floor, or other secondary address information).',
    `business_unit_id` BIGINT COMMENT 'Reference to the business unit this division belongs to for financial and operational reporting.',
    `city` STRING COMMENT 'City where the division is located.',
    `cost_center_code` STRING COMMENT 'Financial accounting code used to track costs and expenses associated with this division. Integrates with SAP for labor cost allocation.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA, CAN, MEX) where the division is located.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this division record was first created in the system.',
    `division_code` STRING COMMENT 'Short alphanumeric code used to identify the division in operational systems and reporting. Typically 2-10 characters.',
    `division_manager_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the manager or director of this division.',
    `division_name` STRING COMMENT 'Full official name of the division.',
    `division_type` STRING COMMENT 'Classification of the division based on its primary function within the organization (e.g., operational, administrative, support, regional, functional, business unit).',
    `effective_end_date` DATE COMMENT 'The date this division ceased operations, was closed, or merged into another division. Null for active divisions.',
    `effective_start_date` DATE COMMENT 'The date this division became operational or was established.',
    `email_address` STRING COMMENT 'Primary email address for division-level communications.',
    `fax_number` STRING COMMENT 'Fax number for the division, if applicable.',
    `general_ledger_account_code` STRING COMMENT 'Primary general ledger account code associated with this division for financial reporting and consolidation.',
    `headcount_actual` STRING COMMENT 'The current number of filled full-time equivalent (FTE) positions in this division.',
    `headcount_authorized` STRING COMMENT 'The approved number of full-time equivalent (FTE) positions authorized for this division.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this division record was last updated in the system.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the division.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the division (e.g., Monday-Friday 8:00 AM - 5:00 PM).',
    `osha_establishment_id` STRING COMMENT 'OSHA establishment identifier for this division used for regulatory reporting and compliance tracking.',
    `parent_division_id` BIGINT COMMENT 'Reference to the parent division in the organizational hierarchy. Null for top-level divisions.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the division.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the divisions address.',
    `primary_facility_id` BIGINT COMMENT 'Reference to the primary facility or headquarters location for this division.',
    `profit_center_code` STRING COMMENT 'Financial accounting code used to track revenue and profitability for this division.',
    `region_id` BIGINT COMMENT 'Reference to the geographic region this division operates within.',
    `safety_incident_rate` DECIMAL(18,2) COMMENT 'The divisions safety incident rate per 100 full-time employees, calculated per OSHA standards.',
    `service_area_description` STRING COMMENT 'Description of the geographic service area or operational scope covered by this division (e.g., counties, municipalities, or facility types served).',
    `state_province_code` STRING COMMENT 'Two-letter state or province code (e.g., TX, CA, ON) where the division is located.',
    `division_status` STRING COMMENT 'Current operational status of the division indicating whether it is actively operating, temporarily suspended, or permanently closed.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the divisions primary location (e.g., America/Chicago, America/New_York).',
    `union_local_number` STRING COMMENT 'The local union chapter number or identifier if employees in this division are unionized.',
    `union_representation_flag` BOOLEAN COMMENT 'Indicates whether employees in this division are represented by a labor union (True/False).',
    CONSTRAINT pk_division PRIMARY KEY(`division_id`)
) COMMENT 'Master reference table for division. Referenced by division_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ADD CONSTRAINT `fk_workforce_job_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ADD CONSTRAINT `fk_workforce_job_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ADD CONSTRAINT `fk_workforce_job_position_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ADD CONSTRAINT `fk_workforce_employee_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ADD CONSTRAINT `fk_workforce_cdl_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `waste_management_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ADD CONSTRAINT `fk_workforce_employee_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `waste_management_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ADD CONSTRAINT `fk_workforce_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ADD CONSTRAINT `fk_workforce_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `waste_management_ecm`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_pay_period_id` FOREIGN KEY (`pay_period_id`) REFERENCES `waste_management_ecm`.`workforce`.`pay_period`(`pay_period_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_primary_time_employee_id` FOREIGN KEY (`primary_time_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `waste_management_ecm`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_tertiary_payroll_approved_by_user_employee_id` FOREIGN KEY (`tertiary_payroll_approved_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `waste_management_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_tertiary_performance_hr_representative_employee_id` FOREIGN KEY (`tertiary_performance_hr_representative_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_approving_manager_employee_id` FOREIGN KEY (`tertiary_disciplinary_approving_manager_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ADD CONSTRAINT `fk_workforce_dot_drug_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_job_position_id` FOREIGN KEY (`job_position_id`) REFERENCES `waste_management_ecm`.`workforce`.`job_position`(`job_position_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_tertiary_job_approved_by_employee_id` FOREIGN KEY (`tertiary_job_approved_by_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_primary_labor_employee_id` FOREIGN KEY (`primary_labor_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_grievance_modified_by_user_employee_id` FOREIGN KEY (`grievance_modified_by_user_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_grievance_supervisor_employee_id` FOREIGN KEY (`grievance_supervisor_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_grievance_union_steward_employee_id` FOREIGN KEY (`grievance_union_steward_employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `waste_management_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_related_grievance_id` FOREIGN KEY (`related_grievance_id`) REFERENCES `waste_management_ecm`.`workforce`.`grievance`(`grievance_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ADD CONSTRAINT `fk_workforce_grievance_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `waste_management_ecm`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ADD CONSTRAINT `fk_workforce_workers_comp_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ADD CONSTRAINT `fk_workforce_cost_center_department_id` FOREIGN KEY (`department_id`) REFERENCES `waste_management_ecm`.`workforce`.`department`(`department_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ADD CONSTRAINT `fk_workforce_cost_center_division_id` FOREIGN KEY (`division_id`) REFERENCES `waste_management_ecm`.`workforce`.`division`(`division_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ADD CONSTRAINT `fk_workforce_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `waste_management_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ADD CONSTRAINT `fk_workforce_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `waste_management_ecm`.`workforce`.`cost_center`(`cost_center_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `waste_management_ecm`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `waste_management_ecm`.`workforce`.`pay_period` ADD CONSTRAINT `fk_workforce_pay_period_prior_pay_period_id` FOREIGN KEY (`prior_pay_period_id`) REFERENCES `waste_management_ecm`.`workforce`.`pay_period`(`pay_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `waste_management_ecm`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_endorsements` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsements');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_card_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Medical Card Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_card_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `dot_medical_card_expiration_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `eeo_classification` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|leave|suspended|terminated');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|contractor|temporary|intern');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `hazwoper_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Operations and Emergency Response (HAZWOPER) Certification Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `hazwoper_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Operations and Emergency Response (HAZWOPER) Certified');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Mobile Phone Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `osha_10_certified` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 10-Hour Certified');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `osha_30_certified` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 30-Hour Certified');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `seniority_date` SET TAGS ('dbx_business_glossary_term' = 'Seniority Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|layoff|end_of_contract|death');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `union_member` SET TAGS ('dbx_business_glossary_term' = 'Union Member');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Human Capital Management (HCM) Employee Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee` ALTER COLUMN `workday_employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `background_check_level` SET TAGS ('dbx_business_glossary_term' = 'Background Check Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `background_check_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `cdl_class_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `cdl_class_required` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|not_required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `cdl_endorsements_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsements Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `cdl_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `direct_reports_count` SET TAGS ('dbx_business_glossary_term' = 'Direct Reports Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `dot_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Regulated Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `epa_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Certification Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `hazwoper_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Operations and Emergency Response (HAZWOPER) Certification Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `hazwoper_certification_required` SET TAGS ('dbx_value_regex' = 'hazwoper_8_hour|hazwoper_24_hour|hazwoper_40_hour|not_required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `headcount_authorization` SET TAGS ('dbx_business_glossary_term' = 'Headcount Authorization');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `osha_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,2}[0-9]{1,2}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|closed|pending_approval');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `rcra_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Training Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Position Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|night|rotating|on_call|flexible');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `supervisory_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Position Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `travel_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement Percentage');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `union_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Position Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `work_environment` SET TAGS ('dbx_business_glossary_term' = 'Work Environment');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_position` ALTER COLUMN `work_environment` SET TAGS ('dbx_value_regex' = 'office|field|facility|mixed');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `dot_facility_number` SET TAGS ('dbx_business_glossary_term' = 'DOT (Department of Transportation) Facility Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `dot_facility_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `epa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'EPA (Environmental Protection Agency) Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Capacity');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `operates_holidays` SET TAGS ('dbx_business_glossary_term' = 'Operates on Holidays Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `operates_weekends` SET TAGS ('dbx_business_glossary_term' = 'Operates on Weekends Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_end` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `operating_hours_start` SET TAGS ('dbx_value_regex' = '^([0-1][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `rcra_permit_number` SET TAGS ('dbx_business_glossary_term' = 'RCRA (Resource Conservation and Recovery Act) Permit Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `rcra_permit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{9,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `safety_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Zone Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `safety_zone_classification` SET TAGS ('dbx_value_regex' = 'low_risk|moderate_risk|high_risk|hazardous');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Profit Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `sap_profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `union_representation` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'corporate|region|district|facility|department|cost_center');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `workday_org_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Organization ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`org_unit` ALTER COLUMN `workday_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,30}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `employee_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Assignment ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|completed');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|temporary|seasonal|on_call|relief');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `cdl_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|seasonal|contractor');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Equivalent');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `hazmat_endorsement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Endorsement Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `labor_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Allocation Percentage');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `osha_training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `ppe_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Assignment Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `ppe_assignment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `rotation_type` SET TAGS ('dbx_business_glossary_term' = 'Rotation Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `rotation_type` SET TAGS ('dbx_value_regex' = 'none|weekly|biweekly|monthly|custom');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'workday|sap|manual|integration');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `work_area_code` SET TAGS ('dbx_business_glossary_term' = 'Work Area Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `work_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `cdl_license_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) License ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `clearinghouse_query_date` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Clearinghouse Query Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `clearinghouse_status` SET TAGS ('dbx_business_glossary_term' = 'Drug and Alcohol Clearinghouse Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `clearinghouse_status` SET TAGS ('dbx_value_regex' = 'clear|violation_pending|violation_resolved|prohibited');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `clearinghouse_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|expiring_soon|suspended|revoked');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `dot_medical_certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Medical Certificate Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `dot_medical_certificate_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `dot_medical_certificate_expiration_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `driver_qualification_file_complete` SET TAGS ('dbx_business_glossary_term' = 'Driver Qualification File Complete Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsements');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `fmcsa_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Motor Carrier Safety Administration (FMCSA) Registration Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `hazmat_endorsement_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Endorsement Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_alcohol_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Alcohol Test Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_alcohol_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Alcohol Test Result');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_alcohol_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|cancelled');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_alcohol_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Drug Test Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_drug_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Drug Test Result');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_drug_test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refused|cancelled');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_drug_test_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_mvr_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Motor Vehicle Record (MVR) Check Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_road_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Road Test Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_road_test_result` SET TAGS ('dbx_business_glossary_term' = 'Last Road Test Result');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `last_road_test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|waived');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `mvr_status` SET TAGS ('dbx_business_glossary_term' = 'Motor Vehicle Record (MVR) Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `mvr_status` SET TAGS ('dbx_value_regex' = 'clear|violations_minor|violations_major|suspended|revoked');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `random_drug_test_pool_status` SET TAGS ('dbx_business_glossary_term' = 'Random Drug Test Pool Enrollment Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `random_drug_test_pool_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|suspended');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Restrictions');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `self_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Self-Certification Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `self_certification_type` SET TAGS ('dbx_value_regex' = 'non_excepted_interstate|excepted_interstate|non_excepted_intrastate|excepted_intrastate');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `serious_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Violations Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `total_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Total Violations Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Entry-Level Driver Training (ELDT) Completion Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `training_provider_registry_number` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Registry Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`cdl_license` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By User');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `cdl_endorsement` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Endorsement');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `cdl_endorsement` SET TAGS ('dbx_value_regex' = 'H|N|P|S|T|X');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'license|certification|training|endorsement|permit');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (United States Dollar)');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `epa_program` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Program');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `equipment_authorization` SET TAGS ('dbx_business_glossary_term' = 'Equipment Authorization');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `exam_required` SET TAGS ('dbx_business_glossary_term' = 'Exam Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `facility_type_authorization` SET TAGS ('dbx_business_glossary_term' = 'Facility Type Authorization');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `hazmat_category` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (Hazmat) Category');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_body_type` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `issuing_body_type` SET TAGS ('dbx_value_regex' = 'federal|state|local|industry|internal');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Exam Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `minimum_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `online_training_available` SET TAGS ('dbx_business_glossary_term' = 'Online Training Available');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `osha_standard` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Standard');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `prerequisite_certifications` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Certifications');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `regulatory_mandate` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `regulatory_mandate` SET TAGS ('dbx_value_regex' = 'DOT|OSHA|EPA|RCRA|state|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Method');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_method` SET TAGS ('dbx_value_regex' = 'retraining|exam|continuing_education|application|automatic');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `training_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `waste_management_ecm`.`workforce`.`certification` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Certification ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|in_progress');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `document_attachment_path` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Path');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Endorsements');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `exam_score` SET TAGS ('dbx_business_glossary_term' = 'Examination Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `issuing_organization` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `job_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Job Requirement Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `passing_score_required` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|reimbursed|denied');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `restrictions` SET TAGS ('dbx_business_glossary_term' = 'Restrictions');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WORKDAY|SAP_HCM|MANUAL_ENTRY|EXTERNAL_IMPORT|TRAINING_LMS');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending_verification|failed_verification');
ALTER TABLE `waste_management_ecm`.`workforce`.`employee_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Course Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'written_exam|practical_demonstration|online_quiz|skills_test|observation|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `cost_per_employee` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Employee');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_value_regex' = 'safety|compliance|technical|operational|leadership|administrative');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_materials_description` SET TAGS ('dbx_business_glossary_term' = 'Course Materials Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|retired|suspended');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `course_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Course Subcategory');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|hybrid|on_the_job|webinar|self_paced');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `instructor_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Instructor Qualification Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `language_offered` SET TAGS ('dbx_business_glossary_term' = 'Language Offered');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `last_content_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Review Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `maximum_class_size` SET TAGS ('dbx_business_glossary_term' = 'Maximum Class Size');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `minimum_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `next_content_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Content Review Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `online_learning_platform_url` SET TAGS ('dbx_business_glossary_term' = 'Online Learning Platform Uniform Resource Locator (URL)');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `ppe_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `recertification_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recertification Frequency Months');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `target_job_roles` SET TAGS ('dbx_business_glossary_term' = 'Target Job Roles');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `vendor_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Provider Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`training_course` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `workforce_training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Training Record ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'written_exam|practical_test|observation|quiz|simulation|no_assessment');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Assessment Attempts Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `attendance_status` SET TAGS ('dbx_value_regex' = 'attended|absent|partial|excused|no_show');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `ceu_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Employee Department');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Training Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `job_role` SET TAGS ('dbx_business_glossary_term' = 'Employee Job Role');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Training Due Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass or Fail Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|waived|in_progress');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `record_source` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `recurrence_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency in Months');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Training Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Training Duration in Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `waste_management_ecm`.`workforce`.`workforce_training_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `cdl_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Days of Week');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `days_of_week` SET TAGS ('dbx_value_regex' = '^(Mon|Tue|Wed|Thu|Fri|Sat|Sun)(,(Mon|Tue|Wed|Thu|Fri|Sat|Sun))*$');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `hazwoper_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Operations and Emergency Response (HAZWOPER) Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `headcount_capacity` SET TAGS ('dbx_business_glossary_term' = 'Headcount Capacity');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `minimum_staffing_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Staffing Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `osha_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_name` SET TAGS ('dbx_value_regex' = 'Day|Swing|Night|Split|Rotating|On-Call');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_priority` SET TAGS ('dbx_business_glossary_term' = 'Shift Priority');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Seasonal|Archived');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'Fixed|Rotating|On-Call|Flex|Seasonal');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `weather_dependent_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Dependent Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`shift_schedule` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `pay_period_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Period ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `primary_time_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `absence_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `break_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Time Minutes');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `cdl_hos_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Hours of Service (HOS) Compliant Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock In Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock Out Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `driving_hours` SET TAGS ('dbx_business_glossary_term' = 'Driving Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `hazmat_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Work Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `hos_violation_code` SET TAGS ('dbx_business_glossary_term' = 'Hours of Service (HOS) Violation Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `off_duty_hours` SET TAGS ('dbx_business_glossary_term' = 'Off Duty Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `on_duty_not_driving_hours` SET TAGS ('dbx_business_glossary_term' = 'On Duty Not Driving Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `ppe_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Issued Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `sleeper_berth_hours` SET TAGS ('dbx_business_glossary_term' = 'Sleeper Berth Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Source');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_source` SET TAGS ('dbx_value_regex' = 'manual|biometric|mobile_app|telematics|system_generated');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|processed|corrected');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_record_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_value_regex' = '^CC[0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tertiary_payroll_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tertiary_payroll_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `tertiary_payroll_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `dental_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Dental Insurance Employee Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `dental_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `dental_insurance_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `disability_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Disability Insurance Employee Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `disability_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `disability_insurance_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax` SET TAGS ('dbx_business_glossary_term' = 'Federal Income Tax Withheld');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `federal_income_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_business_glossary_term' = 'Wage Garnishment Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `hazard_pay` SET TAGS ('dbx_business_glossary_term' = 'Hazard Pay Differential');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `hazard_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `life_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Employee Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `life_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `life_insurance_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medical_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Medical Insurance Employee Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medical_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medical_insurance_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Medicare Tax (FICA)');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `medicare_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `overtime_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|paper_check|payroll_card');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Record Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `payroll_status` SET TAGS ('dbx_value_regex' = 'draft|processed|posted|paid|voided|reversed');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_pay` SET TAGS ('dbx_business_glossary_term' = 'Regular Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `regular_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_business_glossary_term' = '401(k) Retirement Plan Employee Contribution');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_401k_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_401k_employer_match` SET TAGS ('dbx_business_glossary_term' = '401(k) Employer Matching Contribution');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `retirement_401k_employer_match` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `sap_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Posting Reference Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `sap_posting_reference` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Pay');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `shift_differential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Social Security Tax (FICA)');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `social_security_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax` SET TAGS ('dbx_business_glossary_term' = 'State Income Tax Withheld');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `state_income_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `total_deductions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_deduction` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `union_dues_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `vision_insurance_deduction` SET TAGS ('dbx_business_glossary_term' = 'Vision Insurance Employee Deduction');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `vision_insurance_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`payroll_record` ALTER COLUMN `vision_insurance_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Annual Employee Contribution');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Annual Employer Contribution');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_value_regex' = 'spouse|child|parent|sibling|domestic_partner|other');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Confirmation Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_election_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) Election Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) Eligible Indicator');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA (Consolidated Omnibus Budget Reconciliation Act) End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family|employee_domestic_partner');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Sent Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_event_type` SET TAGS ('dbx_value_regex' = 'new_hire|annual_open_enrollment|qualifying_life_event|benefit_change|rehire|leave_of_absence');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online_portal|paper_form|phone|hr_representative|automatic|default');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|suspended|waived|cancelled');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `evidence_of_insurability_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|incomplete');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `union_plan_indicator` SET TAGS ('dbx_business_glossary_term' = 'Union Plan Indicator');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_representative_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Representative Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_representative_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `tertiary_performance_hr_representative_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'performance_review|verbal_warning|written_warning|final_warning|suspension|termination');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|upheld|overturned|withdrawn|not_applicable');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `attendance_score` SET TAGS ('dbx_business_glossary_term' = 'Attendance Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `customer_service_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommended Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `near_miss_reports_count` SET TAGS ('dbx_business_glossary_term' = 'Near-Miss Reports Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `osha_recordable_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Incidents Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `productivity_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Productivity Metric Unit');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `productivity_metric_unit` SET TAGS ('dbx_value_regex' = 'stops_per_hour|tons_per_day|work_orders_per_day|calls_per_hour|other');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `productivity_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Productivity Metric Value');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `quality_of_work_score` SET TAGS ('dbx_business_glossary_term' = 'Quality of Work Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|completed|appealed|archived');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|disciplinary|termination');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `safety_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Performance Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `teamwork_collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Teamwork and Collaboration Score');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`performance_review` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_approving_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_approving_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_approving_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_warning|suspension|termination|demotion');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|upheld|overturned|modified|withdrawn');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('dbx_value_regex' = 'active|expired|overturned|superseded');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `dot_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Reportable Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `eligible_for_rehire_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Rehire Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_statement` SET TAGS ('dbx_business_glossary_term' = 'Employee Statement');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Review Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `paid_suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Suspension Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|moderate|serious|critical');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Duration in Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_category` SET TAGS ('dbx_value_regex' = 'safety|dot_compliance|attendance|conduct|performance|substance_abuse');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`disciplinary_action` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` SET TAGS ('dbx_subdomain' = 'compliance_training');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `dot_drug_test_id` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Drug Test ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) License Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `cdl_state` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) State');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `collection_site_address` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Address');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `collection_site_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `collection_site_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `collection_site_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Site Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `collector_name` SET TAGS ('dbx_business_glossary_term' = 'Collector Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `collector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending review|exempted');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `concentration_level` SET TAGS ('dbx_business_glossary_term' = 'Concentration Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `concentration_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `concentration_level` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `follow_up_testing_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Testing Plan Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `laboratory_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Certification Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Contact Phone');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_review_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Review Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Officer (MRO) Verification Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `mro_verification_status` SET TAGS ('dbx_value_regex' = 'verified positive|verified negative|verified refusal|pending|cancelled by mro');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `random_pool_selection_date` SET TAGS ('dbx_business_glossary_term' = 'Random Pool Selection Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `return_to_duty_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Return-to-Duty Clearance Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `safety_sensitive_position_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `sap_evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Evaluation Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `sap_evaluation_status` SET TAGS ('dbx_value_regex' = 'not required|pending|in progress|completed|not completed');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `sap_reference_code` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Reference ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `sap_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Referral Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `sap_referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Substance Abuse Professional (SAP) Referral Required Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `specimen_code` SET TAGS ('dbx_business_glossary_term' = 'Specimen ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `specimen_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `specimen_type` SET TAGS ('dbx_business_glossary_term' = 'Specimen Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `specimen_type` SET TAGS ('dbx_value_regex' = 'urine|breath|blood|saliva|hair');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `split_specimen_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Split Specimen Requested Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `split_specimen_result` SET TAGS ('dbx_business_glossary_term' = 'Split Specimen Result');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `split_specimen_result` SET TAGS ('dbx_value_regex' = 'confirmed|not confirmed|not tested|unavailable');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `split_specimen_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `split_specimen_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `substances_detected` SET TAGS ('dbx_business_glossary_term' = 'Substances Detected');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `substances_detected` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `substances_detected` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Test Reason Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'negative|positive|refusal|cancelled|invalid');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_result` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_time` SET TAGS ('dbx_business_glossary_term' = 'Test Time');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'DOT Test Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'pre-employment|random|post-accident|reasonable suspicion|return-to-duty|follow-up');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`dot_drug_test` ALTER COLUMN `workday_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Reference ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `job_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `job_position_id` SET TAGS ('dbx_business_glossary_term' = 'Job Position Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `approved_headcount` SET TAGS ('dbx_business_glossary_term' = 'Approved Headcount');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `education_level_required` SET TAGS ('dbx_business_glossary_term' = 'Education Level Required');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `education_level_required` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `filled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Filled Headcount');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `posting_channel` SET TAGS ('dbx_business_glossary_term' = 'Posting Channel');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_close_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Close Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'backfill|new_headcount|seasonal|temporary|contractor_conversion|internal_transfer');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`job_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|field|remote|hybrid');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `labor_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Allocation ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `cell_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Cell ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|percentage|driver_based|activity_based|standard_rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|reversed');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `hazard_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Hazard Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `hazard_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `labor_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `regular_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Regular Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `regular_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `sap_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Posting Reference');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `total_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Labor Cost');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `total_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`workforce`.`labor_cost_allocation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_ratification|active|expired|terminated|under_negotiation');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'master|local|supplemental|memorandum_of_understanding|side_letter');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `arbitration_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Provision Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `bargaining_unit_size` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit Size');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_rate_maximum` SET TAGS ('dbx_business_glossary_term' = 'Base Wage Rate Maximum');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_rate_maximum` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_rate_maximum` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_rate_minimum` SET TAGS ('dbx_business_glossary_term' = 'Base Wage Rate Minimum');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_rate_minimum` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_rate_minimum` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `cdl_premium_rate` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Premium Rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `covered_job_classifications` SET TAGS ('dbx_business_glossary_term' = 'Covered Job Classifications');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `document_attachment_path` SET TAGS ('dbx_business_glossary_term' = 'Document Attachment Path');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `double_time_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Threshold Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `grievance_filing_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filing Deadline Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `grievance_procedure_steps` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure Steps');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `hazard_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Hazard Pay Rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `health_insurance_employer_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Employer Contribution Percentage');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `health_insurance_employer_contribution_pct` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `health_insurance_employer_contribution_pct` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `lead_negotiator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Negotiator Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `management_rights_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Rights Clause Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `negotiation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Completion Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `no_strike_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'No Strike Clause Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `paid_holidays_count` SET TAGS ('dbx_business_glossary_term' = 'Paid Holidays Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `paid_time_off_accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Paid Time Off (PTO) Accrual Rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `pension_employer_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Pension Employer Contribution Percentage');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `pension_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Pension Plan Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `pension_plan_type` SET TAGS ('dbx_value_regex' = 'defined_benefit|defined_contribution|multi_employer|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `probationary_period_days` SET TAGS ('dbx_business_glossary_term' = 'Probationary Period Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Ratification Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `seniority_system_type` SET TAGS ('dbx_business_glossary_term' = 'Seniority System Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `seniority_system_type` SET TAGS ('dbx_value_regex' = 'company_wide|facility_based|classification_based|hybrid');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_dues_deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_dues_deduction_frequency` SET TAGS ('dbx_business_glossary_term' = 'Union Dues Deduction Frequency');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_dues_deduction_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|per_pay_period');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `wage_scale_tier_count` SET TAGS ('dbx_business_glossary_term' = 'Wage Scale Tier Count');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `wage_scale_tier_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`union_agreement` ALTER COLUMN `wage_scale_tier_count` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Grievance Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_union_steward_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Union Steward Employee Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_union_steward_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_union_steward_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `related_grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Hearing Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_decision` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Decision');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitration_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `arbitrator_name` SET TAGS ('dbx_business_glossary_term' = 'Arbitrator Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `back_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Back Pay Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `cba_article_cited` SET TAGS ('dbx_business_glossary_term' = 'Collective Bargaining Agreement (CBA) Article Cited');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filing Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_number` SET TAGS ('dbx_business_glossary_term' = 'Grievance Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_status` SET TAGS ('dbx_value_regex' = 'filed|under_review|pending_response|resolved|withdrawn|arbitration');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_business_glossary_term' = 'Grievance Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `grievance_type` SET TAGS ('dbx_value_regex' = 'discipline|scheduling|safety|wage|benefits|working_conditions');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grievance Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Grievance Priority Level');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `remedy_description` SET TAGS ('dbx_business_glossary_term' = 'Remedy Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Outcome');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'upheld|denied|partially_upheld|settled|withdrawn');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `step` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure Step');
ALTER TABLE `waste_management_ecm`.`workforce`.`grievance` ALTER COLUMN `step` SET TAGS ('dbx_value_regex' = 'step_1|step_2|step_3|arbitration');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `workers_comp_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `ehs_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Health and Safety (EHS) Incident ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Case Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_case_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_case_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `adjuster_name` SET TAGS ('dbx_business_glossary_term' = 'Claims Adjuster Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `adjuster_phone` SET TAGS ('dbx_business_glossary_term' = 'Claims Adjuster Phone Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `adjuster_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `adjuster_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Filed Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^WC-[0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Reserve Amount');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|under_review|approved|denied|closed|appealed');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Cost');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `indemnity_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `injury_date` SET TAGS ('dbx_business_glossary_term' = 'Injury Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `injury_description` SET TAGS ('dbx_business_glossary_term' = 'Injury Description');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|severe|catastrophic|fatal');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `insurer_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Claim Reference');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `lost_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `lost_time_flag` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_cost` SET TAGS ('dbx_business_glossary_term' = 'Medical Cost');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Facility Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Type');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `medical_treatment_type` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|hospitalization|surgery|ongoing_care|none');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Claim Notes');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `osha_case_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Case Number');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Report Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `restricted_duty_days` SET TAGS ('dbx_business_glossary_term' = 'Restricted Duty Days');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `restricted_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Duty Flag');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `return_to_work_status` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Status');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `return_to_work_status` SET TAGS ('dbx_value_regex' = 'full_duty|light_duty|modified_duty|not_returned|terminated');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `total_incurred_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Incurred Cost');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `total_incurred_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `treating_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Treating Physician Name');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `treating_physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `waste_management_ecm`.`workforce`.`workers_comp_claim` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`benefit_plan` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`pay_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`pay_period` SET TAGS ('dbx_subdomain' = 'compensation_operations');
ALTER TABLE `waste_management_ecm`.`workforce`.`pay_period` ALTER COLUMN `pay_period_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`pay_period` ALTER COLUMN `prior_pay_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`department` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `division_id` SET TAGS ('dbx_business_glossary_term' = 'Division Identifier');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`workforce`.`division` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
