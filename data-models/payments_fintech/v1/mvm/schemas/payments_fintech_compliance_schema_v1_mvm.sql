-- Schema for Domain: compliance | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`compliance` COMMENT 'Enterprise regulatory compliance domain owning AML screening results, OFAC/SDN sanctions checks, SAR and STR filings, CTF controls, BSA compliance records, PSD2 regulatory reporting, PCI DSS audit trails, GDPR data subject rights, and regulatory examination support. SSOT for regulatory obligations, FinCEN reporting, and compliance attestations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` (
    `aml_screening_result_id` BIGINT COMMENT 'System-generated unique identifier for each AML screening result record.',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: An AML screening result that triggers an investigation is associated with a compliance case. One compliance case may aggregate multiple AML screening results (e.g., a pattern of suspicious transaction',
    `ecosystem_partner_id` BIGINT COMMENT 'Internal identifier of the screened entity (transaction, cardholder, merchant, or partner).',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: AML screening results must be scoped to the legal entity being screened for regulatory reporting, jurisdictional compliance obligations, and entity-level risk aggregation required by financial regulat',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: AML screening is performed against a party (cardholder, merchant, or business entity). The party table is the compliance SSOT for all screened entities. Adding party_id normalizes the relationship and',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: AML screening of cross-border transactions must capture the FX rate at screening time for regulatory reporting, suspicious activity pattern analysis, and USD-equivalent threshold calculations required',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: AML screening results are governed by a regulatory obligation; linking enables obligation‑centric reporting.',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: AML screening is performed on account holders during onboarding and ongoing monitoring per FATF/BSA requirements. Compliance operations teams must trace each AML screening result to the specific accou',
    `analyst_override_flag` BOOLEAN COMMENT 'Indicates whether an analyst manually overrode the automated disposition.',
    `analyst_override_reason` STRING COMMENT 'Free‑text explanation provided by the analyst for the override.',
    `compliance_aml_screening_result_status` STRING COMMENT 'Current lifecycle status of the screening result record.. Valid values are `active|inactive|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the screening result record was first created in the data lake.',
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
    CONSTRAINT pk_aml_screening_result PRIMARY KEY(`aml_screening_result_id`)
) COMMENT 'SSOT for Anti-Money Laundering screening outcomes. Records each AML screening event against a transaction, cardholder, or merchant entity — including the screening engine used, risk score assigned, matched typology, disposition (pass/review/block), analyst override, and regulatory obligation reference. Sourced from the Risk and Compliance Management System AML module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` (
    `sanctions_check_id` BIGINT COMMENT 'Unique identifier for each sanctions screening event.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the party (cardholder, merchant, partner, beneficiary) screened.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Sanctions checks are performed by/for specific legal entities; required for OFAC reporting, entity-level compliance status tracking, and regulatory examination responses in payments fintech operations',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Sanctions screening is performed against a party (cardholder, merchant, or counterparty). The party table is the compliance master for all screened entities. Adding party_id to sanctions_check links e',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Sanctions screening must record which payment product was used to support product‑level risk analytics.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with this screening, if applicable.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Sanctions screening requires capturing the FX rate to calculate USD-equivalent amounts for OFAC reporting thresholds. Transactions exceeding USD thresholds trigger mandatory reporting; rate at screeni',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: Sanctions screening is performed against account holders per OFAC/UN requirements. Compliance teams must link each sanctions check result to the cardholder-domain account_holder for blocking decisions',
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
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: A SAR filing is typically triggered by an AML screening result that flagged suspicious activity. Linking sar_filing to the originating compliance_aml_screening_result provides full audit traceability ',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: A SAR filing is submitted as part of a compliance investigation case. Linking sar_filing to compliance_case allows the case record to aggregate all associated SAR filings and provides the investigativ',
    `cross_border_payment_id` BIGINT COMMENT 'Foreign key linking to fx.cross_border_payment. Business justification: SARs frequently involve cross-border payments with FX conversion. Direct link enables compliance officers to reference payment corridors, FX rates, beneficiary details, and SWIFT references in SAR nar',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: SARs must identify the filing legal entity for regulatory submission to FinCEN/FIU, audit trail requirements, and entity-level suspicious activity reporting obligations in payments fintech.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: SAR filings often relate to a specific payment product (e.g., card vs ACH) for product‑level AML reporting.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: FinCEN, FINTRAC, and AUSTRAC require SARs to reference the specific transactions that triggered suspicious activity. sar_filing links to compliance_aml_screening_result and compliance_case but not dir',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: A SAR filing is a specific type of regulatory filing submitted to FinCEN. The regulatory_filing table is the master record of all regulatory submissions. Linking sar_filing to its corresponding regula',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: SAR filings are made about specific account holders per FinCEN/BSA requirements. subject_party_id references compliance.party; a direct FK to account_holder enables compliance officers to pull all SAR',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: The SAR filing subject (subject_entity_name, subject_identifier, subject_address) corresponds to a party in the compliance party master. Adding subject_party_id links the SAR to the authoritative part',
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
    `subject_entity_type` STRING COMMENT 'Classification of the subject entity.. Valid values are `individual|organization|trust|partnership|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SAR record.',
    CONSTRAINT pk_sar_filing PRIMARY KEY(`sar_filing_id`)
) COMMENT 'Suspicious Activity Report filing record — the authoritative record of each SAR submitted to FinCEN or equivalent regulator. Captures the subject entity, suspicious activity type, activity date range, filing date, BSA tracking number, narrative summary, filing officer, and acknowledgement receipt. Supports regulatory examination and audit trail requirements under BSA.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` (
    `compliance_kyc_verification_id` BIGINT COMMENT 'Unique identifier for the KYC verification record.',
    `beneficiary_id` BIGINT COMMENT 'Foreign key linking to fx.beneficiary. Business justification: Cross-border payment beneficiaries require KYC verification under AML/CTF regulations. Payment processors must verify beneficiary identity, sanctions status, and risk tier before authorizing payments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: KYC verifications are performed on behalf of a legal entity for regulatory compliance, licensing requirements, and entity-level customer due diligence obligations in payments fintech operations.',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: KYC verification is performed on a party (cardholder, merchant, or business entity). The party table is the compliance SSOT for all verified entities. Adding party_id to compliance_kyc_verification li',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: KYC verification rules differ by payment product; linking enables product‑specific KYC enforcement.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: KYC verification references the sanctions check performed for the same entity; linking provides audit trail.',
    `participant_id` BIGINT COMMENT 'Foreign key linking to settlement.participant. Business justification: KYC verification records must be linked to the settlement participant (bank) they pertain to for AML compliance reporting.',
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
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Controls govern specific endpoint security configurations (TLS version controls, encryption controls, access controls for network endpoints). Linking control to endpoint enables endpoint-level control',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Posting expenses or adjustments from compliance activities requires a GL account; this FK supports accurate financial statements and audit trails.',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: A compliance control is implemented to satisfy a policy document (AML program policy, PCI DSS information security policy, etc.). Linking control to policy_document establishes the policy-to-control t',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each compliance control implements one or more regulatory obligations; linking provides direct mapping.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Controls are scheme-specific — Visa mandates different controls than Mastercard (e.g., Visas VAMP program, Mastercards MATCH list controls). Linking control to scheme enables scheme-specific control',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: Operational controls (uptime targets, latency thresholds, error rate limits) are enforced and measured via SLA profiles. Links control definition to monitoring/enforcement mechanism for control effect',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Compliance controls are scoped to specific transaction types — AML controls apply to cross-border transactions, SCA controls apply to card-not-present, PCI controls apply to card-present. control.cont',
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
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: A control assessment that identifies a significant finding or exception may trigger a compliance case for investigation and remediation. Linking control_assessment to compliance_case enables traceabil',
    `control_id` BIGINT COMMENT 'Unique identifier of the compliance control being assessed.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: Control assessments test specific integration-level controls (authentication strength, encryption algorithms, rate limiting effectiveness, webhook security). Real control testing workflow requires lin',
    `pci_dss_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.pci_dss_audit. Business justification: Control assessments are frequently conducted as part of a PCI DSS audit cycle. Linking control_assessment to pci_dss_audit allows the audit record to aggregate all control assessments performed during',
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
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: PCI DSS audits are scoped to specific legal entities for compliance certification, regulatory reporting, and entity-level cardholder data environment assessment required by payment card networks.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: PCI DSS audits are performed to satisfy regulatory obligations; linking enables obligation‑centric audit tracking.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: PCI-DSS audits are scoped to specific payment schemes — a Visa audit scope differs from a Mastercard audit scope. Linking pci_dss_audit to scheme enables scheme-specific PCI-DSS compliance tracking an',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`consent_record` (
    `consent_record_id` BIGINT COMMENT 'System-generated unique identifier for each consent record.',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: A consent record violation (e.g., processing data without valid consent, GDPR breach) may trigger a compliance case. Linking consent_record to compliance_case enables traceability from consent events ',
    `device_id` BIGINT COMMENT 'Unique identifier of the device (e.g., mobile device ID) used during consent capture.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Consent requirements are jurisdiction-specific (GDPR in EU, CCPA in California, PDPA in Thailand, etc.). Linking consent_record to jurisdiction_profile establishes which regulatory jurisdiction govern',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Consent records must track which legal entity collected consent for GDPR/privacy law compliance, data controller identification, and regulatory examination responses in payments fintech operations.',
    `party_id` BIGINT COMMENT 'Unique identifier of the data subject (cardholder or merchant) who gave the consent.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Consent collection varies by payment product (BNPL credit checks, card tokenization, P2P data sharing). GDPR/CCPA compliance requires tracking which product triggered consent and for what processing p',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Consent records are collected to meet specific regulatory obligations; linking clarifies which obligation the consent satisfies.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.request. Business justification: GDPR/CCPA consent records must be traceable to the specific API request that collected consent (IP address, timestamp, user agent, collection channel). Required for regulatory audit trails proving law',
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
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_case. Business justification: A regulatory filing (CTR, SAR, STR, PSD2 report) is often submitted as a result of a compliance case investigation. Linking regulatory_filing to compliance_case provides the investigative context for ',
    `examination_request_id` BIGINT COMMENT 'Foreign key linking to compliance.examination_request. Business justification: A regulatory filing may be submitted in direct response to an examination request from a regulator (OCC, CFPB, FCA, ECB). Linking regulatory_filing to examination_request establishes the response trac',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory filings are submitted by specific legal entities; fundamental for regulatory reporting, audit trail, and entity-level compliance status tracking required by financial regulators in payments',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: A regulatory filing is submitted to a governing body within a specific jurisdiction. Linking regulatory_filing to jurisdiction_profile establishes the jurisdictional context for the filing, enabling j',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Currency Transaction Reports (CTRs) and similar regulatory filings are triggered by specific payment transactions exceeding reporting thresholds (e.g., $10,000 USD under BSA). regulatory_filing has no',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filings are made to satisfy specific obligations; linking enables tracking of filing status per obligation.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory filings are made for specific payment schemes (interchange fee reports to EU regulators, scheme compliance certifications, scheme-specific STR filings). Linking regulatory_filing to scheme ',
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
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: A regulatory examination is conducted by a regulator operating within a specific jurisdiction (OCC for US national banks, FCA for UK firms, ECB for EU institutions). Linking examination_request to jur',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Examination requests from regulators target specific legal entities; required for regulatory response coordination, document production, and entity-level examination tracking in payments fintech opera',
    `pci_dss_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.pci_dss_audit. Business justification: A regulatory examination may specifically review PCI DSS compliance, requiring the examiner to access the most recent PCI DSS audit record. Linking examination_request to pci_dss_audit enables direct ',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory examinations are frequently scoped to specific payment schemes (e.g., a regulator examining Visa debit routing compliance or Mastercard interchange practices). Linking examination_request t',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Compliance cases involving partner misconduct need a direct FK to the partner to generate case reports, regulatory filings, and remediation actions.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: A compliance case is governed by the regulatory framework of a specific jurisdiction. Linking compliance_case to jurisdiction_profile establishes the jurisdictional context for the investigation, ensu',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory case reporting (AML, SAR) must capture the legal entity involved for filing with authorities; experts expect a direct link to the entity record.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: Compliance cases investigating merchant behavior (fraud patterns, PCI violations, AML alerts) must reference the specific integration configuration under review to assess authentication methods, compl',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: A compliance case is typically opened when a potential violation of a specific policy is identified. Linking compliance_case to policy_document establishes which policy was allegedly violated, enablin',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the case, if applicable.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Compliance cases are opened for scheme-level incidents (scheme rule violations, certification failures, scheme-mandated dispute investigations). Linking compliance_case to scheme enables scheme-level ',
    `scheme_membership_id` BIGINT COMMENT 'Foreign key linking to network.scheme_membership. Business justification: Compliance cases are opened specifically about scheme membership issues (membership suspension, certification non-compliance, fee disputes). Linking compliance_case to scheme_membership enables case m',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: Compliance cases (AML, sanctions, fraud) are opened against specific account holders. Compliance officers need to retrieve all cases for a given account holder for regulatory reporting and case manage',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Compliance cases trigger account-level actions (suspension, credit limit freeze, account closure). Compliance and operations teams need to link a case directly to the affected cardholder_account to ex',
    `action_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance action was executed.',
    `case_category` STRING COMMENT 'High‑level grouping of the case (e.g., regulatory, operational, conduct).',
    `case_number` STRING COMMENT 'Business identifier assigned to the case for tracking and reference.',
    `case_status` STRING COMMENT 'Current lifecycle status of the case.. Valid values are `open|in_review|escalated|closed|dismissed`',
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
    `severity` STRING COMMENT 'Severity rating reflecting potential impact.. Valid values are `critical|high|medium|low`',
    `source_trigger` STRING COMMENT 'Origin that triggered the creation of the case.. Valid values are `SAR|audit_finding|regulator_inquiry|internal_alert|whistleblower`',
    `subtype` STRING COMMENT 'More granular classification within the main category.',
    `tags` STRING COMMENT 'Comma‑separated list of user‑defined tags for search and categorisation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the case record.',
    CONSTRAINT pk_compliance_case PRIMARY KEY(`compliance_case_id`)
) COMMENT 'Compliance investigation case record — opened when a potential violation, breach, or regulatory concern is identified. Captures case type (AML, sanctions, PCI, GDPR, conduct), case status, assigned compliance officer, source trigger (SAR, audit finding, regulator inquiry, internal alert), investigation timeline, evidence log references, and resolution outcome. Distinct from fraud_case in the fraud domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` (
    `watchlist_entry_id` BIGINT COMMENT 'System-generated unique identifier for each watchlist entry.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: When watchlist entries are for entities (not individuals), they reference legal entities for sanctions compliance, entity screening, and corporate structure sanctions risk assessment in payments finte',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: A watchlist entry may correspond to a known party in the compliance party master (e.g., a cardholder or merchant who appears on OFAC/SDN lists). Linking watchlist_entry to party enables cross-referenc',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`policy_document` (
    `policy_document_id` BIGINT COMMENT 'Unique system-generated identifier for the policy document.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: A compliance policy document is scoped to one or more regulatory jurisdictions (e.g., an EU GDPR policy applies to EU jurisdictions, a BSA/AML policy applies to US jurisdictions). Linking policy_docum',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `account_holder_id` BIGINT COMMENT 'Foreign key linking to cardholder.account_holder. Business justification: compliance.party is the compliance-domain identity entity; cardholder.account_holder is the cardholder-domain identity entity. In payments fintech, an account_holder IS a party for compliance purposes',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Parties that are organizations/businesses should link to legal_entity for corporate structure tracking, regulatory reporting, and entity-level compliance status aggregation in payments fintech operati',
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
    `party_status` STRING COMMENT 'Current lifecycle status of the party record.',
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
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status of the party.',
    `subtype` STRING COMMENT 'More granular classification within the party type, such as corporate, non‑profit, or sovereign.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` (
    `case_party_involvement_id` BIGINT COMMENT 'Unique identifier for this case-party involvement record',
    `compliance_case_id` BIGINT COMMENT 'Foreign key linking to the compliance case being investigated',
    `party_id` BIGINT COMMENT 'Foreign key linking to the party involved in the investigation',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this involvement record was created',
    `interview_date` DATE COMMENT 'Date when this party was interviewed regarding this case (nullable)',
    `involvement_date` DATE COMMENT 'Date when this party was identified as involved in the case',
    `involvement_notes` STRING COMMENT 'Free-form notes about this specific partys involvement in this specific case',
    `involvement_role` STRING COMMENT 'The role this party plays in the compliance case investigation (e.g., primary subject, witness, associated entity, beneficial owner)',
    `involvement_status` STRING COMMENT 'Current status of this partys involvement in the investigation (e.g., identified, under review, interviewed, cleared, implicated)',
    `is_primary_subject` BOOLEAN COMMENT 'Flag indicating whether this party is the primary subject of the compliance investigation',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this involvement record was last updated',
    `risk_contribution_level` STRING COMMENT 'Assessment of how much this party contributed to the compliance risk in this case',
    CONSTRAINT pk_case_party_involvement PRIMARY KEY(`case_party_involvement_id`)
) COMMENT 'This association product represents the investigative involvement relationship between compliance_case and party. It captures which parties are subjects, witnesses, or associated entities in each compliance investigation, along with their role, involvement timeline, and investigative status. Each record links one compliance_case to one party with attributes that exist only in the context of this specific investigation relationship.. Existence Justification: In compliance investigations, a single case routinely involves multiple parties (subject, witnesses, beneficial owners, associated entities), and a single party can be involved in multiple compliance cases over time in different roles. Compliance officers actively manage case party involvement as a distinct investigative concept, tracking each partys role, involvement status, interview dates, and risk contribution for each case. This is an operational M:N relationship that cannot be modeled with a simple FK without losing critical investigative tracking data.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ADD CONSTRAINT `fk_compliance_aml_screening_result_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ADD CONSTRAINT `fk_compliance_sanctions_check_watchlist_entry_id` FOREIGN KEY (`watchlist_entry_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`watchlist_entry`(`watchlist_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_aml_screening_result_id` FOREIGN KEY (`aml_screening_result_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`aml_screening_result`(`aml_screening_result_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ADD CONSTRAINT `fk_compliance_sar_filing_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ADD CONSTRAINT `fk_compliance_compliance_kyc_verification_sanctions_check_id` FOREIGN KEY (`sanctions_check_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`sanctions_check`(`sanctions_check_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ADD CONSTRAINT `fk_compliance_control_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_control_id` FOREIGN KEY (`control_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`control`(`control_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_pci_dss_audit_id` FOREIGN KEY (`pci_dss_audit_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`pci_dss_audit`(`pci_dss_audit_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ADD CONSTRAINT `fk_compliance_control_assessment_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ADD CONSTRAINT `fk_compliance_pci_dss_audit_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ADD CONSTRAINT `fk_compliance_consent_record_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_examination_request_id` FOREIGN KEY (`examination_request_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`examination_request`(`examination_request_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ADD CONSTRAINT `fk_compliance_examination_request_pci_dss_audit_id` FOREIGN KEY (`pci_dss_audit_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`pci_dss_audit`(`pci_dss_audit_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ADD CONSTRAINT `fk_compliance_compliance_case_policy_document_id` FOREIGN KEY (`policy_document_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`policy_document`(`policy_document_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ADD CONSTRAINT `fk_compliance_watchlist_entry_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_jurisdiction_profile_id` FOREIGN KEY (`jurisdiction_profile_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`jurisdiction_profile`(`jurisdiction_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ADD CONSTRAINT `fk_compliance_policy_document_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` ADD CONSTRAINT `fk_compliance_jurisdiction_profile_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ADD CONSTRAINT `fk_compliance_party_parent_party_id` FOREIGN KEY (`parent_party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ADD CONSTRAINT `fk_compliance_case_party_involvement_compliance_case_id` FOREIGN KEY (`compliance_case_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`compliance_case`(`compliance_case_id`);
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ADD CONSTRAINT `fk_compliance_case_party_involvement_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`compliance`.`party`(`party_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `payments_fintech_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance AML Screening Result ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Account Holder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `analyst_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `analyst_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Analyst Override Reason');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `compliance_aml_screening_result_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `compliance_aml_screening_result_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|review|block');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'transaction|cardholder|merchant|partner');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `is_sar_required` SET TAGS ('dbx_business_glossary_term' = 'SAR Required Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `is_str_required` SET TAGS ('dbx_business_glossary_term' = 'STR Required Flag');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `match_type` SET TAGS ('dbx_business_glossary_term' = 'Match Type');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `match_type` SET TAGS ('dbx_value_regex' = 'none|name|address|email|phone|sanctions');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `sar_filing_status` SET TAGS ('dbx_business_glossary_term' = 'SAR Filing Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `sar_filing_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|filed|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `sar_filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SAR Filing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `screening_engine` SET TAGS ('dbx_business_glossary_term' = 'Screening Engine');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `screening_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Screening Rule Version');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `source_module` SET TAGS ('dbx_business_glossary_term' = 'Source Module');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_business_glossary_term' = 'STR Filing Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `str_filing_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|filed|rejected');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `str_filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'STR Filing Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `typology` SET TAGS ('dbx_business_glossary_term' = 'Typology');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`aml_screening_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Related Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sanctions_check` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Account Holder Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Suspicious Activity Report Filing ID (SAR_FILING_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Payment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Account Holder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Party Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Subject Entity Type (SUBJECT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `subject_entity_type` SET TAGS ('dbx_value_regex' = 'individual|organization|trust|partnership|other');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`sar_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `compliance_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_kyc_verification` ALTER COLUMN `participant_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Participant Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Control Assessment Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`control_assessment` ALTER COLUMN `pci_dss_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Pci Dss Audit Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `pci_dss_audit_id` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Audit Identifier (AUDIT_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`pci_dss_audit` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DEVICE_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Identifier (PARTY_ID)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`consent_record` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `examination_request_id` SET TAGS ('dbx_business_glossary_term' = 'Examination Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date (REG_RESPONSE_DUE)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `response_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Received Timestamp (REG_RESPONSE_RECV_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (REG_SOURCE_SYS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp (REG_SUBMIT_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REG_UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `examination_request_id` SET TAGS ('dbx_business_glossary_term' = 'Examination Request Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Compliance Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `pci_dss_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Pci Dss Audit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`examination_request` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_compliance_case');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Related Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `scheme_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Membership Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Account Holder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Number (CCN)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Case Status (CCS)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|in_review|escalated|closed|dismissed');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity Level');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `source_trigger` SET TAGS ('dbx_business_glossary_term' = 'Case Source Trigger (CST)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `source_trigger` SET TAGS ('dbx_value_regex' = 'SAR|audit_finding|regulator_inquiry|internal_alert|whistleblower');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Case Subtype');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Case Tags');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`compliance_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` SET TAGS ('dbx_subdomain' = 'risk_screening');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `watchlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`watchlist_entry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`policy_document` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`jurisdiction_profile` SET TAGS ('dbx_subdomain' = 'regulatory_governance');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `account_holder_id` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `parent_party_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `citizenship_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`party` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` SET TAGS ('dbx_subdomain' = 'compliance_operations');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` SET TAGS ('dbx_association_edges' = 'compliance.compliance_case,compliance.party');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `case_party_involvement_id` SET TAGS ('dbx_business_glossary_term' = 'Case Party Involvement ID');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `compliance_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Party Involvement - Compliance Case Id');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Case Party Involvement - Party Id');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `involvement_date` SET TAGS ('dbx_business_glossary_term' = 'Involvement Date');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `involvement_notes` SET TAGS ('dbx_business_glossary_term' = 'Involvement Notes');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `involvement_notes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `involvement_role` SET TAGS ('dbx_business_glossary_term' = 'Involvement Role');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `involvement_status` SET TAGS ('dbx_business_glossary_term' = 'Involvement Status');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `is_primary_subject` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Subject');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `payments_fintech_ecm`.`compliance`.`case_party_involvement` ALTER COLUMN `risk_contribution_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Contribution Level');
