-- Schema for Domain: underwriting | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`underwriting` COMMENT 'Risk assessment and new business (NB) decisioning for life and annuity applications. Owns medical underwriting (APS, MIB lookups), financial underwriting, automated rules engine outputs, risk classifications, STOLI detection, and facultative/automatic reinsurance placement decisions. Manages underwriting workbench workflows, evidence requirements, mortality/morbidity risk evaluation, and NAR calculation for policy changes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`application` (
    `application_id` BIGINT COMMENT 'Primary key for application',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Application intake captures payer and billing setup preferences that establish the billing account for premium collection post-issue. Essential for new business processing workflow linking underwritin',
    `agency_id` BIGINT COMMENT 'Reference to the agency, Brokerage General Agency (BGA), or Managing General Agent (MGA) through which the application was submitted.',
    `compensation_contract_id` BIGINT COMMENT 'Foreign key linking to commission.compensation_contract. Business justification: Applications must validate the producers active compensation contract to ensure eligibility and determine applicable commission rates. Real business process: producer appointment verification and com',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter assigned to review and make a decision on this application.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Applications are written by specific legal entities (insurance carriers). Essential for statutory reporting, RBC calculations, consolidation, and regulatory filings. NAIC annual statements require app',
    `party_id` BIGINT COMMENT 'Reference to the proposed policy owner if different from the applicant. Nullable for owner-insured applications.',
    `plan_id` BIGINT COMMENT 'Reference to the life or annuity product applied for (e.g., Whole Life, Universal Life, Indexed Universal Life, Fixed Indexed Annuity, Single Premium Immediate Annuity).',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable life and annuity applications require applicants to select investment portfolios/funds for premium allocation. Core business process in variable product sales and administration. New attribut',
    `producer_id` BIGINT COMMENT 'Reference to the writing agent, broker, or producer who submitted the application.',
    `reinsurer_id` BIGINT COMMENT 'Reference to the reinsurance company assuming risk for this application under facultative or automatic reinsurance arrangements. Null if fully retained.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to commission.commission_schedule. Business justification: Applications must reference the commission schedule in effect at submission to calculate producer compensation. Critical for commission calculation, producer statements, and regulatory compliance (ens',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Variable product applications directly reference separate account funds chosen by applicant for premium investment. Essential for variable life/annuity underwriting and policy issuance. Separate accou',
    `program_id` BIGINT COMMENT 'Foreign key linking to underwriting.program. Business justification: Applications are submitted under specific underwriting programs (e.g., simplified issue, accelerated underwriting, traditional full underwriting). The program defines eligibility criteria, evidence re',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Applications require tracking of primary evidence vendors (exam companies, APS services) for vendor management, performance monitoring, and cost allocation. Essential for vendor selection and contract',
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
    `reinsurance_type` STRING COMMENT 'Type of reinsurance arrangement for this application: none (retained), automatic (treaty-based), facultative (case-by-case), or pending reinsurer decision.. Valid values are `none|automatic|facultative|pending`',
    `replacement_indicator` BOOLEAN COMMENT 'Indicates whether this application involves replacement of existing life insurance or annuity coverage, triggering additional suitability and disclosure requirements.',
    `source_system` STRING COMMENT 'Operational system of record from which this application data originated (e.g., RGAX AURA, Swiss Re Magnum underwriting workbench, policy administration system NB intake module).. Valid values are `rgax_aura|swiss_re_magnum|policy_admin|crm`',
    `stoli_risk_score` DECIMAL(18,2) COMMENT 'Automated risk score (0-100) assessing the likelihood that this application represents Stranger-Originated Life Insurance (STOLI), an illegal or unethical arrangement where investors initiate policies on individuals with no insurable interest.',
    `submission_channel` STRING COMMENT 'Channel through which the application was submitted to the company (e.g., agent portal, paper mail, email, fax, API integration, point-of-sale system).. Valid values are `agent_portal|paper_mail|email|fax|api_integration|pos_system`',
    `submission_date` DATE COMMENT 'Date the application was received by the insurance company for underwriting review.',
    `table_rating` STRING COMMENT 'Substandard table rating (A through P) applied for increased mortality risk. Each table typically represents a 25% premium increase. Null for standard and preferred classes.. Valid values are `^[A-P]$|`',
    `underwriting_class` STRING COMMENT 'Risk classification assigned by underwriting based on mortality/morbidity assessment. Determines final premium rate. Substandard may include table ratings.. Valid values are `preferred_plus|preferred|standard_plus|standard|substandard|declined`',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Core master record for a new business (NB) life or annuity insurance application submitted for underwriting review. Captures applicant details, product applied for, face amount, application date, submission channel, NIGO flags, application source (agent, BGA, MGA), and current underwriting workflow status. This is the primary anchor entity for the underwriting domain, originating from the Underwriting Workbench (RGAX AURA / Swiss Re Magnum) and Policy Administration System NB intake module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` (
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Unique identifier for the underwriting risk assessment record. Primary key for the risk assessment entity.',
    `application_id` BIGINT COMMENT 'Reference to the new business application being underwritten. Links this risk assessment to the originating application.',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Risk assessments trigger requirement letters, counter-offer notices, and decline communications. Core underwriting workflow: decision notification to applicants and agents. Domain experts expect this ',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter assigned to perform the risk assessment. Links to the agent/producer master for underwriter personnel.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Risk assessments must be attributed to the legal entity performing underwriting for regulatory compliance, reserve adequacy analysis, and statutory reporting. Real business need: state insurance depar',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Risk assessments reference specific mortality tables for mortality risk scoring and risk classification. Real business need: underwriting decision support, mortality debits/credits calculation, risk c',
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
    `medical_risk_classification` STRING COMMENT 'Medical underwriting risk classification based on mortality and morbidity evaluation. Reflects health status, medical history, and clinical findings.. Valid values are `preferred|standard|substandard|declined`',
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
    CONSTRAINT pk_underwriting_risk_assessment PRIMARY KEY(`underwriting_risk_assessment_id`)
) COMMENT 'Comprehensive underwriting risk evaluation master record for a life or annuity application, encompassing medical, financial, and compliance risk dimensions in a single holistic assessment. Medical underwriting: captures mortality and morbidity risk classification outputs, build chart results, aviation/avocation hazard ratings, APS review outcomes, MIB inquiry findings, and overall medical risk score. Financial underwriting: captures insurable interest determination, income replacement multiple analysis, human life value (HLV) calculation, business insurance justification (key person, buy-sell), existing coverage in-force summary, financial statement review notes, and financial underwriting decision outcome — ensures coverage amounts are financially justified and detects potential over-insurance. STOLI/IOLI detection: captures STOLI indicator flags (premium financing with non-recourse loans, investor-owned life insurance indicators, irrevocable trust ownership patterns, life settlement broker involvement, rapid policy transfer intent, unusual beneficiary designations), investigation status, compliance review outcome, state-specific STOLI statute compliance check, SIU referral flag, and STOLI determination (cleared, confirmed, inconclusive). Also captures NAR (Net Amount at Risk) calculations, NAR calculation method, and whether NAR triggers reinsurance cession thresholds. Represents the underwriters formal holistic risk evaluation tied to a specific application. Sourced from the Underwriting Workbench automated rules engine and manual underwriter review.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`risk_class` (
    `risk_class_id` BIGINT COMMENT 'Unique identifier for the risk classification category. Primary key for the risk class reference table.',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Risk classification rules must comply with state regulations prohibiting unfair discrimination (gender, genetic information, HIV status). Business process: state regulatory compliance for underwriting',
    `age_band_max` STRING COMMENT 'Maximum age (in years) for which this risk class is applicable. Null if no upper age limit applies.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) for which this risk class is applicable. Used to define age-specific risk classification rules.',
    `aml_risk_score` STRING COMMENT 'Anti-Money Laundering (AML) risk score (0-100) associated with this risk class for Know Your Customer (KYC) and AML compliance. Higher scores indicate elevated AML risk.',
    `cost_of_insurance_rate_class` STRING COMMENT 'Rate class code used to determine monthly Cost of Insurance (COI) charges for Universal Life (UL), Indexed Universal Life (IUL), and Variable Universal Life (VUL) products. Links to COI rate tables.',
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
    `reinsurance_cession_class` STRING COMMENT 'Reinsurance classification code used for automatic or facultative reinsurance cession. Maps risk class to reinsurer treaty terms and retention limits.',
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
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who made the final decision on this application.',
    `decision_supervisory_approver_employee_id` BIGINT COMMENT 'Reference to the senior underwriter or supervisor who approved the decision. Null if supervisory approval was not required or not yet obtained.',
    `reinsurer_id` BIGINT COMMENT 'Reference to the facultative reinsurer if facultative reinsurance was placed. Null for automatic reinsurance or retained cases.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy record if the application was approved and issued. Null for declined or postponed decisions.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Underwriting decisions produce formal decision letters, decline notifications, and approval documents sent to applicants and producers. Business process: policy issuance workflow and producer notifica',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Underwriting decisions must be tracked by legal entity for regulatory reporting, RBC calculations, and statutory compliance. Real business need: NAIC annual statements require decision statistics (app',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Underwriting decisions document which mortality table was used for final risk classification and pricing. Real business need: audit trail, reinsurance facultative submissions, regulatory examination s',
    `premium_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.premium_schedule. Business justification: Underwriting decision (approved risk class, table ratings, flat extras) directly determines premium schedule created at policy issue. Core business process: underwriting approval triggers billing setu',
    `program_id` BIGINT COMMENT 'Foreign key linking to underwriting.program. Business justification: Underwriting decisions are made within the context of specific underwriting programs. The program defines decision authority limits, acceptable risk classes, and approval thresholds. Linking decision ',
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
    `reinsurance_type` STRING COMMENT 'The type of reinsurance placement required. Automatic indicates coverage under existing automatic treaty. Facultative indicates case-by-case reinsurance negotiation required. Not Required indicates risk retained in full.. Valid values are `Automatic|Facultative|Not Required`',
    `risk_class` STRING COMMENT 'The assigned risk classification for the insured. Preferred Plus and Preferred indicate superior mortality risk. Standard Plus and Standard indicate average mortality risk. Substandard indicates elevated mortality risk requiring rating. Declined indicates uninsurable risk.. Valid values are `Preferred Plus|Preferred|Standard Plus|Standard|Substandard|Declined`',
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
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Evidence orders (APS, exams, financial statements) require communications to vendors, physicians, and applicants. Real workflow: evidence ordering, scheduling, and follow-up tracking. Critical for cas',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: Facultative reinsurers require specific medical evidence (APS, paramedicals, labs) before making underwriting decisions. Evidence gathered during underwriting is transmitted to facultative reinsurer a',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy being underwritten or re-underwritten, if applicable for policy change cases.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Evidence requirements are summarized by period for vendor cost analysis, turnaround time reporting, evidence ordering efficiency metrics, and vendor performance scorecards. Core operational metric for',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who reviewed this document. May differ from the primary underwriter assigned to the risk assessment if multiple underwriters collaborate. Explicitly identified in detection phase relationship data.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Evidence requirements are often triggered by specific riders (e.g., aviation rider requires aviation questionnaire, LTC rider requires ADL assessment). Underwriters need to track which rider triggered',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to vendor.service_order. Business justification: Evidence requirements generate vendor service orders for fulfillment. Links underwriting evidence needs to specific vendor orders for order status tracking, invoice matching, SLA measurement, and cost',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Evidence requirements are ordered and tracked as part of the risk assessment process. The evidence_requirement table consolidates all evidence items (medical exams, APS, MIB, lab results) ordered for ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Evidence requirements are fulfilled by specific contracted vendors. Links underwriting evidence needs to vendor master for contract compliance, SLA tracking, invoice reconciliation, and vendor perform',
    `blood_pressure_diastolic` STRING COMMENT 'Diastolic blood pressure reading in mmHg from paramedical examination.',
    `blood_pressure_systolic` STRING COMMENT 'Systolic blood pressure reading in mmHg from paramedical examination.',
    `completion_status` STRING COMMENT 'Indicates whether the evidence item is complete and sufficient for underwriting decision or requires additional information.. Valid values are `complete|incomplete|partial|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evidence requirement record was first created in the underwriting workbench system.',
    `document_type_context` STRING COMMENT 'Classification of the document type within the context of this specific risk assessment (e.g., medical_evidence, financial_statement, mib_report, aps_record, compliance_document). Provides assessment-specific categorization that may differ from the documents general type. Explicitly identified in detection phase relationship data.',
    `evidence_cost_amount` DECIMAL(18,2) COMMENT 'Cost incurred by the insurance company to obtain this evidence from the vendor or provider.',
    `evidence_review_id` BIGINT COMMENT 'Unique identifier for the evidence review record. Primary key for the association.',
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
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: APS requests involve formal communications with physicians (authorization, request letters, follow-ups). Business process: medical records acquisition workflow. Essential for tracking physician corres',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who reviewed the APS.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy if APS is requested post-issue for underwriting review or policy change.',
    `document_id` BIGINT COMMENT 'Reference identifier to the stored APS document in the document management system.',
    `party_id` BIGINT COMMENT 'Reference to the insured individual whose medical history is documented in this APS.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: APS records are aggregated by period for vendor performance analysis, cost tracking, turnaround time reporting, and physician responsiveness metrics. Required for APS vendor management and evidence ac',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to vendor.service_order. Business justification: APS records are obtained through specific vendor service orders. Links APS requests to vendor orders for order tracking, turnaround time measurement, invoice reconciliation, and cost allocation. Enabl',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: APS (Attending Physician Statement) records are medical evidence that feeds into the comprehensive risk_assessment. Physician statements provide medical history, treatment details, and prognosis that ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: APS records are obtained through contracted APS retrieval vendors. Essential for vendor cost allocation, performance tracking, turnaround time analysis, and invoice matching. Replaces denormalized aps',
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
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who reviewed the MIB inquiry results. Used for accountability and quality assurance.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: MIB inquiries generate response documents with condition codes and hit indicators. Business process: underwriters review MIB response documents for discrepancy detection and STOLI investigation. No ex',
    `party_id` BIGINT COMMENT 'Reference to the individual applicant whose medical history is being checked through MIB. The proposed insured or annuitant.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: MIB inquiries are tracked by period for hit rate analysis, discrepancy trending, compliance reporting, and fraud detection effectiveness. Required for MIB program effectiveness measurement and regulat',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: MIB (Medical Information Bureau) inquiry results are evidence that feeds into the comprehensive risk_assessment. MIB findings (condition_codes, hit_indicator, discrepancy_detected_flag) inform medical',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: MIB inquiries are services provided by MIB Group as a contracted vendor. Enables tracking MIB as vendor for contract management, invoice reconciliation, service cost allocation, and SLA monitoring. Es',
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
    `employee_id` BIGINT COMMENT 'Unique identifier for the individual paramedical examiner who conducted the examination. Used for quality tracking and auditing.',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Paramedical exams require scheduling communications, confirmation notices, rescheduling correspondence, and results notifications. Real workflow: exam coordination with applicants and vendors. Critica',
    `exam_vendor_order_id` BIGINT COMMENT 'Foreign key linking to vendor.exam_vendor_order. Business justification: Paramedical exams are fulfilled through exam vendor orders. Links underwriting exam requirements to vendor order system for scheduling coordination, results transmission tracking, invoice matching, an',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Paramedical exams produce lab reports, examiner notes, and specimen results as documents. Business process: underwriters access exam documents during risk classification and decision-making. No existi',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Paramedical exams are tracked by period for vendor performance reporting, cost analysis, exam completion rate metrics, and examiner quality assessment. Essential for paramedical vendor management and ',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Paramedical examination results are medical evidence that feeds into the comprehensive risk_assessment. Exam findings (blood pressure, BMI, lab results, abnormal findings) inform medical risk classifi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Paramedical exams are performed by contracted exam vendors. Critical for vendor assignment, scheduling coordination, invoice reconciliation, SLA compliance monitoring, and vendor performance scoring. ',
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
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Automated underwriting rules reference mortality tables for STP decisioning and mortality risk scoring. Real business need: rules calibration, mortality assumption alignment between underwriting and a',
    `risk_class_id` BIGINT COMMENT 'Reference to the risk classification recommended by the rules engine based on automated evaluation of mortality and morbidity risk factors.',
    `program_id` BIGINT COMMENT 'Foreign key linking to underwriting.program. Business justification: Rules engine evaluations are executed within the context of specific underwriting programs. The program defines the rule set, evidence requirements, and decision parameters. Linking rules_engine_outpu',
    `aml_risk_score` DECIMAL(18,2) COMMENT 'Anti-money laundering (AML) risk score (0-100) calculated by the rules engine based on financial underwriting data, source of funds, and Know Your Customer (KYC) checks. Higher scores indicate elevated AML risk.',
    `applicant_age` STRING COMMENT 'Age of the primary applicant at the time of rules engine evaluation. Critical factor in mortality risk assessment and risk classification.',
    `applicant_gender` STRING COMMENT 'Gender of the primary applicant. Used in mortality table selection and risk classification where permitted by state regulations.. Valid values are `male|female|unspecified`',
    `aps_required_flag` BOOLEAN COMMENT 'Indicates whether the rules engine determined that an Attending Physician Statement (APS) is required based on medical history disclosures or risk factors.',
    `automated_decision` STRING COMMENT 'The automated underwriting decision recommendation generated by the rules engine. Approve indicates auto-approval eligibility, decline indicates auto-decline, refer indicates human review required, pend indicates additional information needed.. Valid values are `approve|decline|refer|pend`',
    `calculated_nar_amount` DECIMAL(18,2) COMMENT 'The net amount at risk (NAR) calculated by the rules engine, representing the insurers exposure (typically death benefit minus reserve or cash value).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rules engine output record was first created in the system. Used for audit trail and data lineage.',
    `decline_reason_codes` STRING COMMENT 'Comma-separated list of reason codes for rules that triggered an automated decline recommendation. Used for adverse action notices and regulatory compliance.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the rules engine evaluation was executed. Represents the business event time of automated decisioning.',
    `evidence_requirements_met_flag` BOOLEAN COMMENT 'Indicates whether all required underwriting evidence (Attending Physician Statement (APS), Medical Information Bureau (MIB) reports, lab results, financial documents) has been received and evaluated by the rules engine.',
    `face_amount` DECIMAL(18,2) COMMENT 'The death benefit or face amount of the policy being underwritten. Used by the rules engine to determine retention limits, reinsurance requirements, and evidence thresholds.',
    `financial_underwriting_required_flag` BOOLEAN COMMENT 'Indicates whether the rules engine determined that enhanced financial underwriting is required based on coverage amount, income verification needs, or STOLI risk indicators.',
    `jurisdiction_code` STRING COMMENT 'Two-letter state or jurisdiction code where the policy will be issued. Determines applicable regulatory requirements and underwriting rules.. Valid values are `^[A-Z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rules engine output record was last modified. Used for audit trail and change tracking.',
    `mib_check_status` STRING COMMENT 'Status of the Medical Information Bureau (MIB) check performed as part of the automated underwriting evaluation. MIB provides medical history information from previous insurance applications.. Valid values are `completed|pending|not_required|failed`',
    `mib_codes_found` STRING COMMENT 'Comma-separated list of MIB codes identified during the MIB check. MIB codes represent medical conditions or risk factors from prior insurance applications.',
    `nar_calculation_method` STRING COMMENT 'Method used by the rules engine to calculate the net amount at risk (NAR) for reinsurance and risk assessment purposes. NAR represents the insurance companys exposure on the policy.. Valid values are `death_benefit_minus_reserve|face_amount_minus_cash_value|custom`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the rules engine evaluation, including any system warnings, edge cases, or contextual information for underwriter review.',
    `product_line` STRING COMMENT 'The life insurance or annuity product line being underwritten. Different product lines have different underwriting rules and risk tolerances.. Valid values are `term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity`',
    `recommended_flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Flat extra premium per thousand dollars of coverage recommended by the rules engine for specific impairments or occupational hazards.',
    `recommended_table_rating` STRING COMMENT 'Table rating (A through P or STD for standard) recommended by the rules engine for substandard risk pricing. Each letter represents an incremental mortality charge.. Valid values are `^[A-P]$|^STD$`',
    `refer_reason_codes` STRING COMMENT 'Comma-separated list of reason codes for rules that triggered a refer outcome, requiring human underwriter review. Each code represents a specific underwriting concern or exception.',
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
    `impairment_guide_id` BIGINT COMMENT 'Foreign key linking to underwriting.impairment_guide. Business justification: Underwriting rules reference specific impairment guidelines from the master impairment_guide catalog. The rule table has impairment_code and impairment_name attributes; adding FK to impairment_guide a',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Individual underwriting rules are calibrated to specific mortality tables for impairment ratings and table rating assignments. Real business need: rules maintenance, actuarial assumption updates, rein',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Underwriting rules are frequently rider-specific (e.g., waiver of premium rider has disability definition rules, accidental death rider has aviation/avocation hazard rules). Rules engine must referenc',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Underwriting rules must align with state-specific requirements (HIV testing restrictions, genetic information prohibitions, unfair discrimination laws). Business process: state regulatory compliance f',
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
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who performed the financial review.',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: Jumbo cases requiring facultative reinsurance need detailed financial underwriting analysis transmitted to reinsurer. Financial review findings (income verification, net worth, insurable interest dete',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Financial underwriting often requires additional documentation requests (tax returns, financial statements, business valuations) communicated to applicants. Real process: financial evidence gathering ',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy if this review is for a policy change or increase.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Financial underwriting reviews analyze financial statements, tax returns, and business valuations submitted as documents. Business process: STOLI detection, insurable interest determination, and over-',
    `party_id` BIGINT COMMENT 'Reference to the applicant whose financial situation is being reviewed.',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Financial underwriting reviews are tracked by period for large case analysis, over-insurance trending, AML reporting, and high net worth market segment analysis. Essential for financial underwriting p',
    `service_order_id` BIGINT COMMENT 'Foreign key linking to vendor.service_order. Business justification: Financial underwriting reviews may require third-party services (credit reports, business valuations, financial statement verification). Links financial reviews to vendor service orders for cost track',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: Financial underwriting review is a specialized component that feeds into the comprehensive risk_assessment. The financial review evaluates economic justification and insurable interest, contributing f',
    `additional_evidence_required` STRING COMMENT 'Description of additional financial documentation or evidence needed to complete the financial underwriting review.',
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

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` (
    `stoli_review_id` BIGINT COMMENT 'Unique identifier for the STOLI review record. Primary key for the STOLI detection and investigation case.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to agent.agency. Business justification: STOLI pattern analysis requires agency-level tracking. Compliance officers monitor agencies recruiting investors for life settlement schemes. Direct link enables agency-level fraud analytics and regul',
    `application_id` BIGINT COMMENT 'Reference to the new business application undergoing STOLI review. Links this review to the policy application being evaluated.',
    `facultative_submission_id` BIGINT COMMENT 'Foreign key linking to reinsurance.facultative_submission. Business justification: STOLI determinations must be disclosed to facultative reinsurers as they materially impact reinsurability, pricing, and legal risk. Regulatory and contractual requirement that STOLI investigation find',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: STOLI investigations collect evidence documents including trust agreements, premium financing contracts, and life settlement broker correspondence. Business process: compliance review, SIU referral, a',
    `employee_id` BIGINT COMMENT 'Identifier of the underwriter who initiated or is managing the STOLI review investigation.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: STOLI investigations must track producer involvement in stranger-originated schemes. Regulatory requirement for fraud detection and producer compliance monitoring. Direct link supports state insurance',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: STOLI reviews are aggregated by period for state insurance department regulatory filings, fraud detection trending, compliance dashboards, and SIU activity reporting. Required for anti-fraud program e',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: STOLI investigations may require communications with applicants (additional information requests), agents (inquiry notices), or regulators (reporting). Compliance process: fraud investigation document',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_assessment. Business justification: STOLI (Stranger-Originated Life Insurance) review is a specialized investigation that feeds findings into the comprehensive risk_assessment. STOLI determination impacts overall risk classification. No',
    `automated_rules_engine_output` STRING COMMENT 'Detailed output from the underwriting workbench automated rules engine listing all STOLI indicator rules triggered and their severity levels.',
    `compliance_review_outcome` STRING COMMENT 'Final compliance review outcome determining whether the application may proceed to issue, must be declined, or requires conditional approval with enhanced monitoring.. Valid values are `approved|declined|conditional_approval|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this STOLI review record was first created in the system.',
    `decline_reason` STRING COMMENT 'Detailed reason for declining the application if STOLI determination results in non-issue decision, citing specific statute violations or fraud indicators.',
    `evidence_documents_collected` STRING COMMENT 'List or description of evidence documents collected during STOLI investigation, such as trust documents, financing agreements, correspondence with brokers, or beneficiary statements.',
    `face_amount` DECIMAL(18,2) COMMENT 'The death benefit face amount of the policy under STOLI review. Large face amounts on elderly insureds are common STOLI indicators.',
    `insurable_interest_concern` STRING COMMENT 'Narrative description of specific insurable interest concerns identified during review, such as lack of familial or financial relationship between owner and insured.',
    `insured_age_at_application` STRING COMMENT 'Age of the insured at time of application. STOLI schemes often target elderly insureds (age 65+) with high mortality risk for investor profit.',
    `investigation_notes` STRING COMMENT 'Free-text narrative notes documenting the investigation process, evidence gathered, interviews conducted, and rationale for final determination.',
    `investor_owned_indicator` BOOLEAN COMMENT 'Flag indicating evidence that the policy is being purchased by or for the benefit of investors without insurable interest, characteristic of IOLI schemes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this STOLI review record was last updated, tracking investigation progress and status changes.',
    `life_settlement_broker_involvement` BOOLEAN COMMENT 'Flag indicating involvement of life settlement broker or viatical settlement provider at point of application, suggesting pre-arranged intent to transfer policy to secondary market.',
    `non_recourse_loan_indicator` BOOLEAN COMMENT 'Flag indicating whether premium financing involves a non-recourse loan where lender has no recourse against borrower beyond policy collateral, a hallmark of STOLI arrangements.',
    `policy_number` STRING COMMENT 'The policy number assigned to the application under review, if policy has been issued conditionally pending STOLI clearance.',
    `premium_financing_indicator` BOOLEAN COMMENT 'Flag indicating whether the application involves premium financing with non-recourse loan structure, a common STOLI red flag where investor funds premiums with expectation of policy transfer.',
    `product_type` STRING COMMENT 'The type of life insurance product applied for (e.g., Universal Life, Whole Life, Term). Universal Life and Indexed Universal Life are common STOLI targets due to cash value accumulation.',
    `rapid_transfer_intent_indicator` BOOLEAN COMMENT 'Flag indicating evidence of intent to transfer policy ownership within contestability period or shortly after issue, violating insurable interest and anti-STOLI statutes.',
    `regulatory_report_date` DATE COMMENT 'Date when the STOLI case was reported to state insurance department or regulatory authority, if reporting was required.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Flag indicating whether this confirmed STOLI case must be reported to state insurance department or other regulatory authorities per anti-fraud reporting requirements.',
    `review_completed_date` DATE COMMENT 'Date when the STOLI review investigation was finalized and a determination was made.',
    `review_initiated_date` DATE COMMENT 'Date when the STOLI review was formally opened, typically triggered by automated rules engine or manual underwriter referral.',
    `review_status` STRING COMMENT 'Current status of the STOLI review investigation workflow. Tracks progression from initial detection through final determination. [ENUM-REF-CANDIDATE: pending|in_progress|under_investigation|referred_to_siu|cleared|confirmed_stoli|inconclusive|closed — 8 candidates stripped; promote to reference product]',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score (0-100 scale) calculated by automated rules engine based on weighted STOLI indicator flags. Higher scores indicate greater STOLI risk.',
    `siu_case_number` STRING COMMENT 'The SIU case tracking number assigned to this STOLI investigation if escalated to fraud investigation unit.',
    `siu_referral_date` DATE COMMENT 'Date when the STOLI case was formally referred to the Special Investigations Unit for enhanced fraud investigation.',
    `siu_referral_flag` BOOLEAN COMMENT 'Flag indicating whether the case has been escalated to the Special Investigations Unit for fraud investigation due to severity of STOLI indicators.',
    `source_system` STRING COMMENT 'The operational system of record that originated this STOLI review record, typically the Underwriting Workbench or Policy Administration System.',
    `state_statute_compliance_status` STRING COMMENT 'Assessment of whether the application complies with the applicable state anti-STOLI statute requirements, including transfer restrictions and insurable interest mandates.. Valid values are `compliant|non_compliant|requires_review|not_applicable`',
    `state_stoli_statute_jurisdiction` STRING COMMENT 'The state jurisdiction whose anti-STOLI statute applies to this application, typically the state of policy delivery or insured residence.',
    `stoli_determination` STRING COMMENT 'Final determination outcome of the STOLI review. Cleared indicates no STOLI indicators confirmed; confirmed_stoli or confirmed_ioli indicates fraudulent life settlement scheme detected; inconclusive requires additional investigation or business judgment.. Valid values are `cleared|confirmed_stoli|confirmed_ioli|inconclusive|pending_investigation`',
    `trust_ownership_pattern_flag` BOOLEAN COMMENT 'Flag indicating suspicious irrevocable trust ownership patterns such as recently-formed trusts, trusts with investor beneficiaries, or trusts structured to facilitate rapid policy transfer.',
    `unusual_beneficiary_designation_flag` BOOLEAN COMMENT 'Flag indicating unusual or suspicious beneficiary designations such as non-family members, business entities without clear insurable interest, or life settlement investors named as beneficiaries.',
    CONSTRAINT pk_stoli_review PRIMARY KEY(`stoli_review_id`)
) COMMENT 'Stranger-Originated Life Insurance (STOLI) and Investor-Originated Life Insurance (IOLI) detection and review record for a new business application. Captures STOLI indicator flags triggered (premium financing arrangement with non-recourse loan, investor-owned life insurance indicators, irrevocable trust ownership patterns, life settlement broker involvement, rapid policy transfer intent, unusual beneficiary designations), investigation status, compliance review outcome, state-specific STOLI statute compliance check, referral to Special Investigations Unit (SIU) flag, and final STOLI determination (cleared, confirmed STOLI, inconclusive). Critical compliance control required by state anti-STOLI statutes to prevent fraudulent life settlement schemes at the point of underwriting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` (
    `reinsurance_placement_id` BIGINT COMMENT 'Unique identifier for the reinsurance placement record. Primary key for this entity.',
    `application_id` BIGINT COMMENT 'Reference to the new business application for which this reinsurance placement decision was made.',
    `reinsurance_recoverable_id` BIGINT COMMENT 'Foreign key linking to finance.reinsurance_recoverable. Business justification: Reinsurance placements establish the basis for future recoverables on claims and reserves. Real business need: actuarial and finance teams reconcile placements to recoverable balances for reserve adeq',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the issued policy if the application was approved and bound. Null for declined or pending applications.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Facultative reinsurance placements generate submission packages, reinsurer offer letters, and acceptance confirmations. Business process: treaty administration, cession tracking, and reinsurer communi',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Reinsurance placements trigger accounting entries for ceded premiums, ceded reserves, and reinsurance recoverables. Real business need: GAAP/SAP require journal entries for every reinsurance transacti',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Reinsurance recoverables are backed by specific investment portfolios in ALM management. Real business process: matching ceded liability cash flows with dedicated reinsurance asset portfolios for regu',
    `reinsurance_treaty_id` BIGINT COMMENT 'Reference to the automatic reinsurance treaty under which this placement was made. Populated for automatic placements; null for facultative.',
    `reinsurer_id` BIGINT COMMENT 'Reference to the primary reinsurer selected for this placement. For facultative placements, this is the reinsurer whose offer was accepted. For automatic placements, this is the treaty reinsurer.',
    `risk_class_id` BIGINT COMMENT 'Reference to the underwriting risk class assigned by the ceding company (e.g., Preferred Plus, Standard, Table B). Used to determine retention limits and automatic treaty eligibility.',
    `program_id` BIGINT COMMENT 'Foreign key linking to underwriting.program. Business justification: Reinsurance placement rules and retention limits vary by underwriting program. The program defines automatic vs. facultative thresholds, treaty applicability, and cession requirements. Linking reinsur',
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
    `plan_code` STRING COMMENT 'Specific product plan code for the policy being reinsured. Used to determine retention limits and treaty applicability.',
    `product_line` STRING COMMENT 'Product line category of the policy being reinsured: term, whole_life, universal_life, variable_universal_life, indexed_universal_life, annuity, disability_income, or long_term_care. [ENUM-REF-CANDIDATE: term|whole_life|universal_life|variable_universal_life|indexed_universal_life|annuity|disability_income|long_term_care — 8 candidates stripped; promote to reference product]',
    `reinsurance_premium_basis` STRING COMMENT 'Basis on which reinsurance premiums are calculated: yrt (yearly renewable term), coinsurance (proportional sharing), modified_coinsurance (coinsurance with funds withheld), funds_withheld (coinsurance with investment control retained by ceding company).. Valid values are `yrt|coinsurance|modified_coinsurance|funds_withheld`',
    `reinsurance_premium_rate` DECIMAL(18,2) COMMENT 'Premium rate per thousand dollars of ceded NAR charged by the reinsurer. For YRT treaties, this is the yearly renewable term rate. For coinsurance, this is the coinsurance percentage.',
    `reinsurer_decision` STRING COMMENT 'Final decision rendered by the reinsurer: approved_standard (accepted at standard rates), approved_substandard (accepted with ratings/extras), declined (rejected), postponed (deferred pending additional information), counter_offer (alternative terms proposed).. Valid values are `approved_standard|approved_substandard|declined|postponed|counter_offer`',
    `reinsurer_exclusions` STRING COMMENT 'Text description of any coverage exclusions imposed by the reinsurer (e.g., aviation exclusion, hazardous activity exclusion). Null if no exclusions.',
    `reinsurer_flat_extra_duration_months` STRING COMMENT 'Duration in months for which the reinsurer flat extra premium applies. Null if permanent or no flat extra.',
    `reinsurer_flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Flat extra premium per thousand dollars of coverage charged by the reinsurer for substandard risks. Zero if no flat extra applied.',
    `reinsurer_risk_class_code` STRING COMMENT 'Risk class code assigned by the reinsurer. May differ from ceding company risk class for facultative placements. Null for automatic placements where reinsurer accepts ceding company classification.',
    `reinsurer_table_rating` STRING COMMENT 'Table rating assigned by the reinsurer (e.g., Table B, Table D). Indicates substandard risk classification. Null if standard risk.',
    `retention_limit_amount` DECIMAL(18,2) COMMENT 'Maximum NAR amount the ceding company will retain on this risk based on retention limit schedule (product line, plan, age, gender, risk class). Amount above this triggers reinsurance cession.',
    `source_system` STRING COMMENT 'Name of the source system from which this reinsurance placement record originated (e.g., RGAX AURA, Swiss Re Magnum, RGA AURA Reinsurance, Swiss Re IRIS).',
    `stoli_indicator` BOOLEAN COMMENT 'Flag indicating whether STOLI risk was detected during underwriting. True if STOLI indicators present, false otherwise. Impacts reinsurer acceptance and placement terms.',
    CONSTRAINT pk_reinsurance_placement PRIMARY KEY(`reinsurance_placement_id`)
) COMMENT 'Consolidated underwriting reinsurance placement, cession decision, and retention limit record for a specific application. Encompasses the full reinsurance placement workflow: retention limit schedule (product line, plan code, insured age band, gender, risk class, retention limit amount, effective date, reinsurance treaty reference), NAR-based cession threshold evaluation, placement type determination (automatic YRT/coinsurance vs. facultative). For automatic placements: treaty reference, cession amount, and automatic binding confirmation. For facultative placements: submission date, reinsurer(s) submitted to, case summary, medical and financial evidence package transmitted, reinsurer offer details (risk class, table rating, flat extra, exclusions, offer expiration date), accepted offer reference, and facultative placement workflow status from submission through acceptance. Stores reinsurer selected, reinsurer decision, reinsurer risk class assigned, and overall placement status. Bridges the underwriting domain to the reinsurance domain for NAR-based cession decisions made at the time of underwriting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`case_activity` (
    `case_activity_id` BIGINT COMMENT 'Primary key for case_activity',
    `compliance_training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Underwriter case activities require documented training completion (STOLI detection, AML red flags, suitability). Regulatory requirement: staff performing underwriting must have current training. Link',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Case activities track document-related events (evidence received, APS reviewed, decision letter sent). Business process: audit trail, workflow tracking, and SLA monitoring require linking activities t',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed or initiated the activity. May be a system identifier for automated activities. Used for audit trail and workload attribution.',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to underwriting.risk_class. Business justification: Case activity events track risk class changes and assignments throughout the underwriting workflow. Adding FK to risk_class reference table for normalization. Removing risk_class_code as it becomes re',
    `application_id` BIGINT COMMENT 'Reference to the parent underwriting case for which this activity was recorded. Links activity to the application case being underwritten.',
    `decision_id` BIGINT COMMENT 'Foreign key linking to underwriting.decision. Business justification: Case activity events reference formal underwriting decisions. When a decision is made, the activity log should link to the decision record. Removing decision_code as it becomes redundant with decision',
    `rules_engine_output_id` BIGINT COMMENT 'Foreign key linking to underwriting.rules_engine_output. Business justification: Case activity log entries track workflow events including rules engine evaluations. When automated rules are executed, the activity log should reference the specific rules_engine_output record. No col',
    `activity_name` STRING COMMENT 'Human-readable name or description of the underwriting activity performed. Provides business-friendly label for the activity type.',
    `activity_notes` STRING COMMENT 'Free-text notes or comments recorded by the underwriter or system regarding this activity. Provides additional context, rationale, or instructions related to the workflow event.',
    `activity_status` STRING COMMENT 'Current status of the activity within the workflow. Indicates whether the activity has been completed, is pending, in progress, failed, or was cancelled.. Valid values are `completed|pending|in_progress|failed|cancelled`',
    `activity_timestamp` TIMESTAMP COMMENT 'Date and time when the underwriting activity occurred or was recorded in the system. Primary business event timestamp for workflow tracking and Service Level Agreement (SLA) monitoring.',
    `activity_type_code` STRING COMMENT 'Code representing the type of underwriting workflow activity. [ENUM-REF-CANDIDATE: EVIDENCE_ORDERED|EVIDENCE_RECEIVED|CASE_ASSIGNED|CASE_REASSIGNED|PRIORITY_CHANGED|REFERRAL_SENIOR_UW|REINSURANCE_SUBMITTED|DECISION_RENDERED|COUNTER_OFFER_ISSUED|APPLICANT_NOTIFICATION_SENT|SLA_ESCALATION_TRIGGERED|QUEUE_ENTRY|QUEUE_EXIT|MEDICAL_REVIEW_REQUESTED|FINANCIAL_REVIEW_REQUESTED|APS_ORDERED|MIB_LOOKUP_COMPLETED|CASE_SUSPENDED|CASE_REOPENED|CASE_WITHDRAWN|REQUIREMENTS_WAIVED — promote to reference product]. Valid values are `EVIDENCE_ORDERED|EVIDENCE_RECEIVED|CASE_ASSIGNED|CASE_REASSIGNED|PRIORITY_CHANGED|REFERRAL_SENIOR_UW`',
    `assigned_underwriter_name` STRING COMMENT 'Full name of the underwriter assigned to the case at the time of this activity. Provides human-readable identification for reporting and workload distribution analysis.',
    `automated_flag` BOOLEAN COMMENT 'Indicator of whether the activity was performed by an automated system or rules engine versus a human underwriter. True for automated activities, False for manual activities.',
    `case_priority_level` STRING COMMENT 'Priority level assigned to the case at the time of this activity. Determines processing urgency and Service Level Agreement (SLA) targets. May change throughout case lifecycle.. Valid values are `critical|high|normal|low`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this activity record was first created in the system. Used for audit trail and data lineage tracking.',
    `decision_rationale` STRING COMMENT 'Explanation or justification for the underwriting decision rendered in this activity. Provides business rationale for approval, decline, or counter-offer decisions.',
    `duration_seconds` BIGINT COMMENT 'Duration of the activity in seconds. Measures the time spent on manual activities or the elapsed time for system processes. Used for productivity and efficiency analysis.',
    `escalation_reason_code` STRING COMMENT 'Code indicating the reason for escalation or referral to senior underwriter. Examples include high Net Amount at Risk (NAR), complex medical history, Stranger-Originated Life Insurance (STOLI) suspicion, Anti-Money Laundering (AML) concern.',
    `evidence_type_code` STRING COMMENT 'Code identifying the type of evidence ordered or received in this activity. Examples include Attending Physician Statement (APS), Medical Information Bureau (MIB) report, financial statements, paramedical exam. Populated for evidence-related activities.',
    `evidence_vendor_name` STRING COMMENT 'Name of the third-party vendor or service provider from whom evidence was ordered or received. Examples include Medical Information Bureau (MIB), paramedical exam providers, Attending Physician Statement (APS) retrieval services.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this activity record was last updated in the system. Used for audit trail and change tracking.',
    `new_status` STRING COMMENT 'Status of the case immediately after this activity occurred. Captures state transition for audit trail and workflow analysis.',
    `notification_channel` STRING COMMENT 'Communication channel used to send notification to applicant or agent. Values include email, postal mail, phone, customer portal, or fax.. Valid values are `email|postal_mail|phone|portal|fax`',
    `notification_type_code` STRING COMMENT 'Code identifying the type of notification sent to the applicant or agent. Examples include decision letter, requirements letter, counter-offer notification, decline notification. Populated for applicant notification activities.',
    `performing_system_name` STRING COMMENT 'Name of the system or automated process that performed the activity when not initiated by a human user. Examples include automated rules engine, batch process, or integration service.',
    `performing_user_name` STRING COMMENT 'Full name of the user who performed the activity. Provides human-readable identification for audit and reporting purposes.',
    `previous_priority_level` STRING COMMENT 'Priority level of the case before this activity. Relevant for priority change activities to track escalations and de-escalations.. Valid values are `critical|high|normal|low`',
    `previous_status` STRING COMMENT 'Status of the case immediately before this activity occurred. Captures state transition for audit trail and workflow analysis.',
    `queue_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the case entered the queue associated with this activity. Used to calculate queue residence time and Service Level Agreement (SLA) compliance.',
    `queue_exit_timestamp` TIMESTAMP COMMENT 'Date and time when the case exited the queue associated with this activity. Used to calculate queue residence time and throughput metrics.',
    `queue_name` STRING COMMENT 'Name of the work queue where the case resided at the time of this activity. Examples include New Business (NB) Intake Queue, Medical Review Queue, Senior Underwriter Queue, Reinsurance Submission Queue.',
    `reinsurance_submission_flag` BOOLEAN COMMENT 'Indicator of whether this activity involved submission to a reinsurer for facultative or automatic reinsurance placement. True if reinsurance was submitted, False otherwise.',
    `reinsurer_name` STRING COMMENT 'Name of the reinsurance company to which the case was submitted. Populated for reinsurance submission activities.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether this activity resulted in a Service Level Agreement (SLA) breach. True if the activity was completed after the SLA due timestamp, False otherwise.',
    `sla_due_timestamp` TIMESTAMP COMMENT 'Target date and time by which the activity or case processing step must be completed to meet Service Level Agreement (SLA) commitments. Used for escalation triggers and performance monitoring.',
    `source_system_name` STRING COMMENT 'Name of the source system that generated this activity record. Examples include Underwriting Workbench, Policy Administration System, automated rules engine.',
    `underwriting_team_code` STRING COMMENT 'Code identifying the underwriting team responsible for the case at the time of this activity. Used for team-level workload and performance reporting.',
    `underwriting_team_name` STRING COMMENT 'Name of the underwriting team responsible for the case. Examples include Medical Underwriting Team, Financial Underwriting Team, Senior Underwriting Team.',
    CONSTRAINT pk_case_activity PRIMARY KEY(`case_activity_id`)
) COMMENT 'Chronological activity log of all underwriting workflow events, actions, work assignments, and queue routing for a specific application case within the Underwriting Workbench. Captures activity type (evidence ordered, evidence received, case assigned to underwriter, case reassigned, priority changed, referral to senior underwriter, reinsurance submitted, decision rendered, counter-offer issued, applicant notification sent, SLA escalation triggered, queue entry, queue exit), activity timestamp, performing user or system, assigned underwriter, underwriting team, case priority level, queue name, SLA due date, and activity notes. Provides the complete audit trail of case progression from submission to final disposition, including work queue assignment, routing history, and workload distribution. Supports workload management reporting, SLA monitoring, and regulatory examination requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` (
    `counter_offer_id` BIGINT COMMENT 'Primary key for counter_offer',
    `application_id` BIGINT COMMENT 'Reference to the new business application that triggered this counter-offer. Links to the underwriting application record.',
    `communication_id` BIGINT COMMENT 'Foreign key linking to correspondence.communication. Business justification: Counter-offers are formal communications requiring applicant acceptance/rejection. Core business process: modified offer presentation and response tracking. Regulatory requirement: clear disclosure of',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who issued this counter-offer. Links to the employee or underwriter resource record.',
    `in_force_policy_id` BIGINT COMMENT 'Foreign key linking to policy.in_force_policy. Business justification: Counter offers issued during underwriting must reference the issued policy to track acceptance outcomes, link counter offer terms to final policy terms, and support regulatory reporting on counter off',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Counter offers generate formal offer documents with modified terms sent to applicants. Business process: acceptance/rejection tracking and signature collection require linking counter offers to their ',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Counter offers document mortality table basis for modified risk class pricing and repricing justification. Real business need: repricing calculations, customer communication support, policy issue vali',
    `plan_id` BIGINT COMMENT 'The modified product code offered by underwriting if a product change is recommended (e.g., offering Term instead of Whole Life (WL) due to insurability concerns).',
    `premium_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.premium_schedule. Business justification: Counter offers with modified risk class, table ratings, or face amount require new premium schedule calculation. Business process: counter offer acceptance by applicant triggers billing setup with rev',
    `risk_class_id` BIGINT COMMENT 'Reference to the risk class originally applied for by the applicant (e.g., Preferred Plus, Standard Non-Smoker).',
    `producer_id` BIGINT COMMENT 'Reference to the writing agent or producer who submitted the original application and will communicate the counter-offer to the applicant.',
    `decision_id` BIGINT COMMENT 'Foreign key linking to underwriting.decision. Business justification: Counter offers are issued based on formal underwriting decisions. When an application cannot be approved as applied, a counter offer is generated referencing the decision that triggered it. Removing u',
    `acceptance_method` STRING COMMENT 'The method by which the applicant accepted the counter-offer (e.g., wet signature on paper form, electronic signature via portal, recorded verbal acceptance, agent attestation).. Valid values are `wet_signature|electronic_signature|verbal_recorded|agent_attestation`',
    `acceptance_signature_date` DATE COMMENT 'The date the applicant signed the acceptance of the counter-offer terms. Used to establish the effective date of coverage under modified terms.',
    `annual_premium_equivalent` DECIMAL(18,2) COMMENT 'The annualized premium amount for the counter-offer, calculated as 10% of single premium or 100% of regular premium. Used for new business (NB) production reporting and commission calculations.',
    `applied_face_amount` DECIMAL(18,2) COMMENT 'The original death benefit (DB) coverage amount requested by the applicant in the initial application.',
    `applied_product_code` STRING COMMENT 'The product code originally applied for by the applicant (e.g., Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL)).',
    `communication_method` STRING COMMENT 'The method used to communicate the counter-offer to the applicant or agent. Tracks compliance with timely notification requirements.. Valid values are `email|postal_mail|phone|agent_portal|in_person`',
    `counter_offer_number` STRING COMMENT 'Business-readable unique identifier for this counter-offer, used in correspondence with agents and applicants.',
    `counter_offer_status` STRING COMMENT 'Current status of the counter-offer in the negotiation workflow. Pending indicates awaiting applicant response; accepted means applicant agreed to modified terms; rejected means applicant declined; expired means response deadline passed; withdrawn means underwriting retracted the offer; superseded means a new counter-offer was issued.. Valid values are `pending|accepted|rejected|expired|withdrawn|superseded`',
    `counter_offer_type` STRING COMMENT 'Classification of the type of modification being offered. Modified coverage indicates reduced face amount; table rating indicates mortality surcharge; flat extra indicates per-thousand charge; exclusion rider indicates specific cause exclusion; product change indicates different product recommendation; combined modification indicates multiple changes.. Valid values are `modified_coverage|table_rating|flat_extra|exclusion_rider|product_change|combined_modification`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this counter-offer record was first created in the system. Used for audit trail and process timing analysis.',
    `decision_rationale` STRING COMMENT 'Detailed explanation of the underwriting rationale for the counter-offer, including specific risk factors identified (e.g., elevated blood pressure, family history, hazardous occupation). Used for agent communication and audit trail.',
    `exclusion_rider_code` STRING COMMENT 'Code identifying the specific exclusion rider attached to the counter-offer (e.g., aviation exclusion, hazardous activity exclusion). Indicates specific causes of death that will not be covered.',
    `exclusion_rider_description` STRING COMMENT 'Detailed description of the exclusion rider terms, specifying what causes of death or conditions are excluded from coverage.',
    `face_amount` DECIMAL(18,2) COMMENT 'The modified death benefit (DB) coverage amount offered by underwriting. May be lower than applied amount due to risk assessment findings.',
    `financial_evidence_summary` STRING COMMENT 'Summary of financial underwriting findings including income verification, net worth assessment, and financial justification for coverage amount that influenced the counter-offer.',
    `flat_extra_duration_months` STRING COMMENT 'The number of months the flat extra charge will apply. Null indicates permanent flat extra for the life of the policy.',
    `flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'The additional premium charge per thousand dollars of coverage, applied for specific temporary or permanent risk factors (e.g., hazardous occupation, avocation).',
    `issue_date` DATE COMMENT 'The date the counter-offer was issued to the applicant or agent. Marks the start of the response period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this counter-offer record was last updated. Tracks changes through the negotiation workflow.',
    `medical_evidence_summary` STRING COMMENT 'Summary of key medical evidence findings from Attending Physician Statement (APS), Medical Information Bureau (MIB) reports, and other medical underwriting sources that influenced the counter-offer decision.',
    `modal_premium_amount` DECIMAL(18,2) COMMENT 'The premium amount per payment period under the counter-offer terms, reflecting the modified risk class, table rating, flat extra, and coverage amount.',
    `nar_calculation_amount` DECIMAL(18,2) COMMENT 'The calculated Net Amount at Risk (NAR) for the counter-offer terms, representing the insurance companys exposure (death benefit minus cash value). Used in reinsurance cession and risk-based capital (RBC) calculations.',
    `notes` STRING COMMENT 'Free-form notes and comments related to the counter-offer negotiation, including agent feedback, applicant questions, and underwriting clarifications.',
    `premium_mode` STRING COMMENT 'The premium payment frequency for the counter-offer terms (annual, semi-annual, quarterly, monthly). May differ from originally applied mode due to underwriting requirements.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `reinsurance_cession_class` STRING COMMENT 'The reinsurance cession class assigned to this counter-offer for automatic treaty placement or facultative submission. Determines reinsurance pricing and terms.',
    `reinsurance_required_flag` BOOLEAN COMMENT 'Indicates whether facultative or automatic reinsurance placement is required for this counter-offer due to retention limits or risk characteristics. True if reinsurance is needed.',
    `rejection_reason_code` STRING COMMENT 'Code indicating the reason the applicant rejected the counter-offer (e.g., premium too high, coverage amount insufficient, product not suitable). Used for Not In Good Order (NIGO) analysis and process improvement.',
    `rejection_reason_description` STRING COMMENT 'Detailed description of why the applicant rejected the counter-offer, captured from agent notes or applicant feedback.',
    `response_date` DATE COMMENT 'The date the applicant or agent provided their acceptance or rejection response. Null if no response received.',
    `response_deadline_date` DATE COMMENT 'The date by which the applicant must accept or reject the counter-offer. After this date, the offer expires and the application may be declined.',
    `source_system` STRING COMMENT 'Identifier of the source underwriting workbench system that created this counter-offer record (e.g., RGAX AURA, Swiss Re Magnum). Used for data lineage and reconciliation.',
    `table_rating_code` STRING COMMENT 'The table rating assigned if the counter-offer includes a mortality surcharge (e.g., Table B, Table D). Represents incremental risk above standard mortality.',
    `table_rating_factor` DECIMAL(18,2) COMMENT 'The numeric multiplier associated with the table rating (e.g., 1.25 for 25% mortality increase). Used in Cost of Insurance (COI) rate calculations.',
    CONSTRAINT pk_counter_offer PRIMARY KEY(`counter_offer_id`)
) COMMENT 'Underwriting counter-offer record issued when an application cannot be approved as applied but can be approved under modified terms. Captures original applied-for coverage amount and risk class, counter-offer terms (modified face amount, table rating, flat extra, exclusion rider, product change), counter-offer issue date, applicant response deadline, and applicant acceptance or rejection status. Manages the counter-offer negotiation workflow between underwriting and the applicant/agent.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` (
    `exclusion_rider_id` BIGINT COMMENT 'Primary key for exclusion_rider',
    `application_id` BIGINT COMMENT 'Reference to the new business application that generated this exclusion rider during underwriting decisioning.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the issued policy to which this exclusion rider is attached. Populated after policy issuance.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Exclusion riders produce policy endorsement documents with specific contract language. Business process: policy contract assembly and claims adjudication require linking riders to their endorsement do',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Exclusion riders must be filed and approved in each jurisdiction before use. Regulatory requirement: form filing compliance for exclusion rider language. Links exclusion rider to form approval authori',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who made the decision to apply this exclusion rider as a condition of policy approval.',
    `reinsurance_cession_id` BIGINT COMMENT 'Foreign key linking to reinsurance.cession. Business justification: Exclusion riders on policies must be tracked at cession level for claims administration. Reinsurer needs to know what exclusions apply to ceded risk to properly adjudicate claims and calculate recover',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Exclusion riders are tracked by period for mortality experience studies, claims analysis, underwriting quality metrics, and risk selection effectiveness. Required for actuarial experience studies and ',
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
    `jurisdiction_code` STRING COMMENT 'Two-letter state or jurisdiction code where this exclusion rider is filed and approved for use (e.g., CA for California, NY for New York).. Valid values are `^[A-Z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this exclusion rider record, capturing updates to status, review dates, or other attributes.',
    `medical_director_approval_flag` BOOLEAN COMMENT 'Indicates whether this exclusion rider required and received approval from the company medical director. True if medical director approval was obtained.',
    `mib_code` STRING COMMENT 'Medical Information Bureau (MIB) code associated with the medical condition or risk factor that triggered this exclusion rider.. Valid values are `^[0-9]{3}$`',
    `nar_impact_flag` BOOLEAN COMMENT 'Indicates whether this exclusion rider affects the Net Amount at Risk (NAR) calculation for reinsurance cession and Cost of Insurance (COI) rate determination. True if NAR calculation is impacted.',
    `notes` STRING COMMENT 'Free-form underwriting notes providing additional context, rationale, or special instructions related to this exclusion rider decision.',
    `permanence_indicator` STRING COMMENT 'Indicates whether the exclusion is permanent for the life of the policy, reviewable after a specified period, or conditional based on future evidence or circumstances.. Valid values are `permanent|reviewable|conditional`',
    `policy_contract_language` STRING COMMENT 'Full legal text of the exclusion rider as it appears in the policy contract document, including all terms, conditions, and definitions.',
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

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` (
    `impairment_guide_id` BIGINT COMMENT 'Unique identifier for the impairment guide entry. Primary key for the impairment guide reference catalog.',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: Impairment guides reference mortality tables for standard mortality debits/credits by medical condition. Real business need: underwriting manual maintenance, mortality assumption consistency across un',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Impairment guidelines must comply with state unfair discrimination laws and rating restrictions (e.g., HIV/AIDS, genetic information, disability). Business process: state regulatory compliance for med',
    `age_band_max` STRING COMMENT 'Maximum age (in years) for which this impairment rating guideline applies. Null indicates no upper age limit for this guideline.',
    `age_band_min` STRING COMMENT 'Minimum age (in years) for which this impairment rating guideline applies. Enables age-specific risk assessment and rating adjustments.',
    `clinical_notes` STRING COMMENT 'Free-text field containing additional clinical context, risk factors, or underwriting considerations for this impairment. May include treatment protocols, prognosis factors, or comorbidity interactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this impairment guide record was first created in the system. Supports audit trail and data lineage.',
    `decline_threshold_indicator` BOOLEAN COMMENT 'Flag indicating whether this impairment at the specified severity level triggers an automatic decline recommendation. True if the condition is uninsurable under standard or substandard terms.',
    `effective_date` DATE COMMENT 'Date from which this impairment guideline becomes active and applicable for underwriting decisions. Supports temporal validity and guideline versioning.',
    `evidence_requirements` STRING COMMENT 'Comma-separated list of required medical evidence for underwriting this impairment (e.g., APS, lab results, ECG, stress test, specialist report). Drives underwriting workbench workflow and evidence ordering.',
    `expiration_date` DATE COMMENT 'Date on which this impairment guideline is superseded or retired. Null indicates the guideline is currently active with no planned expiration.',
    `flat_extra_duration_months` STRING COMMENT 'Duration in months for which the flat extra charge applies. Null indicates permanent flat extra. Used for temporary impairments with expected recovery or stabilization.',
    `flat_extra_per_thousand_max` DECIMAL(18,2) COMMENT 'Maximum flat extra charge per thousand dollars of NAR for this impairment. Defines the upper bound of flat extra rating range.',
    `flat_extra_per_thousand_min` DECIMAL(18,2) COMMENT 'Minimum flat extra charge per thousand dollars of Net Amount at Risk (NAR) applied for this impairment, expressed in dollars. Used for temporary or permanent additional mortality risk.',
    `gender_applicability` STRING COMMENT 'Gender for which this impairment guideline applies. Certain conditions have gender-specific mortality or morbidity risk profiles.. Valid values are `male|female|all`',
    `guideline_source` STRING COMMENT 'Origin of the underwriting guideline for this impairment. Indicates whether the rating is based on internal company manual, reinsurer medical guide, industry best practice, or medical director judgment.. Valid values are `company_manual|reinsurer_guide|industry_standard|medical_director`',
    `guideline_version` STRING COMMENT 'Version identifier of the underwriting manual or reinsurer guide from which this impairment entry is derived. Enables tracking of guideline updates and historical analysis.',
    `icd_10_code` STRING COMMENT 'ICD-10-CM diagnosis code mapping for the impairment. Enables integration with Attending Physician Statement (APS) data and medical records. May contain multiple codes separated by semicolon for complex conditions.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,4})?$`',
    `impairment_category` STRING COMMENT 'High-level medical system classification grouping the impairment for reporting and risk segmentation purposes. [ENUM-REF-CANDIDATE: cardiovascular|endocrine|respiratory|neurological|musculoskeletal|gastrointestinal|genitourinary|oncological|psychiatric|hematological|dermatological|other — 12 candidates stripped; promote to reference product]',
    `impairment_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the medical impairment within the underwriting manual. Used for rapid lookup and system integration.. Valid values are `^[A-Z0-9]{3,10}$`',
    `impairment_guide_status` STRING COMMENT 'Current lifecycle status of the impairment guideline. Active guidelines are used in production underwriting; pending_review indicates medical director review in progress; superseded indicates replacement by newer version.. Valid values are `active|inactive|pending_review|superseded`',
    `impairment_name` STRING COMMENT 'Full medical name of the impairment condition (e.g., Type 2 Diabetes Mellitus, Coronary Artery Disease, Obstructive Sleep Apnea). Primary human-readable identifier for underwriters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this impairment guide record. Enables change tracking and audit compliance.',
    `last_review_date` DATE COMMENT 'Date of the most recent medical director or underwriting committee review of this impairment guideline. Used for compliance and guideline currency tracking.',
    `modified_by_user` STRING COMMENT 'User identifier or name of the medical director, underwriter, or administrator who last modified this impairment guideline. Supports accountability and audit trail.',
    `morbidity_multiplier` DECIMAL(18,2) COMMENT 'Multiplicative factor applied to standard morbidity rates for this impairment. Used for Disability Income (DI) and Long-Term Care (LTC) product underwriting. A value of 1.000 indicates standard morbidity.',
    `mortality_multiplier` DECIMAL(18,2) COMMENT 'Multiplicative factor applied to standard mortality rates for this impairment. Used in actuarial reserve calculations and Cost of Insurance (COI) rate determination. A value of 1.000 indicates standard mortality.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this impairment guideline. Ensures guidelines remain current with medical advances and actuarial experience.',
    `product_line_applicability` STRING COMMENT 'Pipe-separated list of product lines (e.g., term_life|whole_life|universal_life|disability_income|long_term_care) for which this impairment guideline applies. Enables product-specific underwriting rules.',
    `reinsurance_notification_required` BOOLEAN COMMENT 'Flag indicating whether facultative or automatic reinsurance notification is required for cases with this impairment. True if the impairment triggers reinsurance review or cession.',
    `severity_level` STRING COMMENT 'Clinical severity classification of the impairment used to determine base mortality or morbidity risk. Drives initial table rating or flat extra assignment.. Valid values are `mild|moderate|severe|critical`',
    `smoker_status_applicability` STRING COMMENT 'Tobacco use status for which this impairment guideline applies. Smoking status significantly impacts mortality risk for many conditions.. Valid values are `smoker|non_smoker|all`',
    `standard_table_rating_max` STRING COMMENT 'Maximum table rating or decline threshold for this impairment. Represents the upper bound of the rating range beyond which the case may be declined.. Valid values are `^[A-Z]$|^decline$`',
    `standard_table_rating_min` STRING COMMENT 'Minimum table rating (e.g., A, B, C, D, E, F, H, J, L, P) or preferred/standard class assigned for this impairment at the specified severity. Represents the lower bound of the rating range.. Valid values are `^[A-Z]$|^preferred$|^standard$`',
    `stoli_risk_indicator` BOOLEAN COMMENT 'Flag indicating whether this impairment is commonly associated with STOLI schemes or investor-owned life insurance arrangements. Used for fraud detection and Anti-Money Laundering (AML) compliance.',
    `underwriting_method_applicability` STRING COMMENT 'Underwriting method (full medical, simplified issue, accelerated underwriting, guaranteed issue) for which this guideline applies. Different methods have different risk tolerance thresholds.. Valid values are `full|simplified|accelerated|guaranteed_issue`',
    CONSTRAINT pk_impairment_guide PRIMARY KEY(`impairment_guide_id`)
) COMMENT 'Reference catalog of medical impairments and underwriting rating guidelines used to assess mortality and morbidity risk for specific health conditions. Stores impairment code, impairment name (e.g., Type 2 Diabetes, Coronary Artery Disease, Sleep Apnea), ICD-10 code mapping, standard rating action (table rating range, flat extra range, decline threshold), age and severity modifiers, and source (company manual or reinsurer guide). Provides the authoritative underwriting manual reference for medical risk classification.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` (
    `policy_change_uw_id` BIGINT COMMENT 'Unique identifier for the policy change underwriting review record. Primary key for post-issue underwriting assessments triggered by in-force policy modifications.',
    `agency_id` BIGINT COMMENT 'Foreign key linking to agent.agency. Business justification: Policy change production tracked at agency level for agency performance reporting and override commission calculations. Direct link supports agency-level analytics, production reporting, and hierarchi',
    `application_id` BIGINT COMMENT 'Reference to the new business application if this change originated from a conversion or 1035 exchange requiring new underwriting.',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter assigned to review this policy change request and make the re-underwriting decision.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the original in-force policy undergoing the change requiring re-underwriting or evidence of insurability.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Policy change underwriting generates amendment documents, endorsements, and change confirmation letters. Business process: policy administration, change implementation, and policyholder notification r',
    `premium_adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_adjustment. Business justification: Policy changes requiring underwriting review (face amount increases, rider additions, risk class changes) trigger premium adjustments in billing system. Direct operational link: underwriting approval ',
    `risk_class_id` BIGINT COMMENT 'Reference to the risk classification of the policy before the change. Used to determine if re-underwriting results in a risk class change.',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Policy changes (increases, riders, conversions) are producer-initiated transactions requiring commission calculations and producer performance tracking. Direct link supports servicing compensation, pr',
    `report_period_id` BIGINT COMMENT 'Foreign key linking to reporting.report_period. Business justification: Policy change underwriting is reported by period for inforce management analysis, conversion tracking, rider attachment metrics, and policy modification trending. Essential for inforce business growth',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to investment.separate_account. Business justification: Policy changes (conversions to variable products, fund reallocations, rider additions) require tracking separate account selections. Real business process: variable product conversions and fund transf',
    `underwriting_risk_assessment_id` BIGINT COMMENT 'Reference to the detailed risk assessment record performed for this policy change underwriting review. Links to medical, financial, and overall risk evaluation.',
    `aps_ordered_flag` BOOLEAN COMMENT 'Indicates whether an Attending Physician Statement was ordered as part of the re-underwriting evidence requirements.',
    `aps_received_date` DATE COMMENT 'Date the Attending Physician Statement was received by the underwriting department for review.',
    `assignment_date` DATE COMMENT 'Date the policy change underwriting case was assigned to the underwriter for review.',
    `change_request_number` STRING COMMENT 'Business identifier for the policy change request that triggered this underwriting review. Externally visible reference number used in correspondence and tracking.',
    `change_requested_date` DATE COMMENT 'Date the policyholder or agent submitted the request for the policy change requiring underwriting review.',
    `change_requested_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the policy change request was received by the underwriting workbench system.',
    `change_type` STRING COMMENT 'Category of policy change requiring underwriting review. Determines evidence requirements and re-underwriting workflow.. Valid values are `face_amount_increase|reinstatement|rider_addition|conversion|1035_exchange|benefit_increase`',
    `conversion_from_policy_number` STRING COMMENT 'Original term policy number being converted to permanent coverage. Applicable for term-to-permanent conversion changes.',
    `conversion_to_product_code` STRING COMMENT 'Product code of the permanent life insurance policy the term coverage is being converted to. Examples include Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy change underwriting record was first created in the underwriting workbench system.',
    `decision_date` DATE COMMENT 'Date the underwriting decision was made for the policy change request.',
    `decision_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the underwriting decision was recorded in the underwriting workbench system.',
    `decline_reason` STRING COMMENT 'Explanation for why the policy change request was declined. Includes medical, financial, or other underwriting reasons for adverse decision.',
    `effective_date` DATE COMMENT 'Date the approved policy change becomes effective. Used by policy administration system for endorsement issuance and premium calculation.',
    `endorsement_number` STRING COMMENT 'Policy endorsement number issued by the policy administration system to document the approved change. Links underwriting decision to policy servicing record.',
    `evidence_requirements_triggered` STRING COMMENT 'Comma-separated list of evidence of insurability requirements triggered by the policy change. May include Attending Physician Statement (APS), Medical Information Bureau (MIB) inquiry, paramedical exam, financial statements, or other underwriting evidence.',
    `exchange_1035_flag` BOOLEAN COMMENT 'Indicates whether this policy change is part of a Section 1035 tax-free insurance policy exchange requiring new underwriting.',
    `exchange_source_carrier` STRING COMMENT 'Name of the insurance carrier from which the policy or annuity contract is being exchanged under Section 1035.',
    `exchange_source_policy_number` STRING COMMENT 'Policy or contract number at the source carrier being exchanged under Section 1035.',
    `incremental_face_amount` DECIMAL(18,2) COMMENT 'Additional death benefit amount being underwritten. Calculated as requested face amount minus original face amount for increase requests.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy change underwriting record was last updated. Tracks workflow progression and data changes.',
    `mib_findings_summary` STRING COMMENT 'Summary of findings from the Medical Information Bureau inquiry relevant to the re-underwriting decision.',
    `mib_inquiry_date` DATE COMMENT 'Date the Medical Information Bureau inquiry was performed for this policy change underwriting case.',
    `mib_inquiry_performed_flag` BOOLEAN COMMENT 'Indicates whether a Medical Information Bureau inquiry was performed as part of the policy change underwriting review.',
    `modification_description` STRING COMMENT 'Description of modifications or conditions applied to the policy change approval. Examples include reduced face amount, table ratings, flat extras, or rider exclusions.',
    `nar_amount` DECIMAL(18,2) COMMENT 'Net Amount at Risk calculated for the policy change. Represents the incremental death benefit exposure net of reserves for face amount increases or rider additions.',
    `notes` STRING COMMENT 'Free-text notes and comments from the underwriter regarding the policy change review, evidence evaluation, and decision rationale.',
    `original_face_amount` DECIMAL(18,2) COMMENT 'Death benefit face amount of the policy before the requested change. Used to calculate the incremental Net Amount at Risk (NAR) for face amount increases.',
    `reinsurance_cession_required_flag` BOOLEAN COMMENT 'Indicates whether the incremental risk from the policy change requires facultative or automatic reinsurance cession placement.',
    `reinsurance_type` STRING COMMENT 'Type of reinsurance arrangement for the incremental risk. Automatic reinsurance follows treaty terms; facultative requires individual case placement.. Valid values are `automatic|facultative|none`',
    `requested_face_amount` DECIMAL(18,2) COMMENT 'New death benefit face amount requested by the policyholder. Applicable for face amount increase changes.',
    `rider_benefit_amount` DECIMAL(18,2) COMMENT 'Benefit amount or coverage limit for the rider being added. Used in underwriting assessment of incremental risk.',
    `rider_code` STRING COMMENT 'Product code for the rider being added to the policy. Applicable for rider addition changes such as Accidental Death Benefit (ADB), Waiver of Premium (WP), Long-Term Care (LTC), or Disability Income (DI).',
    `risk_class_changed_flag` BOOLEAN COMMENT 'Indicates whether the re-underwriting resulted in a change to the policy risk classification compared to the original risk class.',
    `source_system` STRING COMMENT 'Name of the underwriting workbench or policy administration system that originated this policy change underwriting record. Examples include RGAX AURA, Swiss Re Magnum, Sapiens LifePro.',
    `underwriting_decision` STRING COMMENT 'Final decision outcome of the policy change underwriting review. Determines whether the requested change is approved, modified, declined, or postponed.. Valid values are `approved_as_applied|approved_modified|declined|postponed|withdrawn`',
    `underwriting_status` STRING COMMENT 'Current lifecycle state of the policy change underwriting review. Tracks workflow progression from initial request through final decision. [ENUM-REF-CANDIDATE: pending|evidence_requested|under_review|approved|declined|withdrawn|postponed — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_policy_change_uw PRIMARY KEY(`policy_change_uw_id`)
) COMMENT 'Underwriting review record for in-force policy changes requiring re-underwriting or evidence of insurability. Covers face amount increases, reinstatements beyond the automatic reinstatement period, rider additions (ADB, WP, LTC, DI), conversion of term to permanent coverage, and Section 1035 exchanges requiring new underwriting. Captures change type, original policy reference, change requested date, evidence requirements triggered, re-underwriting risk assessment, new risk class if changed, decision outcome, and effective date of change. Manages the post-issue underwriting workflow distinct from new business application underwriting, including coordination with the policy administration system for endorsement issuance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Underwriting programs must reference approved policy forms; programs cannot be activated until forms are approved in applicable jurisdictions. Business process: form approval validation before underwr',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Underwriting programs must comply with state-specific regulations (free look periods, replacement rules, nonforfeiture requirements). Business process: state regulatory compliance validation for under',
    `age_band_max` STRING COMMENT 'Maximum age of applicant eligible for this underwriting program.',
    `age_band_min` STRING COMMENT 'Minimum age of applicant eligible for this underwriting program.',
    `aps_waiver_flag` BOOLEAN COMMENT 'Indicates whether this program waives the requirement for Attending Physician Statement (APS) review. True for accelerated and jet issue programs.',
    `automated_rules_engine_flag` BOOLEAN COMMENT 'Indicates whether this program uses an automated underwriting rules engine for instant decisioning without manual underwriter review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this underwriting program record was first created in the system.',
    `distribution_channel_applicability` STRING COMMENT 'Comma-separated list of distribution channels authorized to use this program (e.g., career agents, independent agents, brokers, direct-to-consumer, worksite marketing).',
    `effective_date` DATE COMMENT 'Date when the underwriting program becomes active and available for application processing.',
    `exchange_1035_allowed_flag` BOOLEAN COMMENT 'Indicates whether tax-free 1035 exchanges from existing life insurance or annuity contracts are permitted under this program.',
    `expiration_date` DATE COMMENT 'Date when the underwriting program is no longer available for new applications. Null for open-ended programs.',
    `face_amount_max` DECIMAL(18,2) COMMENT 'Maximum death benefit (DB) face amount allowed under this underwriting program. Applications exceeding this limit require full underwriting or facultative reinsurance.',
    `face_amount_min` DECIMAL(18,2) COMMENT 'Minimum death benefit (DB) face amount required for an application to qualify for this underwriting program.',
    `financial_underwriting_required_flag` BOOLEAN COMMENT 'Indicates whether financial underwriting (income verification, net worth analysis, insurable interest determination) is required for this program.',
    `flat_extra_allowed_flag` BOOLEAN COMMENT 'Indicates whether flat extra premium charges (per thousand of coverage) are permitted under this program for aviation, avocation, or medical hazards.',
    `gender_applicability` STRING COMMENT 'Gender eligibility criteria for the underwriting program. Some programs may be gender-specific based on mortality risk profiles.. Valid values are `male|female|all|unisex`',
    `jurisdiction_applicability` STRING COMMENT 'Comma-separated list of state or country codes where this underwriting program is approved and available for use. Programs must comply with state-specific underwriting regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this underwriting program record was last updated.',
    `medical_exam_waiver_flag` BOOLEAN COMMENT 'Indicates whether this program waives the requirement for a paramedical examination. True for simplified and accelerated underwriting programs.',
    `mib_check_required_flag` BOOLEAN COMMENT 'Indicates whether a Medical Information Bureau (MIB) inquiry is required for applications under this program.',
    `nar_calculation_method` STRING COMMENT 'Method used to calculate Net Amount at Risk (NAR) for policies issued under this program. NAR determines reinsurance cession and Cost of Insurance (COI) charges.. Valid values are `death_benefit_minus_reserve|death_benefit_minus_cash_value|statutory_method`',
    `notes` STRING COMMENT 'Free-form text field for additional program notes, special instructions, or underwriting guidelines not captured in structured fields.',
    `premium_financing_allowed_flag` BOOLEAN COMMENT 'Indicates whether premium financing arrangements are permitted for policies issued under this program. Premium financing may trigger additional STOLI scrutiny.',
    `product_line_applicability` STRING COMMENT 'Comma-separated list of product lines eligible for this underwriting program (e.g., Term Life, Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL), Variable Universal Life (VUL)).',
    `program_code` STRING COMMENT 'Business identifier code for the underwriting program used in operational systems and reporting. Externally-known unique code.. Valid values are `^[A-Z0-9]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed business description of the underwriting program including target market, eligibility criteria, evidence requirements, and risk acceptance philosophy.',
    `program_name` STRING COMMENT 'Full business name of the underwriting program as presented to underwriters and agents.',
    `program_status` STRING COMMENT 'Current lifecycle status of the underwriting program indicating whether it is available for new business applications.. Valid values are `active|inactive|suspended|pending_approval|retired`',
    `program_type` STRING COMMENT 'Classification of the underwriting program defining the risk assessment pathway and evidence requirements.. Valid values are `simplified_issue|guaranteed_issue|accelerated_underwriting|jet_issue|graded_benefit|traditional_full_underwriting`',
    `regulatory_approval_number` STRING COMMENT 'State insurance department approval or filing number for this underwriting program. Required for compliance tracking and audit purposes.',
    `reinsurance_retention_limit` DECIMAL(18,2) COMMENT 'Maximum Net Amount at Risk (NAR) the company retains before ceding to reinsurers under this program. Amounts exceeding this limit are ceded per treaty terms.',
    `reinsurance_type` STRING COMMENT 'Type of reinsurance arrangement applicable to policies issued under this program. Automatic reinsurance applies to standard programs; facultative reinsurance applies to high-risk or high-face-amount cases.. Valid values are `automatic|facultative|none`',
    `replacement_allowed_flag` BOOLEAN COMMENT 'Indicates whether applications involving replacement of existing coverage are eligible for this program. Some accelerated programs exclude replacements due to anti-money laundering (AML) risk.',
    `risk_class_eligibility` STRING COMMENT 'Comma-separated list of risk classifications eligible for this program (e.g., Preferred Plus, Preferred, Standard, Table Rated). Some programs are restricted to preferred risk classes only.',
    `sla_decision_time_hours` STRING COMMENT 'Target turnaround time in hours for underwriting decision under this program. Accelerated and jet issue programs typically have SLAs of 24-48 hours.',
    `smoker_status_applicability` STRING COMMENT 'Tobacco use eligibility criteria for the underwriting program. Some accelerated programs are restricted to non-smokers only.. Valid values are `smoker|non_smoker|all`',
    `source_system` STRING COMMENT 'Name of the source underwriting workbench or policy administration system from which this program definition originated (e.g., RGAX AURA, Swiss Re Magnum, Sapiens LifePro).',
    `stoli_detection_required_flag` BOOLEAN COMMENT 'Indicates whether Stranger-Originated Life Insurance (STOLI) screening and detection protocols are mandatory for applications under this program.',
    `table_rating_max` STRING COMMENT 'Maximum table rating (A through P) allowed under this program. Applications with higher table ratings require full underwriting or decline. None indicates no table ratings are accepted.. Valid values are `^[A-P]$|none`',
    `target_market_segment` STRING COMMENT 'Description of the intended customer segment for this program (e.g., young professionals, high net worth individuals, seniors, small business owners).',
    `version_number` STRING COMMENT 'Version number of the underwriting program configuration. Incremented with each modification to track program evolution and regulatory changes.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record defining underwriting programs and special risk acceptance programs offered by the company. Captures program name, program type (simplified issue, guaranteed issue, accelerated underwriting, jet issue, graded benefit), eligibility criteria (age band, face amount limit, product line), evidence waiver rules, maximum face amount, program effective date, and program status. Governs which applications qualify for streamlined underwriting pathways versus full underwriting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` (
    `uw_authority_id` BIGINT COMMENT 'Unique identifier for the underwriting authority record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the senior officer or executive who delegated this authority tier. Links to the employee or officer record.',
    `superseded_by_authority_uw_authority_id` BIGINT COMMENT 'Identifier of the authority tier record that supersedes this one, if applicable. Null if this is the current active version.',
    `superseded_uw_authority_id` BIGINT COMMENT 'Self-referencing FK on uw_authority (superseded_uw_authority_id)',
    `age_band_max` STRING COMMENT 'Maximum insured age (in years) for which this authority tier applies. Null means no maximum age restriction.',
    `age_band_min` STRING COMMENT 'Minimum insured age (in years) for which this authority tier applies. Null means no minimum age restriction.',
    `audit_review_frequency_days` STRING COMMENT 'Frequency (in days) at which decisions made under this authority tier are subject to quality assurance and compliance audit review.',
    `authority_tier_code` STRING COMMENT 'Code representing the underwriter authority level (trainee, junior, senior, chief underwriter, medical director, or special authority).. Valid values are `TRAINEE|JUNIOR|SENIOR|CHIEF|MEDICAL_DIRECTOR|SPECIAL`',
    `authority_tier_name` STRING COMMENT 'Descriptive name of the underwriter authority tier (e.g., Trainee Underwriter, Senior Underwriter, Chief Underwriter, Medical Director).',
    `case_routing_queue_name` STRING COMMENT 'Name of the underwriting workbench queue to which cases matching this authority tier are automatically routed.',
    `counter_offer_authority_flag` BOOLEAN COMMENT 'Indicates whether this authority tier can issue counter offers to applicants (True) or requires escalation (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this underwriting authority record was first created in the system.',
    `decline_authority_flag` BOOLEAN COMMENT 'Indicates whether this authority tier has the authority to decline applications (True) or requires escalation (False).',
    `delegation_date` DATE COMMENT 'Date on which this authority tier was formally delegated by the delegating officer.',
    `effective_date` DATE COMMENT 'Date from which this underwriting authority tier becomes active and enforceable.',
    `escalation_tier_code` STRING COMMENT 'Code of the next higher authority tier to which cases exceeding this tiers limits must be escalated (e.g., SENIOR, CHIEF, MEDICAL_DIRECTOR).',
    `exclusion_rider_authority_flag` BOOLEAN COMMENT 'Indicates whether this authority tier can approve exclusion riders (True) or requires escalation (False).',
    `expiration_date` DATE COMMENT 'Date on which this underwriting authority tier expires or is superseded. Null indicates no expiration (open-ended).',
    `face_amount_ceiling` DECIMAL(18,2) COMMENT 'Maximum face amount (death benefit) that this authority tier is authorized to approve without escalation. Expressed in policy currency.',
    `face_amount_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the face amount ceiling (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `facultative_reinsurance_authority_flag` BOOLEAN COMMENT 'Indicates whether this authority tier can approve facultative reinsurance placements (True) or requires escalation (False).',
    `gender_applicability` STRING COMMENT 'Gender to which this authority tier applies (Male, Female, All, Unisex). All means no gender restriction.. Valid values are `MALE|FEMALE|ALL|UNISEX`',
    `jurisdiction_applicability` STRING COMMENT 'Comma-separated list of state or jurisdiction codes (e.g., NY, CA, TX) to which this authority tier applies. Empty means all jurisdictions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this underwriting authority record was last updated or modified.',
    `maximum_flat_extra_per_thousand` DECIMAL(18,2) COMMENT 'Maximum flat extra premium per thousand dollars of coverage that this authority tier can approve without escalation.',
    `maximum_table_rating` STRING COMMENT 'Highest table rating (e.g., Table D, Table 8) that this authority tier can approve. Ratings beyond this threshold require escalation.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special conditions, or clarifications regarding this underwriting authority tier.',
    `product_line_applicability` STRING COMMENT 'Comma-separated list of product lines to which this authority applies (e.g., Term Life, Whole Life (WL), Universal Life (UL), Indexed Universal Life (IUL), Variable Universal Life (VUL), Annuities). Empty means all product lines.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the regulatory authority approved this underwriting authority tier, if applicable.',
    `regulatory_approval_number` STRING COMMENT 'Reference number or filing identifier for the regulatory approval of this authority tier, if applicable.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this authority tier requires explicit regulatory approval from state insurance departments (True) or is internally delegated (False).',
    `reinsurance_cession_authority_flag` BOOLEAN COMMENT 'Indicates whether this authority tier has the authority to approve reinsurance cession decisions (True) or requires escalation (False).',
    `risk_class_restrictions` STRING COMMENT 'Comma-separated list of risk classes this authority tier is restricted from approving (e.g., Substandard, Rated, Declined). Empty means no restrictions.',
    `sla_decision_time_hours` STRING COMMENT 'Service Level Agreement (SLA) target time (in hours) for underwriting decisions at this authority tier.',
    `smoker_status_applicability` STRING COMMENT 'Smoker status to which this authority tier applies (Smoker, Non-Smoker, All). All means no smoker status restriction.. Valid values are `SMOKER|NON_SMOKER|ALL`',
    `source_system` STRING COMMENT 'Name of the source system from which this underwriting authority record originated (e.g., Underwriting Workbench, Policy Administration System).',
    `stoli_investigation_authority_flag` BOOLEAN COMMENT 'Indicates whether this authority tier has the authority to conduct and conclude Stranger-Originated Life Insurance (STOLI) investigations (True) or requires escalation (False).',
    `underwriting_method_applicability` STRING COMMENT 'Comma-separated list of underwriting methods to which this authority applies (e.g., Full Medical, Simplified Issue, Guaranteed Issue, Accelerated Underwriting). Empty means all methods.',
    `uw_authority_status` STRING COMMENT 'Current lifecycle status of this underwriting authority tier (Active, Inactive, Suspended, Pending Approval, Superseded).. Valid values are `ACTIVE|INACTIVE|SUSPENDED|PENDING|SUPERSEDED`',
    `version_number` STRING COMMENT 'Version number of this authority tier record, incremented with each revision to support change tracking and audit history.',
    CONSTRAINT pk_uw_authority PRIMARY KEY(`uw_authority_id`)
) COMMENT 'Underwriting authority and approval limit schedule defining the maximum face amount, risk class, and table rating each underwriter level (trainee, junior, senior, chief, medical director) is authorized to approve without escalation. Captures authority tier, face amount ceiling, maximum table rating, product line restrictions, effective date, and delegating officer. Drives case routing, escalation rules, and audit of decision authority compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` (
    `treaty_risk_pricing_id` BIGINT COMMENT 'Unique surrogate identifier for this treaty-risk class pricing record. Primary key.',
    `risk_class_id` BIGINT COMMENT 'Foreign key linking to the underwriting risk classification category for which this treaty pricing applies',
    `treaty_schedule_id` BIGINT COMMENT 'Foreign key linking to the reinsurance treaty schedule under which this risk class pricing is defined',
    `allowance_percentage` DECIMAL(18,2) COMMENT 'Commission or expense allowance percentage paid by the reinsurer to the ceding company for this risk class under this treaty. Allowances may vary by risk class based on expected profitability and administrative costs.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'The percentage of the policys face amount or account value ceded to the reinsurer for this risk class under this treaty. Varies by risk class as higher-risk classes may have different coinsurance terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this treaty-risk class pricing record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which this specific risk class pricing becomes effective under this treaty schedule. Risk class pricing may be amended independently within a treaty.',
    `expiry_date` DATE COMMENT 'Date on which this specific risk class pricing ceases to be applicable under this treaty schedule. Null for open-ended pricing. Allows for risk class-specific pricing amendments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this treaty-risk class pricing record was last updated.',
    `risk_class` STRING COMMENT 'Underwriting risk classification applicable to this schedule band (e.g., Preferred Plus, Preferred, Standard, Substandard). Drives the YRT rate per thousand or coinsurance percentage applicable to ceded policies. [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard|substandard|rated|uninsurable — promote to reference product] [Moved from treaty_schedule: The risk_class attribute in treaty_schedule is a denormalized reference that should be replaced by the proper FK relationship through this association. The treaty schedule itself does not have a single risk class - it has pricing for MULTIPLE risk classes, which is the essence of this M:N relationship.]',
    `table_rating_percentage` DECIMAL(18,2) COMMENT 'Numeric multiplier representing the substandard table rating as a percentage of standard mortality for this risk class under this treaty schedule. Negotiated per risk class.',
    `treaty_risk_pricing_status` STRING COMMENT 'Current lifecycle status of this treaty-risk class pricing record: active (in use for cessions), inactive (no longer applicable), pending (negotiated but not yet effective), superseded (replaced by newer pricing).',
    `yrt_rate_per_thousand` DECIMAL(18,2) COMMENT 'The YRT reinsurance premium rate expressed as a dollar amount per $1,000 of Net Amount at Risk for this specific risk class under this treaty schedule. This rate is negotiated per risk class and varies across treaties.',
    CONSTRAINT pk_treaty_risk_pricing PRIMARY KEY(`treaty_risk_pricing_id`)
) COMMENT 'This association product represents the reinsurance pricing agreement between a specific risk classification and a treaty schedule. It captures the negotiated rates, allowances, and terms that apply when ceding business of a particular risk class under a specific reinsurance treaty. Each record links one risk_class to one treaty_schedule with pricing attributes that exist only in the context of this reinsurance arrangement.. Existence Justification: In life insurance reinsurance operations, a single treaty schedule defines pricing for MULTIPLE risk classifications (Preferred Plus, Preferred, Standard, Substandard tables, etc.), and each risk class can have different negotiated rates across MULTIPLE reinsurance treaties with different reinsurers. The business actively manages a pricing grid where YRT rates, coinsurance percentages, table rating factors, and allowances are negotiated and maintained per treaty-risk class combination. This is operational data that reinsurance teams create, update, and query regularly.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`application_document` (
    `application_document_id` BIGINT COMMENT 'Primary key uniquely identifying each application-document association record.',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter or document reviewer who reviewed this document for this application. Provides audit trail for underwriting decisions.',
    `document_id` BIGINT COMMENT 'Foreign key linking to the insurance document master record. Identifies which document is part of this application package.',
    `application_id` BIGINT COMMENT 'Foreign key linking to the underwriting application record. Identifies which application this document is associated with.',
    `document_role` STRING COMMENT 'The specific role or purpose this document serves within the application package. Examples include application form, illustration, replacement form, beneficiary designation, medical records, APS (Attending Physician Statement), financial statement, identity verification documents. This attribute exists only in the context of the application-document relationship because the same document (e.g., medical records) may serve different roles in different applications.',
    `received_flag` BOOLEAN COMMENT 'Indicates whether this required document has been received and logged for this application. Used to track NIGO (Not In Good Order) status and document completeness for underwriting workflow progression.',
    `required_flag` BOOLEAN COMMENT 'Indicates whether this document is required for this specific application based on underwriting rules, face amount, age, and product type. This is relationship-specific because document requirements vary by application characteristics (e.g., medical exam required for high face amounts).',
    `review_date` DATE COMMENT 'Date when this document was reviewed by the underwriter for this application. Part of the underwriting timeline and audit trail.',
    `review_notes` STRING COMMENT 'Underwriter notes or comments specific to this documents review for this application. May include findings, concerns, or additional information requirements.',
    `review_status` STRING COMMENT 'Current review status of this document within the context of this applications underwriting process. Tracks whether the document has been reviewed, approved, or requires additional information.',
    `submission_date` DATE COMMENT 'Date when this specific document was submitted or received for this application. This is relationship-specific because the same document may be submitted on different dates for different applications (e.g., medical records used for concurrent applications).',
    `version_number` STRING COMMENT 'Version identifier of the document at the time it was associated with this application. Tracks which version of the document was used for underwriting review, important for audit trail and regulatory compliance.',
    CONSTRAINT pk_application_document PRIMARY KEY(`application_document_id`)
) COMMENT 'This association product represents the document package relationship between underwriting applications and insurance documents. It captures the specific role, submission status, and version of each document required for or submitted with an application. Each record links one application to one document with attributes that exist only in the context of this application-document relationship, such as the documents role in the application (e.g., application form, illustration, medical records, replacement form), submission status, and whether the document is required or optional.. Existence Justification: In life insurance underwriting operations, applications require multiple documents (application form, illustrations, medical records, APS, beneficiary designations, replacement forms, financial statements) to complete the underwriting review process. Simultaneously, the same document can be shared across multiple concurrent applications for the same applicant or related parties (e.g., medical records from one exam used for multiple policies, financial statements for concurrent applications). The business actively manages document packages as a core underwriting workflow, tracking which documents are required, received, reviewed, and approved for each application, with specific roles and statuses that belong to the application-document relationship rather than to either entity alone.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` (
    `application_party_role_id` BIGINT COMMENT 'Unique identifier for this application party role record. Primary key.',
    `party_id` BIGINT COMMENT 'Foreign key linking to the party participating in this application in a specific role',
    `application_id` BIGINT COMMENT 'Foreign key to underwriting.application.uw_application_id',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage allocation for beneficiary roles. For primary beneficiaries, percentages must sum to 100%. For contingent beneficiaries, percentages apply if all primary beneficiaries predecease the insured. Null for non-beneficiary roles.',
    `consent_status` STRING COMMENT 'Status of required consent from this party for this role. Pending indicates consent not yet obtained, obtained confirms signature/consent received, declined if party refused to sign, not required for roles that do not require signature (e.g., contingent beneficiary), revoked if consent was withdrawn.',
    `consent_type` STRING COMMENT 'Type of consent or authorization obtained from this party in this role. Application signature for general application consent, HIPAA authorization for medical records release, MIB authorization for Medical Information Bureau check, credit check authorization for financial underwriting, replacement acknowledgment for existing policy replacement, 1035 exchange authorization for tax-free exchange.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this application party role record was created in the system.',
    `effective_date` DATE COMMENT 'Date this party role becomes effective. Typically the application date for initial roles, but may differ for roles added during underwriting (e.g., owner change, beneficiary update during underwriting).',
    `insurable_interest_verified` BOOLEAN COMMENT 'Indicates whether insurable interest has been verified for this party in this role. Critical for owner and beneficiary roles to prevent STOLI (Stranger-Originated Life Insurance) and ensure legitimate insurance purpose.',
    `last_modified_by` STRING COMMENT 'User ID or system process that last modified this application party role record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this application party role record was last modified.',
    `relationship_to_insured` STRING COMMENT 'Relationship of this party to the proposed insured. Used for insurable interest verification, STOLI risk assessment, and beneficiary relationship validation. Self for insured party, spouse/child/parent for family relationships, business partner for key person insurance, employer for group coverage, trust for trust-owned policies.',
    `role_sequence` BIGINT COMMENT 'Ordinal position for ordering multiple parties in the same role (e.g., primary beneficiary #1, #2, #3). Used for beneficiary allocation order and display sequence on application documents.',
    `role_status` STRING COMMENT 'Current status of this party role in the application. Active indicates the role is current and will carry forward to policy issue, superseded indicates the role was replaced by another party, declined if the party declined to participate, pending verification if identity or consent verification is incomplete.',
    `role_type` STRING COMMENT 'The capacity in which this party participates in the application. Proposed insured for life insurance, proposed annuitant for annuities, proposed owner if different from insured, payor if premium payor differs, beneficiary designations (primary/contingent), and legal representatives (guardian, attorney-in-fact, trustee for trust-owned policies).',
    `signature_date` DATE COMMENT 'Date this party signed the application in this role. Critical for determining application date, contestability period start, and regulatory compliance (e.g., insured must sign before policy issue).',
    `signature_method` STRING COMMENT 'Method by which this party provided signature consent for this role. Wet signature for paper applications, electronic signature for e-app platforms, voice signature for telephonic applications, digital signature for advanced electronic signatures with certificate authority, not required for certain non-signing roles.',
    `termination_date` DATE COMMENT 'Date this party role was terminated or superseded. Populated when a party role is removed during underwriting (e.g., owner change, beneficiary replacement before policy issue). Null for active roles that transition to the issued policy.',
    `created_by` STRING COMMENT 'User ID or system process that created this application party role record.',
    CONSTRAINT pk_application_party_role PRIMARY KEY(`application_party_role_id`)
) COMMENT 'This association product represents the Role relationship between party and application. It captures the participation of a party in an underwriting application in a specific capacity (proposed insured, owner, payor, beneficiary, guardian, attorney-in-fact). Each record links one party to one application with role-specific attributes that exist only in the context of this participation: role type, signature details, consent status, and role sequence for ordering multiple parties in the same role.. Existence Justification: In life insurance underwriting, applications inherently involve multiple parties in different capacities: the proposed insured, policy owner (often different from insured), premium payor (may differ from owner), primary and contingent beneficiaries (multiple allowed), and legal representatives (guardians for minors, attorneys-in-fact, trustees for trust-owned policies). Conversely, a single party participates in multiple applications over their lifetime as they apply for different policies, and the same party may serve in different roles across applications (e.g., insured on one application, beneficiary on another). Underwriters actively manage party participation by verifying signatures, consent status, insurable interest, and role-specific requirements for each party-application combination.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` (
    `program_rule_configuration_id` BIGINT COMMENT 'Primary key for program_rule_configuration',
    `program_id` BIGINT COMMENT 'Foreign key linking to the underwriting program that uses this rule configuration',
    `rule_id` BIGINT COMMENT 'Foreign key linking to the underwriting rule being configured for this program',
    `config_owner` STRING COMMENT 'Name or identifier of the underwriting team or individual responsible for maintaining this program-rule configuration.',
    `config_status` STRING COMMENT 'Lifecycle status of this program-rule configuration. Active = currently enforced, Inactive = temporarily disabled, Pending = scheduled for future activation, Deprecated = replaced by newer configuration.',
    `effective_date` DATE COMMENT 'Date when this rule configuration becomes active for the program. Supports temporal rule set management and regulatory compliance tracking.',
    `evidence_trigger_override` STRING COMMENT 'Program-specific override for evidence requirements when this rule triggers. May require additional evidence (e.g., APS required for simplified issue program) or waive evidence (e.g., No APS needed for accelerated underwriting).',
    `expiration_date` DATE COMMENT 'Date when this rule configuration is no longer active for the program. Enables rule set versioning and regulatory change management.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this program-rule configuration.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this program-rule configuration. Supports audit trail and change management.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this program applies custom overrides to the standard rule logic. When true, program_specific_action contains the override behavior.',
    `program_specific_action` STRING COMMENT 'Custom underwriting action or rating adjustment applied by this program when the rule triggers. Overrides the standard_rating_action from the rule master. Examples: Decline (program declines where standard rule allows), Table D instead of Table F (program is more lenient), Require APS (program adds evidence requirement).',
    `rule_enabled_flag` BOOLEAN COMMENT 'Indicates whether this rule is actively enforced for this program. Allows selective activation/deactivation of rules across different programs without modifying the rule master.',
    `rule_priority` STRING COMMENT 'Execution sequence priority for this rule within the programs rule set. Lower numbers execute first. Critical for rules engine orchestration where rule order affects decisioning outcomes.',
    CONSTRAINT pk_program_rule_configuration PRIMARY KEY(`program_rule_configuration_id`)
) COMMENT 'This association product represents the configuration relationship between underwriting programs and underwriting rules. It captures how specific rules are applied within the context of each program, including rule priority, program-specific overrides, and temporal applicability. Each record links one program to one rule with attributes that define how that rule behaves within that specific program context.. Existence Justification: Underwriting programs and rules have a genuine operational many-to-many relationship in life insurance. A single underwriting program (e.g., Simplified Issue Term) uses dozens or hundreds of rules to evaluate applications, and a single rule (e.g., Type 2 Diabetes with HbA1c >9%) is reused across multiple programs (Term, Whole Life, Guaranteed Issue) with program-specific configurations. The business actively manages Program Rule Configurations where the same rule behaves differently across programs—different priorities, different rating actions, different evidence requirements. This is not an analytical correlation; underwriting operations teams explicitly configure, version, and maintain these rule sets as a core operational activity.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` (
    `evidence_review_id` BIGINT COMMENT 'Primary key for evidence_review',
    `application_id` BIGINT COMMENT 'Reference to the life or annuity insurance application being underwritten.',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter assigned to review this evidence.',
    `document_id` BIGINT COMMENT 'Reference identifier for the physical or digital document containing the evidence.',
    `evidence_requirement_id` BIGINT COMMENT 'Reference to the specific evidence requirement that triggered this review.',
    `peer_reviewer_employee_id` BIGINT COMMENT 'Reference to the underwriter who performed the peer review if applicable.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy if evidence review is for a policy change or reinstatement.',
    `follow_up_evidence_review_id` BIGINT COMMENT 'Self-referencing FK on evidence_review (follow_up_evidence_review_id)',
    `additional_evidence_required` BOOLEAN COMMENT 'Indicates whether additional evidence is required to complete the underwriting assessment.',
    `additional_evidence_type` STRING COMMENT 'Type of additional evidence requested if further information is needed.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ADD CONSTRAINT `fk_underwriting_application_program_id` FOREIGN KEY (`program_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`program`(`program_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ADD CONSTRAINT `fk_underwriting_underwriting_risk_assessment_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ADD CONSTRAINT `fk_underwriting_decision_program_id` FOREIGN KEY (`program_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`program`(`program_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ADD CONSTRAINT `fk_underwriting_evidence_requirement_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ADD CONSTRAINT `fk_underwriting_aps_record_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ADD CONSTRAINT `fk_underwriting_mib_inquiry_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ADD CONSTRAINT `fk_underwriting_paramedical_exam_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ADD CONSTRAINT `fk_underwriting_rules_engine_output_program_id` FOREIGN KEY (`program_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`program`(`program_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ADD CONSTRAINT `fk_underwriting_rule_impairment_guide_id` FOREIGN KEY (`impairment_guide_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`impairment_guide`(`impairment_guide_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ADD CONSTRAINT `fk_underwriting_financial_uw_review_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ADD CONSTRAINT `fk_underwriting_stoli_review_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ADD CONSTRAINT `fk_underwriting_reinsurance_placement_program_id` FOREIGN KEY (`program_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`program`(`program_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ADD CONSTRAINT `fk_underwriting_case_activity_rules_engine_output_id` FOREIGN KEY (`rules_engine_output_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rules_engine_output`(`rules_engine_output_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ADD CONSTRAINT `fk_underwriting_counter_offer_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ADD CONSTRAINT `fk_underwriting_exclusion_rider_decision_id` FOREIGN KEY (`decision_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`decision`(`decision_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ADD CONSTRAINT `fk_underwriting_policy_change_uw_underwriting_risk_assessment_id` FOREIGN KEY (`underwriting_risk_assessment_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment`(`underwriting_risk_assessment_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ADD CONSTRAINT `fk_underwriting_uw_authority_superseded_by_authority_uw_authority_id` FOREIGN KEY (`superseded_by_authority_uw_authority_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`uw_authority`(`uw_authority_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ADD CONSTRAINT `fk_underwriting_uw_authority_superseded_uw_authority_id` FOREIGN KEY (`superseded_uw_authority_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`uw_authority`(`uw_authority_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ADD CONSTRAINT `fk_underwriting_treaty_risk_pricing_risk_class_id` FOREIGN KEY (`risk_class_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`risk_class`(`risk_class_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ADD CONSTRAINT `fk_underwriting_application_document_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ADD CONSTRAINT `fk_underwriting_application_party_role_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ADD CONSTRAINT `fk_underwriting_program_rule_configuration_program_id` FOREIGN KEY (`program_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`program`(`program_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ADD CONSTRAINT `fk_underwriting_program_rule_configuration_rule_id` FOREIGN KEY (`rule_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`rule`(`rule_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_application_id` FOREIGN KEY (`application_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`application`(`application_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_evidence_requirement_id` FOREIGN KEY (`evidence_requirement_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_requirement`(`evidence_requirement_id`);
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ADD CONSTRAINT `fk_underwriting_evidence_review_follow_up_evidence_review_id` FOREIGN KEY (`follow_up_evidence_review_id`) REFERENCES `life_insurance_ecm`.`underwriting`.`evidence_review`(`evidence_review_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`underwriting` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`underwriting` SET TAGS ('dbx_domain' = 'underwriting');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `compensation_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `compensation_contract_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `compensation_contract_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Program Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'none|automatic|facultative|pending');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `replacement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Replacement Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'rgax_aura|swiss_re_magnum|policy_admin|crm');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `stoli_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `submission_channel` SET TAGS ('dbx_value_regex' = 'agent_portal|paper_mail|email|fax|api_integration|pos_system');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `table_rating` SET TAGS ('dbx_business_glossary_term' = 'Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `table_rating` SET TAGS ('dbx_value_regex' = '^[A-P]$|');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_value_regex' = 'preferred_plus|preferred|standard_plus|standard|substandard|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `aps_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `aps_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `aps_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Review Outcome');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `aps_review_outcome` SET TAGS ('dbx_value_regex' = 'favorable|acceptable|adverse|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'new_business|policy_change|reinstatement|conversion|increase');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `automated_rules_engine_decision` SET TAGS ('dbx_business_glossary_term' = 'Automated Rules Engine Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `automated_rules_engine_decision` SET TAGS ('dbx_value_regex' = 'auto_approve|refer_to_underwriter|auto_decline');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `aviation_hazard_rating` SET TAGS ('dbx_business_glossary_term' = 'Aviation Hazard Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `aviation_hazard_rating` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `avocation_hazard_rating` SET TAGS ('dbx_business_glossary_term' = 'Avocation Hazard Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `avocation_hazard_rating` SET TAGS ('dbx_value_regex' = 'none|low|moderate|high|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `build_chart_result` SET TAGS ('dbx_business_glossary_term' = 'Build Chart Result');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `build_chart_result` SET TAGS ('dbx_value_regex' = 'preferred|standard|overweight|underweight');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `business_insurance_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Insurance Justification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `business_insurance_justification` SET TAGS ('dbx_value_regex' = 'key_person|buy_sell|executive_bonus|split_dollar|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `existing_coverage_inforce_amount` SET TAGS ('dbx_business_glossary_term' = 'Existing Coverage In-Force Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `financial_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Classification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `financial_risk_classification` SET TAGS ('dbx_value_regex' = 'approved|approved_with_limits|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `financial_statement_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `financial_statement_review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `human_life_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Human Life Value (HLV) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `income_replacement_multiple` SET TAGS ('dbx_business_glossary_term' = 'Income Replacement Multiple');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `insurable_interest_determination` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Determination');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `insurable_interest_determination` SET TAGS ('dbx_value_regex' = 'confirmed|questionable|not_established');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `life_settlement_broker_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Settlement Broker Involvement Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `manual_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Medical Risk Classification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_classification` SET TAGS ('dbx_value_regex' = 'preferred|standard|substandard|declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_classification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_classification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Medical Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `medical_risk_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `mib_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Findings Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `mib_findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `mib_inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `mib_inquiry_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Performed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_value_regex' = 'death_benefit_minus_av|death_benefit_minus_csv|statutory|gaap');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `premium_financing_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Financing Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `reinsurance_cession_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'automatic|facultative|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `siu_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `stoli_determination` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Determination');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `stoli_determination` SET TAGS ('dbx_value_regex' = 'cleared|confirmed|inconclusive');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `stoli_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `stoli_investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Investigation Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `stoli_investigation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|cleared|confirmed');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved_as_applied|approved_with_modifications|declined|postponed|withdrawn');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`underwriting_risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Band');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Band');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `aml_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `cost_of_insurance_rate_class` SET TAGS ('dbx_business_glossary_term' = 'Cost of Insurance (COI) Rate Class');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`risk_class` ALTER COLUMN `reinsurance_cession_class` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Class');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Decision Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_supervisory_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Approver Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_supervisory_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `decision_supervisory_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Reinsurer Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `premium_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Program Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'Automatic|Facultative|Not Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `risk_class` SET TAGS ('dbx_business_glossary_term' = 'Risk Class');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `risk_class` SET TAGS ('dbx_value_regex' = 'Preferred Plus|Preferred|Standard Plus|Standard|Substandard|Declined');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `stoli_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `supervisory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Approval Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `supervisory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Approval Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `table_rating` SET TAGS ('dbx_business_glossary_term' = 'Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` SET TAGS ('dbx_subdomain' = 'evidence_collection');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirement Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Diastolic Reading');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_diastolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_business_glossary_term' = 'Blood Pressure Systolic Reading');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `blood_pressure_systolic` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Completion Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|partial|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `document_type_context` SET TAGS ('dbx_business_glossary_term' = 'Document Type Context');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Evidence Cost Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_requirement` ALTER COLUMN `evidence_review_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Review Identifier');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` SET TAGS ('dbx_subdomain' = 'evidence_collection');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `aps_record_id` SET TAGS ('dbx_business_glossary_term' = 'Aps Record Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Aps Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`aps_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` SET TAGS ('dbx_subdomain' = 'evidence_collection');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `mib_inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Underwriter Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`mib_inquiry` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` SET TAGS ('dbx_subdomain' = 'evidence_collection');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `paramedical_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Paramedical Examination Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Examiner Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `exam_vendor_order_id` SET TAGS ('dbx_business_glossary_term' = 'Exam Vendor Order Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`paramedical_exam` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `rules_engine_output_id` SET TAGS ('dbx_business_glossary_term' = 'Rules Engine Output Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Recommended Risk Class ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Program Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `decline_reason_codes` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Codes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `evidence_requirements_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirements Met Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `financial_underwriting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rules_engine_output` ALTER COLUMN `refer_reason_codes` SET TAGS ('dbx_business_glossary_term' = 'Refer Reason Codes');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `impairment_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Impairment Guide Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`rule` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `financial_uw_review_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting (UW) Review ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Review Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Order Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`financial_uw_review` ALTER COLUMN `additional_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Additional Financial Evidence Required');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `stoli_review_id` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Review ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `facultative_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Facultative Submission Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Stoli Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `automated_rules_engine_output` SET TAGS ('dbx_business_glossary_term' = 'Automated Rules Engine Output');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Outcome');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_value_regex' = 'approved|declined|conditional_approval|pending');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Decline Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `evidence_documents_collected` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documents Collected');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `insurable_interest_concern` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Concern Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `insured_age_at_application` SET TAGS ('dbx_business_glossary_term' = 'Insured Age at Application');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'STOLI Investigation Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `investor_owned_indicator` SET TAGS ('dbx_business_glossary_term' = 'Investor-Owned Life Insurance Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `life_settlement_broker_involvement` SET TAGS ('dbx_business_glossary_term' = 'Life Settlement Broker Involvement Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `non_recourse_loan_indicator` SET TAGS ('dbx_business_glossary_term' = 'Non-Recourse Loan Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `premium_financing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Premium Financing Arrangement Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Product Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `rapid_transfer_intent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Rapid Policy Transfer Intent Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `review_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Review Initiated Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'STOLI Review Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Risk Score');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `siu_case_number` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Case Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `siu_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `siu_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Investigations Unit (SIU) Referral Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `state_statute_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'State Anti-STOLI Statute Compliance Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `state_statute_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|requires_review|not_applicable');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `state_stoli_statute_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Stranger-Originated Life Insurance (STOLI) Statute Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `stoli_determination` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) / Investor-Originated Life Insurance (IOLI) Determination');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `stoli_determination` SET TAGS ('dbx_value_regex' = 'cleared|confirmed_stoli|confirmed_ioli|inconclusive|pending_investigation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `trust_ownership_pattern_flag` SET TAGS ('dbx_business_glossary_term' = 'Irrevocable Life Insurance Trust (ILIT) Ownership Pattern Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`stoli_review` ALTER COLUMN `unusual_beneficiary_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Unusual Beneficiary Designation Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` SET TAGS ('dbx_subdomain' = 'reinsurance_operations');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Placement Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_recoverable_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Reinsurance Recoverable Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Program Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_premium_basis` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Premium Basis');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_premium_basis` SET TAGS ('dbx_value_regex' = 'yrt|coinsurance|modified_coinsurance|funds_withheld');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurance_premium_rate` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Premium Rate');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_decision` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_decision` SET TAGS ('dbx_value_regex' = 'approved_standard|approved_substandard|declined|postponed|counter_offer');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Exclusions');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_flat_extra_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Flat Extra Duration Months');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_risk_class_code` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Risk Class Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `reinsurer_table_rating` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `retention_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Limit Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`reinsurance_placement` ALTER COLUMN `stoli_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `case_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Case Activity Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Completion Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performing User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting (UW) Case Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Decision Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `rules_engine_output_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Rules Engine Output Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_name` SET TAGS ('dbx_business_glossary_term' = 'Activity Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'completed|pending|in_progress|failed|cancelled');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activity Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_value_regex' = 'EVIDENCE_ORDERED|EVIDENCE_RECEIVED|CASE_ASSIGNED|CASE_REASSIGNED|PRIORITY_CHANGED|REFERRAL_SENIOR_UW');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `assigned_underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Underwriter Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `assigned_underwriter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `automated_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `case_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Case Priority Level');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `case_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Decision Rationale');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration Seconds');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `escalation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `evidence_type_code` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `evidence_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Evidence Vendor Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|portal|fax');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `notification_type_code` SET TAGS ('dbx_business_glossary_term' = 'Notification Type Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `performing_system_name` SET TAGS ('dbx_business_glossary_term' = 'Performing System Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `performing_user_name` SET TAGS ('dbx_business_glossary_term' = 'Performing User Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `performing_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `previous_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Previous Priority Level');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `previous_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `queue_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `queue_exit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Queue Exit Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `reinsurance_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Submission Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `reinsurer_name` SET TAGS ('dbx_business_glossary_term' = 'Reinsurer Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `sla_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `underwriting_team_code` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Team Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`case_activity` ALTER COLUMN `underwriting_team_name` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Team Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `counter_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `communication_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Communication Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Product Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `premium_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Applied For Risk Class Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `decision_id` SET TAGS ('dbx_business_glossary_term' = 'Uw Decision Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `acceptance_method` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Acceptance Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `acceptance_method` SET TAGS ('dbx_value_regex' = 'wet_signature|electronic_signature|verbal_recorded|agent_attestation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `acceptance_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Acceptance Signature Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `annual_premium_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Annual Premium Equivalent (APE)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `applied_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied For Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `applied_product_code` SET TAGS ('dbx_business_glossary_term' = 'Applied For Product Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Communication Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|phone|agent_portal|in_person');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `counter_offer_number` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `counter_offer_status` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `counter_offer_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|expired|withdrawn|superseded');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `counter_offer_type` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `counter_offer_type` SET TAGS ('dbx_value_regex' = 'modified_coverage|table_rating|flat_extra|exclusion_rider|product_change|combined_modification');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Rationale');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `exclusion_rider_code` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `exclusion_rider_description` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `financial_evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Financial Evidence Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `financial_evidence_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `flat_extra_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Duration in Months');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Issue Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `medical_evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Medical Evidence Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `medical_evidence_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `modal_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Modal Premium Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `nar_calculation_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `premium_mode` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Mode');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `premium_mode` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `reinsurance_cession_class` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Class');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `reinsurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Rejection Reason Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Rejection Reason Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Response Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Response Deadline Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `table_rating_code` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`counter_offer` ALTER COLUMN `table_rating_factor` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Factor');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `exclusion_rider_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Application Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `reinsurance_cession_id` SET TAGS ('dbx_business_glossary_term' = 'Cession Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`exclusion_rider` ALTER COLUMN `policy_contract_language` SET TAGS ('dbx_business_glossary_term' = 'Policy Contract Language');
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
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Impairment Guide Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `clinical_notes` SET TAGS ('dbx_business_glossary_term' = 'Clinical Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `decline_threshold_indicator` SET TAGS ('dbx_business_glossary_term' = 'Decline Threshold Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `evidence_requirements` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirements');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `flat_extra_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Duration in Months');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `flat_extra_per_thousand_max` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `flat_extra_per_thousand_min` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Per Thousand Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_business_glossary_term' = 'Gender Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_value_regex' = 'male|female|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `guideline_source` SET TAGS ('dbx_business_glossary_term' = 'Guideline Source');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `guideline_source` SET TAGS ('dbx_value_regex' = 'company_manual|reinsurer_guide|industry_standard|medical_director');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `guideline_version` SET TAGS ('dbx_business_glossary_term' = 'Guideline Version');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `icd_10_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `icd_10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,4})?$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_category` SET TAGS ('dbx_business_glossary_term' = 'Impairment Category');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_code` SET TAGS ('dbx_business_glossary_term' = 'Impairment Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_guide_status` SET TAGS ('dbx_business_glossary_term' = 'Guideline Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_guide_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|superseded');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `impairment_name` SET TAGS ('dbx_business_glossary_term' = 'Impairment Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `morbidity_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Morbidity Multiplier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `mortality_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Mortality Multiplier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `product_line_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Line Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `reinsurance_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Notification Required');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `standard_table_rating_max` SET TAGS ('dbx_business_glossary_term' = 'Standard Table Rating Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `standard_table_rating_max` SET TAGS ('dbx_value_regex' = '^[A-Z]$|^decline$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `standard_table_rating_min` SET TAGS ('dbx_business_glossary_term' = 'Standard Table Rating Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `standard_table_rating_min` SET TAGS ('dbx_value_regex' = '^[A-Z]$|^preferred$|^standard$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `stoli_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Risk Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `underwriting_method_applicability` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Method Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`impairment_guide` ALTER COLUMN `underwriting_method_applicability` SET TAGS ('dbx_value_regex' = 'full|simplified|accelerated|guaranteed_issue');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `policy_change_uw_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Change Underwriting (UW) ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `agency_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `premium_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Adjustment Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Original Risk Class ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `report_period_id` SET TAGS ('dbx_business_glossary_term' = 'Report Period Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `underwriting_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `aps_ordered_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Ordered Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `aps_received_date` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Received Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `change_request_number` SET TAGS ('dbx_business_glossary_term' = 'Change Request Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `change_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Change Requested Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `change_requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Change Requested Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'face_amount_increase|reinstatement|rider_addition|conversion|1035_exchange|benefit_increase');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `conversion_from_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Conversion From Policy Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `conversion_to_product_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion To Product Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `endorsement_number` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `evidence_requirements_triggered` SET TAGS ('dbx_business_glossary_term' = 'Evidence Requirements Triggered');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `exchange_1035_flag` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `exchange_source_carrier` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Source Carrier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `exchange_source_policy_number` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Source Policy Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `incremental_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Incremental Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `mib_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Findings Summary');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `mib_inquiry_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `mib_inquiry_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Inquiry Performed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `modification_description` SET TAGS ('dbx_business_glossary_term' = 'Modification Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `original_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `reinsurance_cession_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'automatic|facultative|none');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `requested_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Face Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `rider_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Rider Benefit Amount');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Rider Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `risk_class_changed_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Changed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved_as_applied|approved_modified|declined|postponed|withdrawn');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`policy_change_uw` ALTER COLUMN `underwriting_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `aps_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Waiver Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `automated_rules_engine_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Rules Engine Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `distribution_channel_applicability` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `exchange_1035_allowed_flag` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `face_amount_max` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `face_amount_min` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `financial_underwriting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Underwriting Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `flat_extra_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_business_glossary_term' = 'Gender Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_value_regex' = 'male|female|all|unisex');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `jurisdiction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `medical_exam_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Exam Waiver Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `medical_exam_waiver_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `medical_exam_waiver_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `mib_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Calculation Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `nar_calculation_method` SET TAGS ('dbx_value_regex' = 'death_benefit_minus_reserve|death_benefit_minus_cash_value|statutory_method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `premium_financing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Premium Financing Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `product_line_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Line Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|retired');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'simplified_issue|guaranteed_issue|accelerated_underwriting|jet_issue|graded_benefit|traditional_full_underwriting');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `reinsurance_retention_limit` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Retention Limit');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `reinsurance_type` SET TAGS ('dbx_value_regex' = 'automatic|facultative|none');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `replacement_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Allowed Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `risk_class_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Eligibility');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `sla_decision_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Decision Time Hours');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_value_regex' = 'smoker|non_smoker|all');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `stoli_detection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Detection Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `table_rating_max` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `table_rating_max` SET TAGS ('dbx_value_regex' = '^[A-P]$|none');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `uw_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting (UW) Authority ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegating Officer ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `superseded_by_authority_uw_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Authority ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `superseded_uw_authority_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `age_band_max` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `age_band_min` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `audit_review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Review Frequency Days');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `authority_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Authority Tier Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `authority_tier_code` SET TAGS ('dbx_value_regex' = 'TRAINEE|JUNIOR|SENIOR|CHIEF|MEDICAL_DIRECTOR|SPECIAL');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `authority_tier_name` SET TAGS ('dbx_business_glossary_term' = 'Authority Tier Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `case_routing_queue_name` SET TAGS ('dbx_business_glossary_term' = 'Case Routing Queue Name');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `counter_offer_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Authority Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `decline_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Decline Authority Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `delegation_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `escalation_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `exclusion_rider_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Rider Authority Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `face_amount_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Ceiling');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `face_amount_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Currency Code');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `face_amount_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `facultative_reinsurance_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Facultative Reinsurance Authority Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_business_glossary_term' = 'Gender Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_value_regex' = 'MALE|FEMALE|ALL|UNISEX');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `gender_applicability` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `jurisdiction_applicability` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `maximum_flat_extra_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Maximum Flat Extra Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `maximum_table_rating` SET TAGS ('dbx_business_glossary_term' = 'Maximum Table Rating');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authority Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `product_line_applicability` SET TAGS ('dbx_business_glossary_term' = 'Product Line Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `reinsurance_cession_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Authority Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `risk_class_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Risk Class Restrictions');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `sla_decision_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Decision Time Hours');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_business_glossary_term' = 'Smoker Status Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `smoker_status_applicability` SET TAGS ('dbx_value_regex' = 'SMOKER|NON_SMOKER|ALL');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `stoli_investigation_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Stranger-Originated Life Insurance (STOLI) Investigation Authority Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `underwriting_method_applicability` SET TAGS ('dbx_business_glossary_term' = 'Underwriting (UW) Method Applicability');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `uw_authority_status` SET TAGS ('dbx_business_glossary_term' = 'Authority Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `uw_authority_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE|SUSPENDED|PENDING|SUPERSEDED');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`uw_authority` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` SET TAGS ('dbx_subdomain' = 'reinsurance_operations');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` SET TAGS ('dbx_association_edges' = 'underwriting.risk_class,reinsurance.treaty_schedule');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `treaty_risk_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Risk Pricing Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `risk_class_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Risk Pricing - Risk Class Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `treaty_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Treaty Risk Pricing - Treaty Schedule Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `allowance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Allowance Percentage');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Expiry Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `risk_class` SET TAGS ('dbx_business_glossary_term' = 'Risk Class');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `table_rating_percentage` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Percentage');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `treaty_risk_pricing_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`treaty_risk_pricing` ALTER COLUMN `yrt_rate_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Yearly Renewable Term Rate Per Thousand');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` SET TAGS ('dbx_subdomain' = 'evidence_collection');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` SET TAGS ('dbx_association_edges' = 'underwriting.application,document.document');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `application_document_id` SET TAGS ('dbx_business_glossary_term' = 'Application Document Package ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Application Document - Insurance Document Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Document - Uw Application Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `document_role` SET TAGS ('dbx_business_glossary_term' = 'Document Role in Application');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `received_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Received Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `required_flag` SET TAGS ('dbx_business_glossary_term' = 'Document Required Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Document Review Notes');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Document Review Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Document Submission Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` SET TAGS ('dbx_association_edges' = 'policyholder.party,underwriting.application');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `application_party_role_id` SET TAGS ('dbx_business_glossary_term' = 'Application Party Role ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Application Party Role - Party Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Application ID');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Role Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `insurable_interest_verified` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Verified Flag');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `role_sequence` SET TAGS ('dbx_business_glossary_term' = 'Role Sequence Number');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Party Role Type');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Role Termination Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`application_party_role` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` SET TAGS ('dbx_subdomain' = 'risk_evaluation');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` SET TAGS ('dbx_association_edges' = 'underwriting.program,underwriting.rule');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `program_rule_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'program_rule_configuration Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rule Configuration - Uw Program Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `rule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Rule Configuration - Uw Rule Id');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `config_owner` SET TAGS ('dbx_business_glossary_term' = 'Configuration Owner');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Effective Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `evidence_trigger_override` SET TAGS ('dbx_business_glossary_term' = 'Program-Specific Evidence Requirement');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Expiration Date');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Modified By');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Configuration Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Program-Specific Override Indicator');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `program_specific_action` SET TAGS ('dbx_business_glossary_term' = 'Program-Specific Rule Action');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `rule_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Rule Enabled for Program');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`program_rule_configuration` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Execution Priority');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` SET TAGS ('dbx_subdomain' = 'evidence_collection');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `evidence_review_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Review Identifier');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `follow_up_evidence_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `icd_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `medical_condition_identified` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `mib_code_identified` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`underwriting`.`evidence_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
