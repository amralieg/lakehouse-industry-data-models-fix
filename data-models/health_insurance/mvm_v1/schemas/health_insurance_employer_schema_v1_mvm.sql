-- Schema for Domain: employer | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`employer` COMMENT 'Manages employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Owns group demographics, SIC classification, group size, ASO/fully-insured funding arrangements, ERISA status, GFC controls, employer-subscriber relationships, contribution strategies, renewal dates, and participation requirements. Supports group billing aggregation, renewal management, and broker/TPA associations. Source system: Facets or QNXT group management module.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`group` (
    `group_id` BIGINT COMMENT 'System-generated unique identifier for the employer group record.',
    `broker_id` BIGINT COMMENT 'Reference to the broker or agency that sourced the group.',
    `address_line1` STRING COMMENT 'Primary street address of the employers headquarters.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `average_claim_cost` DECIMAL(18,2) COMMENT 'Average cost per claim historically incurred by the group.',
    `city` STRING COMMENT 'City component of the employers address.',
    `contribution_strategy` STRING COMMENT 'Method used to calculate employer contributions to premiums.. Valid values are `fixed|percentage|tiered`',
    `country` STRING COMMENT 'Country of the employers headquarters (ISO‑3 code).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employer group record was first created in the system.',
    `dba_name` STRING COMMENT 'Trade name or DBA under which the employer operates, if different from legal name.',
    `domicile_state` STRING COMMENT 'Two‑letter state code where the employer is legally domiciled.. Valid values are `^[A-Z]{2}$`',
    `effective_date` DATE COMMENT 'Date the employer group contract becomes binding.',
    `email_address` STRING COMMENT 'Primary email address for employer communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `enrollment_count_ec` STRING COMMENT 'Number of employees plus dependent children enrolled.',
    `enrollment_count_ef` STRING COMMENT 'Number of employees enrolled with full family coverage (employee, spouse, and children).',
    `enrollment_count_eo` STRING COMMENT 'Number of employees enrolled in employee‑only coverage.',
    `enrollment_count_es` STRING COMMENT 'Number of employees plus spouses enrolled.',
    `erisa_status` STRING COMMENT 'Indicates whether the group is subject to ERISA regulations.. Valid values are `covered|exempt`',
    `funding_arrangement` STRING COMMENT 'How the group pays for coverage: fully insured, ASO, or self‑funded.. Valid values are `fully_insured|aso|self_funded`',
    `gfc_code` BIGINT COMMENT 'Link to the financial control entity responsible for the groups accounting.',
    `group_number` STRING COMMENT 'Internal identifier assigned to the employer group by the insurer.',
    `group_status` STRING COMMENT 'Current lifecycle state of the employer group relationship.. Valid values are `prospect|active|suspended|terminated|reinstated`',
    `headcount_current` STRING COMMENT 'Current total number of employees covered under the group plan.',
    `headcount_last_month` STRING COMMENT 'Employee headcount as of the end of the previous month.',
    `headcount_last_year` STRING COMMENT 'Employee headcount as of the same month in the prior calendar year.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the status field last changed value.',
    `legal_name` STRING COMMENT 'Full legal name of the employer organization as registered.',
    `line_of_business` STRING COMMENT 'Primary product line(s) offered to the employer group.. Valid values are `health|dental|vision|wellness|pharmacy`',
    `market_segment` STRING COMMENT 'Regulatory market segment classification for the group.. Valid values are `small_group|large_group|individual`',
    `naics_code` STRING COMMENT 'Six‑digit code representing the employers industry sector.. Valid values are `^d{6}$`',
    `participation_requirement` STRING COMMENT 'Minimum employee participation level required for the group plan.',
    `phone_number` STRING COMMENT 'Primary business telephone number for the employer.. Valid values are `^d{10}$`',
    `postal_code` STRING COMMENT 'ZIP code for the employers address.. Valid values are `^d{5}(-d{4})?$`',
    `renewal_date` DATE COMMENT 'Scheduled date for contract renewal negotiations.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used in risk‑adjusted pricing for the group.',
    `sic_code` STRING COMMENT 'Four‑digit code classifying the employers primary industry.. Valid values are `^d{4}$`',
    `size_tier` STRING COMMENT 'Categorization of the employer based on employee headcount.. Valid values are `small|medium|large|enterprise`',
    `state` STRING COMMENT 'State component of the employers address.',
    `tax_id_ein` STRING COMMENT 'Federal tax identification number for the employer, used for reporting and compliance.. Valid values are `^d{2}-d{7}$`',
    `termination_date` DATE COMMENT 'Date the employer group contract is terminated or expires.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employer group record.',
    CONSTRAINT pk_group PRIMARY KEY(`group_id`)
) COMMENT 'Master record for employer group accounts — the B2B commercial customers who sponsor health coverage for their employees. Captures group demographics, legal entity name, tax ID (EIN), SIC/NAICS industry classification, group size tier, historical headcount and enrollment counts by coverage tier (EO/ES/EC/EF) tracked at monthly intervals for ACA small/large group market classification, line of business (LOB), funding arrangement (fully-insured vs ASO), ERISA status, domicile state, effective and termination dates, group financial control (GFC) identifiers, and complete lifecycle status transitions (prospect, active, suspended, terminated, reinstated) with status history. Single source of truth for employer group identity, size classification, headcount history, and status history.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`group_location` (
    `group_location_id` BIGINT COMMENT 'Unique surrogate key for each group location record.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Group locations belong to an employer group; linking enables address normalization and removes duplicate address fields from employer_group.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Links employer on‑site clinic locations to provider facilities, enabling employee access reporting and utilization analytics.',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Group enrollment validation requires confirming that a groups physical location falls within a plans service area. Compliance and eligibility teams run this check during onboarding and renewal. No e',
    `address_line1` STRING COMMENT 'First line of the street address.',
    `address_line2` STRING COMMENT 'Second line of the street address, if applicable.',
    `address_type` STRING COMMENT 'Classifies the purpose of the address (headquarters, billing, satellite, mailing).. Valid values are `headquarters|billing|satellite|mailing`',
    `city` STRING COMMENT 'City of the location.',
    `country_code` STRING COMMENT 'Three-letter ISO country code (e.g., USA).',
    `county_fips` STRING COMMENT 'Federal Information Processing Standard code for the county.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the location ceases to be effective; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the location becomes effective for billing and regulatory purposes.',
    `geocode_accuracy` STRING COMMENT 'Indicates the precision of the latitude/longitude coordinates.. Valid values are `high|medium|low`',
    `group_location_status` STRING COMMENT 'Current lifecycle status of the location record.. Valid values are `active|inactive|pending|closed`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary address for the employer group.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the location in decimal degrees.',
    `location_code` STRING COMMENT 'Business identifier code for the location used in billing and regulatory filings.',
    `location_name` STRING COMMENT 'Descriptive name for the location (e.g., Headquarters, West Coast Office).',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the location in decimal degrees.',
    `notes` STRING COMMENT 'Free-text field for additional remarks about the location.',
    `rating_area` STRING COMMENT 'Geographic rating area used for premium calculations.',
    `source_system` STRING COMMENT 'Name of the source operational system (e.g., Facets, QNXT) that supplied the record.',
    `state` STRING COMMENT 'Two-letter state abbreviation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `zip_code` STRING COMMENT 'Five-digit postal code.',
    `zip_plus4` STRING COMMENT 'Extended ZIP+4 postal code.',
    CONSTRAINT pk_group_location PRIMARY KEY(`group_location_id`)
) COMMENT 'Physical and mailing addresses associated with an employer group, including headquarters, billing address, and satellite office locations. Tracks address type, street, city, state, ZIP+4, county FIPS code, and effective date range. Supports geographic rating, state regulatory filings, and premium billing address routing.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`group_contact` (
    `group_contact_id` BIGINT COMMENT 'System-generated unique identifier for the group contact record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this contact belongs.',
    `address_line1` STRING COMMENT 'First line of the contacts mailing address.',
    `address_line2` STRING COMMENT 'Second line of the contacts mailing address, if applicable.',
    `authorization_level` STRING COMMENT 'Level of authority the contact has for enrollment and billing actions.. Valid values are `full|limited|view_only`',
    `can_bill` BOOLEAN COMMENT 'Indicates whether the contact is authorized to initiate billing or premium payment actions.',
    `can_enroll` BOOLEAN COMMENT 'Indicates whether the contact is authorized to submit enrollment transactions.',
    `city` STRING COMMENT 'City component of the contacts mailing address.',
    `contact_type` STRING COMMENT 'Classification of the contacts functional role for the employer group.. Valid values are `hr_admin|benefits_coordinator|payroll|executive_sponsor|other`',
    `country` STRING COMMENT 'Three‑letter ISO country code for the contacts address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the system.',
    `department` STRING COMMENT 'Department or business unit where the contact works.',
    `effective_end_date` DATE COMMENT 'Date when the contacts authorization expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the contacts authorization becomes effective.',
    `email` STRING COMMENT 'Primary email address used for electronic communications with the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the contact.',
    `full_name` STRING COMMENT 'Legal full name of the contact person.',
    `group_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|terminated|pending`',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the group.',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the contact.',
    `phone_number` STRING COMMENT 'Primary telephone number for the contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contacts mailing address.',
    `preferred_communication_channel` STRING COMMENT 'Contacts preferred method for receiving communications.. Valid values are `email|phone|mail|portal`',
    `source_system` STRING COMMENT 'Name of the operational system that supplied the contact data (e.g., Facets, QNXT).',
    `source_system_contact_reference` STRING COMMENT 'Identifier for the contact as defined in the source system.',
    `state` STRING COMMENT 'State or province component of the contacts mailing address.',
    `title` STRING COMMENT 'Professional title or position of the contact within the employer organization.',
    CONSTRAINT pk_group_contact PRIMARY KEY(`group_contact_id`)
) COMMENT 'Authorized contacts associated with an employer group, including HR administrators, benefits coordinators, payroll contacts, and executive sponsors. Captures contact role type, name, title, phone, email, preferred communication channel, and authorization level for enrollment and billing transactions.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`group_division` (
    `group_division_id` BIGINT COMMENT 'Unique surrogate key for the group division record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Different employer divisions (e.g., executive, hourly, salaried) are commonly assigned distinct benefit packages with different cost-sharing structures. Benefits administration systems track division-',
    `group_location_id` BIGINT COMMENT 'Foreign key linking to employer.group_location. Business justification: An organizational division (subsidiary, cost center, department) is physically located at a specific employer location. group_location already links to group via group_id, and group_division links to ',
    `group_id` BIGINT COMMENT 'Identifier of the parent employer group to which this division belongs.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the Preferred Provider Organization (PPO) plan associated with this division, if applicable.',
    `billing_entity_flag` BOOLEAN COMMENT 'Indicates whether the division is billed as a separate entity from the parent group.',
    `classification` STRING COMMENT 'Funding arrangement classification for the division.. Valid values are `ASO|Fully_Insured|Self_Funded|TPA|Broker_Managed`',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount contributed by employee per pay period for this division (if applicable).',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of premium contributed by employee for this division (if applicable).',
    `contribution_strategy` STRING COMMENT 'Method used to calculate employee contributions for this division.. Valid values are `fixed|percentage|tiered|none`',
    `covered_member_count` STRING COMMENT 'Number of members (including dependents) covered under this divisions benefits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the division record was first created in the system.',
    `division_code` STRING COMMENT 'Unique code assigned to the division for internal reference and billing.',
    `division_name` STRING COMMENT 'Human readable name of the division or subsidiary within the employer group.',
    `division_type` STRING COMMENT 'Category of the division indicating its organizational role.. Valid values are `department|subsidiary|cost_center|location|joint_venture`',
    `effective_end_date` DATE COMMENT 'Date when the divisions benefit configuration ends or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the divisions benefit configuration becomes effective.',
    `eligibility_rule_set` STRING COMMENT 'Reference to the eligibility rule set applied to members in this division.',
    `employee_count` STRING COMMENT 'Number of employees assigned to this division.',
    `flex_spending_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for the divisions Flexible Spending Account.',
    `fsa_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for the divisions Flexible Spending Account.',
    `group_division_status` STRING COMMENT 'Current lifecycle status of the division.. Valid values are `active|inactive|pending|closed|suspended`',
    `hsa_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for the divisions Health Savings Account.',
    `is_eligible_for_flex_spending` BOOLEAN COMMENT 'Indicates if the division participates in a Flexible Spending Account (FSA) program.',
    `is_eligible_for_fsa` BOOLEAN COMMENT 'Indicates if the division offers a Flexible Spending Account (FSA) to its members.',
    `is_eligible_for_hsa` BOOLEAN COMMENT 'Indicates if the division offers a Health Savings Account (HSA) to its members.',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Indicates if the division qualifies for employer-sponsored subsidy programs.',
    `is_eligible_for_waiver` BOOLEAN COMMENT 'Indicates if the division is eligible for premium waivers under certain conditions.',
    `renewal_date` DATE COMMENT 'Date when the divisions contract is up for renewal.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Fixed dollar subsidy amount applied to employee premiums for this division.',
    `subsidy_percent` DECIMAL(18,2) COMMENT 'Percentage subsidy applied to employee premiums for this division.',
    `termination_date` DATE COMMENT 'Date when the divisions agreement was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the division record.',
    CONSTRAINT pk_group_division PRIMARY KEY(`group_division_id`)
) COMMENT 'Organizational sub-units within an employer group — divisions, subsidiaries, cost centers, or departments — that have distinct benefit configurations, billing aggregation, or eligibility rules. Tracks division name, division code, parent group reference, effective dates, and whether the division is a separate billing entity. Supports multi-site and multi-subsidiary group structures in Facets.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` (
    `group_plan_offering_id` BIGINT COMMENT 'System‑generated unique identifier for the group plan offering record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: A group plan offering presents a specific benefit package to employees, not just a health plan. Benefits enrollment systems must resolve which benefit package (metal tier, cost-share structure) is act',
    `group_id` BIGINT COMMENT 'Identifier of the employer group that sponsors this offering.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the underlying health plan catalog record.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Employer plan offerings are tied to a specific provider network for network adequacy reporting, open enrollment materials, and member steerage. Underwriters and account managers need direct access to ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.network_tier. Business justification: Supports Plan Tier Assignment process: defines which network tier (e.g., Tier 1, Tier 2) an employers plan offering uses for cost‑share calculations.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: group_plan_offering.plan_year is a denormalized plain-text field. Normalizing to plan.year.year_id enables accurate plan-year-based contribution reporting, ACA affordability calculations, and renewal ',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per employee when contribution_type = flat.',
    `contribution_effective_end_date` DATE COMMENT 'Date when the defined contribution strategy expires; null if ongoing.',
    `contribution_effective_start_date` DATE COMMENT 'Date when the defined contribution strategy becomes effective.',
    `contribution_percent` DECIMAL(18,2) COMMENT 'Percentage of the premium the employer pays when contribution_type = percentage.',
    `contribution_strategy_description` STRING COMMENT 'Detailed explanation of how employer contributions are calculated.',
    `contribution_tier` STRING COMMENT 'Textual description of tiered contribution rules (e.g., "Tier 1: 70%", "Tier 2: 80%").',
    `contribution_type` STRING COMMENT 'Method the employer uses to calculate its contribution.. Valid values are `flat|percentage|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the offering record was first created in the system.',
    `effective_from` DATE COMMENT 'Date the offering becomes binding for the employer group.',
    `effective_until` DATE COMMENT 'Date the offering ends; null for open‑ended contracts.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for employee‑only coverage.',
    `family_contribution_amount` DECIMAL(18,2) COMMENT 'Employer contribution amount for family coverage.',
    `group_plan_offering_status` STRING COMMENT 'Current lifecycle state of the offering.. Valid values are `active|pending|terminated|draft|suspended`',
    `hra_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to employee HRA accounts.',
    `hsa_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to employee HSA accounts.',
    `is_affordable` BOOLEAN COMMENT 'True if the offering meets ACA affordability testing for the employer group.',
    `measurement_period_end` DATE COMMENT 'End of the period used to evaluate participation compliance.',
    `measurement_period_start` DATE COMMENT 'Start of the period used to evaluate participation compliance.',
    `minimum_enrolled_headcount` STRING COMMENT 'Absolute minimum number of participants required for the offering.',
    `minimum_participation_percent` DECIMAL(18,2) COMMENT 'Required percentage of eligible employees that must enroll for the offering to remain active.',
    `offering_code` STRING COMMENT 'External code used by the employer and carriers to reference this specific plan offering.',
    `offering_description` STRING COMMENT 'Narrative description of the plan offering, including benefits highlights.',
    `offering_name` STRING COMMENT 'Human‑readable name of the plan offering as displayed to employees.',
    `offering_type` STRING COMMENT 'Category of the health plan offering (e.g., QHP, HMO, PPO, EPO, HDHP, Dental, Vision). [ENUM-REF-CANDIDATE: qhp|hmo|ppo|epo|hdhp|dental|vision — promote to reference product]',
    `open_enrollment_end_date` DATE COMMENT 'Last day employees can enroll in the offering.',
    `open_enrollment_start_date` DATE COMMENT 'First day employees can enroll in the offering.',
    `participation_status` STRING COMMENT 'Current compliance result for the offerings participation thresholds.. Valid values are `compliant|non_compliant|pending_review`',
    `plan_catalog_version` STRING COMMENT 'Version identifier of the plan catalog used for this offering.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the offering record.',
    `waiver_criteria_description` STRING COMMENT 'Narrative description of the conditions under which a waiver may be granted.',
    `waiver_eligible` BOOLEAN COMMENT 'Indicates whether the employer allows waiver of spousal or other coverage.',
    CONSTRAINT pk_group_plan_offering PRIMARY KEY(`group_plan_offering_id`)
) COMMENT 'The set of health plan products offered by an employer group to its eligible employees during a plan year — the single source of truth for what plans are available, how the employer contributes, and what participation rules apply. Captures which QHP, HMO, PPO, EPO, HDHP, dental, and vision plans are available; employer contribution strategy per plan including contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and contribution effective date ranges; minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and participation compliance status; and the open enrollment window linkage. Consolidates contribution strategies and participation requirements as attributes of the plan offering. Links employer groups to the plan catalog and drives the enrollment eligibility matrix, premium billing split calculations, and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` (
    `contribution_strategy_id` BIGINT COMMENT 'System-generated unique identifier for the contribution strategy record.',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Contribution strategies can be defined at the division level — different subsidiaries or cost centers within a group may have different employer contribution rules. contribution_strategy already has g',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group to which this contribution strategy applies.',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: A contribution strategy is defined for a specific plan offering — the employer contribution rules (amount, percentage, type) apply to a particular health plan product offered during a specific plan ye',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Contribution strategies are established or revised during the renewal cycle. Linking contribution_strategy to the group_renewal that created or last modified it provides renewal-year traceability for ',
    `health_plan_id` BIGINT COMMENT 'Unique identifier of the health plan that the contribution rules are associated with.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Employer contribution strategies are explicitly tier-differentiated — employers set different contribution amounts for Tier 1 vs Tier 2 network usage to incentivize member steerage. The denormalized t',
    `affordability_test_flag` BOOLEAN COMMENT 'Indicates whether the contribution satisfies the ACA affordability requirement.',
    `contribution_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employer contributes per employee when contribution_type is flat.',
    `contribution_code` STRING COMMENT 'External business code used to reference the contribution strategy in contracts and communications.',
    `contribution_frequency` STRING COMMENT 'How often the employer contribution is applied to premium billing.. Valid values are `monthly|quarterly|annually`',
    `contribution_percentage` DECIMAL(18,2) COMMENT 'Percentage of the premium the employer pays when contribution_type is percentage.',
    `contribution_rule_name` STRING COMMENT 'Descriptive name of the contribution rule for reporting and UI display.',
    `contribution_strategy_status` STRING COMMENT 'Current lifecycle state of the contribution strategy.. Valid values are `active|inactive|pending|retired`',
    `contribution_type` STRING COMMENT 'Method used to calculate the employer contribution: flat dollar amount, percentage of premium, or tiered based on coverage tier.. Valid values are `flat|percentage|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contribution strategy record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the contribution strategy expires or is superseded; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the contribution strategy becomes active.',
    `eligibility_criteria` STRING COMMENT 'Free‑text description of employee eligibility rules (e.g., full‑time status, tenure) for this contribution.',
    `employer_contribution_cap` DECIMAL(18,2) COMMENT 'Maximum total amount the employer will contribute per employee per billing period.',
    `hra_employer_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to a Health Reimbursement Arrangement for eligible employees.',
    `hsa_employer_seed_amount` DECIMAL(18,2) COMMENT 'Employer‑funded seed contribution to a Health Savings Account for eligible employees.',
    `is_post_tax` BOOLEAN COMMENT 'True if the employer contribution is made on a post‑tax basis.',
    `is_pre_tax` BOOLEAN COMMENT 'True if the employer contribution is made on a pre‑tax basis.',
    `last_review_date` DATE COMMENT 'Date when the contribution strategy was last reviewed for compliance or policy updates.',
    `maximum_employee_contribution` DECIMAL(18,2) COMMENT 'Highest amount an employee may be required to pay after employer contribution is applied.',
    `minimum_employee_contribution` DECIMAL(18,2) COMMENT 'Lowest amount an employee must pay after employer contribution is applied.',
    `notes` STRING COMMENT 'Additional comments or special instructions related to the contribution strategy.',
    `review_status` STRING COMMENT 'Result of the most recent compliance review.. Valid values are `compliant|non_compliant|under_review`',
    `tax_credit_eligible` BOOLEAN COMMENT 'Indicates whether the contribution qualifies for a tax credit under applicable regulations.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the contribution strategy record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_contribution_strategy PRIMARY KEY(`contribution_strategy_id`)
) COMMENT 'Employer contribution rules defining how much the employer pays toward employee and dependent premiums for each offered plan. Captures contribution type (flat dollar, percentage of premium, tiered by coverage tier), employee-only vs family contribution amounts, HSA/HRA employer seed amounts, and effective date ranges. Supports premium billing split calculations and ACA affordability compliance testing.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`group_renewal` (
    `group_renewal_id` BIGINT COMMENT 'System-generated unique identifier for the group renewal record.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker representing the group.',
    `employer_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: A group renewal lifecycle record is supported by an underwriting evaluation. The underwriting case determines risk factors, rating methodology, and premium estimates that feed directly into the renewa',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group associated with this renewal.',
    `rate_quote_id` BIGINT COMMENT 'Foreign key linking to employer.rate_quote. Business justification: A group renewal is finalized against a specific accepted rate quote. group_renewal already stores premium_rate_renewal_year and rate_change_percentage as computed summary values, but lacks a direct FK',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Group renewals are executed within a specific plan year governing premium rates, compliance deadlines, and open enrollment rules. Renewal processing and CMS regulatory filings require tying each renew',
    `amendment_count` STRING COMMENT 'Total number of amendments applied to this renewal record.',
    `amendment_flag` BOOLEAN COMMENT 'True if any amendment has been applied to the renewal.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the renewal record was first created in the data warehouse.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the renewal record.',
    `benefit_plan_ids` STRING COMMENT 'Comma‑separated list of benefit plan identifiers attached to the renewal.',
    `compliance_check_date` DATE COMMENT 'Date on which the regulatory compliance check was performed.',
    `compliance_status` STRING COMMENT 'Result of the compliance validation for the renewal.. Valid values are `compliant|non_compliant|pending`',
    `contribution_strategy` STRING COMMENT 'How employer contributions are calculated for the renewal period.. Valid values are `fixed|percentage|tiered`',
    `erisa_status` STRING COMMENT 'Indicates whether the Employee Retirement Income Security Act applies to the group.. Valid values are `applicable|not_applicable`',
    `funding_arrangement` STRING COMMENT 'Method by which the group finances coverage.. Valid values are `fully_insured|aso|self_funded|tpa`',
    `group_size` STRING COMMENT 'Total number of covered individuals in the group for the renewal year.',
    `latest_amendment_after_value` DECIMAL(18,2) COMMENT 'Value of the changed attribute after the amendment (stored as text).',
    `latest_amendment_approval_status` STRING COMMENT 'Approval status of the most recent amendment.. Valid values are `approved|rejected|pending`',
    `latest_amendment_before_value` DECIMAL(18,2) COMMENT 'Value of the changed attribute before the amendment (stored as text).',
    `latest_amendment_effective_date` DATE COMMENT 'Effective date of the most recent amendment.',
    `latest_amendment_reason_code` STRING COMMENT 'Standardized reason code for the most recent amendment.',
    `latest_amendment_type` STRING COMMENT 'Type of the most recent amendment applied to the renewal.. Valid values are `benefit_change|plan_add_drop|contribution_change|address_update|contact_change`',
    `participation_requirement_met` BOOLEAN COMMENT 'Indicates whether the group met the minimum participation threshold for the renewal.',
    `participation_requirement_outcome` STRING COMMENT 'Result of the participation requirement evaluation.. Valid values are `met|not_met|partial`',
    `premium_rate_prior_year` DECIMAL(18,2) COMMENT 'Base premium rate applied in the prior renewal year.',
    `premium_rate_renewal_year` DECIMAL(18,2) COMMENT 'Base premium rate applied for the renewal year.',
    `prior_renewal_effective_date` DATE COMMENT 'Effective date of the immediately preceding renewal.',
    `rate_change_percentage` DECIMAL(18,2) COMMENT 'Percent change between prior year and renewal year premium rates.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the renewal passed all required regulatory validations.',
    `renewal_cycle_year` STRING COMMENT 'Calendar year in which the renewal takes effect.',
    `renewal_effective_date` DATE COMMENT 'First day of coverage under the renewed contract.',
    `renewal_end_date` DATE COMMENT 'Last day of coverage for the renewal term.',
    `renewal_notes` STRING COMMENT 'Free‑form notes entered by users during the renewal process.',
    `renewal_status` STRING COMMENT 'Current workflow status of the renewal.. Valid values are `pending|proposed|accepted|declined|expired`',
    `renewal_status_date` DATE COMMENT 'Date when the current renewal status was set.',
    `retention_outcome` STRING COMMENT 'Result of the renewal in terms of group retention.. Valid values are `retained|lost|pending`',
    `retention_reason_code` STRING COMMENT 'Code describing why a group was retained or lost.',
    `sic_code` STRING COMMENT 'Four‑digit industry classification code for the employer.',
    CONSTRAINT pk_group_renewal PRIMARY KEY(`group_renewal_id`)
) COMMENT 'Annual renewal lifecycle record and single source of truth for all group configuration changes — both at renewal and between renewal cycles. Captures renewal effective date, prior year vs renewal year premium rates, rate change percentage, benefit modifications, participation requirement outcomes, renewal status (pending, proposed, accepted, declined), and retention outcome. Also captures mid-year and off-cycle amendments including amendment type (benefit change, plan add/drop, contribution change, address update, contact change), amendment effective date, reason code, approval status, and before/after values of changed attributes. Consolidates group amendments as lifecycle events within the renewal record — amendments are tracked against the current plan years renewal. Provides complete audit trail for group retention management, regulatory compliance, and configuration change history.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`participation_requirement` (
    `participation_requirement_id` BIGINT COMMENT 'Unique identifier for the participation requirement record.',
    `group_id` BIGINT COMMENT 'Identifier of the employer group to which this participation requirement applies.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Participation requirements are evaluated as part of the renewal process. group_renewal already stores participation_requirement_met and participation_requirement_outcome as summary fields, but partici',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Participation requirements are evaluated against a specific plan years enrollment thresholds and measurement periods. Compliance audits and regulatory reporting require tying participation assessment',
    `compliance_review_due_date` DATE COMMENT 'Date by which the next compliance review of the participation requirement must be completed.',
    `compliance_status` STRING COMMENT 'Current compliance outcome of the participation requirement.. Valid values are `compliant|non_compliant|under_review`',
    `contribution_strategy` STRING COMMENT 'How premium contributions are allocated for the group (employer, employee, or shared).. Valid values are `employer_paid|employee_paid|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the participation requirement record was first created.',
    `effective_from` DATE COMMENT 'Date when the participation requirement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the participation requirement expires or is superseded (null if open‑ended).',
    `enrolled_headcount` STRING COMMENT 'Current number of members enrolled under the group.',
    `erisa_status` STRING COMMENT 'Indicates whether the employer group is subject to ERISA regulations.. Valid values are `applicable|not_applicable`',
    `funding_arrangement` STRING COMMENT 'Funding model for the group (Administrative Services Only, Fully Insured, or Self‑Funded).. Valid values are `ASO|fully_insured|self_funded`',
    `group_size` STRING COMMENT 'Total number of eligible members in the employer group.',
    `last_evaluated_date` DATE COMMENT 'Date when the participation requirement was last evaluated for compliance.',
    `measurement_period` STRING COMMENT 'Frequency at which participation is measured for compliance.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `minimum_enrolled_headcount` STRING COMMENT 'Minimum number of enrolled individuals required for the group to remain eligible.',
    `notes` STRING COMMENT 'Additional notes or comments entered by administrators.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of eligible members that must enroll to satisfy the requirement.',
    `participation_requirement_description` STRING COMMENT 'Free‑form description providing context and details about the participation requirement.',
    `participation_requirement_status` STRING COMMENT 'Current lifecycle status of the participation requirement.. Valid values are `active|inactive|pending|suspended|terminated`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this participation requirement must be reported to regulatory bodies (e.g., CMS, NAIC).',
    `renewal_date` DATE COMMENT 'Scheduled date for the next renewal evaluation of the participation requirement.',
    `requirement_code` STRING COMMENT 'Business identifier code for the participation requirement.',
    `requirement_name` STRING COMMENT 'Human‑readable name of the participation requirement.',
    `requirement_type` STRING COMMENT 'Classification of the requirement (e.g., minimum participation, waiver eligibility, headcount threshold).. Valid values are `minimum_participation|waiver_eligibility|headcount_threshold`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the participation requirement record.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether the group permits waivers (e.g., spousal coverage waivers).',
    `waiver_percentage_allowed` DECIMAL(18,2) COMMENT 'Maximum percentage of eligible members that may be waived while maintaining compliance.',
    CONSTRAINT pk_participation_requirement PRIMARY KEY(`participation_requirement_id`)
) COMMENT 'Minimum participation rules that an employer group must satisfy to maintain group coverage eligibility. Captures minimum participation percentage, minimum enrolled headcount, waiver eligibility criteria (e.g., spousal coverage waivers), measurement period, and compliance status. Used during underwriting, renewal, and open enrollment to validate group eligibility for continued coverage.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`broker_assignment` (
    `broker_assignment_id` BIGINT COMMENT 'Unique surrogate key for the broker assignment record.',
    `broker_id` BIGINT COMMENT 'FK to employer.broker',
    `group_id` BIGINT COMMENT 'Unique identifier for the employer group (client) in the core administration system.',
    `agency_name` STRING COMMENT 'Legal name of the brokers agency or firm.',
    `broker_assignment_status` STRING COMMENT 'Current lifecycle status of the broker assignment.. Valid values are `active|inactive|pending|terminated`',
    `commission_basis` STRING COMMENT 'Business metric on which the commission is calculated.. Valid values are `premium|claim|revenue|service_fee`',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate applicable to the broker for this employer group, expressed as a percentage.',
    `commission_type` STRING COMMENT 'Method used to calculate broker commission.. Valid values are `percentage|flat|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the broker assignment terminates or expires. Null if ongoing.',
    `effective_start_date` DATE COMMENT 'Date when the broker assignment becomes effective.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this broker is the primary broker for the employer group.',
    `notes` STRING COMMENT 'Free-text field for additional comments or remarks about the broker assignment.',
    `source_system` STRING COMMENT 'Name of the source operational system where the broker assignment originated (e.g., Facets, QNXT).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the broker assignment record.',
    CONSTRAINT pk_broker_assignment PRIMARY KEY(`broker_assignment_id`)
) COMMENT 'Association between an employer group and its licensed broker(s) or general agent(s), capturing the broker NPN, agency name, commission arrangement type, commission rate, effective and termination dates, and primary vs secondary broker designation. Supports broker compensation processing, group servicing accountability, and regulatory disclosure requirements.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` (
    `tpa_arrangement_id` BIGINT COMMENT 'System-generated unique identifier for the TPA arrangement record.',
    `broker_id` BIGINT COMMENT 'FK to employer.broker',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: TPA arrangement is specific to an employer group; linking provides association.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract_provider_contract. Business justification: TPA arrangements in self-funded health insurance are formalized through provider contracts. Operations teams must link TPA administrative agreements to the underlying contract_provider_contract for cl',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Self-funded employer TPA arrangements administer claims against a specific provider networks contracted rates. Claims adjudication, network access reporting, and stop-loss calculations all require kn',
    `reinsurance_arrangement_id` BIGINT COMMENT 'Foreign key linking to risk.reinsurance_arrangement. Business justification: Self-insured employer TPA arrangements always include a stop-loss/reinsurance component. The stop_loss_* columns on tpa_arrangement are denormalized from reinsurance_arrangement. Linking directly enab',
    `arrangement_name` STRING COMMENT 'Human‑readable name for the TPA arrangement.',
    `arrangement_number` STRING COMMENT 'External contract number or code assigned to the TPA arrangement.',
    `arrangement_type` STRING COMMENT 'Category of the arrangement indicating funding model.. Valid values are `ASO|Self-Funded|Fully-Insured`',
    `contribution_rate_pmpm` DECIMAL(18,2) COMMENT 'Per member per month contribution amount defined by the employer.',
    `contribution_strategy` STRING COMMENT 'Method used to calculate employer contributions to the self‑funded arrangement.. Valid values are `fixed|percentage|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the arrangement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date the arrangement terminates or expires; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date the arrangement becomes binding.',
    `erisa_status` STRING COMMENT 'Indicates whether the arrangement is subject to ERISA regulations.. Valid values are `covered|exempt`',
    `fee_schedule_cap_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount payable for the fee schedule within a billing period.',
    `fee_schedule_rate_pmpm` DECIMAL(18,2) COMMENT 'Per member per month rate charged for the specified service type.',
    `fee_schedule_type` STRING COMMENT 'Service category for which the fee schedule applies.. Valid values are `claims_processing|network_access|care_management|pbm|utilization_review`',
    `gfc_control_flag` BOOLEAN COMMENT 'True if the arrangement is subject to Group Financial Control oversight.',
    `group_size_max` STRING COMMENT 'Maximum number of covered lives allowed under the arrangement.',
    `group_size_min` STRING COMMENT 'Minimum number of covered lives required for the arrangement.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `renewal_date` DATE COMMENT 'Date when the arrangement is scheduled for renewal.',
    `source_system` STRING COMMENT 'Originating operational system (e.g., Facets, QNXT) that supplied the record.',
    `stop_loss_coverage_scope` STRING COMMENT 'Benefit categories covered by the stop‑loss policy.. Valid values are `medical|dental|vision|rx|all`',
    `stop_loss_effective_date` DATE COMMENT 'Date the stop‑loss coverage becomes active.',
    `stop_loss_expiration_date` DATE COMMENT 'Date the stop‑loss coverage ends.',
    `tpa_arrangement_status` STRING COMMENT 'Current operational status of the TPA arrangement.. Valid values are `active|inactive|suspended|terminated|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the arrangement record.',
    CONSTRAINT pk_tpa_arrangement PRIMARY KEY(`tpa_arrangement_id`)
) COMMENT 'Third Party Administrator (TPA) and Administrative Services Only (ASO) arrangement record for self-funded employer groups — the single source of truth for all ASO/self-funded configuration. Captures TPA entity name, TPA NPI/tax ID, ASO contract reference; administrative fee schedule components by service type (claims processing, network access, care management, PBM, utilization review) with PMPM rates, effective dates, and contractual fee caps; stop-loss (excess loss) insurance configuration including stop-loss carrier name, policy number, specific deductible (individual attachment point), aggregate deductible, aggregate corridor, lasering provisions with member-level laser amounts, stop-loss premium, covered benefits scope, and stop-loss policy effective/expiration dates; and overall arrangement effective dates. Consolidates ASO fee schedules and stop-loss policies as sub-configurations of the TPA arrangement, aligned with Facets/QNXT ASO module patterns. Drives ASO revenue recognition in the finance domain and self-funded group financial risk management.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` (
    `open_enrollment_window_id` BIGINT COMMENT 'Primary key for open_enrollment_window',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group that sponsors the enrollment window.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: An open enrollment window is triggered by and associated with a specific renewal cycle. The renewal record defines the plan year, effective dates, and benefit changes that the open enrollment window c',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Open enrollment windows are defined per plan year; the plan year record governs enrollment start/end dates, grace periods, and special enrollment rules. HR systems and compliance reports require linki',
    `change_deadline` DATE COMMENT 'Last date an employee may modify an already‑submitted election within the window.',
    `coverage_type` STRING COMMENT 'Category of benefits offered in this enrollment window.. Valid values are `medical|dental|vision|wellness|all`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment window record was first created in the system.',
    `eligible_employee_count` STRING COMMENT 'Number of employees who meet eligibility criteria for this enrollment window.',
    `end_date` DATE COMMENT 'Date the enrollment window closes; no further changes are accepted after this date.',
    `enrollment_method` STRING COMMENT 'Channel through which employees may submit their elections (online portal, paper forms, or EDI 834).. Valid values are `online|paper|edi`',
    `enrollment_window_status` STRING COMMENT 'Current lifecycle status of the enrollment window.. Valid values are `open|closed|pending|cancelled`',
    `enrollment_window_type` STRING COMMENT 'Classification of the window (annual open enrollment, new‑hire election, COBRA election, or special election).. Valid values are `annual|new_hire|cobra|special`',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special instructions related to the window.',
    `participation_rate` DECIMAL(18,2) COMMENT 'Percentage (to two decimal places) of eligible employees who completed an election.',
    `plan_selection_method` STRING COMMENT 'Whether employees may select a single plan or multiple plans during the window.. Valid values are `single|multiple`',
    `source_system` STRING COMMENT 'Name of the source system that originated the enrollment window record (e.g., Facets, QNXT).',
    `start_date` DATE COMMENT 'Date the enrollment window becomes effective for employee elections.',
    `submission_deadline` DATE COMMENT 'Final date by which an employee must submit an election to be processed.',
    `total_employee_count` STRING COMMENT 'Total number of employees in the employer group at the start of the window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment window record.',
    `waiver_allowed` BOOLEAN COMMENT 'Indicates whether employees may waive coverage during this window.',
    `waiver_deadline` DATE COMMENT 'Date by which a waiver must be submitted if waivers are permitted.',
    `window_code` STRING COMMENT 'Business identifier code assigned to the enrollment window (e.g., OE2024Q1).',
    CONSTRAINT pk_open_enrollment_window PRIMARY KEY(`open_enrollment_window_id`)
) COMMENT 'Scheduled open enrollment windows defined by an employer group during which employees may elect, change, or waive coverage. Captures enrollment period type (annual open enrollment, new hire window, COBRA election), start and end dates, eligible plan offerings, enrollment method (online portal, paper, EDI 834), and enrollment completion status. Drives eligibility event processing in the enrollment domain.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` (
    `employer_underwriting_case_id` BIGINT COMMENT 'System-generated unique identifier for the underwriting case.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker facilitating the employer’s enrollment.',
    `group_id` BIGINT COMMENT 'Unique identifier of the employer group that is the subject of the underwriting case.',
    `aca_adjustment_factor` DECIMAL(18,2) COMMENT 'Adjustment applied to ensure compliance with Affordable Care Act rating rules.',
    `actuarial_basis_document` STRING COMMENT 'Reference identifier for the actuarial documentation supporting the rating.',
    `age_gender_composite_factor` DECIMAL(18,2) COMMENT 'Composite factor derived from the group’s age and gender distribution.',
    `case_number` STRING COMMENT 'Business identifier assigned to the underwriting case, used for tracking and communication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the underwriting case record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the premium estimate.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `effective_end_date` DATE COMMENT 'Last day the proposed premium rates are valid; after this date a new quote is required.',
    `effective_start_date` DATE COMMENT 'First day the proposed premium rates become effective if the quote is accepted.',
    `experience_rating_factor` DECIMAL(18,2) COMMENT 'Factor based on the employer’s prior loss experience and credibility weighting.',
    `geographic_factor` DECIMAL(18,2) COMMENT 'Factor reflecting cost differentials across geographic rating areas.',
    `group_average_age` DECIMAL(18,2) COMMENT 'Average age of covered members in the group.',
    `group_census_size` STRING COMMENT 'Number of covered lives in the employer group at the time of underwriting.',
    `group_female_percentage` DECIMAL(18,2) COMMENT 'Percentage of female members in the group census.',
    `industry_risk_factor` STRING COMMENT 'Code representing the industry classification risk factor applied to the group.',
    `manual_rate_basis` BOOLEAN COMMENT 'Indicates whether the rate was manually set rather than algorithmically derived.',
    `pmpm_estimate` DECIMAL(18,2) COMMENT 'Estimated premium cost per covered member per month.',
    `prior_carrier_loss_experience` STRING COMMENT 'Narrative summary of loss experience with the previous carrier.',
    `quote_expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the quote expires if not accepted.',
    `quote_generated_timestamp` TIMESTAMP COMMENT 'Date and time when the premium quote was generated.',
    `quote_status` STRING COMMENT 'Current status of the premium quote within the underwriting workflow.. Valid values are `draft|presented|accepted|expired|retracted`',
    `rating_area_code` STRING COMMENT 'Geographic rating area identifier used for regional premium adjustments.',
    `rating_methodology` STRING COMMENT 'Method used to calculate rates: community rated, experience rated, or blended.. Valid values are `community|experience|blended`',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the employer group based on underwriting analysis.. Valid values are `low|medium|high|very_high`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the underwriting case was initially submitted.',
    `total_premium_estimate` DECIMAL(18,2) COMMENT 'Aggregate estimated premium for the entire employer group for the quoted period.',
    `underwriting_decision` STRING COMMENT 'Final decision outcome for the case after review.. Valid values are `approved|declined|modified|pending`',
    `underwriting_status` STRING COMMENT 'Current lifecycle status of the underwriting case.. Valid values are `draft|presented|accepted|expired|declined|modified`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the underwriting case record.',
    CONSTRAINT pk_employer_underwriting_case PRIMARY KEY(`employer_underwriting_case_id`)
) COMMENT 'Underwriting evaluation record and single source of truth for the complete risk assessment process from submission through rating through quote generation through decision for a new or renewing employer group. Tracks case submission date, group census data, prior carrier loss experience, medical underwriting status, risk tier assignment, manual rate basis; rating factors including age/gender composite factors, geographic area rating factors, industry risk factors, experience rating credibility weights, ACA-compliant rating adjustments, and actuarial basis documentation; underwriting decision (approved, declined, modified); and premium rate quotes with proposed rates by plan, coverage tier, and rating area, quote effective and expiration dates, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Consolidates rating factors and rate quotes as stages within the underwriting case lifecycle. Links to the risk domain for RAF and HCC-based risk scoring at the group level. Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`rate_quote` (
    `rate_quote_id` BIGINT COMMENT 'System‑generated unique identifier for the premium rate quote.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or sales agent handling the quote.',
    `employer_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to employer.employer_underwriting_case. Business justification: A rate quote is the commercial output of an underwriting evaluation. One employer_underwriting_case can produce multiple rate quotes (e.g., different plan configurations, quote versions, or revised qu',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Actuarial rate quoting for employer groups uses contracted fee schedules as the pricing basis for pmpm_rate and total_premium_estimate calculations. Underwriters and actuaries must trace which fee sch',
    `group_id` BIGINT COMMENT 'Identifier of the employer group for which the quote is generated.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which the quote applies.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Rate quotes are generated for a specific provider network configuration — network type (HMO/PPO/EPO), tier structure, and geographic footprint directly drive premium calculations. Actuaries require di',
    `contribution_strategy` STRING COMMENT 'Employer contribution approach (e.g., fixed amount, percentage of premium).',
    `coverage_tier` STRING COMMENT 'Tier of coverage being quoted (e.g., employee only, family).. Valid values are `employee|family|individual|spouse`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the quote (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discounts applied to the gross premium.',
    `effective_date` DATE COMMENT 'First date on which the quoted rates become effective if the quote is accepted.',
    `erisa_status` STRING COMMENT 'Indicates whether the employer group is subject to ERISA regulations.. Valid values are `ERISA|NonERISA`',
    `expiration_date` DATE COMMENT 'Date after which the quote is no longer valid.',
    `gross_premium_amount` DECIMAL(18,2) COMMENT 'Total premium before any discounts or adjustments, expressed in the quote currency.',
    `group_sic_code` STRING COMMENT 'Standard Industrial Classification code describing the employers industry.',
    `group_size` STRING COMMENT 'Total number of employees eligible for coverage under the employer group.',
    `group_type` STRING COMMENT 'Funding arrangement for the group: Administrative Services Only (ASO) or Fully Insured.. Valid values are `ASO|FullyInsured`',
    `issue_timestamp` TIMESTAMP COMMENT 'Date‑time when the quote was formally issued to the employer.',
    `member_count` STRING COMMENT 'Number of covered lives in the employer group for the quoted period.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Final premium after discounts, the amount the employer is expected to pay.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `plan_year` STRING COMMENT 'Calendar year to which the quoted plan benefits apply.',
    `pmpm_rate` DECIMAL(18,2) COMMENT 'Proposed premium rate expressed as a per‑member‑per‑month amount.',
    `quote_number` STRING COMMENT 'External reference number assigned to the quote for tracking and communication with the employer.',
    `quote_version` STRING COMMENT 'Version number of the quote, incremented on each revision.',
    `rate_quote_status` STRING COMMENT 'Current lifecycle state of the quote (e.g., draft, presented, accepted, expired, rejected).. Valid values are `draft|presented|accepted|expired|rejected`',
    `rating_area` STRING COMMENT 'Geographic rating area used to calculate the premium.',
    `rating_methodology` STRING COMMENT 'Method used to calculate rates: community, experience, or blended.. Valid values are `community|experience|blended`',
    `renewal_date` DATE COMMENT 'Date when the current policy term ends and renewal is expected.',
    `total_group_premium_estimate` DECIMAL(18,2) COMMENT 'Projected total premium for the entire employer group based on the quoted rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quote record.',
    CONSTRAINT pk_rate_quote PRIMARY KEY(`rate_quote_id`)
) COMMENT 'Premium rate quote issued to a prospective or renewing employer group, capturing proposed rates by plan, coverage tier, and rating area. Includes quote effective date, expiration date, rating methodology (community rated, experience rated, blended), proposed PMPM rates, total group premium estimate, and quote status (draft, presented, accepted, expired). Supports the sales and renewal pipeline.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`employer`.`broker` (
    `broker_id` BIGINT COMMENT 'Primary key for broker',
    `parent_broker_id` BIGINT COMMENT 'Self-referencing FK on broker (parent_broker_id)',
    `address_line1` STRING COMMENT 'First line of brokers physical address.',
    `address_line2` STRING COMMENT 'Second line of brokers physical address.',
    `agreement_end_date` DATE COMMENT 'End date of the broker agreement.',
    `agreement_start_date` DATE COMMENT 'Start date of the broker agreement.',
    `agreement_status` STRING COMMENT 'Current status of the broker agreement.',
    `agreement_terms` STRING COMMENT 'Detailed terms and conditions of the broker agreement.',
    `broker_name` STRING COMMENT 'Full legal name of the broker.',
    `broker_status` STRING COMMENT 'Current operational status of the broker.',
    `broker_type` STRING COMMENT 'Classification of broker (e.g., independent, captive).',
    `city` STRING COMMENT 'City of brokers address.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission amount paid to the broker.',
    `commission_currency` STRING COMMENT 'Currency in which the commission is paid.',
    `commission_end_date` DATE COMMENT 'End date of the commission period.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate agreed with the broker.',
    `commission_start_date` DATE COMMENT 'Start date of the commission period.',
    `country` STRING COMMENT 'Country of brokers address.',
    `email` STRING COMMENT 'Primary email address for broker communication.',
    `end_date` DATE COMMENT 'Date when the broker relationship ended or is scheduled to end.',
    `fax` STRING COMMENT 'Fax number for broker contact.',
    `license_number` STRING COMMENT 'License number issued by regulatory authority.',
    `phone` STRING COMMENT 'Primary phone number for broker contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of brokers address.',
    `rating` DECIMAL(18,2) COMMENT 'Credit rating or performance score assigned to the broker.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the broker record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp when the broker record was last updated.',
    `region` STRING COMMENT 'Geographic region where the broker operates.',
    `registration_number` STRING COMMENT 'Official registration number assigned to the broker.',
    `renewal_date` DATE COMMENT 'Scheduled date for renewing the broker agreement.',
    `renewal_status` STRING COMMENT 'Current status of the renewal process.',
    `start_date` DATE COMMENT 'Date when the broker relationship began.',
    `state` STRING COMMENT 'State or province of brokers address.',
    `tax_number` STRING COMMENT 'Tax ID used for regulatory reporting.',
    `termination_reason` STRING COMMENT 'Reason for terminating the broker relationship.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master reference table for broker. Referenced by broker_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ADD CONSTRAINT `fk_employer_group_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ADD CONSTRAINT `fk_employer_group_location_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ADD CONSTRAINT `fk_employer_group_contact_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_group_location_id` FOREIGN KEY (`group_location_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_location`(`group_location_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ADD CONSTRAINT `fk_employer_group_division_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ADD CONSTRAINT `fk_employer_group_plan_offering_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_division_id` FOREIGN KEY (`group_division_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_division`(`group_division_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_plan_offering_id` FOREIGN KEY (`group_plan_offering_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_plan_offering`(`group_plan_offering_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ADD CONSTRAINT `fk_employer_contribution_strategy_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_employer_underwriting_case_id` FOREIGN KEY (`employer_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`employer`.`employer_underwriting_case`(`employer_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ADD CONSTRAINT `fk_employer_group_renewal_rate_quote_id` FOREIGN KEY (`rate_quote_id`) REFERENCES `health_insurance_ecm`.`employer`.`rate_quote`(`rate_quote_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ADD CONSTRAINT `fk_employer_participation_requirement_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ADD CONSTRAINT `fk_employer_participation_requirement_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ADD CONSTRAINT `fk_employer_broker_assignment_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ADD CONSTRAINT `fk_employer_tpa_arrangement_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ADD CONSTRAINT `fk_employer_open_enrollment_window_group_renewal_id` FOREIGN KEY (`group_renewal_id`) REFERENCES `health_insurance_ecm`.`employer`.`group_renewal`(`group_renewal_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ADD CONSTRAINT `fk_employer_employer_underwriting_case_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_employer_underwriting_case_id` FOREIGN KEY (`employer_underwriting_case_id`) REFERENCES `health_insurance_ecm`.`employer`.`employer_underwriting_case`(`employer_underwriting_case_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ADD CONSTRAINT `fk_employer_rate_quote_group_id` FOREIGN KEY (`group_id`) REFERENCES `health_insurance_ecm`.`employer`.`group`(`group_id`);
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ADD CONSTRAINT `fk_employer_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `health_insurance_ecm`.`employer`.`broker`(`broker_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`employer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `health_insurance_ecm`.`employer` SET TAGS ('dbx_domain' = 'employer');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` SET TAGS ('dbx_subdomain' = 'employer_accounts');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (Broker Identifier)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Address Line 1)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Address Line 2)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `average_claim_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Claim Cost (Average Claim Cost)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy (Contribution Strategy)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (Country)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Record Creation Timestamp)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (DBA Name)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State (Domicile State)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `domicile_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Effective Date)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (Email Address)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `enrollment_count_ec` SET TAGS ('dbx_business_glossary_term' = 'Employee + Child Enrollment Count (Employee + Child Enrollment Count)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `enrollment_count_ef` SET TAGS ('dbx_business_glossary_term' = 'Family Enrollment Count (Family Enrollment Count)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `enrollment_count_eo` SET TAGS ('dbx_business_glossary_term' = 'Employee‑Only Enrollment Count (Employee‑Only Enrollment Count)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `enrollment_count_es` SET TAGS ('dbx_business_glossary_term' = 'Employee + Spouse Enrollment Count (Employee + Spouse Enrollment Count)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status (ERISA Status)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'covered|exempt');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Funding Arrangement (Funding Arrangement)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_value_regex' = 'fully_insured|aso|self_funded');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `gfc_code` SET TAGS ('dbx_business_glossary_term' = 'Group Financial Control Identifier (GFC Identifier)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number (Group Number)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_business_glossary_term' = 'Group Lifecycle Status (Group Lifecycle Status)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `group_status` SET TAGS ('dbx_value_regex' = 'prospect|active|suspended|terminated|reinstated');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `headcount_current` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount (Current Headcount)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `headcount_last_month` SET TAGS ('dbx_business_glossary_term' = 'Headcount Last Month (Headcount Last Month)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `headcount_last_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Last Year (Headcount Last Year)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (Last Status Change Timestamp)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (Legal Name)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (Line of Business)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'health|dental|vision|wellness|pharmacy');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment (Market Segment)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'small_group|large_group|individual');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System Code (NAICS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `participation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement (Participation Requirement)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (Phone Number)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^d{10}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (Postal Code)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date (Renewal Date)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (Risk Adjustment Factor)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification Code (SIC)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `size_tier` SET TAGS ('dbx_business_glossary_term' = 'Group Size Tier (Group Size Tier)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `size_tier` SET TAGS ('dbx_value_regex' = 'small|medium|large|enterprise');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State (State)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Record Update Timestamp)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` SET TAGS ('dbx_subdomain' = 'employer_accounts');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `group_location_id` SET TAGS ('dbx_business_glossary_term' = 'Group Location ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'On Site Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Group Location Address Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|billing|satellite|mailing');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `group_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Location Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Group Location Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Group Location Name');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_business_glossary_term' = 'ZIP+4 Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_location` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` SET TAGS ('dbx_subdomain' = 'employer_accounts');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `group_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Group Contact ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Contact Authorization Level (AUTHORIZATION_LEVEL)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `can_bill` SET TAGS ('dbx_business_glossary_term' = 'Can Bill Flag (CAN_BILL)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `can_enroll` SET TAGS ('dbx_business_glossary_term' = 'Can Enroll Flag (CAN_ENROLL)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact City (CITY)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type (CONTACT_TYPE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'hr_admin|benefits_coordinator|payroll|executive_sponsor|other');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Contact Country Code (COUNTRY)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department (DEPARTMENT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address (EMAIL)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name (FIRST_NAME)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (FULL_NAME)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `group_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag (IS_PRIMARY_CONTACT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name (LAST_NAME)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (LAST_UPDATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number (PHONE_NUMBER)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Postal Code (POSTAL_CODE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (PREFERRED_COMM_CHANNEL)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `source_system_contact_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Contact Identifier (SOURCE_SYSTEM_CONTACT_ID)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Contact State/Province (STATE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_contact` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title (TITLE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` SET TAGS ('dbx_subdomain' = 'employer_accounts');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `group_location_id` SET TAGS ('dbx_business_glossary_term' = 'Group Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'PPO Plan ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `billing_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Billing Entity Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Funding Classification');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'ASO|Fully_Insured|Self_Funded|TPA|Broker_Managed');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Contribution Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `contribution_percent` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percent');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered|none');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `covered_member_count` SET TAGS ('dbx_business_glossary_term' = 'Covered Member Count');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `division_name` SET TAGS ('dbx_business_glossary_term' = 'Division Name');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `division_type` SET TAGS ('dbx_business_glossary_term' = 'Division Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `division_type` SET TAGS ('dbx_value_regex' = 'department|subsidiary|cost_center|location|joint_venture');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `eligibility_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Set');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `flex_spending_amount` SET TAGS ('dbx_business_glossary_term' = 'Flex Spending Contribution Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `fsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'FSA Contribution Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `group_division_status` SET TAGS ('dbx_business_glossary_term' = 'Division Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `group_division_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `hsa_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'HSA Contribution Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_flex_spending` SET TAGS ('dbx_business_glossary_term' = 'Flex Spending Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_fsa` SET TAGS ('dbx_business_glossary_term' = 'FSA Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_hsa` SET TAGS ('dbx_business_glossary_term' = 'HSA Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `is_eligible_for_waiver` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `subsidy_percent` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Percent');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_division` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` SET TAGS ('dbx_subdomain' = 'coverage_setup');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Identifier');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (EMP_GRP_ID)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier (PLAN_ID)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Contribution Amount (CONTRIB_AMT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective End Date (CONTRIB_EFF_END)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Effective Start Date (CONTRIB_EFF_START)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_percent` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage (CONTRIB_PCT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Description (CONTRIB_STRAT_DESC)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_tier` SET TAGS ('dbx_business_glossary_term' = 'Contribution Tier (CONTRIB_TIER)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type (CONTRIB_TYPE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_FROM)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_UNTIL)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee‑Only Contribution Amount (EMP_CONTRIB_AMT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `family_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Contribution Amount (FAM_CONTRIB_AMT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('dbx_business_glossary_term' = 'Offering Status (OFC_STATUS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `group_plan_offering_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|draft|suspended');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `hra_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Reimbursement Arrangement Seed Amount (HRA_SEED)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `hsa_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account Seed Amount (HSA_SEED)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `is_affordable` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Indicator (ACA_AFFORD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date (MEAS_END)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `measurement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date (MEAS_START)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `minimum_enrolled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrolled Headcount (MIN_ENR_HEADCOUNT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `minimum_participation_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participation Percentage (MIN_PART_PCT)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `offering_code` SET TAGS ('dbx_business_glossary_term' = 'Offering Code (OFC)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `offering_description` SET TAGS ('dbx_business_glossary_term' = 'Offering Description (OFC_DESC)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `offering_name` SET TAGS ('dbx_business_glossary_term' = 'Offering Name (OFC_NAME)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Offering Type (OFC_TYPE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date (OE_END)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date (OE_START)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status (PARTICIP_STATUS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `plan_catalog_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Catalog Version (CATALOG_VER)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Waiver Criteria Description (WAIVER_CRIT_DESC)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_plan_offering` ALTER COLUMN `waiver_eligible` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligibility (WAIVER_ELIG)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` SET TAGS ('dbx_subdomain' = 'coverage_setup');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `affordability_test_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Test Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Contribution Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_code` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Code (CS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contribution Percentage');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rule Name');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_strategy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Contribution Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `contribution_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `employer_contribution_cap` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Cap (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `hra_employer_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer HRA Seed Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `hsa_employer_seed_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer HSA Seed Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `is_post_tax` SET TAGS ('dbx_business_glossary_term' = 'Post‑Tax Contribution Indicator');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `is_pre_tax` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Tax Contribution Indicator');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `maximum_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Maximum Employee Contribution (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `minimum_employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Minimum Employee Contribution (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `tax_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`contribution_strategy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` SET TAGS ('dbx_subdomain' = 'coverage_setup');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `rate_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `benefit_plan_ids` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan IDs');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'applicable|not_applicable');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_value_regex' = 'fully_insured|aso|self_funded|tpa');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size (Number of Covered Lives)');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_after_value` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment After Value');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Approval Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_before_value` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Before Value');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Effective Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Reason Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `latest_amendment_type` SET TAGS ('dbx_value_regex' = 'benefit_change|plan_add_drop|contribution_change|address_update|contact_change');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement Met');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_outcome` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement Outcome');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `participation_requirement_outcome` SET TAGS ('dbx_value_regex' = 'met|not_met|partial');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `premium_rate_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Prior Year Premium Rate');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `premium_rate_renewal_year` SET TAGS ('dbx_business_glossary_term' = 'Renewal Year Premium Rate');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `prior_renewal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Renewal Effective Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `rate_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Percentage');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Year');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Effective Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal End Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_notes` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|proposed|accepted|declined|expired');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `renewal_status_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `retention_outcome` SET TAGS ('dbx_business_glossary_term' = 'Retention Outcome');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `retention_outcome` SET TAGS ('dbx_value_regex' = 'retained|lost|pending');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `retention_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Retention Reason Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`group_renewal` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` SET TAGS ('dbx_subdomain' = 'coverage_setup');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Participation Requirement ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `compliance_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Due Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'employer_paid|employee_paid|shared');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `enrolled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Enrolled Headcount');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'applicable|not_applicable');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Funding Arrangement');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `funding_arrangement` SET TAGS ('dbx_value_regex' = 'ASO|fully_insured|self_funded');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Total Group Size');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `last_evaluated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `measurement_period` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `measurement_period` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `minimum_enrolled_headcount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Enrolled Headcount');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requirement Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Participation Percentage');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_status` SET TAGS ('dbx_business_glossary_term' = 'Requirement Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `participation_requirement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Evaluation Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `requirement_name` SET TAGS ('dbx_business_glossary_term' = 'Requirement Name');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Requirement Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `requirement_type` SET TAGS ('dbx_value_regex' = 'minimum_participation|waiver_eligibility|headcount_threshold');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `waiver_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`participation_requirement` ALTER COLUMN `waiver_percentage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Waiver Percentage');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Agency Name (AGENCY_NAME)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Broker Assignment Status (STATUS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `broker_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `commission_basis` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis (COMMISSION_BASIS)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `commission_basis` SET TAGS ('dbx_value_regex' = 'premium|claim|revenue|service_fee');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate (COMMISSION_RATE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `commission_type` SET TAGS ('dbx_business_glossary_term' = 'Commission Type (COMMISSION_TYPE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `commission_type` SET TAGS ('dbx_value_regex' = 'percentage|flat|tiered');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Broker Indicator (IS_PRIMARY)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'TPA Arrangement ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `reinsurance_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_value_regex' = 'ASO|Self-Funded|Fully-Insured');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_rate_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Contribution Rate (PMPM)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Strategy');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Effective End Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Coverage Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'covered|exempt');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Cap Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_rate_pmpm` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Rate (PMPM)');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_value_regex' = 'claims_processing|network_access|care_management|pbm|utilization_review');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `gfc_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Group Financial Control Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `group_size_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Group Size');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `group_size_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Group Size');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Renewal Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Coverage Scope');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_coverage_scope` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|all');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Effective Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `stop_loss_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Stop‑Loss Expiration Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `tpa_arrangement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`employer`.`tpa_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` SET TAGS ('dbx_subdomain' = 'coverage_setup');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Identifier');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `change_deadline` SET TAGS ('dbx_business_glossary_term' = 'Election Change Deadline');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|wellness|all');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `eligible_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Eligible Employee Count');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window End Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Method');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_method` SET TAGS ('dbx_value_regex' = 'online|paper|edi');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|cancelled');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `enrollment_window_type` SET TAGS ('dbx_value_regex' = 'annual|new_hire|cobra|special');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `participation_rate` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `plan_selection_method` SET TAGS ('dbx_business_glossary_term' = 'Plan Selection Method');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `plan_selection_method` SET TAGS ('dbx_value_regex' = 'single|multiple');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Window Start Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Election Submission Deadline');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `total_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Total Employee Count');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_allowed` SET TAGS ('dbx_business_glossary_term' = 'Waiver Allowed Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `waiver_deadline` SET TAGS ('dbx_business_glossary_term' = 'Waiver Deadline');
ALTER TABLE `health_insurance_ecm`.`employer`.`open_enrollment_window` ALTER COLUMN `window_code` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` SET TAGS ('dbx_subdomain' = 'underwriting_rating');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `aca_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'ACA Adjustment Factor');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `actuarial_basis_document` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Basis Document Reference');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_business_glossary_term' = 'Age/Gender Composite Factor');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `age_gender_composite_factor` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Case Number (UCN)');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Effective End Date (Expiration Date)');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Effective Start Date (Effective Date)');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `experience_rating_factor` SET TAGS ('dbx_business_glossary_term' = 'Experience Rating Factor');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `geographic_factor` SET TAGS ('dbx_business_glossary_term' = 'Geographic Rating Factor');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_average_age` SET TAGS ('dbx_business_glossary_term' = 'Group Average Age');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_census_size` SET TAGS ('dbx_business_glossary_term' = 'Group Census Size');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `group_female_percentage` SET TAGS ('dbx_business_glossary_term' = 'Group Female Percentage');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `industry_risk_factor` SET TAGS ('dbx_business_glossary_term' = 'Industry Risk Factor Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `manual_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Manual Rate Basis Flag');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `pmpm_estimate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month (PMPM) Estimate');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `prior_carrier_loss_experience` SET TAGS ('dbx_business_glossary_term' = 'Prior Carrier Loss Experience Summary');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Generation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|retracted');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_area_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Area Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'community|experience|blended');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Submission Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `total_premium_estimate` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Estimate (USD)');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved|declined|modified|pending');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `underwriting_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|declined|modified');
ALTER TABLE `health_insurance_ecm`.`employer`.`employer_underwriting_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` SET TAGS ('dbx_subdomain' = 'underwriting_rating');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Quote ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `employer_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `contribution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee|family|individual|spouse');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Effective Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `erisa_status` SET TAGS ('dbx_business_glossary_term' = 'ERISA Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `erisa_status` SET TAGS ('dbx_value_regex' = 'ERISA|NonERISA');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Expiration Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `gross_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `group_sic_code` SET TAGS ('dbx_business_glossary_term' = 'Group SIC Code');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `group_size` SET TAGS ('dbx_business_glossary_term' = 'Group Size');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('dbx_business_glossary_term' = 'Group Funding Type');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `group_type` SET TAGS ('dbx_value_regex' = 'ASO|FullyInsured');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Issue Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `pmpm_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Member Per Month Rate');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `quote_version` SET TAGS ('dbx_business_glossary_term' = 'Quote Version');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `rate_quote_status` SET TAGS ('dbx_value_regex' = 'draft|presented|accepted|expired|rejected');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'community|experience|blended');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `total_group_premium_estimate` SET TAGS ('dbx_business_glossary_term' = 'Total Group Premium Estimate');
ALTER TABLE `health_insurance_ecm`.`employer`.`rate_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` SET TAGS ('dbx_subdomain' = 'broker_relations');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `broker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`employer`.`broker` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_national_id' = 'true');
