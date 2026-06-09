-- Schema for Domain: agent | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`agent` COMMENT 'SSOT for all distribution channel participants — captive agents, independent agents, BGAs, MGAs, GAs, and broker-dealers. Owns agent licensing and appointment records, hierarchy management, E&O coverage, FINRA registration for variable product sales, contracting status, producer onboarding, production metrics, and POS system integration. Supports multi-level distribution hierarchy modeling and channel performance tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`producer` (
    `producer_id` BIGINT COMMENT 'Unique identifier for the producer. Primary key for the producer entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Producers generate commission expenses and overhead costs that must be allocated to cost centers for distribution channel profitability analysis, expense management, and producer P&L reporting—standar',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Captive agents and internal wholesalers are employees. Required for: integrated compensation reporting, performance review coordination, HR policy application, benefits eligibility, and workforce plan',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Producers are contracted to specific legal entities for commission payment processing, 1099 tax reporting, state licensing compliance, and statutory financial reporting—fundamental requirement for pro',
    `parent_producer_id` BIGINT COMMENT 'Identifier of the parent producer in a multi-level distribution hierarchy. Used to model upline relationships for MGAs, GAs, and agency hierarchies.',
    `address_line_1` STRING COMMENT 'First line of the producers primary business or residential address.',
    `address_line_2` STRING COMMENT 'Second line of the producers address for suite, apartment, or unit information.',
    `annual_production_target` DECIMAL(18,2) COMMENT 'Target annual premium production amount assigned to the producer for performance tracking and incentive qualification.',
    `background_check_date` DATE COMMENT 'Date the producers background check was completed.',
    `background_check_status` STRING COMMENT 'Status of the producers background check during onboarding. Used for compliance and risk assessment.. Valid values are `not_started|in_progress|cleared|flagged|failed`',
    `business_name` STRING COMMENT 'Legal business name or DBA name for agency entities such as BGAs, MGAs, GAs, or broker-dealer firms.',
    `city` STRING COMMENT 'City name for the producers primary address.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission rate schedule assigned to this producer. Links to commission rate tables in the commission management system.. Valid values are `^[A-Z0-9]{4,10}$`',
    `contracting_status` STRING COMMENT 'Status of the producers contractual agreement with the carrier. Indicates whether the producer has a valid, signed contract in place.. Valid values are `contracted|not_contracted|pending_contract|contract_expired`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the producers primary address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the producer record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth for individual producers. Used for identity verification and regulatory compliance.',
    `email_address` STRING COMMENT 'Primary email address for producer communication, commission statements, and regulatory notices.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `eo_coverage_indicator` BOOLEAN COMMENT 'Indicates whether the producer has active Errors and Omissions insurance coverage. Required for compliance and risk management.',
    `eo_expiration_date` DATE COMMENT 'Expiration date of the producers Errors and Omissions insurance policy. Monitored for compliance.',
    `eo_policy_number` STRING COMMENT 'Policy number for the producers Errors and Omissions insurance coverage.',
    `finra_crd_number` STRING COMMENT 'FINRA-assigned identifier for broker-dealers and registered representatives authorized to sell variable life insurance and annuity products.. Valid values are `^[0-9]{1,8}$`',
    `first_name` STRING COMMENT 'Legal first name of the producer if the producer is an individual person.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the distribution hierarchy. Level 1 is top-level (e.g., MGA), higher numbers represent downline agents.',
    `hire_date` DATE COMMENT 'Date the producer was hired or appointed by the carrier. Marks the start of the producers relationship with the company.',
    `kyc_status` STRING COMMENT 'Status of the Know Your Customer verification process for the producer. Required for AML compliance.. Valid values are `not_started|in_progress|verified|failed`',
    `kyc_verification_date` DATE COMMENT 'Date the producers KYC verification was completed.',
    `last_name` STRING COMMENT 'Legal last name or surname of the producer if the producer is an individual person.',
    `lifetime_production_amount` DECIMAL(18,2) COMMENT 'Cumulative total premium production amount for the producer since hire date.',
    `middle_name` STRING COMMENT 'Middle name or initial of the producer if the producer is an individual person.',
    `npn` STRING COMMENT 'Unique 10-digit identifier assigned by the NAIC to licensed insurance producers. Used for multi-state licensing and regulatory tracking.. Valid values are `^[0-9]{10}$`',
    `onboarding_stage` STRING COMMENT 'Current stage in the producer onboarding workflow. Tracks progress from initial application through final approval. [ENUM-REF-CANDIDATE: application_submitted|background_check|licensing_verification|contract_review|training|approved|rejected — 7 candidates stripped; promote to reference product]',
    `phone_number` STRING COMMENT 'Primary contact phone number for the producer.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP code or ZIP+4 code for the producers primary address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_language` STRING COMMENT 'Two-letter ISO language code for the producers preferred communication language.. Valid values are `^[a-z]{2}$`',
    `producer_code` STRING COMMENT 'Business identifier assigned to the producer for operational use. Externally-known unique code used in commission systems and policy administration.. Valid values are `^[A-Z0-9]{6,12}$`',
    `producer_status` STRING COMMENT 'Current lifecycle status of the producers relationship with the carrier. Active (currently writing business), Inactive (not writing but relationship intact), Suspended (temporarily restricted), Terminated (relationship ended), Pending (onboarding in progress).. Valid values are `active|inactive|suspended|terminated|pending`',
    `producer_type` STRING COMMENT 'Classification of the producers distribution channel role. Captive Agent (exclusive to one carrier), Independent Agent (represents multiple carriers), BGA (Brokerage General Agency), MGA (Managing General Agent), GA (General Agent), Broker-Dealer (securities-licensed for variable products).. Valid values are `captive_agent|independent_agent|bga|mga|ga|broker_dealer`',
    `state_code` STRING COMMENT 'Two-letter state or territory code for the producers primary address.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal tax identification number for the producer. May be an Employer Identification Number (EIN) for entities or Social Security Number (SSN) for individuals. Used for IRS Form 1099 reporting.. Valid values are `^[0-9]{2}-[0-9]{7}$|^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `termination_date` DATE COMMENT 'Date the producers appointment or contract with the carrier was terminated. Null if the producer is still active.',
    `termination_reason` STRING COMMENT 'Reason for the producers termination. Required for regulatory reporting and compliance tracking.. Valid values are `voluntary_resignation|retirement|performance|compliance_violation|license_revocation|other`',
    `training_completion_date` DATE COMMENT 'Date the producer completed required onboarding and product training.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the producer record was last modified.',
    `ytd_production_amount` DECIMAL(18,2) COMMENT 'Total premium production amount for the producer in the current calendar year. Updated as new business is issued.',
    CONSTRAINT pk_producer PRIMARY KEY(`producer_id`)
) COMMENT 'Master record for all distribution channel participants — captive agents, independent agents, BGAs, MGAs, GAs, and broker-dealers. Serves as the SSOT for producer identity, demographic profile, tax identification (TIN/SSN), producer type classification, contracting status, onboarding stage, and channel affiliation. Sourced from the Agent and Commission Management System (Sapiens Commission / Annocera).';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`license` (
    `license_id` BIGINT COMMENT 'Unique identifier for the insurance producer license record. Primary key.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: State-issued license certificates and renewal confirmations must be retained for regulatory compliance. Appointment processing and DOI audits require production of license certificates. Links license ',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer who holds this license.',
    `appointment_date` DATE COMMENT 'Date when the producer was appointed by the insurance carrier to sell products in the issuing state.',
    `appointment_status` STRING COMMENT 'Status of the producers appointment with the insurance carrier in the issuing state.. Valid values are `appointed|terminated|pending|suspended`',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the producer as part of licensing or renewal requirements.',
    `background_check_status` STRING COMMENT 'Result of the most recent background check for the producer.. Valid values are `passed|failed|pending|waived`',
    `ce_compliance_status` STRING COMMENT 'Indicates whether the producer has met the continuing education requirements for the current renewal cycle.. Valid values are `compliant|non_compliant|pending|exempt`',
    `ce_hours_completed` DECIMAL(18,2) COMMENT 'Total number of continuing education hours completed by the producer toward the current renewal cycle.',
    `ce_hours_required` DECIMAL(18,2) COMMENT 'Total number of continuing education hours required by the issuing state for license renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this license record was first created in the system.',
    `doi_confirmation_number` STRING COMMENT 'Confirmation number issued by the state Department of Insurance (DOI) upon successful renewal submission.',
    `effective_date` DATE COMMENT 'Date when the license became active and the producer was authorized to begin selling insurance products in the issuing state.',
    `eo_coverage_required` BOOLEAN COMMENT 'Indicates whether Errors and Omissions (E&O) insurance coverage is required for this license by the issuing state.',
    `eo_expiration_date` DATE COMMENT 'Expiration date of the producers Errors and Omissions (E&O) insurance coverage.',
    `eo_policy_number` STRING COMMENT 'Policy number of the Errors and Omissions (E&O) insurance coverage maintained by the producer.',
    `expiration_date` DATE COMMENT 'Date when the license expires and must be renewed to maintain active status. Nullable for licenses with indefinite terms.',
    `finra_crd_number` STRING COMMENT 'FINRA Central Registration Depository (CRD) number for producers authorized to sell variable products.',
    `finra_registration_required` BOOLEAN COMMENT 'Indicates whether FINRA registration is required for this license to sell variable life insurance or variable annuity products.',
    `issuing_state` STRING COMMENT 'Two-letter US state or territory code of the Department of Insurance (DOI) that issued this license. Supports all 50 US states plus territories.',
    `last_renewal_date` DATE COMMENT 'Date when the license was most recently renewed by the producer.',
    `late_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed for late license renewal submission.',
    `late_renewal_penalty_flag` BOOLEAN COMMENT 'Indicates whether a late renewal penalty was assessed due to renewal submission after the due date.',
    `license_class` STRING COMMENT 'Classification of the license based on the producers residency status in the issuing state.. Valid values are `resident|non_resident|temporary|reciprocal`',
    `license_number` STRING COMMENT 'State-issued insurance producer license number assigned by the Department of Insurance (DOI). This is the externally-known unique identifier for the license.',
    `license_status` STRING COMMENT 'Current lifecycle status of the license indicating whether the producer is authorized to sell insurance products.. Valid values are `active|inactive|suspended|revoked|expired|pending`',
    `line_of_authority` STRING COMMENT 'The insurance product line(s) the producer is authorized to sell under this license (e.g., life, health, variable products).. Valid values are `life|health|variable|property|casualty|personal_lines`',
    `next_renewal_due_date` DATE COMMENT 'Date by which the producer must submit renewal application and fees to maintain active license status.',
    `nipr_number` STRING COMMENT 'National Insurance Producer Registry (NIPR) number used for multi-state license management and reciprocity.',
    `original_issue_date` DATE COMMENT 'Date when the license was first issued to the producer in the issuing state, prior to any renewals.',
    `reciprocal_state` STRING COMMENT 'Two-letter state code of the producers home state when this is a non-resident reciprocal license.',
    `renewal_cycle_months` STRING COMMENT 'Number of months in the license renewal cycle (typically 12, 24, or 36 months depending on state requirements).',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount required by the issuing state Department of Insurance (DOI) for license renewal.',
    `renewal_fee_paid_date` DATE COMMENT 'Date when the renewal fee was paid to the issuing state Department of Insurance (DOI).',
    `renewal_reminder_sent_date` DATE COMMENT 'Date when the automated renewal reminder notification was sent to the producer.',
    `renewal_submission_date` DATE COMMENT 'Date when the license renewal application was submitted to the issuing state Department of Insurance (DOI).',
    `termination_date` DATE COMMENT 'Date when the license or appointment was terminated, suspended, or revoked.',
    `termination_reason` STRING COMMENT 'Reason for license or appointment termination, suspension, or revocation (e.g., voluntary surrender, regulatory action, non-renewal).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this license record was last modified in the system.',
    CONSTRAINT pk_license PRIMARY KEY(`license_id`)
) COMMENT 'State-issued insurance producer license records tracking license number, line of authority (life, health, variable), issuing state DOI, license class, effective date, expiration date, and active/inactive status. Includes renewal lifecycle tracking: CE hours completed vs. required, renewal submission dates, fee payment status, state DOI submission confirmation, renewed expiration dates, and late renewal penalty flags. Supports multi-state licensing across all 50 US states and territories per NAIC Producer Licensing Model Act requirements. Provides automated renewal reminders and CE compliance monitoring across multi-state license portfolios.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`appointment` (
    `appointment_id` BIGINT COMMENT 'Unique identifier for the carrier appointment record.',
    `producer_id` BIGINT COMMENT 'Reference to the licensed producer being appointed.',
    `appointment_upline_agent_producer_id` BIGINT COMMENT 'Reference to the supervising or sponsoring agent in the distribution hierarchy, if applicable. Used for commission rollup and override calculations.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Appointment letters, state filing confirmations, and termination notices are regulatory documents requiring retention. State DOI audits and producer disputes require production of appointment document',
    `eo_policy_id` BIGINT COMMENT 'Foreign key linking to agent.eo_policy. Business justification: Appointments track E&O coverage requirements. Currently appointment has errors_and_omissions_policy_number (STRING) and expiration_date but no FK to eo_policy table. Adding eo_policy_id FK links the a',
    `finra_registration_id` BIGINT COMMENT 'Foreign key linking to agent.finra_registration. Business justification: Appointments track FINRA registration requirements for variable product sales. Currently appointment has finra_crd_number (STRING) but no FK to finra_registration table. Adding finra_registration_id F',
    `license_id` BIGINT COMMENT 'Foreign key linking to agent.license. Business justification: Appointment records authorize a producer to sell specific product lines based on an underlying state license. The appointment.state_of_appointment and appointment.line_of_authority should correspond t',
    `anti_money_laundering_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the producer has completed required AML training as mandated by FinCEN and internal compliance policies.',
    `anti_money_laundering_training_date` DATE COMMENT 'Date on which the producer completed required AML training. Must be refreshed periodically per compliance requirements.',
    `appointing_carrier_code` STRING COMMENT 'NAIC company code or internal identifier of the insurance carrier granting the appointment.',
    `appointing_carrier_name` STRING COMMENT 'Legal name of the insurance carrier granting the appointment.',
    `appointment_number` STRING COMMENT 'Business identifier for the appointment record, often used in state DOI filings and external correspondence.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the appointment. Active indicates the producer is authorized to sell; pending indicates awaiting state approval; terminated indicates appointment has ended.. Valid values are `active|pending|terminated|suspended|expired|cancelled`',
    `appointment_type` STRING COMMENT 'Classification of the appointment action: new appointment, renewal of existing appointment, reinstatement after lapse, termination, or amendment to existing terms.. Valid values are `new|renewal|reinstatement|termination|amendment`',
    `background_check_completed_flag` BOOLEAN COMMENT 'Indicates whether required background check was completed prior to appointment approval, per carrier onboarding requirements.',
    `background_check_date` DATE COMMENT 'Date on which the background check was completed for the producer.',
    `broker_dealer_name` STRING COMMENT 'Name of the broker-dealer firm through which the producer is registered for variable product sales, if applicable.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission rate schedule applicable to business written under this appointment.',
    `contract_number` STRING COMMENT 'Reference to the underlying agent contract or agreement that governs the commercial relationship between the carrier and producer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this appointment record was first created in the system.',
    `distribution_channel` STRING COMMENT 'Classification of the distribution channel through which the producer operates (captive agent, independent agent, BGA, MGA, broker-dealer, bank, worksite, direct). [ENUM-REF-CANDIDATE: captive|independent|bga|mga|broker_dealer|bank|worksite|direct — 8 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the producer is authorized to begin selling products on behalf of the carrier in the specified state and line of authority.',
    `errors_and_omissions_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether the carrier requires the producer to maintain errors and omissions insurance as a condition of appointment.',
    `finra_registration_required_flag` BOOLEAN COMMENT 'Indicates whether FINRA registration is required for this appointment due to variable product sales authority. True if line of authority includes variable life or variable annuities.',
    `hierarchy_level` STRING COMMENT 'Position of the producer within the distribution hierarchy (writing agent, general agent, managing general agent, brokerage general agent, regional director, national director).. Valid values are `writing_agent|ga|mga|bga|regional_director|national_director`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this appointment record was last updated in the system.',
    `line_of_authority` STRING COMMENT 'Product line or lines the producer is authorized to sell under this appointment (e.g., Life, Accident and Health, Variable Contracts, Fixed Annuities). May be comma-separated for multi-line appointments. [ENUM-REF-CANDIDATE: life|accident_and_health|variable_life|variable_annuity|fixed_annuity|long_term_care|disability_income — promote to reference product]',
    `nipr_appointment_number` STRING COMMENT 'Unique identifier assigned by NIPR for appointments filed through the Producer Database (PDB) system.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special conditions, or restrictions associated with the appointment.',
    `renewal_date` DATE COMMENT 'Date on which the appointment is scheduled for renewal review. Some states require periodic renewal filings.',
    `source_system_code` STRING COMMENT 'Identifier of the operational system from which this appointment record originated (e.g., Sapiens Commission, Annocera, NIPR PDB).',
    `state_approval_date` DATE COMMENT 'Date on which the state Department of Insurance approved the appointment. May differ from effective date in some jurisdictions.',
    `state_filing_confirmation_number` STRING COMMENT 'Confirmation or tracking number provided by the state DOI upon successful appointment filing submission.',
    `state_filing_date` DATE COMMENT 'Date on which the appointment was filed with the state Department of Insurance. Most states require filing within 15-30 days of appointment.',
    `state_of_appointment` STRING COMMENT 'Two-letter US state or territory code where the appointment is filed and effective. Each state requires separate appointment filing.',
    `suitability_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the producer has completed required product suitability and best interest training per state and NAIC requirements.',
    `suitability_training_date` DATE COMMENT 'Date on which the producer completed required suitability and best interest training.',
    `termination_date` DATE COMMENT 'Date on which the appointment ended or will end. Null for active appointments. Required for terminated appointments per state DOI notification requirements.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for appointment termination. For-cause terminations must be reported to state DOI within specified timeframes. [ENUM-REF-CANDIDATE: voluntary|involuntary|for_cause|non_renewal|license_lapse|death|retirement|other — 8 candidates stripped; promote to reference product]',
    `termination_reason_description` STRING COMMENT 'Detailed narrative explanation of the termination reason, especially for for-cause terminations that require state DOI reporting.',
    CONSTRAINT pk_appointment PRIMARY KEY(`appointment_id`)
) COMMENT 'Formal carrier appointment records authorizing a licensed producer to sell specific product lines on behalf of the insurer. Tracks appointment status, appointing carrier, line of authority, state of appointment, effective and termination dates, and appointment type (new, renewal, termination). Required for regulatory compliance with state DOI appointment filing obligations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` (
    `hierarchy_node_id` BIGINT COMMENT 'Unique identifier for the hierarchy node. Primary key.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to agent.agency. Business justification: Hierarchy nodes can represent either individual producers or agency entities in the distribution hierarchy. When a node represents an agency (BGA, MGA, GA), this FK links to the agency master record. ',
    `parent_node_hierarchy_node_id` BIGINT COMMENT 'Reference to the parent node in the distribution hierarchy. Self-referencing foreign key enabling tree traversal and roll-up reporting. Null for top-level nodes.',
    `producer_id` BIGINT COMMENT 'Reference to the agent or distribution participant represented by this hierarchy node. Links to the agent master record.',
    `channel_code` STRING COMMENT 'Distribution channel classification for this hierarchy node. Career represents captive career agents. Independent represents independent agents and agencies. Worksite represents employer-sponsored distribution. Financial institution represents bank and credit union channels. Broker-dealer represents securities-licensed distribution for variable products.. Valid values are `career|independent|worksite|financial_institution|direct|broker_dealer`',
    `child_node_count` STRING COMMENT 'Number of direct child nodes reporting to this hierarchy node. Used for span-of-control analysis and organizational structure metrics. Zero for leaf nodes.',
    `commission_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this node participates in commission calculation and override chains. True for nodes eligible for commission processing. False for reporting-only or inactive nodes.',
    `commission_schedule_code` STRING COMMENT 'Reference to the commission rate schedule applicable to this hierarchy node. Determines first-year commission (Annual Premium Equivalent (APE)), renewal commission, and override rates. Links to commission rate tables.',
    `commission_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of commission allocated to this hierarchy node when multiple nodes share commission on the same policy. Used in split-commission scenarios and joint-writing arrangements. Value between 0.00 and 100.00.',
    `contract_type` STRING COMMENT 'Legal relationship type between the company and this hierarchy node. W2 employee represents captive career agents. 1099 contractor represents independent agents. Corporate entity represents agency corporations. Partnership represents multi-owner agencies.. Valid values are `w2_employee|1099_contractor|corporate_entity|partnership`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was first created in the system. Used for audit trail and data lineage tracking.',
    `depth_level` STRING COMMENT 'Calculated depth of this node from the root of the hierarchy tree. Root nodes have depth 0. Used for tree traversal algorithms and organizational chart rendering.',
    `descendant_node_count` STRING COMMENT 'Total number of descendant nodes (children, grandchildren, etc.) under this hierarchy node. Used for organizational size metrics and production roll-up calculations. Zero for leaf nodes.',
    `effective_date` DATE COMMENT 'Date when this hierarchy node became active and operational. Used for temporal queries and commission eligibility determination.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the distribution hierarchy tree. Level 1 represents top-level nodes (e.g., Brokerage General Agency (BGA)), higher numbers represent deeper levels (e.g., writing agents). Enables depth-based queries and organizational charting.',
    `hierarchy_path` STRING COMMENT 'Materialized path representing the full lineage from root to this node, typically formatted as slash-delimited node IDs (e.g., /1/45/203/). Enables efficient ancestor and descendant queries without recursive joins.',
    `hierarchy_type` STRING COMMENT 'Classification of the distribution hierarchy structure. Captive represents company-owned distribution, independent represents non-exclusive agents, brokerage represents broker-dealer channels, hybrid represents mixed models, direct represents company-direct sales, reinsurance represents reinsurance intermediary chains.. Valid values are `captive|independent|brokerage|hybrid|direct|reinsurance`',
    `hierarchy_version` STRING COMMENT 'Version number for this hierarchy node configuration. Incremented when node attributes change. Supports temporal hierarchy analysis and historical commission recalculations.',
    `leaf_node_flag` BOOLEAN COMMENT 'Indicates whether this node is a leaf node (has no children) in the hierarchy tree. True for individual writing agents. False for supervisory and management levels with downstream agents.',
    `node_code` STRING COMMENT 'Business identifier or code for this hierarchy node. Used for reporting, commission processing, and system integration. May align with legacy system codes or external partner identifiers.',
    `node_name` STRING COMMENT 'Business name or label for this hierarchy node. May represent the agent name, agency name, Managing General Agent (MGA) name, General Agent (GA) name, or Brokerage General Agency (BGA) name depending on hierarchy level.',
    `node_status` STRING COMMENT 'Current operational status of the hierarchy node. Active indicates the node is operational and eligible for commission processing. Inactive indicates temporary suspension. Terminated indicates permanent closure. Pending indicates awaiting approval or activation.. Valid values are `active|inactive|suspended|pending|terminated`',
    `notes` STRING COMMENT 'Free-form text notes and comments about this hierarchy node. Used for documenting special arrangements, historical context, or operational considerations.',
    `organizational_unit` STRING COMMENT 'Business division, region, or organizational unit to which this hierarchy node belongs. Used for management reporting, territory assignment, and organizational charting.',
    `override_eligible_flag` BOOLEAN COMMENT 'Indicates whether this hierarchy node is eligible to receive override commissions from downstream production. True for supervisory and management levels (Managing General Agent (MGA), General Agent (GA), Brokerage General Agency (BGA)). False for individual writing agents.',
    `production_credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of production volume credited to this hierarchy node for quota and performance tracking. Used in split-credit scenarios and joint-production arrangements. Value between 0.00 and 100.00.',
    `reporting_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this node participates in management reporting hierarchies. True for nodes used in executive dashboards and performance reporting. False for commission-only or administrative nodes.',
    `roll_up_eligible_flag` BOOLEAN COMMENT 'Indicates whether production from this node should roll up to parent nodes for reporting and commission calculations. Typically true for all nodes except top-level organizational units.',
    `sort_order` STRING COMMENT 'Display sequence for this node among siblings in the hierarchy tree. Used for consistent organizational chart rendering and report ordering.',
    `termination_date` DATE COMMENT 'Date when this hierarchy node was terminated or deactivated. Null for active nodes. Used for historical reporting and commission cutoff calculations.',
    `termination_reason` STRING COMMENT 'Reason for hierarchy node termination. Voluntary indicates agent-initiated departure. Involuntary indicates company-initiated termination. Restructure indicates organizational change. Compliance indicates regulatory or policy violation. Performance indicates failure to meet production targets. [ENUM-REF-CANDIDATE: voluntary|involuntary|restructure|merger|acquisition|compliance|performance|retirement — 8 candidates stripped; promote to reference product]',
    `territory_code` STRING COMMENT 'Geographic or market territory assigned to this hierarchy node. Used for territory management, lead assignment, and market penetration analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this hierarchy node record was last modified. Used for audit trail, change tracking, and data synchronization.',
    CONSTRAINT pk_hierarchy_node PRIMARY KEY(`hierarchy_node_id`)
) COMMENT 'Represents a single node in the multi-level distribution hierarchy — from individual writing agents up through supervisory levels, GAs, MGAs, BGAs, and broker-dealers. Each node captures the participant, their hierarchy level, parent node reference (enabling tree traversal), effective and termination dates, override eligibility flag, and hierarchy type (captive, independent, brokerage). Self-referencing parent-child structure enables roll-up reporting, commission override chain calculations, and organizational charting across distribution tiers.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`contracting` (
    `contracting_id` BIGINT COMMENT 'Unique identifier for the producer contracting record. Primary key for the contracting entity.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Executed producer contracts are legal documents requiring retention per regulatory schedules. Termination processing, commission disputes, and regulatory audits require access to signed contract docum',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer who is party to this contract. Links to the agent master record.',
    `contracting_upline_agent_producer_id` BIGINT COMMENT 'Reference to the upline agent or agency in the distribution hierarchy. Null for top-level producers who report directly to the carrier.',
    `eo_policy_id` BIGINT COMMENT 'FK to agent.eo_policy',
    `finra_registration_id` BIGINT COMMENT 'FK to agent.finra_registration',
    `termination_event_id` BIGINT COMMENT 'Reference to the termination event record in the event log for historical tracking and audit trail purposes.',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the producer as part of the contracting process.',
    `background_check_status` STRING COMMENT 'Result of the background check conducted during producer onboarding. Passed indicates no issues found; failed indicates disqualifying findings; pending indicates check in progress; waived indicates check was not required.. Valid values are `passed|failed|pending|waived`',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission schedule and rate structure applicable to this producer contract. Determines how commissions are calculated for sales under this contract.',
    `contract_number` STRING COMMENT 'Externally-known unique identifier for the producer contract. Used for business reference and correspondence.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the producer contract. Pending indicates onboarding in progress; active indicates the producer is authorized to sell; suspended indicates temporary hold; terminated indicates contract has ended.. Valid values are `pending|active|suspended|terminated`',
    `contract_type` STRING COMMENT 'Classification of the producer contract. Captive agents represent only the carrier; independent agents represent multiple carriers; brokerage agreements are for broker-dealers; MGA (Managing General Agent), BGA (Brokerage General Agency), and GA (General Agent) represent hierarchical distribution models.. Valid values are `captive|independent|brokerage|mga|bga|ga`',
    `contracting_date` DATE COMMENT 'Date when the producer contract was executed and signed by both parties. Marks the formal agreement date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contracting record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the producer contract becomes active and the producer is authorized to sell products on behalf of the carrier.',
    `eo_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether the producer is required to maintain Errors and Omissions insurance as a condition of the contract.',
    `expiration_date` DATE COMMENT 'Date when the producer contract expires or is scheduled to end. Null for open-ended contracts.',
    `finra_registration_required_flag` BOOLEAN COMMENT 'Indicates whether the producer must be FINRA-registered to sell variable products under this contract. True for contracts authorizing variable life or variable annuity sales.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the distribution hierarchy. Level 1 typically represents direct agents; higher levels represent MGAs, BGAs, or GAs who manage downline producers.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the contracting application is Not In Good Order due to missing documentation, incomplete information, or compliance issues. True means the contract is incomplete and requires remediation.',
    `nigo_reason` STRING COMMENT 'Detailed explanation of why the contracting application is flagged as NIGO. Describes missing documents, compliance gaps, or information deficiencies.',
    `nigo_resolution_date` DATE COMMENT 'Date when all NIGO issues were resolved and the contract moved to good order status.',
    `onboarding_completion_date` DATE COMMENT 'Date when all onboarding requirements were completed and the producer was fully activated in the system.',
    `product_line_authorization` STRING COMMENT 'Comma-separated list of product lines the producer is authorized to sell under this contract (e.g., life, annuity, variable products, long-term care). Defines the scope of selling authority.',
    `regulatory_reporting_status` STRING COMMENT 'Status of regulatory reporting obligations for this contract termination. Tracks whether required notifications to NAIC, state DOI, and FINRA have been completed.. Valid values are `not_required|pending|submitted|confirmed`',
    `source_system` STRING COMMENT 'Name of the Agent and Commission Management System module that originated this contracting record (e.g., Sapiens Commission Onboarding, Annocera Contracting).',
    `state_notification_date` DATE COMMENT 'Date when the carrier notified the state Department of Insurance about the contract termination.',
    `state_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the carrier is required to notify state Departments of Insurance about this contract termination per state regulatory requirements.',
    `termination_date` DATE COMMENT 'Effective date when the producer contract was terminated and the producer lost selling authority.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for contract termination (e.g., performance issues, compliance violation, business closure, retirement, voluntary resignation).',
    `termination_reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and reasons for contract termination.',
    `termination_type` STRING COMMENT 'Classification of contract termination. Voluntary indicates producer-initiated termination; carrier-initiated indicates the carrier ended the contract; regulatory indicates termination due to regulatory action; mutual indicates both parties agreed to end the contract.. Valid values are `voluntary|carrier_initiated|regulatory|mutual`',
    `u5_confirmation_number` STRING COMMENT 'FINRA-issued confirmation number for the U5 filing, serving as proof of submission.',
    `u5_filing_date` DATE COMMENT 'Date when the FINRA Form U5 was filed to report the termination of the producers securities registration.',
    `u5_filing_required_flag` BOOLEAN COMMENT 'Indicates whether a FINRA Form U5 filing is required for this termination. Required when the producer was registered to sell variable products and the contract is terminated.',
    `unearned_commission_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of unearned commissions that must be returned by the producer upon termination.',
    `unearned_commission_return_flag` BOOLEAN COMMENT 'Indicates whether the producer is required to return unearned commissions upon contract termination. Typically applies when policies lapse or are cancelled shortly after issue.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contracting record was last modified in the system.',
    CONSTRAINT pk_contracting PRIMARY KEY(`contracting_id`)
) COMMENT 'Producer contracting records capturing the formal agreement between the insurer and a producer or agency. Tracks contract type (captive, independent, brokerage), contract status (pending, active, suspended, terminated), product line authorizations, contracting date, and NIGO (Not In Good Order) flags. Includes full termination lifecycle: termination type (voluntary, carrier-initiated, regulatory), effective date, reason code, state notification requirements, U5 filing obligation flag, return of unearned commission flag, regulatory reporting status, and termination_event_id for historical reference. Supports NAIC termination reporting and FINRA U5 filing obligations. Sourced from the Agent and Commission Management System onboarding module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`eo_policy` (
    `eo_policy_id` BIGINT COMMENT 'Primary key for eo_policy',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: E&O insurance carriers (Chubb, Hiscox, Travelers) are vendors providing insurance coverage to the agent network. Insurance operations, finance, and compliance need this link for premium payment proces',
    `document_id` BIGINT COMMENT 'Identifier of the stored COI document in the document management system.',
    `producer_id` BIGINT COMMENT 'Identifier of the producer (agent, broker, BGA, MGA, GA) to whom this E&O coverage applies.',
    `aggregate_limit` DECIMAL(18,2) COMMENT 'Maximum total amount the E&O policy will pay for all claims during the policy period, expressed in USD.',
    `cancellation_date` DATE COMMENT 'Date when the E&O coverage was cancelled, if applicable. Cancellation triggers immediate appointment termination in most states.',
    `cancellation_reason` STRING COMMENT 'Reason for E&O coverage cancellation, if applicable.. Valid values are `non-payment|underwriting|insured request|carrier decision|fraud|material misrepresentation`',
    `carrier_naic_code` STRING COMMENT 'Five-digit NAIC company code uniquely identifying the E&O insurance carrier.. Valid values are `^[0-9]{5}$`',
    `certificate_of_insurance_received` BOOLEAN COMMENT 'Indicates whether a Certificate of Insurance (COI) has been received and filed for this E&O coverage. COI is typically required for producer contracting.',
    `certificate_received_date` DATE COMMENT 'Date when the Certificate of Insurance was received and filed.',
    `claims_made_coverage` BOOLEAN COMMENT 'Indicates whether the E&O policy is claims-made (covers claims filed during the policy period) or occurrence-based (covers incidents that occurred during the policy period). Most E&O policies are claims-made.',
    `compliance_verification_date` DATE COMMENT 'Date when the E&O coverage was last verified for compliance with carrier and state DOI requirements. Used in automated onboarding and renewal workflows.',
    `compliance_verified_by` STRING COMMENT 'Name or identifier of the compliance officer or system that performed the most recent E&O verification.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Total coverage limit (per occurrence or aggregate) provided by the E&O policy, expressed in USD. Minimum coverage amounts are often mandated by state DOI or carrier contracting requirements.',
    `coverage_status` STRING COMMENT 'Current status of the E&O coverage. Active coverage is required for producer appointment and contracting in most states.. Valid values are `active|expired|cancelled|pending|suspended`',
    `coverage_type` STRING COMMENT 'Type of E&O coverage: individual (single producer), group (multiple producers under one policy), agency (agency-level coverage), or corporate (entity-level coverage).. Valid values are `individual|group|agency|corporate`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this E&O coverage record was first created in the system.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount the insured producer must pay before E&O coverage applies, expressed in USD.',
    `effective_date` DATE COMMENT 'Date when the E&O coverage becomes active and binding. Producer appointments cannot be processed before this date.',
    `erp_duration_months` STRING COMMENT 'Duration of the Extended Reporting Period in months, if applicable.',
    `expiration_date` DATE COMMENT 'Date when the E&O coverage terminates. Producers must renew coverage before this date to maintain appointment status.',
    `extended_reporting_period` BOOLEAN COMMENT 'Indicates whether the policy includes an Extended Reporting Period (tail coverage) that allows claims to be reported after the policy expires for incidents that occurred during the policy period.',
    `finra_coverage_required` BOOLEAN COMMENT 'Indicates whether FINRA-compliant E&O coverage is required for this producer due to variable product sales authority.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent E&O policy renewal.',
    `lines_of_authority_covered` STRING COMMENT 'Comma-separated list of lines of authority (LOA) covered by this E&O policy (e.g., Life, Accident and Health, Property and Casualty, Variable Products). Some carriers require separate E&O coverage for variable products.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the producer must renew the E&O coverage to avoid lapse. Used for automated renewal reminder workflows.',
    `original_issue_date` DATE COMMENT 'Date when the E&O policy was first issued to the producer, regardless of subsequent renewals.',
    `per_occurrence_limit` DECIMAL(18,2) COMMENT 'Maximum amount the E&O policy will pay for a single claim or occurrence, expressed in USD.',
    `policy_number` STRING COMMENT 'The unique policy number assigned by the E&O insurance carrier. This is the externally-known identifier for the coverage.',
    `policy_term_months` STRING COMMENT 'Duration of the E&O policy term in months (typically 12 or 24 months).',
    `premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount paid by the producer for the E&O coverage, expressed in USD.',
    `premium_paid_date` DATE COMMENT 'Date when the most recent E&O premium payment was received by the carrier.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which the producer pays the E&O premium.. Valid values are `annual|semi-annual|quarterly|monthly`',
    `reinstatement_eligible` BOOLEAN COMMENT 'Indicates whether the producer is eligible to reinstate the E&O coverage after cancellation or lapse.',
    `renewal_reminder_sent_date` DATE COMMENT 'Date when the most recent renewal reminder was sent to the producer. Used in automated compliance workflows to prevent coverage lapse.',
    `retroactive_date` DATE COMMENT 'For claims-made policies, the earliest date of an incident that will be covered. Incidents before this date are not covered even if the claim is filed during the policy period.',
    `state_filing_confirmation_number` STRING COMMENT 'Confirmation number issued by the state DOI upon successful filing of the E&O coverage.',
    `state_filing_date` DATE COMMENT 'Date when the E&O coverage was filed with the state DOI, if required.',
    `state_filing_required` BOOLEAN COMMENT 'Indicates whether the E&O coverage must be filed with the state Department of Insurance (DOI) as part of the producer appointment process.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this E&O coverage record was last updated in the system.',
    `variable_products_covered` BOOLEAN COMMENT 'Indicates whether the E&O policy covers variable life insurance and variable annuity products. FINRA-registered representatives selling variable products typically require enhanced E&O coverage.',
    CONSTRAINT pk_eo_policy PRIMARY KEY(`eo_policy_id`)
) COMMENT 'Errors and Omissions (E&O) insurance coverage records for producers. Tracks E&O carrier, policy number, coverage amount, effective and expiration dates, coverage status, and compliance verification date. E&O coverage is a mandatory prerequisite for producer contracting and appointment in most states. Supports automated compliance checks during onboarding and renewal workflows.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`finra_registration` (
    `finra_registration_id` BIGINT COMMENT 'Unique identifier for the FINRA registration record. Primary key for this entity.',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer who holds this FINRA registration. Links to the agent master record.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: FINRA U4 and U5 forms are regulatory filings requiring retention. FINRA audits, disclosure event investigations, and termination processing require access to filed U4/U5 documents. Links FINRA registr',
    `background_check_completed_flag` BOOLEAN COMMENT 'Indicates whether a background check has been completed as part of the FINRA registration process. Required for all new registrations.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed for the agents FINRA registration. Used for compliance documentation and audit trail.',
    `broker_dealer_crd_number` STRING COMMENT 'CRD number of the broker-dealer firm. Used to verify the firms registration status with FINRA.. Valid values are `^[0-9]{1,10}$`',
    `broker_dealer_name` STRING COMMENT 'Name of the broker-dealer firm through which the agent is registered to sell variable products. Required for SEC and FINRA compliance.',
    `continuing_education_compliant_flag` BOOLEAN COMMENT 'Indicates whether the agent is current with FINRA continuing education requirements (Regulatory Element and Firm Element). Non-compliance can result in registration suspension.',
    `crd_number` STRING COMMENT 'Unique CRD number assigned by FINRA to the registered representative. This is the primary identifier for securities industry registration and is required for all variable product sales.. Valid values are `^[0-9]{1,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FINRA registration record was first created in the system. Used for audit trail and data lineage tracking.',
    `disclosure_event_count` STRING COMMENT 'Total number of disclosure events reported on the agents CRD record. Used for risk assessment and compliance monitoring.',
    `disclosure_event_flag` BOOLEAN COMMENT 'Indicates whether the agent has any reportable disclosure events on their CRD record (customer complaints, regulatory actions, criminal charges, civil judgments, etc.). True if disclosure events exist.',
    `fingerprint_submission_date` DATE COMMENT 'Date when fingerprints were submitted to FINRA as part of the registration process. Fingerprinting is required for all registered representatives.',
    `last_continuing_education_date` DATE COMMENT 'Date when the agent last completed required FINRA continuing education training. Used to track compliance with ongoing education requirements.',
    `last_disclosure_event_date` DATE COMMENT 'Date of the most recent disclosure event reported on the agents CRD record. Used to track recency of compliance issues.',
    `next_continuing_education_due_date` DATE COMMENT 'Date by which the agent must complete their next continuing education requirement. Regulatory Element is required every three years on the anniversary of initial registration.',
    `registered_representative_type` STRING COMMENT 'Type of registered representative designation held by the agent. Variable contracts representative (Series 6) or general securities representative (Series 7) are common for life insurance variable product sales.. Valid values are `general_securities|investment_company|variable_contracts|limited_representative`',
    `registration_date` DATE COMMENT 'Date when the agents FINRA registration became effective. This is the date from which the agent is authorized to sell variable products.',
    `registration_expiration_date` DATE COMMENT 'Date when the FINRA registration expires. Agents must maintain active registration to continue selling variable products. Nullable for registrations without fixed expiration.',
    `registration_notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special circumstances related to the FINRA registration. Used for compliance documentation and internal tracking.',
    `registration_status` STRING COMMENT 'Current status of the FINRA registration. Active status is required for the agent to sell variable life insurance and variable annuity products.. Valid values are `active|inactive|suspended|pending|terminated|expired`',
    `sec_registration_number` STRING COMMENT 'SEC registration number for the agent or their broker-dealer, if applicable. Required for certain variable product sales activities.',
    `series_63_exam_date` DATE COMMENT 'Date when the agent passed the Series 63 exam. Used to verify state-level securities qualification.',
    `series_63_exam_passed_flag` BOOLEAN COMMENT 'Indicates whether the agent has passed the Series 63 (Uniform Securities Agent State Law) exam. Required in most states for securities registration.',
    `series_65_exam_date` DATE COMMENT 'Date when the agent passed the Series 65 exam. Used to verify investment adviser qualification.',
    `series_65_exam_passed_flag` BOOLEAN COMMENT 'Indicates whether the agent has passed the Series 65 (Uniform Investment Adviser Law) exam. May be required for agents providing investment advice on variable products.',
    `series_6_exam_date` DATE COMMENT 'Date when the agent passed the Series 6 exam. Used to verify qualification timeline and continuing education requirements.',
    `series_6_exam_passed_flag` BOOLEAN COMMENT 'Indicates whether the agent has passed the Series 6 (Investment Company and Variable Contracts Products Representative) exam. Required for selling variable annuities and variable life insurance.',
    `series_7_exam_date` DATE COMMENT 'Date when the agent passed the Series 7 exam. Used to verify qualification timeline and continuing education requirements.',
    `series_7_exam_passed_flag` BOOLEAN COMMENT 'Indicates whether the agent has passed the Series 7 (General Securities Representative) exam. Series 7 qualifies the agent to sell a broader range of securities including variable products.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this FINRA registration record originated (e.g., Agent and Commission Management System, CRD system feed). Used for data lineage and reconciliation.',
    `termination_date` DATE COMMENT 'Date when the FINRA registration was terminated. Populated when the agent leaves the broker-dealer or the registration is otherwise ended.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for termination of the FINRA registration. Used for regulatory reporting and compliance tracking.. Valid values are `voluntary|discharged|permitted_to_resign|deceased|other`',
    `u4_filing_date` DATE COMMENT 'Date when the Form U4 was filed with FINRA to register the agent. Form U4 is the initial registration application required for all securities industry registrations.',
    `u4_filing_status` STRING COMMENT 'Current processing status of the Form U4 filing. Tracks the application through FINRA review and approval process.. Valid values are `submitted|approved|rejected|pending_review|incomplete`',
    `u5_filing_date` DATE COMMENT 'Date when the Form U5 was filed with FINRA to terminate the agents registration. Form U5 must be filed within 30 days of termination.',
    `u5_filing_status` STRING COMMENT 'Current processing status of the Form U5 termination filing. Tracks the termination notice through FINRA review process.. Valid values are `submitted|approved|rejected|pending_review|incomplete`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this FINRA registration record was last modified. Used for audit trail and change tracking.',
    `variable_product_authorization_flag` BOOLEAN COMMENT 'Indicates whether the agent is currently authorized to sell variable life insurance and variable annuity products based on their FINRA registration status. True if authorized.',
    CONSTRAINT pk_finra_registration PRIMARY KEY(`finra_registration_id`)
) COMMENT 'FINRA registration records for producers authorized to sell variable products (VUL, variable annuities). Tracks CRD number, registration status, registered representative type, broker-dealer affiliation, registration date, U4/U5 filing status, and disclosure event flags. Required for SEC/FINRA compliance for all variable product sales per FINRA Rule 1220.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`onboarding_case` (
    `onboarding_case_id` BIGINT COMMENT 'Unique identifier for the producer onboarding case. Primary key for tracking the complete onboarding workflow from initial application through contracting and system provisioning.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to agent.agency. Business justification: Onboarding cases track the producer onboarding workflow, which often involves joining a specific agency. This FK links the onboarding case to the agency the producer is joining. No columns removed bec',
    `background_check_id` BIGINT COMMENT 'Reference to the primary background check record associated with this onboarding case. Links to detailed screening results including criminal, credit, and regulatory history checks.',
    `contracting_id` BIGINT COMMENT 'Foreign key linking to agent.contracting. Business justification: Onboarding cases track the end-to-end producer onboarding workflow, which culminates in a contracting record. This FK links the onboarding case to the resulting contracting record. Populated when onbo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Onboarding activities incur recruiting costs (background checks, training, licensing fees, system provisioning) that must be capitalized or expensed to cost centers for producer acquisition cost analy',
    `distribution_channel_id` BIGINT COMMENT 'FK to agent.distribution_channel',
    `employee_id` BIGINT COMMENT 'Reference to the internal staff member assigned to review and process this onboarding case. Used for workload management and accountability.',
    `eo_policy_id` BIGINT COMMENT 'Foreign key linking to agent.eo_policy. Business justification: Onboarding cases validate E&O coverage. Currently onboarding_case has eo_policy_number (STRING) and eo_expiration_date but no FK to eo_policy table. Adding eo_policy_id FK links the onboarding case to',
    `finra_registration_id` BIGINT COMMENT 'Foreign key linking to agent.finra_registration. Business justification: Onboarding cases verify FINRA registration for producers authorized to sell variable products. Currently onboarding_case has finra_crd_number (STRING) but no FK to finra_registration table. Adding fin',
    `license_id` BIGINT COMMENT 'Foreign key linking to agent.license. Business justification: Onboarding cases track license verification status. Currently onboarding_case has nipr_number (STRING) but no FK to the license table. Adding license_id FK links the onboarding case to the specific li',
    `package_id` BIGINT COMMENT 'Foreign key linking to document.document_package. Business justification: Producer onboarding requires tracking complete documentation packages (licenses, background checks, E&O certificates, training records). Onboarding workflow depends on document package completeness ve',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer being onboarded. Links to the agent master record once created during the onboarding process.',
    `adverse_action_flag` BOOLEAN COMMENT 'Indicates whether an adverse action (denial or termination based on background check results) was taken or is being considered. True if adverse action applies, False otherwise.',
    `aml_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the producer has completed required Anti-Money Laundering training. True if completed, False otherwise. Required for compliance with Bank Secrecy Act and USA PATRIOT Act.',
    `aml_training_completion_date` DATE COMMENT 'Date when the producer completed AML training. Used for compliance tracking and periodic re-training requirements.',
    `application_submission_date` DATE COMMENT 'Date when the producer submitted the initial onboarding application. Marks the start of the onboarding workflow and is used for SLA tracking.',
    `application_type` STRING COMMENT 'Type of onboarding application: new agent appointment, transfer from another carrier, reappointment after termination, or upgrade to higher authority level.. Valid values are `new_agent|transfer|reappointment|upgrade`',
    `assigned_reviewer_name` STRING COMMENT 'Full name of the internal staff member assigned to review this onboarding case. Provides quick reference without requiring a join to the employee table.',
    `background_check_completion_date` DATE COMMENT 'Date when the background check results were received from the screening vendor. Marks completion of the screening phase.',
    `background_check_result_status` STRING COMMENT 'Overall result status of the background screening: pending (not yet complete), clear (no issues found), flagged (issues requiring review), or adverse action (disqualifying issues found).. Valid values are `pending|clear|flagged|adverse_action`',
    `background_check_submission_date` DATE COMMENT 'Date when the background check request was submitted to the screening vendor. Used for tracking turnaround time and SLA compliance.',
    `background_check_type` STRING COMMENT 'Type of background check performed: criminal history only, credit check, regulatory history (state DOI and FINRA), or comprehensive (all checks combined).. Valid values are `criminal|credit|regulatory|comprehensive`',
    `background_screening_vendor` STRING COMMENT 'Name of the third-party vendor used to conduct the background screening. Examples include LexisNexis, Sterling, or Checkr.',
    `case_number` STRING COMMENT 'Business-facing unique case number assigned to the onboarding workflow. Used for tracking and communication with the applicant and internal stakeholders.',
    `contracting_entity_code` STRING COMMENT 'Code identifying the legal entity or carrier with which the producer is contracting. Supports multi-carrier and multi-entity operations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding case record was first created in the system. Used for audit trail and data lineage tracking.',
    `eo_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether Errors and Omissions insurance coverage is required for this producer based on their distribution channel and product authority. True if required, False otherwise.',
    `eo_validation_status` STRING COMMENT 'Status of the E&O insurance validation. Indicates whether the producers E&O coverage has been verified to meet carrier requirements.. Valid values are `not_required|pending|validated|expired|insufficient`',
    `finra_registration_required_flag` BOOLEAN COMMENT 'Indicates whether FINRA registration is required for this producer based on their intended product authority (variable life, variable annuities). True if required, False otherwise.',
    `finra_verification_status` STRING COMMENT 'Status of FINRA registration verification. Indicates whether the producers FINRA registration has been validated through BrokerCheck.. Valid values are `not_required|pending|verified|failed`',
    `license_verification_date` DATE COMMENT 'Date when the producers licenses were successfully verified. Used for compliance tracking and audit purposes.',
    `license_verification_status` STRING COMMENT 'Status of the license verification process. Indicates whether the producers state licenses have been validated through NIPR or state DOI systems.. Valid values are `not_started|in_progress|verified|failed`',
    `mib_inquiry_reference` STRING COMMENT 'Reference number for any MIB inquiry conducted as part of the background screening. Used for producers who will sell life insurance products requiring underwriting knowledge.',
    `nigo_date` DATE COMMENT 'Date when the application was marked as Not In Good Order. Used for tracking resolution time and applicant communication.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the application has been flagged as Not In Good Order due to missing or incomplete documentation. True if NIGO, False otherwise.',
    `nigo_reason_code` STRING COMMENT 'Standardized code indicating the specific reason the application was marked NIGO. Examples include missing license copy, incomplete background check authorization, or missing E&O certificate.',
    `nigo_reason_description` STRING COMMENT 'Detailed explanation of why the application was marked NIGO. Provides specific guidance to the applicant on what is needed to move forward.',
    `onboarding_completion_date` DATE COMMENT 'Date when the entire onboarding process was completed and the producer was fully appointed and ready to transact business. Used for time-to-productivity metrics and SLA tracking.',
    `onboarding_status` STRING COMMENT 'Current status of the onboarding case in the workflow. Tracks progression from initial application through final approval or rejection. [ENUM-REF-CANDIDATE: initiated|nigo|under_review|pending_background|pending_licensing|approved|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `regulatory_disqualification_flag` BOOLEAN COMMENT 'Indicates whether the producer has any regulatory disqualifications that would prevent appointment. Examples include state DOI sanctions, FINRA bars, or federal convictions. True if disqualified, False otherwise.',
    `rejection_date` DATE COMMENT 'Date when the onboarding application was formally rejected. Used for tracking and adverse action notification timing.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for onboarding rejection. Examples include failed background check, license issues, or regulatory disqualification.',
    `rejection_reason_description` STRING COMMENT 'Detailed explanation of why the onboarding application was rejected. Provides context for the rejection decision and supports adverse action communication.',
    `suitability_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the producer has completed required suitability and best interest training for annuity sales. True if completed, False otherwise. Required for NAIC Model Regulation 275 compliance.',
    `suitability_training_completion_date` DATE COMMENT 'Date when the producer completed suitability training. Used for compliance tracking and state reporting requirements.',
    `system_provisioning_date` DATE COMMENT 'Date when system access was successfully provisioned for the producer. Marks readiness for production activity.',
    `system_provisioning_status` STRING COMMENT 'Status of system access provisioning for the producer. Indicates whether user accounts, POS system access, and portal credentials have been created.. Valid values are `not_started|in_progress|completed|failed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding case record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_onboarding_case PRIMARY KEY(`onboarding_case_id`)
) COMMENT 'Tracks the end-to-end producer onboarding workflow from initial application through contracting, licensing verification, E&O validation, background screening, and system provisioning. Captures onboarding stage, NIGO reason codes, assigned reviewer, AML training completion, and overall onboarding completion date. Includes embedded background check tracking: screening vendor, check type (criminal, credit, regulatory history), submission date, result status (clear, flagged, pending), adverse action flags, MIB inquiry reference, and regulatory disqualification indicators. Supports periodic re-screening workflows and maintains historical screening records with unique background_check_id references. Satisfies NAIC background check requirements and FINRA suitability obligations. Sourced from the Agent and Commission Management System onboarding module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`producer_training` (
    `producer_training_id` BIGINT COMMENT 'Unique identifier for the producer training record.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Training completion certificates must be retained for regulatory compliance and CE credit verification. State DOI audits require production of training certificates. Links training records to stored c',
    `license_id` BIGINT COMMENT 'Foreign key linking to agent.license. Business justification: Producer training records often satisfy continuing education (CE) requirements for specific state licenses. This FK links the training record to the license for which CE credit is being applied. The s',
    `producer_id` BIGINT COMMENT 'Identifier of the producer who completed the training. Links to the producer master record.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Training providers (Kaplan Financial Education, ExamFX, WebCE) are vendors delivering CE and compliance training courses. Finance needs this link for invoice reconciliation (matching training completi',
    `attempts_count` STRING COMMENT 'Number of attempts the producer made to complete or pass the training course.',
    `ce_credit_hours_awarded` DECIMAL(18,2) COMMENT 'Number of continuing education credit hours awarded to the producer upon successful completion of the training.',
    `ce_credit_type` STRING COMMENT 'Type or category of continuing education credit awarded, such as general, ethics, product-specific, law, annuity, or long-term care.. Valid values are `general|ethics|product_specific|law|annuity|long_term_care`',
    `certificate_issued_date` DATE COMMENT 'Date the training certificate or credential was issued to the producer.',
    `certification_number` STRING COMMENT 'Unique certification or credential number issued upon successful completion of the training.',
    `completion_score` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved by the producer upon completion of the training course.',
    `compliance_requirement_met` BOOLEAN COMMENT 'Boolean flag indicating whether this training completion satisfies a regulatory or carrier compliance requirement.',
    `compliance_requirement_type` STRING COMMENT 'Type of compliance requirement satisfied by this training, such as AML/BSA, DOL fiduciary, FINRA, state CE mandate, or carrier-specific certification. [ENUM-REF-CANDIDATE: aml_bsa|dol_fiduciary|finra_continuing_education|state_ce_mandate|carrier_certification|suitability|ethics|product_authorization — promote to reference product]',
    `cost_paid_by` STRING COMMENT 'Party responsible for paying the training cost, such as the producer, carrier, agency, or a third party.. Valid values are `producer|carrier|agency|third_party`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the producer training record was first created in the system.',
    `enrollment_date` DATE COMMENT 'Date the producer enrolled in the training course.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the producer training record was last updated or modified.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the producer must renew or retake the training to maintain compliance.',
    `pass_fail_indicator` STRING COMMENT 'Indicator of whether the producer passed or failed the training course.. Valid values are `pass|fail|not_applicable`',
    `passing_score_required` DECIMAL(18,2) COMMENT 'Minimum score or percentage required to pass the training course.',
    `renewal_cycle_months` STRING COMMENT 'Number of months in the renewal cycle before the training must be retaken or renewed.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this training requires periodic renewal or retaking.',
    `source_system_code` STRING COMMENT 'Code identifying the source system or platform from which the training record originated, such as the Agent and Commission Management System or Learning Management System.',
    `state_approval_number` STRING COMMENT 'State-issued approval or course number for continuing education credit recognition.',
    `state_of_credit` STRING COMMENT 'Two-letter state code indicating the jurisdiction where the continuing education credit is recognized.',
    `training_category` STRING COMMENT 'Business category of the training such as AML/BSA, product training (IUL, FIA, GMWB), suitability, ethics, sales practices, or carrier-specific certification. [ENUM-REF-CANDIDATE: aml_bsa|product_iul|product_fia|product_gmwb|suitability|ethics|sales_practices|carrier_certification|dol_fiduciary|state_ce|finra_compliance — promote to reference product]',
    `training_completion_date` DATE COMMENT 'Date the producer successfully completed the training course.',
    `training_cost_amount` DECIMAL(18,2) COMMENT 'Cost or fee paid for the training course in USD. Single-currency business operates in USD.',
    `training_course_code` STRING COMMENT 'Unique code identifying the training course or program.',
    `training_course_name` STRING COMMENT 'Full name of the training course or certification program.',
    `training_delivery_method` STRING COMMENT 'Method by which the training was delivered to the producer.. Valid values are `classroom|online|webinar|self_paced|blended|on_the_job`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course in hours.',
    `training_expiration_date` DATE COMMENT 'Date when the training certification or credit expires and renewal or retaking is required.',
    `training_notes` STRING COMMENT 'Free-form notes or comments related to the producers training record, including special circumstances or observations.',
    `training_provider_code` STRING COMMENT 'Unique code identifying the training provider or vendor.',
    `training_start_date` DATE COMMENT 'Date the producer began the training course.',
    `training_status` STRING COMMENT 'Current status of the producers participation in the training course.. Valid values are `enrolled|in_progress|completed|failed|expired|waived`',
    `training_type` STRING COMMENT 'Classification of the training program indicating whether it is mandatory, elective, certification-based, continuing education, product-specific, or compliance-related.. Valid values are `mandatory|elective|certification|continuing_education|product_specific|compliance`',
    `waiver_approval_date` DATE COMMENT 'Date the training waiver was approved.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person or authority who approved the training waiver.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a waiver was granted exempting the producer from this training requirement.',
    `waiver_reason` STRING COMMENT 'Reason or justification for granting a training waiver to the producer.',
    CONSTRAINT pk_producer_training PRIMARY KEY(`producer_training_id`)
) COMMENT 'Records of mandatory and elective training completions for producers — including AML/BSA training, product-specific training (IUL, FIA, GMWB), suitability training, CE credits, and carrier-specific certification programs. Tracks course name, provider, completion date, score, CE credit hours awarded, expiration date, and compliance status. Supports DOL fiduciary training requirements and state CE mandates.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` (
    `producer_product_auth_id` BIGINT COMMENT 'Unique identifier for the producer product authorization record.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Producer product authorization requires linking to specific product plans for selling authority verification, commission schedule assignment, state-specific authorization validation, and compliance re',
    `producer_id` BIGINT COMMENT 'Reference to the producer (agent, broker, BGA, MGA, GA) who is authorized to sell the product.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved this product authorization.',
    `authorization_approval_date` DATE COMMENT 'The date on which the producers authorization to sell this product was approved by the carrier.',
    `authorization_effective_date` DATE COMMENT 'The date on which the producers authorization to sell this product becomes effective.',
    `authorization_expiration_date` DATE COMMENT 'The date on which the producers authorization to sell this product expires. Null indicates no expiration (perpetual authorization).',
    `authorization_notes` STRING COMMENT 'Free-form notes regarding special conditions, restrictions, or comments related to this product authorization.',
    `authorization_number` STRING COMMENT 'Unique authorization number or certificate number issued for this producer-product authorization.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `authorization_status` STRING COMMENT 'Current status of the producers authorization to sell this product. Active indicates full selling authority; pending indicates approval in progress; suspended indicates temporary restriction; revoked indicates permanent removal; expired indicates authorization lapsed; inactive indicates not currently authorized.. Valid values are `active|pending|suspended|revoked|expired|inactive`',
    `authorized_states` STRING COMMENT 'Comma-separated list of state codes where the producer is authorized to sell this product. Null if authorization applies to all states where producer is licensed.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission schedule applicable to this producer for sales of this product.. Valid values are `^[A-Z0-9]{3,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this producer product authorization record was first created in the system.',
    `finra_registration_required_flag` BOOLEAN COMMENT 'Indicates whether FINRA registration is required to sell this product. True for variable products (VUL, variable annuities) that require securities licensing; False for traditional insurance products.',
    `finra_series_license_required` STRING COMMENT 'Comma-separated list of FINRA series licenses required to sell this product (e.g., Series 6, Series 7, Series 63, Series 65). Null if no FINRA registration required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this producer product authorization record was last updated in the system.',
    `maximum_case_size_amount` DECIMAL(18,2) COMMENT 'Maximum policy face amount or premium amount that the producer is authorized to write for this product without special approval. Null if no maximum applies.',
    `minimum_case_size_amount` DECIMAL(18,2) COMMENT 'Minimum policy face amount or premium amount that the producer is authorized to write for this product. Null if no minimum applies.',
    `override_commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether the producer is eligible to receive override commissions on downline sales of this product. True for producers with hierarchy management responsibilities (BGAs, MGAs, GAs); False for individual producers.',
    `pos_system_integration_flag` BOOLEAN COMMENT 'Indicates whether this authorization is integrated with the Point of Sale system for real-time product availability filtering. True if POS integration active; False if manual authorization verification required.',
    `renewal_reminder_sent_date` DATE COMMENT 'The date on which a renewal reminder was sent to the producer for this product authorization. Used for tracking training renewal and authorization maintenance communications.',
    `required_training_code` STRING COMMENT 'Code identifying the mandatory training program that must be completed before the producer can sell this product.. Valid values are `^[A-Z0-9]{3,10}$`',
    `restricted_states` STRING COMMENT 'Comma-separated list of state codes where the producer is explicitly restricted from selling this product despite having a general license.',
    `revocation_date` DATE COMMENT 'The date on which the producers authorization to sell this product was revoked. Null if authorization has not been revoked.',
    `revocation_reason_code` STRING COMMENT 'Code indicating the reason for authorization revocation (e.g., compliance violation, performance deficiency, voluntary surrender, license termination).. Valid values are `^[A-Z0-9]{2,6}$`',
    `revocation_reason_description` STRING COMMENT 'Detailed description of the reason for authorization revocation.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this producer product authorization record originated (e.g., Sapiens Commission, Annocera, FAST).. Valid values are `^[A-Z0-9]{2,10}$`',
    `state_specific_authorization_flag` BOOLEAN COMMENT 'Indicates whether this authorization is subject to state-specific restrictions or overrides. True if state-level authorization rules apply; False if authorization is uniform across all states.',
    `suspension_end_date` DATE COMMENT 'The date on which a temporary suspension of this product authorization is scheduled to end. Null if suspension is indefinite or authorization not suspended.',
    `suspension_reason` STRING COMMENT 'Description of the reason for temporary suspension of this product authorization (e.g., pending investigation, training renewal required, compliance review).',
    `suspension_start_date` DATE COMMENT 'The date on which a temporary suspension of this product authorization began. Null if authorization has not been suspended.',
    `training_completion_date` DATE COMMENT 'The date on which the producer completed the required training for this product authorization.',
    `training_compliance_status` STRING COMMENT 'Current compliance status of the producers training requirements for this product. Compliant indicates all training current; non-compliant indicates training deficiency; pending indicates training in progress; expired indicates certification lapsed.. Valid values are `compliant|non-compliant|pending|expired`',
    `training_expiration_date` DATE COMMENT 'The date on which the producers training certification expires and must be renewed to maintain authorization.',
    `underwriting_authority_level` STRING COMMENT 'Level of underwriting authority granted to the producer for this product. Standard indicates normal authority; limited indicates restricted authority requiring additional review; enhanced indicates expanded authority for simplified issue; full indicates complete underwriting discretion; none indicates no underwriting authority.. Valid values are `standard|limited|enhanced|full|none`',
    CONSTRAINT pk_producer_product_auth PRIMARY KEY(`producer_product_auth_id`)
) COMMENT 'Association table governing which specific insurance products (WL, UL, IUL, VUL, FIA, SPIA, DI, LTC) a producer is authorized to sell. Tracks product line authorization, authorization status, effective and expiration dates, required training completion, and state-specific authorization overrides. Prevents unauthorized product sales and supports POS system integration for product availability filtering.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`production_activity` (
    `production_activity_id` BIGINT COMMENT 'Unique identifier for the production activity record. Primary key for this table.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Production activity drives commission expenses that must be allocated to cost centers for expense accrual, distribution channel profitability analysis, and variance reporting—enables matching commissi',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Production tracking by specific product plan enables accurate sales reporting, producer performance analysis by product, commission calculation, and product profitability analysis. Essential for sales',
    `producer_id` BIGINT COMMENT 'Reference to the producer (agent, broker, BGA, MGA, GA) who generated this production activity.',
    `activity_period_end_date` DATE COMMENT 'The end date of the reporting period for this production activity record.',
    `activity_period_start_date` DATE COMMENT 'The start date of the reporting period for this production activity record (weekly, monthly, or quarterly).',
    `activity_status` STRING COMMENT 'Current status of this production activity record in the reporting workflow (draft, submitted, approved, or finalized).. Valid values are `draft|submitted|approved|finalized`',
    `annuity_count` STRING COMMENT 'Number of annuity contracts issued during this period.',
    `annuity_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for annuity contracts issued during this period.',
    `ape_amount` DECIMAL(18,2) COMMENT 'Annual Premium Equivalent representing the sum of regular annual premiums plus 10% of single premiums written during this period. Standard industry metric for measuring new business production.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this production activity record was approved by management or compliance.',
    `bonus_earned_amount` DECIMAL(18,2) COMMENT 'Total bonus amount earned by the producer during this period for meeting production targets or incentive qualifications.',
    `commission_earned_amount` DECIMAL(18,2) COMMENT 'Total commission amount earned by the producer during this period based on production activity.',
    `conservation_rate` DECIMAL(18,2) COMMENT 'Percentage of premium retained after accounting for lapses and surrenders. Measures the producers ability to conserve business.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this production activity record was first created in the system.',
    `distribution_channel` STRING COMMENT 'The distribution channel through which the producer operates (captive agent, independent agent, BGA, MGA, broker-dealer, bank channel, or direct). [ENUM-REF-CANDIDATE: captive_agent|independent_agent|bga|mga|broker_dealer|bank_channel|direct — 7 candidates stripped; promote to reference product]',
    `first_year_premium_amount` DECIMAL(18,2) COMMENT 'Total first-year premium amount for new business placed during this period.',
    `hierarchy_level` STRING COMMENT 'The producers position within the distribution hierarchy (producer, supervisor, manager, regional director, or national director).. Valid values are `producer|supervisor|manager|regional_director|national_director`',
    `issued_policy_count` STRING COMMENT 'Total number of policies issued and placed by the producer during this period.',
    `iul_count` STRING COMMENT 'Number of indexed universal life insurance policies issued during this period.',
    `iul_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for indexed universal life insurance policies issued during this period.',
    `lapse_count` STRING COMMENT 'Number of policies that lapsed during this period from the producers book of business.',
    `nigo_count` STRING COMMENT 'Number of applications submitted that were Not In Good Order (incomplete or missing required information) during this period.',
    `period_type` STRING COMMENT 'The frequency or type of reporting period for this production activity (weekly, monthly, quarterly, or annual).. Valid values are `weekly|monthly|quarterly|annual`',
    `persistency_ratio` DECIMAL(18,2) COMMENT 'Ratio of policies remaining in force to total policies issued, measuring retention performance. Calculated as (policies in force / policies issued) for the producers book of business.',
    `placement_rate` DECIMAL(18,2) COMMENT 'Ratio of issued policies to submitted applications, measuring the producers effectiveness in converting applications to issued policies.',
    `renewal_premium_amount` DECIMAL(18,2) COMMENT 'Total renewal premium amount collected on existing policies serviced by the producer during this period.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this production activity record originated (Policy Administration System or Agent and Commission Management System).',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when this production activity record was submitted for approval or finalization.',
    `submitted_application_count` STRING COMMENT 'Total number of new business applications submitted by the producer during this period.',
    `term_life_count` STRING COMMENT 'Number of term life insurance policies issued during this period.',
    `term_life_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for term life insurance policies issued during this period.',
    `total_face_amount` DECIMAL(18,2) COMMENT 'Total death benefit face amount placed by the producer during this period across all issued policies.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount collected or placed by the producer during this period across all products.',
    `universal_life_count` STRING COMMENT 'Number of universal life insurance policies issued during this period.',
    `universal_life_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for universal life insurance policies issued during this period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this production activity record was last modified or updated.',
    `vul_count` STRING COMMENT 'Number of variable universal life insurance policies issued during this period.',
    `vul_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for variable universal life insurance policies issued during this period.',
    `whole_life_count` STRING COMMENT 'Number of whole life insurance policies issued during this period.',
    `whole_life_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount for whole life insurance policies issued during this period.',
    CONSTRAINT pk_production_activity PRIMARY KEY(`production_activity_id`)
) COMMENT 'Periodic transactional records of producer sales production — new business submissions, placed policies, APE (Annual Premium Equivalent), face amount placed, product mix breakdown, and channel attribution. Each record represents a producers activity for a defined period (weekly, monthly, quarterly). Captures submitted application count, issued policy count, placed premium, lapse count, persistency ratio, and conservation rate. Feeds channel performance dashboards, incentive qualification calculations, and management reporting. Sourced from Policy Administration System and Agent and Commission Management System.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`incentive_program` (
    `incentive_program_id` BIGINT COMMENT 'Unique identifier for the incentive program record. Primary key.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Incentive programs frequently target specific product plans for promotional campaigns, new product launches, or inventory management. Required for program eligibility determination, qualification trac',
    `announcement_date` DATE COMMENT 'The date when the incentive program was officially announced to the distribution channel.',
    `award_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cash award amounts (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The total budget allocated for this incentive program including all reward costs and administrative expenses.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program budget amount.. Valid values are `^[A-Z]{3}$`',
    `cash_award_amount` DECIMAL(18,2) COMMENT 'The monetary value of the cash bonus component of the reward for base-level qualification. Null if reward does not include cash.',
    `communication_plan` STRING COMMENT 'Description of the communication strategy for promoting the program to eligible producers including channels, frequency, and key messages.',
    `compliance_notes` STRING COMMENT 'Free-text notes from compliance review including any conditions, restrictions, or special requirements for the program.',
    `compliance_review_date` DATE COMMENT 'The date when the compliance review was completed for this incentive program.',
    `compliance_review_status` STRING COMMENT 'The status of internal compliance review for the incentive program to ensure adherence to regulatory requirements and company policies.. Valid values are `pending|approved|rejected|conditional_approval`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the incentive program record was first created in the system.',
    `eligibility_criteria` STRING COMMENT 'Detailed description of the eligibility requirements producers must meet to participate in the program (e.g., active appointment status, minimum tenure, specific product lines, geographic territory).',
    `eligible_distribution_channel` STRING COMMENT 'The distribution channel(s) whose producers are eligible to participate in this incentive program. [ENUM-REF-CANDIDATE: career|independent|brokerage|bank|worksite|direct|all_channels — 7 candidates stripped; promote to reference product]',
    `eligible_producer_type` STRING COMMENT 'Comma-separated list of producer types eligible for this program (e.g., captive_agent, independent_agent, BGA, MGA, broker_dealer). [ENUM-REF-CANDIDATE: captive_agent|independent_agent|bga|mga|ga|broker_dealer|career_agent|independent_broker — promote to reference product]',
    `finra_approval_date` DATE COMMENT 'The date when FINRA approval was obtained for the incentive program. Null if FINRA approval is not required.',
    `finra_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the incentive program requires FINRA approval due to involvement of registered representatives selling variable products.',
    `payout_date` DATE COMMENT 'The scheduled date when rewards will be paid or distributed to qualifying producers. Null for programs with variable payout timing.',
    `payout_timing` STRING COMMENT 'The timing schedule for when rewards are distributed to qualifying producers.. Valid values are `immediate|quarterly|annual|upon_completion|deferred`',
    `production_metric_type` STRING COMMENT 'The type of production measurement used to determine qualification (e.g., Annual Premium Equivalent (APE), New Business Value (NBV), total premium volume, policy count, annuity account value, life insurance face amount).. Valid values are `ape|nbv|premium_volume|policy_count|account_value|face_amount`',
    `program_administrator` STRING COMMENT 'The name or identifier of the individual or team responsible for day-to-day administration of the incentive program.',
    `program_code` STRING COMMENT 'Unique business identifier code assigned to the incentive program for external reference and system integration.. Valid values are `^[A-Z0-9]{6,12}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the incentive program including objectives, rules, and special conditions.',
    `program_name` STRING COMMENT 'Full descriptive name of the incentive program (e.g., Presidents Club 2024, Q1 New Business Accelerator, MDRT Qualifier Program).',
    `program_sponsor` STRING COMMENT 'The business unit, department, or executive sponsor responsible for funding and overseeing the incentive program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the incentive program indicating its operational state.. Valid values are `draft|active|suspended|completed|cancelled|archived`',
    `program_type` STRING COMMENT 'Classification of the incentive program by its primary purpose and structure.. Valid values are `sales_contest|bonus_program|convention_qualification|club_membership|recognition_award|performance_incentive`',
    `qualification_period_end_date` DATE COMMENT 'The date when the qualification period for the incentive program ends. Production activity must occur on or before this date to count toward qualification.',
    `qualification_period_start_date` DATE COMMENT 'The date when the qualification period for the incentive program begins. Production activity on or after this date counts toward program qualification.',
    `qualification_threshold_amount` DECIMAL(18,2) COMMENT 'The minimum production amount required to qualify for the base level of the incentive program, measured in the unit specified by production_metric_type.',
    `reward_description` STRING COMMENT 'Detailed description of the reward(s) offered including cash amounts, trip destinations, merchandise items, or recognition benefits.',
    `reward_type` STRING COMMENT 'The primary type of reward offered to qualifying producers.. Valid values are `cash_bonus|trip|merchandise|points|recognition|mixed`',
    `source_system_code` STRING COMMENT 'The code identifying the source operational system from which this incentive program record originated (e.g., SAPIENS_COMM, ANNOCERA, CUSTOM_INCENTIVE).',
    `tax_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether the reward is subject to tax reporting requirements (e.g., IRS Form 1099-MISC reporting for cash bonuses or fair market value of non-cash prizes).',
    `threshold_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary qualification thresholds (e.g., USD, CAD, GBP). Null for non-monetary metrics.. Valid values are `^[A-Z]{3}$`',
    `tier_count` STRING COMMENT 'The number of qualification tiers in the program structure (e.g., Bronze, Silver, Gold, Platinum = 4 tiers). Null if tier_structure_flag is False.',
    `tier_definition` STRING COMMENT 'Structured description of each tier including tier name, threshold amount, and reward details. Typically stored as JSON or delimited text for parsing.',
    `tier_structure_flag` BOOLEAN COMMENT 'Indicates whether the program has multiple qualification tiers with escalating thresholds and rewards (True) or a single qualification level (False).',
    `tracking_system_code` STRING COMMENT 'The system or module code used to track producer progress and qualification status for this program (e.g., commission system module identifier, incentive tracking platform code).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the incentive program record was last modified in the system.',
    CONSTRAINT pk_incentive_program PRIMARY KEY(`incentive_program_id`)
) COMMENT 'Master and transactional records for producer incentive and recognition programs — sales contests, bonus programs, convention qualifications, and club memberships (e.g., MDRT qualifiers, Presidents Club). Tracks program definition (name, qualification period, eligibility criteria, production thresholds, reward type, tier structure) and individual producer qualification records (qualifying production amounts, period progress, current qualification status, award earned, payout date) identified by unique incentive_qualification_id. Links producers to programs and provides both the program structure and the transactional record of incentive achievement. Sourced from Agent and Commission Management System incentive tracking module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`agency` (
    `agency_id` BIGINT COMMENT 'Unique identifier for the agency legal entity in the distribution network.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Agency master agreements, amendments, and termination notices are legal documents requiring retention. Commission disputes, termination processing, and regulatory audits require access to executed age',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Agencies are organizational units that incur operating expenses (rent, staff, marketing) tracked in cost centers for agency-level P&L statements, overhead allocation, and distribution channel profitab',
    `distribution_channel_id` BIGINT COMMENT 'Foreign key linking to agent.distribution_channel. Business justification: Agencies operate through specific distribution channels. Currently agency.channel_type is a STRING attribute. Adding distribution_channel_id FK normalizes this to reference the distribution_channel ma',
    `eo_policy_id` BIGINT COMMENT 'Foreign key linking to agent.eo_policy. Business justification: Agencies have E&O coverage requirements. Currently agency has eo_policy_number (STRING) and eo_expiration_date but no FK to eo_policy table. Adding eo_policy_id FK links the agency to its E&O policy r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Agencies operate under specific legal entities for regulatory licensing, statutory financial reporting, commission payment processing, and legal liability—required for state DOI filings, financial con',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Agency principal officers are typically employees in career distribution models. Required for: management reporting hierarchy, compliance oversight accountability, organizational structure reporting, ',
    `parent_agency_id` BIGINT COMMENT 'Reference to the parent agency in multi-tier distribution hierarchies, enabling upline agency tracking for MGAs and BGAs.',
    `address_line_1` STRING COMMENT 'Primary street address line for the agencys principal place of business.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, or building information for the agencys principal place of business.',
    `agency_code` STRING COMMENT 'Carrier-assigned unique code for the agency used in policy administration and commission systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `agency_type` STRING COMMENT 'Classification of the agency entity: BGA (Brokerage General Agency), MGA (Managing General Agent), GA (General Agent), IMO (Independent Marketing Organization), NMO (National Marketing Organization), or Captive Agency.. Valid values are `BGA|MGA|GA|IMO|NMO|Captive Agency`',
    `annual_production_target` DECIMAL(18,2) COMMENT 'Target annual premium production amount (APE) set for the agency for the current calendar year.',
    `appointment_date` DATE COMMENT 'Date when the agency was first appointed by the carrier to sell insurance products.',
    `appointment_status` STRING COMMENT 'Current appointment status of the agency with the carrier for selling insurance products.. Valid values are `Appointed|Pending|Terminated|Suspended|Not Appointed`',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the agency.',
    `background_check_status` STRING COMMENT 'Status of the background check conducted on the agencys principal officer and key personnel.. Valid values are `Not Required|Pending|Cleared|Failed|Expired`',
    `broker_dealer_crd_number` STRING COMMENT 'FINRA CRD number of the broker-dealer firm the agency is affiliated with for variable product distribution.. Valid values are `^[0-9]{1,8}$`',
    `broker_dealer_name` STRING COMMENT 'Name of the broker-dealer firm the agency is affiliated with for variable product sales, if applicable.',
    `city` STRING COMMENT 'City where the agencys principal place of business is located.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission rate schedule applicable to this agency for product sales and renewals.. Valid values are `^[A-Z0-9]{3,10}$`',
    `contract_effective_date` DATE COMMENT 'Date when the agencys distribution contract with the carrier became effective.',
    `contract_number` STRING COMMENT 'Unique contract number assigned to the agencys distribution agreement with the carrier.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `contract_termination_date` DATE COMMENT 'Date when the agencys distribution contract was terminated, if applicable.',
    `contracting_status` STRING COMMENT 'Current status of the agencys contracting relationship with the carrier.. Valid values are `Active|Pending|Suspended|Terminated|Inactive`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the agencys principal place of business.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency record was first created in the system.',
    `dba_name` STRING COMMENT 'Trade name or DBA name under which the agency operates in the market, if different from legal name.',
    `domicile_state` STRING COMMENT 'Two-letter state code where the agency is legally domiciled and holds its primary business registration.. Valid values are `^[A-Z]{2}$`',
    `email_address` STRING COMMENT 'Primary business email address for agency communications and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `eo_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether the agency is required to maintain errors and omissions insurance coverage as a condition of appointment.',
    `finra_registration_required_flag` BOOLEAN COMMENT 'Indicates whether the agency must be FINRA-registered to sell variable life insurance and variable annuity products.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the distribution hierarchy where 1 is top-level (e.g., NMO) and higher numbers represent downstream tiers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency record was last updated in the system.',
    `legal_name` STRING COMMENT 'The official legal name of the agency as registered with state authorities and used in contracting.',
    `lifetime_production_amount` DECIMAL(18,2) COMMENT 'Total cumulative premium production amount (APE) generated by the agency since initial appointment.',
    `lines_of_authority` STRING COMMENT 'Comma-separated list of insurance lines the agency is authorized to sell (e.g., Life, Annuity, Accident and Health, Variable Products).',
    `onboarding_stage` STRING COMMENT 'Current stage in the agency onboarding and credentialing process.. Valid values are `Not Started|In Progress|Completed|On Hold`',
    `phone_number` STRING COMMENT 'Primary business phone number for the agency.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code for the agencys principal place of business.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `principal_officer_name` STRING COMMENT 'Full name of the principal officer or designated responsible party for the agency.',
    `state_code` STRING COMMENT 'Two-letter state code for the agencys principal place of business.. Valid values are `^[A-Z]{2}$`',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) issued by the IRS for tax reporting and commission payment purposes.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `termination_reason` STRING COMMENT 'Detailed reason for contract termination, including voluntary termination, compliance violations, or business restructuring.',
    `website_url` STRING COMMENT 'Public website URL for the agency, if available.',
    `ytd_production_amount` DECIMAL(18,2) COMMENT 'Cumulative premium production amount (APE) generated by the agency from beginning of year to current date.',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master record for agency legal entities in the distribution network — BGAs (Brokerage General Agencies), MGAs (Managing General Agents), GAs (General Agents), IMOs (Independent Marketing Organizations), and NMOs (National Marketing Organizations). Captures agency legal name, DBA name, agency type classification, federal tax ID (EIN), principal officer, domicile state, contracting status with the carrier, channel type, appointment status, and parent organization for multi-tier agency structures. Distinct from individual producer records — agencies are legal entities that employ or contract with individual producers.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` (
    `agency_producer_affiliation_id` BIGINT COMMENT 'Unique identifier for the agency-producer affiliation relationship record.',
    `agency_id` BIGINT COMMENT 'Reference to the agency organization in this affiliation relationship.',
    `contracting_id` BIGINT COMMENT 'Foreign key linking to agent.contracting. Business justification: Agency-producer affiliations reference formal contracting records. Currently affiliation has contract_number (STRING) and contract dates but no FK to contracting table. Adding contracting_id FK links ',
    `eo_policy_id` BIGINT COMMENT 'Foreign key linking to agent.eo_policy. Business justification: Agency-producer affiliations track E&O coverage. Currently affiliation has errors_and_omissions_policy_number (STRING) and expiration_date but no FK to eo_policy table. Adding eo_policy_id FK links th',
    `producer_id` BIGINT COMMENT 'Reference to the individual producer in this affiliation relationship.',
    `affiliation_notes` STRING COMMENT 'Free-form text field for capturing additional information, special circumstances, or administrative notes related to this agency-producer affiliation. Used for internal documentation and context.',
    `affiliation_status` STRING COMMENT 'Current lifecycle status of the agency-producer affiliation. Active indicates the relationship is in force, inactive indicates temporarily not producing, suspended indicates regulatory or compliance hold, pending indicates awaiting approval or onboarding completion, terminated indicates relationship has ended.. Valid values are `active|inactive|suspended|pending|terminated`',
    `affiliation_type` STRING COMMENT 'Classification of the relationship between the producer and agency. Employed indicates W-2 employee status, contracted indicates 1099 independent contractor, sub-agent indicates hierarchical sub-relationship, independent indicates non-exclusive arrangement, captive indicates exclusive arrangement, broker indicates broker-dealer relationship.. Valid values are `employed|contracted|sub_agent|independent|captive|broker`',
    `annual_production_target` DECIMAL(18,2) COMMENT 'Target annual production volume in Annual Premium Equivalent (APE) or premium dollars assigned to this producer within this agency affiliation. Used for performance management and incentive qualification.',
    `anti_money_laundering_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the producer has completed required Anti-Money Laundering training for this agency affiliation. True if completed, false if not. Required under Bank Secrecy Act and USA PATRIOT Act.',
    `anti_money_laundering_training_date` DATE COMMENT 'Date when the producer completed Anti-Money Laundering training for this agency affiliation. Used for compliance tracking and renewal scheduling.',
    `background_check_completed_flag` BOOLEAN COMMENT 'Indicates whether a background check was completed for this producer as part of the agency affiliation onboarding process. True if completed, false if not.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed for this producer within this agency affiliation.',
    `background_check_status` STRING COMMENT 'Result status of the background check. Passed indicates cleared for affiliation, failed indicates issues identified, pending indicates in progress, waived indicates not required or exempted.. Valid values are `passed|failed|pending|waived`',
    `broker_dealer_crd_number` STRING COMMENT 'FINRA CRD number of the broker-dealer firm associated with this agency affiliation. Used for regulatory reporting and compliance verification.',
    `broker_dealer_name` STRING COMMENT 'Name of the broker-dealer firm through which the producer is registered for variable product sales within this agency affiliation. Required when variable_products_authorized_flag is true.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission rate schedule or compensation plan applicable to this producer within this agency affiliation. Links to commission rate tables for calculating producer compensation on new business and renewals.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency-producer affiliation record was first created in the system. Used for audit trail and data lineage tracking.',
    `distribution_channel` STRING COMMENT 'Classification of the distribution channel through which this producer operates within the agency. Career indicates captive career agents, independent indicates independent agents, BGA indicates Brokerage General Agency, MGA indicates Managing General Agent, broker_dealer indicates registered representatives, bank indicates bank channel, worksite indicates worksite marketing. [ENUM-REF-CANDIDATE: career|independent|bga|mga|broker_dealer|bank|worksite — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date when the agency-producer affiliation relationship became active and the producer was authorized to represent the agency.',
    `errors_and_omissions_coverage_required_flag` BOOLEAN COMMENT 'Indicates whether errors and omissions professional liability insurance coverage is required for this producer within this agency affiliation. True if required, false if not. Requirements vary by state and agency policy.',
    `finra_crd_number` STRING COMMENT 'The producers FINRA Central Registration Depository number associated with this agency affiliation. Required for producers selling variable products. Links to FINRA BrokerCheck system.',
    `finra_registration_required_flag` BOOLEAN COMMENT 'Indicates whether FINRA registration is required for this producer within this agency affiliation based on the products they are authorized to sell. True if FINRA registration required, false if not.',
    `hierarchy_level` STRING COMMENT 'Numeric indicator of the producers position within the agencys organizational hierarchy. Level 1 typically represents direct agency producers, higher numbers indicate sub-agent or downline positions. Used for commission override calculations and reporting rollups.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agency-producer affiliation record was last updated in the system. Used for audit trail and change tracking.',
    `lines_of_authority` STRING COMMENT 'Comma-separated list of insurance lines of authority the producer is authorized to sell through this agency affiliation. Examples include life, accident and health, variable products, annuities. Must align with producers active licenses.',
    `onboarding_completion_date` DATE COMMENT 'Date when the producer completed all required onboarding activities for this agency affiliation, including training, compliance certifications, system access setup, and contract execution.',
    `override_eligible_flag` BOOLEAN COMMENT 'Indicates whether the producer is eligible to receive override commissions on production from downline producers in the hierarchy. True if eligible for overrides, false if not. Typically true for Managing General Agents (MGA), General Agents (GA), and Brokerage General Agents (BGA).',
    `primary_agency_flag` BOOLEAN COMMENT 'Indicates whether this agency is the producers primary or home agency affiliation. True for primary agency, false for secondary or additional affiliations. Used in multi-agency affiliation scenarios common in independent distribution channels.',
    `production_credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of production volume credited to this agency for this producers sales. Used in split-credit scenarios where a producer has multiple agency affiliations. Value between 0.00 and 100.00.',
    `suitability_training_completed_flag` BOOLEAN COMMENT 'Indicates whether the producer has completed required suitability and best interest training for this agency affiliation. True if completed, false if not. Required under NAIC Suitability in Annuity Transactions Model Regulation and state insurance regulations.',
    `suitability_training_date` DATE COMMENT 'Date when the producer completed suitability and best interest training for this agency affiliation. Used for compliance tracking and renewal scheduling.',
    `termination_date` DATE COMMENT 'Date when the agency-producer affiliation relationship ended. Null for active affiliations.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for affiliation termination. Voluntary indicates producer-initiated separation, involuntary indicates agency-initiated separation, retirement indicates producer retirement, relocation indicates geographic move, performance indicates production or quality issues, compliance indicates regulatory or policy violations, license_revocation indicates loss of required licensing. [ENUM-REF-CANDIDATE: voluntary|involuntary|retirement|relocation|performance|compliance|license_revocation — 7 candidates stripped; promote to reference product]',
    `termination_reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and reasons for affiliation termination. Used for internal documentation and regulatory reporting.',
    `variable_products_authorized_flag` BOOLEAN COMMENT 'Indicates whether the producer is authorized to sell variable life insurance and variable annuity products through this agency affiliation. True if authorized, false if not. Requires active FINRA registration and broker-dealer affiliation.',
    CONSTRAINT pk_agency_producer_affiliation PRIMARY KEY(`agency_producer_affiliation_id`)
) COMMENT 'Association table capturing the relationship between individual producers and the agencies they are affiliated with. Tracks affiliation type (employed, contracted, sub-agent), effective and termination dates, primary agency flag, override eligibility, and hierarchy level within the agency. Supports multi-agency affiliation scenarios common in independent distribution channels.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`compliance_event` (
    `compliance_event_id` BIGINT COMMENT 'Unique identifier for the compliance event record. Primary key for the compliance event entity.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to agent.appointment. Business justification: Compliance events can impact specific appointments (tracked via appointment_impact_action field). This FK links the compliance event to the affected appointment record. No columns removed because comp',
    `contracting_id` BIGINT COMMENT 'Foreign key linking to agent.contracting. Business justification: Compliance events can impact producer contracting status (tracked via contracting_impact_flag field). This FK links the compliance event to the affected contracting record. No columns removed because ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance events involving employee-producers require HR coordination. Required for: disciplinary action cross-reference, termination processing, regulatory reporting (SAR filings), background check ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: When external_counsel_engaged_flag is true, the law firm engaged is a vendor providing legal services for regulatory matters. Legal operations and finance need this link for matter management, cost al',
    `finra_registration_id` BIGINT COMMENT 'Foreign key linking to agent.finra_registration. Business justification: Compliance events involving FINRA disclosures should reference the specific FINRA registration record. The finra_crd_number can be retrieved from the finra_registration table via this FK, eliminating ',
    `license_id` BIGINT COMMENT 'Foreign key linking to agent.license. Business justification: Compliance events can impact producer licenses (tracked via license_impact_flag field). This FK links the compliance event to the affected license record. No columns removed because compliance_event t',
    `producer_id` BIGINT COMMENT 'Reference to the producer (agent, broker, BGA, MGA, GA) who is the subject of this compliance event.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Compliance investigations and regulatory events require supporting documentation (complaint letters, investigation reports, resolution agreements, state filings). Regulatory audits and legal proceedin',
    `aml_sar_filed_flag` BOOLEAN COMMENT 'Indicator of whether a Suspicious Activity Report was filed with FinCEN as a result of this compliance event.',
    `appointment_impact_action` STRING COMMENT 'The specific action taken or recommended regarding the producers appointment status as a result of this compliance event.. Valid values are `none|suspension|termination|restriction|monitoring`',
    `contracting_impact_flag` BOOLEAN COMMENT 'Indicator of whether this compliance event has resulted in or may result in changes to the producers contracting status, appointment status, or selling authority.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance event record was first created in the system.',
    `escalation_date` DATE COMMENT 'The date on which the compliance event was escalated to senior management or other oversight bodies.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicator of whether this compliance event requires escalation to senior management, legal counsel, or the board of directors due to its severity or potential impact.',
    `event_date` DATE COMMENT 'The date on which the compliance event occurred or was first identified by the regulatory authority or internal compliance team.',
    `event_number` STRING COMMENT 'Business identifier or case number assigned to this compliance event by the originating authority or internal compliance system.',
    `event_status` STRING COMMENT 'Current lifecycle status of the compliance event indicating its resolution state and whether further action is required.. Valid values are `open|under_investigation|pending_remediation|resolved|closed`',
    `event_type` STRING COMMENT 'Classification of the compliance event indicating the nature of the compliance issue or regulatory action.. Valid values are `doi_complaint|finra_disciplinary_action|regulatory_investigation|aml_suspicious_activity|suitability_violation|market_conduct_finding`',
    `external_counsel_engaged_flag` BOOLEAN COMMENT 'Indicator of whether external legal counsel was engaged to assist with the investigation, defense, or resolution of this compliance event.',
    `finra_disclosure_required_flag` BOOLEAN COMMENT 'Indicator of whether this compliance event must be disclosed on the producers FINRA Form U4 or BrokerCheck profile.',
    `internal_case_owner` STRING COMMENT 'The name or identifier of the internal compliance officer or team responsible for managing and resolving this compliance event.',
    `jurisdiction_state` STRING COMMENT 'The US state or territory under whose regulatory jurisdiction this compliance event falls, relevant for state DOI complaints and licensing actions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance event record was most recently updated or modified.',
    `license_impact_flag` BOOLEAN COMMENT 'Indicator of whether this compliance event has resulted in or may result in changes to the producers state insurance license status.',
    `monetary_penalty_amount` DECIMAL(18,2) COMMENT 'The dollar amount of any fine, penalty, or restitution assessed against the producer or the company as a result of this compliance event.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, context, or internal commentary regarding the compliance event, its investigation, or resolution.',
    `penalty_paid_date` DATE COMMENT 'The date on which any assessed monetary penalty or restitution was paid in full.',
    `regulatory_citation` STRING COMMENT 'The specific statute, regulation, rule, or code section that was allegedly violated or is the basis for the compliance event (e.g., FINRA Rule 2111, State Insurance Code Section).',
    `remediation_action_required` STRING COMMENT 'Description of the corrective or remedial actions required to resolve the compliance event, such as retraining, policy changes, restitution, or contract termination.',
    `remediation_completion_date` DATE COMMENT 'The date on which all required remediation actions were completed and verified by the compliance team or regulatory authority.',
    `reported_date` DATE COMMENT 'The date on which the compliance event was formally reported to the company or regulatory authority.',
    `resolution_date` DATE COMMENT 'The date on which the compliance event was formally resolved or closed, either through remediation, regulatory clearance, or administrative closure.',
    `resolution_status` STRING COMMENT 'The current state of resolution efforts for the compliance event, indicating whether remediation has been completed or is ongoing.. Valid values are `pending|in_progress|resolved_no_action|resolved_with_remediation|escalated`',
    `sar_filing_date` DATE COMMENT 'The date on which the Suspicious Activity Report was filed with FinCEN, if applicable.',
    `severity_level` STRING COMMENT 'The assessed severity or risk level of the compliance event, indicating the potential impact on the producers contracting status and the companys regulatory standing.. Valid values are `critical|high|medium|low`',
    `source_authority` STRING COMMENT 'The regulatory body, government agency, or internal department that originated or reported the compliance event (e.g., State DOI, FINRA, FinCEN, Internal Compliance).',
    `source_authority_type` STRING COMMENT 'Classification of the source authority indicating the type of regulatory or oversight body that originated the event.. Valid values are `state_doi|finra|fincen|sec|internal_compliance|other`',
    `source_system_code` STRING COMMENT 'The code or identifier of the operational system from which this compliance event record originated (e.g., Agent Commission System, Compliance Management System).',
    `violation_description` STRING COMMENT 'Detailed narrative description of the compliance violation, regulatory finding, or suspicious activity that triggered this event.',
    CONSTRAINT pk_compliance_event PRIMARY KEY(`compliance_event_id`)
) COMMENT 'Operational records of producer-specific compliance events that directly impact a producers ability to sell — state DOI complaints, FINRA disciplinary actions, regulatory investigations, AML suspicious activity flags, suitability violations, and market conduct examination findings. Tracks event type, source authority (state DOI, FINRA, FinCEN), event date, severity, resolution status, remediation action required, and downstream impact on contracting or appointment status. Scoped strictly to agent-domain operational tracking; enterprise-wide compliance program management, regulatory filing calendars, and compliance policy definitions reside in the compliance domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` (
    `agent_bulk_comm_recipient_id` BIGINT COMMENT 'Primary key for agent_bulk_comm_recipient',
    `bulk_comm_campaign_id` BIGINT COMMENT 'Foreign key linking to the bulk communication campaign in which this producer was included as a recipient.',
    `correspondence_bulk_comm_recipient_id` BIGINT COMMENT 'Unique identifier for this bulk communication recipient record. Primary key for the association.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to the producer who is the recipient of this bulk communication campaign.',
    `delivery_outcome_code` STRING COMMENT 'Final outcome code for the delivery attempt to this producer, indicating success or specific failure reason.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was confirmed as delivered to this producers address.',
    `dispatch_status` STRING COMMENT 'Current status of the communication dispatch for this specific producer-campaign pair. Tracks the lifecycle from queuing through final dispatch or suppression.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was dispatched to this specific producer.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the producer opened or viewed the communication (for email or digital channels with tracking capability).',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the producer has opted out of receiving this type of communication, captured at the time of campaign execution.',
    `recipient_sequence_number` BIGINT COMMENT 'Sequential number assigned to this recipient within the campaign batch for tracking and reconciliation purposes.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this producer was suppressed from receiving this campaign due to opt-out status, invalid contact information, or business rules.',
    CONSTRAINT pk_agent_bulk_comm_recipient PRIMARY KEY(`agent_bulk_comm_recipient_id`)
) COMMENT 'This association product represents the delivery event between a producer and a bulk communication campaign. It captures the operational record of each producers inclusion in a bulk correspondence campaign, tracking dispatch status, delivery outcomes, engagement metrics, and opt-out preferences. Each record links one producer to one bulk_comm_campaign with attributes that exist only in the context of this specific campaign delivery.. Existence Justification: In life insurance operations, bulk communication campaigns (regulatory notices, compliance alerts, product updates) are dispatched to multiple producers simultaneously, and each producer receives multiple campaigns over their lifecycle. The correspondence domain actively manages recipient lists, tracks delivery status per producer-campaign pair, monitors engagement metrics, and maintains opt-out preferences. This is an operational M:N relationship where the business creates, monitors, and reports on individual recipient records.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` (
    `producer_product_authorization_id` BIGINT COMMENT 'Primary key for producer_product_authorization',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the product plan that the producer is authorized to sell',
    `producer_id` BIGINT COMMENT 'Foreign key linking to the producer who is authorized to sell the product plan',
    `authorization_code` BIGINT COMMENT 'Unique identifier for this producer-product authorization record. Primary key.',
    `authorization_effective_date` DATE COMMENT 'The date on which the producers authorization to sell this product plan becomes effective. Used for compliance tracking and commission eligibility.',
    `authorization_expiration_date` DATE COMMENT 'The date on which the producers authorization to sell this product plan expires. Null indicates no expiration. Used for renewal tracking and compliance.',
    `authorization_status` STRING COMMENT 'Current status of the producers authorization to sell this product plan. Active indicates the producer can currently sell the product. Pending indicates authorization is in process. Suspended indicates temporary restriction. Revoked indicates permanent removal of authorization. Expired indicates authorization period has ended.',
    `authorized_states` STRING COMMENT 'Comma-separated list of two-letter state codes where the producer is authorized to sell this specific product plan. Used when state_specific_authorization_flag is true. Must align with state insurance department approvals and producer licensing.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission rate schedule assigned to this producer for this specific product plan. Commission rates can vary by producer-product combination based on production volume, producer type, and negotiated agreements.',
    `state_specific_authorization_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this authorization is restricted to specific states rather than being a blanket authorization across all states where the producer is licensed.',
    `training_completion_date` DATE COMMENT 'The date on which the producer completed required product-specific training for this product plan. Many complex products (IUL, VUL, FIA) require specialized training before producers can sell them. Used for compliance and authorization eligibility.',
    `underwriting_authority_level` STRING COMMENT 'The level of underwriting authority granted to this producer for this product plan. None indicates no authority (all cases go to underwriting). Limited indicates authority up to a certain face amount or simplified issue only. Standard indicates normal authority. Enhanced indicates higher limits. Full indicates maximum authority including jumbo cases. Authority levels vary by producer experience, production history, and product complexity.',
    CONSTRAINT pk_producer_product_authorization PRIMARY KEY(`producer_product_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between producers and product plans. It captures state-specific selling permissions, training requirements, commission schedules, and underwriting authority levels. Each record links one producer to one product plan with attributes that exist only in the context of this authorization relationship.. Existence Justification: In life insurance distribution, producers are authorized to sell multiple product plans, and each product plan is sold by multiple producers. The authorization relationship is actively managed by the business through state-specific permissions, product-specific training requirements, commission schedule assignments, and underwriting authority levels. This is not a simple reference but an operational business entity that compliance, sales operations, and commission systems actively create, update, and query.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`program_participation` (
    `program_participation_id` BIGINT COMMENT 'Unique identifier for this producers participation record in a specific incentive program. Primary key for the association.',
    `incentive_program_id` BIGINT COMMENT 'Foreign key linking to the incentive program in which the producer is participating',
    `producer_id` BIGINT COMMENT 'Foreign key linking to the producer participating in the incentive program',
    `award_amount` DECIMAL(18,2) COMMENT 'The monetary value of the award earned by this producer for this program participation. Explicitly identified in detection reasoning as relationship data.',
    `award_payout_date` DATE COMMENT 'The date when the award was paid or is scheduled to be paid to the producer for this program. Explicitly identified in detection reasoning as relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was created in the source system.',
    `enrollment_date` DATE COMMENT 'The date when the producer was enrolled or registered for participation in this incentive program. Tracks when the participation relationship was established.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this participation record was last modified in the source system.',
    `participation_status` STRING COMMENT 'Current lifecycle status of the producers participation in this program. Values include Active, Withdrawn, Completed, Disqualified, Suspended.',
    `production_amount_qualifying` DECIMAL(18,2) COMMENT 'The total production amount credited to this producer for qualification purposes in this specific program. Explicitly identified in detection reasoning as relationship data.',
    `qualification_date` DATE COMMENT 'The date when the producer achieved qualification for this incentive program. Explicitly identified in detection reasoning as relationship data.',
    `qualification_status` STRING COMMENT 'Current status of the producers qualification for this program. Explicitly identified in detection reasoning as relationship data. Values include Qualified, Not Qualified, In Progress, Pending Review, Disqualified.',
    `ranking` STRING COMMENT 'The producers ranking position among all participants in this incentive program based on qualifying production. Explicitly identified in detection reasoning as relationship data.',
    `tier_achieved` STRING COMMENT 'The specific tier level achieved by the producer in this program (e.g., Bronze, Silver, Gold, Platinum). Explicitly identified in detection reasoning as relationship data. Applicable when the program has tier_structure_flag = true.',
    CONSTRAINT pk_program_participation PRIMARY KEY(`program_participation_id`)
) COMMENT 'This association product represents the participation relationship between producers and incentive programs. It captures the operational record of a producers enrollment, qualification tracking, and award achievement within a specific incentive program. Each record links one producer to one incentive program with attributes that exist only in the context of this participation relationship, including qualification status, production amounts, tier achievement, and award details.. Existence Justification: In life insurance distribution, producers routinely participate in multiple incentive programs simultaneously (e.g., a producer can be enrolled in a Q1 sales contest, an annual Presidents Club qualification, and a product-specific bonus program all at the same time). Conversely, each incentive program has hundreds or thousands of producer participants. The business actively manages these participation relationships as operational entities, tracking each producers qualification progress, status, production amounts, tier achievement, and award payouts for each program independently.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` (
    `agent_training_completion_id` BIGINT COMMENT 'Primary key for agent_training_completion',
    `producer_id` BIGINT COMMENT 'Foreign key linking to the producer who completed the training course',
    `compliance_training_completion_id` BIGINT COMMENT 'Unique surrogate identifier for each training completion record. Primary key for the association.',
    `training_course_id` BIGINT COMMENT 'Foreign key linking to the training course that was completed',
    `attempt_number` STRING COMMENT 'Sequential number indicating which attempt this represents for this producer-course combination. Used to enforce max_attempts_allowed business rules.',
    `certificate_number` STRING COMMENT 'Unique certificate identifier issued upon successful completion. Used for audit verification and regulatory demonstration.',
    `completion_date` DATE COMMENT 'Date on which the producer successfully completed the training course. Used for regulatory reporting and expiration calculation.',
    `completion_method` STRING COMMENT 'The specific delivery method used for this completion instance. May differ from the courses defined delivery_method if multiple modalities are offered.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this completion record was created in the compliance system.',
    `delivery_platform` STRING COMMENT 'Name of the learning management system or platform through which this specific completion was delivered (e.g., Cornerstone, Skillsoft, in-person classroom). May differ from the courses primary delivery_platform if multiple modalities are supported.',
    `expiration_date` DATE COMMENT 'Date on which this training completion expires and renewal is required. Calculated from completion_date plus renewal_frequency_months from the course definition. Null if course does not require renewal.',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator for instructor-led or classroom training completions. Null for self-paced online courses.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this completion record was last modified.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the producer passed or failed the training course assessment. Only PASS records satisfy regulatory requirements.',
    `score_achieved` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved by the producer on the course assessment. Used to determine pass/fail status against the passing_score_threshold defined in the course.',
    CONSTRAINT pk_agent_training_completion PRIMARY KEY(`agent_training_completion_id`)
) COMMENT 'This association product represents the completion event between a producer and a training course. It captures the regulatory and operational record of each instance when a licensed producer completes a compliance training course. Each record links one producer to one training course with completion-specific attributes including date, score, pass/fail status, certificate number, and expiration tracking. This serves as the single source of truth for demonstrating regulatory compliance with AML, HIPAA, suitability, ethics, and continuing education requirements.. Existence Justification: In life insurance operations, producers must complete multiple training courses over their career (initial onboarding, annual CE requirements, product-specific training, AML/HIPAA renewals), and each training course is completed by many producers across the distribution network. The business actively manages training completion as a distinct operational entity with its own lifecycle: completion records are created when producers finish courses, tracked for expiration, queried for compliance audits, and used to determine producer licensing eligibility.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`termination_event` (
    `termination_event_id` BIGINT COMMENT 'Primary key for termination_event',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to agent.appointment. Business justification: Termination events may terminate specific appointments. Currently termination_event does not have appointment_id. Adding this FK allows tracking which appointment is being terminated. No columns to re',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved the termination decision.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified this termination event record.',
    `producer_id` BIGINT COMMENT 'Identifier of the agent whose contract or appointment is being terminated.',
    `successor_agent_producer_id` BIGINT COMMENT 'Identifier of the agent who is taking over the terminated agents book of business and client relationships.',
    `reinstated_termination_event_id` BIGINT COMMENT 'Self-referencing FK on termination_event (reinstated_termination_event_id)',
    `approval_date` DATE COMMENT 'The date on which the termination was formally approved by management or compliance.',
    `book_of_business_transfer_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the agents book of business (client policies) is being transferred to another agent.',
    `book_transfer_effective_date` DATE COMMENT 'The date on which the book of business transfer to the successor agent becomes effective.',
    `commission_payout_status` STRING COMMENT 'Status of outstanding commission payments owed to the agent at the time of termination.',
    `contract_end_date` DATE COMMENT 'The final date of the agents contract or appointment, which may differ from the termination effective date in cases of notice periods.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this termination event record was first created in the system.',
    `exit_interview_completed_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether an exit interview was conducted with the agent as part of the termination process.',
    `exit_interview_date` DATE COMMENT 'The date on which the exit interview with the terminated agent was conducted.',
    `final_commission_payout_date` DATE COMMENT 'The date on which the final commission payment was or will be issued to the terminated agent.',
    `finra_form_u5_filed_date` DATE COMMENT 'The date on which FINRA Form U5 (Uniform Termination Notice for Securities Industry Registration) was filed for this agent termination.',
    `finra_reportable_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this termination must be reported to FINRA due to the agents registration for variable product sales.',
    `for_cause_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the termination was for cause (due to misconduct, policy violation, or performance failure) versus without cause.',
    `initiated_by` STRING COMMENT 'Indicates which party initiated the termination: the agent, the company, mutual agreement, or a regulatory authority.',
    `initiating_party_name` STRING COMMENT 'Name of the specific individual or department that initiated the termination process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this termination event record was most recently updated or modified.',
    `notice_period_days` STRING COMMENT 'Number of days of notice provided or required between termination notification and effective date, as specified in the agent contract.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or state insurance department to which the termination was reported.',
    `regulatory_report_date` DATE COMMENT 'The date on which the termination was reported to the relevant regulatory authority, if applicable.',
    `regulatory_reportable_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this termination event must be reported to state insurance departments or regulatory authorities.',
    `rehire_eligible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the terminated agent is eligible for future rehire or reappointment with the company.',
    `severance_amount` DECIMAL(18,2) COMMENT 'Total monetary severance payment provided to the agent upon termination, if applicable.',
    `severance_eligible_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the agent is eligible for severance pay or benefits as part of the termination.',
    `termination_effective_date` DATE COMMENT 'The date on which the agent termination becomes legally and operationally effective, marking the end of the agents active status.',
    `termination_notes` STRING COMMENT 'Internal confidential notes and comments regarding the termination event, including any special circumstances or follow-up actions required.',
    `termination_notification_date` DATE COMMENT 'The date on which the agent was formally notified of the termination decision.',
    `termination_number` STRING COMMENT 'Business-facing unique identifier for the termination event, used in correspondence and reporting.',
    `termination_reason_code` STRING COMMENT 'Standardized code representing the specific reason for termination (e.g., performance, compliance violation, business restructure, personal reasons).',
    `termination_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the agent termination, providing context beyond the reason code.',
    `termination_request_date` DATE COMMENT 'The date on which the termination was initially requested or initiated, either by the agent or the company.',
    `termination_status` STRING COMMENT 'Current workflow status of the termination event indicating its stage in the termination process.',
    `termination_type` STRING COMMENT 'Classification of the termination event indicating whether it was voluntary, involuntary, mutual agreement, contract expiration, regulatory action, death, or retirement.',
    CONSTRAINT pk_termination_event PRIMARY KEY(`termination_event_id`)
) COMMENT 'Master reference table for termination_event. Referenced by termination_event_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`agent`.`distribution_channel` (
    `distribution_channel_id` BIGINT COMMENT 'Primary key for distribution_channel',
    `parent_channel_id` BIGINT COMMENT 'Reference to the parent distribution channel in a multi-level hierarchy (e.g., an independent agent under an MGA).',
    `parent_distribution_channel_id` BIGINT COMMENT 'Self-referencing FK on distribution_channel (parent_distribution_channel_id)',
    `annual_production_target` DECIMAL(18,2) COMMENT 'Target annual premium production amount in USD for this distribution channel, used for performance tracking and incentive calculations.',
    `appointment_date` DATE COMMENT 'Date when the distribution channel was appointed by the carrier to sell insurance products.',
    `appointment_status` STRING COMMENT 'Current appointment status of the distribution channel with the insurance carrier, indicating authorization to sell products.',
    `business_address_line1` STRING COMMENT 'First line of the distribution channel business address including street number and name.',
    `business_address_line2` STRING COMMENT 'Second line of the business address for suite, floor, or additional location details.',
    `business_city` STRING COMMENT 'City name of the distribution channel business location.',
    `business_country_code` STRING COMMENT 'Three-letter ISO country code for the distribution channel business location.',
    `business_postal_code` STRING COMMENT 'Postal or ZIP code for the distribution channel business location.',
    `business_state_province` STRING COMMENT 'Two-letter state or province code for the distribution channel business location.',
    `channel_code` STRING COMMENT 'Unique business identifier code for the distribution channel used in operational systems and reporting.',
    `channel_name` STRING COMMENT 'Full business name of the distribution channel.',
    `channel_status` STRING COMMENT 'Current lifecycle status of the distribution channel indicating operational availability.',
    `channel_tier` STRING COMMENT 'Strategic tier classification of the channel based on production volume, relationship depth, and business importance.',
    `channel_type` STRING COMMENT 'Classification of the distribution channel. BGA = Brokerage General Agency, MGA = Managing General Agency, GA = General Agency.',
    `commission_structure_type` STRING COMMENT 'Type of commission structure applied to this distribution channel for compensation calculations.',
    `contract_effective_date` DATE COMMENT 'Date when the current distribution contract became effective.',
    `contract_expiration_date` DATE COMMENT 'Date when the current distribution contract expires or is scheduled for renewal.',
    `contracting_status` STRING COMMENT 'Current status of the contractual relationship between the carrier and the distribution channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution channel record was first created in the system.',
    `default_commission_rate` DECIMAL(18,2) COMMENT 'Default commission rate percentage applied to sales through this channel, expressed as a decimal (e.g., 0.0750 for 7.5%).',
    `effective_date` DATE COMMENT 'Date when the distribution channel relationship became active and operational.',
    `errors_omissions_coverage_flag` BOOLEAN COMMENT 'Indicates whether the distribution channel maintains active Errors and Omissions insurance coverage.',
    `errors_omissions_expiration_date` DATE COMMENT 'Expiration date of the current Errors and Omissions insurance policy.',
    `errors_omissions_policy_number` STRING COMMENT 'Policy number for the Errors and Omissions insurance coverage held by the distribution channel.',
    `finra_crd_number` STRING COMMENT 'FINRA Central Registration Depository number for broker-dealer channels authorized to sell variable products.',
    `finra_registered_flag` BOOLEAN COMMENT 'Indicates whether the distribution channel is registered with FINRA for selling variable insurance products and securities.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the distribution hierarchy structure, with 1 being the top level (e.g., MGA) and higher numbers representing downstream levels.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review or audit conducted for this distribution channel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution channel record was last updated in the system.',
    `licensing_jurisdiction` STRING COMMENT 'Primary state or jurisdiction where the distribution channel holds insurance licenses. Multiple jurisdictions may be tracked in related licensing tables.',
    `next_compliance_review_date` DATE COMMENT 'Scheduled date for the next compliance review or audit of this distribution channel.',
    `onboarding_completion_date` DATE COMMENT 'Date when the distribution channel completed all onboarding requirements including training, compliance, and system setup.',
    `pos_system_code` STRING COMMENT 'External system identifier for the distribution channel in the point-of-sale platform.',
    `pos_system_integration_flag` BOOLEAN COMMENT 'Indicates whether the distribution channel is integrated with the carrier point-of-sale system for electronic application submission.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for channel communications and notifications.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact for this distribution channel.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the distribution channel contact.',
    `product_authorization_scope` STRING COMMENT 'Description of the product lines and types this distribution channel is authorized to sell (e.g., term life, whole life, annuities, variable products).',
    `termination_date` DATE COMMENT 'Date when the distribution channel relationship was terminated or is scheduled to terminate. Null for active channels.',
    `ytd_production_amount` DECIMAL(18,2) COMMENT 'Cumulative premium production amount in USD for the current calendar year through this distribution channel.',
    CONSTRAINT pk_distribution_channel PRIMARY KEY(`distribution_channel_id`)
) COMMENT 'Master reference table for distribution_channel. Referenced by distribution_channel_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ADD CONSTRAINT `fk_agent_producer_parent_producer_id` FOREIGN KEY (`parent_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ADD CONSTRAINT `fk_agent_license_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_appointment_upline_agent_producer_id` FOREIGN KEY (`appointment_upline_agent_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_eo_policy_id` FOREIGN KEY (`eo_policy_id`) REFERENCES `life_insurance_ecm`.`agent`.`eo_policy`(`eo_policy_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_finra_registration_id` FOREIGN KEY (`finra_registration_id`) REFERENCES `life_insurance_ecm`.`agent`.`finra_registration`(`finra_registration_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ADD CONSTRAINT `fk_agent_appointment_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ADD CONSTRAINT `fk_agent_hierarchy_node_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ADD CONSTRAINT `fk_agent_hierarchy_node_parent_node_hierarchy_node_id` FOREIGN KEY (`parent_node_hierarchy_node_id`) REFERENCES `life_insurance_ecm`.`agent`.`hierarchy_node`(`hierarchy_node_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ADD CONSTRAINT `fk_agent_hierarchy_node_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_contracting_upline_agent_producer_id` FOREIGN KEY (`contracting_upline_agent_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_eo_policy_id` FOREIGN KEY (`eo_policy_id`) REFERENCES `life_insurance_ecm`.`agent`.`eo_policy`(`eo_policy_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_finra_registration_id` FOREIGN KEY (`finra_registration_id`) REFERENCES `life_insurance_ecm`.`agent`.`finra_registration`(`finra_registration_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ADD CONSTRAINT `fk_agent_contracting_termination_event_id` FOREIGN KEY (`termination_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`termination_event`(`termination_event_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ADD CONSTRAINT `fk_agent_eo_policy_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ADD CONSTRAINT `fk_agent_finra_registration_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_contracting_id` FOREIGN KEY (`contracting_id`) REFERENCES `life_insurance_ecm`.`agent`.`contracting`(`contracting_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_eo_policy_id` FOREIGN KEY (`eo_policy_id`) REFERENCES `life_insurance_ecm`.`agent`.`eo_policy`(`eo_policy_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_finra_registration_id` FOREIGN KEY (`finra_registration_id`) REFERENCES `life_insurance_ecm`.`agent`.`finra_registration`(`finra_registration_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ADD CONSTRAINT `fk_agent_onboarding_case_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ADD CONSTRAINT `fk_agent_producer_training_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ADD CONSTRAINT `fk_agent_producer_product_auth_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ADD CONSTRAINT `fk_agent_production_activity_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_distribution_channel_id` FOREIGN KEY (`distribution_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_eo_policy_id` FOREIGN KEY (`eo_policy_id`) REFERENCES `life_insurance_ecm`.`agent`.`eo_policy`(`eo_policy_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ADD CONSTRAINT `fk_agent_agency_parent_agency_id` FOREIGN KEY (`parent_agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ADD CONSTRAINT `fk_agent_agency_producer_affiliation_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `life_insurance_ecm`.`agent`.`agency`(`agency_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ADD CONSTRAINT `fk_agent_agency_producer_affiliation_contracting_id` FOREIGN KEY (`contracting_id`) REFERENCES `life_insurance_ecm`.`agent`.`contracting`(`contracting_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ADD CONSTRAINT `fk_agent_agency_producer_affiliation_eo_policy_id` FOREIGN KEY (`eo_policy_id`) REFERENCES `life_insurance_ecm`.`agent`.`eo_policy`(`eo_policy_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ADD CONSTRAINT `fk_agent_agency_producer_affiliation_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `life_insurance_ecm`.`agent`.`appointment`(`appointment_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_contracting_id` FOREIGN KEY (`contracting_id`) REFERENCES `life_insurance_ecm`.`agent`.`contracting`(`contracting_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_finra_registration_id` FOREIGN KEY (`finra_registration_id`) REFERENCES `life_insurance_ecm`.`agent`.`finra_registration`(`finra_registration_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_license_id` FOREIGN KEY (`license_id`) REFERENCES `life_insurance_ecm`.`agent`.`license`(`license_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ADD CONSTRAINT `fk_agent_compliance_event_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ADD CONSTRAINT `fk_agent_agent_bulk_comm_recipient_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ADD CONSTRAINT `fk_agent_producer_product_authorization_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ADD CONSTRAINT `fk_agent_program_participation_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `life_insurance_ecm`.`agent`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ADD CONSTRAINT `fk_agent_program_participation_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ADD CONSTRAINT `fk_agent_agent_training_completion_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_appointment_id` FOREIGN KEY (`appointment_id`) REFERENCES `life_insurance_ecm`.`agent`.`appointment`(`appointment_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_producer_id` FOREIGN KEY (`producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_successor_agent_producer_id` FOREIGN KEY (`successor_agent_producer_id`) REFERENCES `life_insurance_ecm`.`agent`.`producer`(`producer_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ADD CONSTRAINT `fk_agent_termination_event_reinstated_termination_event_id` FOREIGN KEY (`reinstated_termination_event_id`) REFERENCES `life_insurance_ecm`.`agent`.`termination_event`(`termination_event_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ADD CONSTRAINT `fk_agent_distribution_channel_parent_channel_id` FOREIGN KEY (`parent_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ADD CONSTRAINT `fk_agent_distribution_channel_parent_distribution_channel_id` FOREIGN KEY (`parent_distribution_channel_id`) REFERENCES `life_insurance_ecm`.`agent`.`distribution_channel`(`distribution_channel_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`agent` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `life_insurance_ecm`.`agent` SET TAGS ('dbx_domain' = 'agent');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `parent_producer_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Producer Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Producer Address Line 1');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Producer Address Line 2');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `annual_production_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Target Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|cleared|flagged|failed');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `business_name` SET TAGS ('dbx_business_glossary_term' = 'Business Name or Doing Business As (DBA) Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Producer City');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `contracting_status` SET TAGS ('dbx_business_glossary_term' = 'Contracting Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `contracting_status` SET TAGS ('dbx_value_regex' = 'contracted|not_contracted|pending_contract|contract_expired');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Producer Country Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Producer Date of Birth');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Producer Email Address');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `eo_coverage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Indicator');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `eo_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `eo_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `finra_crd_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `finra_crd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Producer First Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Producer Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Producer Hire Date or Appointment Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|failed');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Producer Last Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `lifetime_production_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Production Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Producer Middle Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `npn` SET TAGS ('dbx_business_glossary_term' = 'National Producer Number (NPN)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `npn` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Producer Phone Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Producer Postal Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_code` SET TAGS ('dbx_business_glossary_term' = 'Producer Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_status` SET TAGS ('dbx_business_glossary_term' = 'Producer Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_type` SET TAGS ('dbx_business_glossary_term' = 'Producer Type Classification');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `producer_type` SET TAGS ('dbx_value_regex' = 'captive_agent|independent_agent|bga|mga|ga|broker_dealer');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Producer State Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `state_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN) or Social Security Number (SSN)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$|^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Producer Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Producer Termination Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|retirement|performance|compliance_violation|license_revocation|other');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Producer Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer` ALTER COLUMN `ytd_production_amount` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Production Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'License Certificate Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'appointed|terminated|pending|suspended');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `ce_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Compliance Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `ce_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `ce_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Completed');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `ce_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Hours Required');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `doi_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'License Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `eo_coverage_required` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Required');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `eo_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `eo_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `finra_crd_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `finra_registration_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `late_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Penalty Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `late_renewal_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Renewal Penalty Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `license_class` SET TAGS ('dbx_business_glossary_term' = 'License Class');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `license_class` SET TAGS ('dbx_value_regex' = 'resident|non_resident|temporary|reciprocal');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired|pending');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `line_of_authority` SET TAGS ('dbx_business_glossary_term' = 'Line of Authority (LOA)');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `line_of_authority` SET TAGS ('dbx_value_regex' = 'life|health|variable|property|casualty|personal_lines');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `nipr_number` SET TAGS ('dbx_business_glossary_term' = 'National Insurance Producer Registry (NIPR) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `original_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Original Issue Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `reciprocal_state` SET TAGS ('dbx_business_glossary_term' = 'Reciprocal State');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Months');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `renewal_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Sent Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `renewal_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Submission Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_upline_agent_producer_id` SET TAGS ('dbx_business_glossary_term' = 'Upline Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `eo_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Eo Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `finra_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Finra Registration Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `anti_money_laundering_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `anti_money_laundering_training_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Training Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointing_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Appointing Carrier Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointing_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Appointing Carrier Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|suspended|expired|cancelled');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'new|renewal|reinstatement|termination|amendment');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `background_check_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `broker_dealer_name` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Agent Contract Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `errors_and_omissions_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `finra_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'writing_agent|ga|mga|bga|regional_director|national_director');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `line_of_authority` SET TAGS ('dbx_business_glossary_term' = 'Line of Authority (LOA)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `nipr_appointment_number` SET TAGS ('dbx_business_glossary_term' = 'National Insurance Producer Registry (NIPR) Appointment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Renewal Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `state_approval_date` SET TAGS ('dbx_business_glossary_term' = 'State Approval Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `state_filing_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'State Filing Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `state_filing_date` SET TAGS ('dbx_business_glossary_term' = 'State Filing Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `state_of_appointment` SET TAGS ('dbx_business_glossary_term' = 'State of Appointment');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `suitability_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suitability Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `suitability_training_date` SET TAGS ('dbx_business_glossary_term' = 'Suitability Training Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`appointment` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` SET TAGS ('dbx_subdomain' = 'distribution_network');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `parent_node_hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Hierarchy Node Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = 'career|independent|worksite|financial_institution|direct|broker_dealer');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `child_node_count` SET TAGS ('dbx_business_glossary_term' = 'Child Node Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `commission_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Hierarchy Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `commission_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'w2_employee|1099_contractor|corporate_entity|partnership');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `depth_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `descendant_node_count` SET TAGS ('dbx_business_glossary_term' = 'Descendant Node Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'captive|independent|brokerage|hybrid|direct|reinsurance');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `hierarchy_version` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Version');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `leaf_node_flag` SET TAGS ('dbx_business_glossary_term' = 'Leaf Node Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `organizational_unit` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `override_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `production_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Production Credit Percentage');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `reporting_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Hierarchy Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `roll_up_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Roll-Up Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Termination Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`hierarchy_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contracting_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contracting_upline_agent_producer_id` SET TAGS ('dbx_business_glossary_term' = 'Upline Agent ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `eo_policy_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `finra_registration_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `termination_event_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Event ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'captive|independent|brokerage|mga|bga|ga');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `contracting_date` SET TAGS ('dbx_business_glossary_term' = 'Contracting Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `eo_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `finra_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `nigo_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Resolution Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `product_line_authorization` SET TAGS ('dbx_business_glossary_term' = 'Product Line Authorization');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|confirmed');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `state_notification_date` SET TAGS ('dbx_business_glossary_term' = 'State Notification Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `state_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'State Notification Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `termination_type` SET TAGS ('dbx_value_regex' = 'voluntary|carrier_initiated|regulatory|mutual');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `u5_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Uniform Termination Notice for Securities Industry Registration (U5) Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `u5_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Uniform Termination Notice for Securities Industry Registration (U5) Filing Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `u5_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Uniform Termination Notice for Securities Industry Registration (U5) Filing Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `unearned_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Unearned Commission Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `unearned_commission_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Unearned Commission Return Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`contracting` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `eo_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Eo Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Document ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `aggregate_limit` SET TAGS ('dbx_business_glossary_term' = 'E&O Aggregate Limit');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Cancellation Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'non-payment|underwriting|insured request|carrier decision|fraud|material misrepresentation');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `carrier_naic_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Carrier Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `carrier_naic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `certificate_of_insurance_received` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Received Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `certificate_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance (COI) Received Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `claims_made_coverage` SET TAGS ('dbx_business_glossary_term' = 'Claims-Made Coverage Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Compliance Verification Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `compliance_verified_by` SET TAGS ('dbx_business_glossary_term' = 'E&O Compliance Verified By');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|pending|suspended');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'individual|group|agency|corporate');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'E&O Deductible Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `erp_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Extended Reporting Period (ERP) Duration in Months');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Coverage Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `extended_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Extended Reporting Period (ERP) Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `finra_coverage_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Coverage Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Last Renewal Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `lines_of_authority_covered` SET TAGS ('dbx_business_glossary_term' = 'Lines of Authority (LOA) Covered');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Next Renewal Due Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `original_issue_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Original Issue Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `per_occurrence_limit` SET TAGS ('dbx_business_glossary_term' = 'E&O Per Occurrence Limit');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Policy Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `policy_term_months` SET TAGS ('dbx_business_glossary_term' = 'E&O Policy Term in Months');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'E&O Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `premium_paid_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Premium Paid Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'E&O Premium Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `reinstatement_eligible` SET TAGS ('dbx_business_glossary_term' = 'E&O Reinstatement Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Sent Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `retroactive_date` SET TAGS ('dbx_business_glossary_term' = 'E&O Retroactive Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `state_filing_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'State Filing Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `state_filing_date` SET TAGS ('dbx_business_glossary_term' = 'State Filing Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `state_filing_required` SET TAGS ('dbx_business_glossary_term' = 'State Filing Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`eo_policy` ALTER COLUMN `variable_products_covered` SET TAGS ('dbx_business_glossary_term' = 'Variable Products Covered Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `finra_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'U4 Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `background_check_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `broker_dealer_crd_number` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `broker_dealer_crd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `broker_dealer_name` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Firm Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `continuing_education_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `crd_number` SET TAGS ('dbx_business_glossary_term' = 'Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `crd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `disclosure_event_count` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Event Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `disclosure_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Event Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `fingerprint_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Fingerprint Submission Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `fingerprint_submission_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `fingerprint_submission_date` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `last_continuing_education_date` SET TAGS ('dbx_business_glossary_term' = 'Last Continuing Education Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `last_disclosure_event_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disclosure Event Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `next_continuing_education_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Continuing Education Due Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registered_representative_type` SET TAGS ('dbx_business_glossary_term' = 'Registered Representative Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registered_representative_type` SET TAGS ('dbx_value_regex' = 'general_securities|investment_company|variable_contracts|limited_representative');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'FINRA Registration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'FINRA Registration Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registration_notes` SET TAGS ('dbx_business_glossary_term' = 'FINRA Registration Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'FINRA Registration Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated|expired');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `sec_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registration Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_63_exam_date` SET TAGS ('dbx_business_glossary_term' = 'Series 63 Exam Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_63_exam_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Series 63 Exam Passed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_65_exam_date` SET TAGS ('dbx_business_glossary_term' = 'Series 65 Exam Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_65_exam_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Series 65 Exam Passed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_6_exam_date` SET TAGS ('dbx_business_glossary_term' = 'Series 6 Exam Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_6_exam_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Series 6 Exam Passed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_7_exam_date` SET TAGS ('dbx_business_glossary_term' = 'Series 7 Exam Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `series_7_exam_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Series 7 Exam Passed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'FINRA Registration Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'FINRA Registration Termination Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'voluntary|discharged|permitted_to_resign|deceased|other');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `u4_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Uniform Application for Securities Industry Registration (Form U4) Filing Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `u4_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Form U4 Filing Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `u4_filing_status` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|pending_review|incomplete');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `u5_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Uniform Termination Notice for Securities Industry Registration (Form U5) Filing Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `u5_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Form U5 Filing Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `u5_filing_status` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|pending_review|incomplete');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`finra_registration` ALTER COLUMN `variable_product_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Variable Product Authorization Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` SET TAGS ('dbx_subdomain' = 'operational_workflow');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_id` SET TAGS ('dbx_business_glossary_term' = 'Background Check Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `contracting_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `eo_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Eo Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `finra_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Finra Registration Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Document Package Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `adverse_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `aml_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `aml_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `application_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new_agent|transfer|reappointment|upgrade');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `assigned_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_result_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Result Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_result_status` SET TAGS ('dbx_value_regex' = 'pending|clear|flagged|adverse_action');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Submission Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_type` SET TAGS ('dbx_business_glossary_term' = 'Background Check Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_check_type` SET TAGS ('dbx_value_regex' = 'criminal|credit|regulatory|comprehensive');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `background_screening_vendor` SET TAGS ('dbx_business_glossary_term' = 'Background Screening Vendor');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `contracting_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Contracting Entity Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `eo_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `eo_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Validation Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `eo_validation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|validated|expired|insufficient');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `finra_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `finra_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Verification Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `finra_verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|failed');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `license_verification_date` SET TAGS ('dbx_business_glossary_term' = 'License Verification Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `license_verification_status` SET TAGS ('dbx_business_glossary_term' = 'License Verification Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `license_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|failed');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `mib_inquiry_reference` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Reference');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `nigo_date` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `nigo_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `regulatory_disqualification_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disqualification Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `suitability_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suitability Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `suitability_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Suitability Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `system_provisioning_date` SET TAGS ('dbx_business_glossary_term' = 'System Provisioning Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `system_provisioning_status` SET TAGS ('dbx_business_glossary_term' = 'System Provisioning Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `system_provisioning_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `life_insurance_ecm`.`agent`.`onboarding_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` SET TAGS ('dbx_subdomain' = 'operational_workflow');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `producer_training_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Training ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Attempts Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `ce_credit_hours_awarded` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credit Hours Awarded');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `ce_credit_type` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education (CE) Credit Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `ce_credit_type` SET TAGS ('dbx_value_regex' = 'general|ethics|product_specific|law|annuity|long_term_care');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `certificate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `completion_score` SET TAGS ('dbx_business_glossary_term' = 'Completion Score');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `compliance_requirement_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Met');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `compliance_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `cost_paid_by` SET TAGS ('dbx_business_glossary_term' = 'Cost Paid By');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `cost_paid_by` SET TAGS ('dbx_value_regex' = 'producer|carrier|agency|third_party');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `pass_fail_indicator` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Indicator');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `pass_fail_indicator` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `passing_score_required` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Required');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Cycle Months');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `state_approval_number` SET TAGS ('dbx_business_glossary_term' = 'State Approval Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `state_of_credit` SET TAGS ('dbx_business_glossary_term' = 'State of Credit');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|webinar|self_paced|blended|on_the_job');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|failed|expired|waived');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'mandatory|elective|certification|continuing_education|product_specific|compliance');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `waiver_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approval Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_training` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `producer_product_auth_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Product Authorization ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Approval Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|revoked|expired|inactive');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `authorized_states` SET TAGS ('dbx_business_glossary_term' = 'Authorized States');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `finra_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `finra_series_license_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Series License Required');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `maximum_case_size_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Case Size Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `minimum_case_size_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Case Size Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `override_commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Commission Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `pos_system_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) System Integration Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `renewal_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Reminder Sent Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `required_training_code` SET TAGS ('dbx_business_glossary_term' = 'Required Training Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `required_training_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `restricted_states` SET TAGS ('dbx_business_glossary_term' = 'Restricted States');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `revocation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `revocation_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `revocation_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `state_specific_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Authorization Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `training_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Training Compliance Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `training_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending|expired');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `training_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `underwriting_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Authority Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_auth` ALTER COLUMN `underwriting_authority_level` SET TAGS ('dbx_value_regex' = 'standard|limited|enhanced|full|none');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` SET TAGS ('dbx_subdomain' = 'sales_incentives');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `production_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Production Activity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `activity_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Period End Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `activity_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Period Start Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|finalized');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `annuity_count` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `annuity_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Annuity Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `ape_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Equivalent (APE) Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `bonus_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Earned Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `commission_earned_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Earned Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `conservation_rate` SET TAGS ('dbx_business_glossary_term' = 'Conservation Rate');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `first_year_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'First Year Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_value_regex' = 'producer|supervisor|manager|regional_director|national_director');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `issued_policy_count` SET TAGS ('dbx_business_glossary_term' = 'Issued Policy Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `iul_count` SET TAGS ('dbx_business_glossary_term' = 'Indexed Universal Life (IUL) Policy Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `iul_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Indexed Universal Life (IUL) Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `lapse_count` SET TAGS ('dbx_business_glossary_term' = 'Lapse Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `nigo_count` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `persistency_ratio` SET TAGS ('dbx_business_glossary_term' = 'Persistency Ratio');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `placement_rate` SET TAGS ('dbx_business_glossary_term' = 'Placement Rate');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `renewal_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `submitted_application_count` SET TAGS ('dbx_business_glossary_term' = 'Submitted Application Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `term_life_count` SET TAGS ('dbx_business_glossary_term' = 'Term Life Policy Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `term_life_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Term Life Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `total_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Face Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `universal_life_count` SET TAGS ('dbx_business_glossary_term' = 'Universal Life (UL) Policy Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `universal_life_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Universal Life (UL) Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `vul_count` SET TAGS ('dbx_business_glossary_term' = 'Variable Universal Life (VUL) Policy Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `vul_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Variable Universal Life (VUL) Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `whole_life_count` SET TAGS ('dbx_business_glossary_term' = 'Whole Life (WL) Policy Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`production_activity` ALTER COLUMN `whole_life_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Whole Life (WL) Premium Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` SET TAGS ('dbx_subdomain' = 'sales_incentives');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Program Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `award_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Award Currency Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `award_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `cash_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Award Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `communication_plan` SET TAGS ('dbx_business_glossary_term' = 'Communication Plan');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional_approval');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `eligible_distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Eligible Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `eligible_producer_type` SET TAGS ('dbx_business_glossary_term' = 'Eligible Producer Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `finra_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Approval Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `finra_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `payout_timing` SET TAGS ('dbx_business_glossary_term' = 'Payout Timing');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `payout_timing` SET TAGS ('dbx_value_regex' = 'immediate|quarterly|annual|upon_completion|deferred');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `production_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Production Metric Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `production_metric_type` SET TAGS ('dbx_value_regex' = 'ape|nbv|premium_volume|policy_count|account_value|face_amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_administrator` SET TAGS ('dbx_business_glossary_term' = 'Program Administrator');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Program Sponsor');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|cancelled|archived');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'sales_contest|bonus_program|convention_qualification|club_membership|recognition_award|performance_incentive');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `qualification_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period End Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `qualification_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Period Start Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `qualification_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualification Threshold Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `reward_description` SET TAGS ('dbx_business_glossary_term' = 'Reward Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `reward_type` SET TAGS ('dbx_business_glossary_term' = 'Reward Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `reward_type` SET TAGS ('dbx_value_regex' = 'cash_bonus|trip|merchandise|points|recognition|mixed');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `tax_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `threshold_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Tier Count');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `tier_definition` SET TAGS ('dbx_business_glossary_term' = 'Tier Definition');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `tier_structure_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Tracking System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`incentive_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` SET TAGS ('dbx_subdomain' = 'distribution_network');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Contract Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `eo_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Eo Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `parent_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agency Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Agency Address Line 1');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Agency Address Line 2');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `agency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_business_glossary_term' = 'Agency Type Classification');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `agency_type` SET TAGS ('dbx_value_regex' = 'BGA|MGA|GA|IMO|NMO|Captive Agency');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `annual_production_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Target Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `annual_production_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Appointment Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `appointment_status` SET TAGS ('dbx_value_regex' = 'Appointed|Pending|Terminated|Suspended|Not Appointed');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `background_check_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'Not Required|Pending|Cleared|Failed|Expired');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `background_check_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `broker_dealer_crd_number` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `broker_dealer_crd_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,8}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `broker_dealer_name` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Agency City');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Contract Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `contracting_status` SET TAGS ('dbx_business_glossary_term' = 'Contracting Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `contracting_status` SET TAGS ('dbx_value_regex' = 'Active|Pending|Suspended|Terminated|Inactive');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Country Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `domicile_state` SET TAGS ('dbx_business_glossary_term' = 'Domicile State Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `domicile_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Agency Email Address');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `eo_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `finra_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Distribution Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Legal Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `lifetime_production_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Production Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `lifetime_production_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `lines_of_authority` SET TAGS ('dbx_business_glossary_term' = 'Lines of Authority (LOA)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Agency Onboarding Stage');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|On Hold');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Phone Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Postal Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `principal_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Principal Officer Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `principal_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'Agency State Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `state_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Identification Number (EIN)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Agency Website Uniform Resource Locator (URL)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `ytd_production_amount` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Production Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency` ALTER COLUMN `ytd_production_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` SET TAGS ('dbx_subdomain' = 'distribution_network');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `agency_producer_affiliation_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Producer Affiliation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `contracting_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `eo_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Eo Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `affiliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `affiliation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `affiliation_type` SET TAGS ('dbx_value_regex' = 'employed|contracted|sub_agent|independent|captive|broker');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `annual_production_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Target');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `anti_money_laundering_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `anti_money_laundering_training_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Training Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `background_check_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `broker_dealer_crd_number` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `broker_dealer_name` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `errors_and_omissions_coverage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Errors and Omissions (E&O) Coverage Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `finra_crd_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Central Registration Depository (CRD) Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `finra_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `lines_of_authority` SET TAGS ('dbx_business_glossary_term' = 'Lines of Authority (LOA)');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `override_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `primary_agency_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Agency Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `production_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Production Credit Percentage');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `suitability_training_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Suitability Training Completed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `suitability_training_date` SET TAGS ('dbx_business_glossary_term' = 'Suitability Training Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Termination Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`agency_producer_affiliation` ALTER COLUMN `variable_products_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Variable Products Authorized Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` SET TAGS ('dbx_subdomain' = 'operational_workflow');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `contracting_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `finra_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Finra Registration Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `aml_sar_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Suspicious Activity Report (SAR) Filed Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `appointment_impact_action` SET TAGS ('dbx_business_glossary_term' = 'Appointment Impact Action');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `appointment_impact_action` SET TAGS ('dbx_value_regex' = 'none|suspension|termination|restriction|monitoring');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `contracting_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Contracting Impact Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_remediation|resolved|closed');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'doi_complaint|finra_disciplinary_action|regulatory_investigation|aml_suspicious_activity|suitability_violation|market_conduct_finding');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `external_counsel_engaged_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Engaged Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `finra_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Disclosure Required Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `internal_case_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Case Owner');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `license_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'License Impact Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `monetary_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetary Penalty Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Notes');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `penalty_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `remediation_action_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Required');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Reported Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved_no_action|resolved_with_remediation|escalated');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `sar_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report (SAR) Filing Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `source_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Source Authority Type');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `source_authority_type` SET TAGS ('dbx_value_regex' = 'state_doi|finra|fincen|sec|internal_compliance|other');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`compliance_event` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` SET TAGS ('dbx_subdomain' = 'operational_workflow');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` SET TAGS ('dbx_association_edges' = 'agent.producer,correspondence.bulk_comm_campaign');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `agent_bulk_comm_recipient_id` SET TAGS ('dbx_business_glossary_term' = 'agent_bulk_comm_recipient Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `bulk_comm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Comm Recipient - Bulk Comm Campaign Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `correspondence_bulk_comm_recipient_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Communication Recipient ID');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Comm Recipient - Producer Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `delivery_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Outcome Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `recipient_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Sequence Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_bulk_comm_recipient` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` SET TAGS ('dbx_subdomain' = 'producer_management');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` SET TAGS ('dbx_association_edges' = 'agent.producer,product.product_plan');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `producer_product_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'producer_product_authorization Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Product Authorization - Plan Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Product Authorization - Producer Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `authorization_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `authorization_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `authorized_states` SET TAGS ('dbx_business_glossary_term' = 'Authorized States');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `state_specific_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'State Specific Authorization Flag');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`producer_product_authorization` ALTER COLUMN `underwriting_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Authority Level');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` SET TAGS ('dbx_subdomain' = 'sales_incentives');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` SET TAGS ('dbx_association_edges' = 'agent.producer,agent.incentive_program');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `program_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `incentive_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation - Incentive Program Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation - Producer Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `award_payout_date` SET TAGS ('dbx_business_glossary_term' = 'Award Payout Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `production_amount_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Production Amount');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `ranking` SET TAGS ('dbx_business_glossary_term' = 'Producer Ranking');
ALTER TABLE `life_insurance_ecm`.`agent`.`program_participation` ALTER COLUMN `tier_achieved` SET TAGS ('dbx_business_glossary_term' = 'Tier Achieved');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` SET TAGS ('dbx_subdomain' = 'operational_workflow');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` SET TAGS ('dbx_association_edges' = 'agent.producer,compliance.training_course');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `agent_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'agent_training_completion Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Producer Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Training Course Id');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `completion_method` SET TAGS ('dbx_business_glossary_term' = 'Completion Method');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `delivery_platform` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `life_insurance_ecm`.`agent`.`agent_training_completion` ALTER COLUMN `score_achieved` SET TAGS ('dbx_business_glossary_term' = 'Score Achieved');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` SET TAGS ('dbx_subdomain' = 'operational_workflow');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ALTER COLUMN `termination_event_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Event Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ALTER COLUMN `reinstated_termination_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ALTER COLUMN `severance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`termination_event` ALTER COLUMN `termination_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` SET TAGS ('dbx_subdomain' = 'distribution_network');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Identifier');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `parent_distribution_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `annual_production_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `commission_structure_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `default_commission_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `errors_omissions_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `finra_crd_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `finra_crd_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`agent`.`distribution_channel` ALTER COLUMN `ytd_production_amount` SET TAGS ('dbx_confidential' = 'true');
