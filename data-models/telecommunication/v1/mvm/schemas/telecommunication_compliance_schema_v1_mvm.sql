-- Schema for Domain: compliance | Business: Telecommunication | Version: v1_mvm
-- Generated on: 2026-05-08 08:31:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`compliance` COMMENT 'SSOT for regulatory and legal compliance obligations — FCC/NTIA/Ofcom/BEREC regulatory filings, lawful intercept (CALEA) records, data privacy consents (GDPR/CCPA), spectrum license compliance, MNP regulatory records, CPNI protection, universal service fund contributions, and ISO/IEC 27001 audit trails.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Foreign key reference to the original regulatory filing if this record represents an amendment or resubmission.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the underlying regulatory obligation or requirement that mandates this filing.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory authority formally acknowledged receipt of the filing.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this filing is an amendment or correction to a previously submitted filing.',
    `comment_period_end_date` DATE COMMENT 'The deadline for public comments or stakeholder feedback on this filing, if applicable.',
    `compliance_risk_level` STRING COMMENT 'Assessment of the regulatory or compliance risk associated with this filing (e.g., potential for penalties, reputational impact).. Valid values are `critical|high|medium|low`',
    `confidential_treatment_requested` BOOLEAN COMMENT 'Indicates whether the filer requested confidential or proprietary treatment for any portion of the submission under applicable rules.',
    `confirmation_number` STRING COMMENT 'Confirmation or receipt number issued by the regulatory authority upon successful submission of the filing.. Valid values are `^[A-Z0-9]{10,20}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was first created in the system. Audit trail for record creation.',
    `document_count` STRING COMMENT 'Total number of supporting documents or attachments included with this regulatory filing.',
    `due_date` DATE COMMENT 'The regulatory deadline by which this filing must be submitted to remain compliant.',
    `external_counsel_firm_name` STRING COMMENT 'Name of the external law firm or consulting firm that assisted with the filing, if applicable.',
    `external_counsel_involved` BOOLEAN COMMENT 'Indicates whether external legal counsel or consultants were engaged in the preparation or review of this filing.',
    `filing_description` STRING COMMENT 'Detailed narrative description of the filing content, scope, and purpose. Provides context for the submission.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the regulatory authority for processing this filing, in the reporting currency.',
    `filing_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the filing fee amount.. Valid values are `^[A-Z]{3}$`',
    `filing_format` STRING COMMENT 'The format or medium in which the filing was submitted to the regulatory authority.. Valid values are `electronic|paper|xml|pdf|csv|api`',
    `filing_period_end_date` DATE COMMENT 'The ending date of the reporting period covered by this regulatory filing.',
    `filing_period_start_date` DATE COMMENT 'The beginning date of the reporting period covered by this regulatory filing.',
    `filing_priority` STRING COMMENT 'Internal priority classification for this filing based on business impact, regulatory risk, or strategic importance.. Valid values are `critical|high|medium|low`',
    `filing_reference_number` STRING COMMENT 'Externally-known unique reference number assigned by the regulatory authority or internal system for tracking this submission. Business identifier for the filing.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing. Tracks the submission through its workflow from draft to final disposition.. Valid values are `draft|submitted|accepted|rejected|under_review|withdrawn`',
    `filing_type` STRING COMMENT 'Classification of the regulatory submission type. Defines the nature and purpose of the filing.. Valid values are `annual_report|spectrum_usage|universal_service|broadband_data_collection|interconnect_disclosure|tariff_filing`',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this record. Audit trail for accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was last updated. Audit trail for record modification.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context related to the filing process or outcome.',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction identifier for the payment of the filing fee.',
    `preparer_department` STRING COMMENT 'Business unit or department responsible for preparing the filing (e.g., Regulatory Affairs, Legal, Finance).',
    `preparer_name` STRING COMMENT 'Name of the individual or team who prepared the filing content and supporting documentation.',
    `public_notice_date` DATE COMMENT 'Date on which the regulatory authority issued a public notice or published the filing for public comment.',
    `regulatory_authority` STRING COMMENT 'The governing body or regulatory agency to which this filing is submitted. Identifies the jurisdiction and oversight entity. [ENUM-REF-CANDIDATE: FCC|NTIA|Ofcom|BEREC|ITU|GSMA|3GPP|ETSI|state_puc|other — 10 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulatory authority if the filing was rejected or returned for correction.',
    `review_completion_date` DATE COMMENT 'Date on which the regulatory authority completed its review and issued a final determination on the filing.',
    `review_date` DATE COMMENT 'Date on which the internal review and approval of the filing was completed prior to submission.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved the filing for submission.',
    `submission_date` DATE COMMENT 'The date on which the filing was officially submitted to the regulatory authority. Principal business event timestamp for the filing.',
    `total_pages` STRING COMMENT 'Total page count across all documents submitted as part of this filing.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Master record of all regulatory submissions made to governing bodies such as FCC, NTIA, Ofcom, BEREC, and ITU. Captures filing type (annual report, spectrum usage, universal service, broadband data collection), submission date, regulatory authority, filing period, status (draft, submitted, accepted, rejected, under review), filing reference number, responsible officer, and associated regulatory obligation. SSOT for all outbound regulatory compliance submissions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record. Primary key for the regulatory obligation master catalog.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to enterprise.segment. Business justification: Regulatory obligations apply differentially by customer segment (e.g., government vs. commercial enterprise, SMB vs. large enterprise). regulatory_obligation.applicable_customer_segments is a denormal',
    `annual_compliance_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated annual cost in USD to maintain compliance with this obligation, including personnel, systems, external audit fees, and filing costs. Used for compliance budgeting and cost-benefit analysis.',
    `applicable_service_types` STRING COMMENT 'Comma-separated list of telecommunications service types to which this obligation applies. Examples: mobile_voice,mobile_data, fixed_broadband,fiber, iptv,ott_video, wholesale_interconnect. Null if obligation applies to all services.',
    `audit_trail_required_flag` BOOLEAN COMMENT 'Indicates whether this obligation requires maintenance of detailed audit trails and evidence of compliance activities. True for obligations subject to regulatory audit or certification (e.g., ISO/IEC 27001, CALEA, GDPR data processing records).',
    `automation_feasibility` STRING COMMENT 'Assessment of the extent to which compliance monitoring, evidence collection, and reporting for this obligation can be automated through systems integration and workflow automation. Drives compliance technology roadmap.. Valid values are `fully_automated|partially_automated|manual_only|automation_in_progress`',
    `compliance_frequency` STRING COMMENT 'Required frequency for compliance reporting, monitoring, or certification activities. Determines the cadence of compliance calendar entries and audit schedules. [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|semi_annual|annual|biennial|event_driven|one_time — 10 candidates stripped; promote to reference product]',
    `compliance_status` STRING COMMENT 'Current state of compliance with this regulatory obligation. Updated based on audit results, self-assessments, and regulatory filings. Drives executive dashboards and risk reporting.. Valid values are `compliant|non_compliant|partially_compliant|under_review|remediation_in_progress|exemption_granted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_retention_period_days` STRING COMMENT 'Number of days that compliance evidence, records, and audit trails must be retained to satisfy this obligation. Null if no specific retention period is mandated. Examples: 2555 days (7 years for CALEA), 1825 days (5 years for financial records).',
    `effective_date` DATE COMMENT 'Date when this regulatory obligation becomes legally binding and enforceable. Compliance activities must be in place by this date.',
    `enforcement_authority` STRING COMMENT 'Name of the regulatory body or government agency responsible for enforcing this obligation. Examples: Federal Communications Commission (FCC), European Data Protection Board (EDPB), Office of Communications (Ofcom), California Public Utilities Commission (CPUC).',
    `exemption_expiry_date` DATE COMMENT 'Date when a granted exemption or waiver expires and full compliance becomes mandatory. Null if no exemption is in effect or exemption is permanent.',
    `exemption_status` STRING COMMENT 'Indicates whether the organization has been granted any exemption, waiver, or special dispensation from this obligation by the enforcement authority. Includes rationale and expiry date of exemption if applicable.. Valid values are `not_applicable|full_exemption|partial_exemption|temporary_waiver|no_exemption`',
    `expiry_date` DATE COMMENT 'Date when this regulatory obligation ceases to be in effect. Null for obligations with no defined end date or perpetual requirements.',
    `internal_policy_reference` STRING COMMENT 'Reference identifier to the internal corporate policy, procedure, or compliance manual that implements this regulatory obligation. Links regulatory requirements to operational controls.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this obligation is currently active and enforceable. False for obligations that have expired, been superseded, or are no longer applicable to the organizations operations.',
    `jurisdiction_code` STRING COMMENT 'ISO country code or jurisdiction identifier where this obligation applies. Examples: USA, GBR, EU, USA-CA (California), USA-FCC (Federal). Supports multi-level jurisdictions (federal, state, regional).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,4})?$`',
    `last_compliance_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment, audit, or certification activity for this obligation. Used to track assessment currency and schedule next reviews.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory obligation record was last updated. Tracks changes to compliance status, assessment dates, or obligation attributes.',
    `last_regulatory_update_date` DATE COMMENT 'Date when the regulatory text, requirements, or interpretation of this obligation was last amended by the enforcement authority. Triggers compliance impact assessments and process updates.',
    `legal_citation` STRING COMMENT 'Full legal citation or reference to the statute, regulation, or rule that establishes this obligation. Examples: 47 USC § 1002, GDPR Article 17, FCC Rule 47 CFR § 64.2009, Communications Act 2003 Section 45.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty amount for a single violation of this obligation, in the currency specified. Used for risk quantification and compliance prioritization.',
    `modified_by_user` STRING COMMENT 'User identifier or email of the person who last modified this regulatory obligation record. Supports audit trail and change management requirements.',
    `next_compliance_due_date` DATE COMMENT 'Next scheduled date by which compliance evidence, filing, or certification must be submitted to the enforcement authority. Drives compliance calendar and alert generation.',
    `obligation_code` STRING COMMENT 'Unique business identifier code for the regulatory obligation, used for external reference and reporting. Examples: CALEA-LI-001, GDPR-ART17, USF-CONTRIB-Q1.. Valid values are `^[A-Z0-9]{4,20}$`',
    `obligation_description` STRING COMMENT 'Comprehensive description of the regulatory obligation, including specific requirements, scope, applicability conditions, and any special provisions or exemptions.',
    `obligation_name` STRING COMMENT 'Full descriptive name of the regulatory obligation. Example: CALEA Lawful Intercept Capability Maintenance, GDPR Right to Erasure Compliance, Universal Service Fund Quarterly Contribution.',
    `obligation_type` STRING COMMENT 'Classification of the regulatory obligation by its primary regulatory domain. Determines the compliance framework, reporting requirements, and enforcement mechanisms applicable to this obligation. [ENUM-REF-CANDIDATE: spectrum_license|calea_mandate|gdpr_requirement|ccpa_requirement|usf_contribution|cpni_protection|mnp_rule|net_neutrality|e911_requirement|roaming_regulation|universal_service|numbering_plan — 12 candidates stripped; promote to reference product]',
    `obligation_url` STRING COMMENT 'URL link to the official regulatory text, guidance document, or enforcement authority webpage for this obligation. Provides direct access to authoritative source material.. Valid values are `^https?://.*$`',
    `penalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the maximum penalty amount. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `penalty_framework` STRING COMMENT 'Description of the penalty structure for non-compliance, including monetary fines, sanctions, license revocation, or other enforcement actions. Examples: Up to 4% of annual global turnover or €20M (GDPR), Daily fines up to $100,000 per violation (FCC).',
    `record_version` STRING COMMENT 'Version number of this regulatory obligation record. Incremented with each modification to support change tracking and historical analysis.',
    `reporting_template_reference` STRING COMMENT 'Reference identifier or URL to the official reporting template, form, or submission format required by the enforcement authority. Examples: FCC Form 477, BEREC Template NN-2023-01, Ofcom C5 Return.',
    `responsible_business_unit` STRING COMMENT 'Name of the internal business unit, department, or function with primary accountability for ensuring compliance with this obligation. Examples: Legal & Regulatory Affairs, Network Operations, Data Privacy Office, Spectrum Management.',
    `risk_severity_level` STRING COMMENT 'Enterprise risk classification for non-compliance with this obligation. Based on potential financial impact, reputational damage, operational disruption, and regulatory scrutiny. Drives compliance prioritization and resource allocation.. Valid values are `critical|high|medium|low`',
    `source_system_reference` STRING COMMENT 'Identifier or name of the operational system(s) that provide compliance data for this obligation. Examples: Amdocs Billing, Nokia NetAct, Salesforce CRM, ServiceNow ITSM. Used for data lineage and integration mapping.',
    `submission_method` STRING COMMENT 'Method by which compliance evidence or filings must be submitted to the enforcement authority. Determines integration requirements and submission workflows.. Valid values are `electronic_portal|email|postal_mail|api|ftp|manual_upload`',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master reference catalog of all regulatory obligations applicable to the telecommunications operator across all jurisdictions. Captures obligation type (spectrum license condition, CALEA mandate, GDPR/CCPA requirement, USF contribution, CPNI protection, MNP rule, net neutrality, E911, roaming, universal service, numbering plan), jurisdiction, effective date, expiry date, enforcement authority, penalty framework, compliance frequency, obligation-specific compliance attributes, and current compliance status. Includes obligation-level tracking for net neutrality traffic management practices, roaming tariff cap compliance, E911 location accuracy requirements, and USF contribution calculations. Serves as the master obligation register driving all compliance activities, calendar deadlines, and regulatory filings across all regulatory frameworks and jurisdictions.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` (
    `lawful_intercept_order_id` BIGINT COMMENT 'Unique identifier for the lawful intercept order. Primary key for this entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Lawful intercept orders are subject to compliance audits to ensure proper handling, chain of custody, and adherence to legal requirements. This FK links intercept orders to the audits that reviewed th',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to interconnect.interconnect_carrier. Business justification: Intercept orders may target traffic from specific carriers (roaming subscribers from foreign carrier). Required for intercept provisioning on carrier-specific traffic, surveillance scope definition, a',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Lawful intercept orders may target enterprise customers (government investigations, corporate fraud cases). Tracking the corporate account enables proper scoping, legal review, and chain-of-custody fo',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lawful intercept orders fulfill regulatory obligations under CALEA (US), RIPA/IPA (UK), or EU Data Retention directives. This FK links intercept orders to the specific regulatory obligation they fulfi',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Lawful intercept orders target specific subscribers by msisdn/imsi for LEA compliance. Real-world process: court order received → subscriber identified → intercept provisioned on subscribers network ',
    `access_control_level` STRING COMMENT 'The access control classification for this lawful intercept order. NEED_TO_KNOW: only authorized personnel directly involved may access; RESTRICTED_ACCESS: limited to compliance and legal teams; EXECUTIVE_ONLY: requires executive approval for access.. Valid values are `NEED_TO_KNOW|RESTRICTED_ACCESS|EXECUTIVE_ONLY`',
    `activation_timestamp` TIMESTAMP COMMENT 'The date and time when the lawful intercept was activated and data collection began. This may differ from order received timestamp due to technical provisioning lead time.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier or pointer to the comprehensive audit trail system where all access logs, provisioning events, delivery confirmations, and chain-of-custody records for this order are stored. Supports ISO/IEC 27001 audit requirements.',
    `chain_of_custody_log` STRING COMMENT 'A structured log or reference to a detailed audit trail documenting every access, handling, and transfer event for this lawful intercept order and its associated data. Ensures legal admissibility and compliance with evidence handling standards.',
    `court_order_reference` STRING COMMENT 'The official reference number or docket number of the court order, warrant, or legal authorization document that mandates this lawful intercept. This is the externally-known business identifier for the order.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lawful intercept order record was first created in the telecommunications providers system. Part of the audit trail for record lifecycle management.',
    `delivery_destination` STRING COMMENT 'The destination address, endpoint, or location where intercepted data is delivered. May be an FTP server URL, physical address, IP address of LEA handover interface, or API endpoint.',
    `delivery_method` STRING COMMENT 'The primary method by which intercepted data is delivered to the LEA. Options include secure FTP, physical media (encrypted USB, DVD), ETSI LI handover interfaces (HI2 for signaling, HI3 for content), network handoff, or secure API.. Valid values are `SECURE_FTP|PHYSICAL_MEDIA|ETSI_LI_HI2|ETSI_LI_HI3|NETWORK_HANDOFF|SECURE_API`',
    `encryption_method` STRING COMMENT 'The encryption algorithm and protocol used to secure intercepted data during transmission and storage. Examples: AES-256, TLS 1.3, PGP, or LEA-specified encryption standards.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time when the lawful intercept order expires and data collection must cease. Nullable for orders without a defined expiration (subject to renewal or explicit termination).',
    `intercept_service_scope` STRING COMMENT 'Defines which services are subject to intercept: voice calls, SMS, MMS, data sessions, VoLTE, VoIP, email, or all services. May be a comma-separated list or specific service identifiers.',
    `intercept_status` STRING COMMENT 'Current lifecycle status of the lawful intercept order. PENDING: received but not yet activated; ACTIVE: currently collecting data; SUSPENDED: temporarily paused; EXPIRED: reached expiry date; TERMINATED: explicitly ended; CLOSED: all deliveries completed and order archived.. Valid values are `PENDING|ACTIVE|SUSPENDED|EXPIRED|TERMINATED|CLOSED`',
    `intercept_technology` STRING COMMENT 'The telecommunications technology or network type on which the intercept is provisioned. Examples: 2G/GSM, 3G/UMTS, 4G/LTE, 5G NR, VoIP/IMS, FTTH, Cable, Satellite. Determines the technical implementation approach.',
    `intercept_type` STRING COMMENT 'Specifies the scope of the lawful intercept: content only (voice, video, messaging payload), metadata only (CDR, signaling, session data), or both content and metadata. Determines what data must be captured and delivered.. Valid values are `CONTENT_ONLY|METADATA_ONLY|CONTENT_AND_METADATA`',
    `issuing_authority` STRING COMMENT 'The name of the court, judge, magistrate, or law enforcement agency that issued the lawful intercept order. Examples include Federal District Court, State Superior Court, FBI, DEA, or equivalent international bodies.',
    `issuing_jurisdiction` STRING COMMENT 'The legal jurisdiction (country, state, province, or district) under which the lawful intercept order was issued. Examples: USA-Federal, USA-CA, GBR, DEU-Bavaria.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this lawful intercept order record was last updated or modified. Tracks changes to order status, delivery records, or administrative updates.',
    `last_renewal_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent renewal or extension of this lawful intercept order. Nullable if the order has never been renewed.',
    `lea_agency_name` STRING COMMENT 'The name of the law enforcement agency (LEA) or government authority that is the recipient of the intercepted data. Examples: FBI, DEA, Metropolitan Police, Europol.',
    `lea_case_reference` STRING COMMENT 'The LEAs internal case number or investigation reference associated with this lawful intercept order. Used for cross-referencing with law enforcement records.',
    `lea_contact_officer` STRING COMMENT 'The name of the LEA officer or agent who is the primary contact for this lawful intercept order. This individual receives delivery confirmations and coordinates with the telecommunications provider.',
    `legal_review_status` STRING COMMENT 'The status of internal legal review for this lawful intercept order. Telecommunications providers typically conduct legal compliance review before activating an intercept to ensure the order is valid and complete.. Valid values are `PENDING_REVIEW|APPROVED|REJECTED|REQUIRES_CLARIFICATION`',
    `legal_review_timestamp` TIMESTAMP COMMENT 'The date and time when the internal legal review of this lawful intercept order was completed and the order was approved for activation.',
    `legal_reviewer_name` STRING COMMENT 'The name of the legal counsel or compliance officer who reviewed and approved this lawful intercept order for activation. Part of the internal approval chain of custody.',
    `notes` STRING COMMENT 'Free-text field for internal notes, special instructions, or operational comments related to this lawful intercept order. May include provisioning challenges, LEA coordination notes, or technical constraints.',
    `order_priority` STRING COMMENT 'The priority level assigned to this lawful intercept order by the issuing authority or LEA. Determines provisioning speed and resource allocation. EMERGENCY orders require immediate activation.. Valid values are `ROUTINE|URGENT|CRITICAL|EMERGENCY`',
    `order_received_timestamp` TIMESTAMP COMMENT 'The date and time when the lawful intercept order was officially received by the telecommunications provider. This is the principal business event timestamp marking the start of the order lifecycle.',
    `provisioning_system_reference` STRING COMMENT 'Reference identifier or ticket number in the telecommunications providers lawful intercept provisioning system (e.g., mediation device, lawful intercept gateway, OSS module) where the technical intercept configuration is managed.',
    `record_version` STRING COMMENT 'Version number for this lawful intercept order record. Incremented with each modification to support change tracking and audit trail integrity.',
    `renewal_count` STRING COMMENT 'The number of times this lawful intercept order has been renewed or extended by the issuing authority. Tracks the orders history and duration of active surveillance.',
    `target_identifier_type` STRING COMMENT 'The type or format of the target identifier. Indicates whether the target is identified by phone number (MSISDN), subscriber identity (IMSI), device identity (IMEI), IP address, email, account number, or SIP URI. [ENUM-REF-CANDIDATE: MSISDN|IMSI|IMEI|IP_ADDRESS|EMAIL|ACCOUNT_NUMBER|SIP_URI — 7 candidates stripped; promote to reference product]',
    `target_location_hint` STRING COMMENT 'Optional geographic or network location information provided in the court order to assist in identifying and provisioning the intercept. May include city, region, cell tower ID, or network segment. Not always present.',
    `termination_timestamp` TIMESTAMP COMMENT 'The actual date and time when the lawful intercept was terminated, either due to expiry, court order withdrawal, or completion of investigation. Marks the end of the intercept lifecycle.',
    `total_data_volume_bytes` BIGINT COMMENT 'The cumulative volume of intercepted data (content and/or metadata) collected under this order, measured in bytes. Used for capacity planning, billing (if applicable), and compliance reporting.',
    `total_delivery_count` STRING COMMENT 'The total number of data delivery events (transmissions, handoffs, or media shipments) that have occurred for this lawful intercept order. Each delivery is typically logged as a separate line item in a related delivery record table.',
    CONSTRAINT pk_lawful_intercept_order PRIMARY KEY(`lawful_intercept_order_id`)
) COMMENT 'Authoritative record of lawful intercept orders received under CALEA (US), RIPA/IPA (UK), EU Data Retention Directive, and equivalent international mandates, including full delivery lifecycle. Captures court order reference, issuing authority, target identifier (MSISDN, IMSI, IP address, email), intercept type (content, metadata, both), activation/expiry dates, intercept status, handling officer, and chain-of-custody log. Includes all delivery records as line items: delivery timestamp, delivery method (secure FTP, physical media, network handoff via ETSI LI interfaces), data volume, delivery confirmation reference, receiving LEA officer, and delivery status. Strictly access-controlled as restricted data with need-to-know enforcement. SSOT for the complete lawful intercept lifecycle from order receipt through data delivery, confirmation, and closure.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` (
    `privacy_consent_id` BIGINT COMMENT 'Unique identifier for the privacy consent record. Primary key for the privacy consent entity.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise B2B customers require corporate-level privacy consent and CPNI compliance tracking. privacy_consent currently links only to subscriber and customer_account. For enterprise accounts, the cor',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this consent record. Links to the customer account master record.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Privacy consents are granted by specific individuals (data subjects). Linking privacy_consent to customer_contact enables the DPO to verify consent was obtained from an authorized contact with the cor',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise Data Processing Agreements (DPAs) under GDPR are formalized as enterprise contracts. Privacy consent records for enterprise customers must reference the governing DPA/enterprise contract to',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Privacy consents are collected to fulfill regulatory obligations under GDPR (EU), CCPA (California), or other privacy regulations. This FK links consents to the specific regulatory obligation that req',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber who granted or withdrew consent. Links to the subscriber master record.',
    `audit_rights_granted` BOOLEAN COMMENT 'Indicates whether the organization has the right to audit the counterpartys data processing activities under this agreement. True if audit rights are granted, false otherwise.',
    `calea_compliance_flag` BOOLEAN COMMENT 'Indicates whether this consent or processing activity is subject to CALEA lawful intercept requirements. True if CALEA compliance obligations apply, false otherwise. Specific to US telecommunications regulatory compliance.',
    `consent_category` STRING COMMENT 'Category of data processing activity covered by this consent. Values: marketing (promotional communications), analytics (usage analytics), personalization (service personalization), third_party_sharing (data sharing with partners), location_tracking (location data processing), cpni (Customer Proprietary Network Information under FCC rules), lawful_intercept (CALEA compliance), research (research and development). [ENUM-REF-CANDIDATE: marketing|analytics|personalization|third_party_sharing|location_tracking|cpni|lawful_intercept|research — 8 candidates stripped; promote to reference product]',
    `consent_channel` STRING COMMENT 'Channel through which the consent was captured or agreement was executed. Values: web_portal (self-service web portal), mobile_app (mobile application), call_center (customer service call), retail_store (in-store interaction), email (email communication), sms (SMS message), paper_form (physical form), api (programmatic API). [ENUM-REF-CANDIDATE: web_portal|mobile_app|call_center|retail_store|email|sms|paper_form|api — 8 candidates stripped; promote to reference product]',
    `consent_proof_document_uri` STRING COMMENT 'URI or file path to the stored consent proof document, signed agreement, or privacy policy version presented to the data subject. Used for audit and regulatory compliance evidence.',
    `consent_reference_number` STRING COMMENT 'Externally visible unique reference number for the consent record, used for customer inquiries and audit trails.. Valid values are `^PC-[0-9]{10}$`',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent record. Values: granted (consent actively granted and valid), withdrawn (consent withdrawn by data subject), expired (consent validity period ended), pending (consent request awaiting response), revoked (consent revoked by organization), suspended (consent temporarily suspended).. Valid values are `granted|withdrawn|expired|pending|revoked|suspended`',
    `consent_type` STRING COMMENT 'Type of privacy governance instrument. Values: individual_data_consent (customer consent for data processing), dpa (Data Processing Agreement with third party), sub_processor_agreement (agreement with sub-processor), data_sharing_agreement (data sharing with partner), pia (Privacy Impact Assessment), dpia (Data Protection Impact Assessment per GDPR Article 35).. Valid values are `individual_data_consent|dpa|sub_processor_agreement|data_sharing_agreement|pia|dpia`',
    `consent_version` STRING COMMENT 'Version identifier of the consent form, privacy policy, or agreement document presented to the data subject or counterparty at the time of consent or signature. Format: vX.Y (e.g., v1.0, v2.3).. Valid values are `^v[0-9]+.[0-9]+$`',
    `counterparty_name` STRING COMMENT 'Name of the third-party organization involved in a Data Processing Agreement, sub-processor agreement, or data sharing agreement. Null for individual data consents. Used for vendor and partner privacy governance.',
    `counterparty_type` STRING COMMENT 'Type of third-party counterparty in the agreement. Values: data_processor (processes data on behalf of controller), sub_processor (sub-contracted processor), joint_controller (joint data controller), data_recipient (receives data for own purposes), mvno (Mobile Virtual Network Operator partner), roaming_partner (roaming agreement partner), content_provider (OTT or IPTV content provider). [ENUM-REF-CANDIDATE: data_processor|sub_processor|joint_controller|data_recipient|mvno|roaming_partner|content_provider — 7 candidates stripped; promote to reference product]',
    `cpni_protection_flag` BOOLEAN COMMENT 'Indicates whether this consent record involves Customer Proprietary Network Information protected under FCC CPNI rules (47 CFR 64.2007). True if CPNI protection applies, false otherwise. Specific to US telecommunications regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this privacy consent record was first created in the system. Audit trail field for record lifecycle tracking.',
    `cross_border_transfer_mechanism` STRING COMMENT 'Legal mechanism used for cross-border transfer of personal data under GDPR Chapter V. Values: adequacy_decision (EU adequacy decision per Article 45), standard_contractual_clauses (SCCs per Article 46), binding_corporate_rules (BCRs per Article 47), certification (approved certification mechanism), derogation (specific derogation per Article 49), none (no cross-border transfer).. Valid values are `adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|derogation|none`',
    `data_categories` STRING COMMENT 'Comma-separated list of personal data categories covered by this consent or agreement (e.g., contact_information, usage_data, location_data, payment_information, call_detail_records, network_performance_data). Aligns with GDPR Article 4 and CCPA definitions.',
    `data_retention_period_days` STRING COMMENT 'Maximum number of days that personal data may be retained under this consent or agreement. Null if no specific retention limit applies. Must comply with GDPR Article 5 storage limitation principle.',
    `data_subjects_affected_count` STRING COMMENT 'Estimated number of data subjects (individuals) whose personal data is affected by the processing activity assessed in the Privacy Impact Assessment or DPIA. Used for proportionality assessment.',
    `dpo_approval_status` STRING COMMENT 'Status of DPO review and approval. Values: approved (DPO approved the record), rejected (DPO rejected the record), pending_review (awaiting DPO review), conditional_approval (approved with conditions or mitigation requirements).. Valid values are `approved|rejected|pending_review|conditional_approval`',
    `dpo_review_date` DATE COMMENT 'Date on which the Data Protection Officer reviewed and approved this consent record, agreement, or privacy impact assessment.',
    `effective_end_date` DATE COMMENT 'Date on which the consent or agreement expires or terminates. Null for open-ended consents or agreements without a fixed expiry.',
    `effective_start_date` DATE COMMENT 'Date from which the consent or agreement becomes legally effective and data processing may commence.',
    `grant_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was granted or the agreement was executed. Represents the principal business event timestamp for this record.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the legal jurisdiction under which this consent or agreement is governed (e.g., USA, GBR, DEU). Determines applicable privacy regulations.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this privacy consent record was last modified. Audit trail field for change tracking and compliance verification.',
    `mitigation_measures` STRING COMMENT 'Description of technical and organizational measures implemented to mitigate identified privacy risks, including data minimization, pseudonymization, encryption, access controls, and privacy-by-design measures per GDPR Article 25 and Article 32.',
    `necessity_assessment` STRING COMMENT 'Assessment of whether the data processing is necessary for the stated purpose and whether less intrusive alternatives exist. Required for GDPR Article 35 DPIA necessity and proportionality evaluation.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this consent record, agreement, or privacy impact assessment. Used for audit trails and internal documentation.',
    `processing_activity_description` STRING COMMENT 'Detailed description of the data processing activity assessed in a Privacy Impact Assessment or Data Protection Impact Assessment. Includes systems involved, data flows, and processing operations.',
    `processing_purpose` STRING COMMENT 'Detailed description of the specific purpose for which personal data is processed under this consent or agreement. Must align with legal basis and be specific, explicit, and legitimate per GDPR Article 5.',
    `proportionality_assessment` STRING COMMENT 'Assessment of whether the data processing is proportionate to the stated purpose and whether the privacy impact is justified by the benefits. Required for GDPR Article 35 DPIA.',
    `risk_categories` STRING COMMENT 'Comma-separated list of privacy risk categories identified in the Privacy Impact Assessment or DPIA (e.g., unauthorized_access, data_breach, profiling, automated_decision_making, cross_border_transfer, surveillance_risk). Used for risk management and mitigation planning.',
    `security_obligations` STRING COMMENT 'Description of technical and organizational security measures required under this agreement or consent, including encryption, access controls, audit logging, and incident response obligations per GDPR Article 32.',
    `supervisory_authority_consultation_date` DATE COMMENT 'Date on which the supervisory authority was consulted regarding this DPIA or consent matter. Null if no consultation occurred.',
    `supervisory_authority_consultation_required` BOOLEAN COMMENT 'Indicates whether consultation with the supervisory authority (e.g., ICO, CNIL, BfDI) is required for this DPIA per GDPR Article 36. True if high residual risk remains after mitigation, false otherwise.',
    `supervisory_authority_name` STRING COMMENT 'Name of the supervisory authority consulted or notified regarding this consent, agreement, or DPIA (e.g., ICO - UK, CNIL - France, BfDI - Germany, FCC - USA). Null if no consultation occurred.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Date and time when the consent was withdrawn by the data subject or the agreement was terminated. Null if consent has not been withdrawn.',
    CONSTRAINT pk_privacy_consent PRIMARY KEY(`privacy_consent_id`)
) COMMENT 'Master record of all privacy governance instruments across the telecommunications operator. Covers: (1) Individual data consents — consent type, channel, version, grant/withdrawal timestamps, legal basis, jurisdiction; (2) Third-party data processing agreements (DPAs), sub-processor agreements, and data sharing agreements — agreement type, counterparty, data categories, processing purposes, retention limits, security obligations, audit rights, effective/expiry dates, DPO sign-off; (3) Privacy Impact Assessments (PIA/DPIA) — processing activity, risk categories, data subjects affected, necessity/proportionality assessment, mitigation measures, DPO review status, supervisory authority consultation requirement. SSOT for all privacy governance across customer touchpoints, vendor relationships, and high-risk processing activities under GDPR, CCPA, and applicable privacy regulations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`privacy_request` (
    `privacy_request_id` BIGINT COMMENT 'Unique identifier for the data subject rights request. Primary key for the privacy request entity.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise customers submit DSARs and erasure requests on behalf of their organizations. privacy_request currently links only to subscriber. For B2B data subject rights management, the corporate_accou',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: GDPR/CCPA privacy requests are submitted at the account level for business customers with multiple subscribers. The compliance team must process account-level data deletion/access requests covering al',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Privacy requests are submitted by a specific authorized contact (data subject or representative). Linking to customer_contact enables identity verification reuse and authorization_level validation — a',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Data breach incidents trigger privacy requests from affected individuals exercising their right to know if their data was compromised. One breach can trigger many privacy requests. FK will be NULL for',
    `privacy_consent_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_consent. Business justification: A data subject rights request (DSR) under GDPR/CCPA is directly tied to the underlying consent instrument — a withdrawal request references the specific consent being withdrawn, an access request may ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Privacy requests (access, deletion, portability) are processed under regulatory obligations defined by GDPR, CCPA, or other privacy laws. This FK links requests to the specific regulatory obligation t',
    `subscriber_id` BIGINT COMMENT 'Identifier of the subscriber who submitted the privacy request. Links to the customer domain subscriber entity.',
    `assignment_timestamp` TIMESTAMP COMMENT 'Date and time when the request was assigned to a handler for processing. Used for queue time analytics.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the request was withdrawn by the data subject or cancelled by the organization. Null if not cancelled.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the request was cancelled. Null if not cancelled.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the request was fully completed and closed. Used for SLA compliance reporting and cycle time analytics.',
    `complexity_level` STRING COMMENT 'Assessed complexity of the request based on scope, number of systems involved, and data volume. Used for resource allocation and prioritization.. Valid values are `low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this privacy request record was first created in the system. Used for audit trail and data lineage.',
    `data_records_retrieved_count` STRING COMMENT 'Total number of data records retrieved across all systems for this request. Used for scope tracking and audit purposes.',
    `data_subject_notified` BOOLEAN COMMENT 'Indicates whether the data subject has been notified of the outcome of their request. Required for regulatory compliance.',
    `data_systems_accessed_count` STRING COMMENT 'Number of internal systems queried to fulfill the request. Used for complexity assessment and process improvement.',
    `delivery_method` STRING COMMENT 'Method used to deliver the requested data or confirmation of action to the data subject. Must ensure secure transmission of personal data.. Valid values are `secure_download|encrypted_email|postal_mail|in_person_pickup|api_export`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the response or data package was delivered to the data subject. Marks fulfillment of the regulatory obligation.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the request has been escalated to senior management or legal counsel due to complexity, risk, or dispute.',
    `escalation_reason` STRING COMMENT 'Reason for escalation. Examples: legal dispute, high-profile data subject, technical complexity, regulatory inquiry. Null if not escalated.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the request was escalated. Null if not escalated.',
    `extended_sla_deadline` TIMESTAMP COMMENT 'New deadline if an extension has been granted. Null if no extension was granted.',
    `fee_charged_amount` DECIMAL(18,2) COMMENT 'Fee charged to the data subject for processing the request, if applicable. GDPR permits fees for manifestly unfounded or excessive requests. CCPA generally prohibits fees. Zero or null if no fee charged.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee charged. Null if no fee charged.. Valid values are `^[A-Z]{3}$`',
    `fee_justification` STRING COMMENT 'Business and legal justification for charging a fee. Required if fee is charged to demonstrate compliance with manifestly unfounded or excessive criteria.',
    `fulfillment_status` STRING COMMENT 'Detailed status of the fulfillment activities for the request. Tracks progress through data collection, review, packaging, and delivery stages. [ENUM-REF-CANDIDATE: not_started|data_collection_in_progress|data_review_in_progress|data_package_prepared|data_delivered|action_completed|partially_fulfilled — 7 candidates stripped; promote to reference product]',
    `identity_verification_method` STRING COMMENT 'Method used to verify the identity of the data subject making the request. Ensures compliance with reasonable verification requirements.. Valid values are `account_credentials|two_factor_authentication|knowledge_based_authentication|document_verification|manual_review`',
    `identity_verification_status` STRING COMMENT 'Status of the identity verification process to confirm the requestor is the legitimate data subject. Critical for preventing fraudulent requests.. Valid values are `not_started|pending|verified|failed|manual_review_required`',
    `identity_verification_timestamp` TIMESTAMP COMMENT 'Date and time when the identity of the data subject was successfully verified. Null if verification is pending or failed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this privacy request record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes documenting processing activities, decisions, communications, and any special circumstances. Used for audit trail and knowledge transfer.',
    `notification_method` STRING COMMENT 'Method used to notify the data subject of the request outcome. Must align with the data subjects preferred communication channel.. Valid values are `email|postal_mail|phone|sms|in_app_notification`',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the data subject was notified of the request outcome. Used for compliance audit trail.',
    `priority_level` STRING COMMENT 'Business priority assigned to the request. Urgent priority for requests approaching SLA deadline or involving high-risk data subjects.. Valid values are `low|normal|high|urgent`',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Date and time when active processing of the request began after identity verification. Used for processing time analytics.',
    `regulatory_authority_name` STRING COMMENT 'Name of the data protection authority that was notified. Examples: ICO (UK), CNIL (France), California Attorney General. Null if no notification made.',
    `regulatory_authority_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory authority was notified. Null if no notification made.',
    `regulatory_authority_notified` BOOLEAN COMMENT 'Indicates whether the relevant data protection authority was notified about this request. Required for certain high-risk or disputed requests.',
    `regulatory_sla_deadline` TIMESTAMP COMMENT 'Regulatory deadline by which the request must be fulfilled. GDPR: 1 month (extendable to 3 months). CCPA: 45 days (extendable to 90 days). Calculated from submission timestamp.',
    `rejection_legal_basis` STRING COMMENT 'Specific legal article or section cited as the basis for rejection. Required for regulatory compliance and audit defense.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the request was rejected. Must cite specific legal grounds per GDPR Article 12(5) or CCPA exceptions. Null if request was not rejected.',
    `request_reference_number` STRING COMMENT 'Externally-visible unique reference number assigned to the privacy request for tracking and customer communication purposes. Format: DSR-XXXXXXXXXX.. Valid values are `^DSR-[0-9]{10}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the privacy request. Tracks progression from receipt through identity verification, processing, and closure. [ENUM-REF-CANDIDATE: received|identity_verification_pending|identity_verified|in_progress|under_review|completed|rejected|cancelled|expired — 9 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Type of data subject rights request. GDPR types: access (Article 15), erasure (Article 17), portability (Article 20), rectification (Article 16), restriction (Article 18). CCPA types: opt_out, do_not_sell, consent_withdrawal. [ENUM-REF-CANDIDATE: access|erasure|portability|rectification|restriction|opt_out|do_not_sell|consent_withdrawal — 8 candidates stripped; promote to reference product]',
    `sla_extension_granted` BOOLEAN COMMENT 'Indicates whether a regulatory-permitted extension to the response deadline has been granted due to request complexity or volume.',
    `sla_extension_reason` STRING COMMENT 'Business justification for granting an SLA extension. Required to be communicated to the data subject per regulatory requirements.',
    `submission_channel` STRING COMMENT 'Channel through which the data subject submitted the privacy request. Used for channel analytics and response routing. [ENUM-REF-CANDIDATE: web_portal|mobile_app|email|phone|postal_mail|in_store|chat — 7 candidates stripped; promote to reference product]',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the privacy request was received by the organization. Marks the start of the regulatory SLA clock.',
    CONSTRAINT pk_privacy_request PRIMARY KEY(`privacy_request_id`)
) COMMENT 'Transactional record of data subject rights requests received from customers under GDPR (right to access, erasure, portability, rectification, restriction) and CCPA (right to know, delete, opt-out). Captures request type, submission channel, submission timestamp, identity verification status, assigned handler, processing deadline (regulatory SLA), fulfillment status, and closure timestamp. Tracks end-to-end DSR (Data Subject Request) lifecycle.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` (
    `spectrum_license_id` BIGINT COMMENT 'Unique identifier for the spectrum license record. Primary key for the spectrum license entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Spectrum licenses require periodic compliance reviews and utilization audits mandated by the granting authority. These compliance review engagements are tracked as audit records. Linking spectrum_lice',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Spectrum licenses are held by legal entities. Enterprise/wholesale operators need to track which corporate entity holds each license for regulatory compliance, asset management, and transfer-of-contro',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: A spectrum license is obtained, renewed, or modified through a regulatory filing submitted to the granting authority (FCC, Ofcom, etc.). The spectrum license is the outcome/grant resulting from the fi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Spectrum licenses are granted under regulatory obligations that define usage conditions, utilization requirements, and interference protection rules. This FK links licenses to the regulatory obligatio',
    `acquisition_cost_amount` DECIMAL(18,2) COMMENT 'The total cost paid by the operator to acquire this spectrum license, including auction bids, transfer fees, and transaction costs. Expressed in the currency specified by the acquisition cost currency code.',
    `acquisition_cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition cost.. Valid values are `^[A-Z]{3}$`',
    `acquisition_date` DATE COMMENT 'The date on which the operator acquired ownership or rights to this spectrum license. May differ from issue date if acquired through secondary market.',
    `acquisition_method` STRING COMMENT 'The method by which the operator acquired this spectrum license. Indicates whether it was obtained through auction, direct assignment, purchase, or other means.. Valid values are `auction|administrative_assignment|secondary_market|merger_acquisition|lease`',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'The annual regulatory fee charged by the granting authority for holding this spectrum license. Expressed in the currency specified by the fee currency code.',
    `bandwidth_mhz` DECIMAL(18,2) COMMENT 'The total bandwidth allocated to this license in megahertz. Calculated as the difference between upper and lower frequency bounds.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the license against regulatory conditions and utilization requirements. Indicates whether the licensee is meeting all obligations.. Valid values are `compliant|non_compliant|under_review|remediation_in_progress`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this spectrum license record was first created in the system. Represents the initial data capture event.',
    `effective_date` DATE COMMENT 'The date on which the license becomes operationally valid and the licensee may begin using the spectrum. May differ from issue date due to administrative or technical conditions.',
    `enforcement_action_description` STRING COMMENT 'Textual description of any enforcement actions taken by the regulatory authority, including the nature of the violation and remediation requirements. Null if no enforcement action exists.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether any regulatory enforcement action (warning, fine, suspension) has been taken against this license. True if enforcement action exists, False otherwise.',
    `expiration_date` DATE COMMENT 'The date on which the spectrum license expires and spectrum rights revert to the regulatory authority unless renewed.',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual license fee (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `frequency_band` STRING COMMENT 'The radio frequency band allocated to this license, expressed in standard band notation (e.g., 600 MHz, 3.5 GHz, 28 GHz). Identifies the spectrum range for transmission.',
    `granting_authority` STRING COMMENT 'The regulatory body or national authority that issued this spectrum license (e.g., FCC, Ofcom, NTIA, BEREC member regulator).',
    `granting_authority_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction where the granting authority operates.. Valid values are `^[A-Z]{3}$`',
    `interference_protection_flag` BOOLEAN COMMENT 'Indicates whether this license includes regulatory protection from interference by other spectrum users. True if protected, False if shared or unlicensed spectrum.',
    `issue_date` DATE COMMENT 'The date on which the spectrum license was officially granted by the regulatory authority. Marks the beginning of the license term.',
    `last_compliance_review_date` DATE COMMENT 'The date of the most recent regulatory compliance review or audit for this license. Used to track periodic compliance verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this spectrum license record was last updated in the system. Tracks the most recent change to any attribute.',
    `license_category` STRING COMMENT 'Classification of the spectrum license by service type. Determines the permitted use case and operational constraints.. Valid values are `mobile_broadband|fixed_wireless|satellite|experimental|cbrs_shared|private_network`',
    `license_number` STRING COMMENT 'The official license number or call sign assigned by the regulatory authority. This is the externally-known unique identifier for the spectrum license.',
    `license_status` STRING COMMENT 'Current lifecycle status of the spectrum license. Indicates whether the license is operational, under review, or terminated.. Valid values are `active|pending|suspended|expired|cancelled|renewal_in_progress`',
    `license_term_years` STRING COMMENT 'The duration of the license grant in years. Defines the period for which the spectrum rights are valid before renewal is required.',
    `lower_frequency_mhz` DECIMAL(18,2) COMMENT 'The lower bound of the licensed frequency range in megahertz. Defines the start of the spectrum allocation.',
    `minimum_utilization_percentage` DECIMAL(18,2) COMMENT 'The minimum spectrum utilization percentage required by the regulatory authority to maintain the license in good standing. Failure to meet this threshold may result in penalties or revocation.',
    `next_compliance_review_date` DATE COMMENT 'The scheduled date for the next regulatory compliance review or audit. Null if no review is scheduled.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or internal notes related to this spectrum license.',
    `renewal_application_date` DATE COMMENT 'The date on which the licensee submitted the renewal application to the regulatory authority. Null if no renewal has been requested.',
    `renewal_status` STRING COMMENT 'Current status of the license renewal process. Tracks whether renewal is required, applied for, or completed.. Valid values are `not_due|pending_application|under_review|approved|denied`',
    `responsible_department` STRING COMMENT 'The internal department or business unit responsible for managing this spectrum license (e.g., Network Engineering, Regulatory Affairs, Spectrum Management).',
    `shared_spectrum_flag` BOOLEAN COMMENT 'Indicates whether this license operates in a shared spectrum environment (e.g., CBRS, LSA) where multiple operators may use the same frequencies under coordination rules. True if shared, False if exclusive.',
    `technology_standard` STRING COMMENT 'The radio access technology or standard authorized for use under this license (e.g., LTE, 5G NR, Wi-Fi 6, satellite). May be technology-neutral or technology-specific depending on regulatory framework.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether this license may be transferred or sold to another operator subject to regulatory approval. True if transferable, False if non-transferable.',
    `upper_frequency_mhz` DECIMAL(18,2) COMMENT 'The upper bound of the licensed frequency range in megahertz. Defines the end of the spectrum allocation.',
    `usage_conditions` STRING COMMENT 'Textual description of the regulatory conditions, restrictions, and obligations attached to this license. May include build-out requirements, interference limits, and service quality mandates.',
    CONSTRAINT pk_spectrum_license PRIMARY KEY(`spectrum_license_id`)
) COMMENT 'Master record of spectrum licenses held by the telecommunications operator including periodic utilization reporting and regulatory compliance tracking. Captures frequency band, bandwidth (MHz), geographic coverage area, license category (mobile broadband, fixed wireless, satellite, experimental, CBRS/shared), license term, annual fees, renewal status, usage conditions, and granting authority (FCC, Ofcom, NTIA, national regulators). Includes all usage reports as line items: reporting period, measured utilization percentage, interference incidents, compliance status against license conditions, submission date, and regulatory authority acknowledgment. SSOT for spectrum asset compliance, license management, utilization tracking, and regulatory efficiency reporting.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` (
    `mnp_compliance_id` BIGINT COMMENT 'Primary key for mnp_compliance',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Mobile number portability for enterprise accounts (porting blocks of numbers for corporate mobile fleets) requires account-level tracking for billing, SLA compliance, and regulatory reporting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: MNP compliance records include account_number_verified_flag and billing_address_verified_flag, confirming account-level verification is required during porting authorization. Linking to customer_accou',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise customers port large number blocks under governing enterprise contracts that define porting SLAs, authorization procedures, and penalty terms. Linking mnp_compliance to enterprise_contract ',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: MNP (Mobile Number Portability) compliance records may be associated with specific regulatory filings submitted to the porting authority or national regulator — for example, periodic MNP compliance re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: MNP compliance records fulfill regulatory obligations that define porting SLAs, rejection criteria, and notification requirements. This FK links MNP records to the specific regulatory obligation that ',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the subscriber associated with the ported number. Links to the customer master record.',
    `account_number_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers account number with the donor operator was verified to prevent fraudulent porting.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for this porting transaction, supporting regulatory audit requirements.',
    `authorization_method` STRING COMMENT 'Method by which customer authorization was obtained (electronic signature, verbal recording, written Letter of Authorization, online consent, in-store verification).. Valid values are `electronic_signature|verbal_recording|written_loa|online_consent|in_store`',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when customer authorization was obtained and verified.',
    `billing_address_verified_flag` BOOLEAN COMMENT 'Indicates whether the customers billing address was verified as part of the porting authorization process.',
    `compliance_notes` STRING COMMENT 'Free-text notes from compliance officers regarding special circumstances, exceptions, or regulatory considerations for this porting transaction.',
    `compliance_review_status` STRING COMMENT 'Status of internal compliance review for this porting transaction, particularly for SLA breaches or rejections.. Valid values are `pending|approved|rejected|escalated`',
    `compliance_review_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance review was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance record was first created in the system.',
    `customer_authorization_verified_flag` BOOLEAN COMMENT 'Indicates whether customer authorization for the port was verified according to regulatory requirements (to prevent unauthorized porting/slamming).',
    `data_retention_expiry_date` DATE COMMENT 'Date when this compliance record is eligible for deletion according to regulatory data retention policies (typically 2-7 years depending on jurisdiction).',
    `donor_operator_code` STRING COMMENT 'Unique code identifying the telecommunications operator from which the number is being ported (the losing carrier).. Valid values are `^[A-Z0-9]{3,10}$`',
    `donor_operator_name` STRING COMMENT 'Full legal name of the donor telecommunications operator.',
    `fraud_check_status` STRING COMMENT 'Status of fraud detection checks performed on this porting request to prevent unauthorized number hijacking.. Valid values are `not_performed|passed|failed|manual_review`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical fraud risk score assigned to this porting transaction by fraud detection systems. Higher scores indicate higher risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance record was last updated.',
    `msisdn` STRING COMMENT 'The mobile phone number being ported. This is the subscribers telephone number in international format.. Valid values are `^[0-9]{10,15}$`',
    `number_count` STRING COMMENT 'Total count of numbers included in this porting transaction. Typically 1 for simple ports, multiple for complex or corporate ports.',
    `number_range_end` STRING COMMENT 'Ending number in a range port (for complex or corporate porting involving multiple consecutive numbers). Null for simple single-number ports.. Valid values are `^[0-9]{10,15}$`',
    `number_range_start` STRING COMMENT 'Starting number in a range port (for complex or corporate porting involving multiple consecutive numbers). Null for simple single-number ports.. Valid values are `^[0-9]{10,15}$`',
    `porting_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the number porting was successfully completed and the number became active on the recipient operators network.',
    `porting_direction` STRING COMMENT 'Indicates whether this is a port-in (number coming to this operator) or port-out (number leaving this operator) transaction.. Valid values are `port_in|port_out`',
    `porting_reference_number` STRING COMMENT 'Unique regulatory reference number assigned to the porting transaction by the central porting authority or clearinghouse. Used for inter-operator coordination and regulatory tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `porting_request_timestamp` TIMESTAMP COMMENT 'Date and time when the porting request was officially submitted to the central porting authority or clearinghouse.',
    `porting_status` STRING COMMENT 'Current status of the porting transaction in the regulatory compliance lifecycle.. Valid values are `pending|in_progress|completed|rejected|cancelled|failed`',
    `porting_type` STRING COMMENT 'Classification of the porting transaction complexity. Simple (single number), complex (multiple numbers), or corporate (enterprise account porting).. Valid values are `simple|complex|corporate`',
    `recipient_operator_code` STRING COMMENT 'Unique code identifying the telecommunications operator to which the number is being ported (the gaining carrier).. Valid values are `^[A-Z0-9]{3,10}$`',
    `recipient_operator_name` STRING COMMENT 'Full legal name of the recipient telecommunications operator.',
    `regulatory_authority_notification_status` STRING COMMENT 'Status of notification to the regulatory authority regarding this porting transaction. Some jurisdictions require operators to report porting metrics to regulators.. Valid values are `not_required|pending|submitted|acknowledged|failed`',
    `regulatory_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory authority was notified of this porting transaction or compliance event.',
    `regulatory_sla_deadline_timestamp` TIMESTAMP COMMENT 'The regulatory deadline by which the porting must be completed to comply with FCC, BEREC, or local regulatory authority SLA requirements (typically 1 business day in the US, varies by jurisdiction).',
    `rejection_flag` BOOLEAN COMMENT 'Indicates whether the porting request was rejected by the donor operator or central porting authority.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for porting rejection (e.g., account mismatch, outstanding balance, invalid authorization).. Valid values are `^[A-Z0-9]{2,10}$`',
    `rejection_reason_description` STRING COMMENT 'Detailed description of why the porting request was rejected, providing context beyond the standardized code.',
    `sla_breach_duration_hours` DECIMAL(18,2) COMMENT 'Number of hours by which the porting transaction exceeded the regulatory SLA deadline. Null if no breach occurred.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the porting transaction breached the regulatory SLA deadline. True if the completion timestamp exceeded the regulatory deadline.',
    CONSTRAINT pk_mnp_compliance PRIMARY KEY(`mnp_compliance_id`)
) COMMENT 'Master record tracking Mobile Number Portability (MNP) regulatory compliance for each port-in and port-out transaction. Captures porting request reference, donor/recipient operator, MSISDN, porting completion timestamp, regulatory SLA deadline, SLA breach indicator, rejection reason (if applicable), and regulatory authority notification status. Supports FCC MNP compliance reporting and BEREC number portability obligations.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit engagement record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise customers in regulated industries (finance, healthcare, government) require compliance audits of telecom services (SOC 2, HIPAA, FedRAMP). Account-level tracking enables audit coordination ',
    `depot_id` BIGINT COMMENT 'Foreign key linking to workforce.depot. Business justification: Telecom depots undergo formal compliance audits (safety, hazmat storage, security, tool inventory). Scoping an audit record to a specific depot enables depot-level compliance tracking and inspection s',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Enterprise contracts include audit_rights_clause provisions. Compliance teams run contract-scoped audits (government framework, wholesale agreement, ISO certification audits). Linking audit to enterpr',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the regulatory obligation that mandated or triggered this audit engagement.',
    `actual_end_date` DATE COMMENT 'Actual date when the audit fieldwork or on-site activities concluded.',
    `actual_start_date` DATE COMMENT 'Actual date when the audit fieldwork or on-site activities commenced.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including business units, processes, systems, geographic locations, and standards clauses covered by the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit engagement. Tracks progression from scheduling through completion. [ENUM-REF-CANDIDATE: SCHEDULED|IN_PROGRESS|FIELDWORK_COMPLETE|UNDER_REVIEW|COMPLETED|CANCELLED|DEFERRED — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit engagement type. Indicates the regulatory framework, standard, or internal policy being audited. [ENUM-REF-CANDIDATE: ISO_27001_SURVEILLANCE|ISO_27001_RECERTIFICATION|FCC_INSPECTION|GDPR_SUPERVISORY_AUTHORITY_AUDIT|SOC_2_EXAMINATION|PCI_DSS_ASSESSMENT|INTERNAL_REVIEW|3GPP_COMPLIANCE_AUDIT|GSMA_SAS_AUDIT|ETSI_STANDARDS_AUDIT|CALEA_LAWFUL_INTERCEPT_AUDIT|CPNI_PROTECTION_AUDIT|UNIVERSAL_SERVICE_FUND_AUDIT|SPECTRUM_LICENSE_COMPLIANCE_AUDIT|MNP_REGULATORY_AUDIT|OFCOM_COMPLIANCE_REVIEW|BEREC_REGULATORY_AUDIT — promote to reference product]',
    `auditing_body` STRING COMMENT 'Name of the organization or regulatory authority conducting the audit (e.g., external certification body, FCC, GDPR supervisory authority, internal audit department).',
    `auditing_body_accreditation_number` STRING COMMENT 'Official accreditation or registration number of the auditing body, if applicable (e.g., ANAB accreditation number for ISO auditors).',
    `certification_expiry_date` DATE COMMENT 'Date when the issued certification expires and requires renewal or recertification.',
    `certification_issue_date` DATE COMMENT 'Date when the certification was officially issued by the certifying body.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certification was issued as a result of this audit. True if certification was granted, False otherwise.',
    `certification_reference_number` STRING COMMENT 'Unique certificate number or reference identifier assigned by the certifying body to the issued certification.',
    `certification_renewal_status` STRING COMMENT 'Current status of the certification renewal process. Tracks whether the certification is active, approaching renewal, or has expired.. Valid values are `NOT_DUE|RENEWAL_SCHEDULED|RENEWAL_IN_PROGRESS|RENEWED|EXPIRED|WITHDRAWN`',
    `certification_scope` STRING COMMENT 'Detailed description of the scope covered by the issued certification, including business units, processes, systems, and geographic locations.',
    `certification_type` STRING COMMENT 'Type of certification issued as a result of the audit, if applicable. Identifies the specific standard or framework for which certification was granted. [ENUM-REF-CANDIDATE: ISO_IEC_27001|SOC_2_TYPE_II|PCI_DSS|FCC_CPNI_ANNUAL|GSMA_SAS|ISO_9001|ISO_20000|ISO_22301|ISO_27017|ISO_27018|CALEA_COMPLIANCE|ETSI_CERTIFICATION — promote to reference product]',
    `compliance_risk_level` STRING COMMENT 'Assessment of the compliance risk level associated with the audit scope and findings. Indicates potential regulatory, financial, or reputational impact.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW|MINIMAL`',
    `corrective_action_deadline` DATE COMMENT 'Deadline date by which corrective actions for identified nonconformities must be completed and submitted for verification.',
    `corrective_actions_verified_date` DATE COMMENT 'Date when the auditing body verified that all corrective actions have been satisfactorily implemented.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the audit engagement, including auditor fees, travel expenses, and related costs.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance audit record was first created in the system.',
    `external_counsel_firm_name` STRING COMMENT 'Name of the external legal counsel firm engaged to support the audit, if applicable.',
    `external_counsel_involved_flag` BOOLEAN COMMENT 'Indicates whether external legal counsel was engaged to support the audit process. True if external counsel was involved, False otherwise.',
    `internal_audit_coordinator_email` STRING COMMENT 'Primary email address of the internal audit coordinator for audit logistics and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `internal_audit_coordinator_name` STRING COMMENT 'Full name of the internal employee responsible for coordinating the audit activities and serving as the primary liaison with the auditing body.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance audit record was last updated or modified in the system.',
    `major_nonconformities_count` STRING COMMENT 'Number of major nonconformities identified during the audit. Major nonconformities represent significant failures to meet compliance requirements.',
    `minor_nonconformities_count` STRING COMMENT 'Number of minor nonconformities identified during the audit. Minor nonconformities represent less critical deviations from compliance requirements.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the audit engagement and certification lifecycle.',
    `observations_count` STRING COMMENT 'Number of observations or opportunities for improvement noted during the audit that do not constitute nonconformities.',
    `outcome` STRING COMMENT 'Overall result or conclusion of the audit engagement. Indicates whether the organization met the compliance requirements under review.. Valid values are `PASSED|PASSED_WITH_OBSERVATIONS|FAILED|CONDITIONAL_PASS|NOT_APPLICABLE`',
    `period_end_date` DATE COMMENT 'End date of the period under audit review. Defines the conclusion of the timeframe for which compliance is being assessed.',
    `period_start_date` DATE COMMENT 'Start date of the period under audit review. Defines the beginning of the timeframe for which compliance is being assessed.',
    `priority` STRING COMMENT 'Business priority level assigned to the audit engagement based on regulatory importance, risk exposure, and business impact.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the audit engagement by the auditing body or internal audit function.',
    `report_document_reference` STRING COMMENT 'Document management system reference or file path to the formal audit report.',
    `report_issued_date` DATE COMMENT 'Date when the formal audit report was issued to the organization.',
    `responsible_executive_email` STRING COMMENT 'Primary email address of the responsible executive officer for compliance communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_executive_name` STRING COMMENT 'Full name of the executive officer responsible for compliance oversight and signatory authority for the audit and certification.',
    `responsible_executive_title` STRING COMMENT 'Job title of the responsible executive officer (e.g., Chief Compliance Officer, Chief Information Security Officer, Data Protection Officer).',
    `scheduled_end_date` DATE COMMENT 'Planned date for the audit fieldwork or on-site activities to conclude.',
    `scheduled_start_date` DATE COMMENT 'Planned date for the audit fieldwork or on-site activities to commence.',
    `team_size` STRING COMMENT 'Total number of auditors and technical experts assigned to the audit engagement.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Master record of compliance audit engagements and resulting certifications held by the telecommunications operator. For audits: captures audit type (ISO 27001 surveillance/recertification, FCC inspection, GDPR supervisory authority audit, SOC 2 examination, PCI-DSS assessment, internal review), auditing body, scope, period, lead auditor, status, and overall outcome. For certifications: captures certification type (ISO/IEC 27001, SOC 2 Type II, PCI-DSS, FCC CPNI annual, GSMA SAS), issuing body, certification scope, issue date, expiry date, renewal status, certificate reference number, and responsible executive signatory. SSOT for the complete audit-to-certification lifecycle including certification renewal tracking.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` (
    `data_breach_incident_id` BIGINT COMMENT 'Unique identifier for the data breach incident record. Primary key for the data breach incident entity.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Data breach incidents trigger compliance audits to investigate root cause, assess control failures, and verify remediation. This FK links breach incidents to the audits that investigated them. FK will',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Data breaches affecting enterprise customers require entity-specific notification, regulatory reporting (GDPR, state breach laws), and remediation tracking. Critical for enterprise account management ',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Data breaches in telecom frequently originate in or affect specific managed services (managed security, managed SD-WAN, managed cloud connectivity). Linking breach incidents to managed_service enables',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Data breach incidents trigger regulatory obligations for notification (e.g., GDPR 72-hour notification, CCPA breach notification). This FK links breach incidents to the specific regulatory obligation ',
    `affected_data_categories` STRING COMMENT 'Comma-separated list of personal data categories affected by the breach (e.g., name, email, phone, address, payment card, CPNI, location data, account credentials).',
    `affected_systems` STRING COMMENT 'Comma-separated list of systems, applications, or infrastructure components affected by the breach (e.g., CRM, billing system, customer portal, database server).',
    `breach_severity_level` STRING COMMENT 'Assessed severity level of the data breach incident based on data sensitivity, volume, and potential harm (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the data breach incident (detected, under investigation, contained, notification in progress, closed, escalated).. Valid values are `detected|under_investigation|contained|notification_in_progress|closed|escalated`',
    `breach_type` STRING COMMENT 'Classification of the data breach incident by attack vector or cause (unauthorized access, accidental disclosure, ransomware, insider threat, third-party breach, lost device).. Valid values are `unauthorized_access|accidental_disclosure|ransomware|insider_threat|third_party_breach|lost_device`',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the data breach incident was formally closed after all remediation, notification, and regulatory obligations were completed.',
    `confirmed_affected_individuals_count` BIGINT COMMENT 'Confirmed number of individuals whose personal data was compromised, based on completed forensic investigation.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when the data breach incident was successfully contained and the vulnerability or exposure was closed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this data breach incident record was first created in the system.',
    `credit_monitoring_offered` BOOLEAN COMMENT 'Indicates whether credit monitoring or identity protection services were offered to affected individuals as part of breach remediation.',
    `data_exfiltration_confirmed` BOOLEAN COMMENT 'Indicates whether forensic investigation confirmed that personal data was actually exfiltrated or accessed by unauthorized parties (true) or only exposed without confirmed access (false).',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the data breach incident was first detected by internal monitoring systems, staff, or external notification.',
    `encryption_in_place` BOOLEAN COMMENT 'Indicates whether the affected personal data was encrypted at the time of the breach, which may reduce notification obligations under certain regulations.',
    `estimated_affected_individuals_count` BIGINT COMMENT 'Estimated number of individuals whose personal data was compromised in the breach incident.',
    `estimated_financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the breach including investigation costs, notification costs, remediation costs, regulatory fines, and potential litigation costs.',
    `external_forensics_firm_engaged` BOOLEAN COMMENT 'Indicates whether an external cybersecurity or forensics firm was engaged to investigate the breach.',
    `external_forensics_firm_name` STRING COMMENT 'Name of the external cybersecurity or forensics firm engaged to investigate the breach.',
    `financial_impact_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `incident_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the data breach incident for tracking and regulatory reporting purposes.',
    `individual_notification_completion_date` DATE COMMENT 'Date when direct notification to all affected individuals was completed.',
    `individual_notification_method` STRING COMMENT 'Primary method used to notify affected individuals (email, postal mail, SMS, phone, website notice, substitute notice).. Valid values are `email|postal_mail|sms|phone|website_notice|substitute_notice`',
    `individual_notification_required` BOOLEAN COMMENT 'Indicates whether the breach meets the threshold for mandatory direct notification to affected individuals under applicable data protection regulations.',
    `individual_notification_start_date` DATE COMMENT 'Date when direct notification to affected individuals began (via email, postal mail, or other channels).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this data breach incident record was last modified or updated.',
    `law_enforcement_notification_required` BOOLEAN COMMENT 'Indicates whether the breach requires notification to law enforcement agencies based on criminal activity or regulatory requirements.',
    `legal_counsel_engaged` BOOLEAN COMMENT 'Indicates whether external legal counsel was engaged to advise on breach notification obligations and regulatory compliance.',
    `legal_counsel_firm_name` STRING COMMENT 'Name of the external legal counsel firm engaged to advise on the breach response.',
    `litigation_initiated` BOOLEAN COMMENT 'Indicates whether civil litigation or class action lawsuits were initiated by affected individuals or consumer advocacy groups as a result of the breach.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the data breach incident, investigation, or response activities.',
    `occurrence_timestamp` TIMESTAMP COMMENT 'Estimated date and time when the data breach incident actually occurred or began, based on forensic investigation.',
    `public_disclosure_date` DATE COMMENT 'Date when the breach was publicly disclosed through media notification, press release, or regulatory public notice.',
    `public_disclosure_required` BOOLEAN COMMENT 'Indicates whether the breach requires public disclosure or media notification due to the number of affected individuals or regulatory requirements.',
    `regulatory_fine_amount` DECIMAL(18,2) COMMENT 'Total amount of regulatory fines or penalties imposed by supervisory authorities as a result of the breach.',
    `regulatory_fine_imposed` BOOLEAN COMMENT 'Indicates whether a regulatory fine or penalty was imposed by a supervisory authority as a result of the breach.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether the breach meets the threshold for mandatory notification to supervisory authorities under applicable data protection regulations.',
    `remediation_completion_date` DATE COMMENT 'Date when all remediation actions were completed and verified.',
    `remediation_plan_description` STRING COMMENT 'Detailed description of the remediation plan implemented to address the breach, prevent recurrence, and mitigate harm to affected individuals.',
    `root_cause_category` STRING COMMENT 'Primary root cause category identified through incident investigation (human error, system vulnerability, malicious attack, third-party failure, physical security breach, process failure).. Valid values are `human_error|system_vulnerability|malicious_attack|third_party_failure|physical_security|process_failure`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause identified through forensic investigation and incident analysis.',
    `supervisory_authority_acknowledgment_reference` STRING COMMENT 'Reference number or acknowledgment identifier provided by the supervisory authority upon receipt of the breach notification.',
    `supervisory_authority_name` STRING COMMENT 'Name of the supervisory authority or regulatory body to which the breach was notified (e.g., ICO, CNIL, FCC, state attorney general).',
    `supervisory_authority_notification_deadline` TIMESTAMP COMMENT 'Regulatory deadline by which the breach must be notified to the supervisory authority (e.g., GDPR 72-hour deadline from detection, FCC 30-day deadline).',
    `supervisory_authority_notification_on_time` BOOLEAN COMMENT 'Indicates whether the supervisory authority notification was submitted within the regulatory deadline (true) or was late (false).',
    `supervisory_authority_notification_timestamp` TIMESTAMP COMMENT 'Actual date and time when the breach notification was submitted to the supervisory authority.',
    CONSTRAINT pk_data_breach_incident PRIMARY KEY(`data_breach_incident_id`)
) COMMENT 'Master record of personal data breach incidents covering the complete lifecycle from detection through regulatory notification, individual notification, and closure. Captures breach type (unauthorized access, accidental disclosure, ransomware, insider threat, third-party breach), affected data categories, estimated affected individual count, detection and containment timestamps, root cause, and remediation plan. Includes all notification records as line items: notification type (supervisory authority, affected individuals, law enforcement), recipient authority or channel, notification timestamp, content summary, regulatory deadline (GDPR 72-hour, CCPA without unreasonable delay, FCC 30-day), on-time indicator, and acknowledgment reference. SSOT for complete data breach lifecycle management including mandatory notification compliance tracking.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_privacy_consent_id` FOREIGN KEY (`privacy_consent_id`) REFERENCES `telecommunication_ecm`.`compliance`.`privacy_consent`(`privacy_consent_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `telecommunication_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `comment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Comment Period End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confidential_treatment_requested` SET TAGS ('dbx_business_glossary_term' = 'Confidential Treatment Requested Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confidential_treatment_requested` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confidential_treatment_requested` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `external_counsel_involved` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Involved Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_format` SET TAGS ('dbx_business_glossary_term' = 'Filing Format');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_format` SET TAGS ('dbx_value_regex' = 'electronic|paper|xml|pdf|csv|api');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_priority` SET TAGS ('dbx_business_glossary_term' = 'Filing Priority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|under_review|withdrawn');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'annual_report|spectrum_usage|universal_service|broadband_data_collection|interconnect_disclosure|tariff_filing');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_department` SET TAGS ('dbx_business_glossary_term' = 'Preparer Department');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `preparer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `total_pages` SET TAGS ('dbx_business_glossary_term' = 'Total Pages');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Segment Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `annual_compliance_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Compliance Cost Estimate');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `annual_compliance_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `audit_trail_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `automation_feasibility` SET TAGS ('dbx_business_glossary_term' = 'Compliance Automation Feasibility');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `automation_feasibility` SET TAGS ('dbx_value_regex' = 'fully_automated|partially_automated|manual_only|automation_in_progress');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Frequency');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Current Compliance Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partially_compliant|under_review|remediation_in_progress|exemption_granted');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period in Days');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Effective Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `enforcement_authority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Authority Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Expiry Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Exemption Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `exemption_status` SET TAGS ('dbx_value_regex' = 'not_applicable|full_exemption|partial_exemption|temporary_waiver|no_exemption');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Expiry Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Obligation Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,4})?$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_compliance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_regulatory_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Update Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `legal_citation` SET TAGS ('dbx_business_glossary_term' = 'Legal Citation Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Detailed Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type Classification');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_url` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_framework` SET TAGS ('dbx_business_glossary_term' = 'Penalty and Enforcement Framework');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Reporting Template Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Submission Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_portal|email|postal_mail|api|ftp|manual_upload');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` SET TAGS ('dbx_subdomain' = 'legal_enforcement');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'NEED_TO_KNOW|RESTRICTED_ACCESS|EXECUTIVE_ONLY');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `access_control_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `chain_of_custody_log` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Log');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `chain_of_custody_log` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `court_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Court Order Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `court_order_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `court_order_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `delivery_destination` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `delivery_destination` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'SECURE_FTP|PHYSICAL_MEDIA|ETSI_LI_HI2|ETSI_LI_HI3|NETWORK_HANDOFF|SECURE_API');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `delivery_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `encryption_method` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_service_scope` SET TAGS ('dbx_business_glossary_term' = 'Intercept Service Scope');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_service_scope` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_status` SET TAGS ('dbx_business_glossary_term' = 'Intercept Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_status` SET TAGS ('dbx_value_regex' = 'PENDING|ACTIVE|SUSPENDED|EXPIRED|TERMINATED|CLOSED');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_technology` SET TAGS ('dbx_business_glossary_term' = 'Intercept Technology');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_type` SET TAGS ('dbx_business_glossary_term' = 'Intercept Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_type` SET TAGS ('dbx_value_regex' = 'CONTENT_ONLY|METADATA_ONLY|CONTENT_AND_METADATA');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `intercept_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `last_renewal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `last_renewal_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lea_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency (LEA) Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lea_agency_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lea_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency (LEA) Case Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lea_case_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lea_contact_officer` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency (LEA) Contact Officer');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lea_contact_officer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'PENDING_REVIEW|APPROVED|REJECTED|REQUIRES_CLARIFICATION');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_review_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `legal_reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'ROUTINE|URGENT|CRITICAL|EMERGENCY');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `order_priority` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `order_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Received Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `order_received_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `provisioning_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Provisioning System Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `provisioning_system_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `renewal_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `target_identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Target Identifier Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `target_identifier_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `target_location_hint` SET TAGS ('dbx_business_glossary_term' = 'Target Location Hint');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `target_location_hint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `target_location_hint` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Termination Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `termination_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `total_data_volume_bytes` SET TAGS ('dbx_business_glossary_term' = 'Total Data Volume in Bytes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `total_data_volume_bytes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `total_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Total Delivery Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `total_delivery_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `audit_rights_granted` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Granted');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `calea_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Communications Assistance for Law Enforcement Act (CALEA) Compliance Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_category` SET TAGS ('dbx_business_glossary_term' = 'Consent Category');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_proof_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Consent Proof Document Uniform Resource Identifier (URI)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_proof_document_uri` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_value_regex' = '^PC-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|expired|pending|revoked|suspended');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'individual_data_consent|dpa|sub_processor_agreement|data_sharing_agreement|pia|dpia');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `cpni_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Protection Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `cross_border_transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Mechanism');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `cross_border_transfer_mechanism` SET TAGS ('dbx_value_regex' = 'adequacy_decision|standard_contractual_clauses|binding_corporate_rules|certification|derogation|none');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `data_categories` SET TAGS ('dbx_business_glossary_term' = 'Data Categories');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `data_subjects_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects Affected Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `dpo_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Approval Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `dpo_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending_review|conditional_approval');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `dpo_review_date` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Officer (DPO) Review Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grant Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `necessity_assessment` SET TAGS ('dbx_business_glossary_term' = 'Necessity Assessment');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `processing_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Processing Purpose');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `proportionality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Proportionality Assessment');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `risk_categories` SET TAGS ('dbx_business_glossary_term' = 'Risk Categories');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `security_obligations` SET TAGS ('dbx_business_glossary_term' = 'Security Obligations');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `supervisory_authority_consultation_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `supervisory_authority_consultation_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Consultation Required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `supervisory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `assignment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Complexity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `complexity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_records_retrieved_count` SET TAGS ('dbx_business_glossary_term' = 'Data Records Retrieved Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_subject_notified` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Notified Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_systems_accessed_count` SET TAGS ('dbx_business_glossary_term' = 'Data Systems Accessed Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'secure_download|encrypted_email|postal_mail|in_person_pickup|api_export');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `extended_sla_deadline` SET TAGS ('dbx_business_glossary_term' = 'Extended Service Level Agreement (SLA) Deadline');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fee_charged_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Charged Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fee_justification` SET TAGS ('dbx_business_glossary_term' = 'Fee Justification');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'account_credentials|two_factor_authentication|knowledge_based_authentication|document_verification|manual_review');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `identity_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|verified|failed|manual_review_required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `identity_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Processing Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|sms|in_app_notification');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_authority_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_authority_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notified Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `regulatory_sla_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Service Level Agreement (SLA) Deadline');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `rejection_legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Rejection Legal Basis');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request (DSR) Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_value_regex' = '^DSR-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `sla_extension_granted` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Extension Granted Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `sla_extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Extension Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'auction|administrative_assignment|secondary_market|merger_acquisition|lease');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `bandwidth_mhz` SET TAGS ('dbx_business_glossary_term' = 'Bandwidth (MHz)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|remediation_in_progress');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `enforcement_action_description` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `frequency_band` SET TAGS ('dbx_business_glossary_term' = 'Frequency Band');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `granting_authority` SET TAGS ('dbx_business_glossary_term' = 'Granting Authority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `granting_authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Granting Authority Country Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `granting_authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `interference_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Interference Protection Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `license_category` SET TAGS ('dbx_business_glossary_term' = 'License Category');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `license_category` SET TAGS ('dbx_value_regex' = 'mobile_broadband|fixed_wireless|satellite|experimental|cbrs_shared|private_network');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|expired|cancelled|renewal_in_progress');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `license_term_years` SET TAGS ('dbx_business_glossary_term' = 'License Term (Years)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `lower_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Lower Frequency (MHz)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `minimum_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Percentage');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|pending_application|under_review|approved|denied');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `shared_spectrum_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Spectrum Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `technology_standard` SET TAGS ('dbx_business_glossary_term' = 'Technology Standard');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `upper_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Upper Frequency (MHz)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `usage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Usage Conditions');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `account_number_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Number Verified Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `account_number_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `account_number_verified_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `authorization_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|verbal_recording|written_loa|online_consent|in_store');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `billing_address_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Verified Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `billing_address_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `billing_address_verified_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `compliance_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `customer_authorization_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Authorization Verified Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `donor_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Operator Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `donor_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `donor_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Operator Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `donor_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `donor_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_value_regex' = 'not_performed|passed|failed|manual_review');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_count` SET TAGS ('dbx_business_glossary_term' = 'Number Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_end` SET TAGS ('dbx_business_glossary_term' = 'Number Range End');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_end` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_end` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_start` SET TAGS ('dbx_business_glossary_term' = 'Number Range Start');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_start` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `number_range_start` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Porting Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_direction` SET TAGS ('dbx_business_glossary_term' = 'Porting Direction');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_direction` SET TAGS ('dbx_value_regex' = 'port_in|port_out');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Porting Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Porting Request Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_status` SET TAGS ('dbx_business_glossary_term' = 'Porting Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected|cancelled|failed');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_type` SET TAGS ('dbx_business_glossary_term' = 'Porting Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `porting_type` SET TAGS ('dbx_value_regex' = 'simple|complex|corporate');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `recipient_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Recipient Operator Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `recipient_operator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `recipient_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Operator Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `recipient_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `recipient_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `regulatory_authority_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notification Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `regulatory_authority_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged|failed');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `regulatory_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `regulatory_sla_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Service Level Agreement (SLA) Deadline Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `rejection_flag` SET TAGS ('dbx_business_glossary_term' = 'Rejection Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `sla_breach_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Duration Hours');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'legal_enforcement');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body Accreditation Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_renewal_status` SET TAGS ('dbx_value_regex' = 'NOT_DUE|RENEWAL_SCHEDULED|RENEWAL_IN_PROGRESS|RENEWED|EXPIRED|WITHDRAWN');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW|MINIMAL');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_actions_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Verified Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `external_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Involved Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `internal_audit_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Coordinator Email Address');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `internal_audit_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `internal_audit_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `internal_audit_coordinator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `internal_audit_coordinator_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Coordinator Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `major_nonconformities_count` SET TAGS ('dbx_business_glossary_term' = 'Major Nonconformities Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `minor_nonconformities_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Nonconformities Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Audit Outcome');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'PASSED|PASSED_WITH_OBSERVATIONS|FAILED|CONDITIONAL_PASS|NOT_APPLICABLE');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Priority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Email Address');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `responsible_executive_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `responsible_executive_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `responsible_executive_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Executive Title');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Size');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` SET TAGS ('dbx_subdomain' = 'privacy_management');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `affected_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Categories');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `breach_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `breach_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'detected|under_investigation|contained|notification_in_progress|closed|escalated');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'unauthorized_access|accidental_disclosure|ransomware|insider_threat|third_party_breach|lost_device');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `confirmed_affected_individuals_count` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Affected Individuals Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `credit_monitoring_offered` SET TAGS ('dbx_business_glossary_term' = 'Credit Monitoring Offered');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `data_exfiltration_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Data Exfiltration Confirmed');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `encryption_in_place` SET TAGS ('dbx_business_glossary_term' = 'Encryption In Place');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `estimated_affected_individuals_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Affected Individuals Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `external_forensics_firm_engaged` SET TAGS ('dbx_business_glossary_term' = 'External Forensics Firm Engaged');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `external_forensics_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Forensics Firm Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `financial_impact_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `individual_notification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Individual Notification Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `individual_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Individual Notification Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `individual_notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|sms|phone|website_notice|substitute_notice');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `individual_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Individual Notification Required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `individual_notification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Individual Notification Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `law_enforcement_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notification Required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `legal_counsel_engaged` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Engaged');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `legal_counsel_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Firm Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `litigation_initiated` SET TAGS ('dbx_business_glossary_term' = 'Litigation Initiated');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `public_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `regulatory_fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Fine Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `regulatory_fine_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `regulatory_fine_imposed` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Fine Imposed');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `remediation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'human_error|system_vulnerability|malicious_attack|third_party_failure|physical_security|process_failure');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `supervisory_authority_acknowledgment_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Acknowledgment Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `supervisory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `supervisory_authority_notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Notification Deadline');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `supervisory_authority_notification_on_time` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Notification On Time');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `supervisory_authority_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Authority Notification Timestamp');
