-- Schema for Domain: employer | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`employer` COMMENT 'Manages employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Owns group demographics, SIC classification, group size, ASO/fully-insured funding arrangements, ERISA status, GFC controls, employer-subscriber relationships, contribution strategies, renewal dates, and participation requirements. Supports group billing aggregation, renewal management, and broker/TPA associations. Source system: Facets or QNXT group management module.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group` (
    `group_id` BIGINT COMMENT 'Primary key',
    `pool_id` BIGINT COMMENT 'FK to risk pool',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `average_claim_cost` DECIMAL(18,2) COMMENT 'The average claim cost attribute capturing relevant data for the group in the employer domain.',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the group in the employer domain.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the group in the employer domain.',
    `country` STRING COMMENT 'The country attribute capturing relevant data for the group in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group in the employer domain.',
    `dba_name` STRING COMMENT 'The descriptive name assigned to the dba for identification purposes.',
    `domicile_state` STRING COMMENT 'The domicile state attribute capturing relevant data for the group in the employer domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this group record.',
    `email_address` STRING COMMENT 'The email address attribute capturing relevant data for the group in the employer domain.',
    `enrollment_count_ec` STRING COMMENT 'The enrollment count ec attribute capturing relevant data for the group in the employer domain.',
    `enrollment_count_ef` STRING COMMENT 'The enrollment count ef attribute capturing relevant data for the group in the employer domain.',
    `enrollment_count_eo` STRING COMMENT 'The enrollment count eo attribute capturing relevant data for the group in the employer domain.',
    `enrollment_count_es` STRING COMMENT 'The enrollment count es attribute capturing relevant data for the group in the employer domain.',
    `erisa_status` STRING COMMENT 'The current status indicator for the erisa within the workflow.',
    `funding_arrangement` STRING COMMENT 'The funding arrangement attribute capturing relevant data for the group in the employer domain.',
    `gfc_code` BIGINT COMMENT 'A standardized code representing the gfc classification.',
    `group_number` STRING COMMENT 'The group number attribute capturing relevant data for the group in the employer domain.',
    `group_status` STRING COMMENT 'The current status indicator for the group within the workflow.',
    `headcount_current` STRING COMMENT 'Current headcount',
    `headcount_last_month` STRING COMMENT 'Last month headcount',
    `headcount_last_year` STRING COMMENT 'Last year headcount',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'The last status change timestamp attribute capturing relevant data for the group in the employer domain.',
    `legal_name` STRING COMMENT 'The descriptive name assigned to the legal for identification purposes.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the group in the employer domain.',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the group in the employer domain.',
    `naics_code` STRING COMMENT 'A standardized code representing the naics classification.',
    `participation_requirement` STRING COMMENT 'The participation requirement attribute capturing relevant data for the group in the employer domain.',
    `phone_number` STRING COMMENT 'The phone number attribute capturing relevant data for the group in the employer domain.',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this group record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the group in the employer domain.',
    `sic_code` STRING COMMENT 'A standardized code representing the sic classification.',
    `size_tier` STRING COMMENT 'The size tier attribute capturing relevant data for the group in the employer domain.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the group in the employer domain.',
    `tax_id_ein` STRING COMMENT 'The tax id ein attribute capturing relevant data for the group in the employer domain.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this group record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group in the employer domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Employer group master record';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_location` (
    `group_location_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `network_service_area_id` BIGINT COMMENT 'FK to network service area',
    `facility_id` BIGINT COMMENT 'FK to facility',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `address_type` STRING COMMENT 'The category or classification type of the address.',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the group location in the employer domain.',
    `country_code` STRING COMMENT 'A standardized code representing the country classification.',
    `county_fips` STRING COMMENT 'The county fips attribute capturing relevant data for the group location in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group location in the employer domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this group location record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this group location record.',
    `geocode_accuracy` STRING COMMENT 'The geocode accuracy attribute capturing relevant data for the group location in the employer domain.',
    `group_location_status` STRING COMMENT 'The current status indicator for the group location within the workflow.',
    `is_primary` BOOLEAN COMMENT 'Is primary flag',
    `latitude` DECIMAL(18,2) COMMENT 'The latitude attribute capturing relevant data for the group location in the employer domain.',
    `location_code` STRING COMMENT 'A standardized code representing the location classification.',
    `location_name` STRING COMMENT 'The descriptive name assigned to the location for identification purposes.',
    `longitude` DECIMAL(18,2) COMMENT 'The longitude attribute capturing relevant data for the group location in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the group location in the employer domain.',
    `rating_area` STRING COMMENT 'The rating area attribute capturing relevant data for the group location in the employer domain.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the group location in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group location in the employer domain.',
    `zip_code` STRING COMMENT 'A standardized code representing the zip classification.',
    `zip_plus4` STRING COMMENT 'Zip plus 4',
    CONSTRAINT pk_group_location PRIMARY KEY(`group_location_id`)
) COMMENT 'Employer group location';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` (
    `group_contact_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `authorization_level` STRING COMMENT 'The authorization level attribute capturing relevant data for the group contact in the employer domain.',
    `can_bill` BOOLEAN COMMENT 'Can bill flag',
    `can_enroll` BOOLEAN COMMENT 'Can enroll flag',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the group contact in the employer domain.',
    `contact_type` STRING COMMENT 'The category or classification type of the contact.',
    `country` STRING COMMENT 'The country attribute capturing relevant data for the group contact in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group contact in the employer domain.',
    `department` STRING COMMENT 'The department attribute capturing relevant data for the group contact in the employer domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this group contact record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this group contact record.',
    `email` STRING COMMENT 'The email attribute capturing relevant data for the group contact in the employer domain.',
    `first_name` STRING COMMENT 'The descriptive name assigned to the first for identification purposes.',
    `full_name` STRING COMMENT 'The descriptive name assigned to the full for identification purposes.',
    `group_contact_status` STRING COMMENT 'The current status indicator for the group contact within the workflow.',
    `is_primary_contact` BOOLEAN COMMENT 'Boolean flag indicating whether primary contact condition applies.',
    `last_name` STRING COMMENT 'The descriptive name assigned to the last for identification purposes.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the group contact in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the group contact in the employer domain.',
    `phone_number` STRING COMMENT 'The phone number attribute capturing relevant data for the group contact in the employer domain.',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification.',
    `preferred_communication_channel` STRING COMMENT 'The preferred communication channel attribute capturing relevant data for the group contact in the employer domain.',
    `source_system_contact_reference` STRING COMMENT 'The source system contact reference attribute capturing relevant data for the group contact in the employer domain.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the group contact in the employer domain.',
    `title` STRING COMMENT 'The title attribute capturing relevant data for the group contact in the employer domain.',
    CONSTRAINT pk_group_contact PRIMARY KEY(`group_contact_id`)
) COMMENT 'Employer group contact';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_division` (
    `group_division_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to parent group',
    `health_plan_id` BIGINT COMMENT 'FK to primary health plan',
    `tertiary_group_epo_plan_health_plan_id` BIGINT COMMENT 'FK to tertiary EPO plan',
    `billing_entity_flag` BOOLEAN COMMENT 'Boolean indicator for the billing entity condition or state.',
    `classification` STRING COMMENT 'The classification attribute capturing relevant data for the group division in the employer domain.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The numeric contribution amount value associated with this group division record.',
    `contribution_percent` DECIMAL(18,2) COMMENT 'The contribution percent attribute capturing relevant data for the group division in the employer domain.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the group division in the employer domain.',
    `covered_member_count` STRING COMMENT 'The total count of covered member items associated with this record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group division in the employer domain.',
    `division_code` STRING COMMENT 'A standardized code representing the division classification.',
    `division_name` STRING COMMENT 'The descriptive name assigned to the division for identification purposes.',
    `division_type` STRING COMMENT 'The category or classification type of the division.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this group division record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this group division record.',
    `eligibility_rule_set` STRING COMMENT 'The eligibility rule set attribute capturing relevant data for the group division in the employer domain.',
    `employee_count` STRING COMMENT 'The total count of employee items associated with this record.',
    `flex_spending_amount` DECIMAL(18,2) COMMENT 'The numeric flex spending amount value associated with this group division record.',
    `fsa_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric fsa contribution amount value associated with this group division record.',
    `group_division_status` STRING COMMENT 'The current status indicator for the group division within the workflow.',
    `hsa_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric hsa contribution amount value associated with this group division record.',
    `is_eligible_for_flex_spending` BOOLEAN COMMENT 'Eligible for flex spending',
    `is_eligible_for_fsa` BOOLEAN COMMENT 'Eligible for FSA',
    `is_eligible_for_hsa` BOOLEAN COMMENT 'Eligible for HSA',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Eligible for subsidy',
    `is_eligible_for_waiver` BOOLEAN COMMENT 'Eligible for waiver',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this group division record.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'The numeric subsidy amount value associated with this group division record.',
    `subsidy_percent` DECIMAL(18,2) COMMENT 'The subsidy percent attribute capturing relevant data for the group division in the employer domain.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this group division record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group division in the employer domain.',
    CONSTRAINT pk_group_division PRIMARY KEY(`group_division_id`)
) COMMENT 'Employer group division';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` (
    `group_plan_offering_id` BIGINT COMMENT 'Primary key',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: A group plan offering is governed by a specific contribution strategy. The existing contribution_strategy_description (DOUBLE type) is a denormalized reference to the contribution_strategy table. Addi',
    `group_id` BIGINT COMMENT 'FK to group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `tier_id` BIGINT COMMENT 'FK to tier',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The numeric contribution amount value associated with this group plan offering record.',
    `contribution_effective_end_date` DATE COMMENT 'The date value representing contribution effective end date for this group plan offering record.',
    `contribution_effective_start_date` DATE COMMENT 'The date value representing contribution effective start date for this group plan offering record.',
    `contribution_percent` DECIMAL(18,2) COMMENT 'The contribution percent attribute capturing relevant data for the group plan offering in the employer domain.',
    `contribution_tier` STRING COMMENT 'The contribution tier attribute capturing relevant data for the group plan offering in the employer domain.',
    `contribution_type` STRING COMMENT 'The category or classification type of the contribution.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group plan offering in the employer domain.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the group plan offering in the employer domain.',
    `effective_until` DATE COMMENT 'The effective until attribute capturing relevant data for the group plan offering in the employer domain.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric employee contribution amount value associated with this group plan offering record.',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric family contribution amount value associated with this group plan offering record.',
    `group_plan_offering_status` STRING COMMENT 'The current status indicator for the group plan offering within the workflow.',
    `hra_seed_amount` DECIMAL(18,2) COMMENT 'The numeric hra seed amount value associated with this group plan offering record.',
    `hsa_seed_amount` DECIMAL(18,2) COMMENT 'The numeric hsa seed amount value associated with this group plan offering record.',
    `is_affordable` BOOLEAN COMMENT 'Boolean flag indicating whether affordable condition applies.',
    `measurement_period_end` DATE COMMENT 'The measurement period end attribute capturing relevant data for the group plan offering in the employer domain.',
    `measurement_period_start` DATE COMMENT 'The measurement period start attribute capturing relevant data for the group plan offering in the employer domain.',
    `minimum_enrolled_headcount` STRING COMMENT 'The minimum enrolled headcount attribute capturing relevant data for the group plan offering in the employer domain.',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'The minimum participation percent attribute capturing relevant data for the group plan offering in the employer domain.',
    `offering_code` STRING COMMENT 'A standardized code representing the offering classification.',
    `offering_description` STRING COMMENT 'A detailed textual description of the offering.',
    `offering_name` STRING COMMENT 'The descriptive name assigned to the offering for identification purposes.',
    `offering_type` STRING COMMENT 'The category or classification type of the offering.',
    `open_enrollment_end_date` DATE COMMENT 'The date value representing open enrollment end date for this group plan offering record.',
    `open_enrollment_start_date` DATE COMMENT 'The date value representing open enrollment start date for this group plan offering record.',
    `participation_status` STRING COMMENT 'The current status indicator for the participation within the workflow.',
    `plan_catalog_version` STRING COMMENT 'The plan catalog version attribute capturing relevant data for the group plan offering in the employer domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group plan offering in the employer domain.',
    `waiver_criteria_description` STRING COMMENT 'A detailed textual description of the waiver criteria.',
    `waiver_eligible` BOOLEAN COMMENT 'The waiver eligible attribute capturing relevant data for the group plan offering in the employer domain.',
    CONSTRAINT pk_group_plan_offering PRIMARY KEY(`group_plan_offering_id`)
) COMMENT 'Employer group plan offering';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` (
    `contribution_strategy_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `affordability_test_flag` BOOLEAN COMMENT 'Boolean indicator for the affordability test condition or state.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'The numeric contribution amount value associated with this contribution strategy record.',
    `contribution_code` STRING COMMENT 'A standardized code representing the contribution classification.',
    `contribution_frequency` STRING COMMENT 'The contribution frequency attribute capturing relevant data for the contribution strategy in the employer domain.',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'The contribution percentage attribute capturing relevant data for the contribution strategy in the employer domain.',
    `contribution_rule_name` STRING COMMENT 'The descriptive name assigned to the contribution rule for identification purposes.',
    `contribution_strategy_status` DOUBLE COMMENT 'The current status indicator for the contribution strategy within the workflow.',
    `contribution_type` STRING COMMENT 'The category or classification type of the contribution.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the contribution strategy in the employer domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this contribution strategy record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this contribution strategy record.',
    `eligibility_criteria` STRING COMMENT 'The eligibility criteria attribute capturing relevant data for the contribution strategy in the employer domain.',
    `employer_contribution_cap` DECIMAL(18,2) COMMENT 'The employer contribution cap attribute capturing relevant data for the contribution strategy in the employer domain.',
    `hra_employer_seed_amount` DECIMAL(18,2) COMMENT 'The numeric hra employer seed amount value associated with this contribution strategy record.',
    `hsa_employer_seed_amount` DECIMAL(18,2) COMMENT 'The numeric hsa employer seed amount value associated with this contribution strategy record.',
    `is_post_tax` BOOLEAN COMMENT 'Boolean flag indicating whether post tax condition applies.',
    `is_pre_tax` BOOLEAN COMMENT 'Boolean flag indicating whether pre tax condition applies.',
    `last_review_date` DATE COMMENT 'The date value representing last review date for this contribution strategy record.',
    `maximum_employee_contribution` DECIMAL(18,2) COMMENT 'The maximum employee contribution attribute capturing relevant data for the contribution strategy in the employer domain.',
    `minimum_employee_contribution` DECIMAL(18,2) COMMENT 'The minimum employee contribution attribute capturing relevant data for the contribution strategy in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the contribution strategy in the employer domain.',
    `review_status` STRING COMMENT 'The current status indicator for the review within the workflow.',
    `tax_credit_eligible` BOOLEAN COMMENT 'The tax credit eligible attribute capturing relevant data for the contribution strategy in the employer domain.',
    `tier_code` STRING COMMENT 'A standardized code representing the tier classification.',
    `updated_by` STRING COMMENT 'The updated by attribute capturing relevant data for the contribution strategy in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the contribution strategy in the employer domain.',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the contribution strategy in the employer domain.',
    CONSTRAINT pk_contribution_strategy PRIMARY KEY(`contribution_strategy_id`)
) COMMENT 'Employer contribution strategy';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` (
    `group_renewal_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'Unique identifier for the tpa record within the group renewal entity.',
    `amendment_count` STRING COMMENT 'The total count of amendment items associated with this record.',
    `amendment_flag` BOOLEAN COMMENT 'Boolean indicator for the amendment condition or state.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'The audit created timestamp attribute capturing relevant data for the group renewal in the employer domain.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'The audit updated timestamp attribute capturing relevant data for the group renewal in the employer domain.',
    `benefit_plan_ids` STRING COMMENT 'The benefit plan ids attribute capturing relevant data for the group renewal in the employer domain.',
    `compliance_check_date` DATE COMMENT 'The date value representing compliance check date for this group renewal record.',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the group renewal in the employer domain.',
    `erisa_status` STRING COMMENT 'The current status indicator for the erisa within the workflow.',
    `funding_arrangement` STRING COMMENT 'The funding arrangement attribute capturing relevant data for the group renewal in the employer domain.',
    `group_size` STRING COMMENT 'The group size attribute capturing relevant data for the group renewal in the employer domain.',
    `latest_amendment_after_value` DECIMAL(18,2) COMMENT 'The latest amendment after value attribute capturing relevant data for the group renewal in the employer domain.',
    `latest_amendment_approval_status` STRING COMMENT 'The current status indicator for the latest amendment approval within the workflow.',
    `latest_amendment_before_value` DECIMAL(18,2) COMMENT 'The latest amendment before value attribute capturing relevant data for the group renewal in the employer domain.',
    `latest_amendment_effective_date` DATE COMMENT 'The date value representing latest amendment effective date for this group renewal record.',
    `latest_amendment_reason_code` STRING COMMENT 'A standardized code representing the latest amendment reason classification.',
    `latest_amendment_type` STRING COMMENT 'The category or classification type of the latest amendment.',
    `participation_requirement_met` BOOLEAN COMMENT 'The participation requirement met attribute capturing relevant data for the group renewal in the employer domain.',
    `participation_requirement_outcome` STRING COMMENT 'The participation requirement outcome attribute capturing relevant data for the group renewal in the employer domain.',
    `premium_rate_prior_year` DECIMAL(18,2) COMMENT 'The calendar or fiscal year associated with the premium rate prior.',
    `premium_rate_renewal_year` DECIMAL(18,2) COMMENT 'The calendar or fiscal year associated with the premium rate renewal.',
    `prior_renewal_effective_date` DATE COMMENT 'The date value representing prior renewal effective date for this group renewal record.',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'The rate change percentage attribute capturing relevant data for the group renewal in the employer domain.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory compliance condition or state.',
    `renewal_cycle_year` STRING COMMENT 'The calendar or fiscal year associated with the renewal cycle.',
    `renewal_effective_date` DATE COMMENT 'The date value representing renewal effective date for this group renewal record.',
    `renewal_end_date` DATE COMMENT 'The date value representing renewal end date for this group renewal record.',
    `renewal_notes` STRING COMMENT 'The renewal notes attribute capturing relevant data for the group renewal in the employer domain.',
    `renewal_status` STRING COMMENT 'The current status indicator for the renewal within the workflow.',
    `renewal_status_date` DATE COMMENT 'The date value representing renewal status date for this group renewal record.',
    `retention_outcome` STRING COMMENT 'The retention outcome attribute capturing relevant data for the group renewal in the employer domain.',
    `retention_reason_code` STRING COMMENT 'A standardized code representing the retention reason classification.',
    `sic_code` STRING COMMENT 'A standardized code representing the sic classification.',
    CONSTRAINT pk_group_renewal PRIMARY KEY(`group_renewal_id`)
) COMMENT 'Employer group renewal';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` (
    `participation_requirement_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `compliance_review_due_date` DATE COMMENT 'The date value representing compliance review due date for this participation requirement record.',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the participation requirement in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the participation requirement in the employer domain.',
    `participation_requirement_description` STRING COMMENT 'A detailed textual description of the participation requirement.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the participation requirement in the employer domain.',
    `effective_until` DATE COMMENT 'The effective until attribute capturing relevant data for the participation requirement in the employer domain.',
    `enrolled_headcount` STRING COMMENT 'The enrolled headcount attribute capturing relevant data for the participation requirement in the employer domain.',
    `erisa_status` STRING COMMENT 'The current status indicator for the erisa within the workflow.',
    `funding_arrangement` STRING COMMENT 'The funding arrangement attribute capturing relevant data for the participation requirement in the employer domain.',
    `group_size` STRING COMMENT 'The group size attribute capturing relevant data for the participation requirement in the employer domain.',
    `last_evaluated_date` DATE COMMENT 'The date value representing last evaluated date for this participation requirement record.',
    `measurement_period` STRING COMMENT 'The measurement period attribute capturing relevant data for the participation requirement in the employer domain.',
    `minimum_enrolled_headcount` STRING COMMENT 'The minimum enrolled headcount attribute capturing relevant data for the participation requirement in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the participation requirement in the employer domain.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'The participation percentage attribute capturing relevant data for the participation requirement in the employer domain.',
    `participation_requirement_status` STRING COMMENT 'The current status indicator for the participation requirement within the workflow.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory reporting condition or state.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this participation requirement record.',
    `requirement_code` STRING COMMENT 'A standardized code representing the requirement classification.',
    `requirement_name` STRING COMMENT 'The descriptive name assigned to the requirement for identification purposes.',
    `requirement_type` STRING COMMENT 'The category or classification type of the requirement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the participation requirement in the employer domain.',
    `waiver_allowed` DECIMAL(18,2) COMMENT 'The waiver allowed attribute capturing relevant data for the participation requirement in the employer domain.',
    `waiver_percentage_allowed` DECIMAL(18,2) COMMENT 'The waiver percentage allowed attribute capturing relevant data for the participation requirement in the employer domain.',
    CONSTRAINT pk_participation_requirement PRIMARY KEY(`participation_requirement_id`)
) COMMENT 'Employer participation requirement';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` (
    `broker_assignment_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `agency_name` STRING COMMENT 'The descriptive name assigned to the agency for identification purposes.',
    `broker_assignment_status` STRING COMMENT 'The current status indicator for the broker assignment within the workflow.',
    `commission_basis` STRING COMMENT 'The commission basis attribute capturing relevant data for the broker assignment in the employer domain.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The numeric commission rate value associated with this broker assignment record.',
    `commission_type` STRING COMMENT 'The category or classification type of the commission.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the broker assignment in the employer domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this broker assignment record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this broker assignment record.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether primary condition applies.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the broker assignment in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the broker assignment in the employer domain.',
    CONSTRAINT pk_broker_assignment PRIMARY KEY(`broker_assignment_id`)
) COMMENT 'Broker assignment to employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` (
    `tpa_arrangement_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `stop_loss_policy_id` BIGINT COMMENT 'Foreign key linking to employer.stop_loss_policy. Business justification: TPA arrangements for self-funded groups include stop-loss coverage details. The tpa_arrangement table has 10 denormalized stop_loss columns (stop_loss_policy_number, stop_loss_premium, stop_loss_carri',
    `tpa_id` BIGINT COMMENT 'Unique identifier for the tpa record within the tpa arrangement entity.',
    `arrangement_name` STRING COMMENT 'The descriptive name assigned to the arrangement for identification purposes.',
    `arrangement_number` STRING COMMENT 'The arrangement number attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `arrangement_type` STRING COMMENT 'The category or classification type of the arrangement.',
    `contract_reference` STRING COMMENT 'The contract reference attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `contribution_rate_pmpm` DECIMAL(18,2) COMMENT 'The contribution rate pmpm attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this tpa arrangement record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this tpa arrangement record.',
    `erisa_status` STRING COMMENT 'The current status indicator for the erisa within the workflow.',
    `fee_schedule_cap_amount` DECIMAL(18,2) COMMENT 'The numeric fee schedule cap amount value associated with this tpa arrangement record.',
    `fee_schedule_rate_pmpm` DECIMAL(18,2) COMMENT 'The fee schedule rate pmpm attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `fee_schedule_type` DECIMAL(18,2) COMMENT 'The category or classification type of the fee schedule.',
    `gfc_control_flag` BOOLEAN COMMENT 'Boolean indicator for the gfc control condition or state.',
    `group_size_max` STRING COMMENT 'The numeric group size max value associated with this tpa arrangement record.',
    `group_size_min` STRING COMMENT 'The group size min attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the tpa arrangement in the employer domain.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this tpa arrangement record.',
    `tpa_arrangement_status` STRING COMMENT 'The current status indicator for the tpa arrangement within the workflow.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the tpa arrangement in the employer domain.',
    CONSTRAINT pk_tpa_arrangement PRIMARY KEY(`tpa_arrangement_id`)
) COMMENT 'TPA arrangement with employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` (
    `open_enrollment_window_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `change_deadline` DATE COMMENT 'The change deadline attribute capturing relevant data for the open enrollment window in the employer domain.',
    `coverage_type` STRING COMMENT 'The category or classification type of the coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the open enrollment window in the employer domain.',
    `eligible_employee_count` STRING COMMENT 'The total count of eligible employee items associated with this record.',
    `end_date` DATE COMMENT 'The date value representing end date for this open enrollment window record.',
    `enrollment_method` STRING COMMENT 'The enrollment method attribute capturing relevant data for the open enrollment window in the employer domain.',
    `enrollment_window_status` STRING COMMENT 'The current status indicator for the enrollment window within the workflow.',
    `enrollment_window_type` STRING COMMENT 'The category or classification type of the enrollment window.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the open enrollment window in the employer domain.',
    `participation_rate` DECIMAL(18,2) COMMENT 'The numeric participation rate value associated with this open enrollment window record.',
    `plan_selection_method` STRING COMMENT 'The plan selection method attribute capturing relevant data for the open enrollment window in the employer domain.',
    `start_date` DATE COMMENT 'The date value representing start date for this open enrollment window record.',
    `submission_deadline` DATE COMMENT 'The submission deadline attribute capturing relevant data for the open enrollment window in the employer domain.',
    `total_employee_count` DECIMAL(18,2) COMMENT 'The total count of total employee items associated with this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the open enrollment window in the employer domain.',
    `waiver_allowed` DECIMAL(18,2) COMMENT 'The waiver allowed attribute capturing relevant data for the open enrollment window in the employer domain.',
    `waiver_deadline` DATE COMMENT 'The waiver deadline attribute capturing relevant data for the open enrollment window in the employer domain.',
    `window_code` STRING COMMENT 'A standardized code representing the window classification.',
    CONSTRAINT pk_open_enrollment_window PRIMARY KEY(`open_enrollment_window_id`)
) COMMENT 'Open enrollment window for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` (
    `employer_underwriting_case_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: An employer underwriting case is typically initiated as part of a group renewal cycle. Linking employer_underwriting_case to group_renewal establishes the business context for the underwriting work. T',
    `tpa_id` BIGINT COMMENT 'Unique identifier for the tpa record within the employer underwriting case entity.',
    `aca_adjustment_factor` DECIMAL(18,2) COMMENT 'The aca adjustment factor attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `actuarial_basis_document` STRING COMMENT 'The actuarial basis document attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `age_gender_composite_factor` DECIMAL(18,2) COMMENT 'The age gender composite factor attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `case_number` STRING COMMENT 'The case number attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this employer underwriting case record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this employer underwriting case record.',
    `experience_rating_factor` DECIMAL(18,2) COMMENT 'The experience rating factor attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `geographic_factor` DECIMAL(18,2) COMMENT 'The geographic factor attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `group_average_age` DECIMAL(18,2) COMMENT 'The group average age attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `group_census_size` STRING COMMENT 'The group census size attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `group_female_percentage` DECIMAL(18,2) COMMENT 'The group female percentage attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `industry_risk_factor` DOUBLE COMMENT 'The industry risk factor attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `manual_rate_basis` BOOLEAN COMMENT 'The manual rate basis attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `pmpm_estimate` DECIMAL(18,2) COMMENT 'The pmpm estimate attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `prior_carrier_loss_experience` STRING COMMENT 'The prior carrier loss experience attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `quote_expiration_timestamp` TIMESTAMP COMMENT 'The quote expiration timestamp attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `quote_generated_timestamp` TIMESTAMP COMMENT 'The quote generated timestamp attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `quote_status` STRING COMMENT 'The current status indicator for the quote within the workflow.',
    `rating_area_code` STRING COMMENT 'A standardized code representing the rating area classification.',
    `rating_methodology` STRING COMMENT 'The rating methodology attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `risk_tier` STRING COMMENT 'The risk tier attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `submission_timestamp` TIMESTAMP COMMENT 'The submission timestamp attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `total_premium_estimate` DECIMAL(18,2) COMMENT 'The total premium estimate attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `underwriting_decision` STRING COMMENT 'The underwriting decision attribute capturing relevant data for the employer underwriting case in the employer domain.',
    `underwriting_status` STRING COMMENT 'The current status indicator for the underwriting within the workflow.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the employer underwriting case in the employer domain.',
    CONSTRAINT pk_employer_underwriting_case PRIMARY KEY(`employer_underwriting_case_id`)
) COMMENT 'Employer underwriting case';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` (
    `rate_quote_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `employer_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: A rate quote is the output of an employer underwriting case. The underwriting case contains the actuarial basis, rating factors, and methodology that produce the quote. Linking rate_quote to employer_',
    `group_id` BIGINT COMMENT 'FK to group',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: A rate quote is produced as part of a group renewal cycle. Linking rate_quote to group_renewal establishes the renewal context for the quote. This FK is nullable — new business quotes will not have a ',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `tpa_id` BIGINT COMMENT 'Unique identifier for the tpa record within the rate quote entity.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the rate quote in the employer domain.',
    `coverage_tier` STRING COMMENT 'The coverage tier attribute capturing relevant data for the rate quote in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the rate quote in the employer domain.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The numeric discount amount value associated with this rate quote record.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this rate quote record.',
    `erisa_status` STRING COMMENT 'The current status indicator for the erisa within the workflow.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this rate quote record.',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'The numeric gross premium amount value associated with this rate quote record.',
    `group_sic_code` STRING COMMENT 'A standardized code representing the group sic classification.',
    `group_size` STRING COMMENT 'The group size attribute capturing relevant data for the rate quote in the employer domain.',
    `group_type` STRING COMMENT 'The category or classification type of the group.',
    `issue_timestamp` TIMESTAMP COMMENT 'The issue timestamp attribute capturing relevant data for the rate quote in the employer domain.',
    `member_count` STRING COMMENT 'The total count of member items associated with this record.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'The numeric net premium amount value associated with this rate quote record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the rate quote in the employer domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'The numeric pmpm rate value associated with this rate quote record.',
    `quote_number` STRING COMMENT 'The quote number attribute capturing relevant data for the rate quote in the employer domain.',
    `quote_version` STRING COMMENT 'The quote version attribute capturing relevant data for the rate quote in the employer domain.',
    `rate_quote_status` DOUBLE COMMENT 'The current status indicator for the rate quote within the workflow.',
    `rating_area` STRING COMMENT 'The rating area attribute capturing relevant data for the rate quote in the employer domain.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this rate quote record.',
    `total_group_premium_estimate` DECIMAL(18,2) COMMENT 'The total group premium estimate attribute capturing relevant data for the rate quote in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the rate quote in the employer domain.',
    CONSTRAINT pk_rate_quote PRIMARY KEY(`rate_quote_id`)
) COMMENT 'Rate quote for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` (
    `group_amendment_id` BIGINT COMMENT 'Primary key',
    `employer_contract_id` BIGINT COMMENT 'Foreign key linking to employer.employer_contract. Business justification: A group amendment modifies a specific employer contract. The group_amendment table tracks changes (before_value, after_value, amendment_type, reason_code) but has no FK to the contract being amended. ',
    `group_id` BIGINT COMMENT 'FK to group',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Group amendments are frequently triggered by or associated with renewal cycles. The group_renewal table has denormalized amendment tracking fields (amendment_count, amendment_flag, latest_amendment_af',
    `after_value` DECIMAL(18,2) COMMENT 'The after value attribute capturing relevant data for the group amendment in the employer domain.',
    `amendment_number` STRING COMMENT 'The amendment number attribute capturing relevant data for the group amendment in the employer domain.',
    `amendment_status` STRING COMMENT 'The current status indicator for the amendment within the workflow.',
    `amendment_type` STRING COMMENT 'The category or classification type of the amendment.',
    `approval_timestamp` TIMESTAMP COMMENT 'The approval timestamp attribute capturing relevant data for the group amendment in the employer domain.',
    `approval_user_role` STRING COMMENT 'The approval user role attribute capturing relevant data for the group amendment in the employer domain.',
    `before_value` DECIMAL(18,2) COMMENT 'The before value attribute capturing relevant data for the group amendment in the employer domain.',
    `contribution_change_amount` DECIMAL(18,2) COMMENT 'The numeric contribution change amount value associated with this group amendment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group amendment in the employer domain.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this group amendment record.',
    `is_critical_change` BOOLEAN COMMENT 'Boolean flag indicating whether critical change condition applies.',
    `new_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric new contribution amount value associated with this group amendment record.',
    `original_contribution_amount` DECIMAL(18,2) COMMENT 'The numeric original contribution amount value associated with this group amendment record.',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification.',
    `reason_description` STRING COMMENT 'A detailed textual description of the reason.',
    `submission_timestamp` TIMESTAMP COMMENT 'The submission timestamp attribute capturing relevant data for the group amendment in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group amendment in the employer domain.',
    CONSTRAINT pk_group_amendment PRIMARY KEY(`group_amendment_id`)
) COMMENT 'Employer group amendment';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` (
    `cobra_administration_id` BIGINT COMMENT 'Primary key',
    `employer_contract_id` BIGINT COMMENT 'Foreign key linking to employer.employer_contract. Business justification: COBRA administration arrangements are governed by the employer contract. The cobra_administration table tracks COBRA eligibility, election periods, and compliance but has no FK to the governing employ',
    `group_id` BIGINT COMMENT 'FK to group',
    `administrator_name` STRING COMMENT 'The descriptive name assigned to the administrator for identification purposes.',
    `administrator_type` STRING COMMENT 'The category or classification type of the administrator.',
    `agreement_type` STRING COMMENT 'The category or classification type of the agreement.',
    `cobra_administration_status` DOUBLE COMMENT 'The current status indicator for the cobra administration within the workflow.',
    `cobra_agreement_number` STRING COMMENT 'The cobra agreement number attribute capturing relevant data for the cobra administration in the employer domain.',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the cobra administration in the employer domain.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the cobra administration in the employer domain.',
    `effective_until` DATE COMMENT 'The effective until attribute capturing relevant data for the cobra administration in the employer domain.',
    `election_end_date` DATE COMMENT 'The date value representing election end date for this cobra administration record.',
    `election_period_days` STRING COMMENT 'The election period days attribute capturing relevant data for the cobra administration in the employer domain.',
    `election_start_date` DATE COMMENT 'The date value representing election start date for this cobra administration record.',
    `group_cobra_eligibility` BOOLEAN COMMENT 'The group cobra eligibility attribute capturing relevant data for the cobra administration in the employer domain.',
    `last_compliance_check_date` DATE COMMENT 'The date value representing last compliance check date for this cobra administration record.',
    `max_employee_count` STRING COMMENT 'The total count of max employee items associated with this record.',
    `min_employee_count` STRING COMMENT 'The total count of min employee items associated with this record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the cobra administration in the employer domain.',
    `notification_method` STRING COMMENT 'The notification method attribute capturing relevant data for the cobra administration in the employer domain.',
    `notification_required` BOOLEAN COMMENT 'The notification required attribute capturing relevant data for the cobra administration in the employer domain.',
    `premium_rate` DECIMAL(18,2) COMMENT 'The numeric premium rate value associated with this cobra administration record.',
    `premium_rate_multiplier` DECIMAL(18,2) COMMENT 'The premium rate multiplier attribute capturing relevant data for the cobra administration in the employer domain.',
    `qualifying_event_type` STRING COMMENT 'The category or classification type of the qualifying event.',
    `state_cobra_law` STRING COMMENT 'The state cobra law attribute capturing relevant data for the cobra administration in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the cobra administration in the employer domain.',
    CONSTRAINT pk_cobra_administration PRIMARY KEY(`cobra_administration_id`)
) COMMENT 'COBRA administration for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` (
    `wellness_program_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `aca_compliance_classification` STRING COMMENT 'The aca compliance classification attribute capturing relevant data for the wellness program in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the wellness program in the employer domain.',
    `current_participant_count` STRING COMMENT 'The total count of current participant items associated with this record.',
    `wellness_program_description` STRING COMMENT 'A detailed textual description of the wellness program.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this wellness program record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this wellness program record.',
    `eligibility_criteria` STRING COMMENT 'The eligibility criteria attribute capturing relevant data for the wellness program in the employer domain.',
    `enrollment_cap` STRING COMMENT 'The enrollment cap attribute capturing relevant data for the wellness program in the employer domain.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'The numeric incentive amount value associated with this wellness program record.',
    `incentive_currency_code` STRING COMMENT 'A standardized code representing the incentive currency classification.',
    `incentive_type` STRING COMMENT 'The category or classification type of the incentive.',
    `is_eligible_for_tax_credit` BOOLEAN COMMENT 'Boolean flag indicating whether eligible for tax credit condition applies.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether mandatory condition applies.',
    `participation_method` STRING COMMENT 'The participation method attribute capturing relevant data for the wellness program in the employer domain.',
    `program_actual_participation_pct` DECIMAL(18,2) COMMENT 'The program actual participation pct attribute capturing relevant data for the wellness program in the employer domain.',
    `program_budget_amount` DECIMAL(18,2) COMMENT 'The numeric program budget amount value associated with this wellness program record.',
    `program_budget_currency` DECIMAL(18,2) COMMENT 'The program budget currency attribute capturing relevant data for the wellness program in the employer domain.',
    `program_category` STRING COMMENT 'The program category attribute capturing relevant data for the wellness program in the employer domain.',
    `program_code` STRING COMMENT 'A standardized code representing the program classification.',
    `program_compliance_notes` STRING COMMENT 'The program compliance notes attribute capturing relevant data for the wellness program in the employer domain.',
    `program_effective_year` STRING COMMENT 'The calendar or fiscal year associated with the program effective.',
    `program_end_reason` STRING COMMENT 'The program end reason attribute capturing relevant data for the wellness program in the employer domain.',
    `program_last_review_date` DATE COMMENT 'The date value representing program last review date for this wellness program record.',
    `program_name` STRING COMMENT 'The descriptive name assigned to the program for identification purposes.',
    `program_review_status` STRING COMMENT 'The current status indicator for the program review within the workflow.',
    `program_risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The program risk adjustment factor attribute capturing relevant data for the wellness program in the employer domain.',
    `program_source_system` STRING COMMENT 'The program source system attribute capturing relevant data for the wellness program in the employer domain.',
    `program_subtype` STRING COMMENT 'The program subtype attribute capturing relevant data for the wellness program in the employer domain.',
    `program_target_participation_pct` DECIMAL(18,2) COMMENT 'The program target participation pct attribute capturing relevant data for the wellness program in the employer domain.',
    `program_type` STRING COMMENT 'The category or classification type of the program.',
    `program_version` STRING COMMENT 'The program version attribute capturing relevant data for the wellness program in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the wellness program in the employer domain.',
    `wellness_program_status` STRING COMMENT 'The current status indicator for the wellness program within the workflow.',
    CONSTRAINT pk_wellness_program PRIMARY KEY(`wellness_program_id`)
) COMMENT 'Wellness program for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_document` (
    `group_document_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to group',
    `amendment_date` DATE COMMENT 'The date value representing amendment date for this group document record.',
    `amendment_number` STRING COMMENT 'The amendment number attribute capturing relevant data for the group document in the employer domain.',
    `audit_trail` STRING COMMENT 'The audit trail attribute capturing relevant data for the group document in the employer domain.',
    `checksum` STRING COMMENT 'The checksum attribute capturing relevant data for the group document in the employer domain.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `confidential` BOOLEAN COMMENT 'The confidential attribute capturing relevant data for the group document in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group document in the employer domain.',
    `document_category` STRING COMMENT 'The document category attribute capturing relevant data for the group document in the employer domain.',
    `document_language` STRING COMMENT 'The document language attribute capturing relevant data for the group document in the employer domain.',
    `document_title` STRING COMMENT 'The document title attribute capturing relevant data for the group document in the employer domain.',
    `document_type` STRING COMMENT 'The category or classification type of the document.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this group document record.',
    `erisa_plan_administrator` STRING COMMENT 'The erisa plan administrator attribute capturing relevant data for the group document in the employer domain.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this group document record.',
    `expiration_policy` DOUBLE COMMENT 'The expiration policy attribute capturing relevant data for the group document in the employer domain.',
    `fiduciary_designation` STRING COMMENT 'The fiduciary designation attribute capturing relevant data for the group document in the employer domain.',
    `file_format` STRING COMMENT 'The file format attribute capturing relevant data for the group document in the employer domain.',
    `file_size_bytes` BIGINT COMMENT 'The file size bytes attribute capturing relevant data for the group document in the employer domain.',
    `group_document_status` STRING COMMENT 'The current status indicator for the group document within the workflow.',
    `is_electronic` BOOLEAN COMMENT 'Boolean flag indicating whether electronic condition applies.',
    `is_mandatory` BOOLEAN COMMENT 'Boolean flag indicating whether mandatory condition applies.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether primary condition applies.',
    `last_reviewed_date` DATE COMMENT 'The date value representing last reviewed date for this group document record.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the group document in the employer domain.',
    `physical_location` STRING COMMENT 'The physical location attribute capturing relevant data for the group document in the employer domain.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `retention_period_months` STRING COMMENT 'The retention period months attribute capturing relevant data for the group document in the employer domain.',
    `reviewed_by` STRING COMMENT 'The reviewed by attribute capturing relevant data for the group document in the employer domain.',
    `source_system_document_reference` STRING COMMENT 'The source system document reference attribute capturing relevant data for the group document in the employer domain.',
    `storage_uri` STRING COMMENT 'The storage uri attribute capturing relevant data for the group document in the employer domain.',
    `trust_agreement_details` STRING COMMENT 'The trust agreement details attribute capturing relevant data for the group document in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group document in the employer domain.',
    `version_number` STRING COMMENT 'The version number attribute capturing relevant data for the group document in the employer domain.',
    CONSTRAINT pk_group_document PRIMARY KEY(`group_document_id`)
) COMMENT 'Employer group document';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` (
    `aso_fee_schedule_id` DECIMAL(18,2) COMMENT 'Primary key',
    `employer_contract_id` BIGINT COMMENT 'Foreign key linking to employer.employer_contract. Business justification: ASO fee schedules are contractual components of Administrative Services Only employer contracts. The aso_fee_schedule table defines the fee structure (PMPM rates, caps, billing frequency) but has no F',
    `group_id` BIGINT COMMENT 'FK to group',
    `aso_fee_schedule_status` DECIMAL(18,2) COMMENT 'The current status indicator for the aso fee schedule within the workflow.',
    `billing_frequency` STRING COMMENT 'The billing frequency attribute capturing relevant data for the aso fee schedule in the employer domain.',
    `cap_amount` DECIMAL(18,2) COMMENT 'The numeric cap amount value associated with this aso fee schedule record.',
    `cap_type` STRING COMMENT 'The category or classification type of the cap.',
    `component_type` STRING COMMENT 'The category or classification type of the component.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the aso fee schedule in the employer domain.',
    `currency_code` STRING COMMENT 'A standardized code representing the currency classification.',
    `aso_fee_schedule_description` DECIMAL(18,2) COMMENT 'A detailed textual description of the aso fee schedule.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this aso fee schedule record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this aso fee schedule record.',
    `eligibility_criteria` STRING COMMENT 'The eligibility criteria attribute capturing relevant data for the aso fee schedule in the employer domain.',
    `is_taxable` BOOLEAN COMMENT 'Boolean flag indicating whether taxable condition applies.',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'The minimum participation percent attribute capturing relevant data for the aso fee schedule in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the aso fee schedule in the employer domain.',
    `pm_per_member_rate` DECIMAL(18,2) COMMENT 'The numeric pm per member rate value associated with this aso fee schedule record.',
    `schedule_code` STRING COMMENT 'A standardized code representing the schedule classification.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The numeric tax rate value associated with this aso fee schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the aso fee schedule in the employer domain.',
    CONSTRAINT pk_aso_fee_schedule PRIMARY KEY(`aso_fee_schedule_id`)
) COMMENT 'ASO fee schedule for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` (
    `stop_loss_policy_id` BIGINT COMMENT 'Primary key',
    `employer_contract_id` BIGINT COMMENT 'Foreign key linking to employer.employer_contract. Business justification: Stop-loss policies are associated with self-funded employer contracts. The stop_loss_policy table tracks aggregate and individual attachment points, premiums, and coverage scope but has no FK to the g',
    `group_id` BIGINT COMMENT 'FK to group',
    `aggregate_attachment_point` DECIMAL(18,2) COMMENT 'The aggregate attachment point attribute capturing relevant data for the stop loss policy in the employer domain.',
    `aggregate_deductible_reset_period` DECIMAL(18,2) COMMENT 'The aggregate deductible reset period attribute capturing relevant data for the stop loss policy in the employer domain.',
    `attachment_point_type` STRING COMMENT 'The category or classification type of the attachment point.',
    `carrier_name` STRING COMMENT 'The descriptive name assigned to the carrier for identification purposes.',
    `claim_payment_limit` DECIMAL(18,2) COMMENT 'The claim payment limit attribute capturing relevant data for the stop loss policy in the employer domain.',
    `claim_payment_limit_currency` DECIMAL(18,2) COMMENT 'The claim payment limit currency attribute capturing relevant data for the stop loss policy in the employer domain.',
    `contribution_strategy` DOUBLE COMMENT 'The contribution strategy attribute capturing relevant data for the stop loss policy in the employer domain.',
    `covered_benefit_codes` STRING COMMENT 'The covered benefit codes attribute capturing relevant data for the stop loss policy in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the stop loss policy in the employer domain.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The numeric deductible amount value associated with this stop loss policy record.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the stop loss policy in the employer domain.',
    `effective_until` DATE COMMENT 'The effective until attribute capturing relevant data for the stop loss policy in the employer domain.',
    `individual_attachment_point` DECIMAL(18,2) COMMENT 'The individual attachment point attribute capturing relevant data for the stop loss policy in the employer domain.',
    `lasering_provision_flag` BOOLEAN COMMENT 'Boolean indicator for the lasering provision condition or state.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the stop loss policy in the employer domain.',
    `policy_number` STRING COMMENT 'The policy number attribute capturing relevant data for the stop loss policy in the employer domain.',
    `policy_type` STRING COMMENT 'The category or classification type of the policy.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The numeric premium amount value associated with this stop loss policy record.',
    `premium_currency` DECIMAL(18,2) COMMENT 'The premium currency attribute capturing relevant data for the stop loss policy in the employer domain.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this stop loss policy record.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'The risk adjustment factor attribute capturing relevant data for the stop loss policy in the employer domain.',
    `stop_loss_policy_status` STRING COMMENT 'The current status indicator for the stop loss policy within the workflow.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this stop loss policy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the stop loss policy in the employer domain.',
    CONSTRAINT pk_stop_loss_policy PRIMARY KEY(`stop_loss_policy_id`)
) COMMENT 'Stop loss policy for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` (
    `group_rating_factor_id` BIGINT COMMENT 'Primary key',
    `employer_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: Group rating factors are inputs to the employer underwriting case. The group_rating_factor table tracks individual factors (age/gender, geographic, industry risk, experience) that are applied during u',
    `group_id` BIGINT COMMENT 'FK to group',
    `rate_quote_id` BIGINT COMMENT 'Foreign key linking to employer.rate_quote. Business justification: Group rating factors are applied to produce specific rate quotes. Linking group_rating_factor to rate_quote establishes which factors were used to produce a given quote, supporting actuarial audit tra',
    `actuarial_basis` STRING COMMENT 'The actuarial basis attribute capturing relevant data for the group rating factor in the employer domain.',
    `adjustment_reason` STRING COMMENT 'The adjustment reason attribute capturing relevant data for the group rating factor in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the group rating factor in the employer domain.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this group rating factor record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this group rating factor record.',
    `factor_code` DOUBLE COMMENT 'A standardized code representing the factor classification.',
    `factor_description` DOUBLE COMMENT 'A detailed textual description of the factor.',
    `factor_type` DOUBLE COMMENT 'The category or classification type of the factor.',
    `factor_value` DECIMAL(18,2) COMMENT 'The factor value attribute capturing relevant data for the group rating factor in the employer domain.',
    `group_rating_factor_status` DOUBLE COMMENT 'The current status indicator for the group rating factor within the workflow.',
    `is_adjusted` BOOLEAN COMMENT 'Boolean flag indicating whether adjusted condition applies.',
    `is_default` BOOLEAN COMMENT 'Boolean flag indicating whether default condition applies.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the group rating factor in the employer domain.',
    `rating_period_end` DATE COMMENT 'The rating period end attribute capturing relevant data for the group rating factor in the employer domain.',
    `rating_period_start` DATE COMMENT 'The rating period start attribute capturing relevant data for the group rating factor in the employer domain.',
    `regulatory_reference` STRING COMMENT 'The regulatory reference attribute capturing relevant data for the group rating factor in the employer domain.',
    `source_system_factor_reference` DOUBLE COMMENT 'The source system factor reference attribute capturing relevant data for the group rating factor in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the group rating factor in the employer domain.',
    `value_unit` STRING COMMENT 'The value unit attribute capturing relevant data for the group rating factor in the employer domain.',
    CONSTRAINT pk_group_rating_factor PRIMARY KEY(`group_rating_factor_id`)
) COMMENT 'Group rating factor';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` (
    `erisa_plan_document_id` BIGINT COMMENT 'Primary key',
    `employer_contract_id` BIGINT COMMENT 'Foreign key linking to employer.employer_contract. Business justification: ERISA plan documents are part of the employer contract documentation package. The erisa_plan_document table tracks plan administrator details, fiduciary designations, and trust information that are co',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: ERISA plan documents belong to specific employer groups. The erisa_plan_document table currently only has health_plan_id (cross-domain FK to plan.health_plan) but lacks a direct link to the employer g',
    `health_plan_id` BIGINT COMMENT 'FK to health plan',
    `amendment_date` DATE COMMENT 'The date value representing amendment date for this erisa plan document record.',
    `amendment_description` STRING COMMENT 'A detailed textual description of the amendment.',
    `amendment_number` STRING COMMENT 'The amendment number attribute capturing relevant data for the erisa plan document in the employer domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the erisa plan document in the employer domain.',
    `document_name` STRING COMMENT 'The descriptive name assigned to the document for identification purposes.',
    `document_number` STRING COMMENT 'The document number attribute capturing relevant data for the erisa plan document in the employer domain.',
    `document_type` STRING COMMENT 'The category or classification type of the document.',
    `effective_from` DATE COMMENT 'The effective from attribute capturing relevant data for the erisa plan document in the employer domain.',
    `effective_until` DATE COMMENT 'The effective until attribute capturing relevant data for the erisa plan document in the employer domain.',
    `erisa_plan_document_status` STRING COMMENT 'The current status indicator for the erisa plan document within the workflow.',
    `fiduciary_name` STRING COMMENT 'The descriptive name assigned to the fiduciary for identification purposes.',
    `fiduciary_role` STRING COMMENT 'The fiduciary role attribute capturing relevant data for the erisa plan document in the employer domain.',
    `filing_deadline_date` DATE COMMENT 'The date value representing filing deadline date for this erisa plan document record.',
    `filing_status` STRING COMMENT 'The current status indicator for the filing within the workflow.',
    `liability_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The numeric liability insurance coverage amount value associated with this erisa plan document record.',
    `liability_insurance_policy_number` STRING COMMENT 'The liability insurance policy number attribute capturing relevant data for the erisa plan document in the employer domain.',
    `liability_insurance_provider` STRING COMMENT 'The liability insurance provider attribute capturing relevant data for the erisa plan document in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the erisa plan document in the employer domain.',
    `plan_administrator_email` STRING COMMENT 'The plan administrator email attribute capturing relevant data for the erisa plan document in the employer domain.',
    `plan_administrator_name` STRING COMMENT 'The descriptive name assigned to the plan administrator for identification purposes.',
    `plan_name` STRING COMMENT 'The descriptive name assigned to the plan for identification purposes.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `trust_address` STRING COMMENT 'The trust address attribute capturing relevant data for the erisa plan document in the employer domain.',
    `trust_city` STRING COMMENT 'The trust city attribute capturing relevant data for the erisa plan document in the employer domain.',
    `trust_ein` STRING COMMENT 'The trust ein attribute capturing relevant data for the erisa plan document in the employer domain.',
    `trust_name` STRING COMMENT 'The descriptive name assigned to the trust for identification purposes.',
    `trust_state` STRING COMMENT 'The trust state attribute capturing relevant data for the erisa plan document in the employer domain.',
    `trust_zip` STRING COMMENT 'The trust zip attribute capturing relevant data for the erisa plan document in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the erisa plan document in the employer domain.',
    CONSTRAINT pk_erisa_plan_document PRIMARY KEY(`erisa_plan_document_id`)
) COMMENT 'ERISA plan document';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` (
    `regulatory_compliance_record_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'FK to employer group',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance condition or state.',
    `compliance_notes` STRING COMMENT 'The compliance notes attribute capturing relevant data for the regulatory compliance record in the employer domain.',
    `compliance_status` STRING COMMENT 'The current status indicator for the compliance within the workflow.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `filing_reference` STRING COMMENT 'The filing reference attribute capturing relevant data for the regulatory compliance record in the employer domain.',
    `last_assessment_date` DATE COMMENT 'The date value representing last assessment date for this regulatory compliance record record.',
    `next_assessment_due_date` DATE COMMENT 'The date value representing next assessment due date for this regulatory compliance record record.',
    `next_due_date` DATE COMMENT 'The date value representing next due date for this regulatory compliance record record.',
    `obligation_type` STRING COMMENT 'Type of obligation',
    `remediation_notes` STRING COMMENT 'The remediation notes attribute capturing relevant data for the regulatory compliance record in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_regulatory_compliance_record PRIMARY KEY(`regulatory_compliance_record_id`)
) COMMENT 'Regulatory compliance record for employer group';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` (
    `employer_contract_id` BIGINT COMMENT 'Primary key',
    `broker_id` BIGINT COMMENT 'FK to broker',
    `group_id` BIGINT COMMENT 'FK to group',
    `tpa_id` BIGINT COMMENT 'Foreign key linking to employer.tpa. Business justification: Employer contracts with ASO funding arrangements involve a Third Party Administrator. The employer_contract table has cobra_administrator as a STRING (denormalized TPA name) but no FK to the tpa maste',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `admin_fee_amount` DECIMAL(18,2) COMMENT 'Administrative fee amount',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'Aggregate stop loss limit',
    `annual_review_date` DATE COMMENT 'The date value representing annual review date for this employer contract record.',
    `aso_fee_amount` DECIMAL(18,2) COMMENT 'The numeric aso fee amount value associated with this employer contract record.',
    `aso_funding_arrangement` STRING COMMENT 'The aso funding arrangement attribute capturing relevant data for the employer contract in the employer domain.',
    `auto_renew_flag` BOOLEAN COMMENT 'Boolean indicator for the auto renew condition or state.',
    `billing_frequency` STRING COMMENT 'The billing frequency attribute capturing relevant data for the employer contract in the employer domain.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Broker commission rate',
    `contract_number` STRING COMMENT 'The contract number attribute capturing relevant data for the employer contract in the employer domain.',
    `contract_status` STRING COMMENT 'The current status indicator for the contract within the workflow.',
    `contract_type` STRING COMMENT 'The category or classification type of the contract.',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Employer contribution percentage',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the employer contract in the employer domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this employer contract record.',
    `employee_count` STRING COMMENT 'Number of employees covered',
    `employer_contract_status` STRING COMMENT 'The current status indicator for the employer contract within the workflow.',
    `erisa_plan_number` STRING COMMENT 'The erisa plan number attribute capturing relevant data for the employer contract in the employer domain.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this employer contract record.',
    `funding_arrangement` STRING COMMENT 'The funding arrangement attribute capturing relevant data for the employer contract in the employer domain.',
    `minimum_participation` DECIMAL(18,2) COMMENT 'Minimum required participation rate',
    `naics_code` STRING COMMENT 'NAICS industry code',
    `notes` STRING COMMENT 'Notes related to employer contract',
    `participation_rate` DECIMAL(18,2) COMMENT 'Participation rate percentage',
    `payment_terms` DECIMAL(18,2) COMMENT 'The payment terms attribute capturing relevant data for the employer contract in the employer domain.',
    `plan_year_end` DATE COMMENT 'Plan year end date',
    `plan_year_start` DATE COMMENT 'Plan year start date',
    `probation_period_days` STRING COMMENT 'Probation period in days',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this employer contract record.',
    `renewal_terms` STRING COMMENT 'The renewal terms attribute capturing relevant data for the employer contract in the employer domain.',
    `renewal_type` STRING COMMENT 'The category or classification type of the renewal.',
    `sic_code` STRING COMMENT 'Standard Industrial Classification code',
    `signed_by_name` STRING COMMENT 'The descriptive name assigned to the signed by for identification purposes.',
    `signed_date` DATE COMMENT 'The date value representing signed date for this employer contract record.',
    `source_system` STRING COMMENT 'Source system for contract record',
    `specific_limit` DECIMAL(18,2) COMMENT 'Specific stop loss limit',
    `stop_loss_attachment` DECIMAL(18,2) COMMENT 'Stop loss attachment point',
    `termination_date` DATE COMMENT 'The date value representing termination date for this employer contract record.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total contract value attribute capturing relevant data for the employer contract in the employer domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the employer contract in the employer domain.',
    `waiting_period_days` STRING COMMENT 'Waiting period in days for new employees',
    `wellness_incentive_amount` DECIMAL(18,2) COMMENT 'Wellness program incentive amount',
    CONSTRAINT pk_employer_contract PRIMARY KEY(`employer_contract_id`)
) COMMENT 'Employer contract';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key',
    `broker_agreement_id` BIGINT COMMENT 'FK to broker agreement',
    `general_agent_id` BIGINT COMMENT 'Foreign key linking to employer.general_agent. Business justification: In health insurance distribution, brokers operate under general agents (GAs) who manage distribution networks. The broker table has no direct FK to general_agent, though broker_agreement has general_a',
    `parent_broker_id` BIGINT COMMENT 'FK to parent broker',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `agreement_end_date` DATE COMMENT 'The date value representing agreement end date for this broker record.',
    `agreement_start_date` DATE COMMENT 'The date value representing agreement start date for this broker record.',
    `agreement_status` STRING COMMENT 'The current status indicator for the agreement within the workflow.',
    `agreement_terms` STRING COMMENT 'The agreement terms attribute capturing relevant data for the broker in the employer domain.',
    `broker_type` STRING COMMENT 'The category or classification type of the broker.',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the broker in the employer domain.',
    `commission_amount` DECIMAL(18,2) COMMENT 'The numeric commission amount value associated with this broker record.',
    `commission_currency` STRING COMMENT 'The commission currency attribute capturing relevant data for the broker in the employer domain.',
    `commission_end_date` DATE COMMENT 'The date value representing commission end date for this broker record.',
    `commission_rate` DECIMAL(18,2) COMMENT 'The numeric commission rate value associated with this broker record.',
    `commission_start_date` DATE COMMENT 'The date value representing commission start date for this broker record.',
    `country` STRING COMMENT 'The country attribute capturing relevant data for the broker in the employer domain.',
    `email` STRING COMMENT 'The email attribute capturing relevant data for the broker in the employer domain.',
    `end_date` DATE COMMENT 'The date value representing end date for this broker record.',
    `fax` STRING COMMENT 'The fax attribute capturing relevant data for the broker in the employer domain.',
    `license_number` STRING COMMENT 'The license number attribute capturing relevant data for the broker in the employer domain.',
    `broker_name` STRING COMMENT 'The descriptive name assigned to the broker for identification purposes.',
    `phone` STRING COMMENT 'The phone attribute capturing relevant data for the broker in the employer domain.',
    `postal_code` STRING COMMENT 'A standardized code representing the postal classification.',
    `rating` DECIMAL(18,2) COMMENT 'The rating attribute capturing relevant data for the broker in the employer domain.',
    `record_audit_created` TIMESTAMP COMMENT 'The record audit created attribute capturing relevant data for the broker in the employer domain.',
    `record_audit_updated` TIMESTAMP COMMENT 'The record audit updated attribute capturing relevant data for the broker in the employer domain.',
    `region` STRING COMMENT 'The region attribute capturing relevant data for the broker in the employer domain.',
    `registration_number` DOUBLE COMMENT 'The registration number attribute capturing relevant data for the broker in the employer domain.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this broker record.',
    `renewal_status` STRING COMMENT 'The current status indicator for the renewal within the workflow.',
    `start_date` DATE COMMENT 'The date value representing start date for this broker record.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the broker in the employer domain.',
    `broker_status` STRING COMMENT 'The current status indicator for the broker within the workflow.',
    `tax_number` STRING COMMENT 'The tax number attribute capturing relevant data for the broker in the employer domain.',
    `termination_reason` STRING COMMENT 'The termination reason attribute capturing relevant data for the broker in the employer domain.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Broker master record';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`tpa` (
    `tpa_id` BIGINT COMMENT 'Primary key',
    `parent_tpa_id` BIGINT COMMENT 'FK to parent TPA',
    `vendor_id` BIGINT COMMENT 'FK to vendor',
    `address_line1` STRING COMMENT 'TPA address line 1',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the tpa in the employer domain.',
    `contact_email` STRING COMMENT 'TPA contact email',
    `contact_name` STRING COMMENT 'TPA contact name',
    `contact_phone` STRING COMMENT 'TPA contact phone',
    `contract_currency` STRING COMMENT 'TPA contract currency',
    `contract_end_date` DATE COMMENT 'TPA contract end date',
    `contract_notes` STRING COMMENT 'TPA contract notes',
    `contract_number` STRING COMMENT 'TPA contract number',
    `contract_start_date` DATE COMMENT 'TPA contract start date',
    `contract_status` STRING COMMENT 'TPA contract status',
    `contract_type` STRING COMMENT 'TPA contract type',
    `contract_value` DECIMAL(18,2) COMMENT 'TPA contract value',
    `country` STRING COMMENT 'TPA country',
    `coverage_end_date` DATE COMMENT 'TPA coverage end date',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'TPA coverage limit amount',
    `coverage_limit_currency` STRING COMMENT 'TPA coverage limit currency',
    `coverage_start_date` DATE COMMENT 'TPA coverage start date',
    `coverage_status` STRING COMMENT 'TPA coverage status',
    `coverage_type` STRING COMMENT 'TPA coverage type',
    `created_at` TIMESTAMP COMMENT 'TPA created at',
    `tpa_name` STRING COMMENT 'The descriptive name assigned to the tpa for identification purposes.',
    `renewal_date` DATE COMMENT 'TPA renewal date',
    `renewal_status` STRING COMMENT 'TPA renewal status',
    `sla_end` DATE COMMENT 'TPA SLA end',
    `sla_notes` STRING COMMENT 'TPA SLA notes',
    `sla_start` DATE COMMENT 'TPA SLA start',
    `sla_status` STRING COMMENT 'TPA SLA status',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the tpa in the employer domain.',
    `tax_number` STRING COMMENT 'TPA tax number',
    `termination_date` DATE COMMENT 'TPA termination date',
    `termination_reason` STRING COMMENT 'TPA termination reason',
    `tpa_status` STRING COMMENT 'The current status indicator for the tpa within the workflow.',
    `tpa_type` STRING COMMENT 'The category or classification type of the tpa.',
    `updated_at` TIMESTAMP COMMENT 'TPA updated at',
    `zip` STRING COMMENT 'The zip attribute capturing relevant data for the tpa in the employer domain.',
    CONSTRAINT pk_tpa PRIMARY KEY(`tpa_id`)
) COMMENT 'Third party administrator master record';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` (
    `broker_agreement_id` BIGINT COMMENT 'Primary key',
    `group_id` BIGINT COMMENT 'Unique identifier for the employer group record within the broker agreement entity.',
    `general_agent_id` BIGINT COMMENT 'Unique identifier for the general agent record within the broker agreement entity.',
    `parent_broker_agreement_id` BIGINT COMMENT 'FK to parent broker agreement',
    `broker_id` BIGINT COMMENT 'Unique identifier for the broker record within the broker agreement entity.',
    `agreement_number` STRING COMMENT 'The agreement number attribute capturing relevant data for the broker agreement in the employer domain.',
    `agreement_type` STRING COMMENT 'The category or classification type of the agreement.',
    `amendment_count` STRING COMMENT 'The total count of amendment items associated with this record.',
    `appointment_date` DATE COMMENT 'The date value representing appointment date for this broker agreement record.',
    `appointment_status` STRING COMMENT 'The current status indicator for the appointment within the workflow.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean indicator for the auto renewal condition or state.',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'The numeric base commission rate value associated with this broker agreement record.',
    `commission_schedule_type` STRING COMMENT 'The category or classification type of the commission schedule.',
    `compensation_method` STRING COMMENT 'The compensation method attribute capturing relevant data for the broker agreement in the employer domain.',
    `compliance_certification_date` DATE COMMENT 'The date value representing compliance certification date for this broker agreement record.',
    `contract_version` STRING COMMENT 'The contract version attribute capturing relevant data for the broker agreement in the employer domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this broker agreement record.',
    `errors_omissions_expiry` DATE COMMENT 'The errors omissions expiry attribute capturing relevant data for the broker agreement in the employer domain.',
    `errors_omissions_required` BOOLEAN COMMENT 'The errors omissions required attribute capturing relevant data for the broker agreement in the employer domain.',
    `exclusivity_flag` BOOLEAN COMMENT 'Boolean indicator for the exclusivity condition or state.',
    `execution_date` DATE COMMENT 'The date value representing execution date for this broker agreement record.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this broker agreement record.',
    `market_segment` STRING COMMENT 'The market segment attribute capturing relevant data for the broker agreement in the employer domain.',
    `minimum_production_requirement` DECIMAL(18,2) COMMENT 'The minimum production requirement attribute capturing relevant data for the broker agreement in the employer domain.',
    `non_compete_period_months` STRING COMMENT 'The non compete period months attribute capturing relevant data for the broker agreement in the employer domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the broker agreement in the employer domain.',
    `override_commission_rate` DECIMAL(18,2) COMMENT 'The numeric override commission rate value associated with this broker agreement record.',
    `payment_frequency` DECIMAL(18,2) COMMENT 'The payment frequency attribute capturing relevant data for the broker agreement in the employer domain.',
    `product_line` STRING COMMENT 'The product line attribute capturing relevant data for the broker agreement in the employer domain.',
    `renewal_commission_rate` DECIMAL(18,2) COMMENT 'The numeric renewal commission rate value associated with this broker agreement record.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this broker agreement record.',
    `state_of_licensure` STRING COMMENT 'The state of licensure attribute capturing relevant data for the broker agreement in the employer domain.',
    `broker_agreement_status` STRING COMMENT 'The current status indicator for the broker agreement within the workflow.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this broker agreement record.',
    `termination_reason` STRING COMMENT 'The termination reason attribute capturing relevant data for the broker agreement in the employer domain.',
    `territory_code` STRING COMMENT 'A standardized code representing the territory classification.',
    CONSTRAINT pk_broker_agreement PRIMARY KEY(`broker_agreement_id`)
) COMMENT 'Broker agreement';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` (
    `general_agent_id` BIGINT COMMENT 'Primary key for general_agent',
    `supervising_general_agent_id` BIGINT COMMENT 'Self-referencing FK on general_agent (supervising_general_agent_id)',
    `agent_type` STRING COMMENT 'Classification of the general agents role in the distribution hierarchy. Distinguishes between General Agent (GA), Managing General Agent (MGA), Field Marketing Organization (FMO), independent broker, or Third-Party Administrator (TPA). [ENUM-REF-CANDIDATE: general_agent|managing_general_agent|field_marketing_organization|broker|tpa — promote to reference product]',
    `appointment_effective_date` DATE COMMENT 'Date on which the general agents appointment with the health plan became effective. Marks the start of the authorized distribution relationship.',
    `appointment_termination_date` DATE COMMENT 'Date on which the general agents appointment with the health plan was terminated. Null if the appointment is currently active. Required for regulatory termination filings.',
    `appointment_termination_reason` STRING COMMENT 'Reason code for the termination of the general agents appointment. Required for state insurance department termination filings under NAIC guidelines.',
    `background_check_date` DATE COMMENT 'Date on which the most recent background check was completed for the general agent.',
    `background_check_status` STRING COMMENT 'Status of the most recent background check conducted on the general agent organization or its principals as part of the appointment due diligence process.',
    `bank_account_number` STRING COMMENT 'Bank account number on file for ACH commission payment disbursements. Stored in encrypted form per PCI-DSS requirements.',
    `bank_routing_number` STRING COMMENT 'ABA routing transit number for the general agents bank account used for ACH commission disbursements.',
    `business_address_line1` STRING COMMENT 'First line of the general agents primary business mailing address. Used for commission check mailing, regulatory correspondence, and contract delivery.',
    `business_address_line2` STRING COMMENT 'Second line of the general agents primary business mailing address (suite, floor, unit number).',
    `business_city` STRING COMMENT 'City of the general agents primary business address.',
    `business_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the general agents primary business address. Typically USA for domestic health insurance operations.',
    `business_state` STRING COMMENT 'Two-letter USPS state code for the general agents primary business address. Used for state-specific regulatory compliance and commission tax reporting.',
    `business_zip_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the general agents primary business address.',
    `cms_certification_date` DATE COMMENT 'Date on which the general agent completed CMS-required certification for Medicare Advantage and/or Part D product distribution.',
    `commission_payment_method` STRING COMMENT 'Method by which commission payments are disbursed to the general agent. Drives payment processing routing in the financial system.',
    `commission_schedule_code` STRING COMMENT 'Code referencing the commission schedule applicable to this general agent. Determines commission rates, override structures, and bonus eligibility for group sales and renewals.',
    `contract_effective_date` DATE COMMENT 'Date on which the general agents distribution contract with the health plan became effective. Governs commission schedules, book-of-business rights, and service obligations.',
    `contract_expiration_date` DATE COMMENT 'Date on which the general agents distribution contract with the health plan expires or is scheduled for renewal. Null for evergreen contracts.',
    `contract_renewal_date` DATE COMMENT 'Date on which the general agents contract is scheduled for renewal review. Used by the producer management team to initiate renewal negotiations.',
    `dba_name` STRING COMMENT 'Trade name or doing business as name used by the general agent in market-facing activities, if different from the legal name.',
    `e_o_coverage_amount` DECIMAL(18,2) COMMENT 'Dollar amount of Errors and Omissions (E&O) professional liability coverage maintained by the general agent. Must meet minimum thresholds set by the health plans appointment requirements.',
    `e_o_expiration_date` DATE COMMENT 'Date on which the general agents E&O professional liability insurance policy expires. Used to trigger renewal reminders and flag compliance gaps.',
    `e_o_insurance_carrier` STRING COMMENT 'Name of the insurance carrier providing Errors and Omissions (E&O) professional liability coverage for the general agent. Required as a condition of appointment.',
    `e_o_policy_number` STRING COMMENT 'Policy number for the general agents Errors and Omissions (E&O) professional liability insurance policy.',
    `ga_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the general agent by the health plan or carrier. Used in downstream systems, commission statements, and regulatory filings to uniquely reference the GA.',
    `is_aca_certified` BOOLEAN COMMENT 'Indicates whether the general agent has completed required ACA marketplace training and certification for individual and small group exchange product sales.',
    `is_cms_approved` BOOLEAN COMMENT 'Indicates whether the general agent has completed CMS-required training and certification for Medicare Advantage and/or Part D product sales. Required for MA/PDP distribution.',
    `line_of_business` STRING COMMENT 'Health insurance line of business for which the general agent is contracted to distribute products. Determines applicable regulatory requirements and commission structures. [ENUM-REF-CANDIDATE: commercial|medicare_advantage|medicaid|dental|vision|life|disability — promote to reference product]',
    `market_segment` STRING COMMENT 'Health insurance market segment(s) in which the general agent is authorized to sell on behalf of the health plan. Drives product availability and commission schedule applicability.',
    `general_agent_name` STRING COMMENT 'Full legal business name of the general agent organization as registered with the state insurance department. Used for contracts, commission payments, and regulatory correspondence.',
    `npi` STRING COMMENT 'National Producer Number assigned by the NIPR (National Insurance Producer Registry) to uniquely identify the general agent across all states. Used for license verification and regulatory reporting. Note: field named npi per industry convention for producer identification.',
    `npn` STRING COMMENT 'National Producer Number (NPN) as assigned by the National Insurance Producer Registry (NIPR). Primary cross-state identifier for producer licensing verification and CMS reporting for Medicare/Medicaid lines of business.',
    `ofac_check_date` DATE COMMENT 'Date on which the most recent OFAC sanctions screening was performed for the general agent.',
    `ofac_check_status` STRING COMMENT 'Status of the OFAC (Office of Foreign Assets Control) sanctions screening for the general agent. Required to ensure the health plan does not conduct business with sanctioned entities.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the general agent organization. Used for commission statements, contract communications, and compliance notifications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the general agent organization for day-to-day operational communications with the health plan.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary contact at the general agent organization.',
    `primary_contact_title` STRING COMMENT 'Job title of the primary contact at the general agent organization (e.g., President, Director of Sales, Account Manager).',
    `primary_state_license_expiration_date` DATE COMMENT 'Date on which the general agents primary state insurance producer license expires. Used to trigger renewal reminders and suspend commission eligibility for unlicensed agents.',
    `primary_state_license_number` STRING COMMENT 'Insurance producer license number issued by the general agents primary state of domicile. Required for appointment processing and regulatory compliance verification.',
    `primary_state_license_state` STRING COMMENT 'Two-letter USPS state code for the state in which the general agent holds their primary insurance producer license (state of domicile).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the general agent record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the general agent record was most recently updated. Used for change tracking, audit trail, and incremental data pipeline processing.',
    `service_area_states` STRING COMMENT 'Comma-delimited list of two-letter state codes representing the states in which the general agent is authorized to market and sell health plan products. Used for geographic territory management.',
    `general_agent_status` STRING COMMENT 'Current lifecycle status of the general agent relationship with the health plan. Drives eligibility for commission payments, new group submissions, and renewal processing.',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) assigned to the general agent by the IRS. Required for commission payments, 1099 reporting, and ACA compliance filings.',
    `w9_on_file` BOOLEAN COMMENT 'Indicates whether a current IRS Form W-9 (Request for Taxpayer Identification Number and Certification) is on file for this general agent. Required before commission payments can be issued.',
    `w9_received_date` DATE COMMENT 'Date on which the most recent IRS Form W-9 was received from the general agent. Used to track compliance with IRS backup withholding requirements.',
    `website_url` STRING COMMENT 'Public website URL for the general agent organization. Used for producer directory listings and employer group referrals.',
    CONSTRAINT pk_general_agent PRIMARY KEY(`general_agent_id`)
) COMMENT 'Master reference table for general_agent. Referenced by general_agent_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ADD CONSTRAINT `fk_employer_group_contact_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_contribution_strategy_id` FOREIGN KEY (`contribution_strategy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`contribution_strategy`(`contribution_strategy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ADD CONSTRAINT `fk_employer_participation_requirement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_stop_loss_policy_id` FOREIGN KEY (`stop_loss_policy_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`stop_loss_policy`(`stop_loss_policy_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_employer_underwriting_case_id` FOREIGN KEY (`employer_underwriting_case_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case`(`employer_underwriting_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ADD CONSTRAINT `fk_employer_group_amendment_employer_contract_id` FOREIGN KEY (`employer_contract_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_contract`(`employer_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ADD CONSTRAINT `fk_employer_group_amendment_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ADD CONSTRAINT `fk_employer_group_amendment_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ADD CONSTRAINT `fk_employer_cobra_administration_employer_contract_id` FOREIGN KEY (`employer_contract_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_contract`(`employer_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ADD CONSTRAINT `fk_employer_cobra_administration_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ADD CONSTRAINT `fk_employer_wellness_program_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` ADD CONSTRAINT `fk_employer_group_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ADD CONSTRAINT `fk_employer_aso_fee_schedule_employer_contract_id` FOREIGN KEY (`employer_contract_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_contract`(`employer_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ADD CONSTRAINT `fk_employer_aso_fee_schedule_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_employer_contract_id` FOREIGN KEY (`employer_contract_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_contract`(`employer_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ADD CONSTRAINT `fk_employer_stop_loss_policy_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ADD CONSTRAINT `fk_employer_group_rating_factor_employer_underwriting_case_id` FOREIGN KEY (`employer_underwriting_case_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case`(`employer_underwriting_case_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ADD CONSTRAINT `fk_employer_group_rating_factor_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ADD CONSTRAINT `fk_employer_group_rating_factor_rate_quote_id` FOREIGN KEY (`rate_quote_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`rate_quote`(`rate_quote_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ADD CONSTRAINT `fk_employer_erisa_plan_document_employer_contract_id` FOREIGN KEY (`employer_contract_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`employer_contract`(`employer_contract_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ADD CONSTRAINT `fk_employer_erisa_plan_document_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` ADD CONSTRAINT `fk_employer_regulatory_compliance_record_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ADD CONSTRAINT `fk_employer_employer_contract_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ADD CONSTRAINT `fk_employer_employer_contract_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ADD CONSTRAINT `fk_employer_employer_contract_tpa_id` FOREIGN KEY (`tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_broker_agreement_id` FOREIGN KEY (`broker_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker_agreement`(`broker_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_general_agent_id` FOREIGN KEY (`general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ADD CONSTRAINT `fk_employer_tpa_parent_tpa_id` FOREIGN KEY (`parent_tpa_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`tpa`(`tpa_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_group_id` FOREIGN KEY (`group_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`group`(`group_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_general_agent_id` FOREIGN KEY (`general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_parent_broker_agreement_id` FOREIGN KEY (`parent_broker_agreement_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker_agreement`(`broker_agreement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ADD CONSTRAINT `fk_employer_broker_agreement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`broker`(`broker_id`);
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ADD CONSTRAINT `fk_employer_general_agent_supervising_general_agent_id` FOREIGN KEY (`supervising_general_agent_id`) REFERENCES `vibe_health_insurance_v1`.`employer`.`general_agent`(`general_agent_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_health_insurance_v1`.`employer` SET TAGS ('dbx_domain' = 'employer');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `tertiary_group_epo_plan_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_renewal` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Policy Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`open_enrollment_window` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` SET TAGS ('dbx_subdomain' = 'underwriting_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_sensitivity' = 'special_category');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_average_age` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` SET TAGS ('dbx_subdomain' = 'underwriting_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_amendment` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `administrator_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`cobra_administration` ALTER COLUMN `state_cobra_law` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` SET TAGS ('dbx_subdomain' = 'plan_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`wellness_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_document` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` SET TAGS ('dbx_subdomain' = 'underwriting_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`aso_fee_schedule` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` SET TAGS ('dbx_subdomain' = 'underwriting_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`stop_loss_policy` ALTER COLUMN `carrier_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` SET TAGS ('dbx_subdomain' = 'underwriting_pricing');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`group_rating_factor` ALTER COLUMN `rate_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `employer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Contract Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `document_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `fiduciary_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_address` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_ein` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`erisa_plan_document` ALTER COLUMN `trust_zip` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`regulatory_compliance_record` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` SET TAGS ('dbx_subdomain' = 'group_administration');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `tpa_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`employer_contract` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `general_agent_id` SET TAGS ('dbx_business_glossary_term' = 'General Agent Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_category' = 'person_name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tpa_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `tax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`tpa` ALTER COLUMN `zip` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `compensation_method` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`broker_agreement` ALTER COLUMN `state_of_licensure` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `general_agent_id` SET TAGS ('dbx_business_glossary_term' = 'General Agent Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `supervising_general_agent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `business_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `dba_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `e_o_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `general_agent_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `general_agent_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_state_license_expiration_date` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_state_license_number` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `primary_state_license_state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`employer`.`general_agent` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
