-- Schema for Domain: compliance | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:46

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`compliance` COMMENT 'SSOT for regulatory and legal compliance obligations — FCC/NTIA/Ofcom/BEREC regulatory filings, lawful intercept (CALEA) records, data privacy consents (GDPR/CCPA), spectrum license compliance, MNP regulatory records, CPNI protection, universal service fund contributions, and ISO/IEC 27001 audit trails.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `bi_report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.bi_report_definition. Business justification: Regulatory filings are generated from specific BI reports (service quality dashboards, accessibility reports, financial summaries). Direct reporting lineage linking filings to source BI reports in tel',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Regulatory filing activities require budgeted resources (staff time, external counsel, filing fees). Linking filings to budget plans enables variance analysis, forecasting of future filing costs, and ',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Regulatory filings are submitted by specific legal entities (company codes). Each filing must be attributed to the correct legal entity for regulatory reporting, audit trails, and financial statement ',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Regulatory filings (spectrum applications, tariff filings, interconnection agreements) are submitted by legal entities. Enterprise customers require entity-specific filing tracking for compliance repo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Filing preparation costs (staff time, external counsel fees, document preparation, filing fees) must be allocated to responsible cost centers for budget management, variance analysis, and departmental',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Regulatory filings report achievement of mandated KPIs (service quality, coverage, accessibility). Telcos track which KPI definitions are referenced in each filing for compliance evidence and audit tr',
    `original_filing_regulatory_filing_id` BIGINT COMMENT 'Foreign key reference to the original regulatory filing if this record represents an amendment or resubmission.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the underlying regulatory obligation or requirement that mandates this filing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Regulatory filings require named responsible officers for FCC/regulatory authority submissions. Telecommunications operators must track which employee is accountable for each filing for audit trails a',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Many regulatory filings (USO reports, franchise compliance, coverage obligations) are territory-specific. Authorities require territory-level data on service availability, investment, and customer cou',
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
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Regulatory obligations (franchise fees, build-out commitments, USO requirements) are territory-specific. Compliance tracking requires mapping obligations to service territories to monitor territory-le',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Regulatory obligations apply to specific legal entities. Each company code must track which regulations it must comply with for jurisdiction-specific reporting (FCC filings for US entities, CRTC for C',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Every regulatory obligation requires an accountable owner for telecommunications compliance management. Used for deadline tracking, escalation workflows, performance reviews, and regulatory audit resp',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_rule. Business justification: Regulatory obligations mandate specific data quality rules (E911 location accuracy thresholds, service quality completeness, consent record retention). Compliance-driven DQ requirements linking obliga',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Regulatory obligations mandate specific KPI tracking (E911 accuracy, network availability SLAs, service quality metrics). Direct business requirement linking compliance obligations to measured KPIs in',
    `annual_compliance_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated annual cost in USD to maintain compliance with this obligation, including personnel, systems, external audit fees, and filing costs. Used for compliance budgeting and cost-benefit analysis.',
    `applicable_customer_segments` STRING COMMENT 'Comma-separated list of customer segments to which this obligation applies. Examples: consumer,soho, enterprise,government, wholesale. Null if obligation applies to all customer types.',
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
    `related_obligations` STRING COMMENT 'Comma-separated list of obligation codes for related or dependent regulatory obligations. Used to model obligation hierarchies, prerequisite relationships, and compliance dependencies. Example: GDPR-ART17,GDPR-ART32 for obligations that must be satisfied together.',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Lawful intercept operations incur costs (personnel time, system resources, data storage, delivery infrastructure) that must be allocated to specific cost centers for internal cost tracking, budget man',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: CALEA/lawful intercept orders handled by specifically authorized employees with security clearances. Telecommunications operators must maintain strict chain of custody and access logs. Required for le',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Lawful intercept equipment (mediation devices, probes) is physically provisioned at specific network sites. Court orders require documenting physical interception points for chain-of-custody and LEA a',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Lawful intercept orders fulfill regulatory obligations under CALEA (US), RIPA/IPA (UK), or EU Data Retention directives. This FK links intercept orders to the specific regulatory obligation they fulfi',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Lawful intercept orders target specific subscribers by msisdn/imsi for LEA compliance. Real-world process: court order received → subscriber identified → intercept provisioned on subscribers network ',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Mobile intercept orders specify target coverage areas for surveillance (cell-level interception). LEA delivery requires coverage-area-level call detail records and location data. Essential for CALEA c',
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
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this consent record. Links to the customer account master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Data Protection Officer is designated employee role required by GDPR/privacy laws. Telecommunications operators must track DPO involvement in consent reviews for regulatory compliance and audit eviden',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Privacy consents are collected to fulfill regulatory obligations under GDPR (EU), CCPA (California), or other privacy regulations. This FK links consents to the specific regulatory obligation that req',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.segment_definition. Business justification: Consent status determines segment eligibility for marketing analytics and personalization (CPNI restrictions, GDPR consent requirements). Real compliance gate for customer segmentation in telecommunic',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Privacy consent requirements vary by jurisdiction (GDPR, CPRA, PIPEDA). Service territories map to regulatory jurisdictions, enabling territory-level consent management, cross-border transfer controls',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Privacy requests (GDPR subject access, deletion) assigned to specific employees for processing. Telecommunications operators track handler for SLA management, workload balancing, and audit trails of d',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Data breach incidents trigger privacy requests from affected individuals exercising their right to know if their data was compromised. One breach can trigger many privacy requests. FK will be NULL for',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Privacy requests (DSAR, erasure) expose data quality issues when records cannot be located or are inconsistent across systems. GDPR operational reality linking privacy request fulfillment to DQ issue ',
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
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Spectrum licenses are held by specific legal entities (company codes). License fees, renewal costs, and compliance obligations must be tracked per entity for regulatory reporting and financial stateme',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Spectrum licenses are held by legal entities. Enterprise/wholesale operators need to track which corporate entity holds each license for regulatory compliance, asset management, and transfer-of-contro',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Spectrum licenses are issued for transmission from specific physical sites. Regulatory filings to granting authorities require site-level reporting of spectrum usage, antenna locations, and interferen',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Spectrum licenses are granted under regulatory obligations that define usage conditions, utilization requirements, and interference protection rules. This FK links licenses to the regulatory obligatio',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Spectrum licenses require named responsible officer for regulatory authority communications and compliance certifications. Telecommunications operators must track accountable employee for license rene',
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
    `customer_mnp_request_id` BIGINT COMMENT 'Reference to the originating MNP request that triggered this compliance record. Links to the customer-facing porting request.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer responsible for reviewing and approving this MNP compliance record.',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` (
    `cpni_authorization_id` BIGINT COMMENT 'Unique identifier for the CPNI authorization record. Primary key for tracking individual customer CPNI consent events throughout their lifecycle.',
    `annual_certification_id` BIGINT COMMENT 'Reference to the annual CPNI compliance certification filing that includes this authorization record. Links individual authorizations to regulatory filings.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which this CPNI authorization applies. Links the authorization to the specific subscriber account in the billing system.',
    `employee_id` BIGINT COMMENT 'Identifier of the customer service representative or retail agent who assisted with the CPNI authorization. Null for self-service channels.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: CPNI authorizations fulfill regulatory obligations under FCC 47 CFR 64.2000 (US) or equivalent customer proprietary network information protection rules. This FK links CPNI authorizations to the speci',
    `subscriber_id` BIGINT COMMENT 'Reference to the individual subscriber who provided or withdrew CPNI consent. May differ from account holder in multi-user accounts.',
    `affected_customer_count` STRING COMMENT 'Number of customers affected by the CPNI violation. Determines FCC notification requirements (mandatory notification for 5000+ customers within 7 business days). Null if no violation.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier to detailed audit trail logs for this CPNI authorization. Links to immutable event log for compliance verification and regulatory inspection.',
    `authentication_timestamp` TIMESTAMP COMMENT 'Date and time when customer identity was verified prior to authorization. Required for FCC compliance to prevent pretexting. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `authorization_channel` STRING COMMENT 'Channel through which the customer provided or modified CPNI authorization: web_portal, mobile_app, IVR (Interactive Voice Response), retail_store, written_form, email, SMS, customer_service_call. [ENUM-REF-CANDIDATE: web_portal|mobile_app|ivr|retail_store|written_form|email|sms|customer_service_call — 8 candidates stripped; promote to reference product]',
    `authorization_reference_number` STRING COMMENT 'Business-facing unique reference number for the CPNI authorization, used in customer communications and regulatory filings. Format: CPNI-{alphanumeric}.. Valid values are `^CPNI-[A-Z0-9]{8,16}$`',
    `authorization_status` STRING COMMENT 'Current lifecycle status of the CPNI authorization: active (consent in effect), expired (time-bound consent lapsed), revoked (customer withdrew), pending_verification (awaiting identity confirmation), superseded (replaced by newer authorization).. Valid values are `active|expired|revoked|pending_verification|superseded`',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the customer provided or modified the CPNI authorization. Critical for regulatory compliance and audit trail. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `authorization_type` STRING COMMENT 'Type of CPNI authorization action: opt_in (customer grants consent), opt_out (customer denies consent), renewal (periodic reconfirmation), withdrawal (customer revokes prior consent), modification (scope change).. Valid values are `opt_in|opt_out|renewal|withdrawal|modification`',
    `certification_period_year` STRING COMMENT 'Calendar year for which this authorization is included in the annual CPNI certification filing to the FCC. Format: YYYY.',
    `consent_scope` STRING COMMENT 'Scope of CPNI usage authorized by the customer: marketing (promotional offers), service_enhancement (network optimization), third_party_sharing (partner disclosures), all_purposes (unrestricted), limited (specific use case only).. Valid values are `marketing|service_enhancement|third_party_sharing|all_purposes|limited`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this CPNI authorization record was first created in the system. Audit field for data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_authentication_method` STRING COMMENT 'Method used to verify customer identity before accepting CPNI authorization, as required by FCC rules: password, PIN, biometric, security_question, two_factor, account_number, ssn_last_four, none (for written/signed forms). [ENUM-REF-CANDIDATE: password|pin|biometric|security_question|two_factor|account_number|ssn_last_four|none — 8 candidates stripped; promote to reference product]',
    `customer_notification_of_breach_flag` BOOLEAN COMMENT 'Indicates whether affected customers were notified of the CPNI breach. True if notified, False otherwise. Required for material breaches.',
    `customer_notification_of_breach_timestamp` TIMESTAMP COMMENT 'Date and time when affected customers were notified of the CPNI breach. Null if not notified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_retention_period_days` STRING COMMENT 'Number of days this CPNI authorization record must be retained per regulatory requirements. Typically minimum 2 years (730 days) per FCC rules.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device used to submit the authorization (e.g., mobile device ID, browser fingerprint). Used for security and fraud prevention.',
    `effective_date` DATE COMMENT 'Date from which the CPNI authorization becomes active and enforceable. May differ from authorization_timestamp if customer specifies future effective date. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date when the CPNI authorization expires and must be renewed. Nullable for indefinite authorizations. Format: yyyy-MM-dd.',
    `fcc_notification_required_flag` BOOLEAN COMMENT 'Indicates whether FCC notification is required for this violation (True if 5000+ customers affected or other mandatory criteria met). False if no notification required or no violation.',
    `fcc_notification_status` STRING COMMENT 'Status of FCC notification for CPNI violation: not_required (below threshold), pending (notification due), submitted (filed with FCC), acknowledged (FCC confirmed receipt), none (no violation).. Valid values are `not_required|pending|submitted|acknowledged|none`',
    `fcc_notification_timestamp` TIMESTAMP COMMENT 'Date and time when FCC was notified of the CPNI violation. Must be within 7 business days of detection for breaches affecting 5000+ customers. Null if not applicable. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ip_address` STRING COMMENT 'IP address from which the customer submitted the CPNI authorization (for web/mobile channels). Used for fraud detection and audit trail. Supports IPv4 and IPv6.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this CPNI authorization record was last updated. Audit field for change tracking and compliance verification. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `law_enforcement_notification_flag` BOOLEAN COMMENT 'Indicates whether law enforcement (FBI, Secret Service, local authorities) was notified of the CPNI violation. True if notified, False otherwise.',
    `law_enforcement_notification_timestamp` TIMESTAMP COMMENT 'Date and time when law enforcement was notified of the CPNI violation. Null if not notified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special circumstances, or compliance officer comments related to this CPNI authorization or violation.',
    `notification_channel` STRING COMMENT 'Channel used to send confirmation notification to customer: email, SMS, postal_mail, in_app, none (if no notification sent).. Valid values are `email|sms|postal_mail|in_app|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a confirmation notification was sent to the customer after CPNI authorization was recorded. True if sent, False otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when confirmation notification was sent to customer. Null if notification_sent_flag is False. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `remediation_action_description` STRING COMMENT 'Detailed description of remediation actions taken to address the CPNI violation and prevent recurrence. Includes technical, process, and policy changes. Null if no violation.',
    `remediation_completion_timestamp` TIMESTAMP COMMENT 'Date and time when all remediation actions for the CPNI violation were completed and verified. Null if remediation ongoing or no violation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `responsible_officer_name` STRING COMMENT 'Name of the corporate officer responsible for CPNI compliance oversight for this authorization record. Required for annual certification attestation.',
    `responsible_officer_title` STRING COMMENT 'Corporate title of the officer responsible for CPNI compliance (e.g., Chief Compliance Officer, VP Legal, Chief Privacy Officer).',
    `store_location_code` STRING COMMENT 'Code identifying the retail store location where the CPNI authorization was captured. Applicable only for retail_store channel.',
    `violation_closure_status` STRING COMMENT 'Current status of the CPNI violation case: open (active incident), remediated (actions complete, awaiting verification), closed (fully resolved), under_investigation (root cause analysis ongoing), none (no violation).. Valid values are `open|remediated|closed|under_investigation|none`',
    `violation_detection_method` STRING COMMENT 'Method by which the CPNI violation was detected: internal_audit, customer_complaint, system_alert, regulatory_inspection, third_party_report, none (if no violation).. Valid values are `internal_audit|customer_complaint|system_alert|regulatory_inspection|third_party_report|none`',
    `violation_detection_timestamp` TIMESTAMP COMMENT 'Date and time when the CPNI violation was first detected. Null if no violation. Critical for FCC 7-business-day notification requirement. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this authorization record is associated with a CPNI violation or breach incident. True if violation occurred, False otherwise.',
    `violation_type` STRING COMMENT 'Type of CPNI violation if violation_flag is True: unauthorized_disclosure (CPNI shared without consent), improper_access (internal unauthorized access), pretexting (fraudulent identity theft), inadequate_safeguards (security failure), none (no violation).. Valid values are `unauthorized_disclosure|improper_access|pretexting|inadequate_safeguards|none`',
    CONSTRAINT pk_cpni_authorization PRIMARY KEY(`cpni_authorization_id`)
) COMMENT 'Master record of Customer Proprietary Network Information (CPNI) compliance per FCC regulations (47 CFR Part 64.2), covering the complete CPNI lifecycle: authorizations, annual certifications, and violation/enforcement tracking. For authorizations: captures customer account reference, opt-in/opt-out status, authorization scope, channel, and timestamps. For annual certifications: captures certification period, filing date, officer attestation, and FCC acceptance status. For violations: captures violation type (unauthorized disclosure, improper access, pretexting), detection method, affected customer count, detection timestamp, FCC notification status (mandatory within 7 business days for breaches affecting 5000+ customers), law enforcement notification, remediation actions, and closure status. SSOT for the complete CPNI compliance lifecycle.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key for the audit finding entity.',
    `audit_id` BIGINT COMMENT 'Reference to the parent audit engagement or audit event during which this finding was identified. Links to the broader audit context.',
    `control_id` BIGINT COMMENT 'Identifier of the internal control, policy, or procedure that was found to be deficient or non-compliant (e.g., ISO 27001 A.9.2.1 User Registration, FCC CPNI Control 3.2).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remediation activities for audit findings consume resources (staff time, system changes, process improvements) that must be tracked against responsible cost centers for budget management and to measur',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Audit findings can identify data breach incidents during compliance audits (e.g., discovering unauthorized access, unencrypted data, or control failures that constitute a breach). This FK links audit ',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Audit findings frequently identify data quality issues requiring remediation tracking (incomplete records, missing consent, inaccurate location data). Natural operational linkage between compliance au',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Audit findings often relate to specific managed services (encryption not enabled, SLA breach, security misconfiguration). Service-level tracking enables targeted remediation and prevents recurrence ac',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Audit findings trigger remediation pipelines to correct data issues (consent backfill, location data refresh, audit log reconstruction). Operational remediation workflow linking findings to pipeline e',
    `previous_finding_audit_finding_id` BIGINT COMMENT 'Reference to the previous finding record if this is a recurrence. Links to the historical finding for trend analysis.',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the specific regulatory obligation, legal requirement, or compliance framework requirement that this finding relates to (e.g., FCC Part 64 CPNI rules, GDPR Article 32 security requirements).',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Audit findings can escalate to regulatory penalties when non-conformities are reported to regulatory authorities or when audits are conducted by external regulators. This FK links audit findings to th',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Audit findings assigned to specific employees for remediation. Telecommunications operators track ownership for escalation, performance management, and audit closure. Essential for audit management an',
    `actual_completion_date` DATE COMMENT 'The actual date when all remediation actions were completed and evidence was submitted for verification.',
    `affected_process` STRING COMMENT 'The business process or operational area impacted by this finding (e.g., Customer Onboarding, Billing and Revenue Management, Network Operations and Monitoring, CALEA Compliance).',
    `audit_date` DATE COMMENT 'The date on which the audit activity that identified this finding was conducted. Represents the business event timestamp for finding discovery.',
    `audit_scope` STRING COMMENT 'Description of the audit scope and boundaries within which this finding was identified (e.g., Network Operations Center security controls, CALEA compliance for lawful intercept, GDPR data subject rights processes).',
    `audit_type` STRING COMMENT 'Classification of the audit engagement type. Internal audits are conducted by the organization; external audits by third parties; regulatory audits by FCC, NTIA, Ofcom, or BEREC; certification audits for ISO/IEC 27001; surveillance audits for ongoing compliance monitoring.. Valid values are `internal|external|regulatory|certification|surveillance|special`',
    `auditor_name` STRING COMMENT 'Full name of the auditor or audit team member who identified and documented this finding.',
    `auditor_organization` STRING COMMENT 'The organization or entity that the auditor represents (e.g., Internal Audit Department, External Certification Body, FCC Enforcement Bureau, ISO Registrar).',
    `closure_approved_by` STRING COMMENT 'Name of the individual or role who approved the closure of the finding (e.g., Chief Compliance Officer, Audit Committee Chair, ISO Management Representative).',
    `closure_date` DATE COMMENT 'The date on which the finding was formally closed after successful verification of corrective actions.',
    `compliance_impact` STRING COMMENT 'Description of the potential regulatory, legal, or business impact if the finding is not addressed (e.g., FCC fines, GDPR penalties, loss of ISO certification, reputational damage).',
    `control_domain` STRING COMMENT 'The functional domain or category of the affected control (e.g., Access Control, Data Privacy, Network Security, Financial Reporting, Lawful Intercept, Spectrum Management).',
    `corrective_action_plan` STRING COMMENT 'Detailed description of the corrective actions, remediation steps, and preventive measures planned to address the finding and prevent recurrence.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was first created in the system. Audit trail for record creation.',
    `escalation_date` DATE COMMENT 'The date on which the finding was escalated to a higher authority or management level.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding has been escalated to senior management, the board, or regulatory authorities due to severity or lack of progress.',
    `escalation_reason` STRING COMMENT 'Explanation of why the finding was escalated (e.g., overdue remediation, critical risk, regulatory deadline, repeated non-compliance).',
    `evidence_of_completion` STRING COMMENT 'Description or reference to the evidence provided to demonstrate that corrective actions have been implemented (e.g., updated policy documents, system logs, training records, screenshots).',
    `finding_description` STRING COMMENT 'Detailed narrative description of the audit finding, including what was observed, what requirement was not met, and the specific evidence supporting the finding.',
    `finding_reference_number` STRING COMMENT 'Business-readable unique reference number assigned to the finding for tracking and communication purposes (e.g., FCC-2024-001, ISO-NC-2024-042).',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding from identification through remediation to closure. Tracks the progress of corrective actions.. Valid values are `open|in_progress|pending_verification|closed|reopened|deferred`',
    `finding_type` STRING COMMENT 'Classification of the finding based on severity and nature. Non-conformity indicates a failure to meet a requirement; observation is a potential issue; opportunity for improvement suggests enhancement areas. [ENUM-REF-CANDIDATE: non-conformity|observation|opportunity_for_improvement|positive_finding|major_non-conformity|minor_non-conformity|regulatory_violation|control_deficiency — promote to reference product]. Valid values are `non-conformity|observation|opportunity_for_improvement|positive_finding|major_non-conformity|minor_non-conformity`',
    `identified_date` DATE COMMENT 'The specific date when this finding was formally identified and documented by the auditor or compliance team.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit finding record was last updated. Audit trail for record modifications.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or context related to the finding, remediation, or verification process.',
    `preventive_action_plan` STRING COMMENT 'Description of preventive measures and systemic improvements implemented to prevent similar findings in the future.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding is a recurrence of a previously identified and closed finding. Used for trend analysis and effectiveness assessment.',
    `regulatory_report_date` DATE COMMENT 'The date on which the finding was reported to the relevant regulatory authority.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Boolean indicator of whether this finding must be reported to a regulatory authority (FCC, NTIA, Ofcom, BEREC, data protection authority) as part of compliance obligations.',
    `remediation_owner_department` STRING COMMENT 'The department or business unit responsible for remediation (e.g., Network Operations, Legal and Regulatory Affairs, Information Security, Customer Privacy).',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort, tracking progress from planning through implementation to verification.. Valid values are `not_started|in_progress|completed|verified|overdue|deferred`',
    `risk_rating` STRING COMMENT 'Risk-based assessment of the potential impact if the finding is not remediated. Considers likelihood and consequence of non-compliance or control failure.. Valid values are `critical|high|medium|low|negligible`',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the root cause(s) that led to the finding, including contributing factors and systemic issues. Documents the why behind the finding.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying root cause of the finding. Used for trend analysis and systemic issue identification.. Valid values are `process_gap|policy_gap|training_gap|system_deficiency|human_error|resource_constraint`',
    `severity_level` STRING COMMENT 'Risk-based severity classification of the finding indicating the urgency and impact of remediation. Critical findings require immediate action; informational findings are advisory.. Valid values are `critical|high|medium|low|informational`',
    `target_completion_date` DATE COMMENT 'The planned or committed date by which the remediation actions are expected to be completed and the finding closed.',
    `verification_date` DATE COMMENT 'The date on which the corrective actions were verified as complete and effective.',
    `verification_notes` STRING COMMENT 'Additional notes or comments from the verifier regarding the adequacy and effectiveness of the corrective actions.',
    `verification_status` STRING COMMENT 'Status of the verification process to confirm that corrective actions have been effectively implemented and the finding can be closed.. Valid values are `pending|verified|rejected|not_required`',
    `verified_by_name` STRING COMMENT 'Full name of the individual who verified the completion and effectiveness of the corrective actions (typically an auditor or compliance officer).',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Transactional record of findings and associated remediation actions identified during internal or external compliance audits, including ISO/IEC 27001 surveillance audits, FCC compliance reviews, and internal control assessments. Captures finding type (non-conformity, observation, opportunity for improvement), severity, audit reference, affected control or obligation, finding description, root cause category, assigned remediation owner, remediation steps, target and actual completion dates, evidence of completion, verification status, and closure date. SSOT for the complete finding-to-remediation lifecycle.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit engagement record. Primary key.',
    `analytical_subject_area_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_subject_area. Business justification: Compliance audits validate data quality and completeness of analytical subject areas used for regulatory reporting (revenue assurance, customer data, network performance). Real audit scope definition ',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Physical compliance audits (safety, environmental, security) occur at specific network sites. Audit reports reference site locations, and audit findings require site-level remediation tracking for cer',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to finance.budget_plan. Business justification: Audit programs require annual budgets for internal resources and external auditor fees. Linking audits to budget plans enables tracking of actual vs. planned audit costs, supports multi-year audit pla',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Compliance audits are conducted at the legal entity level. Audit costs, findings, and certifications must be attributed to specific company codes for financial reporting, internal cost allocation, and',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise customers in regulated industries (finance, healthcare, government) require compliance audits of telecom services (SOC 2, HIPAA, FedRAMP). Account-level tracking enables audit coordination ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit costs (internal staff time, external auditor fees, remediation expenses) must be allocated to responsible cost centers for departmental budget tracking and accountability. Already tracks audit_c',
    `dq_execution_result_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_execution_result. Business justification: Audits review DQ execution results to verify data governance controls and compliance with regulatory data quality requirements. Real audit evidence trail linking compliance audits to DQ execution in t',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Audit costs must post to specific GL accounts (professional fees for external audits, internal labor for internal audits) for expense recognition and financial statement reporting. Links compliance ac',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Internal audits led by employee auditors. Telecommunications operators track lead auditor for audit planning, resource allocation, quality review, and auditor performance management. Core audit manage',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` (
    `regulatory_penalty_id` BIGINT COMMENT 'Unique identifier for the regulatory penalty record. Primary key for the regulatory penalty entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Penalties are assessed against specific legal entities and must be recorded in the correct companys financial records for accurate financial statements, tax reporting, and regulatory disclosures. Alr',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Regulatory penalties are assessed against legal entities. Enterprise customers may incur penalties (TCPA violations, robocalling, service quality failures). Tracking at account level enables billing, ',
    `cpni_authorization_id` BIGINT COMMENT 'Foreign key linking to compliance.cpni_authorization. Business justification: Regulatory penalties can be issued for CPNI violations (e.g., unauthorized disclosure, failure to obtain proper authorization, improper authentication). This FK links penalties to the specific CPNI au',
    `data_breach_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.data_breach_incident. Business justification: Regulatory penalties are often issued as a result of data breach incidents. One breach can result in multiple penalties from different authorities. This FK links penalties to their triggering breach i',
    `e911_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.e911_compliance. Business justification: Regulatory penalties can be issued for E911 compliance failures (e.g., location accuracy failures, PSAP routing failures, database update failures). This FK links penalties to the specific E911 compli',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Penalty amounts must post to specific GL accounts (typically fines/penalties expense) for financial statement reporting and variance analysis. Replaces denormalized general_ledger_account_code with pr',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Penalty payments and accruals generate journal entries that must be traceable back to the originating compliance event for audit trails, variance analysis, and regulatory examination. Links compliance',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key reference to any associated regulatory filing or report that is related to this penalty, such as a corrective action plan, compliance certification, or remediation report.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the underlying regulatory obligation or compliance requirement that was violated, linking this penalty to the specific rule, statute, or license condition.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Regulatory penalties require accountable officer for telecommunications operators. Used for executive reporting, performance management, remediation tracking, and regulatory authority communications. ',
    `spectrum_license_id` BIGINT COMMENT 'Foreign key linking to compliance.spectrum_license. Business justification: Regulatory penalties can be issued for spectrum license violations (e.g., exceeding authorized power, operating outside licensed frequencies, failure to meet utilization requirements). This FK links p',
    `accounting_period` STRING COMMENT 'Fiscal period (quarter or month) in which the penalty expense was recognized in the financial statements, formatted as YYYY-QN for quarters or YYYY-MM for months.. Valid values are `^d{4}-Q[1-4]$|^d{4}-d{2}$`',
    `adjusted_penalty_amount` DECIMAL(18,2) COMMENT 'Final penalty amount after any reductions, settlements, or adjustments resulting from appeals, negotiations, or compliance remediation. Null if no adjustment has been made.',
    `appeal_decision_date` DATE COMMENT 'Date on which the regulatory authority or court issued a final decision on the appeal. Null if appeal is still pending or no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the telecommunications operator has filed a formal appeal or petition for reconsideration with the regulatory authority or judicial body. True if appeal filed, False otherwise.',
    `appeal_filing_date` DATE COMMENT 'Date on which the operator filed a formal appeal, petition for reconsideration, or judicial review of the penalty. Null if no appeal has been filed.',
    `appeal_outcome` STRING COMMENT 'Final result of the appeal process, indicating whether the original penalty was upheld, modified, or overturned. [ENUM-REF-CANDIDATE: Penalty Upheld|Penalty Reduced|Penalty Waived|Remanded for Further Review|Settled|Withdrawn|Other — 7 candidates stripped; promote to reference product]',
    `appeal_status` STRING COMMENT 'Current status of the appeal or reconsideration process, tracking progression from filing through final adjudication. [ENUM-REF-CANDIDATE: Not Filed|Pending|Under Review|Hearing Scheduled|Denied|Granted|Partially Granted|Withdrawn|Settled — 9 candidates stripped; promote to reference product]',
    `compliance_risk_level` STRING COMMENT 'Internal risk assessment classification of the penalty based on severity, reputational impact, likelihood of recurrence, and regulatory relationship implications.. Valid values are `Critical|High|Medium|Low`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this regulatory penalty record was first created in the system, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `external_counsel_firm_name` STRING COMMENT 'Name of the law firm or regulatory consulting firm engaged to represent the operator in the penalty matter. Null if no external counsel was retained.',
    `external_counsel_involved_flag` BOOLEAN COMMENT 'Boolean indicator of whether external legal counsel or regulatory consultants were engaged to manage the penalty response, appeal, or settlement. True if external counsel involved, False otherwise.',
    `financial_impact_category` STRING COMMENT 'Classification of the penaltys financial materiality for accounting and financial reporting purposes, based on corporate materiality thresholds and SEC guidance.. Valid values are `Material|Significant|Minor|Immaterial`',
    `issuing_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the penalty was issued (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this regulatory penalty record was most recently updated, formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-form text field for additional context, internal commentary, lessons learned, or special circumstances related to the penalty that do not fit structured fields.',
    `payment_confirmation_number` STRING COMMENT 'Transaction reference or confirmation number provided by the regulatory authority or financial institution upon successful payment of the penalty.',
    `payment_date` DATE COMMENT 'Actual date on which the penalty was paid to the regulatory authority. Null if payment has not yet been made.',
    `payment_due_date` DATE COMMENT 'Deadline by which the penalty amount must be paid to the regulatory authority to avoid additional enforcement actions or interest charges.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to remit the penalty payment to the regulatory authority.. Valid values are `Wire Transfer|Check|Electronic Funds Transfer|Credit Card|Settlement Agreement|Other`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of the fine or penalty assessed by the regulatory authority. Represents the gross penalty before any adjustments, settlements, or appeals.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `penalty_notice_date` DATE COMMENT 'Date on which the regulatory authority officially issued the Notice of Apparent Liability (NAL), forfeiture order, or penalty notice to the telecommunications operator.',
    `penalty_reference_number` STRING COMMENT 'External reference number or citation number assigned by the regulatory authority to this enforcement action. Used for official correspondence and tracking.',
    `penalty_status` STRING COMMENT 'Current lifecycle status of the penalty enforcement action, tracking progression from issuance through resolution or appeal. [ENUM-REF-CANDIDATE: Issued|Under Appeal|Appeal Denied|Appeal Granted|Paid|Partially Paid|Overdue|Waived|Settled|Withdrawn — 10 candidates stripped; promote to reference product]',
    `public_disclosure_date` DATE COMMENT 'Date on which the penalty was publicly disclosed through regulatory filings, press releases, or financial reporting. Null if not yet disclosed or disclosure not required.',
    `public_disclosure_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the penalty must be publicly disclosed in regulatory filings, financial statements, or public notices per securities law or regulatory transparency requirements. True if disclosure required, False otherwise.',
    `recurrence_risk_flag` BOOLEAN COMMENT 'Boolean indicator of whether the compliance team has identified a risk of similar violations recurring due to systemic process gaps or control weaknesses. True if recurrence risk identified, False otherwise.',
    `regulatory_authority` STRING COMMENT 'The regulatory body or government agency that issued the penalty. Examples include Federal Communications Commission (FCC), Office of Communications (Ofcom), Body of European Regulators for Electronic Communications (BEREC), or state-level Public Utility Commissions (PUC). [ENUM-REF-CANDIDATE: FCC|ITU|ETSI|3GPP|Ofcom|BEREC|NTIA|GSMA|State PUC|Data Protection Authority|Other — 11 candidates stripped; promote to reference product]',
    `remediation_completion_date` DATE COMMENT 'Date on which all required remediation actions were completed and verified by the regulatory authority or internal compliance team. Null if remediation is ongoing or not required.',
    `remediation_plan_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the regulatory authority has mandated submission of a corrective action plan, compliance improvement plan, or remediation roadmap. True if required, False otherwise.',
    `remediation_plan_submission_date` DATE COMMENT 'Date on which the operator submitted the required remediation or corrective action plan to the regulatory authority. Null if not required or not yet submitted.',
    `responsible_business_unit` STRING COMMENT 'Name or code of the internal business unit, division, or department responsible for the operations or activities that led to the regulatory violation.',
    `settlement_agreement_flag` BOOLEAN COMMENT 'Boolean indicator of whether the penalty was resolved through a negotiated settlement or consent decree with the regulatory authority. True if settled, False otherwise.',
    `settlement_date` DATE COMMENT 'Date on which a settlement agreement or consent decree was executed between the operator and the regulatory authority. Null if no settlement was reached.',
    `settlement_terms` STRING COMMENT 'Summary of the key terms and conditions of the settlement agreement, including any compliance commitments, remediation actions, or payment schedules agreed upon.',
    `violation_description` STRING COMMENT 'Detailed narrative description of the specific regulatory violation, including the nature of the breach, affected services, customer impact, and any aggravating or mitigating circumstances.',
    `violation_end_date` DATE COMMENT 'Date on which the violation was remediated or ceased. Null for single-occurrence violations or if the violation is ongoing.',
    `violation_occurrence_date` DATE COMMENT 'Date on which the regulatory violation occurred or was first detected by the regulatory authority. May represent the start date for ongoing or repeated violations.',
    `violation_type` STRING COMMENT 'Classification of the regulatory violation that triggered the penalty. [ENUM-REF-CANDIDATE: Spectrum License Non-Compliance|Service Quality Violation|Consumer Protection Breach|Data Privacy Violation|Lawful Intercept Non-Compliance|Universal Service Fund Shortfall|Network Outage Reporting Failure|Billing Practice Violation|Emergency Services (E911) Failure|Interconnection Dispute|Anti-Competitive Conduct|Environmental Compliance Breach|Other — promote to reference product]',
    CONSTRAINT pk_regulatory_penalty PRIMARY KEY(`regulatory_penalty_id`)
) COMMENT 'Transactional record of regulatory penalties, fines, and enforcement actions issued against the telecommunications operator by FCC, Ofcom, BEREC, data protection authorities, or other regulators. Captures issuing authority, violation type, penalty amount, currency, penalty notice date, payment due date, payment status, appeal status, and associated regulatory filing or obligation. SSOT for enforcement action tracking and financial exposure management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` (
    `data_breach_incident_id` BIGINT COMMENT 'Unique identifier for the data breach incident record. Primary key for the data breach incident entity.',
    `analytical_model_registry_id` BIGINT COMMENT 'Foreign key linking to analytics.analytical_model_registry. Business justification: Breach investigations identify model vulnerabilities (models exposing PII, inadequate anonymization, unauthorized data access). Security audit linkage between breach incidents and model registry in te',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Data breach incidents trigger compliance audits to investigate root cause, assess control failures, and verify remediation. This FK links breach incidents to the audits that investigated them. FK will',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Data breaches often originate from compromised physical sites (data centers, network operations centers). Incident response requires site identification for physical containment, forensics access, and',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Breach incidents occur within specific legal entities. Financial impacts (remediation costs, fines, litigation) must be tracked per company code for accurate financial reporting, insurance claims, and',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Data breaches affecting enterprise customers require entity-specific notification, regulatory reporting (GDPR, state breach laws), and remediation tracking. Critical for enterprise account management ',
    `dq_issue_id` BIGINT COMMENT 'Foreign key linking to analytics.dq_issue. Business justification: Breach investigations uncover data quality problems (incomplete audit logs, missing consent records, inconsistent PII). Real forensic workflow linking security incidents to data quality remediation in',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Breach-related costs (remediation, forensics, legal counsel, credit monitoring, regulatory fines) must post to specific GL accounts for expense tracking, financial statement reporting, and insurance c',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Data breach response led by designated employee. Telecommunications operators must track incident commander for GDPR/breach notification compliance, audit trails, and incident management reporting. Re',
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

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` (
    `e911_compliance_id` BIGINT COMMENT 'Primary key for e911_compliance',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: E911 compliance testing (location accuracy, call routing) is conducted at specific cell sites and PSAPs. Regulatory certifications require site-level test results and location accuracy measurements fo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: E911 compliance activities (location accuracy testing, database maintenance, PSAP coordination, system upgrades) incur ongoing costs that must be allocated to specific cost centers for budget manageme',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: E911 compliance is measured per coverage area (horizontal/vertical accuracy requirements vary by area type). Regulatory obligations require coverage-area-level accuracy reporting to demonstrate compli',
    `enterprise_site_id` BIGINT COMMENT 'Foreign key linking to enterprise.site. Business justification: E911 compliance is site-specific for enterprise voice services. Each site must have accurate dispatchable location, PSAP routing, and ALI database entries. Required for FCC compliance and emergency re',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: E911 compliance records fulfill regulatory obligations under FCC rules (US) or equivalent emergency services regulations in other jurisdictions. This FK links E911 compliance records to the specific r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: E911 compliance requires named responsible officer for FCC certifications and public safety coordination. Telecommunications operators must track accountable employee for regulatory filings, testing c',
    `ani_ali_database_provider` STRING COMMENT 'Name of the third-party provider managing the ANI/ALI database for this service (if applicable).',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this E911 compliance record to detailed audit logs and supporting documentation for regulatory inspection.',
    `call_routing_method` STRING COMMENT 'Method by which E911 calls are routed to the appropriate PSAP (legacy selective router, Next Generation 911 ESInet, IP-based, hybrid, direct PSAP connection).. Valid values are `Legacy Selective Router|NG911 ESInet|IP-Based|Hybrid|Direct PSAP`',
    `certification_date` DATE COMMENT 'Date when the E911 compliance certification was issued or filed with the regulatory authority.',
    `certification_expiry_date` DATE COMMENT 'Date when the E911 compliance certification expires and renewal is required.',
    `compliance_reference_number` STRING COMMENT 'Externally-known unique reference number for this E911 compliance record, used for regulatory filings and audit trails.. Valid values are `^E911-[A-Z0-9]{8,16}$`',
    `compliance_status` STRING COMMENT 'Current compliance status of the E911 obligation for this service and coverage area.. Valid values are `Compliant|Non-Compliant|Pending Review|Remediation Required|Exempt|Suspended`',
    `compliance_test_date` DATE COMMENT 'Date when the most recent E911 compliance test was conducted for this service and coverage area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this E911 compliance record was first created in the system.',
    `database_update_frequency` STRING COMMENT 'Frequency at which subscriber location information is updated in the ANI/ALI or LIS database to maintain E911 compliance.. Valid values are `Real-Time|Hourly|Daily|Weekly|On-Demand`',
    `dispatchable_location_capable` BOOLEAN COMMENT 'Indicates whether the service is capable of providing dispatchable location (civic address including street address, floor, suite) to the PSAP.',
    `horizontal_accuracy_meters` DECIMAL(18,2) COMMENT 'Horizontal location accuracy in meters required or achieved for Phase II wireless E911 compliance.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction where this E911 compliance obligation applies.. Valid values are `USA|CAN|GBR|AUS|NZL|IRL`',
    `jurisdiction_state_province` STRING COMMENT 'State or province within the country where this E911 compliance obligation applies (e.g., California, Ontario).',
    `last_database_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the ANI/ALI or LIS database for this coverage area or service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this E911 compliance record was last modified or updated.',
    `location_accuracy_success_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of E911 test calls that met the required location accuracy threshold (Phase I, Phase II, or dispatchable location) during the most recent compliance test.',
    `location_accuracy_tier` STRING COMMENT 'FCC-defined location accuracy tier for wireless E911 (Phase I: cell tower/sector; Phase II: lat/long within specified accuracy; Dispatchable Location: civic address; Z-Axis: vertical location for multi-story buildings).. Valid values are `Phase I|Phase II|Dispatchable Location|Z-Axis|Not Applicable`',
    `next_test_due_date` DATE COMMENT 'Date when the next E911 compliance test is required per regulatory schedule.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this E911 compliance record, including special circumstances, waivers, or regulatory correspondence.',
    `psap_code` STRING COMMENT 'Unique identifier for the Public Safety Answering Point (PSAP) as assigned by NENA or state authority.',
    `psap_name` STRING COMMENT 'Name of the Public Safety Answering Point (PSAP) serving this coverage area.',
    `regulatory_certification_reference` STRING COMMENT 'Reference number or identifier for the regulatory certification or attestation filed with the FCC or equivalent authority confirming E911 compliance.',
    `remediation_due_date` DATE COMMENT 'Date by which E911 compliance remediation actions must be completed per regulatory requirement or internal commitment.',
    `remediation_plan_description` STRING COMMENT 'Description of the remediation plan to address E911 compliance deficiencies identified during testing.',
    `service_type` STRING COMMENT 'Type of telecommunications service subject to E911 compliance requirements (VoIP, wireless, wireline, fixed wireless, MVNO, satellite).. Valid values are `VoIP|Wireless|Wireline|Fixed Wireless|MVNO|Satellite`',
    `subscriber_count` BIGINT COMMENT 'Number of active subscribers in this coverage area subject to this E911 compliance record.',
    `test_call_success_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of E911 test calls that successfully reached the correct PSAP with accurate location information during the most recent compliance test.',
    `test_failure_reason` STRING COMMENT 'Detailed explanation of why the E911 compliance test failed, if applicable.',
    `test_outcome` STRING COMMENT 'Outcome of the most recent E911 compliance test (pass, fail, partial pass, not tested, waived).. Valid values are `Pass|Fail|Partial Pass|Not Tested|Waived`',
    `vertical_accuracy_meters` DECIMAL(18,2) COMMENT 'Vertical location accuracy in meters (Z-axis) required or achieved for multi-story building E911 compliance.',
    CONSTRAINT pk_e911_compliance PRIMARY KEY(`e911_compliance_id`)
) COMMENT 'Master record tracking E911 (Enhanced 911) and emergency services compliance obligations per FCC rules (47 CFR Part 9) and equivalent international mandates. Captures service type (VoIP, wireless, wireline), coverage area, location accuracy tier (Phase I/Phase II), compliance test date, test outcome, dispatchable location capability status, and regulatory certification reference. SSOT for emergency services regulatory compliance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`calendar` (
    `calendar_id` BIGINT COMMENT 'Unique identifier for the compliance calendar entry. Primary key for the compliance calendar master record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Compliance calendar entries track audit-related deadlines such as certification renewal dates, corrective action deadlines, and surveillance audit dates. This FK links calendar entries to the specific',
    `bi_report_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.bi_report_definition. Business justification: Compliance deadlines drive scheduled regulatory reports (quarterly service quality, annual accessibility, monthly E911 certification). Real reporting workflow linking compliance calendar to BI report ',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Compliance deadlines tied to specific contracts (government contract reporting, SLA reporting deadlines, audit submission dates). Contract-level tracking enables automated reminders and ensures contra',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Compliance calendar entries track regulatory change deadlines such as implementation deadlines, comment period end dates, and effective dates. This FK links calendar entries to the specific regulatory',
    `regulatory_filing_id` BIGINT COMMENT 'Reference to the specific regulatory filing associated with this deadline, if applicable. Links to the regulatory filing record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the underlying regulatory obligation that drives this deadline. Links to the master regulatory obligation record.',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Compliance calendar entries track penalty-related deadlines such as payment due dates, appeal filing deadlines, and remediation plan submission dates. This FK links calendar entries to the specific pe',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Compliance deadlines assigned to specific employees. Telecommunications operators use this for task management, reminder workflows, performance tracking, and escalation. Core compliance operations req',
    `recurrence_source_calendar_id` BIGINT COMMENT 'Self-referencing FK on calendar (recurrence_source_calendar_id)',
    `backup_officer_email` STRING COMMENT 'Email address of the backup officer for redundant notification and escalation paths.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `backup_officer_name` STRING COMMENT 'Full name of the secondary or backup compliance officer who can assume responsibility if the primary officer is unavailable.',
    `completed_by_name` STRING COMMENT 'Full name of the individual who completed or submitted the compliance obligation.',
    `completion_date` DATE COMMENT 'Actual date when the compliance obligation was fulfilled and the deadline requirement was met.',
    `completion_status` STRING COMMENT 'Current status of work toward meeting the deadline. Tracks progress from initiation through verification of completion.. Valid values are `not_started|in_progress|completed|verified|overdue|cancelled`',
    `completion_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the compliance obligation was marked as completed, including time and timezone information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance calendar entry was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `days_overdue` STRING COMMENT 'Number of calendar days the deadline is overdue. Calculated as the difference between current date and due date when overdue flag is true.',
    `deadline_description` STRING COMMENT 'Detailed description of the compliance deadline, including specific requirements, deliverables, and any special instructions or conditions.',
    `deadline_reference_number` STRING COMMENT 'Business-assigned unique reference number for the compliance deadline entry, used for tracking and communication purposes.',
    `deadline_status` STRING COMMENT 'Current lifecycle status of the compliance deadline. Tracks progression from scheduling through completion or escalation. [ENUM-REF-CANDIDATE: scheduled|pending|in_progress|completed|overdue|cancelled|deferred — 7 candidates stripped; promote to reference product]',
    `deadline_title` STRING COMMENT 'Short descriptive title of the compliance deadline for quick identification and calendar display purposes.',
    `deadline_type` STRING COMMENT 'Classification of the compliance deadline. Indicates the nature of the obligation requiring completion by the due date. [ENUM-REF-CANDIDATE: regulatory_filing|certification_renewal|audit_submission|penalty_payment|dsr_response|license_renewal|report_submission|inspection|training_completion|policy_review — 10 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'The date by which the compliance obligation must be fulfilled. This is the regulatory or contractual deadline for completion.',
    `due_time` TIMESTAMP COMMENT 'Precise timestamp including time-of-day when the deadline expires, if a specific time is mandated. Includes timezone information.',
    `escalation_date` DATE COMMENT 'Date when the escalation process was triggered and notifications were sent to escalation path recipients.',
    `escalation_path` STRING COMMENT 'Defined escalation hierarchy for overdue deadlines. Comma-separated list of roles or names to notify in sequence when deadlines are missed.',
    `escalation_triggered_flag` BOOLEAN COMMENT 'Indicates whether the escalation process has been initiated due to overdue status or high-risk non-completion.',
    `extended_due_date` DATE COMMENT 'New due date if an extension has been granted. Replaces the original due date for compliance tracking purposes.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a deadline extension has been granted by the regulatory authority or internal governance body.',
    `extension_reason` STRING COMMENT 'Business justification or regulatory grounds for the deadline extension. Documents the rationale for the extension request and approval.',
    `first_reminder_sent_date` DATE COMMENT 'Date when the first automated reminder notification was sent to the responsible officer.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or jurisdiction identifier where the compliance obligation applies. Examples: USA, GBR, DEU.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this compliance calendar entry. Tracks when any field in the record was last changed.',
    `last_reminder_sent_date` DATE COMMENT 'Date when the most recent reminder notification was sent, tracking the latest communication to responsible parties.',
    `next_occurrence_date` DATE COMMENT 'The date of the next scheduled occurrence for recurring deadlines. Automatically calculated based on recurrence pattern.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, dependencies, or any other relevant information about the compliance deadline.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the deadline has passed without completion. Automatically set when current date exceeds due date and completion status is not completed.',
    `priority_level` STRING COMMENT 'Business priority assigned to this compliance deadline based on regulatory impact, penalty severity, and business risk.. Valid values are `critical|high|medium|low`',
    `recurrence_interval` STRING COMMENT 'Numeric interval for recurring deadlines when using custom recurrence patterns. For example, every 2 months or every 3 years.',
    `recurrence_pattern` STRING COMMENT 'Frequency pattern for recurring compliance deadlines. Indicates whether the deadline repeats and at what interval. [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|semi_annual|annual|biennial|custom — 9 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or governing authority that mandates this deadline. Examples include FCC, NTIA, Ofcom, BEREC, GDPR supervisory authorities.',
    `reminder_count` STRING COMMENT 'Total number of reminder notifications sent for this deadline. Used to track engagement and escalation needs.',
    `reminder_trigger_days` STRING COMMENT 'Comma-separated list of days before the due date when automated reminders should be sent to responsible officers. Example: 30,14,7,3,1.',
    `responsible_department` STRING COMMENT 'Business unit or department accountable for meeting this compliance deadline, such as Legal, Regulatory Affairs, or Network Operations.',
    `risk_severity_level` STRING COMMENT 'Assessment of the risk severity if this deadline is missed, considering potential regulatory penalties, reputational damage, and operational impact.. Valid values are `critical|high|medium|low|minimal`',
    `submission_window_end_date` DATE COMMENT 'The final date when submission or filing will be accepted. Typically aligns with the due date but may differ for certain regulatory processes.',
    `submission_window_start_date` DATE COMMENT 'The earliest date when submission or filing can be accepted by the regulatory authority. Defines the opening of the submission window.',
    `verification_date` DATE COMMENT 'Date when the completion was verified and approved by the designated reviewer or compliance officer.',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether independent verification or approval is required before the deadline can be marked as fully completed.',
    `verified_by_name` STRING COMMENT 'Full name of the individual who verified or approved the completion of the compliance obligation.',
    CONSTRAINT pk_calendar PRIMARY KEY(`calendar_id`)
) COMMENT 'Master record of compliance deadlines, recurring filing dates, certification renewal dates, and regulatory submission windows. Captures deadline type (filing, certification renewal, audit, penalty payment, DSR response), associated obligation or filing reference, due date, responsible officer, reminder triggers, completion status, and overdue escalation path. SSOT for the compliance teams operational scheduling and deadline management across all regulatory frameworks.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` (
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Regulatory changes assigned to analysts for impact assessment. Telecommunications operators track analyst for workload management, expertise matching, and change implementation tracking. Essential for',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to finance.capital_project. Business justification: Major regulatory changes (new spectrum standards, enhanced network security requirements, E911 location accuracy mandates) often trigger capital projects for system upgrades or new infrastructure. Lin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Implementation of regulatory changes requires resources (impact analysis, system modifications, training, documentation) that must be budgeted and tracked by cost center. Already tracks estimated_comp',
    `enterprise_contract_id` BIGINT COMMENT 'Foreign key linking to enterprise.enterprise_contract. Business justification: Regulatory changes (data sovereignty rules, tariff changes, spectrum policy) directly impact enterprise contracts and may trigger amendments, renegotiation, or price adjustments. Contract-level tracki',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Regulatory changes introduce new KPI requirements (new service quality metrics, accessibility standards, reporting obligations). Real change management process linking regulatory updates to KPI defini',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key reference to the regulatory obligation record that is created, amended, or repealed by this change. Null if the change does not map to a specific tracked obligation.',
    `superseded_change_regulatory_change_id` BIGINT COMMENT 'Foreign key reference to the prior regulatory change record that this change replaces or supersedes. Null if this is a new obligation with no predecessor.',
    `superseded_regulatory_change_id` BIGINT COMMENT 'Self-referencing FK on regulatory_change (superseded_regulatory_change_id)',
    `affected_compliance_areas` STRING COMMENT 'Comma-separated list of compliance domains or operational areas impacted by this regulatory change (e.g., spectrum licensing, lawful intercept, data privacy, universal service fund, Mobile Number Portability (MNP), Customer Proprietary Network Information (CPNI) protection, emergency services).',
    `affected_service_types` STRING COMMENT 'Comma-separated list of telecommunications service types impacted by this change (e.g., wireless, broadband, Fiber to the Home (FTTH), Voice over Long-Term Evolution (VoLTE), Internet Protocol Television (IPTV), Mobile Virtual Network Operator (MVNO) services).',
    `change_reference_number` STRING COMMENT 'External reference number or docket number assigned by the regulatory authority (e.g., FCC docket number, EU directive reference, parliamentary bill number). Used for tracking and cross-referencing with official regulatory publications.',
    `change_status` STRING COMMENT 'Current lifecycle status of the regulatory change indicating its progression through the legislative or rulemaking process. [ENUM-REF-CANDIDATE: proposed|under_review|public_comment|finalized|enacted|withdrawn|superseded — 7 candidates stripped; promote to reference product]',
    `change_title` STRING COMMENT 'Official title or short name of the regulatory change, proposed rulemaking, or legislative amendment as published by the issuing authority.',
    `change_type` STRING COMMENT 'Classification of the regulatory change indicating whether it introduces a new obligation, amends existing regulation, repeals prior rules, provides clarification, or issues guidance. [ENUM-REF-CANDIDATE: new_obligation|amendment|repeal|clarification|guidance|proposed_rule|final_rule — 7 candidates stripped; promote to reference product]',
    `comment_period_end_date` DATE COMMENT 'Date when the public comment period closes. Comments submitted after this date may not be considered by the regulatory authority.',
    `comment_period_start_date` DATE COMMENT 'Date when the public comment period opens for proposed rulemakings, allowing stakeholders to submit feedback to the regulatory authority.',
    `comment_submission_date` DATE COMMENT 'Date when the operator submitted its formal comments to the regulatory authority. Null if no comment was submitted.',
    `comment_submitted_flag` BOOLEAN COMMENT 'Boolean indicator of whether the telecommunications operator submitted formal comments or feedback to the regulatory authority during the public comment period.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated compliance cost amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was first created in the compliance management system.',
    `document_url` STRING COMMENT 'Web link to the official regulatory document, proposed rule, or legislative text published by the issuing authority.',
    `effective_date` DATE COMMENT 'Date when the regulatory change becomes legally binding and enforceable. Null for proposed rules not yet finalized.',
    `escalation_date` DATE COMMENT 'Date when this regulatory change was escalated to senior leadership. Null if no escalation has occurred.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this regulatory change has been escalated to senior management or the board of directors due to high impact or strategic significance.',
    `estimated_compliance_cost_amount` DECIMAL(18,2) COMMENT 'Estimated financial cost to achieve compliance with this regulatory change, including system modifications, process changes, training, and external consulting. Expressed in the operators reporting currency.',
    `external_counsel_firm_name` STRING COMMENT 'Name of the external law firm or regulatory consulting firm engaged to support the operators response to this regulatory change. Null if no external counsel was involved.',
    `external_counsel_involved_flag` BOOLEAN COMMENT 'Boolean indicator of whether external legal counsel or regulatory consultants were engaged to assess or respond to this regulatory change.',
    `impact_assessment_status` STRING COMMENT 'Status of the internal impact assessment process evaluating how this regulatory change affects the operators systems, processes, costs, and compliance posture.. Valid values are `not_started|in_progress|completed|not_required`',
    `impact_severity_level` STRING COMMENT 'Assessed severity of the regulatory changes impact on the telecommunications operator, considering operational disruption, financial cost, and compliance risk.. Valid values are `critical|high|medium|low|negligible`',
    `implementation_completion_date` DATE COMMENT 'Actual date when the operator achieved full compliance with the regulatory change. Null if implementation is not yet complete.',
    `implementation_deadline` DATE COMMENT 'Date by which the telecommunications operator must achieve full compliance with the new or amended regulatory obligation. May differ from effective date if a transition period is granted.',
    `implementation_plan_description` STRING COMMENT 'Summary of the planned or executed actions to achieve compliance, including system changes, process updates, training programs, and policy revisions.',
    `implementation_status` STRING COMMENT 'Current status of the operators implementation efforts to achieve compliance with this regulatory change. [ENUM-REF-CANDIDATE: not_started|planning|in_progress|testing|completed|deferred|not_applicable — 7 candidates stripped; promote to reference product]',
    `internal_policy_reference` STRING COMMENT 'Reference number or identifier of the internal corporate policy, procedure, or compliance framework document that addresses this regulatory change.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory change record was most recently updated, reflecting changes in status, assessment, or implementation progress.',
    `legal_citation` STRING COMMENT 'Full legal citation or reference to the statute, regulation, directive, or standard document (e.g., 47 CFR Part 64, EU Directive 2018/1972, 3GPP TS 23.501).',
    `modified_by_user` STRING COMMENT 'Username or employee identifier of the user who last modified this regulatory change record, supporting audit trail and accountability.',
    `monitoring_priority` STRING COMMENT 'Priority level assigned for ongoing monitoring and tracking of this regulatory change through its lifecycle, based on business impact and compliance risk.. Valid values are `critical|high|medium|low`',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or internal commentary regarding this regulatory change, its implications, or the operators response strategy.',
    `publication_date` DATE COMMENT 'Date when the regulatory change, proposed rule, or legislative amendment was officially published or announced by the issuing authority.',
    `related_changes` STRING COMMENT 'Comma-separated list of related regulatory change IDs or reference numbers that are connected to this change (e.g., predecessor rules, companion amendments, superseded regulations).',
    `responsible_business_unit` STRING COMMENT 'Name of the business unit, department, or division responsible for implementing compliance with this regulatory change (e.g., Legal, Regulatory Affairs, Network Operations, Customer Privacy).',
    `source_authority` STRING COMMENT 'Name of the regulatory body, legislative body, or standards organization that issued or proposed the change (e.g., FCC, NTIA, Ofcom, BEREC, European Parliament, 3GPP, ITU).',
    `source_jurisdiction` STRING COMMENT 'Geographic or political jurisdiction of the issuing authority using ISO 3166-1 alpha-3 country codes or regional identifiers (e.g., USA, GBR, EUR for EU-wide directives).',
    CONSTRAINT pk_regulatory_change PRIMARY KEY(`regulatory_change_id`)
) COMMENT 'Master record tracking regulatory changes, proposed rulemakings (NPRM), and legislative amendments that may impact the telecommunications operator. Captures change source (FCC docket, EU directive, parliamentary act), change type (new obligation, amendment, repeal), affected compliance areas, impact assessment status, implementation deadline, assigned analyst, implementation status, and linkage to affected obligations. Supports proactive compliance management and regulatory horizon scanning.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` (
    `coverage_obligation_id` BIGINT COMMENT 'Primary key for the coverage_obligation association',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to the specific coverage area subject to this regulatory obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation being tracked for compliance in this coverage area',
    `assessor_name` STRING COMMENT 'Name or identifier of the individual, team, or third-party auditor who conducted the last compliance assessment for this obligation-area pair.',
    `compliance_deadline` DATE COMMENT 'The deadline by which this coverage area must achieve compliance with this regulatory obligation. May differ from the obligations general effective date based on phased rollout requirements or area-specific build-out schedules.',
    `compliance_gap_percentage` DECIMAL(18,2) COMMENT 'The difference between required and actual coverage percentage (required minus actual). Positive values indicate non-compliance. Used for prioritizing remediation efforts and regulatory reporting.',
    `compliance_status` STRING COMMENT 'Current compliance status for this specific obligation in this specific coverage area. Tracks whether the coverage area meets the requirements of this particular regulatory obligation. Updated based on assessments, audits, and automated monitoring.',
    `coverage_percentage_actual` DECIMAL(18,2) COMMENT 'The actual coverage percentage achieved in this coverage area as measured against this regulatory obligations requirements. Updated based on drive tests, propagation models, or crowdsourced data. Used to calculate compliance gap.',
    `coverage_percentage_required` DECIMAL(18,2) COMMENT 'The minimum coverage percentage required by this regulatory obligation for this specific coverage area. Expressed as a percentage (0-100). May vary by area based on regulatory classification (urban, rural, tribal, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage obligation compliance record was first created in the system.',
    `exemption_status` STRING COMMENT 'Indicates whether this specific coverage area has been granted an exemption or waiver from this regulatory obligation. Exemptions may be granted based on technical infeasibility, economic hardship, or other regulatory relief provisions.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent compliance assessment or audit conducted for this obligation-area combination. Used to track assessment frequency and identify areas requiring re-assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage obligation compliance record was last updated.',
    `next_assessment_due_date` DATE COMMENT 'The scheduled date for the next compliance assessment or verification activity for this obligation-area pair. Calculated based on the obligations compliance frequency and last assessment date.',
    `notes` STRING COMMENT 'Free-text field for additional context about the compliance status, assessment findings, exemption justifications, or remediation activities specific to this obligation-area combination.',
    `remediation_plan_reference` STRING COMMENT 'Reference identifier to the remediation plan, capital project, or network expansion initiative addressing any compliance gap in this obligation-area combination. Null if compliant or no plan exists.',
    `reporting_period` STRING COMMENT 'The regulatory reporting period to which this compliance record applies (e.g., 2024-Q1, 2024-Annual). Used for historical compliance tracking and regulatory filing preparation.',
    CONSTRAINT pk_coverage_obligation PRIMARY KEY(`coverage_obligation_id`)
) COMMENT 'This association product represents the compliance relationship between a regulatory obligation and a specific coverage area. It captures obligation-specific compliance tracking for geographic coverage requirements including universal service obligations (USO), rural broadband mandates, franchise build-out commitments, and spectrum license coverage conditions. Each record links one regulatory obligation to one coverage area with compliance status, required vs. actual coverage metrics, assessment dates, and exemption status that exist only in the context of this specific obligation-area pairing.. Existence Justification: Telecommunications operators face multiple geographic coverage obligations from different regulatory authorities (FCC universal service obligations, state franchise build-out commitments, spectrum license coverage conditions, rural broadband mandates). Each regulatory obligation applies to multiple coverage areas across the operators service territory, and each coverage area is simultaneously subject to multiple overlapping obligations. The business actively manages compliance on a per-obligation-per-area basis, tracking required vs. actual coverage percentages, assessment dates, compliance status, and remediation plans for each unique pairing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`account_obligation` (
    `account_obligation_id` BIGINT COMMENT 'Unique identifier for this account-obligation compliance relationship record. Primary key.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to the corporate account subject to this regulatory obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the master regulatory obligation record that applies to this corporate account',
    `applicability_determination_date` DATE COMMENT 'Date when it was determined that this regulatory obligation applies to this corporate account, based on services contracted, jurisdictions served, or industry vertical.',
    `applicability_reason` STRING COMMENT 'Business reason why this obligation applies to this account. Examples: Account operates in California - CCPA applies, Account uses POTS services - CALEA applies, Government account - FedRAMP required.',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific corporate account for this specific regulatory obligation. Overrides the master obligation compliance_status with account-level granularity. Explicitly identified in detection reasoning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this account-obligation relationship record was created in the system.',
    `evidence_repository_reference` STRING COMMENT 'Reference identifier, URL, or file path to the repository location where compliance evidence, audit trails, and certification documents for this account-obligation combination are stored.',
    `exemption_status` STRING COMMENT 'Indicates whether this specific corporate account has been granted an exemption, waiver, or special dispensation from this regulatory obligation. Account-specific exemption tracking. Explicitly identified in detection reasoning.',
    `last_assessment_date` DATE COMMENT 'Date when this corporate account was last assessed for compliance with this specific regulatory obligation. Account-specific assessment tracking. Explicitly identified in detection reasoning.',
    `last_audit_finding` STRING COMMENT 'Summary of the most recent audit or assessment finding for this accounts compliance with this obligation. Captures issues identified, corrective actions required, or clean audit confirmation.',
    `next_due_date` DATE COMMENT 'Next scheduled date by which this corporate account must demonstrate compliance, submit filings, or complete certification for this specific obligation. Account-specific deadline tracking. Explicitly identified in detection reasoning.',
    `responsible_officer` STRING COMMENT 'Name or identifier of the compliance officer, account manager, or business unit representative responsible for ensuring this corporate accounts compliance with this specific obligation. Explicitly identified in detection reasoning.',
    `risk_level` STRING COMMENT 'Risk severity classification for non-compliance with this obligation for this specific corporate account, considering account size, revenue, industry vertical, and regulatory exposure. Account-specific risk assessment. Explicitly identified in detection reasoning.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this account-obligation compliance record.',
    CONSTRAINT pk_account_obligation PRIMARY KEY(`account_obligation_id`)
) COMMENT 'This association product represents the compliance relationship between a corporate account and a regulatory obligation. It captures account-specific compliance tracking, assessment history, and responsibility assignment for each obligation applicable to each enterprise customer. Each record links one regulatory_obligation to one corporate_account with attributes that track the accounts specific compliance posture, due dates, responsible officers, and exemption status for that particular obligation.. Existence Justification: In telecommunications regulatory compliance, each regulatory obligation (CALEA, GDPR, E911, spectrum license conditions, etc.) applies to multiple corporate accounts based on their service portfolio, jurisdictions served, and industry vertical. Conversely, each corporate account is subject to multiple regulatory obligations simultaneously. The compliance function actively manages this many-to-many relationship by tracking account-specific compliance status, assessment schedules, responsible officers, exemptions, and risk levels for each account-obligation pairing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` (
    `audit_rule_test_id` BIGINT COMMENT 'Unique identifier for this audit rule test record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to the compliance audit engagement during which this DQ rule was tested',
    `dq_rule_id` BIGINT COMMENT 'Foreign key linking to the data quality rule that was tested during this audit',
    `actual_threshold_percentage` DECIMAL(18,2) COMMENT 'The actual pass rate percentage achieved when this rule was tested during the audit. Compared against the rules defined threshold_percentage to determine pass/fail status.',
    `auditor_notes` STRING COMMENT 'Free-text observations and commentary from the auditor regarding the testing of this rule, including context for findings, remediation recommendations, or mitigating factors.',
    `contributes_to_nonconformity_flag` BOOLEAN COMMENT 'Indicates whether the failure of this rule test contributed to a major or minor nonconformity finding in the overall audit outcome.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit rule test record was created in the system. Immutable audit trail field.',
    `evidence_reference` STRING COMMENT 'Document management system reference or file path to the detailed test evidence, screenshots, or data extracts supporting this rule test result.',
    `findings_count` STRING COMMENT 'The number of violations or non-conformities identified when testing this rule during the audit. Zero indicates full compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this audit rule test record was last modified. Updated when retest results or auditor notes are added.',
    `pass_fail_status` STRING COMMENT 'The outcome of testing this rule during the audit. Indicates whether the rule met its threshold and compliance requirements. Corresponds to rule_pass_fail_status from detection phase.',
    `retest_date` DATE COMMENT 'The date when this rule was retested after corrective actions were implemented. Null if no retest was required or has not yet occurred.',
    `retest_required_flag` BOOLEAN COMMENT 'Indicates whether this rule must be retested as part of corrective action verification or follow-up audit activities.',
    `sample_size` BIGINT COMMENT 'The number of records or data points evaluated when testing this rule during the audit. Used to assess statistical significance of test results.',
    `test_date` DATE COMMENT 'The date when this specific DQ rule was tested during the audit engagement. Corresponds to audit_test_date from detection phase.',
    `test_method` STRING COMMENT 'The methodology used by auditors to test this rule during the audit engagement.',
    CONSTRAINT pk_audit_rule_test PRIMARY KEY(`audit_rule_test_id`)
) COMMENT 'This association product represents the testing event between compliance_audit and dq_rule. It captures the execution and results of testing a specific data quality rule during a compliance audit engagement. Each record links one compliance_audit to one dq_rule with test execution metadata, pass/fail status, sample size, findings count, and auditor observations that exist only in the context of this audit-rule test relationship.. Existence Justification: In telecommunications compliance operations, auditors test multiple data quality rules during each audit engagement (ISO 27001, SOC 2, PCI-DSS, regulatory inspections), and each DQ rule is tested across multiple audits over time. The business actively manages audit rule testing as a distinct compliance activity, tracking test execution dates, pass/fail outcomes, sample sizes, findings counts, and auditor observations for each audit-rule combination to build regulatory evidence trails and demonstrate continuous compliance.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`control` (
    `control_id` BIGINT COMMENT 'Primary key for control',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Controls are created to satisfy specific regulatory obligations; linking control to regulatory_obligation enables direct navigation and eliminates the need for indirect joins via audit_finding.',
    `parent_control_id` BIGINT COMMENT 'Self-referencing FK on control (parent_control_id)',
    `assessment_frequency` STRING COMMENT 'How often the control is assessed for effectiveness.',
    `assessment_result` STRING COMMENT 'Outcome of the latest assessment.',
    `control_category` STRING COMMENT 'Higher‑level grouping of the control within the compliance framework.',
    `control_code` STRING COMMENT 'Unique business code assigned to the control (e.g., ISO‑27001 control identifier).',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework to which the control maps.',
    `control_cost_usd` DECIMAL(18,2) COMMENT 'Estimated annual cost to implement and maintain the control, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was initially captured.',
    `document_url` STRING COMMENT 'Link to the detailed control documentation or policy.',
    `effective_from` DATE COMMENT 'Date when the control becomes effective.',
    `effective_until` DATE COMMENT 'Date when the control expires or is scheduled for retirement (nullable).',
    `effectiveness_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the controls measured effectiveness.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the control is mandatory under the applicable framework.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent assessment of the control.',
    `control_name` STRING COMMENT 'Human‑readable name of the control.',
    `next_assessment_date` DATE COMMENT 'Planned date for the upcoming assessment.',
    `owner` STRING COMMENT 'Name of the individual or team responsible for the control.',
    `owner_contact` STRING COMMENT 'Primary contact information (email or phone) for the control owner.',
    `owner_department` STRING COMMENT 'Organizational unit that holds accountability for the control.',
    `priority` STRING COMMENT 'Business priority assigned to the control for remediation scheduling.',
    `regulatory_body` STRING COMMENT 'Governing authority overseeing the compliance requirement.',
    `remediation_plan` STRING COMMENT 'Description of actions required to address identified gaps.',
    `risk_level` STRING COMMENT 'Risk rating associated with the control based on impact and likelihood.',
    `source_system` STRING COMMENT 'Originating system or application where the control record was first created.',
    `control_status` STRING COMMENT 'Current lifecycle state of the control.',
    `control_type` STRING COMMENT 'Category of the control based on its purpose.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the control record.',
    CONSTRAINT pk_control PRIMARY KEY(`control_id`)
) COMMENT 'Master reference table for control. Referenced by control_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`compliance`.`annual_certification` (
    `annual_certification_id` BIGINT COMMENT 'Primary key for annual_certification',
    `prior_annual_certification_id` BIGINT COMMENT 'Self-referencing FK on annual_certification (prior_annual_certification_id)',
    `attached_document_path` STRING COMMENT 'File system or storage URI pointing to the scanned certification document.',
    `audit_date` DATE COMMENT 'Date when the most recent compliance audit was performed.',
    `audit_findings_summary` STRING COMMENT 'High‑level summary of audit observations and any non‑conformities.',
    `auditor_name` STRING COMMENT 'Name of the individual or firm that conducted the audit.',
    `certification_body` STRING COMMENT 'Organization that performed the certification assessment.',
    `certification_level` STRING COMMENT 'Depth or rigor of the certification (e.g., basic, standard, advanced).',
    `certification_name` STRING COMMENT 'Descriptive name of the certification (e.g., "FCC Spectrum Compliance").',
    `certification_number` STRING COMMENT 'Official number assigned by the issuing authority to identify the certification.',
    `certification_type` STRING COMMENT 'Category of the certification indicating its origin or purpose.',
    `compliance_area` STRING COMMENT 'Business domain or regulatory area covered by the certification (e.g., privacy, spectrum, security).',
    `compliance_requirements` STRING COMMENT 'Textual description of the specific regulatory or policy requirements satisfied by the certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the certification becomes legally effective.',
    `expiration_date` DATE COMMENT 'Date when the certification expires; null for open‑ended certifications.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the certification is mandatory for the business unit (true) or optional (false).',
    `issuing_authority` STRING COMMENT 'Name of the government or industry body that issued the certification.',
    `issuing_authority_code` STRING COMMENT 'Standard code identifying the issuing authority (e.g., FCC, Ofcom).',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code of the jurisdiction governing the certification.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification was last reviewed for relevance or renewal.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the certification.',
    `renewal_date` DATE COMMENT 'Scheduled date for the next certification renewal.',
    `renewal_status` STRING COMMENT 'Current status of the renewal process.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the certification based on audit results.',
    `annual_certification_status` STRING COMMENT 'Current lifecycle status of the certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_annual_certification PRIMARY KEY(`annual_certification_id`)
) COMMENT 'Master reference table for annual_certification. Referenced by annual_certification_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_original_filing_regulatory_filing_id` FOREIGN KEY (`original_filing_regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ADD CONSTRAINT `fk_compliance_lawful_intercept_order_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ADD CONSTRAINT `fk_compliance_privacy_consent_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ADD CONSTRAINT `fk_compliance_privacy_request_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ADD CONSTRAINT `fk_compliance_spectrum_license_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ADD CONSTRAINT `fk_compliance_mnp_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ADD CONSTRAINT `fk_compliance_cpni_authorization_annual_certification_id` FOREIGN KEY (`annual_certification_id`) REFERENCES `telecommunication_ecm`.`compliance`.`annual_certification`(`annual_certification_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ADD CONSTRAINT `fk_compliance_cpni_authorization_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_control_id` FOREIGN KEY (`control_id`) REFERENCES `telecommunication_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_previous_finding_audit_finding_id` FOREIGN KEY (`previous_finding_audit_finding_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_cpni_authorization_id` FOREIGN KEY (`cpni_authorization_id`) REFERENCES `telecommunication_ecm`.`compliance`.`cpni_authorization`(`cpni_authorization_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_data_breach_incident_id` FOREIGN KEY (`data_breach_incident_id`) REFERENCES `telecommunication_ecm`.`compliance`.`data_breach_incident`(`data_breach_incident_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_e911_compliance_id` FOREIGN KEY (`e911_compliance_id`) REFERENCES `telecommunication_ecm`.`compliance`.`e911_compliance`(`e911_compliance_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_spectrum_license_id` FOREIGN KEY (`spectrum_license_id`) REFERENCES `telecommunication_ecm`.`compliance`.`spectrum_license`(`spectrum_license_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ADD CONSTRAINT `fk_compliance_data_breach_incident_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ADD CONSTRAINT `fk_compliance_e911_compliance_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_recurrence_source_calendar_id` FOREIGN KEY (`recurrence_source_calendar_id`) REFERENCES `telecommunication_ecm`.`compliance`.`calendar`(`calendar_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_change_regulatory_change_id` FOREIGN KEY (`superseded_change_regulatory_change_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_superseded_regulatory_change_id` FOREIGN KEY (`superseded_regulatory_change_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ADD CONSTRAINT `fk_compliance_coverage_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ADD CONSTRAINT `fk_compliance_account_obligation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ADD CONSTRAINT `fk_compliance_audit_rule_test_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `telecommunication_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `telecommunication_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_parent_control_id` FOREIGN KEY (`parent_control_id`) REFERENCES `telecommunication_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `telecommunication_ecm`.`compliance`.`annual_certification` ADD CONSTRAINT `fk_compliance_annual_certification_prior_annual_certification_id` FOREIGN KEY (`prior_annual_certification_id`) REFERENCES `telecommunication_ecm`.`compliance`.`annual_certification`(`annual_certification_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `telecommunication_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bi Report Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `original_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Rule Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `annual_compliance_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Compliance Cost Estimate');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `annual_compliance_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `applicable_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segments');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `related_obligations` SET TAGS ('dbx_business_glossary_term' = 'Related Obligations Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `reporting_template_reference` SET TAGS ('dbx_business_glossary_term' = 'Reporting Template Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Submission Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_portal|email|postal_mail|api|ftp|manual_upload');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnect Carrier Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Handling Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Intercept Site Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`lawful_intercept_order` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Target Coverage Area Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `privacy_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dpo Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_consent` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `privacy_request_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Request ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Handler Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`privacy_request` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Site Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`spectrum_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `mnp_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Mnp Compliance Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `customer_mnp_request_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number Portability (MNP) Request ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`mnp_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `cpni_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `annual_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Annual Customer Proprietary Network Information (CPNI) Certification ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Agent ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authentication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Authentication Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Channel');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_reference_number` SET TAGS ('dbx_value_regex' = '^CPNI-[A-Z0-9]{8,16}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|pending_verification|superseded');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `authorization_type` SET TAGS ('dbx_value_regex' = 'opt_in|opt_out|renewal|withdrawal|modification');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `certification_period_year` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Certification Period Year');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Consent Scope');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `consent_scope` SET TAGS ('dbx_value_regex' = 'marketing|service_enhancement|third_party_sharing|all_purposes|limited');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `customer_authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Authentication Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `customer_notification_of_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification of Breach Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `customer_notification_of_breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification of Breach Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period Days');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Effective Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Expiration Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `fcc_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Notification Required Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `fcc_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Notification Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `fcc_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|acknowledged|none');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `fcc_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `law_enforcement_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notification Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `law_enforcement_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Notification Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Authorization Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Channel');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|postal_mail|in_app|none');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `remediation_action_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `remediation_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `responsible_officer_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Title');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `store_location_code` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Location Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_closure_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Violation Closure Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_closure_status` SET TAGS ('dbx_value_regex' = 'open|remediated|closed|under_investigation|none');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_detection_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Violation Detection Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_detection_method` SET TAGS ('dbx_value_regex' = 'internal_audit|customer_complaint|system_alert|regulatory_inspection|third_party_report|none');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Violation Detection Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Violation Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Proprietary Network Information (CPNI) Violation Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`cpni_authorization` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'unauthorized_disclosure|improper_access|pretexting|inadequate_safeguards|none');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `previous_finding_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_business_glossary_term' = 'Affected Process');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|certification|surveillance|special');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closure_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `control_domain` SET TAGS ('dbx_business_glossary_term' = 'Control Domain');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `evidence_of_completion` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Completion');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|closed|reopened|deferred');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'non-conformity|observation|opportunity_for_improvement|positive_finding|major_non-conformity|minor_non-conformity');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `preventive_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Plan');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner Department');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue|deferred');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process_gap|policy_gap|training_gap|system_deficiency|human_error|resource_constraint');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|not_required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_finding` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `analytical_subject_area_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Subject Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `dq_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Execution Result Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `cpni_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Cpni Authorization Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `e911_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'E911 Compliance Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `spectrum_license_id` SET TAGS ('dbx_business_glossary_term' = 'Spectrum License Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$|^d{4}-d{2}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `adjusted_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `adjusted_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `appeal_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `compliance_risk_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `external_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Involved Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `financial_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Category');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `financial_impact_category` SET TAGS ('dbx_value_regex' = 'Material|Significant|Minor|Immaterial');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `issuing_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Penalty Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `payment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'Wire Transfer|Check|Electronic Funds Transfer|Credit Card|Settlement Agreement|Other');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Notice Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Penalty Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `penalty_status` SET TAGS ('dbx_business_glossary_term' = 'Penalty Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `public_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `recurrence_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Risk Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `remediation_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Required Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `remediation_plan_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Submission Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `settlement_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `violation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Violation End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `violation_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Occurrence Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_penalty` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` SET TAGS ('dbx_subdomain' = 'privacy_governance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `data_breach_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Data Breach Incident ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `analytical_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Model Registry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Origin Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `dq_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Dq Issue Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Response Team Lead Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`data_breach_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `e911_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'E911 Compliance Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Site Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `enterprise_site_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `ani_ali_database_provider` SET TAGS ('dbx_business_glossary_term' = 'ANI/ALI (Automatic Number Identification/Automatic Location Identification) Database Provider');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `call_routing_method` SET TAGS ('dbx_business_glossary_term' = 'Call Routing Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `call_routing_method` SET TAGS ('dbx_value_regex' = 'Legacy Selective Router|NG911 ESInet|IP-Based|Hybrid|Direct PSAP');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `compliance_reference_number` SET TAGS ('dbx_business_glossary_term' = 'E911 (Enhanced 911) Compliance Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `compliance_reference_number` SET TAGS ('dbx_value_regex' = '^E911-[A-Z0-9]{8,16}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Pending Review|Remediation Required|Exempt|Suspended');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `compliance_test_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Test Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `database_update_frequency` SET TAGS ('dbx_business_glossary_term' = 'Database Update Frequency');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `database_update_frequency` SET TAGS ('dbx_value_regex' = 'Real-Time|Hourly|Daily|Weekly|On-Demand');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `dispatchable_location_capable` SET TAGS ('dbx_business_glossary_term' = 'Dispatchable Location Capable');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `horizontal_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Horizontal Accuracy (Meters)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|GBR|AUS|NZL|IRL');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `last_database_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Database Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `location_accuracy_success_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Location Accuracy Success Rate (Percent)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `location_accuracy_tier` SET TAGS ('dbx_business_glossary_term' = 'Location Accuracy Tier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `location_accuracy_tier` SET TAGS ('dbx_value_regex' = 'Phase I|Phase II|Dispatchable Location|Z-Axis|Not Applicable');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `psap_code` SET TAGS ('dbx_business_glossary_term' = 'PSAP (Public Safety Answering Point) ID');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `psap_name` SET TAGS ('dbx_business_glossary_term' = 'PSAP (Public Safety Answering Point) Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `regulatory_certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Certification Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `remediation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'VoIP|Wireless|Wireline|Fixed Wireless|MVNO|Satellite');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `subscriber_count` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `test_call_success_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Call Success Rate (Percent)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `test_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `test_outcome` SET TAGS ('dbx_business_glossary_term' = 'Test Outcome');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `test_outcome` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Partial Pass|Not Tested|Waived');
ALTER TABLE `telecommunication_ecm`.`compliance`.`e911_compliance` ALTER COLUMN `vertical_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Vertical Accuracy (Meters)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Calendar Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `bi_report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bi Report Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `recurrence_source_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `backup_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Backup Officer Email Address');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `backup_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `backup_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `backup_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `backup_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Backup Officer Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `completed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Completed By Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue|cancelled');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `deadline_description` SET TAGS ('dbx_business_glossary_term' = 'Deadline Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `deadline_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Deadline Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `deadline_status` SET TAGS ('dbx_business_glossary_term' = 'Deadline Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `deadline_title` SET TAGS ('dbx_business_glossary_term' = 'Deadline Title');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Deadline Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `due_time` SET TAGS ('dbx_business_glossary_term' = 'Due Time');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `escalation_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Triggered Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `first_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'First Reminder Sent Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `last_reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Sent Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `next_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Occurrence Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `reminder_trigger_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Trigger Days');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `risk_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `risk_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `submission_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Window End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `submission_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Window Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`calendar` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `enterprise_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_change_regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Regulatory Change Identifier (ID)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `superseded_regulatory_change_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_compliance_areas` SET TAGS ('dbx_business_glossary_term' = 'Affected Compliance Areas');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `affected_service_types` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Types');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Change Reference Number');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Title');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Type');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `comment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period End Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `comment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period Start Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `comment_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Comment Submission Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `comment_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Comment Submitted Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_compliance_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compliance Cost Amount');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `estimated_compliance_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Firm Name');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `external_counsel_firm_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `external_counsel_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Involved Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_assessment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_required');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Impact Severity Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `impact_severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Completion Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Description');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `legal_citation` SET TAGS ('dbx_business_glossary_term' = 'Legal Citation');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `monitoring_priority` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Priority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `monitoring_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `related_changes` SET TAGS ('dbx_business_glossary_term' = 'Related Regulatory Changes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Regulatory Authority');
ALTER TABLE `telecommunication_ecm`.`compliance`.`regulatory_change` ALTER COLUMN `source_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Source Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` SET TAGS ('dbx_association_edges' = 'compliance.regulatory_obligation,location.coverage_area');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `coverage_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Obligation - Coverage Obligation Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Obligation - Coverage Area Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Obligation - Regulatory Obligation Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessor');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Obligation Compliance Deadline');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `compliance_gap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `compliance_gap_percentage` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation-Area Compliance Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `coverage_percentage_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Coverage Percentage');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `coverage_percentage_actual` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `coverage_percentage_required` SET TAGS ('dbx_business_glossary_term' = 'Required Coverage Percentage');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `coverage_percentage_required` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Area-Specific Exemption Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `exemption_status` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `telecommunication_ecm`.`compliance`.`coverage_obligation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_regulatory_data' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` SET TAGS ('dbx_association_edges' = 'compliance.regulatory_obligation,enterprise.corporate_account');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `account_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Account Obligation Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Obligation - Corporate Account Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Account Obligation - Regulatory Obligation Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `applicability_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Determination Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `applicability_reason` SET TAGS ('dbx_business_glossary_term' = 'Applicability Reason');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Account-Specific Compliance Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `evidence_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Repository Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Account-Specific Exemption Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Assessment Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `last_audit_finding` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Finding');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Due Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `responsible_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Compliance Officer');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Account-Specific Risk Level');
ALTER TABLE `telecommunication_ecm`.`compliance`.`account_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` SET TAGS ('dbx_association_edges' = 'compliance.compliance_audit,analytics.dq_rule');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `audit_rule_test_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Rule Test Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Rule Test - Compliance Audit Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `dq_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Rule Test - Dq Rule Id');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `actual_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Rule Pass Rate');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Test Notes');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `contributes_to_nonconformity_flag` SET TAGS ('dbx_business_glossary_term' = 'Nonconformity Contribution Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Evidence Reference');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Rule Violation Findings Count');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Test Pass/Fail Status');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Execution Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `retest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Required Flag');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Size');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Date');
ALTER TABLE `telecommunication_ecm`.`compliance`.`audit_rule_test` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Method');
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`compliance`.`control` ALTER COLUMN `parent_control_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`compliance`.`annual_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`compliance`.`annual_certification` SET TAGS ('dbx_subdomain' = 'audit_assurance');
ALTER TABLE `telecommunication_ecm`.`compliance`.`annual_certification` ALTER COLUMN `annual_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Annual Certification Identifier');
ALTER TABLE `telecommunication_ecm`.`compliance`.`annual_certification` ALTER COLUMN `prior_annual_certification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
