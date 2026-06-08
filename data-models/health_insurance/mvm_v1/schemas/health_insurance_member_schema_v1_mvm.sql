-- Schema for Domain: member | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`member` COMMENT 'Single source of truth for all insured individuals — members, subscribers, dependents, and beneficiaries across commercial, Medicare, Medicaid, and CHIP lines of business. Owns member demographics, PII/PHI identity, eligibility status, LOB assignment, COBRA continuants, household relationships, and member lifecycle events. All other domains reference member identity via FK. Supports HIPAA privacy obligations and CMS enrollment reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Primary key for subscriber',
    `contact_id` BIGINT COMMENT 'FK to member.contact',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Subscribers (employees) belong to a specific employer group division, which determines their benefit eligibility, contribution amounts, and plan offerings. HR/benefits administration requires division',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for payroll‑deduction enrollment reports linking each employee subscriber to their employer group for contribution calculations and ERISA compliance.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan product.',
    `coordinator_id` BIGINT COMMENT 'Foreign key linking to care.care_coordinator. Business justification: Primary Care Coordinator Assignment: case‑management reports need each subscriber linked to their assigned care coordinator.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: Primary Care Provider assignment for each subscriber is needed for care coordination, network adequacy reporting, and member portal display.',
    `annual_income` DECIMAL(18,2) COMMENT 'Subscribers reported annual income (for subsidy eligibility).',
    `chip_number` STRING COMMENT 'Childrens Health Insurance Program identifier.',
    `citizenship_status` STRING COMMENT 'Legal citizenship or residency status.. Valid values are `citizen|permanent_resident|non_resident|unknown`',
    `cob_indicator` STRING COMMENT 'Indicates subscribers position in coordination of benefits.. Valid values are `primary|secondary|tertiary`',
    `consent_to_electronic_communication` BOOLEAN COMMENT 'Subscribers consent to receive electronic communications.',
    `coverage_type` STRING COMMENT 'Type of health plan coverage.. Valid values are `hmo|ppo|epo|pos|hdhp|hsa`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscriber record was created.',
    `date_of_birth` DATE COMMENT 'Subscribers birth date.',
    `disability_status` STRING COMMENT 'Indicates if subscriber has a disability.. Valid values are `yes|no|unknown`',
    `effective_date` DATE COMMENT 'Date when subscriber coverage becomes effective.',
    `enrollment_source` STRING COMMENT 'Channel through which subscriber enrolled.. Valid values are `online|call_center|agent|mail|broker`',
    `first_name` STRING COMMENT 'Subscribers given name.',
    `gender` STRING COMMENT 'Subscribers gender as reported.. Valid values are `male|female|other|unknown`',
    `hcc_score` DECIMAL(18,2) COMMENT 'Aggregated HCC score for the subscriber.',
    `is_deceased` BOOLEAN COMMENT 'Flag indicating if subscriber is deceased.',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|zh|other`',
    `last_name` STRING COMMENT 'Subscribers family name.',
    `line_of_business` STRING COMMENT 'Business line the subscriber belongs to.. Valid values are `commercial|medicare|medicaid|chip|group|individual`',
    `marital_status` STRING COMMENT 'Subscribers marital status.. Valid values are `single|married|divorced|widowed|separated|unknown`',
    `medicaid_number` STRING COMMENT 'State Medicaid identifier.',
    `medicare_beneficiary_number` STRING COMMENT 'Unique identifier for Medicare beneficiaries.',
    `middle_name` STRING COMMENT 'Subscribers middle name (if any).',
    `primary_contact_method` STRING COMMENT 'Preferred method for contacting subscriber.. Valid values are `phone|email|mail|portal`',
    `race_ethnicity` STRING COMMENT 'Self-reported race/ethnicity for reporting.. Valid values are `white|black|asian|hispanic|native_american|other`',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk adjustment calculations.',
    `ssn` STRING COMMENT 'Subscribers Social Security Number.. Valid values are `^(d{3}-d{2}-d{4})$`',
    `subscriber_number` STRING COMMENT 'External contract number assigned to the subscriber.',
    `subscriber_status` STRING COMMENT 'Current lifecycle status of the subscriber.. Valid values are `active|inactive|terminated|suspended|pending`',
    `termination_date` DATE COMMENT 'Date when subscriber coverage ends (if applicable).',
    `tobacco_use_status` STRING COMMENT 'Subscribers tobacco use status.. Valid values are `current|former|never|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscriber record.',
    `veteran_status` BOOLEAN COMMENT 'Indicates if subscriber is a veteran.',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Core master entity representing the primary insured individual (subscriber/policyholder) who holds the health insurance contract. Captures full demographic identity including SSN, date of birth, gender, marital status, language preference, race/ethnicity (for HEDIS/CMS reporting), tobacco use status, disability status, and Medicare/Medicaid beneficiary identifiers. Serves as the SSOT for subscriber identity across commercial, Medicare Advantage, Medicaid, and CHIP lines of business. All dependent, eligibility, and benefit records reference this entity. Supports HIPAA PHI/PII obligations, CMS enrollment reporting, and X12 834 subscriber loop requirements.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`dependent` (
    `dependent_id` BIGINT COMMENT 'Primary key for dependent',
    `address_id` BIGINT COMMENT 'Foreign key linking to member.member_address. Business justification: Dependent has inline address columns (address_line1, address_line2, city, state, postal_code, country) that duplicate the authoritative member_address table. Adding member_address_id FK normalizes dep',
    `contact_id` BIGINT COMMENT 'Foreign key linking to member.member_contact. Business justification: Dependent has inline contact fields (email_address, phone_number) that duplicate the authoritative member_contact table. Adding member_contact_id FK normalizes dependent contact data to the canonical ',
    `identity_id` BIGINT COMMENT 'Foreign key linking to member.identity. Business justification: The identity product is the authoritative identity resolution record for each unique insured individual — explicitly including both subscribers AND dependents. Currently identity.subscriber_id links i',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary member (subscriber) to whom this dependent is attached.',
    `age_out_eligibility_flag` BOOLEAN COMMENT 'True if the dependent is eligible for age-out coverage under plan rules.',
    `chip_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for the Childrens Health Insurance Program.',
    `coverage_end_date` DATE COMMENT 'Date when dependents coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when dependents coverage became effective.',
    `coverage_status` STRING COMMENT 'Current status of the dependents coverage.. Valid values are `active|inactive|terminated|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Birth date of the dependent.',
    `disability_status` BOOLEAN COMMENT 'Indicates if the dependent has a documented disability.',
    `first_name` STRING COMMENT 'Given name of the dependent.',
    `gender` STRING COMMENT 'Gender of the dependent as reported.. Valid values are `male|female|other|unknown`',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates if this dependent is the primary contact for the subscribers household.',
    `language_preference` STRING COMMENT 'Preferred language for communications with the dependent.',
    `last_name` STRING COMMENT 'Family name of the dependent.',
    `medicaid_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for Medicaid program.',
    `middle_name` STRING COMMENT 'Middle name or initial of the dependent.',
    `record_status` STRING COMMENT 'Lifecycle status of the record itself.. Valid values are `active|inactive|deleted|archived`',
    `relationship_end_date` DATE COMMENT 'Date when the dependent relationship ended, if applicable.',
    `relationship_start_date` DATE COMMENT 'Date when the dependent relationship became effective.',
    `relationship_type` STRING COMMENT 'Legal relationship of the dependent to the subscriber.. Valid values are `spouse|domestic_partner|child|other`',
    `sequence_number` STRING COMMENT 'Ordinal number to differentiate multiple dependents of same relationship type.',
    `ssn` STRING COMMENT 'Government-issued identifier for the dependent.. Valid values are `^d{3}-d{2}-d{4}$`',
    `student_status` BOOLEAN COMMENT 'Indicates if the dependent is currently a student (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dependent record.',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Master entity representing individuals covered under a subscribers health plan — spouses, domestic partners, children, and other qualifying dependents. Tracks relationship type to subscriber, dependent sequence number, student status, disability status, age-out eligibility rules, and CHIP/Medicaid eligibility indicators. Maintains its own demographic profile including DOB, gender, SSN, and language preference. Supports dependent verification workflows, age-out processing, and CMS CHIP enrollment reporting. Each dependent record is linked to a subscriber and an enrollment span.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`identity` (
    `identity_id` BIGINT COMMENT 'Primary key for identity',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Business process: Billing Account Management – each member identity must be linked to a billing account for premium collection, payment processing, and regulatory reporting.',
    `address_id` BIGINT COMMENT 'FK to member.member_address',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan to which the member is assigned.',
    `subscriber_id` BIGINT COMMENT 'Identifier assigned by the health plan to the member (e.g., commercial member ID, MBI for Medicare).',
    `citizenship_status` STRING COMMENT 'Citizenship or residency status relevant for eligibility and reporting.. Valid values are `citizen|non_citizen|permanent_resident|temporary_resident|unknown`',
    `coverage_end_date` DATE COMMENT 'Date when the members coverage terminated or is scheduled to end.',
    `coverage_start_date` DATE COMMENT 'Date when the members coverage became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the identity record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Members birth date, used for age‑based eligibility and risk calculations.',
    `eligibility_status` STRING COMMENT 'Current eligibility determination for benefits coverage.. Valid values are `eligible|ineligible|pending`',
    `email` STRING COMMENT 'Primary email address used for member communications and portal login.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_effective_date` DATE COMMENT 'Date the members enrollment into the plan became effective.',
    `ethnicity` STRING COMMENT 'Members ethnicity as reported for demographic reporting.',
    `external_subscriber_number` STRING COMMENT 'Identifier from an external source such as employer payroll or third‑party administrator.',
    `first_name` STRING COMMENT 'Members given (first) name.',
    `full_name` STRING COMMENT 'Complete legal name of the member as it appears on official documents.',
    `gender` STRING COMMENT 'Self‑identified gender of the member.. Valid values are `male|female|other|unknown`',
    `language_preference` STRING COMMENT 'Primary language the member prefers for communications.',
    `last_name` STRING COMMENT 'Members family (last) name.',
    `lob` STRING COMMENT 'Business line (e.g., commercial, Medicare) to which the member belongs.. Valid values are `commercial|medicare|medicaid|chip|group`',
    `marital_status` STRING COMMENT 'Members marital status for demographic and eligibility purposes.. Valid values are `single|married|divorced|widowed|separated|unknown`',
    `member_status` STRING COMMENT 'Overall lifecycle status of the member within the health plan.. Valid values are `active|inactive|terminated|suspended|pending`',
    `member_type` STRING COMMENT 'Indicates whether the record represents a primary subscriber or a dependent.. Valid values are `subscriber|dependent|spouse|child|other`',
    `middle_name` STRING COMMENT 'Members middle name(s), if any.',
    `phone_number` STRING COMMENT 'Primary telephone number for member contact.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for member communications.. Valid values are `email|phone|mail|portal`',
    `race` STRING COMMENT 'Members race classification for HEDIS and regulatory reporting.',
    `relationship_to_subscriber` STRING COMMENT 'Describes the members relationship to the primary subscriber.. Valid values are `self|spouse|child|parent|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score used for underwriting and care management.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the identity data.. Valid values are `Facets|QNXT|Custom`',
    `source_system_record_code` STRING COMMENT 'Unique identifier of the source record in the originating system.',
    `ssn_hash` STRING COMMENT 'Hashed Social Security Number used for identity matching while protecting PII.',
    `termination_date` DATE COMMENT 'Date the members relationship with the plan was terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the identity record.',
    `verification_date` DATE COMMENT 'Date on which the members identity was successfully verified.',
    `verification_status` STRING COMMENT 'Current status of the members identity verification process.. Valid values are `unverified|pending|verified|failed`',
    CONSTRAINT pk_identity PRIMARY KEY(`identity_id`)
) COMMENT 'Authoritative identity resolution record for each unique insured individual (subscriber or dependent) assigned a unique member ID by the health plan. Stores the plan-assigned member ID (MBI for Medicare, Medicaid ID, commercial member ID), cross-reference IDs from source systems (Facets member ID, QNXT ID), alternate IDs (SSN hash, external subscriber ID from employer), and identity verification status. Manages member ID history and superseded IDs. This is the enterprise golden record for member identity used by all downstream domains (claims, pharmacy, care management) to resolve member identity.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`address` (
    `address_id` BIGINT COMMENT 'Surrogate primary key for the address record.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the member to whom this address belongs.',
    `address_type` STRING COMMENT 'Classification of address purpose.. Valid values are `home|mailing|temporary|employer|other`',
    `census_tract` STRING COMMENT 'Census tract identifier for demographic analysis.. Valid values are `^d{11}$`',
    `change_reason` STRING COMMENT 'Reason for address change (e.g., member request, system update).',
    `city` STRING COMMENT 'City name of the address.',
    `country_code` STRING COMMENT 'Three-letter ISO country code.. Valid values are `^[A-Z]{3}$`',
    `county_fips` STRING COMMENT 'Federal Information Processing Standard code for the county.. Valid values are `^d{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was first created in the data lake.',
    `effective_date` DATE COMMENT 'Date when the address became effective for the member.',
    `external_code` STRING COMMENT 'External identifier for the address from source system.',
    `geocode_accuracy_meters` STRING COMMENT 'Accuracy of the geocoding result in meters.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this address is the primary address for the member.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude in decimal degrees.',
    `line1` STRING COMMENT 'Primary street address line.',
    `line2` STRING COMMENT 'Secondary address line (apartment, suite, etc.).',
    `line3` STRING COMMENT 'Additional address line if needed.',
    `line4` STRING COMMENT 'Additional address line if needed.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude in decimal degrees.',
    `member_address_status` STRING COMMENT 'Current lifecycle status of the address.. Valid values are `active|inactive|pending|terminated`',
    `postal_code` STRING COMMENT 'Five-digit ZIP code, optionally with ZIP+4.. Valid values are `^d{5}(-d{4})?$`',
    `priority_rank` STRING COMMENT 'Rank indicating priority among multiple concurrent addresses for the member (1 = highest).',
    `source_system` STRING COMMENT 'Source system that supplied the address record (e.g., Facets, CRM).',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when the address was terminated or superseded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `verification_date` DATE COMMENT 'Date when address verification was performed.',
    `verification_status` STRING COMMENT 'USPS CASS certification status of the address.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Manages all physical and mailing addresses associated with a member, including home address, mailing address, temporary address, and employer address. Tracks address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, and geographic coordinates for network adequacy analysis. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, and CMS geographic reporting. Maintains address history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`contact` (
    `contact_id` BIGINT COMMENT 'System-generated unique identifier for each contact record associated with a member.',
    `address_cass_certified` BOOLEAN COMMENT 'True if the address has passed USPS CASS certification.',
    `address_effective_date` DATE COMMENT 'Date when the address became effective for the member.',
    `address_geocode_accuracy` STRING COMMENT 'Indicates the confidence level of the geocoding result.. Valid values are `high|medium|low`',
    `address_geocode_source` STRING COMMENT 'System used to generate latitude/longitude for the address.. Valid values are `USPS|Google|HERE|Other`',
    `address_line1` STRING COMMENT 'Primary street address line.',
    `address_line2` STRING COMMENT 'Secondary street address line (apartment, suite, etc.).',
    `address_priority_rank` STRING COMMENT 'Numeric rank indicating the order of address preference for the member.',
    `address_source_system` STRING COMMENT 'Source system that originally supplied the address record.. Valid values are `Facets|QNXT|CRM|Other`',
    `address_termination_date` DATE COMMENT 'Date when the address was terminated or superseded.',
    `address_type` STRING COMMENT 'Purpose of the address (e.g., home, mailing, temporary).. Valid values are `home|mailing|temporary|employer|other`',
    `address_verification_status` STRING COMMENT 'USPS CASS certification status of the address.. Valid values are `verified|unverified|pending`',
    `census_tract` STRING COMMENT 'Eleven‑digit census tract identifier for geographic analysis.',
    `city` STRING COMMENT 'City of the address.',
    `contact_name` STRING COMMENT 'Legal full name of the contact person (member, dependent, or other party).',
    `contact_type` STRING COMMENT 'Classification of the contact relationship to the member.. Valid values are `member|dependent|beneficiary|employer|provider|other`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the address.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `county_fips` STRING COMMENT 'Five‑digit Federal Information Processing Standard code for the county.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contact record was first created.',
    `email_address` STRING COMMENT 'Primary electronic mail address for the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the contact.',
    `id_type` STRING COMMENT 'Type of identifier used for the contact (e.g., NPI, SSN).. Valid values are `NPI|SSN|MemberID|Other`',
    `id_value` DECIMAL(18,2) COMMENT 'The actual identifier value corresponding to contact_id_type.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this record is the members primary contact.',
    `language_preference` STRING COMMENT 'Members preferred language for communications.. Valid values are `en|es|fr|zh|other`',
    `last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent address verification event.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the address in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the address in decimal degrees.',
    `member_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|terminated|pending`',
    `notes` STRING COMMENT 'Free‑form notes related to the contact (e.g., preferred call times).',
    `opt_in_email` BOOLEAN COMMENT 'Indicates whether the member has consented to receive email communications.',
    `opt_in_robocall` BOOLEAN COMMENT 'Indicates whether the member permits automated voice calls.',
    `opt_in_sms` BOOLEAN COMMENT 'Indicates whether the member has consented to receive SMS messages.',
    `phone_home` STRING COMMENT 'Primary residential telephone number.',
    `phone_mobile` STRING COMMENT 'Cellular telephone number for mobile contact.',
    `phone_work` STRING COMMENT 'Telephone number associated with the contacts place of work.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.',
    `preferred_contact_method` STRING COMMENT 'Contact channel the member prefers for communications.. Valid values are `phone|email|mail|sms`',
    `relationship` STRING COMMENT 'Relationship of the contact to the member.. Valid values are `self|spouse|child|parent|guardian|other`',
    `state_province` STRING COMMENT 'State or province component of the address.',
    `tcp_a_consent_flag` BOOLEAN COMMENT 'True if the contact has provided consent under the Telephone Consumer Protection Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the contact record.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Single source of truth for all member contact information and addresses. Manages physical and mailing addresses (home, mailing, temporary, employer), phone numbers (home, mobile, work), email addresses, and fax numbers. Tracks contact type, address type, effective and termination dates, address verification status (USPS CASS-certified), county FIPS code, census tract, geographic coordinates for network adequacy analysis, opt-in/opt-out status per channel (SMS, email, robocall), TCPA consent flags, and preferred contact method and language. Supports multiple concurrent addresses with priority ranking. Used for premium billing, EOB mailing, provider directory access, CMS geographic reporting, member services outreach, care management communications, and CAHPS survey administration. Maintains full address and contact history for audit and compliance purposes.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` (
    `member_eligibility_span_id` BIGINT COMMENT 'System-generated unique identifier for the eligibility span record.',
    `benefit_package_id` BIGINT COMMENT 'Identifier of the specific benefit package within the plan.',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: Capitation payment runs require attributing each member eligibility span to a capitation arrangement to generate accurate PMPM payments to PCPs/IPAs. This is a core operational process in capitated he',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Claims adjudication and member cost-sharing calculations require knowing which fee schedule governs a members eligibility span. Health plan operations teams join eligibility spans to fee schedules to',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Each eligibility span is governed by a specific formulary that determines drug coverage, tier cost-sharing, PA requirements, and step therapy rules for that coverage period. Health insurance operation',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Eligibility spans are governed by division-specific benefit packages, contribution strategies, and eligibility rules. Eligibility processing systems must validate which divisions rules apply to a spa',
    `group_id` BIGINT COMMENT 'Identifier of the employer group or organization sponsoring the coverage.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which the member is eligible.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom this eligibility span applies.',
    `open_enrollment_window_id` BIGINT COMMENT 'Foreign key linking to employer.open_enrollment_window. Business justification: Eligibility spans are created or modified during employer open enrollment windows. Linking spans to the originating window supports compliance audit trails, retroactive eligibility validation, and reg',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: An eligibility span represents a continuous period of health plan coverage for a member, which is governed by a specific policy. Linking member_eligibility_span to policy via policy_id enables traceab',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: The eligibility span is the operational record that drives premium calculation for a coverage period. Linking it directly to the applicable premium rate enables premium estimation at enrollment, rate ',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Eligibility Verification and Network Adequacy reports need the network associated with the eligibility span to assess provider access and regulatory compliance.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: The rate record determines the premium for each eligibility span. Linking member_eligibility_span to plan.rate enables premium reconciliation, actuarial audit trails, and CMS rate filing compliance. p',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Member eligibility spans in tiered network plans must reference the assigned tier to drive deductible, copay, and OOP max differentials during claims adjudication and EOB generation. A health insuranc',
    `tpa_arrangement_id` BIGINT COMMENT 'Foreign key linking to employer.tpa_arrangement. Business justification: For self-funded employer groups, eligibility spans are administered under a specific TPA arrangement governing claims adjudication, fee schedules, and stop-loss thresholds. TPA administrators require ',
    `um_program_id` BIGINT COMMENT 'Foreign key linking to utilization.um_program. Business justification: Eligibility-based UM program assignment: a members eligibility span determines which UM program (and its clinical criteria, PA requirements, LOB rules) governs their coverage period. Health insurance',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: VBC/ACO performance measurement and shared savings calculations require attributing member eligibility spans to VBC contracts. CMS and commercial VBC programs mandate member attribution tracking per p',
    `cobro_end_date` DATE COMMENT 'End date of COBRA continuation coverage, if applicable.',
    `cobro_start_date` DATE COMMENT 'Start date of COBRA continuation coverage, if applicable.',
    `coverage_type` STRING COMMENT 'Type of coverage provided during the eligibility span.. Valid values are `medical|dental|vision|rx|wellness`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility span record was created in the system.',
    `effective_date` DATE COMMENT 'Date when the eligibility period becomes effective.',
    `eligibility_source` STRING COMMENT 'Origin of the eligibility information (e.g., EDI 834 file, manual entry).. Valid values are `834|manual|cms|portal`',
    `eligibility_status` STRING COMMENT 'Current status of the eligibility span.. Valid values are `active|terminated|suspended|cobra|pending`',
    `enrollment_type` STRING COMMENT 'Nature of the enrollment event that created this eligibility span.. Valid values are `new|renewal|change|reinstatement`',
    `gap_in_coverage_flag` BOOLEAN COMMENT 'True if there is a gap in coverage between this span and the previous span.',
    `is_primary_coverage` BOOLEAN COMMENT 'Indicates whether this span represents the primary coverage for the member (vs. supplemental).',
    `line_of_business` STRING COMMENT 'Business line under which the coverage is offered.. Valid values are `commercial|medicare|medicaid|chip`',
    `retroactive_eligibility_flag` BOOLEAN COMMENT 'Indicates if the eligibility was applied retroactively.',
    `subscriber_relationship_code` STRING COMMENT 'Code indicating the relationship of the member to the primary subscriber.. Valid values are `self|spouse|child|parent|other`',
    `termination_date` DATE COMMENT 'Date when the eligibility period ends or is scheduled to end.',
    `termination_reason_code` STRING COMMENT 'Code describing why the eligibility span terminated.. Valid values are `member_request|non_payment|plan_change|death|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the eligibility span record.',
    CONSTRAINT pk_member_eligibility_span PRIMARY KEY(`member_eligibility_span_id`)
) COMMENT 'Core transactional entity representing a continuous period of health plan eligibility for a member. Captures effective date, termination date, termination reason code, plan ID, benefit package, group/employer ID, subscriber relationship code, premium amount, and eligibility source (834 EDI, manual entry, CMS enrollment file). Tracks eligibility status (active, terminated, suspended, COBRA), retroactive eligibility adjustments, and gap-in-coverage periods. The SSOT for answering Is this member eligible on date X? — used by claims adjudication, pharmacy, and provider eligibility verification (270/271 transactions).';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`cobra_continuant` (
    `cobra_continuant_id` BIGINT COMMENT 'System-generated unique identifier for the COBRA continuant record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: COBRA continuants require a dedicated billing account separate from the employer group account — premiums are billed directly to the individual. COBRA billing setup and premium collection operations r',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: COBRA administration requires tracking the specific benefit package from prior coverage to calculate correct COBRA premiums (102% of plan cost per ERISA). cobra_continuant only links to health_plan_id',
    `cobra_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.cobra_election. Business justification: cobra_continuant (member domain) and cobra_election (enrollment domain) are complementary records of the same COBRA event. Linking them is essential for COBRA administration, DOL 60-day notice complia',
    `disenrollment_id` BIGINT COMMENT 'Foreign key linking to member.disenrollment. Business justification: COBRA continuation is triggered by a qualifying disenrollment event (loss of employer-sponsored coverage). Linking cobra_continuant to the triggering disenrollment record via disenrollment_id establis',
    `group_id` BIGINT COMMENT 'Identifier of the employer group that sponsored the original coverage.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan under which COBRA coverage is provided.',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is the COBRA continuant.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: A COBRA continuant record represents continuation of a specific policy after loss of employer-sponsored coverage. Linking cobra_continuant to policy via policy_id enables traceability to the underlyin',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: COBRA administration requires knowing which provider network the continuant is enrolled in for member communications, directory access, and care coordination during continuation coverage. COBRA system',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: COBRA eligibility is triggered by qualifying life events. cobra_continuant has denormalized qualifying_event_type and qualifying_event_date but no FK to the QLE record. Linking to qualifying_life_even',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: COBRA premiums are calculated as 102% of the applicable plan rate per ERISA. Linking cobra_continuant to the specific plan.rate record enables COBRA premium notice accuracy, regulatory audit trails, a',
    `tpa_arrangement_id` BIGINT COMMENT 'Foreign key linking to employer.tpa_arrangement. Business justification: COBRA administration for self-funded groups is governed by the TPA arrangement, which defines premium billing, stop-loss coverage, and administrative fees. COBRA administrators need this link to apply',
    `transaction_id` BIGINT COMMENT 'Identifier of the original enrollment that triggered COBRA eligibility.',
    `cobra_continuant_status` STRING COMMENT 'Current lifecycle status of the COBRA coverage.. Valid values are `active|inactive|terminated|expired|pending`',
    `cobra_eligibility_indicator` BOOLEAN COMMENT 'Flag indicating whether the member is eligible for COBRA coverage.',
    `cobra_eligibility_reason` STRING COMMENT 'Free‑text explanation for eligibility determination.',
    `cobra_notice_sent_date` DATE COMMENT 'Date the required COBRA notice was mailed or emailed to the member.',
    `cobra_notice_type` STRING COMMENT 'Classification of the notice (e.g., initial election notice, reminder, final notice).. Valid values are `initial|reminder|final`',
    `coverage_end_date` DATE COMMENT 'Date coverage under COBRA ends, either by max period or termination.',
    `coverage_start_date` DATE COMMENT 'Date coverage under COBRA begins.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COBRA continuant record was first created.',
    `election_date` DATE COMMENT 'Date the member elected to continue coverage under COBRA.',
    `election_deadline` DATE COMMENT 'Last date by which the member must elect COBRA coverage.',
    `exhaustion_date` DATE COMMENT 'Date when coverage was exhausted due to reaching the maximum period.',
    `is_exhausted` BOOLEAN COMMENT 'True when the maximum COBRA coverage period has been reached.',
    `max_coverage_end_date` DATE COMMENT 'Calculated date when the maximum allowable COBRA period expires.',
    `max_coverage_months` STRING COMMENT 'Maximum number of months the member may receive COBRA coverage (e.g., 18, 29, 36).',
    `member_relationship` STRING COMMENT 'Relationship of the continuant to the primary employee (e.g., employee, spouse, child).. Valid values are `employee|spouse|child|parent|other`',
    `notes` STRING COMMENT 'Free‑text field for any additional comments or audit notes.',
    `payment_frequency` STRING COMMENT 'How often the premium is billed.. Valid values are `monthly|quarterly|annual`',
    `payment_method` STRING COMMENT 'Method used to collect the COBRA premium.. Valid values are `auto_debit|check|credit_card|other`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount (typically 102% of the group rate).',
    `premium_currency` STRING COMMENT 'Currency code for the premium amount.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `premium_due_date` DATE COMMENT 'Date by which the premium must be paid for the coverage month.',
    `premium_payment_date` DATE COMMENT 'Date the premium payment was actually received.',
    `premium_payment_status` STRING COMMENT 'Current status of premium payment for the coverage period.. Valid values are `paid|unpaid|partial|overdue`',
    `termination_date` DATE COMMENT 'Date when COBRA coverage was terminated before the scheduled end.',
    `termination_reason` STRING COMMENT 'Reason for early termination of COBRA coverage, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_cobra_continuant PRIMARY KEY(`cobra_continuant_id`)
) COMMENT 'Manages COBRA continuation coverage records for members who have lost employer-sponsored coverage due to qualifying events. Tracks qualifying event type (termination, reduction in hours, divorce, death, Medicare entitlement, dependent status loss), COBRA election date, election deadline, coverage start and end dates, maximum coverage period (18/29/36 months), premium amount (102% of group rate), payment status, and exhaustion date. Supports COBRA notice generation, election tracking, premium payment monitoring, and qualifying event triggering for the billing domain.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`pcp_assignment` (
    `pcp_assignment_id` BIGINT COMMENT 'Primary key for pcp_assignment',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: PCP assignment requirements vary by benefit package (HMO vs. PPO tiers within the same health plan). PCP panel management, prior-auth workflows, and network adequacy reporting require knowing which be',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: PCP assignments drive capitation payments — the assigned PCPs capitation arrangement determines the PMPM rate. Health plan finance teams require pcp_assignment → capitation_arrangement to generate ac',
    `contract_network_participation_id` BIGINT COMMENT 'Foreign key linking to contract.network_participation. Business justification: PCP assignment validation requires confirming the providers active network participation record, including pcp_assignment_eligible_flag and accepting_new_patients_flag. Health plan enrollment systems',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: PCP assignments are valid only during active eligibility periods — an HMO or POS member must have active coverage for a PCP assignment to be meaningful. Linking pcp_assignment to member_eligibility_sp',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom the PCP is assigned.',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: PCP assignment validation requires the specific network_provider participation record to check panel_status, accepting_new_patients_flag, and tier designation — not just provider identity and network ',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: REQUIRED: PCP assignment records must reference the provider entity to support network participation audits and accurate provider‑member linkage.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: PCP assignments are made to a provider at a specific practice location. Network adequacy reporting, member directory display, and care coordination workflows all require knowing which physical locatio',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required for compliance check that a PCP assignment respects an active provider contract; ensures network participation rules are enforced during PCP selection.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the PCP belongs.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Tiered network PCP assignments drive cost-sharing differentials (copay, coinsurance) for members. The plain-text network_tier column is a denormalization of network.tier. Linking to tier_id enables ac',
    `assignment_reason` STRING COMMENT 'Free‑text explanation for why the PCP was assigned (e.g., member request, network requirement).',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the PCP assignment.. Valid values are `active|inactive|pending|terminated`',
    `assignment_type` STRING COMMENT 'Method by which the PCP was assigned: member‑selected, auto‑assigned by system, or plan‑assigned.. Valid values are `member_selected|auto_assigned|plan_assigned`',
    `change_reason` STRING COMMENT 'Reason for a change to the PCP assignment (e.g., member relocation, provider departure).',
    `change_timestamp` TIMESTAMP COMMENT 'Exact time when the most recent change to the assignment was recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the PCP assignment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the PCP assignment becomes effective for the member.',
    `is_current` BOOLEAN COMMENT 'True if the assignment is the active PCP for the member at query time.',
    `is_primary` BOOLEAN COMMENT 'Indicates if this PCP is the members primary provider when multiple assignments exist.',
    `notes` STRING COMMENT 'Additional free‑form comments or audit notes about the assignment.',
    `panel_status` STRING COMMENT 'Indicates whether the PCP is currently in the members provider panel.. Valid values are `in_panel|out_of_panel|pending`',
    `pcp_specialty_code` STRING COMMENT 'Standardized code representing the PCPs clinical specialty.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the assignment data.. Valid values are `Facets|Cactus|RxClaim|InterQual|Casenet|HealthEdge`',
    `termination_date` DATE COMMENT 'Date when the PCP assignment ends or is scheduled to end; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the PCP assignment record.',
    CONSTRAINT pk_pcp_assignment PRIMARY KEY(`pcp_assignment_id`)
) COMMENT 'Tracks Primary Care Provider (PCP) assignments for members enrolled in HMO, POS, and other gatekeeper plan types. Records assigned PCP NPI, PCP effective and termination dates, assignment type (member-selected, auto-assigned, plan-assigned), PCP change reason, PCP panel status at time of assignment, and PCP network tier. Manages PCP change request history and auto-assignment rules for newborns and new enrollees. Used for care coordination, referral authorization, capitation payment calculation, and HEDIS PCP attribution. Integrates with provider and network domains.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`cob_record` (
    `cob_record_id` BIGINT COMMENT 'Primary key for cob_record',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Coordination of Benefits records are applicable during specific eligibility periods — COB rules (birthday rule, MSP compliance) apply to a members active coverage span. Linking cob_record to member_e',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member to whom this COB record belongs.',
    `birthday_rule_applicable` BOOLEAN COMMENT 'Indicates whether the birthday rule is used to determine primary payer.',
    `cob_order` STRING COMMENT 'Sequencing of the carrier in the coordination of benefits hierarchy.. Valid values are `primary|secondary|tertiary`',
    `cob_record_number` STRING COMMENT 'Business identifier assigned to the COB record for external reference.',
    `cob_status` STRING COMMENT 'Current lifecycle status of the COB record.. Valid values are `active|inactive|pending|terminated`',
    `cob_verification_date` DATE COMMENT 'Date when the COB information was verified.',
    `coordination_of_benefits_rule` STRING COMMENT 'Rule applied to determine payer order (e.g., birthday rule).. Valid values are `birthday|plan|state|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COB record was first created in the data lake.',
    `effective_date` DATE COMMENT 'Date the COB coverage becomes effective.',
    `is_msp_compliant` BOOLEAN COMMENT 'Indicates compliance with Medicare Secondary Payer rules.',
    `is_subrogation_flag` BOOLEAN COMMENT 'True if the claim may be subject to subrogation based on this COB arrangement.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the COB arrangement.',
    `policy_type` STRING COMMENT 'Classification of the other carrier policy.. Valid values are `commercial|medicare|medicaid|auto|workers_comp|other`',
    `source_system` STRING COMMENT 'System of record that originated the COB data. [ENUM-REF-CANDIDATE: Facets|QNXT|Cactus|ProviderSource|RxClaim|Argus|InterQual|MCG|Casenet|TruCare|Altruista|Salesforce|Pega|HealthEdge|CustomBilling|OracleFinancials|Milliman|Availity|ChangeHealthcare|Snowflake — promote to reference product]',
    `termination_date` DATE COMMENT 'Date the COB coverage ends or is terminated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COB record.',
    `verification_method` STRING COMMENT 'Method used to verify the COB information.. Valid values are `manual|electronic|auto`',
    CONSTRAINT pk_cob_record PRIMARY KEY(`cob_record_id`)
) COMMENT 'Coordination of Benefits (COB) record tracking a members other insurance coverage to prevent duplicate payment and ensure correct primary/secondary/tertiary payer sequencing. Captures other carrier name, other carrier member ID, other carrier group number, policy type (commercial, Medicare, Medicaid, auto, workers comp), COB order (primary/secondary/tertiary), effective and termination dates, birthday rule applicability, and COB verification date. Supports COB inquiry workflows, subrogation identification, and Medicare Secondary Payer (MSP) compliance. Used by claims adjudication for COB calculation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`consent` (
    `consent_id` BIGINT COMMENT 'Primary key for consent',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: HIPAA and 42 CFR Part 2 consent records frequently name a specific provider as the authorized recipient of PHI disclosures. Compliance audits and authorization tracking require a structured FK to the ',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Care program enrollment requires documented member consent (HIPAA, state regulations). care_enrollment tracks consent_status as a flag but has no FK to the actual consent record. This link enables con',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: HIPAA and 42 CFR Part 2 require documented consent records linked to care coordination activities. Care plans require explicit consent for sharing PHI among care team members. This FK enables complian',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: HIPAA BAA and 42 CFR Part 2 regulations require member consent records to be tied to the delegation agreement under which a delegated entity handles member data. Compliance audits and regulatory filin',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member providing consent.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: HIPAA consent and authorization records (42 CFR Part 2, state privacy laws) are often scoped to a specific policy or coverage period. Linking consent to policy via policy_id enables consent records to',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Consent records (electronic communication consent, 42 CFR Part 2, HIPAA authorizations) are frequently captured during enrollment transactions. Linking consent to the enrollment transaction supports H',
    `authorized_recipient` STRING COMMENT 'Entity or individual authorized to receive the disclosed PHI.',
    `collection_method` STRING COMMENT 'Method used to collect the consent from the member.. Valid values are `written|electronic|verbal|attested`',
    `consent_date` DATE COMMENT 'Date when the consent was originally obtained.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent.. Valid values are `active|revoked|expired|pending|withdrawn`',
    `consent_type` STRING COMMENT 'Category of consent indicating purpose of authorized disclosure.. Valid values are `phid_disclosure|release_of_information|marketing_opt_in|research_participation|care_management|advance_directive`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `disclosure_scope` STRING COMMENT 'Description of the data elements or categories covered by the consent.',
    `effective_date` DATE COMMENT 'Date when the consent becomes effective for use.',
    `expiration_date` DATE COMMENT 'Date when the consent expires if not renewed.',
    `is_42cfr_part2_applicable` BOOLEAN COMMENT 'Flag indicating if the consent is subject to 42 CFR Part 2 substance abuse privacy rules.',
    `is_electronic_signature` BOOLEAN COMMENT 'Indicates if the consent was captured with an electronic signature.',
    `is_minimum_necessary` BOOLEAN COMMENT 'Indicates whether the consent adheres to the HIPAA minimum necessary standard.',
    `language` STRING COMMENT 'Language in which the consent was provided.',
    `notes` STRING COMMENT 'Free-text notes related to the consent record.',
    `revocation_date` DATE COMMENT 'Date when the consent was revoked by the member.',
    `signature_timestamp` TIMESTAMP COMMENT 'Timestamp of the electronic signature capture.',
    `source_system` STRING COMMENT 'Source system where the consent record originated (e.g., member portal, call center).',
    `state_of_residence` STRING COMMENT 'State code of the members residence at time of consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `version` STRING COMMENT 'Version number of the consent document for audit tracking.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Manages member consent and authorization records required under HIPAA Privacy Rule and state privacy laws. Tracks consent type (PHI disclosure authorization, ROI — Release of Information, marketing opt-in, research participation, care management program enrollment consent, advance directive), consent status (active, revoked, expired), consent date, expiration date, authorized recipient, scope of disclosure, revocation date, and consent collection method (written, electronic, verbal with attestation). Supports HIPAA minimum necessary standard, 42 CFR Part 2 (substance abuse), and state mental health privacy requirements.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`disenrollment` (
    `disenrollment_id` BIGINT COMMENT 'Primary key for disenrollment',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan the member was enrolled in before disenrollment.',
    `disenrollment_new_plan_health_plan_id` BIGINT COMMENT 'Identifier of a new plan if the member re‑enrolls immediately after disenrollment.',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.group. Business justification: Disenrollment events are triggered by employment termination or group contract termination, requiring direct group association for COBRA notification, ERISA compliance reporting, and group-level disen',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: A disenrollment event terminates a specific eligibility span. Linking disenrollment to member_eligibility_span via member_eligibility_span_id identifies precisely which coverage period is being termin',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member who is being disenrolled.',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: Many disenrollments are triggered by qualifying life events (loss of other coverage, death, relocation). Linking disenrollment to the QLE supports SEP/QLE audit trails, CMS regulatory reporting of inv',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.transaction. Business justification: Every disenrollment generates an enrollment transaction record for processing. Linking disenrollment to its driving transaction supports enrollment transaction reconciliation, regulatory termination r',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Care transition compliance: when a member disenrolls, open UM cases must be identified, closed, or transitioned to the new plan. Regulatory requirements mandate notifying providers of authorization st',
    `appeal_rights_notified` BOOLEAN COMMENT 'Indicates whether the member was notified of appeal rights.',
    `cobro_eligibility` BOOLEAN COMMENT 'Flag indicating if the member qualifies for COBRA continuation coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disenrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for any monetary amounts.',
    `disenrollment_number` STRING COMMENT 'Business identifier assigned to the disenrollment event, used for external reporting and audit.',
    `disenrollment_status` STRING COMMENT 'Current processing status of the disenrollment request.. Valid values are `pending|processed|cancelled|reversed`',
    `effective_timestamp` TIMESTAMP COMMENT 'Date and time when the disenrollment becomes effective for coverage purposes.',
    `eligibility_loss_indicator` BOOLEAN COMMENT 'True if disenrollment is due to loss of eligibility.',
    `notice_sent_date` DATE COMMENT 'Date the required notice of disenrollment was sent to the member.',
    `processed_by` STRING COMMENT 'User or system identifier that processed the disenrollment.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date and time when the disenrollment was processed.',
    `reason_code` STRING COMMENT 'Standardized code representing why the member is disenrolling.. Valid values are `voluntary|non_payment|eligibility_loss|plan_termination|death|fraud`',
    `reason_description` STRING COMMENT 'Free‑text description of the disenrollment reason.',
    `refund_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments (e.g., fees, penalties) applied to the gross refund.',
    `refund_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount refunded to the member as part of disenrollment.',
    `refund_net_amount` DECIMAL(18,2) COMMENT 'Net amount actually paid to the member after adjustments.',
    `request_date` DATE COMMENT 'Date the member or source submitted the disenrollment request.',
    `source` STRING COMMENT 'Origin of the disenrollment request.. Valid values are `member|employer|cms|state_medicaid|provider`',
    `termination_type` STRING COMMENT 'Classification of the disenrollment termination.. Valid values are `voluntary|involuntary|death|fraud|relocation|plan_termination`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the disenrollment record.',
    CONSTRAINT pk_disenrollment PRIMARY KEY(`disenrollment_id`)
) COMMENT 'Captures the formal disenrollment event when a member voluntarily or involuntarily terminates health plan coverage. Records disenrollment effective date, disenrollment reason code (voluntary termination, non-payment of premium, loss of eligibility, plan termination, death, fraud, relocation out of service area), disenrollment request date, source of disenrollment (member request, employer group, CMS, state Medicaid agency), notice sent date, and appeal rights notification. Supports CMS disenrollment reporting for Medicare Advantage, Medicaid managed care disenrollment rules, and COBRA qualifying event triggering.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`member_enrollment` (
    `member_enrollment_id` BIGINT COMMENT 'Primary key for the enrollment association',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Member enrollment in benefit programs is division-specific — different divisions have distinct benefit packages, FSA/HSA eligibility, and subsidy rules. Benefits administrators manage enrollment by di',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Member enrollment in a care program (disease management, wellness, care coordination) is only valid during an active eligibility span. Linking member_enrollment to member_eligibility_span via member_e',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to subscriber',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Member enrollments are initiated during open enrollment periods. Direct FK supports open enrollment volume reporting, regulatory compliance tracking, and annual enrollment analytics — health plan oper',
    `open_enrollment_window_id` BIGINT COMMENT 'Foreign key linking to employer.open_enrollment_window. Business justification: Member enrollment events must be validated against the employers active open enrollment window. Enrollment operations teams enforce that plan elections occur within the windows start/end dates and s',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Member enrollment records are created as a result of plan elections. Linking member_enrollment to the driving plan_election supports open enrollment audit trails, enrollment processing reconciliation,',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Care program enrollment is governed by the members active policy — program eligibility rules, benefit coverage for care management services, and enrollment periods are all policy-dependent. Linking m',
    `program_id` BIGINT COMMENT 'Foreign key linking to care program',
    `qualifying_life_event_id` BIGINT COMMENT 'Foreign key linking to enrollment.qualifying_life_event. Business justification: SEP enrollments are triggered by qualifying life events. Linking member_enrollment to the QLE supports CMS SEP audit requirements, special enrollment period reporting, and verification that SEP enroll',
    `effective_end_date` DATE COMMENT 'Date when the enrollment ends or is terminated',
    `effective_start_date` DATE COMMENT 'Date when the enrollment becomes effective',
    `enrollment_number` STRING COMMENT 'Unique identifier for the enrollment record',
    `enrollment_status` STRING COMMENT 'Current status of the enrollment (e.g., active, terminated)',
    `enrollment_type` STRING COMMENT 'Classification of enrollment (e.g., mandatory, optional)',
    `reason` STRING COMMENT 'Reason for enrollment, often derived from eligibility criteria',
    CONSTRAINT pk_member_enrollment PRIMARY KEY(`member_enrollment_id`)
) COMMENT 'This association product represents the enrollment contract between a subscriber and a care program. It captures enrollment-specific data such as enrollment number, status, effective dates, type, and reason. Each record links one subscriber to one care program.. Existence Justification: Subscribers can enroll in multiple care programs and each care program can have many subscribers. The enrollment is an operational record that is created, updated, and deleted by staff and includes attributes such as enrollment dates, status, type, and reason. The business treats enrollment as a distinct entity (Enrollment) that is queried and reported on.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`member`.`policy` (
    `policy_id` BIGINT COMMENT 'Primary key for policy',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: A policys cost-sharing structure (deductible, OOP max, copays) is defined by the benefit_package. Policy administration and claims adjudication require this direct reference. deductible_amount, deduc',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: A policy defines the members pharmacy benefit terms, including which formulary governs drug coverage. Health insurance operations require this link for member-facing benefit communications, EOB gener',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: A member policy is issued under a specific employer group plan offering that defines contribution amounts, plan year, open enrollment dates, and waiver criteria. Premium reconciliation, renewal proces',
    `health_plan_id` BIGINT COMMENT 'Reference to the plan or product associated with the policy.',
    `identity_id` BIGINT COMMENT 'Reference to the insured member associated with the policy.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: ACA compliance reporting and open enrollment volume tracking require knowing which open enrollment period produced each policy. Regulators and actuaries use this link for annual enrollment analytics, ',
    `parent_policy_id` BIGINT COMMENT 'Self-referencing FK on policy (parent_policy_id)',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: A policy is always bound to a specific provider network; claims adjudication, member ID card generation, and EOB production all require the network tied to the policy. Domain experts expect policy to ',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Member policies are governed by reimbursement policies defining adjudication rules (NCCI edits, global surgery periods, max procedures). Claims operations teams require policy → reimbursement_policy t',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to member.subscriber. Business justification: Policy is a child of subscriber; adding subscriber_id FK establishes the 1:N relationship and removes the silo.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: The policy defines the purchased network tier level (e.g., Tier 1 vs Tier 2 plan), which drives premium calculation, benefit structure, and SBC disclosure. This is distinct from the eligibility span t',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Policies are scoped to a plan year, which governs accumulator reset dates, open enrollment rules, and ACA regulatory filing requirements. Direct year_id on policy enables plan-year reporting, accumula',
    `coverage_end_date` DATE COMMENT 'Date when coverage under the policy ends.',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary limit for covered services under the policy.',
    `coverage_limit_currency` STRING COMMENT 'Currency code for the coverage limit amount.',
    `coverage_limit_type` STRING COMMENT 'Scope of the coverage limit (e.g., lifetime, annual).',
    `coverage_start_date` DATE COMMENT 'Date when coverage under the policy begins.',
    `coverage_status` STRING COMMENT 'Current status of the coverage portion of the policy.',
    `coverage_type` STRING COMMENT 'Type of coverage plan (e.g., HMO, PPO).',
    `effective_date` DATE COMMENT 'Date when the policy becomes effective.',
    `expiration_date` DATE COMMENT 'Date when the policy expires if not renewed.',
    `policy_number` STRING COMMENT 'Human-readable policy number assigned by the insurer.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy.',
    `policy_type` STRING COMMENT 'Classification of the policy based on the insured entity type.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Amount to be paid for the policy coverage.',
    `premium_currency` STRING COMMENT 'Currency code for the premium amount.',
    `premium_frequency` STRING COMMENT 'Frequency at which the premium is billed.',
    `renewal_amount` DECIMAL(18,2) COMMENT 'Total amount paid for the policy renewal.',
    `renewal_currency` STRING COMMENT 'Currency code for the renewal amount.',
    `renewal_date` DATE COMMENT 'Date when the policy renewal was processed.',
    `renewal_deductible_amount` DECIMAL(18,2) COMMENT 'Deductible portion of the renewal payment.',
    `renewal_deductible_currency` STRING COMMENT 'Currency code for the renewal deductible amount.',
    `renewal_out_of_pocket_max_amount` DECIMAL(18,2) COMMENT 'Out-of-pocket maximum for the renewal period.',
    `renewal_out_of_pocket_max_currency` STRING COMMENT 'Currency code for the renewal out-of-pocket maximum amount.',
    `renewal_premium_amount` DECIMAL(18,2) COMMENT 'Premium portion of the renewal payment.',
    `renewal_premium_currency` STRING COMMENT 'Currency code for the renewal premium amount.',
    `renewal_status` STRING COMMENT 'Current status of the policy renewal process.',
    `termination_date` DATE COMMENT 'Date when the policy was terminated.',
    `termination_reason` STRING COMMENT 'Reason for policy termination.',
    CONSTRAINT pk_policy PRIMARY KEY(`policy_id`)
) COMMENT 'Master reference table for policy. Referenced by policy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ADD CONSTRAINT `fk_member_subscriber_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `health_insurance_ecm`.`member`.`contact`(`contact_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_address_id` FOREIGN KEY (`address_id`) REFERENCES `health_insurance_ecm`.`member`.`address`(`address_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `health_insurance_ecm`.`member`.`contact`(`contact_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ADD CONSTRAINT `fk_member_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_address_id` FOREIGN KEY (`address_id`) REFERENCES `health_insurance_ecm`.`member`.`address`(`address_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ADD CONSTRAINT `fk_member_identity_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`address` ADD CONSTRAINT `fk_member_address_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ADD CONSTRAINT `fk_member_member_eligibility_span_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_disenrollment_id` FOREIGN KEY (`disenrollment_id`) REFERENCES `health_insurance_ecm`.`member`.`disenrollment`(`disenrollment_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ADD CONSTRAINT `fk_member_cobra_continuant_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ADD CONSTRAINT `fk_member_pcp_assignment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ADD CONSTRAINT `fk_member_cob_record_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ADD CONSTRAINT `fk_member_consent_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ADD CONSTRAINT `fk_member_disenrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_member_eligibility_span_id` FOREIGN KEY (`member_eligibility_span_id`) REFERENCES `health_insurance_ecm`.`member`.`member_eligibility_span`(`member_eligibility_span_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ADD CONSTRAINT `fk_member_member_enrollment_policy_id` FOREIGN KEY (`policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_identity_id` FOREIGN KEY (`identity_id`) REFERENCES `health_insurance_ecm`.`member`.`identity`(`identity_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_parent_policy_id` FOREIGN KEY (`parent_policy_id`) REFERENCES `health_insurance_ecm`.`member`.`policy`(`policy_id`);
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ADD CONSTRAINT `fk_member_policy_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `health_insurance_ecm`.`member`.`subscriber`(`subscriber_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`member` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `health_insurance_ecm`.`member` SET TAGS ('dbx_domain' = 'member');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Coordinator Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Annual Income');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_business_glossary_term' = 'CHIP Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `chip_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent_resident|non_resident|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `consent_to_electronic_communication` SET TAGS ('dbx_business_glossary_term' = 'Electronic Communication Consent');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'hmo|ppo|epo|pos|hdhp|hsa');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'yes|no|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|agent|mail|broker');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC) Score');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `hcc_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `is_deceased` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (Family Name)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip|group|individual');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Marital Status');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `medicare_beneficiary_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|portal');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Race/Ethnicity');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_value_regex' = 'white|black|asian|hispanic|native_american|other');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `race_ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^(d{3}-d{2}-d{4})$');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Number (Policy Number)');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `subscriber_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Status');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `subscriber_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Status');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `tobacco_use_status` SET TAGS ('dbx_value_regex' = 'current|former|never|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`subscriber` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Member Address Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Member Contact Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Member Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `age_out_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Age-Out Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `chip_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'CHIP Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Dependent Date of Birth (DOB)');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent First Name');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Dependent Gender');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Last Name');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `medicaid_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Middle Name');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|archived');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Dependent Relationship Type');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'spouse|domestic_partner|child|other');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Dependent Sequence Number');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_business_glossary_term' = 'Student Status');
ALTER TABLE `health_insurance_ecm`.`member`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Identity Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Assigned Member Identifier (Member ID)');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Member Citizenship Status');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|non_citizen|permanent_resident|temporary_resident|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Member Date of Birth');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Status');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Member Email Address');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_business_glossary_term' = 'Member Ethnicity');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `ethnicity` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_business_glossary_term' = 'External Subscriber Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `external_subscriber_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Member First Name');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Member Full Legal Name');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Member Gender');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Member Preferred Language');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Member Last Name');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip|group');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Member Marital Status');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|divorced|widowed|separated|unknown');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_business_glossary_term' = 'Member Lifecycle Status');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `member_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|suspended|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('dbx_business_glossary_term' = 'Member Type (Subscriber or Dependent)');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `member_type` SET TAGS ('dbx_value_regex' = 'subscriber|dependent|spouse|child|other');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Member Middle Name');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Member Phone Number');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `race` SET TAGS ('dbx_business_glossary_term' = 'Member Race');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT|Custom');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number Hash');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `ssn_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Date');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `health_insurance_ecm`.`member`.`identity` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|failed');
ALTER TABLE `health_insurance_ecm`.`member`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`address` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Member Address ID');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract Code');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_value_regex' = '^d{11}$');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `census_tract` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Address Change Reason');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `county_fips` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `external_code` SET TAGS ('dbx_business_glossary_term' = 'External Address ID');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `geocode_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (Meters)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Street Address)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Apartment/Suite)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_business_glossary_term' = 'Address Line 4');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `line4` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `member_address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code (Postal Code)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code (US Postal)');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `health_insurance_ecm`.`member`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` SET TAGS ('dbx_subdomain' = 'member_identity');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Member Contact Identifier (MCID)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_business_glossary_term' = 'CASS Certified Flag (CASS)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_cass_certified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date (AED)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Geocode Accuracy (GEO_ACC)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_accuracy` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_business_glossary_term' = 'Geocode Source (GEO_SRC)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_value_regex' = 'USPS|Google|HERE|Other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_geocode_source` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Address Priority Rank (APR)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_priority_rank` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_business_glossary_term' = 'Address Source System (ASS)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT|CRM|Other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_source_system` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Address Termination Date (ATD)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_termination_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type (AT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'home|mailing|temporary|employer|other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status (AVS)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract (CT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name (CFN)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type (CT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'member|dependent|beneficiary|employer|provider|other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `county_fips` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code (FIPS)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number (FAX)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier Type (CID_TYPE)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `id_type` SET TAGS ('dbx_value_regex' = 'NPI|SSN|MemberID|Other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier Value (CID_VAL)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `id_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag (PRIMARY)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|zh|other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Timestamp (LVT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `member_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (CSTAT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `member_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes (CNOTES)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_business_glossary_term' = 'Email Opt‑In Flag (EMAIL_OPT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `opt_in_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `opt_in_robocall` SET TAGS ('dbx_business_glossary_term' = 'Robocall Opt‑In Flag (RC_OPT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `opt_in_sms` SET TAGS ('dbx_business_glossary_term' = 'SMS Opt‑In Flag (SMS_OPT)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_business_glossary_term' = 'Home Phone Number (HPN)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_home` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number (MPN)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_mobile` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (WPN)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `phone_work` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PCM)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|sms');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship (CREL)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `relationship` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|guardian|other');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (ST)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `tcp_a_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'TCPA Consent Flag (TCPA)');
ALTER TABLE `health_insurance_ecm`.`member`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `um_program_id` SET TAGS ('dbx_business_glossary_term' = 'Um Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `cobro_end_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA End Date');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `cobro_start_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Start Date');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx|wellness');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `eligibility_source` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Source');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `eligibility_source` SET TAGS ('dbx_value_regex' = '834|manual|cms|portal');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'active|terminated|suspended|cobra|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'new|renewal|change|reinstatement');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `gap_in_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap In Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `is_primary_coverage` SET TAGS ('dbx_business_glossary_term' = 'Primary Coverage Indicator');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|chip');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `retroactive_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `subscriber_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Relationship Code (SRC)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `subscriber_relationship_code` SET TAGS ('dbx_value_regex' = 'self|spouse|child|parent|other');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Termination Date');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code (TRC)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'member_request|non_payment|plan_change|death|other');
ALTER TABLE `health_insurance_ecm`.`member`.`member_eligibility_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_continuant_id` SET TAGS ('dbx_business_glossary_term' = 'COBRA Continuant Identifier (CCID)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_election_id` SET TAGS ('dbx_business_glossary_term' = 'Cobra Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `disenrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Identifier (EGID)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (PID)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MID)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier (EID)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_continuant_status` SET TAGS ('dbx_business_glossary_term' = 'COBRA Coverage Status (CCS)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_continuant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|expired|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_eligibility_indicator` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Indicator (CEI)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Reason (CER)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Notice Sent Date (CNSD)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_notice_type` SET TAGS ('dbx_business_glossary_term' = 'COBRA Notice Type (CNT)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `cobra_notice_type` SET TAGS ('dbx_value_regex' = 'initial|reminder|final');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date (CED)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date (CSD)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Date (CED)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `election_deadline` SET TAGS ('dbx_business_glossary_term' = 'COBRA Election Deadline (CEDL)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `exhaustion_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Exhaustion Date (CED)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `is_exhausted` SET TAGS ('dbx_business_glossary_term' = 'Coverage Exhausted Indicator (CEI)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `max_coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Maximum Coverage Exhaustion Date (MCED)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `max_coverage_months` SET TAGS ('dbx_business_glossary_term' = 'Maximum Coverage Months (MCM)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `member_relationship` SET TAGS ('dbx_business_glossary_term' = 'Member Relationship (MR)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `member_relationship` SET TAGS ('dbx_value_regex' = 'employee|spouse|child|parent|other');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes (AN)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency (PF)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PM)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'auto_debit|check|credit_card|other');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'COBRA Premium Amount (CPA)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency (PC)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_due_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Due Date (PDD)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Date (PPD)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status (PPS)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|overdue');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date (CTD)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Reason (CTR)');
ALTER TABLE `health_insurance_ecm`.`member`.`cobra_continuant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` SET TAGS ('dbx_subdomain' = 'care_benefits');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `pcp_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Assignment Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `contract_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID (Member Identifier)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Reason');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Status');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider Assignment Type');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'member_selected|auto_assigned|plan_assigned');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'PCP Change Reason');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PCP Change Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Assignment Start Date)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Current Assignment Indicator');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary PCP Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Panel Status');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'in_panel|out_of_panel|pending');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `pcp_specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Code (CPT/HCPCS)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Facets|Cactus|RxClaim|InterQual|Casenet|HealthEdge');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Assignment End Date)');
ALTER TABLE `health_insurance_ecm`.`member`.`pcp_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` SET TAGS ('dbx_subdomain' = 'care_benefits');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_record_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Record Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('dbx_business_glossary_term' = 'Birthday Rule Applicability');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `birthday_rule_applicable` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_order` SET TAGS ('dbx_business_glossary_term' = 'COB Order');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_order` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_record_number` SET TAGS ('dbx_business_glossary_term' = 'COB Record Number');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'COB Status');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `cob_verification_date` SET TAGS ('dbx_business_glossary_term' = 'COB Verification Date');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `coordination_of_benefits_rule` SET TAGS ('dbx_business_glossary_term' = 'COB Rule Type');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `coordination_of_benefits_rule` SET TAGS ('dbx_value_regex' = 'birthday|plan|state|other');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `is_msp_compliant` SET TAGS ('dbx_business_glossary_term' = 'MSP Compliance Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `is_subrogation_flag` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'COB Notes');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type (COB)');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|auto|workers_comp|other');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `health_insurance_ecm`.`member`.`cob_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'manual|electronic|auto');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` SET TAGS ('dbx_subdomain' = 'care_benefits');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recipient Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `authorized_recipient` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recipient');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'written|electronic|verbal|attested');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired|pending|withdrawn');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'phid_disclosure|release_of_information|marketing_opt_in|research_participation|care_management|advance_directive');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `disclosure_scope` SET TAGS ('dbx_business_glossary_term' = 'Scope of Disclosure');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `is_42cfr_part2_applicable` SET TAGS ('dbx_business_glossary_term' = '42 CFR Part 2 Applicability');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `is_electronic_signature` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `is_minimum_necessary` SET TAGS ('dbx_business_glossary_term' = 'Minimum Necessary Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Consent Source System');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('dbx_business_glossary_term' = 'Member State of Residence');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `state_of_residence` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Plan ID');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_new_plan_health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'New Plan ID');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_new_plan_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_new_plan_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `appeal_rights_notified` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Notified');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `cobro_eligibility` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Number');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Status');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `disenrollment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cancelled|reversed');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Effective Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `eligibility_loss_indicator` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Loss Indicator');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Notice Sent Date');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `processed_by` SET TAGS ('dbx_business_glossary_term' = 'Processed By');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason Code');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'voluntary|non_payment|eligibility_loss|plan_termination|death|fraud');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Reason Description');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Gross Amount');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Net Amount');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `refund_net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Request Date');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Disenrollment Source');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'member|employer|cms|state_medicaid|provider');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|death|fraud|relocation|plan_termination');
ALTER TABLE `health_insurance_ecm`.`member`.`disenrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Enrollment Id');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Member Subscriber Id');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `open_enrollment_window_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Window Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Care Program Id');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `qualifying_life_event_id` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective End Date');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `health_insurance_ecm`.`member`.`member_enrollment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Reason');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` SET TAGS ('dbx_subdomain' = 'enrollment_coverage');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `parent_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`member`.`policy` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
