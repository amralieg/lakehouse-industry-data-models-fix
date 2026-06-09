-- Schema for Domain: partner | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`partner` COMMENT 'Master data for ecosystem partners — acquiring banks, issuing banks, card schemes, PSPs, ISOs, PayFacs, aggregators, TSPs, and technology partners. Owns partner onboarding, agreements, API integration credentials, revenue sharing, SLA commitments, referral tracking, and network participation records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` (
    `ecosystem_partner_id` BIGINT COMMENT 'Unique surrogate identifier for the ecosystem partner.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Facilitates internal cost allocation of partner‑related expenses to a cost center for budgeting and performance tracking.',
    `currency_id` BIGINT COMMENT 'ISO 4217 currency code used for settlements with the partner.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Partner defines a default currency pair for all cross‑border payments, needed for routing, DCC offers and regulatory reporting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Maps each partner to its legal entity for regulatory reporting, KYC/AML compliance, and consolidated financial statements.',
    `parent_partner_ecosystem_partner_id` BIGINT COMMENT 'Identifier of the parent partner in hierarchical relationships, if applicable.',
    `partner_type_id` BIGINT COMMENT 'FK to partner.partner_type',
    `api_integration_endpoint` STRING COMMENT 'Base URL or endpoint used for API integration with the partner.',
    `api_key_identifier` STRING COMMENT 'Identifier for the API key used to authenticate calls to the partner.',
    `compliance_last_review_date` DATE COMMENT 'Date of the most recent compliance review for the partner.',
    `contact_address_line1` STRING COMMENT 'First line of the partners primary mailing address.',
    `contact_address_line2` STRING COMMENT 'Second line of the partners primary mailing address, if any.',
    `contact_city` STRING COMMENT 'City component of the partners primary mailing address.',
    `contact_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the partners primary mailing address.. Valid values are `^[A-Z]{3}$`',
    `contact_email` STRING COMMENT 'Primary email address for partner communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for partner communications.. Valid values are `^[+]?d{1,3}?[- .]?d{1,14}$`',
    `contact_postal_code` STRING COMMENT 'Postal or ZIP code of the partners primary mailing address.',
    `contact_state` STRING COMMENT 'State or province component of the partners primary mailing address.',
    `contract_effective_date` DATE COMMENT 'Date when the partnership contract became effective.',
    `contract_expiration_date` DATE COMMENT 'Date when the partnership contract expires, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner record was first created.',
    `data_privacy_agreement_signed` BOOLEAN COMMENT 'Indicates whether the partner has signed the required data privacy agreement.',
    `fraud_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether real‑time fraud monitoring is active for this partner.',
    `is_approved_for_cross_border` BOOLEAN COMMENT 'True if the partner is authorized to process cross‑border transactions.',
    `is_global_partner` BOOLEAN COMMENT 'True if the partner operates in multiple jurisdictions globally.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit for the partner.',
    `network_participation_flags` STRING COMMENT 'Comma‑separated flags indicating participation in specific payment networks or schemes.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the partner.',
    `onboarding_date` DATE COMMENT 'Date when the partner completed onboarding and became active.',
    `onboarding_stage` STRING COMMENT 'Lifecycle stage of the partner onboarding process.. Valid values are `prospecting|under_review|approved|active|deactivated`',
    `operational_status` STRING COMMENT 'Current operational status of the partner within the ecosystem.. Valid values are `active|inactive|suspended|terminated`',
    `pci_dss_compliance_status` STRING COMMENT 'Current PCI DSS compliance status of the partner.. Valid values are `compliant|non_compliant|pending`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary individual contact for the partner.',
    `primary_contact_role` STRING COMMENT 'Role of the primary contact within the partner organization.. Valid values are `account_manager|technical_lead|compliance_officer`',
    `registration_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the partner is legally registered.. Valid values are `^[A-Z]{3}$`',
    `regulatory_license_number` STRING COMMENT 'Official license or registration number issued by the relevant financial regulator.',
    `revenue_sharing_model` STRING COMMENT 'Model used to share revenue with the partner.. Valid values are `percentage|fixed|tiered`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating assigned to the partner based on AML, fraud, and credit assessments.',
    `sla_commitments` STRING COMMENT 'Textual description of Service Level Agreement commitments with the partner.',
    `tax_identification_number` STRING COMMENT 'Government‑issued tax identifier for the partner.',
    `termination_date` DATE COMMENT 'Date on which the partnership was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner record.',
    CONSTRAINT pk_ecosystem_partner PRIMARY KEY(`ecosystem_partner_id`)
) COMMENT 'Master record for all ecosystem partners in the payments network — acquiring banks, issuing banks, card schemes, PSPs, ISOs, PayFacs, aggregators, TSPs, and technology partners. Owns the authoritative partner identity including legal entity name, partner type classification, registration jurisdiction, regulatory license numbers, PCI DSS compliance status, network participation flags, operational status, and onboarding lifecycle stage. SSOT for partner identity across the enterprise.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_profile` (
    `partner_profile_id` BIGINT COMMENT 'Unique surrogate key for the partner profile record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner profile extends ecosystem partner; adding partner_id FK creates the required parent‑child relationship and eliminates the silo.',
    `partner_type_id` BIGINT COMMENT 'Foreign key linking to partner.partner_type. Business justification: Add FK to reference partner_type lookup, replace redundant string column and enable consistent type classification.',
    `partner_contact_id` BIGINT COMMENT 'Foreign key linking to partner.partner_contact. Business justification: Replace duplicated contact details with FK to partner_contact, ensuring single source of truth for contact information.',
    `annual_tpv_tier` STRING COMMENT 'Tier of total payment volume processed annually.. Valid values are `low|medium|high|very_high|enterprise`',
    `api_capability_authentication` BOOLEAN COMMENT 'Indicates if partner supports authentication APIs (e.g., 3‑DS).',
    `api_capability_settlement` BOOLEAN COMMENT 'Indicates if partner supports settlement APIs.',
    `api_capability_tokenization` BOOLEAN COMMENT 'Indicates if partner supports tokenization APIs.',
    `business_description` STRING COMMENT 'Brief description of the partners business activities.',
    `compliance_status` STRING COMMENT 'Current compliance status of the partner.. Valid values are `compliant|non_compliant|under_review`',
    `contract_effective_end` DATE COMMENT 'Contract end date (nullable if open‑ended).',
    `contract_effective_start` DATE COMMENT 'Contract start date.',
    `contract_number` STRING COMMENT 'Unique contract identifier governing the partnership.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner profile record was first created.',
    `data_privacy_compliance` STRING COMMENT 'Applicable data privacy and security compliance frameworks.. Valid values are `GDPR|CCPA|PCI_DSS|SOX|FATF|NONE`',
    `data_retention_period_days` STRING COMMENT 'Number of days partner data is retained per policy.',
    `dispute_resolution_contact` STRING COMMENT 'Contact name for dispute resolution communications.',
    `dispute_resolution_email` STRING COMMENT 'Email address for dispute resolution contact.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `geographic_footprint` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the partner operates. [ENUM-REF-CANDIDATE: list of many countries — promote to reference product]',
    `headquarters_address_line1` STRING COMMENT 'First line of the partners headquarters street address.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the headquarters address (optional).',
    `headquarters_city` STRING COMMENT 'City of the partners headquarters.',
    `headquarters_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of headquarters.. Valid values are `^[A-Z]{3}$`',
    `headquarters_state` STRING COMMENT 'State or province of the headquarters.',
    `is_active` BOOLEAN COMMENT 'Indicates if the partner profile is currently active.',
    `kyc_status` STRING COMMENT 'KYC verification status of the partner.. Valid values are `verified|pending|failed`',
    `last_risk_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent risk review for the partner.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the partner.',
    `onboarding_date` DATE COMMENT 'Date when the partner was onboarded.',
    `partner_name` STRING COMMENT 'Legal name of the ecosystem partner.',
    `partner_profile_status` STRING COMMENT 'Current lifecycle status of the partner profile.. Valid values are `active|inactive|suspended|pending|terminated`',
    `partner_tier` STRING COMMENT 'Partner tier classification based on revenue sharing and SLA commitments.. Valid values are `gold|silver|bronze|platinum`',
    `revenue_sharing_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the fintech per transaction.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the partner based on AML and fraud assessments.',
    `service_fee_percentage` DECIMAL(18,2) COMMENT 'Service fee percentage charged to the partner.',
    `sla_commitment_days` STRING COMMENT 'Number of days guaranteed for SLA response time.',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 currency codes supported by the partner.',
    `supported_payment_rails` STRING COMMENT 'Payment rails supported by the partner (e.g., ACH, SWIFT, RTP, CARD, NFC, QR, UPI, B2B, P2P). [ENUM-REF-CANDIDATE: ACH|SWIFT|RTP|CARD|NFC|QR|UPI|B2B|P2P — promote to reference product]',
    `termination_date` DATE COMMENT 'Date when the partnership was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner profile.',
    `website_url` STRING COMMENT 'Public website URL of the partner.',
    CONSTRAINT pk_partner_profile PRIMARY KEY(`partner_profile_id`)
) COMMENT 'Extended business profile for each ecosystem partner capturing operational details beyond identity — headquarters address, primary contact information, website, business description, annual TPV tier, supported payment rails (ACH, SWIFT, RTP, card), geographic footprint (countries served), supported currencies, API capability flags, and partner tier classification (Gold, Silver, Bronze). Complements ecosystem_partner with rich operational metadata.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Unique system-generated identifier for each partner agreement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Legal/contract team designates an employee owner for each partner agreement; needed for responsibility tracking and regulatory reporting.',
    `currency_id` BIGINT COMMENT 'Three‑letter ISO currency code used for any monetary amounts in the agreement.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the ecosystem partner associated with this agreement.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Agreements often embed an FX fee schedule governing cross‑border fees; required for invoicing and compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Links revenue‑share agreements to a GL account for accurate revenue recognition and compliance reporting.',
    `partner_contact_id` BIGINT COMMENT 'FK to partner.partner_contact',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Legal jurisdiction whose law governs the agreement (e.g., US, EU, UK).',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Agreements are often scheme‑specific (e.g., Visa, Mastercard) and the scheme context is needed for fee, rule, and regulatory compliance calculations.',
    `agreement_number` STRING COMMENT 'Human‑readable business identifier for the agreement, often referenced in legal and operational documents.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|active|suspended|terminated|pending`',
    `agreement_type` STRING COMMENT 'Category of the partnership contract (e.g., acquiring bank, ISO/PayFac, Token Service Provider, technology partner, network participation).. Valid values are `acquiring|iso|payfac|tsp|technology|network`',
    `amendment_version` STRING COMMENT 'Version identifier for the latest amendment to the agreement (e.g., v1.2).',
    `aml_screening_status` STRING COMMENT 'Result of the most recent anti‑money‑laundering screening for the partner.. Valid values are `passed|failed|pending`',
    `audit_notes` STRING COMMENT 'Free‑form notes captured during audits or reviews of the agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry.',
    `compliance_requirements` STRING COMMENT 'List of regulatory or internal compliance obligations tied to the agreement.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the agreement.. Valid values are `restricted|confidential|internal|public`',
    `contract_document_url` STRING COMMENT 'Secure URL pointing to the stored signed contract document.',
    `created_by_user` STRING COMMENT 'System user identifier who created the agreement record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `data_retention_period_years` STRING COMMENT 'Number of years the agreement data must be retained for regulatory compliance.',
    `effective_end_date` DATE COMMENT 'Date on which the agreement expires or terminates; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date on which the agreement becomes legally binding.',
    `irf_rate` DECIMAL(18,2) COMMENT 'IRF rate applicable to the partner, expressed as a percentage.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the partner has exclusive rights for the covered product or service.',
    `kyc_completed_flag` BOOLEAN COMMENT 'Indicates whether Know‑Your‑Customer verification has been completed for the partner.',
    `last_modified_by_user` STRING COMMENT 'System user identifier who last modified the agreement record.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum single transaction amount permitted for the partner.',
    `max_transaction_volume` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction volume the partner is allowed to process under the agreement.',
    `mdr_rate` DECIMAL(18,2) COMMENT 'Standard MDR applied to the partners transactions, expressed as a percentage.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that a renewal notice must be issued.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction value shared with the partner when revenue_share_type = percentage.',
    `revenue_share_type` STRING COMMENT 'Method used to calculate revenue sharing (percentage of volume, fixed fee, or tiered structure).. Valid values are `percentage|fixed|tiered`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the partner based on underwriting criteria.. Valid values are `low|medium|high`',
    `settlement_cycle_days` STRING COMMENT 'Number of days between transaction processing and settlement for the partner.',
    `signatory_email` STRING COMMENT 'Email address of the signatory for correspondence and audit trails.',
    `signatory_name` STRING COMMENT 'Legal name of the individual signing the agreement on behalf of the partner.',
    `signatory_title` STRING COMMENT 'Job title or role of the signatory within the partner organization.',
    `sla_tier_code` STRING COMMENT 'Code representing the SLA tier committed to the partner.. Valid values are `gold|silver|bronze|standard`',
    `termination_clause` STRING COMMENT 'Textual description of the conditions under which the agreement may be terminated.',
    `termination_date` DATE COMMENT 'Actual date the agreement was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Contractual agreement records between Payments Fintech and ecosystem partners — covering acquiring agreements, ISO/PayFac sponsorship agreements, network participation agreements, TSP licensing agreements, and technology partner contracts. Captures agreement type, effective date, expiration date, auto-renewal flag, governing law jurisdiction, signatory details, MDR/IRF revenue share terms reference, SLA tier reference, termination clauses, and agreement status lifecycle (draft, active, suspended, terminated).';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` (
    `onboarding_application_id` BIGINT COMMENT 'System-generated unique identifier for the partner onboarding application.',
    `assigned_analyst_employee_id` BIGINT COMMENT 'Identifier of the onboarding analyst responsible for this application.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Onboarding application belongs to a partner; adding partner_id FK links the application to its ecosystem partner and resolves the silo.',
    `employee_id` BIGINT COMMENT 'Identifier of the onboarding analyst responsible for this application.',
    `aml_screening_date` DATE COMMENT 'Date the AML screening was performed.',
    `aml_screening_result` STRING COMMENT 'Outcome of Anti-Money Laundering screening.. Valid values are `clear|potential_match|blocked`',
    `api_credentials_provided` BOOLEAN COMMENT 'Flag indicating whether API credentials have been provisioned for the partner.',
    `applicant_contact_email` STRING COMMENT 'Primary email address for communication with the applicant.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_contact_phone` STRING COMMENT 'Primary phone number for the applicant organization.',
    `applicant_legal_entity_name` STRING COMMENT 'Legal name of the partner organization applying for onboarding.',
    `application_date` DATE COMMENT 'Date the onboarding application was submitted.',
    `application_number` STRING COMMENT 'Business-visible identifier assigned to the onboarding application.',
    `application_status` STRING COMMENT 'Current lifecycle status of the onboarding application.. Valid values are `pending|approved|rejected|withdrawn|on_hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding record was first created in the system.',
    `due_diligence_score` DECIMAL(18,2) COMMENT 'Numerical score reflecting the outcome of due‑diligence checks.',
    `effective_end_date` DATE COMMENT 'Date the partnership agreement terminates or expires (nullable).',
    `effective_start_date` DATE COMMENT 'Date the partnership agreement becomes effective.',
    `go_live_date` DATE COMMENT 'Planned date when the partner becomes operational in production.',
    `integration_assessment_score` DECIMAL(18,2) COMMENT 'Score indicating technical integration readiness.',
    `kyc_completion_date` DATE COMMENT 'Date KYC verification was completed.',
    `kyc_status` STRING COMMENT 'Progress status of Know Your Customer verification.. Valid values are `not_started|in_progress|completed|failed`',
    `last_status_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status change.',
    `notes` STRING COMMENT 'Free‑form notes captured by analysts during review.',
    `partner_type` STRING COMMENT 'Category of partner being onboarded (e.g., acquiring bank, PSP, PayFac).. Valid values are `acquiring_bank|issuing_bank|psp|payfac|aggregator|technology_partner`',
    `pci_attestation_date` DATE COMMENT 'Date the PCI DSS attestation was recorded.',
    `pci_dss_attestation_status` STRING COMMENT 'Status of the partners PCI DSS compliance attestation.. Valid values are `not_required|pending|completed|failed`',
    `regulatory_screening_status` STRING COMMENT 'Result of regulatory compliance screening (e.g., OFAC, sanctions).. Valid values are `passed|failed|exempt`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why an application was rejected.',
    `revenue_sharing_model` STRING COMMENT 'Model used to calculate revenue share with the partner.. Valid values are `fixed|percentage|tiered`',
    `risk_assessment_status` STRING COMMENT 'Risk tier assigned after assessment.. Valid values are `low|medium|high|critical`',
    `sanction_check_status` STRING COMMENT 'Outcome of sanctions list checking.. Valid values are `clear|matched|blocked`',
    `sla_commitment_level` STRING COMMENT 'Level of service‑level agreement committed to the partner.. Valid values are `standard|premium|enterprise`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the onboarding record.',
    CONSTRAINT pk_onboarding_application PRIMARY KEY(`onboarding_application_id`)
) COMMENT 'Partner onboarding application record tracking the full lifecycle of a new partner joining the ecosystem — from initial application submission through KYC/KYB verification, due diligence, compliance screening (OFAC/AML), technical integration assessment, and final approval or rejection. Captures application date, applicant legal entity, partner type requested, assigned onboarding analyst, KYC status, AML screening result, PCI DSS attestation status, approval decision, rejection reason codes, and go-live date.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` (
    `onboarding_document_id` BIGINT COMMENT 'System-generated unique identifier for the onboarding document record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner to which this document belongs.',
    `checksum_sha256` STRING COMMENT 'SHA‑256 hash used to verify file integrity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the onboarding document record was first created in the system.',
    `document_language` STRING COMMENT 'Language in which the document content is written.. Valid values are `en|es|fr|de|zh`',
    `document_name` STRING COMMENT 'Human‑readable name or title of the submitted document.',
    `document_number` STRING COMMENT 'Business‑assigned reference number or code for the document.',
    `document_type` STRING COMMENT 'Category of the onboarding document indicating its purpose and regulatory relevance.. Valid values are `incorporation_certificate|pci_dss_certificate|aml_policy|network_membership|bank_account_verification|regulatory_license`',
    `document_version` STRING COMMENT 'Version label or number of the document, if multiple revisions are submitted.',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer considered valid for onboarding.',
    `file_format` STRING COMMENT 'File format of the stored document.. Valid values are `pdf|docx|png|jpg`',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `is_confidential` BOOLEAN COMMENT 'True if the document contains confidential or restricted information.',
    `is_original` BOOLEAN COMMENT 'True if the uploaded file is the original source document; false if it is a copy or scan.',
    `onboarding_document_description` STRING COMMENT 'Free‑form description or notes about the document content or purpose.',
    `onboarding_document_status` STRING COMMENT 'Current processing state of the document within the onboarding workflow.. Valid values are `submitted|under_review|approved|rejected|expired|revoked`',
    `retention_policy` STRING COMMENT 'Policy governing how long the document must be retained for compliance.. Valid values are `retain_7_years|retain_5_years|retain_indefinite`',
    `storage_path` STRING COMMENT 'Secure URI or file system path where the document file is stored.',
    `submission_date` DATE COMMENT 'Date the document was initially submitted by the partner.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the onboarding document record.',
    `verification_date` DATE COMMENT 'Date the document was reviewed and its compliance status confirmed.',
    `verifying_analyst` STRING COMMENT 'Name of the analyst who performed the document verification.',
    CONSTRAINT pk_onboarding_document PRIMARY KEY(`onboarding_document_id`)
) COMMENT 'Documents submitted as part of partner onboarding and ongoing compliance — articles of incorporation, PCI DSS certificates of compliance (CoC), AML policy documents, network membership certificates, bank account verification letters, and regulatory license copies. Tracks document type, submission date, expiration date, verification status, verifying analyst, document storage reference, and associated onboarding application.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` (
    `partner_api_credential_id` BIGINT COMMENT 'Unique identifier for the partner API credential.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user who created the credential.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner to which the credential is issued.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who created the credential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credential record was created in the system.',
    `credential_type` STRING COMMENT 'Type of credential issued to the partner.. Valid values are `api_key|oauth2_client|mtls_certificate`',
    `credential_value` DECIMAL(18,2) COMMENT 'The secret value of the credential (e.g., API key, client secret, certificate).',
    `environment` STRING COMMENT 'Deployment environment for which the credential is valid.. Valid values are `sandbox|production`',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the credential expires.',
    `ip_allowlist` STRING COMMENT 'Comma-separated list of IP addresses or CIDR blocks allowed to use the credential.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the credential was issued.',
    `last_rotation_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent credential rotation.',
    `partner_api_credential_description` STRING COMMENT 'Human readable description of the credential purpose.',
    `partner_api_credential_status` STRING COMMENT 'Current lifecycle status of the credential.. Valid values are `active|inactive|revoked|suspended|pending`',
    `permission_scopes` STRING COMMENT 'Comma-separated list of permission scopes granted to the credential.',
    `rate_limit_tier` STRING COMMENT 'Tier defining the allowed request rate for the credential.. Valid values are `bronze|silver|gold|platinum`',
    `revocation_status` STRING COMMENT 'Revocation state of the credential.. Valid values are `not_revoked|revoked|pending_revocation`',
    `sdk_version` STRING COMMENT 'Version of the SDK associated with the credential.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credential record.',
    `usage_quota` DECIMAL(18,2) COMMENT 'Maximum number of API calls allowed per billing period.',
    `usage_reset_frequency` STRING COMMENT 'Frequency at which usage quota resets.. Valid values are `daily|weekly|monthly`',
    CONSTRAINT pk_partner_api_credential PRIMARY KEY(`partner_api_credential_id`)
) COMMENT 'API integration credentials issued to partners for accessing Payments Fintech platform services — gateway APIs, tokenization APIs, reporting APIs, and webhook endpoints. Captures credential type (API key, OAuth2 client, mTLS certificate), environment (sandbox, production), issued date, expiration date, last rotation date, permission scopes, rate limit tier, IP allowlist, revocation status, and associated SDK version. Critical for partner integration security and access governance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` (
    `api_credential_rotation_id` BIGINT COMMENT 'System‑generated unique identifier for each API credential rotation event.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the ecosystem partner whose API credentials are being rotated.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rotation record was first inserted into the data lake.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this rotation record.',
    `credential_scope` STRING COMMENT 'Logical grouping or API surface that the credential grants access to.',
    `credential_type` STRING COMMENT 'Classification of the credential being rotated.. Valid values are `api_key|oauth_token|certificate`',
    `error_code` STRING COMMENT 'Error identifier returned if the rotation failed.',
    `new_credential_hash` STRING COMMENT 'Cryptographic hash of the newly issued credential.',
    `new_credential_issued_timestamp` TIMESTAMP COMMENT 'Date‑time when the new credential became active.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the rotation event.',
    `old_credential_hash` STRING COMMENT 'Cryptographic hash of the credential value before rotation (used for audit verification).',
    `partner_acknowledgment_status` STRING COMMENT 'Current acknowledgment state of the partner after rotation.. Valid values are `pending|acknowledged|rejected`',
    `rollback_window_expiry` TIMESTAMP COMMENT 'Timestamp after which the old credential can no longer be used for rollback.',
    `rotating_actor` STRING COMMENT 'Name or system identifier of the analyst or automated process that performed the rotation.',
    `rotation_reason` STRING COMMENT 'Free‑form description of why the rotation was required (e.g., key compromise, policy update).',
    `rotation_success_flag` BOOLEAN COMMENT 'Indicates whether the rotation completed successfully.',
    `rotation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the credential rotation was performed.',
    `rotation_trigger` STRING COMMENT 'Reason that initiated the rotation: scheduled, security incident, or manual request.. Valid values are `scheduled|security_incident|manual_request`',
    CONSTRAINT pk_api_credential_rotation PRIMARY KEY(`api_credential_rotation_id`)
) COMMENT 'Audit trail of API credential rotation events for partner integrations — capturing rotation trigger (scheduled, security incident, manual request), old credential reference hash, new credential issued timestamp, rotating analyst or automated process, partner acknowledgment status, and rollback window expiry. Supports PCI DSS key management compliance and security incident response.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` (
    `revenue_share_schedule_id` BIGINT COMMENT 'Unique surrogate key for the revenue share schedule record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the master agreement that governs the revenue share terms.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the ecosystem partner associated with this revenue share schedule.',
    `bonus_structure_description` STRING COMMENT 'Free‑text description of any bonus or performance‑based components of the schedule.',
    `compliance_approval_status` STRING COMMENT 'Regulatory compliance review outcome for the schedule.. Valid values are `approved|pending|rejected`',
    `compliance_review_date` DATE COMMENT 'Date on which the compliance approval was performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the revenue share schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in the schedule.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date on which the revenue share schedule becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the revenue share schedule expires or is superseded (null for open‑ended).',
    `incentive_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary volume threshold that triggers additional incentive payments.',
    `irf_rate` DECIMAL(18,2) COMMENT 'Pass‑through rate applied to the Interchange Reimbursement Fee (expressed as a decimal fraction of the fee).',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the schedule.. Valid values are `active|inactive|suspended|terminated|pending`',
    `mdr_split_percent` DECIMAL(18,2) COMMENT 'Percentage of the MDR that is allocated to the partner.',
    `msf_tier` STRING COMMENT 'Tier identifier (e.g., A, B, C) that determines the MSF sharing percentage.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or operational comments.',
    `payment_frequency` STRING COMMENT 'How often revenue share amounts are calculated and paid to the partner.. Valid values are `monthly|quarterly|annually`',
    `residual_income_rate` DECIMAL(18,2) COMMENT 'Rate applied to residual income calculations for referral partners (e.g., ISO/PayFac).',
    `schedule_name` STRING COMMENT 'Human‑readable name for the revenue share schedule.',
    `schedule_type` STRING COMMENT 'Category of revenue sharing mechanism (e.g., Interchange Reimbursement Fee pass‑through, Merchant Discount Rate split, Merchant Service Fee tier, bonus, or incentive).. Valid values are `irf|mdr|msf|bonus|incentive`',
    `tier_logic_description` STRING COMMENT 'Narrative explaining how volume bands map to rates and percentages.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revenue share schedule record.',
    `version_number` STRING COMMENT 'Incremental version of the schedule for change tracking.',
    `volume_threshold` BIGINT COMMENT 'Transaction volume (count) required to qualify for the defined tier or incentive.',
    CONSTRAINT pk_revenue_share_schedule PRIMARY KEY(`revenue_share_schedule_id`)
) COMMENT 'Revenue sharing schedule defining the economic terms between Payments Fintech and a partner — IRF pass-through rates, MDR split percentages, MSF sharing tiers, volume-based incentive thresholds, residual income rates for ISO/PayFac referrals, and bonus structures. Captures effective date, expiration date, tiering logic (volume bands), currency, payment frequency (monthly, quarterly), and the associated partner agreement. SSOT for partner economics.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` (
    `revenue_share_statement_id` BIGINT COMMENT 'Unique system-generated identifier for the revenue share statement record.',
    `agreement_id` BIGINT COMMENT 'Identifier of the revenue‑share agreement governing the calculation.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the ecosystem partner (acquiring bank, PSP, etc.) to whom the statement applies.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Allows posting of revenue‑share statements to the general ledger, required for financial consolidation and audit.',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Sum of chargebacks, refunds, penalties, and other adjustments affecting the partners share.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the statement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `[A-Z]{3}`',
    `gross_interchange_amount` DECIMAL(18,2) COMMENT 'Total interchange fees earned from transactions processed through the partner before any deductions.',
    `invoice_number` STRING COMMENT 'Reference number of the invoice generated for the partner payout.',
    `irf_amount` DECIMAL(18,2) COMMENT 'Total IRF paid to card schemes or networks on behalf of the partner.',
    `mdr_amount` DECIMAL(18,2) COMMENT 'Total MDR collected from merchants and attributed to the partner.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue after subtracting MDR and IRF from gross interchange.',
    `partner_share_amount` DECIMAL(18,2) COMMENT 'Portion of net revenue allocated to the partner as per agreement.',
    `payment_due_date` DATE COMMENT 'Date by which the partner must be paid for the statement.',
    `payment_status` STRING COMMENT 'Current status of the payout to the partner.. Valid values are `unpaid|paid|failed`',
    `remarks` STRING COMMENT 'Free‑form comments or notes related to the statement.',
    `revenue_share_statement_status` STRING COMMENT 'Current processing state of the statement.. Valid values are `draft|pending|approved|paid|rejected`',
    `settlement_date` DATE COMMENT 'Date on which the payout was settled in the financial system.',
    `statement_date` TIMESTAMP COMMENT 'Exact date and time when the statement was generated.',
    `statement_number` STRING COMMENT 'Business identifier assigned to the statement, e.g., RSS-2023-07-001.',
    `statement_period_end` DATE COMMENT 'Last calendar date covered by the statement period.',
    `statement_period_start` DATE COMMENT 'First calendar date covered by the statement period.',
    `statement_type` STRING COMMENT 'Frequency of the statement issuance.',
    `total_payable_amount` DECIMAL(18,2) COMMENT 'Final amount payable to the partner after all adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the statement record.',
    CONSTRAINT pk_revenue_share_statement PRIMARY KEY(`revenue_share_statement_id`)
) COMMENT 'Periodic revenue share statement generated for each partner — capturing the calculation period, total TPV processed through the partner, gross interchange earned, MDR collected, IRF paid to networks, net revenue, partner share amount, adjustments (chargebacks, refunds, penalties), and final payable amount. Supports partner billing reconciliation and Oracle Financials AP integration for partner payouts.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` (
    `sla_commitment_id` BIGINT COMMENT 'Unique system-generated identifier for the SLA commitment record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Link SLA commitment to its governing agreement for traceability; agreement_number string is redundant.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the ecosystem partner to which this SLA applies.',
    `breach_count` STRING COMMENT 'Cumulative number of times the SLA has been breached.',
    `breach_last_date` DATE COMMENT 'Date of the most recent SLA breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA commitment record was created.',
    `effective_end_date` DATE COMMENT 'Date on which the SLA commitment expires or is terminated (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the SLA commitment becomes effective.',
    `escalation_contact_email` STRING COMMENT 'Email address of the escalation contact.',
    `escalation_contact_name` STRING COMMENT 'Name of the primary contact for SLA escalations.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of the escalation contact.',
    `last_measured_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent metric measurement for this SLA.',
    `measurement_frequency` STRING COMMENT 'How often the metric is measured within the measurement window.',
    `measurement_frequency_unit` STRING COMMENT 'Unit for measurement frequency (day, hour, minute).. Valid values are `day|hour|minute`',
    `measurement_method` STRING COMMENT 'Method or system used to capture the metric (e.g., real‑time monitoring, batch report).',
    `measurement_window` STRING COMMENT 'Length of the time window over which the metric is measured.',
    `measurement_window_unit` STRING COMMENT 'Unit for the measurement window (day, hour, minute).. Valid values are `day|hour|minute`',
    `metric_name` STRING COMMENT 'Name of the performance metric measured against the SLA (e.g., "Uptime Percentage").',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the SLA commitment.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied for each breach of the SLA.',
    `penalty_currency` STRING COMMENT 'ISO 4217 currency code for the penalty amount (e.g., USD, EUR).',
    `penalty_description` STRING COMMENT 'Narrative description of penalty terms and conditions.',
    `reporting_frequency` STRING COMMENT 'How often SLA performance reports are generated.',
    `reporting_frequency_unit` STRING COMMENT 'Unit for reporting frequency (day, hour, minute).. Valid values are `day|hour|minute`',
    `reporting_method` STRING COMMENT 'Mechanism by which SLA performance is reported to the partner (e.g., API, dashboard, email).',
    `sla_commitment_status` STRING COMMENT 'Current lifecycle status of the SLA commitment.. Valid values are `active|inactive|suspended|terminated|pending`',
    `sla_type` STRING COMMENT 'Category of the SLA commitment (e.g., uptime guarantee, authorization response time).. Valid values are `uptime|auth_response_time|settlement_cutoff|dispute_turnaround|api_availability|support_response`',
    `target_unit` STRING COMMENT 'Unit of measure for the target value (e.g., percent, seconds).. Valid values are `percent|seconds|transactions|ms|minutes`',
    `target_value` DECIMAL(18,2) COMMENT 'Numeric target that the partner must achieve for the metric.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SLA commitment record.',
    CONSTRAINT pk_sla_commitment PRIMARY KEY(`sla_commitment_id`)
) COMMENT 'SLA commitments defined for each partner relationship — covering uptime guarantees, authorization response time targets (TPS thresholds), settlement cutoff SLAs, dispute resolution turnaround times, API availability SLAs, and support response tiers. Captures SLA type, metric name, target value, measurement unit, measurement window, breach penalty terms, and effective period. Distinct from generic product SLAs — these are partner-specific negotiated commitments.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` (
    `sla_breach_event_id` BIGINT COMMENT 'Unique identifier for the SLA breach event record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the ecosystem partner associated with the breach.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice generated for the penalty.',
    `remediation_plan_id` BIGINT COMMENT 'Reference to the remediation plan created to address the breach.',
    `sla_commitment_id` BIGINT COMMENT 'Foreign key linking to partner.sla_commitment. Business justification: Associate breach events with the specific SLA commitment they violate, enabling detailed reporting.',
    `actual_value` DECIMAL(18,2) COMMENT 'The observed value of the metric at the time of breach.',
    `breach_description` STRING COMMENT 'Free‑text description of the breach circumstances.',
    `breach_duration_seconds` STRING COMMENT 'Length of time the SLA metric remained out of compliance, measured in seconds.',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach event.. Valid values are `open|closed|in_progress|escalated`',
    `breach_timestamp` TIMESTAMP COMMENT 'Exact time when the SLA breach was detected by the monitoring system.',
    `comments` STRING COMMENT 'Any supplemental notes or remarks about the breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach event record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the penalty amount.. Valid values are `USD|EUR|GBP|JPY|CHF|CAD`',
    `detection_method` STRING COMMENT 'How the breach was identified (e.g., automated monitoring).. Valid values are `automated|manual|monitoring_tool`',
    `escalation_level` STRING COMMENT 'Internal escalation tier applied to the breach.. Valid values are `none|level1|level2|level3`',
    `financial_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty triggered by the breach, before tax.',
    `partner_notified_timestamp` TIMESTAMP COMMENT 'Time when the partner was formally notified of the breach.',
    `penalty_triggered_flag` BOOLEAN COMMENT 'Indicates whether the financial penalty was actually applied.',
    `recorded_by` STRING COMMENT 'Name or identifier of the system or user that logged the event.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach was considered resolved.',
    `root_cause_category` STRING COMMENT 'High‑level classification of why the SLA breach occurred.. Valid values are `technical|operational|vendor|process|external`',
    `severity_level` STRING COMMENT 'Business impact rating assigned to the breach.. Valid values are `low|medium|high|critical`',
    `sla_metric` STRING COMMENT 'The specific SLA metric that was not met (e.g., transaction processing time).. Valid values are `transaction_processing_time|authorization_time|settlement_time|availability|throughput`',
    `source_system` STRING COMMENT 'Originating system that supplied the breach data.. Valid values are `gateway|settlement|crm|erp|fraud_platform`',
    `target_value` DECIMAL(18,2) COMMENT 'The contractual target value for the SLA metric.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach event record.',
    CONSTRAINT pk_sla_breach_event PRIMARY KEY(`sla_breach_event_id`)
) COMMENT 'Recorded instances where a partner SLA commitment was breached — capturing breach detection timestamp, SLA metric breached, actual measured value, target value, breach duration, root cause category, financial penalty triggered, partner notification timestamp, remediation plan reference, and resolution timestamp. Supports partner performance management and penalty billing workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`referral_record` (
    `referral_record_id` BIGINT COMMENT 'System-generated unique identifier for the referral record.',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: Referral attribution: linking the referring cardholder to the partner referral record enables incentive calculations and performance reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the partner who made the referral.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or system process that created the record.',
    `primary_referral_employee_id` BIGINT COMMENT 'Identifier of the internal user or system process that created the record.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant (or sub‑merchant) that was referred.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user or system process that performed the latest update.',
    `compliance_review_date` TIMESTAMP COMMENT 'Timestamp when the compliance review was completed.',
    `compliance_review_status` STRING COMMENT 'Status of any compliance or AML review performed on the referral.. Valid values are `not_reviewed|reviewed|flagged`',
    `conversion_date` TIMESTAMP COMMENT 'Timestamp when the referral was converted into an active merchant (if applicable).',
    `converted_mid` STRING COMMENT 'MID assigned to the merchant after successful conversion.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the referral record was first created in the system.',
    `fee_eligible_flag` BOOLEAN COMMENT 'Indicates whether the referral qualifies for a commission based on program rules.',
    `is_test_referral` BOOLEAN COMMENT 'Indicates whether the referral is a test record used for onboarding or QA.',
    `notes` STRING COMMENT 'Free‑form comments or remarks added by the partner or internal staff.',
    `referral_campaign_code` STRING COMMENT 'Code identifying the marketing or incentive campaign associated with the referral.',
    `referral_channel` STRING COMMENT 'Channel through which the referral was received.. Valid values are `web|mobile|sales|partner_portal|api`',
    `referral_date` TIMESTAMP COMMENT 'Timestamp when the partner submitted the referral.',
    `referral_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount payable to the referring partner for a successful conversion.',
    `referral_fee_currency` STRING COMMENT 'ISO 4217 currency code for the referral fee.',
    `referral_number` STRING COMMENT 'External reference code assigned to the referral for tracking across systems.',
    `referral_record_status` STRING COMMENT 'Current lifecycle status of the referral.. Valid values are `pending|converted|rejected|withdrawn`',
    `referral_region` STRING COMMENT 'Three‑letter ISO country code representing the geographic region of the referral.',
    `referral_type` STRING COMMENT 'Category of the referring partner (ISO, PayFac, Agent, etc.).. Valid values are `iso|payfac|agent|other`',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the referral record (e.g., CRM, Partner Portal).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the referral record.',
    CONSTRAINT pk_referral_record PRIMARY KEY(`referral_record_id`)
) COMMENT 'Referral tracking records for ISO, PayFac, and agent partners who refer merchants or sub-merchants to Payments Fintech. Captures referral date, referring partner, referred merchant or entity, referral channel, referral campaign code, conversion status (pending, converted, rejected), conversion date, MID assigned upon conversion, and referral fee eligibility flag. Feeds into revenue_share_statement for referral commission calculation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`network_participation` (
    `network_participation_id` BIGINT COMMENT 'System-generated unique identifier for each network participation record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the ecosystem partner (acquirer, issuer, PSP, etc.) associated with this network participation.',
    `bin_range_end` BIGINT COMMENT 'Ending value of the BIN range allocated to the partner.',
    `bin_range_start` BIGINT COMMENT 'Starting value of the BIN range allocated to the partner for routing.',
    `certification_body` STRING COMMENT 'Name of the authority or network that issued the certification.',
    `certification_date` DATE COMMENT 'Date when the partners certification on the network became effective.',
    `certification_expiry` DATE COMMENT 'Date when the partners certification on the network expires (nullable if open‑ended).',
    `certification_type` STRING COMMENT 'Type of certification granted to the partner (full, provisional, or revoked).. Valid values are `full|provisional|revoked`',
    `compliance_status` STRING COMMENT 'Current compliance standing of the participation with network rules.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the participation record was first created in the system.',
    `iin_range_end` BIGINT COMMENT 'Ending IIN assigned to the partner.',
    `iin_range_start` BIGINT COMMENT 'Starting IIN (Issuer Identification Number) assigned to the partner.',
    `is_primary_network` BOOLEAN COMMENT 'Indicates whether this network is the primary routing network for the partner.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the last compliance audit performed on this participation record.',
    `network_member_code` STRING COMMENT 'Identifier assigned by the network to the partner (e.g., Visa MID, Mastercard ID).',
    `network_name` STRING COMMENT 'Name of the payment network or rail (e.g., Visa, Mastercard, ACH, SWIFT, UPI).',
    `network_participation_status` STRING COMMENT 'Current lifecycle status of the participation record.. Valid values are `active|inactive|suspended|pending|terminated`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the participation agreement.',
    `participation_code` STRING COMMENT 'Business identifier assigned to the participation agreement for tracking and reporting.',
    `participation_role` STRING COMMENT 'Role of the partner within the network (acquirer, issuer, processor, or sponsor).. Valid values are `acquirer|issuer|processor|sponsor`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction revenue shared with the partner under this network participation.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to the partners participation based on fraud and risk models.',
    `sla_commitment` STRING COMMENT 'SLA tier agreed for the participation (e.g., gold, silver).. Valid values are `gold|silver|bronze|standard`',
    `termination_date` DATE COMMENT 'Date on which the participation agreement was terminated.',
    `termination_reason` STRING COMMENT 'Reason provided for terminating the network participation, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the participation record.',
    CONSTRAINT pk_network_participation PRIMARY KEY(`network_participation_id`)
) COMMENT 'Network participation records defining which payment card schemes and rails a partner is certified and active on — Visa, Mastercard, Amex, Discover, ACH, RTP, SWIFT, UPI. Captures network name, participation role (acquirer, issuer, processor, sponsor), BIN range assignments, IIN registrations, certification date, certification expiry, network-assigned member ID, and participation status. Critical for routing decisions and interchange qualification.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` (
    `bin_sponsorship_id` BIGINT COMMENT 'Unique identifier for the BIN sponsorship record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the entity (PayFac, ISO, sub-processor) receiving the sponsorship.',
    `primary_bin_sponsoring_bank_partner_ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring/issuing bank sponsoring the BIN range.',
    `agreement_reference` STRING COMMENT 'Reference to the legal agreement document.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `bin_range_end` STRING COMMENT 'Ending BIN/IIN number of the sponsored range.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_start` STRING COMMENT 'Starting BIN/IIN number of the sponsored range.. Valid values are `^[0-9]{6,8}$`',
    `bin_sponsorship_status` STRING COMMENT 'Current lifecycle status of the sponsorship.. Valid values are `active|inactive|suspended|pending|terminated`',
    `card_scheme` STRING COMMENT 'Payment network brand associated with the BIN range.. Valid values are `Visa|Mastercard|Amex|Discover|JCB|UnionPay`',
    `compliance_attestation_date` DATE COMMENT 'Date when compliance attestation was completed.',
    `compliance_attestation_status` STRING COMMENT 'Status of compliance attestation for the sponsorship.. Valid values are `attested|pending|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values in the sponsorship.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when sponsorship becomes effective.',
    `expiration_date` DATE COMMENT 'Date when sponsorship ends, if applicable.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or performance review.',
    `notes` STRING COMMENT 'Free-form notes related to the sponsorship.',
    `partner_contact_email` STRING COMMENT 'Email address of the primary contact for the sponsoring partner.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `partner_contact_phone` STRING COMMENT 'Phone number of the primary contact for the sponsoring partner.. Valid values are `^+?[0-9]{7,15}$`',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates if regulatory filing is required for this sponsorship.',
    `revenue_share_amount` DECIMAL(18,2) COMMENT 'Monetary amount of revenue share per period.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction revenue shared with the sponsoring partner.',
    `risk_rating` STRING COMMENT 'Assessed risk level of the sponsorship.. Valid values are `low|medium|high`',
    `sla_commitment` STRING COMMENT 'Service level agreement tier for the sponsorship.. Valid values are `standard|premium|custom`',
    `sla_commitment_details` STRING COMMENT 'Textual description of SLA terms.',
    `sponsorship_code` STRING COMMENT 'Business identifier for the sponsorship agreement.. Valid values are `^[A-Z0-9]{1,20}$`',
    `sponsorship_type` STRING COMMENT 'Nature of the sponsorship relationship.. Valid values are `exclusive|non-exclusive|partial`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sponsorship record.',
    CONSTRAINT pk_bin_sponsorship PRIMARY KEY(`bin_sponsorship_id`)
) COMMENT 'BIN/IIN sponsorship records where an acquiring or issuing bank partner sponsors BIN ranges on behalf of PayFacs, ISOs, or sub-processors. Captures sponsored BIN range start/end, sponsoring bank partner, sponsored entity, card scheme, sponsorship effective date, expiration date, sponsorship agreement reference, and compliance attestation status. Essential for PayFac and ISO program management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_contact` (
    `partner_contact_id` BIGINT COMMENT 'Unique identifier for the partner contact record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner organization this contact belongs to.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each partner contact is assigned an internal employee liaison; required for service level management and escalation handling.',
    `address_line1` STRING COMMENT 'First line of the contacts mailing address.',
    `address_line2` STRING COMMENT 'Second line of the contacts mailing address (optional).',
    `city` STRING COMMENT 'City component of the contacts mailing address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the contacts mailing address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was created.',
    `department` STRING COMMENT 'Department or business unit where the contact works.',
    `effective_end_date` DATE COMMENT 'Date when the contact relationship ended or is scheduled to end (nullable for active contacts).',
    `effective_start_date` DATE COMMENT 'Date when the contact relationship became effective.',
    `email` STRING COMMENT 'Primary email address for the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the contact.',
    `full_name` STRING COMMENT 'Legal full name of the contact person.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary business contact for the partner.',
    `job_title` STRING COMMENT 'Job title or position of the contact within the partner organization.',
    `last_contacted_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent interaction with the contact.',
    `last_name` STRING COMMENT 'Family name of the contact.',
    `notes` STRING COMMENT 'Free‑form notes or remarks about the contact.',
    `partner_contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|pending|suspended|terminated`',
    `phone_number` STRING COMMENT 'Primary phone number for the contact.. Valid values are `^+?[0-9]{7,15}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contacts mailing address.',
    `preferred_communication_channel` STRING COMMENT 'Preferred channel for communication with this contact.. Valid values are `email|phone|sms|messenger|portal`',
    `role_type` STRING COMMENT 'Role type of the contact within the partner relationship.. Valid values are `primary|technical|compliance|finance|executive|support`',
    `state_province` STRING COMMENT 'State or province component of the contacts mailing address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record.',
    CONSTRAINT pk_partner_contact PRIMARY KEY(`partner_contact_id`)
) COMMENT 'Contact persons associated with partner organizations — primary business contacts, technical integration contacts, compliance officers, finance/billing contacts, and executive sponsors. Captures full name, job title, department, email, phone, contact role type, preferred communication channel, and active status. Supports CRM (Salesforce) synchronization for partner relationship management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` (
    `partner_hierarchy_id` BIGINT COMMENT 'Unique surrogate key for each partner hierarchy record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the downstream (child) partner in the hierarchy.',
    `primary_ecosystem_partner_id` BIGINT COMMENT 'Identifier of the upstream (parent) partner in the hierarchy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy record was first created in the system.',
    `depth` STRING COMMENT 'Number of levels from the top‑most parent to this child partner (root = 0).',
    `effective_from` DATE COMMENT 'Date when the hierarchical relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the hierarchical relationship ends or is scheduled to end; null if open‑ended.',
    `hierarchy_type` STRING COMMENT 'Classification of the relationship between parent and child partners.. Valid values are `ownership|sponsorship|referral|subsidiary|affiliate|jointventure`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the hierarchy relationship is currently active.',
    `relationship_description` STRING COMMENT 'Free‑text description providing context or notes about the hierarchy relationship.',
    `relationship_status` STRING COMMENT 'Current operational status of the parent‑child relationship.. Valid values are `active|inactive|pending|terminated|suspended`',
    `source_system` STRING COMMENT 'Name of the source system that originated the hierarchy record (e.g., CRM, ERP).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the hierarchy record.',
    CONSTRAINT pk_partner_hierarchy PRIMARY KEY(`partner_hierarchy_id`)
) COMMENT 'Organizational hierarchy relationships between partner entities — parent-child relationships for bank holding companies, ISO sub-agent networks, PayFac sub-merchant aggregators, and technology partner subsidiaries. Captures parent partner, child partner, hierarchy type (ownership, sponsorship, referral network), effective date, and hierarchy depth level. Enables roll-up reporting of TPV and revenue across partner networks.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` (
    `integration_endpoint_id` BIGINT COMMENT 'System-generated unique identifier for the integration endpoint configuration.',
    `partner_api_credential_id` BIGINT COMMENT 'Identifier of the stored credential (API key, certificate, secret) used for authentication.',
    `authentication_method` STRING COMMENT 'Mechanism used to authenticate calls to the endpoint.. Valid values are `API_KEY|OAUTH2|CERTIFICATE|BASIC`',
    `change_log` STRING COMMENT 'Free‑form log of configuration changes and version history.',
    `compliance_status` STRING COMMENT 'Regulatory compliance posture of the endpoint configuration.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the endpoint record was first created.',
    `deprecation_date` DATE COMMENT 'Date when the endpoint is scheduled to be retired.',
    `documentation_url` STRING COMMENT 'Link to technical documentation or integration guide.',
    `effective_from` DATE COMMENT 'Date when the endpoint configuration becomes effective.',
    `effective_until` DATE COMMENT 'Date when the endpoint configuration expires or is superseded (null if indefinite).',
    `encryption_algorithm` STRING COMMENT 'Algorithm used for payload encryption.. Valid values are `AES256|RSA|NONE`',
    `endpoint_url` STRING COMMENT 'Full URL or network address used to invoke the partner API or messaging service.',
    `environment` STRING COMMENT 'Operational environment where the endpoint is provisioned.. Valid values are `sandbox|production|test`',
    `error_handling_policy` STRING COMMENT 'Policy dictating how errors from the endpoint are processed.. Valid values are `ignore|retry|alert`',
    `health_check_url` STRING COMMENT 'Endpoint used by monitoring tools to verify service health.',
    `integration_endpoint_description` STRING COMMENT 'Narrative description of the endpoint purpose and usage.',
    `integration_endpoint_name` STRING COMMENT 'Human‑readable name for the integration endpoint.',
    `integration_endpoint_status` STRING COMMENT 'Current operational status of the endpoint.. Valid values are `active|inactive|deprecated|maintenance`',
    `ip_address` STRING COMMENT 'Network IP address of the endpoint (if applicable).. Valid values are `^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the endpoint is currently enabled for traffic.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the endpoint has been deprecated.',
    `last_test_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent connectivity test.',
    `max_retries` STRING COMMENT 'Maximum number of retry attempts allowed.',
    `message_format` STRING COMMENT 'Standard format of messages exchanged on the endpoint.. Valid values are `JSON|XML|ISO8583|ISO20022|CSV`',
    `monitoring_enabled` BOOLEAN COMMENT 'Indicates whether continuous health monitoring is active.',
    `monitoring_endpoint` STRING COMMENT 'URL or address of the monitoring service for this endpoint.',
    `network_zone` STRING COMMENT 'Logical network zone where the endpoint resides.. Valid values are `DMZ|INTERNAL|EXTERNAL`',
    `owner_contact_email` STRING COMMENT 'Email address of the internal owner responsible for the endpoint.',
    `owner_contact_phone` STRING COMMENT 'Phone number of the internal owner responsible for the endpoint.',
    `payload_encryption` BOOLEAN COMMENT 'Indicates whether request/response payloads are encrypted.',
    `port` STRING COMMENT 'TCP/UDP port used for the connection.',
    `protocol` STRING COMMENT 'Communication protocol used by the endpoint (e.g., REST, SOAP, ISO 8583, ISO 20022, SFTP, Webhook).. Valid values are `REST|SOAP|ISO8583|ISO20022|SFTP|WEBHOOK`',
    `rate_limit_per_minute` STRING COMMENT 'Maximum number of requests allowed per minute.',
    `retry_policy` STRING COMMENT 'Strategy applied when a request fails.. Valid values are `exponential|fixed|none`',
    `sla_response_time_ms` STRING COMMENT 'Maximum allowed response time per service level agreement.',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Targeted service availability expressed as a percentage.',
    `supported_operations` STRING COMMENT 'Directionality of traffic the endpoint supports.. Valid values are `request|response|both`',
    `test_result` STRING COMMENT 'Outcome of the last connectivity test.. Valid values are `success|failure`',
    `timeout_seconds` STRING COMMENT 'Maximum time in seconds to wait for a response before aborting.',
    `tls_version` STRING COMMENT 'Transport Layer Security version required for the connection.. Valid values are `TLS1.2|TLS1.3`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the endpoint record.',
    `version` STRING COMMENT 'Version label of the endpoint configuration (e.g., v1.2).',
    CONSTRAINT pk_integration_endpoint PRIMARY KEY(`integration_endpoint_id`)
) COMMENT 'Technical integration endpoint configurations for partner API and messaging connections — REST API endpoints, ISO 8583 socket connections, ISO 20022 messaging endpoints, SFTP batch file exchange endpoints, and webhook delivery URLs. Captures endpoint URL, protocol type, message format standard (ISO 8583, ISO 20022, JSON REST), environment (sandbox/production), TLS version, authentication method, timeout settings, retry policy, and health check URL.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` (
    `partner_certification_record_id` BIGINT COMMENT 'System-generated unique identifier for the partner certification record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the partner to which this certification applies.',
    `assessment_date` DATE COMMENT 'Date on which the certification assessment was performed.',
    `certificate_number` STRING COMMENT 'Official identifier or number assigned by the issuing body to this certification.',
    `certification_document_url` STRING COMMENT 'Secure link to the stored certification document or PDF.',
    `certification_name` STRING COMMENT 'Human‑readable name of the certification (e.g., PCI DSS QSA Assessment, EMVCo Type Approval).',
    `certification_type` STRING COMMENT 'Category of certification; possible values include PCI_DSS, EMVCo, 3DS, PA-DSS, Visa_Ready, Mastercard_Engage, AML, KYC. [ENUM-REF-CANDIDATE: PCI_DSS|EMVCo|3DS|PA-DSS|Visa_Ready|Mastercard_Engage|AML|KYC — promote to reference product]',
    `compliance_level` STRING COMMENT 'Internal rating of compliance maturity for this certification (e.g., level1‑basic to level4‑advanced).. Valid values are `level1|level2|level3|level4`',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall compliance assessment result.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `document_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA‑256) of the certification document for integrity verification.',
    `expiration_reason` STRING COMMENT 'Reason for certification expiration if status is expired (e.g., lapse, revocation).',
    `expiry_date` DATE COMMENT 'Date when the certification expires and must be renewed.',
    `is_current` BOOLEAN COMMENT 'True if the certification is currently valid (i.e., not expired or revoked).',
    `issuing_body` STRING COMMENT 'Organization that issued the certification, such as PCI Security Standards Council, EMVCo, Visa, Mastercard, FinCEN, or other.. Valid values are `PCI_SSC|EMVCo|Visa|Mastercard|FinCEN|Other`',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the regulatory jurisdiction governing the certification.',
    `next_assessment_due` DATE COMMENT 'Planned date for the next required assessment or re‑certification.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations about the certification.',
    `partner_certification_record_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|inactive|revoked|expired|pending`',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation or standard (e.g., PCI DSS v4.0, EMVCo 3DS 2.2).',
    `remediation_details` STRING COMMENT 'Free‑text description of required remediation actions, if any.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether any remediation actions are required to maintain compliance.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk rating associated with the partners certification status, derived from internal risk models.',
    `scope_description` STRING COMMENT 'Narrative describing the functional or geographic scope covered by the certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `version_number` STRING COMMENT 'Version identifier of the certification (e.g., v1.2, rev‑3).',
    CONSTRAINT pk_partner_certification_record PRIMARY KEY(`partner_certification_record_id`)
) COMMENT 'Partner certification and compliance attestation records — PCI DSS QSA assessments, EMVCo type approval certifications, 3DS server certifications, PA-DSS validations, network scheme certifications (Visa Ready, Mastercard Engage), and AML program certifications. Captures certification type, issuing body, certificate number, assessment date, expiry date, scope description, compliance level, and remediation items if any.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_event` (
    `partner_event_id` BIGINT COMMENT 'Unique identifier for the partner lifecycle event record.',
    `actor_employee_id` BIGINT COMMENT 'Identifier of the user or system component that initiated the event.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the partner to which this event relates.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system component that initiated the event.',
    `agreement_id` BIGINT COMMENT 'Identifier of the partner agreement that is directly affected by this event, if applicable.',
    `related_agreement_partner_agreement_id` BIGINT COMMENT 'Identifier of the partner agreement that is directly affected by this event, if applicable.',
    `onboarding_application_id` BIGINT COMMENT 'Identifier of the partner onboarding or integration application linked to the event.',
    `actor_type` STRING COMMENT 'Indicates whether the event was triggered by an automated system process or a human user.. Valid values are `system|user`',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the primary driver for the state change.. Valid values are `regulatory|contractual|operational|risk|customer_request|system_error`',
    `event_description` STRING COMMENT 'Free‑text narrative describing the reason or context for the event.',
    `event_source` STRING COMMENT 'System or application module that generated the event (e.g., Partner Management System, Compliance Engine).',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the event actually occurred in the business process.',
    `event_type` STRING COMMENT 'Categorizes the nature of the partner lifecycle event.. Valid values are `status_change|agreement_amendment|ownership_change|regulatory_notification|network_membership_change|escalation`',
    `new_state` STRING COMMENT 'Partner lifecycle status after the event was applied.. Valid values are `active|suspended|terminated|pending|draft|closed`',
    `payload` STRING COMMENT 'Structured or semi‑structured data captured with the event (e.g., JSON snapshot of changed fields).',
    `previous_state` STRING COMMENT 'Partner lifecycle status before the event was applied.. Valid values are `active|suspended|terminated|pending|draft|closed`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this event record was first inserted into the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this event record (e.g., after enrichment).',
    CONSTRAINT pk_partner_event PRIMARY KEY(`partner_event_id`)
) COMMENT 'Significant lifecycle events recorded against a partner relationship — partner status changes (activation, suspension, termination), agreement amendments, ownership changes, regulatory action notifications, network membership changes, and escalation events. Captures event type, event timestamp, triggering actor (system or user), previous state, new state, event description, and linked agreement or application reference. Provides a full audit trail of partner relationship history.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` (
    `volume_commitment_id` BIGINT COMMENT 'Unique system-generated identifier for each volume commitment.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user who created the volume commitment entry.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the ecosystem partner (acquiring bank, PSP, etc.) associated with this commitment.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who created the volume commitment entry.',
    `actual_tpv_amount` DECIMAL(18,2) COMMENT 'Total payment volume actually processed by the partner in the measurement period.',
    `actual_transaction_count` BIGINT COMMENT 'Number of transactions the partner actually processed during the measurement period.',
    `commitment_number` STRING COMMENT 'Human‑readable contract number or code assigned to the volume commitment.',
    `commitment_type` STRING COMMENT 'The type of volume commitment (e.g., annual, quarterly, monthly, or one‑time).. Valid values are `annual|quarterly|monthly|one_time`',
    `committed_tpv_amount` DECIMAL(18,2) COMMENT 'Total payment volume (in the measurement currency) the partner guarantees for the commitment period.',
    `committed_transaction_count` BIGINT COMMENT 'Minimum number of individual transactions the partner must achieve.',
    `compliance_review_status` STRING COMMENT 'Current compliance standing of the volume commitment.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the volume commitment record was first created in the system.',
    `effective_from` DATE COMMENT 'The start date when the volume commitment takes effect.',
    `effective_until` DATE COMMENT 'The termination date of the commitment; null if the agreement is open‑ended.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Reward amount payable to the partner for surpassing the committed volume thresholds.',
    `last_review_date` DATE COMMENT 'Date when the commitment was last reviewed for compliance and performance.',
    `measurement_currency` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency for TPV amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|AUD|CAD|CHF|CNY|INR|BRL — promote to reference product]',
    `measurement_end_date` DATE COMMENT 'Last day of the period over which actual TPV and transaction counts are measured.',
    `measurement_start_date` DATE COMMENT 'First day of the period over which actual TPV and transaction counts are measured.',
    `notes` STRING COMMENT 'Additional comments, special conditions, or remarks related to the volume commitment.',
    `overachievement_flag` BOOLEAN COMMENT 'True if actual TPV or transaction count exceeds the committed thresholds.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty charged to the partner for under‑performance relative to the committed volume.',
    `shortfall_flag` BOOLEAN COMMENT 'True if actual TPV or transaction count is below the committed thresholds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the volume commitment record.',
    `volume_commitment_status` STRING COMMENT 'Operational status of the volume commitment.. Valid values are `active|inactive|pending|terminated|suspended`',
    CONSTRAINT pk_volume_commitment PRIMARY KEY(`volume_commitment_id`)
) COMMENT 'Volume commitment records negotiated with partners — minimum annual TPV guarantees, transaction volume floors for preferential pricing, and volume-based incentive targets. Captures commitment period, committed TPV amount, committed transaction count, measurement currency, penalty for shortfall, incentive for overachievement, and actual-vs-committed tracking reference. Supports commercial negotiations and partner performance reviews.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` (
    `partner_settlement_account_id` BIGINT COMMENT 'System-generated unique identifier for the partner settlement account record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the partner that owns this settlement account.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for mapping each partner settlement transaction to a GL account for financial reporting and audit compliance.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Settlement accounts are linked to internal Nostro accounts for liquidity management of cross‑border flows.',
    `account_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code of the settlement account.. Valid values are `USD|EUR|GBP|JPY|CHF|AUD`',
    `account_holder_name` STRING COMMENT 'Legal name of the individual or entity that holds the settlement account.',
    `account_number` STRING COMMENT 'Local bank account number (PCI‑DSS protected).',
    `account_type` STRING COMMENT 'Classification of the settlement account for accounting and payout purposes.. Valid values are `checking|savings|current|settlement|escrow`',
    `bank_branch` STRING COMMENT 'Specific branch of the bank (if applicable) where the account is maintained.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the settlement account is held.',
    `bic_swift_code` STRING COMMENT 'SWIFT/BIC code identifying the bank for international transfers.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the settlement account with regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement account record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days the settlement account data must be retained to satisfy regulatory obligations.',
    `designated_use` STRING COMMENT 'Business purpose for which payouts are made to this account.. Valid values are `revenue_share|penalty|refund|incentive|commission`',
    `effective_end_date` DATE COMMENT 'Date when the settlement account is no longer valid for payouts (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the settlement account became effective for payouts.',
    `iban` STRING COMMENT 'Standardized international account identifier used for cross‑border payouts.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or risk audit performed on the account.',
    `partner_settlement_account_status` STRING COMMENT 'Current operational status of the settlement account.. Valid values are `active|inactive|suspended|closed|pending`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating assigned to the settlement account based on AML/KYC and fraud monitoring.',
    `routing_number` STRING COMMENT 'Domestic routing number used for ACH transfers in the United States.. Valid values are `^[0-9]{9}$`',
    `settlement_method` STRING COMMENT 'Preferred method for disbursing funds to the settlement account.. Valid values are `wire|ach|sepa|rtgs|swift`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement account record.',
    `verification_date` DATE COMMENT 'Date on which the settlement account was successfully verified.',
    `verification_status` STRING COMMENT 'Current status of the account verification process.. Valid values are `unverified|pending|verified|rejected`',
    CONSTRAINT pk_partner_settlement_account PRIMARY KEY(`partner_settlement_account_id`)
) COMMENT 'Bank account and settlement account details registered for partner payouts — revenue share disbursements, referral commissions, and incentive payments. Captures account holder name, bank name, account type, IBAN, BIC/SWIFT code, routing number (ACH), account currency, account verification status, verification date, and designated use (revenue share, penalty, refund). Distinct from merchant settlement accounts — these are partner-level financial accounts.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` (
    `partner_fee_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each partner fee schedule record.',
    `currency_id` BIGINT COMMENT 'Three‑letter ISO 4217 currency code for the fee amount.',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the partner to which this fee schedule applies.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Partner‑specific fee schedules reference the master FX fee schedule to calculate per‑transaction FX fees.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Enables posting of partner fee accruals to the general ledger, essential for fee revenue recognition and audit trails.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fee schedule changes are managed by a specific employee; linking enables change‑approval audit and compliance checks.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Fee schedules are defined per card scheme; linking enables accurate fee lookup and reporting per scheme.',
    `billing_frequency` STRING COMMENT 'How often the fee is billed to the partner.. Valid values are `per_transaction|monthly|quarterly|annually`',
    `compliance_approval_status` STRING COMMENT 'Regulatory compliance review outcome for the fee schedule.. Valid values are `approved|pending|rejected`',
    `compliance_review_date` DATE COMMENT 'Date when the compliance approval was performed.',
    `created_by_user` STRING COMMENT 'Identifier of the internal user who created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee schedule record was first created.',
    `effective_date` DATE COMMENT 'Date when the fee schedule becomes binding.',
    `expiration_date` DATE COMMENT 'Date when the fee schedule ends; null for open‑ended.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount for the fee (if applicable).',
    `fee_application_method` STRING COMMENT 'Mechanism by which the fee is applied to partner activity.. Valid values are `per_transaction|per_batch|flat`',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum fee amount that can be charged in a billing period.',
    `fee_minimum_amount` DECIMAL(18,2) COMMENT 'Minimum fee amount that will be charged in a billing period.',
    `fee_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to the fee base (e.g., 0.0250 for 2.5%).',
    `fee_type` STRING COMMENT 'Category of fee charged to the partner.. Valid values are `platform_access|transaction_processing|monthly_minimum|chargeback_handling|api_overage|compliance_program`',
    `is_recurring` BOOLEAN COMMENT 'True if the fee recurs on each billing cycle.',
    `last_modified_by_user` STRING COMMENT 'Identifier of the internal user who last modified the record.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the fee schedule.',
    `partner_fee_schedule_description` STRING COMMENT 'Free‑form description of the fee schedule purpose and scope.',
    `partner_fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule.. Valid values are `active|inactive|pending|terminated`',
    `regulatory_reference_code` STRING COMMENT 'Code linking the fee schedule to a specific regulatory requirement (e.g., PCI_DSS, PSD2).',
    `sla_commitment_days` STRING COMMENT 'Number of days partner is given to comply with fee schedule changes per SLA.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the fee is exempt from tax.',
    `tier_threshold_unit` STRING COMMENT 'Unit of measurement for the volume tier thresholds.. Valid values are `transactions|dollar_volume`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fee schedule record.',
    `version_number` STRING COMMENT 'Version of the fee schedule record for change management.',
    `volume_tier_max` BIGINT COMMENT 'Maximum transaction volume (count) for this tier; null if no upper bound.',
    `volume_tier_min` BIGINT COMMENT 'Minimum transaction volume (count) required for this tier.',
    CONSTRAINT pk_partner_fee_schedule PRIMARY KEY(`partner_fee_schedule_id`)
) COMMENT 'Fee schedule defining charges billed TO partners by Payments Fintech — platform access fees, per-transaction processing fees, monthly minimum fees, chargeback handling fees, API call overage fees, and compliance program fees. Captures fee type, fee amount or rate, billing frequency, effective date, expiration date, volume tier thresholds, and currency. Distinct from revenue_share_schedule which defines amounts paid OUT to partners.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each partner invoice record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Supports allocation of partner invoice amounts to internal cost centers for budgeting and cost analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Invoices must record the employee who generated them for internal accounting, dispute resolution, and audit trails.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for the invoice amounts.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner to whom the invoice is issued.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Necessary to post partner invoices to a GL account for revenue accounting and financial statement preparation.',
    `payment_rail_id` BIGINT COMMENT 'Method by which settlement to the partner is performed.',
    `reversal_invoice_id` BIGINT COMMENT 'Reference to the invoice that reverses this invoice, if applicable.',
    `ar_reference_number` STRING COMMENT 'Accounts Receivable reference number in Oracle Financials linked to this invoice.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by the invoice.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by the invoice.',
    `created_by_user` STRING COMMENT 'User identifier who created the invoice record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to the invoice, if any.',
    `due_date` DATE COMMENT 'Date by which payment for the invoice is due.',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert invoice currency to USD for reporting.',
    `external_invoice_number` STRING COMMENT 'Invoice number provided by the partner (if they issue a reciprocal invoice).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Sum of platform and processing fees included in the invoice.',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and issued to the partner.',
    `invoice_number` STRING COMMENT 'Business identifier assigned to the invoice by the Payments Fintech system.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. [ENUM-REF-CANDIDATE: draft|issued|paid|partial|overdue|voided|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Category of fee or charge represented by the invoice.. Valid values are `platform_fee|processing_charge|penalty|adjustment|rebate`',
    `is_credit_memo` BOOLEAN COMMENT 'Indicates whether this invoice is a credit memo (negative amount).',
    `last_modified_by_user` STRING COMMENT 'User identifier who last modified the invoice record.',
    `last_payment_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent payment applied to the invoice.',
    `line_item_count` STRING COMMENT 'Number of line items included in the invoice.',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Net amount payable after taxes, fees, penalties, and discounts.',
    `notes` STRING COMMENT 'Free-form notes or comments related to the invoice.',
    `payment_method` STRING COMMENT 'Method by which the partner is expected to settle the invoice. [ENUM-REF-CANDIDATE: credit_card|debit_card|bank_transfer|ach|wire|digital_wallet|crypto — 7 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current payment settlement status of the invoice.. Valid values are `unpaid|paid|partial|failed|refunded`',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the partner.. Valid values are `net_30|net_45|net_60|due_on_receipt|custom`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty or late fee amount assessed on the invoice, if any.',
    `settlement_currency` STRING COMMENT 'Currency used for settlement of the invoice with the partner.. Valid values are `[A-Z]{3}`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates if the invoice is exempt from tax.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross total amount billed on the invoice before any adjustments.',
    `total_quantity` STRING COMMENT 'Aggregate quantity of units across all line items (e.g., total transaction count).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    `vat_rate` DECIMAL(18,2) COMMENT 'Applicable VAT rate applied to the invoice, if tax is not exempt.',
    `void_reason` STRING COMMENT 'Reason provided for voiding the invoice.',
    `voided_flag` BOOLEAN COMMENT 'Indicates whether the invoice has been voided.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Invoices issued to partners for platform fees, processing charges, and penalty assessments — distinct from revenue share statements which represent outbound payments. Captures invoice number, billing period, invoice date, due date, line items (fee type, quantity, unit rate, amount), total amount due, currency, payment status, and Oracle Financials AR reference. Supports the ERP AR module integration for partner billing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_type` (
    `partner_type_id` BIGINT COMMENT 'Unique surrogate key for each partner type record.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three‑letter currency code used for settlements with this partner type.',
    `payment_rail_id` BIGINT COMMENT 'Preferred settlement method for transactions involving this partner type.',
    `aml_screening_required_flag` BOOLEAN COMMENT 'Indicates whether Anti‑Money‑Laundering screening is required for partners of this type.',
    `compliance_last_review_date` DATE COMMENT 'Date of the most recent compliance review for this partner type.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner type record was first created in the system.',
    `data_privacy_compliance_flag` BOOLEAN COMMENT 'True if the partner type is required to meet data‑privacy regulations (e.g., GDPR, CCPA).',
    `effective_from` DATE COMMENT 'Date when the partner type definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the partner type definition is retired or superseded (null if indefinite).',
    `fee_structure_type` STRING COMMENT 'Type of fee structure applied to this partner type.. Valid values are `percentage|flat|tiered`',
    `governing_body_standards` STRING COMMENT 'Applicable industry standards or regulatory frameworks governing this partner type (e.g., PCI DSS, EMVCo, PSD2, ISO 20022). [ENUM-REF-CANDIDATE: PCI_DSS|EMVCo|PSD2|ISO_20022|FATF|SOX|GDPR|CCPA — promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Indicates whether the partner type is currently in active use within the organization.',
    `kyc_required_flag` BOOLEAN COMMENT 'Indicates whether Know‑Your‑Customer verification is mandatory for partners of this type.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last compliance or governance review of this partner type.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum single transaction amount permitted for this partner type.',
    `max_transaction_volume` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction volume (in currency_code) allowed for this partner type per reporting period.',
    `network_role` STRING COMMENT 'Specific functional role(s) the partner plays in the payment network (e.g., acquiring, issuing, settlement, tokenization). [ENUM-REF-CANDIDATE: acquiring_bank|issuing_bank|card_scheme|psp|iso|payfac|aggregator|tsp|technology_partner|bnpl_provider|digital_wallet_provider|cross_border_specialist — promote to reference product]',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or operational notes about the partner type.',
    `partner_category` STRING COMMENT 'High‑level classification of the partner for regulatory and risk purposes.. Valid values are `bank|service_provider|technology|other`',
    `partner_type_description` STRING COMMENT 'Detailed description of the partner type, its role in the payments ecosystem, and typical services offered.',
    `revenue_share_model` STRING COMMENT 'Model used to calculate revenue share with partners of this type.. Valid values are `percentage|fixed|tiered|none`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the partner type based on regulatory and operational risk assessments.. Valid values are `low|medium|high`',
    `sla_commitment_days` STRING COMMENT 'Number of days within which service level agreements must be fulfilled for this partner type.',
    `surcharge_applicable_flag` BOOLEAN COMMENT 'True if transaction surcharges may be applied to this partner type under regulatory rules.',
    `type_code` STRING COMMENT 'Compact alphanumeric code used to reference the partner type in system integrations.',
    `type_name` STRING COMMENT 'Human‑readable name of the partner type (e.g., Acquiring Bank, Issuing Bank, PSP).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner type record.',
    CONSTRAINT pk_partner_type PRIMARY KEY(`partner_type_id`)
) COMMENT 'Reference classification of partner types in the payments ecosystem — Acquiring Bank, Issuing Bank, Card Scheme, PSP, ISO, PayFac, Aggregator, TSP, Technology Partner, BNPL Provider, Digital Wallet Provider, and Cross-Border Specialist. Captures type code, type name, regulatory classification, typical network roles, and applicable governing body standards. Used for partner segmentation, routing logic, and compliance rule application.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` (
    `integration_test_result_id` BIGINT COMMENT 'System-generated unique identifier for each integration test result record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Reference to the ecosystem partner being certified.',
    `integration_test_case_id` BIGINT COMMENT 'Unique identifier for the individual test case within the suite.',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the test satisfied all regulatory and compliance checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was first created in the system.',
    `execution_duration_seconds` STRING COMMENT 'Total time taken to execute the test case, measured in seconds.',
    `execution_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the test case was executed.',
    `failure_reason` STRING COMMENT 'Detailed explanation when the test result is a failure or block.',
    `is_automated` BOOLEAN COMMENT 'True if the test case was executed automatically without manual intervention.',
    `logs_uri` STRING COMMENT 'Location (URL or storage path) of detailed execution logs and artifacts.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or observations.',
    `result_status` STRING COMMENT 'Overall outcome of the test case execution.. Valid values are `passed|failed|blocked|skipped`',
    `risk_impact_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the risk impact of any failure observed.',
    `sign_off_flag` BOOLEAN COMMENT 'Indicates whether the test result has been formally signed off for go‑live.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Date‑time when the sign‑off was recorded.',
    `software_version` STRING COMMENT 'Version identifier of the partners software component being validated.',
    `test_case_actual_outcome` STRING COMMENT 'The observed result from the test execution.',
    `test_case_category` STRING COMMENT 'Broad functional area the test case belongs to.. Valid values are `api|iso8583|emv|3ds|settlement`',
    `test_case_created_timestamp` TIMESTAMP COMMENT 'When the test case was originally created in the test management system.',
    `test_case_description` STRING COMMENT 'Human‑readable description of the test case purpose and scope.',
    `test_case_expected_outcome` STRING COMMENT 'The anticipated result defined for the test case.',
    `test_case_last_modified_timestamp` TIMESTAMP COMMENT 'Most recent modification time of the test case definition.',
    `test_case_owner` STRING COMMENT 'Team or individual responsible for the test case definition.',
    `test_case_priority` STRING COMMENT 'Business priority assigned to the test case.. Valid values are `low|medium|high`',
    `test_case_result_code` STRING COMMENT 'Machine‑readable code representing the result outcome (e.g., ERR001, PASS).',
    `test_case_result_message` STRING COMMENT 'Human‑readable message accompanying the result code.',
    `test_data_set_identifier` STRING COMMENT 'Identifier of the data set used during the test (e.g., sample transaction file).',
    `test_environment` STRING COMMENT 'Environment in which the test was run (e.g., sandbox, staging, production).. Valid values are `sandbox|staging|production`',
    `test_suite_name` STRING COMMENT 'Name of the test suite that groups related test cases for partner integration certification.',
    `test_tool_name` STRING COMMENT 'Name of the testing framework or tool used to execute the test.',
    `test_tool_version` STRING COMMENT 'Version identifier of the testing framework or tool.',
    `tester_name` STRING COMMENT 'Name of the person or automated agent that performed the test.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test result record.',
    `validation_schema_version` STRING COMMENT 'Version of the schema or contract against which the test was validated.',
    CONSTRAINT pk_integration_test_result PRIMARY KEY(`integration_test_result_id`)
) COMMENT 'Results of partner integration certification testing — sandbox API testing, ISO 8583 message format validation, EMV chip transaction testing, 3DS authentication flow testing, and settlement file format validation. Captures test suite name, test case ID, test execution date, pass/fail result, failure reason, tester identity, environment, software version under test, and sign-off status. Required before partner go-live approval.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`performance_period` (
    `performance_period_id` BIGINT COMMENT 'Primary key uniquely identifying each partner performance snapshot for a measurement period.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the ecosystem partner whose performance is being recorded.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Partner performance reviews are performed by a designated employee; linking supports performance dashboards and compliance reporting.',
    `authorization_approval_rate` DECIMAL(18,2) COMMENT 'Percentage of transaction authorizations that were approved for the partner (approved / total attempts).',
    `chargeback_rate` DECIMAL(18,2) COMMENT 'Percentage of settled transactions that resulted in a chargeback during the period.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the partner with respect to regulatory and internal policies.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance record was first inserted.',
    `data_source_system` STRING COMMENT 'Name of the operational system that supplied the raw performance data (e.g., Transaction Processing Platform).',
    `fraud_rate` DECIMAL(18,2) COMMENT 'Percentage of transactions flagged as fraudulent for the partner in the period.',
    `measurement_period_end_date` DATE COMMENT 'Last calendar date of the reporting period (inclusive).',
    `measurement_period_start_date` DATE COMMENT 'First calendar date of the reporting period (inclusive).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the performance snapshot was generated.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the partners performance for the period.',
    `partner_tier` STRING COMMENT 'Current commercial tier classification of the partner based on volume and performance.. Valid values are `platinum|gold|silver|bronze`',
    `period_type` STRING COMMENT 'Granularity of the reporting period; either monthly or quarterly.. Valid values are `monthly|quarterly`',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk rating for the partner based on fraud, compliance, and operational metrics.',
    `settlement_timeliness_score` DECIMAL(18,2) COMMENT 'Score (0‑100) measuring how promptly the partners settlements were completed relative to SLA targets.',
    `sla_compliance_score` DECIMAL(18,2) COMMENT 'Composite score (0‑100) reflecting the partners adherence to agreed Service Level Agreement metrics for the period.',
    `total_tpv` DECIMAL(18,2) COMMENT 'Aggregate monetary volume of all transactions processed for the partner during the period, expressed in the settlement currency.',
    `transaction_count` BIGINT COMMENT 'Total number of individual payment transactions attributed to the partner in the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance record.',
    `volume_commitment_met_flag` BOOLEAN COMMENT 'Indicates whether the partner met its contractual transaction volume commitment for the period.',
    CONSTRAINT pk_performance_period PRIMARY KEY(`performance_period_id`)
) COMMENT 'Periodic partner performance measurement records — capturing a partners actual TPV, transaction count, authorization approval rate, chargeback rate, SLA compliance score, fraud rate, and settlement timeliness for a given measurement period (monthly or quarterly). Feeds partner tier reviews, volume commitment tracking, and commercial renegotiation triggers. Distinct from individual SLA breach events — this is the aggregated performance snapshot per period.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` (
    `sub_merchant_registration_id` BIGINT COMMENT 'System-generated unique identifier for the sub-merchant registration record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Sub‑merchant may have a default currency pair for DCC transactions; the pair drives conversion rates shown to cardholders.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the PayFac or aggregator partner sponsoring the sub‑merchant.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Sub‑merchant onboarding must record the card scheme under which the merchant will process transactions for compliance and settlement.',
    `active_status` STRING COMMENT 'Current operational status of the sub‑merchant registration.. Valid values are `active|inactive|suspended|closed`',
    `address_line1` STRING COMMENT 'Primary street address of the sub‑merchants registered location.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, floor, etc.).',
    `aml_screening_status` STRING COMMENT 'Result of the anti‑money‑laundering screening for the sub‑merchant.. Valid values are `passed|failed|pending`',
    `city` STRING COMMENT 'City of the sub‑merchants registered address.',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the sub‑merchant with regulatory and internal policies.. Valid values are `compliant|non_compliant|under_review`',
    `contract_effective_end` DATE COMMENT 'Date the contract expires or is scheduled to terminate.',
    `contract_effective_start` DATE COMMENT 'Date the contract became legally effective.',
    `contract_number` STRING COMMENT 'Reference number of the contractual agreement between the sub‑merchant and the sponsor partner.',
    `country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 country code of the registered address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration record was first created in the system.',
    `data_privacy_agreement_signed` BOOLEAN COMMENT 'True if the sub‑merchant has signed the data‑privacy agreement required for processing.',
    `dba_name` STRING COMMENT 'Trade name under which the sub-merchant operates.',
    `irf_rate` DECIMAL(18,2) COMMENT 'Interchange fee rate applicable to the sub‑merchants transactions.',
    `is_global_partner` BOOLEAN COMMENT 'Indicates whether the sponsor partner operates globally (true) or regionally (false).',
    `kyc_status` STRING COMMENT 'Current status of the Know‑Your‑Customer verification process.. Valid values are `pending|completed|failed`',
    `last_kyc_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent KYC review or re‑verification.',
    `legal_name` STRING COMMENT 'Full legal name of the sub-merchant entity.',
    `mcc_code` STRING COMMENT 'Four‑digit code that classifies the sub‑merchants business activity.',
    `mdr_rate` DECIMAL(18,2) COMMENT 'Standard fee rate charged to the sub‑merchant per transaction.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or comments about the registration.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registration_date` DATE COMMENT 'Date the sub‑merchant registration became effective.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue allocated to the sponsor partner.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) derived from fraud and AML assessments.',
    `sanctions_check_status` STRING COMMENT 'Outcome of sanctions list checks for the sub‑merchant.. Valid values are `cleared|blocked|pending`',
    `settlement_currency` STRING COMMENT 'Three‑letter ISO currency code used for settlement of the sub‑merchants funds.',
    `settlement_method` STRING COMMENT 'Mechanism used to settle funds to the sub‑merchant.. Valid values are `ACH|SWIFT|WIRE|LOCAL`',
    `sla_tier_code` STRING COMMENT 'Tier level of service‑level commitments agreed with the sponsor partner.. Valid values are `gold|silver|bronze|platinum`',
    `state_province` STRING COMMENT 'State or province component of the registered address.',
    `sub_mid` STRING COMMENT 'Merchant Identification Number assigned to the sub‑merchant within the PayFac ecosystem.',
    `termination_date` DATE COMMENT 'Date the sub‑merchant registration was terminated, if applicable.',
    `transaction_limit_tier` STRING COMMENT 'Tier defining the maximum transaction volume or amount the sub‑merchant is permitted.. Valid values are `low|medium|high|custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the registration record.',
    CONSTRAINT pk_sub_merchant_registration PRIMARY KEY(`sub_merchant_registration_id`)
) COMMENT 'Sub-merchant registration records managed by PayFac and aggregator partners on behalf of their sub-merchants. Captures sub-merchant legal name, DBA name, MCC, registered address, PayFac sponsor partner, assigned sub-MID, registration date, KYC verification status, transaction limit tier, and active status. Distinct from the merchant domains full merchant master — this is the partner-domain view of sub-merchant registrations owned by PayFac partners.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` (
    `manager_assignment_id` BIGINT COMMENT 'Primary key for the partner_manager_assignment association',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to the ecosystem partner',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee',
    `effective_end_date` DATE COMMENT 'Date when the employee stopped managing the partner (null if current)',
    `effective_start_date` DATE COMMENT 'Date when the employee started managing the partner',
    `manager_role` STRING COMMENT 'The role of the employee in managing the partner (e.g., Regional Manager, Product Specialist)',
    CONSTRAINT pk_manager_assignment PRIMARY KEY(`manager_assignment_id`)
) COMMENT 'This association product represents the assignment of account‑manager employees to ecosystem partners. It captures which employee manages which partner, the role of the employee in that relationship, and the effective period of the assignment.. Existence Justification: An ecosystem partner can be serviced by multiple account‑manager employees and an employee can manage multiple ecosystem partners. The business actively creates, updates, and deletes these assignments, tracking the manager role and the active period for each assignment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` (
    `rail_onboarding_id` BIGINT COMMENT 'Primary key for the partner_rail_onboarding association',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to ecosystem_partner',
    `payment_rail_id` BIGINT COMMENT 'Foreign key linking to payment_rail',
    `compliance_status` STRING COMMENT 'Compliance status of the partner for the specific payment rail',
    `onboarding_date` DATE COMMENT 'Date the partner was onboarded to the payment rail',
    CONSTRAINT pk_rail_onboarding PRIMARY KEY(`rail_onboarding_id`)
) COMMENT 'This association product represents the onboarding contract between an ecosystem partner and a payment rail. It captures the date a partner was onboarded to a rail and the compliance status of that partnership. Each record links one ecosystem_partner to one payment_rail with attributes that exist only in the context of this relationship.. Existence Justification: An ecosystem partner can be onboarded to multiple payment rails, and each payment rail serves many ecosystem partners. The onboarding process records an onboarding date and a compliance status for each partner‑rail pairing. This relationship is actively managed by the business as a distinct entity.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` (
    `integration_test_case_id` BIGINT COMMENT 'Primary key for integration_test_case',
    `depends_on_integration_test_case_id` BIGINT COMMENT 'Self-referencing FK on integration_test_case (depends_on_integration_test_case_id)',
    `associated_feature` STRING COMMENT 'Product or platform feature that this test case validates.',
    `compliance_requirement` STRING COMMENT 'Regulatory or standards requirement covered by the test case.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the test case record was first created.',
    `data_volume_mb` DECIMAL(18,2) COMMENT 'Typical size of request/response payloads in megabytes.',
    `deprecation_date` DATE COMMENT 'Date on which the test case becomes deprecated.',
    `documentation_url` STRING COMMENT 'Link to detailed documentation or runbook for the test case.',
    `execution_frequency` STRING COMMENT 'How often the test case is scheduled to run.',
    `expected_response_code` STRING COMMENT 'HTTP response code(s) expected from a successful execution. [ENUM-REF-CANDIDATE: 200|201|400|401|403|404|500 — promote to reference product]',
    `failure_reason` STRING COMMENT 'Root cause description when the last execution failed.',
    `http_method` STRING COMMENT 'HTTP verb used when invoking the API.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test case is executed automatically by CI/CD pipelines.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether failure of this test case is considered critical to operations.',
    `is_deprecated` BOOLEAN COMMENT 'Indicates whether the test case is marked for deprecation.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Date‑time when the test case was last executed.',
    `last_execution_status` STRING COMMENT 'Result of the most recent test execution.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of automatic retries on failure.',
    `notes` STRING COMMENT 'Additional free‑text notes or comments.',
    `notification_email` STRING COMMENT 'Email address to receive test execution alerts.',
    `notification_enabled` BOOLEAN COMMENT 'Flag indicating whether notifications are sent for this test case.',
    `owner` STRING COMMENT 'Team or individual responsible for maintaining the test case.',
    `priority` STRING COMMENT 'Business priority assigned to the test case.',
    `regression_impact` STRING COMMENT 'Potential impact on regression suites if this test case changes.',
    `related_api_endpoint` STRING COMMENT 'Full URL of the API endpoint exercised by the test case.',
    `request_payload_schema` STRING COMMENT 'Reference identifier for the JSON schema of the request payload.',
    `retry_interval_seconds` STRING COMMENT 'Delay between retry attempts.',
    `risk_level` STRING COMMENT 'Risk rating associated with test case failure.',
    `sla_actual_seconds` STRING COMMENT 'Observed execution time of the most recent run.',
    `sla_target_seconds` STRING COMMENT 'Maximum allowed execution time for the test case as defined in the service level agreement.',
    `integration_test_case_status` STRING COMMENT 'Current lifecycle status of the test case.',
    `tags` STRING COMMENT 'Free‑form tags for ad‑hoc categorisation.',
    `test_case_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the test case within the catalog.',
    `test_case_name` STRING COMMENT 'Human‑readable name of the integration test case.',
    `test_category` STRING COMMENT 'High‑level business domain the test case belongs to.',
    `test_duration_seconds` STRING COMMENT 'Typical execution time for the test case.',
    `test_environment` STRING COMMENT 'Target environment where the test case is executed.',
    `test_type` STRING COMMENT 'Category of test performed (e.g., functional, performance).',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the test case record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the test case record.',
    `version` STRING COMMENT 'Semantic version of the test case definition.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the test case record.',
    CONSTRAINT pk_integration_test_case PRIMARY KEY(`integration_test_case_id`)
) COMMENT 'Master reference table for integration_test_case. Referenced by test_case_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` (
    `remediation_plan_id` BIGINT COMMENT 'Primary key for remediation_plan',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the external partner, if applicable.',
    `follow_up_remediation_plan_id` BIGINT COMMENT 'Self-referencing FK on remediation_plan (follow_up_remediation_plan_id)',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual financial cost incurred for the remediation plan.',
    `approval_status` STRING COMMENT 'Current approval status of the remediation plan.',
    `approved_by` STRING COMMENT 'Name of the individual who approved the remediation plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation plan was approved.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes capturing audit trail information.',
    `completion_date` DATE COMMENT 'Date when the remediation plan was actually completed.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance requirements addressed by the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation plan record was first created in the system.',
    `currency` STRING COMMENT 'Three-letter ISO currency code for cost fields.',
    `due_date` DATE COMMENT 'Target date by which the remediation plan should be completed.',
    `effective_from` DATE COMMENT 'Date when the remediation plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the remediation plan expires or is scheduled to end.',
    `escalation_contact_email` STRING COMMENT 'Email address for escalation contact.',
    `escalation_contact_name` STRING COMMENT 'Name of the person to contact for escalations.',
    `escalation_contact_phone` STRING COMMENT 'Phone number for escalation contact.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected financial cost to execute the remediation plan.',
    `external_partner_name` STRING COMMENT 'Name of the external partner involved in the remediation plan, if any.',
    `is_external` BOOLEAN COMMENT 'Indicates whether the remediation plan involves external parties.',
    `issue_category` STRING COMMENT 'High-level category of the issue prompting the remediation plan.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the remediation plan.',
    `measurement_unit` STRING COMMENT 'Unit of the measurement value.',
    `measurement_value` DECIMAL(18,2) COMMENT 'Quantitative measurement associated with the success metric.',
    `owner_email` STRING COMMENT 'Email address of the plan owner.',
    `owner_name` STRING COMMENT 'Full name of the individual responsible for the remediation plan.',
    `owner_phone` STRING COMMENT 'Contact phone number for the plan owner.',
    `plan_code` STRING COMMENT 'Unique business code for the remediation plan.',
    `plan_name` STRING COMMENT 'Human readable name of the remediation plan.',
    `plan_type` STRING COMMENT 'Category of remediation plan based on the nature of the issue addressed.',
    `priority` STRING COMMENT 'Priority level assigned to the remediation plan.',
    `remediation_steps` STRING COMMENT 'Detailed description of the steps to be taken to remediate the issue.',
    `review_cycle` STRING COMMENT 'Frequency at which the remediation plan is reviewed.',
    `risk_level` STRING COMMENT 'Risk level associated with the issue addressed by the plan.',
    `sla_actual_hours` STRING COMMENT 'Actual number of hours taken to resolve the issue.',
    `sla_target_hours` STRING COMMENT 'Target number of hours to resolve the issue as per SLA.',
    `remediation_plan_status` STRING COMMENT 'Current lifecycle status of the remediation plan.',
    `success_metric` STRING COMMENT 'Key metric used to evaluate the success of the remediation plan.',
    `target_system` STRING COMMENT 'Name of the system or application that the remediation plan targets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the remediation plan record.',
    `version_number` STRING COMMENT 'Version number of the remediation plan document.',
    CONSTRAINT pk_remediation_plan PRIMARY KEY(`remediation_plan_id`)
) COMMENT 'Master reference table for remediation_plan. Referenced by remediation_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_parent_partner_ecosystem_partner_id` FOREIGN KEY (`parent_partner_ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_partner_type_id` FOREIGN KEY (`partner_type_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_type`(`partner_type_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ADD CONSTRAINT `fk_partner_partner_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ADD CONSTRAINT `fk_partner_partner_profile_partner_type_id` FOREIGN KEY (`partner_type_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_type`(`partner_type_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ADD CONSTRAINT `fk_partner_partner_profile_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ADD CONSTRAINT `fk_partner_onboarding_application_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ADD CONSTRAINT `fk_partner_onboarding_document_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ADD CONSTRAINT `fk_partner_partner_api_credential_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ADD CONSTRAINT `fk_partner_api_credential_rotation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ADD CONSTRAINT `fk_partner_revenue_share_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ADD CONSTRAINT `fk_partner_revenue_share_schedule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ADD CONSTRAINT `fk_partner_sla_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ADD CONSTRAINT `fk_partner_sla_commitment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ADD CONSTRAINT `fk_partner_sla_breach_event_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ADD CONSTRAINT `fk_partner_sla_breach_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `payments_fintech_ecm`.`partner`.`invoice`(`invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ADD CONSTRAINT `fk_partner_sla_breach_event_remediation_plan_id` FOREIGN KEY (`remediation_plan_id`) REFERENCES `payments_fintech_ecm`.`partner`.`remediation_plan`(`remediation_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ADD CONSTRAINT `fk_partner_sla_breach_event_sla_commitment_id` FOREIGN KEY (`sla_commitment_id`) REFERENCES `payments_fintech_ecm`.`partner`.`sla_commitment`(`sla_commitment_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ADD CONSTRAINT `fk_partner_referral_record_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ADD CONSTRAINT `fk_partner_network_participation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_primary_bin_sponsoring_bank_partner_ecosystem_partner_id` FOREIGN KEY (`primary_bin_sponsoring_bank_partner_ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ADD CONSTRAINT `fk_partner_partner_hierarchy_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ADD CONSTRAINT `fk_partner_partner_hierarchy_primary_ecosystem_partner_id` FOREIGN KEY (`primary_ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ADD CONSTRAINT `fk_partner_integration_endpoint_partner_api_credential_id` FOREIGN KEY (`partner_api_credential_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_api_credential`(`partner_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ADD CONSTRAINT `fk_partner_partner_certification_record_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ADD CONSTRAINT `fk_partner_partner_event_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ADD CONSTRAINT `fk_partner_partner_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ADD CONSTRAINT `fk_partner_partner_event_related_agreement_partner_agreement_id` FOREIGN KEY (`related_agreement_partner_agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ADD CONSTRAINT `fk_partner_partner_event_onboarding_application_id` FOREIGN KEY (`onboarding_application_id`) REFERENCES `payments_fintech_ecm`.`partner`.`onboarding_application`(`onboarding_application_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ADD CONSTRAINT `fk_partner_volume_commitment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ADD CONSTRAINT `fk_partner_partner_fee_schedule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ADD CONSTRAINT `fk_partner_invoice_reversal_invoice_id` FOREIGN KEY (`reversal_invoice_id`) REFERENCES `payments_fintech_ecm`.`partner`.`invoice`(`invoice_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ADD CONSTRAINT `fk_partner_integration_test_result_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ADD CONSTRAINT `fk_partner_integration_test_result_integration_test_case_id` FOREIGN KEY (`integration_test_case_id`) REFERENCES `payments_fintech_ecm`.`partner`.`integration_test_case`(`integration_test_case_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ADD CONSTRAINT `fk_partner_performance_period_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ADD CONSTRAINT `fk_partner_sub_merchant_registration_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ADD CONSTRAINT `fk_partner_manager_assignment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ADD CONSTRAINT `fk_partner_rail_onboarding_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` ADD CONSTRAINT `fk_partner_integration_test_case_depends_on_integration_test_case_id` FOREIGN KEY (`depends_on_integration_test_case_id`) REFERENCES `payments_fintech_ecm`.`partner`.`integration_test_case`(`integration_test_case_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ADD CONSTRAINT `fk_partner_remediation_plan_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ADD CONSTRAINT `fk_partner_remediation_plan_follow_up_remediation_plan_id` FOREIGN KEY (`follow_up_remediation_plan_id`) REFERENCES `payments_fintech_ecm`.`partner`.`remediation_plan`(`remediation_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`partner` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`partner` SET TAGS ('dbx_domain' = 'partner');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `parent_partner_ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `partner_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `api_integration_endpoint` SET TAGS ('dbx_business_glossary_term' = 'API Integration Endpoint');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `api_key_identifier` SET TAGS ('dbx_business_glossary_term' = 'API Key Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `api_key_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `compliance_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Contact Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_city` SET TAGS ('dbx_business_glossary_term' = 'Contact City');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_country` SET TAGS ('dbx_business_glossary_term' = 'Contact Country');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^[+]?d{1,3}?[- .]?d{1,14}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Postal Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_state` SET TAGS ('dbx_business_glossary_term' = 'Contact State/Province');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contact_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `data_privacy_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Agreement Signed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `fraud_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Monitoring Enabled');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `is_approved_for_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Approval Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `is_global_partner` SET TAGS ('dbx_business_glossary_term' = 'Global Partner Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `network_participation_flags` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Flags');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_value_regex' = 'prospecting|under_review|approved|active|deactivated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `pci_dss_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `pci_dss_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `primary_contact_role` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Role');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `primary_contact_role` SET TAGS ('dbx_value_regex' = 'account_manager|technical_lead|compliance_officer');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `registration_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Registration Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `registration_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `regulatory_license_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory License Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `regulatory_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `regulatory_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Model');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_value_regex' = 'percentage|fixed|tiered');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `sla_commitments` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitments');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Profile Identifier (PPID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_type_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Partner Contact Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `annual_tpv_tier` SET TAGS ('dbx_business_glossary_term' = 'Annual Total Payment Volume Tier (ATPV_TIER)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `annual_tpv_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|enterprise');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `api_capability_authentication` SET TAGS ('dbx_business_glossary_term' = 'API Authentication Capability (API_AUTH)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `api_capability_settlement` SET TAGS ('dbx_business_glossary_term' = 'API Settlement Capability (API_SET)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `api_capability_tokenization` SET TAGS ('dbx_business_glossary_term' = 'API Tokenization Capability (API_TOK)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `business_description` SET TAGS ('dbx_business_glossary_term' = 'Partner Business Description (PBD)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CSTAT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `contract_effective_end` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date (CEND)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `contract_effective_start` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date (CSTART)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CN)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `contract_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `data_privacy_compliance` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Compliance Frameworks (DPC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `data_privacy_compliance` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|PCI_DSS|SOX|FATF|NONE');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (DRP_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `dispute_resolution_contact` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Contact Name (DRCN)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `dispute_resolution_email` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Email (DRE)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `dispute_resolution_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `dispute_resolution_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `dispute_resolution_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Footprint (GF)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1 (HAL1)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2 (HAL2)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City (HC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code (HCC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State/Province (HS)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (ACTIVE)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status (KYCSTAT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `last_risk_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Review Timestamp (LRRT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Notes (PNOTES)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Onboarding Date (PONB)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Legal Name (PLN)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status (PS)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier (PTIER)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|platinum');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `revenue_sharing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Percentage (RSP)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `revenue_sharing_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Score (PRS)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `service_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Fee Percentage (SFP)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `service_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `service_fee_percentage` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `sla_commitment_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Days (SLA_D)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies (SC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `supported_payment_rails` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Rails (SPR)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Termination Date (PTERM)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Partner Website URL (PWEB)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'acquiring|iso|payfac|tsp|technology|network');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `amendment_version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `data_retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Years)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `irf_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Partnership Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `kyc_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'KYC Completed Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `max_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `mdr_rate` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed|tiered');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `settlement_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle (Days)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address (PII)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Full Name (PII)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `sla_tier_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `sla_tier_code` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|standard');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `onboarding_application_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Application ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `assigned_analyst_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Result');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_value_regex' = 'clear|potential_match|blocked');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `api_credentials_provided` SET TAGS ('dbx_business_glossary_term' = 'API Credentials Provided');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Email');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `applicant_legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Legal Entity Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn|on_hold');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `due_diligence_score` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go‑Live Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `integration_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Integration Assessment Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Completion Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `last_status_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'acquiring_bank|issuing_bank|psp|payfac|aggregator|technology_partner');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `pci_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'PCI Attestation Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `pci_dss_attestation_status` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Attestation Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `pci_dss_attestation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `regulatory_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Screening Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `regulatory_screening_status` SET TAGS ('dbx_value_regex' = 'passed|failed|exempt');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Model');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_value_regex' = 'fixed|percentage|tiered');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `risk_assessment_status` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `sanction_check_status` SET TAGS ('dbx_value_regex' = 'clear|matched|blocked');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `sla_commitment_level` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Level');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `sla_commitment_level` SET TAGS ('dbx_value_regex' = 'standard|premium|enterprise');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `onboarding_document_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Document ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA-256 Checksum of Document');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (e.g., Incorporation Certificate, PCI DSS Certificate, AML Policy, Network Membership, Bank Account Verification, Regulatory License)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'incorporation_certificate|pci_dss_certificate|aml_policy|network_membership|bank_account_verification|regulatory_license');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|png|jpg');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document File Size in Bytes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Document Indicator');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `is_original` SET TAGS ('dbx_business_glossary_term' = 'Original Document Indicator');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `onboarding_document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `onboarding_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Verification Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `onboarding_document_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|approved|rejected|expired|revoked');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Policy');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `retention_policy` SET TAGS ('dbx_value_regex' = 'retain_7_years|retain_5_years|retain_indefinite');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path (URI)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Document Submission Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Document Verification Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `verifying_analyst` SET TAGS ('dbx_business_glossary_term' = 'Verifying Analyst Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `verifying_analyst` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_document` ALTER COLUMN `verifying_analyst` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `partner_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Partner API Credential ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'api_key|oauth2_client|mtls_certificate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `credential_value` SET TAGS ('dbx_business_glossary_term' = 'Credential Value');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `credential_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `credential_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'sandbox|production');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `ip_allowlist` SET TAGS ('dbx_business_glossary_term' = 'IP Allowlist');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `last_rotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Rotation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `partner_api_credential_description` SET TAGS ('dbx_business_glossary_term' = 'Credential Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `partner_api_credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `partner_api_credential_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `permission_scopes` SET TAGS ('dbx_business_glossary_term' = 'Permission Scopes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Tier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'not_revoked|revoked|pending_revocation');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'SDK Version');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `usage_quota` SET TAGS ('dbx_business_glossary_term' = 'Usage Quota');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `usage_reset_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Reset Frequency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `usage_reset_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `api_credential_rotation_id` SET TAGS ('dbx_business_glossary_term' = 'API Credential Rotation ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `credential_scope` SET TAGS ('dbx_business_glossary_term' = 'Credential Scope');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'api_key|oauth_token|certificate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Rotation Error Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `new_credential_hash` SET TAGS ('dbx_business_glossary_term' = 'New Credential Hash');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `new_credential_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `new_credential_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'New Credential Issued Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rotation Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `old_credential_hash` SET TAGS ('dbx_business_glossary_term' = 'Old Credential Hash');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `old_credential_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `partner_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Acknowledgment Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `partner_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|rejected');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rollback_window_expiry` SET TAGS ('dbx_business_glossary_term' = 'Rollback Window Expiry');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rotating_actor` SET TAGS ('dbx_business_glossary_term' = 'Rotating Actor');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rotation_reason` SET TAGS ('dbx_business_glossary_term' = 'Credential Rotation Reason');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rotation_success_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotation Success Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credential Rotation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rotation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Credential Rotation Trigger');
ALTER TABLE `payments_fintech_ecm`.`partner`.`api_credential_rotation` ALTER COLUMN `rotation_trigger` SET TAGS ('dbx_value_regex' = 'scheduled|security_incident|manual_request');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `revenue_share_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `bonus_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Bonus Structure Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `incentive_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `irf_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `mdr_split_percent` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate Split Percentage');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `msf_tier` SET TAGS ('dbx_business_glossary_term' = 'Merchant Service Fee Tier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `residual_income_rate` SET TAGS ('dbx_business_glossary_term' = 'Residual Income Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'irf|mdr|msf|bonus|incentive');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `tier_logic_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Logic Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Threshold');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `revenue_share_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Statement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `gross_interchange_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Interchange Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `irf_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee (IRF) Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `mdr_amount` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR) Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `partner_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Share Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|failed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `revenue_share_statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `revenue_share_statement_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|paid|rejected');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Generation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Statement Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `statement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `statement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `total_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payable Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `breach_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `last_measured_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency Unit');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_frequency_unit` SET TAGS ('dbx_value_regex' = 'day|hour|minute');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_window` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_window_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Unit');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `measurement_window_unit` SET TAGS ('dbx_value_regex' = 'day|hour|minute');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `reporting_frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency Unit');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `reporting_frequency_unit` SET TAGS ('dbx_value_regex' = 'day|hour|minute');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `reporting_method` SET TAGS ('dbx_business_glossary_term' = 'Reporting Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `sla_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `sla_commitment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'uptime|auth_response_time|settlement_cutoff|dispute_turnaround|api_availability|support_response');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `target_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Unit');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `target_unit` SET TAGS ('dbx_value_regex' = 'percent|seconds|transactions|ms|minutes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `sla_breach_event_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Event ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Invoice Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `remediation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Commitment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Measured Value');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `breach_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|escalated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Detection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CHF|CAD');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'automated|manual|monitoring_tool');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|level1|level2|level3');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `financial_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `partner_notified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Partner Notification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `penalty_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Triggered Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Recorded By System/User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'technical|operational|vendor|process|external');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `sla_metric` SET TAGS ('dbx_business_glossary_term' = 'SLA Metric (Metric) Breached');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `sla_metric` SET TAGS ('dbx_value_regex' = 'transaction_processing_time|authorization_time|settlement_time|availability|throughput');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|settlement|crm|erp|fraud_platform');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target SLA Value');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_breach_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_record_id` SET TAGS ('dbx_business_glossary_term' = 'Referral Record ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `primary_referral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `primary_referral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `primary_referral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Referred Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|reviewed|flagged');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `converted_mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `fee_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `is_test_referral` SET TAGS ('dbx_business_glossary_term' = 'Test Referral Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Referral Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Campaign Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_channel` SET TAGS ('dbx_business_glossary_term' = 'Referral Channel');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|sales|partner_portal|api');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Referral Fee Currency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Referral Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_record_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_record_status` SET TAGS ('dbx_value_regex' = 'pending|converted|rejected|withdrawn');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_region` SET TAGS ('dbx_business_glossary_term' = 'Referral Region');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_type` SET TAGS ('dbx_business_glossary_term' = 'Referral Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `referral_type` SET TAGS ('dbx_value_regex' = 'iso|payfac|agent|other');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`partner`.`referral_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Identifier (Network Participation ID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (Partner ID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End (BIN End)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start (BIN Start)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Authority (CA)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Effective Date (CED)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `certification_expiry` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date (CED Expiry)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (CT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'full|provisional|revoked');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `iin_range_end` SET TAGS ('dbx_business_glossary_term' = 'IIN Range End (IIN End)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `iin_range_start` SET TAGS ('dbx_business_glossary_term' = 'IIN Range Start (IIN Start)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `is_primary_network` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Flag (Primary Network)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp (LAT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_member_code` SET TAGS ('dbx_business_glossary_term' = 'Network Assigned Member Identifier (NAMI)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_member_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_member_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Name (Network Name)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status (NPS)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (Notes)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `participation_code` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Code (NPC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Role (NPR)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `participation_role` SET TAGS ('dbx_value_regex' = 'acquirer|issuer|processor|sponsor');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage (RSP)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Risk Score)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `sla_commitment` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement Commitment (SLA Commitment)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `sla_commitment` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|standard');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (Termination Reason)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'BIN Sponsorship ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsored Entity ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `primary_bin_sponsoring_bank_partner_ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Bank Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `agreement_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_sponsorship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|JCB|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `compliance_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `compliance_attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `compliance_attestation_status` SET TAGS ('dbx_value_regex' = 'attested|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Email');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `revenue_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `revenue_share_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sla_commitment` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sla_commitment` SET TAGS ('dbx_value_regex' = 'standard|premium|custom');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sla_commitment_details` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Details');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sponsorship_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `sponsorship_type` SET TAGS ('dbx_value_regex' = 'exclusive|non-exclusive|partial');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Contact Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Email Address (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_contacted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Contacted Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `partner_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `partner_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|sms|messenger|portal');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type (Partner Contact)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'primary|technical|compliance|finance|executive|support');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `partner_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Hierarchy ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Child Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `primary_ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `depth` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Depth Level');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type (Ownership, Sponsorship, Referral, etc.)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'ownership|sponsorship|referral|subsidiary|affiliate|jointventure');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_hierarchy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `integration_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `partner_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Authentication Credential ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'API_KEY|OAUTH2|CERTIFICATE|BASIC');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `change_log` SET TAGS ('dbx_business_glossary_term' = 'Change Log');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'AES256|RSA|NONE');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint URL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'sandbox|production|test');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `error_handling_policy` SET TAGS ('dbx_business_glossary_term' = 'Error Handling Policy');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `error_handling_policy` SET TAGS ('dbx_value_regex' = 'ignore|retry|alert');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_business_glossary_term' = 'Health‑Check URL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `health_check_url` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `integration_endpoint_description` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `integration_endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `integration_endpoint_status` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `integration_endpoint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|maintenance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Endpoint IP Address');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `last_test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Test Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `max_retries` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retries');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `message_format` SET TAGS ('dbx_business_glossary_term' = 'Message Format');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `message_format` SET TAGS ('dbx_value_regex' = 'JSON|XML|ISO8583|ISO20022|CSV');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Enabled');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `monitoring_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Endpoint');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `network_zone` SET TAGS ('dbx_value_regex' = 'DMZ|INTERNAL|EXTERNAL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `payload_encryption` SET TAGS ('dbx_business_glossary_term' = 'Payload Encryption Enabled');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `port` SET TAGS ('dbx_business_glossary_term' = 'Network Port');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Protocol Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'REST|SOAP|ISO8583|ISO20022|SFTP|WEBHOOK');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `rate_limit_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit (Per Minute)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'exponential|fixed|none');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Percentage');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `supported_operations` SET TAGS ('dbx_business_glossary_term' = 'Supported Operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `supported_operations` SET TAGS ('dbx_value_regex' = 'request|response|both');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'success|failure');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `tls_version` SET TAGS ('dbx_business_glossary_term' = 'TLS Version');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `tls_version` SET TAGS ('dbx_value_regex' = 'TLS1.2|TLS1.3');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Version');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `partner_certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Certification Record ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `certification_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certification Document URL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Compliance Level');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `compliance_level` SET TAGS ('dbx_value_regex' = 'level1|level2|level3|level4');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `compliance_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `document_hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Expiration Reason');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `is_current` SET TAGS ('dbx_business_glossary_term' = 'Is Current Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `issuing_body` SET TAGS ('dbx_value_regex' = 'PCI_SSC|EMVCo|Visa|Mastercard|FinCEN|Other');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `next_assessment_due` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `partner_certification_record_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `partner_certification_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `remediation_details` SET TAGS ('dbx_business_glossary_term' = 'Remediation Details');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_certification_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `partner_event_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Event ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `actor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Actor ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Actor ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Related Agreement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `related_agreement_partner_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Related Agreement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `onboarding_application_id` SET TAGS ('dbx_business_glossary_term' = 'Related Application ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'system|user');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'regulatory|contractual|operational|risk|customer_request|system_error');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source Module');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'status_change|agreement_amendment|ownership_change|regulatory_notification|network_membership_change|escalation');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `new_state` SET TAGS ('dbx_business_glossary_term' = 'New State');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `new_state` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|draft|closed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_business_glossary_term' = 'Previous State');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `previous_state` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|draft|closed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `volume_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `actual_tpv_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual TPV Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `actual_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `commitment_number` SET TAGS ('dbx_business_glossary_term' = 'Commitment Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_business_glossary_term' = 'Commitment Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `commitment_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|one_time');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `committed_tpv_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed TPV Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `committed_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Committed Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `measurement_currency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Currency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `measurement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `measurement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Commitment Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `overachievement_flag` SET TAGS ('dbx_business_glossary_term' = 'Overachievement Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `shortfall_flag` SET TAGS ('dbx_business_glossary_term' = 'Shortfall Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `volume_commitment_status` SET TAGS ('dbx_business_glossary_term' = 'Commitment Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`volume_commitment` ALTER COLUMN `volume_commitment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_business_glossary_term' = 'Account Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CHF|AUD');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Full Name (AHFN)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (BAN)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Type (SAT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|current|settlement|escrow');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `bank_branch` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code / SWIFT Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `bic_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `designated_use` SET TAGS ('dbx_business_glossary_term' = 'Designated Use of Settlement Account');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `designated_use` SET TAGS ('dbx_value_regex' = 'revenue_share|penalty|refund|incentive|commission');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `partner_settlement_account_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `partner_settlement_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account Risk Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'ACH Routing Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'wire|ach|sepa|rtgs|swift');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Account Verification Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Account Verification Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|rejected');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `partner_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Fee Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Owner Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency (BF)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_transaction|monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXD)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount (FA)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_application_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Application Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_application_method` SET TAGS ('dbx_value_regex' = 'per_transaction|per_batch|flat');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate (FR)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type (FT)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'platform_access|transaction_processing|monthly_minimum|chargeback_handling|api_overage|compliance_program');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `partner_fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `partner_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `partner_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `regulatory_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `sla_commitment_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Days');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `tier_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Tier Threshold Unit (TTU)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `tier_threshold_unit` SET TAGS ('dbx_value_regex' = 'transactions|dollar_volume');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `volume_tier_max` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Maximum (VTX)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_fee_schedule` ALTER COLUMN `volume_tier_min` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier Minimum (VTM)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Invoice ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `reversal_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Invoice ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `ar_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Reference Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to USD');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `external_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'External Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'platform_fee|processing_charge|penalty|adjustment|rebate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `is_credit_memo` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `last_payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|failed|refunded');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt|custom');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `vat_rate` SET TAGS ('dbx_business_glossary_term' = 'VAT Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `payments_fintech_ecm`.`partner`.`invoice` ALTER COLUMN `voided_flag` SET TAGS ('dbx_business_glossary_term' = 'Voided Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `partner_type_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `aml_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Required Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `compliance_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `data_privacy_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `fee_structure_type` SET TAGS ('dbx_value_regex' = 'percentage|flat|tiered');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `governing_body_standards` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Standards');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `kyc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'KYC Required Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `max_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `network_role` SET TAGS ('dbx_business_glossary_term' = 'Network Role');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `partner_category` SET TAGS ('dbx_business_glossary_term' = 'Partner Category');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `partner_category` SET TAGS ('dbx_value_regex' = 'bank|service_provider|technology|other');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `partner_type_description` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Model');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_value_regex' = 'percentage|fixed|tiered|none');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `sla_commitment_days` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Days');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `surcharge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicable Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `integration_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Test Result ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `integration_test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `execution_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Test Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `logs_uri` SET TAGS ('dbx_business_glossary_term' = 'Logs URI');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Test Result Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'passed|failed|blocked|skipped');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `risk_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `sign_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Sign‑Off Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign‑Off Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version Under Test');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_actual_outcome` SET TAGS ('dbx_business_glossary_term' = 'Actual Outcome');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_category` SET TAGS ('dbx_business_glossary_term' = 'Test Case Category');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_category` SET TAGS ('dbx_value_regex' = 'api|iso8583|emv|3ds|settlement');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Case Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_description` SET TAGS ('dbx_business_glossary_term' = 'Test Case Description');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_expected_outcome` SET TAGS ('dbx_business_glossary_term' = 'Expected Outcome');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Case Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_owner` SET TAGS ('dbx_business_glossary_term' = 'Test Case Owner');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Case Priority');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_result_code` SET TAGS ('dbx_business_glossary_term' = 'Test Result Code');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_case_result_message` SET TAGS ('dbx_business_glossary_term' = 'Test Result Message');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_data_set_identifier` SET TAGS ('dbx_business_glossary_term' = 'Test Data Set Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'sandbox|staging|production');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_suite_name` SET TAGS ('dbx_business_glossary_term' = 'Test Suite Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Test Tool Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `test_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Test Tool Version');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `tester_name` SET TAGS ('dbx_business_glossary_term' = 'Tester Name');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_result` ALTER COLUMN `validation_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Validation Schema Version');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Period ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `authorization_approval_rate` SET TAGS ('dbx_business_glossary_term' = 'Authorization Approval Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `chargeback_rate` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `fraud_rate` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rate');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `partner_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Tier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `partner_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `settlement_timeliness_score` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timeliness Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `sla_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance Score');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `total_tpv` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Payment Volume (TPV)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`performance_period` ALTER COLUMN `volume_commitment_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Met Flag');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `sub_merchant_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Merchant Registration ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Partner ID (Sponsor Partner ID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status (Active Status)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Address Line 1)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Address Line 2)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Status (AML Status)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `contract_effective_end` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date (Contract Effective End)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `contract_effective_start` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date (Contract Effective Start)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (Contract Number)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (Country Code)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `data_privacy_agreement_signed` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Agreement Signed Flag (Data Privacy Agreement Signed)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (DBA Name)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `irf_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Reimbursement Fee Rate (IRF)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `is_global_partner` SET TAGS ('dbx_business_glossary_term' = 'Is Global Partner Flag (Is Global Partner)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status (KYC Status)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `last_kyc_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last KYC Review Timestamp (Last KYC Review Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name (Legal Name)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `mdr_rate` SET TAGS ('dbx_business_glossary_term' = 'Merchant Discount Rate (MDR)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Notes)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (Postal Code)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date (Registration Date)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage (Revenue Share %)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (Risk Score)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `sanctions_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Status (Sanctions Status)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `sanctions_check_status` SET TAGS ('dbx_value_regex' = 'cleared|blocked|pending');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency (Settlement Currency)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method (Settlement Method)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'ACH|SWIFT|WIRE|LOCAL');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `sla_tier_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Tier Code (SLA Tier)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `sla_tier_code` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze|platinum');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (State/Province)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `sub_mid` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Merchant Identifier (Sub‑MID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `transaction_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Tier (Transaction Limit Tier)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `transaction_limit_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|custom');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sub_merchant_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` SET TAGS ('dbx_association_edges' = 'partner.ecosystem_partner,workforce.employee');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `manager_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Manager Assignment - Partner Manager Assignment Id');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Manager Assignment - Ecosystem Partner Id');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Manager Assignment - Employee Id');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_temporal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `manager_role` SET TAGS ('dbx_business_glossary_term' = 'Manager Role');
ALTER TABLE `payments_fintech_ecm`.`partner`.`manager_assignment` ALTER COLUMN `manager_role` SET TAGS ('dbx_role' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` SET TAGS ('dbx_association_edges' = 'partner.ecosystem_partner,reference.payment_rail');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ALTER COLUMN `rail_onboarding_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Rail Onboarding - Partner Rail Onboarding Id');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Rail Onboarding - Ecosystem Partner Id');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ALTER COLUMN `payment_rail_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Rail Onboarding - Payment Rail Id');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Rail Onboarding - Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`rail_onboarding` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Rail Onboarding - Onboarding Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` SET TAGS ('dbx_subdomain' = 'integration_services');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` ALTER COLUMN `integration_test_case_id` SET TAGS ('dbx_business_glossary_term' = 'Integration Test Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` ALTER COLUMN `depends_on_integration_test_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` ALTER COLUMN `notification_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_test_case` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `remediation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `follow_up_remediation_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`remediation_plan` ALTER COLUMN `owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
