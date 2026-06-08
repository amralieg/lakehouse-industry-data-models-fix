-- Schema for Domain: cardholder | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`cardholder` COMMENT 'SSOT for all consumer and business cardholder identities served by the platform. Owns cardholder profiles, account credentials, KYC verification status, PAN/DPAN linkages, authentication attributes (CVV, AVS), SCA compliance data, and customer lifecycle supporting B2C and B2B payment relationships across all channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` (
    `account_holder_id` BIGINT COMMENT 'Unique system-generated identifier for the account holder (golden record).',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Corporate account holders in B2B payments fintech are registered legal entities. Linking enables KYC/AML regulatory reporting, tax identification reconciliation, and sanctions screening against the le',
    `account_holder_status` STRING COMMENT 'Current lifecycle status of the account holder.. Valid values are `active|suspended|closed|dormant|pending`',
    `account_holder_type` STRING COMMENT 'Indicates whether the holder is an individual consumer (B2C) or a corporate entity (B2B).. Valid values are `individual|business`',
    `avs_verified` BOOLEAN COMMENT 'Result of Address Verification System check during onboarding.',
    `business_category` STRING COMMENT 'Industry classification of business account holder (e.g., retail, services).',
    `city` STRING COMMENT 'City of the mailing address.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the account holder was closed or deactivated, if applicable.',
    `corporate_name` STRING COMMENT 'Legal corporate name for business account holders.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account holder record was first created in the system.',
    `cvv_last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent CVV verification event.',
    `date_of_birth` DATE COMMENT 'Birth date of the individual account holder.',
    `dpan` STRING COMMENT 'Device Primary Account Number used for tokenized transactions.',
    `email_address` STRING COMMENT 'Primary email address for the account holder.',
    `failed_login_attempts` STRING COMMENT 'Count of consecutive failed login attempts.',
    `first_name` STRING COMMENT 'Given name of the account holder.',
    `full_name` STRING COMMENT 'Complete legal name of the account holder as provided during onboarding.',
    `incorporation_date` DATE COMMENT 'Date when the business entity was incorporated.',
    `kyc_status` STRING COMMENT 'Current KYC verification status of the account holder.. Valid values are `verified|pending|failed|rejected`',
    `kyc_verification_timestamp` TIMESTAMP COMMENT 'Timestamp when KYC verification was completed.',
    `last_login_timestamp` TIMESTAMP COMMENT 'Timestamp of the last successful login to the platform.',
    `last_name` STRING COMMENT 'Family name of the account holder.',
    `mailing_address_line1` STRING COMMENT 'First line of the mailing address.',
    `mailing_address_line2` STRING COMMENT 'Second line of the mailing address.',
    `mcc_code` STRING COMMENT 'Merchant Category Code associated with the account holder (if applicable).',
    `nationality` STRING COMMENT 'Country of citizenship or nationality of the account holder.',
    `onboarding_channel` STRING COMMENT 'Channel through which the account holder was onboarded.. Valid values are `online|branch|partner|mobile_app|api`',
    `pan` STRING COMMENT 'Primary Account Number linked to the account holder (masked for security).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the account holder.',
    `postal_code` STRING COMMENT 'Postal code of the mailing address.',
    `preferred_language` STRING COMMENT 'Preferred language for communications with the account holder.',
    `sca_compliance` BOOLEAN COMMENT 'Indicates if the account holder has completed Strong Customer Authentication compliance.',
    `source_of_funds` STRING COMMENT 'Declared source of funds for the account holder.',
    `state_province` STRING COMMENT 'State or province of the mailing address.',
    `status_reason` STRING COMMENT 'Reason code for the current status (e.g., fraud_suspected, compliance_hold).',
    `tax_exempt` BOOLEAN COMMENT 'Indicates if the account holder is tax-exempt.',
    `tax_identifier` STRING COMMENT 'Tax identification number (e.g., SSN, EIN, TIN) for tax reporting.',
    `tokenization_status` STRING COMMENT 'Indicates whether the PAN has been tokenized.. Valid values are `tokenized|not_tokenized|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account holder record.',
    CONSTRAINT pk_account_holder PRIMARY KEY(`account_holder_id`)
) COMMENT 'SSOT master record for every consumer and business cardholder identity served by the platform. Captures full legal identity (name, DOB, nationality, tax ID), account holder type (individual B2C vs. corporate B2B), onboarding channel, lifecycle status (active, suspended, closed, dormant), preferred language, and platform-assigned cardholder reference number. This is the root anchor entity for all cardholder sub-entities and the authoritative golden record for cardholder identity across all payment channels.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` (
    `cardholder_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the cardholder profile record.',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: cardholder_profile extends the master account_holder; linking provides a single source of truth and allows removal of duplicated personal and KYC fields from the profile.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Links employee cardholder profiles to cost centers for expense allocation and internal reporting.',
    `dcc_config_id` BIGINT COMMENT 'Foreign key linking to fx.dcc_config. Business justification: Cardholders can be pre-enrolled in DCC programs; the applicable dcc_config governs offer presentation method, margin percentage, and opt-in defaults for that profile. DCC enrollment management and com',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Needed for loyalty and offer management: the primary partner offering programs to the cardholder is identified for personalized marketing and compliance.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: FX fee schedule applied per cardholder for fee calculation reports; treasury uses this to charge correct FX fees based on customer segment.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Regulatory AML/KYC reporting requires linking each cardholder to their issuing bank’s settlement participant to trace funds and satisfy cross‑border settlement netting.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Cardholder profiles are subject to jurisdiction-specific compliance rules (GDPR in EU, different KYC thresholds by country, cross-border restrictions). Linking cardholder_profile to jurisdiction_profi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Global card programs issue cardholder profiles under specific legal entities per jurisdiction. Required for GDPR data residency compliance, local regulatory reporting, and multi-entity financial conso',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Needed for offering cardholder‑specific scheme preferences during new card issuance and for compliance reporting on scheme‑wise cardholder demographics.',
    `rate_margin_config_id` BIGINT COMMENT 'Foreign key linking to fx.rate_margin_config. Business justification: Custom margin config per cardholder determines FX rate margins; used in pricing engine and compliance reporting.',
    `account_lock_flag` BOOLEAN COMMENT 'Indicates whether the cardholders account is currently locked due to security policies.',
    `address_line1` STRING COMMENT 'First line of the cardholders street address.',
    `address_line2` STRING COMMENT 'Second line of the street address (optional).',
    `address_verified` BOOLEAN COMMENT 'Indicates whether the cardholders address has been validated through KYC processes.',
    `cardholder_type` STRING COMMENT 'Segment indicating whether the cardholder is an individual consumer, business entity, merchant, or partner.. Valid values are `consumer|business|merchant|partner`',
    `completeness_score` DECIMAL(18,2) COMMENT 'Calculated percentage (0‑100) reflecting how many optional profile fields are populated.',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent consent (e.g., marketing) was recorded.',
    `created_by_system` STRING COMMENT 'Name of the system or service that initially created the profile record.',
    `data_retention_opt_out` BOOLEAN COMMENT 'Indicates if the cardholder has opted out of data retention beyond statutory periods.',
    `dpan_token` STRING COMMENT 'Tokenized representation of the cardholders device PAN used for tokenization services.',
    `email_verified` BOOLEAN COMMENT 'True when the primary email address has been confirmed via verification workflow.',
    `external_customer_code` STRING COMMENT 'Identifier used by external partner systems to reference this cardholder.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score generated by the fraud detection platform for this cardholder.',
    `gender` STRING COMMENT 'Self‑declared gender of the cardholder for demographic reporting.. Valid values are `male|female|non_binary|unspecified|prefer_not_to_say|other`',
    `is_test_account` BOOLEAN COMMENT 'True if the profile is used for internal testing or sandbox environments.',
    `kyc_verification_status` STRING COMMENT 'Result of the Know‑Your‑Customer verification process for the cardholder.. Valid values are `verified|unverified|pending|failed`',
    `last_modified_by_system` STRING COMMENT 'Name of the system that performed the most recent update.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the cardholder profile.. Valid values are `active|inactive|suspended|closed|pending|deceased`',
    `marketing_consent_email` BOOLEAN COMMENT 'Indicates whether the cardholder has opted in to receive marketing emails.',
    `marketing_consent_sms` BOOLEAN COMMENT 'Indicates whether the cardholder has opted in to receive marketing SMS messages.',
    `pan_linked` BOOLEAN COMMENT 'True if a primary account number (PAN) is linked to this profile.',
    `preferred_communication_channel` STRING COMMENT 'Cardholders chosen channel for receiving marketing and transactional messages.. Valid values are `email|sms|push|phone|mail`',
    `preferred_language` STRING COMMENT 'Language preference for communications and UI.. Valid values are `en|es|fr|de|zh|ja`',
    `primary_email` STRING COMMENT 'Main email address used for communication and account notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone number for SMS alerts and voice contact.. Valid values are `^+?[0-9]{7,15}$`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the profile record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the profile record.',
    `right_to_erasure_requested` BOOLEAN COMMENT 'True when the cardholder has submitted a request for data deletion.',
    `risk_level` STRING COMMENT 'Overall risk classification derived from fraud and compliance signals.. Valid values are `low|medium|high|critical`',
    `sca_compliance_status` STRING COMMENT 'Current SCA compliance state of the cardholder as required by PSD2.. Valid values are `compliant|non_compliant|pending|not_applicable`',
    `source_system` STRING COMMENT 'Originating system that created or last modified the profile.. Valid values are `gateway|crm|wallet|risk`',
    `time_zone` STRING COMMENT 'Time zone identifier associated with the cardholder.. Valid values are `UTC|EST|CST|PST|GMT|CET`',
    `total_failed_auth_attempts` STRING COMMENT 'Cumulative count of consecutive failed login or authentication attempts.',
    `version` STRING COMMENT 'Incremental version number tracking changes to the profile over time.',
    CONSTRAINT pk_cardholder_profile PRIMARY KEY(`cardholder_profile_id`)
) COMMENT 'Extended personal and contact profile for an account holder. Stores PII attributes including full legal name, date of birth, gender, primary email, primary phone, preferred communication channel, marketing consent flags, and profile completeness score. Distinct from account_holder (which owns identity and lifecycle) — this entity owns the mutable contact and preference layer that changes independently of identity status. Supports GDPR/CCPA data subject rights management including right-to-erasure flags.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`address` (
    `address_id` BIGINT COMMENT 'Unique surrogate key for the cardholder address record.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Address records belong to a cardholder profile; linking enables address lookup and removes the need for profile‑level address fields.',
    `address_status` STRING COMMENT 'Lifecycle status of the address record.. Valid values are `active|inactive|archived|pending_verification`',
    `address_type` STRING COMMENT 'Classification of the address purpose.. Valid values are `billing|shipping|residential|registered_business`',
    `avs_verified_flag` BOOLEAN COMMENT 'Flag indicating if the address passed Address Verification System (AVS) check.',
    `avs_verified_timestamp` TIMESTAMP COMMENT 'Timestamp when the AVS verification was performed.',
    `city` STRING COMMENT 'City or locality of the address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the address record was created in the system.',
    `effective_from` DATE COMMENT 'Date when the address became effective for the cardholder.',
    `effective_until` DATE COMMENT 'Date when the address ceased to be effective (null if still active).',
    `geocode_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate from geocoding the address.',
    `geocode_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate from geocoding the address.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this address is the primary address for the cardholder.',
    `label` STRING COMMENT 'Human‑readable label for the address (e.g., Home, Office).',
    `line1` STRING COMMENT 'First line of the street address.',
    `line2` STRING COMMENT 'Second line of the street address (optional).',
    `line3` STRING COMMENT 'Third line of the street address (optional).',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the address.. Valid values are `^[A-Z0-9 -]{3,10}$`',
    `state_province` STRING COMMENT 'State, province, or region of the address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the address record.',
    `verification_attempts` STRING COMMENT 'Number of verification attempts performed for this address.',
    `verification_source` STRING COMMENT 'Source of address verification.. Valid values are `avs|kyc|manual`',
    `verification_status` STRING COMMENT 'Current verification status of the address.. Valid values are `verified|unverified|failed|pending`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Physical and mailing address records associated with a cardholder. Stores structured address components (street, city, state/province, postal code, country ISO code), address type (billing, shipping, residential, registered business), AVS-verified flag, AVS verification timestamp, geocoding coordinates, and address lifecycle (primary, secondary, historical). Supports AVS (Address Verification System) checks during card-not-present authorization and KYC address validation workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` (
    `cardholder_kyc_verification_id` BIGINT COMMENT 'System-generated unique identifier for each KYC verification record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: KYC verifications are performed within a specific partners program (BaaS, co-brand). Regulatory compliance and partner-level KYC audit reporting require knowing which ecosystem partners onboarding f',
    `model_id` BIGINT COMMENT 'Foreign key linking to risk.risk_model. Business justification: KYC verification scores and risk_tier assignments are computed by specific risk models. Model governance and AML regulatory audits require traceability from each KYC verification record to the scoring',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder to whom this verification applies.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: KYC verifications are performed to satisfy specific regulatory obligations (CDD under AMLD5, KYC under BSA, EDD under FATF Recommendation 10). Linking each KYC verification to the regulatory_obligatio',
    `aml_check_passed` BOOLEAN COMMENT 'Result of the Anti‑Money‑Laundering screening performed during verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYC verification record was first created in the system.',
    `ctf_check_passed` BOOLEAN COMMENT 'Result of the Counter‑Terrorism Financing screening performed during verification.',
    `document_hash` STRING COMMENT 'SHA‑256 hash of the submitted document to ensure integrity.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `document_type` STRING COMMENT 'Type of identity document submitted for verification.. Valid values are `passport|driver_license|national_id|utility_bill|bank_statement`',
    `expiry_date` DATE COMMENT 'Date after which the verification is considered expired and must be renewed.',
    `is_sca_compliant` BOOLEAN COMMENT 'Indicates whether the verification satisfies Strong Customer Authentication requirements.',
    `issued_at` TIMESTAMP COMMENT 'Exact time when the KYC verification was performed.',
    `notes` STRING COMMENT 'Additional comments or observations recorded by the verification analyst.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'True if this verification must be reported to regulatory bodies (e.g., FinCEN, FCA).',
    `reverification_count` STRING COMMENT 'Number of times the cardholder has been re‑verified after the initial verification.',
    `risk_tier` STRING COMMENT 'Risk tier assigned to the cardholder after KYC evaluation.. Valid values are `low|medium|high|critical`',
    `sanctions_screened` BOOLEAN COMMENT 'Indicates whether the cardholder passed sanctions list screening.',
    `score_timestamp` TIMESTAMP COMMENT 'Timestamp when the verification score was calculated.',
    `source_channel` STRING COMMENT 'Channel through which the verification request originated.. Valid values are `web|mobile|branch|api`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the KYC verification record.',
    `verification_method` STRING COMMENT 'Method used to perform the KYC verification.. Valid values are `document_scan|biometric|database_check|eidv`',
    `verification_provider` STRING COMMENT 'Name of the third‑party or internal provider that performed the verification.',
    `verification_reference_number` STRING COMMENT 'External reference number (e.g., ARN) linking this verification to downstream audit trails.',
    `verification_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0‑100) produced by the KYC engine.',
    `verification_status` STRING COMMENT 'Current lifecycle status of the verification record.. Valid values are `pending|passed|failed|expired|manual_review`',
    CONSTRAINT pk_cardholder_kyc_verification PRIMARY KEY(`cardholder_kyc_verification_id`)
) COMMENT 'KYC (Know Your Customer) verification record capturing the full identity verification lifecycle for a cardholder. Stores verification method (document scan, biometric, database check, eIDV), verification provider, verification status (pending, passed, failed, expired, manual_review), risk tier assigned post-KYC, document types submitted, verification score, expiry date of verification, and regulatory jurisdiction. Supports AML/CTF compliance obligations and onboarding gating logic. Each re-verification creates a new record preserving the full audit trail.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` (
    `kyc_document_id` BIGINT COMMENT 'Unique surrogate identifier for the KYC document record.',
    `cardholder_kyc_verification_id` BIGINT COMMENT 'Identifier of the parent KYC verification to which this document belongs.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the internal user who performed the manual review.',
    `checksum` STRING COMMENT 'SHA‑256 checksum of the document file for integrity verification.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance evaluation was performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `document_category` STRING COMMENT 'Business classification of the document purpose for KYC.. Valid values are `identity_proof|address_proof|financial_proof`',
    `document_image_uri` STRING COMMENT 'Secure vault URI pointing to the stored image or PDF of the document.',
    `document_issue_place` STRING COMMENT 'City or locality where the document was issued.',
    `document_language` STRING COMMENT 'Two‑letter language code of the document content.. Valid values are `^[a-z]{2}$`',
    `document_number` STRING COMMENT 'Masked or tokenized identifier of the document (e.g., passport number).',
    `document_type` STRING COMMENT 'Classification of the identity document submitted for verification.. Valid values are `passport|national_id|drivers_license|utility_bill|bank_statement`',
    `expiry_date` DATE COMMENT 'Date after which the document is no longer valid.',
    `file_format` STRING COMMENT 'File format of the stored document image.. Valid values are `pdf|jpg|png`',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored document file in bytes.',
    `is_compliant` BOOLEAN COMMENT 'Indicates whether the document meets all regulatory compliance checks.',
    `issue_date` DATE COMMENT 'Date on which the document was originally issued by the authority.',
    `issuing_country` STRING COMMENT 'Three‑letter ISO country code of the authority that issued the document.. Valid values are `^[A-Z]{3}$`',
    `kyc_document_status` STRING COMMENT 'Current lifecycle status of the document record.. Valid values are `active|inactive|archived|rejected`',
    `manual_review_outcome` STRING COMMENT 'Result of the manual review after completion.. Valid values are `approved|rejected|escalated`',
    `manual_review_status` STRING COMMENT 'Current status of the human review process for the document.. Valid values are `pending|in_review|completed`',
    `notes` STRING COMMENT 'Free‑form text field for additional remarks by reviewers or operators.',
    `ocr_confidence_score` DECIMAL(18,2) COMMENT 'Confidence percentage (0‑100) of the OCR extraction accuracy.',
    `ocr_status` STRING COMMENT 'Current status of optical character recognition processing for the document.. Valid values are `pending|completed|failed`',
    `retention_expiry_date` DATE COMMENT 'Date after which the document must be deleted to satisfy regulatory retention rules.',
    `review_timestamp` TIMESTAMP COMMENT 'Date‑time when the manual review was finalized.',
    `source_channel` STRING COMMENT 'Method by which the document was submitted to the platform.. Valid values are `upload|api|mobile_app`',
    `tamper_detected` BOOLEAN COMMENT 'Indicates whether the document image shows signs of tampering.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version_number` STRING COMMENT 'Sequential version of the document record for audit purposes.',
    CONSTRAINT pk_kyc_document PRIMARY KEY(`kyc_document_id`)
) COMMENT 'Individual identity document submitted as part of a KYC verification. Captures document type (passport, national ID, drivers license, utility bill, bank statement), issuing country, document number (tokenized/masked), issue date, expiry date, document image reference (vault URI), OCR extraction status, tamper detection flag, and manual review outcome. Linked to a parent kyc_verification record. Supports regulatory document retention requirements under BSA, PSD2, and FATF standards.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` (
    `pan_record_id` BIGINT COMMENT 'Surrogate primary key for the PAN record.',
    `bin_sponsorship_id` BIGINT COMMENT 'Foreign key linking to partner.bin_sponsorship. Business justification: Each PAN falls within a specific BIN sponsorship range. BIN sponsorship governs the PANs card scheme rules, issuing bank compliance, and revenue share. Domain experts expect pan_record to reference b',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: A PAN is issued within a card programs BIN range. Issuance, fraud, and routing teams identify which card program a PAN belongs to for fee calculation, scheme routing, and compliance. card_scheme on p',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: A PAN is issued in a specific currency; the currency_pair governs DCC eligibility and cross-border fee application at the card level. FX and issuing operations teams use the cards currency pair to de',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: PANs are issued under a specific partners program. Partner-level card portfolio reporting, BIN management, and compliance obligations require knowing which ecosystem partner issued the PAN. Domain ex',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Issuers pre-classify PANs to an IRF rate category based on BIN range, card_type, and card_scheme for interchange cost modeling and qualification analysis. A payments-fintech domain expert expects this',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: Each PAN is issued under a specific settlement participant (issuing bank/BIN sponsor). Interchange reporting, scheme compliance, and chargeback processing require knowing which participant issued the ',
    `cardholder_profile_id` BIGINT COMMENT 'Surrogate key linking the PAN to its owning cardholder profile.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Required for card issuance and settlement: each PAN must be associated with its payment scheme (Visa, Mastercard) to route transactions and calculate interchange fees.',
    `aml_screening_status` STRING COMMENT 'Result of Anti‑Money‑Laundering screening for the PAN.. Valid values are `clear|match|pending`',
    `bin` STRING COMMENT 'First six digits of the PAN identifying the issuing bank and card brand.',
    `compliance_status` STRING COMMENT 'Indicates whether the PAN record meets current PCI‑DSS requirements.. Valid values are `pci_compliant|non_compliant`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for transactions using this PAN. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|AUD|CAD|CHF|CNY|INR|BRL|... — promote to reference product]',
    `expiry_date` DATE COMMENT 'Date when the PAN expires and can no longer be used for new authorizations.',
    `fraud_flag` BOOLEAN COMMENT 'True if the PAN has been flagged for suspected fraudulent activity.',
    `iin` STRING COMMENT 'First eight digits of the PAN used for routing and issuer identification.',
    `is_primary` BOOLEAN COMMENT 'True if this PAN is the default/primary PAN for the linked cardholder.',
    `is_sca_compliant` BOOLEAN COMMENT 'True if the PAN is eligible for Strong Customer Authentication under PSD2.',
    `kyc_status` STRING COMMENT 'Current Know‑Your‑Customer verification state of the cardholder linked to this PAN.. Valid values are `verified|unverified|pending`',
    `last_four` STRING COMMENT 'Last four digits of the PAN, commonly used for verification and customer service.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent successful authorization involving this PAN.',
    `masked_pan` STRING COMMENT 'Masked representation of the PAN (e.g., XXXX‑XXXX‑XXXX‑1234) for human‑readable displays.',
    `pan_format` STRING COMMENT 'Indicates whether the PAN consists of only numeric characters or includes alphanumeric characters.. Valid values are `numeric|alphanumeric`',
    `pan_length` STRING COMMENT 'Number of digits in the PAN (typically 16, 15, or 19).',
    `pan_status` STRING COMMENT 'Operational status of the PAN within its lifecycle.. Valid values are `active|blocked|expired|replaced|pending`',
    `pan_token` STRING COMMENT 'PCI‑DSS compliant token that represents the PAN; never stores the clear PAN.',
    `pan_type` STRING COMMENT 'Indicates whether the PAN is a physical PAN (FPAN) or a device‑generated token (DPAN).. Valid values are `fpan|dpan`',
    `record_audit_created` TIMESTAMP COMMENT 'Date‑time when the PAN record was initially persisted.',
    `record_audit_updated` TIMESTAMP COMMENT 'Date‑time of the latest modification to the PAN record.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑99.99) indicating fraud likelihood.',
    `token_expiry_date` DATE COMMENT 'Date when the PAN token becomes invalid.',
    `token_service_provider` STRING COMMENT 'Entity responsible for generating and managing the PAN token.. Valid values are `tsp_a|tsp_b|tsp_c|internal|other`',
    `tokenization_method` STRING COMMENT 'Technique used to derive the token from the clear PAN.. Valid values are `tsp|hce|dpan|other`',
    `usage_count` BIGINT COMMENT 'Total number of successful transactions processed for this PAN.',
    CONSTRAINT pk_pan_record PRIMARY KEY(`pan_record_id`)
) COMMENT 'Authoritative PAN (Primary Account Number) registry for cardholders. Stores the tokenized PAN reference (never the raw PAN in clear text per PCI DSS), BIN (Bank Identification Number), IIN (Issuer Identification Number), card scheme (Visa, Mastercard, Amex, Discover), PAN type (FPAN physical, DPAN device token), PAN status (active, blocked, expired, replaced), expiry date, and the issuing bank reference. This is the SSOT for PAN-to-cardholder linkage and supports BIN-level routing and interchange qualification.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` (
    `payment_credential_id` BIGINT COMMENT 'Unique system-generated identifier for the payment credential record.',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Payment credentials (EMV, contactless, tokenization) are configured per card program. card_program defines contactless_enabled, emv_configuration, and tokenization support. Credential issuance and lif',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: A payment_credential authenticates a specific PAN/DPAN. The credential stores dpan_reference and token_reference as raw string fields, but pan_record is the authoritative PAN registry (storing pan_tok',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder who owns this credential.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Payment credentials (EMV chip, tokenized cards, 3DS enrollment) are governed by scheme-specific standards. Scheme determines 3DS version support, tokenization method, and CVV validation rules. Issuers',
    `authentication_method` STRING COMMENT 'Primary method used to authenticate the credential during a transaction.. Valid values are `cvv|pin|biometric|otp|none`',
    `biometric_enabled_flag` BOOLEAN COMMENT 'Indicates whether biometric authentication is enabled for this credential.',
    `biometric_type` STRING COMMENT 'Specific biometric modality used (if enabled).. Valid values are `fingerprint|face|iris|voice`',
    `contactless_nfc_enabled_flag` BOOLEAN COMMENT 'True when NFC/contactless payments are permitted for this credential.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credential record was first created in the system.',
    `credential_label` STRING COMMENT 'Human‑readable name or label assigned to the credential (e.g., "Primary Card Credential").',
    `credential_source_system` STRING COMMENT 'Name of the operational system that originated the credential record (e.g., Digital Wallet Platform).',
    `credential_status` STRING COMMENT 'Current operational state of the credential.. Valid values are `active|inactive|suspended|revoked|expired`',
    `credential_type` STRING COMMENT 'Category of the credential indicating the underlying payment instrument.. Valid values are `card|token|digital_wallet|virtual_card`',
    `credential_version` STRING COMMENT 'Monotonically increasing version number for the credential record.',
    `cvv2_validation_flag` BOOLEAN COMMENT 'Indicates whether CVV2 validation is required for this credential.',
    `cvv_hash_ref` STRING COMMENT 'Reference to the hashed CVV/CVC stored securely in the HSM.',
    `emv_chip_enabled_flag` BOOLEAN COMMENT 'Indicates whether EMV chip authentication is supported.',
    `expiration_date` DATE COMMENT 'Date after which the credential is no longer valid.',
    `external_credential_code` STRING COMMENT 'Identifier used by external systems (e.g., token service provider) to reference this credential.',
    `hsm_key_reference` STRING COMMENT 'Identifier of the HSM key used to encrypt credential secrets.',
    `issuance_date` DATE COMMENT 'Date when the credential was originally issued.',
    `last_rotation_timestamp` TIMESTAMP COMMENT 'Date‑time when the credential secrets were last rotated.',
    `otp_enabled_flag` BOOLEAN COMMENT 'Indicates whether one‑time‑password (OTP) authentication is active.',
    `otp_last_sent_timestamp` TIMESTAMP COMMENT 'Date‑time when the most recent OTP was generated/sent.',
    `pan_linkage_status` STRING COMMENT 'Current relationship status between the credential and its PAN/DPAN.. Valid values are `linked|unlinked|pending`',
    `pin_last_change_timestamp` TIMESTAMP COMMENT 'Date‑time when the PIN offset was last updated.',
    `pin_offset` STRING COMMENT 'Encrypted PIN offset used for offline PIN verification (PCI‑DSS).',
    `sca_compliance_flag` BOOLEAN COMMENT 'True when the credential meets PSD2 Strong Customer Authentication requirements.',
    `sca_compliance_timestamp` TIMESTAMP COMMENT 'Date‑time when SCA compliance was last verified.',
    `three_ds_enrollment_status` STRING COMMENT 'State of Strong Customer Authentication enrollment for this credential.. Valid values are `enrolled|not_enrolled|pending`',
    `three_ds_method` STRING COMMENT 'Method used for 3‑DS challenge‑response (e.g., OTP, biometric).. Valid values are `otp|biometric|out_of_band|none`',
    `tokenization_status` STRING COMMENT 'State of tokenization for the underlying PAN/DPAN.. Valid values are `tokenized|not_tokenized`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credential record.',
    CONSTRAINT pk_payment_credential PRIMARY KEY(`payment_credential_id`)
) COMMENT 'Authentication credential set associated with a cardholders payment instrument. Stores CVV/CVC hash reference, CVV2 validation flag, PIN offset (for debit/ATM), 3DS enrollment status, 3DS authentication method (OTP, biometric, out-of-band), SCA compliance flag per PSD2, credential version, last rotation timestamp, and HSM key reference identifier. Distinct from pan_record (which owns the PAN identity) — this entity owns the authentication secrets and SCA compliance state. Supports EMV chip credential management and NFC contactless authentication.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` (
    `cardholder_sca_challenge_id` BIGINT COMMENT 'Globally unique identifier for the SCA challenge event.',
    `auth_3ds_result_id` BIGINT COMMENT 'Foreign key linking to fraud.auth_3ds_result. Business justification: 3DS authentication outcome reporting requires linking the cardholder-side SCA challenge to the ACS/fraud-side auth_3ds_result for liability shift determination and PSD2 SCA compliance reporting. Domai',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: SCA challenges under PSD2 are triggered in the context of a specific payment account transaction. While cardholder_sca_challenge already links to cardholder_profile_id (identity) and transaction_id (c',
    `device_id` BIGINT COMMENT 'Unique identifier of the device used for the challenge (e.g., mobile device ID).',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who received the challenge.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.request. Business justification: An SCA challenge is triggered by a specific gateway request. PSD2 and 3DS audit requirements mandate end-to-end traceability from the originating payment request through the SCA challenge outcome. The',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: SCA challenges are scheme-specific (Visa Secure vs Mastercard Identity Check), with different 3DS protocol versions, ECI indicators, and exemption rules per scheme. Scheme-level SCA compliance reporti',
    `threeds_config_id` BIGINT COMMENT 'Foreign key linking to gateway.threeds_config. Business justification: Each SCA challenge is executed under a specific 3DS configuration (protocol version, challenge preference, exemption rules, risk threshold). PSD2 SCA compliance audit trails require tracing every chal',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction associated with the SCA challenge.',
    `acs_reference` STRING COMMENT 'Identifier of the ACS that generated the challenge.',
    `attempt_number` STRING COMMENT 'Sequential number of the challenge attempt for the same transaction.',
    `authentication_value` DECIMAL(18,2) COMMENT 'Cryptographic authentication value returned by the ACS.',
    `challenge_status` STRING COMMENT 'Current lifecycle state of the challenge.. Valid values are `ISSUED|PASSED|FAILED|EXPIRED|BYPASSED`',
    `challenge_timestamp` TIMESTAMP COMMENT 'Exact time the challenge was issued to the cardholder.',
    `challenge_type` STRING COMMENT 'Method used to deliver the SCA challenge to the cardholder.. Valid values are `OTP_SMS|OTP_EMAIL|BIOMETRIC|PUSH_NOTIFICATION|OUT_OF_BAND`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCA challenge record was first created in the lakehouse.',
    `eci_indicator` STRING COMMENT 'Indicator of the authentication outcome used for liability shift.. Valid values are `00|01|02|05`',
    `exemption_reason` STRING COMMENT 'Reason why SCA was bypassed, if applicable.. Valid values are `LOW_VALUE|TRANSACTION_RISK_ANALYSIS|MERCHANT_INITIATED|OTHER`',
    `failure_reason` STRING COMMENT 'Textual description of why the challenge failed, if applicable.',
    `ip_address` STRING COMMENT 'IP address of the device that initiated the challenge.',
    `is_successful` BOOLEAN COMMENT 'Indicates whether the challenge was successfully completed (true) or not (false).',
    `latency_ms` STRING COMMENT 'Time in milliseconds between challenge issuance and final response.',
    `three_ds_version` STRING COMMENT 'Version of the 3‑Domain Secure protocol applied.. Valid values are `2.0|2.1|2.2`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SCA challenge record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string presented during the challenge.',
    CONSTRAINT pk_cardholder_sca_challenge PRIMARY KEY(`cardholder_sca_challenge_id`)
) COMMENT 'Record of each Strong Customer Authentication (SCA) challenge event issued to a cardholder under PSD2/3DS protocols. Captures challenge type (OTP SMS, OTP email, biometric, push notification, out-of-band), challenge status (issued, passed, failed, expired, bypassed), 3DS version, ACS (Access Control Server) reference, authentication value (CAVV/AAV), ECI indicator, challenge timestamp, and exemption reason if SCA was bypassed (low-value, TRA, merchant-initiated). Provides the full SCA audit trail required by PSD2 RTS.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` (
    `cardholder_account_id` BIGINT COMMENT 'Unique surrogate key for the cardholder account record.',
    `a2a_product_id` BIGINT COMMENT 'Foreign key linking to product.a2a_product. Business justification: A cardholder account enabled for A2A bank transfers is governed by an a2a_product defining settlement windows, ISO 20022 version, supported rails, and regulatory reporting requirements. Operations and',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Card billing statement generation and payment due date tracking require tying each cardholder account to its current accounting period. Enables period-close AR aging, minimum payment calculations, and',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Cardholder accounts are governed by a specific partner agreement defining MDR rates, fee structures, revenue share, and compliance requirements. Linking accounts to agreements enables accurate revenue',
    `bin_sponsorship_id` BIGINT COMMENT 'Foreign key linking to partner.bin_sponsorship. Business justification: Each cardholder account is issued under a specific BIN sponsorship arrangement governing card scheme, issuing bank, and compliance framework. BIN sponsorship attribution on accounts is required for po',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: A cardholder account enrolled in BNPL is governed by a specific bnpl_plan defining installment count, interest rate, late fees, and credit limits. Collections and product teams need this link for deli',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: A cardholder account is issued under a specific card program governing BIN range, spend limits, fee structure, and compliance rules. Issuers and operations teams query which card program does this ac',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to risk.credit_limit. Business justification: Cardholder account servicing, credit decisioning, and regulatory capital reporting require direct linkage to the governing credit_limit record. credit_limit and available_credit on cardholder_account ',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Cardholder accounts are denominated in a home currency; the currency_pair governs DCC eligibility and FX exposure attribution per account. FX operations teams use this link for exposure netting and DC',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Cardholder accounts are opened under a specific partners program (co-brand, BaaS, prepaid). Partner-level account portfolio reporting, revenue share calculations, and regulatory reporting all require',
    `funding_schedule_id` BIGINT COMMENT 'Foreign key linking to settlement.funding_schedule. Business justification: Prepaid and digital wallet cardholder_accounts are governed by a funding_schedule (direct deposit, top-up cadence). Account management operations and funding operations teams require this link to dete',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Required for daily GL posting of each cardholder credit account balances to financial statements.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: In multi-entity card programs, each cardholder account is issued under a specific legal entity. Required for IFRS 9 ECL impairment reporting, consumer credit regulatory filings, and tax reporting — a ',
    `multi_network_routing_id` BIGINT COMMENT 'Foreign key linking to network.multi_network_routing. Business justification: Debit cardholder accounts require a multi-network routing profile for Durbin Amendment compliance (US regulation mandating ≥2 unaffiliated networks). The routing profile governs least-cost routing and',
    `p2p_product_id` BIGINT COMMENT 'Foreign key linking to product.p2p_product. Business justification: A cardholder account enabled for P2P transfers is governed by a p2p_product defining transfer limits, KYC requirements, AML screening, and FX eligibility. Product and compliance teams need this link t',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: A cardholder_account is the financial account tied to a specific payment card (PAN). cardholder_account currently stores dpan_token as a raw string and has a pan_linked boolean flag, but has no FK to ',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Account statements, fee calculation, and regulatory reporting require linking each cardholder_account to its underlying payment_product (e.g., credit card product).',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Cardholder accounts operate under specific risk policies governing transaction limits, credit behavior, and exposure caps. product_program_code on cardholder_account is insufficient for policy traceab',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (person) owning the account.',
    `product_pricing_plan_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_plan. Business justification: Each cardholder account is assigned a pricing plan determining fees, discount rates, and transaction charges. Billing and revenue teams use this to calculate account-level charges and produce fee reve',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.program. Business justification: A cardholder account is enrolled in a specific interchange program (e.g., Visa Signature, MC World Elite) governing applicable interchange rates. This drives interchange qualification, billing, and re',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Cardholder accounts are issued under a specific card scheme (Visa, Mastercard, Amex), governing interchange calculation, dispute routing, and scheme compliance reporting. card_scheme is a denormaliz',
    `virtual_account_product_id` BIGINT COMMENT 'Foreign key linking to product.virtual_account_product. Business justification: A cardholder account may be a virtual account issued under a virtual_account_product definition governing BIN range, spend limits, tokenization, and issuance fees. Issuance and product management team',
    `account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|delinquent|charged_off|closed|suspended`',
    `account_tier` STRING COMMENT 'Tier level of the account based on eligibility and benefits.. Valid values are `standard|gold|platinum|enterprise`',
    `account_type` STRING COMMENT 'Category of the financial account.. Valid values are `credit|debit|prepaid|bnpl`',
    `billing_cycle_day` STRING COMMENT 'Day of month when billing cycle starts (1-31).',
    `closure_date` DATE COMMENT 'Date when the account was closed, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was created in the system.',
    `currency_conversion_flag` BOOLEAN COMMENT 'Indicates if the account supports multi-currency transactions.',
    `current_balance` DECIMAL(18,2) COMMENT 'Outstanding balance on the account.',
    `delinquency_status` STRING COMMENT 'Delinquency bucket based on days past due.. Valid values are `none|30_days|60_days|90_days|120_days|write_off`',
    `fraud_score` STRING COMMENT 'Current fraud risk score assigned to the account (0-100).',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the account (e.g., 0.1999 for 19.99%).',
    `is_overlimit` BOOLEAN COMMENT 'Flag indicating if the current balance exceeds the credit limit.',
    `is_suspended` BOOLEAN COMMENT 'Flag indicating if the account is currently suspended.',
    `kyc_status` STRING COMMENT 'Know Your Customer verification status for the account holder.. Valid values are `verified|pending|rejected`',
    `last_fraud_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent fraud risk review for the account.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment applied to the account.',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status change event.',
    `minimum_payment_due` DECIMAL(18,2) COMMENT 'Minimum payment amount required for the next billing cycle.',
    `open_date` DATE COMMENT 'Date when the account was opened.',
    `pan_linked` BOOLEAN COMMENT 'Indicates whether a primary account number (PAN) is linked to this account.',
    `payment_due_amount` DECIMAL(18,2) COMMENT 'Total amount due by the payment due date.',
    `payment_due_date` DATE COMMENT 'Due date for the next payment.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the account is subject to special regulatory reporting (e.g., AML).',
    `reward_program_flag` BOOLEAN COMMENT 'Indicates if the account participates in a rewards program.',
    `sca_compliance_flag` BOOLEAN COMMENT 'Indicates if the account meets Strong Customer Authentication (SCA) requirements.',
    `source_system` STRING COMMENT 'Source system where the account record originated.. Valid values are `gateway|core|wallet|crm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the last update to the account record.',
    CONSTRAINT pk_cardholder_account PRIMARY KEY(`cardholder_account_id`)
) COMMENT 'Financial account record owned by a cardholder on the platform. Represents the account-level construct (credit card account, prepaid account, debit account, BNPL account) that aggregates one or more payment instruments. Stores account type, credit limit, available credit, current balance, billing cycle day, statement currency, account open date, account status (active, delinquent, charged-off, closed), and product program reference. This is the financial account layer sitting between the cardholder identity and individual payment instruments.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` (
    `account_status_history_id` BIGINT COMMENT 'Unique surrogate key for each status transition record.',
    `cardholder_account_id` BIGINT COMMENT 'Identifier of the cardholder account whose status changed.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was created in the system.',
    `correlation_code` STRING COMMENT 'Identifier to correlate this event across multiple systems.',
    `effective_timestamp` TIMESTAMP COMMENT 'Timestamp when the new status became effective.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the status transition event occurred.',
    `initiating_actor` STRING COMMENT 'Entity that initiated the status change.. Valid values are `system|agent|cardholder`',
    `notes` STRING COMMENT 'Additional free-text notes about the status change.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the status changed.',
    `reason_description` STRING COMMENT 'Human readable description of the reason for status change.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates if this record represents a reversal of a previous status change.',
    `source_system` STRING COMMENT 'System of record that generated the status change event.. Valid values are `gateway|processing|fraud|wallet|compliance`',
    `status_after` STRING COMMENT 'The status of the account after the transition.. Valid values are `active|suspended|closed|pending|restricted|terminated`',
    `status_before` STRING COMMENT 'The status of the account prior to the transition.. Valid values are `active|suspended|closed|pending|restricted|terminated`',
    CONSTRAINT pk_account_status_history PRIMARY KEY(`account_status_history_id`)
) COMMENT 'Immutable audit log of all status transitions for a cardholder account. Records each status change event (e.g., active→suspended, suspended→closed), the reason code, initiating actor (system, agent, cardholder self-service), effective timestamp, and reversal flag. Supports regulatory audit trail requirements under SOX, PCI DSS, and CFPB complaint handling. Enables lifecycle analytics and delinquency workflow tracking without mutating the parent cardholder_account record.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique surrogate identifier for the cardholder segment record.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Segmentation classification is assigned per profile; linking provides direct association for analytics and targeting.',
    `model_id` BIGINT COMMENT 'Identifier of the machine‑learning model used for ML‑assigned segments.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Customer segments are often defined by regulatory obligations (e.g., high-risk segments requiring EDD per FATF, PEP segments per AMLD5). Linking segment definitions to the regulatory_obligation that m',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the rule set used for rule‑based assignment.',
    `assignment_method` STRING COMMENT 'Method used to assign the segment to a cardholder (rule‑based, machine‑learning, or manual).. Valid values are `rule_based|ml_assigned|manual`',
    `audience` STRING COMMENT 'Target audience type for the segment (consumer, business, or both).. Valid values are `consumer|business|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment record was first created in the system.',
    `criteria_definition` STRING COMMENT 'Textual definition of the rules or model logic that determines segment membership.',
    `criteria_version` STRING COMMENT 'Version identifier of the segment criteria rule set.',
    `effective_end_date` DATE COMMENT 'Date when the segment definition expires or is superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the segment definition becomes active for assignments.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this segment is the default fallback for cardholders without explicit assignment.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the segment definition was last reviewed or updated by governance.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent cardholder assignment to this segment.',
    `priority` STRING COMMENT 'Numeric priority used when multiple segments could apply; lower numbers indicate higher precedence.',
    `region` STRING COMMENT 'Three‑letter ISO country code indicating the geographic region the segment applies to.. Valid values are `^[A-Z]{3}$`',
    `score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., from ML model) representing the strength of fit for the segment.',
    `segment_code` STRING COMMENT 'Business identifier code for the segment, used in reporting and integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `segment_description` STRING COMMENT 'Detailed description of the segment purpose and criteria.',
    `segment_name` STRING COMMENT 'Human‑readable name of the segment.',
    `segment_status` STRING COMMENT 'Current lifecycle status of the segment definition.. Valid values are `active|inactive|pending|retired`',
    `segment_tier` STRING COMMENT 'Business tier level that defines pricing or eligibility (mass market, premium, etc.).. Valid values are `mass_market|premium|ultra_premium|smb|corporate`',
    `segment_type` STRING COMMENT 'Category of segmentation (e.g., spend tier, risk tier, loyalty tier, product tier).. Valid values are `spend|risk|loyalty|product`',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the segment record.',
    `created_by` STRING COMMENT 'User or system identifier that created the segment record.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Segmentation classification assigned to a cardholder for product targeting, risk tiering, and pricing differentiation. Stores segment code, segment name, segment tier (mass market, premium, ultra-premium, SMB, corporate), assignment method (rule-based, ML-assigned, manual), effective date, expiry date, and the segment criteria version used. Supports product eligibility gating, MDR/MSF pricing tiers, and personalized offer targeting. A cardholder may have one active segment per segment dimension (spend tier, risk tier, loyalty tier).';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`consent` (
    `consent_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each consent record.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder to whom the consent applies.',
    `consent_cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder to whom the consent applies.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: GDPR/CCPA consent tracking per partner: required to record which partner’s data processing the cardholder has consented to.',
    `collection_channel` STRING COMMENT 'Channel through which the consent was obtained.. Valid values are `web|mobile|pos|call_center|email`',
    `consent_status` STRING COMMENT 'Current lifecycle state of the consent record.. Valid values are `granted|withdrawn|pending`',
    `consent_timestamp` TIMESTAMP COMMENT 'Exact date and time when the consent was granted.',
    `consent_type` STRING COMMENT 'Category of consent captured, indicating the purpose such as GDPR data processing, CCPA sale opt‑out, marketing communications, data sharing, or biometric usage.. Valid values are `gdpr_data_processing|ccpa_sale_opt_out|marketing_email|marketing_sms|data_sharing_partners|biometric_data`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first created in the system.',
    `data_category` STRING COMMENT 'High‑level classification of the data types covered by the consent.. Valid values are `personal|financial|biometric|behavioral|location`',
    `expiry_timestamp` TIMESTAMP COMMENT 'Optional expiry date/time after which the consent is no longer valid.',
    `ip_address` STRING COMMENT 'IP address of the device used at the moment of consent capture.',
    `legal_basis` STRING COMMENT 'Legal justification for processing under GDPR, such as consent or legitimate interest.. Valid values are `consent|legitimate_interest|contract|legal_obligation|vital_interests|public_task`',
    `scope_description` STRING COMMENT 'Free‑text description of the data processing activities covered by the consent.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the consent record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string recorded during consent collection.',
    `version` STRING COMMENT 'Version identifier of the consent text or policy that the cardholder agreed to.',
    `withdrawal_channel` STRING COMMENT 'Channel through which the consent was withdrawn.. Valid values are `web|mobile|pos|call_center|email`',
    `withdrawal_ip_address` STRING COMMENT 'IP address of the device used when consent was withdrawn.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Date and time when the cardholder withdrew the consent, if applicable.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Explicit consent and preference record for a cardholder covering data privacy, marketing, and regulatory consent obligations. Captures consent type (GDPR data processing, CCPA sale opt-out, marketing email, marketing SMS, data sharing with partners, biometric data), consent status (granted, withdrawn, pending), consent version, collection channel, IP address at consent time, and withdrawal timestamp. Provides the SSOT for all consent decisions required under GDPR, CCPA, and PSD2 open banking data sharing rules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` (
    `linked_account_id` BIGINT COMMENT 'Primary key for linked_account',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Funding source compliance: linking each external account to the partner bank that supplies the funds enables AML checks and settlement routing.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who owns this linked account.',
    `settlement_account_id` BIGINT COMMENT 'Foreign key linking to settlement.settlement_account. Business justification: In digital wallet and prepaid programs, an external linked_account (ACH/bank account) maps to an internal settlement_account for funding reconciliation and debit processing. Operations teams use this ',
    `account_category` STRING COMMENT 'Indicates whether the linked account is personal or business.. Valid values are `personal|business`',
    `account_holder_name` STRING COMMENT 'Full legal name of the person or entity that owns the linked account.',
    `account_nickname` STRING COMMENT 'User‑defined friendly name for the linked account.',
    `account_number_token` STRING COMMENT 'Tokenized representation of the external account number used for secure processing.',
    `account_type` STRING COMMENT 'Classification of the external account (e.g., checking, savings, brokerage).. Valid values are `checking|savings|brokerage|credit|debit`',
    `bank_name` STRING COMMENT 'Legal name of the financial institution that holds the linked account.',
    `bic` STRING COMMENT 'SWIFT BIC code of the bank that holds the linked account.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent AML/KYC compliance verification for the linked account.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance check for the linked account.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the linked account record was first created in the lakehouse.',
    `daily_debit_limit` DECIMAL(18,2) COMMENT 'Maximum total amount that can be debited from the linked account per calendar day.',
    `daily_debit_used` DECIMAL(18,2) COMMENT 'Cumulative amount debited from the linked account today.',
    `external_account_code` STRING COMMENT 'Original identifier of the account in the external financial institutions system.',
    `funding_method` STRING COMMENT 'Method used to verify and link the external account for funding.. Valid values are `micro_deposit|instant_verification|manual`',
    `iban` STRING COMMENT 'Standardized international bank account identifier for cross‑border linked accounts.',
    `is_primary_funding` BOOLEAN COMMENT 'Indicates whether this linked account is the default source for funding transactions.',
    `is_tokenized` BOOLEAN COMMENT 'Indicates whether the linked account details are stored as a tokenized value.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction that used this linked account as a funding source.',
    `risk_score` STRING COMMENT 'Numeric risk rating assigned to the linked account based on fraud models.',
    `routing_number_masked` STRING COMMENT 'Masked routing number of the external account, showing only the last 4 digits.',
    `source_channel` STRING COMMENT 'Origin of the account linking process (e.g., Plaid, Finicity, manual entry).. Valid values are `plaid|finicity|manual|other`',
    `token_service_provider` STRING COMMENT 'Name of the token service provider (TSP) that issued the token for this account.',
    `transaction_count` BIGINT COMMENT 'Total number of funding transactions executed against this linked account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the linked account record.',
    `verification_attempts` STRING COMMENT 'Number of verification attempts made for this linked account.',
    `verification_method` STRING COMMENT 'Method used to verify the linked account (e.g., micro‑deposit, instant verification, manual entry).. Valid values are `micro_deposit|instant|manual`',
    `verification_status` STRING COMMENT 'Current status of the account verification process.. Valid values are `unverified|pending|verified|failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful verification of the linked account.',
    CONSTRAINT pk_linked_account PRIMARY KEY(`linked_account_id`)
) COMMENT 'External bank account or financial account linked to a cardholder for funding, ACH pull, A2A transfer, or BNPL repayment purposes. Stores account type (checking, savings, brokerage), routing number (masked), account number token, bank name, account holder name, linking method (micro-deposit, instant verification via Plaid/Finicity, manual), verification status, and primary funding flag. Supports ACH debit authorization, IBAN/BIC for cross-border linked accounts, and open banking account aggregation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`device` (
    `device_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying a registered cardholder device.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: A device is registered by a specific cardholder; linking device to cardholder_profile eliminates the need for indirect look‑ups via events and enables direct device‑to‑profile queries.',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: Unified device profiling links registered cardholder device to its fraud fingerprint record for accurate risk scoring.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'When the most recent compliance assessment was performed.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance check (e.g., security posture, OS version).. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the device record was created in the system.',
    `device_name` STRING COMMENT 'Human‑readable name assigned by the cardholder to the device (e.g., John’s iPhone).',
    `device_type` STRING COMMENT 'Category of the device used for digital wallet or authentication.. Valid values are `ios|android|wearable|browser|other`',
    `dpan_provisioned` BOOLEAN COMMENT 'True if a Device Primary Account Number has been provisioned to the device.',
    `fingerprint_hash` STRING COMMENT 'Cryptographic hash representing the device fingerprint used for risk scoring.',
    `firmware_version` STRING COMMENT 'Version of the device firmware, if applicable.',
    `hce_capable` BOOLEAN COMMENT 'Indicates whether the device can perform Host Card Emulation for tokenized payments.',
    `imei` STRING COMMENT 'Unique hardware identifier for mobile devices, used for device tracking and fraud detection.',
    `ip_address` STRING COMMENT 'IP address observed during the last activity of the device.',
    `last_active_timestamp` TIMESTAMP COMMENT 'Most recent timestamp when the device was used for a transaction or authentication.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the device’s last known location (if available).',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the device’s last known location (if available).',
    `manufacturer` STRING COMMENT 'Company that manufactured the device (e.g., Apple, Samsung).',
    `model` STRING COMMENT 'Model identifier of the device (e.g., iPhone 13, Galaxy S22).',
    `nfc_capable` BOOLEAN COMMENT 'Indicates whether the device supports Near Field Communication for contactless payments.',
    `os_name` STRING COMMENT 'Name of the operating system running on the device (e.g., iOS, Android).',
    `os_version` STRING COMMENT 'Version string of the operating system (e.g., 16.4).',
    `push_notification_token` STRING COMMENT 'Token used to send push notifications to the device.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the device registration.. Valid values are `active|deactivated|suspended|pending`',
    `registration_timestamp` TIMESTAMP COMMENT 'Date and time when the device was first registered to the cardholder.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the device record.',
    `uuid` STRING COMMENT 'Universally unique identifier assigned to the device within the platform.',
    CONSTRAINT pk_device PRIMARY KEY(`device_id`)
) COMMENT 'Mobile device or hardware token registered by a cardholder for digital wallet provisioning, HCE (Host Card Emulation), NFC payments, or 3DS out-of-band authentication. Stores device type (iOS, Android, wearable, browser), device fingerprint hash, device name, OS version, NFC capability flag, HCE capability flag, device registration status (active, deactivated, suspended), DPAN provisioning status, and last active timestamp. Distinct from wallet domain device records — this entity owns the cardholder-device relationship and authentication eligibility.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` (
    `authentication_event_id` BIGINT COMMENT 'System-generated unique identifier for each authentication event record.',
    `device_id` BIGINT COMMENT 'Unique identifier of the device used for authentication.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Audit of authentication providers: each SCA event must record the authentication partner (e.g., 3DS provider) for SLA and dispute analysis.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder whose authentication was attempted.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Authentication events (3DS, biometric, OTP) are scheme-governed with distinct flows per scheme. Scheme-level authentication success/failure analytics, fraud liability shift reporting, and regulatory s',
    `score_event_id` BIGINT COMMENT 'Foreign key linking to fraud.score_event. Business justification: Fraud step-up authentication decisions and false-positive analysis require linking each authentication event to the fraud score event that evaluated it. Fraud operations teams use this link to tune mo',
    `attempt_number` STRING COMMENT 'Sequential number of the attempt within the current authentication session.',
    `authentication_channel` STRING COMMENT 'Channel through which the authentication request was made.. Valid values are `online|mobile|ivr|pos|api`',
    `authentication_factor` STRING COMMENT 'Specific factor used in the authentication (e.g., password, OTP, biometric).. Valid values are `password|otp|biometric_fingerprint|biometric_face|fido2_passkey|knowledge_based`',
    `authentication_method` STRING COMMENT 'Method used to authenticate the cardholder (e.g., password, OTP, biometric).',
    `authentication_outcome` STRING COMMENT 'Result of the authentication attempt.. Valid values are `success|failure|lockout`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authentication event record was first created in the lakehouse.',
    `device_type` STRING COMMENT 'Category of the device (e.g., mobile, desktop, POS terminal).',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the authentication attempt occurred.',
    `failure_reason` STRING COMMENT 'Reason for authentication failure when outcome is failure or lockout.',
    `geolocation_city` STRING COMMENT 'City inferred from the IP address or device location.',
    `ip_address` STRING COMMENT 'Source IP address from which the authentication request originated.',
    `latency_ms` STRING COMMENT 'Time in milliseconds between request receipt and response.',
    `lockout_flag` BOOLEAN COMMENT 'Indicates whether the cardholder account was locked as a result of this attempt.',
    `risk_flags` STRING COMMENT 'Pipe‑separated list of risk indicators (e.g., high_velocity|blacklist|suspicious_location).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk assessment generated by fraud detection engine for this attempt.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authentication event record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string presented during authentication.',
    CONSTRAINT pk_authentication_event PRIMARY KEY(`authentication_event_id`)
) COMMENT 'Record of each cardholder authentication attempt across all channels — online banking login, mobile app login, IVR PIN entry, card activation, and password reset. Captures authentication method (password, OTP, biometric fingerprint, biometric face, FIDO2 passkey, knowledge-based), authentication outcome (success, failure, lockout), failure reason, IP address, geolocation, device reference, session ID, and risk signal flags. Supports fraud detection correlation, account takeover (ATO) detection, and PCI DSS access control audit requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` (
    `cardholder_velocity_control_id` BIGINT COMMENT 'Unique surrogate key for the velocity control record.',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: cardholder_velocity_control explicitly describes per-account spending controls (per-cardholder or per-account). The existing cardholder_profile_id FK covers profile-level controls, but account-level',
    `limit_id` BIGINT COMMENT 'Foreign key linking to product.limit. Business justification: Cardholder velocity controls implement product-level limit definitions. Compliance and fraud teams reconcile cardholder-level controls against the product.limit records they enforce (daily, weekly, mo',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Merchant-scoped velocity controls are a real issuing feature: cardholders can have per-merchant spending limits (e.g., gambling, subscription merchants). Issuers enforce and report these controls at t',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Velocity controls on cardholder accounts are operationalized from risk policies. Compliance and audit teams must trace each velocity control back to its governing risk policy for regulatory examinatio',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder to whom this control applies.',
    `risk_rule_id` BIGINT COMMENT 'Foreign key linking to risk.risk_rule. Business justification: Each cardholder velocity control enforces a specific risk rule (e.g., max 5 transactions/hour). Fraud and risk operations teams need this link to audit which rule instantiated a velocity control, supp',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Velocity controls are frequently scheme-mandated (Mastercard contactless tap limits, Visa spend controls for prepaid). Linking velocity controls to a scheme enables scheme-specific limit enforcement, ',
    `cardholder_velocity_control_status` STRING COMMENT 'Current lifecycle status of the control.. Valid values are `active|inactive|suspended|pending|retired`',
    `channel_type` STRING COMMENT 'Payment channel to which the control applies (e.g., Card-Not-Present, Card-Present).. Valid values are `CNP|CP|ATM|online|mobile|pos`',
    `control_source` STRING COMMENT 'Origin of the control definition: issuer-set, cardholder self-service, or regulatory mandate.. Valid values are `issuer|cardholder|regulatory`',
    `control_type` STRING COMMENT 'Category of the velocity control (e.g., spending limit, transaction count, MCC restriction).. Valid values are `spending_limit|transaction_count|mcc_restriction|geographic_restriction|channel_restriction`',
    `control_version` STRING COMMENT 'Version number of the control for change tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was created.',
    `daily_spent_amount` DECIMAL(18,2) COMMENT 'Total amount spent by the cardholder today under this control.',
    `daily_transaction_count` STRING COMMENT 'Number of transactions performed today under this control.',
    `effective_from` DATE COMMENT 'Date when the control becomes effective.',
    `effective_until` DATE COMMENT 'Date when the control expires or is no longer applicable; null for indefinite.',
    `enforcement_priority` STRING COMMENT 'Numeric priority for rule evaluation when multiple controls apply; lower numbers have higher priority.',
    `is_exempted` BOOLEAN COMMENT 'Indicates if the cardholder is exempted from this control (e.g., corporate card).',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction evaluation against this control.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Monetary amount limit for the control (e.g., daily spend cap).',
    `limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the limit amount.. Valid values are `[A-Z]{3}`',
    `limit_period` STRING COMMENT 'Time window for the monetary limit.. Valid values are `daily|weekly|monthly|yearly`',
    `notes` STRING COMMENT 'Free-text field for additional information or business rationale.',
    `transaction_count_limit` STRING COMMENT 'Maximum number of transactions allowed in the defined period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `violation_count` STRING COMMENT 'Cumulative count of times the control was violated.',
    CONSTRAINT pk_cardholder_velocity_control PRIMARY KEY(`cardholder_velocity_control_id`)
) COMMENT 'Cardholder-level velocity and spending control configuration. Defines per-cardholder or per-account spending limits (daily, weekly, monthly), transaction count limits, single-transaction amount caps, MCC-level restrictions, geographic restrictions (allowed/blocked countries), channel restrictions (CNP, CP, ATM, online), and control source (issuer-set, cardholder self-service, regulatory mandate). Supports real-time authorization decisioning and parental/corporate card control programs. Each active control record represents a currently enforced rule.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ADD CONSTRAINT `fk_cardholder_cardholder_profile_account_holder_id` FOREIGN KEY (`account_holder_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`account_holder`(`account_holder_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ADD CONSTRAINT `fk_cardholder_address_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ADD CONSTRAINT `fk_cardholder_cardholder_kyc_verification_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ADD CONSTRAINT `fk_cardholder_kyc_document_cardholder_kyc_verification_id` FOREIGN KEY (`cardholder_kyc_verification_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification`(`cardholder_kyc_verification_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ADD CONSTRAINT `fk_cardholder_kyc_document_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ADD CONSTRAINT `fk_cardholder_pan_record_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ADD CONSTRAINT `fk_cardholder_payment_credential_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ADD CONSTRAINT `fk_cardholder_payment_credential_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ADD CONSTRAINT `fk_cardholder_cardholder_sca_challenge_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_pan_record_id` FOREIGN KEY (`pan_record_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`pan_record`(`pan_record_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ADD CONSTRAINT `fk_cardholder_cardholder_account_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ADD CONSTRAINT `fk_cardholder_account_status_history_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ADD CONSTRAINT `fk_cardholder_segment_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ADD CONSTRAINT `fk_cardholder_consent_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ADD CONSTRAINT `fk_cardholder_consent_consent_cardholder_profile_id` FOREIGN KEY (`consent_cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ADD CONSTRAINT `fk_cardholder_linked_account_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ADD CONSTRAINT `fk_cardholder_device_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_device_id` FOREIGN KEY (`device_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`device`(`device_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ADD CONSTRAINT `fk_cardholder_authentication_event_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_cardholder_account_id` FOREIGN KEY (`cardholder_account_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_account`(`cardholder_account_id`);
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ADD CONSTRAINT `fk_cardholder_cardholder_velocity_control_cardholder_profile_id` FOREIGN KEY (`cardholder_profile_id`) REFERENCES `payments_fintech_ecm`.`cardholder`.`cardholder_profile`(`cardholder_profile_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`cardholder` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`cardholder` SET TAGS ('dbx_domain' = 'cardholder');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `account_holder_status` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `account_holder_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|dormant|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `account_holder_type` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Type (INDIVIDUAL|BUSINESS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `account_holder_type` SET TAGS ('dbx_value_regex' = 'individual|business');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `avs_verified` SET TAGS ('dbx_business_glossary_term' = 'AVS Verification Result');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `business_category` SET TAGS ('dbx_business_glossary_term' = 'Business Category');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Closure Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `corporate_name` SET TAGS ('dbx_business_glossary_term' = 'Corporate Legal Name');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `corporate_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `corporate_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `cvv_last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CVV Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `cvv_last_used_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `cvv_last_used_timestamp` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `dpan` SET TAGS ('dbx_business_glossary_term' = 'Device Primary Account Number (DPAN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `dpan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `dpan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `failed_login_attempts` SET TAGS ('dbx_business_glossary_term' = 'Failed Login Attempts');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (GIVEN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Legal Name (FLN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|rejected');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `kyc_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `last_login_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Login Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (FAMILY)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality (Country of Citizenship)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `onboarding_channel` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `onboarding_channel` SET TAGS ('dbx_value_regex' = 'online|branch|partner|mobile_app|api');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `pan` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Number (PAN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `pan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `pan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `sca_compliance` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Code');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'tokenized|not_tokenized|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_holder` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `dcc_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `rate_margin_config_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Margin Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `account_lock_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Lock Flag (ACCOUNT_LOCKED)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDRESS_LINE2)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Verified Flag (ADDRESS_VERIFIED)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `address_verified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `cardholder_type` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Type (CARDHOLDER_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `cardholder_type` SET TAGS ('dbx_value_regex' = 'consumer|business|merchant|partner');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `completeness_score` SET TAGS ('dbx_business_glossary_term' = 'Profile Completeness Score (PROFILE_COMPLETENESS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp (CONSENT_AT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `created_by_system` SET TAGS ('dbx_business_glossary_term' = 'Created By System (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `data_retention_opt_out` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Opt‑Out Flag (RETENTION_OPT_OUT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `dpan_token` SET TAGS ('dbx_business_glossary_term' = 'Device Primary Account Number Token (DPAN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `dpan_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `dpan_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `email_verified` SET TAGS ('dbx_business_glossary_term' = 'Email Verified Flag (EMAIL_VERIFIED)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `email_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `email_verified` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `external_customer_code` SET TAGS ('dbx_business_glossary_term' = 'External Customer Identifier (EXTERNAL_CUST_ID)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score (FRAUD_RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender (GENDER)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|unspecified|prefer_not_to_say|other');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `is_test_account` SET TAGS ('dbx_business_glossary_term' = 'Test Account Indicator (IS_TEST_ACCOUNT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status (KYC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `last_modified_by_system` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By System (MODIFIED_BY)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending|deceased');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `marketing_consent_email` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent Email (MARKETING_EMAIL_CONSENT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `marketing_consent_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `marketing_consent_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `marketing_consent_sms` SET TAGS ('dbx_business_glossary_term' = 'Marketing Consent SMS (MARKETING_SMS_CONSENT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `pan_linked` SET TAGS ('dbx_business_glossary_term' = 'PAN Linked Indicator (PAN_LINKED)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `pan_linked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `pan_linked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel (PREF_COMM_CHANNEL)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|sms|push|phone|mail');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (PREFERRED_LANGUAGE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address (EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number (PHONE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_AT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `right_to_erasure_requested` SET TAGS ('dbx_business_glossary_term' = 'Right to Erasure Requested Flag (ERASURE_REQUESTED)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK_LEVEL)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `sca_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication Compliance Status (SCA_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `sca_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|crm|wallet|risk');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (TIME_ZONE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = 'UTC|EST|CST|PST|GMT|CET');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `total_failed_auth_attempts` SET TAGS ('dbx_business_glossary_term' = 'Total Failed Authentication Attempts (FAILED_AUTH_COUNT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_profile` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Profile Version Number (PROFILE_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Address ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status (AS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending_verification');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type (AT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'billing|shipping|residential|registered_business');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `avs_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'AVS Verified Flag (AVF)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `avs_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'AVS Verified Timestamp (AVT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geocode Latitude (GLAT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geocode Longitude (GLON)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag (PAF)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `label` SET TAGS ('dbx_business_glossary_term' = 'Address Label (AL)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (AL1)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (AL2)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3 (AL3)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `line3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (PC)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9 -]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (SP)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `verification_attempts` SET TAGS ('dbx_business_glossary_term' = 'Verification Attempts (VA)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source (VS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `verification_source` SET TAGS ('dbx_value_regex' = 'avs|kyc|manual');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VST)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`address` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `cardholder_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `aml_check_passed` SET TAGS ('dbx_business_glossary_term' = 'AML Check Passed');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `ctf_check_passed` SET TAGS ('dbx_business_glossary_term' = 'CTF Check Passed');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `document_hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `document_hash` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'passport|driver_license|national_id|utility_bill|bank_statement');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `is_sca_compliant` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `issued_at` SET TAGS ('dbx_business_glossary_term' = 'Verification Issued Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `reverification_count` SET TAGS ('dbx_business_glossary_term' = 'Reverification Count');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `sanctions_screened` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screened');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `score_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Score Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|branch|api');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_scan|biometric|database_check|eidv');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_provider` SET TAGS ('dbx_business_glossary_term' = 'Verification Provider');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Reference Number');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_score` SET TAGS ('dbx_business_glossary_term' = 'Verification Score');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_kyc_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|expired|manual_review');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `kyc_document_id` SET TAGS ('dbx_business_glossary_term' = 'KYC Document ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `cardholder_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum (SHA256)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'identity_proof|address_proof|financial_proof');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_image_uri` SET TAGS ('dbx_business_glossary_term' = 'Document Image URI');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_issue_place` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Place');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (Tokenized)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|drivers_license|utility_bill|bank_statement');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|jpg|png');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `kyc_document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `kyc_document_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|rejected');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `manual_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Outcome');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `manual_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|escalated');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `manual_review_status` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `manual_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|completed');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `ocr_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'OCR Confidence Score');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `ocr_status` SET TAGS ('dbx_business_glossary_term' = 'OCR Extraction Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `ocr_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'upload|api|mobile_app');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `tamper_detected` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detection Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`kyc_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'PAN Record ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `bin_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Sponsorship Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `bin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `bin` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pci_compliant|non_compliant');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'PAN Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `iin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identification Number (IIN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `iin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `iin` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary PAN Indicator');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `is_sca_compliant` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `last_four` SET TAGS ('dbx_business_glossary_term' = 'PAN Last Four Digits');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `masked_pan` SET TAGS ('dbx_business_glossary_term' = 'Masked PAN');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `masked_pan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `masked_pan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_format` SET TAGS ('dbx_business_glossary_term' = 'PAN Format');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_format` SET TAGS ('dbx_value_regex' = 'numeric|alphanumeric');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_length` SET TAGS ('dbx_business_glossary_term' = 'PAN Length');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_status` SET TAGS ('dbx_business_glossary_term' = 'PAN Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_status` SET TAGS ('dbx_value_regex' = 'active|blocked|expired|replaced|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_token` SET TAGS ('dbx_business_glossary_term' = 'PAN Token (Tokenized Primary Account Number)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_type` SET TAGS ('dbx_business_glossary_term' = 'PAN Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `pan_type` SET TAGS ('dbx_value_regex' = 'fpan|dpan');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'PAN Risk Score');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `token_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_value_regex' = 'tsp_a|tsp_b|tsp_c|internal|other');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'tsp|hce|dpan|other');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`pan_record` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'PAN Usage Count');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` SET TAGS ('dbx_subdomain' = 'payment_authentication');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `payment_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Credential ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'cvv|pin|biometric|otp|none');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_enabled_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_enabled_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_type` SET TAGS ('dbx_business_glossary_term' = 'Biometric Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_type` SET TAGS ('dbx_value_regex' = 'fingerprint|face|iris|voice');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `biometric_type` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `contactless_nfc_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Contactless NFC Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_label` SET TAGS ('dbx_business_glossary_term' = 'Credential Label');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_source_system` SET TAGS ('dbx_business_glossary_term' = 'Credential Source System');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'card|token|digital_wallet|virtual_card');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `credential_version` SET TAGS ('dbx_business_glossary_term' = 'Credential Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `cvv2_validation_flag` SET TAGS ('dbx_business_glossary_term' = 'CVV2 Validation Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `cvv_hash_ref` SET TAGS ('dbx_business_glossary_term' = 'CVV Hash Reference');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `cvv_hash_ref` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `cvv_hash_ref` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `emv_chip_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'EMV Chip Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `external_credential_code` SET TAGS ('dbx_business_glossary_term' = 'External Credential Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `hsm_key_reference` SET TAGS ('dbx_business_glossary_term' = 'HSM Key Reference');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `hsm_key_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Issuance Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `last_rotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Rotation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `otp_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'OTP Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `otp_last_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OTP Last Sent Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pan_linkage_status` SET TAGS ('dbx_business_glossary_term' = 'PAN Linkage Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pan_linkage_status` SET TAGS ('dbx_value_regex' = 'linked|unlinked|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pin_last_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'PIN Last Change Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pin_offset` SET TAGS ('dbx_business_glossary_term' = 'PIN Offset');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pin_offset` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `pin_offset` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `sca_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `sca_compliance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `three_ds_enrollment_status` SET TAGS ('dbx_business_glossary_term' = '3‑DS Enrollment Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `three_ds_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|not_enrolled|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `three_ds_method` SET TAGS ('dbx_business_glossary_term' = '3‑DS Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `three_ds_method` SET TAGS ('dbx_value_regex' = 'otp|biometric|out_of_band|none');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `tokenization_status` SET TAGS ('dbx_value_regex' = 'tokenized|not_tokenized');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`payment_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` SET TAGS ('dbx_subdomain' = 'payment_authentication');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `cardholder_sca_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Challenge ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `auth_3ds_result_id` SET TAGS ('dbx_business_glossary_term' = 'Auth 3Ds Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `device_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `threeds_config_id` SET TAGS ('dbx_business_glossary_term' = 'Threeds Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `acs_reference` SET TAGS ('dbx_business_glossary_term' = 'Access Control Server (ACS) Reference');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `authentication_value` SET TAGS ('dbx_business_glossary_term' = 'Authentication Value (CAVV/AAV)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `authentication_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `authentication_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'Challenge Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'ISSUED|PASSED|FAILED|EXPIRED|BYPASSED');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `challenge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Challenge Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_business_glossary_term' = 'Challenge Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `challenge_type` SET TAGS ('dbx_value_regex' = 'OTP_SMS|OTP_EMAIL|BIOMETRIC|PUSH_NOTIFICATION|OUT_OF_BAND');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `eci_indicator` SET TAGS ('dbx_business_glossary_term' = 'Electronic Commerce Indicator (ECI)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `eci_indicator` SET TAGS ('dbx_value_regex' = '00|01|02|05');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Reason');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_value_regex' = 'LOW_VALUE|TRANSACTION_RISK_ANALYSIS|MERCHANT_INITIATED|OTHER');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Challenge Success Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Challenge Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `three_ds_version` SET TAGS ('dbx_business_glossary_term' = '3‑DS Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `three_ds_version` SET TAGS ('dbx_value_regex' = '2.0|2.1|2.2');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_sca_challenge` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `a2a_product_id` SET TAGS ('dbx_business_glossary_term' = 'A2A Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `bin_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Sponsorship Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `funding_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi Network Routing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `p2p_product_id` SET TAGS ('dbx_business_glossary_term' = 'P2P Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `product_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `virtual_account_product_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (ACC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|delinquent|charged_off|closed|suspended');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier (ACC_TIER)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'standard|gold|platinum|enterprise');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (ACC_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|bnpl');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `billing_cycle_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Day (BILL_DAY)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date (CLOSE_DT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `currency_conversion_flag` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Support Flag (CUR_CONV_FLG)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance (CUR_BAL)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `delinquency_status` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Status (DLQ_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `delinquency_status` SET TAGS ('dbx_value_regex' = 'none|30_days|60_days|90_days|120_days|write_off');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score (FRAUD_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate (INT_RATE)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `is_overlimit` SET TAGS ('dbx_business_glossary_term' = 'Overlimit Flag (OVERLIMIT_FLG)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `is_suspended` SET TAGS ('dbx_business_glossary_term' = 'Account Suspension Flag (SUSP_FLG)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status (KYC_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `last_fraud_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Fraud Review Timestamp (FRAUD_REVIEW_TS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount (LAST_PMT_AMT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date (LAST_PMT_DT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp (STATUS_CHG_TS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `minimum_payment_due` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Due (MIN_PMT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date (OPEN_DT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `pan_linked` SET TAGS ('dbx_business_glossary_term' = 'PAN Linked Flag (PAN_LINKED)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Amount (PMT_DUE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date (PMT_DUE_DT)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT_FLG)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `reward_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Reward Program Participation Flag (REWARD_FLG)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `sca_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Flag (SCA_FLG)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|core|wallet|crm');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `account_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Account Status History ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `correlation_code` SET TAGS ('dbx_business_glossary_term' = 'Correlation ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `initiating_actor` SET TAGS ('dbx_business_glossary_term' = 'Initiating Actor');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `initiating_actor` SET TAGS ('dbx_value_regex' = 'system|agent|cardholder');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|processing|fraud|wallet|compliance');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `status_after` SET TAGS ('dbx_business_glossary_term' = 'New Account Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `status_after` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending|restricted|terminated');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `status_before` SET TAGS ('dbx_business_glossary_term' = 'Previous Account Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`account_status_history` ALTER COLUMN `status_before` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending|restricted|terminated');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Segment ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Segment ML Model ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Rule ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_assigned|manual');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `audience` SET TAGS ('dbx_business_glossary_term' = 'Segment Audience');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `audience` SET TAGS ('dbx_value_regex' = 'consumer|business|both');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `criteria_definition` SET TAGS ('dbx_business_glossary_term' = 'Criteria Definition');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `criteria_version` SET TAGS ('dbx_business_glossary_term' = 'Criteria Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Segment');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Segment Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Segment Priority');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Segment Region');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Segment Score');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Tier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_value_regex' = 'mass_market|premium|ultra_premium|smb|corporate');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `segment_type` SET TAGS ('dbx_value_regex' = 'spend|risk|loyalty|product');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` SET TAGS ('dbx_subdomain' = 'identity_management');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Consent ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Collection Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `collection_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|call_center|email');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'granted|withdrawn|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'gdpr_data_processing|ccpa_sale_opt_out|marketing_email|marketing_sms|data_sharing_partners|biometric_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `data_category` SET TAGS ('dbx_business_glossary_term' = 'Data Category');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `data_category` SET TAGS ('dbx_value_regex' = 'personal|financial|biometric|behavioral|location');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_value_regex' = 'consent|legitimate_interest|contract|legal_obligation|vital_interests|public_task');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope Description');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `withdrawal_channel` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `withdrawal_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|call_center|email');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `withdrawal_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal IP Address');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `withdrawal_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `withdrawal_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`consent` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` SET TAGS ('dbx_subdomain' = 'account_operations');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `linked_account_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_category` SET TAGS ('dbx_value_regex' = 'personal|business');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name (PII)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_nickname` SET TAGS ('dbx_business_glossary_term' = 'Account Nickname');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_number_token` SET TAGS ('dbx_business_glossary_term' = 'Account Number Token (PCI)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_number_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_number_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|brokerage|credit|debit');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `bic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `bic` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `daily_debit_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Debit Limit');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `daily_debit_used` SET TAGS ('dbx_business_glossary_term' = 'Daily Debit Used');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `external_account_code` SET TAGS ('dbx_business_glossary_term' = 'External Account Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `external_account_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `external_account_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `funding_method` SET TAGS ('dbx_business_glossary_term' = 'Funding Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `funding_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|instant_verification|manual');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `is_primary_funding` SET TAGS ('dbx_business_glossary_term' = 'Primary Funding Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `routing_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Routing Number (Masked) (PCI)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `routing_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `routing_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'plaid|finicity|manual|other');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `verification_attempts` SET TAGS ('dbx_business_glossary_term' = 'Verification Attempts');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|instant|manual');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|pending|verified|failed');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`linked_account` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` SET TAGS ('dbx_subdomain' = 'payment_authentication');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Device ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Device Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'ios|android|wearable|browser|other');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `dpan_provisioned` SET TAGS ('dbx_business_glossary_term' = 'DPAN Provisioning Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Hash');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Device Firmware Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `hce_capable` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `imei` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Device IP Address');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `last_active_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Active Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Last Known Latitude');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Last Known Longitude');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'Device Model');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `nfc_capable` SET TAGS ('dbx_business_glossary_term' = 'NFC Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `os_name` SET TAGS ('dbx_business_glossary_term' = 'Operating System Name');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `push_notification_token` SET TAGS ('dbx_business_glossary_term' = 'Push Notification Token');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|deactivated|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `registration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `uuid` SET TAGS ('dbx_business_glossary_term' = 'Device UUID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `uuid` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`device` ALTER COLUMN `uuid` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` SET TAGS ('dbx_subdomain' = 'payment_authentication');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_event_id` SET TAGS ('dbx_business_glossary_term' = 'Authentication Event ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `device_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Auth Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `score_event_id` SET TAGS ('dbx_business_glossary_term' = 'Score Event Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_channel` SET TAGS ('dbx_business_glossary_term' = 'Authentication Channel');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|ivr|pos|api');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_factor` SET TAGS ('dbx_business_glossary_term' = 'Authentication Factor');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_factor` SET TAGS ('dbx_value_regex' = 'password|otp|biometric_fingerprint|biometric_face|fido2_passkey|knowledge_based');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_outcome` SET TAGS ('dbx_business_glossary_term' = 'Authentication Outcome');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `authentication_outcome` SET TAGS ('dbx_value_regex' = 'success|failure|lockout');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_business_glossary_term' = 'Geolocation City');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `geolocation_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Authentication Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `lockout_flag` SET TAGS ('dbx_business_glossary_term' = 'Lockout Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `risk_flags` SET TAGS ('dbx_business_glossary_term' = 'Risk Flags');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`authentication_event` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` SET TAGS ('dbx_subdomain' = 'payment_authentication');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_velocity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Limit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_velocity_control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `cardholder_velocity_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'CNP|CP|ATM|online|mobile|pos');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `control_source` SET TAGS ('dbx_business_glossary_term' = 'Control Source');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `control_source` SET TAGS ('dbx_value_regex' = 'issuer|cardholder|regulatory');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'spending_limit|transaction_count|mcc_restriction|geographic_restriction|channel_restriction');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `control_version` SET TAGS ('dbx_business_glossary_term' = 'Control Version');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `daily_spent_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Spent Amount');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `daily_spent_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `daily_spent_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `daily_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `enforcement_priority` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Priority');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `is_exempted` SET TAGS ('dbx_business_glossary_term' = 'Is Exempted Flag');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Limit Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_currency` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_period` SET TAGS ('dbx_business_glossary_term' = 'Limit Period');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `limit_period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|yearly');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `transaction_count_limit` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count Limit');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`cardholder`.`cardholder_velocity_control` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count');
