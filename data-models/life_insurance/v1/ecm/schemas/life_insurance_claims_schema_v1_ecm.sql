-- Schema for Domain: claims | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`claims` COMMENT 'Manages the full claims adjudication and settlement lifecycle for death benefits (DB), disability income (DI), LTC, living benefits, and waiver-of-premium claims. Owns claim intake, FNOL, investigation, fraud detection, beneficiary verification, contestability review, settlement calculations (DB, GMDB, GMIB), payment disbursement, and claim closure. Tracks IBNR reserves and integrates with reinsurance recoverables for ceded claim recovery.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claim` (
    `claim_id` BIGINT COMMENT 'Unique identifier for the claim. Primary key for the claim entity.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Claims arise from annuity contracts for death benefits (GMDB), living benefits (GMWB, LTC riders), and surrender disputes. Essential for claim adjudication, reserve calculation, and benefit determinat',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy or annuity contract against which this claim is filed.',
    `claim_policy_in_force_policy_id` BIGINT COMMENT 'FK to policy.in_force_policy.in_force_policy_id — Every claim must be linked to the policy it is filed against. This is the most fundamental cross-domain join in life insurance — claim adjudication requires policy status, coverage amounts, beneficiar',
    `employee_id` BIGINT COMMENT 'Reference to the claims examiner currently assigned to adjudicate this claim.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Claims adjudication, benefit calculation, reserve establishment, and regulatory reporting require direct access to product plan specifications (benefit structure, riders, tax treatment, contestability',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Variable life/annuity death benefit claims require separate account fund reference to calculate account value component for GMDB floor comparison. Essential for variable product death benefit adjudica',
    `application_id` BIGINT COMMENT 'Foreign key linking to underwriting.application. Business justification: Claims originate from underwriting applications. Contestability reviews, material misrepresentation investigations, and fraud detection require direct access to original application data, disclosed me',
    `amount_approved` DECIMAL(18,2) COMMENT 'Total benefit amount approved for payment after adjudication, including death benefit, guaranteed minimum benefits, or disability income.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount disbursed to the claimant or beneficiary to date.',
    `amount_requested` DECIMAL(18,2) COMMENT 'Total benefit amount requested by the claimant at the time of filing.',
    `attending_physician_statement_received_flag` BOOLEAN COMMENT 'Indicates whether an Attending Physician Statement (APS) has been received as part of the claim documentation.',
    `beneficiary_verification_status` STRING COMMENT 'Status of beneficiary identity verification: pending, verified, failed, or not required.. Valid values are `pending|verified|failed|not_required`',
    `cause_of_loss` STRING COMMENT 'Primary cause of the loss event: natural death, accidental death, suicide, homicide, disability, chronic illness, critical illness, terminal illness, or other. [ENUM-REF-CANDIDATE: natural_death|accidental_death|suicide|homicide|disability|chronic_illness|critical_illness|terminal_illness|other — 9 candidates stripped; promote to reference product]',
    `claim_number` STRING COMMENT 'Externally visible business identifier for the claim, used in correspondence and reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the claim: First Notice of Loss (FNOL), open, under investigation, pending documentation, approved, denied, closed, or withdrawn. [ENUM-REF-CANDIDATE: fnol|open|under_investigation|pending_documentation|approved|denied|closed|withdrawn — 8 candidates stripped; promote to reference product]',
    `claim_type` STRING COMMENT 'Type of claim filed: Death Benefit (DB), Disability Income (DI), Long-Term Care (LTC), Guaranteed Minimum Death Benefit (GMDB), Guaranteed Minimum Income Benefit (GMIB), Guaranteed Minimum Withdrawal Benefit (GMWB), living benefit, or waiver-of-premium. [ENUM-REF-CANDIDATE: death_benefit|disability_income|long_term_care|gmdb|gmib|gmwb|living_benefit|waiver_of_premium — 8 candidates stripped; promote to reference product]',
    `claimant_relationship` STRING COMMENT 'Relationship of the claimant to the insured: insured (for DI/LTC), primary beneficiary, contingent beneficiary, estate, trust, legal representative, or other. [ENUM-REF-CANDIDATE: insured|primary_beneficiary|contingent_beneficiary|estate|trust|legal_representative|other — 7 candidates stripped; promote to reference product]',
    `closure_date` DATE COMMENT 'Date the claim was officially closed in the claims management system.',
    `contestability_period_flag` BOOLEAN COMMENT 'Indicates whether the claim falls within the policy contestability period (typically first two years from issue date), requiring enhanced investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all claim monetary amounts (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `date_of_loss` DATE COMMENT 'Date the insured event occurred (date of death, date of disability onset, date of chronic illness diagnosis, or date of terminal illness diagnosis).',
    `date_reported` DATE COMMENT 'Date the claim was first reported to the insurer (FNOL date).',
    `death_certificate_received_flag` BOOLEAN COMMENT 'Indicates whether an official death certificate has been received for death benefit claims.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the reason for claim denial (e.g., material misrepresentation, suicide exclusion, policy lapse, contestability).. Valid values are `^[A-Z0-9]{2,10}$`',
    `denial_reason_description` STRING COMMENT 'Detailed explanation of the reason for claim denial, provided to the claimant.',
    `disposition` STRING COMMENT 'Final disposition of the claim: approved in full, approved partial, denied due to contestability, denied due to exclusion, denied due to fraud, denied due to lapse, withdrawn by claimant, or settled. [ENUM-REF-CANDIDATE: approved_full|approved_partial|denied_contestability|denied_exclusion|denied_fraud|denied_lapse|withdrawn|settled — 8 candidates stripped; promote to reference product]',
    `examiner_assignment_date` DATE COMMENT 'Date the claim was assigned to the current examiner.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the claim has been flagged for potential fraud investigation.',
    `ibnr_flag` BOOLEAN COMMENT 'Indicates whether this claim is classified as Incurred But Not Reported (IBNR) for reserving purposes.',
    `investigation_completion_date` DATE COMMENT 'Date the claim investigation was completed, if applicable.',
    `investigation_required_flag` BOOLEAN COMMENT 'Indicates whether the claim requires special investigation (e.g., contestability review, fraud investigation, or field investigation).',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether the claim is subject to litigation or legal dispute.',
    `loss_description` STRING COMMENT 'Detailed narrative description of the circumstances surrounding the loss event.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim record was last modified.',
    `net_amount_at_risk` DECIMAL(18,2) COMMENT 'Net Amount at Risk (NAR) at the time of claim: death benefit minus account value or cash surrender value, representing the insurers pure insurance risk.',
    `payment_date` DATE COMMENT 'Date the claim benefit payment was issued or disbursed to the claimant.',
    `payment_method` STRING COMMENT 'Method by which the claim benefit is disbursed: check, Electronic Funds Transfer (EFT), wire transfer, annuitization, retained asset account, or other.. Valid values are `check|eft|wire_transfer|annuitization|retained_asset_account|other`',
    `reopened_date` DATE COMMENT 'Date the claim was reopened, if applicable.',
    `reopened_flag` BOOLEAN COMMENT 'Indicates whether the claim has been reopened after initial closure.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Actuarial reserve established for this claim, including Incurred But Not Reported (IBNR) reserves if applicable.',
    `sla_actual_days` STRING COMMENT 'Actual number of days elapsed from date reported to claim closure or payment.',
    `sla_target_days` STRING COMMENT 'Target number of days for claim adjudication and settlement per internal Service Level Agreement (SLA) or regulatory requirement.',
    CONSTRAINT pk_claim PRIMARY KEY(`claim_id`)
) COMMENT 'Core master record for every life insurance and annuity claim filed against a policy or contract. Captures the full claim lifecycle from FNOL (First Notice of Loss) through adjudication, settlement, and closure. Tracks claim type (DB, DI, LTC, GMDB, GMIB, living benefit, waiver-of-premium), claim status, cause of loss (death, disability, chronic/critical illness, terminal illness), contestability period flag, policy reference, claimant identity, date of loss, date reported, assigned examiner, examiner assignment history, and claim disposition. Supports all claim types for life, annuity, and rider benefits. SSOT for all claim identity, lifecycle state, and examiner assignment within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`fnol` (
    `fnol_id` BIGINT COMMENT 'Unique identifier for the first notice of loss record. Primary key for the FNOL entity.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: First Notice of Loss for annuity-related events (annuitant death, disability trigger, LTC claim initiation) must reference the originating annuity contract for triage, contestability assessment, and b',
    `claim_id` BIGINT COMMENT 'Reference to the claim record created from this FNOL. May be null if claim has not yet been created from the notification.',
    `employee_id` BIGINT COMMENT 'System identifier for the claims adjuster assigned to follow up on this FNOL and create the formal claim record.',
    `fnol_employee_id` BIGINT COMMENT 'System identifier of the claims intake specialist or automated system that processed the FNOL submission.',
    `in_force_policy_id` BIGINT COMMENT 'System identifier for the validated policy record associated with this FNOL after policy lookup and verification.',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: First Notice of Loss captures insured identity for fraud screening, DMF matching, and claim triage. Links FNOL to party master for identity verification and duplicate claim detection. Removes denormal',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: FNOL triage and routing decisions depend on product type, contestability period, and benefit structure. Determines investigation requirements, SLA targets, and adjudication workflow based on product c',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: FNOL intake involves PHI/PII collection; data breaches during FNOL processing trigger privacy incident reporting under HIPAA and state breach notification laws. Insurance operations must track which F',
    `producer_id` BIGINT COMMENT 'System identifier for the agent or broker who submitted the FNOL on behalf of the claimant, if applicable.',
    `agent_code` STRING COMMENT 'Business identifier code for the agent or broker who submitted the FNOL, if the notification came through agent channel.',
    `beneficiary_name` STRING COMMENT 'Name of the primary beneficiary claiming the benefit, as provided at time of FNOL. Subject to verification during claims adjudication.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of the beneficiary to the insured, such as spouse, child, parent, trust, estate, or other designation.',
    `claim_created_date` DATE COMMENT 'Date when the formal claim record was created from this FNOL. Null if claim has not yet been created.',
    `contestability_flag` BOOLEAN COMMENT 'Boolean indicator that the policy is within the contestability period at time of loss, requiring enhanced investigation and underwriting review. True indicates contestable.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this FNOL record was first created in the claims management system. Used for audit trail and data lineage.',
    `fnol_status` STRING COMMENT 'Current processing status of the FNOL record in the intake workflow. Tracks progression from initial receipt through claim creation or closure.. Valid values are `received|pending_validation|validated|claim_created|nigo|closed`',
    `fraud_indicator` BOOLEAN COMMENT 'Boolean flag indicating that the FNOL has been flagged for potential fraud based on initial screening rules or manual review. True indicates fraud suspected.',
    `fraud_reason` STRING COMMENT 'Description of the reason the FNOL was flagged for potential fraud, such as inconsistent information, suspicious timing, or pattern matching.',
    `loss_date` DATE COMMENT 'Date when the loss event occurred as reported by the claimant. For death claims, this is the date of death. For disability, the date disability began.',
    `loss_description` STRING COMMENT 'Free-text narrative description of the loss event as provided by the reporter at time of initial notification. May be incomplete or preliminary.',
    `loss_event_type` STRING COMMENT 'High-level classification of the type of loss event being reported. Drives initial triage and routing to appropriate claims adjudication team. [ENUM-REF-CANDIDATE: death|disability|critical_illness|ltc_benefit|waiver_of_premium|living_benefit|other — 7 candidates stripped; promote to reference product]',
    `loss_location` STRING COMMENT 'Geographic location where the loss event occurred, if applicable and provided by the reporter.',
    `nigo_flag` BOOLEAN COMMENT 'Boolean indicator that the FNOL submission is incomplete or missing required information to proceed with claim creation. True indicates NIGO status.',
    `nigo_reason` STRING COMMENT 'Description of the missing or incomplete information that caused the FNOL to be flagged as Not In Good Order. Used to guide follow-up with reporter.',
    `notes` STRING COMMENT 'Additional free-text notes or comments captured during FNOL intake, including follow-up actions, special instructions, or clarifications.',
    `notification_channel` STRING COMMENT 'Channel through which the first notice of loss was submitted to the insurer. [ENUM-REF-CANDIDATE: phone|web_portal|mobile_app|agent|email|mail|fax|in_person — 8 candidates stripped; promote to reference product]',
    `notification_date` DATE COMMENT 'Calendar date when the first notice of loss was received by the insurer. Starts the claim reporting SLA clock.',
    `notification_timestamp` TIMESTAMP COMMENT 'Precise date and time when the first notice of loss was received by the insurer, including time zone. Used for SLA tracking and audit trail.',
    `policy_number` STRING COMMENT 'Policy number provided by the reporter at time of notification. May be incomplete or incorrect in initial submission.',
    `reporter_email` STRING COMMENT 'Email address of the individual who submitted the first notice of loss, used for follow-up communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `reporter_name` STRING COMMENT 'Full name of the individual or entity who submitted the first notice of loss.',
    `reporter_phone` STRING COMMENT 'Primary contact phone number for the individual who reported the loss event.',
    `reporter_relationship` STRING COMMENT 'Description of the reporters relationship to the insured or policyholder, such as spouse, child, parent, business partner, or legal representative.',
    `reporter_type` STRING COMMENT 'Classification of the individual or entity reporting the loss event. Identifies the relationship of the reporter to the insured or policy. [ENUM-REF-CANDIDATE: beneficiary|insured|agent|broker|attorney|family_member|executor|trustee|third_party_administrator|other — 10 candidates stripped; promote to reference product]',
    `sla_target_date` DATE COMMENT 'Target date by which the FNOL must be processed and claim created to meet regulatory and internal service level agreements.',
    `source_reference_number` STRING COMMENT 'External reference number or tracking ID from the source system that captured the FNOL, used for cross-system reconciliation.',
    `source_system` STRING COMMENT 'Name of the source system or application that captured the FNOL submission, such as claims management system, web portal, or IVR system.',
    `triage_classification` STRING COMMENT 'Initial classification assigned during FNOL intake to route the claim to the appropriate adjudication team and priority queue.. Valid values are `standard|expedited|complex|fraud_suspected|contestable|non_contestable`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this FNOL record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_fnol PRIMARY KEY(`fnol_id`)
) COMMENT 'First Notice of Loss record capturing the initial intake event when a claimant, beneficiary, agent, or third party first reports a loss event to the insurer. Records the notification channel (phone, web portal, agent, mail, email), date and time of notification, reporter identity and relationship to insured, preliminary loss description, policy number provided, NIGO (Not In Good Order) flags for incomplete submissions, and initial triage classification. Drives the claim creation workflow and SLA clock start. SSOT for all initial loss notification events within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claimant` (
    `claimant_id` BIGINT COMMENT 'Unique identifier for the claimant record. Primary key for the claimant entity.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Claimant identity verification includes AML/KYC screening and OFAC sanctions checks. Suspicious claimants trigger AML cases for investigation and potential SAR filing, required by BSA/AML regulations ',
    `claim_id` BIGINT COMMENT 'Reference to the claim this claimant is associated with. Links to the parent claim record.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy or annuity contract against which the claim is being made.',
    `party_id` BIGINT COMMENT 'FK to policyholder.party.party_id — Claimant identity resolution requires joining to the policyholder party master. Without this FK, claims adjusters cannot resolve claimant demographics, contact information, or KYC status — a productio',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Claimant verification and benefit eligibility determination require product plan specifications for beneficiary designation rules, payment options, settlement methods, and tax withholding requirements',
    `address_line_1` STRING COMMENT 'Primary street address line for the claimant. Used for mailing claim documents, checks, and correspondence.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Optional field.',
    `alternate_phone_number` STRING COMMENT 'Secondary contact phone number for the claimant. Used when primary contact is unavailable.',
    `aml_screening_date` DATE COMMENT 'Date when AML screening was last performed for the claimant. Used for compliance audit trails and periodic re-screening.',
    `aml_screening_status` STRING COMMENT 'Status of AML screening for the claimant. Indicates whether the claimant has been screened against OFAC, sanctions lists, and PEP databases. Required before claim payment.. Valid values are `not_screened|clear|flagged|under_review|escalated`',
    `bank_account_number` STRING COMMENT 'Bank account number for electronic payment disbursement. Required when payment_method is EFT or wire_transfer. Encrypted at rest.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the claimants account is held. Used for payment verification and audit trails.',
    `bank_routing_number` STRING COMMENT 'Bank routing number (ABA number) for electronic payment disbursement. Required when payment_method is EFT or wire_transfer.',
    `benefit_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total claim benefit allocated to this claimant. Used for split-benefit scenarios where multiple claimants share the death benefit or other proceeds. Must sum to 100% across all claimants for a given claim.',
    `city` STRING COMMENT 'City name for the claimants mailing address.',
    `claim_submission_date` DATE COMMENT 'Date when the claimant submitted their claim. Used for tracking claim processing timelines, SLA compliance, and contestability period calculations.',
    `claimant_status` STRING COMMENT 'Current lifecycle status of the claimant record in the claims adjudication process. Tracks progression from initial submission through verification, investigation, approval, and payment.. Valid values are `pending_verification|verified|rejected|under_investigation|approved|paid`',
    `claimant_type` STRING COMMENT 'Classification of the claimant role in relation to the policy. Indicates whether the claimant is a primary beneficiary, contingent beneficiary, the insured themselves (for DI/LTC/living benefit claims), an estate, a trust (ILIT), or a guardian acting on behalf of a minor.. Valid values are `primary_beneficiary|contingent_beneficiary|insured|estate|trust|guardian`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the claimants address. Used for international claims and compliance with cross-border regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claimant record was first created in the system. Used for audit trails and data lineage tracking.',
    `date_of_birth` DATE COMMENT 'Date of birth of the individual claimant. Used for identity verification, age validation, and compliance with contestability period rules.',
    `email_address` STRING COMMENT 'Primary email address for claimant communication, claim status updates, and document delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `entity_name` STRING COMMENT 'Full legal name of the claimant when the claimant is a non-individual entity such as an estate, trust (ILIT), or organization. Used when claimant_type is estate or trust.',
    `first_name` STRING COMMENT 'Legal first name of the individual claimant. For entity claimants (estate, trust), this field may be null.',
    `guardian_name` STRING COMMENT 'Full legal name of the guardian when the claimant is a minor or lacks legal capacity. Required when legal_capacity is minor_with_guardian or conservator.',
    `guardian_relationship` STRING COMMENT 'Relationship of the guardian to the claimant (e.g., parent, legal guardian, court-appointed conservator).',
    `identity_document_expiration_date` DATE COMMENT 'Expiration date of the identity document. Used to validate document currency during KYC verification.',
    `identity_document_issuing_authority` STRING COMMENT 'Government authority or agency that issued the identity document (e.g., state DMV, US Department of State for passports).',
    `identity_document_number` STRING COMMENT 'Document number from the government-issued identity document. Used for identity verification and fraud detection.',
    `identity_document_type` STRING COMMENT 'Type of government-issued identity document provided by the claimant for verification. Used for KYC compliance and fraud prevention.. Valid values are `drivers_license|passport|state_id|military_id|other`',
    `kyc_verification_date` DATE COMMENT 'Date when KYC verification was successfully completed for the claimant. Used for compliance audit trails and periodic re-verification scheduling.',
    `kyc_verification_status` STRING COMMENT 'Status of the KYC verification process for the claimant. Tracks identity verification, document validation, and AML screening completion. Required before claim payment can be processed.. Valid values are `not_started|in_progress|verified|failed|expired`',
    `last_name` STRING COMMENT 'Legal last name or surname of the individual claimant. For entity claimants (estate, trust), this field may be null.',
    `legal_capacity` STRING COMMENT 'Legal standing of the claimant to receive claim proceeds. Indicates whether the claimant is an individual with full capacity, a minor requiring a guardian, an estate executor, a trustee (ILIT), or someone acting under power of attorney.. Valid values are `individual|minor_with_guardian|estate_executor|trustee|power_of_attorney|conservator`',
    `middle_name` STRING COMMENT 'Middle name or initial of the individual claimant. Optional field.',
    `payment_method` STRING COMMENT 'Method by which claim proceeds will be disbursed to the claimant. Options include physical check, electronic funds transfer (EFT), wire transfer, or conversion to an annuity payout structure.. Valid values are `check|eft|wire_transfer|annuity_payout`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the claimant. Used for claim investigation, verification calls, and status updates.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the claimants address. Used for mail delivery and geographic analysis.',
    `relationship_to_insured` STRING COMMENT 'Describes the claimants relationship to the insured individual. Critical for beneficiary verification and contestability review. Self indicates the insured is the claimant (DI, LTC, living benefit claims). [ENUM-REF-CANDIDATE: self|spouse|child|parent|sibling|other_relative|estate|trust|unrelated — 9 candidates stripped; promote to reference product]',
    `ssn` STRING COMMENT 'Social Security Number of the individual claimant. Used for identity verification, tax reporting (1099-R), and KYC compliance. Required for individual claimants.',
    `state_province` STRING COMMENT 'State or province code for the claimants address. Two-letter abbreviation for US states.',
    `tin` STRING COMMENT 'Taxpayer Identification Number for entity claimants (estates, trusts, organizations). Used for tax reporting and compliance when SSN is not applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the claimant record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    CONSTRAINT pk_claimant PRIMARY KEY(`claimant_id`)
) COMMENT 'Master record for every individual or entity asserting a claim against a life insurance policy or annuity contract. Distinct from the policyholder domains insured record — a claimant is the party making the claim demand, which may be a beneficiary, the insured themselves (DI/LTC/living benefit), an estate, or a trust (ILIT). Captures claimant name, SSN/TIN, relationship to insured, contact information, KYC/AML verification status, identity document references, and legal capacity (individual, estate, trust, minor with guardian). Supports multiple claimants per claim for split-benefit scenarios.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` (
    `beneficiary_verification_id` BIGINT COMMENT 'Unique identifier for the beneficiary verification record. Primary key for tracking each formal verification process for claimants asserting entitlement to claim proceeds.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Beneficiary verification includes OFAC/AML screening (already tracked in beneficiary_verification attributes). When adverse findings occur, an AML case is opened for investigation and potential SAR fi',
    `beneficiary_designation_id` BIGINT COMMENT 'Reference to the beneficiary designation record from the policyholder domain that establishes the claimants entitlement. Used to validate the claimant against the policys beneficiary of record.',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim for which this beneficiary verification is being conducted. Links to the claim record in the claims domain.',
    `claimant_id` BIGINT COMMENT 'Reference to the claimant record representing the individual or entity asserting entitlement to claim proceeds. Links to claimant master data in the claims domain.',
    `employee_id` BIGINT COMMENT 'Reference to the claims examiner or verification specialist responsible for conducting and completing the beneficiary verification process.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy under which the claim is being filed. Used to validate beneficiary designation on file.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Verification procedures vary by product type (term vs. permanent, qualified vs. non-qualified). Product plan defines beneficiary designation rules, trust provisions, and minor beneficiary handling req',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Identity and KYC verification often uses third-party services (LexisNexis, Experian, IDology) for beneficiary validation. Vendor tracking supports regulatory compliance (AML/KYC audit trails), invoice',
    `adverse_findings_description` STRING COMMENT 'Detailed description of any adverse findings discovered during the verification process. Includes nature of the issue, supporting evidence, and recommended actions.',
    `adverse_findings_flag` BOOLEAN COMMENT 'Indicates whether any adverse findings were discovered during the verification process that require escalation. Examples include sanctions list matches, fraud indicators, contested beneficiary claims, or documentation discrepancies.',
    `aml_screening_date` DATE COMMENT 'The date on which the AML screening was performed for this beneficiary verification.',
    `aml_screening_status` STRING COMMENT 'Status of the AML screening process to detect potential money laundering or terrorist financing risks. Required before claim disbursement authorization.. Valid values are `cleared|flagged|pending|not_required`',
    `competing_claimants_count` STRING COMMENT 'The number of competing claimants asserting entitlement to the claim proceeds when the beneficiary designation is contested. Used to track the complexity of contested claim scenarios.',
    `contested_claim_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary designation is contested by multiple claimants asserting competing entitlement to the claim proceeds. Triggers special handling and potential interpleader action.',
    `court_order_reference` STRING COMMENT 'Reference number or description of any court order related to the beneficiary verification or contested claim. Used to track legal directives governing claim disbursement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this beneficiary verification record was first created in the system. Audit trail field for data lineage and compliance.',
    `disbursement_authorization_date` DATE COMMENT 'The date on which claim disbursement was authorized following successful completion of all beneficiary verification requirements. Null if disbursement has not yet been authorized.',
    `disbursement_authorized_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary verification process has been successfully completed and claim disbursement has been authorized. Set to true only after all required verifications (identity, KYC, AML, OFAC, legal standing) are cleared.',
    `documents_outstanding` STRING COMMENT 'Comma-separated list or description of documents still outstanding and required to complete the verification process. Represents the gap between documents requested and documents received.',
    `documents_received` STRING COMMENT 'Comma-separated list or description of documents received from the claimant in support of the verification process. Tracks which requested documents have been submitted.',
    `documents_requested` STRING COMMENT 'Comma-separated list or description of documents requested from the claimant to support the verification process. May include death certificate, government ID, probate documents, trust documents, guardianship papers, etc.',
    `estate_beneficiary_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary is the insureds estate. Triggers probate validation requirements and verification of executor or administrator authority.',
    `guardian_verified_flag` BOOLEAN COMMENT 'Indicates whether the legal guardian or custodian for a minor beneficiary has been verified. Required before disbursement to a minors guardian.',
    `identity_verification_method` STRING COMMENT 'The method used to verify the claimants identity: government-issued ID, passport, drivers license, birth certificate, SSN (Social Security Number) verification, biometric verification, notarized affidavit, or other approved method. [ENUM-REF-CANDIDATE: government_id|passport|drivers_license|birth_certificate|ssn_verification|biometric|notarized_affidavit|other — 8 candidates stripped; promote to reference product]',
    `identity_verification_outcome` STRING COMMENT 'The result of the identity verification process: verified (identity confirmed), failed (identity could not be confirmed), pending (verification in progress), or not applicable (identity verification not required for this verification type).. Valid values are `verified|failed|pending|not_applicable`',
    `insurable_interest_verified` BOOLEAN COMMENT 'Indicates whether the claimants insurable interest in the insured has been verified. Required for certain policy types and jurisdictions to prevent STOLI (Stranger-Originated Life Insurance) and fraud.',
    `interpleader_filed_flag` BOOLEAN COMMENT 'Indicates whether an interpleader action has been filed with the court to resolve a contested beneficiary designation. Interpleader allows the insurer to deposit claim proceeds with the court and let competing claimants litigate entitlement.',
    `interpleader_filing_date` DATE COMMENT 'The date on which the interpleader action was filed with the court. Null if no interpleader has been filed.',
    `kyc_verification_status` STRING COMMENT 'Status of the KYC verification process to confirm the claimants identity and legitimacy. Required for AML (Anti-Money Laundering) and BSA (Bank Secrecy Act) compliance before disbursement.. Valid values are `passed|failed|pending|not_required`',
    `legal_standing_verified` BOOLEAN COMMENT 'Indicates whether the claimants legal standing to receive claim proceeds has been verified. Includes validation of executor/administrator status for estate claims, trustee authority for trust claims, or guardian status for minor beneficiaries.',
    `mib_check_date` DATE COMMENT 'The date on which the MIB check was performed for this beneficiary verification.',
    `mib_check_status` STRING COMMENT 'Status of the MIB check to verify medical and identity information. Used to detect potential fraud or misrepresentation during the verification process.. Valid values are `completed|pending|not_required|match_found|no_match`',
    `minor_beneficiary_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary is a minor (under age of majority in the jurisdiction). Triggers additional verification requirements for guardian or custodian documentation.',
    `ofac_sanctions_check_date` DATE COMMENT 'The date on which the OFAC sanctions screening was performed for this beneficiary verification.',
    `ofac_sanctions_check_status` STRING COMMENT 'Status of the OFAC sanctions screening to ensure the claimant is not on any sanctions lists. Match found indicates a potential sanctions list hit requiring escalation. Required before disbursement authorization.. Valid values are `cleared|match_found|pending|not_required`',
    `probate_validated_flag` BOOLEAN COMMENT 'Indicates whether probate documentation has been validated for an estate beneficiary claim. Includes verification of letters testamentary or letters of administration.',
    `trust_beneficiary_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary is a trust or ILIT (Irrevocable Life Insurance Trust). Triggers trust document validation and trustee authority verification.',
    `trust_validated_flag` BOOLEAN COMMENT 'Indicates whether the trust documentation and trustee authority have been validated for a trust beneficiary claim. Includes verification of trust agreement and trustee appointment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this beneficiary verification record was last updated. Audit trail field for tracking changes and data lineage.',
    `verification_completed_date` DATE COMMENT 'The date on which the beneficiary verification process was completed, either successfully verified or failed. Null if verification is still in progress.',
    `verification_initiated_date` DATE COMMENT 'The date on which the beneficiary verification process was formally initiated following claim intake or FNOL (First Notice of Loss).',
    `verification_notes` STRING COMMENT 'Free-text notes and comments from the verification examiner documenting the verification process, findings, decisions, and any special circumstances or considerations.',
    `verification_status` STRING COMMENT 'Current status of the beneficiary verification process. Tracks progression from initiation through completion or escalation. [ENUM-REF-CANDIDATE: pending|in_progress|documents_requested|documents_received|under_review|verified|failed|escalated|contested — 9 candidates stripped; promote to reference product]',
    `verification_type` STRING COMMENT 'The category of verification being performed: identity verification, insurable interest validation, legal standing confirmation, minor guardianship documentation, estate probate validation, or trust/ILIT (Irrevocable Life Insurance Trust) validation.. Valid values are `identity|insurable_interest|legal_standing|minor_guardianship|estate_probate|trust_validation`',
    CONSTRAINT pk_beneficiary_verification PRIMARY KEY(`beneficiary_verification_id`)
) COMMENT 'Operational record tracking the formal verification process for each beneficiary or claimant asserting entitlement to claim proceeds. Links to the claimant record (claims domain) and references the beneficiary designation from the policyholder domain to validate entitlement. Captures verification type (identity, insurable interest, legal standing, minor guardianship, estate probate, trust/ILIT validation), verification status, documents requested and received, MIB check results, AML/BSA screening outcome, OFAC sanctions check status, KYC verification results, verification examiner, verification date, and any adverse findings requiring escalation. For contested beneficiary designations: tracks competing claims, interpleader filing status, and court order references. Ensures compliance with state DOI requirements, AML/BSA obligations, and OFAC sanctions screening before disbursement authorization. SSOT for all claimant/beneficiary verification activity within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claim_investigation` (
    `claim_investigation_id` BIGINT COMMENT 'Unique identifier for the claim investigation record. Primary key.',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim being investigated.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Fraud investigations may escalate to AML cases when suspicious activity involves money laundering, STOLI, or financial crimes. BSA/AML regulations require tracking this escalation path for SAR filing ',
    `contestability_review_id` BIGINT COMMENT 'Foreign key linking to claims.contestability_review. Business justification: When investigation is triggered by contestability concerns (claim filed within 2-year period), it should reference the formal contestability_review record. The contestability_flag and contestability_f',
    `issue_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_issue. Business justification: Claim investigations may uncover systemic compliance issues (pattern of improper denials, inadequate documentation, process failures). Risk management requires linking investigations to compliance iss',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Fraud investigations require producer interview, file review, and pattern analysis for STOLI detection and misrepresentation cases. SIU business process links investigations to selling producer for re',
    `siu_referral_id` BIGINT COMMENT 'Foreign key linking to claims.siu_referral. Business justification: When a claim investigation escalates to SIU, the investigation should reference the SIU referral record. Business pattern: investigation identifies fraud indicators → creates SIU referral → investigat',
    `application_id` BIGINT COMMENT 'Foreign key linking to underwriting.application. Business justification: Fraud investigations and SIU referrals require direct comparison of claim circumstances against original application disclosures, medical exam results, APS records, MIB findings, and financial underwr',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Claims investigations frequently engage external vendors for field investigations, surveillance, medical record retrieval, and fraud detection services. Tracking vendor relationship enables invoice re',
    `aps_received_date` DATE COMMENT 'Date the Attending Physician Statement was received from the medical provider.',
    `aps_requested_flag` BOOLEAN COMMENT 'Indicates whether an Attending Physician Statement was requested as part of the investigation to verify medical history or cause of death.',
    `benefit_reduction_amount` DECIMAL(18,2) COMMENT 'Recommended reduction in claim benefit amount based on investigation findings (e.g., premium adjustment for undisclosed risk factors).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was first created in the system.',
    `escalation_level` STRING COMMENT 'Severity and escalation tier: standard investigation, Special Investigations Unit (SIU) referral, law enforcement referral, or state Department of Insurance (DOI) fraud bureau filing per NAIC Insurance Fraud Prevention Model Act.. Valid values are `standard|siu_referral|law_enforcement|state_doi_fraud_bureau`',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Estimated financial loss to the insurer if fraud or misrepresentation is substantiated, used for prioritization and reserve adjustments.',
    `external_vendor_used_flag` BOOLEAN COMMENT 'Indicates whether external investigation vendors or third-party investigators were engaged for this case.',
    `field_investigation_performed_flag` BOOLEAN COMMENT 'Indicates whether a field investigation (on-site visit, witness interviews, scene inspection) was conducted as part of the investigation.',
    `findings_summary` STRING COMMENT 'Comprehensive narrative summary of investigation findings, evidence collected, interviews conducted, and rationale for disposition.',
    `fraud_indicator_score` DECIMAL(18,2) COMMENT 'Quantitative fraud risk score (0.00 to 100.00) calculated from fraud detection rules engine, used to prioritize SIU referrals.',
    `investigation_close_date` DATE COMMENT 'Date the investigation was formally closed and disposition recorded.',
    `investigation_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the investigation including investigator time, external vendor fees, APS costs, and legal expenses.',
    `investigation_disposition` STRING COMMENT 'Final outcome of the investigation: substantiated (fraud/misrepresentation confirmed), unsubstantiated (no evidence found), closed without action, rescind policy (cancel coverage retroactively), pay claim in full, or reduce benefit amount.. Valid values are `substantiated|unsubstantiated|closed_without_action|rescind_policy|pay_in_full|reduce_benefit`',
    `investigation_number` STRING COMMENT 'Business-facing unique investigation case number assigned at investigation initiation.. Valid values are `^INV-[0-9]{8,12}$`',
    `investigation_open_date` DATE COMMENT 'Date the investigation was formally opened and assigned.',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the investigation based on fraud score, claim amount, and regulatory risk.. Valid values are `low|medium|high|critical`',
    `investigation_reason` STRING COMMENT 'Detailed narrative explaining why the investigation was initiated, including specific fraud triggers, contestability concerns, or cause-of-death questions.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation workflow.. Valid values are `open|in_progress|pending_info|closed`',
    `investigation_type` STRING COMMENT 'Category of investigation: contestability (within 2-year window), fraud/SIU referral, cause-of-death investigation, Attending Physician Statement (APS) review, Medical Information Bureau (MIB) record review, or Stranger-Originated Life Insurance (STOLI) investigation.. Valid values are `contestability|fraud_siu|cause_of_death|aps_review|mib_review|stoli`',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the case was referred (e.g., FBI, state police, local district attorney).',
    `law_enforcement_referral_date` DATE COMMENT 'Date the investigation was formally referred to law enforcement.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the investigation was referred to law enforcement agencies for potential criminal prosecution.',
    `mib_check_date` DATE COMMENT 'Date the Medical Information Bureau database query was executed.',
    `mib_check_performed_flag` BOOLEAN COMMENT 'Indicates whether a Medical Information Bureau database check was performed to identify undisclosed medical conditions or prior insurance applications.',
    `nicb_check_performed_flag` BOOLEAN COMMENT 'Indicates whether a National Insurance Crime Bureau database check was performed to identify prior fraud indicators or suspicious activity patterns.',
    `policy_rescission_recommended_flag` BOOLEAN COMMENT 'Indicates whether the investigation findings support a recommendation to rescind (retroactively cancel) the policy due to material misrepresentation during application.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this investigation must be reported to regulatory authorities (state DOI, NAIC, FinCEN) based on fraud substantiation or statutory thresholds.',
    `state_doi_filing_date` DATE COMMENT 'Date the fraud investigation was filed with the state Department of Insurance fraud bureau.',
    `state_doi_filing_flag` BOOLEAN COMMENT 'Indicates whether the investigation was reported to the state Department of Insurance fraud bureau as required by NAIC Insurance Fraud Prevention Model Act.',
    `stoli_indicator_flag` BOOLEAN COMMENT 'Indicates whether the investigation identified indicators of Stranger-Originated Life Insurance (STOLI) schemes where investors initiate policies on strangers for speculative purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was last modified.',
    CONSTRAINT pk_claim_investigation PRIMARY KEY(`claim_investigation_id`)
) COMMENT 'Tracks all formal investigation workflows for claims requiring scrutiny beyond standard adjudication, including Special Investigations Unit (SIU) referrals, contestability reviews, and field investigations. CONTESTABILITY: covers claims within the 2-year contestability window — application misrepresentation findings, medical history discrepancies, MIB report findings, and rescission recommendations. FRAUD/SIU: covers fraud referral triggers, SIU case numbers, fraud indicator scoring, law enforcement referrals, state DOI fraud bureau filings (per NAIC Insurance Fraud Prevention Model Act), and NICB database checks. GENERAL INVESTIGATION: covers cause-of-death investigations, APS requests, MIB record reviews, STOLI/stranger-originated life insurance investigations, and field investigations. Records investigation type, escalation level (standard, SIU referral, law enforcement), assigned investigator, investigation open/close dates, findings summary, investigation disposition (substantiated, unsubstantiated, closed without action, rescind policy, pay in full, reduce benefit), and regulatory reporting obligations. SSOT for all claim investigation, fraud referral, and contestability review activity within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`adjudication` (
    `adjudication_id` BIGINT COMMENT 'Unique identifier for the claim adjudication decision record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the claims examiner who rendered the adjudication decision.',
    `adjudication_supervisor_employee_id` BIGINT COMMENT 'Reference to the supervisor who reviewed and approved the adjudication decision when supervisor review was required.',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim being adjudicated.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Adjudication decisions must comply with policies on prompt payment, fair claims handling, and benefit determination standards. Insurance operations link adjudications to compliance policies for audit ',
    `contestability_review_id` BIGINT COMMENT 'Foreign key linking to claims.contestability_review. Business justification: When adjudicating a claim that underwent contestability review, the adjudication should reference the contestability_review record. The review findings (material misrepresentation found, rescission re',
    `db_calculation_id` BIGINT COMMENT 'Foreign key linking to claims.db_calculation. Business justification: For death benefit claims, adjudication should reference the specific DB calculation that determined the benefit_amount_approved. The db_calculation product performs the actuarial computation (base fac',
    `living_benefit_claim_id` BIGINT COMMENT 'Foreign key linking to claims.living_benefit_claim. Business justification: For living benefit claims (DI, LTC, waiver of premium), adjudication should reference the living_benefit_claim detail record that contains the benefit calculation basis, elimination period, monthly be',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Adjudication decisions require product plan specifications for benefit calculations, policy provisions cited, settlement options, tax treatment, and authority level determination. Core to claims decis',
    `adjudication_date` DATE COMMENT 'Date on which the formal adjudication decision was rendered. Used for state prompt payment law compliance tracking.',
    `adjudication_number` STRING COMMENT 'Business-facing unique identifier for the adjudication decision, used in correspondence and external reporting.',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Precise date and time when the adjudication decision was finalized in the claims system.',
    `adverse_action_notice_flag` BOOLEAN COMMENT 'Indicates whether an adverse action notice was issued to the claimant in compliance with state insurance regulations for denied or partially approved claims.',
    `appeal_rights_disclosed` BOOLEAN COMMENT 'Indicates whether claimant appeal rights and procedures were disclosed in the denial or adverse action notice, as required by state regulations.',
    `authority_level` STRING COMMENT 'The organizational authority level applied to approve this adjudication decision, based on claim amount and complexity thresholds.. Valid values are `examiner|senior_examiner|supervisor|manager|director|special_authority`',
    `beneficiary_signature_confirmed` BOOLEAN COMMENT 'Indicates whether beneficiary signature on settlement election forms has been verified and confirmed at adjudication time.',
    `benefit_amount_approved` DECIMAL(18,2) COMMENT 'Total monetary benefit amount approved for payment as a result of the adjudication decision. For approved and partially approved outcomes, represents the Death Benefit (DB), Guaranteed Minimum Death Benefit (GMDB), Guaranteed Minimum Income Benefit (GMIB), disability income, or other benefit amount authorized. Null for denied outcomes.',
    `benefit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved benefit amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `contestability_review_flag` BOOLEAN COMMENT 'Indicates whether the claim was subject to contestability period review for potential material misrepresentation or fraud during the policy application process.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this adjudication record was first created in the claims management system.',
    `decision_basis` STRING COMMENT 'Detailed narrative explanation of the rationale and policy provisions applied to reach the adjudication decision. Includes citation of specific policy clauses, exclusions, riders, and underwriting conditions.',
    `denial_letter_date` DATE COMMENT 'Date on which the formal denial letter was generated and sent to the claimant. Used for adverse action notice compliance tracking.',
    `denial_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for claim denial, aligned with NAIC and state Department of Insurance (DOI) reporting standards. Examples include suicide exclusion, contestability period misrepresentation, policy lapse, exclusion rider, material misrepresentation, fraud, lack of insurable interest.',
    `denial_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for claim denial, including specific facts, policy provisions, and legal basis. Used in denial letters and adverse action notices.',
    `doi_complaint_flag` BOOLEAN COMMENT 'Indicates whether a complaint related to this adjudication decision has been filed with the state Department of Insurance (DOI).',
    `external_review_referral_flag` BOOLEAN COMMENT 'Indicates whether the claim was referred for external independent review as part of the appeals process or regulatory requirement.',
    `federal_withholding_percentage` DECIMAL(18,2) COMMENT 'Percentage of benefit payment to be withheld for federal income tax, as elected by beneficiary at adjudication time.',
    `fraud_investigation_flag` BOOLEAN COMMENT 'Indicates whether the claim was flagged for or underwent fraud investigation as part of the adjudication process.',
    `internal_review_completion_date` DATE COMMENT 'Date on which internal quality assurance or compliance review of the adjudication decision was completed.',
    `litigation_hold_flag` BOOLEAN COMMENT 'Indicates whether a litigation hold has been placed on this adjudication record due to pending or anticipated legal action by the claimant.',
    `notes` STRING COMMENT 'Free-form notes and comments recorded by the claims examiner during the adjudication process, including rationale for decision, special considerations, and internal documentation.',
    `outcome` STRING COMMENT 'Final decision outcome of the claim adjudication process. Approved indicates full benefit payment authorized; denied indicates no payment; partially approved indicates reduced benefit; pended indicates additional information required; rescinded indicates reversal of prior approval; reopened indicates reconsideration of closed claim.. Valid values are `approved|denied|partially_approved|pended|rescinded|reopened`',
    `payment_frequency` STRING COMMENT 'Frequency of benefit payments for installment or annuity settlement methods elected at adjudication time.. Valid values are `single|monthly|quarterly|semi_annual|annual`',
    `policy_provision_cited` STRING COMMENT 'Specific policy provision, clause, exclusion, or rider section number cited as the legal basis for the adjudication decision. Examples include suicide exclusion clause, contestability period provision, misrepresentation clause, or specific exclusion riders.',
    `prompt_payment_compliance_days` STRING COMMENT 'Number of calendar days from claim receipt to adjudication decision, used to track compliance with state prompt payment laws (typically 30-60 days depending on jurisdiction).',
    `reinsurance_recoverable_flag` BOOLEAN COMMENT 'Indicates whether a portion of the approved benefit amount is recoverable from reinsurers under ceded reinsurance treaties.',
    `settlement_method` STRING COMMENT 'The settlement method elected or assigned at adjudication time for approved claims. Lump sum indicates single payment; installment indicates periodic payments over defined term; annuity indicates conversion to annuity contract; retained asset indicates funds held in interest-bearing account; interest only indicates principal retained with periodic interest payments; combination indicates multiple methods applied. This is the SSOT for the adjudication-time settlement decision.. Valid values are `lump_sum|installment|annuity|retained_asset|interest_only|combination`',
    `settlement_option_elected` STRING COMMENT 'Detailed description of the specific settlement option elected by the beneficiary or assigned by the policy at adjudication time. Includes option code, term length, payment frequency, and any special conditions.',
    `state_withholding_percentage` DECIMAL(18,2) COMMENT 'Percentage of benefit payment to be withheld for state income tax, as elected by beneficiary at adjudication time.',
    `supervisor_review_flag` BOOLEAN COMMENT 'Indicates whether the adjudication decision required or received supervisory review and approval prior to finalization.',
    `tax_withholding_election` STRING COMMENT 'Beneficiary election for tax withholding on benefit payments, captured at adjudication time. Determines whether federal and/or state income tax withholding will be applied to disbursements.. Valid values are `no_withholding|federal_only|state_only|federal_and_state`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this adjudication record was last modified in the claims management system.',
    CONSTRAINT pk_adjudication PRIMARY KEY(`adjudication_id`)
) COMMENT 'Core transactional record capturing the formal adjudication decision for a claim, including full denial documentation and adverse action lifecycle when applicable. Records adjudication outcome (approved, denied, partially approved, pended, rescinded), adjudication date, examiner ID, decision basis (policy provisions applied: suicide exclusion, contestability, misrepresentation, exclusion riders), benefit amount approved, supervisor review flag, and authority level applied. For approved claims: captures the selected settlement method and election details (elected option, payment frequency, tax withholding preference, beneficiary signature confirmation) as the SSOT for the adjudication-time settlement decision. For denial outcomes: captures denial reason codes (per NAIC and state DOI standards), policy provision cited, denial letter generation date, adverse action notice compliance flag, claimant appeal rights disclosure, external review referral flag, internal review completion date, and litigation hold management. Supports state prompt payment law compliance and DOI complaint tracking. SSOT for all claim adjudication decisions and adverse actions within the claims domain. Note: settlement election details here record the decision-time election; claim_payment records the execution-time disbursement details.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`db_calculation` (
    `db_calculation_id` BIGINT COMMENT 'Unique identifier for the death benefit calculation record. Primary key for this entity.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Death benefit calculations for annuity contracts require GMDB floor amounts, account values, accumulated values, and rider provisions. Critical for accurate benefit determination and regulatory compli',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim record for which this death benefit calculation was performed.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy for which the death benefit is being calculated.',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Death benefit calculations use mortality tables to compute net amount at risk, determine corridor percentages for tax qualification, and calculate reserve impacts. Essential for accurate DB calculatio',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Death benefit calculations require product-specific formulas, death benefit options, rider amounts, GMDB provisions, and calculation methods defined in the product plan. Essential for accurate benefit',
    `employee_id` BIGINT COMMENT 'User ID of the claims examiner or actuarial analyst who performed or approved the calculation.',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Death benefit calculations for variable products require separate account values to determine greater-of benefit (face amount vs. account value vs. GMDB floor). Core calculation for variable life insu',
    `account_value` DECIMAL(18,2) COMMENT 'Current account value of the policy for universal life, indexed universal life, and variable universal life products. Used to determine the death benefit for Option A (level) or Option B (increasing) death benefit designs.',
    `accumulated_dividends` DECIMAL(18,2) COMMENT 'Total dividends accumulated on the policy that are left on deposit with the insurer and payable as part of the death benefit. Applicable primarily to participating whole life policies.',
    `adb_rider_amount` DECIMAL(18,2) COMMENT 'Additional death benefit payable if the insureds death was caused by a covered accident. Typically doubles or triples the base face amount. Zero if death was not accidental or rider not in force.',
    `base_face_amount` DECIMAL(18,2) COMMENT 'The original face amount of the life insurance policy as stated in the policy contract. This is the foundational death benefit before any adjustments.',
    `calculation_date` DATE COMMENT 'The date on which the death benefit calculation was performed by the claims examiner or actuarial system.',
    `calculation_method` STRING COMMENT 'Method used to perform the death benefit calculation: manual (examiner-calculated), automated (system-calculated), or hybrid (system-assisted with manual review).. Valid values are `manual|automated|hybrid`',
    `calculation_notes` STRING COMMENT 'Free-text notes documenting special circumstances, assumptions, or adjustments made during the death benefit calculation process.',
    `calculation_status` STRING COMMENT 'Current status of the death benefit calculation in the approval workflow.. Valid values are `draft|pending_review|approved|rejected|superseded`',
    `calculation_version` STRING COMMENT 'Version number of this calculation. Increments when recalculations are performed due to additional information, corrections, or appeals.',
    `contestability_applied_flag` BOOLEAN COMMENT 'Indicates whether the policy was within the contestability period (typically 2 years from issue) at the time of death, which may affect benefit calculations or require additional investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this death benefit calculation record was first created in the system.',
    `csv_amount` DECIMAL(18,2) COMMENT 'The cash surrender value of the policy at the time of death. Used for comparison with GMDB floors and for certain death benefit option calculations.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this calculation record (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `death_benefit_option` STRING COMMENT 'The death benefit option elected by the policyholder for universal life products. Option A (level) pays face amount; Option B (increasing) pays face amount plus account value.. Valid values are `option_a|option_b|option_c|level|increasing`',
    `gmdb_floor_amount` DECIMAL(18,2) COMMENT 'The guaranteed minimum death benefit floor applicable to variable life and variable annuity products. Ensures beneficiaries receive at least this amount regardless of investment performance.',
    `gross_db_amount` DECIMAL(18,2) COMMENT 'Total gross death benefit before deductions, calculated as base face amount plus accumulated dividends, paid-up additions, ADB rider amount, and any applicable GMDB floor adjustments.',
    `interest_on_delayed_payment` DECIMAL(18,2) COMMENT 'Interest accrued on the death benefit from the date of death to the date of payment, as required by state insurance regulations. Typically calculated at the statutory interest rate.',
    `nar_amount` DECIMAL(18,2) COMMENT 'The net amount at risk to the insurer, calculated as the death benefit minus the policy reserve or account value. Critical for reinsurance cession calculations and risk management.',
    `net_db_payable` DECIMAL(18,2) COMMENT 'The final net death benefit amount payable to beneficiaries after all additions and deductions. This is the authoritative benefit amount that feeds adjudication and payment records.',
    `outstanding_loan_balance` DECIMAL(18,2) COMMENT 'Total outstanding policy loan principal and accrued interest that must be deducted from the gross death benefit. Loans reduce the net amount payable to beneficiaries.',
    `paid_up_additions` DECIMAL(18,2) COMMENT 'Additional insurance purchased with policy dividends that increases the total death benefit. Common in whole life policies with dividend reinvestment options.',
    `premium_arrears` DECIMAL(18,2) COMMENT 'Unpaid premiums owed by the policyholder at the time of death, including any grace period premiums. Deducted from the gross death benefit.',
    `product_type` STRING COMMENT 'Type of life insurance product for which the death benefit is calculated. WL=Whole Life, UL=Universal Life, IUL=Indexed Universal Life, VUL=Variable Universal Life, term=Term Life, SPIA=Single Premium Immediate Annuity.. Valid values are `WL|UL|IUL|VUL|term|SPIA`',
    `recalculation_reason` STRING COMMENT 'Reason for recalculating the death benefit if this is a subsequent version. Examples include additional information received, correction of errors, beneficiary dispute resolution, or appeal.',
    `reinsurance_ceded_amount` DECIMAL(18,2) COMMENT 'Portion of the death benefit that is ceded to reinsurers under reinsurance treaties. Used to calculate the net retained liability and reinsurance recoverables.',
    `review_date` DATE COMMENT 'Date on which the death benefit calculation was reviewed and approved by a senior examiner or manager.',
    `statutory_interest_rate` DECIMAL(18,2) COMMENT 'The interest rate mandated by state law for calculating interest on delayed death benefit payments. Expressed as a decimal (e.g., 0.0500 for 5%).',
    `suicide_clause_applied_flag` BOOLEAN COMMENT 'Indicates whether the suicide exclusion clause was applied to this calculation. If death occurred within the suicide exclusion period (typically 2 years), only premiums paid may be returned instead of the full death benefit.',
    `total_deductions` DECIMAL(18,2) COMMENT 'Sum of all deductions from the gross death benefit, including outstanding loan balance, premium arrears, and any other policy-specific deductions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this death benefit calculation record was last modified.',
    CONSTRAINT pk_db_calculation PRIMARY KEY(`db_calculation_id`)
) COMMENT 'Death Benefit (DB) calculation record capturing the actuarial and contractual computation of the total death benefit payable for a life insurance claim. Tracks base face amount, accumulated dividends, paid-up additions, outstanding loan balance deductions, premium arrears deductions, ADB (Accidental Death Benefit) rider amount, GMDB (Guaranteed Minimum Death Benefit) floor for variable products, interest on delayed payment, and net DB payable. Supports WL, UL, IUL, VUL, and term product benefit calculations. Provides the authoritative benefit amount feeding the adjudication and payment records.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` (
    `living_benefit_claim_id` BIGINT COMMENT 'Unique system identifier for the living benefit claim record. Primary key.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Living benefit claims (LTC, disability, chronic illness) originate from annuity rider elections. Link required to verify rider terms, benefit bases, elimination periods, and payment calculations per c',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: Living benefit claims (LTC, disability, critical illness) inform morbidity assumption development and reserve adequacy testing. Actuaries track actual vs expected claim incidence, duration, and severi',
    `claim_id` BIGINT COMMENT 'Foreign key reference to the parent claim record in the claims domain. Links this living benefit claim to the core claim lifecycle and shared claim attributes.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key reference to the policy under which this living benefit claim is filed. Links to the policy master record.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Living benefit claims (LTC, disability, critical illness) require product plan specifications for benefit triggers, elimination periods, benefit duration, ADL requirements, and inflation protection. D',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: GMWB/GMIB living benefit claims on variable annuities require separate account values to compare benefit base against account value for withdrawal eligibility and amount determination. Required for gu',
    `adl_impairment_count` STRING COMMENT 'The number of Activities of Daily Living (ADL) in which the insured is impaired and requires substantial assistance. ADLs typically include bathing, dressing, eating, toileting, transferring, and continence. Most LTC policies require impairment in 2 or more ADLs for benefit eligibility. Protected Health Information (PHI).',
    `adl_impairment_list` STRING COMMENT 'Comma-separated list of specific Activities of Daily Living (ADL) in which the insured is impaired. Examples: bathing, dressing, eating, toileting, transferring, continence. Used to document LTC benefit eligibility. Protected Health Information (PHI).',
    `attending_physician_name` STRING COMMENT 'Name of the attending physician who provided the medical documentation and Attending Physician Statement (APS) supporting this living benefit claim. Protected Health Information (PHI).',
    `attending_physician_statement_received_flag` BOOLEAN COMMENT 'Boolean indicator of whether the Attending Physician Statement (APS) has been received and is on file for this claim. APS is typically required for medical evidence in living benefit claims.',
    `benefit_calculation_basis` STRING COMMENT 'The contractual basis used to calculate the living benefit payment amount. Examples include policy face amount (for ADB), account value (for annuity guarantees), benefit base (for GMIB/GMWB), income base, ADL daily benefit amount (for LTC), flat benefit amount, or percentage of premium waived (for WP). [ENUM-REF-CANDIDATE: policy_face_amount|account_value|benefit_base|income_base|adl_daily_benefit|flat_benefit|percentage_of_premium — 7 candidates stripped; promote to reference product]',
    `benefit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the benefit payment amount (e.g., USD, CAD, GBP). Aligns with policy currency.. Valid values are `^[A-Z]{3}$`',
    `benefit_duration_months` STRING COMMENT 'The maximum duration (in months) for which benefits are payable under this claim, as defined by the policy contract. Common durations include 24, 60, or to age 65 for DI; 24, 36, 60, or lifetime for LTC. Null indicates lifetime or indefinite duration.',
    `benefit_end_date` DATE COMMENT 'The date on which benefit payments ended or are scheduled to end. May be due to benefit duration expiration, recovery, death, policy termination, or other termination event. Null indicates benefits are ongoing.',
    `benefit_start_date` DATE COMMENT 'The date on which benefit payments commenced or are scheduled to commence. Typically follows the elimination period end date and claim approval.',
    `care_setting` STRING COMMENT 'The care setting in which Long-Term Care (LTC) services are being provided. Options include home health care, assisted living facility, nursing facility (skilled nursing), adult day care, hospice, or not applicable (for non-LTC claims). Determines benefit eligibility and payment rates.. Valid values are `home_health|assisted_living|nursing_facility|adult_day_care|hospice|not_applicable`',
    `claim_subtype` STRING COMMENT 'Specific type of living benefit claim being processed. Distinguishes between Disability Income (DI), Long-Term Care (LTC), Accelerated Death Benefit (ADB), chronic illness, critical illness, terminal illness, Waiver of Premium (WP), Guaranteed Minimum Income Benefit (GMIB), Guaranteed Minimum Withdrawal Benefit (GMWB), Activities of Daily Living (ADL) benefit, and cognitive impairment claims. [ENUM-REF-CANDIDATE: disability_income|long_term_care|accelerated_death_benefit|chronic_illness|critical_illness|terminal_illness|waiver_of_premium|gmib|gmwb|adl_benefit|cognitive_impairment — 11 candidates stripped; promote to reference product]',
    `cognitive_impairment_flag` BOOLEAN COMMENT 'Boolean indicator of whether the insured has been diagnosed with cognitive impairment requiring substantial supervision to protect health and safety. Cognitive impairment (e.g., Alzheimers, dementia) is an alternative trigger for LTC benefits even without ADL impairment. Protected Health Information (PHI).',
    `coordination_of_benefits_description` STRING COMMENT 'Free-text description of the coordination of benefits arrangement, including the other payer(s) and the coordination method (e.g., Medicare primary, policy secondary; Medicaid coordination for LTC).',
    `coordination_of_benefits_flag` BOOLEAN COMMENT 'Boolean indicator of whether coordination of benefits (COB) with other insurance, Medicare, Medicaid, or government programs applies to this claim. True indicates benefits are coordinated to prevent duplicate payment; False indicates no coordination required.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this living benefit claim record was first created in the system. Audit trail field for data lineage and compliance.',
    `diagnosis_code` STRING COMMENT 'ICD-10 or ICD-11 diagnosis code documenting the medical condition underlying the claim. Used for medical underwriting, claim validation, and regulatory reporting. Protected Health Information (PHI).',
    `diagnosis_description` STRING COMMENT 'Plain-language description of the medical diagnosis or condition that triggered the living benefit claim. Protected Health Information (PHI).',
    `disability_definition_applied` STRING COMMENT 'The contractual definition of disability applied to this claim. Relevant for Disability Income (DI) claims. Options include own-occupation (unable to perform duties of own occupation), any-occupation (unable to perform duties of any occupation), modified own-occupation (own-occ for initial period, then any-occ), or presumptive disability (automatic qualification based on specific conditions). Not applicable for non-DI claims.. Valid values are `own_occupation|any_occupation|modified_own_occupation|presumptive_disability|not_applicable`',
    `elimination_period_days` STRING COMMENT 'The contractual waiting period (in days) that must elapse after the triggering event before benefit payments begin. Common elimination periods are 30, 60, 90, 180, or 365 days. Zero indicates no elimination period.',
    `elimination_period_end_date` DATE COMMENT 'The date on which the elimination period was satisfied and benefit payments became eligible to commence. Calculated as elimination_period_start_date plus elimination_period_days.',
    `elimination_period_satisfied_flag` BOOLEAN COMMENT 'Boolean indicator of whether the elimination period has been fully satisfied. True indicates the waiting period is complete and benefits are eligible for payment; False indicates the elimination period is still in progress.',
    `elimination_period_start_date` DATE COMMENT 'The date on which the elimination period began, typically the triggering event date. Used to calculate when benefit payments should commence.',
    `functional_capacity_evaluation_date` DATE COMMENT 'The date on which a functional capacity evaluation (FCE) was performed to assess the insureds ability to perform work duties (for DI claims) or activities of daily living (for LTC claims). Used to support disability determination.',
    `inflation_protection_rate` DECIMAL(18,2) COMMENT 'The annual compound inflation protection rate applied to Long-Term Care (LTC) benefits to adjust for cost-of-living increases. Common rates are 3% or 5% compound. Expressed as a decimal (e.g., 0.03 for 3%). Zero or null indicates no inflation protection.',
    `monthly_benefit_amount` DECIMAL(18,2) COMMENT 'The calculated monthly benefit payment amount for this living benefit claim. Expressed in the claim currency. For non-monthly payment frequencies, this represents the normalized monthly equivalent.',
    `next_eligibility_verification_date` DATE COMMENT 'The date on which the next periodic eligibility verification (re-certification) is required to confirm ongoing qualification for living benefits. Common for DI and LTC claims to ensure continued impairment. Null if no periodic verification is required.',
    `payment_frequency` STRING COMMENT 'The frequency at which living benefit payments are disbursed to the claimant. Common frequencies include monthly (most common for DI and LTC), quarterly, annual, lump sum (for ADB or critical illness), or as incurred (for reimbursement-based LTC).. Valid values are `monthly|quarterly|annual|lump_sum|as_incurred`',
    `recovery_date` DATE COMMENT 'The date on which the insured recovered from the disability or condition, resulting in termination of living benefit payments. Null if no recovery has occurred or if claim terminated for other reasons.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'The amount recoverable from reinsurers for this living benefit claim under applicable reinsurance treaties. Represents the ceded portion of claim payments. Zero if no reinsurance applies.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The actuarial reserve amount established for this living benefit claim to cover estimated future benefit payments. Updated periodically based on claim experience and actuarial assumptions. Used for statutory and GAAP financial reporting.',
    `social_security_offset_amount` DECIMAL(18,2) COMMENT 'The monthly amount by which the disability income benefit is reduced due to Social Security Disability Insurance (SSDI) benefits received by the insured. Many DI policies include SSDI offset provisions to prevent over-insurance. Zero if no offset applies.',
    `tax_treatment_code` STRING COMMENT 'The tax treatment classification for this living benefit payment under the Internal Revenue Code (IRC). IRC Section 101(g) governs Accelerated Death Benefits (ADB) for terminal/chronic illness (generally tax-free if qualified). IRC Section 7702B governs qualified Long-Term Care (LTC) benefits (tax-free up to per diem limits). Other benefits may be taxable income.. Valid values are `irc_101g_qualified|irc_7702b_qualified|taxable|tax_free|not_applicable`',
    `termination_reason_code` STRING COMMENT 'The reason why living benefit payments were terminated. Options include recovery from disability/illness, death of insured, benefit maximum reached, policy lapse, fraud determination, voluntary termination by claimant, or not terminated (benefits ongoing). [ENUM-REF-CANDIDATE: recovery|death|benefit_maximum_reached|policy_lapse|fraud|voluntary_termination|not_terminated — 7 candidates stripped; promote to reference product]',
    `total_benefit_paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative total of all benefit payments made on this living benefit claim from inception to the current date. Expressed in the claim currency. Used for benefit maximum tracking and financial reporting.',
    `triggering_event` STRING COMMENT 'The specific event or condition that triggered eligibility for this living benefit claim. Examples include disability onset, terminal illness diagnosis, chronic illness diagnosis, critical illness diagnosis, Activities of Daily Living (ADL) impairment, cognitive impairment, premium waiver trigger condition, or annuity guarantee trigger event. [ENUM-REF-CANDIDATE: disability_onset|terminal_diagnosis|chronic_diagnosis|critical_diagnosis|adl_impairment|cognitive_impairment|premium_waiver_trigger|annuity_guarantee_trigger — 8 candidates stripped; promote to reference product]',
    `triggering_event_date` DATE COMMENT 'The date on which the triggering event occurred (e.g., date of disability onset, date of terminal diagnosis, date ADL impairment began). Used to determine benefit eligibility and elimination period start.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this living benefit claim record was last modified. Audit trail field for data lineage and compliance. Updated on any change to claim status, benefit amounts, or other attributes.',
    `waiver_of_premium_amount` DECIMAL(18,2) COMMENT 'The monthly or annual premium amount being waived under a Waiver of Premium (WP) rider due to the insureds disability or qualifying condition. Represents the premium obligation that the insurer is absorbing. Zero for non-WP claims.',
    CONSTRAINT pk_living_benefit_claim PRIMARY KEY(`living_benefit_claim_id`)
) COMMENT 'Consolidated claim detail record for all living-insured benefit claims including Disability Income (DI), Long-Term Care (LTC), Accelerated Death Benefit (ADB), chronic/critical illness riders, GMIB/GMWB annuity guarantees, and Waiver-of-Premium (WP) claims. Captures claim subtype, triggering event (disability onset, terminal/chronic/critical illness diagnosis, ADL impairment, cognitive impairment), elimination period tracking, benefit calculation basis, payment frequency and duration, ongoing eligibility verification requirements, medical documentation (ICD-10 codes, APS, functional capacity evaluations), disability definition applied (own-occ, any-occ, modified own-occ), care setting (for LTC: home health, assisted living, nursing facility), Social Security offset (for DI), coordination of benefits with Medicare/Medicaid (for LTC), tax treatment (IRC 101(g) for ADB), waiver trigger and premium amount waived (for WP), inflation protection adjustment (for LTC), and termination/recovery events. Extends the core claim record with type-specific attributes while sharing the common claim lifecycle. SSOT for all non-death-benefit claim detail within the claims domain — replaces standalone DI, LTC, and waiver-of-premium claim records.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claim_payment` (
    `claim_payment_id` BIGINT COMMENT 'Unique identifier for the claim payment transaction. Primary key for the claim payment record.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claims.adjudication. Business justification: Each claim payment should reference the adjudication that authorized it. The adjudication record contains the benefit_amount_approved and settlement_method, and the payment executes that decision. Thi',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim for which this payment is being made. Links payment to the adjudicated claim record.',
    `claimant_id` BIGINT COMMENT 'Foreign key linking to claims.claimant. Business justification: Payment should directly reference the claimant receiving the payment for in-domain tracking. Currently claim_payment has payee_id → commission.payee (cross-domain for payment processing), but should a',
    `employee_id` BIGINT COMMENT 'User ID of the claims examiner or supervisor who approved the payment. Supports audit trail and accountability.',
    `erisa_plan_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.erisa_plan_filing. Business justification: Group life insurance claim payments under ERISA plans must be reported on Form 5500 Schedule A. DOL regulations require linking claim payments to ERISA plan filings for participant benefit reporting a',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the insurance policy under which this claim payment is made. Enables direct policy-to-payment traceability.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Every claim payment must be recorded in the general ledger for financial reporting, statutory compliance, and audit trail. This links payment execution to the specific GL entry that books cash disburs',
    `original_payment_claim_payment_id` BIGINT COMMENT 'Reference to the original payment record if this is a reissue. Null for initial payment issuance.',
    `party_id` BIGINT COMMENT 'Social Security Number (SSN) or Employer Identification Number (EIN) of the payee. Required for IRS Form 1099 reporting.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Payment processing requires product-specific settlement options, payment frequency rules, tax treatment codes, and 1099 reporting requirements. Product plan defines available payment methods and tax q',
    `reinsurance_cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: When claims are paid, finance teams must calculate reinsurance recoverables against specific cessions to determine net claim cost. Payment processing systems require cession identification for recover',
    `report_line_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_line_definition. Business justification: Claim payments feed benefit payment lines in statutory exhibits (Schedule T) and GAAP income statements. Finance teams map payment types to specific report lines for accurate financial reporting. Crit',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.sar_filing. Business justification: Suspicious claim payment patterns (structuring, rapid beneficiary changes, unusual payees) trigger SAR filings to FinCEN. Insurance operations must link payments to SAR filings for BSA/AML compliance ',
    `beneficiary_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total claim benefit allocated to this specific payee in split-benefit scenarios. Sum across all payments for a claim equals 100%.',
    `cleared_date` DATE COMMENT 'Date the payment cleared the banking system and funds were successfully transferred to payee account. Null if not yet cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Supports audit trail and data lineage.',
    `direct_deposit_authorization_flag` BOOLEAN COMMENT 'Indicates whether the payee has provided written authorization for direct deposit. Required for ACH compliance.',
    `escheatment_referral_date` DATE COMMENT 'Date the unclaimed payment was referred to state escheatment process. Null if payment has not reached escheatment status.',
    `escheatment_state` STRING COMMENT 'Two-letter US state code to which unclaimed funds were escheated. Determined by payee last known address or policy domicile.. Valid values are `^[A-Z]{2}$`',
    `federal_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from the payment per payee election or mandatory withholding rules. Reported on Form 1099-R.',
    `form_1099_reporting_flag` BOOLEAN COMMENT 'Indicates whether this payment is reportable on IRS Form 1099-R or 1099-MISC. Drives year-end tax reporting workflow.',
    `form_1099_type` STRING COMMENT 'Specific IRS Form 1099 type applicable to this payment. 1099-R for distributions from retirement accounts, 1099-MISC for other payments.. Valid values are `1099-R|1099-MISC|not_reportable`',
    `gross_payment_amount` DECIMAL(18,2) COMMENT 'Total payment amount before any withholdings or deductions. Represents the full benefit amount approved for disbursement.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net amount disbursed to payee after all withholdings and deductions. This is the actual amount received by the beneficiary.',
    `payee_bank_account_number` STRING COMMENT 'Bank account number for electronic funds transfer (EFT) or ACH payment. Encrypted at rest per PCI-DSS requirements.',
    `payee_bank_name` STRING COMMENT 'Name of the financial institution holding the payees account. Used for payment verification and audit trail.',
    `payee_bank_routing_number` STRING COMMENT 'Nine-digit ABA routing transit number for the payees financial institution. Required for ACH and wire transfers.. Valid values are `^[0-9]{9}$`',
    `payment_approval_date` DATE COMMENT 'Date the payment was approved by claims examiner or automated adjudication system. Precedes payment issuance.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment. Typically USD for US-domiciled policies but supports multi-currency scenarios.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'Date the payment was issued or disbursed to the payee. Used for accounting recognition and regulatory reporting.',
    `payment_effective_date` DATE COMMENT 'Date from which the payment is effective for benefit calculation purposes. May differ from payment date for backdated settlements.',
    `payment_frequency` STRING COMMENT 'Frequency of recurring payments for installment or periodic benefit disbursements. Null for lump sum payments.. Valid values are `one_time|monthly|quarterly|annual`',
    `payment_method` STRING COMMENT 'Instrument or mechanism used to disburse the payment. Determines processing workflow and settlement timeline.. Valid values are `check|eft_ach|wire_transfer|retained_asset_account`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments regarding the payment transaction. Captures special handling instructions or payment-specific context.',
    `payment_number` STRING COMMENT 'Business-readable unique identifier for the payment transaction. Used for customer communication and payment tracking.',
    `payment_sequence` STRING COMMENT 'Sequential number of this payment within the claim. Supports tracking of multiple partial payments or installment disbursements for a single claim.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks payment from issuance through final disposition including returned or escheated funds.. Valid values are `issued|cleared|voided|returned|escheatment_referred|pending`',
    `payment_type` STRING COMMENT 'Classification of the payment based on the benefit type being disbursed. Aligns with claim type and benefit structure.. Valid values are `death_benefit|disability_income|long_term_care|living_benefit|waiver_of_premium|partial_settlement`',
    `reissue_flag` BOOLEAN COMMENT 'Indicates whether this payment is a reissue of a previous payment. True if replacing a voided, returned, or stopped payment.',
    `settlement_option` STRING COMMENT 'Executed settlement election chosen by beneficiary or claimant. Records how the benefit is being paid out over time.. Valid values are `lump_sum|installment|life_income|retained_asset_account|annuitization`',
    `state_tax_withheld_amount` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from the payment per payee election or state withholding requirements.',
    `stop_payment_date` DATE COMMENT 'Date the stop payment order was placed. Null if no stop payment has been requested.',
    `stop_payment_flag` BOOLEAN COMMENT 'Indicates whether a stop payment order has been placed on this payment. Typically used for lost or stolen checks.',
    `stop_payment_reason` STRING COMMENT 'Business reason for placing stop payment order. Common reasons include lost check, incorrect payee, or duplicate payment.',
    `tax_withholding_election` STRING COMMENT 'Payees election for federal and state income tax withholding. Determines withholding calculation method.. Valid values are `no_withholding|mandatory_20_percent|custom_percentage|state_default`',
    `tax_withholding_percentage` DECIMAL(18,2) COMMENT 'Custom withholding percentage elected by payee if custom withholding option was selected. Null if not applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was last modified. Tracks all changes to payment status, amounts, or payee information.',
    CONSTRAINT pk_claim_payment PRIMARY KEY(`claim_payment_id`)
) COMMENT 'Transactional record for every monetary disbursement made in settlement or partial settlement of a claim. Captures payment amount, payment date, payment method (check, EFT/ACH, wire transfer), payee identity and banking details, tax withholding amount (federal and state), tax withholding election, 1099-R or 1099-MISC reporting flag, payment status (issued, cleared, voided, returned, escheatment-referred), stop-payment flag, reissue reference, and direct deposit authorization. For settlement execution: records the executed settlement option (lump sum, installment, life income, retained asset account), executed payment frequency, and beneficiary payment allocation for split-benefit scenarios. Supports periodic DI/LTC benefit payments with payment schedule tracking and annuity domain handoff for life income settlement options requiring annuitization. SSOT for all claim disbursement transactions and payment execution within the claims domain. Note: the adjudication record captures the decision-time settlement election; this product records the actual payment execution.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claim_reserve` (
    `claim_reserve_id` BIGINT COMMENT 'Unique identifier for the claim reserve record. Primary key for the claim reserve entity.',
    `claim_id` BIGINT COMMENT 'Reference to the claim for which this reserve is established. Links to the parent claim record.',
    `staff_license_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_license. Business justification: Actuarial reserve estimation requires active FSA/ASA credentials. SOX controls and state insurance regulations mandate tracking which licensed actuary signed off on reserve calculations. Critical for ',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy under which the claim and reserve are recorded.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Claim reserves must be recorded in the general ledger via journal entries. The claim_reserve product tracks actuarial reserve estimates, but the actual GL posting is a separate finance domain event. A',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Reserve calculations require product-specific mortality tables, interest rate assumptions, reserve basis, and valuation methods. Product performance monitoring and reserve adequacy testing aggregate r',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Claim reserves are backed by investment portfolios for ALM duration matching and RBC C3 interest rate risk calculations. Statutory reserve adequacy testing requires linking reserves to supporting asse',
    `employee_id` BIGINT COMMENT 'Reference to the claims examiner responsible for establishing and maintaining the case reserve. Applicable to case reserves; null for IBNR estimates.',
    `reinsurance_treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty. Business justification: Actuaries calculating claim reserves must identify applicable reinsurance treaties to properly account for ceded reserves and reinsurance recoverables in net reserve amounts. Required for Schedule S s',
    `report_line_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_line_definition. Business justification: Reserve amounts populate specific statutory exhibit lines (Schedule P, Schedule F). Actuaries map reserve types to report line codes for NAIC Annual Statement preparation. Required for reserve adequac',
    `reserve_calculation_id` BIGINT COMMENT 'Foreign key linking to actuarial.reserve_calculation. Business justification: Claims reserves are inputs to actuarial reserve calculations for statutory/GAAP reporting, reserve adequacy testing, and regulatory filings. Actuaries reconcile case reserves to valuation reserves qua',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Claim reserve establishment and changes are key SOX controls for financial statement accuracy (valuation assertion). Public insurers must link reserves to SOX control testing for Sarbanes-Oxley compli',
    `actuarial_signoff_date` DATE COMMENT 'The date on which the appointed actuary formally approved the reserve estimate, certifying its adequacy and compliance with applicable standards.',
    `actuarial_signoff_status` STRING COMMENT 'Approval status of the reserve estimate by the appointed actuary or actuarial team. PENDING: awaiting actuarial review; APPROVED: actuary has signed off on the reserve; REJECTED: reserve estimate rejected and requires recalculation; CONDITIONAL: approved with conditions or qualifications.. Valid values are `pending|approved|rejected|conditional`',
    `catastrophic_event_code` STRING COMMENT 'Standardized code identifying the specific catastrophic event (e.g., COVID-19, Hurricane Katrina, 9/11) for bulk reserve tracking and reporting. Null for non-catastrophic reserves.',
    `catastrophic_event_flag` BOOLEAN COMMENT 'Indicates whether this reserve is associated with a catastrophic event (e.g., pandemic, natural disaster, terrorism) requiring bulk or supplemental reserves. True if catastrophic; False otherwise.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval (typically 75th or 80th percentile) for the IBNR estimate, representing a more conservative reserve level. Used for risk assessment and capital adequacy analysis.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval (typically 90th or 95th percentile) for the IBNR estimate, representing a more adverse reserve scenario. Used for stress testing and capital planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this reserve record was first created in the system. Audit field for data lineage and compliance.',
    `current_reserve_amount` DECIMAL(18,2) COMMENT 'The current outstanding reserve amount after all adjustments, payments, and releases. Represents the best estimate of remaining liability as of the valuation date.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The interest rate used to discount future claim payments to present value for certain reserve calculations, particularly under PBR and IFRS 17. Expressed as a decimal (e.g., 0.035 for 3.5%).',
    `estimation_methodology` STRING COMMENT 'The actuarial or statistical method used to calculate the reserve. Examples: chain-ladder development, Bornhuetter-Ferguson, frequency-severity, expected loss ratio, case-based estimation. Applicable primarily to IBNR and bulk reserves. [ENUM-REF-CANDIDATE: chain_ladder|bornhuetter_ferguson|frequency_severity|expected_loss_ratio|case_based|cape_cod|benktander|grossing_up — promote to reference product]',
    `ibnr_development_variance` DECIMAL(18,2) COMMENT 'The difference between the current period IBNR estimate and the prior period estimate, adjusted for claims emerged and paid. Positive variance indicates adverse development; negative indicates favorable development.',
    `initial_reserve_amount` DECIMAL(18,2) COMMENT 'The original reserve amount established when the claim was first reported or the IBNR estimate was first recorded. Represents the initial actuarial or claims examiner estimate of liability.',
    `last_review_date` DATE COMMENT 'The most recent date on which the reserve adequacy was reviewed and confirmed or adjusted by a claims examiner or actuary.',
    `loss_development_factor` DECIMAL(18,2) COMMENT 'The age-to-age development factor applied in the reserve calculation, representing the expected ratio of ultimate losses to reported losses at the current development stage. Used in chain-ladder and related IBNR methodologies.',
    `net_amount_at_risk` DECIMAL(18,2) COMMENT 'The difference between the death benefit and the account value or cash surrender value at the time of reserve establishment. Represents the insurance companys pure mortality risk exposure net of policyholder funds.',
    `net_reserve_amount` DECIMAL(18,2) COMMENT 'The reserve amount net of reinsurance recoverables, representing the companys retained liability after reinsurance. Calculated as current_reserve_amount minus reinsurance_recoverable_amount.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next reserve adequacy review. Used for workflow management and compliance with periodic review requirements.',
    `prior_period_ibnr_amount` DECIMAL(18,2) COMMENT 'The IBNR reserve amount from the previous valuation period, used for comparison and development analysis. Enables tracking of reserve adequacy and emergence patterns over time.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'The portion of the reserve that is expected to be recovered from reinsurers under ceded reinsurance treaties. Represents the reinsurers share of the claim liability.',
    `reserve_adequacy_indicator` STRING COMMENT 'Assessment of whether the current reserve is sufficient to cover expected claim payments. ADEQUATE: reserve meets actuarial best estimate; DEFICIENT: reserve is insufficient and requires strengthening; REDUNDANT: reserve exceeds expected liability; UNDER_REVIEW: adequacy assessment in progress.. Valid values are `adequate|deficient|redundant|under_review`',
    `reserve_basis` STRING COMMENT 'Accounting or regulatory basis under which the reserve is calculated. SAP: Statutory Accounting Principles; GAAP: Generally Accepted Accounting Principles (ASC 944, LDTI); IFRS: International Financial Reporting Standards (IFRS 17); TAX: tax basis reserves; PBR: Principle-Based Reserving (VM-20/VM-21).. Valid values are `sap|gaap|ifrs|tax|pbr`',
    `reserve_change_amount` DECIMAL(18,2) COMMENT 'The net change in reserve amount since the last valuation or adjustment. Positive values indicate reserve strengthening; negative values indicate reserve release.',
    `reserve_change_reason_code` STRING COMMENT 'Standardized code indicating the reason for the most recent reserve adjustment. NEW_INFORMATION: new medical or investigative findings; PAYMENT: partial payment reducing reserve; SETTLEMENT: claim settled; ADEQUACY_REVIEW: periodic review adjustment; ACTUARIAL_UPDATE: updated loss development factors or methodology; CLAIM_CLOSURE: claim closed and reserve released; REOPENING: claim reopened requiring reserve re-establishment. [ENUM-REF-CANDIDATE: new_information|payment|settlement|adequacy_review|actuarial_update|claim_closure|reopening — 7 candidates stripped; promote to reference product]',
    `reserve_change_reason_description` STRING COMMENT 'Free-text narrative explaining the business rationale for the reserve change, providing additional context beyond the reason code.',
    `reserve_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the reserve amounts (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `reserve_establishment_date` DATE COMMENT 'The date on which the reserve was first established in the system. For case reserves, typically the FNOL or claim intake date; for IBNR, the estimation period end date.',
    `reserve_notes` STRING COMMENT 'Free-text field for additional comments, assumptions, or qualifications related to the reserve calculation or adequacy assessment. Used for documentation and audit trail purposes.',
    `reserve_release_amount` DECIMAL(18,2) COMMENT 'The amount of reserve released upon claim closure or settlement. Represents the difference between the final reserve and actual claim payments, contributing to reserve development gains or losses.',
    `reserve_release_date` DATE COMMENT 'The date on which the reserve was released back to surplus, typically upon final claim settlement or closure. Null for open reserves.',
    `reserve_status` STRING COMMENT 'Current lifecycle status of the reserve. OPEN: active reserve; CLOSED: reserve closed upon claim settlement; RELEASED: reserve released back to surplus; ADJUSTED: reserve amount modified; UNDER_REVIEW: reserve under adequacy review.. Valid values are `open|closed|released|adjusted|under_review`',
    `reserve_type` STRING COMMENT 'Classification of the reserve. CASE: individual claim case reserve; IBNR: Incurred But Not Reported portfolio reserve; BULK: supplemental reserves for catastrophic events or emerging trends; ALAE: Allocated Loss Adjustment Expense; ULAE: Unallocated Loss Adjustment Expense; SUPPLEMENTAL: additional reserves for specific risk exposures.. Valid values are `case|ibnr|bulk|alae|ulae|supplemental`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this reserve record was last modified. Audit field for tracking reserve adjustments and changes over time.',
    `valuation_date` DATE COMMENT 'The as-of date for which the reserve amount is calculated and reported. Typically month-end, quarter-end, or year-end for IBNR; claim event date or review date for case reserves.',
    CONSTRAINT pk_claim_reserve PRIMARY KEY(`claim_reserve_id`)
) COMMENT 'Actuarial reserve record tracking claim-level case reserves and portfolio-level IBNR (Incurred But Not Reported) estimates for claims liability management. CASE RESERVES: captures initial and current reserve amounts per open claim, reserve change history with reason codes, reserve adequacy review dates, reserving examiner, and reserve release upon claim closure. IBNR ESTIMATES: captures estimation period (month-end, quarter-end, year-end), estimation methodology (chain-ladder development, Bornhuetter-Ferguson, frequency-severity), estimated IBNR amount by claim type (DB, DI, LTC, living benefit), confidence intervals, loss development factors, prior period IBNR comparison, estimating actuary ID, and actuarial sign-off/approval status. BULK RESERVES: captures supplemental reserves for catastrophic events or emerging trends. Tracks SAP and GAAP reserve basis and supports LDTI (ASC 944), PBR (VM-20/VM-21), and ORSA reserve adequacy assessments. Feeds actuarial and finance domains for statutory reporting (Annual Statement Schedule P equivalent for life). SSOT for all claim-level case reserves, portfolio-level IBNR estimates, and bulk reserve balances within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claim_document` (
    `claim_document_id` BIGINT COMMENT 'Unique identifier for the claim document record. Primary key for the claim document registry.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to claims.appeal. Business justification: Appeal documents (additional evidence, claimant statements, medical records submitted with appeal) should reference the appeal record. This tracks which documents were submitted as part of the appeal ',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim to which this document belongs. Links document to the claim lifecycle.',
    `claim_investigation_id` BIGINT COMMENT 'Foreign key linking to claims.claim_investigation. Business justification: Investigation documents (field investigation reports, surveillance evidence, third-party records) should reference the specific investigation they support. This organizes documents by investigation wo',
    `contestability_review_id` BIGINT COMMENT 'Foreign key linking to claims.contestability_review. Business justification: Contestability review documents (Attending Physician Statements, MIB reports, underwriting files, application records) should reference the contestability_review they support. This organizes evidence ',
    `fnol_id` BIGINT COMMENT 'Foreign key linking to claims.fnol. Business justification: Documents submitted with First Notice of Loss should reference the FNOL record. This distinguishes FNOL intake documents from later investigation/adjudication documents. Population timing: when docume',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with the claim. Enables policy-level document tracking and compliance verification.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who reviewed the document. Supports audit trails and accountability for document processing decisions.',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Claim documents contain PHI/PII; breaches during document handling (misdirected mail, unauthorized access, lost files) trigger privacy incidents. HIPAA and state breach notification laws require track',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Life insurers frequently use third-party document storage vendors (Iron Mountain, cloud providers) for claims documentation. Tracking storage vendor relationship supports contract compliance, SLA moni',
    `approval_date` DATE COMMENT 'Date the document was approved and accepted for claims adjudication. Marks the document as meeting all requirements.',
    `completeness_checklist_status` STRING COMMENT 'Status of the document against the adjudication completeness checklist. Indicates whether all required elements are present for claims processing.. Valid values are `complete|incomplete|not_applicable|pending_review`',
    `confidentiality_level` STRING COMMENT 'Data classification level of the document content. Determines access controls and handling procedures.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was first created in the system. Supports audit trails and data lineage tracking.',
    `document_date` DATE COMMENT 'Date the document was originally created or issued by the source. For example, the issue date on a death certificate or the date of an APS report.',
    `document_format` STRING COMMENT 'File format or media type of the document. Determines processing and storage requirements.. Valid values are `pdf|tiff|jpeg|png|xml|edi`',
    `document_page_count` STRING COMMENT 'Number of pages in the document. Supports completeness verification and storage capacity planning.',
    `document_receipt_date` DATE COMMENT 'Date the document was received by the claims organization. Critical for SLA tracking and contestability period calculations.',
    `document_receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document was received. Supports detailed audit trails and time-sensitive adjudication requirements.',
    `document_size_bytes` BIGINT COMMENT 'File size of the document in bytes. Used for storage management and transmission optimization.',
    `document_source` STRING COMMENT 'Origin or provider of the document. Identifies the party who submitted or generated the document for claims processing. [ENUM-REF-CANDIDATE: claimant|beneficiary|physician|hospital|funeral_home|attorney|agent|third_party_administrator|reinsurer — 9 candidates stripped; promote to reference product]',
    `document_source_contact` STRING COMMENT 'Contact information (phone, email, or address) for the document source. Enables follow-up for clarification or additional documentation.',
    `document_source_name` STRING COMMENT 'Name of the individual or organization that provided the document. Supports source verification and follow-up communication.',
    `document_status` STRING COMMENT 'Current processing status of the document within the claims adjudication workflow. Tracks document lifecycle from receipt through final disposition.. Valid values are `received|under_review|accepted|rejected|pending|incomplete`',
    `document_storage_location` STRING COMMENT 'Physical or logical storage location identifier (e.g., repository name, bucket, archive system). Supports disaster recovery and data governance.',
    `document_storage_reference` STRING COMMENT 'Unique reference or URI linking to the physical document in the document management system. Enables retrieval of the actual document content.',
    `document_subtype` STRING COMMENT 'Further classification within the document type. For example, APS may be subtyped as initial, follow-up, or supplemental. Provides granular categorization for document management.',
    `document_type` STRING COMMENT 'Classification of the document based on its purpose and content. Determines adjudication requirements and completeness checklist items. [ENUM-REF-CANDIDATE: death_certificate|aps|autopsy_report|police_report|proof_of_identity|beneficiary_designation_form|claimant_statement|medical_records|court_order|letters_testamentary|hipaa_authorization|tax_withholding_form|power_of_attorney|trust_agreement|settlement_agreement|fraud_investigation_report|reinsurance_notification|contestability_evidence — promote to reference product]',
    `expiration_date` DATE COMMENT 'Date after which the document is no longer valid for claims processing. Applicable to time-sensitive documents such as authorizations or certifications.',
    `fraud_indicator_flag` BOOLEAN COMMENT 'Indicates whether the document has been flagged for potential fraud during review. True if fraud indicators are detected.',
    `fraud_indicator_reason` STRING COMMENT 'Description of the fraud indicators detected in the document. Supports fraud investigation and special investigation unit (SIU) referral.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the document was rejected as Not In Good Order. True if the document is incomplete, illegible, or otherwise deficient.',
    `nigo_reason_code` STRING COMMENT 'Standardized code indicating the specific reason the document was marked NIGO. Supports root cause analysis and process improvement.',
    `nigo_reason_description` STRING COMMENT 'Detailed explanation of why the document was marked NIGO. Provides context for claimant communication and resubmission guidance.',
    `notes` STRING COMMENT 'Free-text notes or comments about the document. Captures examiner observations, special handling instructions, or follow-up actions.',
    `phi_flag` BOOLEAN COMMENT 'Indicates whether the document contains Protected Health Information subject to HIPAA regulations. True if PHI is present.',
    `pii_flag` BOOLEAN COMMENT 'Indicates whether the document contains Personally Identifiable Information. True if PII is present, requiring enhanced data protection measures.',
    `rejection_date` DATE COMMENT 'Date the document was rejected. Triggers claimant notification and resubmission workflow.',
    `required_for_adjudication_flag` BOOLEAN COMMENT 'Indicates whether this document is mandatory for claim adjudication. True if the claim cannot be processed without this document.',
    `retention_expiration_date` DATE COMMENT 'Date after which the document may be purged or archived per retention policy. Calculated from receipt date plus retention period.',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained per regulatory and legal requirements. Drives document lifecycle and archival policies.',
    `review_date` DATE COMMENT 'Date the document was reviewed by the claims examiner or adjudicator. Tracks processing timeline and SLA compliance.',
    `submission_channel` STRING COMMENT 'Method or channel through which the document was submitted. Supports channel analytics and digital transformation tracking. [ENUM-REF-CANDIDATE: mail|fax|email|web_portal|mobile_app|agent_portal|api — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was last modified. Tracks the most recent change to any field in the record.',
    `verification_date` DATE COMMENT 'Date the document was successfully verified. Marks completion of the verification workflow.',
    `verification_required_flag` BOOLEAN COMMENT 'Indicates whether the document requires independent verification from the source. True if verification is needed before acceptance.',
    `verification_status` STRING COMMENT 'Current status of the document verification process. Tracks whether independent verification has been completed and the outcome.. Valid values are `not_required|pending|verified|failed|waived`',
    CONSTRAINT pk_claim_document PRIMARY KEY(`claim_document_id`)
) COMMENT 'Registry of all documents associated with a claim throughout its lifecycle. Tracks document type (death certificate, APS, autopsy report, police report, proof of identity, beneficiary designation form, claimant statement, medical records, court order, letters testamentary, HIPAA authorization, tax withholding forms), document receipt date, document source, document status (received, reviewed, accepted, rejected, pending), NIGO reason if rejected, document completeness checklist status, and document storage reference linking to the document management domain. Manages the document completeness requirements for adjudication readiness. SSOT for all claim-related document tracking within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claim_status_history` (
    `claim_status_history_id` BIGINT COMMENT 'Unique identifier for each claim status history record. Primary key for the immutable audit trail of claim lifecycle events.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claims.adjudication. Business justification: Status history events related to adjudication (adjudication completed, decision rendered, approval issued) should reference the specific adjudication record. This provides granular audit trail linking',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to claims.appeal. Business justification: Status history events related to appeal (appeal filed, appeal under review, appeal decision rendered) should reference the specific appeal record. This provides audit trail of appeal lifecycle events.',
    `claim_id` BIGINT COMMENT 'Foreign key reference to the parent claim record. Links this status history event to the specific claim being tracked.',
    `employee_id` BIGINT COMMENT 'System user identifier of the person or automated process that triggered this status change or activity. Supports audit trail and accountability requirements.',
    `document_id` BIGINT COMMENT 'Reference identifier linking this activity to a document in the document management system. Enables retrieval of supporting documentation for audit and dispute resolution.',
    `activity_note_text` STRING COMMENT 'Free-form text note entered by the examiner or system describing the activity, decision rationale, or communication summary. Critical for claim file narrative and regulatory exam defense.',
    `activity_type` STRING COMMENT 'Type of activity or event recorded in this history entry. Distinguishes between status transitions, examiner notes, communications, diary entries, Service Level Agreement (SLA) milestones, and document receipt events.. Valid values are `status_change|examiner_note|communication|diary_entry|sla_milestone|document_received`',
    `attorney_client_privilege_flag` BOOLEAN COMMENT 'Indicates whether this activity record is protected by attorney-client privilege. Used to restrict disclosure during regulatory examinations and litigation discovery processes.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the status change or activity. Maps to internal reason code reference tables for consistent categorization.',
    `change_reason_description` STRING COMMENT 'Human-readable explanation of the reason for the status change or activity. Provides business context for audit review and dispute resolution.',
    `changed_by_role` STRING COMMENT 'Business role or job function of the user at the time of the event (e.g., Claims Examiner, Senior Adjudicator, Special Investigations Unit (SIU) Investigator, System Administrator). Supports role-based audit analysis.',
    `changed_by_user_name` STRING COMMENT 'Full name of the user who performed the status change or activity. Denormalized for audit reporting and dispute resolution without requiring user table joins.',
    `communication_channel` STRING COMMENT 'Channel through which the communication occurred (phone, email, postal mail, fax, customer portal, in-person). Supports channel effectiveness analysis and regulatory documentation requirements.. Valid values are `phone|email|mail|fax|portal|in_person`',
    `communication_party_name` STRING COMMENT 'Name of the external party involved in the communication. Supports complete claim file documentation for regulatory exams and litigation defense.',
    `communication_party_type` STRING COMMENT 'Type of external party involved in the communication (claimant, beneficiary, agent, attorney, attending physician, investigator, reinsurer, other). Enables stakeholder engagement tracking. [ENUM-REF-CANDIDATE: claimant|beneficiary|agent|attorney|physician|investigator|reinsurer|other — 8 candidates stripped; promote to reference product]',
    `communication_type` STRING COMMENT 'Direction of communication activity: inbound (received from claimant, beneficiary, agent, or third party) or outbound (sent to external party). Applicable when activity_type is communication.. Valid values are `inbound|outbound`',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether this activity record contains attorney-client privileged information or Special Investigations Unit (SIU) sensitive content. Controls access and disclosure in regulatory exams and litigation discovery.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this status history record was inserted into the data warehouse. Distinct from status_change_timestamp which reflects the business event time. Supports data lineage and Extract Transform Load (ETL) auditing.',
    `diary_completed_flag` BOOLEAN COMMENT 'Indicates whether the diary entry has been completed or resolved. False indicates an open diary item requiring follow-up action.',
    `diary_due_date` DATE COMMENT 'Follow-up date for diary entries. Indicates when the examiner should review the claim for pending items or next actions. Supports workflow management and Service Level Agreement (SLA) tracking.',
    `document_type` STRING COMMENT 'Type of document received or generated (e.g., Attending Physician Statement (APS), death certificate, beneficiary identification, investigative report). Applicable when activity_type is document_received.',
    `event_sequence_number` STRING COMMENT 'Sequential ordering of status change and activity events within a claim lifecycle. Enables chronological reconstruction of claim history.',
    `new_status` STRING COMMENT 'The claim status after this event. For non-status-change activities, this field contains the current status at the time of the activity. Supports state-at-time queries.',
    `prior_status` STRING COMMENT 'The claim status immediately before this event. Null for the initial claim submission event. Enables tracking of status transitions and workflow progression.',
    `siu_sensitive_flag` BOOLEAN COMMENT 'Indicates whether this activity is part of a fraud investigation by the Special Investigations Unit (SIU). Restricts access to authorized fraud investigators and legal counsel.',
    `sla_actual_date` DATE COMMENT 'Actual date when this Service Level Agreement (SLA) milestone was completed. Compared against target date to measure compliance and identify process bottlenecks.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether this Service Level Agreement (SLA) milestone was met within the target timeframe. False indicates a breach of service level commitments or regulatory prompt payment requirements.',
    `sla_milestone_type` STRING COMMENT 'Type of Service Level Agreement (SLA) milestone reached (e.g., initial contact, acknowledgment sent, decision rendered, payment issued). Supports compliance tracking for state prompt payment laws.',
    `sla_target_date` DATE COMMENT 'Target date by which this Service Level Agreement (SLA) milestone should be completed. Used to calculate compliance with state Department of Insurance (DOI) prompt payment requirements (typically 30-day adjudication windows).',
    `source_system` STRING COMMENT 'Name of the operational system that created this status history record (e.g., Guidewire ClaimCenter, Majesco Claims). Supports data lineage tracking in multi-system environments.',
    `source_transaction_reference` STRING COMMENT 'Unique transaction identifier from the source operational system. Enables traceability back to the originating system for reconciliation and troubleshooting.',
    `status_change_date` DATE COMMENT 'Calendar date of the status change or activity event. Supports day-level reporting and aggregation for state Department of Insurance (DOI) regulatory reporting.',
    `status_change_timestamp` TIMESTAMP COMMENT 'Precise date and time when the status change or activity event occurred. Critical for Service Level Agreement (SLA) compliance monitoring and regulatory prompt payment law tracking.',
    `system_generated_flag` BOOLEAN COMMENT 'Indicates whether this activity was automatically generated by the claims system (e.g., automated Service Level Agreement (SLA) milestone tracking, workflow triggers) versus manually entered by a user.',
    CONSTRAINT pk_claim_status_history PRIMARY KEY(`claim_status_history_id`)
) COMMENT 'Immutable audit trail of every status transition and significant activity event for a claim throughout its lifecycle. Records status change events (submitted, under review, pended, investigation, approved, denied, payment issued, closed, reopened), prior and new status, change timestamp, changed-by user ID, change reason code, activity type (status change, examiner note, communication, diary entry, SLA milestone), note text for activity entries, confidentiality flag (attorney-client privilege, SIU sensitive), and associated references. Enables SLA compliance monitoring, regulatory reporting of claim processing timelines, dispute resolution, and complete claim file narrative for audits. Supports state DOI prompt payment law compliance tracking (typically 30-day adjudication windows). SSOT for claim lifecycle audit trail, activity log, and examiner notes within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for the claim appeal record. Primary key.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claims.adjudication. Business justification: Appeal should reference the specific adjudication being appealed. Currently appeal has claim_id but not the specific adjudication_id. A claim may have multiple adjudications (initial, reconsideration)',
    `claim_id` BIGINT COMMENT 'Reference to the underlying claim that is being appealed.',
    `claimant_id` BIGINT COMMENT 'Reference to the claimant who filed the appeal.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to review this appeal',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: Market conduct exam findings often identify improper claim denials, triggering appeals. Insurance operations track which appeals resulted from exam findings for remediation tracking and regulatory rep',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy under which the appealed claim was filed.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Appeal reviews require product plan specifications to evaluate whether original adjudication correctly applied policy provisions, benefit calculations, and settlement options. Essential for appeal dec',
    `additional_evidence_description` STRING COMMENT 'Summary of the new evidence or documentation submitted by the claimant during the appeal process.',
    `additional_evidence_received_date` DATE COMMENT 'Date on which additional evidence was received and logged by the insurer or reviewing body.',
    `additional_evidence_submitted_flag` BOOLEAN COMMENT 'Indicates whether the claimant submitted new or additional evidence (medical records, financial documents, witness statements) in support of the appeal.',
    `appeal_number` STRING COMMENT 'Business-facing unique reference number assigned to the appeal for tracking and correspondence.',
    `appeal_status` STRING COMMENT 'Current lifecycle status of the appeal: filed, under review, pending additional evidence, decision rendered, closed, withdrawn, or escalated to higher authority. [ENUM-REF-CANDIDATE: filed|under_review|pending_evidence|decision_rendered|closed|withdrawn|escalated — 7 candidates stripped; promote to reference product]',
    `appeal_type` STRING COMMENT 'Classification of the appeal mechanism: internal administrative review, external independent review, Department of Insurance (DOI) complaint, litigation, arbitration, or mediation.. Valid values are `internal_administrative_review|external_independent_review|doi_complaint|litigation|arbitration|mediation`',
    `arbitration_case_number` STRING COMMENT 'Reference number assigned by the arbitration body or forum.',
    `arbitration_filed_flag` BOOLEAN COMMENT 'Indicates whether the claimant has initiated binding arbitration proceedings as an alternative dispute resolution mechanism.',
    `arbitration_filing_date` DATE COMMENT 'Date on which the arbitration claim was filed.',
    `assignment_date` DATE COMMENT 'The date on which this employee was formally assigned to the appeal review committee. Used to track committee formation timeline and workload distribution.',
    `basis` STRING COMMENT 'Claimants stated reason or grounds for contesting the original claim decision, including factual, legal, or procedural objections.',
    `claimant_representative_contact` STRING COMMENT 'Contact phone number or email address for the claimants representative.',
    `claimant_representative_name` STRING COMMENT 'Name of the attorney, advocate, or authorized representative acting on behalf of the claimant in the appeal process.',
    `closure_date` DATE COMMENT 'Date on which the appeal was formally closed, either after decision communication, withdrawal, or exhaustion of all remedies.',
    `committee_position` STRING COMMENT 'The formal position held by this employee on the appeal review committee. Determines decision-making authority and procedural responsibilities.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the appeal record was first created in the claims management system.',
    `deadline_date` DATE COMMENT 'Regulatory or contractual deadline by which the appeal decision must be rendered to remain compliant with state DOI or ERISA timelines.',
    `decision` STRING COMMENT 'Final outcome of the appeal: upheld (original decision stands), overturned (claim approved), modified (partial adjustment), remanded (sent back for re-review), or withdrawn by claimant.. Valid values are `upheld|overturned|modified|remanded|withdrawn`',
    `decision_date` DATE COMMENT 'Date on which the final appeal decision was rendered and communicated to the claimant.',
    `decision_rationale` STRING COMMENT 'Detailed explanation and justification for the appeal decision, including reference to policy terms, evidence reviewed, and regulatory standards applied.',
    `doi_complaint_filed_flag` BOOLEAN COMMENT 'Indicates whether the claimant filed a formal complaint with the state Department of Insurance regarding the claim or appeal.',
    `doi_complaint_filing_date` DATE COMMENT 'Date on which the claimant filed the complaint with the state Department of Insurance.',
    `doi_complaint_number` STRING COMMENT 'Reference number assigned by the state DOI to the complaint filed by the claimant.',
    `exhaustion_status` STRING COMMENT 'Indicates whether the claimant has exhausted all internal and external appeal remedies as required before pursuing litigation or regulatory complaint.. Valid values are `not_exhausted|exhausted|external_review_available|litigation_pending`',
    `filing_date` DATE COMMENT 'Date on which the claimant formally filed the appeal with the insurer or regulatory body.',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the appeal was received and logged into the system, used for regulatory timeline compliance.',
    `hours_spent` DECIMAL(18,2) COMMENT 'The number of hours this employee spent reviewing the appeal case, evidence, and documentation. Used for workload tracking and cost allocation.',
    `litigation_case_number` STRING COMMENT 'Court-assigned case number for the lawsuit filed by the claimant.',
    `litigation_filed_flag` BOOLEAN COMMENT 'Indicates whether the claimant has initiated legal proceedings (lawsuit) against the insurer related to the claim or appeal.',
    `litigation_filing_date` DATE COMMENT 'Date on which the lawsuit was filed in court.',
    `notes` STRING COMMENT 'Free-text field for internal notes, observations, and case management details related to the appeal process.',
    `recusal_flag` BOOLEAN COMMENT 'Indicates whether this employee recused themselves from the appeal review due to conflict of interest, prior involvement in the claim, or other ethical considerations. Critical for regulatory compliance and audit defense.',
    `recusal_reason` STRING COMMENT 'Documented explanation for why the employee recused themselves from this appeal review. Required for compliance and governance audit trail when recusal_flag is true.',
    `review_completion_date` DATE COMMENT 'Date on which the appeal review was completed and a decision was reached.',
    `review_date` DATE COMMENT 'The date on which this employee conducted their review of the appeal. Used for regulatory timeline compliance and audit trail.',
    `review_role` STRING COMMENT 'The specific role or capacity in which this employee is participating in the appeal review committee. Determines voting authority and area of expertise contribution.',
    `review_start_date` DATE COMMENT 'Date on which the formal review of the appeal commenced.',
    `reviewing_committee_name` STRING COMMENT 'Name of the internal committee or external independent review organization (IRO) responsible for the appeal decision.',
    `revised_claim_amount_approved` DECIMAL(18,2) COMMENT 'Updated claim benefit amount approved as a result of the appeal decision, if the appeal was overturned or modified.',
    `revised_claim_amount_paid` DECIMAL(18,2) COMMENT 'Actual additional payment disbursed to the claimant following a successful appeal.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the appeal record was last modified, supporting audit trail and data lineage requirements.',
    `vote_outcome` STRING COMMENT 'This committee members individual vote on the appeal decision. Captured for regulatory compliance and internal governance audit trail.',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Tracks the formal appeal process when a claimant contests a claim denial or partial payment decision. Captures appeal type (internal administrative review, external independent review, DOI complaint, litigation, arbitration), appeal filing date, appeal deadline, appeal basis stated by claimant, additional evidence submitted, reviewing examiner or committee, appeal decision, appeal decision date, outcome (upheld, overturned, modified), and appeal exhaustion status. Manages the regulatory appeal timelines mandated by state DOI regulations and ERISA for group products. Feeds compliance domain for DOI complaint reporting. SSOT for all claim appeal and dispute resolution activity within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` (
    `unclaimed_property_id` BIGINT COMMENT 'Unique identifier for the unclaimed property record. Primary key for tracking life insurance claim proceeds and matured benefits that cannot be disbursed due to lost beneficiary contact or unlocated beneficiaries.',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: Due diligence process for unclaimed property requires linking beneficiary to party master for address updates, contact attempts, and state escheatment filing. Removes denormalized beneficiary name fie',
    `claim_id` BIGINT COMMENT 'Reference to the associated claim record if the unclaimed property originated from a death benefit or other claim settlement that could not be disbursed.',
    `claim_payment_id` BIGINT COMMENT 'Foreign key linking to claims.claim_payment. Business justification: Unclaimed property should reference the original claim_payment that was issued but returned/unclaimed. This links the escheatment record to the specific payment attempt. Business pattern: payment issu',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the underlying life insurance policy or annuity contract from which the unclaimed benefit originated.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Escheatment compliance and DMF matching require linking unclaimed property records to insured master for death verification, beneficiary search, and state reporting. Removes denormalized insured attri',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Escheatment events require GL entries to reclassify claim liabilities to unclaimed property liability accounts and record state remittances. This is a distinct accounting event mandated by state uncla',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Escheatment processing and due diligence requirements vary by product type, state approval specifications, and dormancy period rules. Product plan determines state of domicile and regulatory complianc',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Unclaimed property requires annual escheatment filings to state treasurers/comptrollers. Insurance operations must link unclaimed property records to regulatory filings for compliance tracking and aud',
    `beneficiary_address_line_1` STRING COMMENT 'Primary street address line for the last known address of the beneficiary. Used for due diligence outreach mailings per NAIC Model 695 requirements.',
    `beneficiary_address_line_2` STRING COMMENT 'Secondary street address line (apartment, suite, unit) for the last known address of the beneficiary.',
    `beneficiary_city` STRING COMMENT 'City of the last known address of the beneficiary. Used for due diligence outreach and state domicile determination.',
    `beneficiary_claim_amount` DECIMAL(18,2) COMMENT 'The dollar amount paid to the beneficiary when the unclaimed property was successfully claimed. May include interest accrued per state law.',
    `beneficiary_claim_date` DATE COMMENT 'Date when the beneficiary successfully claimed the unclaimed benefit, either directly from the insurer (before escheatment) or from the state unclaimed property fund (after escheatment).',
    `beneficiary_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the last known address of the beneficiary. Determines whether state escheatment laws apply or if international unclaimed property protocols are required.. Valid values are `USA|CAN|GBR|MEX|AUS`',
    `beneficiary_postal_code` STRING COMMENT 'Postal or ZIP code of the last known address of the beneficiary. Used for due diligence outreach mailings.',
    `beneficiary_state_province` STRING COMMENT 'State or province of the last known address of the beneficiary. Critical for determining the applicable state escheatment law and dormancy period.',
    `benefit_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of the unclaimed benefit including death benefit, account value (AV), accumulated interest, and any guaranteed minimum death benefit (GMDB) or guaranteed minimum income benefit (GMIB) amounts. Excludes interest accrued post-escheatment.',
    `closure_date` DATE COMMENT 'Date when the unclaimed property record was closed, either due to successful beneficiary claim, escheatment to state, or administrative closure (e.g., benefit amount below state minimum threshold).',
    `closure_reason` STRING COMMENT 'Reason for closing the unclaimed property record: beneficiary paid (successfully claimed), escheated to state (remitted to state fund), below threshold (amount below state minimum reporting threshold), duplicate record (consolidated with another record), or administrative error (record created in error).. Valid values are `beneficiary_paid|escheated_to_state|below_threshold|duplicate_record|administrative_error`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the unclaimed property record was first created in the system. Used for audit trail and compliance reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the benefit amount. Typically USD for US-domiciled policies.. Valid values are `USD|CAD|GBP|EUR|JPY|AUD`',
    `dmf_match_date` DATE COMMENT 'Date when the Death Master File (DMF) match was performed or confirmed. Used to establish the timeline for due diligence and escheatment eligibility.',
    `dmf_match_status` STRING COMMENT 'Result of the Death Master File (DMF) comparison to identify deceased insureds whose beneficiaries have not claimed benefits. Matched indicates a confirmed death record; no match indicates insured not found in DMF; pending indicates search in progress; manual review indicates ambiguous results requiring human verification.. Valid values are `matched|no_match|pending|manual_review`',
    `dormancy_period_years` STRING COMMENT 'Number of years of inactivity required before the property becomes eligible for escheatment, as defined by the applicable state unclaimed property law. Typically ranges from 3 to 5 years depending on jurisdiction.',
    `due_diligence_attempts_count` STRING COMMENT 'Total number of outreach attempts made to locate the beneficiary, including certified mail, phone calls, email, and database searches. NAIC Model 695 requires documented reasonable efforts.',
    `due_diligence_completed_date` DATE COMMENT 'Date when all required due diligence outreach efforts were completed, regardless of outcome. Establishes compliance with NAIC Model 695 requirements prior to escheatment.',
    `due_diligence_initiated_date` DATE COMMENT 'Date when the insurer initiated due diligence outreach efforts to locate the beneficiary, as required by NAIC Model 695. Must occur before escheatment eligibility date.',
    `due_diligence_method` STRING COMMENT 'Description of the due diligence methods employed to locate the beneficiary: certified mail, phone outreach, email, address verification services, public records search, social media search, or third-party locator services. Must meet NAIC Model 695 reasonable search standards.',
    `due_diligence_outcome` STRING COMMENT 'Result of the due diligence outreach efforts: beneficiary located (contact established), no response (outreach delivered but no reply), address invalid (mail returned), deceased beneficiary (beneficiary also deceased), or refused claim (beneficiary declined benefit).. Valid values are `beneficiary_located|no_response|address_invalid|deceased_beneficiary|refused_claim`',
    `escheatment_eligibility_date` DATE COMMENT 'Date when the unclaimed property becomes eligible for escheatment to the state unclaimed property fund, calculated as last known contact date plus the applicable state dormancy period. Triggers due diligence and reporting obligations.',
    `escheatment_filing_date` DATE COMMENT 'Date when the unclaimed property report was filed with the applicable state unclaimed property administrator. Typically occurs annually by a state-mandated deadline (e.g., November 1).',
    `escheatment_remittance_amount` DECIMAL(18,2) COMMENT 'The actual dollar amount remitted to the state unclaimed property fund. May differ from the original benefit amount due to interest accrual, administrative fees, or partial claims.',
    `escheatment_remittance_date` DATE COMMENT 'Date when the unclaimed benefit amount was remitted to the state unclaimed property fund. Typically occurs shortly after the filing date per state law.',
    `last_known_contact_date` DATE COMMENT 'Date of the last confirmed contact with the beneficiary or policyholder (premium payment, correspondence, service request, or other affirmative action). Establishes the start of the dormancy period for escheatment eligibility per state law.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, or case-specific details related to the unclaimed property record, due diligence efforts, or escheatment process.',
    `policy_number` STRING COMMENT 'The externally-known policy or contract number associated with the unclaimed benefit. Used for beneficiary outreach and state reporting.',
    `state_claim_number` STRING COMMENT 'Unique identifier assigned by the state unclaimed property administrator when the property is escheated. Used for tracking and reconciliation if the beneficiary later claims the property from the state.',
    `state_of_domicile` STRING COMMENT 'The US state or jurisdiction to which the unclaimed property must be escheated, determined by the beneficiarys last known address or, if unknown, the policyholders last known address or the state of policy issuance. Critical for determining applicable escheatment law and reporting requirements.',
    `unclaimed_property_status` STRING COMMENT 'Current lifecycle status of the unclaimed property record: identified (newly detected), due diligence (outreach in progress), escheatment eligible (dormancy period met), escheated (remitted to state), claimed (beneficiary located and paid), or closed.. Valid values are `identified|due_diligence|escheatment_eligible|escheated|claimed|closed`',
    `unclaimed_property_type` STRING COMMENT 'Classification of the type of unclaimed benefit: death benefit (DB), matured endowment, annuity proceeds, cash surrender value (CSV), uncashed check, or retained asset account balance.. Valid values are `death_benefit|matured_endowment|annuity_proceeds|cash_surrender_value|uncashed_check|retained_asset_account`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the unclaimed property record was last modified. Used for audit trail and tracking status changes throughout the due diligence and escheatment lifecycle.',
    CONSTRAINT pk_unclaimed_property PRIMARY KEY(`unclaimed_property_id`)
) COMMENT 'Tracks life insurance claim proceeds and matured benefits that cannot be disbursed due to lost beneficiary contact, unlocated beneficiaries, or uncashed checks, subject to state escheatment laws. Captures policy reference, benefit amount, last known beneficiary contact date, due diligence outreach attempts (NAIC Model 695 compliance), escheatment eligibility date, state of domicile for escheatment, escheatment filing date, remittance to state unclaimed property fund, and DMF (Death Master File) match status. Supports compliance with NAIC Model Unclaimed Life Insurance Benefits Act and state-specific dormancy periods. SSOT for all unclaimed property and escheatment tracking within the claims domain.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`siu_referral` (
    `siu_referral_id` BIGINT COMMENT 'Unique identifier for the SIU referral record. Primary key.',
    `staff_license_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_license. Business justification: SIU fraud investigations require state-specific fraud investigator licenses or CFE certification. Legal defensibility in fraud cases and admissibility of investigation findings depend on investigator ',
    `claim_id` BIGINT COMMENT 'Reference to the claim that triggered this SIU referral.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Claims SIU referrals for fraud may escalate to compliance AML cases when financial crimes (money laundering, STOLI, terrorist financing) are suspected. BSA/AML regulations require cross-functional cas',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy associated with the referred claim.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Fraud investigation procedures and rescission authority vary by product type, contestability period, underwriting class requirements, and STOLI indicators. Product plan defines investigation triggers ',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system user who initiated the SIU referral.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: SIU referrals track producer involvement for fraud pattern analysis, STOLI detection, and regulatory reporting. Business requires linking referrals to producers for producer fraud scoring, state DOI n',
    `application_id` BIGINT COMMENT 'Foreign key linking to underwriting.application. Business justification: SIU fraud investigations compare claim circumstances against original application data including STOLI risk scores, AML risk assessments, premium financing flags, life settlement broker involvement, a',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: SIU investigations use specialized fraud investigation vendors for complex cases requiring surveillance, background checks, or forensic analysis. Vendor tracking supports cost management, invoice vali',
    `originating_siu_referral_id` BIGINT COMMENT 'Self-referencing FK on siu_referral (originating_siu_referral_id)',
    `actual_loss_amount` DECIMAL(18,2) COMMENT 'Confirmed financial loss amount resulting from the fraudulent activity, if fraud was substantiated.',
    `assigned_investigator_name` STRING COMMENT 'Name of the SIU investigator assigned to the case.',
    `claim_denial_recommended_flag` BOOLEAN COMMENT 'Indicates whether the SIU investigation findings support a recommendation to deny the claim based on fraud.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the SIU referral record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this referral.. Valid values are `^[A-Z]{3}$`',
    `disposition` STRING COMMENT 'Final outcome determination of the SIU investigation indicating the action taken based on findings. [ENUM-REF-CANDIDATE: fraud_confirmed|fraud_not_substantiated|insufficient_evidence|claim_denied|claim_approved_with_adjustment|referred_to_law_enforcement|referred_to_doi|policy_rescinded|case_withdrawn — 9 candidates stripped; promote to reference product]',
    `disposition_date` DATE COMMENT 'Date when the final disposition decision was made and documented.',
    `estimated_loss_amount` DECIMAL(18,2) COMMENT 'Estimated financial loss to the company if the suspected fraud had not been detected, expressed in the claim currency.',
    `external_vendor_used_flag` BOOLEAN COMMENT 'Indicates whether external investigation services or vendors were engaged to support the SIU investigation.',
    `fraud_indicator_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0-100) calculated by automated fraud detection rules engine indicating likelihood of fraud.',
    `fraud_indicator_type` STRING COMMENT 'Classification of the suspected fraud type based on the nature of the fraudulent activity. [ENUM-REF-CANDIDATE: application_fraud|premium_fraud|death_claim_fraud|living_benefit_fraud|beneficiary_fraud|agent_fraud|stoli|policy_churning|material_misrepresentation|concealment — 10 candidates stripped; promote to reference product]',
    `investigation_completion_date` DATE COMMENT 'Date when the SIU investigation was concluded and findings were documented.',
    `investigation_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the SIU investigation, including internal labor, external vendor fees, and other expenses.',
    `investigation_findings` STRING COMMENT 'Comprehensive summary of the SIU investigation results, evidence collected, and conclusions reached.',
    `investigation_start_date` DATE COMMENT 'Date when the SIU formal investigation commenced.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the fraud case was referred (e.g., FBI, state police, local district attorney).',
    `law_enforcement_case_number` STRING COMMENT 'Case or docket number assigned by the law enforcement agency for tracking the criminal investigation.',
    `law_enforcement_referral_date` DATE COMMENT 'Date when the case was formally referred to law enforcement authorities.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was referred to law enforcement authorities for criminal investigation.',
    `nicb_referral_date` DATE COMMENT 'Date when the fraud case was reported to NICB.',
    `nicb_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was reported to the National Insurance Crime Bureau for industry-wide fraud tracking.',
    `policy_rescission_recommended_flag` BOOLEAN COMMENT 'Indicates whether the SIU investigation findings support a recommendation to rescind the policy due to material misrepresentation.',
    `priority_level` STRING COMMENT 'Urgency classification for the SIU investigation based on severity of fraud indicators and potential loss amount.. Valid values are `critical|high|medium|low`',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudulent party through restitution, legal action, or other means.',
    `referral_date` DATE COMMENT 'Date when the claim was referred to the Special Investigations Unit for fraud investigation.',
    `referral_number` STRING COMMENT 'Business identifier for the SIU referral, used for tracking and external communication.',
    `referral_reason_code` STRING COMMENT 'Standardized code representing the primary reason for SIU referral (e.g., material misrepresentation, suspicious death circumstances, premium fraud).',
    `referral_reason_description` STRING COMMENT 'Detailed narrative explanation of the fraud indicators and circumstances that triggered the SIU referral.',
    `referral_source` STRING COMMENT 'Origin or channel through which the fraud suspicion was identified and referred to SIU. [ENUM-REF-CANDIDATE: claims_examiner|underwriter|automated_rules_engine|external_tip|mib_alert|nicb_alert|agent_report|customer_complaint|law_enforcement|state_doi — 10 candidates stripped; promote to reference product]',
    `referral_status` STRING COMMENT 'Current lifecycle status of the SIU referral case.. Valid values are `open|under_investigation|closed|referred_to_law_enforcement|referred_to_doi|withdrawn`',
    `referral_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the SIU referral was created in the system.',
    `referring_user_name` STRING COMMENT 'Name of the employee or system user who initiated the SIU referral.',
    `state_doi_case_number` STRING COMMENT 'Case number assigned by the state DOI fraud bureau for tracking the regulatory investigation.',
    `state_doi_referral_date` DATE COMMENT 'Date when the fraud case was reported to the state DOI fraud bureau.',
    `state_doi_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was reported to the state Department of Insurance fraud bureau.',
    `stoli_indicator_flag` BOOLEAN COMMENT 'Indicates whether the investigation identified indicators of stranger-originated life insurance arrangements.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the SIU referral record was last modified.',
    CONSTRAINT pk_siu_referral PRIMARY KEY(`siu_referral_id`)
) COMMENT 'Tracks Special Investigations Unit (SIU) referrals for claims suspected of fraud, misrepresentation, or material non-disclosure. Captures referral reason, investigation findings, and disposition.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`subrogation` (
    `subrogation_id` BIGINT COMMENT 'Unique identifier for the subrogation case.',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim for which subrogation is being pursued.',
    `claim_payment_id` BIGINT COMMENT 'Foreign key linking to claims.claim_payment. Business justification: Subrogation should reference the specific claim_payment being recovered. Currently subrogation has claim_id but not the specific payment. A claim may have multiple payments, and subrogation targets th',
    `employee_id` BIGINT COMMENT 'Identifier of the claims examiner responsible for managing the subrogation case.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy under which the claim and subrogation occurred.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Subrogation recoveries generate distinct accounting entries for recovery income recognition, receivable establishment, and reserve adjustments. These are separate GL events from original claim payment',
    `related_subrogation_id` BIGINT COMMENT 'Self-referencing FK on subrogation (related_subrogation_id)',
    `abandonment_reason_code` STRING COMMENT 'Code indicating the reason why the subrogation case was abandoned without recovery.. Valid values are `cost_prohibitive|insufficient_evidence|third_party_insolvent|statute_expired|other`',
    `abandonment_reason_description` STRING COMMENT 'Detailed explanation of why the subrogation case was abandoned.',
    `assigned_attorney_name` STRING COMMENT 'Name of the attorney or law firm handling the subrogation case.',
    `case_number` STRING COMMENT 'Official case number assigned by the court for the subrogation litigation.',
    `closure_date` DATE COMMENT 'Date when the subrogation case was formally closed, either through recovery, settlement, or abandonment.',
    `court_name` STRING COMMENT 'Name and jurisdiction of the court where litigation was filed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subrogation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this subrogation case.. Valid values are `^[A-Z]{3}$`',
    `demand_amount` DECIMAL(18,2) COMMENT 'Amount formally demanded from the third party in the demand letter.',
    `demand_letter_sent_date` DATE COMMENT 'Date when the formal demand letter for recovery was sent to the responsible third party or their insurer.',
    `initiation_date` DATE COMMENT 'Date when the subrogation case was formally opened and investigation began.',
    `judgment_amount` DECIMAL(18,2) COMMENT 'Amount awarded by the court in favor of the insurer in the subrogation case.',
    `judgment_date` DATE COMMENT 'Date when the court issued a final judgment in the subrogation case.',
    `liability_determination_date` DATE COMMENT 'Date when the third partys liability was formally established or acknowledged.',
    `litigation_filing_date` DATE COMMENT 'Date when legal action was formally filed in court.',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether legal proceedings have been initiated to pursue the subrogation claim.',
    `net_recovery_amount` DECIMAL(18,2) COMMENT 'Net amount recovered after deducting recovery expenses from the gross recovered amount.',
    `notes` STRING COMMENT 'Free-form text field for examiner notes, case updates, and additional context regarding the subrogation action.',
    `recoverable_amount` DECIMAL(18,2) COMMENT 'Estimated or actual amount that the insurer seeks to recover from the responsible third party.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Actual amount successfully recovered from the third party through settlement or judgment.',
    `recovery_expenses` DECIMAL(18,2) COMMENT 'Total expenses incurred in pursuing the subrogation action, including legal fees, investigation costs, and court costs.',
    `reinsurance_participation_flag` BOOLEAN COMMENT 'Indicates whether reinsurers have a participation interest in the subrogation recovery.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'Portion of the subrogation recovery that is ceded to reinsurers under treaty terms.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Agreed-upon settlement amount to be paid by the third party.',
    `settlement_date` DATE COMMENT 'Date when a settlement agreement was reached with the third party.',
    `statute_of_limitations_date` DATE COMMENT 'Date by which legal action must be initiated to preserve subrogation rights under applicable law.',
    `subrogation_number` STRING COMMENT 'Business-facing unique identifier for the subrogation case, used for tracking and reporting.',
    `subrogation_status` STRING COMMENT 'Current lifecycle status of the subrogation case. [ENUM-REF-CANDIDATE: initiated|investigation|demand_sent|negotiation|litigation|settled|closed|abandoned — 8 candidates stripped; promote to reference product]',
    `subrogation_type` STRING COMMENT 'Classification of the subrogation action based on the nature of the third-party liability.. Valid values are `third_party_liability|product_liability|medical_malpractice|auto_accident|workers_compensation|other`',
    `third_party_contact_info` STRING COMMENT 'Contact details for the responsible third party, including address, phone, and email.',
    `third_party_insurer_name` STRING COMMENT 'Name of the insurance carrier representing the responsible third party, if applicable.',
    `third_party_name` STRING COMMENT 'Name of the responsible third party from whom recovery is being sought.',
    `third_party_policy_number` STRING COMMENT 'Policy number of the third partys insurance coverage, if known.',
    `third_party_type` STRING COMMENT 'Classification of the responsible third party entity type.. Valid values are `individual|corporation|government_entity|medical_provider|manufacturer|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the subrogation record was last modified.',
    CONSTRAINT pk_subrogation PRIMARY KEY(`subrogation_id`)
) COMMENT 'Manages subrogation and recovery actions where the insurer seeks to recover claim payments from responsible third parties. Captures subrogation type, recovery amount, third-party details, and legal proceedings.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`interpleader` (
    `interpleader_id` BIGINT COMMENT 'Unique identifier for the interpleader action record.',
    `claim_id` BIGINT COMMENT 'Reference to the underlying death benefit claim that triggered the interpleader action.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy for which multiple parties are claiming death benefit proceeds.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Interpleader proceedings require product plan specifications for beneficiary designation rules, settlement options, trust provisions, and minor beneficiary handling. Product plan defines legal framewo',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: Court interpleader filings require formal party identification for competing claimants to verify legal standing, insurable interest, and beneficiary designation conflicts. Links primary claimant to pa',
    `consolidated_interpleader_id` BIGINT COMMENT 'Self-referencing FK on interpleader (consolidated_interpleader_id)',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether any party filed an appeal of the courts decision in the interpleader action.',
    `appeal_filing_date` DATE COMMENT 'Date on which an appeal of the interpleader decision was filed with the appellate court.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Amount of death benefit proceeds awarded to the prevailing claimant per the courts final order.',
    `awarded_claimant_name` STRING COMMENT 'Full legal name of the claimant to whom the court awarded all or a portion of the death benefit proceeds.',
    `beneficiary_designation_conflict_flag` BOOLEAN COMMENT 'Indicates whether the dispute arises from conflicting or ambiguous beneficiary designations on the policy.',
    `case_number` STRING COMMENT 'Official docket or case number assigned by the court to the interpleader action.',
    `closure_date` DATE COMMENT 'Date on which the interpleader action was fully closed and all administrative tasks completed.',
    `company_counsel_contact` STRING COMMENT 'Contact phone number or email for the companys legal counsel handling the interpleader case.',
    `company_counsel_name` STRING COMMENT 'Name of the attorney or law firm representing the insurance company in the interpleader action.',
    `competing_claimants_count` STRING COMMENT 'Total number of parties asserting entitlement to the death benefit proceeds, triggering the interpleader action.',
    `court_district` STRING COMMENT 'Geographic district or circuit designation of the court handling the interpleader case.',
    `court_jurisdiction` STRING COMMENT 'Type of court jurisdiction where the interpleader action was filed, either federal or state court system.. Valid values are `federal|state`',
    `court_name` STRING COMMENT 'Full legal name of the court where the interpleader action was filed.',
    `court_order_reference` STRING COMMENT 'Reference number or citation for the final court order directing distribution of the death benefit proceeds.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this interpleader record was first created in the claims management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed death benefit amount.. Valid values are `USD|CAD|EUR|GBP|AUD`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Actual amount deposited with the court, which may differ from the disputed amount due to legal fees or interest adjustments.',
    `deposit_into_court_date` DATE COMMENT 'Date on which the insurance company deposited the disputed death benefit amount with the court registry.',
    `discharge_from_liability_date` DATE COMMENT 'Date on which the court formally discharged the insurance company from further liability regarding the disputed proceeds.',
    `dispute_basis` STRING COMMENT 'Detailed description of the legal or factual basis for the competing claims that necessitated the interpleader action.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total death benefit amount in dispute that is subject to the interpleader action and will be distributed per court order.',
    `divorce_decree_involved_flag` BOOLEAN COMMENT 'Indicates whether a divorce decree or marital settlement agreement is a factor in the competing claims.',
    `estate_claim_flag` BOOLEAN COMMENT 'Indicates whether one or more claimants represent the estate of the deceased insured.',
    `filing_date` DATE COMMENT 'Date on which the insurance company filed the interpleader action with the court.',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the interpleader action was officially filed with the court system.',
    `interpleader_number` STRING COMMENT 'Business-facing unique case number assigned to the interpleader action for tracking and reference purposes.',
    `interpleader_status` STRING COMMENT 'Current lifecycle status of the interpleader action indicating its progression through the legal process.. Valid values are `pending|filed|active|resolved|dismissed|withdrawn`',
    `judge_name` STRING COMMENT 'Name of the judge assigned to preside over the interpleader case.',
    `legal_fees_incurred` DECIMAL(18,2) COMMENT 'Total legal fees and court costs incurred by the insurance company in prosecuting the interpleader action.',
    `minor_beneficiary_flag` BOOLEAN COMMENT 'Indicates whether one or more claimants are minors requiring guardian or court-appointed representation.',
    `notes` STRING COMMENT 'Free-form text field for recording additional details, observations, or special circumstances related to the interpleader action.',
    `primary_claimant_relationship` STRING COMMENT 'Relationship of the primary claimant to the deceased insured, establishing their basis for claiming proceeds.',
    `resolution_date` DATE COMMENT 'Date on which the court issued a final order resolving the competing claims and directing distribution of proceeds.',
    `resolution_method` STRING COMMENT 'Method by which the interpleader action was resolved, such as court judgment, settlement agreement, or voluntary withdrawal.. Valid values are `court_order|settlement|dismissal|withdrawal`',
    `secondary_claimant_name` STRING COMMENT 'Full legal name of the second competing claimant in the interpleader action.',
    `secondary_claimant_relationship` STRING COMMENT 'Relationship of the secondary claimant to the deceased insured, establishing their basis for claiming proceeds.',
    `trust_involved_flag` BOOLEAN COMMENT 'Indicates whether a trust entity is one of the competing claimants for the death benefit proceeds.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this interpleader record was last modified in the claims management system.',
    CONSTRAINT pk_interpleader PRIMARY KEY(`interpleader_id`)
) COMMENT 'Tracks interpleader actions filed when multiple parties claim entitlement to the same death benefit proceeds. Captures competing claimants, court filing details, and resolution status.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`contestability_review` (
    `contestability_review_id` BIGINT COMMENT 'Unique identifier for the contestability review record. Primary key.',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Contestability reviews for annuity death claims examine application misrepresentation, issue date, and contestability period per contract. Required for rescission decisions and regulatory compliance (',
    `claim_id` BIGINT COMMENT 'Reference to the parent claim being reviewed under contestability provisions.',
    `exam_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.exam_finding. Business justification: Market conduct exams scrutinize contestability practices (rescission rates, material misrepresentation standards). Exam findings on contestability issues link to specific contestability reviews for re',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy contract under contestability review.',
    `staff_license_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_license. Business justification: State insurance laws require licensed physicians to review medical evidence in contestability cases. Tracking the specific medical license used ensures legal defensibility of rescission decisions and ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Contestability reviews require Attending Physician Statements and medical records, typically obtained through specialized medical record retrieval vendors (ExamOne, EMSI). Vendor tracking enables invo',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Contestability reviews reference mortality tables to assess impact of material misrepresentation on underwriting class and pricing. Used to calculate premium refund amounts and reserve adjustments whe',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Contestability reviews require product plan specifications for contestability period duration, underwriting requirements, material misrepresentation standards, and rescission procedures. Determines re',
    `employee_id` BIGINT COMMENT 'Reference to the claims examiner or special investigator assigned to conduct the contestability review.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Contestability reviews examine producer conduct during sale, training records, and application submission patterns. Material misrepresentation investigations require linking to producer for regulatory',
    `tertiary_contestability_medical_director_employee_id` BIGINT COMMENT 'Reference to the medical director who provided clinical opinion on the contestability case.',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Contestability reviews evaluate whether misrepresentation impacted underwriting decision. Reviewers need access to complete risk assessment including medical risk classification, APS review outcomes, ',
    `application_id` BIGINT COMMENT 'Foreign key linking to underwriting.application. Business justification: Contestability reviews are the core business process comparing claim facts against original application question responses, disclosed medical conditions, and applicant statements. Rescission decisions',
    `reopened_contestability_review_id` BIGINT COMMENT 'Self-referencing FK on contestability_review (reopened_contestability_review_id)',
    `actual_fact_discovered` STRING COMMENT 'The true fact or condition discovered during investigation that contradicts the applicant response.',
    `appeal_deadline_date` DATE COMMENT 'Final date by which the beneficiary may file an appeal of the contestability review decision.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the beneficiary or policyholder has filed an appeal of the rescission decision.',
    `applicant_response` STRING COMMENT 'The answer provided by the applicant on the insurance application that is under contestability review.',
    `application_question_number` STRING COMMENT 'Reference to the specific question number on the insurance application where misrepresentation occurred.',
    `aps_reviewed_flag` BOOLEAN COMMENT 'Indicates whether attending physician statements were obtained and reviewed as part of the contestability investigation.',
    `beneficiary_notification_date` DATE COMMENT 'Date when the beneficiary or claimant was formally notified of the contestability review outcome and rescission decision.',
    `claim_denial_amount` DECIMAL(18,2) COMMENT 'Death benefit or claim amount that is being denied as a result of the rescission decision.',
    `contestability_period_days` STRING COMMENT 'Number of days elapsed between policy issue date and date of loss, used to confirm contestability eligibility (typically within 730 days).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the contestability review record was first created in the claims management system.',
    `date_of_loss` DATE COMMENT 'Date of the insured event (death or disability) that triggered the claim under review.',
    `evidence_source` STRING COMMENT 'Primary source of evidence that substantiated the material misrepresentation finding. [ENUM-REF-CANDIDATE: aps|mib|prescription_database|dmv_records|criminal_records|financial_records|social_media|witness_statement|other — 9 candidates stripped; promote to reference product]',
    `legal_review_date` DATE COMMENT 'Date when legal counsel completed their review of the contestability case.',
    `legal_review_required_flag` BOOLEAN COMMENT 'Indicates whether the contestability case requires review and approval by the legal department before final decision.',
    `material_misrepresentation_found_flag` BOOLEAN COMMENT 'Indicates whether the investigation identified material misrepresentation or concealment of facts in the application that would have affected underwriting.',
    `medical_director_review_flag` BOOLEAN COMMENT 'Indicates whether the case was escalated to the medical director for clinical assessment of the misrepresentation materiality.',
    `mib_check_performed_flag` BOOLEAN COMMENT 'Indicates whether a Medical Information Bureau database check was conducted during the review.',
    `mib_discrepancy_found_flag` BOOLEAN COMMENT 'Indicates whether the MIB check revealed information inconsistent with the application.',
    `misrepresentation_category` STRING COMMENT 'Classification of the type of material misrepresentation discovered during the contestability review. [ENUM-REF-CANDIDATE: medical_history|tobacco_use|occupation|hazardous_activities|financial_information|criminal_history|other_insurance|none — 8 candidates stripped; promote to reference product]',
    `misrepresentation_description` STRING COMMENT 'Detailed narrative describing the specific facts, omissions, or false statements identified as material misrepresentation.',
    `policy_issue_date` DATE COMMENT 'Original issue date of the policy, used to determine if claim falls within the two-year contestability period.',
    `premium_refund_amount` DECIMAL(18,2) COMMENT 'Total amount of premiums paid that will be refunded to the policyholder or estate if rescission is approved.',
    `premium_refund_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the premium refund amount.. Valid values are `USD|CAD|GBP|EUR`',
    `rescission_decision` STRING COMMENT 'Final decision rendered by the company regarding policy rescission following contestability review.. Valid values are `rescission_approved|rescission_denied|partial_rescission|claim_adjustment|pending`',
    `rescission_effective_date` DATE COMMENT 'Date from which the policy is deemed void ab initio (from the beginning) if rescission is approved, typically the original policy issue date.',
    `rescission_recommended_flag` BOOLEAN COMMENT 'Indicates whether the investigator recommends rescinding the policy contract based on material misrepresentation findings.',
    `review_completed_date` DATE COMMENT 'Date when the contestability review was finalized and a decision was rendered.',
    `review_initiated_date` DATE COMMENT 'Date when the contestability review was formally opened and investigation began.',
    `review_notes` STRING COMMENT 'Free-form text field capturing investigator notes, findings summary, and key decision rationale for the contestability review.',
    `review_number` STRING COMMENT 'Business identifier for the contestability review case, used for tracking and reference.',
    `review_status` STRING COMMENT 'Current lifecycle status of the contestability review process. [ENUM-REF-CANDIDATE: initiated|in_progress|pending_legal_review|pending_medical_review|completed|rescission_approved|rescission_denied|closed — 8 candidates stripped; promote to reference product]',
    `review_trigger_reason` STRING COMMENT 'Primary reason or business rule that triggered the contestability review investigation. [ENUM-REF-CANDIDATE: automatic_contestability|fraud_indicator|mib_discrepancy|aps_discrepancy|underwriting_red_flag|siu_referral|large_claim_amount|early_death — 8 candidates stripped; promote to reference product]',
    `state_doi_notification_date` DATE COMMENT 'Date when the state insurance department was notified of the rescission decision.',
    `state_doi_notification_required_flag` BOOLEAN COMMENT 'Indicates whether state insurance department notification is required for this rescission action per regulatory requirements.',
    `underwriting_decision_impact` STRING COMMENT 'Assessment of how the discovered misrepresentation would have affected the original underwriting decision had the true facts been known.. Valid values are `would_have_declined|would_have_rated|would_have_excluded_condition|would_have_required_higher_premium|no_impact`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the contestability review record was last modified, used for audit trail and data lineage.',
    `within_contestability_flag` BOOLEAN COMMENT 'Indicates whether the claim occurred within the statutory two-year contestability period from policy issue date.',
    CONSTRAINT pk_contestability_review PRIMARY KEY(`contestability_review_id`)
) COMMENT 'Tracks contestability period reviews for claims filed within the two-year contestability period. Captures material misrepresentation findings, rescission decisions, and premium refund calculations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`claims_cession` (
    `claims_cession_id` BIGINT COMMENT 'Primary key for claims_cession',
    `reinsurance_cession_id` BIGINT COMMENT 'Unique surrogate identifier for this specific cession record. Primary key for the cession association.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to the claim whose risk is being ceded under this treaty',
    `reinsurance_treaty_id` BIGINT COMMENT 'Foreign key linking to the reinsurance treaty under which this claim risk is ceded',
    `ceded_amount` DECIMAL(18,2) COMMENT 'Total face amount or Net Amount at Risk (NAR) ceded to the reinsurer for this claim under this treaty. Calculated based on cession percentage and claim amount. Identified in detection phase as relationship data.',
    `cession_status` STRING COMMENT 'Current lifecycle status of this cession record: pending (awaiting reinsurer acknowledgment), active (in force), settled (reinsurer has paid recovery), disputed (disagreement on terms or amount), cancelled (cession reversed). Identified in detection phase as relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this cession record was created in the reinsurance system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this cession record (ceded_amount, recoverable_amount). Must align with treaty_currency from the treaty.',
    `effective_date` DATE COMMENT 'Date on which this specific cession became effective and the risk transfer to the reinsurer commenced for this claim under this treaty. Identified in detection phase as relationship data.',
    `notification_date` DATE COMMENT 'Date on which the ceding company notified the reinsurer of this claim cession under this treaty. Required for treaty compliance and recovery timing.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage of the claim risk ceded to the reinsurer under this treaty. Represents the proportional share of risk transferred for this specific claim-treaty combination. Identified in detection phase as relationship data.',
    `recoverable_amount` DECIMAL(18,2) COMMENT 'Amount expected to be recovered from the reinsurer for this specific claim under this specific treaty. May differ from ceded_amount based on treaty terms, allowances, and claim adjudication. Identified in detection phase as relationship data.',
    `recovery_amount_received` DECIMAL(18,2) COMMENT 'Actual amount received from the reinsurer for this cession. May differ from recoverable_amount due to disputes, adjustments, or treaty allowances.',
    `recovery_received_date` DATE COMMENT 'Date on which the reinsurer paid the recoverable amount to the ceding company for this cession. Null if recovery is pending or disputed.',
    `reinsurance_recoverable_amount` DECIMAL(18,2) COMMENT 'Amount expected to be recovered from reinsurers under ceded reinsurance treaties for this claim. [Moved from claim: This attribute in the claim product represents the TOTAL recoverable amount across ALL treaties. The per-treaty recoverable amount belongs in the cession association as recoverable_amount. The claim-level attribute should be derived as SUM(cession.recoverable_amount) for all cessions of that claim.]',
    `reinsurer_claim_number` STRING COMMENT 'External claim reference number assigned by the reinsurer for tracking this cession. Used in correspondence and recovery processing with the reinsurer.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this cession record was last modified.',
    CONSTRAINT pk_claims_cession PRIMARY KEY(`claims_cession_id`)
) COMMENT 'This association product represents the operational cession of claim risk from the ceding company to one or more reinsurers under specific treaty terms. It captures the financial and contractual relationship between a specific claim and a specific treaty, including the portion of risk ceded, amounts recoverable, and cession status. Each record links one claim to one treaty with attributes that exist only in the context of this specific risk transfer transaction.. Existence Justification: In life insurance reinsurance operations, a single claim can be ceded to multiple reinsurance treaties simultaneously based on layered reinsurance structures, product line coverage, and retention limits. For example, a $5M death benefit claim may have $1M retained, $2M ceded to Treaty A (base coverage), $1M ceded to Treaty B (rider coverage), and $1M ceded to Treaty C (excess of loss). Conversely, each treaty covers thousands of claims over its lifetime. The business actively manages each cession as a distinct operational record with specific amounts, percentages, statuses, and recovery tracking.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` (
    `investigation_assignment_id` BIGINT COMMENT 'Unique identifier for this investigation assignment record. Primary key for the association.',
    `claim_investigation_id` BIGINT COMMENT 'Foreign key linking to the claim investigation being staffed. Each assignment record associates one investigation with one employee in a specific role.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the investigation. Each assignment record captures one employees participation in one investigation.',
    `assignment_date` DATE COMMENT 'Date this employee was assigned to this investigation in this role. Explicitly identified in detection reasoning as relationship data. Used for workload tracking and investigation timeline analysis.',
    `assignment_end_date` DATE COMMENT 'Date this employees assignment to this investigation ended (investigation closed, role transferred, employee reassigned). Null for active assignments. Supports historical tracking of investigation team changes.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this assignment. Tracks whether the employee is actively working this investigation, temporarily on hold, completed their portion, or was reassigned.',
    `hours_actual` DECIMAL(18,2) COMMENT 'Actual hours this employee worked on this investigation. Used for cost tracking, variance analysis, and workload management. Compared against hours_allocated for budget control.',
    `hours_allocated` DECIMAL(18,2) COMMENT 'Total hours allocated or budgeted for this employees work on this investigation. Explicitly identified in detection reasoning as relationship data. Used for cost allocation and capacity planning.',
    `investigation_phase` STRING COMMENT 'The phase of the investigation lifecycle for which this employee has primary responsibility. Explicitly identified in detection reasoning as relationship data. Supports phase-based workload and timeline tracking.',
    `investigation_role` STRING COMMENT 'The specific role this employee performs in this investigation. Explicitly identified in detection reasoning as relationship data. Critical for understanding team composition and responsibility allocation.',
    `primary_assignment_flag` BOOLEAN COMMENT 'Indicates whether this is the primary/lead assignment for this investigation (typically the lead investigator). Used to identify the main point of contact and primary responsible party.',
    `responsibility_percentage` DECIMAL(18,2) COMMENT 'Percentage of overall investigation responsibility allocated to this employee (0.00 to 100.00). Explicitly identified in detection reasoning as relationship data. Used for cost allocation across team members and workload balancing.',
    CONSTRAINT pk_investigation_assignment PRIMARY KEY(`investigation_assignment_id`)
) COMMENT 'This association product represents the Assignment between claim_investigation and employee. It captures the operational reality that complex claim investigations require multi-disciplinary teams with specialized roles (lead investigator, field investigator, medical reviewer, fraud analyst, legal counsel). Each record links one claim_investigation to one employee with attributes that exist only in the context of this assignment: the specific role performed, assignment dates, hours allocated to the investigation, investigation phase responsibility, and percentage of overall investigation responsibility for cost allocation and workload management purposes.. Existence Justification: Complex claim investigations in life insurance require multi-disciplinary teams with specialized roles: lead investigators manage the case, field investigators conduct on-site work, medical reviewers analyze APS and MIB data, fraud analysts score risk indicators, and legal counsel advises on rescission and regulatory reporting. Each employee works multiple investigations concurrently, and each investigation has multiple team members. The business actively manages these assignments with role definitions, time allocation, phase responsibility, and cost allocation percentages.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` (
    `interpleader_team_assignment_id` BIGINT COMMENT 'Primary key for the interpleader_team_assignment association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the interpleader case team',
    `interpleader_id` BIGINT COMMENT 'Foreign key linking to the interpleader case being staffed',
    `assignment_date` DATE COMMENT 'Date the employee was assigned to this interpleader case team. Used for workload tracking and cost allocation.',
    `assignment_end_date` DATE COMMENT 'Date the employees assignment to this case ended. Null for active assignments. Used for historical team composition tracking.',
    `assignment_status` STRING COMMENT 'Current status of this team assignment. Tracks lifecycle of employee involvement in the case.',
    `external_counsel_flag` BOOLEAN COMMENT 'Indicates whether this employee is coordinating with external legal counsel for this case. Used for cost allocation and communication tracking.',
    `hours_billed` DECIMAL(18,2) COMMENT 'Cumulative hours the employee has charged to this interpleader case. Critical for legal cost management and budget tracking.',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this employee is the primary point of contact for this interpleader case. Each case typically has one primary contact.',
    `responsibility_area` STRING COMMENT 'Specific aspect of the interpleader case this employee is responsible for (e.g., court filings, claimant negotiations, regulatory compliance, document discovery). Enables coordination and prevents duplication.',
    `role_in_case` STRING COMMENT 'Specific functional role the employee performs on this interpleader case team. Determines responsibility areas and approval authority.',
    CONSTRAINT pk_interpleader_team_assignment PRIMARY KEY(`interpleader_team_assignment_id`)
) COMMENT 'This association product represents the assignment of internal employees to interpleader case teams. It captures the operational reality that complex interpleader litigation requires coordinated multi-disciplinary teams (claims counsel, litigation managers, compliance officers, senior adjusters) working on the same case, with each employee managing multiple concurrent interpleader cases. Each record links one interpleader case to one employee with role, time allocation, and responsibility tracking required for legal cost management and case coordination.. Existence Justification: Interpleader litigation cases require multi-disciplinary case teams with specialized roles (claims counsel, litigation managers, compliance officers, senior adjusters). Each complex interpleader case has multiple employees working on it simultaneously with distinct responsibilities, and each employee manages multiple concurrent interpleader cases. The business actively manages these team assignments with role definitions, time tracking, and responsibility allocation for legal cost management and case coordination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ADD CONSTRAINT `fk_claims_fnol_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ADD CONSTRAINT `fk_claims_claimant_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ADD CONSTRAINT `fk_claims_beneficiary_verification_claimant_id` FOREIGN KEY (`claimant_id`) REFERENCES `life_insurance_ecm`.`claims`.`claimant`(`claimant_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_contestability_review_id` FOREIGN KEY (`contestability_review_id`) REFERENCES `life_insurance_ecm`.`claims`.`contestability_review`(`contestability_review_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ADD CONSTRAINT `fk_claims_claim_investigation_siu_referral_id` FOREIGN KEY (`siu_referral_id`) REFERENCES `life_insurance_ecm`.`claims`.`siu_referral`(`siu_referral_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_contestability_review_id` FOREIGN KEY (`contestability_review_id`) REFERENCES `life_insurance_ecm`.`claims`.`contestability_review`(`contestability_review_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_db_calculation_id` FOREIGN KEY (`db_calculation_id`) REFERENCES `life_insurance_ecm`.`claims`.`db_calculation`(`db_calculation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ADD CONSTRAINT `fk_claims_adjudication_living_benefit_claim_id` FOREIGN KEY (`living_benefit_claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`living_benefit_claim`(`living_benefit_claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ADD CONSTRAINT `fk_claims_db_calculation_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ADD CONSTRAINT `fk_claims_living_benefit_claim_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `life_insurance_ecm`.`claims`.`adjudication`(`adjudication_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_claimant_id` FOREIGN KEY (`claimant_id`) REFERENCES `life_insurance_ecm`.`claims`.`claimant`(`claimant_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ADD CONSTRAINT `fk_claims_claim_payment_original_payment_claim_payment_id` FOREIGN KEY (`original_payment_claim_payment_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_payment`(`claim_payment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ADD CONSTRAINT `fk_claims_claim_reserve_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `life_insurance_ecm`.`claims`.`appeal`(`appeal_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_claim_investigation_id` FOREIGN KEY (`claim_investigation_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_investigation`(`claim_investigation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_contestability_review_id` FOREIGN KEY (`contestability_review_id`) REFERENCES `life_insurance_ecm`.`claims`.`contestability_review`(`contestability_review_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ADD CONSTRAINT `fk_claims_claim_document_fnol_id` FOREIGN KEY (`fnol_id`) REFERENCES `life_insurance_ecm`.`claims`.`fnol`(`fnol_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ADD CONSTRAINT `fk_claims_claim_status_history_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `life_insurance_ecm`.`claims`.`adjudication`(`adjudication_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ADD CONSTRAINT `fk_claims_claim_status_history_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `life_insurance_ecm`.`claims`.`appeal`(`appeal_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ADD CONSTRAINT `fk_claims_claim_status_history_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `life_insurance_ecm`.`claims`.`adjudication`(`adjudication_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ADD CONSTRAINT `fk_claims_appeal_claimant_id` FOREIGN KEY (`claimant_id`) REFERENCES `life_insurance_ecm`.`claims`.`claimant`(`claimant_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ADD CONSTRAINT `fk_claims_unclaimed_property_claim_payment_id` FOREIGN KEY (`claim_payment_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_payment`(`claim_payment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ADD CONSTRAINT `fk_claims_siu_referral_originating_siu_referral_id` FOREIGN KEY (`originating_siu_referral_id`) REFERENCES `life_insurance_ecm`.`claims`.`siu_referral`(`siu_referral_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ADD CONSTRAINT `fk_claims_subrogation_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ADD CONSTRAINT `fk_claims_subrogation_claim_payment_id` FOREIGN KEY (`claim_payment_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_payment`(`claim_payment_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ADD CONSTRAINT `fk_claims_subrogation_related_subrogation_id` FOREIGN KEY (`related_subrogation_id`) REFERENCES `life_insurance_ecm`.`claims`.`subrogation`(`subrogation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ADD CONSTRAINT `fk_claims_interpleader_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ADD CONSTRAINT `fk_claims_interpleader_consolidated_interpleader_id` FOREIGN KEY (`consolidated_interpleader_id`) REFERENCES `life_insurance_ecm`.`claims`.`interpleader`(`interpleader_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ADD CONSTRAINT `fk_claims_contestability_review_reopened_contestability_review_id` FOREIGN KEY (`reopened_contestability_review_id`) REFERENCES `life_insurance_ecm`.`claims`.`contestability_review`(`contestability_review_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ADD CONSTRAINT `fk_claims_claims_cession_claim_id` FOREIGN KEY (`claim_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim`(`claim_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ADD CONSTRAINT `fk_claims_investigation_assignment_claim_investigation_id` FOREIGN KEY (`claim_investigation_id`) REFERENCES `life_insurance_ecm`.`claims`.`claim_investigation`(`claim_investigation_id`);
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ADD CONSTRAINT `fk_claims_interpleader_team_assignment_interpleader_id` FOREIGN KEY (`interpleader_id`) REFERENCES `life_insurance_ecm`.`claims`.`interpleader`(`interpleader_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`claims` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`claims` SET TAGS ('dbx_domain' = 'claims');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Examiner Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Application Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `amount_approved` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount Approved');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount Paid');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `amount_requested` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount Requested');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `attending_physician_statement_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Received Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `beneficiary_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Verification Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `beneficiary_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|not_required');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `cause_of_loss` SET TAGS ('dbx_business_glossary_term' = 'Cause of Loss');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `claimant_relationship` SET TAGS ('dbx_business_glossary_term' = 'Claimant Relationship');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Closure Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `contestability_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Contestability Period Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `date_of_loss` SET TAGS ('dbx_business_glossary_term' = 'Date of Loss');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `date_reported` SET TAGS ('dbx_business_glossary_term' = 'Date Reported');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `death_certificate_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Death Certificate Received Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Claim Disposition');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `examiner_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Examiner Assignment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `ibnr_flag` SET TAGS ('dbx_business_glossary_term' = 'Incurred But Not Reported (IBNR) Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `investigation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `net_amount_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|eft|wire_transfer|annuitization|retained_asset_account|other');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `reopened_date` SET TAGS ('dbx_business_glossary_term' = 'Reopened Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `reopened_flag` SET TAGS ('dbx_business_glossary_term' = 'Reopened Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `sla_actual_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Days');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fnol_id` SET TAGS ('dbx_business_glossary_term' = 'First Notice of Loss (FNOL) ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Adjuster ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fnol_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Intake User ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fnol_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fnol_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `agent_code` SET TAGS ('dbx_business_glossary_term' = 'Agent Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `claim_created_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Created Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `contestability_flag` SET TAGS ('dbx_business_glossary_term' = 'Contestability Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fnol_status` SET TAGS ('dbx_business_glossary_term' = 'First Notice of Loss (FNOL) Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fnol_status` SET TAGS ('dbx_value_regex' = 'received|pending_validation|validated|claim_created|nigo|closed');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fraud_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `loss_date` SET TAGS ('dbx_business_glossary_term' = 'Loss Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `loss_event_type` SET TAGS ('dbx_business_glossary_term' = 'Loss Event Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `loss_location` SET TAGS ('dbx_business_glossary_term' = 'Loss Location');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'FNOL Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_email` SET TAGS ('dbx_business_glossary_term' = 'Reporter Email Address');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_phone` SET TAGS ('dbx_business_glossary_term' = 'Reporter Phone Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_relationship` SET TAGS ('dbx_business_glossary_term' = 'Reporter Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `reporter_type` SET TAGS ('dbx_business_glossary_term' = 'Reporter Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `triage_classification` SET TAGS ('dbx_business_glossary_term' = 'Triage Classification');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `triage_classification` SET TAGS ('dbx_value_regex' = 'standard|expedited|complex|fraud_suspected|contestable|non_contestable');
ALTER TABLE `life_insurance_ecm`.`claims`.`fnol` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'not_screened|clear|flagged|under_review|escalated');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `benefit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Benefit Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claim_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claimant_status` SET TAGS ('dbx_business_glossary_term' = 'Claimant Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claimant_status` SET TAGS ('dbx_value_regex' = 'pending_verification|verified|rejected|under_investigation|approved|paid');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claimant_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `claimant_type` SET TAGS ('dbx_value_regex' = 'primary_beneficiary|contingent_beneficiary|insured|estate|trust|guardian');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Entity Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `entity_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `entity_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant First Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Guardian Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `guardian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_business_glossary_term' = 'Guardian Relationship');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Document Expiration Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Identity Document Issuing Authority');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_number` SET TAGS ('dbx_business_glossary_term' = 'Identity Document Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_type` SET TAGS ('dbx_business_glossary_term' = 'Identity Document Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `identity_document_type` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|state_id|military_id|other');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|verified|failed|expired');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Last Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `legal_capacity` SET TAGS ('dbx_business_glossary_term' = 'Legal Capacity');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `legal_capacity` SET TAGS ('dbx_value_regex' = 'individual|minor_with_guardian|estate_executor|trustee|power_of_attorney|conservator');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Middle Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|eft|wire_transfer|annuity_payout');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Taxpayer Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claimant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `beneficiary_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Verification ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `beneficiary_designation_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Examiner ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `adverse_findings_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Findings Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `adverse_findings_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Findings Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `aml_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_required');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `competing_claimants_count` SET TAGS ('dbx_business_glossary_term' = 'Competing Claimants Count');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `contested_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Contested Claim Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `court_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Court Order Reference');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `disbursement_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `disbursement_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorized Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `documents_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Documents Outstanding');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `documents_received` SET TAGS ('dbx_business_glossary_term' = 'Documents Received');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `documents_requested` SET TAGS ('dbx_business_glossary_term' = 'Documents Requested');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `estate_beneficiary_flag` SET TAGS ('dbx_business_glossary_term' = 'Estate Beneficiary Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `guardian_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Guardian Verified Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `identity_verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Outcome');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `identity_verification_outcome` SET TAGS ('dbx_value_regex' = 'verified|failed|pending|not_applicable');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `insurable_interest_verified` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Verified');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `interpleader_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Filed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `interpleader_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `legal_standing_verified` SET TAGS ('dbx_business_glossary_term' = 'Legal Standing Verified');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `mib_check_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `mib_check_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `mib_check_status` SET TAGS ('dbx_value_regex' = 'completed|pending|not_required|match_found|no_match');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `minor_beneficiary_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Beneficiary Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `ofac_sanctions_check_date` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Sanctions Check Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `ofac_sanctions_check_status` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Sanctions Check Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `ofac_sanctions_check_status` SET TAGS ('dbx_value_regex' = 'cleared|match_found|pending|not_required');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `probate_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Probate Validated Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `trust_beneficiary_flag` SET TAGS ('dbx_business_glossary_term' = 'Trust Beneficiary Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `trust_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Trust Validated Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `verification_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completed Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `verification_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Initiated Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `verification_type` SET TAGS ('dbx_business_glossary_term' = 'Verification Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`beneficiary_verification` ALTER COLUMN `verification_type` SET TAGS ('dbx_value_regex' = 'identity|insurable_interest|legal_standing|minor_guardianship|estate_probate|trust_validation');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` SET TAGS ('dbx_subdomain' = 'fraud_management');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `claim_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Investigation Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Case Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `contestability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `siu_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Siu Referral Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Application Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `aps_received_date` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Received Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `aps_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Requested Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `benefit_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Reduction Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'standard|siu_referral|law_enforcement|state_doi_fraud_bureau');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `external_vendor_used_flag` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Used Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `field_investigation_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Field Investigation Performed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `fraud_indicator_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Score');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_close_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Close Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_cost` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_disposition` SET TAGS ('dbx_business_glossary_term' = 'Investigation Disposition');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_disposition` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|closed_without_action|rescind_policy|pay_in_full|reduce_benefit');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_business_glossary_term' = 'Investigation Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_open_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Open Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_reason` SET TAGS ('dbx_business_glossary_term' = 'Investigation Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_info|closed');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'contestability|fraud_siu|cause_of_death|aps_review|mib_review|stoli');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `law_enforcement_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `mib_check_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `mib_check_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Performed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `nicb_check_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'National Insurance Crime Bureau (NICB) Check Performed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `policy_rescission_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Rescission Recommended Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `state_doi_filing_date` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `state_doi_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Filing Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `stoli_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_investigation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Claims Examiner Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `contestability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `db_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Db Calculation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `living_benefit_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Living Benefit Claim Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_date` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_number` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `adverse_action_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `appeal_rights_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Disclosed');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `authority_level` SET TAGS ('dbx_value_regex' = 'examiner|senior_examiner|supervisor|manager|director|special_authority');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `beneficiary_signature_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Signature Confirmed');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `benefit_amount_approved` SET TAGS ('dbx_business_glossary_term' = 'Benefit Amount Approved');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `benefit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `benefit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `contestability_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `decision_basis` SET TAGS ('dbx_business_glossary_term' = 'Decision Basis');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `denial_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Letter Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `doi_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Complaint Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `external_review_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'External Review Referral Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `federal_withholding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Federal Withholding Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `fraud_investigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Investigation Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `internal_review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `litigation_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Hold Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Outcome');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|partially_approved|pended|rescinded|reopened');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'single|monthly|quarterly|semi_annual|annual');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `policy_provision_cited` SET TAGS ('dbx_business_glossary_term' = 'Policy Provision Cited');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `prompt_payment_compliance_days` SET TAGS ('dbx_business_glossary_term' = 'Prompt Payment Compliance Days');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `reinsurance_recoverable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'lump_sum|installment|annuity|retained_asset|interest_only|combination');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `settlement_option_elected` SET TAGS ('dbx_business_glossary_term' = 'Settlement Option Elected');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `state_withholding_percentage` SET TAGS ('dbx_business_glossary_term' = 'State Withholding Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `supervisor_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Review Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `tax_withholding_election` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Election');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `tax_withholding_election` SET TAGS ('dbx_value_regex' = 'no_withholding|federal_only|state_only|federal_and_state');
ALTER TABLE `life_insurance_ecm`.`claims`.`adjudication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `db_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) Calculation ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Calculated By User ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `account_value` SET TAGS ('dbx_business_glossary_term' = 'Account Value (AV)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `accumulated_dividends` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Dividends');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `adb_rider_amount` SET TAGS ('dbx_business_glossary_term' = 'Accidental Death Benefit (ADB) Rider Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `base_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Face Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'manual|automated|hybrid');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|superseded');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `calculation_version` SET TAGS ('dbx_business_glossary_term' = 'Calculation Version Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `contestability_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Contestability Applied Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `csv_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `death_benefit_option` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit Option');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `death_benefit_option` SET TAGS ('dbx_value_regex' = 'option_a|option_b|option_c|level|increasing');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `gmdb_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Death Benefit (GMDB) Floor Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `gross_db_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Death Benefit (DB) Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `interest_on_delayed_payment` SET TAGS ('dbx_business_glossary_term' = 'Interest on Delayed Payment');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `net_db_payable` SET TAGS ('dbx_business_glossary_term' = 'Net Death Benefit (DB) Payable');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `outstanding_loan_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Loan Balance');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `paid_up_additions` SET TAGS ('dbx_business_glossary_term' = 'Paid-Up Additions (PUA)');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `premium_arrears` SET TAGS ('dbx_business_glossary_term' = 'Premium Arrears');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'WL|UL|IUL|VUL|term|SPIA');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `recalculation_reason` SET TAGS ('dbx_business_glossary_term' = 'Recalculation Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `reinsurance_ceded_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Ceded Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `statutory_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Statutory Interest Rate');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `suicide_clause_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Suicide Clause Applied Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `life_insurance_ecm`.`claims`.`db_calculation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `living_benefit_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Living Benefit Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `adl_impairment_count` SET TAGS ('dbx_business_glossary_term' = 'Activities of Daily Living (ADL) Impairment Count');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `adl_impairment_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `adl_impairment_count` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `adl_impairment_list` SET TAGS ('dbx_business_glossary_term' = 'Activities of Daily Living (ADL) Impairment List');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `adl_impairment_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `adl_impairment_list` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `attending_physician_name` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `attending_physician_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `attending_physician_name` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `attending_physician_statement_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Received Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `benefit_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Benefit Calculation Basis');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `benefit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `benefit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `benefit_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Benefit Duration Months');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `benefit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Payment End Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `benefit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Payment Start Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Care (LTC) Care Setting');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'home_health|assisted_living|nursing_facility|adult_day_care|hospice|not_applicable');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `claim_subtype` SET TAGS ('dbx_business_glossary_term' = 'Living Benefit Claim Subtype');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `cognitive_impairment_flag` SET TAGS ('dbx_business_glossary_term' = 'Cognitive Impairment Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `cognitive_impairment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `cognitive_impairment_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `coordination_of_benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `coordination_of_benefits_flag` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Diagnosis Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `disability_definition_applied` SET TAGS ('dbx_business_glossary_term' = 'Disability Definition Applied');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `disability_definition_applied` SET TAGS ('dbx_value_regex' = 'own_occupation|any_occupation|modified_own_occupation|presumptive_disability|not_applicable');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `disability_definition_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `disability_definition_applied` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `elimination_period_days` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period Days');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `elimination_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period End Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `elimination_period_satisfied_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period Satisfied Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `elimination_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period Start Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `functional_capacity_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Functional Capacity Evaluation Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `inflation_protection_rate` SET TAGS ('dbx_business_glossary_term' = 'Inflation Protection Rate');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `monthly_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Benefit Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `next_eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Eligibility Verification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Benefit Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|lump_sum|as_incurred');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `social_security_offset_amount` SET TAGS ('dbx_business_glossary_term' = 'Social Security Disability Insurance (SSDI) Offset Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `social_security_offset_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `social_security_offset_amount` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'irc_101g_qualified|irc_7702b_qualified|taxable|tax_free|not_applicable');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Termination Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `total_benefit_paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Benefit Paid to Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Claim Triggering Event');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`living_benefit_claim` ALTER COLUMN `waiver_of_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Premium (WP) Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `claim_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `erisa_plan_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Erisa Plan Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `original_payment_claim_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Tax Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `party_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `reinsurance_cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `report_line_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Line Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `beneficiary_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `direct_deposit_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Deposit Authorization Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `escheatment_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Referral Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `escheatment_state` SET TAGS ('dbx_business_glossary_term' = 'Escheatment State');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `escheatment_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `federal_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withheld Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `form_1099_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Reporting Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `form_1099_type` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `form_1099_type` SET TAGS ('dbx_value_regex' = '1099-R|1099-MISC|not_reportable');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `gross_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Account Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Routing Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payee_bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Effective Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|annual');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|eft_ach|wire_transfer|retained_asset_account');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_sequence` SET TAGS ('dbx_business_glossary_term' = 'Payment Sequence Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'issued|cleared|voided|returned|escheatment_referred|pending');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'death_benefit|disability_income|long_term_care|living_benefit|waiver_of_premium|partial_settlement');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `reissue_flag` SET TAGS ('dbx_business_glossary_term' = 'Reissue Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `settlement_option` SET TAGS ('dbx_business_glossary_term' = 'Settlement Option');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `settlement_option` SET TAGS ('dbx_value_regex' = 'lump_sum|installment|life_income|retained_asset_account|annuitization');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `state_tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'State Tax Withheld Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `stop_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Stop Payment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `stop_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Stop Payment Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `stop_payment_reason` SET TAGS ('dbx_business_glossary_term' = 'Stop Payment Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `tax_withholding_election` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Election');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `tax_withholding_election` SET TAGS ('dbx_value_regex' = 'no_withholding|mandatory_20_percent|custom_percentage|state_default');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `tax_withholding_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `claim_reserve_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Reserve Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_business_glossary_term' = 'Estimating Actuary Staff License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reserving Examiner Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `report_line_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Line Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Reserve Calculation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `actuarial_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Sign-Off Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `actuarial_signoff_status` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Sign-Off Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `actuarial_signoff_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `catastrophic_event_code` SET TAGS ('dbx_business_glossary_term' = 'Catastrophic Event Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `catastrophic_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Catastrophic Event Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `current_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `estimation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Estimation Methodology');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `ibnr_development_variance` SET TAGS ('dbx_business_glossary_term' = 'Incurred But Not Reported (IBNR) Development Variance');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `initial_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `loss_development_factor` SET TAGS ('dbx_business_glossary_term' = 'Loss Development Factor (LDF)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `net_amount_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `net_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `prior_period_ibnr_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Incurred But Not Reported (IBNR) Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_adequacy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reserve Adequacy Indicator');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_adequacy_indicator` SET TAGS ('dbx_value_regex' = 'adequate|deficient|redundant|under_review');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_business_glossary_term' = 'Reserve Basis');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_value_regex' = 'sap|gaap|ifrs|tax|pbr');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reserve Change Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reserve Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Establishment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_notes` SET TAGS ('dbx_business_glossary_term' = 'Reserve Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Release Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_release_date` SET TAGS ('dbx_business_glossary_term' = 'Reserve Release Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_business_glossary_term' = 'Reserve Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_status` SET TAGS ('dbx_value_regex' = 'open|closed|released|adjusted|under_review');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_business_glossary_term' = 'Reserve Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `reserve_type` SET TAGS ('dbx_value_regex' = 'case|ibnr|bulk|alae|ulae|supplemental');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_reserve` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `claim_document_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `claim_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Investigation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `contestability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `fnol_id` SET TAGS ('dbx_business_glossary_term' = 'Fnol Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Document Approval Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `completeness_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Completeness Checklist Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `completeness_checklist_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|not_applicable|pending_review');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|tiff|jpeg|png|xml|edi');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Document Receipt Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Document Receipt Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document Size in Bytes');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_source` SET TAGS ('dbx_business_glossary_term' = 'Document Source');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_source_contact` SET TAGS ('dbx_business_glossary_term' = 'Document Source Contact Information');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_source_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_source_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_source_name` SET TAGS ('dbx_business_glossary_term' = 'Document Source Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_source_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'received|under_review|accepted|rejected|pending|incomplete');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Reference');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_subtype` SET TAGS ('dbx_business_glossary_term' = 'Document Subtype');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `fraud_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `fraud_indicator_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `nigo_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Document Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `phi_flag` SET TAGS ('dbx_business_glossary_term' = 'Protected Health Information (PHI) Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `pii_flag` SET TAGS ('dbx_business_glossary_term' = 'Personally Identifiable Information (PII) Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Document Rejection Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `required_for_adjudication_flag` SET TAGS ('dbx_business_glossary_term' = 'Required for Adjudication Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `verification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Required Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|verified|failed|waived');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `claim_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Status History Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `activity_note_text` SET TAGS ('dbx_business_glossary_term' = 'Activity Note Text');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `activity_note_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'status_change|examiner_note|communication|diary_entry|sla_milestone|document_received');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `attorney_client_privilege_flag` SET TAGS ('dbx_business_glossary_term' = 'Attorney-Client Privilege Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `changed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Role');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'phone|email|mail|fax|portal|in_person');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_party_name` SET TAGS ('dbx_business_glossary_term' = 'Communication Party Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_party_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Party Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_type` SET TAGS ('dbx_business_glossary_term' = 'Communication Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `communication_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Activity Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `diary_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Diary Completed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `diary_due_date` SET TAGS ('dbx_business_glossary_term' = 'Diary Due Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Claim Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Claim Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `siu_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Sensitive Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `sla_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `sla_milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Milestone Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `sla_target_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `status_change_date` SET TAGS ('dbx_business_glossary_term' = 'Status Change Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claim_status_history` ALTER COLUMN `system_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'System Generated Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` SET TAGS ('dbx_subdomain' = 'dispute_resolution');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `claimant_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Assignment - Employee Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Finding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `additional_evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Additional Evidence Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `additional_evidence_received_date` SET TAGS ('dbx_business_glossary_term' = 'Additional Evidence Received Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `additional_evidence_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Additional Evidence Submitted Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `appeal_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Reference Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'internal_administrative_review|external_independent_review|doi_complaint|litigation|arbitration|mediation');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `arbitration_case_number` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `arbitration_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Filed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `arbitration_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Appeal Basis');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `claimant_representative_contact` SET TAGS ('dbx_business_glossary_term' = 'Claimant Representative Contact Information');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `claimant_representative_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `claimant_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Representative Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Closure Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `committee_position` SET TAGS ('dbx_business_glossary_term' = 'Committee Position');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|remanded|withdrawn');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Rationale');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `doi_complaint_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Complaint Filed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `doi_complaint_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Complaint Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `doi_complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Complaint Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `exhaustion_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Exhaustion Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `exhaustion_status` SET TAGS ('dbx_value_regex' = 'not_exhausted|exhausted|external_review_available|litigation_pending');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `hours_spent` SET TAGS ('dbx_business_glossary_term' = 'Hours Spent on Review');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `litigation_case_number` SET TAGS ('dbx_business_glossary_term' = 'Litigation Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `litigation_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Filed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `litigation_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `recusal_flag` SET TAGS ('dbx_business_glossary_term' = 'Recusal Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `recusal_reason` SET TAGS ('dbx_business_glossary_term' = 'Recusal Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `review_role` SET TAGS ('dbx_business_glossary_term' = 'Appeal Review Role');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Start Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `reviewing_committee_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Committee Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `revised_claim_amount_approved` SET TAGS ('dbx_business_glossary_term' = 'Revised Claim Amount Approved');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `revised_claim_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Revised Claim Amount Paid');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`appeal` ALTER COLUMN `vote_outcome` SET TAGS ('dbx_business_glossary_term' = 'Vote Outcome');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `unclaimed_property_id` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Property ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `claim_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 1');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 2');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_city` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary City');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Claim Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Claim Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_country_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Country Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|GBR|MEX|AUS');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Postal Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_state_province` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary State or Province');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `beneficiary_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'beneficiary_paid|escheated_to_state|below_threshold|duplicate_record|administrative_error');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|JPY|AUD');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `dmf_match_date` SET TAGS ('dbx_business_glossary_term' = 'Death Master File (DMF) Match Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `dmf_match_status` SET TAGS ('dbx_business_glossary_term' = 'Death Master File (DMF) Match Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `dmf_match_status` SET TAGS ('dbx_value_regex' = 'matched|no_match|pending|manual_review');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `dormancy_period_years` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Period Years');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `due_diligence_attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Attempts Count');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `due_diligence_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completed Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `due_diligence_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Initiated Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `due_diligence_method` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `due_diligence_outcome` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Outcome');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `due_diligence_outcome` SET TAGS ('dbx_value_regex' = 'beneficiary_located|no_response|address_invalid|deceased_beneficiary|refused_claim');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `escheatment_eligibility_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligibility Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `escheatment_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `escheatment_remittance_amount` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Remittance Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `escheatment_remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Remittance Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `last_known_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Known Contact Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `state_claim_number` SET TAGS ('dbx_business_glossary_term' = 'State Claim Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `state_of_domicile` SET TAGS ('dbx_business_glossary_term' = 'State of Domicile');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `unclaimed_property_status` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Property Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `unclaimed_property_status` SET TAGS ('dbx_value_regex' = 'identified|due_diligence|escheatment_eligible|escheated|claimed|closed');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `unclaimed_property_type` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Property Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `unclaimed_property_type` SET TAGS ('dbx_value_regex' = 'death_benefit|matured_endowment|annuity_proceeds|cash_surrender_value|uncashed_check|retained_asset_account');
ALTER TABLE `life_insurance_ecm`.`claims`.`unclaimed_property` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` SET TAGS ('dbx_subdomain' = 'fraud_management');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `siu_referral_id` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Referral ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Staff License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Case Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Referring User ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Application Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `originating_siu_referral_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `actual_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Loss Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `assigned_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `claim_denial_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Recommended Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `estimated_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Loss Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `external_vendor_used_flag` SET TAGS ('dbx_business_glossary_term' = 'External Vendor Used Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `fraud_indicator_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Score');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `fraud_indicator_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `investigation_cost` SET TAGS ('dbx_business_glossary_term' = 'Investigation Cost');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `law_enforcement_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `nicb_referral_date` SET TAGS ('dbx_business_glossary_term' = 'National Insurance Crime Bureau (NICB) Referral Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `nicb_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'National Insurance Crime Bureau (NICB) Referral Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `policy_rescission_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Policy Rescission Recommended Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_date` SET TAGS ('dbx_business_glossary_term' = 'Referral Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_number` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Referral Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_business_glossary_term' = 'Referral Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|closed|referred_to_law_enforcement|referred_to_doi|withdrawn');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referral_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Referral Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referring_user_name` SET TAGS ('dbx_business_glossary_term' = 'Referring User Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referring_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `referring_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `state_doi_case_number` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `state_doi_referral_date` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Referral Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `state_doi_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Referral Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `stoli_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`siu_referral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` SET TAGS ('dbx_subdomain' = 'dispute_resolution');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `subrogation_id` SET TAGS ('dbx_business_glossary_term' = 'Subrogation ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `claim_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Payment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Examiner ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `related_subrogation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `abandonment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Reason Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `abandonment_reason_code` SET TAGS ('dbx_value_regex' = 'cost_prohibitive|insufficient_evidence|third_party_insolvent|statute_expired|other');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `abandonment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Reason Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `assigned_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Attorney Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Closure Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `court_name` SET TAGS ('dbx_business_glossary_term' = 'Court Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `demand_amount` SET TAGS ('dbx_business_glossary_term' = 'Demand Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `demand_letter_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Demand Letter Sent Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Initiation Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `judgment_amount` SET TAGS ('dbx_business_glossary_term' = 'Judgment Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `judgment_date` SET TAGS ('dbx_business_glossary_term' = 'Judgment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `liability_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Liability Determination Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `litigation_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `net_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Recovery Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `recovery_expenses` SET TAGS ('dbx_business_glossary_term' = 'Recovery Expenses');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `reinsurance_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Participation Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `statute_of_limitations_date` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `subrogation_number` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `subrogation_status` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `subrogation_type` SET TAGS ('dbx_business_glossary_term' = 'Subrogation Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `subrogation_type` SET TAGS ('dbx_value_regex' = 'third_party_liability|product_liability|medical_malpractice|auto_accident|workers_compensation|other');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_contact_info` SET TAGS ('dbx_business_glossary_term' = 'Third Party Contact Information');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_contact_info` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Insurer Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Third Party Policy Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_type` SET TAGS ('dbx_business_glossary_term' = 'Third Party Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `third_party_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|government_entity|medical_provider|manufacturer|other');
ALTER TABLE `life_insurance_ecm`.`claims`.`subrogation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` SET TAGS ('dbx_subdomain' = 'dispute_resolution');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `interpleader_id` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Claimant Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `consolidated_interpleader_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `appeal_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `awarded_claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Awarded Claimant Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `awarded_claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `awarded_claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `beneficiary_designation_conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Conflict Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Closure Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `company_counsel_contact` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Counsel Contact Information');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `company_counsel_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `company_counsel_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `company_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Counsel Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `competing_claimants_count` SET TAGS ('dbx_business_glossary_term' = 'Competing Claimants Count');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `court_district` SET TAGS ('dbx_business_glossary_term' = 'Court District');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `court_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Court Jurisdiction Type');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `court_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `court_name` SET TAGS ('dbx_business_glossary_term' = 'Court Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `court_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Court Order Reference Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Court Deposit Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `deposit_into_court_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Into Court Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `discharge_from_liability_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge From Liability Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `dispute_basis` SET TAGS ('dbx_business_glossary_term' = 'Dispute Basis Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Death Benefit (DB) Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `divorce_decree_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Divorce Decree Involved Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `estate_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Estate Claim Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Filing Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Filing Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `interpleader_number` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Case Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `interpleader_status` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `interpleader_status` SET TAGS ('dbx_value_regex' = 'pending|filed|active|resolved|dismissed|withdrawn');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `judge_name` SET TAGS ('dbx_business_glossary_term' = 'Presiding Judge Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `legal_fees_incurred` SET TAGS ('dbx_business_glossary_term' = 'Legal Fees Incurred');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `minor_beneficiary_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Beneficiary Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Case Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `primary_claimant_relationship` SET TAGS ('dbx_business_glossary_term' = 'Primary Claimant Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Resolution Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'court_order|settlement|dismissal|withdrawal');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `secondary_claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Claimant Name');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `secondary_claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `secondary_claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `secondary_claimant_relationship` SET TAGS ('dbx_business_glossary_term' = 'Secondary Claimant Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `trust_involved_flag` SET TAGS ('dbx_business_glossary_term' = 'Trust Involved Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` SET TAGS ('dbx_subdomain' = 'claim_processing');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `contestability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `exam_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Finding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Staff License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `staff_license_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Records Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `vendor_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `vendor_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `tertiary_contestability_medical_director_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Director ID');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `tertiary_contestability_medical_director_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `tertiary_contestability_medical_director_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Application Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `reopened_contestability_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `actual_fact_discovered` SET TAGS ('dbx_business_glossary_term' = 'Actual Fact Discovered');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `applicant_response` SET TAGS ('dbx_business_glossary_term' = 'Applicant Response');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `application_question_number` SET TAGS ('dbx_business_glossary_term' = 'Application Question Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `aps_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `beneficiary_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Notification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `claim_denial_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Denial Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `contestability_period_days` SET TAGS ('dbx_business_glossary_term' = 'Contestability Period Days');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `date_of_loss` SET TAGS ('dbx_business_glossary_term' = 'Date of Loss');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `legal_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `material_misrepresentation_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Misrepresentation Found Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `medical_director_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Review Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `medical_director_review_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `medical_director_review_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `mib_check_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Performed Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `mib_discrepancy_found_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Discrepancy Found Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `misrepresentation_category` SET TAGS ('dbx_business_glossary_term' = 'Misrepresentation Category');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `misrepresentation_description` SET TAGS ('dbx_business_glossary_term' = 'Misrepresentation Description');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `policy_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `premium_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Refund Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `premium_refund_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Premium Refund Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `premium_refund_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `rescission_decision` SET TAGS ('dbx_business_glossary_term' = 'Rescission Decision');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `rescission_decision` SET TAGS ('dbx_value_regex' = 'rescission_approved|rescission_denied|partial_rescission|claim_adjustment|pending');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `rescission_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rescission Effective Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `rescission_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Rescission Recommended Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `review_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Review Initiated Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Notes');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Contestability Review Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `review_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Review Trigger Reason');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `state_doi_notification_date` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Notification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `state_doi_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'State Department of Insurance (DOI) Notification Required Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `underwriting_decision_impact` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Impact');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `underwriting_decision_impact` SET TAGS ('dbx_value_regex' = 'would_have_declined|would_have_rated|would_have_excluded_condition|would_have_required_higher_premium|no_impact');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`contestability_review` ALTER COLUMN `within_contestability_flag` SET TAGS ('dbx_business_glossary_term' = 'Within Contestability Period Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` SET TAGS ('dbx_association_edges' = 'claims.claim,reinsurance.treaty');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `claims_cession_id` SET TAGS ('dbx_business_glossary_term' = 'claims_cession Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `reinsurance_cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cession - Claim Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Cession - Treaty Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `ceded_amount` SET TAGS ('dbx_business_glossary_term' = 'Ceded Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `cession_status` SET TAGS ('dbx_business_glossary_term' = 'Cession Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cession Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cession Currency Code');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Cession Effective Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Cession Notification Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Cession Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `recovery_amount_received` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount Received');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `recovery_received_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Received Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `reinsurance_recoverable_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Recoverable Amount');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `reinsurer_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Claim Number');
ALTER TABLE `life_insurance_ecm`.`claims`.`claims_cession` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cession Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` SET TAGS ('dbx_subdomain' = 'fraud_management');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` SET TAGS ('dbx_association_edges' = 'claims.claim_investigation,workforce.employee');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `investigation_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assignment Identifier');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `claim_investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assignment - Claim Investigation Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Assignment - Employee Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `hours_allocated` SET TAGS ('dbx_business_glossary_term' = 'Hours Allocated');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `investigation_phase` SET TAGS ('dbx_business_glossary_term' = 'Investigation Phase');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `investigation_role` SET TAGS ('dbx_business_glossary_term' = 'Investigation Role');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `primary_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`investigation_assignment` ALTER COLUMN `responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Percentage');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` SET TAGS ('dbx_subdomain' = 'dispute_resolution');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` SET TAGS ('dbx_association_edges' = 'claims.interpleader,workforce.employee');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `interpleader_team_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Team Assignment - Interpleader Team Assignment Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Team Assignment - Employee Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `interpleader_id` SET TAGS ('dbx_business_glossary_term' = 'Interpleader Team Assignment - Interpleader Id');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `external_counsel_flag` SET TAGS ('dbx_business_glossary_term' = 'External Counsel Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `hours_billed` SET TAGS ('dbx_business_glossary_term' = 'Hours Billed');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `responsibility_area` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Area');
ALTER TABLE `life_insurance_ecm`.`claims`.`interpleader_team_assignment` ALTER COLUMN `role_in_case` SET TAGS ('dbx_business_glossary_term' = 'Role in Case');
