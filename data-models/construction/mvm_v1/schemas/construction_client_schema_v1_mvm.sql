-- Schema for Domain: client | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`client` COMMENT 'Master client/owner data managing relationships with project owners, developers, and sponsors who commission construction work. Owns client profiles, account hierarchies, JV structures, stakeholder contacts, communication preferences, and relationship history. Supports CRM (Customer Relationship Management), opportunity pipeline management, and client segmentation across public-sector, private-sector, and PPP/BOT arrangements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`client`.`account` (
    `account_id` BIGINT COMMENT 'Unique surrogate identifier for the client/owner account record in the Silver Layer lakehouse. Primary key for the account master entity.',
    `parent_account_id` BIGINT COMMENT 'Reference to the parent account record for clients that are subsidiaries or divisions within a larger corporate hierarchy. Enables account hierarchy traversal for consolidated reporting and group-level relationship management.',
    `primary_ultimate_parent_account_id` BIGINT COMMENT 'Reference to the top-level account in the corporate hierarchy (ultimate holding entity). Used for group-level exposure analysis, consolidated pipeline reporting, and enterprise relationship management.',
    `account_status` STRING COMMENT 'Current lifecycle status of the client account. Controls whether the account is eligible for new project bids, contract awards, and CRM pipeline activities.. Valid values are `active|inactive|prospect|suspended|blacklisted|archived`',
    `account_type` STRING COMMENT 'Classification of the client account by ownership and sector type. Drives contract template selection, compliance requirements, and reporting segmentation. [ENUM-REF-CANDIDATE: public_sector|private_sector|government_body|corporate_sponsor|jv_entity|ppp_authority — promote to reference product]. Valid values are `public_sector|private_sector|government_body|corporate_sponsor|jv_entity|ppp_authority`',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported or estimated annual revenue of the client organisation in the accounts billing currency. Used for client segmentation, credit assessment, and strategic account prioritisation.',
    `billing_address` STRING COMMENT 'Address to which invoices and financial correspondence are directed for this client account. May differ from the registered address. Used in SAP S/4HANA accounts receivable and Viewpoint Vista job costing.',
    `bim_requirement_level` STRING COMMENT 'Level of Building Information Modeling (BIM) mandated by the client for construction projects. Drives design collaboration tooling requirements (e.g., Autodesk BIM 360), data exchange standards, and project delivery methodology.. Valid values are `none|bim_level_1|bim_level_2|bim_level_3`',
    `client_tier` STRING COMMENT 'Strategic segmentation tier assigned to the client based on revenue potential, relationship depth, and strategic importance. Tier 1 represents the highest-value clients. Drives account management resource allocation and executive engagement levels.. Valid values are `tier_1|tier_2|tier_3|strategic`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country of incorporation or primary operations for the client organisation. Used for jurisdictional compliance, tax treatment, and geographic segmentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was first created in the source Salesforce CRM system. Represents the audit trail creation event for the master client record.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding receivable balance approved for this client account. Used by the finance team to manage exposure and payment risk on construction contracts. Expressed in the accounts billing currency.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the client organisation by a recognised credit rating agency (e.g., S&P, Moodys, Fitch) or internal credit assessment score. Used for financial risk evaluation, payment terms negotiation, and bonding/surety decisions.',
    `crm_account_code` STRING COMMENT 'Source system identifier for the account as recorded in Salesforce CRM. Used for cross-system reconciliation and lineage tracing back to the operational system of record.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary billing currency for this client account (e.g., USD, GBP, EUR, AED). Used for contract valuation, invoicing, and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `do_not_contact` BOOLEAN COMMENT 'Indicates whether outbound marketing and unsolicited commercial communications to this client account are restricted. Set to True when the client has opted out of communications or is subject to legal/regulatory restrictions. Supports GDPR compliance.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet Data Universal Numbering System identifier for the client organisation. Used for credit assessment, supplier/client qualification, and global entity resolution.. Valid values are `^[0-9]{9}$`',
    `employee_count` STRING COMMENT 'Approximate number of employees in the client organisation. Used as a proxy for organisational scale, procurement capacity, and client segmentation in CRM analytics.',
    `eot_policy` STRING COMMENT 'Clients standard policy for granting Extension of Time (EOT) on construction contracts. Indicates whether the client follows standard FIDIC provisions, applies strict timelines, or allows flexible negotiation. Used in bid risk evaluation.. Valid values are `standard|strict|flexible`',
    `hse_compliance_required` BOOLEAN COMMENT 'Indicates whether this client mandates specific Health, Safety and Environment (HSE) compliance standards (e.g., ISO 45001, OSHA requirements, client-specific HSE plans) as a condition of contract. Drives HSE planning and prequalification requirements.',
    `industry_sector` STRING COMMENT 'Primary industry sector of the client organisation (e.g., Infrastructure, Energy, Real Estate, Transportation, Healthcare, Government). Used for market segmentation and opportunity pipeline analytics in Salesforce CRM.',
    `is_jv_entity` BOOLEAN COMMENT 'Indicates whether this client account represents a Joint Venture (JV) entity formed specifically for a construction project or programme. JV entities require special contract administration, profit-sharing arrangements, and consolidated reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account record in the source Salesforce CRM system. Used for change data capture, incremental ETL processing, and audit trail maintenance.',
    `last_project_award_date` DATE COMMENT 'Date of the most recent contract or project award from this client. Used to identify dormant accounts, measure relationship recency, and prioritise re-engagement activities in the CRM pipeline.',
    `ld_clause_standard` STRING COMMENT 'Indicates whether this client typically enforces Liquidated Damages (LD) clauses in construction contracts, and whether the LD terms are standard or negotiable. Informs bid risk assessment and contract strategy.. Valid values are `yes|no|negotiable`',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether this client requires LEED (Leadership in Energy and Environmental Design) certification for construction projects. Drives design, procurement, and construction methodology decisions to meet green building standards.',
    `legal_name` STRING COMMENT 'Full registered legal name of the client/owner organisation as it appears on contracts, invoices, and regulatory filings. This is the authoritative identity label for the account.',
    `ntp_authority_level` STRING COMMENT 'Describes the clients internal authority level or approval threshold required to issue a Notice to Proceed (NTP) on construction contracts. Used in contract administration to understand client governance and approval workflows.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the client for construction contracts (e.g., Net 30, Net 60, milestone-based, progress payment). Drives accounts receivable management and cash flow forecasting in SAP S/4HANA.',
    `preferred_contract_type` STRING COMMENT 'Clients preferred contract delivery model for construction engagements. Options include Engineering Procurement and Construction (EPC), Guaranteed Maximum Price (GMP), Design-Bid-Build (DBB), Design-Build (DB), Public-Private Partnership (PPP), and Build-Operate-Transfer (BOT). Informs bid strategy and contract template selection. [ENUM-REF-CANDIDATE: EPC|GMP|DBB|DB|PPP|BOT|FIDIC — 7 candidates stripped; promote to reference product]',
    `prequalification_expiry_date` DATE COMMENT 'Date on which the clients prequalification approval expires and requires renewal. Used to trigger re-assessment workflows and ensure compliance before new contract awards.',
    `prequalification_status` STRING COMMENT 'Current prequalification status of the client as a commissioning entity. Indicates whether the client has been assessed and approved for contract award eligibility, is pending review, or has an expired/rejected qualification.. Valid values are `approved|pending|expired|rejected`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact at the client organisation. Used for RFI responses, RFP submissions, contract correspondence, and CRM communication tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary point of contact at the client organisation for commercial and contractual matters. Typically the clients project director, procurement manager, or authorised representative.',
    `primary_contact_phone` STRING COMMENT 'Direct telephone number for the primary contact at the client organisation. Used for urgent project communications, bid clarifications, and relationship management activities.',
    `registered_address` STRING COMMENT 'Full registered office address of the client organisation as recorded with the relevant business registry. Used for legal correspondence, contract execution, and regulatory filings.',
    `registration_number` STRING COMMENT 'Official company or entity registration number issued by the relevant national or state business registry authority. Used for legal entity verification and compliance due diligence.',
    `relationship_start_date` DATE COMMENT 'Date on which the business relationship with this client was formally established (e.g., first contract award, first NTP issued, or CRM account creation date). Used for relationship tenure analysis and loyalty segmentation.',
    `tax_number` STRING COMMENT 'Government-issued tax identification number (e.g., EIN, VAT number, GST number) for the client entity. Required for invoicing, contract administration, and financial reporting under IFRS/GAAP.',
    `trading_name` STRING COMMENT 'Operating or brand name used by the client organisation in day-to-day business, which may differ from the registered legal name. Used in CRM displays and correspondence.',
    `website_url` STRING COMMENT 'Official website address of the client organisation. Used for due diligence, background research, and CRM account enrichment.. Valid values are `^https?://[^s/$.?#].[^s]*$`',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master record for each client/owner organization that commissions construction work. SSOT for client identity across public-sector agencies, private developers, government bodies, and corporate sponsors. Captures legal entity name, registration number, tax ID, industry sector, client tier, credit rating, preferred contract type (EPC, GMP, DBB, PPP, BOT), account status, CRM account owner, and segment assignments. Sourced from Salesforce CRM Account object. All other client domain products reference this entity.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique surrogate identifier for the individual stakeholder contact record in the Databricks Silver Layer. Primary key for the contact data product.',
    `account_id` BIGINT COMMENT 'Reference to the parent client account (project owner, developer, or sponsor) to which this contact belongs. Sourced from Salesforce CRM Account object.',
    `address_id` BIGINT COMMENT 'Foreign key linking to client.address. Business justification: The contact table carries five denormalized mailing address fields (mailing_street, mailing_city, mailing_state, mailing_postal_code, mailing_country) that duplicate the address master table. The addr',
    `reports_to_contact_id` BIGINT COMMENT 'Self-referencing identifier pointing to the contacts direct manager or superior within the client organisation. Enables hierarchical stakeholder mapping and organisational chart modelling for large client accounts.',
    `account_manager` STRING COMMENT 'Full name of the internal account manager or business development representative responsible for managing the relationship with this contact. Used for ownership assignment and pipeline accountability in Salesforce CRM.',
    `birthdate` DATE COMMENT 'Date of birth of the contact. Stored for relationship personalisation purposes (e.g., milestone acknowledgements) and identity verification in regulated markets. Handled under strict GDPR data minimisation principles.',
    `client_segment` STRING COMMENT 'Segment classification of the client organisation associated with this contact. Supports client segmentation analytics across public-sector, private-sector, Public-Private Partnership (PPP), Build-Operate-Transfer (BOT), and Joint Venture (JV) arrangements.. Valid values are `public_sector|private_sector|ppp|bot|jv`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record within the CRM system. active indicates an engaged stakeholder; inactive indicates no recent engagement; archived indicates the contact has left the organisation; do_not_contact indicates a communication opt-out or legal restriction.. Valid values are `active|inactive|archived|do_not_contact`',
    `contact_type` STRING COMMENT 'Classification of the contacts functional role in the client relationship (e.g., owner representative, technical representative, procurement officer, legal counsel, executive sponsor, financial approver). Drives stakeholder engagement strategy and communication routing. [ENUM-REF-CANDIDATE: owner|technical|procurement|legal|executive|financial|hse|commercial — promote to reference product]. Valid values are `owner|technical|procurement|legal|executive|financial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created in the source Salesforce CRM system. Used for data lineage, audit trail, and CRM record age analytics in the Databricks Silver Layer.',
    `crm_contact_code` STRING COMMENT 'External identifier for this contact as recorded in Salesforce CRM Contact object. Used for cross-system reconciliation and data lineage tracing back to the operational system of record.',
    `data_consent_date` DATE COMMENT 'Date on which the contacts data processing consent was last recorded or updated. Required for GDPR compliance audit trails to demonstrate lawful basis for processing personal data.',
    `data_consent_status` STRING COMMENT 'Current status of the contacts consent for personal data processing under applicable privacy regulations (GDPR, CCPA). Tracks whether consent has been granted, withdrawn, is pending confirmation, or is not required (e.g., legitimate interest basis).. Valid values are `granted|withdrawn|pending|not_required`',
    `decision_authority_level` STRING COMMENT 'Indicates the contacts level of decision-making authority within the client organisation for construction project approvals, contract awards, and change order authorisations. Supports bid strategy and stakeholder influence mapping.. Valid values are `strategic|operational|advisory|none`',
    `department` STRING COMMENT 'Organisational department or business unit within the client organisation to which the contact belongs (e.g., Engineering, Procurement, Legal, Finance). Supports targeted stakeholder engagement and communication routing.',
    `do_not_contact` BOOLEAN COMMENT 'Indicates that this contact has opted out of all marketing and non-essential communications, or that a legal restriction prevents outreach. Enforces GDPR Article 21 right to object and CAN-SPAM compliance in Salesforce CRM campaign management.',
    `email` STRING COMMENT 'Primary business email address of the contact used for official project correspondence, RFI responses, bid submissions, and CRM communication tracking. Sourced from Salesforce CRM.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `email_opt_out` BOOLEAN COMMENT 'Indicates whether the contact has opted out of email marketing communications specifically. Distinct from do_not_contact which covers all channels. Enforces GDPR consent management and CAN-SPAM compliance.',
    `first_name` STRING COMMENT 'Given name of the individual stakeholder contact as recorded in Salesforce CRM. Used for personalised correspondence and formal communication in client relationship management.',
    `full_name` STRING COMMENT 'Complete display name of the contact (e.g., salutation + first + last name) as stored in Salesforce CRM. Used in formal correspondence, bid submissions, and contract administration documents.',
    `influence_score` STRING COMMENT 'Numeric score (typically 1–10) representing the contacts level of influence over project award decisions, contract negotiations, and change order approvals. Used in bid strategy and stakeholder mapping for major infrastructure pursuits.',
    `is_decision_maker` BOOLEAN COMMENT 'Indicates whether this contact has final decision-making authority for contract awards, change orders (CO), or project approvals. Critical for bid management and opportunity pipeline qualification in Salesforce CRM.',
    `is_executive_sponsor` BOOLEAN COMMENT 'Indicates whether this contact holds the role of executive sponsor for the client relationship. Executive sponsors are senior client representatives who champion the construction partnership at the strategic level.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the designated primary point of contact for the client account. Only one contact per account should be flagged as primary. Used to route official correspondence and contract notifications.',
    `job_title` STRING COMMENT 'Official job title or position of the contact within their organisation (e.g., Project Director, Procurement Manager, Chief Engineer). Used to identify the contacts functional role in client engagement and bid management.',
    `last_activity_date` DATE COMMENT 'Date of the most recent logged activity (call, email, meeting, site visit) with this contact in Salesforce CRM. Used to measure engagement recency and identify at-risk relationships in client retention analytics.',
    `last_meeting_date` DATE COMMENT 'Date of the most recent in-person or virtual meeting held with this contact. Used by account managers to track face-to-face engagement frequency and support relationship health assessments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record in the source Salesforce CRM system. Used for incremental data loading, change data capture (CDC), and audit trail maintenance in the Silver Layer.',
    `last_name` STRING COMMENT 'Family name or surname of the individual stakeholder contact. Combined with first_name to form the full display name used in client-facing communications and CRM reporting.',
    `linkedin_url` STRING COMMENT 'LinkedIn professional profile URL for the contact. Used by business development and account management teams for relationship intelligence, stakeholder research, and pre-bid engagement in Salesforce CRM.. Valid values are `^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$`',
    `mobile_phone` STRING COMMENT 'Mobile or cell phone number for the contact. Used for urgent site communications, HSE notifications, and out-of-hours contact during critical project milestones.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `notes` STRING COMMENT 'Free-text field for account managers to record qualitative observations, relationship context, stakeholder preferences, and strategic notes about the contact. Supports informed client engagement and bid strategy preparation.',
    `phone` STRING COMMENT 'Primary business phone number for the contact, including country and area code. Used for direct communication during project execution, bid clarifications, and contract administration.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for project correspondence, meeting invitations, and bid-related notifications. Sourced from Salesforce CRM and used to personalise outreach in opportunity pipeline management.. Valid values are `email|phone|video_call|in_person|portal`',
    `preferred_language` STRING COMMENT 'ISO 639-1 language code representing the contacts preferred language for written and verbal communication (e.g., en, fr, ar, zh). Supports multilingual project environments common in global EPC and infrastructure projects.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `relationship_health` STRING COMMENT 'Qualitative assessment of the current health of the business relationship with this contact, as evaluated by the account manager or business development team. Used in CRM pipeline forecasting and client retention strategies.. Valid values are `strong|good|neutral|at_risk|poor`',
    `salutation` STRING COMMENT 'Formal honorific or title prefix for the contact (e.g., Mr., Ms., Dr.) used in official correspondence, contract documents, and client communications.. Valid values are `Mr.|Ms.|Mrs.|Dr.|Prof.`',
    `source` STRING COMMENT 'Origin channel through which this contact was acquired or first identified (e.g., CRM import, referral, industry conference, Request for Proposal (RFP) response, website enquiry, partner introduction). Supports lead source analytics in Salesforce CRM.. Valid values are `crm|referral|conference|rfp|website|partner`',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual stakeholder contact associated with a client account, including project owners, technical representatives, procurement officers, legal counsel, and executive sponsors. Captures full name, job title, department, email, phone, preferred communication channel, decision-making authority level, and relationship health indicator. Sourced from Salesforce CRM Contact object.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`jv_structure` (
    `jv_structure_id` BIGINT COMMENT 'Unique surrogate identifier for the Joint Venture (JV) structure record in the Databricks Silver Layer. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the primary contract under which the JV is engaged. Links the JV structure to the contract administration domain for CO (Change Order), LD (Liquidated Damages), and EOT (Extension of Time) management.',
    `client_opportunity_id` BIGINT COMMENT 'Identifier of the associated opportunity record in Salesforce CRM. Links the JV structure to the bid management and pipeline forecasting process, enabling traceability from opportunity to JV formation.',
    `construction_project_id` BIGINT COMMENT 'Reference to the primary construction project associated with this JV structure. Links the JV arrangement to the project entity for scheduling, cost control, and EVM (Earned Value Management) reporting.',
    `tender_id` BIGINT COMMENT 'Foreign key linking to bid.tender. Business justification: JV structures in construction are formed specifically to pursue a named tender. Linking jv_structure to the tender it was established for enables JV governance reporting, bid compliance tracking, and ',
    `aconex_document_reference` STRING COMMENT 'Reference identifier for the JV agreement document as registered in the Aconex document management system. Enables direct traceability to the executed legal instrument and associated transmittals.',
    `client_segment` STRING COMMENT 'Segmentation of the JVs client or owner base. Distinguishes between public-sector (government-funded), private-sector, PPP (Public-Private Partnership), and BOT (Build-Operate-Transfer) arrangements for CRM analytics and opportunity pipeline management.. Valid values are `public_sector|private_sector|PPP|BOT|government`',
    `country_of_operation` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country where the JVs construction project is being executed. Used for regulatory compliance, HSE reporting, and geographic portfolio analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the JV structure record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail, data lineage, and compliance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary currency in which the JVs financial obligations, equity contributions, and profit/loss distributions are denominated.. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractually agreed mechanism for resolving disputes between JV partners. DAB refers to Dispute Adjudication Board as defined under FIDIC contracts. Drives legal strategy and contract administration.. Valid values are `arbitration|litigation|mediation|DAB|expert_determination`',
    `dissolution_date` DATE COMMENT 'Calendar date on which the JV was or is scheduled to be dissolved and wound up. Null if the JV is ongoing. Used for financial reporting, DLP (Defects Liability Period) tracking, and regulatory compliance.',
    `dlp_end_date` DATE COMMENT 'Date on which the DLP (Defects Liability Period) for the JVs project obligations expires. After this date, the JVs liability for defects under the contract ceases. Critical for contract closeout and financial provisioning.',
    `formation_date` DATE COMMENT 'Calendar date on which the JV was formally constituted and the JV agreement became effective. Marks the start of the JVs legal existence and is used for financial reporting under IFRS 11.',
    `governing_law_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the jurisdiction whose laws govern the JV agreement and dispute resolution. Critical for cross-border JV arrangements and PPP/BOT projects.. Valid values are `^[A-Z]{3}$`',
    `governing_law_jurisdiction` STRING COMMENT 'Specific legal jurisdiction or state/province within the governing law country that applies to the JV agreement (e.g., New South Wales, Dubai International Financial Centre). Supplements governing_law_country for sub-national jurisdictions.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the JV structure record is currently active and operational. False indicates the JV has been dissolved, superseded, or administratively deactivated. Used for data filtering in reporting and CRM pipeline views.',
    `is_lead_sponsor_internal` BOOLEAN COMMENT 'Boolean flag indicating whether the lead sponsor of the JV is an internal entity (i.e., Construction itself or one of its subsidiaries) as opposed to an external third-party organisation. Drives internal vs. external reporting segmentation.',
    `jv_agreement_reference` STRING COMMENT 'Document reference number or identifier for the executed JV agreement, as registered in Aconex document management or the contract administration system. Used to trace the legal instrument governing the JV.',
    `jv_manager_email` STRING COMMENT 'Business email address of the designated JV Manager. Used for official correspondence, notifications, and stakeholder communication management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `jv_manager_name` STRING COMMENT 'Full name of the designated JV Manager or Managing Director responsible for day-to-day operations and governance of the JV. This is a role-level contact, not a personal identifier.',
    `jv_manager_phone` STRING COMMENT 'Business phone number of the designated JV Manager for direct contact. Used for urgent project communications and stakeholder engagement.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `jv_name` STRING COMMENT 'Official registered or trading name of the Joint Venture entity as stated in the JV agreement and used in all project correspondence, bid submissions, and regulatory filings.',
    `jv_reference_number` STRING COMMENT 'Externally-known unique business identifier assigned to the JV arrangement, used in contracts, correspondence, and regulatory filings. Sourced from Salesforce CRM or Aconex document management.. Valid values are `^JV-[A-Z0-9]{4,20}$`',
    `jv_short_name` STRING COMMENT 'Abbreviated or commonly used name for the JV, used in internal reporting, dashboards, and project management systems such as Oracle Primavera P6 and Procore.',
    `jv_status` STRING COMMENT 'Current lifecycle status of the JV arrangement. formation indicates the JV is being constituted; pending indicates awaiting regulatory or client approval; active indicates fully operational; suspended indicates temporarily halted; dissolved indicates the JV has been wound up.. Valid values are `active|pending|dissolved|suspended|formation`',
    `jv_type` STRING COMMENT 'Classification of the JV arrangement by delivery model or legal structure. PPP (Public-Private Partnership), BOT (Build-Operate-Transfer), Consortium, Incorporated JV, Unincorporated JV, or EPC (Engineering Procurement and Construction) joint venture. [ENUM-REF-CANDIDATE: PPP|BOT|Consortium|Incorporated|Unincorporated|EPC — promote to reference product if additional types are required]. Valid values are `PPP|BOT|Consortium|Incorporated|Unincorporated|EPC`',
    `leed_certification_target` STRING COMMENT 'Target LEED (Leadership in Energy and Environmental Design) certification level for the project associated with this JV. Used for sustainability reporting and client commitment tracking.. Valid values are `certified|silver|gold|platinum|none`',
    `liability_structure` STRING COMMENT 'Legal liability arrangement between JV partners as defined in the JV agreement. joint_and_several means each partner is fully liable; several_only means each partner is liable only for their share. Critical for risk management and contract administration.. Valid values are `joint_and_several|several_only|limited|proportional`',
    `management_structure_type` STRING COMMENT 'Type of governance and management structure adopted by the JV. board indicates a formal board of directors; management_committee indicates a joint committee; single_manager indicates one partner manages on behalf of all; co_management indicates shared management responsibilities.. Valid values are `board|management_committee|single_manager|co_management`',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special conditions, or commentary about the JV arrangement that is not captured in structured fields. Used by contract administrators and project managers.',
    `ntp_date` DATE COMMENT 'Date on which the NTP (Notice to Proceed) was issued to the JV, authorising commencement of construction works. Marks the official start of the JVs contractual obligations and is used for schedule baseline management in Oracle Primavera P6.',
    `participant_count` STRING COMMENT 'Total number of participating entities (partners or members) in the JV arrangement. Used for governance reporting and to validate completeness of the JV participant roster.',
    `profit_sharing_basis` STRING COMMENT 'Basis on which profits and losses are distributed among JV participants. equity_proportional aligns P&L distribution with equity share percentages; negotiated indicates a bespoke arrangement defined in the JV agreement.. Valid values are `equity_proportional|equal_share|negotiated|cost_plus`',
    `project_sector` STRING COMMENT 'Primary industry sector of the construction project(s) associated with this JV. Used for client segmentation, pipeline forecasting in Salesforce CRM, and portfolio analytics. [ENUM-REF-CANDIDATE: infrastructure|energy|commercial|residential|industrial|transport|water|healthcare|education — promote to reference product]. Valid values are `infrastructure|energy|commercial|residential|industrial|transport`',
    `registration_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country in which the JV entity is legally registered. May differ from the governing law country for cross-border projects.. Valid values are `^[A-Z]{3}$`',
    `registration_number` STRING COMMENT 'Official company or entity registration number issued by the relevant government authority for the incorporated JV entity. Applicable for incorporated JV types; null for unincorporated consortia.',
    `source_system` STRING COMMENT 'Name of the operational system of record from which this JV structure record was sourced. Supports data lineage tracking and reconciliation across Salesforce CRM, Aconex, SAP S/4HANA, and Procore.. Valid values are `Salesforce|Aconex|SAP_S4HANA|Procore|Manual`',
    `total_committed_capital` DECIMAL(18,2) COMMENT 'Total capital committed by all JV participants as stated in the JV agreement, expressed in the JVs primary currency. Used for financial reporting, EBITDA analysis, and project cost control.',
    `total_equity_pct` DECIMAL(18,2) COMMENT 'Sum of all participating entities equity share percentages in the JV. Must equal 100.00% for a fully constituted JV. Used as a validation and audit control field.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the JV structure record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change tracking, data lineage, and incremental ETL processing in the Databricks Silver Layer.',
    CONSTRAINT pk_jv_structure PRIMARY KEY(`jv_structure_id`)
) COMMENT 'Defines Joint Venture (JV) arrangements where multiple client entities co-sponsor or co-own a construction project. Captures JV name, lead sponsor, participating entities, equity share percentages, JV agreement reference, governing law, JV type (PPP, BOT, consortium), formation date, dissolution date, and JV management structure. Critical for PPP and BOT project delivery models.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate identifier for each client address record in the Construction data platform. Serves as the primary key for the client_address entity.',
    `account_id` BIGINT COMMENT 'Reference to the parent client account to which this address belongs. Links the address record to the client master in the CRM (Customer Relationship Management) system (Salesforce CRM).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address record. Active indicates the address is in current use; inactive means it is no longer used; pending_validation awaits address verification; superseded means it has been replaced by a newer address; undeliverable indicates mail or correspondence has been returned.. Valid values are `active|inactive|pending_validation|superseded|undeliverable`',
    `address_type` STRING COMMENT 'Classifies the functional purpose of the address. Registered office is the legal domicile; billing is used for invoice delivery; correspondence is the preferred mailing address; project_site_liaison is the on-site contact office for a specific project; head_office and branch_office denote organisational hierarchy locations. [ENUM-REF-CANDIDATE: registered_office|billing|correspondence|project_site_liaison|head_office|branch_office — promote to reference product]. Valid values are `registered_office|billing|correspondence|project_site_liaison|head_office|branch_office`',
    `attention_to` STRING COMMENT 'Name of the specific individual or department to whom correspondence should be directed at this address (e.g., Attn: Contracts Manager or Attn: Finance Department). Used in formal contract correspondence and RFI (Request for Information) transmittals.',
    `building_name` STRING COMMENT 'Name of the building or complex at this address (e.g., Empire State Building, One Canada Square, Dubai World Trade Centre). Used for precise address identification in dense urban environments and for formal correspondence headers.',
    `city` STRING COMMENT 'Name of the city, town, or municipality in which the address is located. Used for regional client segmentation, jurisdiction determination, and multi-city project coordination.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the address (e.g., USA, GBR, AUS, ARE). Supports multi-jurisdiction client management across global construction operations including EPC (Engineering, Procurement and Construction) and PPP (Public-Private Partnership) projects.. Valid values are `^[A-Z]{3}$`',
    `country_name` STRING COMMENT 'Full English name of the country corresponding to the country_code. Stored for display and reporting purposes to avoid repeated lookups against the ISO country reference table.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the data platform. Provides the audit trail creation marker for data governance and GDPR compliance tracking.',
    `effective_from_date` DATE COMMENT 'Date from which this address became or becomes effective for the client. Supports temporal address management, enabling historical address tracking for contract administration and legal notice purposes.',
    `effective_to_date` DATE COMMENT 'Date on which this address ceases to be effective for the client. Null indicates the address is currently active with no planned end date. Used for temporal address history management and superseded address tracking.',
    `email_address` STRING COMMENT 'General email address associated with this address location (e.g., a departmental or office inbox). Used for electronic correspondence, transmittal delivery via Aconex, and formal notice under contract. Distinct from individual contact email addresses.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number associated with this address location. Retained for clients and jurisdictions where fax remains a legally recognised method of formal notice delivery under FIDIC contract conditions.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `floor_level` STRING COMMENT 'Floor or level number within a building at this address (e.g., Level 12, Ground Floor, Basement 2). Used for precise delivery instructions and visitor access coordination for client site visits.',
    `format_type` STRING COMMENT 'Indicates the structural format of the address to support correct rendering and printing. Western follows street-city-state-postal conventions; eastern follows country-specific formats (e.g., Japan, China); po_box is a post office box address; free_form is an unstructured address entry.. Valid values are `western|eastern|po_box|free_form`',
    `is_billing_address` BOOLEAN COMMENT 'Indicates whether this address is designated as the billing address for invoice delivery and accounts receivable correspondence. Used by SAP S/4HANA AR (Accounts Receivable) module for invoice routing.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the primary address for the client account. Only one address per client should be flagged as primary at any given time. Used to determine the default address for correspondence and contract documentation.',
    `is_registered_office` BOOLEAN COMMENT 'Indicates whether this address is the legally registered office address of the client entity. Required for contract execution, legal notices under FIDIC conditions, and regulatory compliance filings.',
    `jurisdiction_code` STRING COMMENT 'Legal and regulatory jurisdiction code applicable to this address, combining ISO 3166-1 country code and subdivision code (e.g., US-CA for California, AU-NSW for New South Wales). Used for tax jurisdiction mapping, OSHA/EPA regulatory compliance, and contract law determination.. Valid values are `^[A-Z]{2,3}-[A-Z0-9]{1,6}$`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the address in decimal degrees (WGS 84 datum). Supports GIS (Geographic Information System) mapping, proximity analysis to active construction sites, and spatial analytics for project planning.',
    `line_1` STRING COMMENT 'Primary street address line including building number, street name, and suite or unit number. Represents the first line of the postal address as used in official correspondence and contract documentation.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as floor number, building name, industrial estate, or campus identifier. Optional field used when the primary line is insufficient.',
    `line_3` STRING COMMENT 'Tertiary address line used for additional locality or district information, particularly relevant for international clients in regions where addresses require more than two street lines.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the address in decimal degrees (WGS 84 datum). Used in conjunction with latitude for GIS (Geographic Information System) spatial analysis, site proximity calculations, and mapping of client office locations.',
    `notes` STRING COMMENT 'Free-text field for additional address-related notes or delivery instructions (e.g., Security clearance required for entry, Use rear entrance, Deliveries accepted Monday-Friday only). Supports operational coordination for site visits and document deliveries.',
    `phone_number` STRING COMMENT 'Primary telephone number associated with this address location. Used for direct contact with the client office at this address for project coordination, site liaison, and contract administration purposes.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `po_box_number` STRING COMMENT 'Post Office (PO) Box number for clients who receive correspondence via a PO Box rather than a street address. Common for government agencies, public-sector clients, and clients in regions where PO Box delivery is standard.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address. Used for mail routing, geographic clustering of clients, and regional analytics. Format varies by country (e.g., 5-digit US ZIP, alphanumeric UK postcode).',
    `preferred_correspondence_language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code indicating the preferred language for correspondence sent to this address (e.g., en for English, fr for French, ar for Arabic). Supports multilingual client communication in international construction markets.. Valid values are `^[a-z]{2,3}$`',
    `region` STRING COMMENT 'Broad geographic region grouping for the address (e.g., North America, Middle East, Asia Pacific, Europe). Used for regional portfolio reporting, business development segmentation, and PMO (Project Management Office) territory alignment.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this address record originated. Supports data lineage tracking and conflict resolution when the same client address exists in multiple systems (e.g., Salesforce CRM vs SAP S/4HANA).. Valid values are `salesforce_crm|sap_s4hana|procore|manual|aconex|other`',
    `source_system_address_code` STRING COMMENT 'The native identifier of this address record in the originating operational system (e.g., Salesforce CRM Address ID, SAP S/4HANA partner address number). Used for data lineage, reconciliation, and cross-system deduplication.',
    `state_province` STRING COMMENT 'State, province, territory, or region within the country. Used for regulatory jurisdiction mapping, tax compliance, and regional reporting across multi-jurisdiction construction clients.',
    `suite_unit_number` STRING COMMENT 'Suite, unit, or office number within a building at this address. Provides the final level of address precision for multi-tenant buildings where multiple client offices may occupy the same floor.',
    `tax_jurisdiction_code` STRING COMMENT 'Specific tax jurisdiction code for the address as used in SAP S/4HANA tax determination. May differ from the general jurisdiction code in federal/state/local tax overlay scenarios. Used for sales tax, VAT, and withholding tax calculations on client invoices.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Asia/Dubai, Australia/Sydney). Used for scheduling client communications, meeting coordination, and project milestone notifications across global construction operations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last modified in the data platform. Used for change detection, incremental data loading in the Databricks Lakehouse Silver Layer, and audit trail maintenance.',
    `validation_date` DATE COMMENT 'Date on which the address was last validated against a postal authority or address verification service. Used to schedule re-validation cycles and assess data quality freshness.',
    `validation_source` STRING COMMENT 'Name of the service or system used to validate the address (e.g., USPS, Google Maps API, Loqate, SmartyStreets). Provides traceability for data quality audits and vendor management.',
    `validation_status` STRING COMMENT 'Result of the address validation process against a postal authority or third-party address verification service. Validated means the address has been confirmed as deliverable; not_validated means validation has not been attempted; failed means the address could not be verified; partial means only some components were verified.. Valid values are `validated|not_validated|failed|partial`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing addresses associated with client accounts, including registered office, billing address, project site liaison office, and correspondence address. Captures address type, street, city, state/province, postal code, country, GIS coordinates, and address validation status. Supports multi-jurisdiction clients operating across regions.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`client_opportunity` (
    `client_opportunity_id` BIGINT COMMENT 'Unique surrogate identifier for the client opportunity record in the Databricks Silver Layer. Primary key for the client_opportunity data product.',
    `account_id` BIGINT COMMENT 'Reference to the client account (project owner, developer, or sponsor) associated with this opportunity. Maps to the Salesforce CRM Account object.',
    `bid_opportunity_id` BIGINT COMMENT 'Foreign key linking to bid.bid_opportunity. Business justification: Required for Opportunity Alignment Report linking client opportunity to the corresponding bid opportunity to track win/loss and financial exposure.',
    `actual_award_date` DATE COMMENT 'Date on which the contract was formally awarded. Populated upon win outcome. Used for win/loss analysis and BD cycle time measurement.',
    `bid_cost_estimate` DECIMAL(18,2) COMMENT 'Internal estimate of the cost to prepare and submit the bid (tendering cost), including estimating, engineering, and proposal resources. Used for bid cost tracking and ROI analysis on BD spend.',
    `bid_no_bid_decision` STRING COMMENT 'Formal decision outcome from the bid/no-bid review process indicating whether the company will pursue this opportunity. Pending_review indicates the decision gate has not yet been completed.. Valid values are `bid|no_bid|pending_review`',
    `bid_no_bid_decision_date` DATE COMMENT 'Date on which the formal bid/no-bid decision was made and recorded. Used for governance audit trails and BD cycle time analysis.',
    `bid_submission_date` DATE COMMENT 'Actual or planned date on which the bid/tender/proposal was or is to be submitted to the client. Critical scheduling milestone for BD and estimating teams.',
    `bim_required` BOOLEAN COMMENT 'Indicates whether the client mandates Building Information Modeling (BIM) as a project delivery requirement. True = BIM is contractually required. Drives technology and resource planning for the bid.',
    `boq_available` BOOLEAN COMMENT 'Indicates whether a Bill of Quantities (BOQ) has been issued by the client as part of the tender package. True = BOQ provided; False = lump-sum or design-build without BOQ. Affects estimating approach and bid strategy.',
    `client_opportunity_description` STRING COMMENT 'Free-text narrative describing the scope, nature, and key characteristics of the construction opportunity. Provides context for BD team members reviewing the pipeline and supports AI/ML-based opportunity classification.',
    `competitor_names` STRING COMMENT 'Names of known competing firms bidding on the same opportunity. Free-text or comma-separated list. Confidential competitive intelligence used for bid strategy and market positioning analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the source CRM system. Represents the business event of opportunity identification and entry into the BD pipeline. Used for pipeline age and BD cycle time analytics.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated contract value and weighted pipeline value (e.g., USD, EUR, AED, GBP). Required for multi-currency pipeline consolidation.. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Contract delivery model under which the construction project will be executed. EPC = Engineering Procurement and Construction; GMP = Guaranteed Maximum Price; DBB = Design-Bid-Build; DB = Design-Build; PPP = Public-Private Partnership; BOT = Build-Operate-Transfer; FIDIC = FIDIC-based contract. Drives risk allocation and commercial strategy. [ENUM-REF-CANDIDATE: EPC|GMP|DBB|DB|PPP|BOT|FIDIC — 7 candidates stripped; promote to reference product]',
    `esg_requirements` STRING COMMENT 'Description of any Environmental, Social, and Governance (ESG) requirements specified by the client for this opportunity (e.g., carbon targets, local content requirements, diversity commitments). Free-text field for BD qualification notes.',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Estimated total contract value of the opportunity in the reporting currency. Used for pipeline forecasting, revenue planning, and bid/no-bid decision thresholds. Raw commercial estimate; not a committed figure.',
    `expected_award_date` DATE COMMENT 'Anticipated date on which the contract is expected to be formally awarded to the company. Used for pipeline close-date forecasting and resource mobilization planning.',
    `expected_ntp_date` DATE COMMENT 'Anticipated date on which the client will issue the Notice to Proceed (NTP), authorizing the start of construction work. Used for resource planning and revenue recognition scheduling.',
    `is_jv_bid` BOOLEAN COMMENT 'Indicates whether this opportunity is being pursued as a Joint Venture (JV) arrangement. True = JV bid; False = sole-entity bid. Drives JV governance and risk review processes.',
    `jv_partner_names` STRING COMMENT 'Names of Joint Venture (JV) partners with whom the company intends to bid on this opportunity. Relevant for JV-structured bids common in large infrastructure and EPC projects. Confidential commercial information.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the opportunity record in the source CRM system. Used for change tracking, data freshness monitoring, and incremental pipeline loads.',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether the client requires LEED (Leadership in Energy and Environmental Design) certification for the project. True = LEED certification is a contract requirement. Drives sustainability planning and cost estimation.',
    `loss_reason` STRING COMMENT 'Reason code or description explaining why the opportunity was lost or withdrawn (e.g., price, technical score, client relationship, competitor strength, scope mismatch). Populated when win_loss_outcome is lost or withdrawn. Used for BD lessons-learned and competitive intelligence. [ENUM-REF-CANDIDATE: price|technical_score|client_relationship|competitor_strength|scope_mismatch|capacity|no_bid_decision|other — promote to reference product]',
    `next_action` STRING COMMENT 'Description of the next planned business development action required to advance this opportunity (e.g., Submit EOI by 15-Mar, Attend client briefing, Complete bid/no-bid review). Operational field used by BD team for pipeline management.',
    `next_action_due_date` DATE COMMENT 'Target date by which the next business development action must be completed. Used for BD pipeline hygiene, follow-up scheduling, and opportunity stagnation alerts.',
    `opportunity_name` STRING COMMENT 'Descriptive name of the construction opportunity, typically including the project name and client name (e.g., Greenfield Highway Extension – ADOT). Used for identification in pipeline reports and BD dashboards.',
    `opportunity_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the opportunity as assigned in Salesforce CRM. Used for cross-system reference and client-facing communications.. Valid values are `^OPP-[0-9]{4}-[0-9]{6}$`',
    `opportunity_status` STRING COMMENT 'Lifecycle status of the opportunity record indicating whether it is actively pursued, won, lost, on hold, or cancelled. Distinct from pipeline_stage which tracks the BD workflow step.. Valid values are `open|closed_won|closed_lost|on_hold|cancelled`',
    `pipeline_stage` STRING COMMENT 'Current stage of the opportunity in the business development pipeline. Drives pipeline forecasting and BD reporting. [ENUM-REF-CANDIDATE: prospect|qualification|bid_preparation|submitted|negotiation|awarded|lost|no_bid — promote to reference product]',
    `prequalification_status` STRING COMMENT 'Status of the companys prequalification with the client for this opportunity. Many public-sector and large private clients require formal prequalification before bid submission. Drives eligibility gating in the BD pipeline.. Valid values are `not_required|pending|approved|rejected`',
    `probability_of_win_pct` DECIMAL(18,2) COMMENT 'Estimated probability (0–100%) that the company will be awarded this contract. Used to calculate weighted pipeline value for revenue forecasting. Assigned by the BD owner and reviewed at stage gates.',
    `project_duration_months` STRING COMMENT 'Estimated duration of the construction project in months from NTP to practical completion. Used for resource planning, revenue phasing, and schedule risk assessment.',
    `project_location_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the construction project will be executed (e.g., USA, ARE, GBR). Used for geographic pipeline analysis and regulatory compliance scoping.. Valid values are `^[A-Z]{3}$`',
    `project_location_region` STRING COMMENT 'State, province, or region where the construction project will be executed. Used for regional pipeline reporting, resource planning, and jurisdictional compliance (e.g., OSHA state plans, local building codes).',
    `project_type` STRING COMMENT 'Classification of the construction project type (e.g., highway, airport, bridge, power plant, residential, commercial, industrial). Used for market segmentation and capability matching. [ENUM-REF-CANDIDATE: highway|airport|bridge|power_plant|residential|commercial|industrial|water_treatment|rail|data_center — promote to reference product]',
    `rfp_issue_date` DATE COMMENT 'Date on which the client issued the Request for Proposal (RFP) or Invitation to Tender (ITT). Marks the formal start of the bid preparation phase.',
    `rfq_number` STRING COMMENT 'Client-issued Request for Quotation (RFQ) or Request for Proposal (RFP) reference number. Used for cross-referencing with client procurement documents and Aconex correspondence.',
    `sector` STRING COMMENT 'Sector classification of the client commissioning the work: public-sector (government/municipal), private-sector (developer/corporate), or PPP/BOT (public-private partnership or build-operate-transfer arrangement). Used for client segmentation and reporting.. Valid values are `public|private|ppp_bot`',
    `source_crm_opportunity_code` STRING COMMENT 'Original opportunity identifier from the Salesforce CRM system of record. Used for data lineage, cross-system reconciliation, and traceability back to the operational source.',
    `strategic_priority` STRING COMMENT 'Internal strategic priority classification assigned to this opportunity by BD leadership. Tier 1 = highest strategic importance (must-win); Tier 2 = important but not critical; Tier 3 = opportunistic. Drives resource allocation for bid preparation.. Valid values are `tier_1|tier_2|tier_3`',
    `weighted_pipeline_value` DECIMAL(18,2) COMMENT 'Estimated contract value multiplied by the probability of win percentage, representing the risk-adjusted contribution of this opportunity to the revenue forecast. Key metric for executive pipeline reporting.',
    `win_loss_outcome` STRING COMMENT 'Final outcome of the opportunity after the bid process concludes. Won = contract awarded to company; Lost = awarded to competitor; Withdrawn = company withdrew bid; No_award = client cancelled procurement. Drives win rate analytics and BD performance reporting.. Valid values are `won|lost|withdrawn|no_award`',
    CONSTRAINT pk_client_opportunity PRIMARY KEY(`client_opportunity_id`)
) COMMENT 'Pre-award commercial opportunity record tracking potential construction projects in the BD pipeline. Captures opportunity name, client account, project type, estimated contract value, delivery model (EPC, GMP, DBB, PPP), bid/no-bid decision, probability of win, expected NTP date, pipeline stage, BD owner, and win/loss outcome. Sourced from Salesforce CRM Opportunity object. SSOT for pipeline forecasting.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`project_engagement` (
    `project_engagement_id` BIGINT COMMENT 'Unique surrogate identifier for the client project engagement record. Primary key for this bridge entity linking a client account to a specific construction project.',
    `account_id` BIGINT COMMENT 'Reference to the client account (owner, developer, sponsor, or funding agency) involved in this engagement. Links to the client master record.',
    `agreement_id` BIGINT COMMENT 'Reference to the primary contract governing this client-project engagement (e.g., EPC, FIDIC, GMP, DB, DBB, or PPP/BOT contract). Links to the contract master record.',
    `client_opportunity_id` BIGINT COMMENT 'The opportunity identifier from the Salesforce CRM system that tracks the sales pipeline record associated with this engagement. Enables traceability from opportunity pursuit through to active project delivery.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project that this client is commissioning, sponsoring, or funding. Links to the project master record.',
    `contact_id` BIGINT COMMENT 'Reference to the primary contact person designated by the client to represent their interests on this project. Typically the client-side project manager or authorized representative.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to client.client_framework_agreement. Business justification: Project engagements in construction are frequently executed as call-offs under a framework agreement or MSA. Linking project_engagement directly to client_framework_agreement enables reporting on fram',
    `rfp_issuance_id` BIGINT COMMENT 'Foreign key linking to client.rfp_issuance. Business justification: A project engagement (the awarded contract relationship) originates from an RFP/ITT issuance. Linking project_engagement to rfp_issuance closes the BD pipeline loop: opportunity → RFP issuance → proje',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'The value of any advance payment made by the client to the contractor at the commencement of this engagement, typically secured by an advance payment guarantee. Expressed in the contract currency.',
    `approved_variation_value` DECIMAL(18,2) COMMENT 'The cumulative value of all approved Change Orders (CO) / variations issued by the client on this engagement to date. Reflects the net adjustment to the original contract value due to scope changes.',
    `bid_reference_number` STRING COMMENT 'The reference number assigned to the original bid or tender submission (RFP/RFQ response) that led to this engagement being awarded. Links the engagement back to the opportunity pipeline in the CRM.',
    `bim_required` BOOLEAN COMMENT 'Indicates whether the client has mandated Building Information Modeling (BIM) as a contractual deliverable requirement for this engagement. Drives BIM execution plan obligations and Autodesk BIM 360 usage.',
    `client_role` STRING COMMENT 'The functional role the client plays in this project engagement. Distinguishes between the primary owner, co-sponsor in a joint venture (JV), lead JV partner, funding agency (e.g., government body), end-user of the completed asset, or developer. [ENUM-REF-CANDIDATE: owner|co_sponsor|jv_lead|funding_agency|end_user|developer|ppp_authority|bot_concessionaire — promote to reference product if additional roles are needed]. Valid values are `owner|co_sponsor|jv_lead|funding_agency|end_user|developer`',
    `communication_preference` STRING COMMENT 'The clients preferred channel for formal project communications and correspondence on this engagement. Determines how RFIs, submittals, transmittals, and official notices are delivered.. Valid values are `email|aconex|portal|formal_letter|meeting`',
    `contract_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the contract value and financial commitments in this engagement (e.g., USD, EUR, GBP, AED). Required for multi-currency project reporting and IFRS/GAAP compliance.. Valid values are `^[A-Z]{3}$`',
    `contract_reference_number` STRING COMMENT 'The externally-known contract number or agreement reference assigned to the governing contract for this engagement. Used for cross-referencing with contract administration systems and client correspondence.',
    `contract_value` DECIMAL(18,2) COMMENT 'The total awarded contract value for this client-project engagement as agreed at contract execution. Represents the baseline financial commitment from the client. Expressed in the contract currency.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp at which this client-project engagement record was first created in the system. Provides the audit trail creation marker for data governance and lineage tracking.',
    `dispute_status` STRING COMMENT 'Current status of any formal contractual dispute between the client and the contractor on this engagement. Tracks the dispute resolution lifecycle from initial notice through negotiation, adjudication, or arbitration to resolution.. Valid values are `none|notice_issued|negotiation|adjudication|arbitration|resolved`',
    `dlp_end_date` DATE COMMENT 'The date on which the Defects Liability Period (DLP) expires, after which the contractors obligation to rectify defects at no cost to the client ceases. Critical for contract close-out and final account settlement.',
    `engagement_end_date` DATE COMMENT 'The date on which the clients formal involvement in the project is expected to conclude or has concluded. Typically aligned with project handover, Defects Liability Period (DLP) expiry, or BOT concession end date. Nullable for open-ended engagements.',
    `engagement_notes` STRING COMMENT 'Free-text field for capturing qualitative notes, special conditions, or contextual information relevant to this client-project engagement that are not captured in structured fields. Used by account managers and project directors.',
    `engagement_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this client-project engagement. Used in correspondence, transmittals, and CRM tracking to uniquely identify the engagement across systems.. Valid values are `^[A-Z]{2,6}-ENG-[0-9]{4,10}$`',
    `engagement_start_date` DATE COMMENT 'The date on which the clients formal involvement in the project commenced. Typically aligned with the Notice to Proceed (NTP) date or the contract execution date.',
    `engagement_status` STRING COMMENT 'Current lifecycle state of the client-project engagement. Tracks whether the engagement is actively ongoing, pending formal commencement (awaiting NTP), on hold, completed at project handover, terminated early, or cancelled prior to commencement.. Valid values are `active|pending|on_hold|completed|terminated|cancelled`',
    `engagement_type` STRING COMMENT 'Classification of the contractual or commercial arrangement type governing this engagement. Reflects the delivery model: EPC (Engineering Procurement and Construction), Design-Build (DB), Design-Bid-Build (DBB), Public-Private Partnership (PPP), Build-Operate-Transfer (BOT), Guaranteed Maximum Price (GMP), framework agreement, or direct award. [ENUM-REF-CANDIDATE: epc|design_build|design_bid_build|ppp|bot|gmp|framework|direct_award — promote to reference product]',
    `eot_days_granted` STRING COMMENT 'The total number of calendar days of Extension of Time (EOT) formally granted by the client to the contractor on this engagement to date. Adjusts the contractual completion date and affects LD exposure.',
    `funding_source` STRING COMMENT 'Classification of the primary funding mechanism used by the client to finance this project engagement. Supports financial risk assessment and reporting. [ENUM-REF-CANDIDATE: government_grant|private_equity|bank_loan|bond_issuance|multilateral|internal_budget|mixed|ppp_concession — promote to reference product]',
    `handover_date` DATE COMMENT 'The actual or planned date on which the completed project asset was or is expected to be handed over to the client. Marks the transition from construction to the Defects Liability Period (DLP) or Operations and Maintenance (O&M) phase.',
    `hse_requirements_classification` STRING COMMENT 'Classification of the HSE (Health, Safety and Environment) requirements imposed by the client for this engagement. Reflects the risk profile and regulatory environment: standard (baseline OSHA/ISO 45001), enhanced (client-specific elevated requirements), or critical (high-hazard environments such as nuclear, offshore, or major infrastructure).. Valid values are `standard|enhanced|critical`',
    `insurance_compliance_verified` BOOLEAN COMMENT 'Indicates whether the contractors required insurance policies (e.g., professional indemnity, public liability, contractors all-risk) have been verified as compliant with the clients contractual requirements for this engagement.',
    `jv_participation_percentage` DECIMAL(18,2) COMMENT 'The clients ownership or participation share percentage in a Joint Venture (JV) arrangement for this project. Applicable when the client role is co-sponsor or JV lead. Null for sole-owner engagements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp at which this client-project engagement record was most recently modified. Supports change tracking, data freshness monitoring, and incremental data pipeline processing in the Databricks Silver layer.',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether the client has mandated LEED (Leadership in Energy and Environmental Design) certification for the project deliverable as a contractual requirement in this engagement.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'The contractually agreed daily or weekly Liquidated Damages (LD) rate payable by the contractor to the client in the event of project delay beyond the agreed completion date. Expressed in the contract currency per day.',
    `ntp_date` DATE COMMENT 'The date on which the Notice to Proceed (NTP) was formally issued by the client to the contractor, authorizing commencement of construction works. A critical contractual milestone in the engagement lifecycle.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether the client has required the contractor to provide a performance bond as a financial security instrument for this engagement. Affects contract financial structuring and risk management.',
    `procurement_method` STRING COMMENT 'The procurement route used by the client to award this engagement. Indicates whether the contract was awarded through open tender, selective tender, direct negotiation, Request for Proposal (RFP), Request for Quotation (RFQ), or a framework call-off.. Valid values are `open_tender|selective_tender|direct_negotiation|rfp|rfq|framework_call_off`',
    `relationship_tier` STRING COMMENT 'Segmentation tier assigned to this client engagement based on strategic importance, revenue contribution, and long-term relationship value. Drives account management priority and resource allocation.. Valid values are `strategic|preferred|standard|transactional`',
    `repeat_client` BOOLEAN COMMENT 'Indicates whether this client has previously engaged the construction company on one or more prior projects. Supports client relationship analytics, win-rate reporting, and strategic account management.',
    `reporting_frequency` STRING COMMENT 'The agreed frequency at which formal project progress reports are submitted to the client for this engagement. Governs the reporting cadence for schedule, cost, and HSE performance updates.. Valid values are `weekly|fortnightly|monthly|quarterly|milestone_based`',
    `retention_percentage` DECIMAL(18,2) COMMENT 'The contractually agreed retention percentage withheld by the client from each progress payment as a performance security. Typically released in two tranches: at practical completion and at DLP expiry.',
    `satisfaction_score` DECIMAL(18,2) COMMENT 'Numeric score representing the clients satisfaction with the construction companys performance on this engagement, typically captured through formal client satisfaction surveys. Scored on a standardized scale (e.g., 1.00–5.00 or 0.00–10.00).',
    `satisfaction_survey_date` DATE COMMENT 'The date on which the most recent client satisfaction survey was conducted for this engagement. Used to track the currency of satisfaction data and schedule follow-up surveys.',
    `sector` STRING COMMENT 'Sector classification of the client for this engagement: public-sector (government/municipal), private-sector (commercial developer or corporation), or PPP (Public-Private Partnership arrangement). Supports client segmentation and reporting.. Valid values are `public|private|ppp`',
    CONSTRAINT pk_project_engagement PRIMARY KEY(`project_engagement_id`)
) COMMENT 'Bridge record linking a client account to a specific construction project they commission, sponsor, or fund. Captures client role (owner, co-sponsor, JV lead, funding agency, end-user), engagement start and end dates, primary client representative, contract reference, engagement status, and satisfaction indicators. SSOT for which clients are involved in which projects from the client domain perspective. Does not duplicate project master data owned by the project domain.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`rfp_issuance` (
    `rfp_issuance_id` BIGINT COMMENT 'Unique surrogate identifier for each RFP/RFQ/ITT issuance record in the system. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the client/owner account that issued this solicitation. Links to the master client account record in the CRM. Sourced from Salesforce CRM Account Management.',
    `client_opportunity_id` BIGINT COMMENT 'Reference to the linked sales opportunity in the CRM pipeline that this RFP issuance is associated with. Enables traceability from solicitation to bid pursuit. Sourced from Salesforce CRM Opportunity Tracking.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to client.client_framework_agreement. Business justification: In construction, RFPs are frequently issued as call-offs under a pre-existing framework agreement or MSA. Linking rfp_issuance to client_framework_agreement enables traceability from a specific tender',
    `addendum_count` STRING COMMENT 'The total number of addenda (amendments) issued by the client against this RFP since original issuance. Each addendum modifies the original RFP terms, scope, or schedule. Used to track document version history.',
    `anticipated_award_date` DATE COMMENT 'The clients indicative target date for issuing the Notice to Proceed (NTP) or contract award, as stated in the RFP. Used for resource planning, bid team scheduling, and pipeline forecasting in Salesforce CRM.',
    `anticipated_completion_date` DATE COMMENT 'The clients required or indicative project completion date as stated in the RFP. Defines the overall programme duration and is a key input to CPM (Critical Path Method) scheduling and resource planning.',
    `anticipated_start_date` DATE COMMENT 'The clients indicative target date for project commencement (Notice to Proceed / NTP) as stated in the RFP. Used for resource mobilisation planning and schedule baseline development in Oracle Primavera P6.',
    `bid_bond_percentage` DECIMAL(18,2) COMMENT 'The bid bond (tender guarantee) value expressed as a percentage of the estimated contract value, as required by the client in the RFP. Typically ranges from 1% to 5% of contract value. Null if bid bond is not required.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether the client requires a bid bond (tender guarantee) to be submitted with the proposal (True) or not (False). Bid bonds protect the client against bidder withdrawal after award.',
    `bid_validity_days` STRING COMMENT 'The number of calendar days from the submission deadline during which the bidders proposal must remain valid and binding, as specified in the RFP. Typically 60 to 180 days. Impacts financial exposure and resource commitment.',
    `bim_level` STRING COMMENT 'The BIM maturity level required by the client in the RFP: level_1 (CAD-based), level_2 (collaborative BIM with federated models), or level_3 (fully integrated open BIM). Null if BIM is not required.. Valid values are `level_1|level_2|level_3`',
    `bim_required` BOOLEAN COMMENT 'Indicates whether the client mandates the use of BIM (Building Information Modeling) for design and construction delivery as specified in the RFP (True) or not (False). Impacts technology requirements and Autodesk BIM 360 platform usage.',
    `client_sector` STRING COMMENT 'Classification of the client/owner by sector: public (government/public authority), private (private developer/corporation), ppp (Public-Private Partnership arrangement), or jv (Joint Venture client entity). Drives compliance, reporting, and bid strategy.. Valid values are `public|private|ppp|jv`',
    `commercial_score_weight` DECIMAL(18,2) COMMENT 'The percentage weighting assigned to the commercial/price component of the bid evaluation, as specified in the RFP (e.g., 40.00 for 40%). Combined with technical_score_weight to total 100%. Null for quality-only evaluations.',
    `contract_type` STRING COMMENT 'The pricing and risk-sharing mechanism for the contract as specified in the RFP: lump_sum (fixed price), unit_rate (BOQ-based), cost_plus (reimbursable), target_cost (incentivised), or framework (call-off arrangement). Directly influences bid strategy and cost estimation.. Valid values are `lump_sum|unit_rate|cost_plus|target_cost|framework`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the country where the project is located (e.g., USA, GBR, AUS). Used for regulatory compliance, currency, and jurisdictional reporting.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the contract value and financial terms stated in the RFP (e.g., USD, GBP, EUR, AUD). Required for multi-currency financial reporting and IFRS/GAAP compliance.. Valid values are `^[A-Z]{3}$`',
    `defects_liability_period_days` STRING COMMENT 'The duration of the Defects Liability Period (DLP) in calendar days as specified in the RFP, commencing from the date of practical completion. Typically 365 or 730 days. Impacts warranty provisioning and post-completion resource planning.',
    `delivery_model` STRING COMMENT 'The contractual delivery model specified in the RFP: DBB (Design-Bid-Build), DB (Design-Build), EPC (Engineering Procurement and Construction), GMP (Guaranteed Maximum Price), PPP (Public-Private Partnership), BOT (Build-Operate-Transfer), EPCM (Engineering Procurement Construction Management), or CM (Construction Management). Determines risk allocation and bid structure. [ENUM-REF-CANDIDATE: DBB|DB|EPC|GMP|PPP|BOT|EPCM|CM — promote to reference product]',
    `estimated_contract_value` DECIMAL(18,2) COMMENT 'Clients published or internally estimated value of the contract in the nominated currency. Used for bid/no-bid decision-making, bonding requirements, and pipeline forecasting. May be client-disclosed or internally estimated.',
    `evaluation_criteria` STRING COMMENT 'The overall evaluation methodology specified in the RFP for assessing and ranking bids: price_only (lowest price wins), price_quality (weighted price and technical), quality_only (technical merit), best_value (whole-life cost), or pass_fail (compliance-based). Drives bid strategy.. Valid values are `price_only|price_quality|quality_only|best_value|pass_fail`',
    `issue_date` DATE COMMENT 'The date on which the RFP/RFQ/ITT was formally issued and released to prospective bidders by the client. Represents the principal business event date for this solicitation record.',
    `issued_timestamp` TIMESTAMP COMMENT 'The system timestamp when this RFP issuance record was first created in the data platform. Represents the audit creation time, distinct from the business issue_date. Used for data lineage and audit trail.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The system timestamp of the most recent modification to this RFP issuance record. Used for change tracking, data synchronisation, and audit trail compliance.',
    `latest_addendum_date` DATE COMMENT 'The date of the most recent addendum issued by the client against this RFP. Null if no addenda have been issued. Used to ensure bidders are working from the latest version of the solicitation document.',
    `leed_certification_level` STRING COMMENT 'The minimum LEED certification level required by the client as stated in the RFP: certified, silver, gold, or platinum. Null if LEED certification is not required.. Valid values are `certified|silver|gold|platinum`',
    `leed_certification_required` BOOLEAN COMMENT 'Indicates whether the client has specified a LEED (Leadership in Energy and Environmental Design) certification requirement for the project in the RFP (True) or not (False). Impacts design, materials, and cost estimation.',
    `liquidated_damages_applicable` BOOLEAN COMMENT 'Indicates whether the RFP specifies that Liquidated Damages (LD) will apply for delays or non-performance (True) or not (False). LD clauses are a key risk factor in bid pricing and schedule planning.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'The daily Liquidated Damages (LD) rate specified in the RFP, expressed in the contract currency. Applied for each calendar day of delay beyond the contractual completion date. Null if LD is not applicable.',
    `local_content_requirement_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of local workforce, materials, or subcontractors required by the client as specified in the RFP. Common in public-sector and government-funded projects. Impacts procurement and subcontractor strategy.',
    `performance_bond_percentage` DECIMAL(18,2) COMMENT 'The performance bond value expressed as a percentage of the contract value, as specified in the RFP. Typically ranges from 5% to 10% of contract value. Null if performance bond is not required.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether the client requires a performance bond to be provided upon contract award (True) or not (False). Performance bonds guarantee the contractor will fulfil contractual obligations.',
    `pre_bid_meeting_date` TIMESTAMP COMMENT 'Scheduled date and time of the mandatory or optional pre-bid conference/site visit where the client clarifies scope and answers bidder questions. Attendance may be a prerequisite for bid eligibility.',
    `pre_bid_meeting_mandatory` BOOLEAN COMMENT 'Indicates whether attendance at the pre-bid meeting is mandatory for bid eligibility (True) or optional (False). Mandatory attendance is a common client requirement for complex infrastructure projects.',
    `project_description` STRING COMMENT 'Detailed narrative description of the project scope, works, and deliverables as outlined in the RFP. Includes key scope elements such as civil works, MEP systems, infrastructure type, and geographic extent.',
    `project_location` STRING COMMENT 'Geographic location or address of the proposed project site as stated in the RFP. Used for site visit planning, logistics assessment, and regional market analysis.',
    `project_sector` STRING COMMENT 'The industry sector classification of the project as described in the RFP. Used for market segmentation, capability matching, and portfolio analytics. [ENUM-REF-CANDIDATE: infrastructure|energy|commercial|residential|industrial|transport|water|healthcare|education|defence — promote to reference product]',
    `project_title` STRING COMMENT 'The official name or title of the project as stated in the RFP document. Provides the primary human-readable description of the work being solicited (e.g., Highway 45 Expansion Phase 2, Airport Terminal C Construction).',
    `rfp_document_reference` STRING COMMENT 'The document control reference number or URL/path to the official RFP package in the document management system (Aconex or Autodesk BIM 360). Enables direct retrieval of the source solicitation document.',
    `rfp_number` STRING COMMENT 'Externally-known reference number assigned by the client to uniquely identify this solicitation document (RFP, RFQ, or ITT). Used in all correspondence and bid submissions. Sourced from Salesforce CRM Bid Management or Aconex Document Management.. Valid values are `^[A-Z0-9-/]{3,50}$`',
    `rfp_status` STRING COMMENT 'Current lifecycle status of the RFP issuance: draft (being prepared), issued (released to market), amended (addendum issued), closed (submission deadline passed), cancelled (withdrawn by client), or awarded (contract awarded). Drives workflow and reporting.. Valid values are `draft|issued|amended|closed|cancelled|awarded`',
    `solicitation_type` STRING COMMENT 'Classification of the solicitation document type: RFP (Request for Proposal), RFQ (Request for Quotation), ITT (Invitation to Tender), EOI (Expression of Interest), or RFI (Request for Information). Determines the formality and evaluation process applied.. Valid values are `RFP|RFQ|ITT|EOI|RFI`',
    `submission_deadline` TIMESTAMP COMMENT 'The exact date and time by which all bid/proposal submissions must be received by the client. Late submissions are typically disqualified. Critical for bid planning and scheduling in Oracle Primavera P6.',
    `technical_score_weight` DECIMAL(18,2) COMMENT 'The percentage weighting assigned to the technical/quality component of the bid evaluation, as specified in the RFP (e.g., 60.00 for 60%). Combined with commercial_score_weight to total 100%. Null for price-only evaluations.',
    CONSTRAINT pk_rfp_issuance PRIMARY KEY(`rfp_issuance_id`)
) COMMENT 'Records RFP (Request for Proposal), RFQ (Request for Quotation), and ITT (Invitation to Tender) documents issued by clients, initiating the formal bid process. Captures RFP reference number, client account, project description, issue date, submission deadline, bond requirements (bid bond, performance bond), evaluation criteria weights, delivery model, pre-bid meeting dates, and linked opportunity. This is the client-side solicitation record; the firms response is managed in the bid domain.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`account_credit_profile` (
    `account_credit_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the account credit profile record in the Databricks Silver Layer. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the client account for which this credit profile applies. Links to the master client account entity in the client domain.',
    `approved_payment_terms` STRING COMMENT 'Contractually approved payment terms for this client account, governing the number of days within which invoices must be settled or the basis on which payments are triggered. Milestone-based and retention-release terms are common in EPC and FIDIC contracts. [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|milestone_based|retention_release|advance_payment|progress_claim — promote to reference product]. Valid values are `net_30|net_45|net_60|net_90|milestone_based|retention_release`',
    `bd_relationship_context` STRING COMMENT 'Business Development (BD) teams qualitative assessment of the strategic importance and relationship health of this client account, used as input to the internal credit scoring process. Strategic key accounts may receive more favourable credit terms.. Valid values are `strategic_key_account|preferred_client|standard|new_client|at_risk|dormant`',
    `client_segment` STRING COMMENT 'Business segment classification of the client account for credit risk segmentation and portfolio analysis. Supports differentiated credit policies for Public-Private Partnership (PPP), Build-Operate-Transfer (BOT), Joint Venture (JV), and private developer clients. [ENUM-REF-CANDIDATE: public_sector|private_sector|ppp|bot|jv_partner|developer|utility|epc_owner|multilateral — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was first created in the data platform. Supports audit trail and data lineage in the Databricks Silver Layer.',
    `credit_approved_date` DATE COMMENT 'Date on which the current credit limit and payment terms were formally approved by the authorised finance approver.',
    `credit_hold_date` DATE COMMENT 'Date on which the credit hold was applied to this client account. Null if no credit hold is currently active.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether this client account is currently placed on credit hold, blocking the issuance of new contracts, purchase orders, or progress claims until the hold is resolved. True = credit hold active; False = normal trading.',
    `credit_hold_reason` STRING COMMENT 'Reason code explaining why the credit hold was applied to this client account. Populated only when credit_hold_flag is True. Supports root-cause analysis and escalation workflows.. Valid values are `overdue_balance|credit_limit_exceeded|rating_downgrade|legal_dispute|insolvency_risk|manual_hold`',
    `credit_insurance_flag` BOOLEAN COMMENT 'Indicates whether trade credit insurance has been obtained to cover the financial exposure to this client account. True = credit insurance in place; False = no credit insurance.',
    `credit_insurance_limit_amount` DECIMAL(18,2) COMMENT 'Maximum insured amount covered by the trade credit insurance policy for this client account. Populated only when credit_insurance_flag is True.',
    `credit_insurance_provider` STRING COMMENT 'Name of the trade credit insurance provider covering the exposure to this client account (e.g., Euler Hermes, Coface, Atradius). Populated only when credit_insurance_flag is True.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure the business is willing to extend to this client account at any point in time, expressed in the profile currency. Used in contract terms negotiation and financial risk management.',
    `credit_limit_change_reason` STRING COMMENT 'Free-text explanation of the reason for the most recent change to the credit limit, such as improved payment history, new contract award, rating upgrade, or financial distress. Supports audit trail and governance requirements.',
    `credit_review_frequency` STRING COMMENT 'Frequency at which this client accounts credit profile is formally reviewed. triggered indicates review is event-driven (e.g., new contract award, overdue threshold breach) rather than calendar-based.. Valid values are `monthly|quarterly|semi_annual|annual|triggered`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit, overdue balance, and all monetary fields on this profile are denominated (e.g., USD, GBP, AED, AUD).. Valid values are `^[A-Z]{3}$`',
    `current_exposure_amount` DECIMAL(18,2) COMMENT 'Total current financial exposure to this client account, comprising all open invoices (billed but unpaid), unbilled certified work, and retention receivables. Used to assess utilisation against the approved credit limit.',
    `dso_days` DECIMAL(18,2) COMMENT 'Average number of days this client account takes to pay invoices, calculated over the trailing review period. DSO (Days Sales Outstanding) is a key accounts receivable metric used to assess payment behaviour and cash flow risk. Sourced from SAP S/4HANA AR aging analysis.',
    `effective_from_date` DATE COMMENT 'Date from which the current credit profile terms (credit limit, payment terms, rating) became effective. Supports temporal tracking of credit profile changes over time.',
    `effective_until_date` DATE COMMENT 'Date until which the current credit profile terms are valid. Null for open-ended profiles. Triggers a review workflow when the current date approaches this date.',
    `external_credit_rating` STRING COMMENT 'Credit rating assigned to the client by an external credit rating agency such as Dun & Bradstreet (D&B), Standard & Poors (S&P), Moodys, or Fitch. Examples: AAA, AA+, BBB-, Ba1, 5A1 (D&B PAYDEX). Null if no external rating is available.',
    `external_rating_agency` STRING COMMENT 'Name of the external credit rating agency that issued the external_credit_rating for this client account. Enables multi-agency comparison and source traceability.. Valid values are `dun_and_bradstreet|sp_global|moodys|fitch|coface|euler_hermes`',
    `external_rating_date` DATE COMMENT 'Date on which the external credit rating was issued or last confirmed by the rating agency. Used to assess the currency and relevance of the external rating.',
    `internal_credit_score` STRING COMMENT 'Internally calculated credit score assigned to this client account by the finance team, typically on a scale of 0–100 or 0–1000, reflecting payment history, financial strength, project delivery track record, and relationship context provided by Business Development (BD). Higher scores indicate lower credit risk.',
    `last_credit_review_date` DATE COMMENT 'Date on which the most recent formal credit review was completed by the finance team. Triggers periodic reassessment workflows and ensures credit profiles remain current.',
    `liquidated_damages_exposure_amount` DECIMAL(18,2) COMMENT 'Maximum financial exposure to Liquidated Damages (LD) that the client could apply against the business under active contracts, based on contractual LD rates and project delay risk. Informs credit risk and P&L exposure assessments.',
    `next_credit_review_date` DATE COMMENT 'Scheduled date for the next periodic credit review of this client account. Supports proactive credit management and ensures timely reassessment before contract renewals or new bid submissions.',
    `overdue_balance_amount` DECIMAL(18,2) COMMENT 'Total outstanding invoice balance that has exceeded the approved payment terms due date as of the last credit review or system refresh. A key indicator for credit hold decisions and risk escalation.',
    `payment_history_rating` STRING COMMENT 'Qualitative rating of the clients historical payment behaviour based on analysis of invoice settlement patterns, frequency of late payments, and dispute history. Derived from AR aging data in SAP S/4HANA and Viewpoint Vista.. Valid values are `excellent|good|satisfactory|poor|defaulted`',
    `payment_terms_days` STRING COMMENT 'Numeric representation of the approved payment terms expressed as the number of calendar days from invoice date to due date (e.g., 30 for net-30, 60 for net-60). Complements the approved_payment_terms field for precise DSO calculation and aging analysis.',
    `previous_credit_limit_amount` DECIMAL(18,2) COMMENT 'Credit limit that was in effect prior to the most recent credit review. Enables trend analysis and audit trail of credit limit changes over time.',
    `profile_reference_number` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this credit profile, used in correspondence with finance teams and credit agencies. Format: CP- followed by 6-12 alphanumeric characters.. Valid values are `^CP-[A-Z0-9]{6,12}$`',
    `profile_status` STRING COMMENT 'Current lifecycle status of the credit profile. active indicates normal trading terms apply; credit_hold indicates all new work or invoicing is blocked pending resolution of overdue balances or risk concerns; under_review indicates a periodic or triggered reassessment is in progress.. Valid values are `active|suspended|under_review|credit_hold|closed`',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each progress claim withheld by the client as retention money under the contract, typically released upon practical completion and expiry of the Defects Liability Period (DLP). Standard construction retention rates range from 5% to 10%.',
    `retention_release_terms` STRING COMMENT 'Terms governing when withheld retention money is released by the client. Common construction arrangements include 50% on practical completion and 50% on Defects Liability Period (DLP) expiry, or full release on a specific milestone.. Valid values are `on_practical_completion|on_dlp_expiry|split_50_50|on_milestone|negotiated`',
    `source_system` STRING COMMENT 'Operational system of record from which this credit profile data was sourced or last updated. Supports data lineage and reconciliation in the Databricks Silver Layer.. Valid values are `sap_s4hana|salesforce_crm|viewpoint_vista|manual`',
    `sovereign_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the sovereign government entity when sovereign_risk_flag is True. Used for country-level risk aggregation and geopolitical exposure reporting.. Valid values are `^[A-Z]{3}$`',
    `sovereign_risk_flag` BOOLEAN COMMENT 'Indicates whether this client account is a government entity or state-owned enterprise subject to sovereign risk considerations, including political risk, currency controls, and delayed payment due to public procurement cycles. True = sovereign/government client; False = private sector client.',
    `special_payment_arrangement_flag` BOOLEAN COMMENT 'Indicates whether a special payment arrangement has been agreed with this client account, such as a retention release schedule, milestone-based payment plan, advance payment structure, or deferred payment agreement. True = special arrangement in place; False = standard terms apply.',
    `special_payment_arrangement_notes` STRING COMMENT 'Free-text description of the specific terms of the special payment arrangement, including key milestones, retention percentages, release conditions, or deferred payment schedules agreed with the client.',
    `special_payment_arrangement_type` STRING COMMENT 'Type of special payment arrangement in place for this client account. Populated only when special_payment_arrangement_flag is True. Retention release schedules and milestone-based payments are standard in FIDIC and EPC contracts.. Valid values are `retention_release_schedule|milestone_based|advance_payment|deferred_payment|instalment_plan`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit profile record was last modified in the data platform. Supports change tracking, audit trail, and incremental data processing in the Databricks Silver Layer.',
    CONSTRAINT pk_account_credit_profile PRIMARY KEY(`account_credit_profile_id`)
) COMMENT 'Financial creditworthiness and payment behavior profile for each client account, supporting contract terms negotiation and financial risk management. Captures credit limit, approved payment terms (net 30/60/90), average payment days (DSO), overdue balance, external credit rating (D&B, S&P), internal credit score, last credit review date, payment history rating, credit hold status, special payment arrangements (retention release schedules, milestone-based payments), and sovereign risk indicator for government clients. Updated periodically by finance with input from BD for relationship context.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`framework_agreement` (
    `framework_agreement_id` BIGINT COMMENT 'Unique surrogate identifier for the framework agreement record in the lakehouse silver layer. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the client account (project owner, developer, or public-sector body) that is party to this framework agreement. Links to the client master product.',
    `client_opportunity_id` BIGINT COMMENT 'Reference to the originating opportunity record in Salesforce CRM from which this framework agreement was won. Enables traceability from bid pipeline to executed agreement for win-rate and revenue analytics.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: client_framework_agreement has a denormalized client_contact_name STRING field representing the primary client contact for the agreement. Normalizing this to a FK contact_id → contact.contact_id repla',
    `parent_agreement_client_framework_agreement_id` BIGINT COMMENT 'Self-referencing identifier linking a call-off contract or lot-level agreement to its parent framework agreement. Supports hierarchical agreement structures where individual call-offs are children of a master framework.',
    `agreement_number` STRING COMMENT 'Externally-known unique reference number assigned to the framework agreement, used in correspondence, call-off orders, and contract administration. Typically issued by the client or procurement authority (e.g., FA-2024-HWY-001).. Valid values are `^[A-Z0-9-]{3,30}$`',
    `agreement_type` STRING COMMENT 'Classification of the long-term agreement structure. framework = competitive framework with multiple call-offs; master_service_agreement (MSA) = pre-agreed terms for repeat services; term_contract = fixed-duration works contract; blanket_order = open purchase order for repeat supply; call_off_contract = individual release under a parent framework.. Valid values are `framework|master_service_agreement|term_contract|blanket_order|call_off_contract`',
    `ceiling_value` DECIMAL(18,2) COMMENT 'Maximum total monetary value of all call-off orders that may be placed under this framework agreement over its full term. Acts as the Guaranteed Maximum Price (GMP) envelope for the framework. Expressed in the agreement currency.',
    `client_framework_agreement_status` STRING COMMENT 'Current lifecycle state of the framework agreement. draft = being negotiated; active = in force and accepting call-offs; suspended = temporarily halted; expired = past expiry date with no renewal; terminated = ended early; under_renewal = renewal process initiated.. Valid values are `draft|active|suspended|expired|terminated|under_renewal`',
    `committed_value` DECIMAL(18,2) COMMENT 'Total value of all call-off orders formally issued against this framework agreement to date. Used to track utilisation against the ceiling value and support financial forecasting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary jurisdiction in which the framework agreement is executed and governed (e.g., GBR, USA, ARE).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the framework agreement record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the ceiling value, call-off values, and rates are denominated (e.g., USD, GBP, EUR, AED).. Valid values are `^[A-Z]{3}$`',
    `delivery_model` STRING COMMENT 'Contractual delivery model governing how works are executed under the framework. EPC = Engineering Procurement and Construction; DB = Design-Build; DBB = Design-Bid-Build; PPP = Public-Private Partnership; BOT = Build-Operate-Transfer; MSA = Master Service Agreement; term_maintenance = ongoing maintenance term. [ENUM-REF-CANDIDATE: EPC|DB|DBB|PPP|BOT|MSA|term_maintenance — 7 candidates stripped; promote to reference product]',
    `dispute_resolution_mechanism` STRING COMMENT 'Contractual mechanism for resolving disputes arising under the framework. dab = Dispute Adjudication Board (FIDIC); arbitration = binding arbitration; adjudication = statutory adjudication; litigation = court proceedings; mediation = non-binding mediation.. Valid values are `arbitration|adjudication|litigation|dab|mediation`',
    `duration_months` STRING COMMENT 'Total planned duration of the framework agreement in calendar months from effective date to expiry date. Used for scheduling, resource planning, and renewal forecasting.',
    `effective_date` DATE COMMENT 'Date on which the framework agreement becomes legally binding and call-offs may commence. Equivalent to the Notice to Proceed (NTP) date for the framework.',
    `expiry_date` DATE COMMENT 'Date on which the framework agreement is scheduled to expire and no further call-offs may be issued, unless an extension option is exercised.',
    `extension_duration_months` STRING COMMENT 'Duration in calendar months of each individual extension option. Combined with extension_options to determine the maximum possible agreement term.',
    `extension_options` STRING COMMENT 'Number of contractual extension options available to the client to extend the framework agreement beyond the original expiry date (e.g., 2 options of 12 months each).',
    `framework_lot` STRING COMMENT 'Lot or package designation within a multi-lot framework agreement (e.g., Lot 1 – Civils, Lot 2 – MEP, Lot 3 – Highways). Applicable where the client has structured the framework into distinct work categories.',
    `geographic_region` STRING COMMENT 'Geographic region or territory within which works under this framework agreement are to be executed (e.g., Northern England, Gulf Region, Southeast Asia). Used for resource planning and regional P&L reporting.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law under which the framework agreement is interpreted and enforced (e.g., English Law, New York State Law, UAE Federal Law). Critical for dispute resolution and contract administration.',
    `hse_requirements` STRING COMMENT 'Summary of Health, Safety and Environment (HSE) obligations and standards mandated under the framework agreement, such as OSHA compliance, ISO 45001 certification, SWMS submission, and minimum PPE standards.',
    `incentive_mechanism` STRING COMMENT 'Description of any pain/gain share, bonus, or incentive fee mechanism embedded in the framework agreement to reward performance above KPI thresholds or penalise underperformance.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether specific insurance requirements (e.g., professional indemnity, public liability, contractors all-risk) are mandated under the framework agreement terms.',
    `kpi_description` STRING COMMENT 'Narrative description of the performance KPIs defined in the framework agreement against which the contractors performance will be measured across call-off orders (e.g., on-time delivery rate, defect rate, TRIR, CPI thresholds).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the framework agreement record was most recently modified. Supports incremental data loading in the Databricks lakehouse silver layer and change data capture.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Pre-agreed daily or weekly Liquidated Damages (LD) rate applicable per call-off order for delay beyond the agreed completion date. Expressed in the agreement currency per day.',
    `max_calloff_value` DECIMAL(18,2) COMMENT 'Maximum monetary value of a single call-off order permitted under this framework agreement without triggering a mini-competition or additional approval. Supports procurement governance.',
    `min_calloff_value` DECIMAL(18,2) COMMENT 'Minimum monetary value of an individual call-off order that may be placed under this framework agreement. Ensures commercial viability of individual work packages.',
    `payment_terms` STRING COMMENT 'Pre-agreed payment terms applicable to all call-off orders under this framework (e.g., Net 30 days from certified invoice, Monthly progress payment, Milestone-based). Governs accounts receivable and cash flow forecasting.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond or parent company guarantee is required from the contractor for call-off orders placed under this framework agreement.',
    `procurement_route` STRING COMMENT 'Mechanism by which individual call-off orders are awarded under the framework. direct_award = awarded without further competition; mini_competition = secondary competition among framework members; competitive_tender = full re-tender; negotiated = negotiated with incumbent.. Valid values are `direct_award|mini_competition|competitive_tender|negotiated`',
    `quality_standard` STRING COMMENT 'Quality management standard or certification required of the contractor under the framework agreement (e.g., ISO 9001:2015, LEED Gold, ITP compliance). Supports QA/QC governance.',
    `renewal_notice_days` STRING COMMENT 'Number of calendar days prior to expiry by which either party must serve notice of intent to renew or extend the framework agreement. Triggers CRM pipeline renewal workflow.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each certified payment withheld as retention money under call-off orders, to be released upon satisfactory completion and expiry of the Defects Liability Period (DLP). Standard construction contract retention mechanism.',
    `scope_description` STRING COMMENT 'Narrative description of the categories of works, services, or supply covered by the framework agreement (e.g., Highway maintenance, resurfacing, and drainage works across the Northern Region).',
    `sector` STRING COMMENT 'Industry sector of the client commissioning the framework, used for client segmentation and pipeline analytics. Distinguishes public-sector (government agencies, highways authorities), private-sector developers, PPP/BOT sponsors, and utilities clients. [ENUM-REF-CANDIDATE: public|private|ppp|utilities|defence|transport|energy|residential|commercial — promote to reference product]',
    `signed_date` DATE COMMENT 'Date on which the framework agreement was formally executed (signed by all parties). May precede the effective date if there is a mobilisation period.',
    `termination_date` DATE COMMENT 'Actual date on which the framework agreement was terminated early, if applicable. Null if the agreement expired naturally or is still active.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the framework agreement. client_default = client failed to meet obligations; contractor_default = contractor breach; mutual_agreement = both parties agreed; force_majeure = unforeseeable event; regulatory = regulatory or legal requirement; convenience = termination for convenience by client.. Valid values are `client_default|contractor_default|mutual_agreement|force_majeure|regulatory|convenience`',
    `title` STRING COMMENT 'Full descriptive title of the framework agreement as stated in the executed contract document (e.g., National Highways Maintenance Framework 2024–2028).',
    CONSTRAINT pk_framework_agreement PRIMARY KEY(`framework_agreement_id`)
) COMMENT 'Long-term framework agreements, master service agreements (MSA), or term contracts established with repeat clients, defining pre-agreed rates, scope categories, KPIs, and call-off procedures for multiple projects over a defined period. Captures agreement title, client account, agreement type (framework, MSA, term contract, blanket order), effective date, expiry date, total ceiling value, call-off mechanism, performance KPIs, renewal terms, and extension options. Common with public-sector clients (e.g., highways agencies, utilities) who procure repeat works under a single competitive framework.';

