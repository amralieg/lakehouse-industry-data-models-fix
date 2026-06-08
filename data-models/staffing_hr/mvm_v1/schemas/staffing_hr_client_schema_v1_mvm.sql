-- Schema for Domain: client | Business: Staffing Hr | Version: v1_mvm
-- Generated on: 2026-05-02 22:45:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm_v1`.`client` COMMENT 'SSOT for all client (employer) identity and commercial relationship data. Owns client company profiles, contacts, account hierarchies, locations, MSA agreements, rate cards, VMS integrations, SLA configurations, NPS scores, and CRM engagement history sourced from Bullhorn and Salesforce. Serves as the authoritative source for WHO the business serves on the demand side, supporting both direct clients and VMS/MSP program relationships.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`client_account` (
    `client_account_id` BIGINT COMMENT 'Unique surrogate primary key for each client account record in the Staffing Hr system. System-generated identifier used as the anchor key for all downstream job orders, placements, billing, and commercial relationships.',
    `account_status` STRING COMMENT 'Current lifecycle status of the client account. Drives operational eligibility for job order creation, placement activity, and billing. Values: prospect (pre-contract sales stage), active (current client with open MSA), inactive (no current activity but relationship intact), on_hold (temporarily suspended per SLA or compliance issue), terminated (relationship ended).. Valid values are `prospect|active|inactive|on_hold|terminated`',
    `billing_contact_email` STRING COMMENT 'Email address of the designated billing contact at the client organization. Primary channel for electronic invoice delivery, payment reminders, and accounts receivable communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Full name of the designated billing contact at the client organization responsible for receiving and approving invoices. Used by Salesforce Revenue Cloud and accounts receivable for invoice delivery and payment follow-up.',
    `bullhorn_client_code` STRING COMMENT 'The native record identifier assigned to this client account within Bullhorn ATS/CRM. Used for cross-system reconciliation and data lineage tracing between the Silver layer and the operational source system.',
    `client_type` STRING COMMENT 'Classifies the commercial relationship model under which Staffing Hr serves this client. Values: direct (standard staffing client), vms_msp (client managed through a Vendor Management System or Managed Service Provider program), rpo (Recruitment Process Outsourcing engagement), eor (Employer of Record arrangement), peo (Professional Employer Organization), sow (Statement of Work-based engagement). [ENUM-REF-CANDIDATE: direct|vms_msp|rpo|eor|peo|sow — promote to reference product]. Valid values are `direct|vms_msp|rpo|eor|peo|sow`',
    `company_size_tier` STRING COMMENT 'Categorical classification of the client organization by employee headcount or revenue band. Used for account segmentation, service tier assignment, pricing strategy, and sales territory management. Values: small (<100 FTE), mid_market (100–999 FTE), enterprise (1,000–9,999 FTE), global_enterprise (10,000+ FTE).. Valid values are `small|mid_market|enterprise|global_enterprise`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the client account record was first created in the system of record (Bullhorn ATS/CRM or Salesforce Revenue Cloud). Represents the audit trail creation event and is used for data lineage, compliance reporting, and record age analysis.',
    `credit_limit` DECIMAL(18,2) COMMENT 'The maximum outstanding accounts receivable balance approved for this client before new placements or billing activity is placed on hold. Managed in Oracle NetSuite ERP as part of credit risk controls. Expressed in USD.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all billing and financial transactions with this client (e.g., USD, CAD, GBP). Defaults to USD for domestic clients. Required for multi-currency revenue recognition in Oracle NetSuite ERP.. Valid values are `^[A-Z]{3}$`',
    `dba_name` STRING COMMENT 'The trade name or Doing Business As (DBA) name under which the client operates commercially, if different from the legal entity name. Used in client-facing communications, invoices, and CRM displays.',
    `duns_number` STRING COMMENT 'The nine-digit Data Universal Numbering System (DUNS) number assigned by Dun & Bradstreet to uniquely identify the client organization globally. Used for credit risk assessment, vendor onboarding, and government contract compliance (OFCCP).. Valid values are `^[0-9]{9}$`',
    `employee_headcount` STRING COMMENT 'Approximate total number of full-time equivalent (FTE) employees at the client organization at the time of account creation or last update. Used to validate company size tier classification and inform workforce planning and capacity estimates.',
    `fein` STRING COMMENT 'The Federal Employer Identification Number (FEIN) assigned by the IRS to uniquely identify the client as a tax entity. Required for W-2 co-employment compliance, tax reporting, and workers compensation administration.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `invoice_delivery_method` STRING COMMENT 'The preferred method by which invoices are delivered to the client. Values: email (electronic PDF via email), portal (client self-service billing portal), mail (physical mail), edi (Electronic Data Interchange), fax (facsimile). Configured in Salesforce Revenue Cloud billing preferences.. Valid values are `email|portal|mail|edi|fax`',
    `invoice_frequency` STRING COMMENT 'The agreed billing cycle frequency for generating and delivering invoices to this client. Values: weekly, biweekly, semimonthly, monthly, on_demand. Drives automated invoice generation scheduling in Salesforce Revenue Cloud.. Valid values are `weekly|biweekly|semimonthly|monthly|on_demand`',
    `invoice_grouping_rule` STRING COMMENT 'Defines how timesheet and placement charges are consolidated onto invoices for this client. Values: consolidated (single invoice for all activity), by_location (separate invoice per work site), by_department (separate invoice per client department), by_cost_center (separate invoice per cost center), by_po (separate invoice per Purchase Order number). Configured per client MSA terms.. Valid values are `consolidated|by_location|by_department|by_cost_center|by_po`',
    `legal_name` STRING COMMENT 'The full registered legal name of the client organization as it appears on the Master Service Agreement (MSA) and all contractual and tax documents. This is the authoritative identity label for the client entity.',
    `main_phone` STRING COMMENT 'Primary switchboard or main office phone number for the client organization. Used for account management outreach, service delivery coordination, and CRM contact records.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `manager_name` STRING COMMENT 'Full name of the Staffing Hr account manager responsible for day-to-day service delivery, relationship management, and SLA compliance for this client. May differ from the CRM account owner (sales rep). Used for operational escalation and KPI reporting.',
    `msa_effective_date` DATE COMMENT 'The date on which the Master Service Agreement (MSA) between Staffing Hr and this client became legally effective. Marks the start of the contractual relationship and governs all placements, billing terms, and SLA obligations. Sourced from DocuSign CLM.',
    `msa_expiration_date` DATE COMMENT 'The date on which the current Master Service Agreement (MSA) is scheduled to expire or must be renewed. Null for evergreen agreements with no fixed end date. Used to trigger renewal workflows in DocuSign CLM and Salesforce.',
    `msp_provider_name` STRING COMMENT 'Name of the Managed Service Provider (MSP) that administers the clients contingent workforce program on their behalf. Relevant when client_type = vms_msp. Staffing Hr submits requisitions and invoices through the MSP rather than directly to the client.',
    `naics_code` STRING COMMENT 'The six-digit North American Industry Classification System (NAICS) code that classifies the clients primary business activity. Used for industry segmentation, workers compensation rate assignment, and regulatory reporting.. Valid values are `^[0-9]{6}$`',
    `nda_on_file` BOOLEAN COMMENT 'Indicates whether a signed Non-Disclosure Agreement (NDA) is on file for this client in DocuSign CLM. Required before sharing candidate profiles or proprietary workforce data with the client.',
    `nps_score` STRING COMMENT 'The most recently recorded Net Promoter Score (NPS) for this client, measured on a scale of -100 to 100. Reflects client satisfaction and likelihood to recommend Staffing Hr. Collected via periodic surveys and tracked in Salesforce and Power BI Analytics Platform.',
    `nps_survey_date` DATE COMMENT 'The date on which the most recent Net Promoter Score (NPS) survey response was recorded for this client. Used to determine survey recency and schedule next survey cycle.',
    `on_hold_reason` STRING COMMENT 'Free-text description of the reason the client account has been placed on hold (account_status = on_hold). Examples include credit limit exceeded, compliance issue pending, contract renewal in progress, or client-requested pause. Null when account is not on hold.',
    `payment_method` STRING COMMENT 'The agreed payment instrument or mechanism used by the client to remit invoice payments. Values: ach (Automated Clearing House bank transfer), check (paper check), wire (wire transfer), credit_card, portal (client payment portal). Stored in Salesforce Revenue Cloud and Oracle NetSuite ERP.. Valid values are `ach|check|wire|credit_card|portal`',
    `payment_terms_days` STRING COMMENT 'The number of days from invoice date within which the client is contractually obligated to remit payment (e.g., Net 30 = 30, Net 45 = 45, Net 60 = 60). Used by Oracle NetSuite ERP for aging analysis, collections scheduling, and cash flow forecasting.',
    `po_required` BOOLEAN COMMENT 'Indicates whether the client requires a valid Purchase Order (PO) number on all invoices before payment will be processed. When True, invoices without a PO number are blocked from submission. Enforced in Salesforce Revenue Cloud billing workflow.',
    `primary_address_line1` STRING COMMENT 'First line of the clients primary registered business address (street number and street name). Used for invoice delivery, compliance filings, and geographic territory assignment.',
    `primary_address_line2` STRING COMMENT 'Second line of the clients primary registered business address (suite, floor, building, or unit number). Supplements address line 1 for complete mailing and compliance address records.',
    `primary_city` STRING COMMENT 'City of the clients primary registered business address. Used for geographic segmentation, territory assignment, state tax jurisdiction determination, and SUTA rate mapping.',
    `primary_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the clients primary registered business address (e.g., USA, CAN, GBR). Determines applicable regulatory framework including GDPR for international clients.. Valid values are `^[A-Z]{3}$`',
    `primary_postal_code` STRING COMMENT 'ZIP or ZIP+4 postal code of the clients primary registered business address. Used for geographic routing, tax jurisdiction lookup, and territory management.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_state` STRING COMMENT 'Two-letter U.S. state or territory code of the clients primary registered business address (ISO 3166-2:US). Drives state tax jurisdiction, SUTA rate assignment, workers compensation classification, and OFCCP reporting.. Valid values are `^[A-Z]{2}$`',
    `salesforce_account_code` STRING COMMENT 'The native record identifier assigned to this client account within Salesforce Revenue Cloud. Enables reconciliation of billing, invoicing, and revenue management data sourced from Salesforce against the master client record.',
    `sic_code` STRING COMMENT 'The four-digit Standard Industrial Classification (SIC) code for the clients primary industry. Maintained alongside NAICS for legacy system compatibility, EEOC reporting, and OFCCP compliance tracking.. Valid values are `^[0-9]{4}$`',
    `sla_tier` STRING COMMENT 'The SLA service tier assigned to this client, which defines response time commitments, submittal quality standards (QoS), time-to-fill (TTF) targets, and escalation protocols. Values: standard, premium, enterprise, custom. Drives SLA configuration and KPI reporting in Power BI Analytics Platform.. Valid values are `standard|premium|enterprise|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the client account record was most recently modified in any source system. Used for incremental data pipeline processing, change detection, and audit trail maintenance in the Databricks Silver layer.',
    `vms_platform` STRING COMMENT 'Name of the Vendor Management System (VMS) platform used by this client to manage contingent workforce requisitions and supplier interactions (e.g., Beeline, Fieldglass, IQNavigator, Coupa). Populated only for client_type = vms_msp. Drives integration configuration with Beeline VMS.',
    `website_url` STRING COMMENT 'The primary public website URL of the client organization. Used for client profile enrichment, candidate research, and CRM account verification.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_client_account PRIMARY KEY(`client_account_id`)
) COMMENT 'Master record for every client (employer) organization that Staffing Hr serves. SSOT for client company identity, classification, and billing configuration. Sourced from Bullhorn ATS/CRM and Salesforce Revenue Cloud. Captures legal entity name, DBA name, DUNS number, FEIN, industry classification (NAICS/SIC), company size tier, client type (direct, VMS/MSP, RPO), account status (prospect, active, inactive, on-hold, terminated), primary business address, website, and CRM account owner. Also owns billing preferences: invoice delivery method, invoice frequency, invoice grouping rules (by location, department, cost center, or consolidated), PO number requirements, payment method (ACH, check, wire), billing contact, and preferred payment portal. Demand-side anchor entity for all job orders, placements, billing, and commercial relationships.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` (
    `client_contact_id` BIGINT COMMENT 'Unique surrogate identifier for the client contact record in the Staffing Hr data platform. Primary key for the contact entity within the client domain.',
    `client_account_id` BIGINT COMMENT 'Reference to the parent client organization this contact belongs to. Links the individual contact to the employer account within the client domain hierarchy.',
    `location_id` BIGINT COMMENT 'Reference to the specific physical office or site location within the client organization where this contact is based. Supports geographic segmentation of contacts and routing of on-site staffing activities.',
    `reports_to_contact_id` BIGINT COMMENT 'Self-referencing identifier pointing to the contacts manager or superior within the client organizations contact hierarchy. Supports org chart modeling and escalation path identification for complex enterprise client accounts.',
    `address_line1` STRING COMMENT 'Primary street address line for the contacts office location. Used for correspondence, on-site visit planning, and geographic territory assignment. May differ from the parent clients corporate address for contacts at branch or satellite offices.',
    `address_line2` STRING COMMENT 'Secondary address line for the contacts office location (suite, floor, building number). Supplements address_line1 for precise mail delivery and on-site visit navigation.',
    `bullhorn_contact_code` STRING COMMENT 'Source system identifier for this contact record as assigned by Bullhorn ATS/CRM. Used for cross-system reconciliation and data lineage tracing between the lakehouse and the operational CRM.',
    `business_email` STRING COMMENT 'Primary business email address of the client contact. Used for job order submissions, submittal notifications, interview scheduling, and all formal CRM-driven communications. Governed by GDPR and CCPA for opt-in/opt-out management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `city` STRING COMMENT 'City of the contacts office location. Used for geographic territory management, local recruiter assignment, and workforce planning analytics by metro area.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record within the CRM. Active contacts are engaged in current staffing workflows. Inactive contacts are no longer at the client or not currently engaged. Do_not_contact reflects opt-out or legal hold. Archived contacts are retained for historical reference only.. Valid values are `active|inactive|do_not_contact|archived`',
    `contact_type` STRING COMMENT 'Classification of the contacts functional role in the staffing relationship. Determines routing of communications, invoices, and requisitions. Key values: hiring_manager (submits reqs and approves submittals), procurement (manages MSA and rate cards), accounts_payable (AP — receives invoices), executive_sponsor (strategic relationship owner), vms_coordinator (manages VMS program interactions). [ENUM-REF-CANDIDATE: hiring_manager|procurement|accounts_payable|executive_sponsor|vms_coordinator|recruiter_liaison|legal|it_admin — promote to reference product]. Valid values are `hiring_manager|procurement|accounts_payable|executive_sponsor|vms_coordinator`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the contacts office location (e.g., USA, CAN, GBR). Supports international staffing operations, GDPR applicability determination, and multi-country workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the Staffing Hr data platform. Supports audit trail requirements, data lineage, and contact acquisition trend analysis. Stored in ISO 8601 format with timezone offset.',
    `department` STRING COMMENT 'Business department or functional unit within the client organization where the contact works (e.g., Human Resources, IT, Finance, Operations). Supports segmentation of contacts by functional area for targeted engagement.',
    `direct_phone` STRING COMMENT 'Direct office or desk phone number for the client contact. Primary synchronous communication channel for recruiters and account managers to reach hiring managers and procurement contacts. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `do_not_call` BOOLEAN COMMENT 'Indicates whether the contact has requested to not be contacted by phone. True = do not call; False = phone contact is permitted. Enforced in CRM dialing workflows to ensure compliance with TCPA and internal communication policies.',
    `email_opt_in` BOOLEAN COMMENT 'Indicates whether the contact has opted in to receive marketing and promotional email communications from Staffing Hr. True = opted in; False = opted out or not consented. Critical for GDPR and CAN-SPAM compliance in outbound marketing campaigns.',
    `end_date` DATE COMMENT 'Date on which the business relationship with this contact was terminated or the contact became inactive (e.g., contact left the client organization, account closed). Null for currently active contacts. Supports lifecycle analysis and historical reporting.',
    `first_name` STRING COMMENT 'Given (first) name of the client contact individual. Used in CRM communications, correspondence, and relationship management workflows.',
    `is_decision_maker` BOOLEAN COMMENT 'Indicates whether this contact has authority to approve staffing requisitions, rate cards, or MSA terms. True = has decision-making authority; False = influencer or end-user without final approval authority. Used to prioritize executive engagement strategies.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the client account. True = primary contact for the account; False = secondary or supplementary contact. Used to route default communications and escalations for the client relationship.',
    `job_title` STRING COMMENT 'Official job title of the contact at their client organization (e.g., Hiring Manager, VP of Engineering, Procurement Director). Used to understand the contacts authority level and role in the staffing engagement.',
    `last_activity_date` DATE COMMENT 'Date of the most recent CRM-logged interaction with this contact (call, email, meeting, note). Used to identify dormant contacts, trigger re-engagement workflows, and measure account manager activity against SLA targets.',
    `last_activity_type` STRING COMMENT 'Type of the most recent CRM-logged interaction with this contact. Provides context for the last_activity_date and supports analysis of engagement channel effectiveness across the client contact portfolio.. Valid values are `call|email|meeting|note|linkedin_message|text_sms`',
    `last_name` STRING COMMENT 'Family (last) name of the client contact individual. Combined with first_name to form the full display name used in CRM, reporting, and client-facing communications.',
    `linkedin_url` STRING COMMENT 'URL to the contacts LinkedIn professional profile. Used by account managers and recruiters for relationship intelligence, org chart mapping, and understanding the contacts professional background and tenure at the client organization.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `middle_name` STRING COMMENT 'Middle name or initial of the client contact. Supports formal correspondence and disambiguation of contacts with identical first and last names at the same client organization.',
    `mobile_phone` STRING COMMENT 'Mobile or cell phone number for the client contact. Used for urgent communications, SMS outreach, and as a fallback when the direct office line is unavailable. Stored in E.164 international format.. Valid values are `^+?[1-9]d{1,14}$`',
    `name_prefix` STRING COMMENT 'Honorific or salutation prefix for the contact (e.g., Mr., Ms., Dr.). Used in formal written correspondence and client-facing communications to ensure professional address.. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `name_suffix` STRING COMMENT 'Professional or generational suffix appended to the contact name (e.g., Jr., Sr., III, CPA, MBA). Supports accurate formal correspondence and professional credential display.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) survey response from this contact, on a scale of 0–10. NPS measures the contacts likelihood to recommend Staffing Hrs services. Scores 0–6 = Detractors, 7–8 = Passives, 9–10 = Promoters. Used in client satisfaction analytics and account health monitoring.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS survey response was collected from this contact. Used to determine survey recency, schedule follow-up surveys, and track satisfaction trend over time.',
    `office_phone_ext` STRING COMMENT 'Phone extension number associated with the contacts direct office line. Required when the client organization uses a PBX system and the direct_phone field contains the main switchboard number.. Valid values are `^d{1,6}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code of the contacts office location. Used for geographic segmentation, territory mapping, and proximity-based recruiter assignment for local staffing engagements.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `preferred_communication_channel` STRING COMMENT 'The contacts stated preferred method of communication for staffing-related outreach. Drives CRM engagement workflows and ensures recruiter and account manager interactions align with the contacts preferences, improving response rates and relationship quality.. Valid values are `email|phone|mobile|linkedin|text_sms`',
    `salesforce_contact_code` STRING COMMENT 'Source system identifier for this contact record as assigned by Salesforce Revenue Cloud CRM. Enables bi-directional sync and deduplication between Bullhorn and Salesforce contact records.',
    `source` STRING COMMENT 'The originating system or channel through which this contact record was first created or imported into the Staffing Hr data platform. Supports data lineage tracking, deduplication analysis, and source quality reporting.. Valid values are `bullhorn|salesforce|vms_import|manual|linkedin|referral`',
    `start_date` DATE COMMENT 'Date on which the business relationship with this contact was formally initiated (e.g., first job order submitted, first meeting logged). Supports relationship tenure analysis and cohort-based client engagement reporting.',
    `state_province` STRING COMMENT 'State or province of the contacts office location using standard two-letter postal abbreviation (e.g., CA, NY, TX). Drives state-level compliance requirements, SUTA jurisdiction, and territory-based account management assignments.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts office location (e.g., America/New_York, America/Chicago). Used to schedule calls, interviews, and automated CRM communications at appropriate local times for the contact.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record in the Staffing Hr data platform. Used for change data capture (CDC), incremental ETL processing, and audit trail compliance.',
    `vms_user_code` STRING COMMENT 'The contacts user identifier within the clients Vendor Management System (VMS) platform (e.g., Beeline). Required for VMS-managed programs where job orders, submittals, and timesheets are processed through the VMS portal. Enables mapping of VMS workflow actions to the CRM contact record.',
    CONSTRAINT pk_client_contact PRIMARY KEY(`client_contact_id`)
) COMMENT 'Individual person record at a client organization who interacts with Staffing Hr in a business capacity. Sourced from Bullhorn CRM and Salesforce. Captures full name, job title, department, direct phone, mobile, business email, contact type (hiring manager, procurement, AP, executive sponsor, VMS coordinator), preferred communication channel, LinkedIn URL, contact status, and opt-in/opt-out flags. Supports CRM engagement tracking and relationship management workflows.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` (
    `account_hierarchy_id` BIGINT COMMENT 'Unique surrogate identifier for each parent-child account hierarchy relationship record in the staffing client account structure.',
    `client_account_id` BIGINT COMMENT 'Reference to the child (subordinate) client account in the hierarchy. Represents the subsidiary, division, franchise, or local site that rolls up to the parent account.',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Account hierarchies can be associated with managed programs (RPO/MSP/hybrid) in addition to VMS programs. This allows tracking which hierarchies are part of managed workforce programs. One hierarchy a',
    `msa_id` BIGINT COMMENT 'Reference to the Master Service Agreement (MSA) that governs the commercial terms for this account hierarchy relationship. Links to the contract lifecycle management system for SLA, rate, and compliance term inheritance.',
    `primary_client_account_id` BIGINT COMMENT 'Reference to the parent (superior) client account in the hierarchy. Represents the owning entity such as a global corporate parent, regional holding company, or divisional umbrella account.',
    `vms_program_id` BIGINT COMMENT 'External program identifier assigned by the Vendor Management System (VMS) platform (e.g., Beeline) for this account hierarchy node. Enables cross-system reconciliation for contingent workforce program management and rate card roll-ups.',
    `approval_status` STRING COMMENT 'Workflow approval state for this account hierarchy relationship. New or modified hierarchy relationships may require internal approval before becoming active for billing consolidation and SLA management.. Valid values are `approved|pending_approval|rejected|draft`',
    `approved_by` STRING COMMENT 'Name or identifier of the internal stakeholder who approved this account hierarchy relationship for activation. Supports audit trail requirements under SOC 2 Type II and internal governance controls.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this account hierarchy relationship was formally approved for activation. Part of the lifecycle audit trail for governance and SOC 2 Type II compliance.',
    `billing_consolidation_flag` BOOLEAN COMMENT 'Indicates whether invoices and billing activity for the child account should be consolidated and rolled up to the parent account level. When true, Oracle NetSuite ERP and Salesforce Revenue Cloud aggregate charges at the parent account for enterprise billing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this account hierarchy relationship record was first created in the system. Serves as the audit creation timestamp for data lineage, SOC 2 Type II compliance, and Silver layer ingestion tracking.',
    `effective_date` DATE COMMENT 'The date on which this parent-child account hierarchy relationship became or becomes operationally binding. Used to determine which hierarchy structure applies for a given billing period or SLA evaluation window.',
    `end_date` DATE COMMENT 'The date on which this parent-child account hierarchy relationship ceases to be operationally binding. Null indicates an open-ended, currently active relationship. Supports historical hierarchy reconstruction for audit and compliance reporting.',
    `hierarchy_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this specific parent-child relationship within the enterprise account structure. Used for cross-system reconciliation between Bullhorn, Salesforce, and Beeline VMS.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `hierarchy_description` STRING COMMENT 'Free-text narrative describing the business rationale or context for this parent-child account relationship, such as organizational restructuring notes or program scope details.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of the child account within the overall account tree, where level 1 represents the ultimate global parent. Used for territory planning, consolidated reporting, and enterprise SLA management across account families.',
    `hierarchy_name` STRING COMMENT 'Human-readable label for this parent-child relationship, typically combining parent and child account names (e.g., Acme Corp > Acme Northeast Division). Used in reporting dashboards and CRM displays.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain from the root parent to the current child node (e.g., /1001/1045/1078). Enables efficient tree traversal queries for enterprise roll-up reporting and consolidated billing in the Databricks Silver layer.',
    `hierarchy_status` STRING COMMENT 'Current lifecycle state of the parent-child account hierarchy relationship. Controls whether the relationship is used in active billing roll-ups, SLA aggregations, and VMS program management.. Valid values are `active|inactive|pending|terminated|suspended`',
    `hierarchy_type` STRING COMMENT 'Classifies the purpose or dimension of this hierarchy relationship. An account may participate in multiple hierarchy types simultaneously (e.g., organizational for CRM, billing for consolidated invoicing, VMS program for Beeline roll-ups).. Valid values are `organizational|geographic|billing|vms_program|reporting`',
    `is_primary_relationship` BOOLEAN COMMENT 'Indicates whether this is the primary (canonical) parent-child relationship for the child account when multiple hierarchy relationships exist (e.g., a subsidiary may belong to both a geographic and a functional hierarchy). Ensures unambiguous roll-up for consolidated billing.',
    `max_depth` STRING COMMENT 'The maximum number of levels in the account hierarchy subtree rooted at this node. Used for enterprise account structure validation and to enforce organizational depth limits in VMS program configurations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this account hierarchy relationship record was last updated. Supports change data capture (CDC) processing in the Databricks Silver layer and audit trail requirements under SOC 2 Type II.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or contextual commentary related to this account hierarchy relationship. Used by account managers and operations teams in Bullhorn and Salesforce CRM.',
    `nps_rollup_flag` BOOLEAN COMMENT 'Indicates whether Net Promoter Score (NPS) survey responses collected at the child account level should be aggregated and rolled up to the parent account for enterprise client satisfaction reporting.',
    `program_type` STRING COMMENT 'Indicates the commercial program model governing this account relationship. Determines whether the hierarchy is managed as a direct staffing engagement, a Managed Service Provider (MSP) program, a Vendor Management System (VMS) program, a Recruitment Process Outsourcing (RPO) engagement, or a hybrid model.. Valid values are `direct|msp|vms|rpo|hybrid`',
    `rate_card_inheritance_flag` BOOLEAN COMMENT 'Indicates whether the child account inherits bill rates, pay rates, and markup percentages from the parent accounts rate card. When true, Beeline VMS and Salesforce Revenue Cloud apply parent-level rate structures to child account job orders.',
    `relationship_type` STRING COMMENT 'Categorical classification of the structural relationship between the parent and child accounts. Drives consolidated billing rules, SLA inheritance, and MSP/VMS program roll-up logic. [ENUM-REF-CANDIDATE: corporate_parent|division|subsidiary|franchise|affiliate|joint_venture — promote to reference product if additional types are needed]. Valid values are `corporate_parent|division|subsidiary|franchise|affiliate`',
    `rollup_headcount_flag` BOOLEAN COMMENT 'Indicates whether the active worker headcount (Full-Time Equivalent and contingent) for the child account should be aggregated and rolled up to the parent account for enterprise workforce planning and reporting in Power BI.',
    `rollup_spend_flag` BOOLEAN COMMENT 'Indicates whether contingent workforce spend (bill amounts, gross margin, markup) for the child account should be aggregated to the parent account level for enterprise spend analytics and MSP program reporting.',
    `sla_inheritance_flag` BOOLEAN COMMENT 'Indicates whether the child account inherits Service Level Agreement (SLA) configurations from the parent account. When true, SLA targets such as Time to Fill (TTF) and Quality of Submission (QoS) defined at the parent level apply to the child account.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this account hierarchy relationship was originated or last updated. Supports data lineage tracking and conflict resolution in the Databricks Silver layer.. Valid values are `bullhorn|salesforce|beeline|netsuite|manual`',
    `source_system_hierarchy_code` STRING COMMENT 'The native identifier for this account hierarchy relationship as recorded in the originating operational system (e.g., Bullhorn relationship ID, Salesforce AccountTeamMember ID, Beeline program node ID). Enables bidirectional traceability for reconciliation.',
    `termination_reason` STRING COMMENT 'Free-text or coded reason explaining why this parent-child account hierarchy relationship was terminated or deactivated. Examples include corporate restructuring, account consolidation, client offboarding, or VMS program exit.',
    CONSTRAINT pk_account_hierarchy PRIMARY KEY(`account_hierarchy_id`)
) COMMENT 'Parent-child organizational relationship between client accounts, enabling enterprise account structures such as global parent, regional subsidiary, and local site. Captures parent account reference, child account reference, hierarchy level, relationship type (corporate parent, division, subsidiary, franchise), effective date, and end date. Critical for consolidated billing, enterprise SLA management, MSP/VMS program roll-ups, and territory planning across account families.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`location` (
    `location_id` BIGINT COMMENT 'Unique surrogate identifier for the client work site location record in the Silver layer lakehouse. Primary key for the location entity.',
    `client_account_id` BIGINT COMMENT 'Reference to the parent client account that owns this work site location. Links the location to its employer of record for assignment dispatch and billing.',
    `address_line1` STRING COMMENT 'Primary street address of the work site (street number and street name). Used for worker dispatch, OSHA establishment registration, and workers comp jurisdiction determination.',
    `address_line2` STRING COMMENT 'Secondary address detail for the work site such as suite, floor, building, or unit number. Supplements address_line1 for precise site identification.',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check (BGC) is mandatory for all workers placed at this location. Drives Sterling Background Check initiation during the onboarding workflow.',
    `badge_instructions` STRING COMMENT 'Free-text instructions for obtaining and using site access badges or security credentials. Provided to workers during onboarding and assignment dispatch to ensure day-one site access.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing or accounts payable contact at this location. Used for invoice delivery and billing dispute resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the accounts payable or billing contact at this location. Used by Salesforce Revenue Cloud for invoice routing and payment follow-up specific to this work site.',
    `bullhorn_location_code` STRING COMMENT 'External identifier for this location as stored in Bullhorn ATS/CRM. Used for system-of-record traceability and cross-system reconciliation.',
    `city` STRING COMMENT 'City in which the work site is located. Used for workers comp jurisdiction mapping, local tax determination, and geographic workforce analytics.',
    `closure_date` DATE COMMENT 'Date on which this work site was or is scheduled to be closed and no longer eligible for new assignments. Null for currently active locations. Used for historical reporting and workforce redeployment planning.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the work site (e.g., USA, CAN, GBR). Required for international staffing operations and GDPR/CCPA compliance jurisdiction determination.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish in which the work site is located. Used for local tax jurisdiction mapping, workers comp rate tables, and OSHA regional compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and SOC 2 Type II compliance.',
    `current_headcount` STRING COMMENT 'Current number of active contingent workers deployed at this location. Sourced from active placement records and used for real-time capacity monitoring and workforce analytics dashboards in Power BI.',
    `dress_code` STRING COMMENT 'Description of the dress code or personal protective equipment (PPE) requirements for workers at this site. Communicated during assignment dispatch and onboarding.',
    `effective_date` DATE COMMENT 'Date on which this location became or becomes active and eligible for worker assignments and job orders. Used for temporal filtering in workforce planning and compliance reporting.',
    `everify_required` BOOLEAN COMMENT 'Indicates whether E-Verify employment eligibility verification is required for workers placed at this location, typically driven by federal contractor status or state mandate.',
    `gl_account_code` STRING COMMENT 'General ledger account code associated with this location for revenue recognition and accounts receivable posting in Oracle NetSuite ERP. Enables location-level financial reporting.',
    `is_drug_free_workplace` BOOLEAN COMMENT 'Indicates whether the client has designated this site as a drug-free workplace, requiring pre-placement and random drug screening for all workers. Triggers Sterling Background Check drug screen requirements during onboarding.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether this location represents a remote or virtual work designation rather than a physical facility. Drives workers comp classification, tax nexus determination, and I-9 remote verification workflows.',
    `is_union_site` BOOLEAN COMMENT 'Indicates whether the work site operates under a collective bargaining agreement (CBA). Affects pay rate floors, overtime rules, and worker eligibility requirements for placements at this location.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work site in decimal degrees (WGS 84). Used for geospatial workforce analytics, proximity-based candidate matching, and mapping integrations.',
    `location_status` STRING COMMENT 'Current lifecycle status of the work site location. Active locations are eligible for new job orders and worker assignments. Inactive or closed locations are retained for historical reporting.. Valid values are `active|inactive|pending|closed`',
    `location_type` STRING COMMENT 'Categorical classification of the work site that determines dispatch rules, workers comp classification, and compliance jurisdiction mapping. [ENUM-REF-CANDIDATE: headquarters|branch|warehouse|plant|remote|on_site — promote to reference product if additional types are needed]. Valid values are `headquarters|branch|warehouse|plant|remote|on_site`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work site in decimal degrees (WGS 84). Used for geospatial workforce analytics, proximity-based candidate matching, and mapping integrations.',
    `max_headcount` STRING COMMENT 'Maximum number of contingent workers (headcount) authorized by the client to be deployed at this location simultaneously. Used for workforce planning, VMS (Vendor Management System) program controls, and capacity analytics.',
    `naics_code` STRING COMMENT 'Six-digit NAICS code representing the primary industry activity conducted at this work site. Used for OSHA recordkeeping, EEOC reporting, OFCCP compliance, and workforce analytics segmentation.. Valid values are `^[0-9]{6}$`',
    `osha_establishment_number` STRING COMMENT 'OSHA-assigned establishment identifier for this work site. Required for OSHA 300 log recordkeeping, injury and illness reporting, and OSHA inspection compliance under 29 CFR 1904.',
    `parking_instructions` STRING COMMENT 'Free-text instructions for worker parking at the site (e.g., designated lot, permit requirements, street parking rules). Included in worker onboarding and assignment dispatch communications.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the work site. Used for geographic routing, local tax jurisdiction lookup, and workers comp rate determination.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `site_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the work site within the client account hierarchy. Used in timesheets, billing, and workforce scheduling systems such as Kronos Workforce Ready.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `site_contact_email` STRING COMMENT 'Email address of the primary on-site contact. Used for timesheet approvals, assignment confirmations, and SLA (Service Level Agreement) communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `site_contact_name` STRING COMMENT 'Full name of the primary on-site contact person (e.g., hiring manager, facility supervisor) responsible for coordinating worker assignments, timesheets, and day-to-day staffing operations at this location.',
    `site_contact_phone` STRING COMMENT 'Direct phone number for the primary on-site contact. Used by staffing coordinators for dispatch coordination, worker check-in issues, and urgent placement communications.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `site_name` STRING COMMENT 'Human-readable name of the physical or virtual work site (e.g., Chicago Distribution Center, Austin HQ – Tower 2, Remote – Pacific Time Zone). Used in assignment dispatch, job orders, and worker communications.',
    `state_province` STRING COMMENT 'Two-letter ISO 3166-2 state or province code where the work site is located. Drives workers comp classification, SUTA (State Unemployment Tax Act) assignment, FLSA overtime rules, and OSHA jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the work site (e.g., America/Chicago, America/Los_Angeles). Used by Kronos Workforce Ready for shift scheduling, timesheet cutoff calculations, and overtime rule application.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this location record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), data lineage tracking, and Silver layer incremental processing.',
    `workers_comp_class_code` STRING COMMENT 'NCCI (National Council on Compensation Insurance) four-digit classification code assigned to the work site based on the nature of work performed. Determines workers comp premium rates for temporary workers placed at this location.. Valid values are `^[0-9]{4}$`',
    `workers_comp_state` STRING COMMENT 'Two-letter state code that governs the workers compensation insurance policy for workers deployed at this site. May differ from the physical state for multi-state operations or border locations. Critical for TempWorks Payroll workers comp classification.. Valid values are `^[A-Z]{2}$`',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Physical or virtual work site associated with a client account. Represents the specific facility, office, plant, or remote work designation where workers are deployed. Captures site name, address (street, city, state, zip, country), location type (headquarters, branch, warehouse, remote, on-site), OSHA establishment ID, workers comp jurisdiction state, site contact, parking/badge instructions, and active status. Used for assignment dispatch, workers comp classification, and compliance jurisdiction mapping.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` (
    `client_rate_card_id` BIGINT COMMENT 'Unique surrogate identifier for the rate card record in the Staffing Hr lakehouse silver layer. Primary key for this entity.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for whom this rate card is negotiated. Links the rate card to the client master record in the client domain.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Rate cards have client_approved_by field storing approver name as string. Adding contact_id FK normalizes this to reference the authoritative contact record who approved the rate card. One rate card a',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Rate cards have location_state and location_country fields indicating geographic applicability. Adding location_id FK normalizes this to reference the authoritative location record, enabling location-',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Rate cards can be associated with managed programs (RPO/MSP) in addition to VMS programs. This allows tracking negotiated rates specific to managed workforce programs. One rate card for one managed pr',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Rate cards reference MSA terms for markup caps, payment terms, and liability provisions. Essential for rate card approval workflow and compliance verification. Replaces denormalized msa_reference_numb',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Rate cards often tied to specific SOWs for project-based staffing engagements. Required for SOW-specific pricing enforcement, billing validation, and scope-of-work rate compliance in statement-of-work',
    `vms_program_id` BIGINT COMMENT 'External identifier of the VMS program (e.g., Beeline program code) under which this rate card is managed. Used to reconcile rate card data between the Staffing Hr lakehouse and the clients VMS platform.',
    `approval_status` STRING COMMENT 'Current workflow state of the rate card in the approval lifecycle. Controls whether the rate card may be used for job order creation and invoice generation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|expired|superseded — promote to reference product if additional states are needed]. Valid values are `draft|pending_approval|approved|rejected|expired|superseded`',
    `approved_by` STRING COMMENT 'Name or identifier of the internal approver (e.g., Account Manager, VP of Sales) who authorized this rate card version. Supports audit trail and governance requirements.',
    `approved_date` DATE COMMENT 'Date on which the rate card was formally approved by the authorized approver. Used for audit trail, compliance reporting, and rate card lifecycle management.',
    `beeline_rate_card_code` STRING COMMENT 'Native rate card identifier from the Beeline VMS system. Used for cross-system reconciliation between the Staffing Hr lakehouse and the clients Beeline VMS program.',
    `bill_rate_dt` DECIMAL(18,2) COMMENT 'Negotiated hourly bill rate charged to the client for double-time (DT) hours, applicable in jurisdictions or client agreements requiring double-time pay (e.g., California labor law, holiday work).',
    `bill_rate_ot` DECIMAL(18,2) COMMENT 'Negotiated hourly bill rate charged to the client for overtime (OT) hours, typically hours worked beyond 40 per week. Governed by FLSA overtime provisions and client MSA terms.',
    `bill_rate_regular` DECIMAL(18,2) COMMENT 'Negotiated hourly bill rate charged to the client for straight-time (regular) hours worked. This is the primary pricing field used in invoice generation and revenue recognition.',
    `burden_rate_included` BOOLEAN COMMENT 'Indicates whether the employer burden costs (FICA, FUTA, SUTA, Workers Compensation, benefits) are already embedded in the bill rate or markup percentage. True = burden is included in the stated rates; False = burden is calculated separately.',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'Employer burden rate as a percentage of pay rate, covering statutory costs including FICA, FUTA, SUTA, Workers Compensation, and applicable benefits. Used when burden_rate_included is True to document the embedded cost component.',
    `conversion_fee_percentage` DECIMAL(18,2) COMMENT 'Negotiated fee percentage charged to the client when a temporary or contract worker is converted to a permanent (direct hire) employee (Temp-to-Perm conversion). Expressed as a percentage of the workers annualized salary.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was first created in the Staffing Hr lakehouse. Supports audit trail, data lineage, and SOC 2 compliance requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary rate values on this rate card are denominated (e.g., USD, CAD, GBP). Supports multi-currency client programs.. Valid values are `^[A-Z]{3}$`',
    `direct_placement_fee_percentage` DECIMAL(18,2) COMMENT 'Negotiated fee percentage charged to the client for direct hire (permanent placement) engagements under this rate card. Expressed as a percentage of the placed candidates first-year base salary.',
    `effective_date` DATE COMMENT 'Date on which the rate card becomes active and may be applied to job orders, submittals, and invoices. Aligns with the MSA or VMS program agreement start date.',
    `expiration_date` DATE COMMENT 'Date on which the rate card ceases to be valid for new transactions. After this date, a new version must be approved before job orders can reference this rate schedule.',
    `holiday_bill_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the regular bill rate for hours worked on client-designated holidays (e.g., 1.5 = time-and-a-half, 2.0 = double time). Null if no holiday premium is negotiated.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Negotiated markup percentage applied over the pay rate to derive the bill rate. Expressed as a percentage (e.g., 45.00 = 45%). Captures the agreed margin structure for this job category and skill level.',
    `max_bill_rate` DECIMAL(18,2) COMMENT 'Ceiling bill rate above which the staffing firm may not price a submittal for this job category and skill level. Enforces client budget caps and VMS program rate compliance.',
    `min_bill_rate` DECIMAL(18,2) COMMENT 'Floor bill rate below which the staffing firm may not price a submittal for this job category and skill level. Enforces margin floor compliance during job order creation and candidate pricing.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or exceptions associated with this rate card line (e.g., client-specific rate exceptions, program notes, negotiation history summaries).',
    `pay_rate_guidance` DECIMAL(18,2) COMMENT 'Recommended or maximum hourly pay rate for the worker under this rate card line. Used as a pricing guardrail during candidate submittal to ensure spread and margin targets are maintained. Not a contractual pay commitment.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance rate for travel, lodging, and meals applicable to workers on this rate card line when deployed away from their primary work location. Null if per diem is not applicable for this engagement.',
    `rate_card_name` STRING COMMENT 'Human-readable name or label for the rate card, typically describing the client program, engagement type, or labor category scope (e.g., Acme Corp IT Contingent 2024).',
    `rate_card_number` STRING COMMENT 'Externally-known business identifier for the rate card, used in client communications, VMS integrations, and invoice references. Sourced from Beeline VMS or Salesforce Revenue Cloud.. Valid values are `^RC-[A-Z0-9]{4,20}$`',
    `salesforce_pricebook_code` STRING COMMENT 'Native price book entry identifier from Salesforce Revenue Cloud. Used for cross-system reconciliation between the lakehouse rate card and the Salesforce billing and invoicing configuration.',
    `spread_amount` DECIMAL(18,2) COMMENT 'Calculated difference between the regular bill rate and the pay rate guidance (Spread = Bill Rate - Pay Rate). Represents the gross dollar margin per hour before burden costs. Stored for operational reference and reporting; not recomputed at query time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate card record was last modified in the Staffing Hr lakehouse. Supports change tracking, audit trail, and data freshness monitoring.',
    `version_number` STRING COMMENT 'Sequential version number of the rate card, incremented each time the rate schedule is renegotiated or amended. Enables tracking of rate card history and supersession.',
    CONSTRAINT pk_client_rate_card PRIMARY KEY(`client_rate_card_id`)
) COMMENT 'Negotiated bill rate and markup schedule agreed upon with a client under an MSA or VMS program agreement. Captures job category, job title, skill level, bill rate (regular, OT, DT), pay rate guidance, markup percentage, spread (bill minus pay), burden rate inclusion flag, per diem rate, currency, effective date, expiration date, rate card version, and approval status. Sourced from Beeline VMS and Salesforce Revenue Cloud. Serves as the client-domain pricing reference for job order creation, candidate submittal pricing, and invoice generation. Note: contract-level rate schedule terms, rate escalation clauses, and contractual rate governance are owned by the contract domain; this product owns the operational rate table used in day-to-day staffing transactions.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` (
    `vms_program_id` BIGINT COMMENT 'Unique surrogate identifier for the VMS program record in the Staffing Hr lakehouse. Primary key for this entity. Entity role: MASTER_AGREEMENT — represents a long-running, binding contingent workforce program administered through a VMS platform.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that owns and administers this VMS program. Links the program to the authoritative client identity record in the client domain.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: A VMS program has a designated client-side program manager or VMS administrator contact who is the primary liaison for the contingent workforce program. Linking vms_program to client_contact via clien',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: A VMS program (client-managed contingent workforce program) frequently operates under a broader managed program umbrella (MSP/RPO). Linking vms_program to managed_program establishes the operational h',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: VMS programs operate under governing MSAs that define program terms, liability, and supplier obligations. Critical for program setup, compliance verification, and supplier onboarding. Replaces denorma',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: VMS programs in staffing frequently operate under a dedicated MSP/MSO SOW that defines program scope, fees, and deliverables separately from the master MSA. Direct SOW linkage enables program-level bi',
    `beeline_program_code` STRING COMMENT 'Native program identifier assigned by the Beeline VMS platform. Used for system-of-record reconciliation and integration with the Beeline API. Serves as the BUSINESS_IDENTIFIER for this agreement as known externally in the VMS ecosystem.',
    `bgc_required` BOOLEAN COMMENT 'Indicates whether a background check (BGC) is mandatory for all workers placed through this VMS program prior to assignment start. Drives onboarding workflow and Sterling Background Check integration requirements.',
    `bill_rate_cap_currency` STRING COMMENT 'ISO 4217 three-letter currency code applicable to bill rate caps and financial terms within this VMS program (e.g., USD, CAD, GBP). Ensures correct currency context for rate card enforcement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `conversion_fee_pct` DECIMAL(18,2) COMMENT 'Percentage fee charged to the client when a temporary worker placed through this VMS program converts to a permanent (direct hire) employee. Governs temp-to-perm and contract-to-hire financial terms within the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMS program record was first created in the Staffing Hr lakehouse. Represents the RECORD_AUDIT_CREATED category for this MASTER_AGREEMENT entity. Sourced from Beeline VMS integration load.',
    `data_privacy_addendum_on_file` BOOLEAN COMMENT 'Indicates whether a Data Privacy Addendum (DPA) or data processing agreement has been executed for this VMS program. Required for programs subject to GDPR, CCPA, or other data privacy regulations where worker personal data is shared with the clients VMS platform.',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether a pre-placement drug screening is required for all workers entering this VMS program. Impacts onboarding timelines and compliance with client safety and OSHA requirements.',
    `eor_required` BOOLEAN COMMENT 'Indicates whether the VMS program mandates use of an Employer of Record (EOR) arrangement for worker engagement. When true, Staffing Hr or a designated EOR entity assumes employer obligations including payroll, benefits, and compliance.',
    `everify_required` BOOLEAN COMMENT 'Indicates whether E-Verify employment eligibility verification is mandated for all workers placed through this VMS program. Relevant for federal contractor clients and OFCCP compliance obligations.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic scope of this VMS program (e.g., National, Northeast Region, California Only, Global — North America and EMEA). Determines which Staffing Hr branch offices and recruiters are eligible to fulfill requisitions under the program.',
    `ic_allowed` BOOLEAN COMMENT 'Indicates whether Independent Contractor (IC) worker classifications are permitted within this VMS program. Impacts worker classification compliance, IRS 1099 obligations, and co-employment risk management.',
    `invoice_frequency` STRING COMMENT 'Frequency at which Staffing Hr generates and submits invoices to the client through this VMS program. Aligns with timesheet approval cycles and client accounts payable requirements. Drives billing workflow in Salesforce Revenue Cloud and Oracle NetSuite ERP.. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMS program record was most recently modified in the Staffing Hr lakehouse. Used for change data capture (CDC), data lineage tracking, and audit compliance.',
    `markup_cap_pct` DECIMAL(18,2) COMMENT 'Maximum allowable markup percentage that Staffing Hr may apply above the pay rate when billing through this VMS program. Enforced by the VMS platform at time of rate submission. Critical financial constraint governing gross margin potential on all placements within the program. Expressed as a percentage (e.g., 35.00 = 35%).',
    `msp_partner_name` STRING COMMENT 'Name of the Managed Service Provider (MSP) that administers the VMS program on behalf of the client (e.g., Allegis Global Solutions, Pontoon, Workforce Logiq). Null when program_type is self-managed. Critical for understanding the intermediary controlling requisition flow and supplier tiering.',
    `nda_on_file` BOOLEAN COMMENT 'Indicates whether a Non-Disclosure Agreement (NDA) has been executed and is on file for this VMS program. Required for programs involving access to sensitive client data or proprietary information.',
    `on_site_coordinator_required` BOOLEAN COMMENT 'Indicates whether the VMS program requires Staffing Hr to provide a dedicated on-site coordinator or account manager at the client location. Impacts staffing firm resource allocation and cost structure for program participation.',
    `ot_markup_cap_pct` DECIMAL(18,2) COMMENT 'Maximum allowable markup percentage for overtime (OT) hours billed through this VMS program. May differ from the standard markup cap. Governs gross margin on OT billing and ensures FLSA-compliant rate submissions.',
    `per_diem_allowed` BOOLEAN COMMENT 'Indicates whether per diem expense reimbursements are permitted for workers placed through this VMS program. Relevant for travel-intensive assignments and impacts payroll burden calculations in TempWorks.',
    `po_required` BOOLEAN COMMENT 'Indicates whether a Purchase Order (PO) number is required on all invoices submitted through this VMS program. Impacts invoice processing workflow and accounts receivable management in Oracle NetSuite ERP.',
    `primary_labor_category` STRING COMMENT 'The dominant workforce labor category served by this VMS program (e.g., Information Technology, Light Industrial, Professional Services, Healthcare, Finance and Accounting). Used for program segmentation, analytics, and workforce planning reporting in Power BI.',
    `program_end_date` DATE COMMENT 'Date on which the VMS program is scheduled to expire or was terminated. Nullable for open-ended programs. Defines the EFFECTIVE_UNTIL boundary for supplier participation and rate applicability.',
    `program_name` STRING COMMENT 'Official name of the VMS contingent workforce program as configured in the VMS platform (e.g., Acme Corp Global Contingent Workforce Program). Used in reporting, supplier communications, and requisition routing. Serves as the IDENTITY_LABEL for this agreement.',
    `program_scope` STRING COMMENT 'Description of the workforce categories and labor types covered by this VMS program (e.g., All Categories, IT Only, Light Industrial, Professional Services, SOW and Services). Determines which job orders from this client flow through the VMS versus direct channels. [ENUM-REF-CANDIDATE: all_categories|it_only|light_industrial|professional|sow_services|clinical|finance_accounting — promote to reference product]',
    `program_start_date` DATE COMMENT 'Date on which the VMS program became or is scheduled to become operationally active. Defines the EFFECTIVE_FROM boundary for supplier participation, rate caps, and requisition routing rules.',
    `program_status` STRING COMMENT 'Current lifecycle state of the VMS program. Drives requisition routing eligibility, supplier participation, and rate card applicability. LIFECYCLE_STATUS for this MASTER_AGREEMENT entity.. Valid values are `active|pending|suspended|terminated|draft`',
    `program_type` STRING COMMENT 'Operational model under which the VMS program is administered. MSP-managed indicates a third-party Managed Service Provider controls supplier relationships and requisition flow; self-managed means the client administers directly; hybrid combines both models. CLASSIFICATION_OR_TYPE for this MASTER_AGREEMENT entity.. Valid values are `MSP-managed|self-managed|hybrid|RPO-managed`',
    `requisition_routing_rule` STRING COMMENT 'Rule or logic governing how new requisitions are distributed to suppliers within this VMS program (e.g., sequential by tier, broadcast to all tier-1, round-robin, category-based routing). Determines how Staffing Hr receives job orders and the competitive dynamics of the program.',
    `sla_tier` STRING COMMENT 'SLA tier classification assigned to this VMS program, reflecting the contractual service commitment level. Higher tiers carry stricter TTF, TTS, and QoS requirements. Aligns with the SLA tier defined in the client MSA.. Valid values are `platinum|gold|silver|bronze|standard`',
    `submission_limit_per_req` STRING COMMENT 'Maximum number of candidate submittals Staffing Hr is permitted to submit per requisition within this VMS program. Enforced by the VMS platform. Impacts sourcing strategy and Quality of Submission (QoS) focus.',
    `supplier_portal_url` STRING COMMENT 'URL of the VMS supplier portal through which Staffing Hr accesses requisitions, submits candidates, and manages worker records for this program. Operational reference for recruiter and account management teams.. Valid values are `^https?://.*`',
    `supplier_tier` STRING COMMENT 'Staffing Hrs designated tier level within the clients VMS supplier hierarchy. Tier 1 suppliers receive first-look requisition routing; lower tiers receive overflow or secondary routing. Directly impacts requisition volume, fill rate opportunity, and competitive positioning within the program.. Valid values are `tier_1|tier_2|tier_3|preferred|approved|backup`',
    `time_to_fill_days` STRING COMMENT 'Target number of calendar days from requisition open date to placement confirmation as defined in the VMS program SLA. Key performance indicator (KPI) for program compliance and client satisfaction measurement.',
    `time_to_submit_hours` STRING COMMENT 'Maximum number of hours from requisition release to candidate submittal allowed under this VMS programs SLA. Drives internal sourcing urgency and recruiter workflow prioritization. Measured in business hours unless otherwise specified.',
    `timesheet_approval_cycle` STRING COMMENT 'Frequency at which worker timesheets are submitted and approved within this VMS program. Drives Kronos Workforce Ready scheduling, payroll processing cycles in TempWorks, and billing cadence in Salesforce Revenue Cloud.. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `vms_fee_pct` DECIMAL(18,2) COMMENT 'Percentage fee charged by the VMS platform or MSP to Staffing Hr on each placement or billing transaction within this program. Deducted from the spread and directly reduces gross margin. Expressed as a percentage of bill rate (e.g., 2.50 = 2.5%).',
    `vms_platform` STRING COMMENT 'Name of the VMS technology platform through which this contingent workforce program is administered. Determines integration protocols, API endpoints, and data exchange formats used by Staffing Hr to receive requisitions and submit candidates.. Valid values are `Beeline|Fieldglass|Coupa|IQNavigator|Workday|Ariba`',
    `workers_comp_code` STRING COMMENT 'Workers Compensation insurance classification code applicable to the primary labor category within this VMS program. Drives burden rate calculations, insurance premium allocation, and payroll processing in TempWorks.',
    CONSTRAINT pk_vms_program PRIMARY KEY(`vms_program_id`)
) COMMENT 'Vendor Management System program record representing a client-managed contingent workforce program administered through a VMS technology platform. Captures program name, VMS platform (Beeline, Fieldglass, Coupa, IQNavigator), MSP partner name (if applicable), program type (MSP-managed, self-managed, hybrid), program scope (all categories, IT only, light industrial, professional, etc.), supplier tier structure, requisition routing rules, markup cap, program start date, program end date, and program status. Sourced from Beeline VMS integration. Critical for staffing firms participating in managed programs where requisition flow, rate caps, and supplier tiering are controlled by the client or their MSP.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`engagement` (
    `engagement_id` BIGINT COMMENT 'Unique surrogate primary key for each client engagement activity record in the Staffing Hr CRM system. Serves as the authoritative identifier for all touchpoints and interactions between Staffing Hr staff and client contacts. Role: TRANSACTION_HEADER.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account (employer organization) associated with this engagement activity. Links the engagement to the authoritative client master record in the client domain.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Client engagements are interactions with specific contacts at client accounts. Currently stores denormalized contact name/email/title. Adding contact_id FK normalizes this relationship and allows join',
    `location_id` BIGINT COMMENT 'Foreign key linking to client.location. Business justification: Client engagements have location_type and location_detail fields indicating where the engagement occurred. Adding location_id FK normalizes this to reference the authoritative location record. One eng',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Client engagements may be specifically about managed program (RPO/MSP) discussions, QBRs, or performance reviews. This allows tracking engagement activity by managed program. One engagement can refere',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: QBRs and renewal discussions (client engagements) are directly tied to a specific MSA under review. Linking engagement to MSA enables contract renewal pipeline tracking, QBR-to-contract outcome report',
    `order_header_id` BIGINT COMMENT 'Optional reference to a specific job order (requisition) that was the subject of this engagement. Enables linkage of engagement activity to open requisitions for pipeline and fill-rate analytics.',
    `sourcing_campaign_id` BIGINT COMMENT 'Reference to the marketing or outreach campaign in Salesforce that generated or is associated with this engagement. Supports marketing attribution and campaign effectiveness analysis.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Client engagements (meetings, QBRs, calls) frequently discuss specific supplier performance, issues, or selection decisions. Tracking which supplier was the subject enables relationship management, is',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: Client engagements may be specifically about VMS program discussions, reviews, or issues. This allows tracking engagement activity by VMS program. One engagement can reference one VMS program.',
    `assigned_staff_name` STRING COMMENT 'Full name of the internal Staffing Hr employee (recruiter or account manager) who conducted or owns this engagement. Denormalized for reporting convenience and historical accuracy in case of staff record changes.',
    `assigned_staff_role` STRING COMMENT 'Business role of the Staffing Hr staff member who conducted the engagement. Enables segmentation of engagement activity by function (e.g., recruiter-led vs. account manager-led touchpoints).. Valid values are `recruiter|account_manager|business_development|branch_manager|vp_sales|other`',
    `attendee_count` STRING COMMENT 'Total number of participants (both Staffing Hr staff and client contacts) who attended this engagement. Used for meeting complexity analysis and resource investment tracking.',
    `bullhorn_activity_code` STRING COMMENT 'Source system identifier for this engagement activity as recorded in Bullhorn ATS/CRM. Used for data lineage, deduplication, and cross-system reconciliation between Bullhorn and Salesforce.',
    `channel` STRING COMMENT 'The communication channel or medium through which the engagement was conducted (e.g., phone, video conference, in-person, email, SMS, client portal, social media). Distinct from engagement_type which captures the business purpose; this captures the delivery mechanism. [ENUM-REF-CANDIDATE: phone|video|in_person|email|sms|portal|social — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this engagement record was first created in the source system. Used for data lineage, audit trail compliance, and Silver layer ingestion tracking. Stored in ISO 8601 format.',
    `direction` STRING COMMENT 'Indicates whether the engagement was initiated by the client (inbound) or by Staffing Hr staff (outbound). Critical for measuring proactive account management activity versus reactive client-driven interactions.. Valid values are `inbound|outbound`',
    `duration_minutes` STRING COMMENT 'Recorded or calculated duration of the engagement activity in minutes. Used for account management effort tracking, relationship investment analysis, and QBR (Quarterly Business Review) reporting.',
    `end_timestamp` TIMESTAMP COMMENT 'The date and time the engagement activity concluded. Used in conjunction with engagement_timestamp to calculate actual duration. Nullable for instantaneous engagements such as emails.',
    `engagement_status` STRING COMMENT 'Current lifecycle state of the engagement activity record. Indicates whether the engagement was successfully completed, cancelled, or requires follow-up action. Supports pipeline and cadence tracking.. Valid values are `planned|completed|cancelled|no_show|rescheduled`',
    `engagement_timestamp` TIMESTAMP COMMENT 'The actual date and time the engagement activity occurred or was initiated. This is the principal real-world business event timestamp, distinct from record audit timestamps. Stored in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `engagement_type` STRING COMMENT 'Classification of the engagement activity by interaction modality. Drives reporting on account management cadence and relationship health. [ENUM-REF-CANDIDATE: call|email|meeting|site_visit|qbr|proposal_presentation|nps_survey|other — promote to reference product]',
    `follow_up_required` BOOLEAN COMMENT 'Flag indicating whether a follow-up action or engagement is required as a result of this interaction. Drives account management task queues and ensures no client touchpoint falls through the cracks.',
    `is_executive_sponsor_present` BOOLEAN COMMENT 'Flag indicating whether a Staffing Hr executive sponsor (e.g., VP, Director) participated in this engagement. Supports executive engagement tracking and strategic account management reporting.',
    `is_qbr` BOOLEAN COMMENT 'Flag indicating whether this engagement constitutes a formal Quarterly Business Review (QBR) with the client. Used to track QBR cadence compliance and account management quality metrics.',
    `next_action` STRING COMMENT 'Free-text description of the agreed or planned follow-up action resulting from this engagement. Drives account management cadence and ensures continuity of client relationship management.',
    `next_action_due_date` DATE COMMENT 'Target date by which the next follow-up action should be completed. Used for account management cadence tracking, SLA monitoring, and pipeline development reporting.',
    `notes` STRING COMMENT 'Free-text narrative capturing the details, discussion points, and context of the engagement activity. May contain commercially sensitive information about client needs, competitive intelligence, or relationship dynamics. Classified as confidential.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) value captured during an NPS survey engagement, ranging from 0 to 10. Null for non-NPS engagement types. Used for relationship health monitoring and client satisfaction reporting per ASA and SIA benchmarks.',
    `nps_verbatim` STRING COMMENT 'Free-text verbatim feedback provided by the client contact during an NPS survey engagement. Null for non-NPS engagement types. Classified as confidential due to commercially sensitive client sentiment data.',
    `outcome` STRING COMMENT 'Qualitative result or disposition of the engagement activity as assessed by the account manager or recruiter. Supports relationship health scoring and pipeline development analytics.. Valid values are `positive|neutral|negative|pending|escalated`',
    `pipeline_stage` STRING COMMENT 'CRM pipeline stage of the client account at the time of this engagement. Enables analysis of engagement activity by sales funnel stage and supports pipeline development reporting. [ENUM-REF-CANDIDATE: prospect|qualification|proposal|negotiation|closed_won|closed_lost|existing_client — 7 candidates stripped; promote to reference product]',
    `purpose` STRING COMMENT 'Business purpose or intent of the engagement activity. Provides finer-grained classification beyond engagement_type to support pipeline development and account management analytics. [ENUM-REF-CANDIDATE: relationship_building|job_order_discussion|submittal_review|placement_follow_up|billing_dispute|contract_renewal|nps_collection|pipeline_development|issue_resolution|other — promote to reference product]',
    `salesforce_activity_code` STRING COMMENT 'Source system identifier for this engagement activity as recorded in Salesforce CRM. Used for data lineage and cross-system reconciliation between Salesforce and Bullhorn.',
    `scheduled_date` DATE COMMENT 'The originally planned or scheduled date for this engagement activity. Distinct from engagement_timestamp which records the actual occurrence. Used to measure scheduling adherence and cadence planning.',
    `sla_tier` STRING COMMENT 'The SLA (Service Level Agreement) tier of the client account at the time of this engagement. Denormalized from the client account record to support historical analysis of engagement cadence relative to SLA commitments.. Valid values are `platinum|gold|silver|bronze|standard`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this engagement record was sourced (Bullhorn ATS/CRM, Salesforce, or manually entered). Supports data lineage and reconciliation in the Silver layer.. Valid values are `bullhorn|salesforce|manual`',
    `subject` STRING COMMENT 'Brief title or subject line describing the purpose or topic of the engagement activity. Mirrors the subject field in Bullhorn and Salesforce activity records. Used for search, filtering, and reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Audit timestamp recording when this engagement record was last modified in the source system. Used for incremental data loading, change detection, and audit trail compliance in the Databricks Silver layer.',
    CONSTRAINT pk_engagement PRIMARY KEY(`engagement_id`)
) COMMENT 'CRM engagement activity record capturing all touchpoints and interactions between Staffing Hr staff and client contacts. Sourced from Bullhorn CRM and Salesforce. Captures engagement type (call, email, meeting, site visit, QBR, proposal presentation, NPS survey), engagement date and time, duration, subject, outcome, next action, assigned recruiter or account manager, and engagement channel. Supports relationship health monitoring, account management cadence tracking, and pipeline development.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` (
    `account_segment_id` BIGINT COMMENT 'Unique surrogate identifier for the account segment record. Primary key for the account_segment data product in the client domain. Entity role: MASTER_RESOURCE — this product defines a commercial segmentation and classification record for a client account, carrying its own identity, lifecycle, and quantitative facts.',
    `client_account_id` BIGINT COMMENT 'Reference to the parent client account record in the client.client_account product. Establishes which client employer this segmentation record belongs to.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: Account segments are often defined by primary labor category (e.g., light industrial, IT, clerical). Linking account_segment to job_category enables market rate benchmarking, segment-level fill rate a',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Account segments have msp_program_flag and rpo_program_flag indicating managed program participation, but lack the FK to identify which specific managed program. This enables segmentation analysis by ',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: Account segments have vms_program_flag indicating VMS program participation, but lack the FK to identify which specific VMS program. This enables segmentation analysis by VMS program. One segment can ',
    `active_placement_count` STRING COMMENT 'Current number of active worker placements (temporary assignments and permanent placements) at this account segment as of the last data refresh. Key operational metric for workforce density and account health assessment. Sourced from Bullhorn ATS/CRM placement records.',
    `active_req_count` STRING COMMENT 'Current number of open job requisitions (Reqs) active for this account segment at the time of the last data refresh. Provides a real-time demand signal for recruiter capacity planning and segment health monitoring. Sourced from Bullhorn ATS/CRM job order data.',
    `annual_revenue_band` STRING COMMENT 'Banded classification of the client companys estimated annual revenue, used for market sizing, credit risk assessment, and service tier alignment. Bands: under_1m, 1m_to_10m, 10m_to_50m, 50m_to_250m, over_250m (USD). Confidential business intelligence used in go-to-market prioritization.. Valid values are `under_1m|1m_to_10m|10m_to_50m|50m_to_250m|over_250m`',
    `conversion_fee_pct` DECIMAL(18,2) COMMENT 'Agreed conversion fee percentage charged to the client when a temporary worker converts to a permanent (direct hire) employee, expressed as a percentage of the converted workers first-year salary. Applicable for temp-to-perm and contract-to-hire arrangements. Confidential commercial term.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account segment record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Serves as the RECORD_AUDIT_CREATED category for this entity. Used for data lineage, audit trail, and compliance reporting.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance (in USD) approved for this account segment before new placements or timesheets are placed on hold. Segment-level credit limit may be more restrictive than the parent client_account credit limit for specific service lines or geographies.',
    `direct_hire_fee_pct` DECIMAL(18,2) COMMENT 'Agreed placement fee percentage charged to the client for direct hire (permanent placement) engagements, expressed as a percentage of the placed candidates first-year base salary. Confidential commercial pricing term negotiated at the account segment level.',
    `effective_date` DATE COMMENT 'Date on which this segment classification became effective and began driving territory planning, resource allocation, and go-to-market prioritization decisions. Serves as the EFFECTIVE_FROM category for this MASTER_RESOURCE entity.',
    `estimated_annual_staffing_spend` DECIMAL(18,2) COMMENT 'Estimated total annual spend (in USD) the client account allocates to contingent and permanent staffing services across all providers. Used to calculate wallet share and prioritize account investment. This is the principal quantitative fact (MEASUREMENT_OR_VALUE) for this MASTER_RESOURCE entity. Sourced from Salesforce Revenue Cloud opportunity data and market intelligence.',
    `expiration_date` DATE COMMENT 'Date on which this segment classification expires and is subject to review or reclassification. Nullable for open-ended segment assignments. Serves as the EFFECTIVE_UNTIL category for this MASTER_RESOURCE entity.',
    `fall_off_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of placements at this account segment that ended prematurely (fall-offs) within the trailing 12-month period, calculated as (fall-off placements / total placements) * 100. Fall-off rate is a key quality metric in staffing, indicating placement quality and candidate-client fit. Used to assess recruiter performance and account health.',
    `geographic_market` STRING COMMENT 'Primary geographic market or territory associated with this client account segment, used for territory planning and regional resource allocation (e.g., Northeast, Southeast, Midwest, West, National, International). Drives assignment of regional account managers and branch coverage. [ENUM-REF-CANDIDATE: northeast|southeast|midwest|west|southwest|national|international — promote to reference product]',
    `gross_margin_target_pct` DECIMAL(18,2) COMMENT 'Target gross margin percentage for this account segment, representing the spread (bill rate minus pay rate and burden costs) as a percentage of the bill rate. Used to evaluate account profitability and guide pricing decisions. Confidential financial target data.',
    `headcount_band` STRING COMMENT 'Banded classification of the client companys total employee headcount, used to estimate staffing demand potential and align service model complexity. Bands represent total FTE (Full-Time Equivalent) employees at the client organization.. Valid values are `1_to_50|51_to_250|251_to_1000|1001_to_5000|over_5000`',
    `last_reviewed_date` DATE COMMENT 'Date on which this account segment classification was most recently reviewed and confirmed or updated by the account management team. Used to track review cadence compliance and identify stale segment assignments.',
    `markup_pct` DECIMAL(18,2) COMMENT 'Standard markup percentage applied to pay rates to derive bill rates for this account segment, expressed as a decimal percentage (e.g., 45.00 = 45%). Markup covers burden costs (FICA, FUTA, SUTA, Workers Comp), overhead, and gross margin. Confidential commercial pricing data. Sourced from Salesforce Revenue Cloud rate card configuration.',
    `msp_program_flag` BOOLEAN COMMENT 'Indicates whether this client account is managed through a Managed Service Provider (MSP) program, where a third-party MSP intermediary manages the contingent workforce program on behalf of the client. Affects supplier tier, rate card access, and billing routing.',
    `nps_score` STRING COMMENT 'Most recent Net Promoter Score (NPS) recorded for this account segment, ranging from -100 to 100. NPS measures client loyalty and likelihood to recommend Staffing Hrs services. Segment-level NPS may differ from the parent client_account NPS if multiple business units or service lines are surveyed independently.',
    `nps_survey_date` DATE COMMENT 'Date on which the most recent NPS (Net Promoter Score) survey was conducted for this account segment. Used to assess recency of satisfaction data and trigger follow-up surveys per client experience policy.',
    `on_site_program_flag` BOOLEAN COMMENT 'Indicates whether this client account has an on-site staffing program where a Staffing Hr on-site manager or coordinator is physically embedded at the client location to manage the contingent workforce. Drives on-site headcount budgeting and operational cost allocation.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the client is contractually required to remit payment for this account segment (e.g., Net 30, Net 45, Net 60). May differ from the parent client_account default payment terms if segment-specific terms have been negotiated.',
    `preferred_supplier_status` STRING COMMENT 'Staffing Hrs supplier status designation within the clients vendor program. Preferred indicates highest-priority routing of requisitions. Tier_1 and Tier_2 reflect VMS/MSP program supplier tiers. Approved indicates active but non-preferred status. Not_listed indicates no formal supplier agreement in place.. Valid values are `preferred|approved|tier_1|tier_2|not_listed`',
    `primary_service_line` STRING COMMENT 'The principal staffing service line through which this client account is primarily served. Temp Staffing (temporary placement), Direct Hire (permanent placement), RPO (Recruitment Process Outsourcing), MSP (Managed Service Provider program), Contract-to-Hire (temp-to-perm), SOW (Statement of Work-based project staffing). Drives billing model, recruiter assignment, and operational workflow.. Valid values are `temp_staffing|direct_hire|rpo|msp|contract_to_hire|sow`',
    `prior_segment_tier` STRING COMMENT 'The segment tier assigned to this account immediately before the most recent reclassification event. Enables trend analysis of account movement across tiers (upgrades vs. downgrades). Null if this is the initial segment assignment.. Valid values are `strategic|key|growth|transactional`',
    `reclassification_reason` STRING COMMENT 'Free-text or coded reason explaining why this account segment was reclassified from a prior tier or service model. Supports audit trail and trend analysis of segment movement (e.g., Revenue decline below key tier threshold, New MSP program win — upgraded to strategic). Populated only when a reclassification event occurs.',
    `rpo_program_flag` BOOLEAN COMMENT 'Indicates whether this client account has an active Recruitment Process Outsourcing (RPO) engagement with Staffing Hr, where Staffing Hr manages some or all of the clients permanent hiring process. Drives RPO-specific SLA tracking and dedicated recruiter team assignment.',
    `segment_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this segment classification record, used in territory planning reports, go-to-market materials, and CRM tagging (e.g., SEG-STRAT-001). Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `segment_notes` STRING COMMENT 'Free-text field for account managers and strategic planners to capture qualitative context about this account segment, including competitive intelligence, relationship history, strategic initiatives, or special handling instructions not captured in structured fields.',
    `segment_review_date` DATE COMMENT 'Scheduled date for the next periodic review and potential reclassification of this account segment. Ensures segment tiers remain current with client revenue performance and strategic fit. Typically set on an annual or semi-annual cadence per territory planning policy.',
    `segment_status` STRING COMMENT 'Current lifecycle state of the account segment record. Active indicates the segmentation is in force and driving territory and resource decisions. Under_review indicates a pending reclassification. Inactive indicates the segment assignment has lapsed. Archived indicates historical record retained for audit. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity.. Valid values are `active|under_review|inactive|archived`',
    `segment_tier` STRING COMMENT 'Strategic classification tier assigned to the client account, defining the level of investment, service intensity, and executive attention. Values: strategic (top-tier, highest revenue potential), key (established high-value), growth (emerging high-potential), transactional (volume-based, lower-touch). Serves as the primary CLASSIFICATION_OR_TYPE for this entity.. Valid values are `strategic|key|growth|transactional`',
    `sla_tier` STRING COMMENT 'SLA (Service Level Agreement) tier assigned to this account segment, defining the contractual service performance standards including Time to Fill (TTF), Time to Start (TTS), submittal quality, and response time commitments. Platinum and Gold tiers carry the most stringent SLA obligations. Distinct from the sla_tier on client_account which may reflect the MSA-level SLA; this field reflects the segment-specific SLA classification.. Valid values are `platinum|gold|silver|standard`',
    `target_ttf_days` STRING COMMENT 'Target number of business days from job order receipt to candidate submittal, as defined for this account segments SLA tier. TTF (Time to Fill) is a core KPI in staffing operations. Used to set recruiter performance expectations and measure delivery quality against segment commitments.',
    `target_tts_days` STRING COMMENT 'Target number of calendar days from job order receipt to candidate start date, as defined for this account segments SLA tier. TTS (Time to Start) measures the full cycle from requisition to placement and is a key client satisfaction metric in staffing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this account segment record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change detection, incremental data pipeline processing, and audit trail maintenance.',
    `vertical_industry` STRING COMMENT 'Primary industry vertical the client account operates in, used to align staffing service delivery, recruiter specialization, and go-to-market strategy (e.g., Healthcare, Technology, Manufacturing, Financial Services, Logistics). Aligns with NAICS/SIC classification on the parent client_account record. [ENUM-REF-CANDIDATE: healthcare|technology|manufacturing|financial_services|logistics|retail|energy|government|education|professional_services — promote to reference product]',
    `vms_program_flag` BOOLEAN COMMENT 'Indicates whether this client account operates through a Vendor Management System (VMS) program, requiring Staffing Hr to submit candidates and timesheets through a third-party VMS platform (e.g., Beeline, SAP Fieldglass, Coupa). Drives operational workflow routing and VMS compliance requirements.',
    `wallet_share_pct` DECIMAL(18,2) COMMENT 'Estimated percentage of the clients total annual staffing spend currently captured by Staffing Hr, expressed as a decimal percentage (e.g., 35.50 = 35.5%). Calculated as (Staffing Hr annual billings / estimated_annual_staffing_spend) * 100. Used to identify whitespace and cross-sell opportunities. Stored as a raw business estimate, not a computed KPI.',
    CONSTRAINT pk_account_segment PRIMARY KEY(`account_segment_id`)
) COMMENT 'Commercial segmentation and classification record for a client account, defining strategic tier, revenue potential, and service model. Captures segment tier (strategic, key, growth, transactional), vertical industry focus, geographic market, annual revenue band, headcount band, estimated annual staffing spend, wallet share estimate, primary service line (temp staffing, direct hire, RPO, MSP), account manager assignment, and segment review date. Used for territory planning, resource allocation, and go-to-market prioritization.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` (
    `program_supplier_id` BIGINT COMMENT 'Unique surrogate identifier for the program supplier association record. Primary key for this entity in the Databricks Silver Layer. Entity role: JUNCTION (extended) — links a staffing supplier/vendor to a specific VMS program and carries its own participation terms, tier assignments, and performance metrics.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that owns and manages this VMS contingent workforce program. Establishes the demand-side context for the supplier participation record.',
    `credential_package_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential_package. Business justification: Suppliers enrolled in a managed program must comply with a specific credential package defining BGC, drug screen, and training requirements for their workers. MSP program management requires linking e',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Suppliers can participate in managed programs (RPO/MSP) in addition to VMS programs. This allows tracking supplier participation across both VMS and managed program types. One supplier association to ',
    `nda_id` BIGINT COMMENT 'Foreign key linking to contract.nda. Business justification: Supplier NDA compliance per program enrollment is a standard staffing procurement requirement. Normalizing nda_on_file (boolean) to a direct NDA FK enables expiration tracking, document retrieval, and',
    `supplier_id` BIGINT COMMENT 'Reference to the staffing supplier/vendor master record in the vendor domain. Vendor identity and master data are owned by the vendor domain; this product owns only the program-specific participation terms.',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.vendor_agreement. Business justification: Each supplier enrolled in a managed program operates under a specific vendor agreement governing rates, compliance, and terms. Normalizing replaces denormalized msa_on_file/msa_effective_date/msa_expi',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS contingent workforce program this supplier is enrolled in. Links to the client-managed program record within the Beeline VMS platform.',
    `active_assignment_count` STRING COMMENT 'Current number of active worker assignments placed by this supplier within the program at the time of the last data refresh. Provides a real-time headcount view of the suppliers workforce contribution to the program. Sourced from Beeline VMS.',
    `authorized_job_categories` STRING COMMENT 'Comma-delimited list of job category codes or names that this supplier is authorized to fill within the program (e.g., IT, Finance, Engineering, Light Industrial). Restricts the suppliers submission eligibility to approved labor categories only.',
    `avg_time_to_fill_days` DECIMAL(18,2) COMMENT 'Average number of calendar days from requisition release to candidate placement for this supplier within the program. A core SLA and KPI metric used to evaluate supplier responsiveness and efficiency. Sourced from Beeline VMS supplier scorecard.',
    `beeline_supplier_program_code` STRING COMMENT 'The externally-known unique identifier assigned by Beeline VMS to this supplier-program enrollment record. Used for cross-system reconciliation and integration with the source VMS platform.',
    `compliance_status` STRING COMMENT 'Certification and compliance status of the supplier within the program. Reflects whether the supplier has met all program-required compliance obligations including insurance certificates, diversity certifications, background check protocols, I-9 compliance, and contractual requirements.. Valid values are `compliant|non_compliant|pending_review|conditionally_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this program supplier association record was first created in the system. Represents the audit creation time in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage and audit trail purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary rate fields for this supplier-program record (e.g., USD, CAD, GBP). Supports multi-currency VMS programs for multinational clients.. Valid values are `^[A-Z]{3}$`',
    `diversity_certification_type` STRING COMMENT 'The specific type of diversity certification held by this supplier, if applicable. Used for OFCCP compliance reporting and corporate diversity spend analytics. [ENUM-REF-CANDIDATE: MBE|WBE|SDVOSB|HUBZone|LGBTBE|DVBE|none — promote to reference product if additional types are needed]',
    `diversity_certified` BOOLEAN COMMENT 'Indicates whether this supplier holds a recognized diversity certification (e.g., MBE, WBE, SDVOSB, HUBZone). Many enterprise VMS programs track diversity supplier participation for OFCCP compliance and corporate diversity spend reporting.',
    `enrollment_date` DATE COMMENT 'The date on which the supplier was formally enrolled and activated within the VMS program. Marks the effective start of the suppliers participation terms and eligibility to receive requisitions.',
    `enrollment_end_date` DATE COMMENT 'The date on which the suppliers participation in the VMS program is scheduled to end or was terminated. Null for open-ended enrollments. Used for contract lifecycle management and program renewal tracking.',
    `fall_off_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of placements made by this supplier within the program that ended prematurely (before the scheduled assignment end date). High fall-off rates indicate poor candidate quality or fit. Used in tier review and supplier performance management.',
    `fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of requisitions assigned to this supplier that were successfully filled within the program period. Calculated as filled requisitions divided by total requisitions routed to the supplier. Key KPI for supplier performance evaluation and tier assignment.',
    `insurance_expiration_date` DATE COMMENT 'The expiration date of the suppliers most recently verified insurance certificate on file for this program. Used to trigger renewal alerts and compliance reviews before coverage lapses.',
    `insurance_verified` BOOLEAN COMMENT 'Indicates whether the suppliers required insurance certificates (general liability, workers compensation, professional liability) have been verified and are current within the program. Required for program participation and compliance.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance review conducted for this supplier within the program. Used to track review cadence and ensure timely tier reassessment based on performance metrics.',
    `markup_cap_percent` DECIMAL(18,2) COMMENT 'The maximum markup percentage this supplier is permitted to apply above the pay rate when billing within this program. Enforced by the VMS platform at submission time. Expressed as a percentage (e.g., 35.00 = 35%). Represents the Spread/Markup ceiling negotiated for this supplier within the program.',
    `max_bill_rate` DECIMAL(18,2) COMMENT 'The maximum bill rate (in the programs currency) that this supplier is authorized to submit for any candidate within this program. Acts as a rate ceiling enforced by the VMS platform at submission time. Distinct from the markup cap percentage.',
    `next_performance_review_date` DATE COMMENT 'The scheduled date for the next formal performance review of this supplier within the program. Supports proactive program management and ensures regular supplier evaluation cadence.',
    `onboarding_complete` BOOLEAN COMMENT 'Indicates whether the supplier has completed all required onboarding steps for this program, including document submission, compliance verification, system access provisioning, and training acknowledgments. Prerequisite for receiving live requisitions.',
    `performance_score` DECIMAL(18,2) COMMENT 'Composite performance score for this supplier within the program, calculated by the VMS platform based on fill rate, time-to-fill (TTF), quality of submission (QoS), assignment completion rate, and fall-off rate. Typically expressed on a 0–100 scale. Used for tier review and program renewal decisions.',
    `preferred_worker_type` STRING COMMENT 'The worker classification type(s) this supplier primarily places within the program (W-2 employees, 1099 independent contractors, Corp-to-Corp, or Employer of Record). Relevant for IRS worker classification compliance and co-employment risk management.. Valid values are `W2|1099|corp_to_corp|EOR|all`',
    `program_contact_email` STRING COMMENT 'Email address of the primary contact person at the supplier organization for this program. Used for requisition notifications, compliance alerts, and program communications via Beeline VMS.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `program_contact_name` STRING COMMENT 'Full name of the primary contact person at the supplier organization responsible for managing this program relationship. This is the supplier-side account manager or program coordinator for the VMS engagement.',
    `requisition_routing_order` STRING COMMENT 'Numeric sequence position determining the order in which this supplier receives requisition notifications within the program tier. Lower numbers receive requisitions first. Used to implement tiered routing logic (e.g., preferred suppliers receive reqs before approved suppliers).',
    `response_time_sla_hours` STRING COMMENT 'The maximum number of hours within which this supplier is contractually required to respond to a new requisition notification within the program. Defines the SLA commitment for supplier responsiveness. Tracked against actual response times for SLA compliance reporting.',
    `submission_limit_per_req` STRING COMMENT 'Maximum number of candidate submittals this supplier is allowed to make per open requisition within the program. Controls Quality of Submission (QoS) and prevents requisition flooding. Enforced by Beeline VMS at the time of submittal.',
    `supplier_status` STRING COMMENT 'Current participation status of the supplier within this specific VMS program. Active suppliers can receive and respond to requisitions; suspended suppliers are temporarily blocked; removed suppliers have been permanently disqualified from the program.. Valid values are `active|suspended|removed|pending_approval|inactive`',
    `supplier_tier` STRING COMMENT 'Tier classification of the supplier within the VMS program, determining routing priority for requisitions. Preferred suppliers receive first-look on new requisitions; approved suppliers are standard participants; backup suppliers are used when preferred/approved cannot fill; probationary suppliers are under performance review.. Valid values are `preferred|approved|backup|probationary|suspended`',
    `suspension_date` DATE COMMENT 'The date on which the supplier was suspended or removed from the program. Populated when supplier_status transitions to suspended or removed. Used for compliance audit trails and program governance reporting.',
    `suspension_reason` STRING COMMENT 'Free-text description of the reason for supplier suspension or removal from the program, if applicable. Populated when supplier_status is suspended or removed. Supports audit trail and program governance documentation.',
    `total_submittals_ytd` STRING COMMENT 'Total number of candidate submittals made by this supplier within the program in the current calendar year. Used to assess supplier engagement level and submission volume relative to program activity.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this program supplier association record was most recently modified. Tracks the last update event for change detection, incremental ETL processing, and audit trail compliance in the Databricks Silver Layer.',
    `vms_supplier_code` STRING COMMENT 'The supplier code or identifier assigned by the clients VMS platform (Beeline) to this supplier within the program. Used as the operational reference key in VMS-generated reports, requisition routing, and timesheet approvals.',
    CONSTRAINT pk_program_supplier PRIMARY KEY(`program_supplier_id`)
) COMMENT 'Association record linking a staffing supplier (vendor) to a specific VMS program, capturing the suppliers participation terms and performance within a client-managed contingent workforce program. Captures supplier tier (preferred, approved, backup), category authorization (which job categories the supplier can fill), markup cap for this supplier within the program, submission limit per requisition, performance score, program enrollment date, certification/compliance status within the program, and supplier status (active, suspended, removed). Sourced from Beeline VMS. Note: supplier/vendor identity and master data are owned by the vendor domain; this product owns only the program-specific participation terms, tier assignments, and performance metrics within the clients program context.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` (
    `sla_measurement_id` BIGINT COMMENT 'Unique surrogate primary key for each SLA measurement record. Identifies a single periodic performance measurement instance against a defined SLA configuration. Entity role: TRANSACTION_HEADER — a discrete business event capturing actual vs. target SLA performance for a reporting window.',
    `client_account_id` BIGINT COMMENT 'Reference to the client (employer) account for whom this SLA measurement is being evaluated. Serves as the PARTY_REFERENCE linking this measurement to the demand-side client entity in the client domain.',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: SLA measurements can apply to managed programs (RPO/MSP) in addition to VMS programs. This allows tracking SLA performance for managed workforce programs. One measurement for one managed program.',
    `sla_id` BIGINT COMMENT 'Reference to the SLA configuration record that defines the metric type, target thresholds, and measurement rules governing this measurement. Links the measurement to its governing SLA definition.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SLA measurements frequently track supplier-specific metrics (fill rate, time-to-fill, quality of submission) within VMS/MSP programs. Linking measurements to suppliers enables performance reporting, s',
    `vms_program_id` BIGINT COMMENT 'The program identifier from the Beeline VMS or equivalent VMS platform for clients operating under a VMS/MSP (Managed Service Provider) program. Enables correlation of SLA measurements with VMS-tracked requisitions and submittals.',
    `account_health_score` DECIMAL(18,2) COMMENT 'A composite numeric score (0–100) representing the overall health of the client account based on this measurement periods SLA performance. Derived from weighted SLA compliance results and used for account risk segmentation and QBR preparation.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The contractual bonus dollar amount earned by over-performance in this measurement period, as calculated per the bonus formula in the SLA configuration. Populated only when bonus_triggered is True. Used for billing adjustments and incentive tracking.',
    `bonus_triggered` BOOLEAN COMMENT 'Boolean flag indicating whether the SLA over-performance in this measurement period has triggered a contractual bonus or incentive clause. True = bonus applies; False = no bonus. Drives positive billing adjustments in Salesforce Revenue Cloud.',
    `compliance_direction` STRING COMMENT 'Indicates whether a higher or lower measured value represents better performance for this metric type. higher_is_better applies to fill_rate, qos, retention_rate; lower_is_better applies to TTF and TTS (fewer days is better). Required to correctly interpret variance sign for compliance determination.. Valid values are `higher_is_better|lower_is_better`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA measurement record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for data lineage, audit trail, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to penalty_amount and bonus_amount fields (e.g., USD, CAD, GBP). Supports multi-currency client engagements in international staffing operations.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Free-text description of the clients stated reason for disputing this SLA measurement result. Populated only when measurement_status is disputed. Supports dispute resolution workflows and MSA compliance documentation.',
    `dispute_resolved_date` DATE COMMENT 'The date on which a disputed SLA measurement was formally resolved between the staffing firm and the client. Populated only when a dispute has been closed. Used to track dispute resolution cycle times and SLA governance compliance.',
    `excluded_req_count` STRING COMMENT 'Number of requisitions excluded from the SLA measurement scope due to agreed exclusion criteria (e.g., client holds, force majeure, late job order submissions). Provides transparency into the effective denominator used in SLA calculations.',
    `exclusion_reason` STRING COMMENT 'Describes any agreed-upon exclusions applied to the measurement scope (e.g., client-caused delays, force majeure, requisitions excluded per MSA terms). Populated when certain requisitions or placements were removed from the SLA calculation denominator.',
    `fall_off_count` STRING COMMENT 'Number of placements that ended prematurely (fall-offs) during the measurement period before the expected assignment end date. High fall-off counts negatively impact retention rate SLA metrics and may trigger penalty clauses.',
    `fill_count` STRING COMMENT 'Number of requisitions that were successfully filled (placement confirmed) within the measurement period. Used as the numerator in fill rate calculations and as a direct performance indicator for talent acquisition effectiveness.',
    `fill_rate_actual` DECIMAL(18,2) COMMENT 'The actual fill rate for the measurement period expressed as a percentage (0–100), calculated as fill_count divided by req_count multiplied by 100. Measures the staffing firms ability to fulfill client demand within the period.',
    `finalized_date` DATE COMMENT 'The date on which this SLA measurement record was locked and finalized for reporting. Represents the BUSINESS_EVENT_TIMESTAMP for the finalization lifecycle event. Once finalized, the record is immutable for audit and billing purposes.',
    `is_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the measured performance met or exceeded the SLA target for this measurement period. True = SLA met (compliant); False = SLA missed (breach). Primary compliance indicator used in account health scoring and QBR reporting.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual observed performance value for the SLA metric during the measurement period. Interpretation depends on sla_metric_type: for TTF/TTS this is average calendar days; for fill_rate/qos/retention_rate this is a percentage (0–100); for submittal_ratio this is a ratio. This is the QUANTITATIVE_RESULT for this transaction.',
    `measurement_notes` STRING COMMENT 'Free-text field for account managers or operations staff to document contextual notes about this measurement record, such as explanations for SLA misses, data quality caveats, client-agreed exclusions, or force majeure circumstances affecting performance.',
    `measurement_number` STRING COMMENT 'Externally-known business identifier for this measurement record, used in client-facing QBR (Quarterly Business Review) reports, penalty/bonus calculations, and audit trails. Format: SLA-MEAS-{YYYY}-{NNNNNN}.. Valid values are `^SLA-MEAS-[0-9]{4}-[0-9]{6}$`',
    `measurement_source_system` STRING COMMENT 'The operational system of record from which the measurement data was sourced. Identifies data lineage for audit and reconciliation purposes. manual indicates data was entered directly by an account manager outside of automated system feeds.. Valid values are `bullhorn|beeline_vms|kronos|tempworks|power_bi|manual`',
    `measurement_status` STRING COMMENT 'Current lifecycle state of the SLA measurement record. draft indicates data is being collected; pending_review awaits account manager sign-off; finalized is locked for reporting; disputed is under client challenge; voided has been invalidated.. Valid values are `draft|pending_review|finalized|disputed|voided`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The contractual penalty dollar amount triggered by this SLA breach, as calculated per the penalty formula in the SLA configuration. Populated only when penalty_triggered is True. Used for billing credit adjustments and financial reporting.',
    `penalty_triggered` BOOLEAN COMMENT 'Boolean flag indicating whether the SLA breach in this measurement period has triggered a contractual penalty clause as defined in the MSA or SLA addendum. True = penalty applies; False = no penalty. Drives billing adjustments in Salesforce Revenue Cloud.',
    `period_end_date` DATE COMMENT 'The last calendar date of the reporting window for which SLA performance is being measured. Defines the close of the measurement interval and determines which requisitions, placements, and timesheets fall within scope.',
    `period_start_date` DATE COMMENT 'The first calendar date of the reporting window for which SLA performance is being measured. Combined with period_end_date, defines the exact scope of the measurement interval (weekly, monthly, quarterly, etc.).',
    `period_type` STRING COMMENT 'Categorizes the cadence of the measurement window. Determines how frequently SLA compliance is evaluated and reported to the client. Drives QBR preparation and penalty/bonus calculation cycles.. Valid values are `weekly|bi_weekly|monthly|quarterly|annual`',
    `qbr_period_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this measurement record falls within a QBR reporting period and should be included in the formal Quarterly Business Review package presented to the client. True = include in QBR; False = standard operational measurement only.',
    `qos_actual_rate` DECIMAL(18,2) COMMENT 'The actual QoS rate for the measurement period, expressed as a percentage (0–100). Typically calculated as the ratio of client-accepted submittals to total submittals, or interview-to-submittal ratio. Measures the quality and relevance of candidate submittals.',
    `req_count` STRING COMMENT 'Total number of open requisitions (job orders) that fell within the measurement period scope and were included in the SLA calculation. Provides the denominator context for fill rate and submittal ratio calculations.',
    `retention_rate_actual` DECIMAL(18,2) COMMENT 'The actual assignment retention rate for the measurement period expressed as a percentage (0–100). Measures the proportion of placed workers who remained on assignment through the expected end date, excluding early terminations and fall-offs.',
    `sla_metric_type` STRING COMMENT 'The specific KPI (Key Performance Indicator) being measured in this record. TTF = Time to Fill; TTS = Time to Start; fill_rate = percentage of requisitions filled; QoS = Quality of Submission rate; submittal_ratio = submittals per req; retention_rate = assignment retention. [ENUM-REF-CANDIDATE: ttf|tts|fill_rate|qos|submittal_ratio|retention_rate|on_time_start|absence_rate — promote to reference product]. Valid values are `ttf|tts|fill_rate|qos|submittal_ratio|retention_rate`',
    `submittal_count` STRING COMMENT 'Total number of candidate submittals made to the client across all in-scope requisitions during the measurement period. Used in QoS (Quality of Submission) and submittal ratio calculations.',
    `target_value` DECIMAL(18,2) COMMENT 'The contractually agreed performance threshold for the SLA metric as defined in the SLA configuration. Represents what was promised to the client in the MSA (Master Service Agreement) or SLA addendum. Used as the benchmark for compliance determination.',
    `ttf_actual_avg_days` DECIMAL(18,2) COMMENT 'The actual average number of calendar days from requisition open date to confirmed placement (fill) across all in-scope requisitions during the measurement period. Core TTF KPI metric used in SLA compliance evaluation and client QBR reporting.',
    `tts_actual_avg_days` DECIMAL(18,2) COMMENT 'The actual average number of calendar days from requisition open date to the workers first day on assignment across all in-scope placements during the measurement period. TTS measures end-to-end speed including onboarding and credentialing.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this SLA measurement record was last modified. Serves as the RECORD_AUDIT_UPDATED field for change tracking, data freshness monitoring, and Silver layer delta processing.',
    `variance_pct` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the target value ((measured_value - target_value) / target_value * 100). Enables normalized comparison of SLA performance across different metric types and clients regardless of unit scale.',
    `variance_value` DECIMAL(18,2) COMMENT 'The arithmetic difference between measured_value and target_value (measured_value minus target_value). Positive variance indicates over-performance; negative variance indicates under-performance. Used to quantify the degree of SLA compliance or breach for penalty/bonus triggers.',
    CONSTRAINT pk_sla_measurement PRIMARY KEY(`sla_measurement_id`)
) COMMENT 'Periodic performance measurement record capturing actual results against a defined SLA configuration for a specific reporting window. Captures measurement period (start/end date), SLA config reference, measured value, target value, variance, compliance flag (met/missed), requisition count in scope, fill count, TTF (Time to Fill) actual average, TTS (Time to Start) actual average, QoS (Quality of Submission) actual rate, fill rate actual, and measurement source system. Generated from operational data in the recruitment and placement domains. Enables SLA compliance reporting, client QBR (Quarterly Business Review) preparation, penalty/bonus calculation triggers, and account health scoring.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique identifier for the credit profile record. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account this credit profile belongs to. Links to the client_account master record.',
    `prior_credit_profile_id` BIGINT COMMENT 'Self-referencing FK on credit_profile (prior_credit_profile_id)',
    `aging_30_days_amount` DECIMAL(18,2) COMMENT 'Total outstanding receivables aged 31-60 days past invoice date. Indicates early payment delays.',
    `aging_60_days_amount` DECIMAL(18,2) COMMENT 'Total outstanding receivables aged 61-90 days past invoice date. Signals moderate collection risk.',
    `aging_90_plus_days_amount` DECIMAL(18,2) COMMENT 'Total outstanding receivables aged 91+ days past invoice date. High collection risk; may require write-off or legal action.',
    `aging_current_amount` DECIMAL(18,2) COMMENT 'Total outstanding receivables in the current bucket (0-30 days past invoice date). Part of AR aging summary.',
    `approving_authority` STRING COMMENT 'Name or role of the individual or committee who approved the credit decision (e.g., Credit Manager, CFO, Credit Committee).',
    `available_credit` DECIMAL(18,2) COMMENT 'Remaining credit capacity calculated as credit_limit minus total_outstanding_balance. Negative values indicate over-limit condition.',
    `bank_reference` STRING COMMENT 'Name and contact information of the clients primary banking institution, used for credit verification and reference checks.',
    `bankruptcy_date` DATE COMMENT 'Date of the most recent bankruptcy filing, if applicable. Null if no bankruptcy on record.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether the client has an active or recent bankruptcy filing on record. True triggers automatic credit hold and legal review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was first created in the system. Audit trail for record creation.',
    `credit_decision` STRING COMMENT 'Final credit decision outcome from the most recent review. Approved allows full credit; conditional requires additional controls; declined blocks business.. Valid values are `approved|conditional|declined|pending`',
    `credit_hold_date` DATE COMMENT 'Date when the credit hold was placed. Null if client is not on hold.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the client is currently on credit hold. True blocks new placements, timesheet approvals, and invoice generation until resolved.',
    `credit_hold_reason` STRING COMMENT 'Reason code explaining why the client is on credit hold. None if credit_hold_flag is false. [ENUM-REF-CANDIDATE: exceeded_limit|past_due_aging|bankruptcy|litigation|fraud_risk|manual_review|none — 7 candidates stripped; promote to reference product]',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance approved for this client. Exceeding this limit triggers credit hold and approval escalation.',
    `credit_score_internal` STRING COMMENT 'Internally calculated composite credit score combining D&B data, payment history, DSO trends, and account behavior. Scale 0-1000.',
    `credit_score_paydex` STRING COMMENT 'D&B PAYDEX score ranging from 1-100, measuring payment performance. Scores 80+ indicate prompt payment; scores below 50 indicate slow payment or default risk.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for credit limit and financial amounts (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `decision_date` DATE COMMENT 'Date when the credit decision was finalized and approved by the credit authority.',
    `dnb_credit_rating` STRING COMMENT 'D&B composite credit rating code (e.g., 5A1, 4A2) indicating financial strength and risk classification. Higher ratings indicate stronger credit.',
    `dnb_report_date` DATE COMMENT 'Date when the most recent D&B credit report was pulled for this client. Used to determine report freshness and review cadence.',
    `dso_actual_days` DECIMAL(18,2) COMMENT 'Actual Days Sales Outstanding for this client, calculated as average number of days to collect payment. Lower is better; values exceeding payment terms indicate collection risk.',
    `duns_number` STRING COMMENT 'Nine-digit Data Universal Numbering System identifier assigned by Dun & Bradstreet. Used to retrieve D&B credit reports and PAYDEX scores.. Valid values are `^[0-9]{9}$`',
    `effective_date` DATE COMMENT 'Date when this credit profile became effective and active for credit decisions. Typically the date of initial credit approval.',
    `expiration_date` DATE COMMENT 'Date when this credit profile expires and requires renewal or re-review. Null for profiles without expiration.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the credit insurance policy. Requires renewal before this date to maintain coverage.',
    `insurance_policy_number` STRING COMMENT 'Policy number for credit insurance or surety bond covering this client, if applicable. Null if insurance not required or not on file.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether credit insurance or bonding is required for this client due to elevated risk. True requires proof of coverage before extending credit.',
    `last_credit_review_date` DATE COMMENT 'Date of the most recent credit review conducted by the credit committee or credit analyst.',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether the client is currently involved in litigation with the company or has unresolved legal disputes affecting creditworthiness.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was last modified. Audit trail for tracking changes to credit terms, limits, or status.',
    `next_review_date` DATE COMMENT 'Date when the next periodic credit review is scheduled. Typically annual for low-risk clients, quarterly for high-risk.',
    `notes` STRING COMMENT 'Free-text notes capturing credit review findings, special conditions, payment arrangements, or other relevant credit management information.',
    `payment_terms_days` STRING COMMENT 'Approved payment terms expressed as net days (e.g., 30 for Net 30, 45 for Net 45). Invoices are due this many days after invoice date.',
    `profile_number` STRING COMMENT 'Business identifier for the credit profile, used for external reference and reporting.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the credit profile. Active profiles are used for credit decisions; suspended profiles block new business.. Valid values are `active|inactive|suspended|under_review|expired`',
    `risk_tier` STRING COMMENT 'Overall credit risk classification. Low = minimal risk, prompt payer; Medium = acceptable risk with monitoring; High = elevated risk requiring controls; Watch = critical risk, potential default.. Valid values are `low|medium|high|watch`',
    `total_outstanding_balance` DECIMAL(18,2) COMMENT 'Sum of all aging buckets; total amount currently owed by the client. Compared against credit_limit to determine available credit.',
    `trade_references` STRING COMMENT 'Summary of trade references provided by the client, including vendor names and payment history feedback. Used for credit assessment.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Client credit and financial risk assessment record used to evaluate and monitor a clients creditworthiness and ability to pay invoices on agreed terms. Captures credit score (D&B PAYDEX, internal composite score), credit limit, approved payment terms (net days), credit hold flag, credit hold reason, last credit review date, next scheduled review date, DSO (Days Sales Outstanding) actual, aging bucket summary (current, 30, 60, 90+ days), bank reference, trade references, credit decision (approved, conditional, declined), decision date, approving authority, and risk tier (low, medium, high, watch). Sourced from D&B Direct, internal AR aging reports, and credit committee decisions. Critical for staffing firms managing significant accounts receivable exposure — supports go/no-go decisions on new business, headcount expansion approvals, and credit hold enforcement during invoice generation.';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` (
    `managed_program_id` BIGINT COMMENT 'Unique identifier for the managed workforce program record. Primary key.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that owns this managed program.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.client_contact. Business justification: A managed program (RPO, MSP, or hybrid) has a designated primary client-side contact who serves as the program sponsor or relationship owner. Linking managed_program to client_contact via client_conta',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Managed programs governed by MSAs that define program scope, SLA terms, and fee structures. Essential for program governance, rate card inheritance, and SLA enforcement. Replaces denormalized msa_refe',
    `parent_managed_program_id` BIGINT COMMENT 'Self-referencing FK on managed_program (parent_managed_program_id)',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Managed programs often have specific SOWs defining deliverables, headcount commitments, and payment terms. Required for scope management, deliverable tracking, and billing reconciliation. Replaces den',
    `active_placement_count` STRING COMMENT 'Current number of active worker placements under this managed program.',
    `active_req_count` STRING COMMENT 'Current number of active job requisitions under this managed program.',
    `annual_spend_estimate` DECIMAL(18,2) COMMENT 'Estimated annual staffing spend for this managed program in the program currency.',
    `bgc_required` BOOLEAN COMMENT 'Indicates whether background checks are mandatory for all placements under this managed program.',
    `conversion_fee_pct` DECIMAL(18,2) COMMENT 'Fee percentage charged when a temporary worker is converted to permanent employment under this managed program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this managed program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial transactions under this managed program.. Valid values are `^[A-Z]{3}$`',
    `data_privacy_addendum_on_file` BOOLEAN COMMENT 'Indicates whether a data privacy addendum (GDPR, CCPA, or other) is on file for this managed program.',
    `direct_hire_fee_pct` DECIMAL(18,2) COMMENT 'Fee percentage of first-year salary charged for direct placement services under this managed program.',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether drug screening is mandatory for all placements under this managed program.',
    `effective_date` DATE COMMENT 'Date when the managed program becomes active and binding.',
    `eor_required` BOOLEAN COMMENT 'Indicates whether an Employer of Record arrangement is required for workers under this managed program.',
    `everify_required` BOOLEAN COMMENT 'Indicates whether E-Verify employment eligibility verification is mandatory for all placements under this managed program.',
    `expiration_date` DATE COMMENT 'Date when the managed program contract ends. Nullable for open-ended programs.',
    `governance_model` STRING COMMENT 'Defines the decision-making and oversight structure for the managed program.. Valid values are `Client-Led|Vendor-Led|Co-Managed|Neutral`',
    `ic_allowed` BOOLEAN COMMENT 'Indicates whether independent contractors (1099 workers) are permitted under this managed program.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review or QBR for this managed program.',
    `markup_cap_pct` DECIMAL(18,2) COMMENT 'Maximum allowable markup percentage (bill rate minus pay rate divided by pay rate) for suppliers participating in this managed program.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this managed program record was last modified.',
    `msp_fee_pct` DECIMAL(18,2) COMMENT 'Management fee percentage charged by the MSP for program administration and oversight.',
    `nda_on_file` BOOLEAN COMMENT 'Indicates whether a signed Non-Disclosure Agreement is on file for this managed program.',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next formal performance review or QBR for this managed program.',
    `notes` STRING COMMENT 'Free-text notes and additional context about the managed program.',
    `on_site_coordinator_required` BOOLEAN COMMENT 'Indicates whether the managed program requires a dedicated on-site coordinator at the client location.',
    `performance_review_frequency` STRING COMMENT 'Frequency of formal performance reviews and Quarterly Business Reviews (QBR) for this managed program.. Valid values are `Monthly|Quarterly|Semi-Annual|Annual`',
    `program_name` STRING COMMENT 'Human-readable name of the managed workforce program.',
    `program_number` STRING COMMENT 'Externally-known unique business identifier for the managed program, used in client communications and contracts.',
    `program_scope` STRING COMMENT 'Detailed description of the services, job categories, and geographic coverage included in the managed program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the managed program.. Valid values are `Active|Suspended|Terminated|Pending|Transition`',
    `program_type` STRING COMMENT 'Classification of the managed program model. RPO (Recruitment Process Outsourcing), MSP (Managed Service Provider), Hybrid (combination), VMS (Vendor Management System), or On-Site (dedicated on-site team).. Valid values are `RPO|MSP|Hybrid|VMS|On-Site`',
    `requisition_routing_rule` STRING COMMENT 'Method by which requisitions are distributed to suppliers in the managed program. Waterfall (sequential by tier), Broadcast (all suppliers simultaneously), Hybrid (combination), or Manual (case-by-case).. Valid values are `Waterfall|Broadcast|Hybrid|Manual`',
    `sla_tier` STRING COMMENT 'Service level tier defining performance targets and response commitments for the managed program.. Valid values are `Platinum|Gold|Silver|Bronze|Standard`',
    `supplier_tier_count` STRING COMMENT 'Number of supplier tiers configured in the managed program for requisition routing and vendor management.',
    `target_fill_rate` DECIMAL(18,2) COMMENT 'Target percentage of requisitions successfully filled under this managed program, as defined in the SLA.',
    `target_qos_rate` DECIMAL(18,2) COMMENT 'Target percentage of submitted candidates that meet client quality standards, as defined in the SLA.',
    `target_ttf_days` STRING COMMENT 'Target number of days to fill a requisition under this managed program, as defined in the SLA.',
    `target_tts_days` STRING COMMENT 'Target number of days from offer acceptance to candidate start date under this managed program, as defined in the SLA.',
    `termination_reason` STRING COMMENT 'Reason for termination or suspension of the managed program, if applicable.',
    CONSTRAINT pk_managed_program PRIMARY KEY(`managed_program_id`)
) COMMENT 'Master record for a managed workforce program — RPO, MSP, or hybrid — operated on behalf of a client, capturing program scope, governance model, and SLA framework';

CREATE OR REPLACE TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` (
    `rate_card_line_id` BIGINT COMMENT 'Unique surrogate identifier for this rate card line item record',
    `client_rate_card_id` BIGINT COMMENT 'Foreign key linking to the client rate card under which this pricing line is defined',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to the job category for which this rate card line establishes pricing',
    `bill_rate_dt` DECIMAL(18,2) COMMENT 'Negotiated hourly bill rate charged to the client for double-time hours for this job category under this rate card',
    `bill_rate_ot` DECIMAL(18,2) COMMENT 'Negotiated hourly bill rate charged to the client for overtime hours for this job category under this rate card',
    `bill_rate_regular` DECIMAL(18,2) COMMENT 'Negotiated hourly bill rate charged to the client for straight-time hours for this job category under this rate card',
    `burden_rate_included` BOOLEAN COMMENT 'Indicates whether employer burden costs are included in the bill rate for this job category under this rate card',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'Employer burden rate as a percentage of pay rate for this job category under this rate card',
    `conversion_fee_percentage` DECIMAL(18,2) COMMENT 'Negotiated fee percentage charged when a temporary worker in this job category converts to permanent under this rate card',
    `direct_placement_fee_percentage` DECIMAL(18,2) COMMENT 'Negotiated fee percentage charged for direct hire placement in this job category under this rate card',
    `effective_date` DATE COMMENT 'Date on which this rate card line becomes active and may be applied to job orders and submittals for this job category',
    `engagement_type` STRING COMMENT 'Classification of the staffing engagement model for which this rate applies. Distinguishes between contract/temporary, temp-to-perm (Contract-to-Hire), direct placement, Statement of Work (SOW), and per diem arrangements. [Moved from rate_card: Engagement type (contract, temp-to-perm, direct hire) varies by job category line within a rate card. A single rate card can have different engagement types for different job categories, so this belongs in the association.]. Valid values are `contract|temp_to_perm|direct_placement|sow|per_diem`',
    `expiration_date` DATE COMMENT 'Date on which this rate card line ceases to be valid for new transactions for this job category',
    `job_title` STRING COMMENT 'Specific job title or position designation for which this rate card line applies (e.g., Software Engineer, Data Analyst, Forklift Operator). Drives rate lookup during job order creation and candidate submittal pricing. [Moved from rate_card: Job title is specific to the job category being priced, not to the rate card as a whole. This belongs in the association or should be derived from the job_category reference.]',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Negotiated markup percentage applied over the pay rate to derive the bill rate for this job category under this rate card',
    `max_bill_rate` DECIMAL(18,2) COMMENT 'Ceiling bill rate above which the staffing firm may not price a submittal for this job category under this rate card',
    `min_bill_rate` DECIMAL(18,2) COMMENT 'Floor bill rate below which the staffing firm may not price a submittal for this job category under this rate card',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours per week (or per day, per overtime_threshold_period) after which overtime bill rates apply. Defaults to 40 hours per week per FLSA; may differ for daily OT jurisdictions (e.g., California 8-hour daily OT rule). [Moved from rate_card: Overtime threshold may vary by job category within a rate card (e.g., exempt vs. non-exempt roles) and belongs in the association.]',
    `overtime_threshold_period` STRING COMMENT 'Period over which the overtime threshold hours are measured. daily applies in jurisdictions with daily OT rules (e.g., California); weekly applies under standard FLSA rules. [Moved from rate_card: Overtime threshold period may vary by job category within a rate card and belongs in the association.]. Valid values are `daily|weekly`',
    `pay_rate_guidance` DECIMAL(18,2) COMMENT 'Recommended or maximum hourly pay rate for workers in this job category under this rate card, guiding recruiter compensation negotiations',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily allowance rate for travel, lodging, and meals applicable to workers in this job category under this rate card',
    `skill_level` STRING COMMENT 'Experience or seniority tier associated with the job title on this rate card line. Differentiates rate tiers within the same job title (e.g., Junior vs. Senior Software Engineer). [Moved from rate_card: Skill level is specific to the job category line item within the rate card, not to the rate card header. This attribute describes the pricing tier for a specific job category and belongs in the association.]. Valid values are `entry|junior|mid|senior|lead|principal`',
    `spread_amount` DECIMAL(18,2) COMMENT 'Calculated difference between the regular bill rate and the pay rate guidance for this job category under this rate card',
    `worker_classification` STRING COMMENT 'Tax and employment classification of the worker under this rate card line. Determines payroll tax treatment, burden rate applicability, and compliance obligations. W-2 (employee), 1099 (independent contractor), Corp-to-Corp, or Employer of Record (EOR). [Moved from rate_card: Worker classification (W2, 1099, etc.) is specific to the job category line item, not the rate card header. Different job categories within the same rate card may have different worker classifications.]. Valid values are `w2|1099|corp_to_corp|eor`',
    CONSTRAINT pk_rate_card_line PRIMARY KEY(`rate_card_line_id`)
) COMMENT 'This association product represents the pricing line items within a client rate card, linking negotiated rates to specific job categories. Each record captures the bill rates, pay guidance, markup, and effective dates that apply when a specific job category is priced under a specific client rate card. This is the operational pricing matrix used daily in job order creation, candidate submittal pricing, and invoice generation.. Existence Justification: In staffing operations, a single rate card negotiated with a client contains pricing for multiple job categories (e.g., Software Engineer, Project Manager, Business Analyst), and each job category appears across multiple client rate cards with different negotiated rates. The rate card is a pricing matrix, not a single-category document. Recruiters and account managers actively manage these rate card lines when creating job orders, pricing candidate submittals, and generating invoices.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ADD CONSTRAINT `fk_client_client_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_primary_client_account_id` FOREIGN KEY (`primary_client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ADD CONSTRAINT `fk_client_account_hierarchy_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ADD CONSTRAINT `fk_client_location_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ADD CONSTRAINT `fk_client_client_rate_card_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ADD CONSTRAINT `fk_client_vms_program_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_location_id` FOREIGN KEY (`location_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`location`(`location_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ADD CONSTRAINT `fk_client_engagement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ADD CONSTRAINT `fk_client_account_segment_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ADD CONSTRAINT `fk_client_account_segment_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ADD CONSTRAINT `fk_client_account_segment_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ADD CONSTRAINT `fk_client_program_supplier_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_managed_program_id` FOREIGN KEY (`managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ADD CONSTRAINT `fk_client_sla_measurement_vms_program_id` FOREIGN KEY (`vms_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`vms_program`(`vms_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ADD CONSTRAINT `fk_client_credit_profile_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ADD CONSTRAINT `fk_client_credit_profile_prior_credit_profile_id` FOREIGN KEY (`prior_credit_profile_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`credit_profile`(`credit_profile_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_client_account_id` FOREIGN KEY (`client_account_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_account`(`client_account_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_client_contact_id` FOREIGN KEY (`client_contact_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_contact`(`client_contact_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ADD CONSTRAINT `fk_client_managed_program_parent_managed_program_id` FOREIGN KEY (`parent_managed_program_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`managed_program`(`managed_program_id`);
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ADD CONSTRAINT `fk_client_rate_card_line_client_rate_card_id` FOREIGN KEY (`client_rate_card_id`) REFERENCES `staffing_hr_ecm_v1`.`client`.`client_rate_card`(`client_rate_card_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm_v1`.`client` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `staffing_hr_ecm_v1`.`client` SET TAGS ('dbx_domain' = 'client');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Client Account Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'prospect|active|inactive|on_hold|terminated');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `bullhorn_client_code` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Client ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `client_type` SET TAGS ('dbx_business_glossary_term' = 'Client Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `client_type` SET TAGS ('dbx_value_regex' = 'direct|vms_msp|rpo|eor|peo|sow');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `company_size_tier` SET TAGS ('dbx_business_glossary_term' = 'Company Size Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `company_size_tier` SET TAGS ('dbx_value_regex' = 'small|mid_market|enterprise|global_enterprise');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Client Credit Limit');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `employee_headcount` SET TAGS ('dbx_business_glossary_term' = 'Employee Headcount (Full-Time Equivalent)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `fein` SET TAGS ('dbx_business_glossary_term' = 'Federal Employer Identification Number (FEIN)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `fein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `fein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `fein` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|portal|mail|edi|fax');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Frequency');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|on_demand');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `invoice_grouping_rule` SET TAGS ('dbx_business_glossary_term' = 'Invoice Grouping Rule');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `invoice_grouping_rule` SET TAGS ('dbx_value_regex' = 'consolidated|by_location|by_department|by_cost_center|by_po');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Client Legal Entity Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `main_phone` SET TAGS ('dbx_business_glossary_term' = 'Client Main Phone Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `main_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `main_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `main_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `msa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `msa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `msp_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `nda_on_file` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) On File Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `on_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Account On-Hold Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|check|wire|credit_card|portal');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `po_required` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Address Line 1');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Address Line 2');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_city` SET TAGS ('dbx_business_glossary_term' = 'Primary Business City');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_country` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Country');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Postal Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_state` SET TAGS ('dbx_business_glossary_term' = 'Primary Business State');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `primary_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `sic_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `sic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise|custom');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `vms_platform` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Platform');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Client Website URL');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_account` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Address Line 1');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Address Line 2');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `bullhorn_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Contact ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `business_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Business Email Address');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `business_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `business_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `business_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Contact Office City');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|do_not_contact|archived');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'hiring_manager|procurement|accounts_payable|executive_sponsor|vms_coordinator');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Country Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Direct Phone Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `direct_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `do_not_call` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Email Marketing Opt-In Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship End Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last CRM Activity Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `last_activity_type` SET TAGS ('dbx_business_glossary_term' = 'Last CRM Activity Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `last_activity_type` SET TAGS ('dbx_value_regex' = 'call|email|meeting|note|linkedin_message|text_sms');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `name_prefix` SET TAGS ('dbx_business_glossary_term' = 'Contact Name Prefix');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `name_prefix` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `name_suffix` SET TAGS ('dbx_business_glossary_term' = 'Contact Name Suffix');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `office_phone_ext` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Phone Extension');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `office_phone_ext` SET TAGS ('dbx_value_regex' = '^d{1,6}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `office_phone_ext` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `office_phone_ext` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Office Postal Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|linkedin|text_sms');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Contact ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Contact Record Source');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'bullhorn|salesforce|vms_import|manual|linkedin|referral');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Relationship Start Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Contact Office State or Province');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `vms_user_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) User ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `vms_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_contact` ALTER COLUMN `vms_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `account_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Child Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `primary_client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Approval Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|draft');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `billing_consolidation_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Consolidation Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy End Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Description');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_name` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Path');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'organizational|geographic|billing|vms_program|reporting');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `is_primary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Primary Relationship Indicator');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `max_depth` SET TAGS ('dbx_business_glossary_term' = 'Maximum Hierarchy Depth');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `nps_rollup_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Roll-Up Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Staffing Program Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'direct|msp|vms|rpo|hybrid');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `rate_card_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Inheritance Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Account Relationship Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'corporate_parent|division|subsidiary|franchise|affiliate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `rollup_headcount_flag` SET TAGS ('dbx_business_glossary_term' = 'Headcount Roll-Up Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `rollup_spend_flag` SET TAGS ('dbx_business_glossary_term' = 'Spend Roll-Up Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `sla_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Inheritance Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|salesforce|beeline|netsuite|manual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `source_system_hierarchy_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Hierarchy ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_hierarchy` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Termination Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `badge_instructions` SET TAGS ('dbx_business_glossary_term' = 'Badge / Access Instructions');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `bullhorn_location_code` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Location ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `current_headcount` SET TAGS ('dbx_business_glossary_term' = 'Current Headcount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `dress_code` SET TAGS ('dbx_business_glossary_term' = 'Dress Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `everify_required` SET TAGS ('dbx_business_glossary_term' = 'E-Verify Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `is_drug_free_workplace` SET TAGS ('dbx_business_glossary_term' = 'Is Drug-Free Workplace Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Is Remote Location Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `is_union_site` SET TAGS ('dbx_business_glossary_term' = 'Is Union Site Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'headquarters|branch|warehouse|plant|remote|on_site');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `max_headcount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Headcount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `naics_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Establishment ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `parking_instructions` SET TAGS ('dbx_business_glossary_term' = 'Parking Instructions');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email Address');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Class Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `workers_comp_class_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `workers_comp_state` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Jurisdiction State');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`location` ALTER COLUMN `workers_comp_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` SET TAGS ('dbx_subdomain' = 'program_pricing');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Approved By Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Approval Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|expired|superseded');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Approved Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `beeline_rate_card_code` SET TAGS ('dbx_business_glossary_term' = 'Beeline VMS Rate Card ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `bill_rate_dt` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Double Time (DT)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `bill_rate_dt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `bill_rate_ot` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Overtime (OT)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `bill_rate_ot` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `bill_rate_regular` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Regular');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `bill_rate_regular` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `burden_rate_included` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Included Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `conversion_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `conversion_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `direct_placement_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Direct Placement Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `direct_placement_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `holiday_bill_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Holiday Bill Rate Multiplier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `holiday_bill_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `max_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `max_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `min_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `min_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `pay_rate_guidance` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Guidance');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `pay_rate_guidance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `rate_card_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_value_regex' = '^RC-[A-Z0-9]{4,20}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `rate_card_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `salesforce_pricebook_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Revenue Cloud Price Book ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount (Bill Rate Minus Pay Rate)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `spread_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`client_rate_card` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Version Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` SET TAGS ('dbx_subdomain' = 'program_pricing');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `beeline_program_code` SET TAGS ('dbx_business_glossary_term' = 'Beeline Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `bgc_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `bill_rate_cap_currency` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Cap Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `bill_rate_cap_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Temp-to-Perm Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `data_privacy_addendum_on_file` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Addendum On File Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `eor_required` SET TAGS ('dbx_business_glossary_term' = 'Employer of Record (EOR) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `everify_required` SET TAGS ('dbx_business_glossary_term' = 'E-Verify Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `ic_allowed` SET TAGS ('dbx_business_glossary_term' = 'Independent Contractor (IC) Allowed Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Frequency');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `invoice_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `markup_cap_pct` SET TAGS ('dbx_business_glossary_term' = 'Markup Cap Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `markup_cap_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `msp_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Partner Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `nda_on_file` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) On File Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `on_site_coordinator_required` SET TAGS ('dbx_business_glossary_term' = 'On-Site Coordinator Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `ot_markup_cap_pct` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Markup Cap Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `ot_markup_cap_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `per_diem_allowed` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Allowed Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `po_required` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `primary_labor_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Labor Category');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'VMS Program End Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'VMS Program Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'VMS Program Scope');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_start_date` SET TAGS ('dbx_business_glossary_term' = 'VMS Program Start Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'VMS Program Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|draft');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'VMS Program Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'MSP-managed|self-managed|hybrid|RPO-managed');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `requisition_routing_rule` SET TAGS ('dbx_business_glossary_term' = 'Requisition Routing Rule');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `submission_limit_per_req` SET TAGS ('dbx_business_glossary_term' = 'Candidate Submission Limit Per Requisition');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `supplier_portal_url` SET TAGS ('dbx_business_glossary_term' = 'VMS Supplier Portal URL');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `supplier_portal_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|approved|backup');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `time_to_submit_hours` SET TAGS ('dbx_business_glossary_term' = 'Time to Submit (TTS) Hours');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `timesheet_approval_cycle` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Approval Cycle');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `timesheet_approval_cycle` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `vms_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `vms_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `vms_platform` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Platform');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `vms_platform` SET TAGS ('dbx_value_regex' = 'Beeline|Fieldglass|Coupa|IQNavigator|Workday|Ariba');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`vms_program` ALTER COLUMN `workers_comp_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Engagement ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Related Job Order ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `sourcing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'CRM Campaign ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `assigned_staff_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `assigned_staff_role` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Role');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `assigned_staff_role` SET TAGS ('dbx_value_regex' = 'recruiter|account_manager|business_development|branch_manager|vp_sales|other');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `bullhorn_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Bullhorn Activity ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Engagement Direction');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration (Minutes)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'planned|completed|cancelled|no_show|rescheduled');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `engagement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Engagement Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Indicator');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `is_executive_sponsor_present` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Present Indicator');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `is_qbr` SET TAGS ('dbx_business_glossary_term' = 'Quarterly Business Review (QBR) Indicator');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next Action');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `nps_verbatim` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Verbatim Feedback');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `nps_verbatim` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Engagement Outcome');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|pending|escalated');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Engagement Purpose');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `salesforce_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Activity ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Engagement Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|salesforce|manual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Engagement Subject');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `account_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Account Segment ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `active_placement_count` SET TAGS ('dbx_business_glossary_term' = 'Active Placement Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `active_req_count` SET TAGS ('dbx_business_glossary_term' = 'Active Requisition (Req) Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Band');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_value_regex' = 'under_1m|1m_to_10m|10m_to_50m|50m_to_250m|over_250m');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `annual_revenue_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `direct_hire_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `direct_hire_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `estimated_annual_staffing_spend` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Staffing Spend');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `estimated_annual_staffing_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `fall_off_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Rate Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `gross_margin_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Target Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `gross_margin_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `headcount_band` SET TAGS ('dbx_business_glossary_term' = 'Headcount Band');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `headcount_band` SET TAGS ('dbx_value_regex' = '1_to_50|51_to_250|251_to_1000|1001_to_5000|over_5000');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `markup_pct` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `markup_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `msp_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Program Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `nps_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Survey Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `on_site_program_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Site Program Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `preferred_supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `preferred_supplier_status` SET TAGS ('dbx_value_regex' = 'preferred|approved|tier_1|tier_2|not_listed');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `primary_service_line` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Line');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `primary_service_line` SET TAGS ('dbx_value_regex' = 'temp_staffing|direct_hire|rpo|msp|contract_to_hire|sow');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `prior_segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Prior Segment Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `prior_segment_tier` SET TAGS ('dbx_value_regex' = 'strategic|key|growth|transactional');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `reclassification_reason` SET TAGS ('dbx_business_glossary_term' = 'Reclassification Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `rpo_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Process Outsourcing (RPO) Program Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_notes` SET TAGS ('dbx_business_glossary_term' = 'Segment Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_review_date` SET TAGS ('dbx_business_glossary_term' = 'Segment Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|under_review|inactive|archived');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_value_regex' = 'strategic|key|growth|transactional');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|standard');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `target_ttf_days` SET TAGS ('dbx_business_glossary_term' = 'Target Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `target_tts_days` SET TAGS ('dbx_business_glossary_term' = 'Target Time to Start (TTS) Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `vertical_industry` SET TAGS ('dbx_business_glossary_term' = 'Vertical Industry Focus');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `vms_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `wallet_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Wallet Share Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`account_segment` ALTER COLUMN `wallet_share_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` SET TAGS ('dbx_subdomain' = 'program_pricing');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Program Supplier ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `credential_package_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Package Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `nda_id` SET TAGS ('dbx_business_glossary_term' = 'Nda Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `active_assignment_count` SET TAGS ('dbx_business_glossary_term' = 'Active Assignment Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `authorized_job_categories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Job Categories');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `avg_time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Average Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `beeline_supplier_program_code` SET TAGS ('dbx_business_glossary_term' = 'Beeline Vendor Management System (VMS) Supplier Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Program Compliance Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|conditionally_compliant');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `diversity_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `diversity_certified` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certified Supplier Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment End Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `fall_off_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Rate Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `insurance_verified` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verified Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `markup_cap_percent` SET TAGS ('dbx_business_glossary_term' = 'Markup Cap Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `markup_cap_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `max_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `max_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `onboarding_complete` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Complete Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Score');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `preferred_worker_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Worker Classification Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `preferred_worker_type` SET TAGS ('dbx_value_regex' = 'W2|1099|corp_to_corp|EOR|all');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Program Contact Email');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Program Contact Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `program_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `requisition_routing_order` SET TAGS ('dbx_business_glossary_term' = 'Requisition Routing Order');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `response_time_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time Service Level Agreement (SLA) Hours');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `submission_limit_per_req` SET TAGS ('dbx_business_glossary_term' = 'Submission Limit Per Requisition (Req)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Program Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|suspended|removed|pending_approval|inactive');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|backup|probationary|suspended');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Suspension Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Supplier Suspension Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `total_submittals_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Submittals Year-to-Date (YTD)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`program_supplier` ALTER COLUMN `vms_supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Supplier Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` SET TAGS ('dbx_subdomain' = 'program_pricing');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `sla_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Measurement ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Configuration ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `account_health_score` SET TAGS ('dbx_business_glossary_term' = 'Account Health Score');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `account_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `account_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'SLA Bonus Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `bonus_triggered` SET TAGS ('dbx_business_glossary_term' = 'SLA Bonus Triggered Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `compliance_direction` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Direction');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `compliance_direction` SET TAGS ('dbx_value_regex' = 'higher_is_better|lower_is_better');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'SLA Dispute Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `dispute_resolved_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Dispute Resolved Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `excluded_req_count` SET TAGS ('dbx_business_glossary_term' = 'Excluded Requisition (Req) Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'SLA Exclusion Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `fall_off_count` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `fill_count` SET TAGS ('dbx_business_glossary_term' = 'Fill Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `fill_rate_actual` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Actual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `finalized_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Finalized Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_number` SET TAGS ('dbx_business_glossary_term' = 'SLA Measurement Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_number` SET TAGS ('dbx_value_regex' = '^SLA-MEAS-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|beeline_vms|kronos|tempworks|power_bi|manual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Measurement Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|finalized|disputed|voided');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'SLA Penalty Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `penalty_triggered` SET TAGS ('dbx_business_glossary_term' = 'SLA Penalty Triggered Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|monthly|quarterly|annual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `qbr_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarterly Business Review (QBR) Period Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `qos_actual_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality of Submission (QoS) Actual Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `req_count` SET TAGS ('dbx_business_glossary_term' = 'Requisition (Req) Count in Scope');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `retention_rate_actual` SET TAGS ('dbx_business_glossary_term' = 'Assignment Retention Rate Actual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `sla_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Metric Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `sla_metric_type` SET TAGS ('dbx_value_regex' = 'ttf|tts|fill_rate|qos|submittal_ratio|retention_rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `submittal_count` SET TAGS ('dbx_business_glossary_term' = 'Submittal Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Value');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `ttf_actual_avg_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (TTF) Actual Average Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `tts_actual_avg_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Start (TTS) Actual Average Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'SLA Variance Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`sla_measurement` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'SLA Variance Value');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `prior_credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Credit Profile Id');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `prior_credit_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `aging_30_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 30 Days Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `aging_60_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 60 Days Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `aging_90_plus_days_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 90+ Days Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `aging_current_amount` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket Current Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Credit Approving Authority Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `bank_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Information');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `bank_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `bankruptcy_date` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Filing Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_decision` SET TAGS ('dbx_business_glossary_term' = 'Credit Decision Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_decision` SET TAGS ('dbx_value_regex' = 'approved|conditional|declined|pending');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_score_internal` SET TAGS ('dbx_business_glossary_term' = 'Internal Composite Credit Score');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `credit_score_paydex` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (D&B) PAYDEX Score');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Decision Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `dnb_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (D&B) Credit Rating');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `dnb_report_date` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (D&B) Report Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `dso_actual_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Actual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet (D&B) DUNS Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Policy Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `last_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Credit Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Net Days)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `profile_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|expired');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|watch');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `total_outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Total Outstanding Accounts Receivable (AR) Balance');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `trade_references` SET TAGS ('dbx_business_glossary_term' = 'Trade References Information');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`credit_profile` ALTER COLUMN `trade_references` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` SET TAGS ('dbx_subdomain' = 'program_pricing');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `parent_managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Managed Program Id');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `parent_managed_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `active_placement_count` SET TAGS ('dbx_business_glossary_term' = 'Active Placement Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `active_req_count` SET TAGS ('dbx_business_glossary_term' = 'Active Requisition Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `annual_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Estimate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `annual_spend_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `bgc_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check (BGC) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `data_privacy_addendum_on_file` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Addendum On File Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `direct_hire_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `direct_hire_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `eor_required` SET TAGS ('dbx_business_glossary_term' = 'Employer of Record (EOR) Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `everify_required` SET TAGS ('dbx_business_glossary_term' = 'E-Verify Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `governance_model` SET TAGS ('dbx_business_glossary_term' = 'Governance Model');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `governance_model` SET TAGS ('dbx_value_regex' = 'Client-Led|Vendor-Led|Co-Managed|Neutral');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `ic_allowed` SET TAGS ('dbx_business_glossary_term' = 'Independent Contractor (IC) Allowed Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `markup_cap_pct` SET TAGS ('dbx_business_glossary_term' = 'Markup Cap Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `markup_cap_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `msp_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Provider (MSP) Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `msp_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `nda_on_file` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) On File Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `on_site_coordinator_required` SET TAGS ('dbx_business_glossary_term' = 'On-Site Coordinator Required Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_number` SET TAGS ('dbx_business_glossary_term' = 'Program Number');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Suspended|Terminated|Pending|Transition');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'RPO|MSP|Hybrid|VMS|On-Site');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `requisition_routing_rule` SET TAGS ('dbx_business_glossary_term' = 'Requisition Routing Rule');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `requisition_routing_rule` SET TAGS ('dbx_value_regex' = 'Waterfall|Broadcast|Hybrid|Manual');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'Platinum|Gold|Silver|Bronze|Standard');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `supplier_tier_count` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier Count');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `target_fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Rate Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `target_qos_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Quality of Submission (QoS) Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `target_ttf_days` SET TAGS ('dbx_business_glossary_term' = 'Target Time to Fill (TTF) Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `target_tts_days` SET TAGS ('dbx_business_glossary_term' = 'Target Time to Start (TTS) Days');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`managed_program` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Program Termination Reason');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` SET TAGS ('dbx_subdomain' = 'program_pricing');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `rate_card_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line Identifier');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line - Rate Card Id');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Line - Job Category Id');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `bill_rate_dt` SET TAGS ('dbx_business_glossary_term' = 'Double-Time Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `bill_rate_ot` SET TAGS ('dbx_business_glossary_term' = 'Overtime Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `bill_rate_regular` SET TAGS ('dbx_business_glossary_term' = 'Regular Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `burden_rate_included` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Included Flag');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `conversion_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `direct_placement_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Direct Placement Fee Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'contract|temp_to_perm|direct_placement|sow|per_diem');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `max_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `min_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bill Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Threshold Hours');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `overtime_threshold_period` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Threshold Period');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `overtime_threshold_period` SET TAGS ('dbx_value_regex' = 'daily|weekly');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `pay_rate_guidance` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Guidance');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'entry|junior|mid|senior|lead|principal');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `staffing_hr_ecm_v1`.`client`.`rate_card_line` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'w2|1099|corp_to_corp|eor');
