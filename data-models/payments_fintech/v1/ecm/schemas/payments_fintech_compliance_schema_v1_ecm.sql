-- Schema for Domain: compliance | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`compliance` COMMENT 'Enterprise regulatory compliance domain owning AML screening results, OFAC/SDN sanctions checks, SAR and STR filings, CTF controls, BSA compliance records, PSD2 regulatory reporting, PCI DSS audit trails, GDPR data subject rights, and regulatory examination support. SSOT for regulatory obligations, FinCEN reporting, and compliance attestations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` (
    `compliance_aml_screening_result_id` BIGINT COMMENT 'System-generated unique identifier for each AML screening result record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Needed for AML reporting to map residence country to standardized country reference for regulatory filings.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Regulatory AML screening reports are generated per wallet account; linking enables reporting and audit of wallet‑specific AML outcomes.',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the screened entity (transaction, cardholder, merchant, or partner).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Internal AML screening of employees; link needed to identify screened staff for SAR reporting.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: AML screening results are governed by a regulatory obligation; linking enables obligation‑centric reporting.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: AML screening result must be traceable to the originating gateway request for audit and regulatory reporting.',
    `analyst_override_flag` BOOLEAN COMMENT 'Indicates whether an analyst manually overrode the automated disposition.',
    `analyst_override_reason` STRING COMMENT 'Free‑text explanation provided by the analyst for the override.',
    `compliance_aml_screening_result_status` STRING COMMENT 'Current lifecycle status of the screening result record.. Valid values are `active|inactive|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening result record was first created in the data lake.',
    `customer_name` STRING COMMENT 'Legal full name of the individual associated with the screened entity.',
    `disposition` STRING COMMENT 'Outcome of the screening: pass, requires manual review, or block.. Valid values are `pass|review|block`',
    `entity_type` STRING COMMENT 'Type of business entity that was screened.. Valid values are `transaction|cardholder|merchant|partner`',
    `is_sar_required` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report (SAR) must be filed.',
    `is_str_required` BOOLEAN COMMENT 'Indicates whether a Suspicious Transaction Report (STR) must be filed.',
    `match_type` STRING COMMENT 'Category of data element that triggered a match during screening.. Valid values are `none|name|address|email|phone|sanctions`',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the screening.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the AML engine (0.00 – 100.00).',
    `sar_filing_status` STRING COMMENT 'Current status of the SAR filing process.. Valid values are `not_required|pending|filed|rejected`',
    `sar_filing_timestamp` TIMESTAMP COMMENT 'Date and time when the SAR was filed, if applicable.',
    `screening_engine` STRING COMMENT 'Name of the AML screening engine or vendor used (e.g., World-Check, LexisNexis).',
    `screening_rule_version` STRING COMMENT 'Version identifier of the rule set applied during the screening.',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the AML screening was performed.',
    `source_module` STRING COMMENT 'Specific module or component within the source system that executed the screening.',
    `source_system` STRING COMMENT 'Name of the system that generated the screening result (e.g., Risk and Compliance Management System).',
    `str_filing_status` STRING COMMENT 'Current status of the STR filing process.. Valid values are `not_required|pending|filed|rejected`',
    `str_filing_timestamp` TIMESTAMP COMMENT 'Date and time when the STR was filed, if applicable.',
    `typology` STRING COMMENT 'AML typology or pattern identified (e.g., structuring, smurfing, terrorist financing).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the screening result record.',
    CONSTRAINT pk_compliance_aml_screening_result PRIMARY KEY(`compliance_aml_screening_result_id`)
) COMMENT 'SSOT for Anti-Money Laundering screening outcomes. Records each AML screening event against a transaction, cardholder, or merchant entity — including the screening engine used, risk score assigned, matched typology, disposition (pass/review/block), analyst override, and regulatory obligation reference. Sourced from the Risk and Compliance Management System AML module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` (
    `sanctions_check_id` BIGINT COMMENT 'Unique identifier for each sanctions screening event.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Sanctions screening is performed on each wallet; FK provides direct traceability for compliance investigations and regulator filings.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the party (cardholder, merchant, partner, beneficiary) screened.',
    `employee_id` BIGINT COMMENT 'Name of the compliance officer responsible for reviewing the hit.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Sanctions screening must record which payment product was used to support product‑level risk analytics.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with this screening, if applicable.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Enables linking sanction checks to jurisdiction metadata for compliance reporting and risk scoring.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch in which the screening was executed, if applicable.',
    `watchlist_entry_id` BIGINT COMMENT 'Foreign key linking to compliance.watchlist_entry. Business justification: Sanctions checks reference entries in the watchlist master; linking provides source of the hit.',
    `block_action_taken` STRING COMMENT 'Action taken as a result of the hit (e.g., blocked transaction, allowed, sent for review).. Valid values are `blocked|allowed|review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sanctions check record was first created.',
    `false_positive_flag` BOOLEAN COMMENT 'Indicates whether the hit was later determined to be a false positive.',
    `hit_details` STRING COMMENT 'Details of the matched sanctioned entity (e.g., name, address).',
    `hit_indicator` BOOLEAN COMMENT 'True if the screening produced a potential match against the sanctions list.',
    `is_critical` BOOLEAN COMMENT 'True if the screening result is considered high‑risk and requires immediate attention.',
    `list_name` STRING COMMENT 'Name of the sanctions list used for the screening (e.g., OFAC SDN, EU Consolidated, UN).',
    `list_version` STRING COMMENT 'Version identifier of the sanctions list at the time of screening.',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0‑100) indicating the strength of the match.',
    `notes` STRING COMMENT 'Free‑form notes added by analysts or reviewers.',
    `party_type` STRING COMMENT 'Classification of the screened party.. Valid values are `cardholder|merchant|partner|beneficiary`',
    `reporting_obligation` STRING COMMENT 'Regulatory filing triggered by the hit (Suspicious Activity Report, Suspicious Transaction Report, or None).. Valid values are `SAR|STR|None`',
    `reporting_obligation_filed` BOOLEAN COMMENT 'True if the required regulatory report was filed.',
    `review_decision` STRING COMMENT 'Outcome of the compliance review.. Valid values are `accept|reject|escalate`',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance officer completed the review.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score combining match score and other risk factors.',
    `screening_method` STRING COMMENT 'Algorithmic method used for the screening.. Valid values are `exact_match|fuzzy_match`',
    `screening_source` STRING COMMENT 'System or module that executed the screening (e.g., Risk and Compliance Management System).',
    `screening_status` STRING COMMENT 'Current processing status of the screening.. Valid values are `completed|pending|error`',
    `screening_timestamp` TIMESTAMP COMMENT 'Exact date and time when the sanctions screening was performed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sanctions check record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_sanctions_check PRIMARY KEY(`sanctions_check_id`)
) COMMENT 'Records each OFAC/SDN and global sanctions screening event performed against a party (cardholder, merchant, partner, beneficiary). Captures the list version screened (SDN, EU Consolidated, UN), match score, hit details, false-positive determination, blocking action taken, and OFAC reporting obligation triggered. SSOT for sanctions screening history.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` (
    `sar_filing_id` BIGINT COMMENT 'Unique identifier for the SAR filing record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Standardizes currency for SAR filing amounts, supporting multi‑currency reporting and conversion.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer who filed the SAR.',
    `filing_officer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer who filed the SAR.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: SAR filings often relate to a specific payment product (e.g., card vs ACH) for product‑level AML reporting.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Provides authoritative jurisdiction reference for SAR filing jurisdiction field, required for regulator reports.',
    `compliance_case_id` BIGINT COMMENT 'Identifier of a related internal case or investigation.',
    `related_compliance_case_id` BIGINT COMMENT 'Identifier of a related internal case or investigation.',
    `activity_end_date` DATE COMMENT 'Date when the suspicious activity ended.',
    `activity_start_date` DATE COMMENT 'Date when the suspicious activity began.',
    `activity_type` STRING COMMENT 'Categorization of the suspicious activity.. Valid values are `money_laundering|fraud|terrorist_financing|structuring|smurfing|other`',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment for this SAR.',
    `amount_involved` DECIMAL(18,2) COMMENT 'Total monetary value associated with the suspicious activity.',
    `attachment_reference` STRING COMMENT 'Reference to supporting documents attached to the filing.',
    `compliance_review_date` TIMESTAMP COMMENT 'Timestamp when the compliance review was completed.',
    `compliance_review_status` STRING COMMENT 'Status of the internal compliance review of the SAR.. Valid values are `pending|completed|escalated`',
    `confidentiality_level` STRING COMMENT 'Classification level indicating data sensitivity.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SAR record was first created in the data lake.',
    `data_retention_expiry` DATE COMMENT 'Date after which the SAR record must be purged per retention policy.',
    `filing_date` TIMESTAMP COMMENT 'Timestamp when the SAR was submitted to the regulator.',
    `filing_number` STRING COMMENT 'External tracking number assigned by BSA for the filing.',
    `filing_officer_name` STRING COMMENT 'Full name of the officer responsible for the filing.',
    `filing_status` STRING COMMENT 'Current processing status of the SAR with the regulator.. Valid values are `submitted|accepted|rejected|under_review|closed`',
    `is_amended` BOOLEAN COMMENT 'True if this filing is an amendment to a prior SAR.',
    `is_high_risk` BOOLEAN COMMENT 'Indicates whether the filing is flagged as high risk.',
    `narrative_summary` STRING COMMENT 'Free‑text narrative describing the suspicious activity.',
    `notes` STRING COMMENT 'Free‑form field for any additional remarks.',
    `regulatory_body` STRING COMMENT 'Regulatory authority to which the SAR was submitted.. Valid values are `FinCEN|OFAC|FCA|ECB|Other|Unknown`',
    `risk_score` STRING COMMENT 'Numeric risk score generated by the compliance scoring engine.',
    `source_system` STRING COMMENT 'Originating system that generated the SAR (e.g., FraudDetectionPlatform).',
    `subject_address` STRING COMMENT 'Physical address of the subject entity.',
    `subject_country_code` STRING COMMENT 'Three‑letter ISO country code of the subjects residence.. Valid values are `^[A-Z]{3}$`',
    `subject_entity_name` STRING COMMENT 'Legal name of the individual or organization subject to the SAR.',
    `subject_entity_type` STRING COMMENT 'Classification of the subject entity.. Valid values are `individual|organization|trust|partnership|other`',
    `subject_identifier` STRING COMMENT 'Government or tax identifier of the subject (e.g., SSN, EIN).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SAR record.',
    CONSTRAINT pk_sar_filing PRIMARY KEY(`sar_filing_id`)
) COMMENT 'Suspicious Activity Report filing record — the authoritative record of each SAR submitted to FinCEN or equivalent regulator. Captures the subject entity, suspicious activity type, activity date range, filing date, BSA tracking number, narrative summary, filing officer, and acknowledgement receipt. Supports regulatory examination and audit trail requirements under BSA.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`str_filing` (
    `str_filing_id` BIGINT COMMENT 'System-generated unique identifier for each STR filing.',
    `compliance_case_id` BIGINT COMMENT 'Reference to the internal investigation case associated with the filing.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Ensures STR filing amounts use a normalized currency reference for cross‑border reporting.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the legal entity that submitted the filing.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: STR filings need the payment product context to assess transaction‑type risk and regulatory metrics.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Links STR filing jurisdiction to reference jurisdiction for consistent regulatory reporting.',
    `acknowledgment_number` STRING COMMENT 'Unique identifier returned by the regulator confirming receipt of the filing.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date‑time the regulator confirmed receipt of the filing.',
    `aml_flag` BOOLEAN COMMENT 'True if the filing is primarily driven by AML considerations.',
    `compliance_officer` STRING COMMENT 'Name or identifier of the compliance officer overseeing the filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the filing record was initially captured.',
    `ctf_flag` BOOLEAN COMMENT 'True if the filing involves potential counter‑terrorism financing concerns.',
    `description_of_suspicion` STRING COMMENT 'Free‑text narrative explaining the reasons for suspicion.',
    `filing_date` DATE COMMENT 'The calendar date on which the filing was officially submitted to the regulator.',
    `filing_reference_number` STRING COMMENT 'External reference number assigned by the regulator or internal system for the filing.',
    `filing_type` STRING COMMENT 'Classification of the filing according to the governing regulatory regime.. Valid values are `FATF|FCA|AUSTRAC|MAS|FINCEN`',
    `is_high_risk` BOOLEAN COMMENT 'True if the filing has been escalated as high risk.',
    `notes` STRING COMMENT 'Supplementary comments or observations added by compliance analysts.',
    `prior_filing_reference` STRING COMMENT 'Identifier of an earlier filing that this record amends or follows up.',
    `regulator_name` STRING COMMENT 'The regulatory authority (e.g., FCA, AUSTRAC) to which the STR is filed.',
    `reporting_entity_name` STRING COMMENT 'Full legal name of the organization filing the STR.',
    `source_system` STRING COMMENT 'Name of the operational system of record that originated the filing.. Valid values are `Risk_Comp_Mgmt|Fraud_Detection|Transaction_Processing`',
    `str_filing_status` STRING COMMENT 'Current processing state of the STR filing.. Valid values are `draft|submitted|acknowledged|rejected|closed`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date‑time the filing was transmitted to the regulator.',
    `suspicious_indicator_codes` STRING COMMENT 'Pipe‑separated list of indicator codes that describe why the transaction is considered suspicious. [ENUM-REF-CANDIDATE: AML|CTF|STRUCTURING|SMURFING|UNUSUAL_ACTIVITY|OTHER — promote to reference product]',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Financial amount involved in the suspicious transaction.',
    `transaction_date` DATE COMMENT 'Calendar date on which the suspicious transaction occurred.',
    `transaction_reference` STRING COMMENT 'Identifier of the transaction that triggered the suspicious activity report (e.g., ARN, MID).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the filing record.',
    CONSTRAINT pk_str_filing PRIMARY KEY(`str_filing_id`)
) COMMENT 'Suspicious Transaction Report filing record for jurisdictions outside the US (e.g., FCA UK, AUSTRAC, MAS Singapore). Captures the reporting entity, subject transaction references, suspicious indicators, filing date, regulator acknowledgement number, and cross-border CTF flags. Distinct from SAR due to differing regulatory schemas and jurisdictional requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` (
    `compliance_kyc_verification_id` BIGINT COMMENT 'Unique identifier for the KYC verification record.',
    `kyc_document_type_id` BIGINT COMMENT 'Foreign key linking to reference.kyc_document_type. Business justification: Connects KYC verification document type to reference catalog for validation and audit trails.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: KYC verification outcome is tied to the specific merchant integration configuration used during onboarding.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: KYC verification rules differ by payment product; linking enables product‑specific KYC enforcement.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: KYC verification references the sanctions check performed for the same entity; linking provides audit trail.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: KYC verification records must be linked to the settlement participant (bank) they pertain to for AML compliance reporting.',
    `aml_screening_result` STRING COMMENT 'Result of AML screening for the party.. Valid values are `clear|match|pending|exempt|unknown`',
    `cdd_classification` STRING COMMENT 'Indicates whether standard (CDD) or enhanced (EDD) due diligence was applied.. Valid values are `cdd|edd|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the KYC verification record was created in the system.',
    `document_expiry_date` DATE COMMENT 'Expiration date of the identity document.',
    `document_issue_date` DATE COMMENT 'Date the identity document was issued.',
    `document_issuing_country` STRING COMMENT 'Three-letter ISO country code of the issuing authority.. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'Identifier number of the presented document.',
    `full_name` STRING COMMENT 'Legal full name of the individual or entity being verified.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the verification record is currently active.',
    `kyc_entity_type` STRING COMMENT 'Classification of the party being verified.. Valid values are `individual|business|sole_proprietor|non_profit|government|other`',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or observations.',
    `primary_contact_type` STRING COMMENT 'Method of primary contact used for KYC communication.. Valid values are `email|phone|mobile|other`',
    `primary_contact_value` DECIMAL(18,2) COMMENT 'Primary contact detail (email address) used for KYC communication.',
    `provider_reference_code` STRING COMMENT 'Reference identifier assigned by the verification provider.',
    `re_verification_due_date` DATE COMMENT 'Date by which the KYC must be refreshed or re‑verified.',
    `risk_tier` STRING COMMENT 'Risk classification assigned based on KYC results.. Valid values are `low|medium|high|critical`',
    `sanctions_check_result` STRING COMMENT 'Result of OFAC/SDN sanctions screening.. Valid values are `clear|match|pending|exempt|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the KYC verification record.',
    `verification_method` STRING COMMENT 'Method used to perform the KYC verification.. Valid values are `document|biometric|database_lookup|third_party|manual`',
    `verification_outcome` STRING COMMENT 'Result of the verification after processing.. Valid values are `pass|fail|partial|pending`',
    `verification_provider` STRING COMMENT 'Name of the third‑party provider performing verification.',
    `verification_status` STRING COMMENT 'Current status of the KYC verification process.. Valid values are `pending|passed|failed|under_review|rejected`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when verification was completed.',
    CONSTRAINT pk_compliance_kyc_verification PRIMARY KEY(`compliance_kyc_verification_id`)
) COMMENT 'Know Your Customer identity verification record for cardholders, merchants, and business entities. Captures verification method (document check, biometric, database lookup), identity document type and number, verification provider, outcome (pass/fail/pending), risk tier assigned, re-verification due date, and CDD/EDD classification. SSOT for KYC status across the platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory obligation record.',
    `amendment_indicator` BOOLEAN COMMENT 'True if the obligation has been amended since its original issuance.',
    `classification` STRING COMMENT 'Indicates whether compliance with the obligation is mandatory, optional, or voluntary.. Valid values are `mandatory|optional|voluntary`',
    `compliance_status` STRING COMMENT 'Current compliance outcome for the obligation.. Valid values are `compliant|non_compliant|partial`',
    `control_owner` STRING COMMENT 'Business unit, department, or role responsible for ensuring compliance with the obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was first created in the lakehouse.',
    `document_url` STRING COMMENT 'Link to the official regulatory document or guidance.',
    `effective_from` DATE COMMENT 'Date on which the obligation becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the obligation expires or is superseded (null if open‑ended).',
    `enforcement_penalty` STRING COMMENT 'Description of penalties, fines, or sanctions associated with non‑compliance.',
    `governing_body` STRING COMMENT 'Name of the authority that issued the obligation (e.g., PCI Security Standards Council, EU PSD2, OFAC).',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the jurisdiction to which the obligation applies.. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date when the obligation was most recently reviewed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the obligation (active, inactive, pending, retired).. Valid values are `active|inactive|pending|retired`',
    `next_review_date` DATE COMMENT 'Planned date for the next compliance review.',
    `obligation_code` STRING COMMENT 'Short alphanumeric code used internally to reference the obligation.. Valid values are `^[A-Z0-9_-]+$`',
    `obligation_name` STRING COMMENT 'Human‑readable name of the regulatory obligation as defined by the governing body.',
    `regulation_type` STRING COMMENT 'Category of the regulatory instrument (law, directive, standard, or guideline).. Valid values are `law|directive|standard|guideline`',
    `regulatory_obligation_description` STRING COMMENT 'Full textual description of the regulatory requirement, including scope and key provisions.',
    `review_cadence` STRING COMMENT 'Frequency at which the obligation is reviewed for relevance and compliance.. Valid values are `annual|biannual|quarterly|monthly`',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the obligation based on potential impact and likelihood of non‑compliance.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating operational system that supplied the obligation record (e.g., Risk and Compliance Management System).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    `version_number` STRING COMMENT 'Version identifier of the obligation (e.g., v1.0, v2.3).. Valid values are `^vd+.d+$`',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master registry of all regulatory obligations applicable to the business — laws, directives, rules, and standards (PCI DSS, PSD2, BSA, GDPR, CCPA, Reg E, Reg II, OFAC, SOX). Each record defines the obligation name, governing body, jurisdiction, effective date, applicability scope, control owner, and review cadence. Serves as the compliance obligation inventory for control mapping.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`control` (
    `control_id` BIGINT COMMENT 'Unique system-generated identifier for the compliance control.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Compliance control budgeting uses cost centers for internal financial reporting; linking enables allocation of control costs to the appropriate cost center.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Posting expenses or adjustments from compliance activities requires a GL account; this FK supports accurate financial statements and audit trails.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Control ownership assigned to a specific employee; needed for control accountability reports.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Control ownership tied to org unit; needed for departmental responsibility reporting.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each compliance control implements one or more regulatory obligations; linking provides direct mapping.',
    `audit_trail` STRING COMMENT 'Reference to audit log entries related to the control.',
    `control_code` STRING COMMENT 'Unique business code used to reference the control across systems.',
    `control_description` STRING COMMENT 'Detailed description of the controls purpose and scope.',
    `control_name` STRING COMMENT 'Human‑readable name of the compliance control.',
    `control_scope` STRING COMMENT 'Business area or process that the control applies to.',
    `control_status` STRING COMMENT 'Current lifecycle status of the control.. Valid values are `active|inactive|retired|pending`',
    `control_type` STRING COMMENT 'Classification of the control based on its nature: preventive, detective, or corrective.. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was created in the system.',
    `criticality` STRING COMMENT 'Criticality level of the control for business continuity.. Valid values are `critical|high|medium|low`',
    `effective_from` DATE COMMENT 'Date when the control becomes effective.',
    `effective_until` DATE COMMENT 'Date when the control expires or is superseded, if applicable.',
    `evidence_collected` BOOLEAN COMMENT 'True if required evidence has been collected for the latest assessment.',
    `evidence_required` STRING COMMENT 'Description of the evidence needed to demonstrate control execution.',
    `evidence_url` STRING COMMENT 'Link to the stored evidence artifact.',
    `frequency` STRING COMMENT 'How often the control is performed or reviewed.. Valid values are `annual|quarterly|monthly|ad_hoc|weekly|daily`',
    `is_automated` BOOLEAN COMMENT 'True if the control is performed automatically by systems.',
    `is_key_control` BOOLEAN COMMENT 'Indicates whether the control is considered a key control for regulatory reporting.',
    `is_manual` BOOLEAN COMMENT 'True if the control requires manual execution.',
    `last_assessment_date` DATE COMMENT 'Date of the most recent assessment of the control.',
    `last_assessment_result` STRING COMMENT 'Outcome of the most recent control assessment.. Valid values are `pass|fail|partial|not_tested`',
    `next_assessment_due` DATE COMMENT 'Planned date for the next control assessment.',
    `regulatory_framework` STRING COMMENT 'Regulatory framework(s) that the control satisfies.. Valid values are `PCI_DSS|SOX|GDPR|AML|CTF|PSD2`',
    `regulatory_requirement_code` STRING COMMENT 'Identifier of the specific regulatory requirement mapped to this control.',
    `remediation_action` STRING COMMENT 'Planned action to address control deficiencies.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort.. Valid values are `pending|in_progress|completed|not_required`',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the control based on its impact and likelihood.. Valid values are `critical|high|medium|low|informational`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing the controls risk level.',
    `source_system` STRING COMMENT 'Originating system that supplied the control information.',
    `tags` STRING COMMENT 'Comma‑separated tags for categorizing the control (e.g., finance, security, privacy).',
    `testing_methodology` STRING COMMENT 'Method used to test the effectiveness of the control.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `version` STRING COMMENT 'Version identifier of the control definition.',
    CONSTRAINT pk_control PRIMARY KEY(`control_id`)
) COMMENT 'Defines each internal compliance control implemented to satisfy one or more regulatory obligations. Captures control ID, control name, control type (preventive/detective/corrective), frequency, owner, mapped obligation references, testing methodology, and last assessment outcome. Forms the control library used in PCI DSS, SOX, and regulatory examination responses.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` (
    `control_assessment_id` BIGINT COMMENT 'System‑generated unique identifier for each control assessment record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Assessment performed by an employee; required for audit of control testing.',
    `control_id` BIGINT COMMENT 'Unique identifier of the compliance control being assessed.',
    `regulatory_obligation_id` BIGINT COMMENT 'Identifier of the specific regulatory requirement linked to the control.',
    `assessment_cycle` STRING COMMENT 'Frequency with which the control is assessed.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `assessment_date` DATE COMMENT 'Calendar date on which the assessment was performed.',
    `assessment_outcome` STRING COMMENT 'Overall pass/fail result of the control assessment.. Valid values are `pass|fail`',
    `assessment_period` STRING COMMENT 'Fiscal or calendar period the assessment covers (e.g., Q1‑2023).',
    `assessment_timestamp` TIMESTAMP COMMENT 'Exact date‑time (with timezone) when the assessment activity occurred.',
    `assessor_role` STRING COMMENT 'Role or function of the assessor within the assessment process.. Valid values are `internal_audit|qsa|external_auditor|compliance_officer`',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the detailed audit log for this assessment.',
    `control_assessment_status` STRING COMMENT 'Current operational status of the assessment record.. Valid values are `active|inactive|archived`',
    `control_category` STRING COMMENT 'Regulatory or framework category to which the control belongs.. Valid values are `pci_dss|sox|gdpr|aml|cft|bsa`',
    `control_effectiveness_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the assessed effectiveness of the control.',
    `control_owner` STRING COMMENT 'Business unit or individual accountable for the control.',
    `control_type` STRING COMMENT 'Classification of the control based on its function.. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `evidence_collected` STRING COMMENT 'Description of documentation, logs, or artifacts gathered as proof of control operation.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether an exception to the control was granted.',
    `exception_reason` STRING COMMENT 'Explanation for why an exception was allowed.',
    `finding_severity` STRING COMMENT 'Severity rating assigned to any deficiency identified during the assessment.. Valid values are `critical|high|medium|low|informational`',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the assessor.',
    `overall_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `completed|pending|in_progress|failed`',
    `regulatory_framework` STRING COMMENT 'Primary regulatory regime governing the control.. Valid values are `pci_dss|sox|gdpr|aml|cft|bsa`',
    `remediation_action` STRING COMMENT 'Planned or executed corrective activity to resolve the finding.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation must be completed.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether corrective action is required to address a finding.',
    `risk_rating` STRING COMMENT 'Overall risk rating derived from the assessment findings.. Valid values are `high|medium|low`',
    `testing_approach` STRING COMMENT 'Methodology used to test the control (e.g., walkthrough, sampling, automated scan).. Valid values are `walkthrough|sampling|automated|penetration|interview`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the assessment record.',
    CONSTRAINT pk_control_assessment PRIMARY KEY(`control_assessment_id`)
) COMMENT 'Records each periodic testing or assessment of a compliance control — including assessment date, assessor (internal audit, QSA, external auditor), testing approach, evidence collected, finding severity, remediation required flag, and pass/fail outcome. Provides the audit trail for control effectiveness over time and supports PCI DSS QSA assessments and SOX testing cycles.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` (
    `pci_dss_audit_id` BIGINT COMMENT 'Unique surrogate key for each PCI DSS audit record.',
    `document_id` BIGINT COMMENT 'Identifier used by the QSA for the audit report document.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: PCI DSS audit reports must reference the exact POS terminal audited for compliance reporting and remediation.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: PCI DSS audits are performed to satisfy regulatory obligations; linking enables obligation‑centric audit tracking.',
    `assessment_end_date` DATE COMMENT 'Date when the on‑site assessment concluded.',
    `assessment_start_date` DATE COMMENT 'Date when the on‑site assessment began.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Exact timestamp of the assessment completion event.',
    `audit_document_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA‑256) of the stored audit report.',
    `audit_name` STRING COMMENT 'Descriptive name of the audit (e.g., "2024 Annual ROC").',
    `audit_number` STRING COMMENT 'External reference number assigned by the QSA or internal tracking system.',
    `audit_source_system` STRING COMMENT 'System that originated the audit record (e.g., Risk and Compliance Management System).',
    `audit_summary` STRING COMMENT 'High‑level narrative summarizing audit results.',
    `audit_type` STRING COMMENT 'Indicates whether the audit is a Report on Compliance (ROC) or a Self‑Assessment Questionnaire (SAQ).. Valid values are `ROC|SAQ`',
    `audit_version` STRING COMMENT 'Version string for the audit (e.g., "v1.0", "v2.1").',
    `cde_boundary_description` STRING COMMENT 'Technical description of the CDE boundaries assessed.',
    `compensating_controls_count` STRING COMMENT 'Count of approved compensating controls for unmet requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `data_classification` STRING COMMENT 'Internal classification of the audit data.. Valid values are `restricted|confidential|internal|public`',
    `findings_count` STRING COMMENT 'Total count of non‑conformities discovered.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code of the primary jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was last reviewed for accuracy.',
    `lifecycle_status` STRING COMMENT 'Current processing state of the audit record.. Valid values are `completed|in_progress|failed|pending`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `overall_compliance_score` DECIMAL(18,2) COMMENT 'Numeric compliance score expressed as a percentage.',
    `overall_compliance_status` STRING COMMENT 'High‑level compliance outcome of the audit.. Valid values are `compliant|non_compliant|partial`',
    `qsa_firm_contact_email` STRING COMMENT 'Primary email address for the QSA firm contact.',
    `qsa_firm_contact_phone` STRING COMMENT 'Phone number for the QSA firm contact.',
    `qsa_firm_name` STRING COMMENT 'Name of the QSA firm that performed the audit.',
    `regulatory_framework` STRING COMMENT 'PCI standard or related framework governing the audit.. Valid values are `PCI_DSS|PCI_P2PE|PCI_PIN`',
    `remediation_deadline` DATE COMMENT 'Target date for completing all remediation actions.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities.. Valid values are `pending|completed|overdue`',
    `report_file_name` STRING COMMENT 'File name of the submitted audit report.',
    `report_file_path` STRING COMMENT 'Path or URI where the audit report is stored.',
    `report_submission_date` DATE COMMENT 'Date the ROC or SAQ report was submitted to the acquiring bank or regulator.',
    `requirements_tested` STRING COMMENT 'Comma‑separated list of PCI DSS requirement numbers examined.',
    `risk_level` STRING COMMENT 'Overall risk rating derived from audit findings.. Valid values are `low|medium|high|critical`',
    `saq_type` STRING COMMENT 'Specific SAQ variant applied when audit_type = SAQ.. Valid values are `A|A-EP|B|C|C-VT|D`',
    `scope_description` STRING COMMENT 'Narrative describing the CDE scope covered by the audit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    CONSTRAINT pk_pci_dss_audit PRIMARY KEY(`pci_dss_audit_id`)
) COMMENT 'PCI DSS compliance audit record capturing each annual or interim assessment cycle — QSA firm, assessment scope (SAQ type or full ROC), cardholder data environment (CDE) boundaries assessed, requirements tested, findings, compensating controls, and Report on Compliance (ROC) or Self-Assessment Questionnaire (SAQ) submission details. SSOT for PCI DSS compliance posture.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` (
    `gdpr_data_subject_request_id` BIGINT COMMENT 'Unique identifier for the GDPR/CCPA data subject request record.',
    `account_holder_id` BIGINT COMMENT 'Internal identifier of the individual or entity making the request.',
    `employee_id` BIGINT COMMENT 'Internal identifier of the individual or entity making the request.',
    `requestor_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Internal employee initiates GDPR request; link needed for request tracking and compliance audit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `fulfillment_action_taken` STRING COMMENT 'Description of the action performed to satisfy the request (e.g., data export, deletion).',
    `fulfillment_status` STRING COMMENT 'Current status of the fulfillment work.. Valid values are `not_started|in_progress|completed|failed`',
    `notes` STRING COMMENT 'Free‑form notes captured by compliance analysts.',
    `request_receipt_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the request was received by the compliance system.',
    `request_reference_number` STRING COMMENT 'External reference number assigned to the request for tracking across systems.',
    `request_status` STRING COMMENT 'Overall lifecycle state of the request.. Valid values are `open|closed|cancelled`',
    `request_type` STRING COMMENT 'Type of data subject rights request as defined by GDPR/CCPA.. Valid values are `access|erasure|portability|rectification|restriction|objection`',
    `requestor_email` STRING COMMENT 'Email address used to contact the requestor.',
    `requestor_name` STRING COMMENT 'Legal full name of the data subject submitting the request.',
    `response_deadline` DATE COMMENT 'Date by which a response must be provided (30‑day GDPR / 45‑day CCPA).',
    `source_system` STRING COMMENT 'Name of the operational system that originated the request record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the request record.',
    `verification_status` STRING COMMENT 'Result of identity verification for the requestor.. Valid values are `pending|verified|rejected`',
    CONSTRAINT pk_gdpr_data_subject_request PRIMARY KEY(`gdpr_data_subject_request_id`)
) COMMENT 'Records each GDPR or CCPA data subject rights request received — request type (access, erasure, portability, rectification, restriction, objection), requestor identity, verification status, request receipt date, regulatory response deadline (30-day GDPR / 45-day CCPA), fulfillment actions taken, and closure date. SSOT for data subject rights compliance lifecycle.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for each consent record.',
    `consent_id` BIGINT COMMENT 'External identifier for the consent agreement, often a UUID or reference number used in audit and reporting.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Maps consent geo‑country code to reference country for jurisdiction‑specific consent compliance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Consent record creation logged by employee; needed for data governance audit.',
    `device_id` BIGINT COMMENT 'Unique identifier of the device (e.g., mobile device ID) used during consent capture.',
    `party_id` BIGINT COMMENT 'Unique identifier of the data subject (cardholder or merchant) who gave the consent.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Consent records are collected to meet specific regulatory obligations; linking clarifies which obligation the consent satisfies.',
    `collection_channel` STRING COMMENT 'The channel through which the consent was obtained (e.g., website, mobile app, in‑store terminal, call centre, email).. Valid values are `web|mobile_app|in_store|call_center|email`',
    `consent_status` STRING COMMENT 'Current lifecycle state of the consent record.. Valid values are `active|withdrawn|expired|pending`',
    `consent_text_hash` STRING COMMENT 'Cryptographic hash of the consent text version to ensure integrity and support audit.',
    `consent_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the consent was recorded.',
    `consent_type` STRING COMMENT 'Category of consent covering marketing, data sharing, open banking, or Strong Customer Authentication (SCA).. Valid values are `marketing|data_sharing|open_banking|sca`',
    `consent_version` STRING COMMENT 'Version string of the consent text to support change management and re‑consent tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consent record was first persisted in the lakehouse.',
    `data_processing_purpose` STRING COMMENT 'Narrative description of why the data is being processed under this consent.',
    `data_retention_period_days` STRING COMMENT 'Number of days the data may be retained after consent, as defined by policy.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when the consent becomes legally effective.',
    `effective_until` TIMESTAMP COMMENT 'Optional expiry timestamp; null if consent is open‑ended.',
    `geo_region` STRING COMMENT 'Higher‑level region or jurisdiction (e.g., EU, APAC) associated with the consent capture.',
    `ip_address` STRING COMMENT 'IP address of the device used to provide consent, required for audit and fraud investigations.',
    `language` STRING COMMENT 'ISO 639‑1 language code of the consent text presented to the data subject.. Valid values are `^[a-z]{2}$`',
    `lawful_basis` STRING COMMENT 'Legal justification for processing under GDPR/CCPA (e.g., consent, contract, legal obligation, legitimate interest).. Valid values are `consent|contract|legal_obligation|legitimate_interest`',
    `party_type` STRING COMMENT 'Indicates whether the consent was provided by a cardholder (consumer) or a merchant (business).. Valid values are `cardholder|merchant`',
    `reconsent_due_date` DATE COMMENT 'Date by which the data subject must provide renewed consent, if required.',
    `reconsent_required` BOOLEAN COMMENT 'Indicates whether a new consent must be obtained due to regulatory or policy changes.',
    `scope` STRING COMMENT 'Describes the data processing activities covered by the consent (e.g., marketing, analytics, third‑party sharing, risk assessment).',
    `source_system` STRING COMMENT 'Originating operational system that captured the consent (e.g., Digital Wallet Platform, Merchant Management System).',
    `updated_by` STRING COMMENT 'System user or service account that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the consent record.',
    `user_agent` STRING COMMENT 'Browser or application user‑agent string providing context about the client environment.',
    `withdrawal_reason` STRING COMMENT 'Free‑text reason provided by the data subject for withdrawing consent.',
    `withdrawal_timestamp` TIMESTAMP COMMENT 'Date‑time when the data subject withdrew the consent, if applicable.',
    CONSTRAINT pk_consent_record PRIMARY KEY(`consent_record_id`)
) COMMENT 'Authoritative record of data processing consent obtained from cardholders and merchants under GDPR, PSD2, and CCPA. Captures consent type (marketing, data sharing, open banking, SCA), consent version, collection channel, timestamp, IP address, withdrawal status, and re-consent triggers. Supports lawful basis documentation and data subject rights fulfillment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory filing overseen by compliance officer employee; essential for filing responsibility tracking.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Normalizes filing currency to reference table for accurate financial aggregation.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Provides a stable jurisdiction key for regulatory filing metadata required by regulators.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filings are made to satisfy specific obligations; linking enables tracking of filing status per obligation.',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when acknowledgment was received from the regulator.',
    `attached_document_count` STRING COMMENT 'Number of supporting documents attached to the filing.',
    `audit_trail_hash` STRING COMMENT 'Hash of the audit trail for integrity verification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was created in the system.',
    `filing_amount` DECIMAL(18,2) COMMENT 'Monetary amount reported in the filing, if applicable (e.g., transaction total for CTR).',
    `filing_category` STRING COMMENT 'High-level category of the filing for reporting purposes.. Valid values are `financial|anti_money_laundering|consumer_protection|security|other`',
    `filing_deadline_date` DATE COMMENT 'Deadline by which the filing must be completed or responded to.',
    `filing_description` STRING COMMENT 'Free-text description providing context and details of the filing.',
    `filing_effective_date` DATE COMMENT 'Effective date of the filing as recognized by the regulator.',
    `filing_priority` STRING COMMENT 'Priority level assigned to the filing.. Valid values are `high|medium|low`',
    `filing_reference_number` STRING COMMENT 'Unique reference number assigned by the regulator for this filing.',
    `filing_status` STRING COMMENT 'Current processing status of the filing.. Valid values are `draft|submitted|accepted|rejected|closed|withdrawn`',
    `filing_title` STRING COMMENT 'Descriptive title or name of the filing.',
    `filing_type` STRING COMMENT 'Category of regulatory filing such as FinCEN Currency Transaction Report (CTR), PSD2 incident report, Reg E notice, etc.. Valid values are `ctr|psd2_incident|reg_e_notice|cfpb_complaint|swift_gpi|other`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the filing contains confidential information.',
    `outcome` STRING COMMENT 'Result of the filing after regulator review.. Valid values are `accepted|rejected|partial|pending|closed`',
    `outcome_description` STRING COMMENT 'Additional details about the filing outcome.',
    `regulator_name` STRING COMMENT 'Name of the regulatory authority to which the filing is submitted (e.g., FinCEN, ECB, CFPB).',
    `related_case_number` STRING COMMENT 'Identifier of any internal case linked to this filing.',
    `response_due_date` DATE COMMENT 'Date by which a response to the regulator is required.',
    `response_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulators response was received.',
    `source_system` STRING COMMENT 'Originating operational system of record for the filing (e.g., Risk and Compliance Management System).',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the filing was submitted to the regulator.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Master record of all regulatory filings submitted to governing bodies — FinCEN CTR (Currency Transaction Reports), PSD2 incident reports to ECB/NCAs, Reg E error resolution notices, CFPB complaint responses, and SWIFT gpi compliance reports. Captures filing type, regulator, submission date, filing reference number, status, and acknowledgement. Distinct from SAR/STR which have dedicated entities.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`examination_request` (
    `examination_request_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory examination request.',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_compliance_case. Business justification: Each examination request is handled by a compliance case; linking provides case context and eliminates silo.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Examination request owned by internal employee; needed for case management.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Links examination request jurisdiction to reference for regulator‑driven examination tracking.',
    `audit_trail` STRING COMMENT 'JSON‑encoded audit trail capturing key actions and timestamps for compliance purposes.',
    `compliance_area` STRING COMMENT 'Regulatory domain to which the examination pertains.. Valid values are `AML|PCI_DSS|GDPR|CCPA|SOX|FATF`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the examination request record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for the currency of any monetary penalty.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `documents_provided` STRING COMMENT 'List or description of the documents submitted in response to the request.',
    `escalation_reason` STRING COMMENT 'Reason for escalation, if applicable.',
    `examination_request_status` STRING COMMENT 'Current lifecycle status of the examination request.. Valid values are `open|in_progress|closed|escalated|withdrawn`',
    `examination_type` STRING COMMENT 'Classification of the examination (routine, targeted, or enforcement).. Valid values are `routine|targeted|enforcement`',
    `examiner_contact_email` STRING COMMENT 'Email address of the regulators examiner.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `examiner_contact_name` STRING COMMENT 'Name of the regulators examiner or point of contact.',
    `examiner_contact_phone` STRING COMMENT 'Phone number of the regulators examiner.',
    `findings_summary` STRING COMMENT 'Brief narrative of the regulators findings.',
    `follow_up_actions` STRING COMMENT 'Actions the organization must take as a result of the examination.',
    `information_requested` STRING COMMENT 'Detailed description of the data, reports, or documentation the regulator is requesting.',
    `internal_owner_email` STRING COMMENT 'Email address of the internal owner.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `is_escalated` BOOLEAN COMMENT 'Flag indicating whether the examination has been escalated to senior management.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the examination request.',
    `outcome` STRING COMMENT 'Result of the examination (e.g., compliant, findings, penalties).. Valid values are `compliant|findings|penalties|no_action`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by the regulator, if any.',
    `regulator` STRING COMMENT 'Regulatory authority that issued the examination request.. Valid values are `OCC|CFPB|FCA|ECB|FinCEN`',
    `request_date` DATE COMMENT 'Date the examination request was received from the regulator.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the examination request.',
    `response_due_date` DATE COMMENT 'Date by which the organization must provide the requested information.',
    `response_submitted_date` DATE COMMENT 'Date the organization submitted its response to the regulator.',
    `risk_rating` STRING COMMENT 'Internal risk rating assigned to the examination request.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the examination request record.',
    CONSTRAINT pk_examination_request PRIMARY KEY(`examination_request_id`)
) COMMENT 'Tracks regulatory examination and supervisory requests received from regulators (OCC, CFPB, FCA, ECB, FinCEN). Captures the regulator, examination type (routine, targeted, enforcement), request date, information requested, response due date, documents provided, examiner contacts, and examination outcome. SSOT for regulatory examination support and response management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` (
    `compliance_case_id` BIGINT COMMENT 'Unique identifier for the compliance_compliance_case data product (auto-inserted pre-linking).',
    `assigned_officer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer responsible for the case.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Compliance cases often originate from wallet‑level fraud or policy breaches; linking the case to the wallet enables case dashboards and risk metrics.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Compliance cases involving partner misconduct need a direct FK to the partner to generate case reports, regulatory filings, and remediation actions.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer responsible for the case.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory case reporting (AML, SAR) must capture the legal entity involved for filing with authorities; experts expect a direct link to the entity record.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Compliance cases are frequently triggered by issues with a particular payment product, requiring direct linkage.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Compliance cases often originate from suspicious activity on a specific terminal; linking enables case‑to‑terminal traceability.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the case, if applicable.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that prompted the case, if applicable.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Associates each compliance case with a canonical jurisdiction for risk scoring and reporting.',
    `risk_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_case. Business justification: Compliance investigations often originate from a risk case; linking preserves the provenance of the compliance case.',
    `action_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance action was executed.',
    `case_category` STRING COMMENT 'High‑level grouping of the case (e.g., regulatory, operational, conduct).',
    `case_number` STRING COMMENT 'Business identifier assigned to the case for tracking and reference.',
    `case_severity` STRING COMMENT 'Severity rating reflecting potential impact.. Valid values are `critical|high|medium|low`',
    `case_status` STRING COMMENT 'Current lifecycle status of the case.. Valid values are `open|in_review|escalated|closed|dismissed`',
    `case_subtype` STRING COMMENT 'More granular classification within the main category.',
    `case_tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for search and categorisation.',
    `case_type` STRING COMMENT 'Category of the case such as AML, sanctions, PCI, GDPR, conduct, fraud, risk, or other. [ENUM-REF-CANDIDATE: AML|sanctions|PCI|GDPR|conduct|fraud|risk|other — promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was closed or resolved (nullable).',
    `compliance_action_taken` STRING COMMENT 'Description of the remedial or enforcement action performed.',
    `compliance_case_description` STRING COMMENT 'Free‑form narrative describing the issue, findings, and context.',
    `compliance_officer_notes` STRING COMMENT 'Notes entered by the compliance officer during investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was created in the system.',
    `data_classification` STRING COMMENT 'Enterprise data classification applied to the case record.. Valid values are `restricted|confidential|internal|public`',
    `evidence_log_reference` STRING COMMENT 'Reference to the evidence log or repository containing supporting documents.',
    `external_reference_code` STRING COMMENT 'Identifier assigned by an external regulator or reporting body.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the case contains confidential information requiring restricted handling.',
    `is_escalated` BOOLEAN COMMENT 'Flag indicating the case was escalated to higher authority.',
    `is_false_positive` BOOLEAN COMMENT 'Flag indicating the case was determined to be a false positive.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who performed the last update.',
    `opened_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was initially opened.',
    `priority_level` STRING COMMENT 'Business-assigned priority indicating urgency.. Valid values are `high|medium|low`',
    `regulatory_framework` STRING COMMENT 'Regulation or standard governing the case.. Valid values are `PCI_DSS|GDPR|AML|OFAC|PSD2|FATF`',
    `regulatory_report_filed` BOOLEAN COMMENT 'Indicates whether a required regulatory report has been filed.',
    `report_filing_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory report was filed.',
    `resolution_outcome` STRING COMMENT 'Result of the case after investigation.. Valid values are `remediation|fine|no_action|warning|settlement`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the case resolution was recorded.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk assessment score for the case.',
    `source_trigger` STRING COMMENT 'Origin that triggered the creation of the case.. Valid values are `SAR|audit_finding|regulator_inquiry|internal_alert|whistleblower`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the case record.',
    CONSTRAINT pk_compliance_case PRIMARY KEY(`compliance_case_id`)
) COMMENT 'Compliance investigation case record — opened when a potential violation, breach, or regulatory concern is identified. Captures case type (AML, sanctions, PCI, GDPR, conduct), case status, assigned compliance officer, source trigger (SAR, audit finding, regulator inquiry, internal alert), investigation timeline, evidence log references, and resolution outcome. Distinct from fraud_case in the fraud domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` (
    `breach_notification_id` BIGINT COMMENT 'System-generated unique identifier for the breach notification record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Breach notification handled by compliance officer employee; needed for breach response accountability.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Data breach notifications must identify the terminal where the breach occurred for incident response and regulator reporting.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Maps breach notification jurisdiction to reference jurisdiction for regulator notification requirements.',
    `affected_data_categories` STRING COMMENT 'Comma‑separated list of data categories compromised (e.g., PAN, personal email, authentication credentials).',
    `affected_systems` STRING COMMENT 'List of internal systems, applications, or services impacted by the breach.',
    `board_report_date` DATE COMMENT 'Date the breach was formally reported to the board.',
    `breach_source` STRING COMMENT 'Origin of the breach (e.g., internal employee, external attacker, third‑party vendor).. Valid values are `internal|external|third_party|unknown`',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach investigation.. Valid values are `open|investigating|resolved|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach notification record was first created in the system.',
    `data_loss_indicator` BOOLEAN COMMENT 'True if data was confirmed to be exfiltrated or accessed without authorization.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Exact date and time when the security incident was first discovered.',
    `encryption_status_at_time` TIMESTAMP COMMENT 'Encryption state of the affected data at the moment of breach.',
    `estimated_cardholder_count` STRING COMMENT 'Estimated number of individual cardholders whose data was impacted.',
    `estimated_merchant_count` STRING COMMENT 'Estimated number of merchants affected by the breach.',
    `is_reported_to_board` BOOLEAN COMMENT 'Indicates whether the breach has been escalated to the board of directors.',
    `legal_basis` STRING COMMENT 'Legal justification for processing personal data at the time of breach, per GDPR. [ENUM-REF-CANDIDATE: consent|contract|legal_obligation|legitimate_interest|vital_interest|public_task|other — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free‑form notes captured by the investigation team.',
    `notification_date` DATE COMMENT 'Date on which the regulator (or required authority) was formally notified.',
    `notification_method` STRING COMMENT 'Channel used to notify affected individuals or regulators.. Valid values are `email|postal|public_statement|portal|other`',
    `notification_trigger` STRING COMMENT 'Regulatory or policy trigger that initiates the breach notification (e.g., GDPR 72‑hour rule, state breach law, PCI DSS Requirement 12.10).. Valid values are `gdpr|state_law|pci_dss|other`',
    `regulator_notified` STRING COMMENT 'Regulatory authority that was notified about the breach.. Valid values are `gdpr|pci_dss|ffiec|other`',
    `remediation_action_summary` STRING COMMENT 'High‑level description of actions taken to contain and remediate the breach.',
    `risk_score` DECIMAL(18,2) COMMENT 'Internal risk rating (0‑100) reflecting severity and potential impact.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach notification record.',
    CONSTRAINT pk_breach_notification PRIMARY KEY(`breach_notification_id`)
) COMMENT 'Records each data breach or security incident notification event — breach discovery date, notification trigger (GDPR 72-hour rule, state breach laws, PCI DSS Requirement 12.10), affected data categories, estimated cardholder/merchant count impacted, regulator notified, notification date, and remediation actions. SSOT for breach notification compliance lifecycle.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` (
    `ctf_control_id` BIGINT COMMENT 'System-generated unique identifier for the Counter-Terrorism Financing control record.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Links CTF control jurisdiction to reference for consistent FATF and AML reporting.',
    `applies_to_channel` STRING COMMENT 'Payment channels (e.g., online, POS) where the control is enforced.. Valid values are `online|pos|mobile|api|batch`',
    `applies_to_transaction_type` STRING COMMENT 'Transaction types to which the control is applied.. Valid values are `card|ach|wire|crypto|mobile_wallet`',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit observations or change rationale.',
    `compliance_framework` STRING COMMENT 'Regulatory framework(s) that mandate the control.. Valid values are `FATF|FinCEN|EU AML|UK FCA|US OFAC`',
    `control_code` STRING COMMENT 'Business‑assigned unique code for the CTF control, used for lookup and reporting.',
    `control_name` STRING COMMENT 'Human‑readable name of the CTF control.',
    `control_owner` STRING COMMENT 'Name of the individual or team responsible for the control.',
    `control_owner_department` STRING COMMENT 'Organizational department that owns the control.',
    `control_type` STRING COMMENT 'Category of the CTF control, indicating the typology it addresses.. Valid values are `transaction_monitoring_rule|high_risk_jurisdiction|pep_screening|due_diligence|correspondent_bank_due_diligence|suspicious_activity_reporting`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was first created in the system.',
    `ctf_control_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and mechanics of the CTF control.',
    `ctf_control_status` STRING COMMENT 'Current lifecycle status of the control.. Valid values are `active|inactive|retired|pending`',
    `effective_from` DATE COMMENT 'Date when the CTF control becomes operational.',
    `effective_until` DATE COMMENT 'Date when the CTF control ceases to be active; null for indefinite.',
    `effectiveness_rating` DECIMAL(18,2) COMMENT 'Quantitative rating (0‑1) of how effective the control is, based on internal assessments.',
    `fatf_recommendation` STRING COMMENT 'Specific FATF recommendation number (e.g., Recommendation 10) that the control implements.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the control is mandatory under regulatory requirements.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last formal review of the controls effectiveness.',
    `regulatory_reporting_requirement` STRING COMMENT 'Specific reporting obligation (e.g., SAR, STR) linked to the control.',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled reviews of the control.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score assigned to the control, reflecting its importance in the CTF risk model.',
    `rule_description` STRING COMMENT 'Technical description of the rule logic (e.g., pseudocode or reference to model version).',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold that triggers the control (if applicable).',
    `threshold_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the threshold amount.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    CONSTRAINT pk_ctf_control PRIMARY KEY(`ctf_control_id`)
) COMMENT 'Counter-Terrorism Financing control record defining specific CTF measures implemented — transaction monitoring rules targeting terrorism financing typologies, high-risk jurisdiction controls, PEP (Politically Exposed Person) screening configurations, and correspondent banking due diligence requirements. Captures control type, applicable FATF recommendation, jurisdiction scope, and effectiveness rating.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` (
    `psd2_incident_report_id` BIGINT COMMENT 'Unique surrogate key for the PSD2 incident report.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PSD2 incident report assigned to compliance officer employee; required for regulator communication.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: PSD2 incident reports frequently involve a particular wallet (e.g., SCA failure); linking supports regulatory reporting and remediation tracking.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: PSD2 incident reports require the affected terminal ID to satisfy regulatory incident filing and risk analysis.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Provides a normalized jurisdiction key for PSD2 incident reporting to supervisory authorities.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: PSD2 incident reports are triggered by regulatory requirements; linking provides direct reference to the obligation.',
    `affected_services` STRING COMMENT 'Comma‑separated list of payment services or APIs impacted by the incident.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident report record was created in the system.',
    `data_subjects_impacted` STRING COMMENT 'Count of individual data subjects whose personal data was affected.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Monetary estimate of the financial loss attributable to the incident, expressed in EUR.',
    `final_report_submission_date` DATE COMMENT 'Date on which the final incident report was submitted to the regulator.',
    `incident_reference_number` STRING COMMENT 'External reference number assigned to the incident by the reporting entity.',
    `incident_severity` STRING COMMENT 'Severity rating of the incident based on impact and risk.. Valid values are `low|medium|high|critical`',
    `incident_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the incident event occurred.',
    `incident_title` STRING COMMENT 'Human‑readable title summarising the incident.',
    `incident_type` STRING COMMENT 'Classification of the incident (e.g., operational, security, fraud).. Valid values are `operational|security|fraud|compliance|other`',
    `interim_report_submission_date` DATE COMMENT 'Date on which the interim incident report was submitted to the regulator.',
    `is_reported_to_nca` BOOLEAN COMMENT 'Indicates whether the incident has been formally reported to the NCA.',
    `is_sar_required` BOOLEAN COMMENT 'Indicates whether a Suspicious Activity Report is required for this incident.',
    `mitigation_actions` STRING COMMENT 'Description of actions taken to mitigate or resolve the incident.',
    `nca_reference_number` STRING COMMENT 'Reference number assigned by the NCA for this incident.',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident was first reported to the compliance team or regulator.',
    `psd2_incident_report_status` STRING COMMENT 'Current lifecycle status of the incident report.. Valid values are `open|under_investigation|resolved|closed`',
    `regulatory_authority` STRING COMMENT 'Regulatory body to which the incident is reported.. Valid values are `ECB|NCA|FCA|OCC|FINCEN|ESMA`',
    `report_submission_status` STRING COMMENT 'Current status of the regulator report submission process.. Valid values are `pending|submitted|rejected|accepted`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the incident by the risk engine.',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause of the incident.',
    `sar_filing_status` STRING COMMENT 'Current filing status of the SAR, if required.. Valid values are `not_filed|filed|pending`',
    `source_system` STRING COMMENT 'Name of the operational system that generated the incident record (e.g., Fraud Detection Platform).',
    `str_filing_status` STRING COMMENT 'Current filing status of the Suspicious Transaction Report, if required.. Valid values are `not_filed|filed|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incident report.',
    `user_impact_count` STRING COMMENT 'Number of end‑users (cardholders, merchants, etc.) affected by the incident.',
    `created_by` STRING COMMENT 'User or process that created the incident report record.',
    CONSTRAINT pk_psd2_incident_report PRIMARY KEY(`psd2_incident_report_id`)
) COMMENT 'PSD2 major operational or security incident report submitted to the relevant National Competent Authority (NCA) or ECB. Captures incident classification (operational, security), initial notification timestamp, root cause, affected payment services, estimated financial impact, user impact count, interim and final report submission dates, and NCA reference number. Required under PSD2 Article 96.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` (
    `sca_exemption_id` BIGINT COMMENT 'Unique identifier for the SCA exemption record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who initiated the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder who initiated the transaction.',
    `compliance_officer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer who reviewed or approved the exemption.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer who reviewed or approved the exemption.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant acquiring the transaction.',
    `transaction_id` BIGINT COMMENT 'Unique identifier of the payment transaction to which the exemption applies.',
    `applied_timestamp` TIMESTAMP COMMENT 'Date‑time when the SCA exemption was granted for the transaction.',
    `audit_log_reference` BIGINT COMMENT 'Identifier linking to the detailed audit log for this exemption.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exemption record was first created in the system.',
    `exemption_reason` STRING COMMENT 'Narrative description of why the exemption was granted.',
    `exemption_reference` STRING COMMENT 'Business identifier assigned to the exemption for external tracking and reporting.',
    `exemption_requested_by` STRING COMMENT 'Party that initiated the exemption request (e.g., PSP, acquiring bank, issuing bank, merchant).. Valid values are `psp|acquirer|issuer|merchant`',
    `exemption_status` STRING COMMENT 'Lifecycle status indicating whether the exemption is active, approved, rejected, revoked, or expired.. Valid values are `applied|approved|rejected|revoked|expired`',
    `exemption_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount for which a low‑value exemption can be applied.',
    `exemption_threshold_currency` STRING COMMENT 'ISO 4217 currency code for the exemption threshold amount.',
    `exemption_type` STRING COMMENT 'Category of exemption as defined by PSD2 RTS (e.g., low‑value, recurring, merchant‑initiated).. Valid values are `low_value|low_risk_tra|recurring|merchant_initiated|whitelisted_payee|trusted_beneficiary`',
    `exemption_valid_from` DATE COMMENT 'Start date of the exemptions validity period.',
    `exemption_valid_until` DATE COMMENT 'End date of the exemptions validity period (nullable if open‑ended).',
    `is_exemption_revoked` BOOLEAN COMMENT 'True if the exemption was later revoked; otherwise false.',
    `liability_shift` STRING COMMENT 'Entity that bears liability for the transaction after the exemption is applied.. Valid values are `merchant|issuer|psp`',
    `notes` STRING COMMENT 'Supplementary information or comments regarding the exemption.',
    `payment_instrument_type` STRING COMMENT 'Category of the payment instrument used in the transaction.. Valid values are `card|bank_transfer|digital_wallet|crypto`',
    `payment_method` STRING COMMENT 'Specific method of payment (e.g., credit card, debit card, prepaid, virtual, contactless).. Valid values are `credit|debit|prepaid|virtual|contactless`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the exemption must be reported to regulators (e.g., PSD2 supervisory reporting).',
    `reporting_deadline` DATE COMMENT 'Date by which the exemption must be reported to the appropriate regulator.',
    `revocation_timestamp` TIMESTAMP COMMENT 'Date‑time when the exemption was revoked, if applicable.',
    `risk_category` STRING COMMENT 'Risk tier derived from the risk score (low, medium, high).. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (e.g., 0‑100) reflecting the risk associated with granting the exemption.',
    `source_system` STRING COMMENT 'Name of the operational system of record that originated the exemption (e.g., Payment Gateway, Risk & Compliance System).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Gross amount of the payment transaction before any fees or discounts.',
    `transaction_arn` STRING COMMENT 'Reference number generated by the acquirer for reconciliation and dispute purposes.',
    `transaction_auth_code` STRING COMMENT 'Code returned by the issuing bank indicating approval of the transaction.',
    `transaction_currency` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the transaction amount.',
    `transaction_mcc` STRING COMMENT 'Four‑digit code classifying the merchants business type.',
    `transaction_mid` STRING COMMENT 'Unique identifier assigned to the merchant by the acquiring bank.',
    `transaction_status` STRING COMMENT 'Lifecycle status of the payment transaction.. Valid values are `authorized|captured|settled|declined|reversed|chargeback`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date‑time when the underlying payment transaction was initiated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the exemption record.',
    CONSTRAINT pk_sca_exemption PRIMARY KEY(`sca_exemption_id`)
) COMMENT 'Records each Strong Customer Authentication (SCA) exemption applied to a payment transaction under PSD2 RTS. Captures exemption type (low-value, low-risk TRA, recurring, merchant-initiated, whitelisted payee), transaction reference, exemption requestor (PSP/acquirer/issuer), liability shift outcome, and regulator-mandated monitoring thresholds. Supports PSD2 SCA compliance reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` (
    `watchlist_entry_id` BIGINT COMMENT 'System-generated unique identifier for each watchlist entry.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Provides a normalized jurisdiction reference for watchlist entries used in AML/CTF screening.',
    `active_status` STRING COMMENT 'Current operational status of the watchlist entry.. Valid values are `active|inactive|pending|removed`',
    `address` STRING COMMENT 'Physical address associated with the entity on the watchlist.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the watchlist entry was first loaded into the system.',
    `date_of_birth` DATE COMMENT 'Birth date of an individual entity, if applicable.',
    `entity_aliases` STRING COMMENT 'Comma‑separated list of alternative names, spellings, or known aliases for the entity.',
    `entity_name` STRING COMMENT 'Legal name of the individual, organization, or vessel as listed on the watchlist.',
    `entity_type` STRING COMMENT 'Category of the watchlist entity: individual, organization, or vessel.. Valid values are `individual|organization|vessel`',
    `expiration_date` DATE COMMENT 'Date when the watchlist entry is scheduled to be removed or become inactive.',
    `gender` STRING COMMENT 'Gender of the individual, if known.. Valid values are `male|female|non_binary|unknown`',
    `identification_number` STRING COMMENT 'Official identifier such as passport number, national ID, or tax ID.',
    `identification_type` STRING COMMENT 'Type of the identification number provided.. Valid values are `passport|national_id|driver_license|tax_id|other`',
    `is_high_risk` BOOLEAN COMMENT 'Flag indicating whether the entity is considered high risk based on internal scoring.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent manual review of the watchlist entry.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the watchlist entry.',
    `list_entry_reference` STRING COMMENT 'Identifier used by the source list to reference this entry (e.g., SDN ID).',
    `list_source` STRING COMMENT 'Originating sanctions or watchlist source for the entry.. Valid values are `OFAC|EU|UN|HM_Treasury|PEP|Adverse_Media`',
    `list_version_date` DATE COMMENT 'Date of the version of the source list that contains this entry.',
    `match_score` DECIMAL(18,2) COMMENT 'Confidence score indicating similarity between this entry and a screened party.',
    `nationality` STRING COMMENT 'ISO‑3166‑1 alpha‑3 code of the entitys nationality or country of citizenship.',
    `notes` STRING COMMENT 'Free‑form comments or additional context about the entry.',
    `place_of_birth` STRING COMMENT 'Geographic location where the individual was born.',
    `review_status` STRING COMMENT 'Current status of the entitys compliance review.. Valid values are `reviewed|not_reviewed|under_review`',
    `risk_category` STRING COMMENT 'Risk tier assigned to the entity by the source list or internal assessment.. Valid values are `high|medium|low|unknown`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) assigned by the compliance team.',
    `sanctions_type` STRING COMMENT 'Primary type of sanction applied to the entity.. Valid values are `financial|trade|travel|arms|dual_use|other`',
    `source_system` STRING COMMENT 'Name of the operational system that supplied the watchlist data (e.g., OFAC Feed, UN Sanctions Feed).',
    `source_url` STRING COMMENT 'Web address or document reference where the entry was originally published.',
    CONSTRAINT pk_watchlist_entry PRIMARY KEY(`watchlist_entry_id`)
) COMMENT 'Reference master of watchlist entries used in AML, sanctions, and CTF screening — sourced from OFAC SDN, EU Consolidated List, UN Consolidated List, HM Treasury, PEP databases, and adverse media feeds. Captures entity name, aliases, entity type (individual/organization/vessel), list source, list version date, risk category, and active status. Feeds the sanctions_check and aml_screening_result processes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`attestation` (
    `attestation_id` BIGINT COMMENT 'Unique system-generated identifier for the compliance attestation record.',
    `compliance_officer_employee_id` BIGINT COMMENT 'System identifier of the compliance officer responsible for the attestation.',
    `employee_id` BIGINT COMMENT 'System identifier of the compliance officer responsible for the attestation.',
    `gateway_api_credential_id` BIGINT COMMENT 'Foreign key linking to gateway.api_credential. Business justification: Regulatory attestation requires certifying each API credential used for gateway integration meets PCI‑DSS and security standards.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Links attestation jurisdiction to reference for auditability and regulator verification.',
    `regulatory_obligation_id` BIGINT COMMENT 'Identifier of the regulatory obligation that this attestation satisfies.',
    `attached_document_url` STRING COMMENT 'Link to the PDF or supporting documentation for the attestation.',
    `attestation_number` STRING COMMENT 'Business-friendly reference number for the attestation, used in reporting and audit trails.',
    `attestation_status` STRING COMMENT 'Current lifecycle state of the attestation.. Valid values are `pending|approved|rejected|revoked|expired`',
    `attestation_type` STRING COMMENT 'Category of regulatory or internal compliance attestation (e.g., PCI DSS Attestation of Compliance, SOX Section 302).. Valid values are `PCI_DSS_AOC|SOX_302|AML_Program|GDPR|PSD2|BSA`',
    `attesting_party_name` STRING COMMENT 'Full legal name of the individual or entity signing the attestation.',
    `attesting_party_role` STRING COMMENT 'Role of the attesting party within the organization.. Valid values are `Compliance Officer|Business Unit Head|Board Member`',
    `control_owner` STRING COMMENT 'Name of the individual or team that owns the compliance control covered by the attestation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the attestation record was first created in the system.',
    `digital_signature_reference` STRING COMMENT 'Pointer (e.g., URL or hash) to the stored digital signature for the attestation.',
    `effective_from` DATE COMMENT 'Date when the attestation becomes effective.',
    `effective_until` DATE COMMENT 'Date when the attestation expires or is no longer valid (nullable for open‑ended attestations).',
    `enforcement_penalty_estimate` DECIMAL(18,2) COMMENT 'Monetary estimate of potential penalties if the attestation were found non‑compliant.',
    `last_review_date` DATE COMMENT 'Date when the attestation was last reviewed.',
    `next_review_date` DATE COMMENT 'Planned date for the next review of the attestation.',
    `notes` STRING COMMENT 'Additional comments or observations related to the attestation.',
    `review_decision` STRING COMMENT 'Outcome of the review process.. Valid values are `approved|rejected|needs_revision`',
    `review_timestamp` TIMESTAMP COMMENT 'Date‑time when the attestation was reviewed and signed.',
    `risk_rating` STRING COMMENT 'Risk level associated with the attestation based on compliance exposure.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative description of the regulatory or policy scope covered by the attestation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the attestation record.',
    `version_number` STRING COMMENT 'Incremental version of the attestation record.',
    CONSTRAINT pk_attestation PRIMARY KEY(`attestation_id`)
) COMMENT 'Formal compliance attestation record — captures periodic sign-offs by compliance officers, business unit heads, or board members confirming adherence to specific regulatory obligations or internal policies. Includes attestation type (annual PCI DSS AOC, SOX 302/906 certification, AML program attestation), attesting party, attestation date, scope, and digital signature reference.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'Unique system-generated identifier for the policy document.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Policy document ownership assigned to employee; required for policy governance.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Associates policy documents with a canonical jurisdiction for regulatory policy management.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Policy documents are tied to specific regulatory obligations; FK replaces code column.',
    `amendment_indicator` BOOLEAN COMMENT 'True if the policy is an amendment to a prior version.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment (if applicable).',
    `approval_authority` STRING COMMENT 'Name or role of the person/committee that approved the policy.',
    `approval_date` DATE COMMENT 'Date on which the policy was formally approved.',
    `attached_file_reference` STRING COMMENT 'Reference to the file storage location (e.g., S3 key).',
    `compliance_status` STRING COMMENT 'Result of the most recent compliance assessment.. Valid values are `compliant|non_compliant|under_review|exception`',
    `confidentiality_level` STRING COMMENT 'Data classification of the policy document.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the system.',
    `distribution_scope` STRING COMMENT 'Intended audience or reach of the policy.. Valid values are `global|regional|internal|partner|customer`',
    `document_url` STRING COMMENT 'Web address where the policy document is stored.',
    `effective_from` DATE COMMENT 'Date on which the policy becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the policy expires or is superseded (null for open‑ended).',
    `last_review_date` DATE COMMENT 'Date when the policy was last reviewed.',
    `next_review_date` DATE COMMENT 'Planned date for the upcoming policy review.',
    `policy_document_description` STRING COMMENT 'Narrative description of the policy purpose and scope.',
    `policy_document_name` STRING COMMENT 'Human‑readable name of the policy or procedure.',
    `policy_document_status` STRING COMMENT 'Current lifecycle status of the policy.. Valid values are `draft|active|inactive|retired|pending|archived`',
    `policy_type` STRING COMMENT 'Category of regulatory or internal policy.. Valid values are `AML|PCI_DSS|GDPR|Sanctions|BSA|Acceptable_Use`',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory policy reviews.',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the policy based on impact and likelihood.. Valid values are `low|medium|high|critical`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the policy record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the policy record.',
    `version_number` STRING COMMENT 'Version identifier of the policy (e.g., 1.0, 2.1).',
    `created_by` STRING COMMENT 'User identifier of the person who created the policy record.',
    CONSTRAINT pk_policy_document PRIMARY KEY(`policy_document_id`)
) COMMENT 'Master record of compliance policies and procedures — AML program policy, PCI DSS information security policy, GDPR data protection policy, sanctions policy, acceptable use policy, and BSA compliance program. Captures policy name, version, effective date, expiry date, owner, approval authority, applicable regulatory obligation references, and distribution scope.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`training_completion` (
    `training_completion_id` BIGINT COMMENT 'Unique identifier for the training completion record.',
    `employee_id` BIGINT COMMENT 'Identifier of the trainer or instructor, if applicable.',
    `primary_training_employee_id` BIGINT COMMENT 'Identifier of the employee who completed the training.',
    `training_module_id` BIGINT COMMENT 'Identifier of the training module or course.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Score achieved on the training assessment, if applicable.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the certification earned, if applicable.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the employee completed the training.',
    `compliance_requirement_code` STRING COMMENT 'Code of the regulatory or compliance requirement linked to this training.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training completion record was created in the system.',
    `credits_earned` DECIMAL(18,2) COMMENT 'Number of continuing education credits earned.',
    `duration_minutes` STRING COMMENT 'Total duration of the training in minutes.',
    `employee_email` STRING COMMENT 'Primary email address of the employee.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `location` STRING COMMENT 'Physical or virtual location where the training took place.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates if the training was mandatory for the employees role.',
    `notes` STRING COMMENT 'Additional remarks or comments about the training completion.',
    `pass_fail_status` STRING COMMENT 'Result of the training assessment indicating pass or fail.. Valid values are `pass|fail`',
    `review_status` STRING COMMENT 'Result of the compliance review of the training completion.. Valid values are `approved|rejected|under_review`',
    `review_timestamp` TIMESTAMP COMMENT 'Timestamp when the training completion was reviewed for compliance.',
    `trainer_name` STRING COMMENT 'Name of the trainer or instructor.',
    `training_category` STRING COMMENT 'Broad category of the training content.. Valid values are `compliance|security|privacy|risk|operations|customer_service`',
    `training_completion_status` STRING COMMENT 'Current status of the training record.. Valid values are `completed|revoked|expired|pending`',
    `training_method` STRING COMMENT 'Method through which the training was delivered.. Valid values are `online|inperson|virtual_class|self_paced`',
    `training_module_name` STRING COMMENT 'Descriptive name of the training module.',
    `training_provider` STRING COMMENT 'Organization or vendor that provided the training.',
    `training_type` STRING COMMENT 'Indicates whether the training is mandatory, optional, refresher, or certification.. Valid values are `mandatory|optional|refresher|certification`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training completion record.',
    `version_number` STRING COMMENT 'Version number of the training record for audit purposes.',
    CONSTRAINT pk_training_completion PRIMARY KEY(`training_completion_id`)
) COMMENT 'Compliance training completion record tracking mandatory regulatory training for employees — AML awareness, PCI DSS security training, GDPR data handling, sanctions awareness, and code of conduct. Captures employee reference, training module, completion date, assessment score, pass/fail status, certification expiry, and training provider. Supports PCI DSS Requirement 12.6 and BSA training obligations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` (
    `remediation_action_id` BIGINT COMMENT 'Unique identifier for the remediation action record.',
    `compliance_officer_employee_id` BIGINT COMMENT 'Identifier of the compliance officer overseeing the remediation.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or team responsible for executing the remediation.',
    `document_id` BIGINT COMMENT 'Identifier of the stored evidence document linked to the remediation.',
    `primary_remediation_employee_id` BIGINT COMMENT 'Identifier of the individual or team responsible for executing the remediation.',
    `regulatory_obligation_id` BIGINT COMMENT 'Reference to the specific regulatory obligation linked to this action.',
    `action_code` STRING COMMENT 'Business‑assigned code used to reference the remediation action in reports and audits.',
    `action_name` STRING COMMENT 'Human‑readable name describing the remediation action.',
    `action_outcome` STRING COMMENT 'Result of the remediation after verification.. Valid values are `resolved|partial|failed|not_applicable`',
    `action_type` STRING COMMENT 'Category of the remediation action indicating its nature.. Valid values are `policy|process|technical|training|audit`',
    `actual_completion_date` DATE COMMENT 'Date on which the remediation action was actually completed.',
    `completion_status` STRING COMMENT 'Result of the completion timing relative to the target.. Valid values are `on_time|late|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation action record was created.',
    `evidence_url` STRING COMMENT 'Link to supporting evidence or documentation for the remediation.',
    `is_high_risk` BOOLEAN COMMENT 'Flag indicating whether the remediation action is considered high risk.',
    `notes` STRING COMMENT 'Free‑form notes captured by analysts or owners.',
    `owner_name` STRING COMMENT 'Full name of the responsible owner.',
    `priority` STRING COMMENT 'Business priority assigned to the remediation action.. Valid values are `low|medium|high`',
    `regulatory_framework` STRING COMMENT 'Regulatory regime governing the remediation requirement.. Valid values are `PCI_DSS|AML|GDPR|PSD2|SOX`',
    `remediation_action_description` STRING COMMENT 'Detailed narrative of what the remediation action entails.',
    `remediation_action_status` STRING COMMENT 'Current lifecycle status of the remediation action.. Valid values are `open|in_progress|completed|closed|deferred`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating assigned to the remediation action.',
    `severity` STRING COMMENT 'Severity classification of the underlying finding.. Valid values are `low|medium|high|critical`',
    `source` STRING COMMENT 'Origin of the compliance finding that triggered this remediation action.. Valid values are `control_assessment|pci_dss_audit|examination_request|compliance_case`',
    `target_completion_date` DATE COMMENT 'Date by which the remediation action is expected to be finished.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the remediation action record.',
    `verification_status` STRING COMMENT 'Status of the post‑remediation verification review.. Valid values are `pending|verified|rejected`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the verification status was recorded.',
    CONSTRAINT pk_remediation_action PRIMARY KEY(`remediation_action_id`)
) COMMENT 'Tracks remediation actions arising from compliance findings, audit deficiencies, regulatory examination outcomes, or breach events. Captures finding source (control_assessment, pci_dss_audit, examination_request, compliance_case), action description, responsible owner, target completion date, actual completion date, evidence of remediation, and closure verification status.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` (
    `jurisdiction_profile_id` BIGINT COMMENT 'Unique system-generated identifier for the jurisdiction profile record.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Jurisdiction profiles define the regulatory environment; linking to obligations ties profiles to applicable rules.',
    `amendment_indicator` BOOLEAN COMMENT 'Flag indicating whether the record reflects an amendment to a prior version.',
    `aml_ctf_regime` STRING COMMENT 'Classification of the jurisdictions anti‑money‑laundering and counter‑terrorism financing regime (e.g., FATF, Non‑FATF).',
    `applicable_regulations` STRING COMMENT 'Comma‑separated list of regulation codes that apply in this jurisdiction (e.g., PSD2, Reg E, APRA CPS 234).',
    `classification` STRING COMMENT 'Category of the jurisdiction (e.g., sovereign, non‑sovereign, special economic zone).',
    `compliance_owner` STRING COMMENT 'Name of the internal owner responsible for this jurisdictions compliance data.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the jurisdiction profile record was first created.',
    `currency_code` STRING COMMENT 'Default currency used for transactions in the jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `data_protection_law` STRING COMMENT 'Primary data‑privacy legislation governing the jurisdiction (e.g., GDPR).',
    `data_residency_requirements` STRING COMMENT 'Specific data residency or localisation obligations imposed by the jurisdiction.',
    `effective_from` DATE COMMENT 'Date when the jurisdiction profile becomes effective.',
    `effective_until` DATE COMMENT 'Date when the jurisdiction profile ceases to be effective (null if open‑ended).',
    `enforcement_penalty` DECIMAL(18,2) COMMENT 'Typical monetary penalty for non‑compliance in this jurisdiction.',
    `fatf_mutual_evaluation_rating` STRING COMMENT 'Latest FATF mutual‑evaluation rating for the jurisdiction.. Valid values are `Compliant|Partially_Compliant|Non_Compliant|Pending`',
    `is_cross_border_allowed` BOOLEAN COMMENT 'Indicates whether cross‑border payments are permitted under local regulations.',
    `jurisdiction_profile_description` STRING COMMENT 'Extended textual description of the jurisdiction profile.',
    `jurisdiction_profile_name` STRING COMMENT 'Human‑readable name of the jurisdiction (e.g., United States, European Union).',
    `jurisdiction_profile_status` STRING COMMENT 'Current lifecycle status of the jurisdiction profile.. Valid values are `active|inactive|deprecated`',
    `jurisdiction_type` STRING COMMENT 'Specific type classification of the jurisdiction.. Valid values are `sovereign|non_sovereign|special_economic_zone`',
    `last_review_date` DATE COMMENT 'Date when the jurisdiction profile was last reviewed for accuracy.',
    `legal_entity_identifier` STRING COMMENT '20‑character global identifier for legal entities operating in the jurisdiction.. Valid values are `^[A-Z0-9]{20}$`',
    `max_daily_volume` DECIMAL(18,2) COMMENT 'Regulatory limit on total daily transaction volume for a participant.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Regulatory ceiling for a single transaction amount in the jurisdiction.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the jurisdiction.',
    `privacy_regulation` STRING COMMENT 'Specific privacy regulation reference applicable in the jurisdiction.',
    `regulatory_zone` STRING COMMENT 'Geographic regulatory zone grouping (e.g., EU, APAC).. Valid values are `EU|EEA|APAC|NA|LATAM|MEA`',
    `reporting_obligation` STRING COMMENT 'Description of mandatory regulatory reporting requirements (e.g., SAR, STR).',
    `review_cadence` STRING COMMENT 'Frequency at which the jurisdiction profile must be reviewed.. Valid values are `annual|biannual|quarterly|monthly`',
    `risk_rating` STRING COMMENT 'Overall compliance risk rating assigned to the jurisdiction.. Valid values are `low|medium|high|critical`',
    `sanctions_regime_membership` STRING COMMENT 'Sanctions lists or regimes the jurisdiction participates in.. Valid values are `OFAC|EU|UN|UK|None`',
    `source_system` STRING COMMENT 'Originating operational system that supplied the jurisdiction data.',
    `tax_identification_number_format` STRING COMMENT 'Pattern or description of the tax ID format used in the jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the jurisdiction profile.',
    `version_number` STRING COMMENT 'Version identifier for the jurisdiction profile record.',
    CONSTRAINT pk_jurisdiction_profile PRIMARY KEY(`jurisdiction_profile_id`)
) COMMENT 'Reference master of regulatory jurisdictions in which the business operates — country, regulatory zone (EU, EEA, APAC), applicable payment regulations (PSD2, Reg E, APRA CPS 234), AML/CTF regime classification, FATF mutual evaluation rating, data residency requirements, and sanctions regime membership. Used to determine applicable obligations per transaction corridor and entity domicile.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` (
    `case_transaction_link_id` BIGINT COMMENT 'Primary key for the case_transaction_link association',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance_compliance_case',
    `wallet_transaction_id` BIGINT COMMENT 'Foreign key linking to wallet_transaction',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the link between the case and transaction was recorded',
    `link_reason` STRING COMMENT 'Reason why the transaction was linked to the compliance case (e.g., AML suspicion, sanction hit)',
    CONSTRAINT pk_case_transaction_link PRIMARY KEY(`case_transaction_link_id`)
) COMMENT 'This association product represents the link between a compliance investigation case and a wallet transaction. It captures the reason for linking and the timestamp when the link was detected. Each record links one compliance case to one wallet transaction with attributes that exist only in the context of this relationship.. Existence Justification: A compliance investigation case may involve multiple wallet transactions, and a single wallet transaction can be referenced by multiple compliance cases when it triggers separate investigations. The business records the reason for each link and the timestamp when the association was detected, meaning the relationship itself carries data.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `parent_party_id` BIGINT COMMENT 'Self-referencing FK on party (parent_party_id)',
    `aml_screening_status` STRING COMMENT 'Result of the anti‑money‑laundering screening process.',
    `business_registration_number` STRING COMMENT 'Official registration number for corporate parties.',
    `citizenship_country_code` STRING COMMENT 'ISO country code of the partys citizenship.',
    `compliance_status` STRING COMMENT 'Overall compliance standing of the party with regulatory obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the party record was first created in the system.',
    `data_retention_end_date` DATE COMMENT 'Date after which the partys personal data must be deleted or anonymized.',
    `data_subject_consent` BOOLEAN COMMENT 'Indicates whether the party has provided consent for data processing.',
    `date_of_birth` DATE COMMENT 'Birth date of an individual party.',
    `external_party_reference` STRING COMMENT 'Identifier used by external partners or regulators to reference this party.',
    `gender` STRING COMMENT 'Self‑declared gender of the individual party.',
    `industry_code` STRING COMMENT 'Standard industry code (e.g., NAICS) describing the partys business sector.',
    `is_high_risk` BOOLEAN COMMENT 'True if the party is classified as high risk based on internal criteria.',
    `is_pep` BOOLEAN COMMENT 'True if the party is identified as a politically exposed person.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance assessment for the party.',
    `legal_name` STRING COMMENT 'The full legal name of the party as recorded in official documents.',
    `national_id_number` STRING COMMENT 'Official national identification number (e.g., SSN, NIN).',
    `notes` STRING COMMENT 'Additional free‑form comments or observations about the party.',
    `ofac_check_status` STRING COMMENT 'Outcome of the sanctions screening against the OFAC SDN list.',
    `party_subtype` STRING COMMENT 'More granular classification within the party type, such as corporate, non‑profit, or sovereign.',
    `party_type` STRING COMMENT 'High‑level classification of the party (e.g., individual, organization).',
    `primary_address_line1` STRING COMMENT 'First line of the partys primary mailing address.',
    `primary_address_line2` STRING COMMENT 'Second line of the partys primary mailing address (optional).',
    `primary_city` STRING COMMENT 'City component of the partys primary address.',
    `primary_country_code` STRING COMMENT 'Three‑letter ISO country code of the partys primary address.',
    `primary_email` STRING COMMENT 'Primary email address used for electronic communications with the party.',
    `primary_phone` STRING COMMENT 'Primary telephone number for contacting the party.',
    `primary_postal_code` STRING COMMENT 'Postal or ZIP code of the partys primary address.',
    `primary_state` STRING COMMENT 'State or province component of the partys primary address.',
    `residency_country_code` STRING COMMENT 'ISO country code where the party currently resides.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating (0‑100) derived from AML, fraud, and regulatory checks.',
    `sanctions_list` STRING COMMENT 'Comma‑separated list of sanctions identifiers that matched this party, if any.',
    `source_of_funds` STRING COMMENT 'Declared origin of the partys funds (e.g., salary, investment, loan).',
    `source_system` STRING COMMENT 'Name of the upstream operational system that originated the party record.',
    `party_status` STRING COMMENT 'Current lifecycle status of the party record.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status of the party.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`training_module` (
    `training_module_id` BIGINT COMMENT 'Primary key for training_module',
    `prerequisite_training_module_id` BIGINT COMMENT 'Self-referencing FK on training_module (prerequisite_training_module_id)',
    `author_email` STRING COMMENT 'Email address of the module author for contact and attribution.',
    `author_name` STRING COMMENT 'Full name of the internal subject‑matter expert who authored the module.',
    `compliance_area` STRING COMMENT 'Regulatory domain or compliance focus of the training module.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the module record was first created in the system.',
    `delivery_method` STRING COMMENT 'Mode through which the training is delivered.',
    `training_module_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and learning objectives of the module.',
    `duration_minutes` STRING COMMENT 'Total expected time to complete the module, expressed in minutes.',
    `effective_from` DATE COMMENT 'Date when the training module becomes effective for learners.',
    `effective_until` DATE COMMENT 'Date when the training module expires or is retired (null if open‑ended).',
    `file_size_bytes` BIGINT COMMENT 'Size of the content file in bytes.',
    `file_url` STRING COMMENT 'Link to the stored training content file.',
    `format` STRING COMMENT 'Technical format of the training material.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of the module is required for the target audience.',
    `language` STRING COMMENT 'Primary language in which the module content is delivered.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the module content was last reviewed for compliance relevance.',
    `module_code` STRING COMMENT 'Business identifier or code used to reference the module in catalogs and reports.',
    `module_name` STRING COMMENT 'Human‑readable name of the training module.',
    `module_type` STRING COMMENT 'Classification of the module indicating whether it is mandatory, optional, or a refresher.',
    `passing_score_percent` DECIMAL(18,2) COMMENT 'Minimum percentage score required to pass the module quiz.',
    `quiz_required` BOOLEAN COMMENT 'Indicates whether the module includes a post‑completion assessment.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory content reviews.',
    `training_module_status` STRING COMMENT 'Current lifecycle status of the module.',
    `target_audience` STRING COMMENT 'Intended audience category for the training module.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the module record.',
    `version` STRING COMMENT 'Version identifier of the module content (e.g., 1.0, 2.1).',
    CONSTRAINT pk_training_module PRIMARY KEY(`training_module_id`)
) COMMENT 'Master reference table for training_module. Referenced by training_module_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ADD CONSTRAINT `fk_compliance_compliance_aml_screening_result_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_watchlist_entry_id` FOREIGN KEY (`watchlist_entry_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`watchlist_entry`(`watchlist_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_related_compliance_case_id` FOREIGN KEY (`related_compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ADD CONSTRAINT `fk_compliance_str_filing_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_control_id` FOREIGN KEY (`control_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ADD CONSTRAINT `fk_compliance_pci_dss_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ADD CONSTRAINT `fk_compliance_psd2_incident_report_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ADD CONSTRAINT `fk_compliance_attestation_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ADD CONSTRAINT `fk_compliance_training_completion_training_module_id` FOREIGN KEY (`training_module_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`training_module`(`training_module_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ADD CONSTRAINT `fk_compliance_remediation_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ADD CONSTRAINT `fk_compliance_jurisdiction_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ADD CONSTRAINT `fk_compliance_case_transaction_link_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ADD CONSTRAINT `fk_compliance_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` ADD CONSTRAINT `fk_compliance_training_module_prerequisite_training_module_id` FOREIGN KEY (`prerequisite_training_module_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`training_module`(`training_module_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `payments_fintech_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` SET TAGS ('dbx_subdomain' = 'aml_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `compliance_aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance AML Screening Result ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `analyst_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `analyst_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Reason');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `compliance_aml_screening_result_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `compliance_aml_screening_result_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Full Name (CUST_NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `customer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|review|block');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'transaction|cardholder|merchant|partner');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `is_sar_required` SET TAGS ('dbx_business_glossary_term' = 'SAR Required Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `is_str_required` SET TAGS ('dbx_business_glossary_term' = 'STR Required Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'none|name|address|email|phone|sanctions');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `sar_filing_status` SET TAGS ('dbx_business_glossary_term' = 'SAR Filing Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `sar_filing_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|filed|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `sar_filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SAR Filing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `screening_engine` SET TAGS ('dbx_business_glossary_term' = 'Screening Engine');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `screening_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Screening Rule Version');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_business_glossary_term' = 'STR Filing Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|filed|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `str_filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'STR Filing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `typology` SET TAGS ('dbx_business_glossary_term' = 'Typology');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_aml_screening_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` SET TAGS ('dbx_subdomain' = 'aml_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Related Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `watchlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `block_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Block Action Taken');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `block_action_taken` SET TAGS ('dbx_value_regex' = 'blocked|allowed|review');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `false_positive_flag` SET TAGS ('dbx_business_glossary_term' = 'False Positive Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `hit_details` SET TAGS ('dbx_business_glossary_term' = 'Hit Details');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `hit_details` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `hit_details` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `hit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hit Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Risk Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `list_name` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `list_version` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Version');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|partner|beneficiary');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_value_regex' = 'SAR|STR|None');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `reporting_obligation_filed` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation Filed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Review Decision');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'accept|reject|escalate');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `screening_method` SET TAGS ('dbx_business_glossary_term' = 'Screening Method');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `screening_method` SET TAGS ('dbx_value_regex' = 'exact_match|fuzzy_match');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `screening_source` SET TAGS ('dbx_business_glossary_term' = 'Screening Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'completed|pending|error');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report Filing ID (SAR_FILING_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Officer Identifier (OFFICER_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Officer Identifier (OFFICER_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case Identifier (CASE_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `related_compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case Identifier (CASE_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `activity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity End Date (ACTIVITY_END_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `activity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Start Date (ACTIVITY_START_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Type (ACTIVITY_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'money_laundering|fraud|terrorist_financing|structuring|smurfing|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Sequence Number (AMENDMENT_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `amount_involved` SET TAGS ('dbx_business_glossary_term' = 'Monetary Amount Involved (AMOUNT_INCURRED)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `amount_involved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `amount_involved` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `attachment_reference` SET TAGS ('dbx_business_glossary_term' = 'Attachment Reference (e.g., file path or token) (ATTACHMENT_REF)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date (COMPLIANCE_REVIEW_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status (COMPLIANCE_REVIEW_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|escalated');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONFIDENTIALITY_LEVEL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `data_retention_expiry` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date (RETENTION_EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date (FILING_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'BSA Tracking Number (BSA_TRACKING_NO)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Filing Officer Name (OFFICER_NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_officer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_officer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (FILING_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|under_review|closed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Amended Filing Indicator (IS_AMENDED)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag (IS_HIGH_RISK)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Summary of Suspicious Activity (NARRATIVE_SUMMARY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REGULATORY_BODY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FinCEN|OFAC|FCA|ECB|Other|Unknown');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Assigned by Compliance System (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Filing (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_address` SET TAGS ('dbx_business_glossary_term' = 'Subject Address (SUBJECT_ADDRESS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_country_code` SET TAGS ('dbx_business_glossary_term' = 'Subject Country ISO Code (SUBJECT_COUNTRY_CODE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Subject Entity Full Name (SUBJECT_NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Entity Type (SUBJECT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_type` SET TAGS ('dbx_value_regex' = 'individual|organization|trust|partnership|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_business_glossary_term' = 'Subject Identifier (e.g., SSN, EIN) (SUBJECT_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `str_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Transaction Report Filing ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Case ID (ICI)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Identifier (REI)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `acknowledgment_number` SET TAGS ('dbx_business_glossary_term' = 'Regulator Acknowledgement Number (RAN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp (AT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `aml_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti‑Money Laundering Flag (AML)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer (CO)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `ctf_flag` SET TAGS ('dbx_business_glossary_term' = 'Counter‑Terrorism Financing Flag (CTF)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `description_of_suspicion` SET TAGS ('dbx_business_glossary_term' = 'Suspicion Description (SD)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date (FD)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number (FRN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type (FT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'FATF|FCA|AUSTRAC|MAS|FINCEN');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High‑Risk Flag (HRF)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes (AN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `prior_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Prior Filing Reference (PFR)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `regulator_name` SET TAGS ('dbx_business_glossary_term' = 'Regulator Name (RN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `reporting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Name (REN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Risk_Comp_Mgmt|Fraud_Detection|Transaction_Processing');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (FS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|rejected|closed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp (ST)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `suspicious_indicator_codes` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Indicator Codes (SIC)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount (TA)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date (TD)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference (TR)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`str_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `compliance_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `kyc_document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Document Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Participant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Result (AML_RESULT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `aml_screening_result` SET TAGS ('dbx_value_regex' = 'clear|match|pending|exempt|unknown');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `cdd_classification` SET TAGS ('dbx_business_glossary_term' = 'Customer Due Diligence Classification (CDD_CLASS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `cdd_classification` SET TAGS ('dbx_value_regex' = 'cdd|edd|none');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_AT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date (EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date (ISSUE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Document Issuing Country (ISSUING_COUNTRY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (DOC_NUM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Full Name (NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (IS_ACTIVE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `kyc_entity_type` SET TAGS ('dbx_business_glossary_term' = 'KYC Entity Type (ENTITY_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `kyc_entity_type` SET TAGS ('dbx_value_regex' = 'individual|business|sole_proprietor|non_profit|government|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `primary_contact_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Type (CONTACT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `primary_contact_type` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `primary_contact_value` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Value (CONTACT_VALUE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `primary_contact_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `primary_contact_value` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `provider_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Reference ID (PROVIDER_REF_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `re_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re‑Verification Due Date (REVERIFY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (RISK_TIER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `sanctions_check_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Result (SANCTIONS_RESULT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `sanctions_check_result` SET TAGS ('dbx_value_regex' = 'clear|match|pending|exempt|unknown');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_AT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (METHOD)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document|biometric|database_lookup|third_party|manual');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Verification Outcome (OUTCOME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|partial|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_provider` SET TAGS ('dbx_business_glossary_term' = 'Verification Provider (PROVIDER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|under_review|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp (TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Obligation Classification');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'mandatory|optional|voluntary');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `control_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Obligation Document URL');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `enforcement_penalty` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Penalty');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulation_type` SET TAGS ('dbx_business_glossary_term' = 'Regulation Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulation_type` SET TAGS ('dbx_value_regex' = 'law|directive|standard|guideline');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_cadence` SET TAGS ('dbx_business_glossary_term' = 'Review Cadence');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_cadence` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|monthly');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Org Unit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Control Audit Trail (CTRL_AUDIT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code (CTRL_CODE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description (CTRL_DESC)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name (CTRL_NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_scope` SET TAGS ('dbx_business_glossary_term' = 'Control Scope (CTRL_SCOPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status (CTRL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type (CTRL_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Control Criticality (CTRL_CRIT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_FROM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EFF_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected Indicator (EVIDENCE_COLLECTED)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required (EVIDENCE_REQ)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL (EVIDENCE_URL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency (CTRL_FREQ)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|ad_hoc|weekly|daily');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automation Indicator (IS_AUTOMATED)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `is_key_control` SET TAGS ('dbx_business_glossary_term' = 'Key Control Indicator (IS_KEY_CTRL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Indicator (IS_MANUAL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date (LAST_ASMT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `last_assessment_result` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Result (LAST_ASMT_RES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `last_assessment_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial|not_tested');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `next_assessment_due` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date (NEXT_ASMT_DUE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework (REG_FRAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'PCI_DSS|SOX|GDPR|AML|CTF|PSD2');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `regulatory_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Code (REG_REQ_CODE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (REMEDIATION_ACT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status (REMEDIATION_STAT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Control Tags (CTRL_TAGS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `testing_methodology` SET TAGS ('dbx_business_glossary_term' = 'Testing Methodology (TEST_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Control Version (CTRL_VER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Control Assessment Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_period` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_business_glossary_term' = 'Assessor Role');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `assessor_role` SET TAGS ('dbx_value_regex' = 'internal_audit|qsa|external_auditor|compliance_officer');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_assessment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_category` SET TAGS ('dbx_business_glossary_term' = 'Control Category');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_category` SET TAGS ('dbx_value_regex' = 'pci_dss|sox|gdpr|aml|cft|bsa');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `evidence_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `finding_severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `finding_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Assessment Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'completed|pending|in_progress|failed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'pci_dss|sox|gdpr|aml|cft|bsa');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `testing_approach` SET TAGS ('dbx_business_glossary_term' = 'Testing Approach');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `testing_approach` SET TAGS ('dbx_value_regex' = 'walkthrough|sampling|automated|penetration|interview');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `pci_dss_audit_id` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Audit Identifier (AUDIT_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'External Audit Document Identifier (DOC_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `assessment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Assessment End Date (END_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Assessment Start Date (START_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Assessment Timestamp (ASSESSMENT_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_document_hash` SET TAGS ('dbx_business_glossary_term' = 'Hash of the Audit Document for Integrity (DOC_HASH)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_name` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Audit Name (AUDIT_NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Audit Number (AUDIT_NO)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record for the Audit (SOURCE_SYS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary of the Audit (SUMMARY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Audit Type (ROC/SAQ)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'ROC|SAQ');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `audit_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Version Identifier (AUDIT_VER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `cde_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Data Environment Boundary Description (CDE_BOUNDARY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `compensating_controls_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Compensating Controls Documented (COMP_CTRL_COUNT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level (DATA_CLASS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Findings Identified (FINDINGS_COUNT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code (ISO 3166‑1 Alpha‑3) (JURISD)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp (REVIEWED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status (AUDIT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `overall_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Score Percentage (COMPLIANCE_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `overall_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `overall_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_contact_email` SET TAGS ('dbx_business_glossary_term' = 'QSA Firm Contact Email (QSA_EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'QSA Firm Contact Phone (QSA_PHONE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `qsa_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Security Assessor Firm Name (QSA_FIRM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Applicable (FRAMEWORK)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'PCI_DSS|PCI_P2PE|PCI_PIN');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline Date (REM_DEADLINE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status (REM_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `report_file_name` SET TAGS ('dbx_business_glossary_term' = 'Report File Name (REPORT_FILE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `report_file_path` SET TAGS ('dbx_business_glossary_term' = 'Report File Path or Storage Location (REPORT_PATH)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date (REPORT_SUBMIT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `requirements_tested` SET TAGS ('dbx_business_glossary_term' = 'List of PCI DSS Requirements Tested (REQ_TESTED)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Assessment (RISK_LEVEL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `saq_type` SET TAGS ('dbx_business_glossary_term' = 'Self‑Assessment Questionnaire Type (SAQ_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `saq_type` SET TAGS ('dbx_value_regex' = 'A|A-EP|B|C|C-VT|D');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description of the Cardholder Data Environment (CDE_SCOPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `gdpr_data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Subject Request ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier (REQ_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier (REQ_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `fulfillment_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Action Taken (FULFILL_ACTION)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status (FULFILL_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `request_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Receipt Timestamp (RR_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `request_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request Reference Number (RRN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Lifecycle Status (REQ_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Type (DSRT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'access|erasure|portability|rectification|restriction|objection');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address (REQ_EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Full Name (REQ_NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Response Deadline (RR_DEADLINE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VER_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`gdpr_data_subject_request` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Identifier (CONSENT_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DEVICE_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Identifier (PARTY_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Collection Channel (COLLECTION_CHANNEL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `collection_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store|call_center|email');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status (CONSENT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_text_hash` SET TAGS ('dbx_business_glossary_term' = 'Consent Text Hash (CONSENT_HASH)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Capture Timestamp (CONSENT_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type (CONSENT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'marketing|data_sharing|open_banking|sca');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version (CONSENT_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `data_processing_purpose` SET TAGS ('dbx_business_glossary_term' = 'Data Processing Purpose (PURPOSE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (RETENTION_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective From (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Consent Effective Until (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `geo_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP_ADDR)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Consent Language (LANGUAGE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `lawful_basis` SET TAGS ('dbx_business_glossary_term' = 'Lawful Basis for Processing (LAWFUL_BASIS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `lawful_basis` SET TAGS ('dbx_value_regex' = 'consent|contract|legal_obligation|legitimate_interest');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Type (PARTY_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'cardholder|merchant');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `reconsent_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re‑consent Due Date (RECONSENT_DUE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `reconsent_required` SET TAGS ('dbx_business_glossary_term' = 'Re‑consent Required (RECONSENT_REQUIRED)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope (SCOPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String (USER_AGENT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason (WITHDRAWAL_REASON)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `withdrawal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Timestamp (WITHDRAWAL_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Timestamp (REG_ACK_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `attached_document_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Count (REG_DOC_COUNT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_trail_hash` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Hash (REG_AUDIT_HASH)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `audit_trail_hash` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REG_CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Amount (REG_FILING_AMT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_business_glossary_term' = 'Filing Category (REG_CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_value_regex' = 'financial|anti_money_laundering|consumer_protection|security|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date (REG_DEADLINE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description (REG_FILING_DESC)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Effective Date (REG_EFFECTIVE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_priority` SET TAGS ('dbx_business_glossary_term' = 'Filing Priority (REG_PRIORITY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number (REG_FILING_REF)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status (REG_FILING_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|closed|withdrawn');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_title` SET TAGS ('dbx_business_glossary_term' = 'Filing Title (REG_FILING_TITLE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type (REG_FILING_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'ctr|psd2_incident|reg_e_notice|cfpb_complaint|swift_gpi|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential (REG_CONFIDENTIAL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Filing Outcome (REG_OUTCOME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description (REG_OUTCOME_DESC)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulator_name` SET TAGS ('dbx_business_glossary_term' = 'Regulator Name (REGULATOR)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `related_case_number` SET TAGS ('dbx_business_glossary_term' = 'Related Case Number (REG_RELATED_CASE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date (REG_RESPONSE_DUE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `response_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Received Timestamp (REG_RESPONSE_RECV_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (REG_SOURCE_SYS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp (REG_SUBMIT_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REG_UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examination_request_id` SET TAGS ('dbx_business_glossary_term' = 'Examination Request Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'AML|PCI_DSS|GDPR|CCPA|SOX|FATF');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `documents_provided` SET TAGS ('dbx_business_glossary_term' = 'Documents Provided');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examination_request_status` SET TAGS ('dbx_business_glossary_term' = 'Examination Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examination_request_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|escalated|withdrawn');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examination_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examination_type` SET TAGS ('dbx_value_regex' = 'routine|targeted|enforcement');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Examiner Contact Email');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Examiner Contact Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Examiner Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examiner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Actions');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `information_requested` SET TAGS ('dbx_business_glossary_term' = 'Information Requested');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `internal_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Email');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `internal_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `internal_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `internal_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Is Escalated');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Examination Outcome');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'compliant|findings|penalties|no_action');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `regulator` SET TAGS ('dbx_business_glossary_term' = 'Regulator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `regulator` SET TAGS ('dbx_value_regex' = 'OCC|CFPB|FCA|ECB|FinCEN');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Examination Request Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_compliance_case');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `assigned_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Compliance Officer Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Compliance Officer Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Related Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `risk_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Number (CCN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Status (CCS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_review|escalated|closed|dismissed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_subtype` SET TAGS ('dbx_business_glossary_term' = 'Case Subtype');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_tags` SET TAGS ('dbx_business_glossary_term' = 'Case Tags');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Type (CCT)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `compliance_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Taken');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `compliance_case_description` SET TAGS ('dbx_business_glossary_term' = 'Case Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `compliance_officer_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `evidence_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Log Reference Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Case Escalation Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `is_false_positive` SET TAGS ('dbx_business_glossary_term' = 'False Positive Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Case Priority Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Applicable');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'PCI_DSS|GDPR|AML|OFAC|PSD2|FATF');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `regulatory_report_filed` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Filed Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `report_filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Filing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Case Resolution Outcome');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'remediation|fine|no_action|warning|settlement');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Case Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `source_trigger` SET TAGS ('dbx_business_glossary_term' = 'Case Source Trigger (CST)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `source_trigger` SET TAGS ('dbx_value_regex' = 'SAR|audit_finding|regulator_inquiry|internal_alert|whistleblower');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `breach_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `affected_data_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected Data Categories');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `affected_systems` SET TAGS ('dbx_business_glossary_term' = 'Affected Systems');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `board_report_date` SET TAGS ('dbx_business_glossary_term' = 'Board Report Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `breach_source` SET TAGS ('dbx_business_glossary_term' = 'Breach Source');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `breach_source` SET TAGS ('dbx_value_regex' = 'internal|external|third_party|unknown');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `data_loss_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Loss Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Discovery Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `encryption_status_at_time` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status at Time of Breach');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `estimated_cardholder_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cardholder Count');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `estimated_merchant_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Merchant Count');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `is_reported_to_board` SET TAGS ('dbx_business_glossary_term' = 'Reported to Board Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Breach Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|postal|public_statement|portal|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `notification_trigger` SET TAGS ('dbx_business_glossary_term' = 'Notification Trigger');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `notification_trigger` SET TAGS ('dbx_value_regex' = 'gdpr|state_law|pci_dss|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `regulator_notified` SET TAGS ('dbx_business_glossary_term' = 'Regulator Notified');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `regulator_notified` SET TAGS ('dbx_value_regex' = 'gdpr|pci_dss|ffiec|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `remediation_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Summary');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Breach Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`breach_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` SET TAGS ('dbx_subdomain' = 'aml_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `ctf_control_id` SET TAGS ('dbx_business_glossary_term' = 'CTF Control ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `applies_to_channel` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channel');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `applies_to_channel` SET TAGS ('dbx_value_regex' = 'online|pos|mobile|api|batch');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `applies_to_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `applies_to_transaction_type` SET TAGS ('dbx_value_regex' = 'card|ach|wire|crypto|mobile_wallet');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_value_regex' = 'FATF|FinCEN|EU AML|UK FCA|US OFAC');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Control Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Control Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `control_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `control_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Department');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'transaction_monitoring_rule|high_risk_jurisdiction|pep_screening|due_diligence|correspondent_bank_due_diligence|suspicious_activity_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `ctf_control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `ctf_control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `ctf_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `fatf_recommendation` SET TAGS ('dbx_business_glossary_term' = 'FATF Recommendation');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `regulatory_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`ctf_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `psd2_incident_report_id` SET TAGS ('dbx_business_glossary_term' = 'PSD2 Incident Report ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `affected_services` SET TAGS ('dbx_business_glossary_term' = 'Affected Payment Services');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `data_subjects_impacted` SET TAGS ('dbx_business_glossary_term' = 'Data Subjects Impacted');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `final_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Submission Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Reference Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_title` SET TAGS ('dbx_business_glossary_term' = 'Incident Title');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'operational|security|fraud|compliance|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `interim_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Interim Report Submission Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `is_reported_to_nca` SET TAGS ('dbx_business_glossary_term' = 'Reported to NCA Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `is_sar_required` SET TAGS ('dbx_business_glossary_term' = 'SAR Required Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `mitigation_actions` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actions');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `nca_reference_number` SET TAGS ('dbx_business_glossary_term' = 'National Competent Authority Reference Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initial Notification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `psd2_incident_report_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `psd2_incident_report_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'ECB|NCA|FCA|OCC|FINCEN|ESMA');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `report_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `report_submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|rejected|accepted');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `sar_filing_status` SET TAGS ('dbx_business_glossary_term' = 'SAR Filing Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `sar_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_business_glossary_term' = 'STR Filing Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `user_impact_count` SET TAGS ('dbx_business_glossary_term' = 'User Impact Count');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`psd2_incident_report` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `sca_exemption_id` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Exemption ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `compliance_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applied Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_reference` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Reference');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_requested_by` SET TAGS ('dbx_business_glossary_term' = 'Exemption Requested By');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_requested_by` SET TAGS ('dbx_value_regex' = 'psp|acquirer|issuer|merchant');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_status` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_status` SET TAGS ('dbx_value_regex' = 'applied|approved|rejected|revoked|expired');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Exemption Threshold Amount');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Exemption Threshold Currency');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'low_value|low_risk_tra|recurring|merchant_initiated|whitelisted_payee|trusted_beneficiary');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Exemption Valid From Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `exemption_valid_until` SET TAGS ('dbx_business_glossary_term' = 'Exemption Valid Until Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `is_exemption_revoked` SET TAGS ('dbx_business_glossary_term' = 'Exemption Revoked Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `liability_shift` SET TAGS ('dbx_business_glossary_term' = 'Liability Shift');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `liability_shift` SET TAGS ('dbx_value_regex' = 'merchant|issuer|psp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exemption Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `payment_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `payment_instrument_type` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|digital_wallet|crypto');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|virtual|contactless');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `reporting_deadline` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exemption Revocation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Exemption Risk Category');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Exemption Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_arn` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_mcc` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|declined|reversed|chargeback');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sca_exemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` SET TAGS ('dbx_subdomain' = 'aml_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `watchlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|removed');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Entity Address (ADDRESS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_aliases` SET TAGS ('dbx_business_glossary_term' = 'Entity Alias Names (ALIASES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_aliases` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_aliases` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Entity Full Name (NAME)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'individual|organization|vessel');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender (GENDER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|unknown');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `identification_number` SET TAGS ('dbx_business_glossary_term' = 'Identification Number (ID_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `identification_type` SET TAGS ('dbx_business_glossary_term' = 'Identification Type (ID_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `identification_type` SET TAGS ('dbx_value_regex' = 'passport|national_id|driver_license|tax_id|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Indicator (HIGH_RISK)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (REVIEW_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `list_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'External List Entry Reference (EXTERNAL_REF)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `list_source` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Source (SOURCE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `list_source` SET TAGS ('dbx_value_regex' = 'OFAC|EU|UN|HM_Treasury|PEP|Adverse_Media');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `list_version_date` SET TAGS ('dbx_business_glossary_term' = 'List Version Date (VERSION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score (MATCH_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality (NATIONALITY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Place of Birth (PLACE_OF_BIRTH)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `place_of_birth` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status (REVIEW_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'reviewed|not_reviewed|under_review');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category (RISK_CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `sanctions_type` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `sanctions_type` SET TAGS ('dbx_value_regex' = 'financial|trade|travel|arms|dual_use|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `source_url` SET TAGS ('dbx_business_glossary_term' = 'Source URL (SOURCE_URL)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Attestation Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `compliance_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Api Credential Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attached_document_url` SET TAGS ('dbx_business_glossary_term' = 'Attached Document URL');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_number` SET TAGS ('dbx_business_glossary_term' = 'Attestation Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_status` SET TAGS ('dbx_business_glossary_term' = 'Attestation Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked|expired');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_type` SET TAGS ('dbx_business_glossary_term' = 'Attestation Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attestation_type` SET TAGS ('dbx_value_regex' = 'PCI_DSS_AOC|SOX_302|AML_Program|GDPR|PSD2|BSA');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attesting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Attesting Party Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attesting_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attesting_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attesting_party_role` SET TAGS ('dbx_business_glossary_term' = 'Attesting Party Role');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `attesting_party_role` SET TAGS ('dbx_value_regex' = 'Compliance Officer|Business Unit Head|Board Member');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `control_owner` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `control_owner` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `control_owner` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `digital_signature_reference` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Reference');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Attestation Effective Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Attestation Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `enforcement_penalty_estimate` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Penalty Estimate');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `enforcement_penalty_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `enforcement_penalty_estimate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attestation Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `review_decision` SET TAGS ('dbx_business_glossary_term' = 'Attestation Review Decision');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `review_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|needs_revision');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attestation Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Attestation Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Attestation Scope Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`attestation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Attestation Version Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `attached_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Attached File Reference');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exception');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'global|regional|internal|partner|customer');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|pending|archived');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'AML|PCI_DSS|GDPR|Sanctions|BSA|Acceptable_Use');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `primary_training_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_module_id` SET TAGS ('dbx_business_glossary_term' = 'Training Module ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `compliance_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Credits Earned');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_email` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address (PII)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `employee_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `trainer_name` SET TAGS ('dbx_business_glossary_term' = 'Trainer Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'compliance|security|privacy|risk|operations|customer_service');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Training Record Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_completion_status` SET TAGS ('dbx_value_regex' = 'completed|revoked|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('dbx_business_glossary_term' = 'Training Method');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_method` SET TAGS ('dbx_value_regex' = 'online|inperson|virtual_class|self_paced');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_module_name` SET TAGS ('dbx_business_glossary_term' = 'Training Module Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|refresher|certification');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_completion` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `compliance_officer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `primary_remediation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `primary_remediation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `primary_remediation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_name` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Outcome');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_outcome` SET TAGS ('dbx_value_regex' = 'resolved|partial|failed|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Type (Policy/Process/Technical/Training/Audit)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'policy|process|technical|training|audit');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'on_time|late|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence URL');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Full Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'PCI_DSS|AML|GDPR|PSD2|SOX');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `remediation_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|deferred');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Finding Source (Control Assessment/PCI DSS Audit/Examination Request/Compliance Case)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'control_assessment|pci_dss_audit|examination_request|compliance_case');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`remediation_action` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `amendment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Amendment Indicator');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `aml_ctf_regime` SET TAGS ('dbx_business_glossary_term' = 'AML/CTF Regime Classification');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Classification');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 3166‑1 Alpha‑3 Country Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 4217 Currency Code');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `data_protection_law` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Law');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `data_residency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Requirements');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `enforcement_penalty` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `fatf_mutual_evaluation_rating` SET TAGS ('dbx_business_glossary_term' = 'FATF Mutual Evaluation Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `fatf_mutual_evaluation_rating` SET TAGS ('dbx_value_regex' = 'Compliant|Partially_Compliant|Non_Compliant|Pending');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `is_cross_border_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Transaction Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_profile_description` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_profile_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'sovereign|non_sovereign|special_economic_zone');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `legal_entity_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `max_daily_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `privacy_regulation` SET TAGS ('dbx_business_glossary_term' = 'Privacy Regulation');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Zone');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_value_regex' = 'EU|EEA|APAC|NA|LATAM|MEA');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation Description');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `review_cadence` SET TAGS ('dbx_business_glossary_term' = 'Review Cadence');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `review_cadence` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|monthly');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `sanctions_regime_membership` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Regime Membership');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `sanctions_regime_membership` SET TAGS ('dbx_value_regex' = 'OFAC|EU|UN|UK|None');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `tax_identification_number_format` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number Format');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` SET TAGS ('dbx_association_edges' = 'compliance.compliance_compliance_case,wallet.wallet_transaction');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ALTER COLUMN `case_transaction_link_id` SET TAGS ('dbx_business_glossary_term' = 'Case Transaction Link - Case Transaction Link Id');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Transaction Link - Compliance Compliance Case Id');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Case Transaction Link - Wallet Transaction Id');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Transaction Link - Detection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_transaction_link` ALTER COLUMN `link_reason` SET TAGS ('dbx_business_glossary_term' = 'Case Transaction Link - Link Reason');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` SET TAGS ('dbx_subdomain' = 'policy_controls');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `primary_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` SET TAGS ('dbx_subdomain' = 'customer_rights');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` ALTER COLUMN `training_module_id` SET TAGS ('dbx_business_glossary_term' = 'Training Module Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` ALTER COLUMN `prerequisite_training_module_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` ALTER COLUMN `author_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`training_module` ALTER COLUMN `author_email` SET TAGS ('dbx_pii_email' = 'true');
