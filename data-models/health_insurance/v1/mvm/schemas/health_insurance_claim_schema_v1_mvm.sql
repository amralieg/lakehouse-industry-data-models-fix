-- Schema for Domain: claim | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`claim` COMMENT 'Core transactional domain for all medical, dental, vision, and behavioral health claims — professional (837P), institutional (837I), and dental (837D). Owns claim header and line detail, diagnosis codes (ICD), procedure codes (CPT/HCPCS), DRG assignments, adjudication decisions, EOB generation, COB processing, adjustments, denials, and LAE tracking. Interfaces with EDI clearinghouses (Availity, Change Healthcare) and supports IBNR reserving and MLR reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`header` (
    `header_id` BIGINT COMMENT 'Primary key for header',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Needed for account‑level statements that combine premium billing and claim charges, a core reporting requirement for member cost‑sharing and financial reconciliation.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Claims submitted under a group NPI must be traceable to the group_practice entity for group-level contract validation, network participation verification, and provider directory reconciliation. Role-p',
    `capitation_arrangement_id` BIGINT COMMENT 'Foreign key linking to contract.capitation_arrangement. Business justification: For capitation-based providers, claims must be evaluated against the capitation arrangement to determine carve-out services (FFS vs. capitation scope). Payers tag claims to capitation arrangements for',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Supports enrollment‑specific claim tracking required by regulatory reporting (e.g., CMS program‑level cost reporting) linking claim to the exact enrollment record.',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to care.care_plan. Business justification: Required for Care Plan Cost Attribution report, linking each claim to the members active care plan to evaluate plan effectiveness and compliance.',
    `cobra_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.cobra_election. Business justification: COBRA claims require special adjudication: premium payment verification, grace period tracking, and subsidy application. Direct FK to cobra_election enables COBRA-specific claim routing, compliance re',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: When claims are processed by a delegated entity (TPA, delegated IPA), the claim header must reference the governing delegation agreement for NCQA/CMS oversight, audit trails, and regulatory filing. He',
    `eligibility_verification_id` BIGINT COMMENT 'Foreign key linking to enrollment.eligibility_verification. Business justification: Real-time eligibility verification (270/271 transactions) performed at claim intake must be traceable to the resulting claim for audit, dispute resolution, and provider portal reporting. Direct FK ena',
    `exchange_enrollment_id` BIGINT COMMENT 'Foreign key linking to enrollment.exchange_enrollment. Business justification: ACA marketplace claims require APTC reconciliation, CSR variant cost-sharing application, and 1095-A reporting. Direct FK to exchange_enrollment enables marketplace-specific adjudication, IRS reconcil',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Inpatient and outpatient claims must be linked to the rendering facility for facility fee adjudication, network status validation, DRG-based reimbursement, and facility-level utilization reporting. He',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: ACA regulatory requirement: claims submitted during a members premium grace period must be pended, paid, or denied based on grace period outcome. Claim processors must reference the active grace peri',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Large employer groups segment members by division with distinct contribution strategies and benefit offerings. Attributing claims to a group_division enables division-level cost reporting, contributio',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for employer‑sponsored plan cost reporting and ACA employer reporting; each claim must be attributed to the employer group that provided the coverage.',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Required for network participation and quality reporting; each claim must be linked to the provider entity for regulatory and performance analytics.',
    `provider_provider_id` BIGINT COMMENT 'FK to provider.provider.provider_id — Every claim must resolve to a rendering provider for network status determination, fee schedule lookup, and provider payment. This is the second most critical operational join in health insurance.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Claim headers must be directly associated with a health plan for MLR reporting, regulatory submissions, and LOB-level claim analytics. A health insurance domain expert expects every claim header to id',
    `inpatient_admission_id` BIGINT COMMENT 'Foreign key linking to utilization.inpatient_admission. Business justification: Required for Admission‑to‑Claim reconciliation report; claims are generated from inpatient admissions, so linking each claim to its admission record is standard practice.',
    `medicaid_eligibility_id` BIGINT COMMENT 'Foreign key linking to enrollment.medicaid_eligibility. Business justification: Medicaid and dual-eligible claims require state agency coordination, crossover claim routing, and cost-sharing limit enforcement. Direct FK to medicaid_eligibility enables Medicaid-specific adjudicati',
    `medicare_entitlement_id` BIGINT COMMENT 'Foreign key linking to enrollment.medicare_entitlement. Business justification: Medicare Advantage and Part D claims require CMS contract number, PBP assignment, and entitlement type for correct adjudication and RAPS/EDPS submission to CMS. Direct FK to medicare_entitlement is es',
    `member_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to member.member_eligibility_span. Business justification: Claims must be validated against the members eligibility span to confirm active coverage on the date of service — a fundamental claims adjudication gate. Eligibility-at-time-of-service validation, re',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member (patient) associated with the claim.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Actuarial claim cost analysis and risk‑adjusted reporting require each claim to reference the members risk score at service time.',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Claims adjudication requires validating that a PA was obtained before service. The headers prior_authorization_number is a denormalized reference to the PA request. Linking header to pa_request enabl',
    `pcp_assignment_id` BIGINT COMMENT 'Foreign key linking to member.pcp_assignment. Business justification: HMO and gatekeeper plans require claims to be validated against the members active PCP assignment for referral authorization and PCP capitation reporting. PCP attribution for quality measures (HEDIS,',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Adjudicators must reference the active plan election to apply correct benefit tiers, rider coverage (dental/vision/FSA/HSA), and cost-sharing rules. Health insurance claim adjudication systems univers',
    `plan_service_area_id` BIGINT COMMENT 'Foreign key linking to plan.plan_service_area. Business justification: Network adequacy and service‑area compliance reports need to map each claim to the plan’s service area where the service was rendered.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Claims adjudication requires the exact policy under which a claim is filed to apply deductibles, OOP maximums, coverage limits, and benefit rules. Adjudicators, auditors, and underwriters routinely jo',
    `program_id` BIGINT COMMENT 'Foreign key linking to care.care_program. Business justification: Needed for Program ROI analysis; associates each claim with the care program enrollment at service time for financial and outcome reporting.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Required for claim adjudication to reference the specific provider contract governing fees; essential for contract performance reporting and compliance audits.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Required for claim adjudication to apply network‑specific contracts and cost‑share rules; claim processors need to know the provider network for each claim.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.party. Business justification: Needed to associate each claim with the contracting party (provider organization) for regulatory reporting and payment reconciliation.',
    `subscriber_id` BIGINT COMMENT 'FK to member.subscriber.subscriber_id — The claim-to-member join is the single most critical operational query in health insurance. Every claim must resolve to a member for eligibility verification, accumulator updates, and EOB generation. ',
    `tpa_arrangement_id` BIGINT COMMENT 'Foreign key linking to employer.tpa_arrangement. Business justification: Self-funded employer groups administer claims under a TPA arrangement governing fee schedules, stop-loss attachment points, and admin rules. Linking claim headers to tpa_arrangement_id enables TPA fee',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for claim adjudication to reference the exact enrollment transaction that established coverage at service date, used in CMS audit and eligibility verification reports.',
    `um_case_id` BIGINT COMMENT 'Foreign key linking to utilization.um_case. Business justification: Needed for Case Management Dashboard; each claim must be tied to the utilization case that governs its clinical and financial review.',
    `vbc_contract_id` BIGINT COMMENT 'Foreign key linking to contract.vbc_contract. Business justification: In value-based care, claims must be attributed to a VBC contract for expenditure tracking against benchmark targets and performance period reconciliation. CMS ACO programs and commercial VBC arrangeme',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.plan_year. Business justification: Regulatory reporting and rate filing require associating each claim with the specific plan year under which coverage was provided.',
    `adjustment_flag` BOOLEAN COMMENT 'Indicates if the claim includes any adjustments.',
    `admission_date` DATE COMMENT 'Date of patient admission for inpatient claims.',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the insurer permits for the services.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the insurer before adjustments.',
    `billing_provider_npi` STRING COMMENT 'NPI of the provider responsible for billing.. Valid values are `^[0-9]{10}$`',
    `billing_type` STRING COMMENT 'Method of billing for the claim.. Valid values are `fee_for_service|capitation|bundled|global|per_diem`',
    `claim_event_timestamp` TIMESTAMP COMMENT 'Date and time of the primary service rendered for the claim.',
    `claim_line_count` STRING COMMENT 'Number of line detail records associated with this claim.',
    `claim_number` STRING COMMENT 'Unique claim identifier assigned by the insurer.',
    `claim_source` STRING COMMENT 'Origin of the claim submission.. Valid values are `edi|paper|portal|api`',
    `claim_status` STRING COMMENT 'Current processing status of the claim.. Valid values are `submitted|pending|adjudicated|paid|denied|suspended`',
    `claim_type` STRING COMMENT 'Category of claim based on service type.. Valid values are `professional|institutional|dental|vision|behavioral`',
    `claim_version` STRING COMMENT 'Version number of the claim for tracking revisions.',
    `cob_indicator` BOOLEAN COMMENT 'Flag indicating whether coordination of benefits processing is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the claim header record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `denial_reason_code` STRING COMMENT 'Code representing the reason for claim denial, if applicable.',
    `diagnosis_codes` STRING COMMENT 'Pipe-separated list of diagnosis codes associated with the claim.',
    `discharge_date` DATE COMMENT 'Date of patient discharge for inpatient claims.',
    `drg_code` STRING COMMENT 'DRG assignment for inpatient claims.. Valid values are `^[0-9]{3,4}$`',
    `is_hipaa_compliant` BOOLEAN COMMENT 'Flag indicating whether the claim data complies with HIPAA regulations.',
    `is_mlr_excluded` BOOLEAN COMMENT 'Indicates if the claim is excluded from MLR calculations.',
    `is_suspended` BOOLEAN COMMENT 'Indicates if the claim is currently suspended pending additional information.',
    `length_of_stay` STRING COMMENT 'Number of days between admission and discharge.',
    `lob` STRING COMMENT 'Business line to which the claim belongs.. Valid values are `medical|dental|vision|pharmacy|behavioral`',
    `paid_amount` DECIMAL(18,2) COMMENT 'Net amount paid to the provider after adjustments.',
    `place_of_service_code` STRING COMMENT 'Code indicating where the service was provided.. Valid values are `^[0-9]{2}$`',
    `prior_status` STRING COMMENT 'Previous status before the most recent transition.. Valid values are `submitted|pending|adjudicated|paid|denied|suspended`',
    `procedure_codes` STRING COMMENT 'Pipe-separated list of procedure codes billed on the claim.',
    `referral_provider_npi` STRING COMMENT 'NPI of the referring provider, if applicable.. Valid values are `^[0-9]{10}$`',
    `sla_due_date` DATE COMMENT 'Date by which the claim must be processed to meet service level agreement.',
    `sla_met` BOOLEAN COMMENT 'Flag indicating whether the claim met the SLA deadline.',
    `status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition.',
    `suspension_reason` STRING COMMENT 'Reason why the claim was suspended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the claim header record.',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record and lifecycle hub for every submitted health insurance claim — professional (CMS-1500/837P), institutional (UB-04/837I), dental (ADA/837D), and behavioral health. Captures claim-level identifiers (ICN), claim type, bill type, place of service, financial totals (billed/allowed/paid), adjudication status with full status transition history (prior status, new status, timestamp, reason, changed-by), service dates, COB indicator, LOB, plan and member identifiers, provider NPIs (rendering, billing, facility, attending, referring), DRG assignment, admission details, claim source (EDI/paper/portal), adjustment linkage, pend/suspend reason tracking, SLA monitoring dates, and HIPAA compliance flags. Serves as the central hub linking all claim-related detail records.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for line',
    `auth_service_line_id` BIGINT COMMENT 'Foreign key linking to utilization.auth_service_line. Business justification: Audit of Prior Authorization compliance; claim line references the authorized service line to verify authorized quantity, price, and status.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Adjudication uses benefit definitions to determine coverage and cost sharing for each claim line; linking claim line to plan.benefit is required for accurate payment calculation.',
    `header_id` BIGINT COMMENT 'Identifier of the parent claim to which this line belongs.',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Each claim line has specific cost-sharing applied (copay, coinsurance, deductible applicability) based on a cost_share_rule. Linking line to cost_share_rule enables accurate patient_responsibility_amo',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Medical claim lines for drug administration (J-codes, infusion, chemotherapy) must resolve NDC to the drug master for drug utilization reporting, formulary compliance checks, and MLR analytics. ndc_co',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Individual claim lines for facility-based services (hospital outpatient, ASC, skilled nursing) require facility identity for line-level facility fee application, revenue code validation, and facility-',
    `fee_schedule_rate_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule_rate. Business justification: Claim line adjudication requires matching each service line to the contracted fee schedule rate (by procedure_code, modifier, place_of_service) to compute allowed_amount. Health insurance adjudicators',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: Claim line adjudication validates the rendering providers specific network participation record (in_network_flag, credentialing_status, panel_status) at time of service. This supports in-network veri',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Each claim line can have a distinct place of service (e.g., telehealth vs. in-office on the same claim). Linking to practice_location enables per-line telehealth determination, place-of-service valida',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Claim lines for drug administration (infusion, specialty injectables) require PA and must reference the PA record for compliance validation, denial prevention, and PA utilization reporting. prior_auth',
    `service_scope_id` BIGINT COMMENT 'Foreign key linking to contract.service_scope. Business justification: Service scope defines contracted covered services by CPT range, revenue code, place of service, and LOB. Linking claim lines to service scope validates whether each billed service falls within contrac',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.network_tier. Business justification: Needed for patient billing statements; tier determines deductible, copay, and coinsurance for each claim line in network‑based cost‑share calculations.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any adjustment applied to the line after initial adjudication.',
    `adjustment_reason_code` STRING COMMENT 'Code describing the reason for the line adjustment.',
    `admission_date` DATE COMMENT 'Date the patient was admitted (applicable to institutional claims).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the payer agrees to pay for the line.',
    `anesthesia_minutes` STRING COMMENT 'Total minutes of anesthesia administered for the line (if applicable).',
    `billed_amount` DECIMAL(18,2) COMMENT 'Charged amount submitted to the payer for the line.',
    `cob_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by secondary/tertiary payers under COB processing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `denial_reason_code` STRING COMMENT 'Standard code indicating why the line was denied.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged (applicable to institutional claims).',
    `emergency_indicator` BOOLEAN COMMENT 'True if the service was rendered as an emergency.',
    `epsdt_indicator` BOOLEAN COMMENT 'True if the service qualifies for EPSDT coverage (for Medicaid).',
    `family_planning_indicator` BOOLEAN COMMENT 'True if the service is related to family planning.',
    `line_description` STRING COMMENT 'Free‑text description of the service rendered.',
    `line_number` STRING COMMENT 'Sequential number of the line within the claim.',
    `line_status` STRING COMMENT 'Current processing status of the claim line.. Valid values are `posted|pending|denied|reversed|adjusted`',
    `line_type` STRING COMMENT 'Category of service rendered on the line.. Valid values are `professional|institutional|dental`',
    `modifier_1` STRING COMMENT 'First two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_2` STRING COMMENT 'Second two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_3` STRING COMMENT 'Third two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `modifier_4` STRING COMMENT 'Fourth two‑character modifier associated with the procedure code.. Valid values are `^[A-Z0-9]{2}$`',
    `paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by the payer for the line.',
    `patient_responsibility_amount` DECIMAL(18,2) COMMENT 'Sum of copay, coinsurance, and deductible amounts owed by the member.',
    `place_of_service_code` STRING COMMENT 'Two‑digit code indicating where the service was provided.. Valid values are `^[0-9]{2}$`',
    `procedure_code` STRING COMMENT 'Standard procedure code representing the service rendered.',
    `remark_code` STRING COMMENT 'Additional informational code attached to the line.',
    `revenue_code` STRING COMMENT 'Four‑digit code used for institutional billing to indicate type of service.. Valid values are `^[0-9]{4}$`',
    `service_date` DATE COMMENT 'Date on which the service was provided.',
    `units_of_service` DECIMAL(18,2) COMMENT 'Quantity of the service rendered (e.g., number of visits, dosage units).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Line-level detail for each service rendered within a claim. Captures line number, CPT/HCPCS procedure code, procedure modifier codes (up to 4), revenue code (institutional), service date, units of service, billed amount per line, allowed amount, paid amount, copay amount, coinsurance amount, deductible amount, COB paid amount, line status, denial reason code, remark codes, place of service code, rendering provider NPI at line level, NDC code (for drug lines), quantity qualifier, anesthesia minutes, emergency indicator, EPSDT indicator, family planning indicator, and prior authorization number.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`diagnosis` (
    `diagnosis_id` BIGINT COMMENT 'Primary key for diagnosis',
    `header_id` BIGINT COMMENT 'Identifier of the claim to which this diagnosis belongs.',
    `hcc_mapping_id` BIGINT COMMENT 'Foreign key linking to risk.hcc_mapping. Business justification: Clinical quality and risk‑adjustment reports need each diagnosis linked to its HCC mapping for proper risk score calculations.',
    `chronic_condition_flag` BOOLEAN COMMENT 'True if the diagnosis represents a chronic condition relevant for care management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the diagnosis line was initially loaded into the data lake.',
    `diagnosis_code` STRING COMMENT 'Official diagnosis code assigned to the claim line.',
    `diagnosis_date` DATE COMMENT 'Calendar date the diagnosis was documented on the claim.',
    `diagnosis_description` STRING COMMENT 'Full textual description of the diagnosis code.',
    `diagnosis_status` STRING COMMENT 'Operational status indicating if the diagnosis line is active, pending review, or logically deleted.. Valid values are `active|inactive|deleted|pending`',
    `diagnosis_type` STRING COMMENT 'Specifies the role of the diagnosis (e.g., principal, admitting, external cause, other).. Valid values are `principal|admitting|external_cause|other`',
    `drg_code` STRING COMMENT 'DRG (Diagnosis Related Group) code assigned for inpatient claims.',
    `drg_description` STRING COMMENT 'Textual description of the DRG code.',
    `hcc_category` STRING COMMENT 'HCC category code used for risk‑adjustment and RAF calculations.',
    `icd_version` STRING COMMENT 'Indicates whether the diagnosis code follows ICD‑9‑CM or ICD‑10‑CM standards.. Valid values are `ICD-9|ICD-10`',
    `line_quantity` STRING COMMENT 'Number of times the same diagnosis appears on the claim; typically 1.',
    `poa_indicator` STRING COMMENT 'Indicates if the condition was present at the time of admission (Y=Yes, N=No, U=Unknown).. Valid values are `Y|N|U`',
    `qualifier` STRING COMMENT 'Free‑text qualifier providing extra context (e.g., laterality, severity).',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Numeric factor used in risk‑adjustment calculations for the diagnosis.',
    `sequence` STRING COMMENT 'Ordinal position of the diagnosis on the claim (1‑n).',
    `source_system` STRING COMMENT 'Originating system of record for the diagnosis information.. Valid values are `Facets|QNXT|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the diagnosis line.',
    CONSTRAINT pk_diagnosis PRIMARY KEY(`diagnosis_id`)
) COMMENT 'Diagnosis code assignments at the claim level supporting ICD-10-CM coding. Captures claim ICN, diagnosis sequence number, ICD version (ICD-10/ICD-9), diagnosis code, diagnosis description, diagnosis type (principal, admitting, external cause, other), POA (Present on Admission) indicator, HCC category mapping, chronic condition flag, and diagnosis qualifier. Supports DRG grouping, risk adjustment (HCC/RAF), HEDIS measure attribution, and clinical analytics.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`procedure` (
    `procedure_id` BIGINT COMMENT 'Primary key for procedure',
    `auth_service_line_id` BIGINT COMMENT 'Foreign key linking to utilization.auth_service_line. Business justification: Procedure-level authorization matching requires verifying that the specific procedure (CPT code, units, price) matches an authorized service line. auth_service_line carries authorized quantity, CPT co',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Claim procedures must be validated against covered benefits to determine coverage eligibility, prior authorization requirements, and applicable cost-sharing. A health insurance domain expert expects p',
    `header_id` BIGINT COMMENT 'Identifier of the parent claim to which this procedure belongs.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Procedures for drug administration (biologics, chemotherapy, 340B drugs) must reference the drug master for drug spend analytics, formulary compliance for medical-benefit drugs, and risk adjustment re',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Procedures performed at a facility require a direct facility FK for facility fee billing, credentialing validation at time of service, quality measure reporting (e.g., HEDIS), and facility-specific pr',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: Procedure-level adjudication requires validating the surgeons network participation record (credentialing status, participation status, tier) at time of service. Linking procedure to network_provider',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Procedure records carry prior_authorization_number (denormalized). Linking procedure to pa_request enables procedure-level authorization verification — validating CPT/HCPCS codes, units, and service d',
    `practice_location_id` BIGINT COMMENT 'Identifier of the facility where the procedure was performed (e.g., hospital NPI or internal location code).',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Procedures for drug administration (chemotherapy, biologics) require PA. Linking to pharmacy.prior_authorization enables PA compliance validation, step therapy verification for drug procedures, and re',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Links surgeon NPI to provider entity for surgeon performance, outcome, and credentialing dashboards mandated by quality‑measure reporting.',
    `anesthesia_time_minutes` STRING COMMENT 'Total minutes of anesthesia administered for the procedure.',
    `billing_category` STRING COMMENT 'Category used for billing and reimbursement rules.. Valid values are `inpatient|outpatient|professional|institutional`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Billed amount for the procedure before adjustments.',
    `claim_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment applied to the procedure charge.',
    `claim_adjustment_reason` STRING COMMENT 'Reason code for any post‑adjudication adjustment applied to this procedure.',
    `claim_line_number` STRING COMMENT 'Line number of this procedure within the claim file.',
    `claim_status` STRING COMMENT 'Current processing status of the claim line containing this procedure.. Valid values are `open|closed|denied|paid|reversed`',
    `code_system` STRING COMMENT 'The coding system used for the procedure_code field.. Valid values are `ICD-10-PCS|CPT|HCPCS`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|CHF`',
    `diagnosis_codes` STRING COMMENT 'Pipe‑delimited list of primary diagnosis codes (ICD‑10‑CM) associated with the procedure. [ENUM-REF-CANDIDATE: multiple codes — promote to reference product]',
    `documentation_indicator` STRING COMMENT 'Indicates completeness of clinical documentation for the procedure.. Valid values are `complete|partial|missing`',
    `drg_code` STRING COMMENT 'DRG assignment for the inpatient case derived from the procedure and diagnoses.',
    `drg_weight` DECIMAL(18,2) COMMENT 'Relative weight of the DRG used for reimbursement calculations.',
    `is_emergency` BOOLEAN COMMENT 'True if the procedure was performed under emergency conditions.',
    `is_outpatient` BOOLEAN COMMENT 'True if the procedure was performed in an outpatient setting.',
    `is_primary_procedure` BOOLEAN COMMENT 'True if this is the principal procedure for the claim.',
    `laterality` STRING COMMENT 'Anatomical side on which the procedure was performed.. Valid values are `left|right|bilateral|none`',
    `modifier` STRING COMMENT 'Additional qualifier or modifier associated with the procedure code (e.g., bilateral, emergency).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final reimbursable amount after adjustments, discounts, and contractual allowances.',
    `notes` STRING COMMENT 'Clinician‑entered free‑text comments about the procedure.',
    `prior_authorization_status` STRING COMMENT 'Current status of the prior authorization request.. Valid values are `approved|denied|pending`',
    `procedure_code` STRING COMMENT 'Standardized code representing the medical procedure performed.',
    `procedure_date` DATE COMMENT 'Calendar date on which the procedure was performed.',
    `procedure_status` STRING COMMENT 'Current processing status of the procedure record.. Valid values are `performed|scheduled|cancelled|pending`',
    `procedure_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the procedure was performed, captured to the second.',
    `quality_measure_flag` BOOLEAN COMMENT 'True if the procedure contributes to a quality measure (e.g., HEDIS).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the procedure record was first inserted into the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the procedure record.',
    `revenue_code` STRING COMMENT 'Hospital revenue code associated with the procedure for institutional claims.',
    `risk_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used for risk‑adjusted payment calculations.',
    `sequence` STRING COMMENT 'Ordinal position of the procedure within the claim (1‑based).',
    `service_location_type` STRING COMMENT 'Classification of the place where the procedure occurred.. Valid values are `hospital|clinic|outpatient_center|home`',
    `surgeon_name` STRING COMMENT 'Full name of the surgeon who performed the procedure.',
    `units_of_service` STRING COMMENT 'Number of units billed for the procedure (e.g., time‑based units).',
    CONSTRAINT pk_procedure PRIMARY KEY(`procedure_id`)
) COMMENT 'Procedure code assignments at the claim header level (distinct from line-level CPT). Captures principal procedure code (ICD-10-PCS for inpatient), procedure date, procedure sequence, surgeon NPI, procedure qualifier, and secondary procedure codes. Supports DRG assignment, surgical case management, and inpatient utilization analytics. Primarily applicable to 837I institutional claims.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`adjudication` (
    `adjudication_id` BIGINT COMMENT 'System-generated unique identifier for the adjudication record.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Adjudication applies benefit-package-level cost-sharing parameters (metal tier, OOP max, deductible type). Linking adjudication directly to benefit_package enables accurate deductible/OOP enforcement ',
    `header_id` BIGINT COMMENT 'Unique identifier of the claim that this adjudication decision applies to.',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Adjudication decisions are made at both the claim header level and the claim line level (per 837 processing standards). The adjudication product description explicitly states for each claim and claim',
    `cost_share_rule_id` BIGINT COMMENT 'Foreign key linking to plan.cost_share_rule. Business justification: Adjudication must record which specific cost-sharing rule (copay, coinsurance, deductible logic) was applied to calculate allowed/paid amounts. This link is essential for audit trails, dispute resolut',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Adjudication engines apply deductible amounts, OOP maximums, benefit designations, and network status directly from the eligibility span. A direct FK avoids multi-hop joins through header and enables ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Adjudication of facility claims requires the facility entity to apply correct fee schedules, validate network participation status, and enforce facility-specific contract terms (DRG rates, per diem). ',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: Adjudication applies a specific fee schedule to determine allowed amounts and payment methodology. Regulators and auditors require traceability from adjudication outcome to the governing fee schedule.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the benefit plan under which the claim was submitted.',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Adjudication applies medical policies to determine coverage and medical necessity. Referencing the specific medical policy applied is required by NCQA UM standards and state regulations for documentin',
    `identity_id` BIGINT COMMENT 'Unique identifier of the insured member associated with the claim.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Adjudication outcome is directly driven by the PA decision (approved/denied/modified quantity). Linking adjudication to pa_decision enables enforcement of authorized amounts, denial reason propagation',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Adjudication must verify PA status (prior_authorization_required, prior_authorization_status are adjudication attrs). Referencing the specific PA request enables authorization enforcement, medical nec',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: Adjudication records for pharmacy claims must reference the pharmacy claim being adjudicated for NCPDP compliance, pharmacy adjudication audit trails, and CMS Part D adjudication reporting. The existi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Adjudication applies policy-level deductibles, OOP maximums, and coverage rules. The adjudication record must reference the specific policy to correctly calculate accumulator impacts and benefit limit',
    `provider_id` BIGINT COMMENT 'National Provider Identifier (NPI) of the treating provider.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Adjudication explicitly determines in-network vs out-of-network cost-sharing rules. A direct FK to provider_network supports adjudication audit trails, network-based payment rule application, and MLR ',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Reimbursement policies (NCCI edits, global surgery, modifier reduction rules) are applied during adjudication and recorded as edit_code/edit_outcome. Linking adjudication to the triggering reimburseme',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Adjudication applies tier-specific cost-sharing rules (copay/coinsurance differentials per tier). A direct FK to network.tier enables adjudication audit trails showing which tier drove cost-sharing ca',
    `accumulator_deductible_impact` DECIMAL(18,2) COMMENT 'Impact on the members deductible accumulator from this adjudication.',
    `accumulator_oop_impact` DECIMAL(18,2) COMMENT 'Impact on the members out‑of‑pocket accumulator.',
    `adjudication_number` STRING COMMENT 'External reference number assigned to the adjudication for audit and communication purposes.',
    `adjudication_status` STRING COMMENT 'Current status of the adjudication decision.. Valid values are `paid|denied|pended|suspended|voided`',
    `adjudication_timestamp` TIMESTAMP COMMENT 'Date and time when the adjudication decision was generated.',
    `admission_date` DATE COMMENT 'Date the patient was admitted (for institutional claims).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the plan permits for the service after contracts and fee schedules.',
    `allowed_amount_method` STRING COMMENT 'Methodology used to calculate the allowed amount.. Valid values are `fee_schedule|mac|rbp|capitation|custom`',
    `auto_adjudication_flag` BOOLEAN COMMENT 'Indicates whether the claim was processed automatically without manual review.',
    `claim_type` STRING COMMENT 'Category of the claim based on service setting.. Valid values are `professional|institutional|dental|vision|behavioral`',
    `cob_adjusted_amount` DECIMAL(18,2) COMMENT 'Amount adjusted after coordination of benefits.',
    `cob_processing_result` STRING COMMENT 'Result of COB processing for the claim.. Valid values are `primary|secondary|tertiary|none`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `[A-Z]{3}`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Portion of the members deductible applied by this adjudication.',
    `diagnosis_code` STRING COMMENT 'Primary diagnosis code associated with the claim.',
    `discharge_date` DATE COMMENT 'Date the patient was discharged (for institutional claims).',
    `duplicate_claim_flag` BOOLEAN COMMENT 'True if the claim is identified as a potential duplicate.',
    `edit_bypass_reason` STRING COMMENT 'Reason provided when an edit was bypassed.',
    `edit_code` STRING COMMENT 'Code of the clinical or administrative edit applied (e.g., NCCI, OCE).',
    `edit_description` STRING COMMENT 'Human‑readable description of the edit.',
    `edit_outcome` STRING COMMENT 'Result of the edit evaluation.. Valid values are `pass|fail|bypass|override`',
    `edit_override_authority` STRING COMMENT 'Identifier of the person or system that overrode the edit.',
    `edit_override_flag` BOOLEAN COMMENT 'Indicates whether the edit result was manually overridden.',
    `edit_timestamp` TIMESTAMP COMMENT 'Date and time when the edit was evaluated.',
    `medical_necessity_flag` BOOLEAN COMMENT 'Indicates whether the service met medical necessity criteria.',
    `oop_amount` DECIMAL(18,2) COMMENT 'Member out‑of‑pocket responsibility after this adjudication.',
    `prior_authorization_required` BOOLEAN COMMENT 'True if the service required prior authorization.',
    `prior_authorization_status` STRING COMMENT 'Outcome of the prior authorization request.. Valid values are `approved|denied|pending|not_required`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the adjudication record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjudication record.',
    `service_date` DATE COMMENT 'Date on which the service was rendered.',
    `timeliness_flag` BOOLEAN COMMENT 'Indicates whether the claim was filed within the required time window.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (deductibles, coinsurance, contractual) applied.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Aggregate charge amount submitted on the claim before any adjustments.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable to the provider after all adjustments.',
    CONSTRAINT pk_adjudication PRIMARY KEY(`adjudication_id`)
) COMMENT 'Authoritative record of the adjudication decision for each claim and claim line, capturing the full pre-payment processing lifecycle including all clinical and administrative edit results. Includes adjudication status (paid/denied/pended/suspended/voided), auto-adjudication flag, adjudicator ID, benefit plan applied, accumulator impacts (deductible/OOP), COB processing results, allowed amount calculation method (fee schedule/MAC/RBP/capitation), network status, medical necessity determination, and final disposition. Captures granular edit-level results (NCCI/OCE/LCD/NCD/plan-specific/timely filing/duplicate) with edit code, edit description, pass/fail/bypass/override outcomes per line, bypass reason, and override authority. Supports coding compliance, payment accuracy, and CMS edit mandate adherence.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`eob` (
    `eob_id` BIGINT COMMENT 'Unique surrogate key for the EOB record.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: EOB documents are generated following claim adjudication decisions. Each EOB directly corresponds to an adjudication outcome — the allowed amounts, COB adjustments, and member responsibility amounts o',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: EOBs are generated to communicate adverse determinations to members. Direct FK from EOB to adverse_determination supports regulatory audit trails verifying that required adverse determination notices ',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: EOBs are member-facing documents that must display the benefit package (metal tier, cost-sharing structure, SBC reference) under which the claim was processed. ACA transparency requirements mandate th',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: EOB is generated for a specific claim; linking to claim header provides the parent relationship',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: When a claim is denied, the EOB document must reference the specific denial record to accurately communicate denial reason codes, appeal rights, and clinical criteria to the member. The eob product ha',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: EOB generation requires the active eligibility span to display correct benefit period, deductible status, OOP remaining, and coverage category. Direct FK enables EOB systems to pull coverage context f',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member associated with the claim.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to claim.payment. Business justification: EOB documents communicate payment information to members and providers, including plan_paid_amount and member_responsibility_amount. Linking eob.payment_id -> payment.payment_id establishes the author',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: EOBs generated for pharmacy claims must reference the pharmacy claim record for accurate member-facing drug cost breakdown, formulary tier explanation, and NCPDP-compliant remittance. Direct link avoi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: EOBs must display policy-specific coverage details, deductible applied, and OOP accumulation. ACA and state insurance regulations require EOB notices to reference the specific policy provision. A dire',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: EOBs must display structured provider information to members. Linking to provider_provider enables accurate provider name, address, and specialty retrieval for EOB generation, replacing denormalized p',
    `subscriber_id` BIGINT COMMENT 'Identifier of the primary subscriber (often the employee or policyholder).',
    `allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the plan permits for the service.',
    `appeal_rights_text` STRING COMMENT 'Narrative describing the members right to appeal the decision.',
    `appeal_rights_version` STRING COMMENT 'Version identifier for the appeal rights language used.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Total amount billed by the provider before any adjustments.',
    `claim_icn` STRING COMMENT 'Unique claim identifier used throughout the adjudication process.',
    `cob_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount adjusted due to coordination of benefits with other payers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the EOB record was first created in the data warehouse.',
    `delivery_date` DATE COMMENT 'Date the EOB was actually delivered to the recipient.',
    `delivery_method` STRING COMMENT 'Method used to deliver the EOB to the member or provider.. Valid values are `mail|portal|edi`',
    `denial_reason_summary` STRING COMMENT 'Brief text explaining why a claim or line was denied.',
    `document_number` STRING COMMENT 'External document identifier assigned to the EOB for tracking and reference.',
    `eob_status` STRING COMMENT 'Current lifecycle status of the EOB record.. Valid values are `generated|delivered|suppressed|error`',
    `eob_type` STRING COMMENT 'Indicates whether the EOB is intended for the member or the provider.. Valid values are `member|provider`',
    `generation_timestamp` TIMESTAMP COMMENT 'Date and time when the EOB was generated by the claims engine.',
    `language_code` STRING COMMENT 'ISO 639‑2 language code indicating the language of the EOB content.',
    `member_responsibility_amount` DECIMAL(18,2) COMMENT 'Portion of the claim the member must pay (deductible, copay, coinsurance, or non‑covered).',
    `member_responsibility_type` STRING COMMENT 'Category of the members financial responsibility for the claim.. Valid values are `deductible|copay|coinsurance|non_covered`',
    `plan_paid_amount` DECIMAL(18,2) COMMENT 'Amount paid by the health plan to the provider.',
    `remark_codes` STRING COMMENT 'Standardized codes providing additional claim processing information.',
    `sbc_reference` STRING COMMENT 'Link or identifier to the applicable Summary of Benefits and Coverage document.',
    `service_end_date` DATE COMMENT 'Last date of service covered by the claim.',
    `service_start_date` DATE COMMENT 'First date of service covered by the claim.',
    `suppression_flag` BOOLEAN COMMENT 'Indicates whether the EOB should be suppressed from member delivery (e.g., for zero‑payment claims).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the EOB record.',
    `version_number` STRING COMMENT 'Sequential version number for revisions of the EOB.',
    CONSTRAINT pk_eob PRIMARY KEY(`eob_id`)
) COMMENT 'Explanation of Benefits document record generated for members and providers following claim adjudication. Captures EOB document ID, EOB type (member/provider), generation date, delivery method (mail/portal/EDI 835), member ID, subscriber ID, claim ICN, service dates, provider name, billed amount, allowed amount, plan paid amount, member responsibility (deductible, copay, coinsurance, non-covered), COB adjustment, denial reason summary, remark codes, appeal rights language version, SBC reference, and EOB suppression flag. Supports member transparency and ACA SBC compliance.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Primary key for adjustment',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Adjustments are post-adjudication corrections to previously adjudicated claims. Each adjustment references the original adjudication decision being corrected, reversed, or voided. Linking adjustment.a',
    `adverse_determination_id` BIGINT COMMENT 'Foreign key linking to appeal.adverse_determination. Business justification: Claim adjustments are executed when adverse determinations are overturned on appeal. Direct FK from adjustment to adverse_determination enables financial impact reporting of overturned adverse determi',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: RAC/internal audit findings directly trigger claim adjustments (overpayment recovery, underpayment correction). The adjustment table carries denormalized `audit_finding_reference` text — replacing it ',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Adjustment records are created after an appeal decision; linking to the appeal case provides audit trail and regulatory reporting of appeal‑driven adjustments.',
    `header_id` BIGINT COMMENT 'Identifier of the original claim to which this adjustment applies.',
    `denial_id` BIGINT COMMENT 'Foreign key linking to claim.denial. Business justification: Adjustments are frequently triggered by denial overturns through the appeals process. When an appeal succeeds, an adjustment record is created to correct the original denial and process payment. Linki',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Retroactive claim adjustments and overpayment recoveries must reference the eligibility span to validate coverage period, apply correct benefit rules, and support CMS 60-day rule compliance. Direct FK',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Adjustments on facility claims (RAC audits, DRG regroups, overpayment recovery) require facility identity for facility-level audit reporting, CMS RAC audit tracking, and recovery demand management. Fa',
    `fwa_case_id` BIGINT COMMENT 'Foreign key linking to compliance.fwa_case. Business justification: FWA investigations (fraud, waste, abuse) directly generate claim adjustments for overpayment recovery. The adjustment table has `is_fraud`, `overpayment_type`, `recovery_method`, `recovery_status` — a',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Adjustment may apply to a specific claim line; replace claim_line_number with a proper FK to claim.line',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member associated with the claim adjustment.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Retrospective risk adjustment drives claim adjustments: when CMS recalculates a members risk score, payers must adjust previously paid claims. Linking adjustment records to the triggering risk score ',
    `payment_id` BIGINT COMMENT 'Foreign key linking to claim.payment. Business justification: Adjustments directly affect payment records — they represent corrections, recoveries, voids, or reversals of previously disbursed payments. The adjustment product tracks adjusted_amount, original_amou',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Claim adjustments triggered by retroactive PA approvals or PA reversals must reference the PA record. Supports pharmacy adjustment audit trails, overpayment recovery tied to PA status changes, and com',
    `provider_id` BIGINT COMMENT 'Unique identifier of the provider linked to the adjusted claim.',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Claim adjustments are frequently triggered by retroactive reimbursement policy changes or policy correction (e.g., NCCI edit updates, bundling rule revisions). Linking adjustment to the governing reim',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Total amount after the adjustment is applied.',
    `adjustment_code` STRING COMMENT 'Internal code categorizing the adjustment for reporting.',
    `adjustment_date` TIMESTAMP COMMENT 'Timestamp when the adjustment was recorded or became effective.',
    `adjustment_description` STRING COMMENT 'Narrative description of why and how the adjustment was made.',
    `adjustment_status` STRING COMMENT 'Current processing status of the adjustment.. Valid values are `pending|approved|rejected|completed`',
    `adjustment_type` STRING COMMENT 'Category of the adjustment indicating its nature.. Valid values are `void|replacement|correction|retroactive`',
    `audit_source` STRING COMMENT 'Origin of the audit finding (e.g., internal, RAC, OIG, provider self‑disclosure).. Valid values are `internal|rac|oig|provider_self_disclosure`',
    `audit_type` STRING COMMENT 'Type of audit that triggered the adjustment.. Valid values are `post_payment|pre_payment|clinical|coding|billing`',
    `compliance_60_day_rule` BOOLEAN COMMENT 'Indicates whether the adjustment complies with the CMS 60‑day overpayment recoupment rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `demand_lifecycle_stage` STRING COMMENT 'Stage of the demand/collection lifecycle for the adjustment.. Valid values are `demand_created|demand_sent|demand_received|demand_resolved`',
    `diagnosis_code` STRING COMMENT 'ICD diagnosis code(s) associated with the claim adjustment, if relevant.',
    `effective_date` DATE COMMENT 'Date when the adjustment takes effect.',
    `expiration_date` DATE COMMENT 'Date when the adjustment ceases to be effective, if applicable.',
    `identifier` STRING COMMENT 'External or business-facing identifier for the adjustment (e.g., RAC audit number).',
    `initiator_role` STRING COMMENT 'Business role of the initiator.. Valid values are `claims_adjuster|auditor|provider|member|system`',
    `is_duplicate` BOOLEAN COMMENT 'Flag identifying the adjustment as a duplicate payment correction.',
    `is_fraud` BOOLEAN COMMENT 'Indicates whether the adjustment is related to suspected fraud.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether the adjustment reverses a prior adjustment.',
    `is_void` BOOLEAN COMMENT 'Indicates whether the adjustment voids the original claim payment.',
    `net_adjustment_amount` DECIMAL(18,2) COMMENT 'Difference between original and adjusted amounts (positive for overpayment recovery, negative for additional payment).',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the adjuster.',
    `original_amount` DECIMAL(18,2) COMMENT 'Total amount originally paid on the claim before any adjustment.',
    `overpayment_indicator` BOOLEAN COMMENT 'Flag indicating whether the adjustment relates to an overpayment.',
    `overpayment_type` STRING COMMENT 'Specific category of overpayment being corrected.. Valid values are `duplicate|incorrect_rate|ineligible_member|billing_error|fraud`',
    `procedure_code` STRING COMMENT 'Procedure code(s) related to the adjusted claim line.',
    `reason_code` STRING COMMENT 'Standardized code describing the business reason for the adjustment.',
    `recovery_method` STRING COMMENT 'Method used to recover the overpayment.. Valid values are `offset|check|installment|write_off`',
    `recovery_status` STRING COMMENT 'Current status of the recovery process.. Valid values are `pending|in_process|completed|failed`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True when the adjustment must be reported to regulatory bodies (e.g., CMS RAC).',
    `resolution_status` STRING COMMENT 'Overall resolution state of the adjustment case.. Valid values are `open|closed|escalated`',
    `sequence` STRING COMMENT 'Sequential order of adjustments applied to the same claim.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjustment record.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Single source of truth for all post-adjudication corrections, recoveries, and audit findings — including claim adjustments, voids, reprocessing events, overpayment identification and recovery, and post-payment audit results for payment integrity and FWA detection. Captures adjustment type (void/replacement/corrected/retroactive), overpayment type (duplicate payment/incorrect rate/ineligible member/billing error/fraud), audit type (post-payment/prepayment/clinical/coding/billing), audit source (internal/RAC/OIG/provider self-disclosure), financial impact (original vs adjusted amounts, net adjustment, overpayment amount, recovery amounts, demand lifecycle), initiator, CMS 60-day overpayment rule compliance, recovery method (offset/check/installment), recovery status, and resolution status. Supports payment integrity programs, CMS RAC audit compliance, and regulatory overpayment reporting.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`denial` (
    `denial_id` BIGINT COMMENT 'System-generated unique identifier for the denial record.',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Denials are the output of adjudication decisions where the claim or line fails medical necessity, authorization, or edit checks. The adjudication record contains edit_code, edit_outcome, medical_neces',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to plan.benefit. Business justification: Denials are issued when a service falls outside a covered benefit or exceeds benefit limits. Linking denial to the specific benefit enables denial management workflows, ERISA/ACA appeal processing, an',
    `header_id` BIGINT COMMENT 'Unique identifier of the claim associated with this denial.',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Eligibility-based denials (member not covered on date of service) require direct reference to the eligibility span for denial root-cause reporting, appeals processing, and CMS compliance audits. This ',
    `grace_period_id` BIGINT COMMENT 'Foreign key linking to billing.grace_period. Business justification: ACA 3-month grace period rule: claims denied due to non-payment of premium must reference the specific grace period that triggered the denial. Required for regulatory reporting, member appeals, and re',
    `line_id` BIGINT COMMENT 'Foreign key linking to claim.line. Business justification: Denial may apply to a specific claim line; replace claim_line_number with a proper FK to claim.line',
    `medical_policy_id` BIGINT COMMENT 'Foreign key linking to utilization.medical_policy. Business justification: Denials based on medical necessity or coverage exclusions must cite the specific medical policy. ACA and state mandates require adverse determination letters to reference the clinical criteria and pol',
    `subscriber_id` BIGINT COMMENT 'Unique identifier of the member whose claim was denied.',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: Denials driven by PA decisions (medical necessity failure, authorization denial) must reference the specific PA decision for appeal processing, regulatory compliance reporting, and denial reason trace',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Many claim denials result from missing or denied PA. Denial records must reference the PA request to support appeal rights documentation, denial letter generation, and regulatory reporting (ACA Sectio',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: State insurance regulations require denial notices to cite the specific policy provision supporting the denial. Denial letters and appeal rights notices must reference the policy under which coverage ',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prior_authorization. Business justification: Pharmacy claim denials frequently result from PA failures or missing PA. Linking denial to pharmacy.prior_authorization enables PA-related denial root-cause analysis, appeals processing, and CMS Part ',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Denials must be communicated to the rendering/billing provider and tracked at the provider level for state-mandated denial rate reporting, provider appeals management, and network performance monitori',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to contract.reimbursement_policy. Business justification: Denials are directly caused by reimbursement policy violations (bundling, NCCI edits, modifier requirements, global surgery periods). Linking denial to the specific reimbursement policy enables denial',
    `appeal_deadline_date` DATE COMMENT 'Last date by which an appeal must be filed.',
    `appeal_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the denial is eligible for an appeal.',
    `carc_code` STRING COMMENT 'Standardized code describing the reason for the claim adjustment/denial.',
    `clinical_criteria` STRING COMMENT 'Reference to the clinical guideline or utilization management criteria applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the denial record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `denial_date` DATE COMMENT 'Date the denial decision was rendered.',
    `denial_number` STRING COMMENT 'External business identifier assigned to the denial, used in communications and reporting.',
    `denial_status` STRING COMMENT 'Current lifecycle status of the denial.. Valid values are `pending|reviewed|appealed|resolved|closed|rejected`',
    `denial_type` STRING COMMENT 'High‑level classification of the denial reason.. Valid values are `clinical|administrative|technical|cob|timely_filing`',
    `denied_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments (e.g., contractual allowances, discounts) applied to the denied amount.',
    `denied_gross_amount` DECIMAL(18,2) COMMENT 'Original amount of the claim that was denied before any adjustments.',
    `denied_net_amount` DECIMAL(18,2) COMMENT 'Final net amount after adjustments that the member is responsible for due to the denial.',
    `letter_generated_flag` BOOLEAN COMMENT 'True if a formal denial letter was generated and sent to the member/provider.',
    `medical_necessity_flag` BOOLEAN COMMENT 'Indicates whether the claim failed medical necessity criteria (true = not medically necessary).',
    `notes` STRING COMMENT 'Free‑form notes captured by reviewers or staff during denial handling.',
    `override_flag` BOOLEAN COMMENT 'True if the denial was manually overridden by a reviewer.',
    `override_reason` STRING COMMENT 'Explanation for why the denial was overridden.',
    `rac_code` STRING COMMENT 'Standardized remark code that provides additional context for the denial.',
    `reason_description` STRING COMMENT 'Narrative explanation of why the claim or line was denied.',
    `resolution_date` DATE COMMENT 'Date the denial was resolved or closed.',
    `resolution_status` STRING COMMENT 'Current status of the denial resolution process.. Valid values are `pending|approved|denied|withdrawn|closed`',
    `source_system` STRING COMMENT 'Originating system that generated the denial record (e.g., Facets, QNXT).',
    `subtype` STRING COMMENT 'More granular category within the denial type, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the denial record.',
    CONSTRAINT pk_denial PRIMARY KEY(`denial_id`)
) COMMENT 'Authoritative record of claim and claim line denials, capturing denial reason codes, clinical rationale, and resolution tracking. Includes denial ID, claim ICN, line number (if line-level denial), denial date, denial type (clinical, administrative, technical, COB, timely filing), CARC code, RARC code, denial reason description, clinical criteria applied (InterQual/MCG), medical necessity determination, denial letter generated flag, appeal eligibility flag, appeal deadline date, denial override flag, override reason, and resolution status. Supports appeals workflow, regulatory reporting, and denial management analytics.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`cob` (
    `cob_id` BIGINT COMMENT 'Primary key for cob',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: COB processing is an integral part of claim adjudication for multi-payer claims. The adjudication record captures cob_processing_result and cob_adjusted_amount, indicating that COB outcomes feed direc',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: COB processing is performed per claim; linking to claim header enables traceability',
    `cob_record_id` BIGINT COMMENT 'Foreign key linking to member.cob_record. Business justification: COB claim processing must reference the members COB record to determine coordination order, birthday rule applicability, and MSP compliance. Claim COB adjudication directly consumes member COB record',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: COB processing requires the members active eligibility span to determine coordination order, coverage overlap periods, and primary/secondary liability. Direct FK enables COB engines to validate cover',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: COB processing for pharmacy claims requires direct linkage to the pharmacy claim record for coordination of benefits calculation, crossover claim processing, and Medicare/Medicaid pharmacy COB reporti',
    `payer_id` BIGINT COMMENT 'Internal identifier of the primary insurance payer.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment applied to the net liability.',
    `adjustment_reason` STRING COMMENT 'Reason for any monetary adjustment applied during COB processing.',
    `batch_number` STRING COMMENT 'Identifier of the ETL batch that loaded this COB record.',
    `claim_icn` STRING COMMENT 'Unique identifier assigned to the underlying claim that this COB record relates to.',
    `claim_line_count` STRING COMMENT 'Number of line items on the underlying claim.',
    `cob_method` STRING COMMENT 'Method used for coordination of benefits: standard, non‑duplication, or maintenance of benefits.. Valid values are `standard|non_duplication|maintenance_of_benefits`',
    `cob_status` STRING COMMENT 'Current processing status of the COB record.. Valid values are `pending|processed|error|reversed`',
    `comments` STRING COMMENT 'Free‑form notes entered by the processor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the COB record was first created in the system.',
    `crossover_claim_flag` BOOLEAN COMMENT 'Indicates whether the claim crosses over between primary and secondary payer responsibilities.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code for monetary values (e.g., USD).. Valid values are `USD`',
    `effective_date` DATE COMMENT 'Date when the COB processing became effective.',
    `expiration_date` DATE COMMENT 'Date when the COB record expires or is no longer valid (nullable).',
    `is_duplicate` BOOLEAN COMMENT 'Flag indicating whether this COB record was generated for a duplicate claim.',
    `is_manual_override` BOOLEAN COMMENT 'True if a user manually overrode automated COB decisions.',
    `medicaid_crossover_indicator` BOOLEAN COMMENT 'Flag showing if Medicaid is involved in a crossover scenario.',
    `msp_indicator` BOOLEAN COMMENT 'Flag indicating whether Medicare is acting as the secondary payer for this claim.',
    `msp_type` STRING COMMENT 'Specifies the type of Medicare secondary payer relationship (full or partial).. Valid values are `full|partial`',
    `net_liability_amount` DECIMAL(18,2) COMMENT 'Remaining liability amount after primary and secondary payments and adjustments.',
    `primary_payer_allowed_amount` DECIMAL(18,2) COMMENT 'Maximum amount the primary payer allowed for the claim before COB.',
    `primary_payer_denial_reason` STRING COMMENT 'Reason code or description why the primary payer denied all or part of the claim.',
    `primary_payer_paid_amount` DECIMAL(18,2) COMMENT 'Amount actually paid by the primary payer after adjudication.',
    `process_order` STRING COMMENT 'Sequential order in which multiple payer COB steps are applied for the claim.',
    `processed_timestamp` TIMESTAMP COMMENT 'Date‑time when the COB processing was completed.',
    `processing_user_name` STRING COMMENT 'Display name of the user who performed the COB processing.',
    `source_system` STRING COMMENT 'Name of the originating operational system (e.g., Facets, QNXT).',
    `total_allowed_amount` DECIMAL(18,2) COMMENT 'Sum of allowed amounts for all claim lines as determined by the primary payer.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Aggregate charge amount from all claim lines before any adjustments.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the primary payer before secondary adjudication.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the COB record.',
    CONSTRAINT pk_cob PRIMARY KEY(`cob_id`)
) COMMENT 'Coordination of Benefits processing record for claims involving multiple payers. Captures COB record ID, claim ICN, primary payer ID, primary payer name, primary payer paid amount, primary payer allowed amount, primary payer denial reason, secondary payer ID, COB processing order, COB method (standard/non-duplication/maintenance of benefits), other insurance type (employer group/Medicare/Medicaid/auto/workers comp), Medicare as secondary payer (MSP) indicator, MSP type, crossover claim flag, Medicaid crossover indicator, and net liability after COB. Supports accurate secondary adjudication and CMS MSP compliance.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`payment` (
    `payment_id` BIGINT COMMENT 'Primary key for payment',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Claim payments are authorized and sized by adjudication decisions. The adjudication record determines the net_amount, allowed_amount, and COB-adjusted amounts that drive the payment disbursement. Link',
    `outcome_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_outcome. Business justification: Payments may be adjusted based on appeal outcomes; linking to the appeal outcome enables accurate reconciliation and compliance reporting of appeal‑related payment changes.',
    `header_id` BIGINT COMMENT 'FK to claim.header',
    `payment_claim_header_id` BIGINT COMMENT 'Identifier of the claim to which this payment applies.',
    `party_id` BIGINT COMMENT 'Unique identifier of the entity receiving the payment (provider NPI or member ID).',
    `payment_payer_party_id` BIGINT COMMENT 'Identifier of the entity funding the payment (usually the health plan).',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: Payments issued for pharmacy claims must reference the pharmacy claim record for 835 transaction reconciliation, pharmacy payment reporting, and PBM payment audit. The existing claim.header link is in',
    `reinsurance_claim_id` BIGINT COMMENT 'Foreign key linking to risk.reinsurance_claim. Business justification: Stop-loss/reinsurance recovery requires tracing which original claim payment triggered the reinsurance claim filing. Payers must document the specific paid claim that breached the attachment point to ',
    `vbc_arrangement_id` BIGINT COMMENT 'Foreign key linking to network.vbc_arrangement. Business justification: VBC shared savings/loss settlements generate payment records that must reference the specific arrangement for CMS reconciliation reporting and financial settlement. Health insurance payers directly li',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all adjustments (CARC/RARC) applied to the gross amount.',
    `batch_number` BIGINT COMMENT 'Identifier of the batch in which this payment was processed.',
    `batch_sequence` STRING COMMENT 'Sequence order of the payment within its batch.',
    `carc_codes` STRING COMMENT 'Pipe‑separated list of CARC codes applied to the claim payment.',
    `channel` STRING COMMENT 'Delivery channel for the payment transaction.. Valid values are `clearinghouse|direct|bank`',
    `check_number` STRING COMMENT 'Check number when payment method is a paper check.',
    `clearinghouse_code` BIGINT COMMENT 'Identifier of the EDI clearinghouse that processed the 835 transaction.',
    `clearinghouse_name` STRING COMMENT 'Human‑readable name of the clearinghouse (e.g., Availity, Change Healthcare).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payment.. Valid values are `USD|CAD|EUR`',
    `cycle` STRING COMMENT 'Frequency with which the payment is issued.. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `gl_account_number` STRING COMMENT 'General ledger account to which the payment is posted.',
    `gl_posting_date` DATE COMMENT 'Date the payment entry was posted to the general ledger.',
    `gl_reference_number` STRING COMMENT 'Reference identifier linking the payment to the GL transaction.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before any adjustments or taxes.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been fully reconciled.',
    `is_returned` BOOLEAN COMMENT 'True if the payment was returned by the bank or clearinghouse.',
    `is_voided` BOOLEAN COMMENT 'True if the payment was voided after issuance.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the payee after adjustments.',
    `note` STRING COMMENT 'Additional free‑form notes related to the payment.',
    `payee_type` STRING COMMENT 'Classification of the payee: provider, member, or other.. Valid values are `provider|member|other`',
    `payment_date` TIMESTAMP COMMENT 'Timestamp when the payment was issued to the payee.',
    `payment_description` STRING COMMENT 'Free‑text description of the payment purpose.',
    `payment_method` STRING COMMENT 'Instrument used to disburse the payment.. Valid values are `eft|check|virtual_card|capitation_offset`',
    `payment_number` STRING COMMENT 'External payment reference number used in remittance advice and provider communications.',
    `payment_source` STRING COMMENT 'Indicates whether the payment originated from internal systems or an external entity.. Valid values are `internal|external`',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `issued|cleared|voided|returned|stopped`',
    `payment_type` STRING COMMENT 'Category of the payment (e.g., claim settlement, capitation offset).. Valid values are `claim_payment|capitation|rebate|adjustment`',
    `racr_codes` STRING COMMENT 'Pipe‑separated list of RARC codes providing additional adjustment details.',
    `reason_code` STRING COMMENT 'Standard code indicating why the payment was made (e.g., claim settlement, rebate).',
    `reconciliation_status` STRING COMMENT 'Current status of the payments financial reconciliation.. Valid values are `reconciled|unreconciled|pending`',
    `returned_reason` STRING COMMENT 'Explanation for why the payment was returned.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax withheld or applied to the payment, if applicable.',
    `trace_number` STRING COMMENT 'Bank‑provided trace number for tracking the payment.',
    `transaction_control_number` STRING COMMENT 'Unique control number for the 835 remittance advice transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    `void_reason` STRING COMMENT 'Explanation for why the payment was voided.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Single source of truth for all claim payment disbursements and electronic remittance advice (835 ERA) transmitted to providers and members. Captures payee information (NPI/TIN/member ID), payment amount, payment date, payment method (EFT/check/virtual card/capitation offset), check/EFT trace number, payment status lifecycle (issued/cleared/voided/returned/stopped), 835 transaction control number, clearinghouse ID (Availity, Change Healthcare), CARC/RARC adjustment codes at claim level, claim-level payment detail, reconciliation status, and GL posting reference. Consolidates provider remittance advice and claim payment into a single authoritative record for payment reconciliation, cash posting, and provider inquiry resolution.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`accumulator` (
    `accumulator_id` BIGINT COMMENT 'Primary key for accumulator',
    `adjudication_id` BIGINT COMMENT 'Foreign key linking to claim.adjudication. Business justification: Accumulator ledger entries are created or updated as a direct result of adjudication decisions. The adjudication record explicitly tracks accumulator_deductible_impact and accumulator_oop_impact, conf',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Accumulators track deductible and OOP accumulation against benefit-package-defined limits (family_deductible_amount, out_of_pocket_max_family). Direct linkage to benefit_package is required for accura',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Care management programs often have program-specific deductible/OOP accumulator rules (e.g., waived cost-sharing for care management participants). Linking accumulators to care enrollment enables care',
    `header_id` BIGINT COMMENT 'Foreign key linking to claim.header. Business justification: Each accumulator ledger entry represents a specific benefit accumulation event triggered by a claim. Linking accumulator.claim_header_id -> header.header_id identifies which claim triggered the accumu',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Deductible and OOP accumulators must be scoped to a specific eligibility span to enforce benefit period resets (deductible_reset_date, oop_reset_date). Without this FK, accumulator engines cannot corr',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan governing the benefit limits.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the accumulator applies.',
    `pharmacy_claim_id` BIGINT COMMENT 'Foreign key linking to pharmacy.pharmacy_claim. Business justification: Accumulator (deductible/OOP) updates driven by pharmacy claims must reference the specific pharmacy claim that triggered the accumulator event. Required for True OOP tracking under CMS Part D, real-ti',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Accumulators (deductible, OOP max) are tracked at the policy level and reset per policy benefit period. Linking accumulator to policy enables accurate benefit period boundary enforcement, accumulator ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Accumulators (deductible/OOP) are tracked separately by network tier per ACA and plan design requirements. The plain network_tier text field is a denormalized representation of network.tier. A direc',
    `accumulated_amount` DECIMAL(18,2) COMMENT 'Total amount that has been applied to the accumulator to date.',
    `accumulator_code` STRING COMMENT 'Business identifier code for the accumulator, used in reporting and member communications.',
    `accumulator_description` STRING COMMENT 'Optional free‑form description or notes about the accumulator record.',
    `accumulator_status` STRING COMMENT 'Current lifecycle status of the accumulator record.. Valid values are `active|inactive|closed|pending|suspended|expired`',
    `accumulator_type` STRING COMMENT 'Type of benefit being tracked (e.g., deductible, out‑of‑pocket maximum).. Valid values are `deductible|oop_max|visit_limit|rx_limit|hospital_stay|annual_max`',
    `adjustment_reason` STRING COMMENT 'Free‑text or coded reason describing why an adjustment was applied.',
    `benefit_category` STRING COMMENT 'High‑level category of the benefit tracked by the accumulator.. Valid values are `medical|dental|vision|pharmacy|wellness|behavioral`',
    `benefit_period_end` DATE COMMENT 'Last day of the benefit period for which the accumulator is calculated.',
    `benefit_period_start` DATE COMMENT 'First day of the benefit period for which the accumulator is calculated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the accumulator record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent claim event that modified the accumulator.',
    `is_adjustment` BOOLEAN COMMENT 'Indicates whether the latest change to the accumulator was an adjustment (e.g., post‑payment correction).',
    `is_reversal` BOOLEAN COMMENT 'True if the most recent transaction reversed a prior accumulator entry.',
    `last_reset_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent reset of the accumulator (e.g., annual renewal).',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed for the accumulator in the benefit period.',
    `line_of_business` STRING COMMENT 'Business segment classification for the members coverage.. Valid values are `individual|group|employer|government|commercial|medicare`',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Amount remaining before the member reaches the benefit limit.',
    `reversal_reason` STRING COMMENT 'Reason code or description for a reversal operation.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the accumulator record (e.g., Facets, QNXT).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the accumulator record.',
    CONSTRAINT pk_accumulator PRIMARY KEY(`accumulator_id`)
) COMMENT 'Member-level benefit accumulator ledger tracking deductibles, out-of-pocket maximums (MOOP), visit limits, and other benefit thresholds applied during claims adjudication. Captures current balances (accumulated amount, remaining balance, benefit limit) by member, benefit period, accumulator type, LOB, plan, and network tier, plus the full transaction-level audit trail of credits, debits, reversals, and resets applied by each claim event. Supports real-time adjudication decisions, ACA MOOP compliance, and member cost-sharing transparency.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`claim`.`payer` (
    `payer_id` BIGINT COMMENT 'Primary key for payer',
    `account_balance` DECIMAL(18,2) COMMENT 'Current balance of the payers account.',
    `account_currency` STRING COMMENT 'ISO 4217 currency code for the payers account.',
    `account_number` STRING COMMENT 'Bank account number used for payments to the payer.',
    `account_status` STRING COMMENT 'Lifecycle status of the payers account.',
    `address_line1` STRING COMMENT 'First line of the payers address.',
    `address_line2` STRING COMMENT 'Second line of the payers address, if applicable.',
    `business_number` STRING COMMENT 'Business registration number for the payer.',
    `city` STRING COMMENT 'City of the payers address.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the payer.',
    `contact_name` STRING COMMENT 'Name of the primary contact person for the payer.',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the payer.',
    `contract_end_date` DATE COMMENT 'End date of the payers contract.',
    `contract_number` STRING COMMENT 'Identifier for the payers contract with the insurer.',
    `contract_start_date` DATE COMMENT 'Start date of the payers contract.',
    `contract_status` STRING COMMENT 'Current status of the payers contract.',
    `country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the payers address.',
    `coverage_end_date` DATE COMMENT 'End date of coverage provided by the payer.',
    `coverage_start_date` DATE COMMENT 'Start date of coverage provided by the payer.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the payer record was first created.',
    `deleted_at` TIMESTAMP COMMENT 'Timestamp when the payer record was soft-deleted.',
    `lei` STRING COMMENT 'Legal Entity Identifier for the payer.',
    `logo_url` STRING COMMENT 'URL to the payers logo image.',
    `notes` STRING COMMENT 'Additional notes or remarks about the payer.',
    `payer_name` STRING COMMENT 'Legal name of the payer organization.',
    `payer_state` STRING COMMENT 'State or province abbreviation of the payers address.',
    `payer_status` STRING COMMENT 'Current lifecycle status of the payer.',
    `payer_type` STRING COMMENT 'Category of the payer entity.',
    `payment_cycle` STRING COMMENT 'Description of the payment cycle for the payer.',
    `payment_frequency` STRING COMMENT 'Frequency of payments to the payer.',
    `payment_method` STRING COMMENT 'Preferred method of payment to the payer.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the payer.',
    `rating` STRING COMMENT 'Rating assigned to the payer by the insurer.',
    `rating_source` STRING COMMENT 'Source of the rating for the payer.',
    `risk_category` STRING COMMENT 'Risk category classification for the payer.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the payer.',
    `tax_number` STRING COMMENT 'Employer Identification Number (EIN) for the payer.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payer record.',
    `website` STRING COMMENT 'Official website URL of the payer.',
    `zip` STRING COMMENT 'ZIP or postal code of the payers address.',
    CONSTRAINT pk_payer PRIMARY KEY(`payer_id`)
) COMMENT 'Master reference table for payer. Referenced by primary_payer_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ADD CONSTRAINT `fk_claim_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ADD CONSTRAINT `fk_claim_diagnosis_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ADD CONSTRAINT `fk_claim_procedure_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ADD CONSTRAINT `fk_claim_adjudication_line_id` FOREIGN KEY (`line_id`) REFERENCES `health_insurance_ecm`.`claim`.`line`(`line_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `health_insurance_ecm`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `health_insurance_ecm`.`claim`.`denial`(`denial_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ADD CONSTRAINT `fk_claim_eob_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `health_insurance_ecm`.`claim`.`payment`(`payment_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `health_insurance_ecm`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_denial_id` FOREIGN KEY (`denial_id`) REFERENCES `health_insurance_ecm`.`claim`.`denial`(`denial_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_line_id` FOREIGN KEY (`line_id`) REFERENCES `health_insurance_ecm`.`claim`.`line`(`line_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ADD CONSTRAINT `fk_claim_adjustment_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `health_insurance_ecm`.`claim`.`payment`(`payment_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `health_insurance_ecm`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ADD CONSTRAINT `fk_claim_denial_line_id` FOREIGN KEY (`line_id`) REFERENCES `health_insurance_ecm`.`claim`.`line`(`line_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `health_insurance_ecm`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ADD CONSTRAINT `fk_claim_cob_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `health_insurance_ecm`.`claim`.`payer`(`payer_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `health_insurance_ecm`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ADD CONSTRAINT `fk_claim_payment_payment_claim_header_id` FOREIGN KEY (`payment_claim_header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_adjudication_id` FOREIGN KEY (`adjudication_id`) REFERENCES `health_insurance_ecm`.`claim`.`adjudication`(`adjudication_id`);
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ADD CONSTRAINT `fk_claim_accumulator_header_id` FOREIGN KEY (`header_id`) REFERENCES `health_insurance_ecm`.`claim`.`header`(`header_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`claim` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `health_insurance_ecm`.`claim` SET TAGS ('dbx_domain' = 'claim');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `capitation_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Capitation Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `cobra_election_id` SET TAGS ('dbx_business_glossary_term' = 'Cobra Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `eligibility_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Claiming Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `inpatient_admission_id` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Admission Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `medicaid_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligibility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `medicare_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Medicare Entitlement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `member_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Member Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `pcp_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Assignment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `plan_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Care Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Party Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `um_case_id` SET TAGS ('dbx_business_glossary_term' = 'Um Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `vbc_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Billing Provider NPI');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billing_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled|global|per_diem');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Claim Service Date (Start)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_line_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Count');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number (CLM)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_source` SET TAGS ('dbx_business_glossary_term' = 'Claim Source');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_source` SET TAGS ('dbx_value_regex' = 'edi|paper|portal|api');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|adjudicated|paid|denied|suspended');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type (PROF/INST/DENT/VIS/BEH)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental|vision|behavioral');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `claim_version` SET TAGS ('dbx_business_glossary_term' = 'Claim Version');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `cob_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes (ICD-10)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Related Group (DRG) Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `drg_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `is_hipaa_compliant` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Compliance Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `is_mlr_excluded` SET TAGS ('dbx_business_glossary_term' = 'Medical Loss Ratio Exclusion Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `is_suspended` SET TAGS ('dbx_business_glossary_term' = 'Suspended Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `length_of_stay` SET TAGS ('dbx_business_glossary_term' = 'Length of Stay (Days)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code (POS)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Claim Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `prior_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|adjudicated|paid|denied|suspended');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `procedure_codes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Codes (CPT/HCPCS)');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Referral Provider NPI');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `referral_provider_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'SLA Due Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`header` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `auth_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Auth Service Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (CLM_ID)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `fee_schedule_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Line Adjustment Reason Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `anesthesia_minutes` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Minutes');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `cob_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits Paid Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Line Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `emergency_indicator` SET TAGS ('dbx_business_glossary_term' = 'Emergency Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `epsdt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Early and Periodic Screening, Diagnostic, and Treatment (EPSDT) Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `family_planning_indicator` SET TAGS ('dbx_business_glossary_term' = 'Family Planning Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'posted|pending|denied|reversed|adjusted');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type (Professional/Institutional/Dental)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 1');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 2');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 3');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier 4');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `patient_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Responsibility Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `remark_code` SET TAGS ('dbx_business_glossary_term' = 'Remark Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `health_insurance_ecm`.`claim`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Line Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `hcc_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Hcc Mapping Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `chronic_condition_flag` SET TAGS ('dbx_business_glossary_term' = 'Chronic Condition Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Line Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deleted|pending');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_value_regex' = 'principal|admitting|external_cause|other');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `diagnosis_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'DRG Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `drg_description` SET TAGS ('dbx_business_glossary_term' = 'DRG Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Condition Category (HCC)');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `hcc_category` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `icd_version` SET TAGS ('dbx_business_glossary_term' = 'ICD Version');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `icd_version` SET TAGS ('dbx_value_regex' = 'ICD-9|ICD-10');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `line_quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Present on Admission Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `poa_indicator` SET TAGS ('dbx_value_regex' = 'Y|N|U');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `qualifier` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Qualifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Sequence Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Facets|QNXT|Other');
ALTER TABLE `health_insurance_ecm`.`claim`.`diagnosis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` SET TAGS ('dbx_subdomain' = 'claim_submission');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `procedure_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `auth_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Auth Service Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Surgeon Provider Provider Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `anesthesia_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Time (Minutes)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `billing_category` SET TAGS ('dbx_business_glossary_term' = 'Billing Category');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `billing_category` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|professional|institutional');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Charge Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `claim_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `claim_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `claim_line_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'open|closed|denied|paid|reversed');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `code_system` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code System');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `code_system` SET TAGS ('dbx_value_regex' = 'ICD-10-PCS|CPT|HCPCS');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|CHF');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Codes');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `diagnosis_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `documentation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Documentation Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `documentation_indicator` SET TAGS ('dbx_value_regex' = 'complete|partial|missing');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `drg_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis‑Related Group (DRG) Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `drg_weight` SET TAGS ('dbx_business_glossary_term' = 'DRG Weight');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedure Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `is_outpatient` SET TAGS ('dbx_business_glossary_term' = 'Outpatient Procedure Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `is_primary_procedure` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Procedure Laterality');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|none');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `modifier` SET TAGS ('dbx_business_glossary_term' = 'Procedure Modifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Procedure Net Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Procedure Notes');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (ICD‑10‑PCS / CPT / HCPCS)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `procedure_date` SET TAGS ('dbx_business_glossary_term' = 'Procedure Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_business_glossary_term' = 'Procedure Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `procedure_status` SET TAGS ('dbx_value_regex' = 'performed|scheduled|cancelled|pending');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `procedure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Procedure Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `quality_measure_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `risk_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk Adjustment Factor (RAF)');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Procedure Sequence');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `service_location_type` SET TAGS ('dbx_business_glossary_term' = 'Service Location Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `service_location_type` SET TAGS ('dbx_value_regex' = 'hospital|clinic|outpatient_center|home');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `surgeon_name` SET TAGS ('dbx_business_glossary_term' = 'Surgeon Name');
ALTER TABLE `health_insurance_ecm`.`claim`.`procedure` ALTER COLUMN `units_of_service` SET TAGS ('dbx_business_glossary_term' = 'Units of Service');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `header_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `cost_share_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Rule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID (NPI)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `provider_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('dbx_business_glossary_term' = 'Deductible Accumulator Impact');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `accumulator_deductible_impact` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('dbx_business_glossary_term' = 'OOP Accumulator Impact');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `accumulator_oop_impact` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `adjudication_number` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Number (External Identifier)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `adjudication_status` SET TAGS ('dbx_value_regex' = 'paid|denied|pended|suspended|voided');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `adjudication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `admission_date` SET TAGS ('dbx_business_glossary_term' = 'Admission Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `allowed_amount_method` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount Calculation Method');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `allowed_amount_method` SET TAGS ('dbx_value_regex' = 'fee_schedule|mac|rbp|capitation|custom');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `auto_adjudication_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Adjudication Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'professional|institutional|dental|vision|behavioral');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'COB Adjusted Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `cob_adjusted_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `cob_processing_result` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Processing Result');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `cob_processing_result` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|none');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount Applied');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `discharge_date` SET TAGS ('dbx_business_glossary_term' = 'Discharge Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `duplicate_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Claim Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_bypass_reason` SET TAGS ('dbx_business_glossary_term' = 'Edit Bypass Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_code` SET TAGS ('dbx_business_glossary_term' = 'Edit Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_description` SET TAGS ('dbx_business_glossary_term' = 'Edit Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Edit Outcome');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|bypass|override');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_override_authority` SET TAGS ('dbx_business_glossary_term' = 'Edit Override Authority');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Edit Override Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `edit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edit Evaluation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('dbx_business_glossary_term' = 'Out‑Of‑Pocket (OOP) Amount Applied');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `oop_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `prior_authorization_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|not_required');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `timeliness_flag` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charged Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Payable Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjudication` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `eob_id` SET TAGS ('dbx_business_glossary_term' = 'Explanation of Benefits (EOB) ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Eob Claim Header Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `allowed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `appeal_rights_text` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Text');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `appeal_rights_version` SET TAGS ('dbx_business_glossary_term' = 'Appeal Rights Version');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `billed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `claim_icn` SET TAGS ('dbx_business_glossary_term' = 'Claim Internal Control Number (ICN)');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'COB Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `cob_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|portal|edi');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `denial_reason_summary` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Summary');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'EOB Document Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `eob_status` SET TAGS ('dbx_business_glossary_term' = 'EOB Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `eob_status` SET TAGS ('dbx_value_regex' = 'generated|delivered|suppressed|error');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `eob_type` SET TAGS ('dbx_business_glossary_term' = 'EOB Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `eob_type` SET TAGS ('dbx_value_regex' = 'member|provider');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'EOB Generation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('dbx_business_glossary_term' = 'Member Responsibility Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `member_responsibility_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `member_responsibility_type` SET TAGS ('dbx_business_glossary_term' = 'Member Responsibility Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `member_responsibility_type` SET TAGS ('dbx_value_regex' = 'deductible|copay|coinsurance|non_covered');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Plan Paid Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `plan_paid_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `remark_codes` SET TAGS ('dbx_business_glossary_term' = 'Remark Codes');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `sbc_reference` SET TAGS ('dbx_business_glossary_term' = 'SBC Reference');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `suppression_flag` SET TAGS ('dbx_business_glossary_term' = 'EOB Suppression Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`eob` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adverse_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Determination Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `fwa_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fwa Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Claim Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|completed');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'void|replacement|correction|retroactive');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `audit_source` SET TAGS ('dbx_business_glossary_term' = 'Audit Source');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `audit_source` SET TAGS ('dbx_value_regex' = 'internal|rac|oig|provider_self_disclosure');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'post_payment|pre_payment|clinical|coding|billing');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `compliance_60_day_rule` SET TAGS ('dbx_business_glossary_term' = 'CMS 60‑Day Rule Compliance');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `demand_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Demand Lifecycle Stage');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `demand_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'demand_created|demand_sent|demand_received|demand_resolved');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code (ICD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `diagnosis_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `initiator_role` SET TAGS ('dbx_business_glossary_term' = 'Initiator Role');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `initiator_role` SET TAGS ('dbx_value_regex' = 'claims_adjuster|auditor|provider|member|system');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `is_fraud` SET TAGS ('dbx_business_glossary_term' = 'Is Fraud Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `net_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Claim Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `overpayment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `overpayment_type` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `overpayment_type` SET TAGS ('dbx_value_regex' = 'duplicate|incorrect_rate|ineligible_member|billing_error|fraud');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code (CPT/HCPCS)');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `procedure_code` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'offset|check|installment|write_off');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'pending|in_process|completed|failed');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|closed|escalated');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Sequence');
ALTER TABLE `health_insurance_ecm`.`claim`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Identifier (DENIAL_ID)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier (CLAIM_ID)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `header_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Denial Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `medical_policy_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (MEMBER_ID)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `appeal_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `carc_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Code (CARC)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `clinical_criteria` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Code (InterQual/MCG)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_number` SET TAGS ('dbx_business_glossary_term' = 'Denial Number (DENIAL_NUM)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_status` SET TAGS ('dbx_business_glossary_term' = 'Denial Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|appealed|resolved|closed|rejected');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_business_glossary_term' = 'Denial Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denial_type` SET TAGS ('dbx_value_regex' = 'clinical|administrative|technical|cob|timely_filing');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denied_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Adjustment Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denied_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Gross Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `denied_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Denied Net Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `letter_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Letter Generated Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Determination Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `medical_necessity_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Denial Management Notes');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Denial Override Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Override Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `override_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `rac_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Code (RARC)');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `reason_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Resolution Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Denial Resolution Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|withdrawn|closed');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Denial Record');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Denial Subtype');
ALTER TABLE `health_insurance_ecm`.`claim`.`denial` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `cob_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Claim Header Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `cob_record_id` SET TAGS ('dbx_business_glossary_term' = 'Cob Record Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `claim_icn` SET TAGS ('dbx_business_glossary_term' = 'Claim Internal Control Number (ICN)');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `claim_line_count` SET TAGS ('dbx_business_glossary_term' = 'Claim Line Count');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `cob_method` SET TAGS ('dbx_business_glossary_term' = 'COB Method');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `cob_method` SET TAGS ('dbx_value_regex' = 'standard|non_duplication|maintenance_of_benefits');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_business_glossary_term' = 'COB Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `cob_status` SET TAGS ('dbx_value_regex' = 'pending|processed|error|reversed');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `crossover_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Crossover Claim Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Claim Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `medicaid_crossover_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Crossover Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `msp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medicare Secondary Payer (MSP) Indicator');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `msp_type` SET TAGS ('dbx_business_glossary_term' = 'MSP Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `msp_type` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `net_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Liability After COB');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `primary_payer_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Allowed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `primary_payer_denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Denial Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `primary_payer_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Payer Paid Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `process_order` SET TAGS ('dbx_business_glossary_term' = 'COB Processing Order');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'COB Processed Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('dbx_business_glossary_term' = 'Processing User Name');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `processing_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `total_allowed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`cob` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `header_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_claim_header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `party_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_payer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `reinsurance_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `batch_sequence` SET TAGS ('dbx_business_glossary_term' = 'Batch Sequence Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `carc_codes` SET TAGS ('dbx_business_glossary_term' = 'Claim Adjustment Reason Codes (CARC)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'clearinghouse|direct|bank');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `clearinghouse_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `clearinghouse_name` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Name');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `cycle` SET TAGS ('dbx_business_glossary_term' = 'Payment Cycle');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'GL Account Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `gl_reference_number` SET TAGS ('dbx_business_glossary_term' = 'GL Reference Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Is Reconciled Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `is_returned` SET TAGS ('dbx_business_glossary_term' = 'Is Returned Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Payment Note');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payee_type` SET TAGS ('dbx_value_regex' = 'provider|member|other');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'eft|check|virtual_card|capitation_offset');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_source` SET TAGS ('dbx_business_glossary_term' = 'Payment Source');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'issued|cleared|voided|returned|stopped');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'claim_payment|capitation|rebate|adjustment');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `racr_codes` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Remark Codes (RARC)');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Reason Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|pending');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `returned_reason` SET TAGS ('dbx_business_glossary_term' = 'Returned Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `trace_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Trace Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `transaction_control_number` SET TAGS ('dbx_business_glossary_term' = '835 Transaction Control Number');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` SET TAGS ('dbx_subdomain' = 'benefit_management');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_id` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `adjudication_id` SET TAGS ('dbx_business_glossary_term' = 'Adjudication Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Header Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `pharmacy_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Claim Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulated_amount` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_code` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Code');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_description` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Description');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Status');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending|suspended|expired');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_type` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Type');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `accumulator_type` SET TAGS ('dbx_value_regex' = 'deductible|oop_max|visit_limit|rx_limit|hospital_stay|annual_max');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `benefit_category` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|wellness|behavioral');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `benefit_period_end` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `benefit_period_start` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Accumulator Event Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `last_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reset Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limit Amount');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'individual|group|employer|government|commercial|medicare');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`claim`.`accumulator` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` SET TAGS ('dbx_subdomain' = 'benefit_management');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `account_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `account_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `business_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `business_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `lei` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `lei` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`claim`.`payer` ALTER COLUMN `tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