CREATE OR REPLACE TABLE `construction_ecm`.`client`.`jv_participant` (
    `jv_participant_id` BIGINT COMMENT 'Primary key for the jv_participant association',
    `account_id` BIGINT COMMENT 'Foreign key linking to the participating client account entity',
    `jv_structure_id` BIGINT COMMENT 'Foreign key linking to the Joint Venture structure in which the account participates',
    `committed_capital_amount` DECIMAL(18,2) COMMENT 'The total capital amount this account has committed to contribute to the JV, as defined in the JV agreement. Specific to each participants obligation within the JV.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the committed_capital_amount. Required because JV participants may commit capital in different currencies in cross-border JV structures.',
    `equity_percentage` DECIMAL(18,2) COMMENT 'The percentage equity stake held by this account in the JV structure. Belongs to the participation record, not to the account or JV structure alone, as each participant holds a distinct share.',
    `exit_date` DATE COMMENT 'The date on which this account exited or is contractually scheduled to exit the JV. Null if the participant remains active through JV dissolution.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this account is currently an active participant in the JV. Set to false when exit_date is reached or participation is formally terminated.',
    `join_date` DATE COMMENT 'The date on which this account formally joined the JV as a participating entity, as executed in the JV agreement or a subsequent accession deed.',
    `participation_role` STRING COMMENT 'The governance and operational role this account holds within the JV structure. Determines voting rights, management responsibilities, and liability exposure.',
    CONSTRAINT pk_jv_participant PRIMARY KEY(`jv_participant_id`)
) COMMENT 'This association product represents the Participation role between account and jv_structure. It captures each client entitys formal membership in a Joint Venture arrangement, including their equity stake, committed capital, governance role, and tenure dates. Each record links one account to one jv_structure with attributes that exist only in the context of that specific participation — data that cannot reside on either the account or the JV structure alone.. Existence Justification: In construction, Joint Ventures are co-ownership vehicles where multiple client entities (accounts) simultaneously participate as equity partners in a single JV structure. A single account (e.g., a large infrastructure developer) can participate in multiple JV structures across different projects, and a single JV structure by definition has multiple participating accounts. The current model only captures the lead sponsor via primary_jv_account_id on jv_structure, leaving all non-lead participants entirely unmodelled — a fundamental gap in the business model.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`client`.`account` ADD CONSTRAINT `fk_client_account_parent_account_id` FOREIGN KEY (`parent_account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`account` ADD CONSTRAINT `fk_client_account_primary_ultimate_parent_account_id` FOREIGN KEY (`primary_ultimate_parent_account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_address_id` FOREIGN KEY (`address_id`) REFERENCES `construction_ecm`.`client`.`address`(`address_id`);
ALTER TABLE `construction_ecm`.`client`.`contact` ADD CONSTRAINT `fk_client_contact_reports_to_contact_id` FOREIGN KEY (`reports_to_contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`client`.`address` ADD CONSTRAINT `fk_client_address_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ADD CONSTRAINT `fk_client_client_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_rfp_issuance_id` FOREIGN KEY (`rfp_issuance_id`) REFERENCES `construction_ecm`.`client`.`rfp_issuance`(`rfp_issuance_id`);
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ADD CONSTRAINT `fk_client_rfp_issuance_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ADD CONSTRAINT `fk_client_account_credit_profile_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ADD CONSTRAINT `fk_client_framework_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ADD CONSTRAINT `fk_client_framework_agreement_client_opportunity_id` FOREIGN KEY (`client_opportunity_id`) REFERENCES `construction_ecm`.`client`.`client_opportunity`(`client_opportunity_id`);
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ADD CONSTRAINT `fk_client_framework_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `construction_ecm`.`client`.`contact`(`contact_id`);
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ADD CONSTRAINT `fk_client_framework_agreement_parent_agreement_client_framework_agreement_id` FOREIGN KEY (`parent_agreement_client_framework_agreement_id`) REFERENCES `construction_ecm`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ADD CONSTRAINT `fk_client_jv_participant_account_id` FOREIGN KEY (`account_id`) REFERENCES `construction_ecm`.`client`.`account`(`account_id`);
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ADD CONSTRAINT `fk_client_jv_participant_jv_structure_id` FOREIGN KEY (`jv_structure_id`) REFERENCES `construction_ecm`.`client`.`jv_structure`(`jv_structure_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`client` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `construction_ecm`.`client` SET TAGS ('dbx_domain' = 'client');
ALTER TABLE `construction_ecm`.`client`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`client`.`account` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account ID');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_ultimate_parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Account ID');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|prospect|suspended|blacklisted|archived');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'public_sector|private_sector|government_body|corporate_sponsor|jv_entity|ppp_authority');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `billing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `bim_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Requirement Level');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `bim_requirement_level` SET TAGS ('dbx_value_regex' = 'none|bim_level_1|bim_level_2|bim_level_3');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `client_tier` SET TAGS ('dbx_business_glossary_term' = 'Client Tier');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `client_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|strategic');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `crm_account_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Account ID');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `eot_policy` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Policy');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `eot_policy` SET TAGS ('dbx_value_regex' = 'standard|strict|flexible');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `hse_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Compliance Required Flag');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `industry_sector` SET TAGS ('dbx_business_glossary_term' = 'Industry Sector');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `is_jv_entity` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Entity Flag');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `last_project_award_date` SET TAGS ('dbx_business_glossary_term' = 'Last Project Award Date');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `ld_clause_standard` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Clause Standard');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `ld_clause_standard` SET TAGS ('dbx_value_regex' = 'yes|no|negotiable');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Required Flag');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `ntp_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Authority Level');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `preferred_contract_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contract Type');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'approved|pending|expired|rejected');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `registered_address` SET TAGS ('dbx_business_glossary_term' = 'Registered Address');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `registered_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `registered_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `construction_ecm`.`client`.`account` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[^s/$.?#].[^s]*$');
ALTER TABLE `construction_ecm`.`client`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`client`.`contact` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `reports_to_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Contact ID');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `account_manager` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_business_glossary_term' = 'Contact Date of Birth');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `birthdate` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `client_segment` SET TAGS ('dbx_business_glossary_term' = 'Client Segment');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `client_segment` SET TAGS ('dbx_value_regex' = 'public_sector|private_sector|ppp|bot|jv');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|do_not_contact');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'owner|technical|procurement|legal|executive|financial');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `crm_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Contact ID');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `data_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Date');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `data_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Consent Status');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `data_consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending|not_required');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `decision_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Decision-Making Authority Level');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `decision_authority_level` SET TAGS ('dbx_value_regex' = 'strategic|operational|advisory|none');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Flag');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Email Address');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-Out Flag');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `email_opt_out` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `influence_score` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Influence Score');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Flag');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `is_executive_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Flag');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `last_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meeting Date');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_business_glossary_term' = 'Contact LinkedIn Profile URL');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_value_regex' = '^https://(www.)?linkedin.com/in/[a-zA-Z0-9-_%]+/?$');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `linkedin_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Phone Number');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `mobile_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Primary Phone Number');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|video_call|in_person|portal');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_business_glossary_term' = 'Relationship Health Indicator');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_value_regex' = 'strong|good|neutral|at_risk|poor');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `relationship_health` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Contact Salutation');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr.|Ms.|Mrs.|Dr.|Prof.');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Contact Source');
ALTER TABLE `construction_ecm`.`client`.`contact` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'crm|referral|conference|rfp|website|partner');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Structure ID');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `tender_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `aconex_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Aconex Document ID');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `client_segment` SET TAGS ('dbx_business_glossary_term' = 'Client Segment');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `client_segment` SET TAGS ('dbx_value_regex' = 'public_sector|private_sector|PPP|BOT|government');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `country_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Country of Operation');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `country_of_operation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'JV Currency Code');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|mediation|DAB|expert_determination');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Dissolution Date');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Formation Date');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Country');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `governing_law_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `is_lead_sponsor_internal` SET TAGS ('dbx_business_glossary_term' = 'Is Lead Sponsor Internal Flag');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Agreement Reference');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_agreement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Manager Email');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Manager Name');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Manager Phone');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_name` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Name');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Reference Number');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_reference_number` SET TAGS ('dbx_value_regex' = '^JV-[A-Z0-9]{4,20}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_short_name` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Short Name');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Status');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_status` SET TAGS ('dbx_value_regex' = 'active|pending|dissolved|suspended|formation');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_type` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Type');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `jv_type` SET TAGS ('dbx_value_regex' = 'PPP|BOT|Consortium|Incorporated|Unincorporated|EPC');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Target');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `leed_certification_target` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum|none');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `liability_structure` SET TAGS ('dbx_business_glossary_term' = 'JV Liability Structure');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `liability_structure` SET TAGS ('dbx_value_regex' = 'joint_and_several|several_only|limited|proportional');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `liability_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `management_structure_type` SET TAGS ('dbx_business_glossary_term' = 'JV Management Structure Type');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `management_structure_type` SET TAGS ('dbx_value_regex' = 'board|management_committee|single_manager|co_management');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'JV Structure Notes');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'JV Participant Count');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `profit_sharing_basis` SET TAGS ('dbx_business_glossary_term' = 'Profit Sharing Basis');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `profit_sharing_basis` SET TAGS ('dbx_value_regex' = 'equity_proportional|equal_share|negotiated|cost_plus');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `profit_sharing_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `project_sector` SET TAGS ('dbx_business_glossary_term' = 'Project Sector');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `project_sector` SET TAGS ('dbx_value_regex' = 'infrastructure|energy|commercial|residential|industrial|transport');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `registration_country` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Registration Country');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `registration_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Registration Number');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce|Aconex|SAP_S4HANA|Procore|Manual');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `total_committed_capital` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Capital');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `total_committed_capital` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `total_equity_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Equity Percentage');
ALTER TABLE `construction_ecm`.`client`.`jv_structure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`client`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`client`.`address` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Client Address ID');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_validation|superseded|undeliverable');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'registered_office|billing|correspondence|project_site_liaison|head_office|branch_office');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `attention_to` SET TAGS ('dbx_business_glossary_term' = 'Attention To (Addressee)');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `attention_to` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `attention_to` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_business_glossary_term' = 'Building Name');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `building_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Country Name');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective From Date');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective To Date');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Address Email Address');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Address Fax Number');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_business_glossary_term' = 'Address Format Type');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `format_type` SET TAGS ('dbx_value_regex' = 'western|eastern|po_box|free_form');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Indicator');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `is_billing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Indicator');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `is_registered_office` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Indicator');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}-[A-Z0-9]{1,6}$');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (GIS Coordinate)');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (GIS Coordinate)');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Address Notes');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Address Phone Number');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `po_box_number` SET TAGS ('dbx_business_glossary_term' = 'Post Office (PO) Box Number');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `po_box_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `po_box_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `preferred_correspondence_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Correspondence Language');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `preferred_correspondence_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_crm|sap_s4hana|procore|manual|aconex|other');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Address ID');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `source_system_address_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State / Province');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `suite_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Suite / Unit Number');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `suite_unit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `suite_unit_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Date');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Source');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `construction_ecm`.`client`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|not_validated|failed|partial');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` SET TAGS ('dbx_subdomain' = 'commercial_engagement');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Client Opportunity ID');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Opportunity Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `actual_award_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Award Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Bid Cost Estimate');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_no_bid_decision` SET TAGS ('dbx_business_glossary_term' = 'Bid / No-Bid Decision');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_no_bid_decision` SET TAGS ('dbx_value_regex' = 'bid|no_bid|pending_review');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_no_bid_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Bid / No-Bid Decision Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bid_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `bim_required` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Required Flag');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `boq_available` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Available Flag');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `client_opportunity_description` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Description');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `competitor_names` SET TAGS ('dbx_business_glossary_term' = 'Competitor Names');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `competitor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `esg_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Requirements');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `expected_award_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Award Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `expected_ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Notice to Proceed (NTP) Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `is_jv_bid` SET TAGS ('dbx_business_glossary_term' = 'Is Joint Venture (JV) Bid Flag');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `jv_partner_names` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Names');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `jv_partner_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Required Flag');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `next_action` SET TAGS ('dbx_business_glossary_term' = 'Next BD Action');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next BD Action Due Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_value_regex' = '^OPP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `opportunity_status` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Status');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `opportunity_status` SET TAGS ('dbx_value_regex' = 'open|closed_won|closed_lost|on_hold|cancelled');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Stage');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `probability_of_win_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability of Win Percentage');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `project_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project Duration (Months)');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `project_location_country` SET TAGS ('dbx_business_glossary_term' = 'Project Location Country');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `project_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `project_location_region` SET TAGS ('dbx_business_glossary_term' = 'Project Location Region / State');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `rfp_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Issue Date');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) / RFP Number');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `sector` SET TAGS ('dbx_value_regex' = 'public|private|ppp_bot');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `source_crm_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Source CRM Opportunity ID');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Tier');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Pipeline Value');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `weighted_pipeline_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_business_glossary_term' = 'Win / Loss Outcome');
ALTER TABLE `construction_ecm`.`client`.`client_opportunity` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|withdrawn|no_award');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` SET TAGS ('dbx_subdomain' = 'commercial_engagement');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `project_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Project Engagement ID');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Representative ID');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Framework Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Issuance Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `approved_variation_value` SET TAGS ('dbx_business_glossary_term' = 'Approved Variation Value');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `approved_variation_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `bid_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Reference Number');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `bim_required` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Required');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `client_role` SET TAGS ('dbx_business_glossary_term' = 'Client Role');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `client_role` SET TAGS ('dbx_value_regex' = 'owner|co_sponsor|jv_lead|funding_agency|end_user|developer');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|aconex|portal|formal_letter|meeting');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contract_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|notice_issued|negotiation|adjudication|arbitration|resolved');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `dispute_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `dlp_end_date` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) End Date');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Reference Number');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-ENG-[0-9]{4,10}$');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'active|pending|on_hold|completed|terminated|cancelled');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `eot_days_granted` SET TAGS ('dbx_business_glossary_term' = 'Extension of Time (EOT) Days Granted');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `handover_date` SET TAGS ('dbx_business_glossary_term' = 'Project Handover Date');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `hse_requirements_classification` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements Classification');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `hse_requirements_classification` SET TAGS ('dbx_value_regex' = 'standard|enhanced|critical');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `insurance_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Insurance Compliance Verified');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `jv_participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Participation Percentage');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `jv_participation_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) Certification Required');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Rate');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'open_tender|selective_tender|direct_negotiation|rfp|rfq|framework_call_off');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Client Relationship Tier');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|standard|transactional');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `repeat_client` SET TAGS ('dbx_business_glossary_term' = 'Repeat Client Indicator');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Client Reporting Frequency');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|fortnightly|monthly|quarterly|milestone_based');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Score');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `satisfaction_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Survey Date');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector');
ALTER TABLE `construction_ecm`.`client`.`project_engagement` ALTER COLUMN `sector` SET TAGS ('dbx_value_regex' = 'public|private|ppp');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` SET TAGS ('dbx_subdomain' = 'commercial_engagement');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `rfp_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Issuance ID');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Client Framework Agreement Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `addendum_count` SET TAGS ('dbx_business_glossary_term' = 'RFP Addendum Count');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `anticipated_award_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Contract Award Date');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `anticipated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Project Completion Date');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `anticipated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Project Start Date');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `bid_bond_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Percentage');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `bid_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required Flag');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `bid_validity_days` SET TAGS ('dbx_business_glossary_term' = 'Bid Validity Period in Days');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `bim_level` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Level');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `bim_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `bim_required` SET TAGS ('dbx_business_glossary_term' = 'Building Information Modeling (BIM) Required Flag');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `client_sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector Classification');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `client_sector` SET TAGS ('dbx_value_regex' = 'public|private|ppp|jv');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `commercial_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Commercial Score Weight Percentage');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_rate|cost_plus|target_cost|framework');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Project Country Code');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `defects_liability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Defects Liability Period (DLP) in Days');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Project Delivery Model');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Contract Value');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `estimated_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Bid Evaluation Criteria Method');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_value_regex' = 'price_only|price_quality|quality_only|best_value|pass_fail');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'RFP Issue Date');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFP Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFP Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `latest_addendum_date` SET TAGS ('dbx_business_glossary_term' = 'Latest RFP Addendum Date');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Level');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `leed_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `leed_certification_required` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Required Flag');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `liquidated_damages_applicable` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Applicable Flag');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Daily Rate');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `local_content_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Local Content Requirement Percentage');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `performance_bond_percentage` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Percentage');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `pre_bid_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Meeting Date');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `pre_bid_meeting_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Pre-Bid Meeting Mandatory Flag');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Scope Description');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `project_location` SET TAGS ('dbx_business_glossary_term' = 'Project Location');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `project_sector` SET TAGS ('dbx_business_glossary_term' = 'Project Sector');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `project_title` SET TAGS ('dbx_business_glossary_term' = 'Project Title');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `rfp_document_reference` SET TAGS ('dbx_business_glossary_term' = 'RFP Document Reference');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `rfp_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Reference Number');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `rfp_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-/]{3,50}$');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `rfp_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Proposal (RFP) Status');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `rfp_status` SET TAGS ('dbx_value_regex' = 'draft|issued|amended|closed|cancelled|awarded');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Type');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_value_regex' = 'RFP|RFQ|ITT|EOI|RFI');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Deadline');
ALTER TABLE `construction_ecm`.`client`.`rfp_issuance` ALTER COLUMN `technical_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Technical Score Weight Percentage');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` SET TAGS ('dbx_subdomain' = 'commercial_engagement');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `account_credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Profile ID');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `approved_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Approved Payment Terms');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `approved_payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|milestone_based|retention_release');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `approved_payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `bd_relationship_context` SET TAGS ('dbx_business_glossary_term' = 'Business Development (BD) Relationship Context');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `bd_relationship_context` SET TAGS ('dbx_value_regex' = 'strategic_key_account|preferred_client|standard|new_client|at_risk|dormant');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `bd_relationship_context` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `client_segment` SET TAGS ('dbx_business_glossary_term' = 'Client Segment');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Approved Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_hold_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_value_regex' = 'overdue_balance|credit_limit_exceeded|rating_downgrade|legal_dispute|insolvency_risk|manual_hold');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_insurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Flag');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_insurance_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Limit Amount');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_insurance_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Provider');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_limit_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Change Reason');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_limit_change_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Frequency');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `credit_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|triggered');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `current_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Credit Exposure Amount');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `current_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `dso_days` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO) Days');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `dso_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Effective From Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Effective Until Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating Agency');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_value_regex' = 'dun_and_bradstreet|sp_global|moodys|fitch|coface|euler_hermes');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `external_rating_date` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `internal_credit_score` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Score');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `internal_credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `last_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `liquidated_damages_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Exposure Amount');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `liquidated_damages_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `overdue_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Balance Amount');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `overdue_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `payment_history_rating` SET TAGS ('dbx_business_glossary_term' = 'Payment History Rating');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `payment_history_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|poor|defaulted');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `previous_credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Credit Limit Amount');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `previous_credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `profile_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Reference Number');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `profile_reference_number` SET TAGS ('dbx_value_regex' = '^CP-[A-Z0-9]{6,12}$');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `profile_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|suspended|under_review|credit_hold|closed');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `retention_release_terms` SET TAGS ('dbx_business_glossary_term' = 'Retention Release Terms');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `retention_release_terms` SET TAGS ('dbx_value_regex' = 'on_practical_completion|on_dlp_expiry|split_50_50|on_milestone|negotiated');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `retention_release_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_s4hana|salesforce_crm|viewpoint_vista|manual');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `sovereign_country_code` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Country Code');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `sovereign_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `sovereign_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Risk Flag');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `special_payment_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Payment Arrangement Flag');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `special_payment_arrangement_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Payment Arrangement Notes');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `special_payment_arrangement_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `special_payment_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Special Payment Arrangement Type');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `special_payment_arrangement_type` SET TAGS ('dbx_value_regex' = 'retention_release_schedule|milestone_based|advance_payment|deferred_payment|instalment_plan');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `special_payment_arrangement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`account_credit_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` SET TAGS ('dbx_subdomain' = 'commercial_engagement');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement ID');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `client_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'CRM Opportunity ID');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `parent_agreement_client_framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Agreement ID');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Number');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Type');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'framework|master_service_agreement|term_contract|blanket_order|call_off_contract');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `ceiling_value` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Value');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `ceiling_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `client_framework_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Status');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `client_framework_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|under_renewal');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `committed_value` SET TAGS ('dbx_business_glossary_term' = 'Committed Value');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `committed_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `delivery_model` SET TAGS ('dbx_business_glossary_term' = 'Delivery Model');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|adjudication|litigation|dab|mediation');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Agreement Duration (Months)');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `extension_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Extension Duration Per Option (Months)');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `extension_options` SET TAGS ('dbx_business_glossary_term' = 'Extension Options (Count)');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `framework_lot` SET TAGS ('dbx_business_glossary_term' = 'Framework Lot');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `incentive_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Incentive Mechanism');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `kpi_description` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicator (KPI) Description');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages (LD) Rate');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `max_calloff_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Call-Off Value');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `max_calloff_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `min_calloff_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Call-Off Value');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `min_calloff_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `procurement_route` SET TAGS ('dbx_business_glossary_term' = 'Procurement Route');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `procurement_route` SET TAGS ('dbx_value_regex' = 'direct_award|mini_competition|competitive_tender|negotiated');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Client Sector');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'client_default|contractor_default|mutual_agreement|force_majeure|regulatory|convenience');
ALTER TABLE `construction_ecm`.`client`.`framework_agreement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Title');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` SET TAGS ('dbx_subdomain' = 'account_identity');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` SET TAGS ('dbx_association_edges' = 'client.account,client.jv_structure');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `jv_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Participant - Jv Participant Id');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Participant - Account Id');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `jv_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Jv Participant - Jv Structure Id');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `committed_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Capital Amount');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `committed_capital_amount` SET TAGS ('dbx_financial_sensitive' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Committed Capital Currency');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `equity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Equity Percentage');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `equity_percentage` SET TAGS ('dbx_financial_sensitive' = 'true');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `exit_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Date');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Participant');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `join_date` SET TAGS ('dbx_business_glossary_term' = 'Join Date');
ALTER TABLE `construction_ecm`.`client`.`jv_participant` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
