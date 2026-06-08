-- Schema for Domain: underwriting | Business: Life Insurance | Version: v1_mvm
-- Generated on: 2026-05-04 07:01:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`underwriting` COMMENT 'Risk assessment and new business (NB) decisioning for life and annuity applications. Owns medical underwriting (APS, MIB lookups), financial underwriting, automated rules engine outputs, risk classifications, STOLI detection, and facultative/automatic reinsurance placement decisions. Manages underwriting workbench workflows, evidence requirements, mortality/morbidity risk evaluation, and NAR calculation for policy changes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`application` (
    `application_id` BIGINT COMMENT 'Primary key for application',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Application intake captures payer and billing setup preferences that establish the billing account for premium collection post-issue. Essential for new business processing workflow linking underwritin',
    `acord_form_id` BIGINT COMMENT 'Foreign key linking to document.acord_form. Business justification: Every life insurance application is submitted on a specific ACORD form version (e.g., ACORD 103, 104). This FK is required for NIGO resolution (wrong form version), compliance audits, and state-specif',
    `agency_id` BIGINT COMMENT 'Reference to the agency, Brokerage General Agency (BGA), or Managing General Agent (MGA) through which the application was submitted.',
    `automatic_binding_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.automatic_binding_limit. Business justification: During new business intake, the application is evaluated against the automatic binding limit to determine if it qualifies for STP processing. Referencing the specific binding limit record supports tre',
    `hierarchy_node_id` BIGINT COMMENT 'Foreign key linking to agent.hierarchy_node. Business justification: Commission override calculation and production reporting require the hierarchy node at time of application submission. Producers can move between nodes post-submission; capturing hierarchy_node_id at ',
    `jurisdiction_license_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_license. Business justification: Applications can only be accepted in jurisdictions where the company holds a valid license. Direct FK enables pre-issuance compliance validation that the company is licensed to write business in the a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Applications are written by specific legal entities (insurance carriers). Essential for statutory reporting, RBC calculations, consolidation, and regulatory filings. NAIC annual statements require app',
    `party_id` BIGINT COMMENT 'Reference to the proposed policy owner if different from the applicant. Nullable for owner-insured applications.',
    `plan_id` BIGINT COMMENT 'Reference to the life or annuity product applied for (e.g., Whole Life, Universal Life, Indexed Universal Life, Fixed Indexed Annuity, Single Premium Immediate Annuity).',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Applications must reference the exact plan version in effect at submission to apply correct underwriting class structure, rate tables, and regulatory forms. Plan versions have different underwriting e',
    `producer_id` BIGINT COMMENT 'Reference to the writing agent, broker, or producer who submitted the application.',
    `producer_product_auth_id` BIGINT COMMENT 'Foreign key linking to agent.producer_product_auth. Business justification: Regulatory compliance and E&O audit trails require capturing which producer_product_auth record was active at application submission. Producer authorizations can be revoked or modified post-submission',
    `reinsurer_id` BIGINT COMMENT 'Reference to the reinsurance company assuming risk for this application under facultative or automatic reinsurance arrangements. Null if fully retained.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to commission.commission_schedule. Business justification: Applications must reference the commission schedule in effect at submission to calculate producer compensation. Critical for commission calculation, producer statements, and regulatory compliance (ens',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Variable product applications directly reference separate account funds chosen by applicant for premium investment. Essential for variable life/annuity underwriting and policy issuance. Separate accou',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: The applied-for underwriting class is a core underwriting input driving evidence requirements, rules engine evaluation, and premium calculation. `underwriting_class` plain column is a denormalized tex',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Anti-Money Laundering (AML) risk score (0-100) based on applicant profile, premium amount, payment source, and geographic risk factors. High scores trigger enhanced due diligence.',
    `application_date` DATE COMMENT 'Date the application was signed by the applicant. This is the official application date used for age calculation, rate determination, and contestability period start.',
    `application_number` STRING COMMENT 'Externally-known business identifier for the application, typically printed on application forms and used in agent/customer communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `application_status` STRING COMMENT 'Current workflow status of the application in the underwriting process. NIGO (Not In Good Order) indicates incomplete or deficient submission requiring correction before underwriting can proceed. [ENUM-REF-CANDIDATE: submitted|nigo|in_underwriting|pending_requirements|approved|declined|withdrawn|postponed — 8 candidates stripped; promote to reference product]',
    `application_type` STRING COMMENT 'Classification of the application purpose: new business (NB), replacement of existing coverage, conversion from group or term, or reinstatement of lapsed policy.. Valid values are `new_business|replacement|conversion|reinstatement`',
    `aps_required` BOOLEAN COMMENT 'Indicates whether an Attending Physician Statement (APS) is required from the applicants treating physician to clarify medical history or current conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this application record was first created in the underwriting workbench system.',
    `decision_date` DATE COMMENT 'Date the final underwriting decision (approved, declined, postponed, or withdrawn) was made. Null for applications still in process.',
    `decision_reason` STRING COMMENT 'Detailed explanation of the underwriting decision, including specific medical, financial, or lifestyle factors that influenced the risk classification or declination.',
    `exchange_1035_flag` BOOLEAN COMMENT 'Indicates whether this application involves a tax-free 1035 exchange under IRC Section 1035, allowing transfer of cash value from an existing policy or annuity without immediate tax consequences.',
    `face_amount` DECIMAL(18,2) COMMENT 'Requested death benefit (DB) amount for life insurance applications. For annuities, this represents the initial premium or account value (AV) amount.',
    `financial_underwriting_required` BOOLEAN COMMENT 'Indicates whether financial underwriting is required to verify the applicants income, net worth, and financial justification for the requested coverage amount.',
    `flat_extra_amount` DECIMAL(18,2) COMMENT 'Additional flat premium per thousand of coverage applied for specific temporary or permanent risks (e.g., hazardous occupation, avocation). Expressed as dollars per thousand of face amount.',
    `kyc_status` STRING COMMENT 'Status of Know Your Customer (KYC) identity verification and due diligence process required for AML compliance.. Valid values are `not_started|in_progress|completed|failed`',
    `medical_exam_required` BOOLEAN COMMENT 'Indicates whether a paramedical examination is required based on face amount, age, and preliminary health questions.',
    `mib_check_status` STRING COMMENT 'Status of Medical Information Bureau (MIB) database check for prior insurance applications and medical history disclosures.. Valid values are `not_requested|pending|completed|no_record`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this application record was last modified in the underwriting workbench system.',
    `nar_amount` DECIMAL(18,2) COMMENT 'Net Amount at Risk (NAR) calculated as the death benefit minus the policy account value or reserve. Represents the insurers pure mortality risk exposure.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the application is Not In Good Order (NIGO), meaning it is incomplete, missing required signatures, or contains errors that prevent underwriting from proceeding.',
    `nigo_reason` STRING COMMENT 'Detailed explanation of why the application was flagged as NIGO. May include missing signatures, incomplete medical history, missing beneficiary information, or payment issues.',
    `policy_issue_date` DATE COMMENT 'Date the policy was issued following underwriting approval and premium payment. Null for applications not yet issued.',
    `policy_number` STRING COMMENT 'Policy number assigned upon issuance. Links the application to the issued policy in the policy administration system. Null for applications not yet issued.. Valid values are `^[A-Z0-9]{8,20}$`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Proposed premium amount for the policy. For single premium products (e.g., SPIA), this is the lump sum. For recurring premium products, this is the periodic payment amount.',
    `premium_mode` STRING COMMENT 'Frequency of premium payments: annual, semi-annual, quarterly, monthly, or single premium.. Valid values are `annual|semi_annual|quarterly|monthly|single`',
    `replacement_indicator` BOOLEAN COMMENT 'Indicates whether this application involves replacement of existing life insurance or annuity coverage, triggering additional suitability and disclosure requirements.',
    `source_system` STRING COMMENT 'Operational system of record from which this application data originated (e.g., RGAX AURA, Swiss Re Magnum underwriting workbench, policy administration system NB intake module).. Valid values are `rgax_aura|swiss_re_magnum|policy_admin|crm`',
    `stoli_risk_score` DECIMAL(18,2) COMMENT 'Automated risk score (0-100) assessing the likelihood that this application represents Stranger-Originated Life Insurance (STOLI), an illegal or unethical arrangement where investors initiate policies on individuals with no insurable interest.',
    `submission_channel` STRING COMMENT 'Channel through which the application was submitted to the company (e.g., agent portal, paper mail, email, fax, API integration, point-of-sale system).. Valid values are `agent_portal|paper_mail|email|fax|api_integration|pos_system`',
    `submission_date` DATE COMMENT 'Date the application was received by the insurance company for underwriting review.',
    `table_rating` STRING COMMENT 'Substandard table rating (A through P) applied for increased mortality risk. Each table typically represents a 25% premium increase. Null for standard and preferred classes.. Valid values are `^[A-P]$|`',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Core master record for a new business (NB) life or annuity insurance application submitted for underwriting review. Captures applicant details, product applied for, face amount, application date, submission channel, NIGO flags, application source (agent, BGA, MGA), and current underwriting workflow status. This is the primary anchor entity for the underwriting domain, originating from the Underwriting Workbench (RGAX AURA / Swiss Re Magnum) and Policy Administration System NB intake module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the underwriting risk assessment record. Primary key for the risk assessment entity.',
    `application_id` BIGINT COMMENT 'Reference to the new business application being underwritten. Links this risk assessment to the originating application.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: The risk assessment is fundamentally performed on a specific insured — evaluating their medical history, build, occupation, and mortality risk. Direct FK supports regulatory audit trails, re-underwrit',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Risk assessments must be attributed to the legal entity performing underwriting for regulatory compliance, reserve adequacy analysis, and statutory reporting. Real business need: state insurance depar',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: The underwriting risk assessment assigns a medical risk classification to the applicant. The existing medical_risk_classification STRING column stores a denormalized value. Replacing it with a FK to t',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Risk assessments reference specific mortality tables for mortality risk scoring and risk classification. Real business need: underwriting decision support, mortality debits/credits calculation, risk c',
    `retention_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.retention_limit. Business justification: underwriting_risk_assessment has reinsurance_cession_required_flag driven by NAR vs. retention limits. Referencing the specific retention_limit record supports actuarial experience studies and regulat',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: The risk assessment determines which product underwriting class the insured qualifies for — this is the core output linking medical/financial risk evaluation to product pricing. Experience studies, mo',
    `aps_review_notes` STRING COMMENT 'Detailed underwriter notes documenting findings from the APS review, including significant medical conditions, treatment history, and clinical observations relevant to risk assessment.',
    `aps_review_outcome` STRING COMMENT 'Summary outcome of the Attending Physician Statement review. Captures the underwriters assessment of medical records obtained from the applicants treating physicians.. Valid values are `favorable|acceptable|adverse|declined`',
    `assessment_date` DATE COMMENT 'Date when the formal risk assessment was completed and the underwriting decision was rendered.',
    `assessment_number` STRING COMMENT 'Business-facing unique identifier for the risk assessment, typically displayed to underwriters and used in correspondence.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the risk assessment workflow. Tracks progression from initial submission through final underwriting decision. [ENUM-REF-CANDIDATE: pending|in_progress|completed|approved|declined|referred|suspended — 7 candidates stripped; promote to reference product]',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the risk assessment was finalized in the underwriting workbench system. Captures the exact moment of decision for audit and SLA tracking.',
    `assessment_type` STRING COMMENT 'Classification of the risk assessment based on the triggering event. Distinguishes between new business (NB) underwriting, policy change underwriting, and other assessment scenarios.. Valid values are `new_business|policy_change|reinstatement|conversion|increase`',
    `automated_rules_engine_decision` STRING COMMENT 'Initial decision rendered by the underwriting workbench automated rules engine. Straight-through processing (STP) cases receive auto-approve; complex cases are referred to manual underwriter review.. Valid values are `auto_approve|refer_to_underwriter|auto_decline`',
    `aviation_hazard_rating` STRING COMMENT 'Risk rating assigned for aviation-related activities. Evaluates frequency and type of flying (private pilot, commercial, military, recreational) and associated mortality risk.. Valid values are `none|low|moderate|high|declined`',
    `avocation_hazard_rating` STRING COMMENT 'Risk rating assigned for hazardous hobbies and recreational activities (e.g., skydiving, scuba diving, rock climbing, racing). Assesses additional mortality risk beyond standard underwriting.. Valid values are `none|low|moderate|high|declined`',
    `build_chart_result` STRING COMMENT 'Outcome of the height-weight-age build chart evaluation. Assesses whether the applicants body mass index (BMI) falls within acceptable underwriting guidelines.. Valid values are `preferred|standard|overweight|underweight`',
    `business_insurance_justification` STRING COMMENT 'Type of business insurance arrangement justifying the coverage. Applicable when the policy is owned by or benefits a business entity (e.g., key person insurance, buy-sell agreement funding).. Valid values are `key_person|buy_sell|executive_bonus|split_dollar|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was first created in the underwriting workbench system. Audit trail for record creation.',
    `decline_reason` STRING COMMENT 'Detailed explanation of the reason for declining the application. Required for regulatory compliance and adverse action notice requirements under FCRA.',
    `existing_coverage_inforce_amount` DECIMAL(18,2) COMMENT 'Total death benefit amount of all existing life insurance policies currently in force on the applicant across all carriers. Used to assess total coverage and detect potential over-insurance.',
    `financial_risk_classification` STRING COMMENT 'Financial underwriting decision outcome. Indicates whether the requested coverage amount is financially justified based on income, net worth, existing coverage, and insurable interest.. Valid values are `approved|approved_with_limits|declined`',
    `financial_statement_review_notes` STRING COMMENT 'Underwriter notes documenting the review of financial statements, tax returns, and other financial documentation. Captures income verification, net worth assessment, and financial justification for coverage.',
    `human_life_value_amount` DECIMAL(18,2) COMMENT 'Calculated human life value representing the present value of the insureds future earnings potential. Used to justify the requested death benefit amount in financial underwriting.',
    `income_replacement_multiple` DECIMAL(18,2) COMMENT 'Ratio of requested death benefit to annual income. Used to assess whether the coverage amount is reasonable relative to the applicants income. Typical guidelines range from 10x to 25x annual income.',
    `insurable_interest_determination` STRING COMMENT 'Underwriters determination of whether the applicant has a valid insurable interest in the insureds life. Required to prevent speculative life insurance purchases.. Valid values are `confirmed|questionable|not_established`',
    `life_settlement_broker_involvement_flag` BOOLEAN COMMENT 'Indicates whether a life settlement broker was involved in the application process. Life settlement broker involvement at policy inception is a strong STOLI indicator.',
    `manual_review_required_flag` BOOLEAN COMMENT 'Indicates whether manual underwriter review is required. Set to true when the automated rules engine refers the case or when additional evidence is needed.',
    `medical_risk_score` DECIMAL(18,2) COMMENT 'Quantitative medical underwriting risk score representing mortality and morbidity risk. Calculated from build chart results, APS review, MIB findings, and medical evidence. Higher scores indicate higher risk.',
    `mib_findings_summary` STRING COMMENT 'Summary of findings from the MIB inquiry, including any codes or alerts that indicate prior medical conditions, insurance applications, or underwriting decisions.',
    `mib_inquiry_date` DATE COMMENT 'Date when the MIB inquiry was submitted and results were received.',
    `mib_inquiry_performed_flag` BOOLEAN COMMENT 'Indicates whether an MIB inquiry was performed as part of the underwriting process. MIB provides information on prior insurance applications and medical history.',
    `nar_amount` DECIMAL(18,2) COMMENT 'Net Amount at Risk representing the insurers exposure. Calculated as the death benefit minus the policys account value or cash surrender value. Used to determine reinsurance cession requirements.',
    `nar_calculation_method` STRING COMMENT 'Method used to calculate the Net Amount at Risk. Varies by product type and accounting basis (statutory vs GAAP).. Valid values are `death_benefit_minus_av|death_benefit_minus_csv|statutory|gaap`',
    `premium_financing_flag` BOOLEAN COMMENT 'Indicates whether the policy premiums will be financed through a third-party loan. Premium financing with non-recourse loans is a common STOLI indicator.',
    `reinsurance_cession_required_flag` BOOLEAN COMMENT 'Indicates whether the NAR exceeds the companys retention limit and requires reinsurance cession. Triggers automatic or facultative reinsurance placement workflow.',
    `reinsurance_type` STRING COMMENT 'Type of reinsurance arrangement applicable to this risk. Automatic reinsurance applies to standard risks within treaty limits; facultative reinsurance requires individual case submission for substandard or jumbo risks.. Valid values are `automatic|facultative|not_applicable`',
    `siu_referral_flag` BOOLEAN COMMENT 'Indicates whether the application was referred to the Special Investigations Unit for fraud investigation. SIU referrals occur when STOLI, fraud, or other suspicious activity is detected.',
    `stoli_determination` STRING COMMENT 'Final determination of whether the application constitutes a STOLI arrangement. Confirmed STOLI cases result in application decline and potential regulatory reporting.. Valid values are `cleared|confirmed|inconclusive`',
    `stoli_indicator_flag` BOOLEAN COMMENT 'Flag indicating whether any STOLI red flags were detected during underwriting. STOLI involves investors purchasing life insurance on individuals with no insurable interest, often through deceptive arrangements.',
    `stoli_investigation_status` STRING COMMENT 'Status of the STOLI investigation workflow. Tracks the progression of compliance review when STOLI indicators are present.. Valid values are `not_required|pending|in_progress|completed|cleared|confirmed`',
    `underwriting_decision` STRING COMMENT 'Final underwriting decision outcome. Approved-as-applied issues at requested terms; approved-with-modifications issues with rate class changes, exclusions, or reduced coverage; declined rejects the application.. Valid values are `approved_as_applied|approved_with_modifications|declined|postponed|withdrawn`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk assessment record was last modified. Audit trail for tracking changes throughout the underwriting workflow.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Comprehensive underwriting risk evaluation master record for a life or annuity application, encompassing medical, financial, and compliance risk dimensions in a single holistic assessment. Medical underwriting: captures mortality and morbidity risk classification outputs, build chart results, aviation/avocation hazard ratings, APS review outcomes, MIB inquiry findings, and overall medical risk score. Financial underwriting: captures insurable interest determination, income replacement multiple analysis, human life value (HLV) calculation, business insurance justification (key person, buy-sell), existing coverage in-force summary, financial statement review notes, and financial underwriting decision outcome — ensures coverage amounts are financially justified and detects potential over-insurance. STOLI/IOLI detection: captures STOLI indicator flags (premium financing with non-recourse loans, investor-owned life insurance indicators, irrevocable trust ownership patterns, life settlement broker involvement, rapid policy transfer intent, unusual beneficiary designations), investigation status, compliance review outcome, state-specific STOLI statute compliance check, SIU referral flag, and STOLI determination (cleared, confirmed, inconclusive). Also captures NAR (Net Amount at Risk) calculations, NAR calculation method, and whether NAR triggers reinsurance cession thresholds. Represents the underwriters formal holistic risk evaluation tied to a specific application. Sourced from the Underwriting Workbench automated rules engine and manual underwriter review.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`risk_class` (
    `risk_class_id` BIGINT COMMENT 'Unique identifier for the risk classification category. Primary key for the risk class reference table.',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Risk class definitions are embedded in approved policy forms and require DOI policy form approval before use. Direct FK enables compliance teams to verify that each active risk class is authorized by ',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Risk classification rules must comply with state regulations prohibiting unfair discrimination (gender, genetic information, HIV status). Business process: state regulatory compliance for underwriting',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Risk classes must map to product-defined underwriting classes to drive COI rate schedule lookups, benefit eligibility, and premium rate table selection. Actuarial pricing and policy issuance depend on',
    `age_band_max` STRING COMMENT 'Maximum age (in years) for which this risk class is applicable. Null if no upper age limit applies.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) for which this risk class is applicable. Used to define age-specific risk classification rules.',
    `aml_risk_score` STRING COMMENT 'Anti-Money Laundering (AML) risk score (0-100) associated with this risk class for Know Your Customer (KYC) and AML compliance. Higher scores indicate elevated AML risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk class record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `decline_reason_category` STRING COMMENT 'High-level category for decline or postpone decisions: medical (health impairments), financial (insufficient income/net worth), lifestyle (hazardous avocations), legal (criminal history), fraud (misrepresentation), or other. Applicable only to decline/postpone risk classes.. Valid values are `medical|financial|lifestyle|legal|fraud|other`',
    `effective_date` DATE COMMENT 'Date on which this risk class becomes effective for new business (NB) underwriting decisions. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date on which this risk class is no longer valid for new underwriting decisions. Null if the risk class is currently active with no planned expiration. Format: yyyy-MM-dd.',
    `flat_extra_duration_months` STRING COMMENT 'Duration in months for which the flat extra charge applies. Null for permanent flat extras or when flat extra is not applicable.',
    `flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Additional premium charge per thousand dollars of coverage (e.g., $2.50 per $1,000 of death benefit (DB)) applied for temporary or permanent extra risk. Used for occupational hazards, avocations, or medical impairments. Null if not applicable.',
    `gender_applicability` STRING COMMENT 'Gender for which this risk class applies: male, female, unisex (gender-neutral pricing), or all (applies to all genders).. Valid values are `male|female|unisex|all`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk class record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `morbidity_multiplier` DECIMAL(18,2) COMMENT 'Numeric multiplier applied to standard morbidity rates for disability income (DI) and long-term care (LTC) products. Standard class = 1.00; preferred < 1.00; substandard > 1.00.',
    `mortality_multiplier` DECIMAL(18,2) COMMENT 'Numeric multiplier applied to standard mortality rates for this risk class. Standard class = 1.00; preferred classes < 1.00; substandard classes > 1.00. Used in premium rate calculation and actuarial valuation.',
    `nar_calculation_method` STRING COMMENT 'Method used to calculate Net Amount at Risk (NAR) for policies assigned this risk class. Standard = DB minus Account Value (AV); enhanced/reduced = adjusted for risk class; custom = product-specific formula.. Valid values are `standard|enhanced|reduced|custom`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or clarifications regarding the use and interpretation of this risk class.',
    `product_line_applicability` STRING COMMENT 'Comma-separated list of product lines to which this risk class applies (e.g., Term Life, Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL), Variable Universal Life (VUL), Fixed Indexed Annuity (FIA), Single Premium Immediate Annuity (SPIA), Disability Income (DI), Long-Term Care (LTC)).',
    `regulatory_approval_required` BOOLEAN COMMENT 'Flag indicating whether state insurance department approval is required before using this risk class. True if approval needed; false otherwise.',
    `risk_class_category` STRING COMMENT 'High-level category grouping for the risk classification: preferred (super-preferred and preferred), standard (standard plus and standard), substandard (table ratings and flat extras), decline, postpone, or rated.. Valid values are `preferred|standard|substandard|decline|postpone|rated`',
    `risk_class_code` STRING COMMENT 'Short alphanumeric code representing the risk classification (e.g., PP, PREF, STD, TABLE_A, DECLINE). Used as the business identifier for underwriting decisioning and system integration.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `risk_class_description` STRING COMMENT 'Detailed description of the risk classification criteria, underwriting guidelines, and applicability conditions for this risk class.',
    `risk_class_name` STRING COMMENT 'Full descriptive name of the risk classification category (e.g., Preferred Plus, Standard, Substandard Table B, Decline).',
    `risk_class_status` STRING COMMENT 'Current lifecycle status of the risk class: active (in use), inactive (not currently used), pending approval (awaiting regulatory approval), deprecated (replaced by newer class), or suspended (temporarily not available).. Valid values are `active|inactive|pending_approval|deprecated|suspended`',
    `smoker_status` STRING COMMENT 'Tobacco usage classification for this risk class: smoker, non-smoker, tobacco user (includes cigars, pipes, chewing tobacco), non-tobacco user, or not applicable (for classes where smoking distinction is not used).. Valid values are `smoker|non_smoker|tobacco_user|non_tobacco_user|not_applicable`',
    `source_system` STRING COMMENT 'Name of the source system from which this risk class definition originated (e.g., Underwriting Workbench, Policy Administration System (PAS), Actuarial Valuation System).',
    `stoli_indicator` BOOLEAN COMMENT 'Flag indicating whether this risk class is associated with Stranger-Originated Life Insurance (STOLI) detection rules. True if STOLI risk factors are present; false otherwise.',
    `table_rating_code` STRING COMMENT 'Substandard table rating designation (Table A through P, or Table 1 through 16). Each table represents an incremental mortality increase (typically 25% per table). Null for non-table-rated classes.. Valid values are `^(TABLE_[A-P]|TABLE_[1-9]|TABLE_1[0-6])?$`',
    `table_rating_factor` DECIMAL(18,2) COMMENT 'Numeric factor corresponding to the table rating (e.g., Table A = 1.25, Table B = 1.50). Used to calculate substandard premium adjustments. Null for non-table-rated classes.',
    `underwriting_method` STRING COMMENT 'Underwriting approach used to assign this risk class: full underwriting (medical exams, Attending Physician Statement (APS), Medical Information Bureau (MIB) checks), simplified issue (health questions only), guaranteed issue (no health questions), accelerated underwriting (data-driven, minimal evidence), or automated underwriting (rules engine-based).. Valid values are `full_underwriting|simplified_issue|guaranteed_issue|accelerated_underwriting|automated_underwriting`',
    `version_number` STRING COMMENT 'Version number of this risk class definition. Incremented with each modification to support change tracking and historical analysis.',
    CONSTRAINT pk_risk_class PRIMARY KEY(`risk_class_id`)
) COMMENT 'Reference table defining all underwriting risk classification categories used in life and annuity mortality and morbidity risk decisioning. Includes standard classifications: Preferred Plus (Super Preferred), Preferred, Standard Plus, Standard, Substandard Table Ratings (Table A through P / Table 1 through 16), Flat Extra per thousand ratings, Decline, and Postpone. Stores rating code, description, mortality multiplier, table rating factor, smoker/non-smoker distinction, and product line applicability. Used to standardize risk class assignments across all underwriting decisions and feeds into premium rate determination and reinsurance cession classification.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`decision` (
    `decision_id` BIGINT COMMENT 'Primary key for decision',
    `application_id` BIGINT COMMENT 'Reference to the new business application that this underwriting decision was issued for.',
    `chargeback_rule_id` BIGINT COMMENT 'Foreign key linking to commission.chargeback_rule. Business justification: Post-issue rescission commission recovery: when an underwriting decision triggers policy rescission (material misrepresentation, STOLI, fraud), the applicable chargeback_rule governs commission recove',
    `reinsurer_id` BIGINT COMMENT 'Reference to the facultative reinsurer if facultative reinsurance was placed. Null for automatic reinsurance or retained cases.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy record if the application was approved and issued. Null for declined or postponed decisions.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Underwriting decisions produce formal decision letters, decline notifications, and approval documents sent to applicants and producers. Business process: policy issuance workflow and producer notifica',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: The underwriting decision (table rating, flat extra, exclusion rider applied) is made about a specific insured. The insured record carries underwriting_decision and underwriting_decision_date as denor',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Underwriting decisions must be tracked by legal entity for regulatory reporting, RBC calculations, and statutory compliance. Real business need: NAIC annual statements require decision statistics (app',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Underwriting decisions document which mortality table was used for final risk classification and pricing. Real business need: audit trail, reinsurance facultative submissions, regulatory examination s',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Underwriting decisions are governed by a specific plan versions rules, rate tables, and benefit structures. Regulatory audits and policy issuance require traceability of which plan version governed t',
    `premium_rate_table_id` BIGINT COMMENT 'Foreign key linking to product.premium_rate_table. Business justification: The underwriting decision approves a specific premium amount calculated from a premium rate table. Regulatory compliance (state rate filings), policy illustration accuracy, and audit trails require th',
    `retention_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.retention_limit. Business justification: The underwriting decisions reinsurance_required flag is driven by NAR exceeding a specific retention limit. Referencing the retention_limit record supports regulatory capital reporting and treaty adm',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.underwriting_risk_assessment. Business justification: The formal underwriting decision is the direct output of the underwriting risk assessment process. Linking decision.underwriting_risk_assessment_id → underwriting_risk_assessment provides direct trace',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: The decision record assigns a formal risk classification to the applicant. The existing decision.risk_class STRING column stores a denormalized risk class code/name. Replacing it with a FK to the risk',
    `rules_engine_output_id` BIGINT COMMENT 'Foreign key linking to underwriting.rules_engine_output. Business justification: The underwriting decision is directly informed by the automated rules engine output. Linking decision.rules_engine_output_id → rules_engine_output provides direct traceability from the formal decision',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.template. Business justification: Underwriting decision notification letters (approval, decline, counter-offer, postpone) are generated from specific DOI-approved templates. This FK records which template version was used for the deci',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: The underwriting decision assigns a final approved underwriting class, which determines the COI rate schedule, premium rate table, and benefit structure applied to the issued policy. This is the prima',
    `workflow_id` BIGINT COMMENT 'Foreign key linking to document.workflow. Business justification: Underwriting decisions directly trigger document workflows: approval triggers policy issuance workflow, decline triggers adverse action notice workflow, counter-offer triggers conditional approval wor',
    `aml_review_completed` BOOLEAN COMMENT 'Indicates whether Anti-Money Laundering (AML) review was completed as part of the underwriting process. True if AML review was performed, False otherwise.',
    `approved_face_amount` DECIMAL(18,2) COMMENT 'The total death benefit amount approved by underwriting. May differ from the applied-for amount if the underwriter reduced coverage.',
    `approved_premium_amount` DECIMAL(18,2) COMMENT 'The total premium amount approved for the policy, including any table ratings, flat extras, and rider premiums.',
    `aps_ordered` BOOLEAN COMMENT 'Indicates whether an Attending Physician Statement (APS) was ordered from the applicants physician as part of the underwriting evidence requirements. True if APS was ordered, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this underwriting decision record was first created in the system.',
    `decision_date` DATE COMMENT 'The date the underwriting decision was formally made and recorded in the underwriting workbench.',
    `decision_method` STRING COMMENT 'The underwriting method used to reach the decision. Automated Rules Engine indicates decision made by algorithmic rules without human intervention. Manual Underwriting indicates full human review. Hybrid indicates combination of automated and manual review. Accelerated Underwriting indicates streamlined process using data analytics. Simplified Issue indicates minimal underwriting with limited evidence.. Valid values are `Automated Rules Engine|Manual Underwriting|Hybrid|Accelerated Underwriting|Simplified Issue`',
    `decision_number` STRING COMMENT 'Business-facing unique decision number or case reference used in underwriting workbench and communications.',
    `decision_status` STRING COMMENT 'Current status of the underwriting decision. Final indicates the decision is authoritative and binding. Interim indicates a preliminary decision subject to further review. Pending Review indicates decision awaiting supervisory approval. Overridden indicates decision was superseded by a subsequent decision. Withdrawn indicates decision was retracted.. Valid values are `Final|Interim|Pending Review|Overridden|Withdrawn`',
    `decision_timestamp` TIMESTAMP COMMENT 'The precise date and time the underwriting decision was finalized and committed to the system.',
    `decision_type` STRING COMMENT 'The formal underwriting decision outcome. Approved Standard indicates acceptance at standard rates. Approved Rated indicates acceptance with table rating. Approved with Exclusion indicates acceptance with specific exclusion riders. Approved with Flat Extra indicates acceptance with additional per-thousand charge. Postponed indicates decision deferred pending additional information. Declined indicates application rejected. Referred to Facultative Reinsurance indicates case requires facultative reinsurance review. [ENUM-REF-CANDIDATE: Approved Standard|Approved Rated|Approved with Exclusion|Approved with Flat Extra|Postponed|Declined|Referred to Facultative Reinsurance — 7 candidates stripped; promote to reference product]',
    `decline_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for declining the application. Null if the application was not declined. Used for regulatory reporting and adverse action notices.',
    `decline_reason_description` STRING COMMENT 'Detailed explanation of the reason for declining the application. Null if the application was not declined. Must comply with adverse action notice requirements.',
    `exclusion_description` STRING COMMENT 'Detailed description of the specific conditions, activities, or causes of death excluded from coverage under the exclusion rider. Null if no exclusions apply.',
    `exclusion_rider_applied` BOOLEAN COMMENT 'Indicates whether one or more exclusion riders were applied to the policy as a condition of approval. True if exclusions apply, False otherwise.',
    `financial_underwriting_completed` BOOLEAN COMMENT 'Indicates whether financial underwriting review was completed to assess the applicants financial capacity and insurable interest. True if financial underwriting was performed, False otherwise.',
    `flat_extra_duration_years` STRING COMMENT 'Number of years the flat extra charge will apply. Null if flat extra is permanent or not applicable.',
    `flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Additional premium charge per thousand dollars of coverage applied for specific hazards or impairments, expressed in dollars. Null if no flat extra applies.',
    `kyc_verification_status` STRING COMMENT 'Status of Know Your Customer (KYC) verification performed during underwriting. Verified indicates successful identity verification. Pending indicates verification in progress. Failed indicates verification could not be completed. Not Required indicates KYC not applicable for this case.. Valid values are `Verified|Pending|Failed|Not Required`',
    `medical_exam_required` BOOLEAN COMMENT 'Indicates whether a paramedical or full medical examination was required as part of the underwriting evidence. True if exam was required, False otherwise.',
    `mib_inquiry_completed` BOOLEAN COMMENT 'Indicates whether a Medical Information Bureau (MIB) inquiry was performed as part of the underwriting process. True if MIB check was completed, False otherwise.',
    `nar_amount` DECIMAL(18,2) COMMENT 'The Net Amount at Risk calculated at the time of underwriting decision, representing the difference between the death benefit and the policy reserve. Critical for reinsurance placement and risk-based capital calculations.',
    `notification_sent_date` DATE COMMENT 'The date the underwriting decision notification was sent to the applicant and/or agent. Critical for tracking regulatory notification timelines.',
    `postpone_reason` STRING COMMENT 'Explanation of why the underwriting decision was postponed, including what additional information or evidence is required. Null if the decision was not postponed.',
    `postpone_review_date` DATE COMMENT 'The scheduled date for re-review of a postponed application. Null if the decision was not postponed.',
    `rationale` STRING COMMENT 'Detailed explanation of the underwriting decision, including key risk factors, medical findings, financial considerations, and justification for the assigned risk class and rating. Critical for audit trail and regulatory compliance.',
    `reinsurance_required` BOOLEAN COMMENT 'Indicates whether reinsurance placement is required for this policy based on retention limits and risk characteristics. True if reinsurance is needed, False otherwise.',
    `stoli_indicator` BOOLEAN COMMENT 'Flag indicating whether the application was flagged for potential Stranger-Originated Life Insurance (STOLI) activity during underwriting review. True if STOLI concerns were identified, False otherwise.',
    `supervisory_approval_date` DATE COMMENT 'The date supervisory approval was granted. Null if supervisory approval was not required or not yet obtained.',
    `supervisory_approval_required` BOOLEAN COMMENT 'Indicates whether the underwriting decision requires supervisory or senior underwriter approval before becoming final. True if approval is required, False otherwise.',
    `table_rating` STRING COMMENT 'The table rating assigned for substandard risks, typically expressed as a letter (A through J) or numeric value (25, 50, 75, etc.) representing percentage increase in mortality. Null for standard and preferred risks.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time this underwriting decision record was last modified in the system.',
    CONSTRAINT pk_decision PRIMARY KEY(`decision_id`)
) COMMENT 'Formal underwriting decision record issued for a life or annuity application. Captures the final or interim decision type (Approved Standard, Approved Rated, Approved with Exclusion, Postponed, Declined, Referred to Facultative Reinsurance), assigned risk class, table rating, flat extra per thousand, exclusion riders applied, decision date, deciding underwriter ID, and decision rationale. Represents the authoritative output of the underwriting process and drives policy issuance in the Policy Administration System.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` (
    `evidence_requirement_id` BIGINT COMMENT 'Unique identifier for the evidence requirement record. Primary key for the evidence requirement entity.',
    `application_id` BIGINT COMMENT 'Reference to the new business application or policy change case for which this evidence is required.',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: Facultative reinsurers require specific medical evidence (APS, paramedicals, labs) before making underwriting decisions. Evidence gathered during underwriting is transmitted to facultative reinsurer a',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy being underwritten or re-underwritten, if applicable for policy change cases.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: In life insurance underwriting, each evidence requirement (APS, labs, exam) is fulfilled by a received document stored in the DMS. This FK directly links the requirement to its fulfilling document, en',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Evidence requirements are often triggered by specific riders (e.g., aviation rider requires aviation questionnaire, LTC rider requires ADL assessment). Underwriters need to track which rider triggered',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Evidence requirements are ordered and tracked as part of the risk assessment process. The evidence_requirement table consolidates all evidence items (medical exams, APS, MIB, lab results) ordered for ',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: State regulations mandate specific evidence requirements for life insurance underwriting (e.g., exam thresholds, APS requirements by face amount). Direct FK enables compliance audits to verify evidenc',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.template. Business justification: APS request letters, HIPAA authorization forms, and lab order forms are generated from DOI-approved templates tied to specific evidence requirements. This FK enables the system to generate the correct',
    `type_id` BIGINT COMMENT 'Foreign key linking to document.document_type. Business justification: Evidence requirements specify what document type is needed (APS, lab report, financial statement, exam report). The existing document_type_context plain attribute is a denormalized reference to the do',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Evidence requirements (paramedical exam, blood work, APS) are driven by the applied-for underwriting class — Preferred classes require more stringent evidence than Simplified Issue. Underwriting opera',
    `blood_pressure_diastolic` STRING COMMENT 'Diastolic blood pressure reading in mmHg from paramedical examination.',
    `blood_pressure_systolic` STRING COMMENT 'Systolic blood pressure reading in mmHg from paramedical examination.',
    `completion_status` STRING COMMENT 'Indicates whether the evidence item is complete and sufficient for underwriting decision or requires additional information.. Valid values are `complete|incomplete|partial|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evidence requirement record was first created in the underwriting workbench system.',
    `evidence_cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred by the insurance company to obtain this evidence from the vendor or provider.',
    `evidence_status` STRING COMMENT 'Current workflow status of the evidence requirement within the underwriting workbench.. Valid values are `ordered|in_transit|received|under_review|satisfied|waived`',
    `evidence_type` STRING COMMENT 'Classification of the evidence item type. [ENUM-REF-CANDIDATE: APS|paramedical_exam|MIB_inquiry|EKG|blood_profile|urine_specimen|treadmill_stress_test|financial_statement|inspection_report|MVR|prescription_drug_history|cognitive_assessment|functional_capacity_evaluation — promote to reference product]. Valid values are `APS|paramedical_exam|MIB_inquiry|EKG|blood_profile|urine_specimen`',
    `exam_date` DATE COMMENT 'Date when the paramedical examination was conducted. Applicable for paramedical exam evidence type.',
    `exam_location` STRING COMMENT 'Physical location or address where the paramedical examination was performed.',
    `examiner_name` STRING COMMENT 'Full name of the paramedical examiner who conducted the examination.',
    `follow_up_action_description` STRING COMMENT 'Description of the follow-up action required, such as ordering additional tests or requesting clarification from the physician.',
    `follow_up_action_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up action or supplementary evidence is required based on the review of this evidence.',
    `height_inches` DECIMAL(18,2) COMMENT 'Applicant height measured in inches during paramedical examination.',
    `hipaa_authorization_date` DATE COMMENT 'Date when the applicant signed the HIPAA authorization form.',
    `hipaa_authorization_received_flag` BOOLEAN COMMENT 'Indicates whether HIPAA authorization was received from the applicant to obtain medical evidence.',
    `lab_results_summary` STRING COMMENT 'Summary of laboratory test results from blood and urine specimens. Contains key findings and abnormal values.',
    `medical_conditions_disclosed` STRING COMMENT 'Free-text summary of medical conditions disclosed in the evidence (APS, exam reports). Contains diagnoses, symptoms, and health history.',
    `medications_list` STRING COMMENT 'List of current and past medications documented in the evidence, including dosages and frequencies.',
    `mib_applicant_consent_flag` BOOLEAN COMMENT 'Indicates whether the applicant provided consent for MIB inquiry as required by FCRA.',
    `mib_condition_codes` STRING COMMENT 'MIB condition codes indicating medical conditions or risk factors disclosed in prior applications.',
    `mib_follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether the MIB response requires additional follow-up investigation or evidence.',
    `mib_member_code` STRING COMMENT 'MIB member code identifying the insurance company submitting the inquiry.',
    `mib_response_codes` STRING COMMENT 'Comma-separated list of MIB response codes returned from the inquiry, indicating prior insurance applications and medical conditions.',
    `mib_submission_date` DATE COMMENT 'Date when the MIB inquiry was submitted. Applicable for MIB inquiry evidence type.',
    `ordered_date` DATE COMMENT 'Date when the evidence requirement was ordered from the vendor or provider.',
    `physician_name` STRING COMMENT 'Full name of the attending physician for APS evidence type. Applicable only when evidence_type is APS.',
    `physician_npi` STRING COMMENT 'Ten-digit National Provider Identifier for the attending physician. Applicable for APS evidence.. Valid values are `^[0-9]{10}$`',
    `physician_practice_name` STRING COMMENT 'Name of the medical practice or facility where the attending physician practices. Applicable for APS evidence.',
    `pulse_rate` STRING COMMENT 'Pulse rate in beats per minute recorded during paramedical examination.',
    `received_date` DATE COMMENT 'Date when the evidence was received by the underwriting team.',
    `relevance_score` DECIMAL(18,2) COMMENT 'Quantitative score (0.00 to 1.00) indicating how relevant this document was to the underwriting decision. Used to prioritize critical evidence and support audit trails. Explicitly identified in detection phase relationship data.',
    `review_date` DATE COMMENT 'Date when the underwriter reviewed this document as part of the risk assessment. Explicitly identified in detection phase relationship data.',
    `review_notes` STRING COMMENT 'Underwriter notes documenting findings from this specific document review, including key observations, red flags identified, or clarifications needed. These notes are specific to the document-assessment pairing.',
    `review_status` STRING COMMENT 'Current status of the document review within the risk assessment workflow. Tracks whether the document has been reviewed, is pending review, or was deferred. Explicitly identified in detection phase relationship data.',
    `review_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document review was completed and recorded in the underwriting workbench.',
    `reviewed_date` DATE COMMENT 'Date when the underwriter completed review of the evidence.',
    `specimen_collection_status` STRING COMMENT 'Status of biological specimen collection (blood, urine) for laboratory testing.. Valid values are `collected|pending|not_required|refused`',
    `treatment_history` STRING COMMENT 'Summary of medical treatments, procedures, and interventions documented in the evidence.',
    `underwriter_review_notes` STRING COMMENT 'Free-text notes and observations recorded by the underwriter during evidence review. Contains risk assessment commentary and decision rationale.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the evidence requirement record was last updated.',
    `waiver_reason` STRING COMMENT 'Reason code or description explaining why the evidence requirement was waived (e.g., accelerated underwriting, low face amount, age-based waiver).',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Applicant weight measured in pounds during paramedical examination.',
    CONSTRAINT pk_evidence_requirement PRIMARY KEY(`evidence_requirement_id`)
) COMMENT 'Consolidated master record for all underwriting evidence items ordered, received, and reviewed for a specific application or policy change re-underwriting case. Encompasses all evidence types and their type-specific detail attributes: Attending Physician Statements (APS) with physician name, practice, NPI, request/received dates, medical conditions disclosed, treatment history, medications, lab results, and underwriter review notes; paramedical examinations with exam vendor (ExamOne, APPS), examiner details, exam date/location, height, weight, blood pressure, pulse, specimen collection status, lab results summary, and completion status; MIB inquiries with submission date, MIB member code, applicant consent flag, response codes, condition codes returned, follow-up action required flag, and review status; EKG, blood profiles, urine specimens, treadmill stress tests, financial statements, inspection reports, MVR, prescription drug history (Rx check), cognitive assessments, and functional capacity evaluations. Tracks ordering date, vendor assigned, received date, evidence status (ordered, in-transit, received, under-review, satisfied, waived), evidence type classification, and type-specific extended attributes. Manages the complete evidence workflow within the Underwriting Workbench. Supports both traditional and accelerated underwriting evidence protocols. Subject to HIPAA data handling requirements for medical evidence, FCRA compliance for consumer report evidence, and MIB Group data use agreements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`aps_record` (
    `aps_record_id` BIGINT COMMENT 'Primary key for aps_record',
    `application_id` BIGINT COMMENT 'Reference to the new business application for which this APS was requested.',
    `evidence_requirement_id` BIGINT COMMENT 'Foreign key linking to underwriting.evidence_requirement. Business justification: An APS (Attending Physician Statement) record is the fulfillment of a specific evidence requirement ordered during underwriting. Linking aps_record.evidence_requirement_id → evidence_requirement direc',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy if APS is requested post-issue for underwriting review or policy change.',
    `document_id` BIGINT COMMENT 'Reference identifier to the stored APS document in the document management system.',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: APS records are filed against the specific insured for a policy application. The insured record holds aps_received_date and aps_required_flag that directly correspond to APS activity. The existing ins',
    `party_id` BIGINT COMMENT 'Reference to the insured individual whose medical history is documented in this APS.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: APS (Attending Physician Statement) records are medical evidence that feeds into the comprehensive risk_assessment. Physician statements provide medical history, treatment details, and prognosis that ',
    `aps_cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred to obtain the APS from the physician or vendor.',
    `aps_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the APS cost amount.. Valid values are `^[A-Z]{3}$`',
    `aps_status` STRING COMMENT 'Current status of the APS request in the underwriting workflow.. Valid values are `requested|pending|received|reviewed|incomplete|cancelled`',
    `aps_type` STRING COMMENT 'Type of APS requested based on underwriting requirements (full medical history, abbreviated summary, or targeted inquiry).. Valid values are `full|abbreviated|targeted|supplemental`',
    `coverage_period_end_date` DATE COMMENT 'End date of the period for which medical history was requested in the APS.',
    `coverage_period_start_date` DATE COMMENT 'Start date of the period for which medical history was requested in the APS.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the APS record was first created in the system.',
    `first_visit_date` DATE COMMENT 'Date of the insureds first visit to the attending physician as documented in the APS.',
    `follow_up_notes` STRING COMMENT 'Notes describing the nature of follow-up required or actions taken.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up or clarification is required from the physician after initial APS review.',
    `hipaa_authorization_date` DATE COMMENT 'Date when HIPAA authorization was signed by the insured.',
    `hipaa_authorization_received_flag` BOOLEAN COMMENT 'Indicates whether HIPAA authorization was received from the insured to request the APS.',
    `lab_results_summary` STRING COMMENT 'Summary of laboratory test results (e.g., blood work, imaging, biopsies) documented in the APS.',
    `last_visit_date` DATE COMMENT 'Date of the insureds most recent visit to the attending physician as documented in the APS.',
    `medical_conditions_disclosed` STRING COMMENT 'Summary of medical conditions, diagnoses, or health issues disclosed by the attending physician in the APS.',
    `medications_prescribed` STRING COMMENT 'List of medications currently or previously prescribed to the insured as documented in the APS.',
    `physician_address_line1` STRING COMMENT 'Street address line 1 of the attending physician practice.',
    `physician_city` STRING COMMENT 'City where the attending physician practice is located.',
    `physician_contact_phone` STRING COMMENT 'Primary contact phone number for the attending physician or practice.',
    `physician_name` STRING COMMENT 'Full name of the attending physician who provided the medical statement.',
    `physician_npi` STRING COMMENT 'Ten-digit National Provider Identifier for the attending physician as assigned by CMS.. Valid values are `^[0-9]{10}$`',
    `physician_postal_code` STRING COMMENT 'Postal or ZIP code of the attending physician practice.',
    `physician_practice_name` STRING COMMENT 'Name of the medical practice or clinic where the attending physician practices.',
    `physician_specialty` STRING COMMENT 'Medical specialty of the attending physician (e.g., Cardiology, Oncology, Internal Medicine).',
    `physician_state` STRING COMMENT 'State or province where the attending physician practice is located.',
    `prognosis_notes` STRING COMMENT 'Physicians prognosis or outlook for the insureds health condition as documented in the APS.',
    `received_date` DATE COMMENT 'Date when the completed APS was received by the insurance company.',
    `request_date` DATE COMMENT 'Date when the APS was requested from the attending physician or vendor.',
    `review_completed_date` DATE COMMENT 'Date when the underwriter completed the review of the APS.',
    `risk_classification_impact` STRING COMMENT 'Impact of the APS findings on the applicants risk classification (e.g., standard, substandard, rated, decline).. Valid values are `no_impact|standard|substandard|rated|decline`',
    `treatment_history_summary` STRING COMMENT 'Summary of treatments, procedures, surgeries, or therapies documented in the APS.',
    `underwriter_review_notes` STRING COMMENT 'Notes and observations recorded by the underwriter during review of the APS for risk assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the APS record was last updated in the system.',
    CONSTRAINT pk_aps_record PRIMARY KEY(`aps_record_id`)
) COMMENT 'Attending Physician Statement (APS) record capturing medical history details obtained from the applicants treating physician. Stores physician name, practice, NPI, date of APS request, date received, medical conditions disclosed, treatment history, medications, lab results, and underwriter review notes. Supports medical underwriting evaluation and mortality risk classification. Subject to HIPAA data handling requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` (
    `mib_inquiry_id` BIGINT COMMENT 'Unique identifier for the MIB inquiry record. Primary key for the MIB inquiry transaction.',
    `application_id` BIGINT COMMENT 'Reference to the underwriting application for which this MIB inquiry was performed. Links the MIB lookup to the new business application being underwritten.',
    `evidence_requirement_id` BIGINT COMMENT 'Foreign key linking to underwriting.evidence_requirement. Business justification: An MIB inquiry is the fulfillment of a specific evidence requirement ordered during underwriting. Linking mib_inquiry.evidence_requirement_id → evidence_requirement directly associates the MIB inquiry',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: MIB inquiries generate response documents with condition codes and hit indicators. Business process: underwriters review MIB response documents for discrepancy detection and STOLI investigation. No ex',
    `party_id` BIGINT COMMENT 'Reference to the individual applicant whose medical history is being checked through MIB. The proposed insured or annuitant.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: MIB (Medical Information Bureau) inquiry results are evidence that feeds into the comprehensive risk_assessment. MIB findings (condition_codes, hit_indicator, discrepancy_detected_flag) inform medical',
    `adverse_action_required_flag` BOOLEAN COMMENT 'Indicates whether the MIB inquiry results will contribute to an adverse underwriting decision requiring FCRA-compliant adverse action notice to the applicant.',
    `applicant_consent_flag` BOOLEAN COMMENT 'Indicates whether the applicant provided written consent for the MIB inquiry as required by FCRA and state insurance regulations. Must be true for inquiry to proceed.',
    `condition_codes` STRING COMMENT 'Comma-separated list of MIB condition codes returned in the response. Each code represents a medical condition, impairment, or underwriting factor previously reported to MIB by member companies. Confidential medical information.',
    `consent_date` DATE COMMENT 'The date when the applicant signed the authorization form permitting the MIB inquiry. Required for FCRA compliance and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this MIB inquiry record was first created in the underwriting system. Used for audit trail and data lineage.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any discrepancies found between the application and MIB records. Documents the nature and severity of non-disclosure or inconsistencies. Confidential underwriting information.',
    `discrepancy_detected_flag` BOOLEAN COMMENT 'Indicates whether the MIB inquiry revealed discrepancies between the applicants stated medical history and the MIB records. True triggers additional investigation for potential non-disclosure or fraud.',
    `error_code` STRING COMMENT 'Error code returned by MIB if the inquiry failed or encountered issues. Used for troubleshooting and retry logic.',
    `error_message` STRING COMMENT 'Detailed error message returned by MIB if the inquiry failed. Provides context for technical troubleshooting.',
    `face_amount` DECIMAL(18,2) COMMENT 'The death benefit or face amount of the policy being applied for. Reported to MIB as part of the inquiry context and used for risk assessment.',
    `follow_up_action_required_flag` BOOLEAN COMMENT 'Indicates whether the MIB response requires follow-up action by the underwriter. True when condition codes or discrepancies necessitate additional investigation or evidence collection.',
    `follow_up_action_type` STRING COMMENT 'The type of follow-up action required based on the MIB response. Specifies what additional underwriting evidence or investigation is needed.. Valid values are `aps_order|medical_exam|applicant_interview|disclosure_verification|no_action`',
    `hit_indicator` BOOLEAN COMMENT 'Indicates whether the MIB inquiry returned any records for the applicant. True means prior insurance applications or medical conditions were found in the MIB database.',
    `inquiry_date` DATE COMMENT 'The date when the MIB inquiry request was submitted to the Medical Information Bureau. This is the business event date for the inquiry transaction.',
    `inquiry_method` STRING COMMENT 'The technical method used to submit the MIB inquiry. Indicates the integration channel between the underwriting system and MIB.. Valid values are `api|batch|manual|web_portal`',
    `inquiry_status` STRING COMMENT 'Current status of the MIB inquiry in its lifecycle. Tracks the inquiry from submission through response receipt.. Valid values are `submitted|pending|completed|failed|cancelled`',
    `inquiry_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the MIB inquiry request was submitted, including time zone. Used for audit trail and SLA tracking.',
    `inquiry_type` STRING COMMENT 'The type of underwriting transaction triggering the MIB inquiry. Determines the scope and purpose of the medical history check.. Valid values are `new_business|reinstatement|conversion|increase`',
    `mib_member_code` STRING COMMENT 'The unique member code assigned to the insurance company by MIB Group. Identifies the requesting carrier in the MIB network.. Valid values are `^[A-Z0-9]{3,10}$`',
    `mib_response_code` STRING COMMENT 'The primary response code returned by MIB indicating the outcome of the inquiry. Standard codes include hit/no-hit, error conditions, and data quality flags.. Valid values are `^[A-Z0-9]{2,6}$`',
    `most_recent_report_date` DATE COMMENT 'The date of the most recent MIB record found for the applicant. Helps underwriters assess the recency and relevance of prior medical information.',
    `number_of_records_found` STRING COMMENT 'The count of prior insurance application records found in the MIB database for this applicant. Indicates the extent of prior underwriting history.',
    `policy_number` STRING COMMENT 'The policy number associated with the application, if already assigned at the time of MIB inquiry. May be null for early-stage applications.',
    `product_type` STRING COMMENT 'The type of insurance or annuity product being applied for. Provides context for the MIB inquiry and underwriting decision.. Valid values are `term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity`',
    `response_received_date` DATE COMMENT 'The date when the MIB response was received by the insurance company. Used to calculate turnaround time and SLA compliance.',
    `response_received_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the MIB response was received, including time zone. Used for detailed audit trail and performance monitoring.',
    `retry_count` STRING COMMENT 'The number of times this MIB inquiry was retried due to technical failures or timeouts. Used for monitoring system reliability.',
    `review_completed_date` DATE COMMENT 'The date when the underwriter completed their review of the MIB inquiry results. Used for workflow tracking and SLA monitoring.',
    `stoli_indicator_flag` BOOLEAN COMMENT 'Indicates whether the MIB inquiry results suggest potential STOLI activity. True when patterns consistent with investor-initiated life insurance are detected.',
    `transaction_reference` STRING COMMENT 'The unique transaction identifier assigned by MIB for this inquiry. Used for reconciliation, support requests, and audit trail.. Valid values are `^[A-Z0-9-]{10,50}$`',
    `underwriter_notes` STRING COMMENT 'Free-text notes entered by the underwriter regarding their analysis of the MIB inquiry results. May include interpretation of condition codes, follow-up plans, or risk assessment observations. Confidential underwriting work product.',
    `underwriter_review_status` STRING COMMENT 'Current status of the underwriters review of the MIB inquiry results. Tracks the progression of manual underwriting analysis.. Valid values are `pending_review|under_review|reviewed|escalated`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this MIB inquiry record was last updated. Tracks modifications to inquiry status, review status, or underwriter notes.',
    CONSTRAINT pk_mib_inquiry PRIMARY KEY(`mib_inquiry_id`)
) COMMENT 'Medical Information Bureau (MIB) inquiry and response record for an underwriting application. Captures inquiry submission date, MIB member code, applicant consent flag, MIB response code, condition codes returned, follow-up action required flag, and underwriter review status. MIB lookups are a mandatory step in life insurance underwriting to detect undisclosed medical conditions and prior declinations. Governed by MIB Group data use agreements and FCRA compliance requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` (
    `paramedical_exam_id` BIGINT COMMENT 'Unique identifier for the paramedical examination record. Primary key for this entity.',
    `application_id` BIGINT COMMENT 'Reference to the new business application for which this paramedical exam was ordered. Links the exam to the underwriting case.',
    `evidence_requirement_id` BIGINT COMMENT 'Foreign key linking to underwriting.evidence_requirement. Business justification: A paramedical examination is the fulfillment of a specific evidence requirement ordered during underwriting. Linking paramedical_exam.evidence_requirement_id → evidence_requirement directly associates',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Paramedical exams produce lab reports, examiner notes, and specimen results as documents. Business process: underwriters access exam documents during risk classification and decision-making. No existi',
    `party_id` BIGINT COMMENT 'Foreign key linking to policyholder.party. Business justification: Paramedical exams are conducted on a specific insured party. Exam scheduling, HIPAA authorization, and lab results must be traceable to the party examined for regulatory compliance and medical records',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Paramedical examination results are medical evidence that feeds into the comprehensive risk_assessment. Exam findings (blood pressure, BMI, lab results, abnormal findings) inform medical risk classifi',
    `abnormal_findings_flag` BOOLEAN COMMENT 'Indicates whether any abnormal findings were identified during the examination or in laboratory results. True if abnormalities detected.',
    `abnormal_findings_summary` STRING COMMENT 'Summary description of any abnormal findings identified during the examination or in laboratory results. Used for underwriting risk assessment.',
    `blood_pressure_diastolic` STRING COMMENT 'Diastolic blood pressure reading in millimeters of mercury (mmHg). Second reading in blood pressure measurement.',
    `blood_pressure_systolic` STRING COMMENT 'Systolic blood pressure reading in millimeters of mercury (mmHg). First reading in blood pressure measurement.',
    `blood_specimen_collected_flag` BOOLEAN COMMENT 'Indicates whether a blood specimen was successfully collected during the examination. True if collected, False if not.',
    `blood_specimen_collection_date` DATE COMMENT 'Date when the blood specimen was collected. May differ from exam date if specimen was collected separately.',
    `bmi` DECIMAL(18,2) COMMENT 'Calculated Body Mass Index based on height and weight measurements. Key indicator for mortality risk classification.',
    `cancellation_notes` STRING COMMENT 'Additional details explaining why the examination was cancelled. Null if exam was completed.',
    `cancellation_reason_code` STRING COMMENT 'Code indicating the reason why the examination was cancelled, if applicable. Null if exam was completed.. Valid values are `APPLICANT_REQUEST|NO_SHOW|VENDOR_ISSUE|POLICY_WITHDRAWN|OTHER`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this paramedical examination record was first created in the system. Used for audit trail and data lineage.',
    `exam_completed_date` DATE COMMENT 'Date when the paramedical examination was actually conducted and completed by the examiner.',
    `exam_cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged by the vendor for conducting the paramedical examination. Used for expense tracking and vendor reconciliation.',
    `exam_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the examination cost amount.. Valid values are `USD|CAD|GBP|EUR`',
    `exam_location_address` STRING COMMENT 'Full street address where the paramedical examination was conducted.',
    `exam_location_city` STRING COMMENT 'City where the paramedical examination was conducted.',
    `exam_location_postal_code` STRING COMMENT 'Postal code (ZIP code) of the location where the paramedical examination was conducted.',
    `exam_location_state` STRING COMMENT 'State or province where the paramedical examination was conducted. Two-letter state code.',
    `exam_location_type` STRING COMMENT 'Type of location where the paramedical examination was conducted (e.g., applicants home, office, clinic, mobile unit).. Valid values are `HOME|OFFICE|CLINIC|MOBILE_UNIT|OTHER`',
    `exam_ordered_date` DATE COMMENT 'Date when the paramedical examination was ordered by the underwriter. Marks the start of the evidence fulfillment workflow.',
    `exam_received_date` DATE COMMENT 'Date when the completed examination results were received by the insurance company from the vendor.',
    `exam_scheduled_date` DATE COMMENT 'Date when the paramedical examination appointment was scheduled with the proposed insured.',
    `exam_status` STRING COMMENT 'Current lifecycle status of the paramedical examination. Tracks the exam from order through completion or cancellation.. Valid values are `ORDERED|SCHEDULED|IN_PROGRESS|COMPLETED|CANCELLED|NO_SHOW`',
    `exam_type` STRING COMMENT 'Type of paramedical examination ordered based on underwriting requirements. Determines the scope of tests and measurements collected.. Valid values are `FULL_PARAMED|MINI_PARAMED|BLOOD_ONLY|URINE_ONLY|VITALS_ONLY|TELE_INTERVIEW`',
    `examiner_license_number` STRING COMMENT 'Professional license number of the paramedical examiner, if applicable. Used for credential verification.',
    `examiner_name` STRING COMMENT 'Full name of the paramedical examiner who conducted the examination.',
    `examiner_notes` STRING COMMENT 'Free-text notes and observations recorded by the paramedical examiner during the examination. May include behavioral observations or environmental factors.',
    `height_inches` DECIMAL(18,2) COMMENT 'Measured height of the proposed insured in inches. Critical measurement for mortality risk assessment and build classification.',
    `lab_clia_number` STRING COMMENT 'CLIA certification number of the laboratory that processed the specimens. Required for regulatory compliance.',
    `lab_name` STRING COMMENT 'Name of the laboratory facility that processed the blood and urine specimens.',
    `lab_results_received_date` DATE COMMENT 'Date when laboratory test results were received from the testing facility.',
    `lab_results_received_flag` BOOLEAN COMMENT 'Indicates whether laboratory test results have been received from the testing facility. True if received, False if pending.',
    `policy_number` STRING COMMENT 'The policy number associated with this paramedical exam, if the application has been issued. May be null for pending applications.',
    `pulse_rate` STRING COMMENT 'Measured pulse rate in beats per minute (BPM). Indicator of cardiovascular health.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this paramedical examination record was last modified. Used for audit trail and change tracking.',
    `urine_specimen_collected_flag` BOOLEAN COMMENT 'Indicates whether a urine specimen was successfully collected during the examination. True if collected, False if not.',
    `urine_specimen_collection_date` DATE COMMENT 'Date when the urine specimen was collected. May differ from exam date if specimen was collected separately.',
    `weight_pounds` DECIMAL(18,2) COMMENT 'Measured weight of the proposed insured in pounds. Critical measurement for mortality risk assessment and build classification.',
    CONSTRAINT pk_paramedical_exam PRIMARY KEY(`paramedical_exam_id`)
) COMMENT 'Paramedical examination record ordered as part of the underwriting evidence process. Captures exam vendor (e.g., ExamOne, APPS), examiner details, exam date, exam location, height, weight, blood pressure readings, pulse, blood and urine specimen collection status, lab results summary, and exam completion status. Drives the evidence fulfillment workflow and feeds into the risk assessment for mortality classification.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` (
    `rules_engine_output_id` BIGINT COMMENT 'Primary key for rules_engine_output',
    `application_id` BIGINT COMMENT 'Reference to the new business (NB) application that was evaluated by the rules engine.',
    `automatic_binding_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.automatic_binding_limit. Business justification: Rules engine determines stp_eligible_flag and reinsurance_required_flag by evaluating the automatic binding limit. Referencing the specific automatic_binding_limit record supports STP workflow audits ',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Automated underwriting rules reference mortality tables for STP decisioning and mortality risk scoring. Real business need: rules calibration, mortality assumption alignment between underwriting and a',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: The rules engine executes against a specific plan versions underwriting guidelines, rate tables, and class structure. Automated underwriting audit trails and STP (straight-through processing) complia',
    `risk_class_id` BIGINT COMMENT 'Reference to the risk classification recommended by the rules engine based on automated evaluation of mortality and morbidity risk factors.',
    `retention_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.retention_limit. Business justification: Rules engine evaluates retention_limit_exceeded_flag against a specific retention limit record. Tracing which retention_limit triggered the reinsurance_required_flag is essential for automated underwr',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.underwriting_risk_assessment. Business justification: The automated rules engine output is generated as part of the underwriting risk assessment workflow. Linking rules_engine_output.underwriting_risk_assessment_id → underwriting_risk_assessment directly',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Rules engine outputs flag regulatory_approval_required_flag per jurisdiction; compliance audits and DOI examinations require traceability from each automated underwriting decision to the specific stat',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Anti-money laundering (AML) risk score (0-100) calculated by the rules engine based on financial underwriting data, source of funds, and Know Your Customer (KYC) checks. Higher scores indicate elevated AML risk.',
    `applicant_age` STRING COMMENT 'Age of the primary applicant at the time of rules engine evaluation. Critical factor in mortality risk assessment and risk classification.',
    `applicant_gender` STRING COMMENT 'Gender of the primary applicant. Used in mortality table selection and risk classification where permitted by state regulations.. Valid values are `male|female|unspecified`',
    `aps_required_flag` BOOLEAN COMMENT 'Indicates whether the rules engine determined that an Attending Physician Statement (APS) is required based on medical history disclosures or risk factors.',
    `automated_decision` STRING COMMENT 'The automated underwriting decision recommendation generated by the rules engine. Approve indicates auto-approval eligibility, decline indicates auto-decline, refer indicates human review required, pend indicates additional information needed.. Valid values are `approve|decline|refer|pend`',
    `calculated_nar_amount` DECIMAL(18,2) COMMENT 'The net amount at risk (NAR) calculated by the rules engine, representing the insurers exposure (typically death benefit minus reserve or cash value).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rules engine output record was first created in the system. Used for audit trail and data lineage.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the rules engine evaluation was executed. Represents the business event time of automated decisioning.',
    `evidence_requirements_met_flag` BOOLEAN COMMENT 'Indicates whether all required underwriting evidence (Attending Physician Statement (APS), Medical Information Bureau (MIB) reports, lab results, financial documents) has been received and evaluated by the rules engine.',
    `face_amount` DECIMAL(18,2) COMMENT 'The death benefit or face amount of the policy being underwritten. Used by the rules engine to determine retention limits, reinsurance requirements, and evidence thresholds.',
    `financial_underwriting_required_flag` BOOLEAN COMMENT 'Indicates whether the rules engine determined that enhanced financial underwriting is required based on coverage amount, income verification needs, or STOLI risk indicators.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rules engine output record was last modified. Used for audit trail and change tracking.',
    `mib_check_status` STRING COMMENT 'Status of the Medical Information Bureau (MIB) check performed as part of the automated underwriting evaluation. MIB provides medical history information from previous insurance applications.. Valid values are `completed|pending|not_required|failed`',
    `mib_codes_found` STRING COMMENT 'Comma-separated list of MIB codes identified during the MIB check. MIB codes represent medical conditions or risk factors from prior insurance applications.',
    `nar_calculation_method` STRING COMMENT 'Method used by the rules engine to calculate the net amount at risk (NAR) for reinsurance and risk assessment purposes. NAR represents the insurance companys exposure on the policy.. Valid values are `death_benefit_minus_reserve|face_amount_minus_cash_value|custom`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the rules engine evaluation, including any system warnings, edge cases, or contextual information for underwriter review.',
    `product_line` STRING COMMENT 'The life insurance or annuity product line being underwritten. Different product lines have different underwriting rules and risk tolerances.. Valid values are `term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity`',
    `recommended_flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Flat extra premium per thousand dollars of coverage recommended by the rules engine for specific impairments or occupational hazards.',
    `recommended_table_rating` STRING COMMENT 'Table rating (A through P or STD for standard) recommended by the rules engine for substandard risk pricing. Each letter represents an incremental mortality charge.. Valid values are `^[A-P]$|^STD$`',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the automated decision requires regulatory approval or notification based on jurisdiction-specific requirements or policy characteristics.',
    `reinsurance_required_flag` BOOLEAN COMMENT 'Indicates whether the rules engine determined that facultative or automatic reinsurance placement is required based on retention limits and risk characteristics.',
    `reinsurance_type` STRING COMMENT 'Type of reinsurance recommended by the rules engine. Automatic reinsurance follows pre-agreed treaty terms; facultative reinsurance requires case-by-case negotiation with reinsurers.. Valid values are `automatic|facultative|not_required`',
    `retention_limit_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the application exceeds the companys retention limit, triggering reinsurance requirements. True means the risk exceeds internal capacity.',
    `rule_execution_duration_ms` STRING COMMENT 'Total execution time in milliseconds for the rules engine evaluation. Used for performance monitoring and STP rate optimization.',
    `rules_engine_output_status` STRING COMMENT 'Current status of this rules engine output record. Active indicates the current evaluation; superseded indicates a newer evaluation exists; archived indicates historical record retention.. Valid values are `active|superseded|archived`',
    `rules_engine_version` STRING COMMENT 'Version identifier of the automated underwriting rules engine that performed the evaluation (e.g., 2.5.1). Critical for audit trail and reproducibility of automated decisions.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `rules_failed_count` STRING COMMENT 'Number of rules that evaluated to a fail outcome, indicating non-compliance with automated underwriting criteria.',
    `rules_fired_count` STRING COMMENT 'Total number of individual rules that were triggered and evaluated during this rules engine run.',
    `rules_passed_count` STRING COMMENT 'Number of rules that evaluated to a pass outcome, indicating compliance with automated underwriting criteria.',
    `rules_refer_count` STRING COMMENT 'Number of rules that evaluated to a refer outcome, requiring human underwriter review and manual decisioning.',
    `smoker_status` STRING COMMENT 'Tobacco use status of the applicant as determined by the rules engine. Major factor in mortality risk assessment and premium calculation.. Valid values are `non_smoker|smoker|occasional_smoker|unknown`',
    `source_system` STRING COMMENT 'Name of the underwriting workbench system that generated this rules engine output (e.g., RGAX AURA, Swiss Re Magnum). Critical for data lineage and system integration troubleshooting.',
    `stoli_risk_score` DECIMAL(18,2) COMMENT 'Risk score (0-100) calculated by the rules engine to detect potential stranger-originated life insurance (STOLI) schemes. Higher scores indicate elevated STOLI risk requiring investigation.',
    `stp_eligible_flag` BOOLEAN COMMENT 'Indicates whether the application qualifies for straight-through processing (STP) based on rules engine evaluation. True means the application can be auto-approved without human intervention.',
    `underwriting_method` STRING COMMENT 'The underwriting method applied by the rules engine. Full underwriting includes medical exams; simplified uses health questions only; accelerated uses data analytics and third-party data; guaranteed issue requires no health questions.. Valid values are `full|simplified|accelerated|guaranteed_issue`',
    CONSTRAINT pk_rules_engine_output PRIMARY KEY(`rules_engine_output_id`)
) COMMENT 'Automated underwriting rules engine evaluation output for a specific application, generated by the Underwriting Workbench (RGAX AURA / Swiss Re Magnum automated rules engine). Captures rules engine version, evaluation timestamp, individual rule IDs fired, rule outcomes (pass/fail/refer), straight-through processing (STP) eligibility flag, automated decision recommendation, and rules that triggered referral to a human underwriter. Enables audit trail of automated decisioning and supports STP rate tracking.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`rule` (
    `rule_id` BIGINT COMMENT 'Primary key for rule',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Individual underwriting rules are calibrated to specific mortality tables for impairment ratings and table rating assignments. Real business need: rules maintenance, actuarial assumption updates, rein',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Underwriting rules are derived from and must align with DOI-approved policy form language. Direct FK enables compliance teams to verify that active underwriting rules are authorized by a currently-app',
    `retention_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.retention_limit. Business justification: Underwriting rules have reinsurance_cession_impact as a plain attr and govern when cession is required. Linking rule to the retention_limit it enforces supports rules engine configuration management a',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Underwriting rules are frequently rider-specific (e.g., waiver of premium rider has disability definition rules, accidental death rider has aviation/avocation hazard rules). Rules engine must referenc',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Underwriting rules must align with state-specific requirements (HIV testing restrictions, genetic information prohibitions, unfair discrimination laws). Business process: state regulatory compliance f',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Underwriting rules are often class-specific — e.g., APS required for Preferred applicants over age 60, or flat extras applicable only to Substandard classes. Rules engine configuration and actuarial g',
    `age_band_max` STRING COMMENT 'Maximum age (in years) for which this rule applies. Defines the upper age boundary for rule applicability. Null if rule applies to all ages above the minimum.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) for which this rule applies. Supports age-specific underwriting criteria and impairment rating adjustments. Null if rule applies to all ages.',
    `approval_date` DATE COMMENT 'Date on which the rule was approved by the appropriate governance body (underwriting committee, compliance, state regulator). Null if approval is not required or pending.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this rule. Supports audit trail and governance accountability. Null if approval is not required or pending.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rule record was first created in the system. Supports audit trail and data lineage.',
    `decline_threshold_description` STRING COMMENT 'Textual description of the conditions under which the rule triggers an automatic decline or decline recommendation. Specifies severity levels, combinations of risk factors, or absolute contraindications. Null if rule does not trigger declines.',
    `effective_date` DATE COMMENT 'Date on which this rule becomes active and enforceable in the underwriting process. Supports version control and regulatory compliance.',
    `evidence_requirement` STRING COMMENT 'Comma-separated list of additional underwriting evidence required when this rule is triggered (e.g., APS, paramedical exam, EKG, blood profile, urine test, MIB report, motor vehicle report, financial statements). Null if no additional evidence required.',
    `expiration_date` DATE COMMENT 'Date on which this rule is no longer active. Null for rules that remain in effect indefinitely. Supports rule lifecycle management and historical analysis.',
    `face_amount_threshold_max` DECIMAL(18,2) COMMENT 'Maximum policy face amount (death benefit) for which this rule applies. Defines the upper face amount boundary for rule applicability. Null if no maximum threshold.',
    `face_amount_threshold_min` DECIMAL(18,2) COMMENT 'Minimum policy face amount (death benefit) for which this rule applies. Supports face-amount-based underwriting tiers (e.g., simplified issue up to $250,000, full underwriting above). Null if no minimum threshold.',
    `flat_extra_duration_months` STRING COMMENT 'Duration in months for which the flat extra charge applies. Used for temporary flat extras that expire after a specified period (e.g., 60 months post-surgery). Null for permanent flat extras or non-flat-extra rules.',
    `flat_extra_per_thousand_max` DECIMAL(18,2) COMMENT 'Maximum flat extra premium charge per thousand dollars of face amount. Defines the upper bound of the flat extra surcharge. Null if rule does not use flat extras.',
    `flat_extra_per_thousand_min` DECIMAL(18,2) COMMENT 'Minimum flat extra premium charge per thousand dollars of face amount, expressed in dollars. Used for temporary or permanent extra mortality charges. Null if rule does not use flat extras.',
    `gender_applicability` STRING COMMENT 'Specifies whether the rule applies to male applicants, female applicants, or all genders. Supports gender-specific medical underwriting criteria (e.g., prostate conditions for males, pregnancy-related conditions for females).. Valid values are `male|female|all`',
    `icd10_code_mapping` STRING COMMENT 'ICD-10 diagnosis code(s) associated with the medical impairment. Supports integration with Attending Physician Statements (APS) and medical records. Multiple codes may be comma-separated. Null for non-medical rules.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `impairment_code` STRING COMMENT 'Standard code identifying a specific medical impairment or health condition (e.g., DIAB2 for Type 2 Diabetes, CAD for Coronary Artery Disease). Used for medical underwriting and impairment rating. Null for non-medical rules.. Valid values are `^[A-Z0-9]{2,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this rule record. Supports change tracking and audit compliance.',
    `logic_description` STRING COMMENT 'Detailed textual description of the rule logic, conditions, and decision criteria. Explains how the rule evaluates applicant data and what actions it triggers. Critical for underwriter training and audit compliance.',
    `nar_calculation_impact` STRING COMMENT 'Describes how this rule affects the Net Amount at Risk (NAR) calculation. NAR is the death benefit minus the policy cash value or account value. Rules that increase mortality risk typically increase NAR exposure.. Valid values are `increases_nar|decreases_nar|no_impact`',
    `notes` STRING COMMENT 'Free-form text field for additional context, special instructions, or clarifications related to the rule. Used by underwriters and rule administrators for operational guidance.',
    `owner` STRING COMMENT 'Name or identifier of the business unit, underwriting team, or individual responsible for maintaining and updating this rule. Supports governance and accountability.',
    `product_line_applicability` STRING COMMENT 'Comma-separated list of product lines to which this rule applies (e.g., Term Life, Whole Life, Universal Life, Indexed Universal Life, Variable Universal Life, Fixed Annuity, Variable Annuity). Null or all if rule applies universally.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether this rule requires state insurance department approval before implementation. True for rules affecting rate classes, policy forms, or underwriting practices subject to regulatory filing requirements.',
    `reinsurance_cession_impact` STRING COMMENT 'Indicates how this rule affects reinsurance placement decisions: automatic (ceded under automatic treaty), facultative (requires facultative reinsurance submission), retained (risk retained by direct writer), or none (no reinsurance impact).. Valid values are `automatic|facultative|retained|none`',
    `rule_category` STRING COMMENT 'Classification of the rule type. Medical rules evaluate health conditions and impairments; financial rules assess income and net worth; product eligibility rules determine product suitability; STOLI detection rules identify stranger-originated life insurance; AML/KYC rules support anti-money laundering compliance; age band rules apply age-specific underwriting criteria.. Valid values are `medical|financial|product_eligibility|stoli_detection|aml_kyc|age_band`',
    `rule_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the rule within the automated rules engine or underwriting manual. Used for system integration and rule invocation.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_name` STRING COMMENT 'Human-readable name of the underwriting rule or medical impairment guideline. Provides clear identification for underwriters and business users.',
    `rule_source` STRING COMMENT 'Origin of the rule: company underwriting manual (proprietary guidelines), reinsurer guide (reinsurer-provided rating manual), regulatory requirement (mandated by state or federal regulation), or industry standard (NAIC, ACORD, MIB best practices).. Valid values are `company_manual|reinsurer_guide|regulatory_requirement|industry_standard`',
    `rule_status` STRING COMMENT 'Current lifecycle status of the rule. Active rules are in production use; inactive rules are disabled; pending approval rules await governance review; retired rules are archived; suspended rules are temporarily disabled pending review.. Valid values are `active|inactive|pending_approval|retired|suspended`',
    `rule_type` STRING COMMENT 'Indicates whether the rule is executed automatically by the rules engine, serves as a manual guideline for underwriter reference, defines an impairment rating action, triggers an automatic decline, or triggers a referral to senior underwriter or medical director.. Valid values are `automated|manual_guideline|impairment_rating|decline_trigger|referral_trigger`',
    `smoker_status_applicability` STRING COMMENT 'Indicates whether the rule applies to smokers, non-smokers, or all applicants. Supports tobacco-use-specific underwriting criteria and rating adjustments.. Valid values are `smoker|non_smoker|all`',
    `source_system` STRING COMMENT 'Name of the operational system from which this rule was sourced (e.g., RGAX AURA, Swiss Re Magnum, proprietary underwriting workbench). Supports data lineage and integration troubleshooting.',
    `standard_rating_action` STRING COMMENT 'Default underwriting action prescribed by the rule: standard (no extra premium), table rating (mortality multiplier), flat extra (per-thousand charge), decline (application rejected), or refer (escalate to senior underwriter or medical director).. Valid values are `standard|table_rating|flat_extra|decline|refer`',
    `table_rating_range_max` STRING COMMENT 'Maximum table rating (A through P) for the impairment or risk factor. Defines the upper bound of mortality surcharge. Null if rule does not use table ratings.. Valid values are `^[A-Z]$`',
    `table_rating_range_min` STRING COMMENT 'Minimum table rating (A through P) for the impairment or risk factor. Table ratings represent mortality multipliers (e.g., Table B = 150% of standard mortality). Null if rule does not use table ratings.. Valid values are `^[A-Z]$`',
    `underwriting_method_applicability` STRING COMMENT 'Specifies the underwriting method(s) to which this rule applies: full underwriting (medical exams, APS), simplified issue (health questions only), guaranteed issue (no health questions), accelerated underwriting (automated data sources), or all methods.. Valid values are `full|simplified|guaranteed|accelerated|all`',
    `version_number` STRING COMMENT 'Sequential version number of the rule. Incremented with each update to support change tracking and historical analysis. Version 1 is the initial rule definition.',
    CONSTRAINT pk_rule PRIMARY KEY(`rule_id`)
) COMMENT 'Master reference catalog of all underwriting rules, medical impairment rating guidelines, and underwriting manual entries configured in the automated rules engine. For automated rules: stores rule code, rule name, rule category (medical, financial, product eligibility, STOLI detection), rule logic description, effective date, expiration date, product line applicability, face amount threshold, age band applicability, and rule owner. For medical impairment guidelines: stores impairment code, impairment name (e.g., Type 2 Diabetes, Coronary Artery Disease, Sleep Apnea), ICD-10 code mapping, standard rating action (table rating range, flat extra range, decline threshold), age and severity modifiers, and source (company manual or reinsurer guide). Provides the authoritative catalog of all automated underwriting rules and medical impairment rating guidelines governing NB decisioning and risk classification. Replaces the need for a separate impairment guide entity.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` (
    `financial_uw_review_id` BIGINT COMMENT 'Unique identifier for the financial underwriting review record.',
    `application_id` BIGINT COMMENT 'Reference to the new business application being financially underwritten.',
    `decision_id` BIGINT COMMENT 'Foreign key linking to underwriting.decision. Business justification: The financial underwriting review directly informs and is referenced by the formal underwriting decision. Linking financial_uw_review.decision_id → decision provides direct traceability from the finan',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: Jumbo cases requiring facultative reinsurance need detailed financial underwriting analysis transmitted to reinsurer. Financial review findings (income verification, net worth, insurable interest dete',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy if this review is for a policy change or increase.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Financial underwriting reviews analyze financial statements, tax returns, and business valuations submitted as documents. Business process: STOLI detection, insurable interest determination, and over-',
    `party_id` BIGINT COMMENT 'Reference to the applicant whose financial situation is being reviewed.',
    `retention_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.retention_limit. Business justification: Financial underwriting reviews assess whether applied_coverage_amount and existing_inforce_amount exceed retention limits. Referencing the specific retention_limit record supports over-insurance detec',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Financial underwriting review is a specialized component that feeds into the comprehensive risk_assessment. The financial review evaluates economic justification and insurable interest, contributing f',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Variable product financial underwriting reviews must reference the specific separate account to validate investment-linked coverage amounts against current NAV, assess over-insurance risk, and confirm',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assessing the potential for money laundering or financial crimes based on financial profile and transaction patterns.',
    `annual_income` DECIMAL(18,2) COMMENT 'Applicants total annual gross income from all sources including salary, bonuses, investment income, and business income.',
    `applied_coverage_amount` DECIMAL(18,2) COMMENT 'The total face amount of life insurance coverage requested by the applicant in the application.',
    `approved_coverage_amount` DECIMAL(18,2) COMMENT 'The maximum face amount of coverage approved by financial underwriting, which may be less than the applied amount if reduced.',
    `business_insurance_justification` STRING COMMENT 'Detailed explanation of business insurance need for key person, buy-sell agreement, or other business-related coverage purposes.',
    `business_ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of business ownership held by the applicant, relevant for key person and buy-sell insurance justification.',
    `business_valuation_amount` DECIMAL(18,2) COMMENT 'Fair market value of the business entity for which business insurance is being purchased.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial underwriting review record was first created in the system.',
    `decline_reason` STRING COMMENT 'Detailed explanation of why the coverage was declined or reduced from a financial underwriting perspective.',
    `existing_inforce_amount` DECIMAL(18,2) COMMENT 'Total face amount of existing life insurance coverage currently in force on the applicant across all carriers.',
    `financial_decision` STRING COMMENT 'Final outcome of the financial underwriting review regarding coverage amount justification.. Valid values are `approved|approved_reduced|declined|referred|pending_information`',
    `financial_review_notes` STRING COMMENT 'Detailed underwriter notes documenting the financial analysis, findings, concerns, and rationale for the financial underwriting decision.',
    `financial_statement_reviewed` BOOLEAN COMMENT 'Indicates whether formal financial statements (tax returns, balance sheets, income statements) were reviewed as part of the financial underwriting process.',
    `financial_statement_type` STRING COMMENT 'Type of financial documentation reviewed during the underwriting process.. Valid values are `tax_return|personal_financial_statement|business_financial_statement|bank_statement|investment_statement|none`',
    `human_life_value` DECIMAL(18,2) COMMENT 'Calculated economic value of the applicants future earnings potential, typically using present value of future income streams.',
    `income_replacement_multiple` DECIMAL(18,2) COMMENT 'Ratio of total coverage amount to annual income, used to assess if coverage is financially justified based on income replacement needs.',
    `insurable_interest_determination` STRING COMMENT 'Classification of the insurable interest relationship between the policy owner and the insured. [ENUM-REF-CANDIDATE: self|spouse|dependent|business_key_person|business_buy_sell|creditor|trust_beneficiary|other — 8 candidates stripped; promote to reference product]',
    `kyc_verification_status` STRING COMMENT 'Status of the Know Your Customer verification process for the applicants identity and financial information.. Valid values are `verified|pending|failed|not_required`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this financial underwriting review record was most recently updated.',
    `liquid_assets` DECIMAL(18,2) COMMENT 'Value of applicants liquid assets including cash, savings, money market accounts, and readily marketable securities.',
    `net_worth` DECIMAL(18,2) COMMENT 'Applicants total net worth calculated as total assets minus total liabilities.',
    `over_insurance_indicator` BOOLEAN COMMENT 'Flag indicating whether the requested coverage amount appears excessive relative to the applicants financial situation and insurable interest.',
    `review_completion_date` DATE COMMENT 'Date when the financial underwriting review was completed and a decision was rendered.',
    `review_duration_days` STRING COMMENT 'Number of calendar days elapsed from review start to completion, used for cycle time analysis.',
    `review_number` STRING COMMENT 'Business identifier for the financial underwriting review, typically system-generated or manually assigned.',
    `review_start_date` DATE COMMENT 'Date when the financial underwriting review process was initiated.',
    `review_status` STRING COMMENT 'Current lifecycle status of the financial underwriting review process. [ENUM-REF-CANDIDATE: pending|in_progress|completed|approved|declined|referred|suspended — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'Classification of the financial review based on the type of underwriting action being performed.. Valid values are `new_business|policy_increase|policy_change|reinstatement|conversion`',
    `source_system` STRING COMMENT 'Name of the underwriting workbench or system that originated this financial review record.',
    `stoli_red_flags` STRING COMMENT 'Specific indicators or red flags identified that suggest potential STOLI activity, such as premium financing, third-party involvement, or unusual beneficiary arrangements.',
    `stoli_risk_indicator` STRING COMMENT 'Assessment of the risk that this application represents a STOLI or investor-originated life insurance scheme lacking legitimate insurable interest.. Valid values are `none|low|medium|high|confirmed`',
    `total_coverage_amount` DECIMAL(18,2) COMMENT 'Sum of applied coverage amount and existing in-force amount, representing total insurance exposure.',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Sum of all applicants outstanding debts including mortgages, loans, credit card balances, and other obligations.',
    `version_number` STRING COMMENT 'Version number of this financial review record, incremented with each modification for audit trail purposes.',
    CONSTRAINT pk_financial_uw_review PRIMARY KEY(`financial_uw_review_id`)
) COMMENT 'Financial underwriting review record assessing the economic justification for the applied-for life insurance coverage amount. Captures insurable interest determination, income replacement multiple analysis, human life value (HLV) calculation, business insurance justification (key person, buy-sell), existing coverage in-force summary, financial statement review notes, and financial underwriting decision outcome. Ensures coverage amounts are financially justified and detects potential over-insurance or STOLI schemes.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` (
    `reinsurance_placement_id` BIGINT COMMENT 'Unique identifier for the reinsurance placement record. Primary key for this entity.',
    `application_id` BIGINT COMMENT 'Reference to the new business application for which this reinsurance placement decision was made.',
    `cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.reinsurance_cession. Business justification: A confirmed reinsurance placement results in a reinsurance_cession record. Linking placement to the resulting cession is essential for end-to-end new business processing traceability and reinsurer set',
    `decision_id` BIGINT COMMENT 'Foreign key linking to underwriting.decision. Business justification: The reinsurance placement is executed as a consequence of the formal underwriting decision (specifically when reinsurance_required is TRUE on the decision record). Linking reinsurance_placement.decisi',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: Facultative placements originate from a facultative_submission. Linking placement to the submission that initiated it supports facultative case management, reinsurer offer tracking, and placement stat',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the issued policy if the application was approved and bound. Null for declined or pending applications.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Facultative reinsurance placements generate submission packages, reinsurer offer letters, and acceptance confirmations. Business process: treaty administration, cession tracking, and reinsurer communi',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Reinsurance cession placement is always tied to the specific insured whose mortality risk is being ceded. Reinsurance teams need the full insured profile (risk class, tobacco status, occupation) when ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.plan. Business justification: Reinsurance placement is structured around the product plan — retention limits, cession percentages, and treaty applicability are plan-specific. `plan_code` is a denormalized plain column from product',
    `premium_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.premium_schedule. Business justification: Reinsurance placement establishes cession percentage and reinsurance premium rates that directly modify the net premium schedule. Actuarial and billing reconciliation reports require linking placement',
    `reinsurer_id` BIGINT COMMENT 'Reference to the primary reinsurer selected for this placement. For facultative placements, this is the reinsurer whose offer was accepted. For automatic placements, this is the treaty reinsurer.',
    `retention_limit_id` BIGINT COMMENT 'Foreign key linking to reinsurance.retention_limit. Business justification: reinsurance_placement.retention_limit_amount is a denormalized value from retention_limit. Replacing it with a FK to the retention_limit record enforces 3NF and supports treaty administration reportin',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.underwriting_risk_assessment. Business justification: Reinsurance placement decisions are directly driven by the underwriting risk assessment findings, particularly the reinsurance_cession_required_flag, NAR amount, and risk classification. Linking reins',
    `risk_class_id` BIGINT COMMENT 'Reference to the underwriting risk class assigned by the ceding company (e.g., Preferred Plus, Standard, Table B). Used to determine retention limits and automatic treaty eligibility.',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Variable life reinsurance placements must identify whether ceded risk is separate account business, as this directly affects treaty terms, reserve calculations, and NAIC Schedule reporting. Reinsurers',
    `treaty_id` BIGINT COMMENT 'Reference to the automatic reinsurance treaty under which this placement was made. Populated for automatic placements; null for facultative.',
    `treaty_schedule_id` BIGINT COMMENT 'Foreign key linking to reinsurance.treaty_schedule. Business justification: reinsurance_placement carries reinsurance_premium_rate and reinsurance_premium_basis as denormalized plain attrs. The specific treaty_schedule row governs the YRT rate or coinsurance percentage applie',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Anti-Money Laundering risk score assigned during underwriting KYC process. Higher scores indicate elevated AML risk. May impact reinsurer acceptance.',
    `automatic_binding_confirmation_date` DATE COMMENT 'Date the automatic treaty binding was confirmed for this placement. Null for facultative placements.',
    `case_summary` STRING COMMENT 'Brief narrative summary of the underwriting case submitted to the facultative reinsurer, including key risk factors, medical findings, and financial underwriting highlights. Null for automatic placements.',
    `ceding_risk_class_code` STRING COMMENT 'Risk class code assigned by the ceding company underwriter. Denormalized for reporting and comparison with reinsurer risk class.',
    `cession_amount` DECIMAL(18,2) COMMENT 'Amount of NAR ceded to reinsurer(s). Calculated as NAR minus retention limit for risks exceeding retention. Zero if within retention.',
    `cession_percentage` DECIMAL(18,2) COMMENT 'Percentage of total NAR ceded to reinsurer(s). Calculated as (cession_amount / nar_amount) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reinsurance placement record was first created in the system.',
    `facultative_acceptance_date` DATE COMMENT 'Date the ceding company accepted the facultative reinsurer offer. Null for automatic placements or declined offers.',
    `facultative_offer_expiration_date` DATE COMMENT 'Date by which the facultative reinsurer offer must be accepted. Null for automatic placements or if no offer received.',
    `facultative_offer_received_date` DATE COMMENT 'Date the reinsurer offer was received for facultative placement. Null for automatic placements or if no offer received.',
    `facultative_submission_date` DATE COMMENT 'Date the facultative reinsurance case was submitted to reinsurer(s). Null for automatic placements.',
    `financial_evidence_transmitted` BOOLEAN COMMENT 'Indicates whether financial underwriting evidence (tax returns, financial statements, net worth documentation) was transmitted to the facultative reinsurer. True if transmitted, false otherwise. Null for automatic placements.',
    `insured_age` STRING COMMENT 'Age of the primary insured at the time of underwriting. Used to determine retention limits and reinsurance rates.',
    `insured_gender` STRING COMMENT 'Gender of the primary insured. Used in retention limit schedule and reinsurance rate determination.. Valid values are `male|female|unspecified`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this reinsurance placement record was last updated. Tracks workflow progression and data changes.',
    `medical_evidence_transmitted` BOOLEAN COMMENT 'Indicates whether medical evidence (APS, paramedical exam, lab results) was transmitted to the facultative reinsurer. True if transmitted, false otherwise. Null for automatic placements.',
    `nar_amount` DECIMAL(18,2) COMMENT 'Net Amount at Risk calculated for this policy: death benefit minus cash surrender value or account value. Used to determine cession threshold and reinsurance need.',
    `notes` STRING COMMENT 'Free-text notes capturing additional placement details, special arrangements, underwriter comments, or reinsurer correspondence highlights.',
    `placement_effective_date` DATE COMMENT 'Date the reinsurance coverage becomes effective. Typically aligns with policy issue date.',
    `placement_status` STRING COMMENT 'Current workflow status of the reinsurance placement: pending (awaiting submission), submitted (sent to reinsurer), under_review (reinsurer evaluating), offered (reinsurer made offer), accepted (offer accepted), declined (reinsurer declined or offer rejected), bound (placement finalized), cancelled (placement withdrawn). [ENUM-REF-CANDIDATE: pending|submitted|under_review|offered|accepted|declined|bound|cancelled — 8 candidates stripped; promote to reference product]',
    `placement_type` STRING COMMENT 'Type of reinsurance placement: automatic (treaty-based, automatic binding), facultative (case-by-case submission), hybrid (partial automatic, partial facultative), declined (no reinsurer accepted), or not_required (within retention).. Valid values are `automatic|facultative|hybrid|declined|not_required`',
    `product_line` STRING COMMENT 'Product line category of the policy being reinsured: term, whole_life, universal_life, variable_universal_life, indexed_universal_life, annuity, disability_income, or long_term_care. [ENUM-REF-CANDIDATE: term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity|disability_income|long_term_care — 8 candidates stripped; promote to reference product]',
    `reinsurer_decision` STRING COMMENT 'Final decision rendered by the reinsurer: approved_standard (accepted at standard rates), approved_substandard (accepted with ratings/extras), declined (rejected), postponed (deferred pending additional information), counter_offer (alternative terms proposed).. Valid values are `approved_standard|approved_substandard|declined|postponed|counter_offer`',
    `reinsurer_exclusions` STRING COMMENT 'Text description of any coverage exclusions imposed by the reinsurer (e.g., aviation exclusion, hazardous activity exclusion). Null if no exclusions.',
    `reinsurer_flat_extra_duration_months` STRING COMMENT 'Duration in months for which the reinsurer flat extra premium applies. Null if permanent or no flat extra.',
    `reinsurer_flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Flat extra premium per thousand dollars of coverage charged by the reinsurer for substandard risks. Zero if no flat extra applied.',
    `reinsurer_risk_class_code` STRING COMMENT 'Risk class code assigned by the reinsurer. May differ from ceding company risk class for facultative placements. Null for automatic placements where reinsurer accepts ceding company classification.',
    `reinsurer_table_rating` STRING COMMENT 'Table rating assigned by the reinsurer (e.g., Table B, Table D). Indicates substandard risk classification. Null if standard risk.',
    `source_system` STRING COMMENT 'Name of the source system from which this reinsurance placement record originated (e.g., RGAX AURA, Swiss Re Magnum, RGA AURA Reinsurance, Swiss Re IRIS).',
    `stoli_indicator` BOOLEAN COMMENT 'Flag indicating whether STOLI risk was detected during underwriting. True if STOLI indicators present, false otherwise. Impacts reinsurer acceptance and placement terms.',
    CONSTRAINT pk_reinsurance_placement PRIMARY KEY(`reinsurance_placement_id`)
) COMMENT 'Consolidated underwriting reinsurance placement, cession decision, and retention limit record for a specific application. Encompasses the full reinsurance placement workflow: retention limit schedule (product line, plan code, insured age band, gender, risk class, retention limit amount, effective date, reinsurance treaty reference), NAR-based cession threshold evaluation, placement type determination (automatic YRT/coinsurance vs. facultative). For automatic placements: treaty reference, cession amount, and automatic binding confirmation. For facultative placements: submission date, reinsurer(s) submitted to, case summary, medical and financial evidence package transmitted, reinsurer offer details (risk class, table rating, flat extra, exclusions, offer expiration date), accepted offer reference, and facultative placement workflow status from submission through acceptance. Stores reinsurer selected, reinsurer decision, reinsurer risk class assigned, and overall placement status. Bridges the underwriting domain to the reinsurance domain for NAR-based cession decisions made at the time of underwriting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` (
    `exclusion_rider_id` BIGINT COMMENT 'Primary key for exclusion_rider',
    `application_id` BIGINT COMMENT 'Reference to the new business application that generated this exclusion rider during underwriting decisioning.',
    `cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: Exclusion riders on policies must be tracked at cession level for claims administration. Reinsurer needs to know what exclusions apply to ceded risk to properly adjudicate claims and calculate recover',
    `evidence_review_id` BIGINT COMMENT 'Foreign key linking to underwriting.evidence_review. Business justification: Exclusion riders are frequently recommended directly from evidence review findings (evidence_review.exclusion_rider_recommended = TRUE). Linking exclusion_rider.evidence_review_id → evidence_review pr',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the issued policy to which this exclusion rider is attached. Populated after policy issuance.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Exclusion riders produce policy endorsement documents with specific contract language. Business process: policy contract assembly and claims adjudication require linking riders to their endorsement do',
    `insured_id` BIGINT COMMENT 'Foreign key linking to policyholder.insured. Business justification: Exclusion riders are applied to a specific insured based on medical history or risk factors identified during underwriting. Claims examiners must validate exclusion applicability against the insured r',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Exclusion riders must be filed and approved in each jurisdiction before use. Regulatory requirement: form filing compliance for exclusion rider language. Links exclusion rider to form approval authori',
    `premium_adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_adjustment. Business justification: When an exclusion rider is applied or removed post-issue, it triggers a premium adjustment record in billing. The exclusion_rider.premium_impact_amount drives the adjustment amount. Regulatory and aud',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.underwriting_risk_assessment. Business justification: Exclusion riders are issued based on specific findings from the underwriting risk assessment (e.g., identified medical conditions, aviation/avocation hazards). Linking exclusion_rider.underwriting_ris',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Exclusion riders must comply with state-specific regulations governing permissible exclusion types, suicide exclusion periods, and aviation exclusions. Direct FK to state_regulation (beyond the existi',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.template. Business justification: Exclusion rider contract language is generated from DOI-approved templates with version-controlled regulatory language. This FK replaces the denormalized policy_contract_language field, enabling compl',
    `treaty_id` BIGINT COMMENT 'Foreign key linking to reinsurance.reinsurance_treaty. Business justification: Exclusion riders have reinsurance_acceptance_status and reinsurance_notification_required_flag. The treaty governs whether exclusion riders are acceptable under reinsurance terms; treaty administrator',
    `decision_id` BIGINT COMMENT 'Reference to the underwriting decision that resulted in this exclusion rider being required as a condition of approval.',
    `aps_reference_number` STRING COMMENT 'Reference number of the Attending Physician Statement (APS) or medical evidence that documented the condition or risk leading to this exclusion rider.',
    `claims_notification_text` STRING COMMENT 'Standardized text to be displayed to claims examiners when a claim is filed on a policy with this exclusion rider, alerting them to verify the cause of death against the exclusion terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exclusion rider record was first created in the underwriting system, typically during the underwriting decision process.',
    `effective_date` DATE COMMENT 'Date on which this exclusion rider becomes effective, typically the policy issue date or the date of a policy change that added the exclusion.',
    `excluded_cause_of_death` STRING COMMENT 'Specific cause of death or medical condition excluded from death benefit payment (e.g., death resulting from aviation activities, death due to pre-existing heart condition).',
    `exclusion_description` STRING COMMENT 'Detailed description of the specific condition, activity, cause of death, or circumstance excluded from coverage under this rider. This text appears in the policy contract.',
    `exclusion_rider_code` STRING COMMENT 'Standard code identifying the type of exclusion rider (e.g., AVN for aviation, WAR for war exclusion, DIS for specific disease exclusion).. Valid values are `^[A-Z0-9]{2,10}$`',
    `exclusion_rider_name` STRING COMMENT 'Standard name of the exclusion rider as filed with regulatory authorities and printed on the policy contract.',
    `exclusion_rider_status` STRING COMMENT 'Current status of this exclusion rider: active (currently in force on the policy), removed (removed following review or policy change), expired (reached expiration date), superseded (replaced by a different exclusion or policy change).. Valid values are `active|removed|expired|superseded`',
    `exclusion_scope` STRING COMMENT 'Scope of the exclusion: death_benefit_only (excludes only death benefit for specified cause), all_benefits (excludes all policy benefits), specific_rider (excludes benefits under a specific rider such as Accidental Death Benefit (ADB) or waiver of premium).. Valid values are `death_benefit_only|all_benefits|specific_rider`',
    `exclusion_type` STRING COMMENT 'Category of exclusion: aviation (piloting, skydiving), avocation (hazardous hobbies), medical_condition (specific disease or condition), occupational_hazard (dangerous occupation), war_military (war, military service), geographic_region (travel to high-risk areas).. Valid values are `aviation|avocation|medical_condition|occupational_hazard|war_military|geographic_region`',
    `expiration_date` DATE COMMENT 'Date on which this exclusion rider expires or is scheduled to be removed. Null if the exclusion is permanent or has no scheduled expiration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this exclusion rider record, capturing updates to status, review dates, or other attributes.',
    `medical_director_approval_flag` BOOLEAN COMMENT 'Indicates whether this exclusion rider required and received approval from the company medical director. True if medical director approval was obtained.',
    `mib_code` STRING COMMENT 'Medical Information Bureau (MIB) code associated with the medical condition or risk factor that triggered this exclusion rider.. Valid values are `^[0-9]{3}$`',
    `nar_impact_flag` BOOLEAN COMMENT 'Indicates whether this exclusion rider affects the Net Amount at Risk (NAR) calculation for reinsurance cession and Cost of Insurance (COI) rate determination. True if NAR calculation is impacted.',
    `notes` STRING COMMENT 'Free-form underwriting notes providing additional context, rationale, or special instructions related to this exclusion rider decision.',
    `permanence_indicator` STRING COMMENT 'Indicates whether the exclusion is permanent for the life of the policy, reviewable after a specified period, or conditional based on future evidence or circumstances.. Valid values are `permanent|reviewable|conditional`',
    `premium_impact_amount` DECIMAL(18,2) COMMENT 'Dollar amount of premium reduction (if any) resulting from the application of this exclusion rider. Positive values indicate premium savings to the policyholder due to reduced coverage.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number of the state insurance department filing that approved this exclusion rider form for use in the applicable jurisdiction.',
    `reinsurance_acceptance_status` STRING COMMENT 'Status of reinsurer acceptance of this exclusion rider: not_applicable (no reinsurance notification required), pending (awaiting reinsurer response), accepted (reinsurer accepted exclusion), rejected (reinsurer rejected exclusion), modified (reinsurer proposed alternative terms).. Valid values are `not_applicable|pending|accepted|rejected|modified`',
    `reinsurance_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the reinsurer must be notified of this exclusion rider per the reinsurance treaty terms. True if notification is required.',
    `removal_date` DATE COMMENT 'Date on which this exclusion rider was removed from the policy following a successful review or policy change. Null if the exclusion is still in force.',
    `removal_reason` STRING COMMENT 'Reason for removal of this exclusion rider (e.g., improved health confirmed by updated APS, cessation of excluded activity, policy anniversary review).',
    `review_criteria` STRING COMMENT 'Specific criteria or evidence required for review of this exclusion (e.g., clean medical records for 5 years, cessation of aviation activities, updated Attending Physician Statement (APS)).',
    `review_date` DATE COMMENT 'Scheduled date for underwriting review of this exclusion rider to determine if it can be removed or modified based on updated evidence. Null if exclusion is permanent.',
    `review_eligible_flag` BOOLEAN COMMENT 'Indicates whether this exclusion rider is eligible for future review and potential removal based on improved health or changed circumstances. True if reviewable, False if permanent.',
    `source_system` STRING COMMENT 'Name of the source system that created this exclusion rider record (e.g., RGAX AURA, Swiss Re Magnum, Underwriting Workbench).',
    `stoli_indicator` BOOLEAN COMMENT 'Indicates whether this exclusion rider was applied due to Stranger-Originated Life Insurance (STOLI) concerns or suspicious circumstances. True if STOLI-related.',
    CONSTRAINT pk_exclusion_rider PRIMARY KEY(`exclusion_rider_id`)
) COMMENT 'Underwriting exclusion rider record documenting specific conditions, activities, or causes of death excluded from coverage as a condition of policy approval. Captures exclusion type (aviation, avocation, specific disease/condition, war), exclusion description, effective date, whether the exclusion is permanent or reviewable, review date, and the underwriting decision that generated the exclusion. Feeds into policy issuance to ensure exclusion riders are attached to issued policies.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` (
    `evidence_review_id` BIGINT COMMENT 'Primary key for evidence_review',
    `application_id` BIGINT COMMENT 'Reference to the life or annuity insurance application being underwritten.',
    `document_id` BIGINT COMMENT 'Reference identifier for the physical or digital document containing the evidence.',
    `evidence_requirement_id` BIGINT COMMENT 'Reference to the specific evidence requirement that triggered this review.',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: evidence_review has facultative_reinsurance_required as a plain attribute. When evidence review determines facultative reinsurance is needed, linking to the resulting facultative_submission supports c',
    `follow_up_evidence_review_id` BIGINT COMMENT 'Self-referencing FK on evidence_review (follow_up_evidence_review_id)',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy if evidence review is for a policy change or reinstatement.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the evidence review record was first created in the system.',
    `evidence_received_date` DATE COMMENT 'Date when the evidence document or report was received by the underwriting department.',
    `evidence_source` STRING COMMENT 'Name of the organization or provider that supplied the evidence (e.g., physician name, laboratory name, MIB).',
    `evidence_type_code` STRING COMMENT 'Type of underwriting evidence being reviewed. APS=Attending Physician Statement, MIB=Medical Information Bureau report, LAB=Laboratory results, EKG=Electrocardiogram, PARA=Paramedical exam, MVR=Motor Vehicle Record.',
    `exclusion_description` STRING COMMENT 'Description of the condition or circumstance to be excluded from coverage if exclusion rider is recommended.',
    `exclusion_rider_recommended` BOOLEAN COMMENT 'Indicates whether an exclusion rider is recommended based on the evidence findings.',
    `facultative_reinsurance_required` BOOLEAN COMMENT 'Indicates whether facultative reinsurance placement is required for this case based on evidence review.',
    `flat_extra_amount` DECIMAL(18,2) COMMENT 'Flat extra premium amount per thousand of coverage recommended based on evidence findings.',
    `flat_extra_duration_years` STRING COMMENT 'Number of years the flat extra premium should be applied.',
    `icd_code` STRING COMMENT 'ICD-10 diagnosis code associated with the medical condition identified in the evidence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the evidence review record was last updated.',
    `medical_condition_identified` STRING COMMENT 'Primary medical condition or finding identified in the evidence that impacts underwriting decision.',
    `medical_director_review_required` BOOLEAN COMMENT 'Indicates whether the evidence requires escalation to the medical director for expert clinical review.',
    `mib_code_identified` STRING COMMENT 'MIB code identified in the evidence that indicates a specific medical or non-medical risk factor.',
    `peer_review_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the peer review was completed.',
    `peer_review_required` BOOLEAN COMMENT 'Indicates whether a peer review by another underwriter is required for quality assurance purposes.',
    `quality_score` STRING COMMENT 'Quality score assigned to the evidence document based on completeness, legibility, and relevance (scale 1-10).',
    `rating_action_recommended` STRING COMMENT 'Underwriting rating action recommended based on the evidence review findings.',
    `reinsurance_referral_required` BOOLEAN COMMENT 'Indicates whether the case must be referred to reinsurance based on evidence findings and retention limits.',
    `review_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the evidence review was completed.',
    `review_notes` STRING COMMENT 'Detailed notes and observations recorded by the underwriter during the evidence review process.',
    `review_outcome` STRING COMMENT 'Overall outcome of the evidence review from an underwriting perspective.',
    `review_priority` STRING COMMENT 'Priority level assigned to this evidence review based on business rules and case characteristics.',
    `review_start_timestamp` TIMESTAMP COMMENT 'Date and time when the underwriter began reviewing the evidence.',
    `review_status` STRING COMMENT 'Current lifecycle status of the evidence review process.',
    `risk_impact_assessment` STRING COMMENT 'Assessment of how the evidence findings impact the overall mortality or morbidity risk evaluation.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the evidence review was completed within the defined service level agreement timeframe.',
    `table_rating_value` STRING COMMENT 'Numeric table rating value recommended (e.g., Table 2, Table 4) if table rating action is recommended.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Total time in hours from evidence receipt to review completion, used for service level monitoring.',
    CONSTRAINT pk_evidence_review PRIMARY KEY(`evidence_review_id`)
) COMMENT 'Master reference table for evidence_review. Referenced by evidence_review_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` (
    `rule_execution_result_id` BIGINT COMMENT 'Primary key for the rule_execution_result association',
    `rule_id` BIGINT COMMENT 'Foreign key linking to the specific underwriting rule that was evaluated',
    `rules_engine_output_id` BIGINT COMMENT 'Foreign key linking to the rules engine evaluation in which this rule was fired',
    `decline_reason_codes` STRING COMMENT 'Comma-separated list of reason codes for rules that triggered an automated decline recommendation. Used for adverse action notices and regulatory compliance. [Moved from rules_engine_output: This comma-separated string on rules_engine_output is a denormalized encoding of individual rule FAIL outcomes. Each decline reason code corresponds to a specific rule that fired with a FAIL result. The correct model is one rule_execution_result record per fired rule with result=FAIL, making this field redundant and replaceable by querying the association table.]',
    `execution_sequence` STRING COMMENT 'The ordinal position in which this rule was evaluated within the rules engine execution. Critical for audit and debugging purposes, as rule execution order can affect downstream rule conditions in chained rule logic.',
    `fired_flag` BOOLEAN COMMENT 'Indicates whether this rule actually triggered (fired) during the evaluation. A rule may be in scope for an evaluation but not fire if its preconditions were not met. Distinguishes between rules that were evaluated and rules that actively influenced the decision.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether a human underwriter overrode the automated result of this specific rule. Supports underwriter override tracking, exception reporting, and model performance monitoring.',
    `override_reason` STRING COMMENT 'Free-text justification provided by the underwriter when overriding this rules automated result. Populated only when override_flag is TRUE. Supports audit trail, compliance review, and underwriter decision quality monitoring.',
    `refer_reason_codes` STRING COMMENT 'Comma-separated list of reason codes for rules that triggered a refer outcome, requiring human underwriter review. Each code represents a specific underwriting concern or exception. [Moved from rules_engine_output: This comma-separated string on rules_engine_output is a denormalized encoding of individual rule REFER outcomes. Each refer reason code corresponds to a specific rule that fired with a REFER result. The correct model is one rule_execution_result record per fired rule with result=REFER, making this field redundant and replaceable by querying the association table.]',
    `result` STRING COMMENT 'The outcome of evaluating this specific rule within this evaluation. PASS indicates the applicant met the rule criteria, FAIL indicates a decline trigger, REFER indicates the rule routed the case to a human underwriter, NOT_APPLICABLE indicates the rule was loaded but conditions for firing were not met.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score or weight contributed by this rule to the overall evaluation. Used in scoring-based rules engines where individual rule contributions are summed or weighted to produce the final automated decision recommendation.',
    CONSTRAINT pk_rule_execution_result PRIMARY KEY(`rule_execution_result_id`)
) COMMENT 'This association product represents the Event between rules_engine_output and rule. It captures the outcome of evaluating one specific underwriting rule within one specific rules engine execution. Each record links one rules_engine_output to one rule and carries the per-rule result data (outcome, score, sequence, override) that exists only in the context of that rule being fired within that evaluation. Provides the granular audit trail required for STP rate analysis, rule performance monitoring, and regulatory examination of automated underwriting decisions.. Existence Justification: In automated underwriting, a rules engine evaluation (rules_engine_output) fires multiple individual rules against a single application, and each rule (rule) is fired across thousands of evaluations over its lifetime. The relationship between a specific evaluation and a specific rule is a discrete operational event — a fired rule — that carries its own result data (pass/fail/refer, score, sequence, override). This is not derivable from either entity alone; the per-rule outcome within a specific evaluation is the core audit record of automated underwriting decisioning.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ADD CONSTRAINT `fk_underwriting_risk_assessment_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_rules_engine_output_id` FOREIGN KEY (`rules_engine_output_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rules_engine_output`(`rules_engine_output_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_evidence_requirement_id` FOREIGN KEY (`evidence_requirement_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_requirement`(`evidence_requirement_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_evidence_requirement_id` FOREIGN KEY (`evidence_requirement_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_requirement`(`evidence_requirement_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_evidence_requirement_id` FOREIGN KEY (`evidence_requirement_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_requirement`(`evidence_requirement_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_evidence_review_id` FOREIGN KEY (`evidence_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_review`(`evidence_review_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_evidence_requirement_id` FOREIGN KEY (`evidence_requirement_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_requirement`(`evidence_requirement_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_follow_up_evidence_review_id` FOREIGN KEY (`follow_up_evidence_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_review`(`evidence_review_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ADD CONSTRAINT `fk_underwriting_rule_execution_result_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rule`(`rule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ADD CONSTRAINT `fk_underwriting_rule_execution_result_rules_engine_output_id` FOREIGN KEY (`rules_engine_output_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rules_engine_output`(`rules_engine_output_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`underwriting` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`underwriting` SET TAGS ('dbx_domain' = 'underwriting');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` SET TAGS ('dbx_subdomain' = 'application_processing');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `acord_form_id` SET TAGS ('dbx_business_glossary_term' = 'Acord Form Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `automatic_binding_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Automatic Binding Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `hierarchy_node_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Node Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `jurisdiction_license_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction License Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `producer_product_auth_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Product Auth Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'new_business|replacement|conversion|reinstatement');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `aps_required` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `exchange_1035_flag` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `financial_underwriting_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `flat_extra_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Exam Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `mib_check_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `mib_check_status` SET TAGS ('dbx_value_regex' = 'not_requested|pending|completed|no_record');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `nigo_reason` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `policy_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `premium_mode` SET TAGS ('dbx_business_glossary_term' = 'Premium Mode');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `premium_mode` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|single');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `replacement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Replacement Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'rgax_aura|swiss_re_magnum|policy_admin|crm');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `stoli_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'agent_portal|paper_mail|email|fax|api_integration|pos_system');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `table_rating` SET TAGS ('dbx_business_glossary_term' = 'Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `table_rating` SET TAGS ('dbx_value_regex' = '^[A-P]$|');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_decisioning');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `retention_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `aps_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `aps_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `aps_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Review Outcome');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `aps_review_outcome` SET TAGS ('dbx_value_regex' = 'favorable|acceptable|adverse|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'new_business|policy_change|reinstatement|conversion|increase');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `automated_rules_engine_decision` SET TAGS ('dbx_business_glossary_term' = 'Automated Rules Engine Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `automated_rules_engine_decision` SET TAGS ('dbx_value_regex' = 'auto_approve|refer_to_underwriter|auto_decline');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `aviation_hazard_rating` SET TAGS ('dbx_business_glossary_term' = 'Aviation Hazard Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `aviation_hazard_rating` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `avocation_hazard_rating` SET TAGS ('dbx_business_glossary_term' = 'Avocation Hazard Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `avocation_hazard_rating` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `build_chart_result` SET TAGS ('dbx_business_glossary_term' = 'Build Chart Result');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `build_chart_result` SET TAGS ('dbx_value_regex' = 'preferred|standard|overweight|underweight');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `business_insurance_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Insurance Justification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `business_insurance_justification` SET TAGS ('dbx_value_regex' = 'key_person|buy_sell|executive_bonus|split_dollar|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `existing_coverage_inforce_amount` SET TAGS ('dbx_business_glossary_term' = 'Existing Coverage In-Force Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `financial_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Classification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `financial_risk_classification` SET TAGS ('dbx_value_regex' = 'approved|approved_with_limits|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `financial_statement_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `financial_statement_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `human_life_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Human Life Value (HLV) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `income_replacement_multiple` SET TAGS ('dbx_business_glossary_term' = 'Income Replacement Multiple');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `insurable_interest_determination` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Determination');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `insurable_interest_determination` SET TAGS ('dbx_value_regex' = 'confirmed|questionable|not_established');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `life_settlement_broker_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Settlement Broker Involvement Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `manual_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `medical_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Medical Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `medical_risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `medical_risk_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `mib_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Findings Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `mib_findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `mib_inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `mib_inquiry_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Performed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_value_regex' = 'death_benefit_minus_av|death_benefit_minus_csv|statutory|gaap');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `premium_financing_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Financing Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `reinsurance_cession_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'automatic|facultative|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `siu_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `stoli_determination` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Determination');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `stoli_determination` SET TAGS ('dbx_value_regex' = 'cleared|confirmed|inconclusive');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `stoli_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `stoli_investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Investigation Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `stoli_investigation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|cleared|confirmed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved_as_applied|approved_with_modifications|declined|postponed|withdrawn');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` SET TAGS ('dbx_subdomain' = 'risk_decisioning');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Band');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Band');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `decline_reason_category` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Category');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `decline_reason_category` SET TAGS ('dbx_value_regex' = 'medical|financial|lifestyle|legal|fraud|other');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `flat_extra_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Duration in Months');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_business_glossary_term' = 'Gender Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_value_regex' = 'male|female|unisex|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `morbidity_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Morbidity Multiplier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `mortality_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Mortality Multiplier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_value_regex' = 'standard|enhanced|reduced|custom');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `product_line_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Line Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Category');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_category` SET TAGS ('dbx_value_regex' = 'preferred|standard|substandard|decline|postpone|rated');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|deprecated|suspended');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `smoker_status` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `smoker_status` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|tobacco_user|non_tobacco_user|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `stoli_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `table_rating_code` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `table_rating_code` SET TAGS ('dbx_value_regex' = '^(TABLE_[A-P]|TABLE_[1-9]|TABLE_1[0-6])?$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `table_rating_factor` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Factor');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `underwriting_method` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `underwriting_method` SET TAGS ('dbx_value_regex' = 'full_underwriting|simplified_issue|guaranteed_issue|accelerated_underwriting|automated_underwriting');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` SET TAGS ('dbx_subdomain' = 'risk_decisioning');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `chargeback_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Rule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Reinsurer Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `premium_rate_table_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `retention_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `rules_engine_output_id` SET TAGS ('dbx_business_glossary_term' = 'Rules Engine Output Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `aml_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Review Completed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `approved_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `approved_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Premium Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `aps_ordered` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Ordered');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_method` SET TAGS ('dbx_business_glossary_term' = 'Decision Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_method` SET TAGS ('dbx_value_regex' = 'Automated Rules Engine|Manual Underwriting|Hybrid|Accelerated Underwriting|Simplified Issue');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_number` SET TAGS ('dbx_business_glossary_term' = 'Decision Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'Final|Interim|Pending Review|Overridden|Withdrawn');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decline_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `exclusion_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `exclusion_rider_applied` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Applied');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `financial_underwriting_completed` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting Completed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `flat_extra_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Duration Years');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Pending|Failed|Not Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Exam Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `medical_exam_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `mib_inquiry_completed` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Completed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `postpone_reason` SET TAGS ('dbx_business_glossary_term' = 'Postpone Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `postpone_review_date` SET TAGS ('dbx_business_glossary_term' = 'Postpone Review Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `reinsurance_required` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `stoli_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `supervisory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Approval Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `supervisory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Approval Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `table_rating` SET TAGS ('dbx_business_glossary_term' = 'Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` SET TAGS ('dbx_subdomain' = 'medical_evidence');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Received Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Diastolic Reading');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Systolic Reading');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Completion Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|partial|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Evidence Cost Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'ordered|in_transit|received|under_review|satisfied|waived');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type Classification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'APS|paramedical_exam|MIB_inquiry|EKG|blood_profile|urine_specimen');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `exam_date` SET TAGS ('dbx_business_glossary_term' = 'Paramedical Examination Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `exam_location` SET TAGS ('dbx_business_glossary_term' = 'Examination Location');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Examiner Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `examiner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `follow_up_action_description` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `follow_up_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Applicant Height in Inches');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `height_inches` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `height_inches` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `hipaa_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `hipaa_authorization_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Received Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `lab_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Results Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `lab_results_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `lab_results_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `medical_conditions_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Medical Conditions Disclosed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `medical_conditions_disclosed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `medical_conditions_disclosed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `medications_list` SET TAGS ('dbx_business_glossary_term' = 'Medications List');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `medications_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `medications_list` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_applicant_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Applicant Consent Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_condition_codes` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Condition Codes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_condition_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_condition_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Follow-Up Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_member_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Member Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_response_codes` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Response Codes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_response_codes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_response_codes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `mib_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `ordered_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Ordered Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_name` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Physician Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_practice_name` SET TAGS ('dbx_business_glossary_term' = 'Physician Practice Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `physician_practice_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `pulse_rate` SET TAGS ('dbx_business_glossary_term' = 'Pulse Rate');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `pulse_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `pulse_rate` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `relevance_score` SET TAGS ('dbx_business_glossary_term' = 'Relevance Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reviewed Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `specimen_collection_status` SET TAGS ('dbx_business_glossary_term' = 'Specimen Collection Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `specimen_collection_status` SET TAGS ('dbx_value_regex' = 'collected|pending|not_required|refused');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `treatment_history` SET TAGS ('dbx_business_glossary_term' = 'Treatment History');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `treatment_history` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `treatment_history` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `underwriter_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `underwriter_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Evidence Waiver Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Applicant Weight in Pounds');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` SET TAGS ('dbx_subdomain' = 'medical_evidence');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_record_id` SET TAGS ('dbx_business_glossary_term' = 'Aps Record Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `evidence_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Cost Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Cost Currency Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_status` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_status` SET TAGS ('dbx_value_regex' = 'requested|pending|received|reviewed|incomplete|cancelled');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_type` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_type` SET TAGS ('dbx_value_regex' = 'full|abbreviated|targeted|supplemental');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `coverage_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Coverage Period End Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `coverage_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Coverage Period Start Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `first_visit_date` SET TAGS ('dbx_business_glossary_term' = 'First Visit Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `hipaa_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `hipaa_authorization_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Authorization Received Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `lab_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Results Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `lab_results_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `lab_results_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `last_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Visit Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `medical_conditions_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Medical Conditions Disclosed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `medical_conditions_disclosed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `medical_conditions_disclosed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `medications_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Medications Prescribed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `medications_prescribed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `medications_prescribed` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Physician Address Line 1');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_city` SET TAGS ('dbx_business_glossary_term' = 'Physician City');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Physician Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_name` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Physician National Provider Identifier (NPI)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Physician Postal Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_practice_name` SET TAGS ('dbx_business_glossary_term' = 'Physician Practice Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_practice_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_specialty` SET TAGS ('dbx_business_glossary_term' = 'Physician Medical Specialty');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `physician_state` SET TAGS ('dbx_business_glossary_term' = 'Physician State');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `prognosis_notes` SET TAGS ('dbx_business_glossary_term' = 'Prognosis Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `prognosis_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `prognosis_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Request Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `risk_classification_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification Impact');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `risk_classification_impact` SET TAGS ('dbx_value_regex' = 'no_impact|standard|substandard|rated|decline');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `treatment_history_summary` SET TAGS ('dbx_business_glossary_term' = 'Treatment History Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `treatment_history_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `treatment_history_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `underwriter_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `underwriter_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` SET TAGS ('dbx_subdomain' = 'medical_evidence');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `mib_inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `evidence_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `adverse_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `applicant_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Applicant Consent Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `condition_codes` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Condition Codes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `condition_codes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Applicant Consent Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `discrepancy_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Detected Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Error Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Error Message');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `follow_up_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `follow_up_action_type` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `follow_up_action_type` SET TAGS ('dbx_value_regex' = 'aps_order|medical_exam|applicant_interview|disclosure_verification|no_action');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `hit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Hit Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_method` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_method` SET TAGS ('dbx_value_regex' = 'api|batch|manual|web_portal');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|completed|failed|cancelled');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Submission Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_type` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `inquiry_type` SET TAGS ('dbx_value_regex' = 'new_business|reinstatement|conversion|increase');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `mib_member_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Member Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `mib_member_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `mib_response_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Response Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `mib_response_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `most_recent_report_date` SET TAGS ('dbx_business_glossary_term' = 'Most Recent Medical Information Bureau (MIB) Report Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `number_of_records_found` SET TAGS ('dbx_business_glossary_term' = 'Number of Medical Information Bureau (MIB) Records Found');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Product Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Response Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `response_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Response Received Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Inquiry Retry Count');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Review Completed Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `stoli_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Transaction Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,50}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `underwriter_notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `underwriter_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `underwriter_review_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Review Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `underwriter_review_status` SET TAGS ('dbx_value_regex' = 'pending_review|under_review|reviewed|escalated');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` SET TAGS ('dbx_subdomain' = 'medical_evidence');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `paramedical_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Paramedical Examination Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `evidence_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `abnormal_findings_flag` SET TAGS ('dbx_business_glossary_term' = 'Abnormal Findings Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `abnormal_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Abnormal Findings Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `abnormal_findings_summary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `abnormal_findings_summary` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Diastolic Reading');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Systolic Reading');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_specimen_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Blood Specimen Collected Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `blood_specimen_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Blood Specimen Collection Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `bmi` SET TAGS ('dbx_business_glossary_term' = 'Body Mass Index (BMI)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `bmi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `bmi` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `cancellation_notes` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'APPLICANT_REQUEST|NO_SHOW|VENDOR_ISSUE|POLICY_WITHDRAWN|OTHER');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Completed Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Examination Cost Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Examination Cost Currency Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_address` SET TAGS ('dbx_business_glossary_term' = 'Examination Location Address');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_city` SET TAGS ('dbx_business_glossary_term' = 'Examination Location City');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Examination Location Postal Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_state` SET TAGS ('dbx_business_glossary_term' = 'Examination Location State');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Location Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_location_type` SET TAGS ('dbx_value_regex' = 'HOME|OFFICE|CLINIC|MOBILE_UNIT|OTHER');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_ordered_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Ordered Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_received_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Results Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Scheduled Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_status` SET TAGS ('dbx_business_glossary_term' = 'Examination Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_status` SET TAGS ('dbx_value_regex' = 'ORDERED|SCHEDULED|IN_PROGRESS|COMPLETED|CANCELLED|NO_SHOW');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_type` SET TAGS ('dbx_value_regex' = 'FULL_PARAMED|MINI_PARAMED|BLOOD_ONLY|URINE_ONLY|VITALS_ONLY|TELE_INTERVIEW');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_license_number` SET TAGS ('dbx_business_glossary_term' = 'Examiner License Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Examiner Full Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_notes` SET TAGS ('dbx_business_glossary_term' = 'Examiner Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `examiner_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `height_inches` SET TAGS ('dbx_business_glossary_term' = 'Height in Inches');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `height_inches` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `height_inches` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `lab_clia_number` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `lab_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `lab_results_received_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Results Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `lab_results_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Results Received Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `pulse_rate` SET TAGS ('dbx_business_glossary_term' = 'Pulse Rate');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `pulse_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `pulse_rate` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `urine_specimen_collected_flag` SET TAGS ('dbx_business_glossary_term' = 'Urine Specimen Collected Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `urine_specimen_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Urine Specimen Collection Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_business_glossary_term' = 'Weight in Pounds');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `weight_pounds` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` SET TAGS ('dbx_subdomain' = 'application_processing');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_engine_output_id` SET TAGS ('dbx_business_glossary_term' = 'Rules Engine Output Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `automatic_binding_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Automatic Binding Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Recommended Risk Class ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `retention_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `applicant_age` SET TAGS ('dbx_business_glossary_term' = 'Applicant Age');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `applicant_gender` SET TAGS ('dbx_business_glossary_term' = 'Applicant Gender');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `applicant_gender` SET TAGS ('dbx_value_regex' = 'male|female|unspecified');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `applicant_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `applicant_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `aps_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `automated_decision` SET TAGS ('dbx_business_glossary_term' = 'Automated Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `automated_decision` SET TAGS ('dbx_value_regex' = 'approve|decline|refer|pend');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `calculated_nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `evidence_requirements_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirements Met Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `financial_underwriting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `mib_check_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `mib_check_status` SET TAGS ('dbx_value_regex' = 'completed|pending|not_required|failed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `mib_codes_found` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Codes Found');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `mib_codes_found` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_value_regex' = 'death_benefit_minus_reserve|face_amount_minus_cash_value|custom');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `recommended_flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Recommended Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `recommended_table_rating` SET TAGS ('dbx_business_glossary_term' = 'Recommended Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `recommended_table_rating` SET TAGS ('dbx_value_regex' = '^[A-P]$|^STD$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `reinsurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'automatic|facultative|not_required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `retention_limit_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Exceeded Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rule_execution_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Duration Milliseconds');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_engine_output_status` SET TAGS ('dbx_business_glossary_term' = 'Rules Engine Output Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_engine_output_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Rules Engine Version');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_engine_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_failed_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Failed Count');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_fired_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Fired Count');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Passed Count');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_refer_count` SET TAGS ('dbx_business_glossary_term' = 'Rules Refer Count');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `smoker_status` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `smoker_status` SET TAGS ('dbx_value_regex' = 'non_smoker|smoker|occasional_smoker|unknown');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `stoli_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `stp_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Straight-Through Processing (STP) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `underwriting_method` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `underwriting_method` SET TAGS ('dbx_value_regex' = 'full|simplified|accelerated|guaranteed_issue');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` SET TAGS ('dbx_subdomain' = 'application_processing');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `retention_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `decline_threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Decline Threshold Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `evidence_requirement` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `face_amount_threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Threshold Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `face_amount_threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Threshold Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `flat_extra_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Duration in Months');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `flat_extra_per_thousand_max` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `flat_extra_per_thousand_min` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_business_glossary_term' = 'Gender Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_value_regex' = 'male|female|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `icd10_code_mapping` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code Mapping');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `icd10_code_mapping` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `impairment_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Impairment Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `impairment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `logic_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `nar_calculation_impact` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Impact');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `nar_calculation_impact` SET TAGS ('dbx_value_regex' = 'increases_nar|decreases_nar|no_impact');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `product_line_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Line Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `reinsurance_cession_impact` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Impact');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `reinsurance_cession_impact` SET TAGS ('dbx_value_regex' = 'automatic|facultative|retained|none');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'medical|financial|product_eligibility|stoli_detection|aml_kyc|age_band');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_source` SET TAGS ('dbx_business_glossary_term' = 'Rule Source');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_source` SET TAGS ('dbx_value_regex' = 'company_manual|reinsurer_guide|regulatory_requirement|industry_standard');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|retired|suspended');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'automated|manual_guideline|impairment_rating|decline_trigger|referral_trigger');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `standard_rating_action` SET TAGS ('dbx_business_glossary_term' = 'Standard Rating Action');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `standard_rating_action` SET TAGS ('dbx_value_regex' = 'standard|table_rating|flat_extra|decline|refer');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `table_rating_range_max` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Range Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `table_rating_range_max` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `table_rating_range_min` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Range Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `table_rating_range_min` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `underwriting_method_applicability` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Method Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `underwriting_method_applicability` SET TAGS ('dbx_value_regex' = 'full|simplified|guaranteed|accelerated|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` SET TAGS ('dbx_subdomain' = 'application_processing');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_uw_review_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting (UW) Review ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `retention_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `annual_income` SET TAGS ('dbx_business_glossary_term' = 'Annual Income');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `annual_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `annual_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `applied_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `approved_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `business_insurance_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Insurance Justification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `business_ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Business Ownership Percentage');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `business_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Business Valuation Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `business_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Financial Decline Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `existing_inforce_amount` SET TAGS ('dbx_business_glossary_term' = 'Existing In-Force Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_decision` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_reduced|declined|referred|pending_information');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_statement_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Reviewed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_statement_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_statement_type` SET TAGS ('dbx_value_regex' = 'tax_return|personal_financial_statement|business_financial_statement|bank_statement|investment_statement|none');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `human_life_value` SET TAGS ('dbx_business_glossary_term' = 'Human Life Value (HLV)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `income_replacement_multiple` SET TAGS ('dbx_business_glossary_term' = 'Income Replacement Multiple');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `insurable_interest_determination` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Determination');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `liquid_assets` SET TAGS ('dbx_business_glossary_term' = 'Liquid Assets');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `liquid_assets` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `liquid_assets` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `net_worth` SET TAGS ('dbx_business_glossary_term' = 'Net Worth');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `net_worth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `net_worth` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `over_insurance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Over-Insurance Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Completion Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Duration in Days');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Start Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'new_business|policy_increase|policy_change|reinstatement|conversion');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `stoli_red_flags` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Red Flags');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `stoli_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Risk Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `stoli_risk_indicator` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|confirmed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `total_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` SET TAGS ('dbx_subdomain' = 'risk_decisioning');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Placement Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `cession_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `premium_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `retention_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `treaty_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `automatic_binding_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Automatic Binding Confirmation Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `case_summary` SET TAGS ('dbx_business_glossary_term' = 'Case Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `ceding_risk_class_code` SET TAGS ('dbx_business_glossary_term' = 'Ceding Company Risk Class Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `cession_amount` SET TAGS ('dbx_business_glossary_term' = 'Cession Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `cession_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cession Percentage');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `facultative_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Facultative Acceptance Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `facultative_offer_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Facultative Offer Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `facultative_offer_received_date` SET TAGS ('dbx_business_glossary_term' = 'Facultative Offer Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `facultative_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `financial_evidence_transmitted` SET TAGS ('dbx_business_glossary_term' = 'Financial Evidence Transmitted Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `insured_age` SET TAGS ('dbx_business_glossary_term' = 'Insured Age');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `insured_gender` SET TAGS ('dbx_business_glossary_term' = 'Insured Gender');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `insured_gender` SET TAGS ('dbx_value_regex' = 'male|female|unspecified');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `insured_gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `insured_gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `medical_evidence_transmitted` SET TAGS ('dbx_business_glossary_term' = 'Medical Evidence Transmitted Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `medical_evidence_transmitted` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `medical_evidence_transmitted` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Placement Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `placement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `placement_status` SET TAGS ('dbx_business_glossary_term' = 'Placement Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'automatic|facultative|hybrid|declined|not_required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_decision` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_decision` SET TAGS ('dbx_value_regex' = 'approved_standard|approved_substandard|declined|postponed|counter_offer');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Exclusions');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_flat_extra_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Flat Extra Duration Months');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_risk_class_code` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Risk Class Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_table_rating` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `stoli_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` SET TAGS ('dbx_subdomain' = 'risk_decisioning');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `evidence_review_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `premium_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `aps_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Reference Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `claims_notification_text` SET TAGS ('dbx_business_glossary_term' = 'Claims Notification Text');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `excluded_cause_of_death` SET TAGS ('dbx_business_glossary_term' = 'Excluded Cause of Death');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_code` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_name` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_status` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_status` SET TAGS ('dbx_value_regex' = 'active|removed|expired|superseded');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Scope');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_scope` SET TAGS ('dbx_value_regex' = 'death_benefit_only|all_benefits|specific_rider');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_type` SET TAGS ('dbx_value_regex' = 'aviation|avocation|medical_condition|occupational_hazard|war_military|geographic_region');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `medical_director_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Director Approval Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `medical_director_approval_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `medical_director_approval_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `mib_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `mib_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `nar_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Impact Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `permanence_indicator` SET TAGS ('dbx_business_glossary_term' = 'Permanence Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `permanence_indicator` SET TAGS ('dbx_value_regex' = 'permanent|reviewable|conditional');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `premium_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Impact Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `reinsurance_acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Acceptance Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `reinsurance_acceptance_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|accepted|rejected|modified');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `reinsurance_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Notification Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Removal Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `review_criteria` SET TAGS ('dbx_business_glossary_term' = 'Review Criteria');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `review_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Review Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `stoli_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` SET TAGS ('dbx_subdomain' = 'medical_evidence');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `evidence_review_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Review Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `follow_up_evidence_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `icd_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `medical_condition_identified` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `medical_director_review_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `medical_director_review_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `mib_code_identified` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` SET TAGS ('dbx_subdomain' = 'application_processing');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` SET TAGS ('dbx_association_edges' = 'underwriting.rules_engine_output,underwriting.rule');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `rule_execution_result_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Result - Rule Execution Result Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Result - Rule Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `rules_engine_output_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Result - Rules Engine Output Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `decline_reason_codes` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Codes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `execution_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Sequence');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `fired_flag` SET TAGS ('dbx_business_glossary_term' = 'Rule Fired Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `refer_reason_codes` SET TAGS ('dbx_business_glossary_term' = 'Refer Reason Codes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `result` SET TAGS ('dbx_business_glossary_term' = 'Rule Result');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule_execution_result` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Rule Score');
