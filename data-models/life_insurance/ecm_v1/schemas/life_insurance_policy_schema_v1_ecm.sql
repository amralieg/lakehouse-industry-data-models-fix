-- Schema for Domain: policy | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`policy` COMMENT 'Core life insurance and annuity policy administration governing the full lifecycle from NB issuance through endorsements, riders (ADB, AWL, CAR, LTC), policy servicing, reinstatements, surrenders, and lapses. Owns policy status, face amount, death benefit (DB), policy values (CSV, AV), MEC/GPT/IRC 7702 compliance flags, and all policy-level master data. SSOT for all in-force contract records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`in_force_policy` (
    `in_force_policy_id` BIGINT COMMENT 'Unique system identifier for the in-force policy record. Primary key for the in-force policy master table.',
    `account_id` BIGINT COMMENT 'Reference to the billing account that manages premium collection for this policy. Multiple policies may share a single billing account (list billing).',
    `plan_id` BIGINT COMMENT 'Reference to the insurance product definition that governs this policy contract.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable life and variable universal life policies hold cash value in separate account portfolios. Required for daily unit value calculations, surrender value determination, death benefit calculations',
    `pricing_basis_id` BIGINT COMMENT 'Foreign key linking to actuarial.pricing_basis. Business justification: Every policy is issued under a specific pricing basis defining mortality tables, expense loadings, and profit margins. Underwriting and product teams reference pricing_basis for rate guarantees and re',
    `producer_id` BIGINT COMMENT 'Reference to the licensed agent or producer who sold this policy and is entitled to first-year and renewal commissions.',
    `product_plan_id` BIGINT COMMENT 'FK to product.product_plan.product_plan_id — Every policy must reference its product plan for benefit structure, COI rates, premium rate tables, and regulatory parameters. This is a foundational FK for policy administration.',
    `vendor_id` BIGINT COMMENT 'The identifier of the policy administration system that is the system of record for this policy (e.g., FAST, EXL, SAPIENS, ORACLE_IPAS). Used for data lineage and reconciliation.',
    `account_value` DECIMAL(18,2) COMMENT 'The current accumulated value in the policy account, representing premiums paid plus interest credited minus cost of insurance and expense charges. Applicable to universal life and annuity products.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy record was first created in the data platform. Used for audit trail and data lineage.',
    `csv_amount` DECIMAL(18,2) COMMENT 'The amount the policy owner would receive if the policy were surrendered today, net of surrender charges and policy loans. This is the guaranteed minimum non-forfeiture value.',
    `death_benefit_amount` DECIMAL(18,2) COMMENT 'The current total death benefit payable upon death of the insured, including face amount plus any accumulated account value, riders, and adjustments. This is the actual amount payable to beneficiaries.',
    `death_benefit_option` STRING COMMENT 'The death benefit structure elected by the policy owner. OPTION_A=level death benefit equal to face amount, OPTION_B=face amount plus account value, OPTION_C=increasing death benefit corridor, ROP=return of premium.. Valid values are `OPTION_A|OPTION_B|OPTION_C|LEVEL|INCREASING|ROP`',
    `effective_date` DATE COMMENT 'The date coverage begins under the policy contract. May differ from issue date due to backdating or delayed effective date elections.',
    `face_amount` DECIMAL(18,2) COMMENT 'The base death benefit amount stated on the policy face page, before any adjustments for riders, policy loans, or accumulated value. Also known as sum insured or coverage amount.',
    `gpt_cvat_election` STRING COMMENT 'The IRC Section 7702 test elected at policy issue to determine life insurance qualification. GPT=Guideline Premium Test with guideline single and level premium limits, CVAT=Cash Value Accumulation Test with cash value corridor requirements.. Valid values are `GPT|CVAT`',
    `insured_id` BIGINT COMMENT 'Reference to the party whose life is insured under this policy contract. Links to the policyholder domain party master.',
    `irc_7702_compliant_flag` BOOLEAN COMMENT 'Indicates whether the policy meets IRC Section 7702 definition of life insurance for federal tax purposes. True=compliant and death benefit is tax-free, False=non-compliant and may lose tax advantages.',
    `issue_age` STRING COMMENT 'The age of the insured at the time the policy was issued, calculated using the insurance age method (age nearest birthday or age last birthday per company practice). Used for premium rating and underwriting class assignment.',
    `issue_date` DATE COMMENT 'The date the policy was officially issued and became a binding contract. This is the principal business event timestamp for the policy lifecycle.',
    `jurisdiction_state` STRING COMMENT 'The two-letter US state code where the policy was issued and is subject to regulatory oversight. Determines applicable insurance laws and regulations.. Valid values are `^[A-Z]{2}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy record was most recently modified in the data platform. Used for change tracking and incremental processing.',
    `maturity_date` DATE COMMENT 'The date the policy contract reaches maturity and the death benefit becomes payable as an endowment. Nullable for term policies and annuities without fixed maturity.',
    `mec_status_flag` BOOLEAN COMMENT 'Indicates whether the policy has been classified as a Modified Endowment Contract under IRC Section 7702A due to premium payments exceeding the 7-pay test. True=MEC status, distributions subject to LIFO tax treatment and 10% penalty.',
    `modal_premium` DECIMAL(18,2) COMMENT 'The scheduled premium amount due per billing mode (monthly, quarterly, semi-annual, annual). Does not include additional premium payments or adjustments.',
    `owner_id` BIGINT COMMENT 'Reference to the party who owns the policy contract and holds all ownership rights including beneficiary designation, surrender, and loan privileges. May differ from insured.',
    `paid_to_date` DATE COMMENT 'The date through which premiums have been paid and coverage is guaranteed. Used to determine grace period expiration and lapse date.',
    `policy_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which all policy values, premiums, and benefits are denominated (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `policy_form_number` STRING COMMENT 'The state-filed policy form number that governs the contractual terms and conditions of this policy. Each form is approved by state insurance departments.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `policy_loan_balance` DECIMAL(18,2) COMMENT 'The current outstanding principal balance of all policy loans taken against the cash value. Reduces the death benefit and cash surrender value. Null or zero if no loans outstanding.',
    `policy_number` STRING COMMENT 'Unique business identifier assigned to the policy contract at issuance. This is the externally-known policy number used across all customer communications, billing statements, and claims processing.. Valid values are `^[A-Z0-9]{8,20}$`',
    `policy_status` STRING COMMENT 'Current lifecycle status of the policy contract. ACTIVE=in-force and premium-paying, LAPSED=terminated due to non-payment, SURRENDERED=voluntarily terminated by owner, MATURED=reached maturity date, DEATH_CLAIM=claim filed on insured death, FREE_LOOK=within free-look cancellation period, GRACE_PERIOD=premium overdue but within grace period. [ENUM-REF-CANDIDATE: ACTIVE|LAPSED|SURRENDERED|MATURED|DEATH_CLAIM|FREE_LOOK|GRACE_PERIOD — 7 candidates stripped; promote to reference product]',
    `premium_mode` STRING COMMENT 'The frequency at which premiums are scheduled to be paid. SINGLE indicates a single premium paid at issue with no recurring payments.. Valid values are `MONTHLY|QUARTERLY|SEMI_ANNUAL|ANNUAL|SINGLE`',
    `product_type` STRING COMMENT 'Classification of the insurance product. WL=Whole Life, UL=Universal Life, IUL=Indexed Universal Life, VUL=Variable Universal Life, YRT=Yearly Renewable Term, TERM=Term Life, FIA=Fixed Indexed Annuity, SPIA=Single Premium Immediate Annuity, MYGA=Multi-Year Guaranteed Annuity, DIA=Deferred Income Annuity. [ENUM-REF-CANDIDATE: WL|UL|IUL|VUL|YRT|TERM|FIA|SPIA|MYGA|DIA|VARIABLE_ANNUITY — 11 candidates stripped; promote to reference product]',
    `reinsurance_cession_flag` BOOLEAN COMMENT 'Indicates whether any portion of the policy risk has been ceded to a reinsurer under a reinsurance treaty. True=reinsurance in place, False=100% retained risk.',
    `risk_class` STRING COMMENT 'The underwriting risk classification assigned to the insured based on health, lifestyle, and mortality risk factors. Determines premium rate structure.. Valid values are `PREFERRED_PLUS|PREFERRED|STANDARD_PLUS|STANDARD|SUBSTANDARD|RATED`',
    `table_rating` STRING COMMENT 'Additional mortality rating applied to substandard risks, expressed as a letter (A-P) or numeric percentage (e.g., 150 for 150% of standard mortality). Null for standard and preferred risks.. Valid values are `^[A-P]$|^[1-9][0-9]{0,2}$`',
    `tax_qualification_status` STRING COMMENT 'Indicates whether the policy is held within a tax-qualified retirement plan. QUALIFIED=held in employer-sponsored or individual retirement account, NON_QUALIFIED=personal after-tax policy. Specific plan types include IRA, Roth IRA, 401(k), 403(b), 457, TSP. [ENUM-REF-CANDIDATE: QUALIFIED|NON_QUALIFIED|IRA|ROTH_IRA|401K|403B|457|TSP — 8 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'The date the policy contract was terminated, lapsed, surrendered, or otherwise ceased to be in force. Null for active policies.',
    `underwriting_class` STRING COMMENT 'The level of underwriting scrutiny applied at policy issuance. FULLY_UNDERWRITTEN=full medical and financial underwriting, SIMPLIFIED_ISSUE=limited health questions, GUARANTEED_ISSUE=no health questions, NON_MEDICAL=no medical exam required.. Valid values are `FULLY_UNDERWRITTEN|SIMPLIFIED_ISSUE|GUARANTEED_ISSUE|NON_MEDICAL`',
    CONSTRAINT pk_in_force_policy PRIMARY KEY(`in_force_policy_id`)
) COMMENT 'Core master record and SSOT for every life insurance and annuity contract administered in the Policy Administration System. Stores policy number (unique business key), product type (WL, UL, IUL, VUL, YRT, FIA, SPIA, MYGA, DIA), issue date, effective date, policy status (active, lapsed, surrendered, matured, death claim, free-look, grace period, pending, rescinded, converted), face amount, death benefit (DB) type (Option A/B/C) and amount, issue age, risk class (preferred plus, preferred, standard, substandard with table rating), underwriting class, modal premium, policy currency, jurisdiction state, IRC 7702 compliance flag, MEC status flag, GPT/CVAT election, tax qualification status (qualified, non-qualified), policy form number, ACORD product code, reinsurance cession flag, and system-of-record identifiers. Links to policyholder domain for insured/owner/annuitant party references. All other policy domain entities reference this master record.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`value` (
    `value_id` BIGINT COMMENT 'Unique identifier for the policy value record. Primary key for the policy value snapshot.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the parent policy contract for which these values are calculated.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable product valuations require portfolio reference to calculate account value, death benefit, and surrender charges. Daily valuation runs apply portfolio unit values to policy units. Essential fo',
    `valuation_id` BIGINT COMMENT 'Foreign key linking to investment.valuation. Business justification: Variable product policy values are calculated by applying investment valuations (unit values) from separate accounts. Links policy accounting to investment accounting for daily unit value application,',
    `valuation_run_id` BIGINT COMMENT 'Reference to the actuarial valuation run that produced these policy values. Links to the actuarial valuation system for audit and reconciliation.',
    `accumulated_premium_amount` DECIMAL(18,2) COMMENT 'The cumulative sum of all premiums paid into the policy from inception through the valuation date. Used for MEC testing and tax compliance.',
    `admin_fee_amount` DECIMAL(18,2) COMMENT 'The administrative or policy fee deducted from the account value during the most recent billing cycle prior to the valuation date.',
    `av_amount` DECIMAL(18,2) COMMENT 'The gross account value of the policy before any surrender charges or loan deductions. Represents accumulated premiums plus interest credits less cost of insurance and fees.',
    `coi_charge_amount` DECIMAL(18,2) COMMENT 'The cost of insurance charge deducted from the account value during the most recent billing cycle prior to the valuation date.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy value record was first created in the system. Used for audit trail and data lineage.',
    `csv_amount` DECIMAL(18,2) COMMENT 'The cash surrender value available to the policyholder if the policy is surrendered on the valuation date. Represents account value less surrender charges and outstanding loans.',
    `cvat_compliance_flag` BOOLEAN COMMENT 'Indicates whether the policy is in compliance with the Cash Value Accumulation Test under IRC Section 7702. True if compliant, False if failed. Alternative to GPT for tax qualification.',
    `dac_balance_amount` DECIMAL(18,2) COMMENT 'The unamortized deferred acquisition cost balance allocated to this policy as of the valuation date. Represents capitalized sales and underwriting expenses under GAAP.',
    `death_benefit_amount` DECIMAL(18,2) COMMENT 'The total death benefit payable to beneficiaries if the insured dies on the valuation date. Includes base face amount plus any riders and accumulated values per policy design.',
    `dividend_accumulation_balance` DECIMAL(18,2) COMMENT 'The balance of policyholder dividends left on deposit with the insurer, earning interest. Available for withdrawal or to pay premiums.',
    `fund_allocation_total` DECIMAL(18,2) COMMENT 'The total value of all sub-account or fund allocations for variable or indexed products. Should reconcile to account value for variable universal life (VUL) policies.',
    `gpt_compliance_flag` BOOLEAN COMMENT 'Indicates whether the policy is in compliance with the Guideline Premium Test under IRC Section 7702. True if compliant, False if failed. Critical for tax-qualified life insurance status.',
    `guaranteed_minimum_value` DECIMAL(18,2) COMMENT 'The guaranteed minimum cash value or account value as of the valuation date, per policy guarantees. Cannot fall below this floor regardless of performance.',
    `index_credit_amount` DECIMAL(18,2) COMMENT 'The index-linked interest credit applied to indexed universal life (IUL) or fixed indexed annuity (FIA) accounts during the most recent crediting cycle.',
    `interest_credited_amount` DECIMAL(18,2) COMMENT 'The interest credited to the account value during the most recent crediting cycle prior to the valuation date. May include guaranteed and excess interest.',
    `last_premium_payment_date` DATE COMMENT 'The date of the most recent premium payment received prior to or on the valuation date. Used for lapse monitoring and grace period calculations.',
    `loan_balance_amount` DECIMAL(18,2) COMMENT 'The outstanding principal balance of all policy loans as of the valuation date. Reduces cash surrender value and may affect death benefit.',
    `loan_interest_accrued_amount` DECIMAL(18,2) COMMENT 'The accrued but unpaid interest on outstanding policy loans as of the valuation date. Typically capitalized into loan balance if unpaid.',
    `mec_status_flag` BOOLEAN COMMENT 'Indicates whether the policy has been classified as a Modified Endowment Contract under IRC Section 7702A. True if MEC, False if not. Affects tax treatment of withdrawals.',
    `nar_amount` DECIMAL(18,2) COMMENT 'The net amount at risk to the insurer, calculated as death benefit minus account value. Critical for risk-based capital calculations and reinsurance cession.',
    `next_billing_date` DATE COMMENT 'The next scheduled date on which premium is due or policy charges will be deducted. Critical for billing system integration and lapse prevention.',
    `paid_up_additions_value` DECIMAL(18,2) COMMENT 'The accumulated value of paid-up additional insurance purchased with dividends or excess premiums. Increases both cash value and death benefit.',
    `policy_anniversary_date` DATE COMMENT 'The annual anniversary date of the policy, used for age changes, rate adjustments, and anniversary-based policy actions.',
    `premium_load_amount` DECIMAL(18,2) COMMENT 'The sales load or premium charge deducted from premiums received during the most recent billing cycle. Represents acquisition cost recovery.',
    `premium_ytd_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of premiums received during the current calendar year through the valuation date. Used for MEC testing and premium tracking.',
    `reserve_amount` DECIMAL(18,2) COMMENT 'The actuarial reserve held by the insurer for this policy as of the valuation date. Calculated per statutory or GAAP requirements depending on valuation basis.',
    `rider_charge_amount` DECIMAL(18,2) COMMENT 'The total charges for all active policy riders (ADB, AWL, LTC, etc.) deducted during the most recent billing cycle prior to the valuation date.',
    `surrender_charge_amount` DECIMAL(18,2) COMMENT 'The surrender charge that would be assessed if the policy is surrendered on the valuation date. Typically declines over time per the policy schedule.',
    `surrender_charge_end_date` DATE COMMENT 'The date on which the surrender charge period expires and no further surrender charges will be assessed. Null if surrender charges have already expired.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this policy value record was last modified. Used for audit trail and change tracking.',
    `valuation_basis_code` STRING COMMENT 'The accounting or regulatory basis under which these policy values were calculated. STAT=Statutory (SAP), GAAP=US GAAP, IFRS=IFRS 17, TAX=Tax basis.. Valid values are `STAT|GAAP|IFRS|TAX`',
    `valuation_date` DATE COMMENT 'The as-of date for which all policy values in this record are calculated. Critical for point-in-time financial reporting and actuarial analysis.',
    `withdrawal_ytd_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of partial withdrawals taken from the policy during the current calendar year through the valuation date. Used for tax reporting and withdrawal limit tracking.',
    CONSTRAINT pk_value PRIMARY KEY(`value_id`)
) COMMENT 'Tracks all policy-level financial values as of a given valuation date. Owns CSV (Cash Surrender Value), AV (Account Value), net death benefit, NAR (Net Amount at Risk), accumulated premiums, loan balance, loan interest accrued, surrender charge amount, surrender charge period end date, paid-up additions value, dividend accumulation balance, and policy fund allocation totals. Updated on each premium posting, withdrawal, loan, or monthly deduction cycle. Critical for ALM, actuarial reserving, and policyholder self-service.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`policy_rider` (
    `policy_rider_id` BIGINT COMMENT 'Unique system identifier for the rider record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Rider additions/changes require underwriting approval by authorized employee for risk assessment and pricing. Authority tracking required for audit and regulatory compliance. Links to uw_authority_ass',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable riders (GMDB, GMWB, GMIB) reference separate account portfolios for benefit base calculations, guaranteed benefit valuations, hedge effectiveness testing, and actuarial reserve calculations. ',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the base policy contract to which this rider is attached. A policy may have multiple riders.',
    `reinsurance_treaty_id` BIGINT COMMENT 'Reference to the reinsurance treaty under which this rider is ceded. Null if rider is not reinsured.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to product.rider_definition. Business justification: Riders on in-force policies must reference their product definition (rider_definition) for benefit structure, premium rates, underwriting class rules, form numbers, and compliance parameters. Essentia',
    `rider_id` BIGINT COMMENT 'Unique system identifier for this specific rider attachment to a policy. Primary key.',
    `acord_form_number` STRING COMMENT 'The standardized ACORD form number associated with this rider type, used for industry-standard data exchange and regulatory reporting.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `attained_age` STRING COMMENT 'The current age of the insured. Used for age-based premium adjustments and benefit calculations. Expressed in years.',
    `benefit_period_months` STRING COMMENT 'The maximum duration (in months) for which benefits will be paid once triggered. Common for disability income and long-term care riders. Null if benefit is a lump sum or lifetime benefit.',
    `benefit_trigger_condition` STRING COMMENT 'The specific condition or event that must occur for the rider benefit to be payable. Examples: accidental death, disability, critical illness diagnosis, inability to perform ADLs (Activities of Daily Living), account value depletion, etc.',
    `cash_value` DECIMAL(18,2) COMMENT 'The accumulated cash value or account value associated with this rider, if applicable. Some riders (e.g., paid-up additions riders) accumulate cash value. Null for term riders or pure protection riders. Expressed in policy currency.',
    `cost_of_insurance_rate` DECIMAL(18,2) COMMENT 'The per-unit cost of insurance rate applied to the rider face amount to calculate the rider charge. Common for universal life and variable universal life riders. Expressed as a rate per thousand of coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rider record was first created in the data platform. Used for audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `effective_date` DATE COMMENT 'The date when this specific rider coverage became effective on the policy. May differ from policy issue date if rider was added post-issue.',
    `elimination_period_days` STRING COMMENT 'The waiting period (in days) from the date of a qualifying event until benefits begin to be paid. Common for disability income and long-term care riders. Zero or null if no elimination period applies.',
    `expiry_date` DATE COMMENT 'Date on which the rider coverage ends or matures. Nullable for riders with lifetime coverage or those tied to base policy duration.',
    `face_amount` DECIMAL(18,2) COMMENT 'The benefit amount for this specific rider attachment. For ADB riders, this is the accidental death benefit amount. For term riders, this is the additional death benefit. Amount is specific to this policy-rider combination.',
    `guaranteed_insurability_flag` BOOLEAN COMMENT 'Indicates whether this rider includes a guaranteed insurability option, allowing the policyholder to increase coverage at specified intervals without additional underwriting. True if option is included, False otherwise.',
    `issue_age` STRING COMMENT 'The age of the insured at the time the rider was issued. Used for premium calculation and benefit determination. Expressed in years.',
    `loan_outstanding_amount` DECIMAL(18,2) COMMENT 'The outstanding loan amount taken against this riders cash value, if loans are permitted. Expressed in policy currency. Null or zero if no loan exists.',
    `premium_amount` DECIMAL(18,2) COMMENT 'The premium charged for this specific rider on this policy, calculated based on rider premium_basis, insured age, risk class, and face amount. This is the actual premium for this policy-rider instance.',
    `premium_frequency` STRING COMMENT 'Frequency at which the rider premium is charged. Annual: once per year. Semi-annual: twice per year. Quarterly: four times per year. Monthly: twelve times per year. Single: one-time premium payment.. Valid values are `annual|semi_annual|quarterly|monthly|single`',
    `premium_mode` STRING COMMENT 'Pattern of premium payments over the rider term. Level: constant premium. Increasing: premium increases over time. Decreasing: premium decreases over time. Flexible: premium varies based on policyholder elections or account performance.. Valid values are `level|increasing|decreasing|flexible`',
    `rating_percentage` DECIMAL(18,2) COMMENT 'Additional premium percentage applied for substandard underwriting risk. Expressed as a percentage (e.g., 25.00 means 25% additional premium). Null or zero for standard and preferred classes.',
    `reinsurance_ceded_flag` BOOLEAN COMMENT 'Indicates whether the risk for this rider has been ceded to a reinsurer. True if reinsured, False if retained. Used for risk management and financial reporting.',
    `rider_status` STRING COMMENT 'Current lifecycle status of the rider. Active: rider is in force and providing coverage. Suspended: temporarily not in force. Terminated: rider has been cancelled. Lapsed: rider has lapsed due to non-payment. Pending: rider application is under review. Matured: rider has reached its maturity date.. Valid values are `active|suspended|terminated|lapsed|pending|matured`',
    `source_system` STRING COMMENT 'The name or identifier of the operational system from which this rider record originated (e.g., FAST, Sapiens LifePro, Oracle Insurance Policy Administration). Used for data lineage and reconciliation.',
    `state_of_issue` STRING COMMENT 'The two-letter US state code where the rider was issued. Determines applicable state insurance regulations and tax treatment.. Valid values are `^[A-Z]{2}$`',
    `surrender_charge` DECIMAL(18,2) COMMENT 'The penalty or charge applied if the rider is surrendered or terminated early. Common for riders with cash value or guaranteed benefits. Expressed in policy currency. Null if no surrender charge applies.',
    `tax_qualified_flag` BOOLEAN COMMENT 'Indicates whether the rider is part of a tax-qualified plan (e.g., 401k, IRA, 403b). True if tax-qualified, False otherwise. Affects tax treatment of premiums and benefits.',
    `termination_date` DATE COMMENT 'The date when this rider coverage was terminated, either due to rider expiry age, policy termination, or voluntary removal by policy owner.',
    `underwriting_class` STRING COMMENT 'The risk classification assigned to the insured for this rider during underwriting. Preferred: lowest risk. Standard: average risk. Substandard: higher risk with rated premium. Declined: rider application was rejected.. Valid values are `preferred|standard|substandard|declined`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this rider record was last modified in the data platform. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `version` STRING COMMENT 'The version or edition of the rider form. Used to track changes in rider terms, benefits, or pricing over time. Important for compliance and benefit administration.. Valid values are `^[A-Z0-9.]{1,10}$`',
    `waiver_of_premium_flag` BOOLEAN COMMENT 'Indicates whether this rider includes a waiver of premium benefit, meaning rider premiums are waived if the insured becomes disabled or meets other qualifying conditions. True if waiver applies, False otherwise.',
    `withdrawal_percentage` DECIMAL(18,2) COMMENT 'The maximum annual withdrawal percentage allowed under a GMWB (Guaranteed Minimum Withdrawal Benefit) rider without penalty. Expressed as a percentage of the benefit base (e.g., 5.00 means 5% per year).',
    CONSTRAINT pk_policy_rider PRIMARY KEY(`policy_rider_id`)
) COMMENT 'Master record for every rider attached to a base policy. Covers all rider types: ADB (Accidental Death Benefit), AWL (Automatic Waiver of Premium), CAR (Company Action Rider), LTC (Long-Term Care), GMDB, GMIB, GMWB, GMAB, DI (Disability Income), child term, spouse term, and return-of-premium riders. Stores rider code, rider description, rider face amount, rider premium, rider effective date, rider expiry date, rider status, benefit trigger conditions, elimination period, benefit period, and ACORD rider form number. One policy may have multiple riders.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`status_history` (
    `status_history_id` BIGINT COMMENT 'Unique identifier for each policy status transition record. Primary key for the policy status history audit log.',
    `in_force_policy_id` BIGINT COMMENT 'Identifier of the policy contract that experienced this status transition. Links to the policy master record.',
    `employee_id` BIGINT COMMENT 'User ID of the person who initiated the status transition. Null if transition was system-automated.',
    `compliance_notes` STRING COMMENT 'Free-text field for compliance officers to document special circumstances, regulatory considerations, or audit notes related to this status transition.',
    `effective_date` DATE COMMENT 'The business-effective date when the new status became active. This is the date used for policy valuation, billing, and regulatory reporting. May differ from processed timestamp.',
    `free_look_cancellation_request_date` DATE COMMENT 'Date when the policyholder requested cancellation during the free-look period. Null if no free-look cancellation occurred.',
    `free_look_period_end_date` DATE COMMENT 'Date when the free-look period expires. Typically 10-30 days after start date per state DOI requirements. Policyholder may cancel without penalty before this date.',
    `free_look_period_start_date` DATE COMMENT 'Date when the free-look period began. Typically starts on policy delivery or issue date. Null if not applicable to this transition.',
    `free_look_refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the policyholder upon free-look cancellation. Typically includes all premiums paid minus any policy charges per state regulations.',
    `free_look_refund_disbursement_date` DATE COMMENT 'Date when the free-look refund was actually disbursed to the policyholder. Null if no refund occurred.',
    `free_look_refund_method` STRING COMMENT 'Method used to refund the premium during free-look cancellation. Null if no refund occurred.. Valid values are `check|eft|wire_transfer|credit_card_reversal|ach|original_payment_method`',
    `grace_period_end_date` DATE COMMENT 'Date when the grace period expires. Typically 30-61 days after start date per state DOI requirements. Policy will lapse if premium not received by this date.',
    `grace_period_length_days` STRING COMMENT 'Number of days in the grace period. Varies by state jurisdiction and product type. Typically ranges from 30 to 61 days.',
    `grace_period_notice_sent_date` DATE COMMENT 'Date when the grace period notice was sent to the policyholder. Required by most state DOI regulations.',
    `grace_period_start_date` DATE COMMENT 'Date when the grace period began for this policy. Applicable when status transitions to grace_period due to premium non-payment. Null if transition is not grace-period-related.',
    `grace_period_status` STRING COMMENT 'Current status of the grace period. Active: grace period in effect. Expired: grace period ended without payment. Cured: premium paid during grace period. Waived: grace period waived by company action.. Valid values are `active|expired|cured|waived`',
    `lapse_effective_date` DATE COMMENT 'Date when the policy officially lapsed due to non-payment after grace period expiry. Null if policy did not lapse.',
    `new_status` STRING COMMENT 'The policy status after this transition. Captures the to-state in the status lifecycle. [ENUM-REF-CANDIDATE: active|pending|in_force|lapsed|grace_period|suspended|terminated|surrendered|matured|death_claim|free_look|rescinded|converted|reinstated|not_taken — 15 candidates stripped; promote to reference product]',
    `overdue_premium_amount` DECIMAL(18,2) COMMENT 'Total premium amount that is overdue and triggered the grace period or lapse. Null if transition is not payment-related.',
    `policy_number` STRING COMMENT 'Business identifier of the policy contract. Denormalized for reporting convenience and audit trail completeness.',
    `prior_status` STRING COMMENT 'The policy status immediately before this transition occurred. Captures the from-state in the status lifecycle. [ENUM-REF-CANDIDATE: active|pending|in_force|lapsed|grace_period|suspended|terminated|surrendered|matured|death_claim|free_look|rescinded|converted|reinstated|not_taken — 15 candidates stripped; promote to reference product]',
    `processed_timestamp` TIMESTAMP COMMENT 'System timestamp when the status transition was recorded in the policy administration system. Captures the exact moment of system processing.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this status transition must be included in regulatory reporting to state DOI or NAIC. True if reportable, False otherwise.',
    `reinstatement_eligibility_expiry_date` DATE COMMENT 'Date after which the policy is no longer eligible for reinstatement. Typically 3-5 years after lapse date per policy terms and state regulations.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this status transition was later reversed or corrected. True if reversed, False otherwise. Used for audit trail integrity.',
    `reversal_reason` STRING COMMENT 'Explanation of why this status transition was reversed. Null if no reversal occurred.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Timestamp when this status transition was reversed. Null if no reversal occurred.',
    `source_transaction_code` STRING COMMENT 'Identifier of the upstream transaction that triggered this status transition. Examples: billing transaction ID, claim ID, underwriting decision ID. Enables traceability to originating event.',
    `source_transaction_type` STRING COMMENT 'Type of transaction that triggered this status transition. Provides context for the originating business event. [ENUM-REF-CANDIDATE: premium_payment|claim_submission|underwriting_decision|policy_amendment|reinstatement_application|surrender_request|maturity_event|death_notification|free_look_cancellation|system_batch — 10 candidates stripped; promote to reference product]',
    `state_jurisdiction_code` STRING COMMENT 'Two-letter state code indicating the regulatory jurisdiction governing this status transition. Important for compliance with state-specific grace period and free-look requirements.',
    `transition_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this status transition required supervisory or underwriting approval. True if approval was required, False otherwise.',
    `transition_approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the status transition was approved. Null if no approval was required or if pending approval.',
    `transition_reason_code` STRING COMMENT 'Standardized code indicating why the status transition occurred. Examples: lapse for non-payment, reinstatement, surrender, death claim, maturity, conversion, rescission, free-look cancellation, grace period expiry, premium payment received, underwriting approval, policy issued.',
    `transition_reason_description` STRING COMMENT 'Detailed narrative explanation of the reason for the status transition. Provides business context beyond the reason code.',
    `transition_triggered_by_system` STRING COMMENT 'Name of the system that triggered the status transition. Examples: Policy Administration System, Billing System, Claims System, Underwriting Workbench, Manual Entry.',
    `transition_triggered_by_user_name` STRING COMMENT 'Full name of the user who initiated the status transition. Denormalized for audit trail completeness. Null if transition was system-automated.',
    CONSTRAINT pk_status_history PRIMARY KEY(`status_history_id`)
) COMMENT 'Immutable audit log of every policy status transition throughout the full policy lifecycle. SSOT for grace period tracking, free-look period management, and all status-driven compliance events. Records prior status, new status, transition reason code (lapse for non-payment, reinstatement, surrender, death claim, maturity, conversion, rescission, free-look cancellation, grace period expiry), effective date, processed timestamp, grace period start date, grace period end date, grace period length in days, overdue premium amount, grace period notice sent date, grace period status (active, expired, cured), lapse effective date (if grace expired without payment), free-look period start date, free-look period end date, free-look cancellation request date, free-look refund amount, free-look refund method, free-look refund disbursement date, reinstatement eligibility expiry date, and the system or user that triggered the transition. Supports regulatory reporting, lapse studies, state DOI grace period compliance (30-61 day minimums), free-look cancellation processing (10-30 day state DOI requirements), and actuarial experience analysis.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` (
    `policy_beneficiary_id` BIGINT COMMENT 'Unique identifier for the policy beneficiary record. Primary key for the policy beneficiary entity.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy or annuity contract to which this beneficiary designation applies.',
    `service_request_id` BIGINT COMMENT 'Reference to the policy servicing change request that created or modified this beneficiary designation. Links to the policy change history for audit trail purposes. Null for original designations at policy issue.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Beneficiary designations (especially trusts, minors, irrevocable designations) require employee verification for compliance with insurable interest, anti-money laundering, and proper documentation. Au',
    `address_line_1` STRING COMMENT 'Primary street address line for the beneficiary. Used for mailing death benefit checks, tax forms (1099-R), and beneficiary correspondence.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number. Optional field for additional address details.',
    `beneficiary_type` STRING COMMENT 'Classification of the beneficiary designation indicating the order of precedence and revocability. Primary beneficiaries receive proceeds first; contingent beneficiaries receive proceeds if primary beneficiaries predecease the insured; tertiary beneficiaries are third in line; irrevocable beneficiaries cannot be changed without their consent; final beneficiaries receive any remaining proceeds.. Valid values are `primary|contingent|tertiary|irrevocable|final`',
    `city` STRING COMMENT 'City or municipality of the beneficiary address.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the beneficiary address (e.g., USA, CAN, GBR). Used for international beneficiary management and tax treaty compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficiary record was first created in the policy administration system. Used for audit trail and data lineage tracking.',
    `date_of_birth` DATE COMMENT 'Date of birth of the individual beneficiary. Used for age verification, minor beneficiary identification, and Required Minimum Distribution (RMD) calculations for inherited annuities. Null for trust or entity beneficiaries.',
    `designation_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount designated to this beneficiary, used when the beneficiary receives a specific amount rather than a percentage. Null if percentage-based designation is used.',
    `designation_effective_date` DATE COMMENT 'Date on which this beneficiary designation became effective. Corresponds to the policy issue date for original designations or the change request approval date for subsequent changes.',
    `designation_end_date` DATE COMMENT 'Date on which this beneficiary designation was terminated or superseded by a new designation. Null for currently active beneficiary designations.',
    `designation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the death benefit (DB) or annuity proceeds allocated to this beneficiary. Must sum to 100.00 within each beneficiary type class for a given policy. Expressed as a decimal (e.g., 50.00 for 50%).',
    `designation_status` STRING COMMENT 'Current status of the beneficiary designation. Active designations are in force; superseded designations have been replaced by newer designations; deceased indicates the beneficiary predeceased the insured; removed indicates the beneficiary was explicitly removed; pending indicates a change request is in process.. Valid values are `active|superseded|deceased|removed|pending`',
    `email_address` STRING COMMENT 'Email address for electronic communication with the beneficiary. Used for beneficiary notifications, digital document delivery, and claims correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `entity_type` STRING COMMENT 'Classification of the beneficiary as an individual person, trust, estate, charitable organization, or business entity. Determines tax treatment and distribution rules. [ENUM-REF-CANDIDATE: individual|trust|estate|charity|corporation|partnership|other — 7 candidates stripped; promote to reference product]',
    `first_name` STRING COMMENT 'First or given name of the individual beneficiary. Null for trust or entity beneficiaries.',
    `full_name` STRING COMMENT 'The complete legal name of the beneficiary as it should appear on death benefit or annuity payout documentation. For trust beneficiaries, this is the full legal name of the trust.',
    `guardian_name` STRING COMMENT 'Name of the legal guardian or custodian designated to manage death benefit proceeds on behalf of a minor beneficiary until the minor reaches the age of majority. Required when is_minor is True.',
    `guardian_relationship` STRING COMMENT 'Relationship of the guardian or custodian to the minor beneficiary. Used for legal verification and compliance with state minor beneficiary laws.. Valid values are `parent|legal_guardian|custodian|other`',
    `is_minor` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary is a minor (under age 18 or state-specific age of majority). True if minor, False if adult. Determines whether guardian or custodian designation is required.',
    `is_revocable` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary designation can be changed by the policy owner without the beneficiary consent. True if revocable (can be changed), False if irrevocable (requires beneficiary consent to change).',
    `last_name` STRING COMMENT 'Last name or surname of the individual beneficiary. Null for trust or entity beneficiaries.',
    `middle_name` STRING COMMENT 'Middle name or initial of the individual beneficiary. Null for trust or entity beneficiaries.',
    `per_stirpes_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the beneficiary share should be distributed per stirpes (by branch) if the beneficiary predeceases the insured. True means the beneficiary share passes to their descendants; False means the share is redistributed among surviving beneficiaries of the same class.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the beneficiary. Used for beneficiary outreach during claims processing and death benefit distribution.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the beneficiary address. Used for mailing and geographic analysis.',
    `relationship_to_insured` STRING COMMENT 'The familial, legal, or business relationship between the beneficiary and the insured or annuitant. Used for underwriting, tax reporting, and regulatory compliance purposes. [ENUM-REF-CANDIDATE: spouse|child|parent|sibling|grandchild|other_relative|trust|estate|charity|business_entity|other — 11 candidates stripped; promote to reference product]',
    `sequence` STRING COMMENT 'Ordering number within the beneficiary type class to establish precedence when multiple beneficiaries of the same type exist.',
    `settlement_option` STRING COMMENT 'The method by which the death benefit or annuity proceeds will be paid to the beneficiary. Lump sum is a single payment; installment is periodic payments over time; life income provides payments for the beneficiary lifetime; interest only holds proceeds and pays interest.. Valid values are `lump_sum|installment|life_income|interest_only|other`',
    `source_system` STRING COMMENT 'Name of the policy administration system or source application from which this beneficiary record originated (e.g., FAST, Sapiens LifePro, Oracle Insurance Policy Administration). Used for data lineage and integration tracking.',
    `ssn` STRING COMMENT 'Social Security Number of the individual beneficiary. Stored in masked or encrypted format. Required for tax reporting (Form 1099-R) upon distribution of death benefits or annuity proceeds. Null for non-US beneficiaries.',
    `state_province` STRING COMMENT 'State, province, or region of the beneficiary address. Two-letter state code for US addresses (e.g., CA, NY, TX).',
    `suffix` STRING COMMENT 'Generational or professional suffix appended to the beneficiary name (e.g., Jr., Sr., II, III).. Valid values are `Jr|Sr|II|III|IV|V`',
    `tin` STRING COMMENT 'Taxpayer Identification Number for trust, estate, or entity beneficiaries. Used for IRS tax reporting when the beneficiary is not an individual. Stored in masked or encrypted format.',
    `trust_date_established` DATE COMMENT 'Date the trust was legally established. Used for trust qualification verification and estate planning documentation. Null for non-trust beneficiaries.',
    `trust_name` STRING COMMENT 'Full legal name of the trust when the beneficiary is an Irrevocable Life Insurance Trust (ILIT) or other trust entity. Null for individual beneficiaries.',
    `trustee_name` STRING COMMENT 'Name of the trustee responsible for administering the trust and receiving death benefit proceeds on behalf of trust beneficiaries. Null for non-trust beneficiaries.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this beneficiary record was last modified in the policy administration system. Used for audit trail and change tracking.',
    CONSTRAINT pk_policy_beneficiary PRIMARY KEY(`policy_beneficiary_id`)
) COMMENT 'Master record for all primary and contingent beneficiaries designated on a life insurance policy or annuity contract. Stores beneficiary name, relationship to insured, beneficiary type (primary, contingent, tertiary, irrevocable), designation percentage, TIN/SSN (masked), date of birth, address, effective date of designation, revocable flag, trust name (for ILIT designations), minor guardian details, and beneficiary change history reference. Owned by the policy domain as a direct contractual attribute of the policy.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`owner` (
    `owner_id` BIGINT COMMENT 'Unique identifier for the policy ownership record. Primary key for the policy owner association entity.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance or annuity policy contract that is owned. Links to the policy master record.',
    `party_id` BIGINT COMMENT 'Reference to the party (typically a lender or financial institution) who holds the collateral assignment interest in the policy. Null if collateral_assignment_flag is False.',
    `owner_party_id` BIGINT COMMENT 'Reference to the legal owner party (individual, trust, corporation, or other entity) who holds ownership rights to the policy. Links to the party master record.',
    `owner_poa_party_id` BIGINT COMMENT 'Reference to the party who holds power of attorney authority to act on behalf of the owner. Null if power_of_attorney_flag is False.',
    `ownership_transfer_id` BIGINT COMMENT 'Reference to the policy servicing transaction that created or modified this ownership record. Links to the transaction audit trail for ownership changes.',
    `party_address_id` BIGINT COMMENT 'Reference to the primary mailing address for the policy owner. Used for correspondence, premium notices, and regulatory communications. Links to the address master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ownership transfers, collateral assignments, and POA arrangements require employee verification for AML/KYC compliance, sanctions screening, and proper documentation. Regulatory requirement for tracki',
    `absolute_assignment_flag` BOOLEAN COMMENT 'Indicates whether the policy has been absolutely assigned (full transfer of all ownership rights) versus collateral assignment (partial rights for security). True = absolute assignment; False = not absolutely assigned. Absolute assignment typically results in ownership transfer.',
    `collateral_assignment_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount of the loan or obligation secured by the collateral assignment. Used to determine assignee priority claim on death benefit and CSV. Null if collateral_assignment_flag is False.',
    `collateral_assignment_date` DATE COMMENT 'Date when the collateral assignment became effective. Null if collateral_assignment_flag is False.',
    `collateral_assignment_flag` BOOLEAN COMMENT 'Indicates whether the policy has been assigned as collateral for a loan or other financial obligation. True = policy is assigned as collateral; False = no collateral assignment. Affects death benefit and CSV distribution rights.',
    `consent_date` DATE COMMENT 'Date when the owner provided written consent to the ownership arrangement. Required for certain ownership structures (e.g., employer-owned life insurance requires employee consent per IRC Section 101(j)).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy ownership record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `effective_date` DATE COMMENT 'Date when this ownership relationship became legally effective. For original policy issuance, this is the policy issue date. For ownership transfers, this is the transfer effective date.',
    `insurable_interest_verified_flag` BOOLEAN COMMENT 'Indicates whether insurable interest between the owner and insured was verified at policy issuance or ownership transfer. True = insurable interest documented and verified; False = not verified. Required for STOLI prevention and regulatory compliance.',
    `kyc_verification_date` DATE COMMENT 'Date when KYC and AML verification was completed for the policy owner. Null if kyc_verification_status is pending or not_required.',
    `kyc_verification_status` STRING COMMENT 'Status of KYC and AML verification for the policy owner. Verified = identity and AML checks passed; Pending = verification in progress; Failed = verification failed; Not Required = KYC not required for this owner type. Required for AML compliance and FinCEN reporting.. Valid values are `verified|pending|failed|not_required`',
    `notice_preference` STRING COMMENT 'Preferred method for delivering policy notices, statements, and communications to the owner. Mail = postal mail; Email = electronic delivery; Portal = online customer portal; Agent = through agent/producer.. Valid values are `mail|email|portal|agent`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest held by this owner in the policy. For sole ownership = 100.00; for co-ownership scenarios, sum of all owner percentages must equal 100.00. Used for CSV and AV distribution calculations.',
    `ownership_source_system` STRING COMMENT 'Name of the source policy administration system or platform that originated this ownership record (e.g., FAST, Sapiens LifePro, Oracle Insurance). Used for data lineage and reconciliation.',
    `ownership_source_system_code` STRING COMMENT 'Unique identifier for this ownership record in the source policy administration system. Used for data lineage, reconciliation, and bidirectional synchronization.',
    `ownership_status` STRING COMMENT 'Current lifecycle status of the ownership relationship. Active = ownership is in force; Terminated = ownership has ended; Suspended = ownership temporarily inactive; Pending = ownership change awaiting approval.. Valid values are `active|terminated|suspended|pending`',
    `ownership_transfer_reason` STRING COMMENT 'Business reason for ownership change or termination. Sale = ownership sold to another party; Gift = ownership gifted; Divorce = ownership transferred due to divorce settlement; Death = ownership transferred due to owner death; Trust Transfer = ownership moved to/from trust; 1035 Exchange = tax-free policy exchange per IRC Section 1035.. Valid values are `sale|gift|divorce|death|trust_transfer|1035_exchange`',
    `ownership_type` STRING COMMENT 'Classification of the legal ownership structure. Individual = single person owner; Joint = multiple co-owners; Trust = trust entity; Corporation = corporate owner; Partnership = partnership entity; ILIT = Irrevocable Life Insurance Trust.. Valid values are `individual|joint|trust|corporation|partnership|ilit`',
    `pep_flag` BOOLEAN COMMENT 'Indicates whether the policy owner is identified as a Politically Exposed Person per AML regulations. True = owner is PEP; False = not PEP. PEP status requires enhanced due diligence and monitoring.',
    `power_of_attorney_flag` BOOLEAN COMMENT 'Indicates whether a power of attorney arrangement is in place allowing another party to act on behalf of the owner for policy servicing transactions. True = POA is active; False = no POA.',
    `relationship_to_insured` STRING COMMENT 'Relationship of the policy owner to the insured life. Self = owner is the insured; Spouse = owner is spouse of insured; Employer = employer-owned life insurance; Trust = trust owns policy on insured; Other = other relationship. Used for underwriting, compliance, and STOLI detection. [ENUM-REF-CANDIDATE: self|spouse|parent|child|sibling|employer|trust|other — 8 candidates stripped; promote to reference product]',
    `sanctions_screening_date` DATE COMMENT 'Date when the most recent sanctions screening was performed for the policy owner. Null if sanctions_screening_status is not_screened.',
    `sanctions_screening_status` STRING COMMENT 'Result of screening the policy owner against OFAC and other sanctions lists. Clear = no match found; Match = potential match requires review; Pending = screening in progress; Not Screened = screening not yet performed.. Valid values are `clear|match|pending|not_screened`',
    `tax_reporting_owner_flag` BOOLEAN COMMENT 'Indicates whether this owner is the designated party for IRS tax reporting purposes (1099-R, 1099-INT). True = this owner receives tax forms; False = not the tax reporting owner. Critical for IRC Section 7702 and 72 compliance.',
    `termination_date` DATE COMMENT 'Date when this ownership relationship ended. Null for active ownership. Populated upon ownership transfer, policy surrender, or policy maturity.',
    `tin` STRING COMMENT 'Tax identification number (SSN or EIN) of the policy owner for IRS reporting. Required for tax reporting and 1099 issuance. May be SSN for individual owners or EIN for entity owners.. Valid values are `^[0-9]{9}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy ownership record was last modified in the data platform. Used for audit trail and change tracking.',
    CONSTRAINT pk_owner PRIMARY KEY(`owner_id`)
) COMMENT 'Association entity linking a policy to its legal owner(s), capturing ownership type (individual, trust, corporation, ILIT, employer), ownership percentage for co-ownership scenarios, ownership effective date, ownership termination date, ownership transfer reason, power-of-attorney flag, and collateral assignment flag. Distinct from the insured (policyholder domain) and from the beneficiary. Supports ownership change transactions, collateral assignment tracking, and 1035 exchange origination.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` (
    `policy_reinstatement_id` BIGINT COMMENT 'Unique identifier for the policy reinstatement record. Primary key for the policy reinstatement entity.',
    `employee_id` BIGINT COMMENT 'Reference to the underwriter who reviewed and made the decision on the reinstatement application. Supports audit trail and quality review.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy being reinstated. Links to the master policy record in the policy administration system.',
    `lapse_event_id` BIGINT COMMENT 'Foreign key linking to billing.lapse_event. Business justification: Reinstatement applications must reference the specific lapse event to verify lapse reason, duration, outstanding amounts, and reinstatement eligibility window. Critical for underwriting decision workf',
    `producer_id` BIGINT COMMENT 'Reference to the agent who assisted with or submitted the reinstatement application. Supports commission tracking and agent performance metrics.',
    `adverse_action_notice_sent_date` DATE COMMENT 'Date the adverse action notice was sent to the applicant following a denial or rated decision. Required for regulatory compliance.',
    `amount_collected` DECIMAL(18,2) COMMENT 'Total amount collected from the policyholder toward reinstatement. Tracks partial payments and full settlement.',
    `application_channel` STRING COMMENT 'Channel through which the reinstatement application was submitted. Supports channel performance analysis and customer experience tracking.. Valid values are `agent|direct_mail|online|phone|branch`',
    `application_date` DATE COMMENT 'Date the policyholder submitted the reinstatement application. Key date for calculating time-sensitive requirements and deadlines.',
    `application_number` STRING COMMENT 'Business identifier for the reinstatement application. Externally visible reference number used in correspondence and tracking.',
    `aps_required_flag` BOOLEAN COMMENT 'Indicates whether an Attending Physician Statement is required as part of the reinstatement underwriting. Typically required for longer lapse periods or health-related concerns.',
    `back_premium_amount` DECIMAL(18,2) COMMENT 'Total amount of unpaid premiums owed from the lapse date to reinstatement date. Must be paid for reinstatement approval.',
    `back_premium_interest_amount` DECIMAL(18,2) COMMENT 'Interest charged on unpaid back premiums calculated per state regulation and company policy. Added to total reinstatement cost.',
    `comments` STRING COMMENT 'Free-form notes and comments from underwriters, processors, or customer service regarding the reinstatement case. Supports case management and audit trail.',
    `contestable_period_restart_flag` BOOLEAN COMMENT 'Indicates whether the two-year contestable period restarts from the reinstatement effective date. Impacts claims adjudication and fraud investigation rights.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reinstatement record was first created in the system. Supports audit trail and data lineage tracking.',
    `csv_at_lapse_amount` DECIMAL(18,2) COMMENT 'Cash surrender value of the policy at the time of lapse. May be applied toward back premiums or returned to policyholder based on policy provisions.',
    `denial_reason_code` STRING COMMENT 'Code indicating the primary reason for denial of the reinstatement application. Required for regulatory reporting and adverse action notices.. Valid values are `health_decline|non_payment|fraud|misrepresentation|outside_window|incomplete_application`',
    `denial_reason_description` STRING COMMENT 'Detailed explanation of why the reinstatement application was denied. Supports adverse action letter generation and appeals process.',
    `effective_date` DATE COMMENT 'Date the policy coverage is restored if reinstatement is approved. May be retroactive to lapse date or prospective based on company policy and state regulation.',
    `evidence_of_insurability_required_flag` BOOLEAN COMMENT 'Indicates whether the applicant must provide evidence of continued insurability for reinstatement. Typically required if lapse exceeded a threshold period.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Administrative fee charged for processing the reinstatement application. May vary by policy type and jurisdiction.',
    `health_statement_attestation_date` DATE COMMENT 'Date the applicant signed and attested to the accuracy of the health statement. Legal date for representation and warranty purposes.',
    `health_statement_received_date` DATE COMMENT 'Date the completed health statement was received from the applicant. Tracks compliance with evidence of insurability requirements.',
    `health_statement_required_flag` BOOLEAN COMMENT 'Indicates whether the applicant must complete a health statement questionnaire. Standard requirement for reinstatements beyond the grace period.',
    `lapse_date` DATE COMMENT 'Date the policy originally lapsed due to non-payment of premium or other reason. Determines reinstatement eligibility window and requirements.',
    `lapse_reason_code` STRING COMMENT 'Code indicating the reason the policy lapsed. Influences reinstatement requirements and underwriting criteria.. Valid values are `non_payment|insufficient_funds|grace_period_expired|voluntary_surrender|other`',
    `loan_balance_at_lapse_amount` DECIMAL(18,2) COMMENT 'Outstanding policy loan balance at the time of lapse. Must be repaid or reinstated along with the policy.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the application was initially submitted incomplete or with errors requiring rework. Tracks application quality and processing efficiency.',
    `nigo_reason_code` STRING COMMENT 'Code indicating the specific deficiency that caused the application to be marked as not in good order. Supports root cause analysis and process improvement.. Valid values are `missing_signature|incomplete_health_statement|insufficient_payment|missing_documents|invalid_information`',
    `payment_method` STRING COMMENT 'Method used by the policyholder to pay reinstatement amounts. Influences processing time and reconciliation procedures.. Valid values are `check|eft|credit_card|cash|wire_transfer|money_order`',
    `payment_received_date` DATE COMMENT 'Date the reinstatement payment was received by the company. Key date for determining when reinstatement can be processed.',
    `processing_duration_days` STRING COMMENT 'Number of calendar days from application receipt to final decision. Key performance indicator for operational efficiency and customer experience.',
    `reinstatement_status` STRING COMMENT 'Current status of the reinstatement application in the workflow. Tracks progression from initial application through final decision.. Valid values are `pending|approved|declined|withdrawn|in_review|incomplete`',
    `reinstatement_type` STRING COMMENT 'Classification of the reinstatement based on requirements and conditions. Automatic requires only payment; conditional requires underwriting; unconditional is within grace period.. Valid values are `automatic|conditional|unconditional|special`',
    `suicide_exclusion_restart_flag` BOOLEAN COMMENT 'Indicates whether the suicide exclusion period restarts from the reinstatement effective date. Impacts death benefit eligibility for suicide claims.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount required for reinstatement including back premiums, interest, and fees. Must be collected before policy is reinstated.',
    `underwriting_decision` STRING COMMENT 'Underwriting decision on the reinstatement application. Determines whether policy can be reinstated and under what terms.. Valid values are `approved_standard|approved_rated|declined|postponed|pending`',
    `underwriting_decision_date` DATE COMMENT 'Date the underwriting decision was made on the reinstatement application. Key milestone in the reinstatement workflow.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the reinstatement record was last modified. Supports audit trail and change tracking for compliance and operational monitoring.',
    `window_expiry_date` DATE COMMENT 'Last date the policy is eligible for reinstatement per policy terms and state regulation. Typically 3-5 years from lapse date.',
    CONSTRAINT pk_policy_reinstatement PRIMARY KEY(`policy_reinstatement_id`)
) COMMENT 'Tracks all policy reinstatement applications and decisions for lapsed policies. Captures reinstatement application date, lapse date, reinstatement effective date, reinstatement status (pending, approved, declined, withdrawn), evidence of insurability requirement flag, APS required flag, back-premium amount due, reinstatement premium collected, interest on back-premiums, health statement attestation date, underwriting decision reference, and reinstatement denial reason code. Sourced from the Policy Administration System reinstatement module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`surrender` (
    `surrender_id` BIGINT COMMENT 'Unique identifier for the surrender transaction record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the underwriter, policy service representative, or system user who approved the surrender transaction. Used for audit trail and quality assurance.',
    `in_force_policy_id` BIGINT COMMENT 'Identifier of the life insurance policy or annuity contract against which this surrender transaction was executed.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable product surrenders require portfolio valuation to calculate net proceeds, market value adjustments based on underlying fund performance, and surrender charges. Essential for accurate surrende',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Surrenders are often producer-assisted transactions requiring conservation efforts. Business needs producer attribution for commission clawback calculations, persistency metrics by producer, conservat',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Surrendered life policies frequently roll into annuities via 1035 tax-free exchanges. Surrender processing tracks the resulting annuity contract for tax reporting (Form 1099-R coordination), customer ',
    `approval_date` DATE COMMENT 'Date the surrender request was approved by underwriting, policy services, or automated workflow. Marks transition from pending to approved status.',
    `charge_amount` DECIMAL(18,2) COMMENT 'Surrender charge assessed against the gross amount per the policy or contract schedule. Recovers deferred acquisition costs (DAC) and early termination expenses.',
    `cost_basis_amount` DECIMAL(18,2) COMMENT 'Policyholders cost basis in the contract at the time of surrender, representing total premiums paid less any prior non-taxable distributions. Used to calculate taxable gain per IRC Section 72.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this surrender transaction record was first created in the policy administration system. Audit trail for data lineage and compliance.',
    `csv_amount_used` DECIMAL(18,2) COMMENT 'Cash Surrender Value amount applied to fund the nonforfeiture benefit (extended term or reduced paid-up insurance) or automatic premium loan. Represents the policy equity consumed by the nonforfeiture transaction.',
    `disbursement_date` DATE COMMENT 'Date the net surrender proceeds were disbursed to the policyholder, beneficiary, or receiving financial institution.',
    `disbursement_method` STRING COMMENT 'Method by which net surrender proceeds were disbursed to the policyholder or receiving institution: check (mailed check), EFT (electronic funds transfer), wire transfer (same-day wire), 1035 direct transfer (trustee-to-trustee transfer for tax-free exchange), ACH (automated clearing house transfer).. Valid values are `check|eft|wire_transfer|1035_direct_transfer|ach`',
    `effective_date` DATE COMMENT 'Date on which the surrender transaction became effective for policy value calculations, coverage termination, and accounting purposes.',
    `extended_term_expiry_date` DATE COMMENT 'Expiration date of the extended term insurance coverage when the extended term nonforfeiture option is elected. Coverage terminates on this date unless the policy is reinstated.',
    `form_1099r_indicator` BOOLEAN COMMENT 'Indicates whether this surrender transaction requires IRS Form 1099-R reporting for taxable distributions from life insurance, annuities, pensions, or retirement plans. True if 1099-R reporting is required; false otherwise.',
    `free_withdrawal_amount` DECIMAL(18,2) COMMENT 'Portion of the withdrawal that falls within the contracts free withdrawal corridor (typically 10% of account value annually) and is not subject to surrender charges.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value available for surrender before application of surrender charges, market value adjustments, or tax withholding. Represents the Cash Surrender Value (CSV) or Account Value (AV) at the time of surrender.',
    `mva_amount` DECIMAL(18,2) COMMENT 'Market Value Adjustment applied to fixed indexed annuities (FIA) or fixed annuities with MVA riders. Positive value indicates upward adjustment; negative value indicates downward adjustment based on interest rate movements since contract issue.',
    `naic_compliance_flag` BOOLEAN COMMENT 'Indicates whether this surrender transaction complies with NAIC Standard Nonforfeiture Law requirements for minimum cash values, nonforfeiture options, and grace period provisions. True if compliant; false if exception or waiver applies.',
    `net_proceeds` DECIMAL(18,2) COMMENT 'Net amount payable to the policyholder or contract owner after deducting surrender charges, market value adjustments, outstanding policy loans, and tax withholding from the gross amount.',
    `nonforfeiture_election_date` DATE COMMENT 'Date the policyholder elected or the insurer applied the default nonforfeiture option. Applicable when policy lapses without premium payment and nonforfeiture provisions are triggered.',
    `nonforfeiture_option_type` STRING COMMENT 'Nonforfeiture benefit option elected or defaulted upon policy lapse or surrender: cash surrender (CSV payout), extended term insurance (CSV purchases term coverage for original face amount), reduced paid-up insurance (CSV purchases reduced permanent coverage), automatic premium loan (CSV funds overdue premiums), or none (no nonforfeiture benefit applicable).. Valid values are `cash_surrender|extended_term|reduced_paid_up|automatic_premium_loan|none`',
    `notes` STRING COMMENT 'Free-text notes and comments captured by policy service representatives or underwriters regarding special circumstances, exceptions, or processing details for this surrender transaction.',
    `outstanding_loan_amount` DECIMAL(18,2) COMMENT 'Outstanding policy loan principal and accrued interest deducted from the gross surrender value at the time of surrender. Applies to life insurance policies with loan provisions.',
    `processing_date` DATE COMMENT 'Date the surrender transaction was processed and posted to the policy administration system, updating policy status, values, and accounting ledgers.',
    `reason_code` STRING COMMENT 'Business reason for the surrender or withdrawal: financial hardship (policyholder financial need), 1035 exchange (tax-free transfer to another policy per IRC Section 1035), annuitization (conversion to income stream), death (beneficiary surrender post-claim), lapse nonforfeiture (automatic nonforfeiture election upon lapse), policy maturity (endowment maturity payout).. Valid values are `financial_hardship|1035_exchange|annuitization|death|lapse_nonforfeiture|policy_maturity`',
    `receiving_carrier_name` STRING COMMENT 'Name of the receiving insurance carrier or financial institution for 1035 exchange transactions. Populated when the surrender is part of a tax-free policy exchange.',
    `receiving_policy_number` STRING COMMENT 'Policy or contract number at the receiving carrier for 1035 exchange transactions. Links the surrendered policy to the replacement contract.',
    `reduced_paid_up_face_amount` DECIMAL(18,2) COMMENT 'Face amount (death benefit) of the reduced paid-up insurance coverage when the reduced paid-up nonforfeiture option is elected. Calculated based on the CSV and attained age of the insured.',
    `reduced_paid_up_status` STRING COMMENT 'Current status of the reduced paid-up policy resulting from the nonforfeiture election: active (coverage in force), lapsed (coverage terminated), matured (endowment matured), surrendered (subsequently surrendered for remaining CSV).. Valid values are `active|lapsed|matured|surrendered`',
    `request_date` DATE COMMENT 'Date the policyholder or contract owner submitted the surrender or withdrawal request to the insurer.',
    `source_system` STRING COMMENT 'Name of the policy administration system or platform that originated this surrender transaction record (e.g., FAST, Sapiens LifePro, Oracle Insurance Policy Administration).',
    `source_transaction_code` STRING COMMENT 'Unique transaction identifier from the source policy administration system. Enables traceability and reconciliation between lakehouse and operational systems.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Federal and state income tax withholding amount deducted from the surrender proceeds per IRS regulations and policyholder election. Applies to taxable gain portion of the distribution.',
    `taxable_gain_amount` DECIMAL(18,2) COMMENT 'Taxable gain portion of the surrender distribution calculated as the excess of the amount received over the cost basis (premiums paid less prior distributions). Reported on IRS Form 1099-R.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number assigned to this surrender event for customer and agent reference.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the surrender transaction: pending (request received, under review), approved (authorized for processing), processed (transaction completed in policy admin system), disbursed (funds paid out), rejected (request denied), reversed (transaction voided or corrected).. Valid values are `pending|approved|processed|disbursed|rejected|reversed`',
    `transaction_type` STRING COMMENT 'Type of surrender or nonforfeiture transaction: full surrender (complete termination with CSV payout), partial surrender (partial withdrawal retaining policy), systematic withdrawal (scheduled recurring withdrawals), extended term insurance election (nonforfeiture option converting CSV to term coverage), reduced paid-up insurance election (nonforfeiture option converting CSV to reduced permanent coverage), or automatic premium loan election (nonforfeiture option using CSV to pay overdue premiums).. Valid values are `full_surrender|partial_surrender|systematic_withdrawal|extended_term_insurance|reduced_paid_up|automatic_premium_loan`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this surrender transaction record was last modified in the policy administration system. Tracks data currency and change history.',
    CONSTRAINT pk_surrender PRIMARY KEY(`surrender_id`)
) COMMENT 'Records all surrender, partial surrender, systematic withdrawal, and nonforfeiture benefit transactions against life insurance policies and annuity contracts. SSOT for nonforfeiture option elections and outcomes. Stores transaction type (full surrender, partial surrender, systematic withdrawal, extended term insurance election, reduced paid-up insurance election, automatic premium loan election, cash surrender value nonforfeiture), request date, effective date, gross amount, surrender charge applied, market value adjustment (MVA) applied, net proceeds, tax withholding amount, 1099-R indicator, free withdrawal amount utilized, reason code (financial hardship, 1035 exchange, annuitization, death, lapse nonforfeiture), nonforfeiture option type elected or defaulted, nonforfeiture election date, extended term insurance expiry date, reduced paid-up face amount, reduced paid-up policy status, CSV amount used to fund the nonforfeiture benefit, disbursement method, and compliance with NAIC Standard Nonforfeiture Law. Sourced from the Policy Administration System surrender, lapse administration, and nonforfeiture processing modules.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`loan` (
    `loan_id` BIGINT COMMENT 'Unique identifier for the policy loan record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Loan origination requires underwriting approval by authorized employee for large amounts or APL-trigger situations. Regulatory requirement for authority tracking and audit trail. SOX control for finan',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the underlying life insurance policy against which this loan is issued.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Variable product loans are collateralized by separate account portfolio value. Required for loan-to-CSV ratio monitoring, automatic premium loan (APL) trigger detection, collateral adequacy assessment',
    `producer_id` BIGINT COMMENT 'Reference to the agent or service representative responsible for administering this loan and handling borrower inquiries.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Loan servicing is often outsourced to specialized third-party administrators (TPAs) or loan servicers. Tracking the servicer vendor supports vendor management, SLA monitoring, reconciliation, and oper',
    `accrued_interest_balance` DECIMAL(18,2) COMMENT 'Total interest accrued on the loan that has not been paid or capitalized into principal.',
    `apl_trigger_flag` BOOLEAN COMMENT 'Indicates whether this loan was automatically triggered due to insufficient funds to pay a premium. True if the loan was initiated by the APL provision; False if borrower-initiated.',
    `closure_date` DATE COMMENT 'Date the loan was fully closed (either through full repayment, offset at death, offset at surrender, or foreclosure). Null if loan is still active.',
    `closure_reason` STRING COMMENT 'Reason the loan was closed. Full_repayment indicates borrower paid off loan; offset_death_claim indicates loan was deducted from death benefit; offset_surrender indicates loan was deducted from surrender proceeds; policy_lapse indicates policy lapsed due to loan exceeding CSV; loan_forgiveness indicates loan was forgiven (rare, typically taxable event).. Valid values are `full_repayment|offset_death_claim|offset_surrender|policy_lapse|loan_forgiveness`',
    `collateral_csv_amount` DECIMAL(18,2) COMMENT 'Cash Surrender Value (CSV) of the policy at the time of loan origination, representing the maximum collateral available to secure the loan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy loan record was first created in the system.',
    `disbursement_date` DATE COMMENT 'Date on which loan proceeds were disbursed to the policyholder or applied to premium/loan interest.',
    `disbursement_method` STRING COMMENT 'Method by which loan proceeds were disbursed. Check indicates mailed check; EFT indicates electronic funds transfer to bank account; wire indicates wire transfer; applied_to_premium indicates loan was used to pay premium (APL); applied_to_loan indicates loan was used to pay interest on existing loan.. Valid values are `check|eft|wire|applied_to_premium|applied_to_loan`',
    `interest_capitalization_date` DATE COMMENT 'Date on which accrued interest was capitalized (added to principal balance), typically occurring annually on the policy anniversary if interest remains unpaid.',
    `interest_crediting_frequency` STRING COMMENT 'Frequency at which interest is calculated and added to the accrued interest balance.. Valid values are `daily|monthly|quarterly|annually`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the policy loan, expressed as a decimal (e.g., 0.0500 for 5%). Rate may be fixed at origination or variable based on an index.',
    `interest_rate_type` STRING COMMENT 'Classification of how the loan interest rate is determined. Fixed rates remain constant; variable rates adjust periodically based on an index such as Moodys Corporate Bond Yield Average, US Treasury rates, or LIBOR; guaranteed_max indicates a rate with a contractual ceiling.. Valid values are `fixed|variable_moodys|variable_treasury|variable_libor|guaranteed_max`',
    `last_interest_posting_date` DATE COMMENT 'Most recent date on which interest was calculated and posted to the accrued interest balance.',
    `last_repayment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent repayment transaction. Null if no repayments have been made.',
    `last_repayment_date` DATE COMMENT 'Date of the most recent repayment transaction applied to this loan. Null if no repayments have been made.',
    `loan_number` STRING COMMENT 'Business identifier for the policy loan, typically displayed on customer statements and correspondence.',
    `loan_status` STRING COMMENT 'Current lifecycle status of the policy loan. Active indicates outstanding balance; repaid indicates full repayment; foreclosed indicates policy lapsed due to loan exceeding CSV; offset_at_death indicates loan was deducted from death benefit at claim; offset_at_surrender indicates loan was deducted from surrender proceeds.. Valid values are `active|repaid|foreclosed|offset_at_death|offset_at_surrender|defaulted`',
    `loan_type` STRING COMMENT 'Classification of the policy loan. Standard loans are borrower-initiated; Automatic Premium Loan (APL) loans are triggered when premium payment fails and policy has sufficient CSV; systematic loans are recurring scheduled loans; emergency loans are expedited loans for urgent needs.. Valid values are `standard|automatic_premium_loan|systematic_loan|emergency_loan`',
    `maximum_loan_amount` DECIMAL(18,2) COMMENT 'Maximum amount that can be borrowed against the policy, typically a percentage of CSV (e.g., 90% of CSV) as defined in the policy contract.',
    `mec_impact_flag` BOOLEAN COMMENT 'Indicates whether this loan was taken on a policy classified as a Modified Endowment Contract (MEC), which has different tax treatment for loans and withdrawals. True if policy is a MEC; False otherwise.',
    `next_scheduled_repayment_date` DATE COMMENT 'Date of the next scheduled loan repayment, if a repayment schedule is in place. Null if no repayment schedule exists or loan is fully repaid.',
    `offset_amount_at_claim` DECIMAL(18,2) COMMENT 'Total loan balance (principal plus accrued interest) that was deducted from the death benefit when a claim was paid. Null if policy has not resulted in a death claim.',
    `offset_amount_at_surrender` DECIMAL(18,2) COMMENT 'Total loan balance (principal plus accrued interest) that was deducted from the cash surrender value when the policy was surrendered. Null if policy has not been surrendered.',
    `original_loan_amount` DECIMAL(18,2) COMMENT 'Principal amount of the loan at origination, before any interest accrual or repayments.',
    `origination_date` DATE COMMENT 'Date the policy loan was issued and funds were disbursed to the policyholder or applied to premium.',
    `outstanding_principal_balance` DECIMAL(18,2) COMMENT 'Current outstanding principal balance of the loan after partial repayments, excluding accrued interest.',
    `repayment_schedule_type` STRING COMMENT 'Type of repayment schedule established for the loan. None indicates no scheduled repayments (loan repaid at death or surrender); monthly/quarterly/annual indicate regular scheduled payments; custom indicates a non-standard repayment plan.. Valid values are `none|monthly|quarterly|annual|custom`',
    `scheduled_repayment_amount` DECIMAL(18,2) COMMENT 'Amount of each scheduled repayment installment, if a repayment schedule is in place. Null if no repayment schedule exists.',
    `source_system` STRING COMMENT 'Name of the source policy administration system from which this loan record originated (e.g., FAST, Sapiens LifePro, Oracle Insurance Policy Administration).',
    `tax_reporting_year` STRING COMMENT 'Tax year in which a taxable event related to this loan must be reported to the IRS (e.g., when loan causes policy to become a Modified Endowment Contract (MEC) or when loan is forgiven at lapse).',
    `taxable_amount` DECIMAL(18,2) COMMENT 'Amount subject to income tax reporting related to this loan (e.g., gain recognized on MEC loan distribution or loan forgiveness at lapse). Null if no taxable event has occurred.',
    `taxable_event_flag` BOOLEAN COMMENT 'Indicates whether this loan has triggered a taxable event requiring IRS reporting (e.g., loan on a MEC policy, loan forgiveness at lapse). True if taxable event occurred; False otherwise.',
    `to_csv_ratio` DECIMAL(18,2) COMMENT 'Ratio of total outstanding loan balance to current policy CSV, expressed as a decimal. Used to monitor loan collateralization and lapse risk. A ratio approaching 1.0 indicates high lapse risk.',
    `total_outstanding_balance` DECIMAL(18,2) COMMENT 'Combined outstanding principal and accrued interest balance. This is the amount that would be deducted from death benefit or surrender value.',
    `total_repayments_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of all repayments (principal and interest) made on this loan since origination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this policy loan record was last modified in the system.',
    CONSTRAINT pk_loan PRIMARY KEY(`loan_id`)
) COMMENT 'Master record for all policy loans issued against the cash surrender value (CSV) of permanent life insurance policies. Captures loan number, loan type (standard, automatic premium loan — APL, systematic loan), loan origination date, original loan amount, outstanding loan balance, accrued interest balance, loan interest rate, interest rate type (fixed, variable, Moodys Corporate Bond Yield Average), loan status (active, repaid, foreclosed, offset at death), last interest posting date, interest capitalization date, collateral CSV amount at origination, automatic premium loan trigger flag, loan repayment schedule, partial repayment amount, and loan offset amount applied at claim or surrender. Critical for policy value calculations, death benefit reduction, and IRS reporting of loan-related taxable events.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`dividend` (
    `dividend_id` BIGINT COMMENT 'Unique identifier for the dividend record. Primary key for the dividend product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Dividend option elections (especially PUA, OYT) and special/terminal dividends require employee approval for suitability review and compliance. Regulatory requirement for tracking who approved dividen',
    `assumption_set_id` BIGINT COMMENT 'Foreign key linking to actuarial.assumption_set. Business justification: Dividend scales are built from actuarial assumption sets containing mortality, interest, and expense factors. Actuaries use assumption_set to calculate declared_amount and apportionment factors. Real ',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the participating whole life policy to which this dividend applies. Links to the policy master record.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Participating whole life dividend calculations are driven by general account portfolio performance (mortality, interest, expense factors). Required for dividend scale setting, apportionment methodolog',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Dividend calculation and processing may be outsourced to actuarial vendors or specialized processing services. Tracking the processor vendor supports vendor performance monitoring, audit trails, recon',
    `accumulated_balance` DECIMAL(18,2) COMMENT 'The current balance of dividends left on deposit with the company when the accumulate-at-interest option is elected. Includes principal and accrued interest.',
    `accumulated_interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate credited to accumulated dividends left on deposit. Expressed as a decimal (e.g., 0.0350 for 3.50%). Rate may be guaranteed or declared annually.',
    `accumulated_interest_ytd` DECIMAL(18,2) COMMENT 'The interest credited to accumulated dividends during the current policy year. Used for tax reporting and policy value reconciliation.',
    `apportionment_method` STRING COMMENT 'The actuarial method used to allocate divisible surplus to this policy. CONTRIBUTION = contribution method; THREE_FACTOR = mortality, interest, expense factors; EXPERIENCE = experience rating; ASSET_SHARE = asset share method.. Valid values are `CONTRIBUTION|THREE_FACTOR|EXPERIENCE|ASSET_SHARE`',
    `cash_payment_amount` DECIMAL(18,2) COMMENT 'The amount paid in cash to the policyholder when the cash dividend option is elected. May differ from declared amount if partial amounts are applied to other options.',
    `cash_payment_date` DATE COMMENT 'The date on which the cash dividend payment was issued or electronically transferred to the policyholder. Used for cash flow tracking and reconciliation.',
    `cash_payment_method` STRING COMMENT 'The method used to disburse the cash dividend payment. CHECK = paper check; ACH = automated clearing house; WIRE = wire transfer; EFT = electronic funds transfer.. Valid values are `CHECK|ACH|WIRE|EFT`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this dividend record was first created in the system. Used for audit trail and data lineage tracking.',
    `declaration_date` DATE COMMENT 'The date on which the board of directors or authorized committee formally declared the dividend for the policy year. Represents the official authorization date.',
    `declared_amount` DECIMAL(18,2) COMMENT 'The total dividend amount declared for the policy for the dividend year, expressed in the policy currency. Represents the policyholders share of divisible surplus before any option election.',
    `dividend_status` STRING COMMENT 'Current processing status of the dividend. DECLARED = authorized but not yet processed; PENDING = awaiting option election; PAID = cash payment issued; APPLIED = applied per elected option; FORFEITED = lost due to lapse; REVERSED = reversed due to policy adjustment.. Valid values are `DECLARED|PENDING|PAID|APPLIED|FORFEITED|REVERSED`',
    `expense_factor` DECIMAL(18,2) COMMENT 'The expense component of the dividend calculation. Represents the policyholders share of favorable expense experience relative to pricing assumptions.',
    `illustration_flag` BOOLEAN COMMENT 'Indicates whether this dividend amount was used in a policy illustration. True if included in an illustration provided to the policyholder; false otherwise. Used for compliance tracking.',
    `interest_factor` DECIMAL(18,2) COMMENT 'The investment earnings component of the dividend calculation. Represents the policyholders share of investment income exceeding guaranteed rates.',
    `loan_reduction_amount` DECIMAL(18,2) COMMENT 'The amount of the dividend applied to reduce the outstanding policy loan balance when the loan reduction option is elected. Reduces principal and/or accrued loan interest.',
    `mortality_factor` DECIMAL(18,2) COMMENT 'The mortality component of the dividend calculation. Represents the policyholders share of favorable mortality experience for the dividend year.',
    `option_code` STRING COMMENT 'The dividend option elected by the policyholder. CASH = cash payment; PREM_RED = premium reduction; PUA = paid-up additions; ACCUM = accumulate at interest; OYT = one-year term insurance; LOAN_RED = loan reduction.. Valid values are `CASH|PREM_RED|PUA|ACCUM|OYT|LOAN_RED`',
    `option_effective_date` DATE COMMENT 'The date on which the elected dividend option becomes effective. May differ from declaration date if the policyholder changes their election within the allowed window.',
    `oyt_coverage_amount` DECIMAL(18,2) COMMENT 'The face amount of one-year term insurance purchased with the dividend when the OYT option is elected. Provides temporary additional death benefit for one policy year.',
    `oyt_premium_paid` DECIMAL(18,2) COMMENT 'The portion of the dividend used to purchase the one-year term coverage. Represents the cost of the temporary insurance benefit.',
    `premium_reduction_amount` DECIMAL(18,2) COMMENT 'The amount of the dividend applied to reduce the next premium due when the premium reduction option is elected. Reduces the net premium payable by the policyholder.',
    `processing_timestamp` TIMESTAMP COMMENT 'The date and time when the dividend record was processed by the policy administration system. Represents the system processing event, distinct from business effective dates.',
    `pua_cash_value` DECIMAL(18,2) COMMENT 'The cash surrender value of the paid-up additions purchased with this dividend. Contributes to the total policy cash value and is available for loans or surrender.',
    `pua_face_amount` DECIMAL(18,2) COMMENT 'The face amount of paid-up additional insurance purchased with the dividend when the PUA option is elected. Represents incremental death benefit added to the base policy.',
    `reversal_date` DATE COMMENT 'The date on which a previously declared or paid dividend was reversed. Used for audit trail and financial reconciliation.',
    `reversal_reason_code` STRING COMMENT 'The reason for reversing a previously declared or paid dividend. POLICY_LAPSE = policy lapsed before dividend paid; POLICY_RESCISSION = policy rescinded; DATA_CORRECTION = data error correction; CALCULATION_ERROR = actuarial calculation error; OPTION_CHANGE = policyholder changed option election.. Valid values are `POLICY_LAPSE|POLICY_RESCISSION|DATA_CORRECTION|CALCULATION_ERROR|OPTION_CHANGE`',
    `scale_version` STRING COMMENT 'The version identifier of the dividend scale used to calculate this dividend. Links to the actuarial dividend scale table and supports audit trail for rate changes.',
    `source_system_code` STRING COMMENT 'The identifier of the source policy administration system from which this dividend record originated. Supports multi-system environments and data lineage tracking.',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this dividend record in the source policy administration system. Enables traceability back to the system of record.',
    `special_dividend_flag` BOOLEAN COMMENT 'Indicates whether this is a special or extraordinary dividend declared outside the normal annual dividend cycle. True for special dividends; false for regular annual dividends.',
    `tax_reporting_year` STRING COMMENT 'The calendar year in which the dividend is reportable for tax purposes. May differ from dividend year due to timing of payment or option application.',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The portion of the dividend that is taxable to the policyholder. Generally zero for participating whole life unless dividends exceed premiums paid, but tracked for IRS reporting compliance.',
    `terminal_dividend_flag` BOOLEAN COMMENT 'Indicates whether this is a terminal dividend paid upon policy maturity, death claim, or surrender. True for terminal dividends; false for annual dividends.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this dividend record was last modified. Used for audit trail and change tracking.',
    `year` STRING COMMENT 'The policy year or calendar year for which the dividend was declared. Represents the experience period underlying the dividend calculation.',
    CONSTRAINT pk_dividend PRIMARY KEY(`dividend_id`)
) COMMENT 'Tracks annual policyholder dividend declarations and elections for participating whole life policies. Stores dividend year, declared dividend amount, dividend option elected (cash, premium reduction, paid-up additions — PUA, accumulate at interest, one-year term), dividend option effective date, paid-up additions face amount purchased, accumulated dividend balance, dividend interest rate, and dividend payment date. Owned by the policy domain as a contractual feature of participating policies.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` (
    `tax_compliance_test_id` BIGINT COMMENT 'Primary key for tax_compliance_test',
    `employee_id` BIGINT COMMENT 'The user ID of the underwriter or compliance officer who performed the manual override of the MEC test result. Null if no override occurred.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance or annuity policy for which this MEC test was performed.',
    `mortality_table_id` BIGINT COMMENT 'Foreign key linking to actuarial.mortality_table. Business justification: MEC and CVAT tests require mortality assumptions to calculate guideline premiums and corridor percentages. IRS compliance testing mandates specific mortality tables. Real regulatory process actuaries ',
    `run_id` BIGINT COMMENT 'A unique identifier for the batch or run in which this MEC test was executed. Used to group tests performed together and trace back to specific actuarial valuation runs.',
    `account_value_at_test` DECIMAL(18,2) COMMENT 'The policy account value (gross cash value before surrender charges) at the time the MEC test was performed. Relevant for universal life and variable universal life products.',
    `actuarial_system_source` STRING COMMENT 'The name and version of the actuarial valuation system that performed the MEC test calculation (e.g., MoSes, AXIS, Prophet). Critical for audit trail and calculation reproducibility.',
    `cash_value_accumulation_limit` DECIMAL(18,2) COMMENT 'The maximum cash value the policy can accumulate under the Cash Value Accumulation Test (CVAT) without violating IRC 7702 life insurance definition. Only applicable if CVAT election was made.',
    `cash_value_at_test` DECIMAL(18,2) COMMENT 'The policy cash surrender value at the time the MEC test was performed. Used in corridor test calculations and CVAT limit assessments.',
    `corridor_test_result` STRING COMMENT 'Result of the corridor test which ensures the death benefit maintains a minimum ratio to the cash value. Required for policies to maintain life insurance tax treatment under IRC 7702.. Valid values are `pass|fail|not applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this MEC test result record was first created in the system.',
    `cumulative_premiums_paid` DECIMAL(18,2) COMMENT 'The total amount of premiums paid into the policy from issuance through the test date. Used to compare against the 7-pay premium limit.',
    `death_benefit_at_test` DECIMAL(18,2) COMMENT 'The policy death benefit amount in effect at the time the MEC test was performed. Death benefit is a key input to the 7-pay premium limit calculation.',
    `definition_election` STRING COMMENT 'The IRC Section 7702 definition of life insurance elected by the policyholder at issuance. GPT uses guideline premiums and cash value corridor; CVAT uses cash value accumulation limits. This election is irrevocable.. Valid values are `GPT|CVAT`',
    `exchange_1035_flag` BOOLEAN COMMENT 'Indicates whether this policy was acquired through a Section 1035 tax-free exchange from another life insurance or annuity contract. 1035 exchanges carry forward the MEC status from the original contract.',
    `exchanged_policy_mec_status` STRING COMMENT 'If this policy was acquired through a 1035 exchange, this field captures the MEC status of the original exchanged policy. MEC status is preserved in 1035 exchanges.. Valid values are `MEC|non-MEC|not applicable`',
    `form_1099r_reportable` BOOLEAN COMMENT 'Indicates whether distributions from this policy are reportable on IRS Form 1099-R due to MEC status. MEC distributions are subject to income tax and potential early withdrawal penalties.',
    `guideline_level_premium` DECIMAL(18,2) COMMENT 'The maximum level annual premium that can be paid into the policy under the Guideline Premium Test (GPT) without violating IRC 7702 life insurance definition. Only applicable if GPT election was made.',
    `guideline_single_premium` DECIMAL(18,2) COMMENT 'The maximum single premium that can be paid into the policy under the Guideline Premium Test (GPT) without violating IRC 7702 life insurance definition. Only applicable if GPT election was made.',
    `insured_age_at_test` STRING COMMENT 'The age of the insured at the time the MEC test was performed. Age is a key actuarial input to the 7-pay premium limit calculation.',
    `irs_reporting_flag` BOOLEAN COMMENT 'Indicates whether this MEC test result requires reporting to the IRS. True if the policy became a MEC or if a material change occurred that affects tax treatment.',
    `material_change_date` DATE COMMENT 'The date on which a material change event occurred, triggering a new 7-pay test period. Null if no material change has occurred.',
    `material_change_event_type` STRING COMMENT 'The type of material change event that triggered a new MEC test. Material changes reset the 7-pay test period. If no material change occurred, this field is set to none.. Valid values are `death benefit increase|rider addition|premium increase|policy exchange|none`',
    `mec_status` STRING COMMENT 'The result of the MEC test indicating whether the policy is classified as a Modified Endowment Contract. MEC status affects the tax treatment of policy distributions and loans.. Valid values are `MEC|non-MEC`',
    `override_reason` STRING COMMENT 'If the MEC test result was manually overridden by an underwriter or compliance officer, this field captures the business justification for the override. Null if no override occurred.',
    `override_timestamp` TIMESTAMP COMMENT 'The date and time when the MEC test result was manually overridden. Null if no override occurred.',
    `policy_issue_date` DATE COMMENT 'The original issue date of the policy. Used to determine policy year and the start of the 7-pay test period.',
    `policy_year_at_test` STRING COMMENT 'The policy year (anniversary year) in which the MEC test was performed. Relevant for tracking the 7-pay test period which spans the first seven policy years or until a material change.',
    `prior_mec_status` STRING COMMENT 'The MEC status of the policy before this test was performed. Used to track status changes and identify when a policy first became a MEC. Set to not applicable for initial issuance tests.. Valid values are `MEC|non-MEC|not applicable`',
    `seven_pay_premium_limit` DECIMAL(18,2) COMMENT 'The maximum cumulative premium that can be paid into the policy during the first seven years (or until a material change) without causing the policy to become a MEC. Calculated based on actuarial assumptions and policy death benefit.',
    `test_calculation_method` STRING COMMENT 'The actuarial methodology and assumptions used to calculate the 7-pay premium limit and other test thresholds. May reference specific assumption sets or calculation standards.',
    `test_date` DATE COMMENT 'The date on which the MEC test was performed. This may be at policy issuance or upon a material change event.',
    `test_notes` STRING COMMENT 'Free-form notes and comments regarding the MEC test, including any special circumstances, assumptions, or actuarial judgments applied during the calculation.',
    `test_status` STRING COMMENT 'The processing status of the MEC test. Indicates whether the test calculation has been completed, is pending actuarial review, failed due to data issues, or was manually overridden.. Valid values are `completed|pending|failed|overridden`',
    `test_type` STRING COMMENT 'The type of MEC test performed. The 7-pay test is the primary test under IRC 7702A to determine if cumulative premiums paid exceed the 7-pay premium limit.. Valid values are `7-pay test|material change test|initial issuance test`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this MEC test result record was last modified in the system.',
    CONSTRAINT pk_tax_compliance_test PRIMARY KEY(`tax_compliance_test_id`)
) COMMENT 'Stores the results of IRC Section 7702A Modified Endowment Contract (MEC) testing performed on each policy at issuance and upon material change. Captures test date, test type (7-pay test), 7-pay premium limit, cumulative premiums paid to date, MEC status flag (MEC / non-MEC), material change event type, material change date, corridor test result, GPT/CVAT election, guideline single premium, guideline level premium, and the actuarial system that performed the calculation. Critical for IRS compliance and tax reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`fund_allocation` (
    `fund_allocation_id` BIGINT COMMENT 'Unique identifier for each policy fund allocation record. Primary key for the policy fund allocation entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Variable/indexed product fund allocation changes require employee approval for suitability review, especially large reallocations or high-risk fund elections. Regulatory requirement (FINRA, state insu',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the parent policy contract (UL, IUL, VUL, or FIA) to which this fund allocation applies.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: Fixed allocation options in hybrid variable products reference general account portfolios. Required for blended portfolio management, ALM analysis, and unified performance reporting across fixed and v',
    `separate_account_fund_id` BIGINT COMMENT 'Foreign key linking to product.separate_account_fund. Business justification: Variable and indexed product fund allocations must link to the separate account fund master (separate_account_fund) for NAV calculation, performance reporting, prospectus compliance, expense ratio app',
    `allocation_amount` DECIMAL(18,2) COMMENT 'For dollar-based allocations (e.g., DCA programs), the fixed dollar amount allocated to this fund per period. Null for percentage-based allocations.',
    `allocation_approval_date` DATE COMMENT 'Date when the allocation instruction was approved and accepted by the policy administration system, completing validation and compliance checks.',
    `allocation_effective_date` DATE COMMENT 'Date when this fund allocation instruction became effective and began applying to premium payments or account value rebalancing.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Current percentage of premium or account value allocated to this fund. Must sum to 100% across all allocations for a given policy and allocation type. Expressed as a percentage (e.g., 25.50 for 25.5%).',
    `allocation_request_date` DATE COMMENT 'Date when the allocation change was requested by the policyholder or advisor. May differ from effective date due to processing time or future-dated instructions.',
    `allocation_sequence_number` STRING COMMENT 'Sequential ordering number for multiple fund allocations within the same policy and allocation type. Used for processing priority and display ordering.',
    `allocation_source` STRING COMMENT 'Origin of this allocation instruction: policyholder-elected, system default, advisor-recommended, or automated program-driven.. Valid values are `policyholder_election|default_allocation|advisor_recommendation|systematic_program|rebalancing_rule`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this fund allocation instruction. Active allocations are applied to transactions; inactive/terminated allocations are historical records.. Valid values are `active|inactive|pending|suspended|terminated`',
    `allocation_termination_date` DATE COMMENT 'Date when this allocation instruction was terminated or superseded by a new allocation. Null for currently active allocations.',
    `allocation_termination_reason` STRING COMMENT 'Reason why this allocation instruction was terminated. Null for active allocations.. Valid values are `policyholder_change|fund_closure|product_conversion|policy_lapse|systematic_completion|regulatory_restriction`',
    `allocation_type` STRING COMMENT 'Type of allocation instruction: premium_allocation (applies to new premium payments), account_value_rebalance (periodic rebalancing of existing AV), transfer (one-time fund transfer), systematic_rebalance (automated periodic rebalancing), dollar_cost_averaging (DCA program allocation).. Valid values are `premium_allocation|account_value_rebalance|transfer|systematic_rebalance|dollar_cost_averaging`',
    `cap_rate` DECIMAL(18,2) COMMENT 'Maximum interest rate that can be credited to the policy account value for this indexed fund allocation, expressed as a percentage (e.g., 12.00 for 12%). Applicable to IUL and FIA products with capped index strategies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this allocation record was first created in the policy administration system.',
    `dollar_cost_averaging_flag` BOOLEAN COMMENT 'Indicates whether this allocation is part of a dollar cost averaging program where premium is systematically transferred from a fixed account to investment funds over time.',
    `floor_rate` DECIMAL(18,2) COMMENT 'Minimum guaranteed interest rate for this fund allocation, expressed as a percentage (e.g., 0.00 for 0% floor). Protects against negative index performance in IUL and FIA products.',
    `fund_category` STRING COMMENT 'High-level investment category classification of the fund for reporting and risk management purposes. [ENUM-REF-CANDIDATE: equity|fixed_income|balanced|money_market|index|specialty|guaranteed|alternative — 8 candidates stripped; promote to reference product]',
    `fund_expense_ratio` DECIMAL(18,2) COMMENT 'Annual expense ratio charged by the investment fund, expressed as a decimal (e.g., 0.0075 for 0.75%). Used for cost disclosure and performance reporting.',
    `fund_risk_rating` STRING COMMENT 'Risk profile classification of the investment fund used for suitability assessment and portfolio construction.. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `index_segment_end_date` DATE COMMENT 'For IUL and FIA products, the end date of the current index crediting segment or term when index gains/losses are calculated and credited.',
    `index_segment_start_date` DATE COMMENT 'For IUL and FIA products, the start date of the current index crediting segment or term. Used to track index performance measurement periods.',
    `index_segment_term_years` STRING COMMENT 'Length of the index crediting term in years (e.g., 1, 2, 5, 7) for IUL and FIA products. Determines the measurement period for index performance.',
    `index_strategy_code` STRING COMMENT 'For IUL and FIA products, the index crediting strategy method used to calculate interest credits. Not applicable for traditional variable products. Common strategies include point-to-point, monthly average, and annual reset. [ENUM-REF-CANDIDATE: point_to_point|monthly_average|annual_reset|high_water_mark|monthly_cap|annual_cap|not_applicable — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this allocation record was most recently updated or modified.',
    `last_rebalance_date` DATE COMMENT 'Date when the most recent automatic or manual rebalancing of account value to target allocation percentages was executed.',
    `maximum_allocation_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage that can be allocated to this fund per product rules or regulatory requirements. Used for compliance validation during allocation changes.',
    `minimum_allocation_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage that must be maintained in this fund per product rules or regulatory requirements. Used for compliance validation during allocation changes.',
    `mortality_and_expense_risk_charge` DECIMAL(18,2) COMMENT 'Annual M&E risk charge assessed against this fund allocation for variable products, expressed as a decimal (e.g., 0.0125 for 1.25%). Covers insurance guarantees and administrative expenses.',
    `next_rebalance_date` DATE COMMENT 'Scheduled date for the next automatic rebalancing transaction based on the rebalancing frequency. Null if no automatic rebalancing is configured.',
    `participation_rate` DECIMAL(18,2) COMMENT 'Percentage of index gain that is credited to the policy account value, expressed as a percentage (e.g., 85.00 for 85% participation). Applicable to IUL and FIA products.',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the policy account value is automatically rebalanced to match the target allocation percentages. none indicates no automatic rebalancing.. Valid values are `none|monthly|quarterly|semi_annually|annually|on_demand`',
    `source_system_code` STRING COMMENT 'Code identifying the policy administration system or platform that originated this allocation record (e.g., FAST, SAPIENS, ORACLE_IPAS).',
    `spread_rate` DECIMAL(18,2) COMMENT 'Percentage deducted from index gains before crediting to the policy account value, expressed as a percentage (e.g., 2.50 for 2.5% spread). Alternative to cap rate in some indexed product designs.',
    CONSTRAINT pk_fund_allocation PRIMARY KEY(`fund_allocation_id`)
) COMMENT 'Tracks investment fund allocation instructions and current allocation percentages for universal life (UL, IUL, VUL) and fixed indexed annuity (FIA) policies with investment options. Stores fund code, fund name, allocation percentage, allocation effective date, allocation type (premium allocation, account value rebalance, transfer), rebalancing frequency, dollar cost averaging flag, index strategy code (for IUL/FIA: point-to-point, monthly average, annual reset), cap rate, participation rate, floor rate, spread, and last rebalance date. Sourced from the Policy Administration System investment allocation module.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for the policy or annuity contract assignment record.',
    `document_id` BIGINT COMMENT 'Reference to the scanned or stored legal assignment document in the document management system.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance policy or annuity contract being assigned.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Collateral assignments and absolute assignments require employee processing/approval for compliance verification, especially for executive benefit arrangements (split-dollar, COLI). Audit trail and SO',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Collateral assignments (especially premium financing arrangements) typically involve producer facilitation and documentation. Business tracks producer involvement for compliance verification, commissi',
    `approval_date` DATE COMMENT 'Date on which the assignment was approved by the insurer.',
    `approval_status` STRING COMMENT 'Internal approval status of the assignment request: approved (accepted by insurer), pending (awaiting review), rejected (denied), or under_review (in evaluation).. Valid values are `approved|pending|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the underwriter or operations staff who approved the assignment.',
    `assigned_amount` DECIMAL(18,2) COMMENT 'For collateral assignments, the maximum dollar amount of the loan or debt secured by the policy. Null for absolute assignments.',
    `assigned_percentage` DECIMAL(18,2) COMMENT 'Percentage of policy benefits assigned to the assignee. Typically 100% for absolute assignments, may be partial for collateral assignments.',
    `assignee_address_line1` STRING COMMENT 'Primary street address line for the assignee, used for legal notices and correspondence.',
    `assignee_address_line2` STRING COMMENT 'Secondary address line (suite, apartment, floor) for the assignee.',
    `assignee_city` STRING COMMENT 'City of the assignees address.',
    `assignee_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the assignees address.. Valid values are `USA|CAN|MEX|GBR|FRA|DEU`',
    `assignee_email` STRING COMMENT 'Primary email address for assignee correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assignee_name` STRING COMMENT 'Full legal name of the individual, financial institution, employer, or trust receiving the assignment rights.',
    `assignee_phone` STRING COMMENT 'Primary contact phone number for the assignee.',
    `assignee_postal_code` STRING COMMENT 'Postal or ZIP code of the assignees address.',
    `assignee_state` STRING COMMENT 'State or province code of the assignees address.',
    `assignee_tin` STRING COMMENT 'Tax identification number (SSN or EIN) of the assignee for IRS reporting and identity verification.',
    `assignee_type` STRING COMMENT 'Classification of the assignee entity: individual person, financial institution (bank, lender), employer (for group policy assignments), trust (ILIT or other), or other entity type.. Valid values are `individual|financial_institution|employer|trust|other`',
    `assignment_number` STRING COMMENT 'Business-facing unique identifier for the assignment, often used in correspondence and legal documents.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment: active (in force), released (terminated by assignee), foreclosed (lender exercised rights), pending (awaiting approval), or cancelled (voided before activation).. Valid values are `active|released|foreclosed|pending|cancelled`',
    `assignment_type` STRING COMMENT 'Type of assignment: absolute (full transfer of ownership rights) or collateral (security interest for a loan).. Valid values are `absolute|collateral`',
    `comments` STRING COMMENT 'Free-text notes or comments regarding the assignment, including special instructions, exceptions, or clarifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the assignment becomes legally effective and the assignees rights commence.',
    `irrevocable_flag` BOOLEAN COMMENT 'Indicates whether the assignment is irrevocable (true) or revocable (false). Irrevocable assignments cannot be changed without assignee consent.',
    `lender_loan_reference` STRING COMMENT 'External loan or account number from the lending institution, used to correlate the assignment with the underlying debt obligation.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the assignment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the assignment record was last modified.',
    `notarization_date` DATE COMMENT 'Date on which the assignment document was notarized.',
    `notary_public_name` STRING COMMENT 'Name of the notary public who notarized the assignment document, if applicable.',
    `notification_sent_date` DATE COMMENT 'Date on which the insurer sent formal notification of the assignment to the policy owner and assignee.',
    `premium_payment_responsibility` STRING COMMENT 'Party responsible for paying policy premiums under the assignment: owner (policy owner retains responsibility), assignee (assignee assumes premium payments), or shared (split responsibility).. Valid values are `owner|assignee|shared`',
    `reason` STRING COMMENT 'Business reason or purpose for the assignment, such as premium financing, estate planning, loan collateral, or gift.',
    `recording_date` DATE COMMENT 'Date on which the assignment was officially recorded in the insurers policy administration system.',
    `rejection_reason` STRING COMMENT 'Explanation for why the assignment request was rejected, if applicable.',
    `release_date` DATE COMMENT 'Date on which the assignment was released or terminated, returning full rights to the policy owner. Null if assignment is still active.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the assignment record.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'Records all absolute and collateral assignments of life insurance policies and annuity contracts. Captures assignment type (absolute, collateral), assignee name, assignee TIN, assignee type (individual, financial institution, employer, trust), assignment effective date, assignment release date, assigned amount (for collateral assignments), assignment status (active, released, foreclosed), lender loan reference number, assignment recording date, and notification sent date. Supports lender notification workflows, collateral release processing, premium financing arrangements, and ownership rights management under UCC Article 9.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Unique identifier for the policy service request transaction. Primary key for all post-issue policy servicing transactions, contractual endorsements, administrative changes, policy conversions, and IRC Section 1035 tax-free exchanges.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal agent, underwriter, or administrator who processed and completed the service request. Supports workload tracking and quality assurance.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance or annuity policy contract being serviced. Links to the master policy record in the Policy Administration System.',
    `issue_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_issue. Business justification: Service requests may trigger compliance issues (e.g., replacement not properly documented, beneficiary change without insurable interest verification). Linking enables root cause analysis, supports pr',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Service requests (conversions, exchanges, beneficiary changes) are frequently producer-facilitated. Business tracks producer involvement for commission attribution, service quality metrics, compliance',
    `annuity_contract_id` BIGINT COMMENT 'Foreign key linking to annuity.annuity_contract. Business justification: Service requests for 1035 exchanges and policy-to-annuity conversions track the resulting annuity contract for workflow completion verification, customer notifications, and regulatory documentation. E',
    `collateral_assignment_amount` DECIMAL(18,2) COMMENT 'For collateral assignment requests, the maximum amount of the death benefit assigned to the lender as collateral. Limits the lenders claim on policy proceeds.',
    `collateral_assignment_lender_name` STRING COMMENT 'For collateral assignment requests, the name of the lending institution or creditor to whom the policy death benefit is assigned as collateral security. Business-confidential financial relationship data.',
    `comments` STRING COMMENT 'Free-text notes and comments from the policyholder, agent, or processing administrator regarding the service request. Captures additional context not structured in other fields.',
    `completion_date` DATE COMMENT 'Date the service request was fully processed and completed in the Policy Administration System. Used for SLA compliance measurement and audit trail.',
    `conversion_credit_amount` DECIMAL(18,2) COMMENT 'For conversion requests, the monetary credit or value transferred from the original policy to the new converted policy. Represents accumulated value or conversion privilege benefit.',
    `conversion_privilege_expiry_date` DATE COMMENT 'For conversion requests, the last date the policyholder can exercise their contractual conversion privilege without evidence of insurability. Critical for conversion window tracking.',
    `conversion_source_policy_type` STRING COMMENT 'For conversion requests, the original policy type being converted from. Typically YRT (Yearly Renewable Term) or term life insurance converting to permanent coverage.. Valid values are `yrt|term|whole_life|universal_life|indexed_universal_life|variable_universal_life`',
    `conversion_target_policy_type` STRING COMMENT 'For conversion requests, the new policy type being converted to. Typically permanent life insurance products (WL, UL, IUL, VUL).. Valid values are `whole_life|universal_life|indexed_universal_life|variable_universal_life`',
    `cost_basis_transferred` DECIMAL(18,2) COMMENT 'For 1035 exchange requests, the tax cost basis (investment in the contract) transferred from the surrendering policy. Critical for future tax calculations on distributions and surrenders.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service request record was first created in the data platform. Audit trail for data lineage and regulatory compliance.',
    `effective_date` DATE COMMENT 'Date the service request change becomes effective on the policy contract. For endorsements, this is the amendment effective date. May differ from request date for future-dated changes.',
    `endorsement_number` STRING COMMENT 'Sequential endorsement identifier for formal contractual amendments to the policy. Null for administrative changes that do not constitute contractual modifications.',
    `evidence_of_insurability_waived_flag` BOOLEAN COMMENT 'For conversion requests, indicates whether medical underwriting and evidence of insurability requirements were waived under the conversion privilege. True if waived, False if evidence required.',
    `exchange_1035_type` STRING COMMENT 'For 1035 exchange requests, the type of tax-free exchange under IRC Section 1035. Determines permissible exchange paths and tax treatment.. Valid values are `life_to_life|annuity_to_annuity|life_to_annuity`',
    `exchange_amount_transferred` DECIMAL(18,2) COMMENT 'For 1035 exchange requests, the total cash surrender value or account value transferred from the surrendering policy to the new policy. Represents the gross exchange proceeds.',
    `gain_deferred` DECIMAL(18,2) COMMENT 'For 1035 exchange requests, the amount of taxable gain deferred through the tax-free exchange. Calculated as exchange_amount_transferred minus cost_basis_transferred. Deferred gain remains taxable upon future surrender or distribution.',
    `irs_form_1035_attestation_flag` BOOLEAN COMMENT 'For 1035 exchange requests, indicates whether the policyholder has signed and submitted IRS Form 1035 attesting to the tax-free exchange. Required for regulatory compliance and tax reporting.',
    `new_policy_reference` STRING COMMENT 'For conversion requests, the policy number or reference of the newly issued converted policy. Links the conversion service request to the resulting new policy contract.',
    `new_value` DECIMAL(18,2) COMMENT 'The value of the policy attribute after the service request change. Combined with prior_value, creates complete before-and-after audit trail.',
    `nigo_reason_code` STRING COMMENT 'Standardized code indicating why the service request was marked NIGO (Not In Good Order). Identifies missing documents, incomplete information, or deficiencies requiring correction. Critical for NIGO reduction initiatives.',
    `prior_value` DECIMAL(18,2) COMMENT 'The value of the policy attribute before the service request change. Provides full audit trail of all contractual and administrative modifications for regulatory compliance.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason or trigger for the service request. Supports root cause analysis and process improvement initiatives.',
    `reinstatement_evidence_required_flag` BOOLEAN COMMENT 'For reinstatement requests, indicates whether evidence of insurability (medical underwriting) is required to reinstate the lapsed policy. Depends on lapse duration and policy provisions.',
    `reinstatement_premium_amount` DECIMAL(18,2) COMMENT 'For reinstatement requests, the total premium amount (including back premiums, interest, and fees) required to reinstate a lapsed policy. Must be paid to restore coverage.',
    `request_channel` STRING COMMENT 'Channel or interface through which the service request was submitted. Supports channel analytics and customer experience optimization. [ENUM-REF-CANDIDATE: phone|web_portal|agent|mail|email|fax|in_person — 7 candidates stripped; promote to reference product]',
    `request_date` DATE COMMENT 'Date the service request was received or initiated by the policyholder, agent, or administrator. Represents the business event timestamp for SLA tracking.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the service request, endorsement, or administrative change. Used for customer and agent communication and tracking.',
    `request_status` STRING COMMENT 'Current lifecycle status of the service request. NIGO (Not In Good Order) indicates incomplete or deficient submission requiring additional information or correction. [ENUM-REF-CANDIDATE: received|in_review|pending_documents|completed|nigo|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `request_type` STRING COMMENT 'Classification of the policy service request or endorsement type. Includes administrative changes (address, beneficiary, ownership, premium mode, face amount, dividend option, name, duplicate contract), contractual amendments (rider addition/removal, collateral assignment), policy reinstatements, term-to-permanent conversions, and IRC Section 1035 tax-free exchanges. [ENUM-REF-CANDIDATE: address_change|beneficiary_change|ownership_change|premium_mode_change|face_amount_change|dividend_option_change|name_change|duplicate_policy_contract|rider_addition|rider_removal|collateral_assignment|reinstatement|conversion|1035_exchange — 14 candidates stripped; promote to reference product]',
    `rider_code` STRING COMMENT 'For rider addition or removal requests, the standardized code identifying the specific rider (ADB - Accidental Death Benefit, AWL - Automatic Waiver of Premium, CAR - Company Action Rider, LTC - Long-Term Care, etc.).',
    `sla_due_date` DATE COMMENT 'Target completion date based on service level agreement commitments for the request type. Used for SLA monitoring, NIGO reduction initiatives, and operational performance tracking.',
    `source_system_transaction_code` STRING COMMENT 'Original transaction identifier from the Policy Administration System (e.g., FAST, Sapiens LifePro, Oracle Insurance). Enables traceability back to source system for reconciliation and audit.',
    `surrendering_carrier_name` STRING COMMENT 'For 1035 exchange requests, the name of the insurance carrier whose policy is being surrendered and exchanged. Required for IRS Form 1035 reporting.',
    `surrendering_policy_number` STRING COMMENT 'For 1035 exchange requests, the policy number of the contract being surrendered at the external carrier. Required for exchange processing and IRS reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the service request record was last modified in the data platform. Supports change tracking and audit trail requirements.',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'SSOT for all post-issue policy servicing transactions, contractual endorsements, administrative changes, policy conversions, and IRC Section 1035 tax-free exchanges processed through the Policy Administration System. Encompasses administrative service requests, formal contractual amendments (endorsements), term-to-permanent conversions, and 1035 exchange transactions. Captures request/endorsement type (address change, beneficiary change, ownership change, premium mode change, face amount change, dividend option change, name change, duplicate policy contract request, rider addition/removal, collateral assignment, reinstatement, conversion, 1035 exchange), endorsement number (for contractual amendments), amendment effective date, request channel (phone, web portal, agent, mail), request date, effective date, request status (received, in-review, completed, NIGO — Not In Good Order, cancelled), prior value, new value, reason code, NIGO reason code, SLA due date, completion date, processing agent ID, source system transaction ID. For conversions: source policy type (YRT, term), target policy type (WL, UL, IUL), conversion credit amount, conversion privilege expiry date, evidence of insurability waived flag, new policy reference. For 1035 exchanges: exchange type (life-to-life, annuity-to-annuity, life-to-annuity), surrendering carrier name, surrendering policy number, exchange amount transferred, cost basis transferred, gain deferred, IRS Form 1035 attestation flag. Provides full audit trail of all contractual modifications. Supports policy servicing SLA monitoring, NIGO reduction initiatives, and regulatory audit trail requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`note` (
    `note_id` BIGINT COMMENT 'Unique identifier for the policy note record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user, agent, or system that created the note. May be employee ID, agent code, or system process identifier.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy contract to which this note is attached. Links note to the in-force policy record.',
    `document_id` BIGINT COMMENT 'Reference to an associated document stored in the document management system (e.g., scanned correspondence, email attachment, form).',
    `issue_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_issue. Business justification: Policy notes may document compliance concerns that later become formal issues (e.g., suitability red flags, AML suspicions). Linking enables audit trail from initial observation to formal issue escala',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Policy notes frequently document producer interactions, field underwriting observations, service requests, or complaints. Business requires producer attribution for service quality tracking, complianc',
    `reply_to_note_id` BIGINT COMMENT 'Self-referencing FK on note (reply_to_note_id)',
    `author_name` STRING COMMENT 'Full name of the individual or system that created the note. Provides human-readable identification for audit and customer service purposes.',
    `author_role` STRING COMMENT 'Functional role or job title of the note author at the time of creation (e.g., underwriter, customer service representative, claims adjudicator, agent, system administrator).',
    `complaint_category` STRING COMMENT 'Classification of the complaint type for regulatory reporting purposes (e.g., claims handling, premium billing, policy servicing, agent conduct).',
    `complaint_flag` BOOLEAN COMMENT 'Indicates whether this note documents a customer complaint. Triggers regulatory reporting and escalation workflows.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the note contains confidential or sensitive information with restricted visibility. Controls access permissions and disclosure rules.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the note record was first created in the source system. Used for audit trail and data lineage.',
    `follow_up_date` DATE COMMENT 'Target date by which follow-up action on this note should be completed. Used for diary management and Service Level Agreement (SLA) tracking.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether the note requires a follow-up action or callback. Used to drive workflow and task management.',
    `follow_up_status` STRING COMMENT 'Current status of the follow-up action associated with this note. Tracks progress toward resolution.. Valid values are `open|in_progress|completed|cancelled|overdue`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the note record was last modified in the source system. Tracks the most recent change to the note.',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether this note is related to a Not In Good Order (NIGO) case, where the policy application or service request is incomplete or requires additional information.',
    `nigo_reason_code` STRING COMMENT 'Standardized code identifying the specific reason the case was marked NIGO (e.g., missing signature, incomplete medical information, payment issue).',
    `note_category` STRING COMMENT 'Secondary classification or sub-type of the note for finer-grained categorization (e.g., NIGO resolution, complaint, inquiry, policy change, premium issue).',
    `note_date` DATE COMMENT 'Business date on which the note was recorded or the event described in the note occurred. Distinct from system audit timestamps.',
    `note_number` STRING COMMENT 'Business-facing unique identifier or sequence number for the note, used for reference and tracking in Policy Administration System (PAS) and customer service interactions.',
    `note_status` STRING COMMENT 'Current lifecycle status of the note. Indicates whether the note requires follow-up action or has been resolved.. Valid values are `open|closed|pending|escalated|archived`',
    `note_text` STRING COMMENT 'Free-form text content of the note. Contains the detailed annotation, diary entry, or case narrative recorded by the author. May include sensitive customer information or internal business commentary.',
    `note_type` STRING COMMENT 'Classification of the note by functional area or originating process. Determines routing, visibility, and retention rules.. Valid values are `servicing_note|underwriting_note|compliance_note|agent_note|system_generated|claim_note`',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether the note is marked as high priority or urgent, requiring expedited attention or escalation.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the note content or associated event must be reported to state insurance departments or other regulatory bodies.',
    `related_transaction_code` STRING COMMENT 'Reference to the specific policy transaction, service request, claim, or billing event that triggered or is associated with this note.',
    `related_transaction_type` STRING COMMENT 'Type of transaction referenced in related_transaction_id (e.g., premium payment, policy change, claim submission, underwriting decision, reinstatement).',
    `source_system` STRING COMMENT 'Name or code of the operational system that originated this note (e.g., Policy Administration System, Claims Management System, Customer Relationship Management system).',
    `source_system_record_code` STRING COMMENT 'Unique identifier of this note record in the source operational system. Used for data lineage and reconciliation.',
    `visibility_scope` STRING COMMENT 'Defines who is authorized to view this note. Controls whether the note is visible to agents, customers, or restricted to internal staff only.. Valid values are `internal_only|agent_visible|customer_visible|restricted`',
    CONSTRAINT pk_note PRIMARY KEY(`note_id`)
) COMMENT 'Captures all free-form and structured annotations, diary entries, and case notes recorded against a policy by servicing representatives, underwriters, agents, and automated systems. Stores note type (servicing note, underwriting note, compliance note, agent note, system-generated), note text, note date, author ID, author role, priority flag, follow-up date, follow-up status (open, closed), related transaction reference, and confidentiality flag. Critical for day-to-day policy servicing, NIGO resolution, complaint tracking, and regulatory examination support. Every PAS operator interacts with policy notes multiple times per day.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` (
    `nonforfeiture_option_id` BIGINT COMMENT 'Unique identifier for the nonforfeiture option election record. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier of the underwriter or manager who approved this nonforfeiture option election, if approval was required.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the permanent life insurance policy for which this nonforfeiture option was elected.',
    `lapse_event_id` BIGINT COMMENT 'Foreign key linking to billing.lapse_event. Business justification: Nonforfeiture option elections are triggered by lapse events and require lapse_event_id to determine CSV at lapse, outstanding loan balance, lapse date, and option election window for extended term in',
    `producer_id` BIGINT COMMENT 'Identifier of the customer service representative or agent who processed the nonforfeiture option election.',
    `superseded_nonforfeiture_option_id` BIGINT COMMENT 'Self-referencing FK on nonforfeiture_option (superseded_nonforfeiture_option_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether underwriting or management approval was required for this nonforfeiture option election (e.g., for large face amounts or special circumstances).',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the nonforfeiture option election was approved.',
    `calculation_method` STRING COMMENT 'Actuarial method or table used to calculate nonforfeiture benefits (e.g., 1980 CSO, 2001 CSO, company-specific tables).',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the nonforfeiture option election, processing, or special circumstances.',
    `cost_basis_amount` DECIMAL(18,2) COMMENT 'Total premiums paid into the policy (cost basis) used to calculate taxable gain on surrender.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this nonforfeiture option record was first created in the system.',
    `csv_at_election` DECIMAL(18,2) COMMENT 'Cash surrender value of the policy at the time of nonforfeiture option election, used as the basis for calculating ETI or RPU benefits.',
    `default_option_flag` BOOLEAN COMMENT 'Indicates whether this nonforfeiture option was applied as the default option per policy contract terms (typically Extended Term Insurance).',
    `disbursement_date` DATE COMMENT 'Date on which surrender proceeds were disbursed to the policyholder.',
    `disbursement_method` STRING COMMENT 'Method by which surrender proceeds were disbursed to the policyholder: check, Electronic Funds Transfer (EFT), wire transfer, or Automated Clearing House (ACH).. Valid values are `check|eft|wire_transfer|ach`',
    `effective_date` DATE COMMENT 'Date on which the nonforfeiture option became effective, typically the lapse date of the original policy.',
    `election_channel` STRING COMMENT 'Channel through which the nonforfeiture option was elected: agent, customer service, online portal, mail, or automatic (default option).. Valid values are `agent|customer_service|online_portal|mail|automatic`',
    `election_date` DATE COMMENT 'Date on which the policyholder elected this nonforfeiture option.',
    `election_reason_code` STRING COMMENT 'Code indicating the reason for nonforfeiture option election (e.g., financial hardship, policy no longer needed, premium affordability).',
    `eti_expiry_date` DATE COMMENT 'Date on which the Extended Term Insurance coverage expires if no death claim occurs.',
    `eti_face_amount` DECIMAL(18,2) COMMENT 'Death benefit face amount for Extended Term Insurance option, typically equal to the original policy face amount.',
    `eti_term_days` STRING COMMENT 'Number of additional days beyond full years for which Extended Term Insurance coverage is provided.',
    `eti_term_years` STRING COMMENT 'Number of full years for which Extended Term Insurance coverage is provided based on the net nonforfeiture value.',
    `form_1099r_issued_flag` BOOLEAN COMMENT 'Indicates whether IRS Form 1099-R was issued for this surrender transaction.',
    `insured_age_at_election` STRING COMMENT 'Attained age of the insured at the time of nonforfeiture option election, used in benefit calculations.',
    `lapse_date` DATE COMMENT 'Date on which the original policy lapsed, triggering the nonforfeiture option election.',
    `net_nonforfeiture_value` DECIMAL(18,2) COMMENT 'Net value available for nonforfeiture benefit after deducting outstanding loans and any applicable charges from CSV.',
    `option_status` STRING COMMENT 'Current lifecycle status of the nonforfeiture option: elected (pending activation), active (in force), expired (ETI term ended), terminated (policy reinstated or surrendered), converted (changed to another option).. Valid values are `elected|active|expired|terminated|converted`',
    `option_type` STRING COMMENT 'Type of nonforfeiture benefit elected: Extended Term Insurance (ETI), Reduced Paid-Up (RPU), cash surrender, or Automatic Premium Loan (APL).. Valid values are `extended_term_insurance|reduced_paid_up|cash_surrender|automatic_premium_loan`',
    `outstanding_loan_balance` DECIMAL(18,2) COMMENT 'Outstanding policy loan balance at the time of election, deducted from CSV to determine net nonforfeiture value.',
    `policy_number` STRING COMMENT 'Human-readable policy number for business reference and reporting.',
    `policy_year_at_election` STRING COMMENT 'Policy year (duration since issue) at the time of nonforfeiture option election.',
    `rpu_cash_value` DECIMAL(18,2) COMMENT 'Cash value of the Reduced Paid-Up policy at the time of conversion, typically equal to the net nonforfeiture value.',
    `rpu_face_amount` DECIMAL(18,2) COMMENT 'Reduced death benefit face amount for Reduced Paid-Up insurance option, calculated based on the net nonforfeiture value and attained age.',
    `source_system_code` STRING COMMENT 'Code identifying the source policy administration system from which this nonforfeiture option record originated (e.g., FAST, EXL, Sapiens LifePro).',
    `source_transaction_code` STRING COMMENT 'Transaction identifier from the source system that created or modified this nonforfeiture option record.',
    `surrender_charge_amount` DECIMAL(18,2) COMMENT 'Surrender charge deducted from gross surrender value, if applicable based on policy duration and contract terms.',
    `surrender_gross_amount` DECIMAL(18,2) COMMENT 'Gross cash surrender amount before deductions for loans, surrender charges, or tax withholding.',
    `surrender_net_proceeds` DECIMAL(18,2) COMMENT 'Net cash proceeds paid to the policyholder after all deductions (loans, surrender charges, tax withholding).',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'Federal and/or state income tax withholding amount deducted from surrender proceeds, if applicable.',
    `taxable_gain_amount` DECIMAL(18,2) COMMENT 'Taxable gain on surrender calculated as gross surrender amount minus cost basis, reportable on IRS Form 1099-R.',
    `termination_date` DATE COMMENT 'Date on which the nonforfeiture option terminated, either due to expiry, reinstatement, or full surrender.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this nonforfeiture option record was last updated in the system.',
    CONSTRAINT pk_nonforfeiture_option PRIMARY KEY(`nonforfeiture_option_id`)
) COMMENT 'Tracks nonforfeiture benefit elections and calculations when a permanent life insurance policy lapses — Extended Term Insurance (ETI), Reduced Paid-Up (RPU), and cash surrender. Captures elected option, effective date, and calculated benefit values.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`conversion` (
    `conversion_id` BIGINT COMMENT 'Unique identifier for the policy conversion transaction. Primary key for the policy conversion record.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the original term life policy being converted. Links to the source policy record in the in-force policy table.',
    `conversion_new_policy_in_force_policy_id` BIGINT COMMENT 'Reference to the newly issued permanent policy resulting from the conversion. Links to the target policy record in the in-force policy table.',
    `producer_id` BIGINT COMMENT 'Reference to the internal user or system agent who processed the conversion transaction. Used for audit and workflow tracking.',
    `conversion_producer_id` BIGINT COMMENT 'Reference to the agent or producer who facilitated the conversion. Links to the producer record in the agent management system.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who approved the conversion. Used for audit trail and accountability tracking.',
    `pricing_basis_id` BIGINT COMMENT 'Foreign key linking to actuarial.pricing_basis. Business justification: Policy conversions require pricing basis to calculate new premium rates, face amounts, and underwriting class adjustments. Underwriting teams reference pricing basis for conversion privilege calculati',
    `original_conversion_id` BIGINT COMMENT 'Self-referencing FK on conversion (original_conversion_id)',
    `approval_date` DATE COMMENT 'Date when the conversion request was approved by underwriting or policy services. Indicates when the conversion was authorized to proceed.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether managerial or underwriting approval is required for this conversion. True if the conversion requires special authorization beyond standard processing.',
    `attained_age_at_conversion` STRING COMMENT 'The insureds age at the time of conversion. Used for underwriting and pricing calculations for the new permanent policy.',
    `basis` STRING COMMENT 'The age basis used for pricing the new permanent policy. Determines whether the new policy is priced at the insureds current attained age or original issue age.. Valid values are `attained_age|original_age|issue_age`',
    `channel` STRING COMMENT 'The distribution channel through which the conversion request was initiated. Indicates how the policyholder submitted the conversion request.. Valid values are `agent|direct|online|call_center|broker`',
    `comments` STRING COMMENT 'Free-form text field for additional notes, special instructions, or context related to the conversion transaction. Used for documenting unique circumstances or processing notes.',
    `completion_date` DATE COMMENT 'Date when the conversion transaction was fully completed and the new policy was issued. Marks the end of the conversion lifecycle.',
    `conversion_number` STRING COMMENT 'Unique business transaction number assigned to this conversion event. Used for tracking and reference in policy administration systems.',
    `conversion_status` STRING COMMENT 'Current lifecycle status of the conversion transaction. Tracks the conversion through its workflow from initial request to final completion. [ENUM-REF-CANDIDATE: pending|approved|in_progress|completed|cancelled|rejected|suspended — 7 candidates stripped; promote to reference product]',
    `conversion_type` STRING COMMENT 'Classification of the conversion based on the contractual provision being exercised. Indicates whether this is a standard contractual right or a special conversion offer.. Valid values are `contractual_privilege|guaranteed_conversion|optional_conversion|special_conversion`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this conversion record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Any credit or value transferred from the original term policy to the new permanent policy. May include accumulated dividends, paid-up additions, or other policy values.',
    `effective_date` DATE COMMENT 'Date when the conversion becomes effective and the new permanent policy is in force. The original term policy terminates on this date.',
    `evidence_of_insurability_required_flag` BOOLEAN COMMENT 'Indicates whether medical evidence of insurability is required for the conversion. True if underwriting evidence is needed; false if conversion is guaranteed without evidence.',
    `evidence_of_insurability_waived_flag` BOOLEAN COMMENT 'Indicates whether the evidence of insurability requirement was waived for this conversion. True if the conversion privilege allows conversion without medical underwriting.',
    `new_face_amount` DECIMAL(18,2) COMMENT 'Death benefit face amount of the newly issued permanent policy. May differ from the original face amount based on conversion terms and policyholder election.',
    `new_modal_premium` DECIMAL(18,2) COMMENT 'The premium amount for the new permanent policy based on the selected payment frequency. Represents the recurring premium obligation for the converted policy.',
    `new_policy_number` STRING COMMENT 'The policy number of the newly issued permanent policy. Business identifier for the converted policy.',
    `new_premium_mode` STRING COMMENT 'The payment frequency selected for the new permanent policy. Indicates how often premiums will be paid on the converted policy.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `new_product_type` STRING COMMENT 'Type of permanent life insurance product resulting from the conversion. Identifies the specific permanent product category of the target policy.. Valid values are `whole_life|universal_life|variable_universal_life|indexed_universal_life|variable_life`',
    `new_table_rating` STRING COMMENT 'Any table rating or substandard rating applied to the new permanent policy. Expressed as a percentage or table letter indicating additional mortality risk.',
    `new_underwriting_class` STRING COMMENT 'The underwriting risk class assigned to the new permanent policy. Determines the premium rate structure for the converted policy.. Valid values are `preferred_plus|preferred|standard_plus|standard|substandard|rated`',
    `nigo_flag` BOOLEAN COMMENT 'Indicates whether the conversion application was flagged as Not In Good Order due to missing or incomplete information. True if the application requires additional documentation or corrections.',
    `nigo_reason_code` STRING COMMENT 'Code indicating the specific reason the conversion application was flagged as Not In Good Order. Used for tracking application quality and processing efficiency.',
    `original_face_amount` DECIMAL(18,2) COMMENT 'Death benefit face amount of the original term policy at the time of conversion. Represents the coverage amount being converted.',
    `original_issue_age` STRING COMMENT 'The insureds age when the original term policy was issued. May be used for pricing if the conversion is on an original-age basis.',
    `original_policy_number` STRING COMMENT 'The policy number of the original term life policy being converted. Business identifier for the source policy.',
    `original_product_type` STRING COMMENT 'Type of term life insurance product being converted. Identifies the specific term product category of the source policy.. Valid values are `term|yrt|level_term|decreasing_term|increasing_term`',
    `privilege_expiry_date` DATE COMMENT 'The last date on which the policyholder can exercise the conversion privilege under the original term policy. After this date, the conversion right expires.',
    `processing_duration_days` STRING COMMENT 'Number of days from conversion request to completion. Used for service level agreement monitoring and process efficiency analysis.',
    `reason_code` STRING COMMENT 'Code indicating the reason or motivation for the conversion. Used for tracking conversion patterns and policyholder behavior analysis.',
    `rejection_reason_code` STRING COMMENT 'Code indicating the reason for conversion rejection if the request was denied. Used for tracking denial patterns and compliance reporting.',
    `rejection_reason_description` STRING COMMENT 'Detailed explanation of why the conversion request was rejected. Provides context for the rejection decision and supports customer communication.',
    `request_date` DATE COMMENT 'Date when the policyholder submitted the conversion request. Marks the beginning of the conversion transaction lifecycle.',
    `source_system_code` STRING COMMENT 'Code identifying the source policy administration system from which the conversion record originated. Used for data lineage and system integration tracking.',
    `source_transaction_code` STRING COMMENT 'The unique transaction identifier from the source policy administration system. Used for reconciliation and traceability back to the originating system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this conversion record was last modified. Used for tracking changes and maintaining data currency.',
    CONSTRAINT pk_conversion PRIMARY KEY(`conversion_id`)
) COMMENT 'Tracks term-to-permanent policy conversion transactions where a term life policyholder exercises the contractual conversion privilege. Captures conversion date, original term policy, new permanent policy, conversion basis, and evidence requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`free_look` (
    `free_look_id` BIGINT COMMENT 'Unique identifier for the free look period record. Primary key.',
    `employee_id` BIGINT COMMENT 'User identifier of the manager or supervisor who approved the free look cancellation processing.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the policy for which this free look period applies.',
    `producer_id` BIGINT COMMENT 'Identifier of the agent or service representative who processed the free look cancellation request.',
    `refund_transaction_id` BIGINT COMMENT 'The transaction identifier from the payment system for the refund disbursement.',
    `document_id` BIGINT COMMENT 'Reference to the document management system identifier for the signed free look waiver document.',
    `extended_free_look_id` BIGINT COMMENT 'Self-referencing FK on free_look (extended_free_look_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether managerial approval is required for processing this free look cancellation, typically for high-value policies or unusual circumstances.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the free look cancellation was approved by the authorized user.',
    `cancellation_effective_date` DATE COMMENT 'The date the policy cancellation becomes effective. Typically retroactive to the policy issue date or effective date.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason the policyholder provided for cancelling during the free look period.',
    `cancellation_reason_description` STRING COMMENT 'Free-text description of the reason for free look cancellation, as provided by the policyholder or agent.',
    `cancellation_request_date` DATE COMMENT 'The date the policyholder submitted a request to cancel the policy during the free look period. Null if no cancellation was requested.',
    `cancellation_request_method` STRING COMMENT 'The channel through which the policyholder submitted the free look cancellation request.. Valid values are `mail|email|phone|in_person|fax|online_portal`',
    `comments` STRING COMMENT 'Free-text notes or comments regarding the free look period, cancellation request, or refund processing.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this free look record was first created in the system.',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Any amount deducted from the premium refund for actual policy charges incurred during the free look period, where permitted by state regulation.',
    `deduction_reason` STRING COMMENT 'Explanation of why a deduction was applied to the refund amount, such as cost of insurance charges or administrative fees where permitted.',
    `delivery_confirmation_date` DATE COMMENT 'The date delivery of the policy was confirmed, such as signature date for certified mail or electronic acknowledgment date.',
    `delivery_method` STRING COMMENT 'The method by which the policy was delivered to the policyholder. Affects the calculation of the free look start date in some jurisdictions.. Valid values are `mail|electronic|in_person|certified_mail|courier`',
    `duration_days` STRING COMMENT 'The number of calendar days allowed for the free look period, determined by state regulation and product type. Typically ranges from 10 to 30 days.',
    `end_date` DATE COMMENT 'The date when the free look period expires. Calculated as start_date plus the applicable free look duration.',
    `free_look_status` STRING COMMENT 'Current lifecycle status of the free look period. Active indicates the period is in effect; expired means the period ended without cancellation; cancelled means the policyholder exercised their right to cancel; waived means the policyholder explicitly waived the free look right; pending_cancellation means a cancellation request has been received but not yet processed; completed means all processing including refunds has been finalized.. Valid values are `active|expired|cancelled|waived|pending_cancellation|completed`',
    `jurisdiction_state` STRING COMMENT 'The state or jurisdiction whose free look regulations apply to this policy. Determines the duration and rules for the free look period.',
    `notice_delivery_method` STRING COMMENT 'The method by which the free look notice was delivered to the policyholder.. Valid values are `mail|email|included_with_policy|electronic|certified_mail`',
    `notice_sent_date` DATE COMMENT 'The date the free look notice was sent to the policyholder, informing them of their right to cancel within the free look period.',
    `policy_delivery_date` DATE COMMENT 'The date the policy was delivered to the policyholder. In many jurisdictions, the free look period begins on this date rather than the issue date.',
    `policy_number` STRING COMMENT 'The externally-known policy number for business user reference and reporting.',
    `premium_paid_amount` DECIMAL(18,2) COMMENT 'The total premium amount paid by the policyholder prior to the free look cancellation request.',
    `product_type` STRING COMMENT 'The type of insurance product (e.g., term life, whole life, universal life, annuity). Different product types may have different free look requirements.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The total amount to be refunded to the policyholder upon free look cancellation. Typically includes all premiums paid, though some jurisdictions allow deduction of actual policy charges incurred.',
    `refund_check_number` STRING COMMENT 'The check number if the refund was issued via check.',
    `refund_disbursement_date` DATE COMMENT 'The date the refund was actually disbursed to the policyholder.',
    `refund_method` STRING COMMENT 'The method by which the refund will be or was disbursed to the policyholder.. Valid values are `check|eft|ach|wire_transfer|credit_card_reversal|original_payment_method`',
    `replacement_indicator` BOOLEAN COMMENT 'Indicates whether this policy is a replacement of an existing policy. Replacement policies may have extended free look periods in some jurisdictions.',
    `senior_applicant_flag` BOOLEAN COMMENT 'Indicates whether the applicant is age 65 or older. Some states mandate extended free look periods for senior applicants.',
    `source_system` STRING COMMENT 'The operational system of record from which this free look record originated (e.g., policy administration system, new business system).',
    `source_transaction_code` STRING COMMENT 'The transaction identifier in the source system that created or modified this free look record.',
    `start_date` DATE COMMENT 'The date when the free look period begins, typically the policy delivery date or issue date depending on state regulation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this free look record was last modified.',
    `waiver_date` DATE COMMENT 'The date the policyholder signed a waiver of their free look cancellation right, if applicable.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the policyholder explicitly waived their free look cancellation right. True if waived, False otherwise.',
    CONSTRAINT pk_free_look PRIMARY KEY(`free_look_id`)
) COMMENT 'Tracks free look period management for newly issued policies. Captures free look start/end dates, state-specific free look duration, cancellation requests received during free look, and premium refund processing.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`incontestability` (
    `incontestability_id` BIGINT COMMENT 'Unique identifier for the incontestability period tracking record. Primary key for this entity.',
    `billing_reinstatement_id` BIGINT COMMENT 'Reference to the policy reinstatement record that triggered this incontestability period, if applicable. Null for original issue periods.',
    `in_force_policy_id` BIGINT COMMENT 'Reference to the life insurance or annuity policy for which incontestability period is being tracked.',
    `reinstated_incontestability_id` BIGINT COMMENT 'Self-referencing FK on incontestability (reinstated_incontestability_id)',
    `adjusted_period_end_date` DATE COMMENT 'The recalculated end date of the incontestability period after accounting for all tolling events. This is the operational date used to determine when the policy becomes incontestable.',
    `aps_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an Attending Physician Statement was required during the underwriting process. True if APS was required; false otherwise. Relevant for contest investigations.',
    `comments` STRING COMMENT 'Free-form text field for additional notes, special circumstances, or administrative comments related to the incontestability period tracking.',
    `contest_action_initiated_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the insurer has formally initiated a contest action to rescind or modify the policy based on material misrepresentation. True if contest action has been initiated; false otherwise.',
    `contest_initiation_date` DATE COMMENT 'The date when the insurer formally initiated a contest action. Must occur before the adjusted period end date to be valid. Null if no contest action has been initiated.',
    `contest_outcome` STRING COMMENT 'The final outcome or current status of the contest action. Rescission approved means the policy was successfully rescinded; rescission denied means the contest was unsuccessful and the policy remains in force; settlement reached indicates a negotiated resolution; withdrawn means the insurer abandoned the contest; litigation indicates the matter is in court.. Valid values are `pending|rescission_approved|rescission_denied|settlement_reached|withdrawn|litigation`',
    `contest_reason_code` STRING COMMENT 'The primary reason code for the contest action. Material misrepresentation is the most common basis for contesting a policy during the incontestability period.. Valid values are `material_misrepresentation|fraud|concealment|non_disclosure|other`',
    `contest_reason_description` STRING COMMENT 'Detailed narrative description of the specific facts and circumstances that form the basis for the contest action. May include references to application questions, medical history, or other underwriting information.',
    `contest_resolution_date` DATE COMMENT 'The date when the contest action was finally resolved, either through rescission, denial, settlement, or withdrawal. Null if contest is still pending.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this incontestability record was first created in the data platform.',
    `insured_age_at_issue` STRING COMMENT 'The age of the insured at the time the policy was issued or reinstated. Relevant for underwriting review and contest analysis.',
    `jurisdiction_state` STRING COMMENT 'The two-letter state or jurisdiction code where the policy was issued and whose incontestability laws govern this period. Incontestability rules vary by state.',
    `mib_check_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a Medical Information Bureau check was completed during underwriting. True if MIB check was performed; false otherwise. Relevant for identifying potential undisclosed medical history.',
    `notification_sent_date` DATE COMMENT 'The date when the period completion notification was sent. Null if no notification was sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a notification was sent to the policyholder or agent when the incontestability period completed. True if notification was sent; false otherwise.',
    `period_end_date` DATE COMMENT 'The date when the incontestability period ends, typically two years from the period start date plus any tolling adjustments. After this date, the insurer generally cannot contest the policy for material misrepresentation.',
    `period_start_date` DATE COMMENT 'The date when the incontestability period begins, typically the policy issue date or reinstatement effective date. This is the anchor date from which the two-year period is calculated.',
    `period_status` STRING COMMENT 'Current lifecycle status of the incontestability period. Active indicates the two-year period is running; completed indicates the period has ended and the policy is now incontestable; tolled indicates the period is paused due to a tolling event; waived indicates the insurer has voluntarily waived contestability rights; contested indicates the insurer has initiated a contest action; expired indicates the period ended without contest.. Valid values are `active|completed|tolled|waived|contested|expired`',
    `policy_issue_date` DATE COMMENT 'The original issue date of the policy, included for reference and to distinguish original issue periods from reinstatement periods.',
    `policy_number` STRING COMMENT 'The externally-known policy contract number for business user reference and cross-system reconciliation.',
    `reinstatement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this incontestability period record is associated with a policy reinstatement. True if the period started due to reinstatement; false if it is the original issue period.',
    `source_system` STRING COMMENT 'The code or name of the source system that originated this incontestability record (e.g., FAST, Sapiens LifePro, Oracle Insurance Policy Administration).',
    `source_system_record_code` STRING COMMENT 'The unique identifier for this incontestability record in the source system, used for data lineage and reconciliation.',
    `statutory_period_length_days` STRING COMMENT 'The statutory length of the incontestability period in days as mandated by the jurisdiction of issue, typically 730 days (two years). May vary by state or product type.',
    `suicide_exclusion_end_date` DATE COMMENT 'The date when the suicide exclusion period ends, after which death by suicide is covered under the policy. Typically runs concurrently with the incontestability period but may have different tolling rules.',
    `suicide_exclusion_period_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the suicide exclusion period (typically also two years) is being tracked in parallel with the incontestability period. True if suicide exclusion applies; false otherwise.',
    `tolling_end_date` DATE COMMENT 'The date when the tolling event ended and the incontestability period clock resumed. Null if tolling is still active or no tolling event occurred.',
    `tolling_event_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a tolling event has occurred that pauses or extends the incontestability period. True if one or more tolling events have been recorded; false otherwise.',
    `tolling_event_type` STRING COMMENT 'The type of event that caused the incontestability period to be tolled or paused. Common tolling events include fraud investigations, pending litigation, insured absence from jurisdiction, or regulatory holds.. Valid values are `fraud_investigation|litigation|insured_absence|regulatory_hold|other`',
    `tolling_start_date` DATE COMMENT 'The date when the tolling event began, pausing the incontestability period clock. Null if no tolling event has occurred.',
    `total_tolling_days` STRING COMMENT 'The cumulative number of days the incontestability period has been tolled across all tolling events. This extends the effective period end date.',
    `underwriting_class` STRING COMMENT 'The underwriting risk class assigned at issue or reinstatement (e.g., preferred, standard, substandard). Relevant for assessing the materiality of any misrepresentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this incontestability record was last modified in the data platform.',
    `waiver_approved_by` STRING COMMENT 'The user ID or name of the authorized individual who approved the contestability waiver. Null if no waiver was granted.',
    `waiver_date` DATE COMMENT 'The date when the insurer formally waived its contestability rights. Null if no waiver was granted.',
    `waiver_reason_code` STRING COMMENT 'The reason code if the insurer voluntarily waived its contestability rights before the period expired. Null if no waiver was granted.. Valid values are `business_decision|settlement|goodwill|regulatory_requirement|other`',
    CONSTRAINT pk_incontestability PRIMARY KEY(`incontestability_id`)
) COMMENT 'Tracks the incontestability period status for each policy — the two-year period after issue during which the insurer can contest the policy for material misrepresentation. Captures period start/end dates and any tolling events.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`rider` (
    `rider_id` BIGINT COMMENT 'Primary key for rider',
    CONSTRAINT pk_rider PRIMARY KEY(`rider_id`)
) COMMENT 'This association product represents the attachment of a rider definition to an in-force policy contract. It captures the specific terms, coverage amounts, premiums, and status for each rider instance on a policy. Each record links one in_force_policy to one rider_definition with attributes that exist only in the context of this specific rider attachment (effective date, face amount, premium, status, underwriting class, rating).. Existence Justification: In life insurance operations, a single policy contract can have multiple riders attached simultaneously (e.g., ADB + waiver of premium + LTC acceleration), and a single rider definition from the product catalog is used across thousands of in-force policies. Each rider attachment has its own coverage terms, premium, effective date, status, and underwriting classification that belong to the specific policy-rider combination, not to the policy alone or the rider definition alone. Policy administration systems actively manage these rider attachments throughout the policy lifecycle.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` (
    `guaranteed_benefit_allocation_id` BIGINT COMMENT 'Unique system identifier for this guaranteed benefit allocation record. Primary key.',
    `policy_rider_id` BIGINT COMMENT 'Foreign key linking to the rider with guaranteed benefits (GMWB, GMDB, GMIB, GMAB) that requires allocation tracking',
    `separate_account_id` BIGINT COMMENT 'Foreign key linking to the separate account that supports this portion of the guaranteed benefit',
    `actuarial_reserve_amount` DECIMAL(18,2) COMMENT 'Actuarial reserve held for this specific allocation, calculated based on allocated benefit base and separate account performance. Used for financial statement preparation and statutory reserve requirements.',
    `allocated_benefit_base_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the riders benefit base allocated to this separate account. Calculated as rider.benefit_base_amount * allocation_percentage. Used for actuarial reserve calculations.',
    `allocation_effective_date` DATE COMMENT 'Date when this allocation became effective. Critical for tracking allocation changes over time and aligning with hedge rebalancing events.',
    `allocation_end_date` DATE COMMENT 'Date when this allocation was terminated or rebalanced. Null for currently active allocations. Used for historical allocation analysis.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the riders benefit base allocated to this specific separate account. Must sum to 100% across all allocations for a given rider. Used for proportional hedge calculations.',
    `allocation_status` STRING COMMENT 'Current status of this allocation. Values: Active (allocation is in force), Suspended (temporarily inactive), Terminated (allocation ended), Pending_Rebalance (rebalancing in progress). Used for operational workflow management.',
    `benefit_base_amount` DECIMAL(18,2) COMMENT 'The guaranteed benefit base used to calculate income or withdrawal benefits for living benefit riders (GMIB, GMWB, GMAB). This base may grow over time based on rider terms. Expressed in policy currency. [Moved from rider: While the total benefit_base_amount remains on the rider, the allocated_benefit_base_amount for each separate account belongs to the allocation relationship. The rider attribute represents the total, while the allocation attribute represents the portion allocated to each account.]',
    `benefit_base_growth_rate` DECIMAL(18,2) COMMENT 'The annual percentage rate at which the benefit base grows for living benefit riders. Expressed as a percentage (e.g., 5.00 means 5% per year). Null if benefit base does not grow. [Moved from rider: Growth rate may vary by separate account allocation based on account performance and guarantee terms. If different accounts have different growth rates for the same rider, this becomes allocation-specific rather than rider-level.]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this allocation record was created. Used for audit trail and allocation history tracking.',
    `hedge_designation` STRING COMMENT 'Indicates whether this allocation is part of a hedging strategy. Values: Hedged (allocation is hedged with derivatives), Unhedged (allocation carries full market risk), Partially_Hedged (partial hedge coverage). Critical for risk management and GAAP hedge accounting.',
    `hedge_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Percentage of market risk hedged for this allocation. 100% for fully hedged, 0% for unhedged. Used for risk reporting and hedge effectiveness testing under ASC 815.',
    `last_rebalance_date` DATE COMMENT 'Date of the most recent rebalancing event for this allocation. Used to track rebalancing frequency and compliance with allocation policies.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this allocation record was last modified. Used for change tracking and audit compliance.',
    `rebalance_trigger_threshold` DECIMAL(18,2) COMMENT 'Percentage deviation threshold that triggers automatic rebalancing of this allocation. Example: 5.00 means rebalance when allocation drifts 5% from target. Used for automated allocation management.',
    CONSTRAINT pk_guaranteed_benefit_allocation PRIMARY KEY(`guaranteed_benefit_allocation_id`)
) COMMENT 'This association product represents the allocation relationship between variable annuity/VUL riders with guaranteed benefits (GMWB, GMDB, GMIB, GMAB) and the separate accounts that support those guarantees. It captures how a riders benefit base is distributed across multiple investment accounts for hedge management and actuarial valuation. Each record links one rider to one separate account with allocation-specific attributes that exist only in the context of this relationship.. Existence Justification: In life insurance operations, variable annuity and VUL riders with guaranteed benefits (GMWB, GMDB, GMIB, GMAB) require their benefit bases to be allocated across multiple separate accounts for hedge management, risk diversification, and actuarial valuation. A single rider can have its benefit base split across multiple separate accounts (e.g., 40% equity account, 30% bond account, 30% balanced account), and each separate account supports guaranteed benefits from multiple riders across different policies. The business actively manages these allocations through rebalancing, hedge designation, and reserve calculations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ADD CONSTRAINT `fk_policy_value_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ADD CONSTRAINT `fk_policy_policy_rider_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ADD CONSTRAINT `fk_policy_policy_rider_rider_id` FOREIGN KEY (`rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`rider`(`rider_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ADD CONSTRAINT `fk_policy_status_history_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ADD CONSTRAINT `fk_policy_policy_beneficiary_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ADD CONSTRAINT `fk_policy_policy_beneficiary_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `life_insurance_ecm`.`policy`.`service_request`(`service_request_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ADD CONSTRAINT `fk_policy_owner_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ADD CONSTRAINT `fk_policy_policy_reinstatement_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ADD CONSTRAINT `fk_policy_surrender_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ADD CONSTRAINT `fk_policy_loan_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ADD CONSTRAINT `fk_policy_dividend_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ADD CONSTRAINT `fk_policy_tax_compliance_test_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ADD CONSTRAINT `fk_policy_fund_allocation_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ADD CONSTRAINT `fk_policy_assignment_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ADD CONSTRAINT `fk_policy_service_request_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ADD CONSTRAINT `fk_policy_note_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ADD CONSTRAINT `fk_policy_note_reply_to_note_id` FOREIGN KEY (`reply_to_note_id`) REFERENCES `life_insurance_ecm`.`policy`.`note`(`note_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ADD CONSTRAINT `fk_policy_nonforfeiture_option_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ADD CONSTRAINT `fk_policy_nonforfeiture_option_superseded_nonforfeiture_option_id` FOREIGN KEY (`superseded_nonforfeiture_option_id`) REFERENCES `life_insurance_ecm`.`policy`.`nonforfeiture_option`(`nonforfeiture_option_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_conversion_new_policy_in_force_policy_id` FOREIGN KEY (`conversion_new_policy_in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ADD CONSTRAINT `fk_policy_conversion_original_conversion_id` FOREIGN KEY (`original_conversion_id`) REFERENCES `life_insurance_ecm`.`policy`.`conversion`(`conversion_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ADD CONSTRAINT `fk_policy_free_look_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ADD CONSTRAINT `fk_policy_free_look_extended_free_look_id` FOREIGN KEY (`extended_free_look_id`) REFERENCES `life_insurance_ecm`.`policy`.`free_look`(`free_look_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ADD CONSTRAINT `fk_policy_incontestability_in_force_policy_id` FOREIGN KEY (`in_force_policy_id`) REFERENCES `life_insurance_ecm`.`policy`.`in_force_policy`(`in_force_policy_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ADD CONSTRAINT `fk_policy_incontestability_reinstated_incontestability_id` FOREIGN KEY (`reinstated_incontestability_id`) REFERENCES `life_insurance_ecm`.`policy`.`incontestability`(`incontestability_id`);
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ADD CONSTRAINT `fk_policy_guaranteed_benefit_allocation_policy_rider_id` FOREIGN KEY (`policy_rider_id`) REFERENCES `life_insurance_ecm`.`policy`.`policy_rider`(`policy_rider_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`policy` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`policy` SET TAGS ('dbx_domain' = 'policy');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'In-Force Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Writing Agent Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `account_value` SET TAGS ('dbx_business_glossary_term' = 'Account Value (AV)');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `csv_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `death_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `death_benefit_option` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) Option');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `death_benefit_option` SET TAGS ('dbx_value_regex' = 'OPTION_A|OPTION_B|OPTION_C|LEVEL|INCREASING|ROP');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `gpt_cvat_election` SET TAGS ('dbx_business_glossary_term' = 'Guideline Premium Test (GPT) or Cash Value Accumulation Test (CVAT) Election');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `gpt_cvat_election` SET TAGS ('dbx_value_regex' = 'GPT|CVAT');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `insured_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `irc_7702_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `issue_age` SET TAGS ('dbx_business_glossary_term' = 'Issue Age');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Maturity Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `mec_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Status Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `modal_premium` SET TAGS ('dbx_business_glossary_term' = 'Modal Premium');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Paid-To Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_currency` SET TAGS ('dbx_business_glossary_term' = 'Policy Currency');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_form_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_form_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_loan_balance` SET TAGS ('dbx_business_glossary_term' = 'Policy Loan Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `premium_mode` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Mode');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `premium_mode` SET TAGS ('dbx_value_regex' = 'MONTHLY|QUARTERLY|SEMI_ANNUAL|ANNUAL|SINGLE');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `reinsurance_cession_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Cession Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `risk_class` SET TAGS ('dbx_business_glossary_term' = 'Risk Class');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `risk_class` SET TAGS ('dbx_value_regex' = 'PREFERRED_PLUS|PREFERRED|STANDARD_PLUS|STANDARD|SUBSTANDARD|RATED');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `table_rating` SET TAGS ('dbx_business_glossary_term' = 'Table Rating');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `table_rating` SET TAGS ('dbx_value_regex' = '^[A-P]$|^[1-9][0-9]{0,2}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `tax_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Qualification Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Termination Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`policy`.`in_force_policy` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_value_regex' = 'FULLY_UNDERWRITTEN|SIMPLIFIED_ISSUE|GUARANTEED_ISSUE|NON_MEDICAL');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `value_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Value Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `accumulated_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Premium Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `admin_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Administrative Fee Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `av_amount` SET TAGS ('dbx_business_glossary_term' = 'Account Value (AV) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `coi_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Insurance (COI) Charge Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `csv_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `cvat_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Accumulation Test (CVAT) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `dac_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Balance Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `death_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `dividend_accumulation_balance` SET TAGS ('dbx_business_glossary_term' = 'Dividend Accumulation Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `fund_allocation_total` SET TAGS ('dbx_business_glossary_term' = 'Policy Fund Allocation Total');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `gpt_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Guideline Premium Test (GPT) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `guaranteed_minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `index_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Index Credit Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `interest_credited_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Credited Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `last_premium_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Premium Payment Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `loan_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Loan Balance Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `loan_interest_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Loan Interest Accrued Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `mec_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Status Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `nar_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount at Risk (NAR) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `paid_up_additions_value` SET TAGS ('dbx_business_glossary_term' = 'Paid-Up Additions Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `policy_anniversary_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Anniversary Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `premium_load_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Load Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `premium_ytd_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Year-to-Date (YTD) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `rider_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Rider Charge Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `surrender_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surrender Charge Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `surrender_charge_end_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Charge Period End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `valuation_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Basis Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `valuation_basis_code` SET TAGS ('dbx_value_regex' = 'STAT|GAAP|IFRS|TAX');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`value` ALTER COLUMN `withdrawal_ytd_amount` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Year-to-Date (YTD) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `policy_rider_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `reinsurance_treaty_id` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `rider_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Rider Instance Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `acord_form_number` SET TAGS ('dbx_business_glossary_term' = 'ACORD Form Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `acord_form_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `attained_age` SET TAGS ('dbx_business_glossary_term' = 'Attained Age');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `benefit_period_months` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period (Months)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `benefit_trigger_condition` SET TAGS ('dbx_business_glossary_term' = 'Benefit Trigger Condition');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `cash_value` SET TAGS ('dbx_business_glossary_term' = 'Rider Cash Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `cost_of_insurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Cost of Insurance (COI) Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rider Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `elimination_period_days` SET TAGS ('dbx_business_glossary_term' = 'Elimination Period (Days)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rider Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `face_amount` SET TAGS ('dbx_business_glossary_term' = 'Rider Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `guaranteed_insurability_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Insurability Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `issue_age` SET TAGS ('dbx_business_glossary_term' = 'Issue Age');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `loan_outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Rider Loan Outstanding Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Rider Premium Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rider Premium Frequency');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|single');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `premium_mode` SET TAGS ('dbx_business_glossary_term' = 'Rider Premium Mode');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `premium_mode` SET TAGS ('dbx_value_regex' = 'level|increasing|decreasing|flexible');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `rating_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rating Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `reinsurance_ceded_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Ceded Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `rider_status` SET TAGS ('dbx_business_glossary_term' = 'Rider Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `rider_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|lapsed|pending|matured');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `state_of_issue` SET TAGS ('dbx_business_glossary_term' = 'State of Issue');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `state_of_issue` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `surrender_charge` SET TAGS ('dbx_business_glossary_term' = 'Rider Surrender Charge');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `tax_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Qualified Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Rider Termination Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_value_regex' = 'preferred|standard|substandard|declined');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rider Version');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.]{1,10}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `waiver_of_premium_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Premium Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_rider` ALTER COLUMN `withdrawal_percentage` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Status History ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Transition Triggered By User ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_cancellation_request_date` SET TAGS ('dbx_business_glossary_term' = 'Free-Look Cancellation Request Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Free-Look Period End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Free-Look Period Start Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Free-Look Refund Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_refund_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Free-Look Refund Disbursement Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_refund_method` SET TAGS ('dbx_business_glossary_term' = 'Free-Look Refund Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `free_look_refund_method` SET TAGS ('dbx_value_regex' = 'check|eft|wire_transfer|credit_card_reversal|ach|original_payment_method');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `grace_period_length_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Length in Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `grace_period_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Notice Sent Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `grace_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Start Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_value_regex' = 'active|expired|cured|waived');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `lapse_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Lapse Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Policy Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `overdue_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Premium Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `prior_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Policy Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Processed Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `reinstatement_eligibility_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Eligibility Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reversal Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reversal Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reversal Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `source_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `source_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `state_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transition Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transition Approved Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Reason Description');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_triggered_by_system` SET TAGS ('dbx_business_glossary_term' = 'Transition Triggered By System');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_triggered_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Transition Triggered By User Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_triggered_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`status_history` ALTER COLUMN `transition_triggered_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `policy_beneficiary_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Beneficiary Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Change Request Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 1');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address Line 2');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `beneficiary_type` SET TAGS ('dbx_value_regex' = 'primary|contingent|tertiary|irrevocable|final');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary City');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Country Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Date of Birth (DOB)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `designation_amount` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `designation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `designation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `designation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `designation_status` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Designation Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `designation_status` SET TAGS ('dbx_value_regex' = 'active|superseded|deceased|removed|pending');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Email Address');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Entity Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary First Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Full Legal Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Guardian or Custodian Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `guardian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_business_glossary_term' = 'Guardian Relationship to Minor');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_value_regex' = 'parent|legal_guardian|custodian|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `is_minor` SET TAGS ('dbx_business_glossary_term' = 'Is Minor Beneficiary Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `is_revocable` SET TAGS ('dbx_business_glossary_term' = 'Is Revocable Beneficiary Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Last Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Middle Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `per_stirpes_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Stirpes Distribution Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Phone Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Postal Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Sequence Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `settlement_option` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Settlement Option');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `settlement_option` SET TAGS ('dbx_value_regex' = 'lump_sum|installment|life_income|interest_only|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Social Security Number (SSN)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary State or Province');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name Suffix');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Taxpayer Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `trust_date_established` SET TAGS ('dbx_business_glossary_term' = 'Trust Date Established');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `trust_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `trustee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `trustee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_beneficiary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Assignee Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `owner_party_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `owner_poa_party_id` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Party Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Change Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `party_address_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Address Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `party_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `party_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `absolute_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Absolute Assignment Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `collateral_assignment_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Assignment Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `collateral_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Assignment Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `collateral_assignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Assignment Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Owner Consent Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `insurable_interest_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurable Interest Verified Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `notice_preference` SET TAGS ('dbx_business_glossary_term' = 'Owner Notice Preference');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `notice_preference` SET TAGS ('dbx_value_regex' = 'mail|email|portal|agent');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_source_system` SET TAGS ('dbx_business_glossary_term' = 'Ownership Source System');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Ownership Source System Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'active|terminated|suspended|pending');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_transfer_reason` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_transfer_reason` SET TAGS ('dbx_value_regex' = 'sale|gift|divorce|death|trust_transfer|1035_exchange');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'individual|joint|trust|corporation|partnership|ilit');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `power_of_attorney_flag` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_business_glossary_term' = 'Owner Relationship to Insured');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending|not_screened');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `tax_reporting_owner_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Owner Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Ownership Termination Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `tin` SET TAGS ('dbx_business_glossary_term' = 'Owner Taxpayer Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `tin` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`owner` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `policy_reinstatement_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Reinstatement Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `lapse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lapse Event Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `adverse_action_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Action Notice Sent Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `amount_collected` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Amount Collected');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `application_channel` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Application Channel');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `application_channel` SET TAGS ('dbx_value_regex' = 'agent|direct_mail|online|phone|branch');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Application Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Application Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `aps_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `back_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Back Premium Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `back_premium_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Back Premium Interest Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `contestable_period_restart_flag` SET TAGS ('dbx_business_glossary_term' = 'Contestable Period Restart Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `csv_at_lapse_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) at Lapse Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Denial Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `denial_reason_code` SET TAGS ('dbx_value_regex' = 'health_decline|non_payment|fraud|misrepresentation|outside_window|incomplete_application');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `denial_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Denial Reason Description');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `evidence_of_insurability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Fee Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Health Statement Attestation Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_attestation_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_attestation_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_received_date` SET TAGS ('dbx_business_glossary_term' = 'Health Statement Received Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_received_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_received_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Statement Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `health_statement_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `lapse_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Lapse Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `lapse_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Lapse Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `lapse_reason_code` SET TAGS ('dbx_value_regex' = 'non_payment|insufficient_funds|grace_period_expired|voluntary_surrender|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `loan_balance_at_lapse_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Loan Balance at Lapse Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_value_regex' = 'missing_signature|incomplete_health_statement|insufficient_payment|missing_documents|invalid_information');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Payment Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|eft|credit_card|cash|wire_transfer|money_order');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Payment Received Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `processing_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Processing Duration in Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `reinstatement_status` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `reinstatement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|declined|withdrawn|in_review|incomplete');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `reinstatement_type` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `reinstatement_type` SET TAGS ('dbx_value_regex' = 'automatic|conditional|unconditional|special');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `suicide_exclusion_restart_flag` SET TAGS ('dbx_business_glossary_term' = 'Suicide Exclusion Restart Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Reinstatement Amount Due');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Underwriting Decision');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `underwriting_decision` SET TAGS ('dbx_value_regex' = 'approved_standard|approved_rated|declined|postponed|pending');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `underwriting_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`policy_reinstatement` ALTER COLUMN `window_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Window Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `surrender_id` SET TAGS ('dbx_business_glossary_term' = 'Surrender Transaction ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Approval Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surrender Charge Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `csv_amount_used` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) Amount Used');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'check|eft|wire_transfer|1035_direct_transfer|ach');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `extended_term_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Term Insurance Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `form_1099r_indicator` SET TAGS ('dbx_business_glossary_term' = 'Form 1099-R Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `free_withdrawal_amount` SET TAGS ('dbx_business_glossary_term' = 'Free Withdrawal Amount Utilized');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Surrender Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `mva_amount` SET TAGS ('dbx_business_glossary_term' = 'Market Value Adjustment (MVA) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `naic_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `net_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Net Surrender Proceeds');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `nonforfeiture_election_date` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Election Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `nonforfeiture_option_type` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `nonforfeiture_option_type` SET TAGS ('dbx_value_regex' = 'cash_surrender|extended_term|reduced_paid_up|automatic_premium_loan|none');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Surrender Transaction Notes');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `outstanding_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Policy Loan Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Processing Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Surrender Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'financial_hardship|1035_exchange|annuitization|death|lapse_nonforfeiture|policy_maturity');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `receiving_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Carrier Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `receiving_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `reduced_paid_up_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Reduced Paid-Up Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `reduced_paid_up_status` SET TAGS ('dbx_business_glossary_term' = 'Reduced Paid-Up Policy Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `reduced_paid_up_status` SET TAGS ('dbx_value_regex' = 'active|lapsed|matured|surrendered');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Surrender Request Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `source_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `taxable_gain_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Gain Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Surrender Transaction Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Surrender Transaction Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|disbursed|rejected|reversed');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Surrender Transaction Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'full_surrender|partial_surrender|systematic_withdrawal|extended_term_insurance|reduced_paid_up|automatic_premium_loan');
ALTER TABLE `life_insurance_ecm`.`policy`.`surrender` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `loan_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Loan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Servicer Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `accrued_interest_balance` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `apl_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Premium Loan (APL) Trigger Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Closure Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Loan Closure Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'full_repayment|offset_death_claim|offset_surrender|policy_lapse|loan_forgiveness');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `collateral_csv_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Cash Surrender Value (CSV) Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'check|eft|wire|applied_to_premium|applied_to_loan');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `interest_capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Capitalization Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `interest_crediting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Crediting Frequency');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `interest_crediting_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Loan Interest Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable_moodys|variable_treasury|variable_libor|guaranteed_max');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `last_interest_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interest Posting Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `last_repayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Repayment Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `last_repayment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Repayment Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `loan_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `loan_status` SET TAGS ('dbx_value_regex' = 'active|repaid|foreclosed|offset_at_death|offset_at_surrender|defaulted');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `loan_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `loan_type` SET TAGS ('dbx_value_regex' = 'standard|automatic_premium_loan|systematic_loan|emergency_loan');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `maximum_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Loan Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `mec_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Impact Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `next_scheduled_repayment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Repayment Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `offset_amount_at_claim` SET TAGS ('dbx_business_glossary_term' = 'Offset Amount At Claim');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `offset_amount_at_surrender` SET TAGS ('dbx_business_glossary_term' = 'Offset Amount At Surrender');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `original_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Loan Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Origination Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `outstanding_principal_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `repayment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Repayment Schedule Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `repayment_schedule_type` SET TAGS ('dbx_value_regex' = 'none|monthly|quarterly|annual|custom');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `scheduled_repayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Repayment Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `tax_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Year');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `taxable_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Event Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `to_csv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan To Cash Surrender Value (CSV) Ratio');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `total_outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Total Outstanding Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `total_repayments_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Repayments To Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`loan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `dividend_id` SET TAGS ('dbx_business_glossary_term' = 'Dividend Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `assumption_set_id` SET TAGS ('dbx_business_glossary_term' = 'Assumption Set Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Dividend Processor Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `accumulated_balance` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Dividend Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `accumulated_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Dividend Interest Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `accumulated_interest_ytd` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Dividend Interest Year-to-Date (YTD)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `apportionment_method` SET TAGS ('dbx_business_glossary_term' = 'Dividend Apportionment Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `apportionment_method` SET TAGS ('dbx_value_regex' = 'CONTRIBUTION|THREE_FACTOR|EXPERIENCE|ASSET_SHARE');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `cash_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Payment Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `cash_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Cash Payment Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `cash_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Cash Payment Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `cash_payment_method` SET TAGS ('dbx_value_regex' = 'CHECK|ACH|WIRE|EFT');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Dividend Declaration Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `declared_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Dividend Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `dividend_status` SET TAGS ('dbx_business_glossary_term' = 'Dividend Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `dividend_status` SET TAGS ('dbx_value_regex' = 'DECLARED|PENDING|PAID|APPLIED|FORFEITED|REVERSED');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `expense_factor` SET TAGS ('dbx_business_glossary_term' = 'Expense Factor');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `illustration_flag` SET TAGS ('dbx_business_glossary_term' = 'Illustration Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `interest_factor` SET TAGS ('dbx_business_glossary_term' = 'Interest Factor');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `loan_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Reduction Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `mortality_factor` SET TAGS ('dbx_business_glossary_term' = 'Mortality Factor');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `option_code` SET TAGS ('dbx_business_glossary_term' = 'Dividend Option Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `option_code` SET TAGS ('dbx_value_regex' = 'CASH|PREM_RED|PUA|ACCUM|OYT|LOAN_RED');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `option_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Dividend Option Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `oyt_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'One-Year Term (OYT) Coverage Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `oyt_premium_paid` SET TAGS ('dbx_business_glossary_term' = 'One-Year Term (OYT) Premium Paid');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `premium_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Reduction Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dividend Processing Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `pua_cash_value` SET TAGS ('dbx_business_glossary_term' = 'Paid-Up Additions (PUA) Cash Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `pua_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid-Up Additions (PUA) Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Dividend Reversal Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dividend Reversal Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_value_regex' = 'POLICY_LAPSE|POLICY_RESCISSION|DATA_CORRECTION|CALCULATION_ERROR|OPTION_CHANGE');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `scale_version` SET TAGS ('dbx_business_glossary_term' = 'Dividend Scale Version');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `special_dividend_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Dividend Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `tax_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Year');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Dividend Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `terminal_dividend_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminal Dividend Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`dividend` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Dividend Year');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `tax_compliance_test_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Compliance Test Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Override By User ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `mortality_table_id` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Test Run ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `account_value_at_test` SET TAGS ('dbx_business_glossary_term' = 'Account Value (AV) at Test');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `actuarial_system_source` SET TAGS ('dbx_business_glossary_term' = 'Actuarial System Source');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `cash_value_accumulation_limit` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Accumulation Test (CVAT) Limit');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `cash_value_at_test` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) at Test');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `corridor_test_result` SET TAGS ('dbx_business_glossary_term' = 'Corridor Test Result');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `corridor_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not applicable');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `cumulative_premiums_paid` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Premiums Paid');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `death_benefit_at_test` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) at Test');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `definition_election` SET TAGS ('dbx_business_glossary_term' = 'Definition Election (Guideline Premium Test (GPT) or Cash Value Accumulation Test (CVAT))');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `definition_election` SET TAGS ('dbx_value_regex' = 'GPT|CVAT');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `exchange_1035_flag` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `exchanged_policy_mec_status` SET TAGS ('dbx_business_glossary_term' = 'Exchanged Policy Modified Endowment Contract (MEC) Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `exchanged_policy_mec_status` SET TAGS ('dbx_value_regex' = 'MEC|non-MEC|not applicable');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `form_1099r_reportable` SET TAGS ('dbx_business_glossary_term' = 'Form 1099-R Reportable');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `guideline_level_premium` SET TAGS ('dbx_business_glossary_term' = 'Guideline Level Premium (GLP)');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `guideline_single_premium` SET TAGS ('dbx_business_glossary_term' = 'Guideline Single Premium (GSP)');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `insured_age_at_test` SET TAGS ('dbx_business_glossary_term' = 'Insured Age at Test');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `irs_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Service (IRS) Reporting Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `material_change_date` SET TAGS ('dbx_business_glossary_term' = 'Material Change Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `material_change_event_type` SET TAGS ('dbx_business_glossary_term' = 'Material Change Event Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `material_change_event_type` SET TAGS ('dbx_value_regex' = 'death benefit increase|rider addition|premium increase|policy exchange|none');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `mec_status` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `mec_status` SET TAGS ('dbx_value_regex' = 'MEC|non-MEC');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `policy_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `policy_year_at_test` SET TAGS ('dbx_business_glossary_term' = 'Policy Year at Test');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `prior_mec_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Modified Endowment Contract (MEC) Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `prior_mec_status` SET TAGS ('dbx_value_regex' = 'MEC|non-MEC|not applicable');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `seven_pay_premium_limit` SET TAGS ('dbx_business_glossary_term' = 'Seven-Pay Premium Limit');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Test Calculation Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|overridden');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = '7-pay test|material change test|initial issuance test');
ALTER TABLE `life_insurance_ecm`.`policy`.`tax_compliance_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `fund_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Fund Allocation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `separate_account_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Sep Account Fund Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Approval Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_request_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Request Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Sequence Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_business_glossary_term' = 'Allocation Source');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_source` SET TAGS ('dbx_value_regex' = 'policyholder_election|default_allocation|advisor_recommendation|systematic_program|rebalancing_rule');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Termination Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Termination Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_termination_reason` SET TAGS ('dbx_value_regex' = 'policyholder_change|fund_closure|product_conversion|policy_lapse|systematic_completion|regulatory_restriction');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'premium_allocation|account_value_rebalance|transfer|systematic_rebalance|dollar_cost_averaging');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `dollar_cost_averaging_flag` SET TAGS ('dbx_business_glossary_term' = 'Dollar Cost Averaging (DCA) Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `floor_rate` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `fund_category` SET TAGS ('dbx_business_glossary_term' = 'Fund Category');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `fund_expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Fund Expense Ratio');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `fund_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Fund Risk Rating');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `fund_risk_rating` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `index_segment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Index Segment End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `index_segment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Index Segment Start Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `index_segment_term_years` SET TAGS ('dbx_business_glossary_term' = 'Index Segment Term Years');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `index_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Index Strategy Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `last_rebalance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rebalance Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `maximum_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `minimum_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `mortality_and_expense_risk_charge` SET TAGS ('dbx_business_glossary_term' = 'Mortality and Expense (M&E) Risk Charge');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `next_rebalance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Rebalance Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `participation_rate` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_value_regex' = 'none|monthly|quarterly|semi_annually|annually|on_demand');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`fund_allocation` ALTER COLUMN `spread_rate` SET TAGS ('dbx_business_glossary_term' = 'Spread Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Document Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assigned_amount` SET TAGS ('dbx_business_glossary_term' = 'Assigned Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assigned_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assigned_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assigned_percentage` SET TAGS ('dbx_business_glossary_term' = 'Assigned Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Assignee Address Line 1');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Assignee Address Line 2');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_city` SET TAGS ('dbx_business_glossary_term' = 'Assignee City');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_country` SET TAGS ('dbx_business_glossary_term' = 'Assignee Country Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX|GBR|FRA|DEU');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_email` SET TAGS ('dbx_business_glossary_term' = 'Assignee Email Address');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Assignee Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_phone` SET TAGS ('dbx_business_glossary_term' = 'Assignee Phone Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Assignee Postal Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_state` SET TAGS ('dbx_business_glossary_term' = 'Assignee State or Province');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_tin` SET TAGS ('dbx_business_glossary_term' = 'Assignee Taxpayer Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_type` SET TAGS ('dbx_business_glossary_term' = 'Assignee Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignee_type` SET TAGS ('dbx_value_regex' = 'individual|financial_institution|employer|trust|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|released|foreclosed|pending|cancelled');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'absolute|collateral');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assignment Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `irrevocable_flag` SET TAGS ('dbx_business_glossary_term' = 'Irrevocable Assignment Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `lender_loan_reference` SET TAGS ('dbx_business_glossary_term' = 'Lender Loan Reference Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `lender_loan_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `notarization_date` SET TAGS ('dbx_business_glossary_term' = 'Notarization Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `notary_public_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `premium_payment_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Responsibility');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `premium_payment_responsibility` SET TAGS ('dbx_value_regex' = 'owner|assignee|shared');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Recording Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Release Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Service Request ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `annuity_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Annuity Contract Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `collateral_assignment_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Assignment Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `collateral_assignment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `collateral_assignment_lender_name` SET TAGS ('dbx_business_glossary_term' = 'Collateral Assignment Lender Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `collateral_assignment_lender_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Service Request Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Service Request Completion Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `conversion_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Credit Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `conversion_privilege_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Privilege Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `conversion_source_policy_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Source Policy Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `conversion_source_policy_type` SET TAGS ('dbx_value_regex' = 'yrt|term|whole_life|universal_life|indexed_universal_life|variable_universal_life');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `conversion_target_policy_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Target Policy Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `conversion_target_policy_type` SET TAGS ('dbx_value_regex' = 'whole_life|universal_life|indexed_universal_life|variable_universal_life');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `cost_basis_transferred` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Transferred');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Service Request Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `endorsement_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Endorsement Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `evidence_of_insurability_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability Waived Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `exchange_1035_type` SET TAGS ('dbx_business_glossary_term' = 'IRC Section 1035 Exchange Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `exchange_1035_type` SET TAGS ('dbx_value_regex' = 'life_to_life|annuity_to_annuity|life_to_annuity');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `exchange_amount_transferred` SET TAGS ('dbx_business_glossary_term' = '1035 Exchange Amount Transferred');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `gain_deferred` SET TAGS ('dbx_business_glossary_term' = 'Gain Deferred');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `irs_form_1035_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 1035 Attestation Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `new_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'New Policy Reference Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `new_value` SET TAGS ('dbx_business_glossary_term' = 'New Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `prior_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Service Request Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `reinstatement_evidence_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Evidence Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `reinstatement_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Premium Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Service Request Channel');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Service Request Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Service Request Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Service Request Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Service Request Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Rider Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `source_system_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `surrendering_carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Surrendering Carrier Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `surrendering_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Surrendering Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`service_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Note Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `issue_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Issue Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `reply_to_note_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `author_role` SET TAGS ('dbx_business_glossary_term' = 'Author Role');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled|overdue');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_category` SET TAGS ('dbx_business_glossary_term' = 'Note Category');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_date` SET TAGS ('dbx_business_glossary_term' = 'Note Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_number` SET TAGS ('dbx_business_glossary_term' = 'Note Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_business_glossary_term' = 'Note Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|escalated|archived');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_text` SET TAGS ('dbx_business_glossary_term' = 'Note Text');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_business_glossary_term' = 'Note Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `note_type` SET TAGS ('dbx_value_regex' = 'servicing_note|underwriting_note|compliance_note|agent_note|system_generated|claim_note');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `related_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `related_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `visibility_scope` SET TAGS ('dbx_business_glossary_term' = 'Visibility Scope');
ALTER TABLE `life_insurance_ecm`.`policy`.`note` ALTER COLUMN `visibility_scope` SET TAGS ('dbx_value_regex' = 'internal_only|agent_visible|customer_visible|restricted');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `nonforfeiture_option_id` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `lapse_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lapse Event Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `superseded_nonforfeiture_option_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `csv_at_election` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) at Election');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `default_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Option Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'check|eft|wire_transfer|ach');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `election_channel` SET TAGS ('dbx_business_glossary_term' = 'Election Channel');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `election_channel` SET TAGS ('dbx_value_regex' = 'agent|customer_service|online_portal|mail|automatic');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Election Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `election_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Election Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `eti_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Term Insurance (ETI) Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `eti_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Term Insurance (ETI) Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `eti_term_days` SET TAGS ('dbx_business_glossary_term' = 'Extended Term Insurance (ETI) Term Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `eti_term_years` SET TAGS ('dbx_business_glossary_term' = 'Extended Term Insurance (ETI) Term Years');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `form_1099r_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1099-R Issued Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `insured_age_at_election` SET TAGS ('dbx_business_glossary_term' = 'Insured Age at Election');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `lapse_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Lapse Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `net_nonforfeiture_value` SET TAGS ('dbx_business_glossary_term' = 'Net Nonforfeiture Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `option_status` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `option_status` SET TAGS ('dbx_value_regex' = 'elected|active|expired|terminated|converted');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'extended_term_insurance|reduced_paid_up|cash_surrender|automatic_premium_loan');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `outstanding_loan_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Loan Balance');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `policy_year_at_election` SET TAGS ('dbx_business_glossary_term' = 'Policy Year at Election');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `rpu_cash_value` SET TAGS ('dbx_business_glossary_term' = 'Reduced Paid-Up (RPU) Cash Value');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `rpu_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Reduced Paid-Up (RPU) Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `source_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `surrender_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surrender Charge Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `surrender_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Surrender Gross Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `surrender_net_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Surrender Net Proceeds');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `taxable_gain_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Gain Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`nonforfeiture_option` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Conversion Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Original Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_new_policy_in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'New Policy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_producer_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `original_conversion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Approval Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `attained_age_at_conversion` SET TAGS ('dbx_business_glossary_term' = 'Attained Age at Conversion');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Conversion Basis');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'attained_age|original_age|issue_age');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Conversion Channel');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'agent|direct|online|call_center|broker');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Conversion Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Completion Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_number` SET TAGS ('dbx_business_glossary_term' = 'Conversion Transaction Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_business_glossary_term' = 'Conversion Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `conversion_type` SET TAGS ('dbx_value_regex' = 'contractual_privilege|guaranteed_conversion|optional_conversion|special_conversion');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Credit Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `evidence_of_insurability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `evidence_of_insurability_waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence of Insurability (EOI) Waived Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_face_amount` SET TAGS ('dbx_business_glossary_term' = 'New Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_modal_premium` SET TAGS ('dbx_business_glossary_term' = 'New Modal Premium');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_policy_number` SET TAGS ('dbx_business_glossary_term' = 'New Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_premium_mode` SET TAGS ('dbx_business_glossary_term' = 'New Premium Mode');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_premium_mode` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_product_type` SET TAGS ('dbx_business_glossary_term' = 'New Product Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_product_type` SET TAGS ('dbx_value_regex' = 'whole_life|universal_life|variable_universal_life|indexed_universal_life|variable_life');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_table_rating` SET TAGS ('dbx_business_glossary_term' = 'New Table Rating');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'New Underwriting Class');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `new_underwriting_class` SET TAGS ('dbx_value_regex' = 'preferred_plus|preferred|standard_plus|standard|substandard|rated');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `nigo_flag` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `nigo_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Not In Good Order (NIGO) Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `original_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Face Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `original_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Original Issue Age');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `original_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Original Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `original_product_type` SET TAGS ('dbx_business_glossary_term' = 'Original Product Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `original_product_type` SET TAGS ('dbx_value_regex' = 'term|yrt|level_term|decreasing_term|increasing_term');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `privilege_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Privilege Expiry Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `processing_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Processing Duration Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Conversion Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Request Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `source_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`policy`.`conversion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `free_look_id` SET TAGS ('dbx_business_glossary_term' = 'Free Look ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Agent ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `refund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Transaction ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Document ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `extended_free_look_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `cancellation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `cancellation_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Description');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `cancellation_request_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Request Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `cancellation_request_method` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Request Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `cancellation_request_method` SET TAGS ('dbx_value_regex' = 'mail|email|phone|in_person|fax|online_portal');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `deduction_reason` SET TAGS ('dbx_business_glossary_term' = 'Deduction Reason');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Policy Delivery Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|electronic|in_person|certified_mail|courier');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Free Look Duration Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Free Look End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `free_look_status` SET TAGS ('dbx_business_glossary_term' = 'Free Look Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `free_look_status` SET TAGS ('dbx_value_regex' = 'active|expired|cancelled|waived|pending_cancellation|completed');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `notice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Notice Delivery Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `notice_delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|included_with_policy|electronic|certified_mail');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Free Look Notice Sent Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `policy_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Delivery Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `premium_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Paid Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `refund_check_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Check Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `refund_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Disbursement Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'check|eft|ach|wire_transfer|credit_card_reversal|original_payment_method');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `replacement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Replacement Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `senior_applicant_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Applicant Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `source_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Free Look Start Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Free Look Waiver Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`free_look` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Free Look Waiver Flag');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `incontestability_id` SET TAGS ('dbx_business_glossary_term' = 'Incontestability Record Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `billing_reinstatement_id` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Record Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `in_force_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `reinstated_incontestability_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `adjusted_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Incontestability Period End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `aps_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attending Physician Statement (APS) Required Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Incontestability Record Comments');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_action_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Contest Action Initiated Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Contest Action Initiation Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_outcome` SET TAGS ('dbx_business_glossary_term' = 'Contest Action Outcome');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_outcome` SET TAGS ('dbx_value_regex' = 'pending|rescission_approved|rescission_denied|settlement_reached|withdrawn|litigation');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Contest Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_reason_code` SET TAGS ('dbx_value_regex' = 'material_misrepresentation|fraud|concealment|non_disclosure|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Contest Reason Description');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_reason_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `contest_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Contest Resolution Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `insured_age_at_issue` SET TAGS ('dbx_business_glossary_term' = 'Insured Age at Issue');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `mib_check_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Information Bureau (MIB) Check Completed Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Period Completion Notification Sent Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Incontestability Period End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Incontestability Period Start Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Incontestability Period Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'active|completed|tolled|waived|contested|expired');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `policy_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Issue Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `reinstatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `statutory_period_length_days` SET TAGS ('dbx_business_glossary_term' = 'Statutory Incontestability Period Length in Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `suicide_exclusion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suicide Exclusion Period End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `suicide_exclusion_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Suicide Exclusion Period Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `tolling_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tolling End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `tolling_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Tolling Event Indicator');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `tolling_event_type` SET TAGS ('dbx_business_glossary_term' = 'Tolling Event Type');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `tolling_event_type` SET TAGS ('dbx_value_regex' = 'fraud_investigation|litigation|insured_absence|regulatory_hold|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `tolling_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tolling Start Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `total_tolling_days` SET TAGS ('dbx_business_glossary_term' = 'Total Tolling Days');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `underwriting_class` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Classification');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By User');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Contestability Waiver Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Contestability Waiver Reason Code');
ALTER TABLE `life_insurance_ecm`.`policy`.`incontestability` ALTER COLUMN `waiver_reason_code` SET TAGS ('dbx_value_regex' = 'business_decision|settlement|goodwill|regulatory_requirement|other');
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` SET TAGS ('dbx_association_edges' = 'policy.in_force_policy,product.rider_definition');
ALTER TABLE `life_insurance_ecm`.`policy`.`rider` ALTER COLUMN `rider_id` SET TAGS ('dbx_business_glossary_term' = 'rider Identifier');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` SET TAGS ('dbx_subdomain' = 'financial_valuation');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` SET TAGS ('dbx_association_edges' = 'policy.rider,investment.separate_account');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `guaranteed_benefit_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Benefit Allocation ID');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `policy_rider_id` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Benefit Allocation - Rider Id');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Benefit Allocation - Separate Account Id');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `actuarial_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Reserve Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `allocated_benefit_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Benefit Base Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `benefit_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Base Amount');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `benefit_base_growth_rate` SET TAGS ('dbx_business_glossary_term' = 'Benefit Base Growth Rate');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `hedge_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Percentage');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `last_rebalance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rebalance Date');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`policy`.`guaranteed_benefit_allocation` ALTER COLUMN `rebalance_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Rebalance Trigger Threshold');
