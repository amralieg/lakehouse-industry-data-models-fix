-- Schema for Domain: correspondence | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`correspondence` COMMENT 'Manages all policyholder and stakeholder communications including inbound/outbound letters, emails, call center interactions, complaint tracking, and service correspondence across all channels. Owns communication templates, delivery tracking, and regulatory correspondence requirements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`communication` (
    `communication_id` BIGINT COMMENT 'Unique identifier for each discrete communication artifact. Primary key for the communication product.',
    `annuity_contract_id` BIGINT COMMENT 'Reference to the annuity contract associated with this communication, if applicable. Links communication to the annuity context.',
    `bulk_comm_campaign_id` BIGINT COMMENT 'Foreign key linking to correspondence.bulk_comm_campaign. Business justification: Link communication to bulk campaign if generated as part of campaign. Essential for campaign tracking and bulk communication management.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link communication to channel master. Replaces STRING channel code with FK to comm_channel for proper channel tracking and analytics.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group sponsor communications (enrollment kits, rate renewal notices, plan administration updates, aggregate reporting) are distinct from individual member communications. Supports sponsor relationship',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this communication, if applicable. Links communication to the policy context.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder or customer who is the primary party for this communication.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Customer communications reference specific product plans for policy inquiries, service requests, and regulatory notices. Plan context is essential for accurate response, compliance with plan-specific ',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable product and separate account customer inquiries, performance questions, and fund transfer requests require portfolio context. Service representatives need portfolio details to respond to inve',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Communications (policy delivery emails, claim decision letters, underwriting requirement requests) reference a primary formal document (policy contract PDF, claim denial letter, APS request form). Cor',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer associated with this communication. Links communication to the distribution channel.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Communications frequently address rider elections, modifications, or benefit explanations. Rider-specific correspondence requires linkage for accurate servicing, compliance with rider-specific disclos',
    `reply_to_communication_id` BIGINT COMMENT 'Self-referencing FK on communication (reply_to_communication_id)',
    `attachment_count` STRING COMMENT 'Number of attachments included with this communication (e.g., policy documents, claim forms, tax forms).',
    `body_text` STRING COMMENT 'Full text content of the communication message. For structured communications, this may contain the rendered template output.',
    `communication_category` STRING COMMENT 'Business classification of the communication purpose (e.g., billing notice, policy change confirmation, regulatory disclosure, complaint acknowledgment, claim status update, underwriting request). [ENUM-REF-CANDIDATE: billing_notice|policy_change_confirmation|regulatory_disclosure|complaint_acknowledgment|claim_status_update|underwriting_request|premium_reminder|lapse_notice|reinstatement_confirmation|beneficiary_change_confirmation|surrender_confirmation|loan_statement|dividend_notice|annual_statement|tax_form|marketing_communication — promote to reference product]',
    `communication_number` STRING COMMENT 'Business-facing unique reference number for this communication. Used for tracking and customer service inquiries.',
    `communication_status` STRING COMMENT 'Current lifecycle status of the communication (draft, pending, sent, delivered, failed, bounced, read). [ENUM-REF-CANDIDATE: draft|pending|sent|delivered|failed|bounced|read — 7 candidates stripped; promote to reference product]',
    `complaint_category` STRING COMMENT 'Classification of the complaint type if this is a complaint communication (e.g., claim handling, premium billing, policy servicing, agent conduct). Null if not a complaint.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this communication record was first created in the system. Audit trail for record creation.',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was successfully delivered to the recipient system or mailbox. Used for delivery tracking and audit.',
    `delivery_failure_reason` STRING COMMENT 'Description of why the communication delivery failed (e.g., invalid email address, mailbox full, address undeliverable). Populated when status is failed or bounced.',
    `direction` STRING COMMENT 'Indicates whether the communication was received from a stakeholder (inbound) or sent by the company (outbound).. Valid values are `inbound|outbound`',
    `is_complaint` BOOLEAN COMMENT 'Indicates whether this communication is classified as a customer complaint requiring tracking and reporting per NAIC Market Conduct standards.',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this communication is mandated by regulatory requirements (e.g., NAIC disclosure, state insurance department notice, FINRA communication for variable products).',
    `language_code` STRING COMMENT 'Two-letter ISO language code indicating the language in which the communication was composed (e.g., en for English, es for Spanish, fr for French).. Valid values are `^[a-z]{2}$`',
    `priority` STRING COMMENT 'Business priority assigned to the communication (low, normal, high, urgent). Determines handling and response time requirements.. Valid values are `low|normal|high|urgent`',
    `read_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was opened or read by the recipient. Available for email and secure message channels with read receipt capability.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when an inbound communication was received by the company. Principal business event timestamp for inbound communications.',
    `recipient_address_line1` STRING COMMENT 'First line of the recipient mailing address for letter-based communications.',
    `recipient_address_line2` STRING COMMENT 'Second line of the recipient mailing address (suite, apartment, etc.) for letter-based communications.',
    `recipient_city` STRING COMMENT 'City of the recipient mailing address for letter-based communications.',
    `recipient_country_code` STRING COMMENT 'Three-letter ISO country code of the recipient mailing address (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
    `recipient_email` STRING COMMENT 'Email address of the recipient. For outbound communications, this is the stakeholder email; for inbound, this is the company email address.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Name of the individual or entity who received the communication (for outbound) or the internal recipient (for inbound).',
    `recipient_phone` STRING COMMENT 'Phone number of the recipient for SMS or phone-based communications.',
    `recipient_postal_code` STRING COMMENT 'Postal code or ZIP code of the recipient mailing address for letter-based communications.',
    `recipient_state` STRING COMMENT 'State or province of the recipient mailing address for letter-based communications.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory requirement or rule that mandates this communication (e.g., NAIC Model Regulation section, state insurance code citation).',
    `response_due_date` DATE COMMENT 'Date by which a response to this communication is required. Used for tracking Service Level Agreement (SLA) compliance and regulatory response timeframes.',
    `response_received_date` DATE COMMENT 'Date when a response to this communication was received. Used for measuring response time and SLA compliance.',
    `sender_email` STRING COMMENT 'Email address of the sender. For inbound communications, this is the stakeholder email; for outbound, this is the company email address used.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Name of the individual or department that sent the communication (for outbound) or the name of the sender (for inbound).',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was sent or transmitted. Principal business event timestamp for outbound communications.',
    `subject` STRING COMMENT 'The subject line or title of the communication. Provides a brief summary of the communication content.',
    `template_code` STRING COMMENT 'Code identifying the standard template used to generate this communication. Links to the template library for content governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this communication record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_communication PRIMARY KEY(`communication_id`)
) COMMENT 'Master record for every individual communication item — inbound or outbound — across all channels (letter, email, fax, secure message, SMS) managed by the correspondence domain. Serves as the SSOT for communication identity, direction, channel, subject, status, and lifecycle. Each record represents one discrete communication artifact tied to a policyholder, agent, claimant, or other stakeholder. Captures originating business context (policy, claim, application), communication category (billing notice, policy change confirmation, regulatory disclosure, complaint acknowledgment), priority, and current delivery status.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`comm_template` (
    `comm_template_id` BIGINT COMMENT 'Unique identifier for the communication template. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit trail requirement: track which employee created each communication template for SOX compliance, regulatory review workflows, and template governance. Standard pattern missing from this product w',
    `master_comm_template_id` BIGINT COMMENT 'Self-referencing FK on comm_template (master_comm_template_id)',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether the template meets accessibility standards (e.g., WCAG 2.1 for digital communications, large print availability for letters) to accommodate policyholders with disabilities per Americans with Disabilities Act (ADA).',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the template for active use. NULL if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the template was approved for active use. NULL if not yet approved.',
    `attachment_required` BOOLEAN COMMENT 'Indicates whether this template requires accompanying attachments (e.g., policy documents, claim forms, disclosure statements).',
    `attachment_type_list` STRING COMMENT 'Comma-separated list of required attachment types (e.g., policy_contract, disclosure_form, claim_form, beneficiary_form). NULL if no attachments required.',
    `business_trigger` STRING COMMENT 'Business event or condition that activates this template (e.g., policy lapse, premium due, beneficiary change, claim approval, complaint received, underwriting decision).',
    `communication_channel` STRING COMMENT 'Delivery channel for which this template is designed (letter, email, SMS, secure portal, fax, IVR).. Valid values are `letter|email|sms|secure_portal|fax|ivr`',
    `compliance_review_date` DATE COMMENT 'Date when compliance review was completed and approval granted.',
    `compliance_review_status` STRING COMMENT 'Status of compliance department review to ensure adherence to NAIC model regulations, Anti-Money Laundering (AML), Know Your Customer (KYC), and other regulatory frameworks.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the template record was first created in the system.',
    `delivery_method` STRING COMMENT 'Specific delivery method within the channel (e.g., standard mail, certified mail, registered mail, electronic delivery, secure portal). Relevant for regulatory and legal notice requirements.. Valid values are `standard|certified|registered|electronic|secure`',
    `effective_date` DATE COMMENT 'Date when the template becomes active and available for use in generating policyholder and stakeholder correspondence.',
    `expiration_date` DATE COMMENT 'Date when the template is no longer valid for use. NULL indicates no expiration (template remains active until explicitly retired).',
    `jurisdiction_code` STRING COMMENT 'Two-letter state or jurisdiction code (e.g., CA, NY, TX) for state-specific template variants required by Department of Insurance (DOI) regulations. NULL indicates template is jurisdiction-agnostic.. Valid values are `^[A-Z]{2}$`',
    `language_code` STRING COMMENT 'ISO 639-1 language code (e.g., en, es, fr) with optional ISO 3166-1 country code (e.g., en-US, es-MX) for localized template variants.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the template record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the template record was last modified.',
    `last_used_date` DATE COMMENT 'Date when the template was last used to generate a communication. NULL if never used.',
    `legal_review_date` DATE COMMENT 'Date when legal review was completed and approval granted.',
    `legal_review_status` STRING COMMENT 'Status of internal legal department review to ensure compliance with contractual obligations, disclosure requirements, and legal standards.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `merge_field_list` STRING COMMENT 'Comma-separated list of merge field placeholders used in the template (e.g., {{policyholder_name}}, {{policy_number}}, {{premium_amount}}). Used for validation and data mapping.',
    `priority_level` STRING COMMENT 'Delivery priority for the communication (low, normal, high, urgent). Affects processing queue and delivery SLA (Service Level Agreement).. Valid values are `low|normal|high|urgent`',
    `product_line` STRING COMMENT 'Insurance product line this template applies to (life insurance, annuity, disability income, long-term care, universal life, or all product lines).. Valid values are `life|annuity|disability|ltc|universal|all`',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was granted by the Department of Insurance or other governing body.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval from Department of Insurance (DOI) or other governing body. Indicates whether template meets state-specific compliance requirements.. Valid values are `not_required|pending|approved|rejected|conditional`',
    `reply_to_email` STRING COMMENT 'Email address for recipient replies. May differ from sender email. NULL for non-email channels.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requires_signature` BOOLEAN COMMENT 'Indicates whether delivery requires recipient signature confirmation (e.g., for regulatory notices, policy cancellations, claim denials).',
    `retention_period_days` STRING COMMENT 'Number of days the generated communication must be retained per regulatory and legal requirements (e.g., 7 years for policy documents, 10 years for claim correspondence).',
    `sender_email` STRING COMMENT 'Email address used as the sender for email communications. NULL for non-email channels.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Display name of the sender (e.g., Customer Service Team, Claims Department, Underwriting Division) used in the communication.',
    `subject_line` STRING COMMENT 'Subject line or title for email and portal communications. NULL for letter and SMS templates.',
    `template_code` STRING COMMENT 'Business-assigned unique code for the template (e.g., LAPSE_NOTICE_01, PREM_REMINDER_STD). Used for operational reference and system integration.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `template_content` STRING COMMENT 'Full text content of the template including merge fields, placeholders, and formatting instructions. May contain HTML, plain text, or markup depending on channel.',
    `template_description` STRING COMMENT 'Detailed description of the template purpose, usage context, and business trigger conditions.',
    `template_name` STRING COMMENT 'Human-readable name of the communication template (e.g., Premium Payment Reminder, Lapse Notice - 30 Day Grace Period).',
    `template_status` STRING COMMENT 'Current lifecycle status of the template (draft, pending regulatory/legal approval, approved, active for use, inactive, retired, superseded by newer version). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|inactive|retired|superseded — 7 candidates stripped; promote to reference product]',
    `template_type` STRING COMMENT 'Classification of the template by business function (operational correspondence, regulatory notice, marketing communication, service request, complaint acknowledgment, claim correspondence, underwriting communication). [ENUM-REF-CANDIDATE: operational|regulatory|marketing|service|complaint|claim|underwriting — 7 candidates stripped; promote to reference product]',
    `translation_available` BOOLEAN COMMENT 'Indicates whether translations of this template are available in other languages to serve diverse policyholder populations.',
    `usage_count` BIGINT COMMENT 'Total number of times this template has been used to generate communications. Used for template effectiveness analysis and optimization.',
    `version_number` STRING COMMENT 'Version identifier for the template (e.g., 1.0, 2.3). Incremented when template content or structure changes.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_comm_template PRIMARY KEY(`comm_template_id`)
) COMMENT 'Master catalog of approved communication templates used to generate standardized policyholder and stakeholder correspondence. Owns template identity, version, channel applicability (letter, email, SMS, secure portal), language, regulatory approval status, and the business trigger that activates the template. Distinct from document.document_template which governs policy contract and form documents — this entity governs operational correspondence templates (e.g., lapse notice, premium reminder, beneficiary change confirmation, complaint acknowledgment). Tracks state-specific template variants required by DOI regulations and NAIC model regulations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` (
    `comm_template_version_id` BIGINT COMMENT 'Unique identifier for each version of a communication template. Primary key.',
    `comm_template_id` BIGINT COMMENT 'Reference to the parent communication template for which this is a specific version. Links to the master template entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who approved this template version for production use. Part of the governance and audit trail.',
    `quaternary_comm_approved_by_user_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `superseded_by_version_comm_template_version_id` BIGINT COMMENT 'Reference to the template version that replaced this one. Nullable for currently active versions. Enables version chain navigation.',
    `tertiary_comm_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this template version record. Part of the change audit trail.',
    `prior_comm_template_version_id` BIGINT COMMENT 'Self-referencing FK on comm_template_version (prior_comm_template_version_id)',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether this template version meets accessibility standards (e.g., WCAG 2.1 for digital channels, large print availability for letters).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when internal approval was granted for this template version. Distinct from regulatory approval.',
    `archive_date` DATE COMMENT 'Date when this template version was moved to archive status. Nullable for non-archived versions.',
    `archive_flag` BOOLEAN COMMENT 'Indicates whether this template version has been archived for long-term retention. Archived versions are retained for regulatory examination but not available for active use.',
    `change_description` STRING COMMENT 'Detailed narrative explanation of what changed in this version compared to the previous version. Supports regulatory defense and market conduct examination.',
    `change_reason_code` STRING COMMENT 'Categorized reason for creating this new version. Essential for audit trail and regulatory examination.. Valid values are `regulatory_update|language_correction|content_enhancement|channel_adaptation|legal_review|compliance_mandate`',
    `channel_type` STRING COMMENT 'Delivery channel for which this template version is designed. Different channels may require different formatting and content adaptations.. Valid values are `email|letter|sms|portal|mobile_app|ivr`',
    `communication_category` STRING COMMENT 'High-level categorization of the communication purpose. Used for organizing templates and ensuring appropriate content governance.. Valid values are `policy_service|billing_notice|claim_correspondence|regulatory_notice|marketing|complaint_response`',
    `content_hash` STRING COMMENT 'SHA-256 hash of the template body text and merge field schema. Used to detect unauthorized modifications and ensure content integrity.. Valid values are `^[a-fA-F0-9]{64}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this template version record was first created in the system. Part of the audit trail.',
    `disclaimer_block` STRING COMMENT 'Required legal and regulatory disclaimer text that must appear in communications generated from this template. Critical for compliance verification.',
    `effective_date` DATE COMMENT 'Date when this template version becomes active and available for use in generating communications. Critical for point-in-time reconstruction.',
    `expiration_date` DATE COMMENT 'Date when this template version is no longer valid for use. Nullable for currently active versions without planned end date.',
    `jurisdiction_code` STRING COMMENT 'State or jurisdiction code for which this template version is approved. Templates often require state-specific language to meet local insurance regulations.. Valid values are `^[A-Z]{2,3}$`',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language of this template version (e.g., ENG for English, SPA for Spanish).. Valid values are `^[A-Z]{3}$`',
    `last_used_date` DATE COMMENT 'Most recent date when this template version was used to generate a communication. Helps identify obsolete templates.',
    `merge_field_schema` STRING COMMENT 'JSON or structured definition of all merge fields (dynamic data placeholders) used in this template version, including field names, data types, and source mappings.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this template version record was last updated. Tracks all changes to version metadata.',
    `notes` STRING COMMENT 'Free-form notes or comments about this template version. Used for internal documentation and knowledge transfer.',
    `product_line_code` STRING COMMENT 'Product line or line of business for which this template is intended (e.g., term life, whole life, annuity, universal life). Nullable for templates applicable across all products.',
    `readability_score` DECIMAL(18,2) COMMENT 'Flesch-Kincaid or similar readability score for the template content. Regulators increasingly require consumer communications to meet minimum readability standards.',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory authority approved this template version for use. Nullable if approval is not required or pending.',
    `regulatory_approval_number` STRING COMMENT 'Official approval or filing number assigned by the regulatory authority. Used for audit trail and regulatory examination.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this template version requires explicit regulatory approval before use. True for templates containing policy language or rate information.',
    `retention_expiry_date` DATE COMMENT 'Date when this template version record may be purged per retention policy. Typically 7-10 years after last use for insurance communications.',
    `subject_line` STRING COMMENT 'Subject line or title text for this template version. Applicable to email and letter communications.',
    `template_body_text` STRING COMMENT 'Complete rendered content snapshot of the template body including all static text, merge field placeholders, and formatting instructions. Enables exact reconstruction of communications sent.',
    `usage_count` BIGINT COMMENT 'Total number of communications generated using this template version. Used for impact analysis when retiring or updating templates.',
    `version_number` STRING COMMENT 'Semantic version number of this template iteration (e.g., 1.0, 2.1, 3.0.1). Used for tracking major and minor revisions.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_status` STRING COMMENT 'Current lifecycle state of this template version. Tracks progression from draft through approval to active use and eventual retirement. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|retired|archived — 7 candidates stripped; promote to reference product]',
    `word_count` STRING COMMENT 'Total word count of the template body text. Used for readability analysis and compliance with plain language requirements.',
    CONSTRAINT pk_comm_template_version PRIMARY KEY(`comm_template_version_id`)
) COMMENT 'Tracks the full version history of each communication template, capturing every revision, regulatory re-approval, language update, or channel adaptation. Stores the effective date range for each version, the reason for change, the approver, and the rendered content snapshot (body text, merge field schema, disclaimer blocks). Enables point-in-time reconstruction of exactly which template version was used to generate a specific communication — critical for regulatory examination and market conduct defense.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` (
    `outbound_notice_id` BIGINT COMMENT 'Unique identifier for the outbound notice record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the billing account associated with this outbound notice, if applicable.',
    `annuity_contract_id` BIGINT COMMENT 'Reference to the annuity contract associated with this outbound notice, if applicable.',
    `bulk_comm_campaign_id` BIGINT COMMENT 'Foreign key linking to correspondence.bulk_comm_campaign. Business justification: Link outbound notice to bulk campaign if generated as part of campaign. Essential for campaign tracking and bulk notice management.',
    `claim_id` BIGINT COMMENT 'Reference to the claim associated with this outbound notice, if applicable.',
    `comm_template_id` BIGINT COMMENT 'Reference to the communication template used to generate this outbound notice.',
    `contract_owner_id` BIGINT COMMENT 'Foreign key linking to policyholder.contract_owner. Business justification: Owner-specific notices (1035 exchange confirmations, loan statements, dividend elections, premium notices, ownership transfer acknowledgments) have distinct regulatory requirements and content. Suppor',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link outbound notice to channel master. Replaces STRING delivery_channel code with FK to comm_channel. Uses delivery_ prefix to distinguish from other channel FKs.',
    `experience_study_id` BIGINT COMMENT 'Foreign key linking to actuarial.experience_study. Business justification: When experience studies result in material assumption changes affecting policyholder rates or benefits, regulatory requirements mandate disclosure notices citing the study. Real business process: poli',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Regulatory notices (1035 exchanges, policy illustrations, beneficiary confirmations, annual statements) are generated as formal insurance_document records for compliance retention and audit trail. Not',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group-specific regulatory notices (plan amendments, rate changes, ERISA compliance certifications, annual reporting) are sent to sponsors with distinct content and timing requirements. Supports compli',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy contract associated with this outbound notice.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Regulatory notices (annual statements, tax reporting, policy anniversaries) are plan-specific and must reference the correct product for compliance, accurate content generation, and regulatory reporti',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Regulatory notices for variable products (annual statements, prospectus updates, performance reports, fund change notifications) are portfolio-specific. SEC and state regulations require portfolio-lev',
    `vendor_id` BIGINT COMMENT 'Reference to the third-party print vendor or mail house responsible for physical production and dispatch of the notice, if applicable.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Producers receive regulatory notices for license renewals, appointment changes, CE compliance deadlines, E&O coverage requirements, and commission statements. Standard agent servicing and regulatory c',
    `party_id` BIGINT COMMENT 'Reference to the party record of the intended recipient of this outbound notice.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Rider-specific notices (benefit changes, premium adjustments, regulatory disclosures) require direct linkage to rider definitions for accurate content generation, compliance with rider-specific disclo',
    `service_order_id` BIGINT COMMENT 'Identifier for the batch or production run in which this notice was included. Used for grouping notices for bulk processing and tracking.',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_filing. Business justification: Life insurers send outbound notices to policyholders and regulators when statutory filings (Annual Statements, Quarterly Statements) are completed. The notice tracks delivery of the filing document. R',
    `resend_outbound_notice_id` BIGINT COMMENT 'Self-referencing FK on outbound_notice (resend_outbound_notice_id)',
    `compliance_deadline_date` DATE COMMENT 'The regulatory deadline by which this notice must be dispatched to remain in compliance. Applicable for time-sensitive regulatory notices such as lapse warnings and grace period notifications.',
    `content_format` STRING COMMENT 'The file format of the rendered notice content. Common formats include Portable Document Format (PDF), Hypertext Markup Language (HTML), plain text, Extensible Markup Language (XML), or other formats.. Valid values are `pdf|html|text|xml|other`',
    `content_reference` STRING COMMENT 'Reference identifier or storage path to the rendered content of the outbound notice. May point to a document management system, content repository, or file storage location.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred for generating and dispatching this outbound notice, including print, postage, and vendor fees. Used for cost allocation and budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this outbound notice record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost amount. Typically United States Dollar (USD) for domestic operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_preference` STRING COMMENT 'The recipients stated preference for receiving notices: paper, electronic, or both. Used to ensure compliance with customer communication preferences.. Valid values are `paper|electronic|both`',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Actual date and time when the outbound notice was dispatched to the delivery channel. Critical for regulatory compliance and service level tracking.',
    `generation_timestamp` TIMESTAMP COMMENT 'Date and time when the outbound notice was generated from the template. Represents the moment the notice content was rendered.',
    `language_code` STRING COMMENT 'Two-letter ISO language code indicating the language in which the notice was generated. Supports multilingual communication requirements.. Valid values are `^[a-z]{2}$`',
    `notice_category` STRING COMMENT 'High-level categorization of the notice for reporting and analytics purposes. Groups notices into functional areas such as billing, servicing, compliance, claims, underwriting, annuity, or general correspondence. [ENUM-REF-CANDIDATE: billing|servicing|compliance|claims|underwriting|annuity|general — 7 candidates stripped; promote to reference product]',
    `notice_number` STRING COMMENT 'Business-facing unique identifier for the outbound notice, used for tracking and reference in customer service interactions.',
    `notice_status` STRING COMMENT 'Current lifecycle status of the outbound notice. Tracks the notice from draft through dispatch, delivery, or failure. Statuses include draft, pending, dispatched, delivered, failed, cancelled, and returned. [ENUM-REF-CANDIDATE: draft|pending|dispatched|delivered|failed|cancelled|returned — 7 candidates stripped; promote to reference product]',
    `notice_type` STRING COMMENT 'Classification of the outbound notice based on the triggering business event. Examples include premium due, lapse warning, policy anniversary, benefit change, regulatory disclosure, free-look period, grace period notification, claim decision, reinstatement, surrender confirmation, maturity notice, Required Minimum Distribution (RMD) notification, 1035 exchange confirmation, Not In Good Order (NIGO) notification. [ENUM-REF-CANDIDATE: premium_due|lapse_warning|grace_period|policy_anniversary|benefit_change|free_look|regulatory_disclosure|claim_decision|reinstatement|surrender_confirmation|maturity|rmd_notification|1035_exchange|nigo|other — 15 candidates stripped; promote to reference product]',
    `page_count` STRING COMMENT 'Number of pages in the rendered notice document. Used for print production planning and cost allocation.',
    `priority_level` STRING COMMENT 'Priority classification for the outbound notice, influencing dispatch sequencing and delivery speed. Levels include urgent, high, normal, and low.. Valid values are `urgent|high|normal|low`',
    `recipient_address_line1` STRING COMMENT 'First line of the recipients mailing address to which the notice was sent.',
    `recipient_address_line2` STRING COMMENT 'Second line of the recipients mailing address (suite, apartment, etc.).',
    `recipient_city` STRING COMMENT 'City of the recipients mailing address.',
    `recipient_country_code` STRING COMMENT 'Three-letter ISO country code of the recipients mailing address.. Valid values are `^[A-Z]{3}$`',
    `recipient_email` STRING COMMENT 'Email address of the recipient if the notice was delivered electronically or if email is the preferred contact method.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Full name of the recipient as it appears on the outbound notice. Captured for audit and delivery tracking purposes.',
    `recipient_postal_code` STRING COMMENT 'Postal or ZIP code of the recipients mailing address.',
    `recipient_state` STRING COMMENT 'State or province code of the recipients mailing address. Critical for state-specific regulatory notice requirements.',
    `recipient_type` STRING COMMENT 'Classification of the intended recipient of the outbound notice. Identifies whether the notice is directed to the policyholder, applicant, beneficiary, agent, broker, Third Party Administrator (TPA), legal representative, or other party. [ENUM-REF-CANDIDATE: policyholder|applicant|beneficiary|agent|broker|third_party_administrator|legal_representative|other — 8 candidates stripped; promote to reference product]',
    `regulatory_jurisdiction` STRING COMMENT 'The state, province, or regulatory jurisdiction whose rules govern this notice. Critical for ensuring compliance with state-specific notice requirements.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this outbound notice is mandated by regulatory requirements (e.g., NAIC-mandated lapse notices, free-look period disclosures, state-specific grace period notifications). True if regulatory, false if discretionary.',
    `scheduled_send_date` DATE COMMENT 'The date on which the notice is scheduled to be dispatched. May differ from the actual dispatch date due to processing delays or business rules.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether the notice was suppressed and not dispatched due to business rules, customer preferences, or duplicate detection. True if suppressed, false if dispatched.',
    `suppression_reason` STRING COMMENT 'Explanation for why the notice was suppressed, if applicable. Examples include duplicate notice, customer opt-out, deceased policyholder, or business rule override.',
    `template_version` STRING COMMENT 'Version identifier of the communication template used at the time of notice generation. Critical for audit and compliance tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this outbound notice record was last modified. Audit trail field.',
    CONSTRAINT pk_outbound_notice PRIMARY KEY(`outbound_notice_id`)
) COMMENT 'Transactional record of every outbound notice, letter, or disclosure generated and dispatched to policyholders, applicants, agents, or beneficiaries. Captures the triggering business event (premium due, lapse warning, policy anniversary, benefit change, regulatory disclosure), the template version used, the rendered content reference, the intended recipient, the scheduled send date, and the actual dispatch timestamp. Tracks regulatory notice requirements such as NAIC-mandated lapse notices, free-look period disclosures, and state-specific grace period notifications. Distinct from delivery_event (which tracks the delivery outcome) — this entity owns the notice generation and dispatch intent.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` (
    `inbound_correspondence_id` BIGINT COMMENT 'Unique identifier for the inbound correspondence record. Primary key for this entity.',
    `annuity_contract_id` BIGINT COMMENT 'Reference to the annuity contract associated with this correspondence, if applicable. Links correspondence to specific annuity contracts.',
    `claim_id` BIGINT COMMENT 'Reference to the claim associated with this correspondence, if applicable. Links correspondence to specific claim cases.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link inbound correspondence to channel master. Replaces STRING correspondence_channel code with FK to comm_channel for proper channel tracking.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to correspondence.complaint. Business justification: Link inbound correspondence to resulting complaint. Essential for tracking complaint origination and correspondence-to-complaint conversion.',
    `employee_id` BIGINT COMMENT 'The identifier of the individual user or case worker assigned to handle this correspondence. Enables individual accountability and workload tracking.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Sponsors submit enrollment files, plan change requests, billing disputes, and compliance documentation. Tracking sponsor-originated correspondence supports plan administration workflows, billing recon',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this correspondence, if applicable. Links correspondence to specific policy contracts.',
    `policyholder_beneficiary_id` BIGINT COMMENT 'Foreign key linking to policyholder.policyholder_beneficiary. Business justification: Beneficiaries initiate correspondence for designation confirmations, settlement option elections, and claim status inquiries. This supports beneficiary service workflows, settlement processing, and re',
    `producer_id` BIGINT COMMENT 'Reference to the agent or producer associated with this correspondence, if the sender or subject is an agent.',
    `queue_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_queue. Business justification: Link inbound correspondence to the queue handling it. Replaces STRING assigned_unit with FK to queue master for proper queue management and workload distribution.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Paper correspondence (beneficiary change requests, premium checks, policy service forms, death claims) is scanned and indexed as insurance_document records. Mailroom scanning workflow creates document',
    `service_order_id` BIGINT COMMENT 'Identifier for the scanning batch in which this physical correspondence was digitized, if applicable. Used for document management and quality control.',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Inbound correspondence (medical records, financial statements, applicant clarifications) often relates to specific risk assessments. Real workflow: evidence receipt and case file assembly. Critical fo',
    `reply_to_inbound_correspondence_id` BIGINT COMMENT 'Self-referencing FK on inbound_correspondence (reply_to_inbound_correspondence_id)',
    `correspondence_body` STRING COMMENT 'The full text content of the correspondence. For scanned documents, this may contain OCR-extracted text. For emails, this is the email body.',
    `correspondence_number` STRING COMMENT 'Business-facing unique reference number assigned to this inbound correspondence for tracking and reference purposes. Used in customer service interactions and audit trails.',
    `correspondence_subject` STRING COMMENT 'The subject line or brief summary of the correspondence topic as provided by the sender or assigned during triage.',
    `correspondence_type` STRING COMMENT 'High-level categorization of the correspondence nature. Determines handling priority and regulatory reporting requirements.. Valid values are `service_request|complaint|inquiry|legal_notice|regulatory_inquiry|document_submission`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this correspondence record was first created in the system. Used for audit trails and data lineage tracking.',
    `document_count` STRING COMMENT 'The number of documents or attachments included with this correspondence. Used for completeness verification and document management.',
    `document_storage_path` STRING COMMENT 'The file system path or document management system location where the digitized correspondence and attachments are stored.',
    `is_complaint` BOOLEAN COMMENT 'Boolean flag indicating whether this correspondence has been classified as a formal complaint requiring regulatory reporting and escalated handling procedures.',
    `is_legal_notice` BOOLEAN COMMENT 'Boolean flag indicating whether this correspondence constitutes a legal notice, subpoena, or attorney communication requiring legal department review.',
    `is_regulatory` BOOLEAN COMMENT 'Boolean flag indicating whether this correspondence originated from a regulatory body or insurance department, requiring priority handling and compliance tracking.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the correspondence was written. Used for routing to appropriate language-capable staff.. Valid values are `^[A-Z]{3}$`',
    `nigo_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this correspondence was incomplete or missing required information, triggering a NIGO workflow for additional information requests.',
    `nigo_reason` STRING COMMENT 'Description of why the correspondence was flagged as NIGO, detailing missing information or documentation required to process the request.',
    `page_count` STRING COMMENT 'The total number of pages across all documents in this correspondence. Used for scanning, storage, and processing resource planning.',
    `postmark_date` DATE COMMENT 'The date stamped on the envelope by the postal service, if correspondence was received via mail. Used for determining timeliness of policyholder actions and regulatory compliance.',
    `priority_level` STRING COMMENT 'Assigned priority level for handling this correspondence based on sender type, subject matter, and regulatory requirements. Drives SLA targets.. Valid values are `urgent|high|normal|low`',
    `received_date` DATE COMMENT 'The date on which the inbound correspondence was received by the company. Critical for service level agreement (SLA) tracking and regulatory response time compliance.',
    `received_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the inbound correspondence was received, including time zone. Used for detailed SLA tracking and audit trails.',
    `requires_response` BOOLEAN COMMENT 'Boolean flag indicating whether this correspondence requires a formal written response to the sender. Drives workflow and SLA tracking.',
    `resolution_date` DATE COMMENT 'The date on which the matter raised in this correspondence was fully resolved and closed. Used for cycle time analysis and performance metrics.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the resolution of this correspondence, including actions taken, decisions made, and outcome summary.',
    `response_due_date` DATE COMMENT 'The date by which a response to this correspondence must be sent to meet regulatory requirements or internal service standards. Calculated based on received date and applicable SLA.',
    `response_sent_date` DATE COMMENT 'The date on which the formal response to this correspondence was sent to the sender. Used for SLA compliance tracking and audit purposes.',
    `sender_address` STRING COMMENT 'The physical mailing address of the sender, particularly relevant for correspondence received via postal mail or for formal response requirements.',
    `sender_email` STRING COMMENT 'The email address of the sender, if correspondence was received electronically or if provided for response purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'The full name of the individual or organization that sent the correspondence. Used for identification and response routing.',
    `sender_phone` STRING COMMENT 'The contact phone number of the sender for follow-up communication or clarification.',
    `sender_type` STRING COMMENT 'Classification of the senders relationship to the company. Determines routing, priority, and handling procedures. [ENUM-REF-CANDIDATE: policyholder|applicant|beneficiary|agent|attorney|regulator|third_party — 7 candidates stripped; promote to reference product]',
    `subject_classification` STRING COMMENT 'Standardized classification code categorizing the subject matter of the correspondence. Used for routing, reporting, and trend analysis. [ENUM-REF-CANDIDATE: policy_change|claim_inquiry|billing_question|complaint|legal_notice|regulatory_inquiry|beneficiary_change|surrender_request|loan_request|premium_payment|general_inquiry|document_request|address_change|name_change|reinstatement_request|lapse_notice_response|contestability_inquiry|underwriting_inquiry|annuity_withdrawal|RMD_inquiry|1035_exchange|other — promote to reference product]',
    `triage_status` STRING COMMENT 'Current status of the correspondence in the intake and triage workflow. Tracks progression from receipt through resolution.. Valid values are `pending_review|triaged|assigned|in_progress|resolved|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this correspondence record was last modified. Used for audit trails and change tracking.',
    CONSTRAINT pk_inbound_correspondence PRIMARY KEY(`inbound_correspondence_id`)
) COMMENT 'Transactional record capturing every inbound communication received from policyholders, applicants, agents, beneficiaries, attorneys, or regulators — including written letters, emails, faxes, secure portal messages, and uploaded documents. Captures receipt date, sender identity, channel, subject classification, associated policy or claim, triage status, assigned handling unit, and resolution status. Serves as the intake record for all inbound correspondence workflows including service requests, complaints, legal notices, and regulatory inquiries. Distinct from policy.policy_service_request (which owns the service transaction) — this entity owns the raw inbound communication artifact.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`call_record` (
    `call_record_id` BIGINT COMMENT 'Unique identifier for the call center interaction record.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link call record to channel master. Replaces STRING call_channel code with FK to comm_channel. Uses call_ prefix for semantic clarity.',
    `claim_id` BIGINT COMMENT 'Reference to the claim if the call pertains to First Notice of Loss (FNOL) or claim inquiry.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to correspondence.complaint. Business justification: Link call record to resulting complaint. Essential for tracking complaint origination from calls and call-to-complaint conversion.',
    `employee_id` BIGINT COMMENT 'Identifier of the call center representative who handled the interaction.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group sponsor service calls (enrollment support, billing inquiries, plan administration questions) are tracked separately for account management and SLA monitoring. Enables sponsor-specific service qu',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance or annuity policy discussed during the call, if applicable.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder who is the subject of or participant in the call.',
    `producer_id` BIGINT COMMENT 'Reference to the insurance agent or broker discussed or represented during the call.',
    `queue_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_queue. Business justification: Link call record to the correspondence queue it was routed through. Essential for queue performance analytics and call routing analysis.',
    `follow_up_call_record_id` BIGINT COMMENT 'Self-referencing FK on call_record (follow_up_call_record_id)',
    `authentication_method` STRING COMMENT 'Method used to verify the identity of the caller: Social Security Number (SSN) verification, date of birth verification, policy number, security question, biometric, or none.. Valid values are `ssn_verification|dob_verification|policy_number|security_question|biometric|none`',
    `authentication_status` STRING COMMENT 'Result of the caller identity verification process: passed, failed, not attempted, or partial.. Valid values are `passed|failed|not_attempted|partial`',
    `call_direction` STRING COMMENT 'Indicates whether the call was initiated by the customer (inbound) or by the company (outbound).. Valid values are `inbound|outbound`',
    `call_disposition` STRING COMMENT 'Final outcome or status of the call: resolved, escalated, transferred, abandoned by caller, callback scheduled, or voicemail left.. Valid values are `resolved|escalated|transferred|abandoned|callback_scheduled|voicemail`',
    `call_duration_seconds` STRING COMMENT 'Total duration of the call measured in seconds from start to end.',
    `call_end_timestamp` TIMESTAMP COMMENT 'Date and time when the call was terminated, in ISO 8601 format.',
    `call_language` STRING COMMENT 'Primary language used during the call: English (ENG), Spanish (SPA), French (FRA), Chinese (CHI), or Other (OTH).. Valid values are `ENG|SPA|FRA|CHI|OTH`',
    `call_notes` STRING COMMENT 'Detailed notes captured by the call center agent documenting the conversation, issues discussed, and actions taken.',
    `call_recording_reference` STRING COMMENT 'Unique reference identifier linking to the stored audio recording of the call for quality assurance and regulatory compliance.',
    `call_start_timestamp` TIMESTAMP COMMENT 'Date and time when the call was initiated or answered, in ISO 8601 format.',
    `call_subject` STRING COMMENT 'Brief summary or subject line describing the primary topic or reason for the call.',
    `call_transcript_reference` STRING COMMENT 'Unique reference identifier linking to the text transcript of the call for quality assurance and regulatory review.',
    `call_type` STRING COMMENT 'Classification of the primary purpose of the call: service inquiry, complaint, claim First Notice of Loss (FNOL), billing question, policy change request, or new business inquiry.. Valid values are `service_inquiry|complaint|claim_fnol|billing_question|policy_change_request|new_business_inquiry`',
    `caller_name` STRING COMMENT 'Name of the individual who initiated or participated in the call, as provided or verified during the interaction.',
    `caller_phone_number` STRING COMMENT 'Phone number from which the call originated, captured via Automatic Number Identification (ANI) or caller ID.',
    `caller_relationship` STRING COMMENT 'Relationship of the caller to the policy or claim: policyholder, beneficiary, agent, claimant, authorized representative, or third party.. Valid values are `policyholder|beneficiary|agent|claimant|authorized_representative|third_party`',
    `complaint_category` STRING COMMENT 'Standardized category of the complaint if the call was flagged as a complaint, aligned with NAIC complaint taxonomy. [ENUM-REF-CANDIDATE: claims_handling|policy_service|billing|underwriting|agent_conduct|product_disclosure|other — promote to reference product]',
    `complaint_flag` BOOLEAN COMMENT 'Indicates whether the call was classified as a formal complaint requiring regulatory tracking and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the call record was first created in the system, in ISO 8601 format.',
    `customer_satisfaction_score` STRING COMMENT 'Post-call survey score provided by the caller rating their satisfaction with the interaction, typically on a scale of 1 to 5.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the call was escalated to a supervisor, specialist, or higher authority for resolution.',
    `escalation_reason` STRING COMMENT 'Reason why the call was escalated, such as complex issue, customer dissatisfaction, or policy exception required.',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action must be completed, in yyyy-MM-dd format.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up action or callback is required after the call.',
    `hold_time_seconds` STRING COMMENT 'Total time in seconds that the caller spent on hold during the call.',
    `ivr_path` STRING COMMENT 'Sequence of menu selections or prompts navigated by the caller in the Interactive Voice Response system before reaching an agent.',
    `qa_review_date` DATE COMMENT 'Date when the quality assurance review of the call was completed, in yyyy-MM-dd format.',
    `quality_assurance_score` DECIMAL(18,2) COMMENT 'Score assigned by quality assurance reviewers evaluating the call against service standards and compliance requirements, typically on a 0-100 scale.',
    `queue_time_seconds` STRING COMMENT 'Time in seconds that the caller waited in the queue before being connected to an agent.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the call interaction must be reported to regulatory authorities such as state insurance departments or NAIC.',
    `resolution_code` STRING COMMENT 'Standardized code indicating the specific resolution or action taken to address the callers inquiry or issue.',
    `source_system` STRING COMMENT 'Name or identifier of the call center platform or Customer Relationship Management (CRM) system that originated this call record.',
    `transfer_count` STRING COMMENT 'Number of times the call was transferred between agents or departments during the interaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the call record was last modified or updated, in ISO 8601 format.',
    CONSTRAINT pk_call_record PRIMARY KEY(`call_record_id`)
) COMMENT 'Transactional record of every call center interaction — inbound and outbound — between Life Insurance representatives and policyholders, agents, beneficiaries, or claimants. Captures call date/time, duration, call type (service inquiry, complaint, claim FNOL, billing question, policy change request), IVR path, agent ID, call disposition, resolution code, and whether a follow-up action was created. Stores call recording reference ID and transcript reference for quality assurance and regulatory compliance. Supports NAIC market conduct examination requirements for call center interaction documentation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique identifier for the complaint record. Primary key.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Complaints about account restrictions, transaction blocks, or suspicious activity monitoring may trigger or reference AML cases. Real business process: complaint investigation linking to underlying AM',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Annuity complaints frequently involve contract-specific disputes: surrender charge disagreements, benefit base calculation errors, rider fee disputes, RMD processing issues. Complaint investigation an',
    `claim_id` BIGINT COMMENT 'Reference to the claim associated with this complaint, if the complaint relates to a claim denial or claim handling issue.',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Link complaint to the originating communication that triggered it. Essential for complaint root cause analysis and communication quality tracking.',
    `party_id` BIGINT COMMENT 'Reference to the party (policyholder, beneficiary, agent, or other stakeholder) who filed the complaint.',
    `suitability_review_id` BIGINT COMMENT 'Foreign key linking to compliance.suitability_review. Business justification: Suitability complaints (unsuitable product sales, misrepresentation) trigger formal suitability reviews and documentation. Real business process: suitability complaint investigation linking to formal ',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Complaints arrive as formal documents (letters, emails, recorded call transcripts, social media screenshots) that must be retained for NAIC complaint reporting and state regulatory audits. Complaint i',
    `employee_id` BIGINT COMMENT 'Reference to the employee or investigator assigned to handle and resolve this complaint.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group sponsor complaints (billing errors, enrollment processing failures, service level breaches, compliance issues) require specialized handling and regulatory reporting. Enables sponsor-specific com',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy contract associated with this complaint, if applicable.',
    `issue_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_issue. Business justification: Customer complaints revealing systemic problems or regulatory violations escalate to formal compliance issues requiring tracking and remediation. Real business process: complaint-to-issue escalation w',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Complaints often relate to specific product features, pricing, or performance. Product linkage enables root cause analysis, trend identification by product line, and regulatory reporting (NAIC complai',
    `policyholder_beneficiary_id` BIGINT COMMENT 'Foreign key linking to policyholder.policyholder_beneficiary. Business justification: Beneficiary complaints (designation disputes, settlement delays, claim denials) are a distinct regulatory category requiring specialized tracking and resolution. Enables beneficiary-specific complaint',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Investment-related complaints (performance disputes, excessive fees, unsuitable fund recommendations, unauthorized transfers) require portfolio context for investigation. Compliance and legal teams ne',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Privacy-related complaints (unauthorized disclosure, data breach concerns) may trigger or reference formal privacy incident investigations. Real business process: privacy complaint handling linking to',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Complaints about producer conduct, sales practices, misrepresentation, or E&O issues require tracking which producer is subject of complaint. Essential for compliance monitoring, market conduct exams,',
    `queue_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_queue. Business justification: Link complaint to the queue handling it. Replaces STRING assigned_unit with FK to queue master for proper queue management and workload tracking.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Rider-related complaints (benefit denials, premium disputes, disclosure issues) require rider-level tracking for resolution, root cause analysis, and regulatory reporting. Essential for market conduct',
    `application_id` BIGINT COMMENT 'Foreign key linking to underwriting.application. Business justification: Complaints frequently reference specific applications (underwriting delays, decision disputes, process issues). Real business need: complaint investigation, root cause analysis, and process improvemen',
    `related_complaint_id` BIGINT COMMENT 'Self-referencing FK on complaint (related_complaint_id)',
    `acknowledged_date` DATE COMMENT 'Date the company formally acknowledged receipt of the complaint to the complainant.',
    `assigned_date` DATE COMMENT 'Date the complaint was assigned to an investigator or resolution team.',
    `closed_date` DATE COMMENT 'Date the complaint case was officially closed in the complaint management system.',
    `complainant_email` STRING COMMENT 'Primary email address of the complainant for correspondence and resolution communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `complainant_name` STRING COMMENT 'Full legal name of the individual or organization filing the complaint.',
    `complainant_phone` STRING COMMENT 'Primary contact phone number of the complainant.',
    `complainant_satisfaction_rating` STRING COMMENT 'Satisfaction rating provided by the complainant after resolution, typically on a scale of 1-5 or 1-10.',
    `complainant_type` STRING COMMENT 'Classification of the complainants relationship to the company: policyholder, beneficiary, agent, broker, third party, or regulator.. Valid values are `policyholder|beneficiary|agent|broker|third_party|regulator`',
    `complaint_category` STRING COMMENT 'Primary classification of the complaint nature: claim denial, claim delay, billing dispute, premium issue, service failure, agent misconduct, product suitability, underwriting decision, policy servicing, commission dispute, misrepresentation, fraud allegation, privacy breach, or discrimination.. Valid values are `claim_denial|claim_delay|billing_dispute|premium_issue|service_failure|agent_misconduct|[ENUM-REF-CANDIDATE: claim_denial|claim_delay|billing_dispute|premium_issue|service_failure|agent_misconduct|product_suitability|underwriting_decision|policy_servicing|commission_dispute|misrepresentation|fraud_allegation|privacy_breach|discrimination — promote to reference product]`',
    `complaint_description` STRING COMMENT 'Detailed narrative description of the complaint as provided by the complainant, including the issue, context, and desired resolution.',
    `complaint_number` STRING COMMENT 'Business-facing unique complaint reference number used for tracking and external communication with complainants and regulators.. Valid values are `^[A-Z0-9]{8,20}$`',
    `complaint_source` STRING COMMENT 'Channel through which the complaint was received: phone, email, web portal, mail, in-person, regulator, or social media. [ENUM-REF-CANDIDATE: phone|email|web_portal|mail|in_person|regulator|social_media — 7 candidates stripped; promote to reference product]',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint: open, under investigation, pending response, resolved, closed, escalated, or withdrawn. [ENUM-REF-CANDIDATE: open|under_investigation|pending_response|resolved|closed|escalated|withdrawn — 7 candidates stripped; promote to reference product]',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar complaints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this complaint record was first created in the system.',
    `escalation_date` DATE COMMENT 'Date the complaint was escalated to a higher authority or specialized team.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the complaint has been escalated to senior management or a specialized resolution team.',
    `financial_remedy_amount` DECIMAL(18,2) COMMENT 'Monetary amount paid or credited to the complainant as part of the complaint resolution, if applicable.',
    `financial_remedy_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial remedy amount.. Valid values are `^[A-Z]{3}$`',
    `investigation_notes` STRING COMMENT 'Internal notes and findings documented during the complaint investigation process.',
    `naic_complaint_code` STRING COMMENT 'Standardized NAIC complaint reason code used for regulatory reporting and complaint ratio calculations.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the complaint based on severity, regulatory involvement, and business impact: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `received_date` DATE COMMENT 'Date the complaint was officially received by the company.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the complaint was logged into the complaint management system.',
    `regulator_involved_flag` BOOLEAN COMMENT 'Indicates whether a regulatory body (state DOI, CFPB, BBB, etc.) is involved in or monitoring this complaint.',
    `regulator_name` STRING COMMENT 'Name of the regulatory body involved in the complaint, if applicable (e.g., State Department of Insurance, CFPB, BBB).',
    `regulator_reference_number` STRING COMMENT 'Reference or case number assigned by the regulatory body for tracking this complaint.',
    `regulatory_response_due_date` DATE COMMENT 'Deadline by which the company must respond to the regulatory body regarding this complaint, per regulatory requirements.',
    `regulatory_response_submitted_date` DATE COMMENT 'Date the company submitted its formal response to the regulatory body.',
    `resolution_date` DATE COMMENT 'Date the complaint was resolved and communicated to the complainant.',
    `resolution_description` STRING COMMENT 'Detailed description of the resolution provided to the complainant, including actions taken and outcome.',
    `resolution_outcome` STRING COMMENT 'Final outcome classification of the complaint resolution: upheld (in favor of complainant), partially upheld, not upheld (in favor of company), withdrawn, or no action required.. Valid values are `upheld|partially_upheld|not_upheld|withdrawn|no_action_required`',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause identified during investigation (e.g., process failure, system error, training gap, policy ambiguity).',
    `subcategory` STRING COMMENT 'Detailed subcategory or reason code providing granular classification of the complaint within the primary category.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this complaint record was last modified.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Master and transactional record for every formal complaint received from policyholders, beneficiaries, agents, or regulators against Life Insurance. Serves as the SSOT for complaint identity, complainant identity, complaint category (claim denial, billing dispute, service failure, agent misconduct, product suitability), associated policy or claim, regulatory body involvement (state DOI, CFPB, BBB), complaint status, assigned investigator, resolution details, and regulatory response deadlines. Tracks NAIC complaint ratio reporting requirements and state DOI complaint register obligations. Distinct from compliance.compliance_issue (which tracks internal compliance violations) — this entity owns external stakeholder complaints.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` (
    `complaint_activity_id` BIGINT COMMENT 'Unique identifier for each activity event within a complaint lifecycle. Primary key for the complaint activity log.',
    `comm_template_id` BIGINT COMMENT 'Reference to the communication template used for this activity, if applicable. Links to the template library for standardized correspondence.',
    `communication_id` BIGINT COMMENT 'Reference to the specific inbound or outbound correspondence document associated with this activity, if applicable. Links to the correspondence management system.',
    `complaint_id` BIGINT COMMENT 'Reference to the parent complaint case that this activity belongs to. Links this activity to the master complaint record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor_contact. Business justification: When complaints involve vendor service failures (TPA, call center, mail house), complaint activities track which vendor contact responded or was escalated to. Critical for vendor performance managemen',
    `employee_id` BIGINT COMMENT 'Identifier of the specific person, system, or entity that performed this activity. May reference employee ID, regulator contact ID, policyholder ID, or system process name depending on actor_type.',
    `primary_complaint_employee_id` BIGINT COMMENT 'Employee or user ID of the staff member assigned to complete this activity. Used for workload management and accountability tracking.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_sla. Business justification: Link complaint activity to the SLA rule governing it. Essential for SLA compliance tracking and breach analysis.',
    `tertiary_complaint_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person or system process that last modified this activity record. Used for audit trail and accountability.',
    `prior_complaint_activity_id` BIGINT COMMENT 'Self-referencing FK on complaint_activity (prior_complaint_activity_id)',
    `activity_description` STRING COMMENT 'Detailed narrative description of the activity event, capturing the specific action taken, communication sent, or status transition that occurred.',
    `activity_status` STRING COMMENT 'Current status of this activity event: pending (scheduled but not yet executed), completed (successfully executed), failed (execution failed), cancelled (activity was cancelled before execution).. Valid values are `pending|completed|failed|cancelled`',
    `activity_timestamp` TIMESTAMP COMMENT 'The precise date and time when this activity event occurred in the complaint lifecycle. Critical for regulatory timeframe compliance tracking and audit trail reconstruction.',
    `activity_type_code` STRING COMMENT 'Standardized code representing the type of activity: ACK (acknowledgment sent), INV_INIT (investigation initiated), DOI_RESP (Department of Insurance response filed), RES_OFF (resolution offered), ESCAL (escalation event), CLOSE (complaint closed), REOPEN (complaint reopened), CORR_OUT (outbound correspondence), CORR_IN (inbound correspondence), CALL_LOG (call center interaction logged). [ENUM-REF-CANDIDATE: ACK|INV_INIT|DOI_RESP|RES_OFF|ESCAL|CLOSE|REOPEN|CORR_OUT|CORR_IN|CALL_LOG — 10 candidates stripped; promote to reference product]',
    `actor_name` STRING COMMENT 'Full name or system identifier of the actor who performed this activity. Used for audit trail and accountability tracking.',
    `actor_type` STRING COMMENT 'Classification of the entity that performed or triggered this activity: internal_staff (company employee), external_regulator (state DOI or regulatory body), policyholder (complainant), agent (producer or broker), system_automated (automated system action).. Valid values are `internal_staff|external_regulator|policyholder|agent|system_automated`',
    `assigned_to_department` STRING COMMENT 'The business department or functional unit responsible for completing this activity (e.g., Customer Service, Claims, Underwriting, Legal, Compliance).',
    `attachment_count` STRING COMMENT 'Number of documents or files attached to this activity event. Used to track supporting documentation and evidence.',
    `claim_number` STRING COMMENT 'The claim number associated with this complaint activity, if the complaint relates to a specific claim. Links the activity to the claims management system.',
    `communication_channel` STRING COMMENT 'The channel through which this activity communication was delivered or received: email, postal_mail, phone, fax, web_portal, mobile_app.. Valid values are `email|postal_mail|phone|fax|web_portal|mobile_app`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this activity record was first created in the database. Used for audit trail and data lineage tracking.',
    `doi_jurisdiction` STRING COMMENT 'The state or territorial Department of Insurance jurisdiction involved in this activity, if applicable. Uses standard two-letter state codes (e.g., CA, NY, TX).',
    `doi_reference_number` STRING COMMENT 'The official reference or case number assigned by the state Department of Insurance for this activity or complaint, if applicable.',
    `escalation_level` STRING COMMENT 'Numeric indicator of the escalation tier for this activity. Level 0 indicates no escalation, higher numbers indicate progressive escalation to senior management or regulatory bodies.',
    `escalation_reason` STRING COMMENT 'Business justification for why this activity was escalated to a higher level. Captures the specific trigger or threshold that prompted escalation.',
    `follow_up_due_date` DATE COMMENT 'The target date by which follow-up action must be completed, if follow_up_required_flag is true. Used for task management and deadline tracking.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this activity requires a subsequent follow-up action. True if additional action is needed, false if activity is self-contained.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this activity record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, observations, or context related to this activity. Used to capture details not covered by structured fields.',
    `policy_number` STRING COMMENT 'The life insurance or annuity policy number associated with this complaint activity, if applicable. Links the activity to the specific policy contract under dispute.',
    `priority_level` STRING COMMENT 'Business priority assigned to this activity: low (routine), medium (standard priority), high (urgent), critical (immediate attention required).. Valid values are `low|medium|high|critical`',
    `regulatory_flag` BOOLEAN COMMENT 'Boolean indicator of whether this activity involves regulatory interaction or reporting. True if the activity is related to Department of Insurance (DOI) communication, regulatory filing, or compliance reporting.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary value of the resolution or settlement offered during this activity, if applicable. Null if no financial resolution was offered.',
    `resolution_offered_flag` BOOLEAN COMMENT 'Boolean indicator of whether a resolution or settlement was offered to the complainant during this activity. True if a formal resolution proposal was made.',
    `resolution_type` STRING COMMENT 'Classification of the type of resolution offered: monetary (financial compensation), policy_correction (policy adjustment or correction), apology (formal apology), explanation (detailed explanation provided), other (other resolution type).. Valid values are `monetary|policy_correction|apology|explanation|other`',
    `sla_actual_date` DATE COMMENT 'The actual completion date when this activity was finalized. Used to measure performance against SLA targets and identify timeframe violations.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this activity was completed within the required SLA timeframe. True if completed on or before sla_target_date, false if late.',
    `sla_target_date` DATE COMMENT 'The target completion date for this activity based on internal service level agreements or regulatory timeframe requirements. Used to track compliance with response time standards.',
    CONSTRAINT pk_complaint_activity PRIMARY KEY(`complaint_activity_id`)
) COMMENT 'Chronological activity log capturing every action, status transition, communication, and escalation event within the lifecycle of a complaint. Records the activity type (acknowledgment sent, investigation initiated, DOI response filed, resolution offered, complaint closed), the actor, the timestamp, and any associated outbound notice or inbound correspondence. Enables full audit trail reconstruction for regulatory examination and supports NAIC-mandated complaint handling timeframe compliance tracking.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` (
    `delivery_tracking_id` BIGINT COMMENT 'Unique identifier for the delivery tracking record.',
    `communication_id` BIGINT COMMENT 'Reference to the outbound correspondence or notice that was dispatched.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link delivery tracking to channel master. Replaces STRING delivery_channel code with FK to comm_channel. Uses delivery_ prefix for clarity.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this delivery tracking event.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder who is the intended recipient of the correspondence.',
    `employee_id` BIGINT COMMENT 'The identifier of the user or system process that created this delivery tracking record.',
    `document_id` BIGINT COMMENT 'Reference to the document containing proof of delivery (e.g., signed receipt, delivery confirmation).',
    `returned_mail_id` BIGINT COMMENT 'Foreign key linking to correspondence.returned_mail. Business justification: Link delivery tracking to returned mail record when delivery outcome is returned mail. Essential for tracking delivery failures and returned mail resolution.',
    `retry_delivery_tracking_id` BIGINT COMMENT 'Self-referencing FK on delivery_tracking (retry_delivery_tracking_id)',
    `attempt_count` STRING COMMENT 'The number of delivery attempts made for this correspondence.',
    `bounce_type` STRING COMMENT 'Classification of email bounce (hard bounce for permanent failures, soft bounce for temporary issues, technical bounce for system errors).. Valid values are `hard_bounce|soft_bounce|technical_bounce`',
    `carrier_name` STRING COMMENT 'The name of the delivery carrier or service provider (e.g., USPS, FedEx, UPS, email service provider).',
    `correspondence_type` STRING COMMENT 'The type or category of correspondence being delivered (e.g., policy notice, billing statement, claim letter, regulatory notice).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery tracking record was first created in the system.',
    `delivery_cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred for this delivery attempt, including postage, carrier fees, or electronic delivery charges.',
    `delivery_notes` STRING COMMENT 'Additional notes or comments related to the delivery attempt, including carrier remarks or special handling instructions.',
    `delivery_priority` STRING COMMENT 'The priority level assigned to this delivery (standard, expedited, urgent, regulatory).. Valid values are `standard|expedited|urgent|regulatory`',
    `delivery_status` STRING COMMENT 'Current status of the delivery attempt (pending, delivered, returned, bounced, undeliverable, opened).. Valid values are `pending|delivered|returned|bounced|undeliverable|opened`',
    `dispatch_timestamp` TIMESTAMP COMMENT 'The date and time when the correspondence was dispatched to the delivery channel.',
    `final_delivery_timestamp` TIMESTAMP COMMENT 'The date and time when the correspondence was successfully delivered or final status was determined.',
    `first_attempt_timestamp` TIMESTAMP COMMENT 'The date and time of the first delivery attempt.',
    `opened_timestamp` TIMESTAMP COMMENT 'The date and time when the recipient opened the electronic correspondence (email, secure portal).',
    `proof_of_delivery_received_flag` BOOLEAN COMMENT 'Indicates whether proof of delivery has been received and confirmed.',
    `proof_of_delivery_required_flag` BOOLEAN COMMENT 'Indicates whether proof of delivery is required for regulatory or compliance purposes (e.g., certified mail for regulatory notices).',
    `recipient_address_line1` STRING COMMENT 'The first line of the mailing address to which the correspondence was sent for physical delivery.',
    `recipient_address_line2` STRING COMMENT 'The second line of the mailing address (apartment, suite, etc.) for physical delivery.',
    `recipient_city` STRING COMMENT 'The city of the mailing address to which the correspondence was sent.',
    `recipient_country_code` STRING COMMENT 'The three-letter ISO country code of the mailing address to which the correspondence was sent.. Valid values are `^[A-Z]{3}$`',
    `recipient_email_address` STRING COMMENT 'The email address to which the correspondence was sent for electronic delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone_number` STRING COMMENT 'The phone number to which the correspondence was sent for SMS or fax delivery.',
    `recipient_postal_code` STRING COMMENT 'The postal code or ZIP code of the mailing address to which the correspondence was sent.',
    `recipient_state_province` STRING COMMENT 'The state or province of the mailing address to which the correspondence was sent.',
    `redelivery_instructions` STRING COMMENT 'Special instructions for redelivery attempts, including alternate addresses or contact methods.',
    `redelivery_requested_flag` BOOLEAN COMMENT 'Indicates whether a redelivery attempt has been requested after initial delivery failure.',
    `regulatory_notice_flag` BOOLEAN COMMENT 'Indicates whether this correspondence is a regulatory notice requiring special delivery tracking and proof of delivery.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the reason for delivery failure or return (e.g., invalid address, recipient refused, mailbox full).',
    `return_reason_description` STRING COMMENT 'Detailed description of the reason for delivery failure or return.',
    `tracking_number` STRING COMMENT 'USPS or carrier tracking number for certified mail or physical delivery requiring proof of delivery.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this delivery tracking record was last updated.',
    CONSTRAINT pk_delivery_tracking PRIMARY KEY(`delivery_tracking_id`)
) COMMENT 'Transactional record tracking the end-to-end delivery outcome for every outbound notice and communication dispatched by the correspondence domain. Captures delivery channel (USPS, email, SMS, secure portal, fax), delivery attempt timestamps, delivery status (delivered, returned, bounced, undeliverable, opened), return reason codes, and re-delivery instructions. Tracks USPS certified mail tracking numbers for regulatory notices requiring proof of delivery. Distinct from document.delivery_event (which tracks electronic document delivery for policy contracts and forms) — this entity owns correspondence-level delivery tracking across all channels.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`queue` (
    `queue_id` BIGINT COMMENT 'Unique identifier for the correspondence queue. Primary key for the correspondence queue entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Operational audit: track which employee established each correspondence queue for organizational change management, capacity planning analysis, and workflow governance. Queue setup is a controlled adm',
    `escalation_queue_id` BIGINT COMMENT 'Identifier of the target queue to which items are escalated when they exceed the escalation threshold or require senior review.',
    `parent_queue_id` BIGINT COMMENT 'Self-referencing FK on queue (parent_queue_id)',
    `active_agent_count` STRING COMMENT 'Current number of agents actively assigned to process work items in this queue. Updated as agents log in/out or are reassigned.',
    `assignment_algorithm` STRING COMMENT 'Method used to distribute work items to agents: round_robin (sequential rotation), skill_based (matched to agent expertise), workload_balanced (assigned to agent with lowest current workload), manual (supervisor assigns).. Valid values are `round_robin|skill_based|workload_balanced|manual`',
    `auto_assignment_enabled` BOOLEAN COMMENT 'Indicates whether work items entering this queue are automatically assigned to available agents based on workload balancing rules (True) or require manual assignment by a supervisor (False).',
    `average_handling_time_minutes` DECIMAL(18,2) COMMENT 'Historical average time in minutes required to process and resolve a single work item in this queue. Used for capacity planning and staffing decisions.',
    `communication_channel` STRING COMMENT 'Primary communication channel through which correspondence items enter this queue: mail (postal mail), email (electronic mail), phone (call center), fax (facsimile), web_portal (online customer portal), mobile_app (mobile application).. Valid values are `mail|email|phone|fax|web_portal|mobile_app`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this queue record was first created in the system.',
    `current_item_count` STRING COMMENT 'Current number of active work items in the queue awaiting processing or resolution. Updated in real-time as items are added or completed.',
    `effective_date` DATE COMMENT 'Date on which this queue became operational and began accepting work items.',
    `escalation_threshold_hours` STRING COMMENT 'Number of business hours after which unresolved items in this queue are automatically escalated to a supervisor or higher-priority queue.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this queue record was last updated, including changes to configuration, SLA targets, or staffing.',
    `manager_email` STRING COMMENT 'Email address of the queue manager for escalation notifications and operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `manager_name` STRING COMMENT 'Full name of the individual responsible for managing the queue, including workload distribution, SLA monitoring, and escalation handling.',
    `max_queue_capacity` STRING COMMENT 'Maximum number of work items that can be held in this queue simultaneously before triggering overflow or escalation procedures. Used for capacity planning and workload management.',
    `open_hours` STRING COMMENT 'Business hours during which this queue is actively staffed and processing work items (e.g., Monday-Friday 8:00 AM - 5:00 PM EST). Items arriving outside these hours are queued for next business day.',
    `owning_business_unit` STRING COMMENT 'Name or code of the business unit responsible for managing and processing work items in this queue (e.g., Customer Service Operations, Compliance Department, Claims Administration).',
    `owning_department` STRING COMMENT 'Specific department within the business unit that owns this queue and is accountable for Service Level Agreement (SLA) compliance.',
    `priority_level` STRING COMMENT 'Default priority level assigned to work items entering this queue. Critical queues handle regulatory inquiries and escalated complaints; high priority handles time-sensitive customer requests; medium handles standard correspondence; low handles informational requests.. Valid values are `critical|high|medium|low`',
    `quality_review_required` BOOLEAN COMMENT 'Indicates whether completed work items from this queue require quality assurance review before final closure (True for regulatory and complaint queues, False for routine correspondence).',
    `quality_sample_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of completed work items from this queue that are randomly selected for quality assurance review. Null if quality_review_required is False.',
    `queue_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the queue for system integration and reporting purposes.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `queue_description` STRING COMMENT 'Detailed business description of the queues purpose, scope, and types of correspondence items it handles. Used for training and operational documentation.',
    `queue_name` STRING COMMENT 'Business name of the correspondence queue (e.g., Inbound Mail Triage, Complaint Handling, Regulatory Response, Returned Mail Processing, Escalation Review).',
    `queue_status` STRING COMMENT 'Current operational status of the queue. Active queues accept new work items; inactive queues are temporarily disabled; suspended queues are paused pending review; archived queues are retired but retained for historical reference.. Valid values are `active|inactive|suspended|archived`',
    `queue_type` STRING COMMENT 'Classification of the queue based on correspondence workflow type: inbound (incoming mail/email triage), outbound (outgoing correspondence processing), complaint (complaint handling), regulatory (regulatory response), escalation (escalated items requiring senior review), returned_mail (undeliverable mail processing).. Valid values are `inbound|outbound|complaint|regulatory|escalation|returned_mail`',
    `regulatory_reporting_category` STRING COMMENT 'Category code used for regulatory reporting purposes when items from this queue are included in state DOI complaint reports or NAIC market conduct filings. Null if requires_regulatory_tracking is False.',
    `requires_regulatory_tracking` BOOLEAN COMMENT 'Indicates whether items in this queue must be tracked and reported to regulatory authorities (True for complaint queues, regulatory response queues) or are internal operational items only (False).',
    `sla_acknowledgment_hours` STRING COMMENT 'Target number of business hours within which correspondence items in this queue must be acknowledged. Typical regulatory requirement is 2 business days (16 hours) per state Department of Insurance (DOI) standards.',
    `sla_compliance_rate_percent` DECIMAL(18,2) COMMENT 'Historical percentage of work items in this queue that were resolved within the defined SLA targets. Calculated over the most recent reporting period (typically 30 or 90 days).',
    `sla_resolution_days` STRING COMMENT 'Target number of business days within which correspondence items in this queue must be fully resolved. Typical regulatory requirement is 30 business days per state DOI requirements for complaint resolution.',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported by this queue (e.g., en,es,zh,fr). Null if supports_multi_language is False.',
    `supports_multi_language` BOOLEAN COMMENT 'Indicates whether this queue is staffed to handle correspondence in multiple languages (True) or English only (False). Critical for compliance with state language access requirements.',
    `termination_date` DATE COMMENT 'Date on which this queue was retired or archived and stopped accepting new work items. Null for active queues.',
    `time_zone` STRING COMMENT 'Time zone in which the queue operates, using IANA time zone database format (e.g., America/New_York, America/Chicago). Used for SLA calculations and business hours enforcement.',
    CONSTRAINT pk_queue PRIMARY KEY(`queue_id`)
) COMMENT 'Operational master record representing a named work queue within the correspondence processing workflow — e.g., inbound mail triage, complaint handling, regulatory response, returned mail processing, escalation review. Defines queue identity, owning business unit, SLA targets (acknowledgment within 2 business days, resolution within 30 days per state DOI requirements), queue type, priority rules, and current capacity metrics. Enables workload management and SLA compliance monitoring across all correspondence handling units.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` (
    `queue_assignment_id` BIGINT COMMENT 'Unique identifier for the queue assignment record. Primary key for the queue assignment entity.',
    `communication_id` BIGINT COMMENT 'Reference to the inbound correspondence item, complaint, or communication task being assigned to a queue.',
    `assignment_id` BIGINT COMMENT 'Reference to the previous queue assignment record if this is a reassignment, enabling reassignment history tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the correspondence handling representative or agent assigned to process this item.',
    `queue_id` BIGINT COMMENT 'Reference to the correspondence queue to which the item is assigned for processing.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_sla. Business justification: Link queue assignment to the SLA rule. Essential for SLA-driven workload management and compliance tracking.',
    `reassigned_from_queue_assignment_id` BIGINT COMMENT 'Self-referencing FK on queue_assignment (reassigned_from_queue_assignment_id)',
    `actual_handling_hours` DECIMAL(18,2) COMMENT 'The actual number of business hours spent by the representative handling the correspondence item from assignment to completion.',
    `assignment_date` DATE COMMENT 'The date when the correspondence item was assigned to the queue and representative.',
    `assignment_method` STRING COMMENT 'The method or mechanism by which the assignment was made, such as automatic routing, manual assignment, escalation, round-robin distribution, skill-based routing, or load balancing.. Valid values are `automatic|manual|escalation|round_robin|skill_based|load_balanced`',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments related to the assignment, such as special instructions, context, or handling guidance for the assigned representative.',
    `assignment_reason_code` STRING COMMENT 'Code indicating the reason for the assignment, such as initial assignment, reassignment due to workload, escalation, skill match, or representative unavailability.',
    `assignment_reason_description` STRING COMMENT 'Detailed description of the reason for the assignment or reassignment of the correspondence item.',
    `assignment_status` STRING COMMENT 'Current status of the queue assignment, tracking the lifecycle from initial assignment through completion or reassignment.. Valid values are `assigned|in_progress|on_hold|reassigned|completed|cancelled`',
    `assignment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the correspondence item was assigned to the queue and representative.',
    `channel` STRING COMMENT 'The channel through which the correspondence was received, such as email, phone, postal mail, web portal, mobile app, or fax.. Valid values are `email|phone|mail|web_portal|mobile_app|fax`',
    `claim_number` STRING COMMENT 'The claim number associated with the correspondence item, if applicable, enabling linkage to the relevant insurance claim.',
    `completion_date` DATE COMMENT 'The date when the assigned representative completed processing of the correspondence item.',
    `completion_timestamp` TIMESTAMP COMMENT 'The precise date and time when the assigned representative completed processing of the correspondence item.',
    `correspondence_type` STRING COMMENT 'The type or category of correspondence item being assigned, such as complaint, inquiry, service request, claim correspondence, policy change request, or regulatory correspondence.. Valid values are `complaint|inquiry|service_request|claim_correspondence|policy_change|regulatory`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this queue assignment record was first created in the system.',
    `escalation_level` STRING COMMENT 'Numeric indicator of the escalation level for this assignment. Zero indicates initial assignment, higher numbers indicate successive escalations to senior representatives or management.',
    `escalation_reason` STRING COMMENT 'Description of the reason for escalation, such as SLA breach, complexity, regulatory sensitivity, or customer request.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active assignment for the correspondence item. False if the item has been reassigned to another representative or queue.',
    `policy_number` STRING COMMENT 'The policy number associated with the correspondence item, if applicable, enabling linkage to the relevant insurance policy.',
    `priority_level` STRING COMMENT 'The priority level assigned to the correspondence item, determining the urgency of processing. Critical items require immediate attention, while routine items follow standard processing timelines.. Valid values are `critical|high|medium|low|routine`',
    `priority_score` STRING COMMENT 'Numeric score representing the priority of the assignment, used for sorting and escalation logic. Higher scores indicate higher priority.',
    `reassignment_count` STRING COMMENT 'The number of times this correspondence item has been reassigned to different representatives or queues, indicating complexity or escalation patterns.',
    `skill_match_score` DECIMAL(18,2) COMMENT 'Numeric score indicating how well the assigned representatives skills match the requirements of the correspondence item, used in skill-based routing.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the service level agreement was breached for this assignment, meaning the item was not resolved within the target timeframe.',
    `sla_breach_hours` DECIMAL(18,2) COMMENT 'The number of hours by which the SLA was breached, calculated as the difference between actual completion time and SLA due time. Null if no breach occurred.',
    `sla_due_date` DATE COMMENT 'The date by which the correspondence item must be resolved or responded to in order to meet service level agreement commitments.',
    `sla_due_timestamp` TIMESTAMP COMMENT 'The precise date and time by which the correspondence item must be resolved or responded to in order to meet service level agreement commitments.',
    `sla_target_hours` STRING COMMENT 'The target number of business hours within which the correspondence item should be resolved, based on the priority level and correspondence type.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this queue assignment record was last updated or modified.',
    `workload_balance_score` DECIMAL(18,2) COMMENT 'Numeric score representing the workload balance factor at the time of assignment, used to distribute work evenly across representatives.',
    CONSTRAINT pk_queue_assignment PRIMARY KEY(`queue_assignment_id`)
) COMMENT 'Transactional record capturing the assignment of an inbound correspondence item, complaint, or communication task to a specific correspondence queue and handling representative. Tracks assignment date, assigned-to representative, assignment reason, priority level, due date based on SLA, reassignment history, and current assignment status. Enables workload balancing, SLA breach detection, and escalation management across the correspondence operations team.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` (
    `notice_compliance_log_id` BIGINT COMMENT 'Unique identifier for the notice compliance log record. Primary key for the notice compliance audit trail.',
    `annuity_contract_id` BIGINT COMMENT 'Reference to the annuity contract when the notice pertains to an annuity product rather than a life insurance policy.',
    `contract_owner_id` BIGINT COMMENT 'Foreign key linking to policyholder.contract_owner. Business justification: Regulatory audits verify owner-specific notices (annual statements, tax forms, ownership change confirmations) were delivered to owners in their ownership capacity. Supports compliance verification fo',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy or annuity contract for which the regulatory notice was required.',
    `outbound_notice_id` BIGINT COMMENT 'Reference to the outbound notice document that was generated and dispatched to satisfy the regulatory requirement.',
    `employee_id` BIGINT COMMENT 'User ID or system process identifier that created this compliance log record (e.g., batch job, correspondence system user).',
    `party_id` BIGINT COMMENT 'Reference to the party (person or organization) who was the intended recipient of the regulatory notice.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_sla. Business justification: Link compliance log to SLA rule. Regulatory deadlines are SLA-driven. Essential for compliance tracking and regulatory reporting.',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_filing. Business justification: Compliance logs track whether required regulatory notices (e.g., policy illustrations, annual disclosures) were sent per statutory filing deadlines. Real business process: regulatory compliance audit ',
    `corrected_notice_compliance_log_id` BIGINT COMMENT 'Self-referencing FK on notice_compliance_log (corrected_notice_compliance_log_id)',
    `actual_dispatch_date` DATE COMMENT 'The date on which the notice was actually generated and dispatched to the recipient (mailed, emailed, or otherwise transmitted).',
    `audit_examiner_notes` STRING COMMENT 'Free-text notes or findings recorded by the market conduct examiner or internal auditor during review of this compliance log record.',
    `audit_examiner_reviewed_flag` BOOLEAN COMMENT 'Boolean indicator that this compliance log record was reviewed by a state DOI market conduct examiner or internal audit team during a compliance examination.',
    `compliance_status` STRING COMMENT 'Current compliance state of the notice delivery: compliant (delivered on time), late (delivered after deadline but within cure period), missed (deadline missed, no delivery), cured (late delivery remediated), pending_confirmation (dispatched, awaiting delivery confirmation).. Valid values are `compliant|late|missed|cured|pending_confirmation`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance log record was first created in the system, capturing the moment the notice requirement was logged.',
    `cure_action_taken` STRING COMMENT 'Description of the remediation action taken to cure a missed or late notice delivery (e.g., expedited certified mail, phone call to policyholder, state DOI voluntary disclosure).',
    `cure_completion_date` DATE COMMENT 'The date on which the cure action was completed and the notice delivery exception was resolved. Null if no cure action was required or if cure is still in progress.',
    `days_to_deadline` STRING COMMENT 'Number of calendar days between the triggering event and the required delivery date, as mandated by regulation (e.g., 30 days for replacement notice, 10 days for free look).',
    `days_variance` STRING COMMENT 'Number of days by which the actual dispatch date differed from the required delivery date. Negative values indicate early dispatch; positive values indicate late dispatch.',
    `delivery_confirmation_date` DATE COMMENT 'The date on which delivery of the notice was confirmed (e.g., postal delivery confirmation, email open receipt, certified mail signature). Null if delivery has not yet been confirmed.',
    `delivery_method` STRING COMMENT 'The channel through which the notice was dispatched: postal_mail, certified_mail, email, secure_portal, fax, or sms.. Valid values are `postal_mail|certified_mail|email|secure_portal|fax|sms`',
    `delivery_tracking_number` STRING COMMENT 'Tracking number or confirmation identifier provided by the delivery service (e.g., USPS tracking number, email message ID, certified mail receipt number).',
    `exception_flag` BOOLEAN COMMENT 'Boolean indicator that the notice delivery missed the regulatory deadline or encountered a delivery failure requiring remediation.',
    `exception_reason` STRING COMMENT 'Free-text explanation of why the notice delivery missed the deadline or failed (e.g., system outage, incorrect address, policyholder contact information unavailable).',
    `jurisdiction_code` STRING COMMENT 'Two-letter state or territory code of the regulatory jurisdiction imposing the notice requirement (e.g., NY, CA, TX).. Valid values are `^[A-Z]{2}$`',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the notice was generated (e.g., en for English, es for Spanish).. Valid values are `^[a-z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance log record was last modified, capturing updates to delivery confirmation, cure actions, or compliance status.',
    `notice_type` STRING COMMENT 'Category of regulatory notice: replacement (policy replacement disclosure), lapse (grace period or lapse warning), reinstatement (reinstatement rights), free_look (free look period rights), privacy (HIPAA or privacy notice), adverse_action (underwriting or claims adverse action).. Valid values are `replacement|lapse|reinstatement|free_look|privacy|adverse_action`',
    `recipient_type` STRING COMMENT 'The role of the party to whom the notice was sent: policyholder, insured, beneficiary, agent, trustee, or assignee.. Valid values are `policyholder|insured|beneficiary|agent|trustee|assignee`',
    `regulatory_requirement_code` STRING COMMENT 'Code identifying the specific regulatory notice requirement being satisfied (e.g., NAIC_REPLACEMENT, STATE_LAPSE, HIPAA_PRIVACY, 1035_EXCHANGE, STOLI_DISCLOSURE).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `regulatory_requirement_description` STRING COMMENT 'Full text description of the regulatory notice requirement, including the statute or regulation citation that mandates the notice.',
    `required_delivery_date` DATE COMMENT 'The regulatory deadline by which the notice must be delivered to the policyholder or stakeholder to remain in compliance.',
    `template_code` STRING COMMENT 'Code identifying the correspondence template used to generate the notice document (e.g., TMPL_REPLACEMENT_NY, TMPL_LAPSE_WARNING_CA).. Valid values are `^[A-Z0-9_]{3,30}$`',
    `template_version` STRING COMMENT 'Version number of the correspondence template used, ensuring audit trail of template changes over time (e.g., 1.0, 2.3).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `triggering_event_code` STRING COMMENT 'Code identifying the business event that triggered the regulatory notice requirement (e.g., POLICY_ISSUE, PREMIUM_DUE, LAPSE_PENDING, CLAIM_DENIAL, REPLACEMENT_APP).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `triggering_event_date` DATE COMMENT 'The date on which the business event occurred that triggered the regulatory notice requirement (e.g., policy issue date, premium due date, lapse effective date).',
    CONSTRAINT pk_notice_compliance_log PRIMARY KEY(`notice_compliance_log_id`)
) COMMENT 'Transactional audit record confirming that each required regulatory notice was generated, dispatched, and delivered within the mandated timeframe for a specific policy or contract. Captures the regulatory notice requirement satisfied, the outbound notice generated, the policy or contract, the required deadline, the actual dispatch date, the delivery confirmation date, and any exceptions or cure actions taken when a deadline was missed. Critical for NAIC market conduct examination defense and state DOI audit response.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` (
    `returned_mail_id` BIGINT COMMENT 'Unique identifier for the returned mail record.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link returned mail to channel master. Replaces STRING delivery_channel code with FK to comm_channel. Uses delivery_ prefix for clarity.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or team assigned to follow up on the returned mail.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with the returned mail.',
    `outbound_notice_id` BIGINT COMMENT 'Reference to the original outbound correspondence that was returned as undeliverable.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder to whom the returned mail was addressed.',
    `prior_returned_mail_id` BIGINT COMMENT 'Self-referencing FK on returned_mail (prior_returned_mail_id)',
    `address_verification_status` STRING COMMENT 'Status of address verification efforts following the returned mail event.. Valid values are `pending|verified|unverified|deceased_confirmed|no_valid_address_found`',
    `attempted_address_line1` STRING COMMENT 'First line of the address where delivery was attempted.',
    `attempted_address_line2` STRING COMMENT 'Second line of the address where delivery was attempted (apartment, suite, unit number).',
    `attempted_city` STRING COMMENT 'City of the address where delivery was attempted.',
    `attempted_country_code` STRING COMMENT 'Three-letter ISO country code of the address where delivery was attempted.. Valid values are `^[A-Z]{3}$`',
    `attempted_postal_code` STRING COMMENT 'Postal code (ZIP code) of the address where delivery was attempted.',
    `attempted_state` STRING COMMENT 'State or province of the address where delivery was attempted.',
    `correspondence_priority` STRING COMMENT 'Priority level of the returned correspondence, indicating urgency of follow-up.. Valid values are `routine|urgent|regulatory_required|time_sensitive`',
    `correspondence_type` STRING COMMENT 'Type of correspondence that was returned (e.g., premium notice, policy statement, claim letter).. Valid values are `notice|statement|claim_letter|policy_document|billing_notice|regulatory_notice`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the returned mail record was first created in the system.',
    `dmf_match_found_flag` BOOLEAN COMMENT 'Indicates whether the policyholder was found in the Death Master File, confirming deceased status.',
    `dmf_search_performed_flag` BOOLEAN COMMENT 'Indicates whether a Death Master File search was performed to verify if the policyholder is deceased.',
    `follow_up_action_code` STRING COMMENT 'Code indicating the follow-up action taken or required in response to the returned mail (e.g., address search initiated, skip tracing, state unclaimed property notification).. Valid values are `address_search|skip_trace|unclaimed_property_notification|policy_lapse|contact_beneficiary|no_action`',
    `follow_up_action_date` DATE COMMENT 'Date when the follow-up action was initiated or completed.',
    `ncoa_match_found_flag` BOOLEAN COMMENT 'Indicates whether a valid forwarding address was found through the NCOA search.',
    `ncoa_search_date` DATE COMMENT 'Date when the NCOA search was performed.',
    `ncoa_search_performed_flag` BOOLEAN COMMENT 'Indicates whether a National Change of Address search was performed to locate a new address.',
    `notes` STRING COMMENT 'Free-text notes documenting follow-up actions, findings, or additional context related to the returned mail.',
    `original_mail_date` DATE COMMENT 'Date when the original correspondence was sent to the policyholder.',
    `policy_status_at_return` STRING COMMENT 'Status of the policy at the time the mail was returned.. Valid values are `active|lapsed|grace_period|paid_up|surrendered|matured`',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this returned mail event requires reporting to regulatory authorities (e.g., NAIC lost policyholder reporting).',
    `resolution_date` DATE COMMENT 'Date when the returned mail issue was resolved and valid contact was re-established.',
    `resolution_status` STRING COMMENT 'Current status of efforts to resolve the returned mail issue and re-establish contact with the policyholder.. Valid values are `open|in_progress|resolved|closed|escalated`',
    `return_date` DATE COMMENT 'Date when the mail was returned as undeliverable.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating why the mail was returned (e.g., address unknown, moved with no forwarding address, refused, deceased). [ENUM-REF-CANDIDATE: address_unknown|moved_no_forwarding|refused|deceased|insufficient_address|unclaimed|forwarding_expired — 7 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed description of the reason the mail was returned, including any additional notes from the postal service.',
    `skip_trace_initiated_flag` BOOLEAN COMMENT 'Indicates whether skip tracing services were initiated to locate the policyholder.',
    `skip_trace_vendor` STRING COMMENT 'Name of the third-party vendor used for skip tracing services.',
    `source_system` STRING COMMENT 'Name of the source system that generated or captured the returned mail record.',
    `tracking_number` STRING COMMENT 'Postal service tracking number for the returned mail piece, if available.',
    `unclaimed_property_notification_date` DATE COMMENT 'Date when the state unclaimed property office was notified of the lost policyholder.',
    `unclaimed_property_state` STRING COMMENT 'State to which unclaimed property was reported or will be escheated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the returned mail record was last updated.',
    CONSTRAINT pk_returned_mail PRIMARY KEY(`returned_mail_id`)
) COMMENT 'Transactional record of every outbound notice or correspondence item returned as undeliverable by the postal service or electronic channel. Captures the original outbound notice, the return date, the return reason code (address unknown, moved no forwarding, refused, deceased), the last known address used, and the follow-up action taken (address search initiated, skip tracing, state unclaimed property notification). Supports NAIC lost policyholder search obligations and state unclaimed property compliance workflows.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`address_search` (
    `address_search_id` BIGINT COMMENT 'Unique identifier for the address search transaction.',
    `employee_id` BIGINT COMMENT 'User identifier of the staff member who reviewed the search results.',
    `in_force_policy_id` BIGINT COMMENT 'Identifier of the policy for which the address search was initiated.',
    `party_id` BIGINT COMMENT 'Identifier of the policyholder or beneficiary whose address is being searched.',
    `returned_mail_id` BIGINT COMMENT 'Foreign key linking to correspondence.returned_mail. Business justification: Link address search to the returned mail event that triggered it. Essential for tracking address search triggers and returned mail resolution.',
    `prior_address_search_id` BIGINT COMMENT 'Self-referencing FK on address_search (prior_address_search_id)',
    `address_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score or quality indicator for the updated address provided by the search vendor.',
    `address_effective_date` DATE COMMENT 'Date from which the updated address is considered effective.',
    `address_found_flag` BOOLEAN COMMENT 'Indicator of whether a valid updated address was found during the search.',
    `address_update_action` STRING COMMENT 'Action taken as a result of the address search outcome.. Valid values are `updated|no_action|manual_review|escalated|escheatment_initiated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address search record was first created in the system.',
    `deceased_date` DATE COMMENT 'Date of death if confirmed during the address search.',
    `deceased_indicator` BOOLEAN COMMENT 'Flag indicating whether the search confirmed the individual is deceased.',
    `escheatment_risk_flag` BOOLEAN COMMENT 'Indicator of whether this policy is at risk of state escheatment due to lost contact.',
    `manual_review_required_flag` BOOLEAN COMMENT 'Indicator of whether the search results require manual review by operations staff.',
    `original_address_line1` STRING COMMENT 'First line of the original address that was returned as undeliverable.',
    `original_address_line2` STRING COMMENT 'Second line of the original address that was returned as undeliverable.',
    `original_city` STRING COMMENT 'City of the original address that was returned as undeliverable.',
    `original_country_code` STRING COMMENT 'Three-letter ISO country code of the original address that was returned as undeliverable.. Valid values are `^[A-Z]{3}$`',
    `original_postal_code` STRING COMMENT 'Postal code of the original address that was returned as undeliverable.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `original_state` STRING COMMENT 'State or province of the original address that was returned as undeliverable.',
    `returned_mail_date` DATE COMMENT 'Date when the mail was returned as undeliverable, triggering the address search.',
    `review_completion_date` DATE COMMENT 'Date when the manual review of the search results was completed.',
    `search_completion_date` DATE COMMENT 'Date when the address search was completed or closed.',
    `search_cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred for the address search service from the vendor.',
    `search_initiation_date` DATE COMMENT 'Date when the address search was initiated.',
    `search_notes` STRING COMMENT 'Free-text notes or comments regarding the address search activity and results.',
    `search_reason_code` STRING COMMENT 'Business reason for initiating the address search activity.. Valid values are `returned_mail|death_claim|escheatment_prevention|beneficiary_search|policy_servicing|regulatory_compliance`',
    `search_request_reference_number` STRING COMMENT 'External reference number or transaction ID provided by the search vendor.',
    `search_result_code` STRING COMMENT 'Outcome code indicating the result of the address search activity.. Valid values are `address_found|no_address_found|deceased_confirmed|multiple_matches|insufficient_data|error`',
    `search_status` STRING COMMENT 'Current status of the address search transaction.. Valid values are `initiated|in_progress|completed|failed|cancelled`',
    `search_type` STRING COMMENT 'Type of address search or skip-tracing method employed.. Valid values are `ncoa|skip_trace|dmf_cross_reference|credit_header|public_records|manual_research`',
    `search_vendor` STRING COMMENT 'Third-party vendor or service used to perform the address search or skip-tracing activity. [ENUM-REF-CANDIDATE: lexisnexis|usps_ncoa|ssa_dmf|accurint|experian|transunion|internal|other — 8 candidates stripped; promote to reference product]',
    `state_reporting_jurisdiction` STRING COMMENT 'State jurisdiction to which unclaimed property would be reported if address search fails.',
    `updated_address_line1` STRING COMMENT 'First line of the updated address found through the search.',
    `updated_address_line2` STRING COMMENT 'Second line of the updated address found through the search.',
    `updated_city` STRING COMMENT 'City of the updated address found through the search.',
    `updated_country_code` STRING COMMENT 'Three-letter ISO country code of the updated address found through the search.. Valid values are `^[A-Z]{3}$`',
    `updated_postal_code` STRING COMMENT 'Postal code of the updated address found through the search.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `updated_state` STRING COMMENT 'State or province of the updated address found through the search.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the address search record was last modified.',
    CONSTRAINT pk_address_search PRIMARY KEY(`address_search_id`)
) COMMENT 'Transactional record of address search and skip-tracing activities initiated when policyholder or beneficiary mail is returned as undeliverable. Captures the search initiation date, search vendor used (LexisNexis, USPS NCOA, SSA Death Master File cross-reference), search results, updated address found, and the resulting address update action. Supports NAIC model regulation requirements for lost policyholder search and state unclaimed property escheatment prevention workflows.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`secure_message` (
    `secure_message_id` BIGINT COMMENT 'Unique identifier for the secure portal message record. Primary key for the secure message entity.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link secure message to channel master. Replaces STRING channel code with FK to comm_channel for proper channel tracking.',
    `comm_template_id` BIGINT COMMENT 'Reference to the message template used to generate this message, if applicable. Null for free-form messages. Enables tracking of template usage and effectiveness.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to correspondence.complaint. Business justification: Link secure message to resulting complaint. Essential for tracking complaint origination from secure portal messages.',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Secure sponsor portals enable enrollment file submission, report requests, and plan administration communications. Tracking sponsor-specific secure messages supports audit trails for enrollment change',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this secure message. Links the message to the specific policy context being discussed.',
    `parent_message_secure_message_id` BIGINT COMMENT 'Reference to the message being replied to. Null for initial messages in a thread. Enables hierarchical conversation structure.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Policyholders with variable products use secure portal messaging to inquire about portfolio performance, request fund transfers, review investment elections, and ask allocation questions. Portfolio co',
    `employee_id` BIGINT COMMENT 'Authenticated portal user identifier of the message sender. Captures the specific login credential used to send the message.',
    `party_id` BIGINT COMMENT 'Reference to the party record of the message sender. Links to policyholder, agent, or other party entity based on sender_type.',
    `service_request_id` BIGINT COMMENT 'Reference to the service request case associated with this secure message, if applicable. Enables tracking of messages related to specific service inquiries or policy servicing actions.',
    `tertiary_secure_compliance_reviewer_employee_id` BIGINT COMMENT 'Employee identifier of the compliance officer who reviewed the message. Null if no review occurred. Supports audit trail for supervised communications.',
    `message_thread_id` BIGINT COMMENT 'Identifier linking this message to a conversation thread. Multiple messages with the same thread_id form a single conversation chain.',
    `reply_to_secure_message_id` BIGINT COMMENT 'Self-referencing FK on secure_message (reply_to_secure_message_id)',
    `archived_timestamp` TIMESTAMP COMMENT 'Date and time when the message was moved to archived status by the user. Null if the message is still active. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `attachment_count` STRING COMMENT 'Number of file attachments included with this message. Zero indicates no attachments. Actual attachment metadata stored in related attachment entity.',
    `auto_response_flag` BOOLEAN COMMENT 'Indicator that the message was generated automatically by the system rather than composed by a human user. True for automated acknowledgments and system notifications.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicator that the message requires compliance review before delivery or archival. True for messages flagged by content scanning or business rules.',
    `compliance_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when compliance review was completed for this message. Null if review has not occurred or is not required. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the message record was first created in the system. Represents the initial capture of the message data. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the message was successfully delivered to the recipients inbox. Null if delivery has not yet occurred. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `device_type` STRING COMMENT 'Type of device used to send the message. Supports analytics on customer communication preferences and digital experience optimization.. Valid values are `desktop|mobile|tablet`',
    `encryption_method` STRING COMMENT 'Encryption standard applied to the message content during transmission and storage. Ensures compliance with data protection requirements.. Valid values are `AES256|TLS1.2|TLS1.3`',
    `has_sensitive_content_flag` BOOLEAN COMMENT 'Indicator that the message contains sensitive information requiring additional security controls. True if message contains PHI, PII, or financial data requiring enhanced protection.',
    `ip_address` STRING COMMENT 'IP address from which the message was sent. Captured for security, fraud detection, and audit purposes.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the language in which the message was written. Supports multilingual customer service and compliance reporting.. Valid values are `ENG|SPA|FRA|CHI|GER|JPN`',
    `message_body` STRING COMMENT 'Full text content of the secure message. Contains the complete communication exchanged between parties through the authenticated portal.',
    `message_category` STRING COMMENT 'Business classification of the message topic. Enables routing, reporting, and analytics on message types and customer service patterns.. Valid values are `policy_inquiry|billing_question|claim_status|beneficiary_change|address_update|general_inquiry`',
    `message_number` STRING COMMENT 'Business-friendly unique identifier for the secure message, displayed to users and agents. Format: SM followed by 10 digits.. Valid values are `^SM[0-9]{10}$`',
    `priority` STRING COMMENT 'Priority level assigned to the message. Determines urgency of response and routing to appropriate service teams.. Valid values are `low|normal|high|urgent`',
    `read_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient first opened and viewed the message. Null if the message has not been read. Used for read receipt tracking and SLA monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `recipient_name` STRING COMMENT 'Full name of the message recipient as displayed in the portal. Captured at time of message creation for audit and display purposes.',
    `recipient_type` STRING COMMENT 'Classification of the message recipient role. Indicates whether the message is directed to a policyholder, beneficiary, agent, company representative, or automated system.. Valid values are `policyholder|beneficiary|agent|company|system`',
    `replied_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient sent a reply to this message. Null if no reply has been sent. Used for response time tracking and service quality metrics. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `retention_category` STRING COMMENT 'Data retention classification determining how long the message must be preserved. Aligns with regulatory requirements and litigation hold policies.. Valid values are `standard|extended|legal_hold|permanent`',
    `retention_expiration_date` DATE COMMENT 'Date when the message becomes eligible for deletion based on retention policy. Null for messages under legal hold or permanent retention. Format: yyyy-MM-dd',
    `secure_message_status` STRING COMMENT 'Current lifecycle status of the secure message. Tracks the message state from creation through delivery, reading, and archival. [ENUM-REF-CANDIDATE: draft|sent|delivered|read|replied|archived|deleted — 7 candidates stripped; promote to reference product]',
    `sender_name` STRING COMMENT 'Full name of the message sender as displayed in the portal. Captured at time of message creation for audit and display purposes.',
    `sender_type` STRING COMMENT 'Classification of the message sender role. Indicates whether the message originated from a policyholder, beneficiary, agent, company representative, or automated system.. Valid values are `policyholder|beneficiary|agent|company|system`',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the message was sent by the sender. Represents the business event time when the message entered the delivery queue. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `session_code` STRING COMMENT 'Unique identifier for the authenticated portal session during which the message was sent. Enables correlation with session analytics and security monitoring.',
    `subject` STRING COMMENT 'Subject line or title of the secure message. Provides a brief summary of the message content for inbox display and search.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the message record was last modified. Tracks any changes to message metadata or status. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    CONSTRAINT pk_secure_message PRIMARY KEY(`secure_message_id`)
) COMMENT 'Transactional record of every secure portal message exchanged between policyholders, agents, or beneficiaries and Life Insurance through the authenticated online portal or mobile application. Captures message thread identity, sender, recipient, subject, message body reference, sent timestamp, read timestamp, and associated policy or service request. Distinct from call_record (phone channel) and inbound_correspondence (physical/email channel) — this entity owns the authenticated digital messaging channel interactions.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` (
    `comm_preference_id` BIGINT COMMENT 'Unique identifier for the communication preference record.',
    `in_force_policy_id` BIGINT COMMENT 'Optional reference to a specific policy contract when preferences are policy-specific rather than party-wide.',
    `party_address_id` BIGINT COMMENT 'Reference to the postal address to which paper correspondence should be mailed.',
    `party_id` BIGINT COMMENT 'Reference to the stakeholder party (policyholder, beneficiary, agent, or other stakeholder) for whom these correspondence preferences are defined.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link communication preference to the preferred channel master. Replaces STRING preferred_channel code with FK to comm_channel for proper channel management and preference enforcement.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Producers have communication preferences for receiving commission statements, compliance alerts, licensing renewal notices, and company announcements. Business operations requirement for agent servici',
    `superseded_comm_preference_id` BIGINT COMMENT 'Self-referencing FK on comm_preference (superseded_comm_preference_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this preference record was first created in the system.',
    `do_not_contact` BOOLEAN COMMENT 'Master suppression flag indicating the party has requested no contact for any non-essential correspondence.',
    `do_not_contact_reason` STRING COMMENT 'Free-text explanation of why the party requested do-not-contact status.',
    `e_delivery_consent_method` STRING COMMENT 'Method by which the party provided consent for electronic delivery: online portal, mobile app, paper form, phone IVR, or agent-assisted enrollment.. Valid values are `online_portal|mobile_app|paper_form|phone_ivr|agent_assisted`',
    `e_delivery_enrolled` BOOLEAN COMMENT 'Indicates whether the party has enrolled in electronic delivery for correspondence, suppressing paper mail for enrolled notice categories.',
    `e_delivery_enrollment_date` DATE COMMENT 'Date on which the party enrolled in electronic delivery for this notice category.',
    `effective_date` DATE COMMENT 'Date on which this preference election becomes effective and should be applied by the correspondence routing engine.',
    `email_address` STRING COMMENT 'The email address to which electronic correspondence should be sent for this preference record.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expiration_date` DATE COMMENT 'Date on which this preference election expires and should no longer be applied, if applicable.',
    `format_preference` STRING COMMENT 'Preferred format for correspondence delivery: standard print, large print for vision accessibility, braille, or audio format.. Valid values are `standard|large_print|braille|audio`',
    `frequency_preference` STRING COMMENT 'Preferred frequency for non-urgent correspondence: immediate delivery, daily digest, weekly digest, or monthly digest.. Valid values are `immediate|daily_digest|weekly_digest|monthly_digest`',
    `language_preference` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the preferred language for correspondence (e.g., ENG for English, SPA for Spanish, FRA for French).. Valid values are `^[A-Z]{3}$`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this preference record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this preference record was last modified.',
    `last_verified_date` DATE COMMENT 'Date on which the preference was last verified or confirmed by the party, used for compliance and data quality tracking.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the party has opted in to receive marketing and promotional communications.',
    `marketing_opt_in_date` DATE COMMENT 'Date on which the party opted in to marketing communications.',
    `marketing_opt_out_date` DATE COMMENT 'Date on which the party opted out of marketing communications, if applicable.',
    `mobile_phone_number` STRING COMMENT 'The mobile phone number to which SMS or mobile app notifications should be sent.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this preference election, including special handling instructions or context.',
    `notice_category` STRING COMMENT 'Category of correspondence to which this preference applies: billing notices, policy change notifications, regulatory disclosures, claims correspondence, marketing communications, or general service notices.. Valid values are `billing|policy_change|regulatory|claims|marketing|service`',
    `phone_contact_consent` BOOLEAN COMMENT 'Indicates whether the party has consented to be contacted by phone for service or marketing purposes.',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record: active (in use), inactive (superseded), pending verification (awaiting confirmation), or expired (no longer valid).. Valid values are `active|inactive|pending_verification|expired`',
    `preference_type` STRING COMMENT 'Scope of the preference record: party-level (applies to all policies), policy-level (specific policy), product-level (all policies of a product type), or notice-category-level (specific notice type).. Valid values are `party_level|policy_level|product_level|notice_category_level`',
    `secondary_channel` STRING COMMENT 'Fallback communication channel to be used if the preferred channel fails or is unavailable.. Valid values are `postal_mail|email|sms|portal|mobile_app|fax`',
    `sms_consent` BOOLEAN COMMENT 'Indicates whether the party has provided explicit consent to receive SMS text messages, as required by TCPA regulations.',
    `sms_consent_date` DATE COMMENT 'Date on which the party provided SMS consent.',
    `source_system` STRING COMMENT 'Name of the operational system from which this preference record originated (e.g., Policy Administration System, CRM, Customer Portal).',
    `source_system_code` STRING COMMENT 'Unique identifier of this preference record in the source operational system.',
    `suppress_duplicate_notices` BOOLEAN COMMENT 'Flag indicating whether duplicate or redundant notices should be suppressed when the party holds multiple policies or roles.',
    `third_party_disclosure_consent` BOOLEAN COMMENT 'Indicates whether the party has consented to disclosure of their information to third parties for marketing or service purposes.',
    `verification_method` STRING COMMENT 'Method by which the preference was verified: email confirmation link, phone verification call, postal confirmation, portal login, or agent-assisted verification.. Valid values are `email_confirmation|phone_verification|postal_confirmation|portal_login|agent_verification`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this preference record.',
    CONSTRAINT pk_comm_preference PRIMARY KEY(`comm_preference_id`)
) COMMENT 'Master record storing the correspondence-specific communication channel preferences and consent elections for each stakeholder party — distinct from policyholder.communication_preference which owns the enterprise-wide preference SSOT. This entity owns the operational correspondence routing instructions derived from the enterprise preference record, including preferred channel for each notice category (billing, policy change, regulatory, marketing), e-delivery enrollment status for correspondence, opt-out flags, and the effective date of each preference election. Used by the outbound notice generation engine to route each notice to the correct channel.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`escalation` (
    `escalation_id` BIGINT COMMENT 'Unique identifier for the escalation event. Primary key.',
    `claim_id` BIGINT COMMENT 'Reference to the claim associated with this escalation, if applicable.',
    `communication_id` BIGINT COMMENT 'Reference to the originating communication or correspondence item that triggered this escalation.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee to whom the escalation has been assigned for resolution.',
    `escalation_escalated_by_user_employee_id` BIGINT COMMENT 'Reference to the user or employee who initiated the escalation.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this escalation, if applicable.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder involved in this escalation.',
    `queue_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_queue. Business justification: Link escalation to the queue it was escalated to. Replaces STRING escalated_to_department with FK to queue master for proper escalation routing and tracking.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_sla. Business justification: Link escalation to the SLA rule that was breached. Essential for SLA breach analysis and escalation management.',
    `escalated_from_escalation_id` BIGINT COMMENT 'Self-referencing FK on escalation (escalated_from_escalation_id)',
    `actual_resolution_date` DATE COMMENT 'Actual date when the escalation was resolved and closed.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions implemented to address the root cause and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this escalation record was first created in the system for audit trail purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_rating` STRING COMMENT 'Customer satisfaction score provided after escalation resolution, typically on a scale of 1 to 5 or 1 to 10.',
    `escalation_category` STRING COMMENT 'Business category of the escalation indicating the functional area involved (service quality, claims handling, underwriting decision, billing dispute, policy servicing, agent conduct).. Valid values are `service_quality|claims_handling|underwriting_decision|billing_dispute|policy_servicing|agent_conduct`',
    `escalation_date` DATE COMMENT 'Date when the escalation was formally triggered and recorded in the system.',
    `escalation_level` STRING COMMENT 'Organizational level to which the escalation has been routed (supervisor, manager, director, executive, legal, compliance, regulatory). [ENUM-REF-CANDIDATE: supervisor|manager|director|executive|legal|compliance|regulatory — 7 candidates stripped; promote to reference product]',
    `escalation_number` STRING COMMENT 'Business-facing unique escalation case number used for tracking and reference in correspondence and regulatory reporting.',
    `escalation_status` STRING COMMENT 'Current lifecycle status of the escalation case (open, assigned, in progress, pending review, resolved, closed, reopened). [ENUM-REF-CANDIDATE: open|assigned|in_progress|pending_review|resolved|closed|reopened — 7 candidates stripped; promote to reference product]',
    `escalation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the escalation event was created, used for Service Level Agreement (SLA) tracking and audit trails.',
    `escalation_type` STRING COMMENT 'Classification of the escalation event based on the nature of the issue (complaint, Service Level Agreement breach, regulatory inquiry, litigation risk, executive review, fraud suspicion).. Valid values are `complaint|sla_breach|regulatory_inquiry|litigation_risk|executive_review|fraud_suspicion`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary value of the financial impact or settlement associated with this escalation (e.g., refund issued, claim adjustment, goodwill payment).',
    `is_litigation_risk` BOOLEAN COMMENT 'Indicates whether this escalation has been flagged as a potential litigation risk requiring legal department review.',
    `is_regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this escalation must be reported to state insurance departments or other regulatory bodies per National Association of Insurance Commissioners (NAIC) requirements.',
    `legal_review_date` DATE COMMENT 'Date when the legal department completed their review of this escalation.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this escalation requires formal review by the legal department before resolution.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context related to the escalation case.',
    `priority` STRING COMMENT 'Priority level assigned to the escalation for queue management and resource allocation (low, medium, high, urgent).. Valid values are `low|medium|high|urgent`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or state Department of Insurance involved in or notified of this escalation, if applicable.',
    `regulatory_reference_number` STRING COMMENT 'External reference number assigned by the regulatory body for tracking this escalation or complaint.',
    `resolution_code` STRING COMMENT 'Standardized code indicating the resolution outcome or disposition type (e.g., customer satisfied, policy adjusted, claim approved, no action required).',
    `resolution_summary` STRING COMMENT 'Detailed narrative describing the actions taken to resolve the escalation and the final outcome.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the escalation was marked as resolved, used for Service Level Agreement (SLA) performance measurement.',
    `root_cause_category` STRING COMMENT 'High-level category identifying the root cause of the escalation (e.g., system error, process failure, agent error, policy ambiguity).',
    `root_cause_description` STRING COMMENT 'Detailed narrative describing the underlying root cause identified during escalation investigation.',
    `severity_level` STRING COMMENT 'Severity classification of the escalation indicating the business impact and urgency (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `sla_breach_hours` DECIMAL(18,2) COMMENT 'Number of hours by which the escalation exceeded the Service Level Agreement (SLA) threshold, if applicable.',
    `target_resolution_date` DATE COMMENT 'Target date by which the escalation must be resolved based on Service Level Agreement (SLA) or regulatory requirements.',
    `trigger_reason` STRING COMMENT 'Detailed explanation of the specific event or condition that triggered the escalation (e.g., SLA threshold exceeded, regulatory body contact, customer threat of litigation).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this escalation record was last modified for audit trail and data lineage purposes.',
    CONSTRAINT pk_escalation PRIMARY KEY(`escalation_id`)
) COMMENT 'Transactional record capturing formal escalation events within the correspondence and complaint handling workflow — triggered when a complaint, inbound correspondence item, or service interaction exceeds SLA thresholds, involves regulatory body contact, requires executive review, or is flagged as a potential litigation risk. Captures the escalation trigger, escalation level (supervisor, manager, legal, executive, regulatory), escalation date, assigned escalation owner, resolution target date, and final resolution. Enables management oversight of high-risk correspondence and supports regulatory examination readiness.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`sla` (
    `sla_id` BIGINT COMMENT 'Unique identifier for the correspondence SLA definition record.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link SLA rule to channel master. SLA rules are channel-specific. Replaces STRING channel code with FK to comm_channel.',
    `employee_id` BIGINT COMMENT 'User ID of the person who approved this SLA definition for activation.',
    `superseded_by_sla_id` BIGINT COMMENT 'Reference to the correspondence_sla_id that supersedes this SLA definition when a new version is created. Null if this is the current version.',
    `superseded_sla_id` BIGINT COMMENT 'Self-referencing FK on sla (superseded_sla_id)',
    `acknowledgment_window_days` STRING COMMENT 'Number of business days within which the correspondence must be acknowledged (e.g., 2 business days for complaint acknowledgment).',
    `acknowledgment_window_unit` STRING COMMENT 'Unit of time for the acknowledgment window (business days, calendar days, or hours).. Valid values are `business_days|calendar_days|hours`',
    `approval_date` DATE COMMENT 'Date on which this SLA definition was formally approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this SLA definition requires formal approval before activation (True/False).',
    `auto_escalation_flag` BOOLEAN COMMENT 'Indicates whether correspondence matching this SLA should be automatically escalated when the escalation threshold is reached (True/False).',
    `business_hours_only_flag` BOOLEAN COMMENT 'Indicates whether SLA time calculations should only count business hours (True) or run continuously (False).',
    `correspondence_category` STRING COMMENT 'The category of correspondence to which this SLA applies (e.g., complaint acknowledgment, regulatory inquiry response, inbound service letter, DOI inquiry).. Valid values are `complaint_acknowledgment|regulatory_inquiry_response|inbound_service_letter|doi_inquiry|policy_service_request|claim_correspondence`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this SLA definition becomes effective and applicable to correspondence.',
    `escalation_queue_code` STRING COMMENT 'Code identifying the work queue to which correspondence should be escalated when the threshold is reached.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `escalation_threshold_days` STRING COMMENT 'Number of days before the resolution deadline at which the correspondence should be escalated to management or specialized teams.',
    `escalation_threshold_unit` STRING COMMENT 'Unit of time for the escalation threshold (business days, calendar days, or hours).. Valid values are `business_days|calendar_days|hours`',
    `exclude_holidays_flag` BOOLEAN COMMENT 'Indicates whether holidays should be excluded from SLA time calculations (True/False).',
    `expiration_date` DATE COMMENT 'Date on which this SLA definition expires or is superseded by a new version. Null indicates no expiration.',
    `jurisdiction_code` STRING COMMENT 'Two-letter state or jurisdiction code where the SLA applies (e.g., CA, NY, TX). Federal regulations use US.. Valid values are `^[A-Z]{2}$`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this SLA definition.',
    `notification_template_code` STRING COMMENT 'Code identifying the notification template to be used for acknowledgment or escalation communications.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `priority_level` STRING COMMENT 'Default priority level assigned to correspondence matching this SLA category (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `regulatory_reference` STRING COMMENT 'Citation of the state or federal regulation mandating this SLA (e.g., CA Insurance Code Section 790.03, NAIC Model Regulation 42).',
    `requires_compliance_review_flag` BOOLEAN COMMENT 'Indicates whether correspondence matching this SLA requires compliance department review (True/False).',
    `requires_legal_review_flag` BOOLEAN COMMENT 'Indicates whether correspondence matching this SLA requires legal department review (True/False).',
    `requires_management_review_flag` BOOLEAN COMMENT 'Indicates whether correspondence matching this SLA requires mandatory management review before closure (True/False).',
    `resolution_window_days` STRING COMMENT 'Number of days within which the correspondence must be fully resolved or responded to (e.g., 30 calendar days for regulatory inquiry response).',
    `resolution_window_unit` STRING COMMENT 'Unit of time for the resolution window (business days, calendar days, or hours).. Valid values are `business_days|calendar_days|hours`',
    `sla_code` STRING COMMENT 'Business identifier code for the SLA rule (e.g., COMPLAINT_ACK, DOI_INQUIRY_RESP, INBOUND_SVC_LETTER).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `sla_name` STRING COMMENT 'Human-readable name of the SLA standard (e.g., Complaint Acknowledgment SLA, Regulatory Inquiry Response SLA).',
    `sla_status` STRING COMMENT 'Current status of the SLA definition (active, inactive, suspended, pending approval).. Valid values are `active|inactive|suspended|pending_approval`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA definition record was last modified.',
    `version_number` STRING COMMENT 'Version number of this SLA definition, incremented when the SLA is updated or revised.',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Reference master defining the service level agreement (SLA) standards governing correspondence handling timeframes by correspondence type, channel, and jurisdiction. Captures the correspondence category (complaint acknowledgment, regulatory inquiry response, inbound service letter, DOI inquiry), the required acknowledgment window (e.g., 2 business days), the required resolution window (e.g., 30 calendar days), the applicable state or federal regulation mandating the SLA, and escalation trigger thresholds. Used by queue_assignment and escalation entities to enforce and monitor compliance with correspondence handling obligations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` (
    `doi_inquiry_id` BIGINT COMMENT 'Unique identifier for the regulatory inquiry record. Primary key for the DOI inquiry entity.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: Regulators frequently inquire about specific assumption sets during examinations, particularly when assumptions change materially or differ from industry norms. DOI inquiries require justification of ',
    `claim_id` BIGINT COMMENT 'Reference to the claim that is the subject of the regulatory inquiry, if applicable.',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: DOI inquiries frequently arise from or result in specific exam findings requiring follow-up. Real business process: regulatory examination workflow linking inquiries to formal findings for tracking an',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy that is the subject of the regulatory inquiry, if applicable.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: State DOI inquiries arrive as formal documents (complaint letters, market conduct exam requests, subpoenas, information requests) that must be retained per state regulatory requirements. Regulatory af',
    `market_conduct_exam_id` BIGINT COMMENT 'Reference to a related market conduct examination if this inquiry is part of or follow-up to a broader examination.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder who is the subject of or complainant in the regulatory inquiry.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Department of Insurance inquiries frequently target specific products for market conduct review, rate justification, or consumer protection investigations. Product linkage is mandatory for regulatory ',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: State DOI market conduct exams and inquiries about investment practices, suitability reviews, fee disclosures, and performance representations require portfolio-level investigation. Regulatory affairs',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: State DOI inquiries frequently target specific producers for licensing issues, appointment irregularities, consumer complaints, or market conduct violations. Required for regulatory response managemen',
    `queue_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_queue. Business justification: Link DOI inquiry to handling queue. Replaces STRING assigned_department with FK to queue master for proper queue management and regulatory inquiry tracking.',
    `rbc_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.rbc_filing. Business justification: DOI inquiries often question RBC calculations, capital adequacy, or action-level triggers shown in specific RBC filings. Real business process: regulatory capital review where examiner references spec',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: DOI inquiries often reference specific regulatory filings under examination (RBC, ORSA, annual statements). Real business process: regulatory inquiry response linking to source filing documentation fo',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: DOI inquiries may focus on specific riders (LTC acceleration, disability waivers, guaranteed insurability) requiring rider-level documentation, justification, and regulatory response. Essential for re',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_filing. Business justification: DOI market conduct exams and inquiries frequently reference specific statutory filings (e.g., "Explain reserve methodology shown in 2023 Annual Statement Schedule E"). Real business process: regulator',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: DOI market conduct exams and regulatory inquiries frequently reference specific valuation runs when questioning reserve adequacy, methodology changes, or assumption updates. Examiners cite valuation r',
    `related_doi_inquiry_id` BIGINT COMMENT 'Self-referencing FK on doi_inquiry (related_doi_inquiry_id)',
    `assigned_regulatory_affairs_contact` STRING COMMENT 'The name or identifier of the internal regulatory affairs representative assigned to manage and respond to this inquiry.',
    `attachment_count` STRING COMMENT 'The number of documents or attachments associated with the inquiry (e.g., correspondence, evidence, supporting documentation).',
    `complainant_contact_info` STRING COMMENT 'Contact information (phone, email, or address) for the complainant, if provided by the regulatory body.',
    `complainant_name` STRING COMMENT 'The name of the individual or entity who filed the complaint with the regulatory body, if applicable.',
    `corrective_action_completion_date` DATE COMMENT 'The date the required corrective actions were completed and verified.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective actions required or taken by the company in response to the regulatory inquiry.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether the regulatory body required the company to take corrective action as a result of the inquiry.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the DOI inquiry record was first created in the system.',
    `disposition_date` DATE COMMENT 'The date the regulatory body issued its final disposition or closed the inquiry.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the inquiry has been escalated to senior management, legal counsel, or enforcement proceedings.',
    `escalation_reason` STRING COMMENT 'The reason for escalating the inquiry (e.g., potential enforcement action, significant financial exposure, reputational risk).',
    `final_disposition` STRING COMMENT 'The final outcome or resolution of the regulatory inquiry as determined by the regulatory body (e.g., resolved with no action, resolved with corrective action, upheld complaint, dismissed).. Valid values are `resolved_no_action|resolved_with_corrective_action|upheld_complaint|dismissed|pending|escalated_to_enforcement`',
    `fine_or_penalty_amount` DECIMAL(18,2) COMMENT 'The monetary fine or penalty amount assessed by the regulatory body as a result of the inquiry, if applicable.',
    `fine_payment_date` DATE COMMENT 'The date the fine or penalty was paid to the regulatory body.',
    `inquiry_category` STRING COMMENT 'The business function or subject matter category of the inquiry (e.g., claims handling, underwriting practices, policy servicing, premium billing, agent conduct). [ENUM-REF-CANDIDATE: claims_handling|underwriting_practices|policy_servicing|premium_billing|agent_conduct|disclosure_compliance|unfair_practices|other — 8 candidates stripped; promote to reference product]',
    `inquiry_description` STRING COMMENT 'Detailed description of the regulatory inquiry, including the specific allegations, questions, or information requests from the regulatory body.',
    `inquiry_received_date` DATE COMMENT 'The date the regulatory inquiry was received by the company from the regulatory body.',
    `inquiry_reference_number` STRING COMMENT 'The external reference number or case number assigned by the regulatory body (DOI, CFPB, FINRA, SEC) to this inquiry.',
    `inquiry_status` STRING COMMENT 'Current lifecycle status of the regulatory inquiry (e.g., received, under review, response drafted, response submitted, closed, escalated). [ENUM-REF-CANDIDATE: received|under_review|response_drafted|response_submitted|closed|escalated|pending_additional_info — 7 candidates stripped; promote to reference product]',
    `inquiry_subject` STRING COMMENT 'Brief subject line or title summarizing the nature of the regulatory inquiry.',
    `inquiry_type` STRING COMMENT 'Classification of the regulatory inquiry type (e.g., consumer complaint, market conduct inquiry, regulatory investigation, information request).. Valid values are `consumer_complaint|market_conduct_inquiry|regulatory_investigation|information_request|examination_follow_up|enforcement_action`',
    `internal_notes` STRING COMMENT 'Internal notes and comments regarding the inquiry, investigation, and response process for audit and tracking purposes.',
    `investigation_completion_date` DATE COMMENT 'The date the internal investigation related to the inquiry was completed.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether an internal investigation is required to respond to the regulatory inquiry.',
    `legal_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether internal or external legal counsel was involved in responding to the inquiry.',
    `priority_level` STRING COMMENT 'The urgency or priority level assigned to the inquiry based on regulatory impact, deadline, and subject matter severity.. Valid values are `critical|high|medium|low`',
    `regulatory_body` STRING COMMENT 'The regulatory authority or governing body that initiated the inquiry (e.g., State Department of Insurance, CFPB, FINRA, SEC). [ENUM-REF-CANDIDATE: state_doi|naic|cfpb|finra|sec|irs|dol|fincen|other — 9 candidates stripped; promote to reference product]',
    `response_due_date` DATE COMMENT 'The deadline date by which the company must submit a response to the regulatory body.',
    `response_method` STRING COMMENT 'The method or channel used to submit the response to the regulatory body (e.g., email, regulatory portal, mail, fax).. Valid values are `email|portal|mail|fax|in_person`',
    `response_submitted_date` DATE COMMENT 'The date the company submitted its formal response to the regulatory inquiry.',
    `response_summary` STRING COMMENT 'Summary of the companys response to the regulatory inquiry, including key findings, actions taken, and resolution details.',
    `state_jurisdiction` STRING COMMENT 'The two-letter state code of the Department of Insurance jurisdiction that issued the inquiry (e.g., CA, NY, TX).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the DOI inquiry record was last updated in the system.',
    CONSTRAINT pk_doi_inquiry PRIMARY KEY(`doi_inquiry_id`)
) COMMENT 'Master and transactional record for formal inquiries and complaints received directly from state Departments of Insurance (DOI) or other regulatory bodies (CFPB, FINRA, SEC) regarding policyholder complaints, market conduct matters, or regulatory investigations. Captures the regulatory body, inquiry reference number, inquiry date, subject matter, associated policyholder or policy, assigned regulatory affairs contact, response deadline, response submitted date, and final disposition. Distinct from compliance.market_conduct_exam (which tracks full examination proceedings) — this entity owns individual regulatory inquiry correspondence.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`doi_response` (
    `doi_response_id` BIGINT COMMENT 'Unique identifier for each formal response submitted to a state Department of Insurance or regulatory body. Primary key for the doi_response product.',
    `annuity_contract_id` BIGINT COMMENT 'Reference to the annuity contract that is the subject of this regulatory response, if applicable.',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: DOI responses must cite specific assumption sets when justifying actuarial methods, explaining reserve changes, or responding to assumption-related inquiries. Responses document which assumption set w',
    `claim_id` BIGINT COMMENT 'Reference to the claim that is the subject of this regulatory response, if applicable.',
    `doi_inquiry_id` BIGINT COMMENT 'Reference to the original DOI inquiry or complaint that this response addresses. Links the response to the initiating regulatory inquiry.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy that is the subject of this regulatory response, if applicable.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: DOI responses must reference the specific product under inquiry for regulatory compliance, audit trail completeness, and ensuring response accuracy. Essential for regulatory compliance, market conduct',
    `employee_id` BIGINT COMMENT 'System user identifier of the employee who executed the submission of the response in the correspondence management system.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: DOI responses about producer licensing status, appointment verification, compliance history, or disciplinary actions require producer context. Essential for regulatory reporting and producer complianc',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Link DOI response to the communication record that delivered it. Essential for tracking regulatory response delivery and audit trail.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Responses to DOI inquiries are formal documents (response letters, exhibits, certifications, sworn statements) requiring legal review, officer signature, and long-term retention. Regulatory response w',
    `statutory_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_filing. Business justification: DOI responses cite specific statutory filings as evidence (e.g., "See Schedule D, Part 1, Line 23 of our 2023 Annual Statement"). Real business process: regulatory inquiry response where company refer',
    `tertiary_doi_approved_by_user_employee_id` BIGINT COMMENT 'System user identifier of the manager or compliance officer who reviewed and approved the response before submission.',
    `valuation_run_id` BIGINT COMMENT 'Foreign key linking to actuarial.valuation_run. Business justification: DOI responses must reference specific valuation runs when answering regulatory inquiries about reserve adequacy, methodology, or compliance. Responses cite valuation run details as evidence. Real busi',
    `superseded_doi_response_id` BIGINT COMMENT 'Self-referencing FK on doi_response (superseded_doi_response_id)',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory body acknowledged receipt of the response, confirming successful delivery and acceptance.',
    `acknowledgment_received_flag` BOOLEAN COMMENT 'Indicator of whether an acknowledgment or receipt confirmation has been received from the regulatory body for this response.',
    `acknowledgment_reference_number` STRING COMMENT 'Reference number or tracking identifier provided by the regulatory body in their acknowledgment of receipt.',
    `approval_date` DATE COMMENT 'Date on which the response was internally approved for submission to the regulatory body.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, exhibits, or attachments included with the regulatory response.',
    `attachment_list` STRING COMMENT 'Comma-separated or structured list of attachment names or document references included with the response for tracking and completeness verification.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicator of whether the regulatory body required the company to take corrective action as a result of the inquiry and response.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this response record was first created in the correspondence management system.',
    `days_to_respond` STRING COMMENT 'Number of calendar days between the inquiry receipt date and the response submission date, measuring response turnaround time.',
    `examiner_contact_email` STRING COMMENT 'Email address of the regulatory examiner for correspondence and follow-up communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `examiner_contact_phone` STRING COMMENT 'Phone number of the regulatory examiner for direct communication regarding the inquiry and response.',
    `examiner_name` STRING COMMENT 'Name of the regulatory examiner or case officer assigned to the inquiry at the Department of Insurance.',
    `extended_due_date` DATE COMMENT 'The revised deadline date if an extension was granted by the regulatory body.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicator of whether the regulatory body granted an extension to the original response deadline.',
    `extension_requested_flag` BOOLEAN COMMENT 'Indicator of whether an extension to the response deadline was requested from the regulatory body.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicator of whether additional follow-up responses or information are required by the regulatory body.',
    `regulatory_body_name` STRING COMMENT 'Full name of the state Department of Insurance or regulatory agency to which the response was submitted.',
    `resolution_outcome` STRING COMMENT 'The outcome or disposition of the regulatory inquiry after the response was reviewed by the regulatory body.. Valid values are `accepted|additional_info_requested|corrective_action_required|closed_satisfactory|closed_unsatisfactory|pending`',
    `response_body_text` STRING COMMENT 'The full text content of the regulatory response letter or submission, containing the detailed explanation and information provided to the regulatory body.',
    `response_content_reference` STRING COMMENT 'Reference identifier or file path to the stored response document in the document management system, enabling retrieval of the full response package.',
    `response_date` DATE COMMENT 'The date on which the formal response was submitted to the Department of Insurance or regulatory body.',
    `response_due_date` DATE COMMENT 'The deadline date by which the regulatory body required the response to be submitted, as specified in the original inquiry.',
    `response_method` STRING COMMENT 'The method or channel used to deliver the response to the regulatory body, such as written letter, online portal, or email.. Valid values are `written_letter|portal_submission|email|fax|certified_mail|hand_delivery`',
    `response_notes` STRING COMMENT 'Internal notes, comments, or observations regarding the response preparation, submission, or outcome for future reference and knowledge management.',
    `response_number` STRING COMMENT 'Business-assigned unique reference number for this regulatory response, used for tracking and correspondence threading.',
    `response_status` STRING COMMENT 'Current lifecycle status of the regulatory response indicating its stage in the submission and acknowledgment workflow.. Valid values are `draft|pending_review|approved|submitted|acknowledged|closed`',
    `response_subject` STRING COMMENT 'Brief subject or title summarizing the topic of the regulatory response for quick identification and filing.',
    `response_timestamp` TIMESTAMP COMMENT 'The precise date and time when the response was submitted to the regulatory body, supporting audit trail and compliance verification.',
    `response_type` STRING COMMENT 'Classification of the response indicating whether it is an initial reply, supplemental information, final resolution, or other response category.. Valid values are `initial|supplemental|final|interim|clarification|corrective_action`',
    `state_jurisdiction` STRING COMMENT 'Two-letter state code identifying the jurisdiction of the regulatory body receiving the response.',
    `submitted_by_officer_name` STRING COMMENT 'Full name of the company officer or authorized representative who signed and submitted the response to the regulatory body.',
    `submitted_by_officer_title` STRING COMMENT 'Job title or position of the officer who submitted the response, such as Chief Compliance Officer, General Counsel, or State Relations Manager.',
    `timeliness_status` STRING COMMENT 'Classification indicating whether the response was submitted on time, late, or early relative to the required deadline.. Valid values are `on_time|late|early`',
    `tracking_number` STRING COMMENT 'Carrier tracking number for certified mail, courier, or other tracked delivery methods used to submit the response.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this response record was last modified, supporting audit trail and change tracking.',
    CONSTRAINT pk_doi_response PRIMARY KEY(`doi_response_id`)
) COMMENT 'Transactional record of each formal response submitted to a state DOI or regulatory body in reply to a doi_inquiry. Captures the response date, response method (written letter, portal submission, email), response content reference, attachments included, submitted-by officer, and acknowledgment receipt from the regulatory body. Maintains the complete regulatory correspondence thread for each inquiry. Supports market conduct examination defense and regulatory relationship management.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` (
    `bulk_comm_campaign_id` BIGINT COMMENT 'Unique identifier for the bulk communication campaign record. Primary key.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link bulk campaign to channel master. Replaces STRING channel code with FK to comm_channel for proper campaign channel management.',
    `employee_id` BIGINT COMMENT 'User identifier of the individual who approved the campaign for dispatch.',
    `follow_up_bulk_comm_campaign_id` BIGINT COMMENT 'Self-referencing FK on bulk_comm_campaign (follow_up_bulk_comm_campaign_id)',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual total cost incurred for executing the bulk communication campaign.',
    `actual_dispatch_date` DATE COMMENT 'Actual date when the bulk communication dispatch was initiated.',
    `actual_sent_count` BIGINT COMMENT 'Actual number of communications successfully dispatched to recipients.',
    `approval_date` DATE COMMENT 'Date when the campaign received formal approval for dispatch.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this campaign requires formal approval before dispatch.',
    `bulk_comm_campaign_status` STRING COMMENT 'Current lifecycle status of the bulk communication campaign.. Valid values are `draft|scheduled|in_progress|completed|cancelled|failed`',
    `business_trigger` STRING COMMENT 'Description of the business event or regulatory requirement that initiated this bulk communication campaign.',
    `campaign_category` STRING COMMENT 'High-level category grouping for the campaign, distinguishing between compliance-driven, servicing, and informational communications.. Valid values are `compliance|servicing|disclosure|notification|informational`',
    `campaign_name` STRING COMMENT 'Descriptive name of the bulk communication campaign that identifies its purpose and scope.',
    `campaign_number` STRING COMMENT 'Business-facing unique identifier or reference number for the bulk communication campaign, used for tracking and reporting purposes.',
    `campaign_type` STRING COMMENT 'Classification of the bulk communication campaign based on its business purpose and trigger.. Valid values are `regulatory_notice|operational_notice|product_discontinuation|rate_action|class_action_settlement|privacy_notice`',
    `completion_date` DATE COMMENT 'Date when the bulk communication campaign was fully completed, including all dispatch and delivery confirmation activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulk communication campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this campaign.. Valid values are `^[A-Z]{3}$`',
    `delivery_failure_count` BIGINT COMMENT 'Number of communications that failed delivery due to invalid addresses, bounced emails, or other delivery issues.',
    `delivery_success_count` BIGINT COMMENT 'Number of communications confirmed as successfully delivered to recipients.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost for executing the bulk communication campaign, including printing, postage, and vendor fees.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the primary language of the communication content.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the campaign.',
    `priority` STRING COMMENT 'Priority level assigned to the campaign, influencing scheduling and resource allocation.. Valid values are `low|medium|high|urgent`',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulation, statute, or compliance framework that mandates this communication (e.g., GLBA Section 503, NAIC Model Act).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this campaign is mandated by regulatory or statutory requirements.',
    `reply_to_email` STRING COMMENT 'Email address designated for recipient replies, if different from the sender email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `scheduled_dispatch_date` DATE COMMENT 'Planned date for initiating the bulk communication dispatch.',
    `sender_email` STRING COMMENT 'Email address used as the sender for email-based campaigns.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Name of the sender or department displayed on the communication.',
    `subject_line` STRING COMMENT 'Subject line or title used for the communication, particularly relevant for email and letter campaigns.',
    `target_population_criteria` STRING COMMENT 'Business rules and selection criteria used to identify the recipient population for this campaign (e.g., all active policyholders in state X with product type Y).',
    `target_recipient_count` BIGINT COMMENT 'Total number of recipients identified for this bulk communication campaign based on the target population criteria.',
    `template_code` STRING COMMENT 'Reference code for the communication template used for this bulk campaign.',
    `template_version` STRING COMMENT 'Version identifier of the communication template used, ensuring traceability and compliance with approved content.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulk communication campaign record was last modified.',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor or service provider used for campaign execution, if applicable.',
    `vendor_reference_number` STRING COMMENT 'External reference number or job identifier provided by the vendor for tracking purposes.',
    CONSTRAINT pk_bulk_comm_campaign PRIMARY KEY(`bulk_comm_campaign_id`)
) COMMENT 'Master record for bulk correspondence campaigns — mass outbound notice events targeting a defined population of policyholders or stakeholders for a specific business purpose. Examples include annual privacy notice mailings (GLBA), in-force rate action notifications, product discontinuation notices, class action settlement notices, and regulatory-mandated mass disclosures. Captures campaign name, business trigger, target population criteria, template used, scheduled dispatch date, total recipient count, and campaign status. Distinct from marketing campaigns (owned by marketing domain) — this entity owns operational and regulatory bulk correspondence.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` (
    `correspondence_bulk_comm_recipient_id` BIGINT COMMENT 'Unique identifier for each individual recipient record within a bulk correspondence campaign. Primary key for the bulk communication recipient entity.',
    `annuity_contract_id` BIGINT COMMENT 'Reference to the annuity contract associated with this recipient communication, if applicable. Used for annuity-specific bulk notices such as account value statements or Required Minimum Distribution (RMD) reminders.',
    `bulk_comm_campaign_id` BIGINT COMMENT 'Reference to the parent bulk correspondence campaign to which this recipient belongs. Links the individual recipient dispatch record to the overall campaign execution.',
    `comm_channel_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_channel. Business justification: Link bulk recipient to channel master. Replaces STRING delivery_channel code with FK to comm_channel. Uses delivery_ prefix for clarity.',
    `communication_id` BIGINT COMMENT 'Reference to the specific personalized communication document or notice that was generated for this recipient as part of the bulk campaign. Links to the individual output artifact.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy associated with this recipient communication, if applicable. Used for policy-specific bulk notices such as annual statements or rate change notifications.',
    `document_id` BIGINT COMMENT 'Reference to the stored proof of delivery document or receipt for this recipient communication. Used for regulatory compliance and legal defense.',
    `party_id` BIGINT COMMENT 'Identifier of the party (policyholder, beneficiary, agent, or other stakeholder) who is the intended recipient of this bulk communication.',
    `resend_correspondence_bulk_comm_recipient_id` BIGINT COMMENT 'Self-referencing FK on correspondence_bulk_comm_recipient (resend_correspondence_bulk_comm_recipient_id)',
    `cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred for dispatching this communication to the recipient. Includes postage, email service fees, or SMS charges. Used for campaign cost analysis and budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this recipient record was first created in the system. Represents the initial campaign recipient selection and queuing event.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost amount. Typically USD for domestic operations but may vary for international campaigns.. Valid values are `^[A-Z]{3}$`',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the recipient was identified as deceased at the time of campaign execution. True if deceased, false otherwise. Used for suppression and Death Master File (DMF) compliance.',
    `delivery_attempt_count` STRING COMMENT 'Number of delivery attempts made for this recipient communication. Used for retry logic and delivery quality analysis.',
    `delivery_failure_reason` STRING COMMENT 'Detailed explanation of why the delivery failed, if applicable. Captures carrier error messages, bounce reasons, or postal service return codes for troubleshooting and remediation.',
    `delivery_outcome_code` STRING COMMENT 'Standardized code representing the final delivery outcome for this recipient. Used for exception management and delivery quality metrics. [ENUM-REF-CANDIDATE: success|hard_bounce|soft_bounce|returned_mail|undeliverable|refused|spam_filtered — 7 candidates stripped; promote to reference product]',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was confirmed delivered to the recipient. Used for proof of delivery and regulatory compliance documentation.',
    `dispatch_status` STRING COMMENT 'Current status of the dispatch attempt for this recipient. Tracks the lifecycle from queuing through final delivery outcome or failure. [ENUM-REF-CANDIDATE: pending|queued|dispatched|delivered|failed|bounced|returned — 7 candidates stripped; promote to reference product]',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when the communication was dispatched to this recipient. Critical for regulatory notice timing requirements and Service Level Agreement (SLA) tracking.',
    `language_code` STRING COMMENT 'Two-letter ISO language code indicating the language in which the communication was generated for this recipient. Used for multilingual campaign management and regulatory compliance.. Valid values are `^[a-z]{2}$`',
    `merge_data_snapshot` STRING COMMENT 'JSON or XML snapshot of the personalized merge data used to generate this recipients communication. Preserves the exact data values used for audit trail and regulatory compliance.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional context, exceptions, or special handling instructions for this recipient dispatch. Used for operational troubleshooting and audit documentation.',
    `opened_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient opened or accessed the electronic communication. Applicable to email and secure portal delivery channels for engagement tracking.',
    `opt_out_flag` BOOLEAN COMMENT 'Indicates whether the recipient has opted out of receiving marketing or non-essential communications. True if opted out, false otherwise. Critical for CAN-SPAM and privacy compliance.',
    `priority_level` STRING COMMENT 'Priority classification assigned to this recipient dispatch within the bulk campaign. Determines processing order and delivery method selection.. Valid values are `urgent|high|normal|low`',
    `proof_of_delivery_required_flag` BOOLEAN COMMENT 'Indicates whether proof of delivery documentation is required for this recipient communication due to regulatory or legal requirements. True if proof required, false otherwise.',
    `recipient_address_line1` STRING COMMENT 'First line of the postal mailing address for this recipient, if delivery channel is postal mail. Captured at dispatch time for delivery tracking and returned mail processing.',
    `recipient_address_line2` STRING COMMENT 'Second line of the postal mailing address for this recipient (apartment, suite, unit number). Optional address component for delivery tracking.',
    `recipient_city` STRING COMMENT 'City name component of the recipient postal address. Used for delivery tracking and geographic analysis of campaign reach.',
    `recipient_country_code` STRING COMMENT 'Three-letter ISO country code of the recipient address. Used for international delivery tracking and cross-border regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `recipient_email` STRING COMMENT 'Email address to which the bulk communication was sent, if delivery channel is email. Used for electronic delivery tracking and bounce management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Full name of the recipient as it appears on the generated correspondence. Captured at dispatch time for audit trail and delivery tracking purposes.',
    `recipient_postal_code` STRING COMMENT 'Postal or ZIP code of the recipient address. Used for delivery tracking, returned mail processing, and National Change of Address (NCOA) matching.',
    `recipient_sequence_number` STRING COMMENT 'Sequential ordering number of this recipient within the bulk campaign batch. Used for tracking processing order and batch segmentation.',
    `recipient_state` STRING COMMENT 'State or province code of the recipient postal address. Critical for regulatory compliance tracking and state-specific disclosure requirements.',
    `regulatory_notice_flag` BOOLEAN COMMENT 'Indicates whether this communication is a regulatory-required notice that must be delivered regardless of recipient preferences. True for mandatory regulatory notices, false for discretionary communications.',
    `returned_mail_flag` BOOLEAN COMMENT 'Indicates whether this recipient has a history of returned mail that triggered suppression or special handling. True if returned mail history exists, false otherwise.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether this recipient was suppressed from receiving the communication due to opt-out, deceased status, returned mail history, or other exclusion criteria. True if suppressed, false if dispatched.',
    `suppression_reason_code` STRING COMMENT 'Standardized code indicating why this recipient was suppressed from the bulk campaign. Used for compliance reporting and suppression list management.. Valid values are `opt_out|deceased|returned_mail|invalid_address|duplicate|regulatory_exclusion`',
    `tracking_number` STRING COMMENT 'Carrier or postal service tracking number assigned to this recipient dispatch. Used for delivery confirmation and proof of mailing for regulatory compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this recipient record was last modified. Tracks status changes, delivery updates, and exception handling throughout the dispatch lifecycle.',
    CONSTRAINT pk_correspondence_bulk_comm_recipient PRIMARY KEY(`correspondence_bulk_comm_recipient_id`)
) COMMENT 'Association and transactional record linking each individual recipient to a bulk correspondence campaign, capturing the per-recipient dispatch record. Stores the recipient party identity, the specific notice generated for that recipient, the personalized merge data used, the dispatch timestamp, the delivery outcome, and any suppression flags (opt-out, deceased, returned mail). Enables per-recipient delivery tracking and exception management within bulk campaign operations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` (
    `comm_channel_id` BIGINT COMMENT 'Unique identifier for the communication channel. Primary key for the communication channel reference master.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user or administrator who most recently updated the communication channel record. Used for audit trail and accountability.',
    `parent_comm_channel_id` BIGINT COMMENT 'Self-referencing FK on comm_channel (parent_comm_channel_id)',
    `accessibility_compliant_flag` BOOLEAN COMMENT 'Indicates whether the channel meets accessibility standards (e.g., WCAG 2.1 for electronic channels, large print options for physical mail) to ensure communications are accessible to policyholders with disabilities. True if accessibility compliant; False if not compliant.',
    `aml_kyc_verification_supported_flag` BOOLEAN COMMENT 'Indicates whether the channel supports identity verification and authentication mechanisms required for AML and KYC compliance (e.g., secure portal with multi-factor authentication). True if AML/KYC verification is supported; False if not supported.',
    `average_delivery_time_hours` DECIMAL(18,2) COMMENT 'Average time in hours from dispatch to delivery for this channel, based on historical delivery tracking data. Used for Service Level Agreement (SLA) planning and channel selection optimization.',
    `batch_processing_supported_flag` BOOLEAN COMMENT 'Indicates whether the channel supports batch processing of multiple communications in a single transmission (e.g., bulk mail, batch email campaigns). True if batch processing is supported; False if only individual communications are supported.',
    `channel_category` STRING COMMENT 'High-level categorization of the communication channel distinguishing between electronic delivery (email, SMS, portal), physical delivery (postal mail, fax), and voice (outbound call). Used for channel grouping and reporting.. Valid values are `electronic|physical|voice`',
    `channel_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the communication channel (e.g., USPS_STD, EMAIL, SMS, PORTAL, FAX, CALL). Used as a business key for channel lookup and routing logic.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `channel_name` STRING COMMENT 'Full descriptive name of the communication channel (e.g., United States Postal Service Standard Mail, Email, SMS Text Message, Secure Portal Message, Fax, Outbound Call).',
    `channel_usage_restriction` STRING COMMENT 'Description of any restrictions or limitations on the use of this channel (e.g., only for non-regulatory notices, requires policyholder consent, not available in certain states, only for specific policy types). Null if no restrictions apply.',
    `cost_per_communication` DECIMAL(18,2) COMMENT 'Average cost in US dollars (USD) to send a single communication via this channel, including postage, vendor fees, and processing costs. Used for cost analysis and channel optimization. All costs are in USD as the company operates in the US market.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the communication channel record was first created in the system. Used for audit trail and data lineage tracking.',
    `delivery_method` STRING COMMENT 'Mechanism by which the communication is delivered: push (sent directly to recipient), pull (recipient retrieves from portal), or interactive (real-time conversation such as phone call).. Valid values are `push|pull|interactive`',
    `display_order` STRING COMMENT 'Numeric value controlling the display sequence of communication channels in user interfaces and channel selection lists. Lower values appear first. Used to prioritize preferred channels.',
    `e_delivery_consent_required_flag` BOOLEAN COMMENT 'Indicates whether the channel requires explicit policyholder consent for electronic delivery under state insurance regulations and NAIC model laws (e.g., E-SIGN Act compliance). True if consent is required; False if not required (e.g., physical mail does not require e-delivery consent).',
    `effective_date` DATE COMMENT 'Date when the communication channel became or will become available for use in the correspondence system.',
    `encryption_required_flag` BOOLEAN COMMENT 'Indicates whether communications sent via this channel must be encrypted to meet data security and privacy requirements (e.g., NAIC Model Regulation for Data Security, HIPAA for health-related communications). True if encryption is required; False if not required.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the channel meets HIPAA compliance requirements for transmitting Protected Health Information (PHI) in disability income and long-term care insurance communications. True if HIPAA compliant; False if not compliant.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the communication channel record was most recently updated. Used for audit trail and change tracking.',
    `max_attachment_size_mb` DECIMAL(18,2) COMMENT 'Maximum total size in megabytes (MB) of attachments that can be sent via this channel. Null if attachments are not supported or if there is no size limit.',
    `multi_language_support_flag` BOOLEAN COMMENT 'Indicates whether the channel supports delivery of communications in multiple languages to accommodate diverse policyholder populations. True if multi-language support is available; False if only English is supported.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special instructions, or operational notes about the communication channel. Used for internal documentation and knowledge sharing.',
    `operational_status` STRING COMMENT 'Current operational availability status of the communication channel. Active means the channel is available for use; Inactive means temporarily unavailable; Suspended means administratively disabled; Deprecated means the channel is being phased out and should not be used for new communications.. Valid values are `active|inactive|suspended|deprecated`',
    `priority_routing_available_flag` BOOLEAN COMMENT 'Indicates whether the channel supports expedited or priority delivery for urgent communications (e.g., certified mail, priority email routing). True if priority routing is available; False if not available.',
    `proof_of_delivery_available_flag` BOOLEAN COMMENT 'Indicates whether the channel provides verifiable proof of delivery (e.g., certified mail tracking, email read receipts, portal access logs). True if proof of delivery is available; False if not available.',
    `regulatory_acceptance_status` STRING COMMENT 'Indicates whether the channel satisfies state Department of Insurance (DOI) notice delivery requirements for regulatory and statutory communications. Accepted means the channel is fully compliant for all notice types; Conditional means the channel is acceptable only under specific circumstances (e.g., with consent); Not Accepted means the channel does not meet regulatory standards for certain notice types.. Valid values are `accepted|conditional|not_accepted`',
    `return_receipt_available_flag` BOOLEAN COMMENT 'Indicates whether the channel provides return receipt or delivery confirmation signed by the recipient (e.g., USPS certified mail return receipt, email read receipt). True if return receipt is available; False if not available.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target delivery time in hours as defined in the service level agreement for this channel. Used to measure channel performance against contractual commitments.',
    `supports_attachments_flag` BOOLEAN COMMENT 'Indicates whether the channel supports sending attachments or supplementary documents along with the primary communication. True if attachments are supported; False if not supported.',
    `termination_date` DATE COMMENT 'Date when the communication channel was or will be retired from operational use. Null if the channel is still active or has no planned termination.',
    `tracking_capability` STRING COMMENT 'Level of delivery tracking available for the channel. Full tracking provides detailed delivery status and timestamps; Partial tracking provides limited status updates; None indicates no tracking capability.. Valid values are `full|partial|none`',
    `vendor_contract_number` STRING COMMENT 'Contract or agreement reference number with the vendor providing the communication channel service. Used for vendor management and contract compliance tracking.',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor or service provider that facilitates delivery for this channel (e.g., United States Postal Service, email service provider, SMS gateway provider). Null if the channel is managed internally.',
    CONSTRAINT pk_comm_channel PRIMARY KEY(`comm_channel_id`)
) COMMENT 'Reference master defining all communication channels supported by the correspondence domain — physical mail (USPS standard, USPS certified), email, SMS/text, secure portal message, fax, and outbound call. Captures channel code, channel name, channel category (electronic vs. physical), e-delivery consent requirement flag, regulatory acceptance status (whether the channel satisfies state DOI notice delivery requirements), and operational availability status. Used by outbound notice generation and delivery tracking to enforce channel eligibility rules.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` (
    `suppression_list_id` BIGINT COMMENT 'Unique identifier for the suppression list record.',
    `in_force_policy_id` BIGINT COMMENT 'Identifier of the policy subject to suppression rules. Null if suppression applies to a party across all policies.',
    `party_id` BIGINT COMMENT 'Identifier of the party (policyholder, beneficiary, agent) subject to suppression. Null if suppression applies to a specific policy only.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created or approved the suppression record.',
    `superseded_suppression_list_id` BIGINT COMMENT 'Self-referencing FK on suppression_list (superseded_suppression_list_id)',
    `authorization_date` DATE COMMENT 'Date when the suppression was authorized and entered into the system.',
    `authorizing_source` STRING COMMENT 'Department or entity that authorized the suppression rule. Legal department for litigation holds; compliance for regulatory mandates; policyholder request for opt-outs; regulatory order for government directives; customer service for complaints; fraud investigation for suspicious activity.. Valid values are `legal_department|compliance_department|policyholder_request|regulatory_order|customer_service|fraud_investigation`',
    `blocked_communication_count` STRING COMMENT 'Total number of outbound communications that have been blocked by this suppression rule since activation. Updated by correspondence dispatch systems.',
    `campaign_exclusion_list` STRING COMMENT 'Comma-separated list of specific campaign codes or identifiers that this suppression rule blocks. Null if suppression applies to all campaigns within the category.',
    `channel_exclusion_list` STRING COMMENT 'Comma-separated list of communication channels blocked by this suppression (e.g., email, SMS, phone, postal mail, fax). Null if all channels within the category are suppressed.',
    `consent_revocation_flag` BOOLEAN COMMENT 'Indicates whether this suppression represents a revocation of previously granted communication consent. True requires removal from all active consent-based campaigns.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression record was first created in the data platform.',
    `deceased_date` DATE COMMENT 'Date of death for the party, if deceased indicator is true. Used for death benefit claims and escheatment timelines.',
    `deceased_indicator` BOOLEAN COMMENT 'Indicates whether the suppression is due to confirmed death of the party. True triggers escheatment workflows and death benefit processing.',
    `dmf_match_flag` BOOLEAN COMMENT 'Indicates whether the party was matched against the Social Security Administration Death Master File. True confirms official death record.',
    `effective_date` DATE COMMENT 'Date when the suppression rule becomes active and begins blocking communications.',
    `enforcement_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the suppression rule was deactivated and stopped blocking correspondence. Null for currently active suppressions.',
    `enforcement_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the suppression rule was activated in outbound communication systems and began blocking correspondence.',
    `escheatment_risk_flag` BOOLEAN COMMENT 'Indicates whether the suppression is associated with potential unclaimed property that may need to be escheated to the state. True triggers escheatment due diligence workflows.',
    `expiration_date` DATE COMMENT 'Date when the suppression rule automatically expires and ceases to block communications. Null for indefinite suppressions.',
    `last_blocked_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression rule most recently blocked an outbound communication attempt.',
    `last_review_date` DATE COMMENT 'Date when this suppression was most recently reviewed and validated by compliance or legal.',
    `legal_case_number` STRING COMMENT 'Court case or legal matter reference number associated with the suppression, if applicable. Used for litigation holds and regulatory orders.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance or legal review of this suppression rule. Null if no review is required.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or case-specific details related to the suppression. Used by compliance and customer service teams.',
    `opt_out_method` STRING COMMENT 'Channel through which the party submitted the opt-out or suppression request. Web portal for online submissions; phone call for IVR or agent; written request for postal mail; email request for electronic; in-person for branch; third-party service for aggregators.. Valid values are `web_portal|phone_call|written_request|email_request|in_person|third_party_service`',
    `opt_out_timestamp` TIMESTAMP COMMENT 'Precise date and time when the opt-out or suppression request was received and recorded in the system.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether the suppression can be manually overridden for urgent or regulatory-required communications. True allows override with proper authorization; false enforces absolute suppression.',
    `override_authorization_level` STRING COMMENT 'Minimum authority level required to override this suppression rule. None means no override permitted; higher levels require escalating approval.. Valid values are `none|supervisor|manager|director|legal_counsel|compliance_officer`',
    `priority_level` STRING COMMENT 'Urgency and importance of enforcing this suppression rule. Critical for legal holds and regulatory orders; high for fraud and deceased; medium for opt-outs; low for preference changes.. Valid values are `critical|high|medium|low`',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the suppression. Deceased for confirmed death; litigation for legal proceedings; regulatory mandate for government orders; customer opt-out for voluntary requests; fraud suspected for investigation; privacy request for data protection; complaint escalation for service issues. [ENUM-REF-CANDIDATE: deceased|litigation|regulatory_mandate|customer_opt_out|fraud_suspected|privacy_request|complaint_escalation — 7 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of why the suppression was applied, including case numbers, complaint references, or legal citations.',
    `regulatory_reference_number` STRING COMMENT 'Government or regulatory body order or directive number that mandates the suppression, if applicable.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this suppression must be reported to regulatory bodies (e.g., state DOI, NAIC). True for suppressions resulting from regulatory orders or market conduct issues.',
    `review_required_flag` BOOLEAN COMMENT 'Indicates whether this suppression requires periodic review or renewal. True for temporary suppressions that need ongoing validation.',
    `source_system` STRING COMMENT 'Name of the upstream system or application that originated this suppression record (e.g., CRM, Policy Admin, Legal Case Management).',
    `source_system_code` STRING COMMENT 'Unique identifier of this suppression record in the source system, used for reconciliation and traceability.',
    `suppression_category` STRING COMMENT 'Scope of communications affected by the suppression. All communications blocks everything; marketing only allows transactional notices; electronic only suppresses email/SMS; phone only blocks calls; mail only stops postal correspondence; specific campaign targets individual campaigns.. Valid values are `all_communications|marketing_only|electronic_only|phone_only|mail_only|specific_campaign`',
    `suppression_list_status` STRING COMMENT 'Current lifecycle state of the suppression rule. Active rules are enforced; expired rules are no longer in effect; suspended rules are temporarily inactive; cancelled rules were terminated early; pending review awaits approval.. Valid values are `active|expired|suspended|cancelled|pending_review`',
    `suppression_number` STRING COMMENT 'Business-facing unique identifier for the suppression record, used for tracking and reference in correspondence systems.',
    `suppression_type` STRING COMMENT 'Category of suppression rule applied. Legal hold prevents all contact during legal proceedings; litigation in progress restricts marketing; deceased no marketing stops promotional communications; opt-out electronic blocks email/SMS; regulatory restriction enforces compliance mandates; do not contact is a blanket prohibition.. Valid values are `legal_hold|litigation_in_progress|deceased_no_marketing|opt_out_electronic|regulatory_restriction|do_not_contact`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this suppression record was most recently modified in the data platform.',
    CONSTRAINT pk_suppression_list PRIMARY KEY(`suppression_list_id`)
) COMMENT 'Master record managing communication suppression rules for specific parties, policies, or communication categories. Captures the suppressed party or policy, the suppression type (legal hold — no contact, litigation in progress, deceased — no marketing, opt-out — electronic only, regulatory restriction), the suppression effective date, expiration date, and the authorizing source (legal department, compliance, policyholder request). Ensures outbound notice generation and bulk campaign engines respect all active suppression rules before dispatching correspondence.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`translation_request` (
    `translation_request_id` BIGINT COMMENT 'Unique identifier for the translation request record. Primary key.',
    `claim_id` BIGINT COMMENT 'Reference to the claim associated with this translation request, if applicable.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with this translation request, if applicable.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder for whom the translation is being requested.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or resource assigned to perform the translation, if handled in-house.',
    `communication_id` BIGINT COMMENT 'Reference to the original communication that requires translation. Links to the correspondence.communication product.',
    `comm_template_id` BIGINT COMMENT 'Foreign key linking to correspondence.comm_template. Business justification: Link translation request to the resulting translated template. Essential for tracking translation outcomes and template versioning.',
    `vendor_id` BIGINT COMMENT 'Reference to the external translation vendor or service provider assigned to perform the translation, if outsourced.',
    `retranslation_request_id` BIGINT COMMENT 'Self-referencing FK on translation_request (retranslation_request_id)',
    `assigned_date` DATE COMMENT 'Date when the translation request was assigned to a vendor or internal resource.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason code for why the translation request was cancelled, if applicable.',
    `certification_date` DATE COMMENT 'Date when the translation was formally certified or notarized, if required.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether the translation requires formal certification or notarization for legal or regulatory purposes.',
    `correspondence_type` STRING COMMENT 'Classification of the type of correspondence being translated (e.g., notice, letter, disclosure, policy document). [ENUM-REF-CANDIDATE: notice|letter|email|form|disclosure|statement|contract|policy_document — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this translation request record was first created in the database.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the translation cost amount (e.g., USD, CAD).',
    `delivery_date` DATE COMMENT 'Date when the completed and approved translation was delivered to the requesting party or system.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, instructions, or context related to the translation request.',
    `priority_level` STRING COMMENT 'Priority classification for the translation request, determining the urgency and sequence of processing.. Valid values are `urgent|high|normal|low`',
    `quality_review_date` DATE COMMENT 'Date when the quality review of the translation was completed.',
    `quality_review_required_flag` BOOLEAN COMMENT 'Indicates whether the translated content requires quality assurance review before approval and delivery.',
    `quality_review_status` STRING COMMENT 'Current status of the quality assurance review process for the translated content.. Valid values are `not_started|in_review|passed|failed|waived`',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric quality score assigned to the translation during the review process, typically on a scale of 0-100.',
    `regulatory_jurisdiction` STRING COMMENT 'State or federal jurisdiction code that mandates the translation requirement, if applicable (e.g., CA for California).',
    `regulatory_reference_code` STRING COMMENT 'Citation or reference to the specific regulation, statute, or DOI requirement that mandates the translation.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this translation is mandated by state or federal regulatory requirements (e.g., California Spanish translation mandate).',
    `rejection_reason` STRING COMMENT 'Explanation or reason code for why the translation was rejected during quality review, if applicable.',
    `request_date` DATE COMMENT 'Date when the translation request was initiated or submitted.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the translation request, used for tracking and reference purposes.',
    `request_status` STRING COMMENT 'Current lifecycle status of the translation request indicating its progress through the translation workflow. [ENUM-REF-CANDIDATE: pending|assigned|in_progress|translated|quality_review|approved|delivered|cancelled|rejected — 9 candidates stripped; promote to reference product]',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time when the translation request was created in the system.',
    `request_type` STRING COMMENT 'Classification of the translation request indicating the reason or driver for the translation (e.g., regulatory mandate, customer preference, legal requirement).. Valid values are `regulatory_mandated|customer_preference|legal_requirement|accessibility|voluntary`',
    `requested_completion_date` DATE COMMENT 'Target date by which the translation must be completed to meet business or regulatory deadlines.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the translation request exceeded the target completion date, resulting in an SLA breach.',
    `source_language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the original language of the communication to be translated.',
    `target_language_code` STRING COMMENT 'ISO 639-1 two-letter language code representing the language into which the communication must be translated.',
    `translated_content_reference` STRING COMMENT 'Reference identifier or storage location for the translated content document or file (e.g., document management system ID, file path).',
    `translation_completion_date` DATE COMMENT 'Date when the translation was completed by the translator or vendor.',
    `translation_cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged for the translation service, either by external vendor or allocated internal cost.',
    `translation_method` STRING COMMENT 'Method used to perform the translation (e.g., human translator, machine translation, hybrid approach, certified translator).. Valid values are `human|machine|hybrid|certified`',
    `translation_start_date` DATE COMMENT 'Date when the actual translation work began.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this translation request record was last modified in the database.',
    `word_count` STRING COMMENT 'Total number of words in the source communication that require translation, used for cost estimation and workload planning.',
    CONSTRAINT pk_translation_request PRIMARY KEY(`translation_request_id`)
) COMMENT 'Transactional record tracking requests for translated correspondence — required when a policyholder has indicated a non-English preferred language or when state regulations mandate translation of specific notices (e.g., California requires Spanish translation for certain insurance notices). Captures the source communication, the target language, the translation vendor or internal resource assigned, the requested completion date, the translated content reference, and the quality review status. Supports state DOI language access compliance requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` (
    `comm_audit_trail_id` BIGINT COMMENT 'Unique identifier for each audit trail record. Primary key for the communication audit trail entity.',
    `claim_id` BIGINT COMMENT 'The unique identifier of the claim associated with the audited correspondence entity, if applicable. Enables claim-level audit trail reporting.',
    `in_force_policy_id` BIGINT COMMENT 'The unique identifier of the policy associated with the audited correspondence entity, if applicable. Enables policy-level audit trail reporting.',
    `party_id` BIGINT COMMENT 'The unique identifier of the policyholder or customer associated with the audited correspondence entity. Enables customer-level audit trail reporting.',
    `employee_id` BIGINT COMMENT 'The unique identifier of the user, system, or agent who performed the action. May be a human user ID, system account, or automated process identifier.',
    `comm_session_id` BIGINT COMMENT 'The unique identifier of the user session or application session during which the action was performed.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to correspondence.correspondence_sla. Business justification: Link audit trail to SLA context when audit event is SLA-related. Essential for SLA compliance auditing and regulatory reporting.',
    `tertiary_comm_exception_approval_user_employee_id` BIGINT COMMENT 'The unique identifier of the supervisor or manager who approved the exception action.',
    `prior_comm_audit_trail_id` BIGINT COMMENT 'Self-referencing FK on comm_audit_trail (prior_comm_audit_trail_id)',
    `action_reason_code` STRING COMMENT 'A standardized code indicating the business reason or trigger for the action (e.g., POLICY_CHANGE, CUSTOMER_REQUEST, REGULATORY_REQUIREMENT, SYSTEM_CORRECTION).',
    `action_reason_description` STRING COMMENT 'A free-text description providing additional context or explanation for why the action was performed.',
    `action_timestamp` TIMESTAMP COMMENT 'The precise date and time when the audited action occurred. This is the business event timestamp, not the record creation timestamp.',
    `action_type` STRING COMMENT 'The specific action or state change that occurred on the entity (e.g., created, dispatched, delivered, returned, escalated, closed, accessed, modified). [ENUM-REF-CANDIDATE: created|updated|dispatched|delivered|returned|escalated|closed|accessed|viewed|modified|deleted|archived — 12 candidates stripped; promote to reference product]',
    `actor_name` STRING COMMENT 'The display name or full name of the user or system that performed the action.',
    `actor_role` STRING COMMENT 'The business role or job function of the actor at the time of the action (e.g., Customer Service Representative, Claims Adjuster, System Administrator, Automated Process).',
    `after_state_snapshot` STRING COMMENT 'A JSON or structured text representation of the entitys state immediately after the action was performed. Captures key field values for comparison and audit purposes.',
    `audit_notes` STRING COMMENT 'Additional free-text notes or comments related to this audit event. May include context, observations, or follow-up actions.',
    `before_state_snapshot` STRING COMMENT 'A JSON or structured text representation of the entitys state immediately before the action was performed. Captures key field values for comparison and audit purposes.',
    `changed_fields` STRING COMMENT 'A comma-separated list or structured representation of the specific fields that were modified during this action. Empty for non-update actions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit trail record was created in the data platform. This is the record insertion timestamp, distinct from the action_timestamp.',
    `entity_reference` BIGINT COMMENT 'The unique identifier of the specific correspondence entity (communication_id, complaint_id, escalation_id, etc.) that was affected by this audit event.',
    `entity_type` STRING COMMENT 'The type of correspondence domain entity that this audit record pertains to (e.g., communication, complaint, escalation, call record, delivery tracking, returned mail).. Valid values are `communication|complaint|escalation|call_record|delivery_tracking|returned_mail`',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this audit event represents an exception to normal business processes or policy (e.g., manual override, expedited processing, policy waiver).',
    `exception_justification` STRING COMMENT 'A free-text explanation of why the exception was necessary and the business justification for the action.',
    `ip_address` STRING COMMENT 'The IP address from which the action was initiated. Used for security audit and fraud detection purposes.',
    `qa_review_date` DATE COMMENT 'The date on which this audit event was reviewed by the quality assurance team.',
    `qa_review_notes` STRING COMMENT 'Free-text notes or comments recorded by the quality assurance reviewer regarding this audit event.',
    `qa_review_outcome` STRING COMMENT 'The result of the quality assurance review (e.g., compliant, non-compliant, exception approved, pending review).. Valid values are `compliant|non_compliant|exception_approved|pending_review`',
    `quality_assurance_flag` BOOLEAN COMMENT 'Indicates whether this audit event has been flagged for quality assurance review or internal audit sampling.',
    `record_hash` STRING COMMENT 'A cryptographic hash of the audit record to ensure immutability and detect tampering. Supports non-repudiation requirements.',
    `regulatory_reference_number` STRING COMMENT 'A reference number or case identifier assigned by a regulatory body for tracking this audit event or related investigation.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this audit event is subject to regulatory reporting requirements (e.g., NAIC market conduct examination, state insurance department inquiry).',
    `retention_expiration_date` DATE COMMENT 'The date on which this audit record is eligible for archival or deletion per retention policy.',
    `retention_period_years` STRING COMMENT 'The number of years this audit record must be retained per regulatory or internal policy requirements.',
    `source_system` STRING COMMENT 'The name or identifier of the system that originated the audited action (e.g., Policy Administration System, CRM, Claims Management System, Customer Portal).',
    `source_transaction_reference` STRING COMMENT 'The unique transaction or request identifier from the source system that triggered this audit event. Enables traceability back to the originating system.',
    `sox_audit_flag` BOOLEAN COMMENT 'Indicates whether this audit event is relevant for SOX compliance and internal control testing.',
    CONSTRAINT pk_comm_audit_trail PRIMARY KEY(`comm_audit_trail_id`)
) COMMENT 'Immutable audit log capturing every significant state change, action, and access event for communications, complaints, and regulatory correspondence managed by the correspondence domain. Records the entity type and ID affected, the action performed (created, dispatched, delivered, returned, escalated, closed, accessed, modified), the actor identity, the timestamp, and the before/after state snapshot. Supports NAIC market conduct examination evidence production, SOX audit requirements, and internal quality assurance reviews. This is a business audit record — not an IT system log.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`template_translation` (
    `template_translation_id` BIGINT COMMENT 'Unique identifier for the template translation service record. Primary key.',
    `comm_template_id` BIGINT COMMENT 'Foreign key linking to the communication template being translated',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor providing translation services',
    `certification_required` BOOLEAN COMMENT 'Indicates whether the vendor must provide certified translation for this template due to regulatory or legal requirements. Explicitly identified in detection reasoning as relationship data.',
    `completion_date` DATE COMMENT 'Date when the vendor completed the translation service for this template.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the translation_cost amount.',
    `engagement_date` DATE COMMENT 'Date when the vendor was engaged to provide translation services for this template.',
    `quality_score` DECIMAL(18,2) COMMENT 'Quality assessment score for the vendors translation of this template, typically on a scale (e.g., 0-100 or 1-5). Used for vendor performance evaluation and selection. Explicitly identified in detection reasoning as relationship data.',
    `service_status` STRING COMMENT 'Current lifecycle status of the translation service engagement (requested, in_progress, completed, approved, rejected, cancelled).',
    `translation_cost` DECIMAL(18,2) COMMENT 'Cost charged by the vendor for translating this specific template. Used for vendor cost comparison and budget optimization. Explicitly identified in detection reasoning as relationship data.',
    `translation_language` STRING COMMENT 'ISO 639-1 language code with optional ISO 3166-1 country code for the target language of this translation service (e.g., es-MX, fr-CA). Explicitly identified in detection reasoning as relationship data.',
    `translation_turnaround_days` STRING COMMENT 'Number of days required by the vendor to complete translation of this template. Used for vendor selection based on urgency requirements. Explicitly identified in detection reasoning as relationship data.',
    CONSTRAINT pk_template_translation PRIMARY KEY(`template_translation_id`)
) COMMENT 'This association product represents the translation service engagement between a communication template and a vendor. It captures the operational record of vendor translation services for specific templates, including translation quality metrics, cost, turnaround time, and language-specific certifications. Each record links one comm_template to one vendor for a specific translation engagement, tracking the business relationship for vendor selection, cost optimization, and quality management.. Existence Justification: In life insurance operations, communication templates require translation into multiple languages for different jurisdictions and customer populations, and this translation work is performed by multiple specialized vendors. A single template (e.g., premium reminder) may be translated by different vendors for different languages (Vendor A translates to Spanish, Vendor B to French), and each vendor translates multiple templates across the template catalog. The business actively manages these vendor-template translation relationships to track quality, cost, and turnaround time for vendor selection and cost optimization.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` (
    `queue_vendor_assignment_id` BIGINT COMMENT 'Unique identifier for this queue-vendor assignment record. Primary key.',
    `correspondence_queue_id` BIGINT COMMENT 'Foreign key to correspondence_queue. Identifies which queue this assignment applies to.',
    `queue_id` BIGINT COMMENT 'Foreign key linking to the correspondence queue being serviced by the vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key to vendor. Identifies which vendor is assigned to service this queue.',
    `assignment_status` STRING COMMENT 'Current operational status of this queue-vendor assignment. Active assignments route work to the vendor; suspended assignments are temporarily paused; terminated assignments are historical records.',
    `assignment_type` STRING COMMENT 'Classification of the vendors role for this queue: primary (main service provider), backup (failover), overflow (handles excess volume), seasonal (temporary capacity during peak periods). Supports the business scenario of multiple vendors servicing one queue with different roles.',
    `cost_per_item` DECIMAL(18,2) COMMENT 'The negotiated cost per correspondence item processed by this vendor for this queue. Pricing varies by queue complexity and vendor. Explicitly identified in detection phase relationship data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this assignment record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this assignment record.',
    `service_end_date` DATE COMMENT 'The date when the vendor stopped or is scheduled to stop servicing this queue. Null indicates active ongoing assignment. Explicitly identified in detection phase relationship data.',
    `service_start_date` DATE COMMENT 'The date when the vendor began servicing this correspondence queue under this assignment. Explicitly identified in detection phase relationship data.',
    `sla_target_hours` STRING COMMENT 'The service level agreement target in business hours for this vendor to process items from this queue. May differ from the queues default SLA based on vendor capabilities and contract terms. Explicitly identified in detection phase relationship data.',
    `volume_commitment` STRING COMMENT 'The minimum or maximum number of items per month that this vendor has committed to process for this queue under the service agreement. Used for capacity planning and vendor performance evaluation. Explicitly identified in detection phase relationship data.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this assignment record.',
    CONSTRAINT pk_queue_vendor_assignment PRIMARY KEY(`queue_vendor_assignment_id`)
) COMMENT 'This association product represents the operational assignment contract between correspondence queues and third-party vendors who service those queues. It captures vendor capacity commitments, SLA targets, cost structures, and service periods for each queue-vendor pairing. Each record links one correspondence queue to one vendor with attributes that exist only in the context of this service relationship — enabling workload distribution, vendor performance monitoring, cost allocation, and capacity planning across the correspondence processing workflow.. Existence Justification: In life insurance correspondence operations, queues (claims intake, policy service, complaints, regulatory response) are serviced by multiple vendors simultaneously in different roles — primary processor, backup vendor, overflow capacity provider. Conversely, a single vendor (e.g., a BPO firm specializing in correspondence handling) services multiple queues across different business units. The business actively manages these assignments with specific SLA targets, cost structures, volume commitments, and service periods for each queue-vendor pairing.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`comm_session` (
    `comm_session_id` BIGINT COMMENT 'Primary key for comm_session',
    `team_id` BIGINT COMMENT 'Reference to the customer service team responsible for this communication session.',
    `contact_id` BIGINT COMMENT 'Reference to the specific contact person involved in this communication session, may differ from policyholder (e.g., beneficiary, agent, legal representative).',
    `contract_owner_id` BIGINT COMMENT 'Reference to the policyholder who is the primary party in this communication session.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent or representative assigned to handle this communication session.',
    `escalated_to_employee_id` BIGINT COMMENT 'Reference to the supervisor or manager to whom this session was escalated, if applicable.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy associated with this communication session.',
    `comm_template_id` BIGINT COMMENT 'Reference to the communication template used for this session, if applicable.',
    `follow_up_comm_session_id` BIGINT COMMENT 'Self-referencing FK on comm_session (follow_up_comm_session_id)',
    `attachment_count` STRING COMMENT 'Number of documents or files attached to this communication session.',
    `channel_type` STRING COMMENT 'The channel through which the communication session was conducted.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the communication session was formally closed.',
    `complaint_category` STRING COMMENT 'Classification of the complaint type if this session involves a complaint.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this communication session record was first created in the system.',
    `customer_callback_number` STRING COMMENT 'Phone number provided by the customer for callback purposes during this communication session.',
    `customer_email` STRING COMMENT 'Email address used by the customer for this communication session.',
    `direction` STRING COMMENT 'Indicates whether the communication was initiated by the customer (inbound) or by the company (outbound).',
    `duration_minutes` STRING COMMENT 'Total duration of the communication session measured in minutes, from initiation to closure.',
    `escalation_level` STRING COMMENT 'Number indicating how many times the session has been escalated to higher authority levels. Zero indicates no escalation.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the first response was provided to the customer in this session.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up action should be completed for this communication session.',
    `follow_up_required` BOOLEAN COMMENT 'Boolean flag indicating whether this communication session requires follow-up action.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the communication session was first initiated or received.',
    `interaction_count` STRING COMMENT 'Total number of individual interactions or exchanges that occurred within this communication session.',
    `is_complaint` BOOLEAN COMMENT 'Boolean flag indicating whether this communication session involves a formal customer complaint.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language used in the communication session.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this communication session record was last updated or modified.',
    `priority_level` STRING COMMENT 'Priority classification assigned to the communication session based on urgency and business impact.',
    `regulatory_report_date` DATE COMMENT 'Date when this communication session was reported to regulatory authorities, if applicable.',
    `regulatory_reportable` BOOLEAN COMMENT 'Boolean flag indicating whether this communication session must be reported to regulatory authorities.',
    `resolution_code` STRING COMMENT 'Standardized code indicating how the communication session was resolved or the outcome achieved.',
    `resolution_notes` STRING COMMENT 'Detailed notes describing the resolution or outcome of the communication session.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the communication session was marked as resolved.',
    `satisfaction_rating` STRING COMMENT 'Customer-provided satisfaction rating for the communication session, typically on a scale of 1 to 5.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Numerical score representing the customer sentiment detected during the communication session, ranging from -100 (very negative) to +100 (very positive).',
    `session_number` STRING COMMENT 'Business-facing unique identifier for the communication session, used for tracking and reference in customer service systems.',
    `session_status` STRING COMMENT 'Current lifecycle status of the communication session.',
    `session_summary` STRING COMMENT 'Detailed summary of the communication session content, including key discussion points, customer concerns, and actions taken.',
    `session_type` STRING COMMENT 'Classification of the communication session based on the primary purpose or subject matter.',
    `source_system` STRING COMMENT 'Name of the system or platform from which this communication session record originated.',
    `subject_line` STRING COMMENT 'Brief summary or subject line describing the primary topic of the communication session.',
    CONSTRAINT pk_comm_session PRIMARY KEY(`comm_session_id`)
) COMMENT 'Master reference table for comm_session. Referenced by session_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`correspondence`.`message_thread` (
    `message_thread_id` BIGINT COMMENT 'Primary key for message_thread',
    `team_id` BIGINT COMMENT 'Reference to the service team or department responsible for handling this message thread.',
    `claim_id` BIGINT COMMENT 'Reference to a claim if this message thread is related to claim correspondence. Null if not claim-related.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent or representative currently assigned to handle this message thread.',
    `parent_thread_id` BIGINT COMMENT 'Reference to a parent message thread if this thread is a continuation or sub-thread of another thread. Null if this is a root thread.',
    `party_id` BIGINT COMMENT 'Reference to the policyholder who is the primary party in this message thread.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy associated with this message thread.',
    `parent_message_thread_id` BIGINT COMMENT 'Self-referencing FK on message_thread (parent_message_thread_id)',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the message thread was formally closed. Null if still open.',
    `complaint_category` STRING COMMENT 'Classification of the complaint type if this thread is flagged as a complaint. Null if not a complaint.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether this message thread contains confidential or sensitive information requiring restricted access.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this message thread record was first created in the system.',
    `customer_satisfaction_score` STRING COMMENT 'Customer-provided satisfaction rating for the handling of this message thread, typically on a scale of 1-5 or 1-10.',
    `escalated_timestamp` TIMESTAMP COMMENT 'Date and time when the message thread was last escalated to a higher level. Null if never escalated.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the message thread, with 0 indicating no escalation and higher numbers indicating progressive management escalation.',
    `first_response_timestamp` TIMESTAMP COMMENT 'Date and time when the first response was sent to the customer after thread initiation.',
    `inbound_message_count` STRING COMMENT 'Number of messages received from the customer or external party in this thread.',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the message thread was first created or initiated by the customer or system.',
    `is_complaint` BOOLEAN COMMENT 'Indicates whether this message thread has been classified as a formal customer complaint requiring regulatory tracking.',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code indicating the primary language used in this message thread.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent activity or message in this thread.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this message thread record was last updated or modified.',
    `message_count` STRING COMMENT 'Total number of individual messages exchanged within this thread.',
    `outbound_message_count` STRING COMMENT 'Number of messages sent to the customer or external party from the company in this thread.',
    `primary_channel` STRING COMMENT 'The primary communication channel through which this message thread was initiated.',
    `priority_level` STRING COMMENT 'Priority classification for the message thread determining response time requirements and escalation rules.',
    `regulatory_reportable` BOOLEAN COMMENT 'Indicates whether this message thread must be included in regulatory reporting to insurance commissioners or governing bodies.',
    `requires_translation` BOOLEAN COMMENT 'Indicates whether this message thread requires translation services due to language barriers.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the message thread was marked as resolved. Null if not yet resolved.',
    `retention_end_date` DATE COMMENT 'Date when this message thread record is eligible for archival or deletion based on retention policies.',
    `sentiment_score` STRING COMMENT 'Automated or manual assessment of the overall customer sentiment expressed in this message thread.',
    `sla_resolution_met` BOOLEAN COMMENT 'Indicates whether the thread was resolved within the SLA target resolution time.',
    `sla_response_met` BOOLEAN COMMENT 'Indicates whether the first response was provided within the SLA target response time.',
    `sla_target_resolution_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which this thread should be resolved, based on priority and type.',
    `sla_target_response_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the first response to this thread should be provided, based on priority and type.',
    `subject_line` STRING COMMENT 'Brief summary or subject of the message thread, providing context for the correspondence topic.',
    `thread_category` STRING COMMENT 'Business category grouping for the message thread, used for routing and reporting purposes.',
    `thread_description` STRING COMMENT 'Detailed description of the message thread topic, issue, or inquiry being addressed.',
    `thread_reference_number` STRING COMMENT 'Business-facing unique reference number for the message thread, used in customer communications and service interactions.',
    `thread_status` STRING COMMENT 'Current lifecycle status of the message thread indicating its state in the correspondence workflow.',
    `thread_type` STRING COMMENT 'Classification of the message thread based on the nature of the correspondence.',
    CONSTRAINT pk_message_thread PRIMARY KEY(`message_thread_id`)
) COMMENT 'Master reference table for message_thread. Referenced by thread_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_bulk_comm_campaign_id` FOREIGN KEY (`bulk_comm_campaign_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign`(`bulk_comm_campaign_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ADD CONSTRAINT `fk_correspondence_communication_reply_to_communication_id` FOREIGN KEY (`reply_to_communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ADD CONSTRAINT `fk_correspondence_comm_template_master_comm_template_id` FOREIGN KEY (`master_comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ADD CONSTRAINT `fk_correspondence_comm_template_version_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ADD CONSTRAINT `fk_correspondence_comm_template_version_superseded_by_version_comm_template_version_id` FOREIGN KEY (`superseded_by_version_comm_template_version_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template_version`(`comm_template_version_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ADD CONSTRAINT `fk_correspondence_comm_template_version_prior_comm_template_version_id` FOREIGN KEY (`prior_comm_template_version_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template_version`(`comm_template_version_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_bulk_comm_campaign_id` FOREIGN KEY (`bulk_comm_campaign_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign`(`bulk_comm_campaign_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ADD CONSTRAINT `fk_correspondence_outbound_notice_resend_outbound_notice_id` FOREIGN KEY (`resend_outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ADD CONSTRAINT `fk_correspondence_inbound_correspondence_reply_to_inbound_correspondence_id` FOREIGN KEY (`reply_to_inbound_correspondence_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`inbound_correspondence`(`inbound_correspondence_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ADD CONSTRAINT `fk_correspondence_call_record_follow_up_call_record_id` FOREIGN KEY (`follow_up_call_record_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`call_record`(`call_record_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ADD CONSTRAINT `fk_correspondence_complaint_related_complaint_id` FOREIGN KEY (`related_complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ADD CONSTRAINT `fk_correspondence_complaint_activity_prior_complaint_activity_id` FOREIGN KEY (`prior_complaint_activity_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint_activity`(`complaint_activity_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_returned_mail_id` FOREIGN KEY (`returned_mail_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`returned_mail`(`returned_mail_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ADD CONSTRAINT `fk_correspondence_delivery_tracking_retry_delivery_tracking_id` FOREIGN KEY (`retry_delivery_tracking_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`delivery_tracking`(`delivery_tracking_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ADD CONSTRAINT `fk_correspondence_queue_escalation_queue_id` FOREIGN KEY (`escalation_queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ADD CONSTRAINT `fk_correspondence_queue_parent_queue_id` FOREIGN KEY (`parent_queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ADD CONSTRAINT `fk_correspondence_queue_assignment_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ADD CONSTRAINT `fk_correspondence_queue_assignment_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ADD CONSTRAINT `fk_correspondence_queue_assignment_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ADD CONSTRAINT `fk_correspondence_queue_assignment_reassigned_from_queue_assignment_id` FOREIGN KEY (`reassigned_from_queue_assignment_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue_assignment`(`queue_assignment_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ADD CONSTRAINT `fk_correspondence_notice_compliance_log_corrected_notice_compliance_log_id` FOREIGN KEY (`corrected_notice_compliance_log_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`notice_compliance_log`(`notice_compliance_log_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ADD CONSTRAINT `fk_correspondence_returned_mail_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ADD CONSTRAINT `fk_correspondence_returned_mail_outbound_notice_id` FOREIGN KEY (`outbound_notice_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`outbound_notice`(`outbound_notice_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ADD CONSTRAINT `fk_correspondence_returned_mail_prior_returned_mail_id` FOREIGN KEY (`prior_returned_mail_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`returned_mail`(`returned_mail_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ADD CONSTRAINT `fk_correspondence_address_search_returned_mail_id` FOREIGN KEY (`returned_mail_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`returned_mail`(`returned_mail_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ADD CONSTRAINT `fk_correspondence_address_search_prior_address_search_id` FOREIGN KEY (`prior_address_search_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`address_search`(`address_search_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`complaint`(`complaint_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_parent_message_secure_message_id` FOREIGN KEY (`parent_message_secure_message_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`secure_message`(`secure_message_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_message_thread_id` FOREIGN KEY (`message_thread_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`message_thread`(`message_thread_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ADD CONSTRAINT `fk_correspondence_secure_message_reply_to_secure_message_id` FOREIGN KEY (`reply_to_secure_message_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`secure_message`(`secure_message_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ADD CONSTRAINT `fk_correspondence_comm_preference_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ADD CONSTRAINT `fk_correspondence_comm_preference_superseded_comm_preference_id` FOREIGN KEY (`superseded_comm_preference_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_preference`(`comm_preference_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ADD CONSTRAINT `fk_correspondence_escalation_escalated_from_escalation_id` FOREIGN KEY (`escalated_from_escalation_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`escalation`(`escalation_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ADD CONSTRAINT `fk_correspondence_sla_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ADD CONSTRAINT `fk_correspondence_sla_superseded_by_sla_id` FOREIGN KEY (`superseded_by_sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ADD CONSTRAINT `fk_correspondence_sla_superseded_sla_id` FOREIGN KEY (`superseded_sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ADD CONSTRAINT `fk_correspondence_doi_inquiry_related_doi_inquiry_id` FOREIGN KEY (`related_doi_inquiry_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`doi_inquiry`(`doi_inquiry_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_doi_inquiry_id` FOREIGN KEY (`doi_inquiry_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`doi_inquiry`(`doi_inquiry_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ADD CONSTRAINT `fk_correspondence_doi_response_superseded_doi_response_id` FOREIGN KEY (`superseded_doi_response_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`doi_response`(`doi_response_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ADD CONSTRAINT `fk_correspondence_bulk_comm_campaign_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ADD CONSTRAINT `fk_correspondence_bulk_comm_campaign_follow_up_bulk_comm_campaign_id` FOREIGN KEY (`follow_up_bulk_comm_campaign_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign`(`bulk_comm_campaign_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_bulk_comm_campaign_id` FOREIGN KEY (`bulk_comm_campaign_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign`(`bulk_comm_campaign_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_comm_channel_id` FOREIGN KEY (`comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ADD CONSTRAINT `fk_correspondence_correspondence_bulk_comm_recipient_resend_correspondence_bulk_comm_recipient_id` FOREIGN KEY (`resend_correspondence_bulk_comm_recipient_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient`(`correspondence_bulk_comm_recipient_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ADD CONSTRAINT `fk_correspondence_comm_channel_parent_comm_channel_id` FOREIGN KEY (`parent_comm_channel_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_channel`(`comm_channel_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ADD CONSTRAINT `fk_correspondence_suppression_list_superseded_suppression_list_id` FOREIGN KEY (`superseded_suppression_list_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`suppression_list`(`suppression_list_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_communication_id` FOREIGN KEY (`communication_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`communication`(`communication_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ADD CONSTRAINT `fk_correspondence_translation_request_retranslation_request_id` FOREIGN KEY (`retranslation_request_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`translation_request`(`translation_request_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_comm_session_id` FOREIGN KEY (`comm_session_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_session`(`comm_session_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`sla`(`sla_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ADD CONSTRAINT `fk_correspondence_comm_audit_trail_prior_comm_audit_trail_id` FOREIGN KEY (`prior_comm_audit_trail_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_audit_trail`(`comm_audit_trail_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ADD CONSTRAINT `fk_correspondence_template_translation_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ADD CONSTRAINT `fk_correspondence_queue_vendor_assignment_correspondence_queue_id` FOREIGN KEY (`correspondence_queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ADD CONSTRAINT `fk_correspondence_queue_vendor_assignment_queue_id` FOREIGN KEY (`queue_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`queue`(`queue_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_comm_template_id` FOREIGN KEY (`comm_template_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_template`(`comm_template_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ADD CONSTRAINT `fk_correspondence_comm_session_follow_up_comm_session_id` FOREIGN KEY (`follow_up_comm_session_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`comm_session`(`comm_session_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_parent_thread_id` FOREIGN KEY (`parent_thread_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`message_thread`(`message_thread_id`);
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ADD CONSTRAINT `fk_correspondence_message_thread_parent_message_thread_id` FOREIGN KEY (`parent_message_thread_id`) REFERENCES `life_insurance_ecm`.`correspondence`.`message_thread`(`message_thread_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`correspondence` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `life_insurance_ecm`.`correspondence` SET TAGS ('dbx_domain' = 'correspondence');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `bulk_comm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Comm Campaign Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `reply_to_communication_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `body_text` SET TAGS ('dbx_business_glossary_term' = 'Communication Body Text');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `communication_category` SET TAGS ('dbx_business_glossary_term' = 'Communication Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `communication_number` SET TAGS ('dbx_business_glossary_term' = 'Communication Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `communication_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `delivery_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Communication Direction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `is_complaint` SET TAGS ('dbx_business_glossary_term' = 'Complaint Communication Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Required Communication Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Communication Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_city` SET TAGS ('dbx_business_glossary_term' = 'Recipient City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient State or Province');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `recipient_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`communication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Template ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `master_comm_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `accessibility_compliant` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `attachment_required` SET TAGS ('dbx_business_glossary_term' = 'Attachment Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `attachment_type_list` SET TAGS ('dbx_business_glossary_term' = 'Attachment Type List');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `business_trigger` SET TAGS ('dbx_business_glossary_term' = 'Business Trigger');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'letter|email|sms|secure_portal|fax|ivr');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'standard|certified|registered|electronic|secure');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `merge_field_list` SET TAGS ('dbx_business_glossary_term' = 'Merge Field List');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'life|annuity|disability|ltc|universal|all');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|conditional');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_business_glossary_term' = 'Reply-To Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `requires_signature` SET TAGS ('dbx_business_glossary_term' = 'Requires Signature Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Subject Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_content` SET TAGS ('dbx_business_glossary_term' = 'Template Content');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_content` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_description` SET TAGS ('dbx_business_glossary_term' = 'Template Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `translation_available` SET TAGS ('dbx_business_glossary_term' = 'Translation Available Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `comm_template_version_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `quaternary_comm_approved_by_user_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `superseded_by_version_comm_template_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseding Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `tertiary_comm_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modifying User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `tertiary_comm_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `tertiary_comm_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `prior_comm_template_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `archive_flag` SET TAGS ('dbx_business_glossary_term' = 'Archive Status Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Version Change Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Version Change Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'regulatory_update|language_correction|content_enhancement|channel_adaptation|legal_review|compliance_mandate');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'email|letter|sms|portal|mobile_app|ivr');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `communication_category` SET TAGS ('dbx_business_glossary_term' = 'Communication Category Classification');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `communication_category` SET TAGS ('dbx_value_regex' = 'policy_service|billing_notice|claim_correspondence|regulatory_notice|marketing|complaint_response');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `content_hash` SET TAGS ('dbx_business_glossary_term' = 'Template Content Hash Value');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `content_hash` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Creation Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `disclaimer_block` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclaimer Block');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Template Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Usage Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `merge_field_schema` SET TAGS ('dbx_business_glossary_term' = 'Merge Field Schema Definition');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Version Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `product_line_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Product Line Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `readability_score` SET TAGS ('dbx_business_glossary_term' = 'Content Readability Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Communication Subject Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `template_body_text` SET TAGS ('dbx_business_glossary_term' = 'Template Body Content Text');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Template Usage Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Template Version Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Lifecycle Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_template_version` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Template Word Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `outbound_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Notice Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `bulk_comm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Comm Campaign Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `contract_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `experience_study_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Generated Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Print Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `resend_outbound_notice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'pdf|html|text|xml|other');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `content_reference` SET TAGS ('dbx_business_glossary_term' = 'Content Reference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `delivery_preference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Preference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `delivery_preference` SET TAGS ('dbx_value_regex' = 'paper|electronic|both');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generation Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `notice_category` SET TAGS ('dbx_business_glossary_term' = 'Notice Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_city` SET TAGS ('dbx_business_glossary_term' = 'Recipient City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient State or Province');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `scheduled_send_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`outbound_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `inbound_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Correspondence Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `policyholder_beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Queue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Scanned Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Scan Batch Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `reply_to_inbound_correspondence_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `correspondence_body` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Body Text');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `correspondence_subject` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Subject Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'service_request|complaint|inquiry|legal_notice|regulatory_inquiry|document_submission');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `is_complaint` SET TAGS ('dbx_business_glossary_term' = 'Complaint Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `is_legal_notice` SET TAGS ('dbx_business_glossary_term' = 'Legal Notice Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `is_regulatory` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inquiry Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Total Page Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `postmark_date` SET TAGS ('dbx_business_glossary_term' = 'Postmark Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Received Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Received Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `requires_response` SET TAGS ('dbx_business_glossary_term' = 'Response Required Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `response_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Response Sent Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_address` SET TAGS ('dbx_business_glossary_term' = 'Sender Mailing Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Full Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_phone` SET TAGS ('dbx_business_glossary_term' = 'Sender Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `sender_type` SET TAGS ('dbx_business_glossary_term' = 'Sender Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `subject_classification` SET TAGS ('dbx_business_glossary_term' = 'Subject Classification Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `triage_status` SET TAGS ('dbx_business_glossary_term' = 'Triage Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `triage_status` SET TAGS ('dbx_value_regex' = 'pending_review|triaged|assigned|in_progress|resolved|closed');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`inbound_correspondence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_record_id` SET TAGS ('dbx_business_glossary_term' = 'Call Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Call Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Call Center Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Queue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `follow_up_call_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'ssn_verification|dob_verification|policy_number|security_question|biometric|none');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Authentication Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `authentication_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_attempted|partial');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_direction` SET TAGS ('dbx_business_glossary_term' = 'Call Direction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_disposition` SET TAGS ('dbx_business_glossary_term' = 'Call Disposition');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_disposition` SET TAGS ('dbx_value_regex' = 'resolved|escalated|transferred|abandoned|callback_scheduled|voicemail');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Call Duration in Seconds');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call End Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_language` SET TAGS ('dbx_business_glossary_term' = 'Call Language');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_language` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|CHI|OTH');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_notes` SET TAGS ('dbx_business_glossary_term' = 'Call Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_recording_reference` SET TAGS ('dbx_business_glossary_term' = 'Call Recording Reference Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_recording_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Start Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_subject` SET TAGS ('dbx_business_glossary_term' = 'Call Subject');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_transcript_reference` SET TAGS ('dbx_business_glossary_term' = 'Call Transcript Reference Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_transcript_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'service_inquiry|complaint|claim_fnol|billing_question|policy_change_request|new_business_inquiry');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_name` SET TAGS ('dbx_business_glossary_term' = 'Caller Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Caller Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_relationship` SET TAGS ('dbx_business_glossary_term' = 'Caller Relationship');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `caller_relationship` SET TAGS ('dbx_value_regex' = 'policyholder|beneficiary|agent|claimant|authorized_representative|third_party');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `hold_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Hold Time in Seconds');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `ivr_path` SET TAGS ('dbx_business_glossary_term' = 'Interactive Voice Response (IVR) Path');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `qa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `quality_assurance_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `queue_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Queue Time in Seconds');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `transfer_count` SET TAGS ('dbx_business_glossary_term' = 'Transfer Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`call_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Aml Case Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Related Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Complainant Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `suitability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Related Suitability Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Related Compliance Issue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `policyholder_beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Privacy Incident Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Queue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Application Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `related_complaint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Acknowledged Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Assigned Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Closed Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_business_glossary_term' = 'Complainant Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_business_glossary_term' = 'Complainant Full Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_business_glossary_term' = 'Complainant Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Complainant Satisfaction Rating');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_type` SET TAGS ('dbx_business_glossary_term' = 'Complainant Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complainant_type` SET TAGS ('dbx_value_regex' = 'policyholder|beneficiary|agent|broker|third_party|regulator');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'claim_denial|claim_delay|billing_dispute|premium_issue|service_failure|agent_misconduct|[ENUM-REF-CANDIDATE: claim_denial|claim_delay|billing_dispute|premium_issue|service_failure|agent_misconduct|product_suitability|underwriting_decision|policy_s...');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_source` SET TAGS ('dbx_business_glossary_term' = 'Complaint Source Channel');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `financial_remedy_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Remedy Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `financial_remedy_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Remedy Currency Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `financial_remedy_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `naic_complaint_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Complaint Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Complaint Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `regulator_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulator Involved Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `regulator_name` SET TAGS ('dbx_business_glossary_term' = 'Regulator Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `regulator_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulator Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `regulatory_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `regulatory_response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Submitted Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Resolution Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'upheld|partially_upheld|not_upheld|withdrawn|no_action_required');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Complaint Subcategory');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `complaint_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Activity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Actor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `primary_complaint_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `primary_complaint_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Sla Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `tertiary_complaint_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `tertiary_complaint_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `prior_complaint_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|cancelled');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `actor_name` SET TAGS ('dbx_business_glossary_term' = 'Actor Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `actor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'internal_staff|external_regulator|policyholder|agent|system_automated');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|fax|web_portal|mobile_app');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `doi_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `doi_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `resolution_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Resolution Offered Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'monetary|policy_correction|apology|explanation|other');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`complaint_activity` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tracking ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `returned_mail_id` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `retry_delivery_tracking_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Attempt Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `bounce_type` SET TAGS ('dbx_business_glossary_term' = 'Bounce Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `bounce_type` SET TAGS ('dbx_value_regex' = 'hard_bounce|soft_bounce|technical_bounce');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|regulatory');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|returned|bounced|undeliverable|opened');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `final_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Final Delivery Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `first_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Attempt Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `proof_of_delivery_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Received Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `proof_of_delivery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_city` SET TAGS ('dbx_business_glossary_term' = 'Recipient City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_state_province` SET TAGS ('dbx_business_glossary_term' = 'Recipient State or Province');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `recipient_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `redelivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Redelivery Instructions');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `redelivery_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Redelivery Requested Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `regulatory_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`delivery_tracking` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Queue Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `escalation_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Queue Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `parent_queue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `active_agent_count` SET TAGS ('dbx_business_glossary_term' = 'Active Agent Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `assignment_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Assignment Algorithm');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `assignment_algorithm` SET TAGS ('dbx_value_regex' = 'round_robin|skill_based|workload_balanced|manual');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `auto_assignment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Assignment Enabled Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `average_handling_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Handling Time (Minutes)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'mail|email|phone|fax|web_portal|mobile_app');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `current_item_count` SET TAGS ('dbx_business_glossary_term' = 'Current Item Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `escalation_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `manager_email` SET TAGS ('dbx_business_glossary_term' = 'Queue Manager Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Manager Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `max_queue_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Capacity');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `open_hours` SET TAGS ('dbx_business_glossary_term' = 'Queue Open Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `owning_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Unit');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `owning_department` SET TAGS ('dbx_business_glossary_term' = 'Owning Department');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `quality_review_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `quality_sample_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Sample Rate Percentage');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_code` SET TAGS ('dbx_business_glossary_term' = 'Queue Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_description` SET TAGS ('dbx_business_glossary_term' = 'Queue Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_status` SET TAGS ('dbx_business_glossary_term' = 'Queue Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_type` SET TAGS ('dbx_business_glossary_term' = 'Queue Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `queue_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|complaint|regulatory|escalation|returned_mail');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `requires_regulatory_tracking` SET TAGS ('dbx_business_glossary_term' = 'Requires Regulatory Tracking Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `sla_acknowledgment_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Acknowledgment Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `sla_compliance_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Rate Percentage');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `sla_resolution_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Resolution Days');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `supports_multi_language` SET TAGS ('dbx_business_glossary_term' = 'Supports Multi-Language Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `queue_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Queue Assignment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Item Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Assignment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Representative Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Queue Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Sla Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `reassigned_from_queue_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `actual_handling_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Handling Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|escalation|round_robin|skill_based|load_balanced');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|on_hold|reassigned|completed|cancelled');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|phone|mail|web_portal|mobile_app|fax');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'complaint|inquiry|service_request|claim_correspondence|policy_change|regulatory');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Assignment');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|routine');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Priority Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `skill_match_score` SET TAGS ('dbx_business_glossary_term' = 'Skill Match Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `sla_breach_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `sla_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_assignment` ALTER COLUMN `workload_balance_score` SET TAGS ('dbx_business_glossary_term' = 'Workload Balance Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `notice_compliance_log_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Compliance Log Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `contract_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `outbound_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Notice Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Sla Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `corrected_notice_compliance_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `actual_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Dispatch Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `audit_examiner_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Examiner Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `audit_examiner_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Examiner Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|late|missed|cured|pending_confirmation');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `cure_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Cure Action Taken');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `cure_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `days_to_deadline` SET TAGS ('dbx_business_glossary_term' = 'Days to Deadline');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `days_variance` SET TAGS ('dbx_business_glossary_term' = 'Days Variance');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'postal_mail|certified_mail|email|secure_portal|fax|sms');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `delivery_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tracking Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `notice_type` SET TAGS ('dbx_value_regex' = 'replacement|lapse|reinstatement|free_look|privacy|adverse_action');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'policyholder|insured|beneficiary|agent|trustee|assignee');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `regulatory_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `regulatory_requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `regulatory_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,30}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `template_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `triggering_event_code` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `triggering_event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`notice_compliance_log` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `returned_mail_id` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `outbound_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Correspondence ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `prior_returned_mail_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|unverified|deceased_confirmed|no_valid_address_found');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `address_verification_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Attempted Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Attempted Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_city` SET TAGS ('dbx_business_glossary_term' = 'Attempted City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_country_code` SET TAGS ('dbx_business_glossary_term' = 'Attempted Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Attempted Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_state` SET TAGS ('dbx_business_glossary_term' = 'Attempted State');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `attempted_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `correspondence_priority` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Priority');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `correspondence_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|regulatory_required|time_sensitive');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'notice|statement|claim_letter|policy_document|billing_notice|regulatory_notice');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `dmf_match_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Death Master File (DMF) Match Found Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `dmf_search_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Death Master File (DMF) Search Performed Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `follow_up_action_code` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `follow_up_action_code` SET TAGS ('dbx_value_regex' = 'address_search|skip_trace|unclaimed_property_notification|policy_lapse|contact_beneficiary|no_action');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `follow_up_action_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `ncoa_match_found_flag` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Match Found Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `ncoa_search_date` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Search Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `ncoa_search_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'National Change of Address (NCOA) Search Performed Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `original_mail_date` SET TAGS ('dbx_business_glossary_term' = 'Original Mail Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `policy_status_at_return` SET TAGS ('dbx_business_glossary_term' = 'Policy Status at Return');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `policy_status_at_return` SET TAGS ('dbx_value_regex' = 'active|lapsed|grace_period|paid_up|surrendered|matured');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|escalated');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `skip_trace_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Skip Trace Initiated Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `skip_trace_vendor` SET TAGS ('dbx_business_glossary_term' = 'Skip Trace Vendor');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `unclaimed_property_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Property Notification Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `unclaimed_property_state` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Property State');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`returned_mail` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_search_id` SET TAGS ('dbx_business_glossary_term' = 'Address Search ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_search_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_search_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `returned_mail_id` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `prior_address_search_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Address Confidence Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_confidence_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_confidence_score` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Address Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_effective_date` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Address Found Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_found_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_found_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_update_action` SET TAGS ('dbx_business_glossary_term' = 'Address Update Action');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_update_action` SET TAGS ('dbx_value_regex' = 'updated|no_action|manual_review|escalated|escheatment_initiated');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_update_action` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `address_update_action` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `deceased_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `escheatment_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Risk Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `manual_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Original Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Original Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_city` SET TAGS ('dbx_business_glossary_term' = 'Original City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_country_code` SET TAGS ('dbx_business_glossary_term' = 'Original Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Original Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_state` SET TAGS ('dbx_business_glossary_term' = 'Original State');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `original_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `returned_mail_date` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Search Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Search Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Search Initiation Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_notes` SET TAGS ('dbx_business_glossary_term' = 'Search Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Search Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_reason_code` SET TAGS ('dbx_value_regex' = 'returned_mail|death_claim|escheatment_prevention|beneficiary_search|policy_servicing|regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_request_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Search Request Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_result_code` SET TAGS ('dbx_business_glossary_term' = 'Search Result Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_result_code` SET TAGS ('dbx_value_regex' = 'address_found|no_address_found|deceased_confirmed|multiple_matches|insufficient_data|error');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_status` SET TAGS ('dbx_business_glossary_term' = 'Search Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|completed|failed|cancelled');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_type` SET TAGS ('dbx_business_glossary_term' = 'Search Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_type` SET TAGS ('dbx_value_regex' = 'ncoa|skip_trace|dmf_cross_reference|credit_header|public_records|manual_research');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `search_vendor` SET TAGS ('dbx_business_glossary_term' = 'Search Vendor');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `state_reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Reporting Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Updated Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Updated Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_city` SET TAGS ('dbx_business_glossary_term' = 'Updated City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_country_code` SET TAGS ('dbx_business_glossary_term' = 'Updated Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Updated Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_state` SET TAGS ('dbx_business_glossary_term' = 'Updated State');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`address_search` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `secure_message_id` SET TAGS ('dbx_business_glossary_term' = 'Secure Message ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `parent_message_secure_message_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Message ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sender User ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Party ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `tertiary_secure_compliance_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `tertiary_secure_compliance_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `tertiary_secure_compliance_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Message Thread ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `reply_to_secure_message_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `archived_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Archived Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `auto_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Response Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `compliance_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewed Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `encryption_method` SET TAGS ('dbx_value_regex' = 'AES256|TLS1.2|TLS1.3');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `has_sensitive_content_flag` SET TAGS ('dbx_business_glossary_term' = 'Has Sensitive Content Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|CHI|GER|JPN');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_body` SET TAGS ('dbx_business_glossary_term' = 'Message Body');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_body` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_category` SET TAGS ('dbx_business_glossary_term' = 'Message Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_category` SET TAGS ('dbx_value_regex' = 'policy_inquiry|billing_question|claim_status|beneficiary_change|address_update|general_inquiry');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_number` SET TAGS ('dbx_business_glossary_term' = 'Message Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `message_number` SET TAGS ('dbx_value_regex' = '^SM[0-9]{10}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Message Priority');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'policyholder|beneficiary|agent|company|system');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `replied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Replied Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `retention_category` SET TAGS ('dbx_business_glossary_term' = 'Retention Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `retention_category` SET TAGS ('dbx_value_regex' = 'standard|extended|legal_hold|permanent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `secure_message_status` SET TAGS ('dbx_business_glossary_term' = 'Message Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `sender_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `sender_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `sender_type` SET TAGS ('dbx_business_glossary_term' = 'Sender Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `sender_type` SET TAGS ('dbx_value_regex' = 'policyholder|beneficiary|agent|company|system');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `session_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Message Subject');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`secure_message` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `comm_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `party_address_id` SET TAGS ('dbx_business_glossary_term' = 'Postal Address ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `party_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `party_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `superseded_comm_preference_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `do_not_contact_reason` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `e_delivery_consent_method` SET TAGS ('dbx_business_glossary_term' = 'E-Delivery Consent Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `e_delivery_consent_method` SET TAGS ('dbx_value_regex' = 'online_portal|mobile_app|paper_form|phone_ivr|agent_assisted');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `e_delivery_enrolled` SET TAGS ('dbx_business_glossary_term' = 'E-Delivery Enrolled');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `e_delivery_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'E-Delivery Enrollment Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `format_preference` SET TAGS ('dbx_business_glossary_term' = 'Format Preference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `format_preference` SET TAGS ('dbx_value_regex' = 'standard|large_print|braille|audio');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `frequency_preference` SET TAGS ('dbx_business_glossary_term' = 'Frequency Preference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `frequency_preference` SET TAGS ('dbx_value_regex' = 'immediate|daily_digest|weekly_digest|monthly_digest');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `marketing_opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `marketing_opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-Out Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `notice_category` SET TAGS ('dbx_business_glossary_term' = 'Notice Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `notice_category` SET TAGS ('dbx_value_regex' = 'billing|policy_change|regulatory|claims|marketing|service');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `phone_contact_consent` SET TAGS ('dbx_business_glossary_term' = 'Phone Contact Consent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `phone_contact_consent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `phone_contact_consent` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|expired');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_value_regex' = 'party_level|policy_level|product_level|notice_category_level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `secondary_channel` SET TAGS ('dbx_business_glossary_term' = 'Secondary Channel');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `secondary_channel` SET TAGS ('dbx_value_regex' = 'postal_mail|email|sms|portal|mobile_app|fax');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `sms_consent` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Consent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `sms_consent_date` SET TAGS ('dbx_business_glossary_term' = 'SMS (Short Message Service) Consent Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `suppress_duplicate_notices` SET TAGS ('dbx_business_glossary_term' = 'Suppress Duplicate Notices');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `third_party_disclosure_consent` SET TAGS ('dbx_business_glossary_term' = 'Third Party Disclosure Consent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'email_confirmation|phone_verification|postal_confirmation|portal_login|agent_verification');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_preference` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_escalated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_escalated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_escalated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Queue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Sla Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalated_from_escalation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_category` SET TAGS ('dbx_business_glossary_term' = 'Escalation Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_category` SET TAGS ('dbx_value_regex' = 'service_quality|claims_handling|underwriting_decision|billing_dispute|policy_servicing|agent_conduct');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_number` SET TAGS ('dbx_business_glossary_term' = 'Escalation Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'complaint|sla_breach|regulatory_inquiry|litigation_risk|executive_review|fraud_suspicion');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `is_litigation_risk` SET TAGS ('dbx_business_glossary_term' = 'Is Litigation Risk Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `is_regulatory_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `resolution_code` SET TAGS ('dbx_business_glossary_term' = 'Resolution Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `sla_breach_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Trigger Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`escalation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Service Level Agreement (SLA) ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `superseded_by_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Service Level Agreement (SLA) ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `superseded_sla_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `acknowledgment_window_days` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Window Days');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `acknowledgment_window_unit` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Window Unit');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `acknowledgment_window_unit` SET TAGS ('dbx_value_regex' = 'business_days|calendar_days|hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `auto_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `business_hours_only_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Hours Only Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `correspondence_category` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `correspondence_category` SET TAGS ('dbx_value_regex' = 'complaint_acknowledgment|regulatory_inquiry_response|inbound_service_letter|doi_inquiry|policy_service_request|claim_correspondence');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `escalation_queue_code` SET TAGS ('dbx_business_glossary_term' = 'Escalation Queue Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `escalation_queue_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `escalation_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Unit');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `escalation_threshold_unit` SET TAGS ('dbx_value_regex' = 'business_days|calendar_days|hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `exclude_holidays_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclude Holidays Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `notification_template_code` SET TAGS ('dbx_business_glossary_term' = 'Notification Template Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `notification_template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `requires_compliance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Compliance Review Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `requires_legal_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Legal Review Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `requires_management_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Management Review Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `resolution_window_days` SET TAGS ('dbx_business_glossary_term' = 'Resolution Window Days');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `resolution_window_unit` SET TAGS ('dbx_business_glossary_term' = 'Resolution Window Unit');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `resolution_window_unit` SET TAGS ('dbx_value_regex' = 'business_days|calendar_days|hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`sla` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `doi_inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Inquiry Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Related Exam Finding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `market_conduct_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Related Market Conduct Examination Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Queue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `rbc_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rbc Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Regulatory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `related_doi_inquiry_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `assigned_regulatory_affairs_contact` SET TAGS ('dbx_business_glossary_term' = 'Assigned Regulatory Affairs Contact');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `complainant_contact_info` SET TAGS ('dbx_business_glossary_term' = 'Complainant Contact Information');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `complainant_contact_info` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `complainant_contact_info` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `complainant_name` SET TAGS ('dbx_business_glossary_term' = 'Complainant Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `complainant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `complainant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'resolved_no_action|resolved_with_corrective_action|upheld_complaint|dismissed|pending|escalated_to_enforcement');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `fine_or_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Fine or Penalty Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `fine_or_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `fine_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fine Payment Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_category` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_description` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_received_date` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Received Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_status` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_subject` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Subject');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_type` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `inquiry_type` SET TAGS ('dbx_value_regex' = 'consumer_complaint|market_conduct_inquiry|regulatory_investigation|information_request|examination_follow_up|enforcement_action');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `legal_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Involved Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `response_method` SET TAGS ('dbx_value_regex' = 'email|portal|mail|fax|in_person');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Response Summary');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_inquiry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `doi_response_id` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Response Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `doi_inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Inquiry Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitting User Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Response Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Response Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `statutory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `tertiary_doi_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `tertiary_doi_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `tertiary_doi_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `superseded_doi_response_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Receipt Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `acknowledgment_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `acknowledgment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Response Approval Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `attachment_list` SET TAGS ('dbx_business_glossary_term' = 'Attachment List');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `days_to_respond` SET TAGS ('dbx_business_glossary_term' = 'Days to Respond');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Examiner Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Examiner Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examiner Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `examiner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `regulatory_body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'accepted|additional_info_requested|corrective_action_required|closed_satisfactory|closed_unsatisfactory|pending');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_body_text` SET TAGS ('dbx_business_glossary_term' = 'Response Body Content');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_body_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_content_reference` SET TAGS ('dbx_business_glossary_term' = 'Response Content Document Reference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submission Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_method` SET TAGS ('dbx_business_glossary_term' = 'Response Delivery Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_method` SET TAGS ('dbx_value_regex' = 'written_letter|portal_submission|email|fax|certified_mail|hand_delivery');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_notes` SET TAGS ('dbx_business_glossary_term' = 'Response Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|submitted|acknowledged|closed');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_subject` SET TAGS ('dbx_business_glossary_term' = 'Response Subject Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Submission Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_type` SET TAGS ('dbx_business_glossary_term' = 'Response Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `response_type` SET TAGS ('dbx_value_regex' = 'initial|supplemental|final|interim|clarification|corrective_action');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `submitted_by_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Submitting Officer Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `submitted_by_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `submitted_by_officer_title` SET TAGS ('dbx_business_glossary_term' = 'Submitting Officer Title');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `timeliness_status` SET TAGS ('dbx_business_glossary_term' = 'Response Timeliness Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `timeliness_status` SET TAGS ('dbx_value_regex' = 'on_time|late|early');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tracking Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`doi_response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `bulk_comm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Communication Campaign Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `follow_up_bulk_comm_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `actual_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Dispatch Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `actual_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Sent Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `bulk_comm_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `bulk_comm_campaign_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `business_trigger` SET TAGS ('dbx_business_glossary_term' = 'Business Trigger');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `campaign_category` SET TAGS ('dbx_business_glossary_term' = 'Campaign Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `campaign_category` SET TAGS ('dbx_value_regex' = 'compliance|servicing|disclosure|notification|informational');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `campaign_number` SET TAGS ('dbx_business_glossary_term' = 'Campaign Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'regulatory_notice|operational_notice|product_discontinuation|rate_action|class_action_settlement|privacy_notice');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `delivery_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `delivery_success_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Success Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Campaign Priority');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_business_glossary_term' = 'Reply-To Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `scheduled_dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Dispatch Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `sender_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Subject Line');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `target_population_criteria` SET TAGS ('dbx_business_glossary_term' = 'Target Population Criteria');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `target_recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Target Recipient Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `template_version` SET TAGS ('dbx_business_glossary_term' = 'Template Version');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`bulk_comm_campaign` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `correspondence_bulk_comm_recipient_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Communication Recipient ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `bulk_comm_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Campaign ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Comm Channel Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Generated Communication ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Document ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `resend_correspondence_bulk_comm_recipient_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `delivery_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `delivery_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Delivery Failure Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `delivery_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Outcome Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `merge_data_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Merge Data Snapshot');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opened Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `proof_of_delivery_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 1');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address Line 2');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_city` SET TAGS ('dbx_business_glossary_term' = 'Recipient City');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Country Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Postal Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Recipient Sequence Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient State or Province');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `recipient_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `regulatory_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `returned_mail_flag` SET TAGS ('dbx_business_glossary_term' = 'Returned Mail Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'Suppression Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `suppression_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `suppression_reason_code` SET TAGS ('dbx_value_regex' = 'opt_out|deceased|returned_mail|invalid_address|duplicate|regulatory_exclusion');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`correspondence_bulk_comm_recipient` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `comm_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `parent_comm_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `accessibility_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `aml_kyc_verification_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Know Your Customer (KYC) Verification Supported Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `average_delivery_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Average Delivery Time (Hours)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `batch_processing_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Processing Supported Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_business_glossary_term' = 'Channel Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `channel_category` SET TAGS ('dbx_value_regex' = 'electronic|physical|voice');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `channel_usage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Channel Usage Restriction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `cost_per_communication` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Communication');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `cost_per_communication` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'push|pull|interactive');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `e_delivery_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Delivery (E-Delivery) Consent Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `encryption_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `hipaa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `max_attachment_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attachment Size (Megabytes)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `multi_language_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Language Support Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deprecated');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `priority_routing_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Routing Available Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `proof_of_delivery_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery Available Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Acceptance Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `regulatory_acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|conditional|not_accepted');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `return_receipt_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Available Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `supports_attachments_flag` SET TAGS ('dbx_business_glossary_term' = 'Supports Attachments Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_business_glossary_term' = 'Tracking Capability');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `tracking_capability` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_channel` ALTER COLUMN `vendor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_list_id` SET TAGS ('dbx_business_glossary_term' = 'Suppression List ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing User ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `superseded_suppression_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `authorizing_source` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Source');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `authorizing_source` SET TAGS ('dbx_value_regex' = 'legal_department|compliance_department|policyholder_request|regulatory_order|customer_service|fraud_investigation');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `blocked_communication_count` SET TAGS ('dbx_business_glossary_term' = 'Blocked Communication Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `campaign_exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Campaign Exclusion List');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `channel_exclusion_list` SET TAGS ('dbx_business_glossary_term' = 'Channel Exclusion List');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `consent_revocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `deceased_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deceased Indicator');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `dmf_match_flag` SET TAGS ('dbx_business_glossary_term' = 'Death Master File (DMF) Match Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Suppression Effective Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `enforcement_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enforcement End Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `enforcement_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Start Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `escheatment_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Risk Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Suppression Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `last_blocked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Blocked Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `legal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Suppression Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `opt_out_method` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `opt_out_method` SET TAGS ('dbx_value_regex' = 'web_portal|phone_call|written_request|email_request|in_person|third_party_service');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `opt_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `override_authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Override Authorization Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `override_authorization_level` SET TAGS ('dbx_value_regex' = 'none|supervisor|manager|director|legal_counsel|compliance_officer');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Suppression Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_category` SET TAGS ('dbx_business_glossary_term' = 'Suppression Category');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_category` SET TAGS ('dbx_value_regex' = 'all_communications|marketing_only|electronic_only|phone_only|mail_only|specific_campaign');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_list_status` SET TAGS ('dbx_business_glossary_term' = 'Suppression Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_list_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|cancelled|pending_review');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_number` SET TAGS ('dbx_business_glossary_term' = 'Suppression Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Suppression Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `suppression_type` SET TAGS ('dbx_value_regex' = 'legal_hold|litigation_in_progress|deceased_no_marketing|opt_out_electronic|regulatory_restriction|do_not_contact');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`suppression_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translation_request_id` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Translator Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Source Communication Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Translated Comm Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Translation Vendor Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `retranslation_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Assignment Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Certification Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Delivery Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Translation Priority Level');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `quality_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `quality_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `quality_review_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Review Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `quality_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|passed|failed|waived');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Translation Quality Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `regulatory_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Translation Request Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'regulatory_mandated|customer_preference|legal_requirement|accessibility|voluntary');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `requested_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `source_language_code` SET TAGS ('dbx_business_glossary_term' = 'Source Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `target_language_code` SET TAGS ('dbx_business_glossary_term' = 'Target Language Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translated_content_reference` SET TAGS ('dbx_business_glossary_term' = 'Translated Content Reference');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translation_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Translation Cost Amount');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translation_method` SET TAGS ('dbx_business_glossary_term' = 'Translation Method');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translation_method` SET TAGS ('dbx_value_regex' = 'human|machine|hybrid|certified');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `translation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Start Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`translation_request` ALTER COLUMN `word_count` SET TAGS ('dbx_business_glossary_term' = 'Source Word Count');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `comm_audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Audit Trail Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Actor User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `comm_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Sla Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `tertiary_comm_exception_approval_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `tertiary_comm_exception_approval_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `tertiary_comm_exception_approval_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `prior_comm_audit_trail_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `action_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Action Reason Code');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `action_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Action Reason Description');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `actor_name` SET TAGS ('dbx_business_glossary_term' = 'Actor Name');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `actor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `actor_role` SET TAGS ('dbx_business_glossary_term' = 'Actor Role');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `after_state_snapshot` SET TAGS ('dbx_business_glossary_term' = 'After State Snapshot');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `before_state_snapshot` SET TAGS ('dbx_business_glossary_term' = 'Before State Snapshot');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `changed_fields` SET TAGS ('dbx_business_glossary_term' = 'Changed Fields');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Entity Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'communication|complaint|escalation|call_record|delivery_tracking|returned_mail');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `qa_review_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `qa_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Notes');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `qa_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Outcome');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `qa_review_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exception_approved|pending_review');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `quality_assurance_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `record_hash` SET TAGS ('dbx_business_glossary_term' = 'Record Hash');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_audit_trail` ALTER COLUMN `sox_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Audit Flag');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` SET TAGS ('dbx_association_edges' = 'correspondence.comm_template,vendor.vendor');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `template_translation_id` SET TAGS ('dbx_business_glossary_term' = 'Template Translation Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `comm_template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Translation - Comm Template Id');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Template Translation - Vendor Id');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Translation Certification Requirement');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Completion Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Translation Cost Currency');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Translation Engagement Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Translation Quality Score');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Translation Service Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `translation_cost` SET TAGS ('dbx_business_glossary_term' = 'Translation Service Cost');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `translation_language` SET TAGS ('dbx_business_glossary_term' = 'Translation Target Language');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`template_translation` ALTER COLUMN `translation_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Translation Turnaround Time');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` SET TAGS ('dbx_subdomain' = 'issue_resolution');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` SET TAGS ('dbx_association_edges' = 'correspondence.correspondence_queue,vendor.vendor');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `queue_vendor_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Queue Vendor Assignment Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `correspondence_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Queue Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Queue Vendor Assignment - Correspondence Queue Id');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `cost_per_item` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Item');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Hours');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`queue_vendor_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ALTER COLUMN `comm_session_id` SET TAGS ('dbx_business_glossary_term' = 'Comm Session Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ALTER COLUMN `follow_up_comm_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ALTER COLUMN `customer_callback_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ALTER COLUMN `customer_callback_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ALTER COLUMN `customer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`comm_session` ALTER COLUMN `customer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` SET TAGS ('dbx_subdomain' = 'message_management');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ALTER COLUMN `message_thread_id` SET TAGS ('dbx_business_glossary_term' = 'Message Thread Identifier');
ALTER TABLE `life_insurance_ecm`.`correspondence`.`message_thread` ALTER COLUMN `parent_message_thread_id` SET TAGS ('dbx_self_ref_fk' = 'true');
