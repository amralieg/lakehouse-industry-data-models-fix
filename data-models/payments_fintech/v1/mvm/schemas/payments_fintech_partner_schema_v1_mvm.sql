-- Schema for Domain: partner | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`partner` COMMENT 'Master data for ecosystem partners — acquiring banks, issuing banks, card schemes, PSPs, ISOs, PayFacs, aggregators, TSPs, and technology partners. Owns partner onboarding, agreements, API integration credentials, revenue sharing, SLA commitments, referral tracking, and network participation records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` (
    `ecosystem_partner_id` BIGINT COMMENT 'Unique surrogate identifier for the ecosystem partner.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Facilitates internal cost allocation of partner‑related expenses to a cost center for budgeting and performance tracking.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Partner defines a default currency pair for all cross‑border payments, needed for routing, DCC offers and regulatory reporting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Maps each partner to its legal entity for regulatory reporting, KYC/AML compliance, and consolidated financial statements.',
    `parent_partner_ecosystem_partner_id` BIGINT COMMENT 'Identifier of the parent partner in hierarchical relationships, if applicable.',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Every partner must be tracked as a party for AML/KYC compliance, sanctions screening, and regulatory reporting. Fintech regulations require legal entity records for all business partners. This is foun',
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
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Partner profiles represent business entities requiring party records for consolidated compliance tracking, KYC status monitoring, and risk scoring. Real-world fintech operations maintain party records',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Partner agreements allocate costs to specific cost centers for internal budget tracking, variance analysis, and departmental P&L reporting. Standard practice in fintech finance operations for cost all',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Partner agreements must specify the default currency pair for cross-border settlements and FX conversions. Critical for multi-currency contract execution, settlement processing, and revenue share calc',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the ecosystem partner associated with this agreement.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Agreements often embed an FX fee schedule governing cross‑border fees; required for invoicing and compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Links revenue‑share agreements to a GL account for accurate revenue recognition and compliance reporting.',
    `partner_contact_id` BIGINT COMMENT 'FK to partner.partner_contact',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Partnership agreements must satisfy specific regulatory obligations (PCI-DSS compliance, data privacy laws, AML requirements). Contract management systems track which regulations each agreement addres',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Partner agreements reference consolidated risk assessments (risk_rating, aml_screening_status, kyc_completed_flag attributes present). Link to risk_profile provides authoritative risk tier, compliance',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: The onboarding application lifecycle culminates in the execution of a formal agreement. Linking onboarding_application to the resulting agreement.agreement_id captures the causal chain from applicatio',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Onboarding application belongs to a partner; adding partner_id FK links the application to its ecosystem partner and resolves the silo.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` (
    `partner_api_credential_id` BIGINT COMMENT 'Unique identifier for the partner API credential.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner to which the credential is issued.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` (
    `revenue_share_schedule_id` BIGINT COMMENT 'Unique surrogate key for the revenue share schedule record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Revenue share schedules must align with accounting periods for proper revenue recognition timing, period-end close processes, and ensuring revenue is recognized in the correct financial reporting peri',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Revenue share statements must be assigned to accounting periods for period-end close, GL reconciliation, and financial reporting. Essential for ensuring partner revenue/expense is recorded in correct ',
    `agreement_id` BIGINT COMMENT 'Identifier of the revenue‑share agreement governing the calculation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Revenue share statements require cost center attribution for departmental P&L allocation, budget vs actual analysis, and management accounting. Essential for internal financial reporting and cost cent',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the ecosystem partner (acquiring bank, PSP, etc.) to whom the statement applies.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Allows posting of revenue‑share statements to the general ledger, required for financial consolidation and audit.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Each revenue share statement generates a corresponding journal entry for GL posting. Critical for audit trail, reconciliation between subledger and GL, and ensuring revenue share accounting is properl',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: Revenue share statements calculate partner payouts based on specific MDR configurations and pricing tiers. Direct link required for accurate revenue allocation, reconciliation, and partner payout calc',
    `partner_settlement_account_id` BIGINT COMMENT 'Foreign key linking to partner.partner_settlement_account. Business justification: A revenue share statement culminates in a disbursement to a specific partner settlement account. The statement carries payment_status, payment_due_date, and total_payable_amount — all of which are ope',
    `revenue_share_schedule_id` BIGINT COMMENT 'Foreign key linking to partner.revenue_share_schedule. Business justification: A revenue_share_statement is the periodic calculated output produced by executing a revenue_share_schedule. Linking the statement directly to the schedule that drove its calculation is essential for t',
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
    `partner_contact_id` BIGINT COMMENT 'Foreign key linking to partner.partner_contact. Business justification: sla_commitment carries three denormalized escalation contact fields (escalation_contact_email, escalation_contact_name, escalation_contact_phone) that duplicate data already managed in partner_contact',
    `breach_count` STRING COMMENT 'Cumulative number of times the SLA has been breached.',
    `breach_last_date` DATE COMMENT 'Date of the most recent SLA breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA commitment record was created.',
    `effective_end_date` DATE COMMENT 'Date on which the SLA commitment expires or is terminated (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the SLA commitment becomes effective.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`network_participation` (
    `network_participation_id` BIGINT COMMENT 'System-generated unique identifier for each network participation record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Unique identifier of the ecosystem partner (acquirer, issuer, PSP, etc.) associated with this network participation.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Partner network participation is always tied to a specific payment scheme (Visa, Mastercard, etc.). Scheme-level compliance reporting, certification management, and interchange calculations require a ',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: BIN sponsorship arrangements are governed by a contractual agreement between the sponsoring bank partner and Payments Fintech. The bin_sponsorship table currently carries an agreement_reference STRING',
    `partner_contact_id` BIGINT COMMENT 'Foreign key linking to partner.partner_contact. Business justification: bin_sponsorship carries partner_contact_email and partner_contact_phone as denormalized STRING fields representing the contact person for the BIN sponsorship arrangement. These duplicate data managed ',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the acquiring/issuing bank sponsoring the BIN range.',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: BIN sponsorship arrangements tie to specific interchange programs (commercial card, prepaid, debit programs). Direct link needed for program eligibility verification, compliance attestation, and regul',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: BIN sponsorships are heavily regulated activities requiring specific licenses and card scheme compliance. Each sponsorship must map to regulatory obligations for audit, license verification, and compl',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: BIN sponsorships carry significant regulatory and financial risk (risk_rating attribute present). Link to risk_profile provides BIN-level risk assessment, exposure limits, and compliance status essent',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: BIN sponsorship is governed by a specific card scheme (Visa, Mastercard, UnionPay). Scheme rules determine BIN range validity, compliance attestation requirements, and interchange applicability. The c',
    `bin_range_end` STRING COMMENT 'Ending BIN/IIN number of the sponsored range.. Valid values are `^[0-9]{6,8}$`',
    `bin_range_start` STRING COMMENT 'Starting BIN/IIN number of the sponsored range.. Valid values are `^[0-9]{6,8}$`',
    `bin_sponsorship_status` STRING COMMENT 'Current lifecycle status of the sponsorship.. Valid values are `active|inactive|suspended|pending|terminated`',
    `compliance_attestation_date` DATE COMMENT 'Date when compliance attestation was completed.',
    `compliance_attestation_status` STRING COMMENT 'Status of compliance attestation for the sponsorship.. Valid values are `attested|pending|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sponsorship record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values in the sponsorship.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when sponsorship becomes effective.',
    `expiration_date` DATE COMMENT 'Date when sponsorship ends, if applicable.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or performance review.',
    `notes` STRING COMMENT 'Free-form notes related to the sponsorship.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` (
    `partner_settlement_account_id` BIGINT COMMENT 'System-generated unique identifier for the partner settlement account record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: A partner settlement account is designated for specific disbursement purposes tied to an agreement — revenue share payouts, interchange settlements, and fee disbursements are all agreement-governed. L',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to fx.correspondent_bank. Business justification: Partner settlement accounts are held at correspondent banks for cross-border payment routing and currency settlement. Core banking relationship required for SWIFT transfers, regulatory compliance, and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Settlement accounts are tied to cost centers for treasury budget tracking, cash flow forecasting by department, and cost center-level liquidity management. Standard treasury and financial planning pra',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ADD CONSTRAINT `fk_partner_ecosystem_partner_parent_partner_ecosystem_partner_id` FOREIGN KEY (`parent_partner_ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ADD CONSTRAINT `fk_partner_partner_profile_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ADD CONSTRAINT `fk_partner_partner_profile_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ADD CONSTRAINT `fk_partner_onboarding_application_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ADD CONSTRAINT `fk_partner_onboarding_application_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ADD CONSTRAINT `fk_partner_partner_api_credential_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ADD CONSTRAINT `fk_partner_revenue_share_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ADD CONSTRAINT `fk_partner_revenue_share_schedule_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_partner_settlement_account_id` FOREIGN KEY (`partner_settlement_account_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_settlement_account`(`partner_settlement_account_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ADD CONSTRAINT `fk_partner_revenue_share_statement_revenue_share_schedule_id` FOREIGN KEY (`revenue_share_schedule_id`) REFERENCES `payments_fintech_ecm`.`partner`.`revenue_share_schedule`(`revenue_share_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ADD CONSTRAINT `fk_partner_sla_commitment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ADD CONSTRAINT `fk_partner_sla_commitment_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ADD CONSTRAINT `fk_partner_sla_commitment_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ADD CONSTRAINT `fk_partner_network_participation_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_partner_contact_id` FOREIGN KEY (`partner_contact_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_contact`(`partner_contact_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ADD CONSTRAINT `fk_partner_bin_sponsorship_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_contact` ADD CONSTRAINT `fk_partner_partner_contact_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` ADD CONSTRAINT `fk_partner_integration_endpoint_partner_api_credential_id` FOREIGN KEY (`partner_api_credential_id`) REFERENCES `payments_fintech_ecm`.`partner`.`partner_api_credential`(`partner_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `payments_fintech_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ADD CONSTRAINT `fk_partner_partner_settlement_account_ecosystem_partner_id` FOREIGN KEY (`ecosystem_partner_id`) REFERENCES `payments_fintech_ecm`.`partner`.`ecosystem_partner`(`ecosystem_partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`partner` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`partner` SET TAGS ('dbx_domain' = 'partner');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `parent_partner_ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`ecosystem_partner` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_profile` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`agreement` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `onboarding_application_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Application ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`onboarding_application` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` SET TAGS ('dbx_subdomain' = 'integration_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `partner_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Partner API Credential ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_api_credential` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `revenue_share_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_schedule` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `revenue_share_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Statement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`revenue_share_statement` ALTER COLUMN `revenue_share_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Schedule Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Commitment Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Partner Contact Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `breach_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`partner`.`sla_commitment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` SET TAGS ('dbx_subdomain' = 'integration_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Identifier (Network Participation ID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (Partner ID)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`network_participation` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` SET TAGS ('dbx_subdomain' = 'integration_operations');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'BIN Sponsorship ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `partner_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Bank Partner ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_sponsorship_status` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Status');
ALTER TABLE `payments_fintech_ecm`.`partner`.`bin_sponsorship` ALTER COLUMN `bin_sponsorship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`integration_endpoint` SET TAGS ('dbx_subdomain' = 'integration_operations');
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
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account ID');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`partner`.`partner_settlement_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
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
