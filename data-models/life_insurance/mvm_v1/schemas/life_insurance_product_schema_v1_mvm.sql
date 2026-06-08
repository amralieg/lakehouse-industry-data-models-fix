-- Schema for Domain: product | Business: Life Insurance | Version: v1_mvm
-- Generated on: 2026-05-04 07:01:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`product` COMMENT 'SSOT for all life insurance and annuity product definitions — WL, UL, IUL, VUL, YRT, FIA, SPIA, GMAB/GMDB/GMIB/GMWB riders, and DI products. Owns product configuration, plan codes, benefit structures, premium rate tables, underwriting classes, IRC 7702 compliance parameters, product filing metadata, state approvals, product retirement schedules, and product profitability tracking. Governs the product catalog across all distribution channels.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the product plan. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Products map to specific GL accounts for premium revenue recognition, reserve liability booking, and DAC asset capitalization. Required for automated journal entry generation, financial statement prep',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Products are issued by specific insurance carriers (legal entities). Essential for statutory reporting by NAIC company code, RBC calculations, and state regulatory filings. Every product must be owned',
    `cash_value_option` BOOLEAN COMMENT 'Boolean flag indicating whether this product plan includes a cash value accumulation component. True for permanent life insurance and annuities; false for term life and pure protection products.',
    `contestability_period_years` STRING COMMENT 'The number of years from policy issue during which the insurer can contest claims based on material misrepresentation in the application. Typically 2 years per state regulation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this product plan record was first created in the system. Used for audit trail and data lineage tracking.',
    `dac_amortization_method` STRING COMMENT 'The accounting method used to amortize deferred acquisition costs for this product plan under GAAP and LDTI standards. Used in actuarial valuation and financial reporting.. Valid values are `straight_line|interest_adjusted|benefit_ratio`',
    `distribution_channel_availability` STRING COMMENT 'Comma-separated list of distribution channels through which this product plan can be sold (e.g., career_agent, independent_broker, bank_channel, direct_to_consumer, worksite). Used in agent authorization and commission calculation. [ENUM-REF-CANDIDATE: career_agent|independent_broker|bank_channel|direct_to_consumer|worksite|bga|mga — promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which this product plan becomes available for sale and new business issuance. Used in policy administration and new business processing.',
    `expiration_date` DATE COMMENT 'The date on which this product plan is no longer available for new business. Nullable for plans with no planned retirement date. Existing policies remain in force after this date.',
    `free_look_period_days` STRING COMMENT 'The number of days after policy delivery during which the policyholder can cancel the policy for a full refund. Varies by state regulation, typically 10-30 days.',
    `gpt_corridor_factor` DECIMAL(18,2) COMMENT 'The corridor factor used in the Guideline Premium Test calculation to ensure IRC 7702 compliance. Defines the minimum death benefit relative to cash value at each attained age.',
    `grace_period_days` STRING COMMENT 'The number of days after a premium due date during which the policy remains in force without penalty. Typically 30-31 days per state regulation.',
    `guaranteed_issue` BOOLEAN COMMENT 'Boolean flag indicating whether this product plan is available on a guaranteed issue basis without medical underwriting. Used in underwriting workbench and new business processing.',
    `illustration_software_code` STRING COMMENT 'The code identifying the illustration software configuration used to generate policy illustrations for this product plan. Used in point-of-sale systems and agent tools.. Valid values are `^[A-Z0-9]{4,10}$`',
    `insurance_type` STRING COMMENT 'The specific insurance product type code. WL (Whole Life), UL (Universal Life), IUL (Indexed Universal Life), VUL (Variable Universal Life), YRT (Yearly Renewable Term), FIA (Fixed Indexed Annuity), SPIA (Single Premium Immediate Annuity), GMAB (Guaranteed Minimum Accumulation Benefit), GMDB (Guaranteed Minimum Death Benefit), GMIB (Guaranteed Minimum Income Benefit), GMWB (Guaranteed Minimum Withdrawal Benefit), DI (Disability Income). [ENUM-REF-CANDIDATE: WL|UL|IUL|VUL|YRT|FIA|SPIA|GMAB|GMDB|GMIB|GMWB|DI — 12 candidates stripped; promote to reference product]',
    `irc_7702_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether the product plan is designed to comply with IRC Section 7702 life insurance tax qualification requirements including cash value accumulation test and guideline premium test.',
    `loan_provision` BOOLEAN COMMENT 'Boolean flag indicating whether policyholders can take loans against the cash value of this product plan. Used in policy servicing and customer service operations.',
    `maximum_face_amount` DECIMAL(18,2) COMMENT 'The maximum death benefit or coverage amount that can be issued under this product plan without special underwriting approval. Used in underwriting and new business validation.',
    `maximum_issue_age` STRING COMMENT 'The maximum age at which an applicant is eligible to purchase this product plan. Used in underwriting rules and new business processing.',
    `maximum_premium_amount` DECIMAL(18,2) COMMENT 'The maximum premium amount allowed for this product plan without triggering MEC status or requiring special approval. Used in new business validation and IRC 7702 compliance testing.',
    `minimum_face_amount` DECIMAL(18,2) COMMENT 'The minimum death benefit or coverage amount that can be issued under this product plan. Used in underwriting and new business validation.',
    `minimum_issue_age` STRING COMMENT 'The minimum age at which an applicant is eligible to purchase this product plan. Used in underwriting rules and new business processing.',
    `minimum_premium_amount` DECIMAL(18,2) COMMENT 'The minimum premium amount required for this product plan, typically expressed as annual premium equivalent. Used in new business validation and underwriting.',
    `naic_product_type_code` STRING COMMENT 'The three-digit NAIC product type code used for statutory reporting and regulatory filings. Required for Annual Statement Schedule T reporting.. Valid values are `^[0-9]{3}$`',
    `participating_product` BOOLEAN COMMENT 'Boolean flag indicating whether this product plan is a participating policy eligible to receive dividends based on company experience. Used in actuarial valuation and policyholder communications.',
    `plan_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying this product plan across all systems and distribution channels. Used in policy administration, underwriting, and billing systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_description` STRING COMMENT 'Detailed description of the product plan including key features, benefits, and target market. Used for agent training and customer education materials.',
    `plan_name` STRING COMMENT 'The full marketing and legal name of the product plan as it appears in policy documents, illustrations, and customer communications.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the product plan. Active plans are available for new business; filed plans are pending regulatory approval; approved plans are cleared but not yet active; suspended plans are temporarily unavailable; retired plans are closed to new business; withdrawn plans have been removed from filing.. Valid values are `active|filed|approved|suspended|retired|withdrawn`',
    `premium_mode_options` STRING COMMENT 'Comma-separated list of premium payment frequency options available for this product plan (e.g., annual, semi_annual, quarterly, monthly, single). Used in billing system configuration. [ENUM-REF-CANDIDATE: annual|semi_annual|quarterly|monthly|single|flexible — promote to reference product]',
    `product_family` STRING COMMENT 'The product family grouping used for portfolio management, profitability analysis, and strategic planning. Examples include term life family, universal life family, fixed annuity family.',
    `profitability_target_irr` DECIMAL(18,2) COMMENT 'The target internal rate of return for this product plan used in pricing and profitability analysis. Expressed as a decimal (e.g., 0.1200 for 12.00%). Business-confidential metric.',
    `reinstatement_period_months` STRING COMMENT 'The number of months after policy lapse during which the policyholder can reinstate the policy without new underwriting. Typically 3-5 years per state regulation.',
    `reinsurance_treaty_code` STRING COMMENT 'The code identifying the reinsurance treaty under which this product plan is ceded. Used in reinsurance management system for cession processing and bordereaux reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reserve_basis` STRING COMMENT 'The primary reserve calculation basis for this product plan. Statutory (SAP), GAAP, IFRS 17, or Principle-Based Reserving (PBR). Used in actuarial valuation system.. Valid values are `statutory|gaap|ifrs17|pbr`',
    `retirement_reason` STRING COMMENT 'The business or regulatory reason for retiring this product plan. Used in product lifecycle management and strategic planning.. Valid values are `regulatory_change|profitability|market_conditions|product_replacement|strategic_decision`',
    `simplified_issue` BOOLEAN COMMENT 'Boolean flag indicating whether this product plan uses simplified underwriting with limited health questions and no medical exam. Used in underwriting workbench and new business processing.',
    `state_approval_count` STRING COMMENT 'The number of US states and territories in which this product plan has received regulatory approval for sale. Used in distribution planning and compliance monitoring.',
    `suicide_exclusion_period_years` STRING COMMENT 'The number of years from policy issue during which death by suicide results in limited or no death benefit payment. Typically 2 years per state regulation.',
    `surrender_charge_schedule` STRING COMMENT 'Reference to the surrender charge schedule identifier that defines the penalty structure for early policy termination. Used in policy servicing and cash surrender value calculations.',
    `tax_qualification_status` STRING COMMENT 'Indicates whether the product is tax-qualified under IRC Section 7702 and whether it is classified as a Modified Endowment Contract (MEC) under IRC Section 7702A. Critical for tax reporting and compliance.. Valid values are `qualified|non_qualified|mec|non_mec`',
    `underwriting_class_eligibility` STRING COMMENT 'Comma-separated list of underwriting risk classes eligible for this product plan (e.g., preferred_plus, preferred, standard, substandard). Used in underwriting workbench and rate table selection. [ENUM-REF-CANDIDATE: preferred_plus|preferred|standard|substandard|table_rated|declined — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this product plan record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Master catalog of all life insurance and annuity product plans offered by the company — WL, UL, IUL, VUL, YRT, FIA, SPIA, GMAB/GMDB/GMIB/GMWB riders, and DI products. Defines the canonical product identity including plan code, product line, product family, insurance type, tax qualification status (IRC 7702 / MEC), minimum and maximum issue ages, face amount limits, underwriting class eligibility, distribution channel availability, product status (active, filed, retired), effective and expiration dates, and NAIC product type code. This is the SSOT for all product definitions across the enterprise.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`plan_version` (
    `plan_version_id` BIGINT COMMENT 'Unique identifier for the plan version record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Plan versions define product economics (expected_nbv_per_policy, profitability_target_irr) used to establish DAC capitalization accounts and GAAP reserve GL mappings at new business setup. Finance tea',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Plan versions track which legal entity issues them for state approval tracking and financial reporting segregation. State approvals and filings are entity-specific; version-level tracking enables accu',
    `plan_id` BIGINT COMMENT 'Reference to the parent product plan. Links this version to the overarching product plan entity.',
    `replacement_plan_version_id` BIGINT COMMENT 'Reference to the successor plan version that replaces this retired version. Supports product migration and agent guidance. Null if no direct replacement exists.',
    `approval_date` DATE COMMENT 'Date when the state insurance department granted approval for this plan version. May differ from effective date based on filing type and state requirements.',
    `approval_status` STRING COMMENT 'Current state of regulatory approval for this plan version. Tracks progression through state insurance department review and approval workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|conditionally_approved|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `approved_by_authority` STRING COMMENT 'Name of the regulatory authority that approved this version (e.g., New York Department of Financial Services, California Department of Insurance). Supports multi-state product tracking.',
    `change_reason` STRING COMMENT 'Business justification for creating this version. Documents the driver for the version change such as regulatory mandate, competitive positioning, profitability improvement, actuarial assumption update, or product redesign.',
    `closed_block_indicator` BOOLEAN COMMENT 'Flag indicating whether this plan version is part of a closed block for statutory accounting and reserve segregation. True when the version is closed to new business and subject to closed block reporting requirements.',
    `closed_block_transition_date` DATE COMMENT 'Date when this plan version was formally designated as a closed block for statutory accounting purposes. Triggers specific reserve calculation and reporting requirements under SAP (Statutory Accounting Principles).',
    `communication_plan_reference` STRING COMMENT 'Identifier or description of the stakeholder communication strategy for this version change. Documents agent bulletins, policyholder notices, and internal training materials associated with the version transition.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this plan version record was first created in the system. Supports audit trail and version history tracking.',
    `distribution_channel_eligibility` STRING COMMENT 'Comma-separated list of authorized distribution channels for this plan version. Examples: career_agent, independent_broker, bank_channel, direct_to_consumer, worksite, brokerage_general_agency. Governs product availability across sales channels.',
    `effective_date` DATE COMMENT 'Date when this plan version becomes active and available for new business or in-force policy administration. Aligns with state insurance department approval effective dates.',
    `expected_nbv_per_policy` DECIMAL(18,2) COMMENT 'Projected new business value per policy for this plan version based on actuarial pricing assumptions. Represents the present value of future profits at issue. Confidential metric used for product portfolio management and sales incentive design.',
    `filing_reference_number` STRING COMMENT 'State insurance department filing identifier or SERFF (System for Electronic Rate and Form Filing) tracking number. Links this version to the regulatory approval documentation.',
    `gpt_compliant` BOOLEAN COMMENT 'Indicates whether this plan version satisfies the Guideline Premium Test under IRC Section 7702. One of two tests (GPT or Cash Value Accumulation Test) required for life insurance tax qualification.',
    `inforce_continuation_policy` STRING COMMENT 'Strategy for managing existing policies after version retirement. Full servicing maintains all policy features; limited servicing restricts certain transactions; closed block segregates reserves; reinsured transfers risk; sold indicates block sale to another carrier.. Valid values are `full_servicing|limited_servicing|closed_block|reinsured|sold`',
    `irc_7702_compliant` BOOLEAN COMMENT 'Indicates whether this plan version meets IRC Section 7702 definition of life insurance for federal tax qualification. Critical for ensuring death benefit tax-free treatment and cash value accumulation tax deferral.',
    `last_new_business_date` DATE COMMENT 'Final date on which new policies may be issued under this plan version. Critical for product retirement and closed-block management. Typically precedes or coincides with superseded date.',
    `maximum_face_amount` DECIMAL(18,2) COMMENT 'Highest death benefit amount permitted for policies issued under this plan version without special underwriting or reinsurance approval. Supports risk management and capacity planning.',
    `maximum_issue_age` STRING COMMENT 'Oldest age at which an applicant may be issued a policy under this plan version. Expressed in years. Aligns with mortality assumptions and product profitability targets.',
    `mec_risk_indicator` BOOLEAN COMMENT 'Flag indicating whether this plan version design carries elevated risk of MEC classification under the 7-pay test. True when premium structure or cash value accumulation patterns approach MEC thresholds.',
    `minimum_face_amount` DECIMAL(18,2) COMMENT 'Lowest death benefit amount permitted for policies issued under this plan version. Enforces product design constraints and underwriting efficiency thresholds.',
    `minimum_issue_age` STRING COMMENT 'Youngest age at which an applicant may be issued a policy under this plan version. Expressed in years. Supports product design and underwriting rules.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this plan version record was last updated. Supports change tracking and audit compliance.',
    `pbr_applicable` BOOLEAN COMMENT 'Indicates whether this plan version is subject to Principle-Based Reserving under VM-20 (Valuation Manual Section 20). Determines reserve calculation methodology and actuarial opinion requirements.',
    `profitability_target_irr` DECIMAL(18,2) COMMENT 'Target internal rate of return percentage for this plan version as established during product pricing. Expressed as a percentage (e.g., 12.50 for 12.5%). Confidential business metric used for product performance monitoring.',
    `rate_table_reference` STRING COMMENT 'Identifier or name of the premium rate table set associated with this plan version. Links to actuarial rate tables for premium calculation, cost of insurance charges, and benefit pricing.',
    `retirement_announcement_date` DATE COMMENT 'Date when the company publicly announced the retirement of this plan version. Supports agent communication and customer notification timelines. Null for non-retired versions.',
    `retirement_reason` STRING COMMENT 'Primary business driver for retiring this plan version. Regulatory change indicates compliance requirements; profitability reflects financial performance; product redesign signals strategic repositioning; market exit covers business line discontinuation; competitive pressure addresses market dynamics; technology limitation reflects system constraints.. Valid values are `regulatory_change|profitability|product_redesign|market_exit|competitive_pressure|technology_limitation`',
    `rider_eligibility` STRING COMMENT 'Comma-separated list of rider codes or names that may be attached to policies issued under this plan version. Examples: ADB (Accidental Death Benefit), WP (Waiver of Premium), GMDB (Guaranteed Minimum Death Benefit), LTC (Long-Term Care). Governs product configuration options.',
    `state_availability` STRING COMMENT 'Comma-separated list of US state and territory postal codes where this plan version is approved for sale. Supports multi-state product distribution and compliance tracking. Example: NY,CA,TX,FL.',
    `superseded_date` DATE COMMENT 'Date when this plan version is replaced by a subsequent version. Null for the current active version. Marks the end of new business eligibility for this version.',
    `underwriting_class_structure` STRING COMMENT 'Description of the risk classification framework for this plan version. Documents available underwriting classes such as Preferred Plus, Preferred, Standard Plus, Standard, Rated, and any substandard table ratings. Supports rate table selection and pricing.',
    `version_description` STRING COMMENT 'Narrative summary of this plan version including key features, target market, competitive positioning, and material changes from prior versions. Supports product training and agent sales materials.',
    `version_number` STRING COMMENT 'Sequential or semantic version identifier for this plan iteration (e.g., 1.0, 2.1, 3.0-A). Supports both numeric and alphanumeric versioning schemes.',
    `version_status` STRING COMMENT 'Current lifecycle state of this plan version. Draft indicates work in progress; pending approval awaits regulatory review; active is available for new business; superseded is replaced by newer version but may have in-force policies; retired is closed to new business; withdrawn is cancelled before activation.. Valid values are `draft|pending_approval|active|superseded|retired|withdrawn`',
    `version_type` STRING COMMENT 'Classification of the version change. New filing represents initial product launch; amendment covers contract language changes; rate revision updates premium or cost structures; benefit enhancement adds or modifies benefits; compliance update addresses regulatory requirements; retirement marks the terminal lifecycle event.. Valid values are `new_filing|amendment|rate_revision|benefit_enhancement|compliance_update|retirement`',
    CONSTRAINT pk_plan_version PRIMARY KEY(`plan_version_id`)
) COMMENT 'Tracks versioned iterations of a product plan over its full lifecycle from initial filing through active sale to retirement. Captures version number, effective date, superseded date, change reason, filing reference, approval status, and version type (new filing, amendment, rate revision, retirement). For product retirement: records retirement announcement date, last new business effective date, in-force continuation policy, reason for retirement (regulatory, profitability, product redesign, market exit), replacement product plan reference, communication plan details, and closed-block transition parameters. Enables point-in-time product configuration retrieval for in-force policy administration, actuarial valuation, and closed-block management. The retirement version type marks the terminal lifecycle event and supports orderly transition of in-force blocks. This is the single source of truth for product versioning and retirement lifecycle management.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`benefit_structure` (
    `benefit_structure_id` BIGINT COMMENT 'Unique identifier for the benefit structure configuration. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Different benefit structures (term, whole life, universal life) have distinct accounting treatment and GL mapping per GAAP/SAP rules. Required for accurate revenue recognition, reserve calculation, an',
    `plan_id` BIGINT COMMENT 'Reference to the parent product (WL, UL, IUL, VUL, YRT, FIA, SPIA, DI) to which this benefit structure applies.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Benefit structures evolve between product versions (death benefit options, cash value methods, rider availability). Each version may offer different benefit configurations. The effective_date and term',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: Benefit structures may vary by underwriting class (different benefit options, limits, or features for different risk classes). While not all benefit structures are class-specific, some products offer ',
    `benefit_ceiling_value` DECIMAL(18,2) COMMENT 'Maximum benefit amount payable under this benefit structure, regardless of performance or other factors. Null if no ceiling applies.',
    `benefit_floor_value` DECIMAL(18,2) COMMENT 'Minimum benefit amount guaranteed under this benefit structure, regardless of performance or other factors. Null if no floor applies.',
    `benefit_formula_parameters` STRING COMMENT 'Structured representation of the mathematical formula and parameters used to calculate benefit amounts, including variables, coefficients, and calculation rules.',
    `benefit_structure_code` STRING COMMENT 'Business-assigned unique code identifying this benefit structure configuration across systems and distribution channels.',
    `benefit_structure_description` STRING COMMENT 'Detailed description of the benefit structure configuration, including key features, limitations, and business purpose.',
    `benefit_structure_name` STRING COMMENT 'Human-readable name of the benefit structure configuration for business user identification and reporting.',
    `benefit_structure_status` STRING COMMENT 'Current lifecycle status of the benefit structure configuration: active (available for sale), inactive (temporarily unavailable), pending approval (awaiting regulatory approval), or retired (permanently discontinued).. Valid values are `active|inactive|pending_approval|retired`',
    `cash_value_accumulation_method` STRING COMMENT 'For permanent life products: method by which cash value accumulates — fixed interest (WL), indexed crediting (IUL), variable investment (VUL), or not applicable for term/annuity/DI products.. Valid values are `fixed_interest|indexed_crediting|variable_investment|not_applicable`',
    `coi_structure` STRING COMMENT 'For UL/IUL/VUL products: structure of cost of insurance charges — level (fixed), increasing (rises over time), attained age (based on current age), or not applicable for term/WL/annuity/DI products.. Valid values are `level|increasing|attained_age|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit structure record was first created in the system.',
    `csv_calculation_basis` STRING COMMENT 'For permanent life products: formula or methodology used to calculate cash surrender value, including surrender charge schedules and interest crediting rules.',
    `death_benefit_option` STRING COMMENT 'For UL/IUL/VUL products: death benefit option selected (Option A: level, Option B: level plus account value, Option C: increasing). Not applicable for term or annuity products.. Valid values are `option_a|option_b|option_c|not_applicable`',
    `death_benefit_type` STRING COMMENT 'For life products: type of death benefit structure — level (constant), increasing (grows with cash value or inflation), return of premium, or not applicable for non-life products.. Valid values are `level|increasing|return_of_premium|not_applicable`',
    `di_benefit_offset_rules` STRING COMMENT 'For DI products: description of rules governing how other income sources (Social Security, workers compensation, other group disability) offset or reduce the DI benefit payable.',
    `di_benefit_period` STRING COMMENT 'For DI products: maximum duration for which disability benefits are payable — 2-year, 5-year, to age 65, to age 67, lifetime, or not applicable for life/annuity products.. Valid values are `2_year|5_year|to_age_65|to_age_67|lifetime|not_applicable`',
    `di_cola_available` BOOLEAN COMMENT 'For DI products: indicates whether cost of living adjustment (COLA) rider is available to increase benefits during claim period.',
    `di_cola_rate_percent` DECIMAL(18,2) COMMENT 'For DI products with COLA: annual percentage rate at which benefits increase during claim period (e.g., 3.00 for 3% annual increase). Null if COLA not available.',
    `di_disability_definition` STRING COMMENT 'For DI products: definition of disability used to determine benefit eligibility — own occupation, any occupation, modified own occupation, or not applicable for life/annuity products.. Valid values are `own_occupation|any_occupation|modified_own_occupation|not_applicable`',
    `di_elimination_period_days` STRING COMMENT 'For DI products: number of days the insured must be disabled before benefits begin (common values: 30, 60, 90, 180, 365 days). Null for life/annuity products.',
    `di_monthly_benefit_maximum` DECIMAL(18,2) COMMENT 'For DI products: maximum monthly benefit amount payable under this benefit structure. Null for life/annuity products.',
    `di_partial_disability_available` BOOLEAN COMMENT 'For DI products: indicates whether partial disability benefit provision is included in this benefit structure.',
    `di_residual_disability_available` BOOLEAN COMMENT 'For DI products: indicates whether residual disability benefit provision is included in this benefit structure.',
    `di_return_to_work_incentive` BOOLEAN COMMENT 'For DI products: indicates whether return-to-work incentive provisions are included to encourage rehabilitation and return to employment.',
    `di_social_insurance_substitute` BOOLEAN COMMENT 'For DI products: indicates whether social insurance substitute benefit is included to provide additional income if Social Security disability benefits are denied.',
    `dividend_option` STRING COMMENT 'For participating whole life products: policyholder election for dividend treatment — cash, reduce premium, paid-up additions, accumulate at interest, one-year term insurance, or not applicable for non-participating products.. Valid values are `cash|reduce_premium|paid_up_additions|accumulate_at_interest|one_year_term|not_applicable`',
    `effective_date` DATE COMMENT 'Date on which this benefit structure configuration becomes effective and available for new policy issuance.',
    `gmab_available` BOOLEAN COMMENT 'For annuity products: indicates whether guaranteed minimum accumulation benefit (GMAB) rider is available.',
    `gmdb_type` STRING COMMENT 'For annuity products: type of guaranteed minimum death benefit — return of premium, highest anniversary value, earnings protection, or not applicable for life/DI products.. Valid values are `return_of_premium|highest_anniversary_value|earnings_protection|not_applicable`',
    `gmib_available` BOOLEAN COMMENT 'For annuity products: indicates whether guaranteed minimum income benefit (GMIB) rider is available.',
    `gmwb_available` BOOLEAN COMMENT 'For annuity products: indicates whether guaranteed minimum withdrawal benefit (GMWB) rider is available.',
    `irc_7702_compliant` BOOLEAN COMMENT 'For life products: indicates whether this benefit structure meets IRC Section 7702 requirements for life insurance tax qualification (guideline premium test or cash value accumulation test).',
    `irc_7702_test_type` STRING COMMENT 'For life products: the IRC 7702 test method used for tax qualification — guideline premium test (GPT) or cash value accumulation test (CVAT). Not applicable for annuity/DI products.. Valid values are `guideline_premium_test|cash_value_accumulation_test|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit structure record was last updated or modified.',
    `ltc_acceleration_available` BOOLEAN COMMENT 'For life and annuity products: indicates whether long-term care (LTC) benefit acceleration rider is available.',
    `nonforfeiture_option_cash_surrender` BOOLEAN COMMENT 'For permanent life products: indicates whether cash surrender value (CSV) nonforfeiture option is available if policy is surrendered.',
    `nonforfeiture_option_extended_term` BOOLEAN COMMENT 'For permanent life products: indicates whether extended term insurance nonforfeiture option is available if policy lapses.',
    `nonforfeiture_option_reduced_paid_up` BOOLEAN COMMENT 'For permanent life products: indicates whether reduced paid-up insurance nonforfeiture option is available if policy lapses.',
    `product_type` STRING COMMENT 'Specific product type: WL (Whole Life), UL (Universal Life), IUL (Indexed Universal Life), VUL (Variable Universal Life), YRT (Yearly Renewable Term), FIA (Fixed Indexed Annuity), SPIA (Single Premium Immediate Annuity), or DI (Disability Income). [ENUM-REF-CANDIDATE: whole_life|universal_life|indexed_universal_life|variable_universal_life|term_life|fixed_annuity|fixed_indexed_annuity|variable_annuity|single_premium_immediate_annuity|disability_income — 10 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Date on which this benefit structure configuration is retired and no longer available for new policy issuance. Null if currently active.',
    CONSTRAINT pk_benefit_structure PRIMARY KEY(`benefit_structure_id`)
) COMMENT 'SSOT for all benefit configurations across life insurance, annuity, and disability income (DI) product plans. For life products: death benefit (DB) type (level, increasing, return of premium), cash value accumulation method, dividend options (for participating WL), cost of insurance (COI) structure, nonforfeiture options (extended term, reduced paid-up, cash surrender), and nonforfeiture value calculation basis. For annuity products: guaranteed minimum death benefit (GMDB), guaranteed minimum accumulation benefit (GMAB), guaranteed minimum income benefit (GMIB), guaranteed minimum withdrawal benefit (GMWB), and long-term care (LTC) acceleration provisions. For disability income (DI) products: own-occupation vs any-occupation definition of disability, elimination period options (30, 60, 90, 180 days), benefit period options (2-year, 5-year, to age 65, lifetime), monthly benefit maximum, partial and residual disability provisions, cost of living adjustment (COLA) parameters, social insurance substitute benefit, return-to-work incentive provisions, DI-specific occupation class definitions, and benefit offset rules. Captures benefit formula parameters, floor and ceiling values, and IRC 7702 compliance constraints. This is the single source of truth for ALL product benefit definitions — no other product in this domain stores benefit structures or DI benefit parameters.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`rider_definition` (
    `rider_definition_id` BIGINT COMMENT 'Unique identifier for the rider definition. Primary key for the rider catalog.',
    `benefit_structure_id` BIGINT COMMENT 'Foreign key linking to product.benefit_structure. Business justification: rider_definition currently stores benefit configuration as a free-text STRING column benefit_structure. Normalizing this to a FK benefit_structure_id → benefit_structure.benefit_structure_id establi',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Riders (LTC acceleration, disability waiver, GMDB) require separate GL accounts for premium revenue and benefit reserves per statutory accounting rules. Essential for Exhibit 1 revenue reporting and r',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Riders have specific regulatory obligations (LTC rider NAIC Model Regulation, accelerated benefit rider IRC 101(g), waiver of premium disability definitions). Compliance teams must track which regulat',
    `accelerated_benefit_flag` BOOLEAN COMMENT 'Indicates whether this rider provides accelerated death benefit (ADB) that pays out a portion of the death benefit while the insured is living due to terminal illness, chronic illness, or critical illness.',
    `approval_date` DATE COMMENT 'Date when this rider form received regulatory approval from the filing jurisdiction. Used for compliance tracking and product launch planning.',
    `commission_schedule_code` STRING COMMENT 'Code identifying the commission schedule applicable to this rider for agent compensation. Links to commission management system for first-year and renewal commission calculations.. Valid values are `^[A-Z0-9]{2,8}$`',
    `cost_of_insurance_impact` STRING COMMENT 'Describes how this rider affects the base policy Cost of Insurance charges. Additive adds to base COI. Multiplicative applies a factor to base COI. Separate COI indicates rider has independent COI charges. None indicates no COI impact (flat premium rider).. Valid values are `none|additive|multiplicative|separate_coi`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rider definition record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this rider definition became available for attachment to new policies. Aligns with state approval dates and product launch schedules.',
    `filing_jurisdiction` STRING COMMENT 'Primary state jurisdiction where this rider form was originally filed and approved. May be domicile state or lead state for interstate compact filings.',
    `form_number` STRING COMMENT 'Official form number assigned to the rider policy form filed with state insurance departments. Used for regulatory compliance and policy document generation.. Valid values are `^[A-Z0-9-]{4,15}$`',
    `guaranteed_insurability_flag` BOOLEAN COMMENT 'Indicates whether this rider provides guaranteed insurability options allowing the policyholder to purchase additional coverage at specified future dates without evidence of insurability.',
    `illustration_required` BOOLEAN COMMENT 'Indicates whether this rider must be included in policy illustrations provided to customers at point of sale. Driven by NAIC illustration requirements and product complexity.',
    `irc_7702_compliant` BOOLEAN COMMENT 'Indicates whether this rider is structured to maintain IRC Section 7702 compliance for life insurance tax qualification. Critical for ensuring policy death benefits remain tax-free.',
    `ltc_qualified_flag` BOOLEAN COMMENT 'Indicates whether this rider qualifies as a tax-qualified long-term care rider under IRC Section 7702B and HIPAA. Qualified LTC riders provide tax-advantaged benefits for ADL (Activities of Daily Living) impairment.',
    `maximum_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount of benefit payable under this rider, if applicable. Null for riders with no maximum cap. Used for underwriting and risk assessment.',
    `maximum_issue_age` STRING COMMENT 'Maximum age of the insured at which this rider can be issued. Used for eligibility validation during new business processing.',
    `mec_impact` STRING COMMENT 'Indicates whether adding this rider can cause the base policy to become a Modified Endowment Contract under IRC Section 7702A. None indicates no MEC impact. Potential indicates MEC testing required. Always indicates rider will trigger MEC status.. Valid values are `none|potential|always`',
    `medical_evidence_required` BOOLEAN COMMENT 'Indicates whether medical evidence (APS - Attending Physician Statement, paramedical exam, lab tests) is required for rider issuance. Drives underwriting workflow and requirements.',
    `minimum_benefit_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount of benefit required for this rider to be issued. Used for underwriting and product eligibility validation.',
    `minimum_issue_age` STRING COMMENT 'Minimum age of the insured at which this rider can be issued. Used for eligibility validation during new business processing.',
    `predecessor_rider_code` STRING COMMENT 'Rider code of the previous version or predecessor rider that this rider replaces. Used for product genealogy tracking and policy conversion analysis. Null for new riders with no predecessor.. Valid values are `^[A-Z0-9]{3,10}$`',
    `premium_basis` STRING COMMENT 'Method by which rider premium is calculated. Per thousand charges premium per $1,000 of coverage. Flat rate charges a fixed dollar amount. Percentage of premium charges as a percentage of base policy premium. Percentage of benefit charges as a percentage of rider benefit amount. Included indicates no additional premium (rider is bundled).. Valid values are `per_thousand|flat_rate|percentage_of_premium|percentage_of_benefit|included`',
    `premium_mode` STRING COMMENT 'Frequency at which rider premium is collected. Aligns with base policy premium mode or may have independent billing schedule.. Valid values are `annual|semi_annual|quarterly|monthly|single|flexible`',
    `reinsurance_treaty_applicable` BOOLEAN COMMENT 'Indicates whether this rider is covered under reinsurance treaties. Drives cession processing and reinsurance bordereaux reporting.',
    `return_of_premium_flag` BOOLEAN COMMENT 'Indicates whether this rider provides return of premium benefits, refunding premiums paid if the insured survives to a specified age or term end.',
    `rider_category` STRING COMMENT 'Indicates whether the rider is optional (customer-elected), mandatory (required for certain product configurations), or automatic (included by default without additional premium).. Valid values are `optional|mandatory|automatic`',
    `rider_code` STRING COMMENT 'Unique alphanumeric code identifying the rider in policy administration systems. Used for policy issuance, billing, and claims processing.. Valid values are `^[A-Z0-9]{3,10}$`',
    `rider_definition_description` STRING COMMENT 'Detailed business description of the rider benefits, coverage, and purpose. Used for agent training, customer communications, and product documentation.',
    `rider_definition_status` STRING COMMENT 'Current lifecycle status of the rider definition. Active riders are available for new business. Discontinued riders remain for in-force policy servicing but are not available for new sales.. Valid values are `active|inactive|pending_approval|withdrawn|discontinued`',
    `rider_expiry_age` STRING COMMENT 'Age at which rider coverage automatically terminates. Common for term riders and certain living benefit riders. Null for riders with no age-based expiry.',
    `rider_name` STRING COMMENT 'Full business name of the rider as it appears on policy documents and customer communications.',
    `rider_type` STRING COMMENT 'High-level classification of the rider by benefit category. Death benefit riders include ADB (Accidental Death Benefit). Living benefit riders include LTC (Long-Term Care), GMDB (Guaranteed Minimum Death Benefit), GMIB (Guaranteed Minimum Income Benefit), GMWB (Guaranteed Minimum Withdrawal Benefit). Waiver riders include AWL (Automatic Waiver of Premium).. Valid values are `death_benefit|living_benefit|waiver|return_of_premium|term|disability_income`',
    `state_availability` STRING COMMENT 'Comma-separated list of US state codes where this rider is approved for sale. Reflects state-by-state filing approvals and regulatory compliance.',
    `surrender_charge_applicable` BOOLEAN COMMENT 'Indicates whether surrender charges apply if the rider is terminated or the policy is surrendered. Relevant for riders with significant acquisition costs or DAC (Deferred Acquisition Cost).',
    `termination_date` DATE COMMENT 'Date when this rider was discontinued for new business. Null for active riders. In-force policies with this rider continue to be serviced after termination.',
    `underwriting_class_required` BOOLEAN COMMENT 'Indicates whether this rider requires underwriting classification (preferred, standard, substandard) or is issued on a guaranteed basis without medical underwriting.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this rider definition record. Used for change tracking and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rider definition record was last modified. Used for change tracking and audit compliance.',
    `version_number` STRING COMMENT 'Version identifier for this rider definition. Incremented when rider terms, rates, or eligibility rules are modified and refiled.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `waiver_of_premium_flag` BOOLEAN COMMENT 'Indicates whether this rider provides waiver of premium benefits in the event of disability. Includes AWL (Automatic Waiver of Premium) and DI (Disability Income) riders.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this rider definition record. Used for audit trail and accountability.',
    CONSTRAINT pk_rider_definition PRIMARY KEY(`rider_definition_id`)
) COMMENT 'Master catalog of all optional and mandatory riders available for attachment to base product plans — ADB (Accidental Death Benefit), AWL (Automatic Waiver of Premium), CAR (Company Action Rider), LTC rider, DI rider, child term rider, return of premium rider, and living benefit riders. Captures rider code, rider type, eligibility rules, maximum benefit amounts, premium basis, underwriting requirements, state availability, and IRC tax treatment. Distinct from benefit_structure as riders have independent pricing, underwriting, and lifecycle management.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`premium_rate_table` (
    `premium_rate_table_id` BIGINT COMMENT 'Unique identifier for the premium rate table. Primary key.',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product to which this rate table applies (WL, UL, IUL, VUL, YRT, FIA, SPIA, etc.).',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Premium rate tables are version-specific. Rate changes typically trigger new product versions. The rate_version_number and predecessor_rate_table_id suggest version-level tracking. Each plan version h',
    `predecessor_rate_table_premium_rate_table_id` BIGINT COMMENT 'Reference to the previous version of this rate table that this version supersedes, enabling rate table lineage tracking.',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: premium_rate_table.underwriting_class is currently a STRING attribute storing class codes. This should be normalized to a FK to the underwriting_class reference table. The underwriting_class table is ',
    `approval_date` DATE COMMENT 'Date on which the state insurance department approved this rate table for use.',
    `attained_age_max` STRING COMMENT 'Maximum attained age (in years) for which rates in this table apply, often the maturity age of the policy.',
    `attained_age_min` STRING COMMENT 'Minimum attained age (in years) for which rates in this table apply, relevant for COI and mortality charge schedules.',
    `coi_rate_per_thousand` DECIMAL(18,2) COMMENT 'Monthly cost of insurance rate per $1,000 of net amount at risk (NAR) for universal life products (UL, IUL, VUL).',
    `created_by_user` STRING COMMENT 'User ID or name of the actuarial analyst or system user who created this rate table record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate table record was first created in the system.',
    `face_amount_band_max` DECIMAL(18,2) COMMENT 'Maximum face amount (death benefit) for which this rate table applies, defining the upper bound of the coverage band.',
    `face_amount_band_min` DECIMAL(18,2) COMMENT 'Minimum face amount (death benefit) for which this rate table applies, defining the lower bound of the coverage band.',
    `filing_number` STRING COMMENT 'State insurance department filing number or SERFF tracking number associated with the approval of this rate table.',
    `flat_extra_amount` DECIMAL(18,2) COMMENT 'Additional flat premium amount per $1,000 of coverage applied for substandard risks or specific underwriting conditions.',
    `gender` STRING COMMENT 'Gender classification for which the rates apply (Male, Female, or Unisex where gender-distinct pricing is not used).. Valid values are `male|female|unisex`',
    `guaranteed_flag` BOOLEAN COMMENT 'Indicates whether the rates in this table are contractually guaranteed and cannot be changed by the insurer.',
    `irc_7702_compliant_flag` BOOLEAN COMMENT 'Indicates whether this rate table meets IRC Section 7702 requirements for life insurance tax qualification (guideline premium test or cash value accumulation test).',
    `issue_age_max` STRING COMMENT 'Maximum issue age (in years) for which this rate table is applicable.',
    `issue_age_min` STRING COMMENT 'Minimum issue age (in years) for which this rate table is applicable.',
    `last_updated_by_user` STRING COMMENT 'User ID or name of the actuarial analyst or system user who last modified this rate table record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate table record was last modified.',
    `modal_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to annual premium to derive premium for other payment modes (e.g., 0.2600 for monthly mode).',
    `mortality_table_basis` STRING COMMENT 'The underlying mortality table standard used as the basis for this rate table (e.g., 2001 CSO, 2017 CSO, 1983 GAM, Annuity 2000).',
    `payment_mode` STRING COMMENT 'Premium payment frequency for which this rate table or modal factor applies (Annual, Semi-Annual, Quarterly, Monthly, Single).. Valid values are `annual|semi_annual|quarterly|monthly|single`',
    `policy_duration_max` STRING COMMENT 'Maximum policy duration (in years) for which this rate table applies.',
    `policy_duration_min` STRING COMMENT 'Minimum policy duration (in years) for which this rate table applies, used for duration-based premium structures.',
    `rate_basis_description` STRING COMMENT 'Detailed description of the actuarial basis, assumptions, and methodology used to derive the rates in this table.',
    `rate_effective_date` DATE COMMENT 'Date from which this rate table becomes effective for new business and in-force policies as applicable.',
    `rate_expiration_date` DATE COMMENT 'Date on which this rate table is no longer effective for new business, nullable for tables with indefinite applicability.',
    `rate_per_unit` DECIMAL(18,2) COMMENT 'Premium rate per unit of coverage (e.g., per $1,000 of face amount for traditional life products).',
    `rate_schedule_type` STRING COMMENT 'Classification of the rate schedule indicating whether rates are guaranteed maximum, current, illustrative, or other contractual basis.. Valid values are `guaranteed|current|illustrative|maximum|minimum|projected`',
    `rate_table_code` STRING COMMENT 'Unique business identifier for the rate table used in policy administration systems and actuarial systems (e.g., 2017CSO_NS_M_UL, COI_PREF_F_IUL).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rate_table_name` STRING COMMENT 'Human-readable descriptive name of the rate table (e.g., 2017 CSO Non-Smoker Male Universal Life, Preferred Female COI Schedule).',
    `rate_table_notes` STRING COMMENT 'Free-form notes or comments regarding special conditions, exceptions, or usage instructions for this rate table.',
    `rate_table_status` STRING COMMENT 'Current lifecycle status of the rate table (Active, Inactive, Pending Approval, Superseded, Withdrawn).. Valid values are `active|inactive|pending_approval|superseded|withdrawn`',
    `rate_type` STRING COMMENT 'Type of rate contained in this table: base premium per unit, cost of insurance (COI) rate per $1,000 NAR, mortality charge, guaranteed annuitization rate, modal factor, flat extra, or table rating. [ENUM-REF-CANDIDATE: base_premium|coi_rate|mortality_charge|annuitization_rate|modal_factor|flat_extra|table_rating — 7 candidates stripped; promote to reference product]',
    `rate_version_number` STRING COMMENT 'Version number of this rate table, incremented when rates are revised or updated.',
    `state_jurisdiction` STRING COMMENT 'Two-letter US state code for which this rate table is approved and applicable, or NA for nationally approved tables.. Valid values are `^[A-Z]{2}$`',
    `table_rating_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to standard rates for substandard risks, expressed as a percentage increase (e.g., 1.25 for Table B = 125% of standard).',
    `tobacco_status` STRING COMMENT 'Tobacco usage classification for which the rates apply (Non-Smoker, Smoker, Tobacco User, Non-Tobacco).. Valid values are `non_smoker|smoker|tobacco_user|non_tobacco`',
    CONSTRAINT pk_premium_rate_table PRIMARY KEY(`premium_rate_table_id`)
) COMMENT 'SSOT for all actuarially determined premium, cost-of-insurance (COI), and mortality charge rate tables across all product lines. For traditional life products (WL, term): base premium rates per unit segmented by underwriting class, gender, tobacco status, issue age, policy duration, face amount band, and payment mode, with modal factors and flat extra amounts. For universal life products (UL, IUL, VUL): monthly COI rates per $1,000 of net amount at risk (NAR) by attained age, gender, tobacco status, and underwriting class, with guaranteed maximum and current rate schedules. For annuity products: mortality charges and guaranteed annuitization rates. Captures mortality table basis (2001 CSO, 2017 CSO), rate effective dates, table ratings, rate schedule type (guaranteed vs current), and rate band breakpoints. This is the single source of truth for ALL product-level rate data including COI schedules — no other product in this domain stores rate schedules or COI rates.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` (
    `coi_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the COI rate schedule. Primary key.',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product (UL, IUL, VUL, FIA) to which this COI rate schedule applies.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: COI rate schedules are version-specific. Rate changes typically trigger new product versions. The version_number attribute and predecessor_schedule_id suggest version-level tracking. Each plan version',
    `predecessor_schedule_coi_rate_schedule_id` BIGINT COMMENT 'Reference to the previous version of this COI rate schedule, if this schedule is a revision or update. Null for initial versions.',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: coi_rate_schedule.underwriting_class is currently a STRING attribute storing class codes. This should be normalized to a FK to the underwriting_class reference table. COI rates vary by underwriting cl',
    `actuarial_notes` STRING COMMENT 'Free-text field for actuarial comments, assumptions, or special considerations related to this COI rate schedule.',
    `attained_age_max` STRING COMMENT 'The maximum attained age (in years) for which this COI rate schedule is applicable.',
    `attained_age_min` STRING COMMENT 'The minimum attained age (in years) for which this COI rate schedule is applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this COI rate schedule record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this COI rate schedule becomes effective for new policies and in-force policy administration.',
    `expiration_date` DATE COMMENT 'The date on which this COI rate schedule expires and is no longer applicable. Null indicates the schedule is currently active with no planned expiration.',
    `gender` STRING COMMENT 'Gender classification for which this COI rate schedule applies. Unisex rates are used in jurisdictions prohibiting gender-based pricing.. Valid values are `male|female|unisex`',
    `illustration_usage_flag` BOOLEAN COMMENT 'Indicates whether this COI rate schedule is approved for use in policy illustrations shown to prospective buyers. True if approved for illustrations, false if for internal use only.',
    `irc_7702_compliant` BOOLEAN COMMENT 'Indicates whether this COI rate schedule meets the requirements of IRC Section 7702 for life insurance tax qualification. True if compliant, false otherwise.',
    `is_current_rate` BOOLEAN COMMENT 'Indicates whether this schedule represents the current COI rates being charged to policyholders. True for current rate schedules, false for guaranteed or historical rates.',
    `is_guaranteed_maximum` BOOLEAN COMMENT 'Indicates whether this schedule represents the guaranteed maximum COI rates contractually promised in the policy. True for guaranteed maximum schedules, false for current or other rate types.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this COI rate schedule record was most recently updated.',
    `mortality_table_basis` STRING COMMENT 'The actuarial mortality table used as the foundation for this COI rate schedule (e.g., 2001 CSO, 2017 CSO).. Valid values are `2001_CSO|2017_CSO|1980_CSO|annuity_2000|GAM83|custom`',
    `profitability_tier` STRING COMMENT 'Classification of the expected profitability of policies using this COI rate schedule, used for product management and pricing strategy.. Valid values are `high|medium|low|loss_leader`',
    `rate_adjustment_factor` DECIMAL(18,2) COMMENT 'A multiplier applied to base mortality rates to derive the final COI rates in this schedule. Used for substandard risk classes or experience-based adjustments.',
    `rate_basis` STRING COMMENT 'The time period basis for the COI rate (monthly, annual, or quarterly). Most universal life products use monthly rates.. Valid values are `monthly|annual|quarterly`',
    `rate_guarantee_period_years` STRING COMMENT 'The number of years for which the COI rates in this schedule are guaranteed not to increase, if applicable. Null indicates no guarantee period.',
    `rate_per_thousand_nar` DECIMAL(18,2) COMMENT 'The monthly COI rate expressed per $1,000 of net amount at risk. This is the core pricing element used in policy administration to calculate monthly COI charges.',
    `retirement_date` DATE COMMENT 'The date on which this COI rate schedule was retired from active use and is no longer available for new policies. Null indicates the schedule is still active.',
    `retirement_reason` STRING COMMENT 'Business explanation for why this COI rate schedule was retired (e.g., regulatory change, product discontinuation, experience-based repricing).',
    `schedule_code` STRING COMMENT 'Business identifier for the COI rate schedule, used in policy administration and illustrations.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `schedule_name` STRING COMMENT 'Descriptive name of the COI rate schedule for business users and reporting.',
    `schedule_type` STRING COMMENT 'Classification of the COI rate schedule indicating whether it represents guaranteed maximum rates, current rates, or rates for specific underwriting classes. [ENUM-REF-CANDIDATE: guaranteed_maximum|current|preferred|standard|substandard|smoker|non_smoker — 7 candidates stripped; promote to reference product]',
    `state_approval_date` DATE COMMENT 'The date on which the state insurance department approved this COI rate schedule for use in that jurisdiction.',
    `state_approval_jurisdiction` STRING COMMENT 'Two-letter state code indicating the insurance department jurisdiction that approved this COI rate schedule for use.. Valid values are `^[A-Z]{2}$`',
    `state_filing_number` STRING COMMENT 'The official filing number assigned by the state insurance department for this COI rate schedule approval.',
    `tobacco_status` STRING COMMENT 'Tobacco use classification for which this COI rate schedule applies (tobacco user, non-tobacco user, or not applicable).. Valid values are `tobacco|non_tobacco|not_applicable`',
    `version_number` STRING COMMENT 'Sequential version number of this COI rate schedule, incremented with each revision or update to the schedule.',
    CONSTRAINT pk_coi_rate_schedule PRIMARY KEY(`coi_rate_schedule_id`)
) COMMENT 'Defines the Cost of Insurance (COI) rate schedules for universal life (UL, IUL, VUL) and annuity products, specifying monthly COI rates per $1,000 of net amount at risk (NAR) by attained age, gender, tobacco status, and underwriting class. Captures guaranteed maximum COI rates, current COI rates, mortality table basis (e.g., 2001 CSO, 2017 CSO), and rate effective dates. Critical for policy illustration compliance and in-force policy administration.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`underwriting_class` (
    `underwriting_class_id` BIGINT COMMENT 'Unique identifier for the underwriting risk classification category. Primary key.',
    `actual_profit_margin` DECIMAL(18,2) COMMENT 'Actual achieved profit margin percentage for in-force business in this underwriting class, based on most recent financial close. Compared against target margin to assess pricing adequacy and competitive position. Null if insufficient in-force experience. Confidential business metric.',
    `age_band_maximum` STRING COMMENT 'Maximum issue age (in years) for which this underwriting class is available. Null if no maximum restriction. Preferred classes often have lower maximum ages than standard classes due to underwriting complexity at advanced ages.',
    `age_band_minimum` STRING COMMENT 'Minimum issue age (in years) for which this underwriting class is available. Null if no minimum restriction. Used to enforce product design rules and underwriting guidelines during new business processing.',
    `approved_states_list` STRING COMMENT 'Comma-separated list of two-letter state codes where this underwriting class is approved for use (e.g., CA,NY,TX,FL). Maintained for quick jurisdiction eligibility checks during new business processing and agent quoting.',
    `cash_value_accumulation_test_factor` DECIMAL(18,2) COMMENT 'Actuarial factor used in IRC Section 7702 Cash Value Accumulation Test for this underwriting class. Alternative to GPT for determining tax qualification. Used primarily for traditional whole life and universal life products.',
    `class_category` STRING COMMENT 'High-level risk category grouping for the underwriting class. Preferred classes represent lowest mortality risk, standard represents average risk, substandard represents elevated risk requiring table ratings, and declined represents uninsurable risk.. Valid values are `preferred|standard|substandard|declined`',
    `class_code` STRING COMMENT 'Short alphanumeric code representing the underwriting class (e.g., PPNT, PNT, SPNT, SNT, PT, ST, TBL-A through TBL-P). Used as the business identifier across policy administration, underwriting, and reinsurance systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `class_name` STRING COMMENT 'Full descriptive name of the underwriting class (e.g., Preferred Plus Non-Tobacco, Standard Tobacco, Table D). Human-readable label used in policy documents, illustrations, and agent-facing systems.',
    `created_by_user` STRING COMMENT 'User ID or system account that created this underwriting class record. Used for audit trail, accountability, and regulatory compliance. Typically an actuarial or product management user.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this underwriting class record was first created in the system. Used for audit trail, data lineage, and regulatory compliance. Immutable after initial insert.',
    `effective_date` DATE COMMENT 'Date on which this underwriting class definition became effective for new business. Policies issued on or after this date may use this class. Critical for rate guarantee periods and product filing compliance.',
    `eligibility_criteria_summary` STRING COMMENT 'High-level summary of the health, lifestyle, and risk criteria required to qualify for this underwriting class (e.g., excellent health, no tobacco use, normal BMI, no adverse family history, no hazardous occupations). Detailed criteria maintained in underwriting rules engine; this field provides business-user-facing overview.',
    `experience_study_mortality_ratio` DECIMAL(18,2) COMMENT 'Most recent actual-to-expected mortality ratio from company experience studies for policies in this underwriting class. Ratio less than 1.0 indicates better-than-expected mortality; greater than 1.0 indicates worse. Used for pricing reviews and reserve adequacy testing. Null if insufficient experience data.',
    `expiration_date` DATE COMMENT 'Date on which this underwriting class definition expires and is no longer available for new business. Null for currently active classes. Existing policies continue under original class; this affects new issue only.',
    `face_amount_maximum` DECIMAL(18,2) COMMENT 'Maximum death benefit face amount allowed for this underwriting class under automatic underwriting or treaty reinsurance. Amounts above this threshold may require facultative reinsurance or senior underwriter approval. Null if no maximum.',
    `face_amount_minimum` DECIMAL(18,2) COMMENT 'Minimum death benefit face amount required to qualify for this underwriting class. Expressed in policy currency (typically USD). Preferred classes often require higher minimums to justify underwriting expense. Null if no minimum.',
    `gender_specific_flag` BOOLEAN COMMENT 'Indicates whether this underwriting class has gender-specific mortality assumptions and premium rates. True if separate male/female rates apply; False if unisex or gender-neutral. Some states mandate unisex rating; this flag supports compliance.',
    `guideline_premium_test_factor` DECIMAL(18,2) COMMENT 'Actuarial factor used in IRC Section 7702 Guideline Premium Test calculations for this underwriting class. Derived from mortality assumptions and interest rates. Used to determine maximum premium corridor and prevent Modified Endowment Contract (MEC) violations.',
    `inforce_policy_count` STRING COMMENT 'Current number of active policies in this underwriting class as of most recent valuation date. Used for experience credibility assessment, reserve calculations, and portfolio risk management. Confidential business metric.',
    `irc_7702_compliant_flag` BOOLEAN COMMENT 'Indicates whether premium rates and COI charges for this underwriting class meet IRC Section 7702 definition of life insurance for tax qualification. All classes must be compliant for products to maintain tax-advantaged status. False would trigger immediate remediation.',
    `last_experience_study_date` DATE COMMENT 'Date of the most recent actuarial experience study that included mortality analysis for this underwriting class. Experience studies typically performed annually or biennially. Used to assess data recency for pricing and reserving decisions.',
    `mortality_loading_factor` DECIMAL(18,2) COMMENT 'Multiplicative factor applied to base mortality rates for this underwriting class. Preferred classes have factors less than 1.0 (e.g., 0.75), standard classes typically 1.0, substandard classes greater than 1.0 (e.g., Table A = 1.25, Table B = 1.50). Used in actuarial reserve calculations and COI determination.',
    `new_business_volume_last_year` STRING COMMENT 'Number of new policies issued in this underwriting class during the most recent calendar year. Used to assess class popularity, distribution effectiveness, and underwriting capacity planning. Confidential business metric.',
    `premium_loading_percentage` DECIMAL(18,2) COMMENT 'Percentage adjustment applied to base premium rates for this underwriting class. Expressed as a percentage (e.g., -15.00 for preferred discount, +50.00 for Table B surcharge). Used in premium billing calculations and policy illustrations.',
    `principle_based_reserving_category` STRING COMMENT 'Risk category assignment for this underwriting class under NAIC Valuation Manual VM-20 Principle-Based Reserving framework. Determines stochastic modeling requirements, deterministic reserve floors, and capital requirements. High-risk classes require more extensive modeling.. Valid values are `low_risk|moderate_risk|high_risk|not_applicable`',
    `profitability_target_margin` DECIMAL(18,2) COMMENT 'Target profit margin percentage for new business issued in this underwriting class, expressed as percentage of premium or present value of profits. Used in product pricing, performance monitoring, and strategic planning. Confidential business metric.',
    `reinsurance_eligible_flag` BOOLEAN COMMENT 'Indicates whether policies issued in this underwriting class are eligible for automatic reinsurance cession under treaty terms. Some substandard classes or experimental classes may require facultative reinsurance or may be retained 100% by the ceding company.',
    `reinsurance_retention_limit` DECIMAL(18,2) COMMENT 'Maximum Net Amount at Risk (NAR) the company will retain for policies in this underwriting class before ceding to reinsurers. Expressed in policy currency (typically USD). Null if class is not reinsurance-eligible or retention varies by treaty.',
    `state_approval_count` STRING COMMENT 'Number of US states (and territories) where this underwriting class has received regulatory approval for use. Life insurance is state-regulated; a class may be approved in some jurisdictions but not others. Used to determine geographic availability.',
    `superseded_by_class_code` STRING COMMENT 'Class code of the underwriting class that replaced this class, if status is superseded. Used to maintain historical lineage and support policy conversion or re-rating initiatives. Null if class is still active or was withdrawn without replacement.',
    `table_rating` STRING COMMENT 'Substandard table rating designation for elevated mortality risk (Table A through Table P, where each letter typically represents 25% mortality loading increment). NONE for standard and preferred classes. Used to calculate premium surcharges and reinsurance cession rates.. Valid values are `^(TABLE-[A-P]|NONE)$`',
    `tobacco_status` STRING COMMENT 'Indicates whether the underwriting class applies to tobacco users, non-tobacco users, or is tobacco-neutral. Critical for premium rating and Cost of Insurance (COI) calculation. Non-tobacco typically defined as no tobacco use in past 12-36 months per company guidelines.. Valid values are `non-tobacco|tobacco|not_applicable`',
    `underwriting_class_status` STRING COMMENT 'Current lifecycle status of the underwriting class. Active classes are available for new business. Pending approval classes are filed but awaiting state approval. Inactive/withdrawn classes are no longer offered. Superseded classes have been replaced by a newer version.. Valid values are `active|inactive|pending_approval|withdrawn|superseded`',
    `updated_by_user` STRING COMMENT 'User ID or system account that last modified this underwriting class record. Used for audit trail, change management, and regulatory compliance. Updated on each modification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this underwriting class record was last modified. Updated on any change to class attributes, status, or configuration. Used for change tracking, audit trail, and data synchronization across systems.',
    CONSTRAINT pk_underwriting_class PRIMARY KEY(`underwriting_class_id`)
) COMMENT 'SSOT reference catalog of all underwriting risk classification categories used across product plans — preferred plus non-tobacco, preferred non-tobacco, standard plus non-tobacco, standard non-tobacco, preferred tobacco, standard tobacco, and substandard table ratings (Table A through Table P). Captures class code, class name, mortality loading factor, premium loading percentage, eligibility criteria summary, applicable product lines, and effective dates. Governs risk segmentation for premium rating, COI calculation, and reinsurance cession. This is the product domains SSOT for underwriting class definitions; the underwriting domain references these classes during risk assessment and the reinsurance domain uses them for treaty eligibility.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`state_approval` (
    `state_approval_id` BIGINT COMMENT 'Unique identifier for the state approval record. Primary key for the state approval entity.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: State approvals reference official approval letters, objection correspondence, and DOI examiner documents. Real business process: regulatory compliance verification and audit trail require linking app',
    `filing_id` BIGINT COMMENT 'Foreign key linking to product.filing. Business justification: A state_approval is the outcome of a regulatory filing submitted to a state Department of Insurance. The state_approval table currently stores filing_reference_number as a STRING, which is a denormali',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: State DOI approvals are granted to specific legal entities (NAIC company codes). Required for regulatory compliance tracking, Annual Statement preparation, and multi-entity product portfolio managemen',
    `plan_id` BIGINT COMMENT 'Reference to the specific product plan version being filed for state approval. Links to the product plan master entity.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: State approvals are version-specific regulatory approvals. Each plan version requires separate state approval. The state_approval table currently only links to product_plan, but approvals are granted ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: State approvals for insurance products are driven by specific regulatory obligations (e.g., NAIC model law requirements, state-specific filing mandates). The state_approval product currently lacks a d',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: State product approvals are granted under specific state regulations. Compliance officers must link each state_approval to the governing state_regulation to track regulatory changes requiring re-filin',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to product.underwriting_class. Business justification: state_approval has an underwriting_class_restrictions STRING field indicating that certain state approvals impose restrictions on which underwriting classes are eligible. Adding underwriting_class_id ',
    `actuarial_memorandum_reference` STRING COMMENT 'Reference identifier for the actuarial memorandum supporting this filing, including rate justification, reserve adequacy, and compliance with state actuarial standards.',
    `approval_conditions` STRING COMMENT 'Any special conditions, requirements, or stipulations imposed by the state DOI as part of the approval. Must be satisfied for continued sale in the jurisdiction.',
    `approval_date` DATE COMMENT 'Date when the state Department of Insurance officially approved the product filing for this jurisdiction. Null if not yet approved.',
    `approval_number` STRING COMMENT 'Official approval number or reference issued by the state DOI upon approval. Used for compliance documentation and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this state approval record was first created in the system. Audit trail for data lineage and compliance tracking.',
    `distribution_channel_restrictions` STRING COMMENT 'State-specific restrictions on which distribution channels (career agents, brokers, banks, direct-to-consumer) are permitted to sell this product in this jurisdiction.',
    `doi_examiner_correspondence` STRING COMMENT 'Reference to all correspondence exchanged with the state DOI examiner, including information requests, clarifications, and responses. Links to document management system.',
    `effective_date` DATE COMMENT 'Date when the approved product plan becomes effective and available for sale in this state jurisdiction. May differ from approval date based on state requirements.',
    `filing_date` DATE COMMENT 'Date when the filing was officially submitted to the state Department of Insurance (DOI) or SERFF system. This is the principal business event timestamp for the filing lifecycle.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing across all target states. Tracks the overall workflow from preparation through final disposition. [ENUM-REF-CANDIDATE: draft|submitted|under_review|objection_received|resubmitted|approved|denied|withdrawn — 8 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'Classification of the regulatory filing indicating the nature of the submission: new product introduction, rate revision, form amendment, rider addition, benefit modification, or product withdrawal.. Valid values are `new_product|rate_revision|form_amendment|rider_addition|benefit_modification|withdrawal`',
    `finra_review_required` BOOLEAN COMMENT 'Indicates whether this product requires FINRA advertising and sales material review due to variable product features and broker-dealer distribution.',
    `form_number` STRING COMMENT 'State-assigned form number for the approved policy form, rider, or rate schedule. Required for policy issuance and compliance verification.',
    `free_look_period_days` STRING COMMENT 'State-mandated free look or right to examine period in days during which the policyholder can cancel for a full refund. Varies by state and product type.',
    `grace_period_days` STRING COMMENT 'State-mandated grace period in days for premium payment before policy lapse. Typically 30-31 days but may vary by state regulation.',
    `illustration_actuary_certification_required` BOOLEAN COMMENT 'Indicates whether state regulations require actuarial certification of policy illustrations for this product. Applies to products with non-guaranteed elements.',
    `irc_7702_compliance_confirmed` BOOLEAN COMMENT 'Indicates whether the product design has been confirmed to meet IRC Section 7702 life insurance tax qualification requirements. Critical for tax-advantaged treatment.',
    `maximum_face_amount` DECIMAL(18,2) COMMENT 'State-approved maximum death benefit or face amount for this product in this jurisdiction. May be limited by state capacity or regulatory constraints.',
    `maximum_issue_age` STRING COMMENT 'State-approved maximum age at which this product can be issued in this jurisdiction. Enforces state-specific age requirements.',
    `minimum_face_amount` DECIMAL(18,2) COMMENT 'State-approved minimum death benefit or face amount for this product in this jurisdiction. Enforces state-specific product design requirements.',
    `minimum_issue_age` STRING COMMENT 'State-approved minimum age at which this product can be issued in this jurisdiction. Enforces state-specific age requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for next regulatory review or rate filing update required by the state. Used for compliance calendar and proactive filing management.',
    `nonforfeiture_options_approved` STRING COMMENT 'State-approved nonforfeiture options available to policyholders upon lapse or surrender, including cash surrender value (CSV), reduced paid-up insurance, and extended term insurance.',
    `objection_history` STRING COMMENT 'Narrative log of all objections, questions, or concerns raised by the state DOI examiner during the review process, including dates and resolution status.',
    `policy_loan_provisions_approved` BOOLEAN COMMENT 'Indicates whether state-approved policy loan provisions are included in this product for this jurisdiction. True if policy loans are available per state requirements.',
    `rate_guarantee_period_months` STRING COMMENT 'Number of months for which premium rates are guaranteed as approved by the state. Applicable to term life and other products with rate guarantee provisions.',
    `replacement_regulations_apply` BOOLEAN COMMENT 'Indicates whether state replacement regulations apply to this product, requiring specific disclosures and procedures when replacing existing coverage.',
    `sec_filing_reference` STRING COMMENT 'SEC filing reference number for variable products requiring securities registration. Null for non-variable products not subject to SEC oversight.',
    `sec_filing_required` BOOLEAN COMMENT 'Indicates whether this product requires SEC registration and filing due to variable product features (VUL, variable annuities). True for variable products subject to securities regulation.',
    `serff_tracking_number` STRING COMMENT 'NAIC SERFF system tracking number assigned when the filing is submitted through the electronic filing portal. Used for multi-state coordination and DOI communication.',
    `state_specific_exclusions` STRING COMMENT 'State-mandated or state-specific policy exclusions, limitations, or restrictions that differ from the base product design. Critical for policy administration compliance.',
    `state_specific_riders_approved` STRING COMMENT 'Comma-separated list of optional riders and benefits approved for attachment to this product in this state, including form numbers and effective dates.',
    `submitted_forms_list` STRING COMMENT 'Comma-separated list of all policy forms, riders, rate schedules, and amendments included in this filing submission. References document management system for full form text.',
    `target_states` STRING COMMENT 'Comma-separated list of all US state and territory codes where this filing was submitted. Used for multi-state filing coordination and tracking.',
    `underwriting_class_restrictions` STRING COMMENT 'State-specific restrictions or requirements on underwriting classes, rate bands, or risk classification methods approved for this product in this jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this state approval record was last modified. Tracks changes to filing status, approval outcomes, and regulatory correspondence.',
    `withdrawal_date` DATE COMMENT 'Date when the product was withdrawn from sale in this state, either voluntarily by the company or mandated by the state DOI. Null if still active.',
    CONSTRAINT pk_state_approval PRIMARY KEY(`state_approval_id`)
) COMMENT 'SSOT for the full regulatory filing, document workflow, and approval lifecycle for each product plan version across all US states and territories. Covers the complete workflow from initial filing preparation through state-level approval: filing reference number, SERFF tracking number, filing type (new product, rate revision, form amendment), submitted forms list, actuarial memorandum reference, filing date, target states, filing status, objection history, DOI examiner correspondence, approval correspondence, and document workflow tracking. Tracks per-state approval outcomes: state code, approval date, approval number, form number, effective date in state, and withdrawal date. Supports NAIC state filing coordination, SEC filings for variable products, and DOI examination responses. Governs which product plans can be sold in each jurisdiction and enforces distribution channel compliance. This is the single source of truth for ALL product regulatory filing and approval data — no other product in this domain stores filing metadata or approval records.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`filing` (
    `filing_id` BIGINT COMMENT 'Unique identifier for the product filing record. Primary key for the product filing entity.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Product filings generate regulatory submission documents (actuarial memoranda, rate justifications, SERFF submissions, approval correspondence). Real business process: state DOI approval workflow and ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Regulatory filings (SERFF) are submitted by legal entities to state DOIs using NAIC company codes. Essential for tracking filing status by entity, managing multi-carrier product portfolios, and regula',
    `plan_id` BIGINT COMMENT 'Reference to the product plan being filed for regulatory approval.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Product filings are version-specific regulatory submissions. Each version change typically requires a new filing (rate changes, benefit modifications, form updates). The filing tracks approval_date, e',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Product filings (form/rate submissions to state DOIs) are submitted to satisfy specific regulatory obligations (state approval requirements for new products, rate changes, form amendments). Each filin',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Product filings are submitted to comply with specific state regulations. Compliance officers must link each filing to its governing state_regulation for regulatory change management and re-filing trig',
    `superseded_by_filing_id` BIGINT COMMENT 'Reference to a subsequent filing that supersedes or replaces this filing, creating a version chain for product filing history.',
    `actual_review_duration_days` STRING COMMENT 'The actual number of calendar days from filing submission to final approval or rejection, used for process improvement and future estimation.',
    `actuarial_memorandum_reference` STRING COMMENT 'Document reference or identifier for the actuarial memorandum supporting the rate and reserve adequacy for this product filing.',
    `approval_correspondence_reference` STRING COMMENT 'Document reference or identifier for the official approval letter or correspondence from the regulatory authority confirming the filing approval.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority officially approved the filing, allowing the product to be marketed and sold in the jurisdiction.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this product filing record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which the approved filing becomes effective and the product can be legally sold or the rate changes take effect.',
    `estimated_review_duration_days` STRING COMMENT 'The estimated number of calendar days for regulatory review based on state-specific timelines and filing complexity.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The total regulatory filing fee paid to state Departments of Insurance or the SEC for processing this filing, in US dollars.',
    `filing_date` DATE COMMENT 'The date on which the filing was officially submitted to the regulatory authority or SERFF system.',
    `filing_method` STRING COMMENT 'The channel or mechanism used to submit the filing: SERFF electronic system, state-specific portal, paper mail, or email.. Valid values are `serff_electronic|state_portal|paper_mail|email`',
    `filing_status` STRING COMMENT 'Current lifecycle status of the filing in the regulatory approval workflow: draft, submitted, under review, objection issued, approved, rejected, withdrawn, or superseded by a later filing. [ENUM-REF-CANDIDATE: draft|submitted|under_review|objection_issued|approved|rejected|withdrawn|superseded — 8 candidates stripped; promote to reference product]',
    `filing_type` STRING COMMENT 'The category of regulatory filing being submitted: new product introduction, rate revision, form amendment, withdrawal, objection response, or resubmission after rejection.. Valid values are `new_product|rate_revision|form_amendment|withdrawal|objection_response|resubmission`',
    `irc_7702_compliance_certification` BOOLEAN COMMENT 'Indicates whether the filing includes certification that the product design complies with IRC Section 7702 life insurance tax qualification requirements (guideline premium test or cash value accumulation test).',
    `notes` STRING COMMENT 'Free-text field for internal notes, special instructions, or context regarding this filing that may be relevant for future reference or audit.',
    `objection_description` STRING COMMENT 'Detailed narrative of the regulatory objections, deficiencies, or concerns raised by the Department of Insurance or SEC regarding this filing.',
    `objection_issued_date` DATE COMMENT 'The date on which the regulatory authority issued an objection, deficiency letter, or request for additional information regarding this filing.',
    `objection_response_date` DATE COMMENT 'The date on which the company submitted its formal response to regulatory objections or deficiency letters.',
    `priority` STRING COMMENT 'Business priority assigned to this filing for internal tracking and resource allocation: expedited for time-sensitive launches, standard for routine filings, low for non-critical updates.. Valid values are `expedited|standard|low`',
    `prospectus_date` DATE COMMENT 'The effective date of the SEC-approved prospectus for variable products, marking when the product can be legally sold.',
    `rate_filing_justification` STRING COMMENT 'Narrative explanation and business rationale for the proposed rates, including competitive positioning, experience data, and actuarial assumptions.',
    `reference_number` STRING COMMENT 'The externally-known unique reference number assigned to this regulatory filing by the company or filing system.',
    `rejection_date` DATE COMMENT 'The date on which the regulatory authority formally rejected the filing, requiring withdrawal or substantial resubmission.',
    `rejection_reason` STRING COMMENT 'Detailed explanation from the regulatory authority for why the filing was rejected, including specific regulatory violations or deficiencies.',
    `sec_file_number` STRING COMMENT 'The SEC registration file number for variable products (e.g., 333-XXXXXX for Securities Act registration, 811-XXXXX for Investment Company Act registration).',
    `sec_registration_required` BOOLEAN COMMENT 'Indicates whether this product is a variable product requiring SEC registration and prospectus filing under the Securities Act of 1933 and Investment Company Act of 1940.',
    `serff_tracking_number` STRING COMMENT 'The unique tracking number assigned by the NAIC SERFF system for electronic filing submission and tracking across state Departments of Insurance.. Valid values are `^[A-Z]{2,4}-d{6,10}$`',
    `submitted_forms_list` STRING COMMENT 'Comma-separated list of form numbers and document identifiers included in this filing package (e.g., policy forms, riders, rate schedules, illustrations).',
    `target_states` STRING COMMENT 'Comma-separated list of state postal codes (e.g., NY,CA,TX) where this product filing is being submitted for approval. Each state requires separate approval.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this product filing record was last modified, tracking the most recent change to filing status or metadata.',
    `withdrawal_date` DATE COMMENT 'The date on which the company voluntarily withdrew the filing from regulatory review, typically due to business strategy changes or unresolvable objections.',
    `withdrawal_reason` STRING COMMENT 'Business rationale for voluntarily withdrawing the filing, such as market conditions, strategic pivot, or inability to address regulatory concerns.',
    CONSTRAINT pk_filing PRIMARY KEY(`filing_id`)
) COMMENT 'Manages the regulatory filing metadata for product plans submitted to state Departments of Insurance (DOI) and the SEC (for variable products). Captures filing reference number, SERFF tracking number, filing type, submitted forms list, actuarial memorandum reference, filing date, target states, filing status, objection history, and approval correspondence. Distinct from state_approval as it tracks the filing process and document workflow, not the final approval outcome per state.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` (
    `irc7702_parameter_id` BIGINT COMMENT 'Unique identifier for the IRC 7702 tax qualification parameter record. Primary key.',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: IRC 7702 compliance parameters are backed by authoritative IRS guidance documents, determination letters, and private letter rulings. Actuarial and compliance teams must trace each parameter set to it',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: IRC 7702 compliance parameters are maintained per legal entity because each insurance company files separate tax returns and holds distinct IRS determination letters. Tax provision calculations and ir',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product plan to which these IRC 7702 parameters apply.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: IRC 7702 tax qualification parameters can change between product versions (guideline premiums, corridor factors, mortality assumptions). Each version may have different tax parameters. The parameter_v',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IRC 7702 parameters are governed by specific IRS regulatory obligations. Compliance teams must track which regulatory_obligation (e.g., SECURE 2.0 IRC 7702 update, TAMRA) governs each parameter set fo',
    `actuarial_certification_flag` BOOLEAN COMMENT 'Indicates whether a qualified actuary has certified that these IRC 7702 parameters comply with IRS requirements and are actuarially sound. True indicates certification is on file. Actuarial certification is required for product filings and regulatory compliance.',
    `attained_age_basis` STRING COMMENT 'The insureds attained age used to determine the applicable corridor percentage and mortality assumptions for IRC 7702 calculations. Corridor percentages are age-banded, typically changing at ages 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, and 95.',
    `catch_up_contribution_limit` DECIMAL(18,2) COMMENT 'The additional annual contribution amount permitted for participants age 50 and older under IRC Section 414(v). For 2024, the catch-up limit is $7,500 for 401(k) plans and $1,000 for IRAs. Catch-up contributions allow older workers to accelerate retirement savings.',
    `compliance_review_date` DATE COMMENT 'The date the most recent compliance review of these IRC 7702 parameters was completed. Compliance reviews ensure parameters remain aligned with current IRS guidance and state regulations. Typically performed annually or when significant tax law changes occur.',
    `compliance_reviewer_name` STRING COMMENT 'Name of the compliance officer or actuary who performed the most recent review of these IRC 7702 parameters. Provides accountability and audit trail for compliance certification.',
    `contribution_limit_annual` DECIMAL(18,2) COMMENT 'The maximum annual contribution amount permitted under IRC rules for this qualified plan type. For 2024, 401(k) elective deferrals are limited to $23,000, IRA contributions to $7,000, with catch-up contributions allowed for participants age 50+. Limits are indexed annually for inflation.',
    `corridor_percentage` DECIMAL(18,2) COMMENT 'The minimum death benefit as a percentage of cash value required to maintain life insurance tax qualification under IRC 7702. The corridor percentage decreases as the insureds attained age increases. For example, at age 40 the corridor might be 250%, meaning death benefit must be at least 2.5 times cash value.',
    `cost_basis_recovery_method` STRING COMMENT 'The method used to determine the taxable and non-taxable portions of distributions when the contract has both pre-tax and after-tax basis. Pro-rata method allocates each distribution proportionally between basis and earnings. FIFO (first-in, first-out) treats basis as distributed first. LIFO (last-in, first-out) treats earnings as distributed first. Specific identification allows the taxpayer to designate which dollars are distributed.. Valid values are `pro_rata|FIFO|LIFO|specific_identification`',
    `default_withholding_rate` DECIMAL(18,2) COMMENT 'The default federal income tax withholding rate applied to distributions if the payee does not make an election. For eligible rollover distributions from qualified plans, the mandatory rate is 20%. For periodic payments, the default is based on withholding tables. For non-periodic payments, the default is 10%.',
    `definition_test_type` STRING COMMENT 'The IRC 7702 test selected to qualify the product as life insurance for tax purposes. CVAT (Cash Value Accumulation Test) compares cash value to net single premium. GPT (Guideline Premium Test) limits premiums to guideline single premium and guideline level premium amounts. The insurer must elect one test at policy issue and cannot change it.. Valid values are `CVAT|GPT`',
    `determination_letter_date` DATE COMMENT 'The date the IRS issued a determination letter confirming the qualified status of the plan. Determination letters provide assurance that a plans form (plan document) complies with IRC requirements. The IRS discontinued the determination letter program for individually designed plans in 2017 but continues it for pre-approved plans.',
    `direct_rollover_option_flag` BOOLEAN COMMENT 'Indicates whether the plan offers a direct rollover option, allowing the participant to transfer an eligible rollover distribution directly to another qualified plan or IRA without taking constructive receipt. Direct rollovers avoid the mandatory 20% withholding that applies to indirect rollovers from qualified plans.',
    `early_withdrawal_penalty_rate` DECIMAL(18,2) COMMENT 'The IRS penalty rate applied to early distributions from qualified plans and IRAs. Generally 10% of the taxable amount for distributions before age 59½, unless an exception applies (disability, death, substantially equal periodic payments, first-time home purchase, qualified education expenses, etc.).',
    `effective_date` DATE COMMENT 'The date these IRC 7702 parameters become effective for the product plan. Typically the date the product is filed with and approved by state insurance departments, or the date IRS guidance becomes effective. Parameters are locked in at policy issue and generally do not change over the policy life.',
    `erisa_applicability_flag` BOOLEAN COMMENT 'Indicates whether the Employee Retirement Income Security Act of 1974 applies to this product plan. True for employer-sponsored qualified plans (401(k), 403(b), defined benefit plans). False for individual IRAs, governmental plans, and church plans. ERISA imposes fiduciary standards, reporting requirements, and participant protections.',
    `exclusion_ratio` DECIMAL(18,2) COMMENT 'The ratio used to determine the tax-free portion of each annuity payment under IRC Section 72(b). Calculated as the investment in the contract (after-tax basis) divided by the expected return. The exclusion ratio remains constant for the life of the annuity. Once the entire investment is recovered, all subsequent payments are fully taxable.',
    `expiration_date` DATE COMMENT 'The date these IRC 7702 parameters expire or are superseded by updated parameters. Null if the parameters remain in effect indefinitely. Parameters may be updated when IRS guidance changes, when mortality tables are updated, or when the product is re-filed.',
    `guideline_level_premium` DECIMAL(18,2) COMMENT 'The maximum level annual premium amount allowed under the GPT test of IRC 7702. Calculated as the level annual premium required to fund future benefits over the policy term based on specified mortality and interest assumptions. Cumulative premiums cannot exceed the greater of GLP or GSP.',
    `guideline_single_premium` DECIMAL(18,2) COMMENT 'The maximum single premium amount allowed under the GPT test of IRC 7702. Calculated as the premium required to fund future benefits based on specified mortality and interest assumptions. Exceeding this amount causes the policy to fail the GPT test and lose tax-qualified status.',
    `interest_rate_assumption` DECIMAL(18,2) COMMENT 'The interest rate assumption used in IRC 7702 guideline premium and cash value accumulation test calculations. IRC 7702(c)(3) specifies the greater of 4% or the rate guaranteed on policy issue. This rate is locked in at issue and does not change over the policy life.',
    `irc_section_code` STRING COMMENT 'The applicable IRC section governing tax qualification for this product plan. IRC 7702 defines life insurance for tax purposes, 7702A covers MEC testing, 72 covers annuity taxation, 401/403/408 cover qualified plans and IRAs, and ERISA covers employee benefit plan requirements. [ENUM-REF-CANDIDATE: 7702|7702A|72|401|403|408|ERISA — 7 candidates stripped; promote to reference product]',
    `irs_guidance_reference` STRING COMMENT 'Citation to the specific IRS guidance, revenue ruling, revenue procedure, notice, or announcement that governs these tax parameters. Examples: Rev. Rul. 2009-13 (corridor percentages), Notice 2008-42 (7702 interest rates), Rev. Proc. 2021-20 (mortality tables). Provides traceability to authoritative IRS sources.',
    `last_updated_date` DATE COMMENT 'The date these IRC 7702 parameter records were last updated in the system. Used for audit trail and change tracking. Updates may occur when IRS guidance changes, when errors are corrected, or when product filings are amended.',
    `mec_status_flag` BOOLEAN COMMENT 'Indicates whether the product plan is classified as a Modified Endowment Contract under IRC 7702A. True if the policy fails the seven-pay test. MEC status subjects policy loans and withdrawals to income taxation and a 10% penalty on the gain portion if taken before age 59½.',
    `mortality_table_basis` STRING COMMENT 'The mortality table used for IRC 7702 calculations. Must be a table permitted under IRC 7702(c)(3)(B)(i), typically the Commissioners Standard Ordinary (CSO) mortality table in effect at policy issue. Examples include 2001 CSO, 2017 CSO. The table is specified by the IRS and locked in at issue.',
    `naic_model_regulation_reference` STRING COMMENT 'Citation to the NAIC Model Regulation that governs the implementation of IRC 7702 requirements at the state level. The NAIC Standard Nonforfeiture Law and Model Variable Annuity Regulation incorporate IRC 7702 requirements. States adopt NAIC models with variations.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, clarifications, or special instructions related to these IRC 7702 parameters. May include information about product-specific interpretations, historical changes, or pending regulatory updates.',
    `parameter_version_number` STRING COMMENT 'Version number for this set of IRC 7702 parameters. Incremented each time parameters are updated. Supports historical tracking and ensures policies issued under prior versions retain their original parameters.',
    `private_letter_ruling_number` STRING COMMENT 'The IRS Private Letter Ruling number, if the insurer obtained a ruling on the tax treatment of this product plan. PLRs provide written guidance from the IRS on the tax consequences of a specific transaction. Format is typically YYYYWWXXX (year, week, sequence). PLRs are binding only for the taxpayer who requested them but provide insight into IRS positions.',
    `qualification_type` STRING COMMENT 'The tax qualification status of the product plan. Qualified products receive favorable tax treatment under IRC sections 401/403/408. Non-qualified products do not meet qualified plan requirements. Modified endowment contracts (MEC) are life insurance policies that fail the seven-pay test under IRC 7702A. Tax-deferred products allow earnings to accumulate without current taxation. Taxable products have no special tax treatment.. Valid values are `qualified|non-qualified|modified_endowment|tax_deferred|taxable`',
    `qualified_plan_type` STRING COMMENT 'The type of qualified retirement plan under which this product is issued, if applicable. 401(k) and 401(a) are employer-sponsored defined contribution plans. 403(b) plans are for public schools and tax-exempt organizations. 457(b) plans are for state and local government employees. IRA and Roth IRA are individual retirement accounts. SEP and SIMPLE are small employer plans. [ENUM-REF-CANDIDATE: 401k|401a|403b|457b|IRA|Roth_IRA|SEP|SIMPLE — 8 candidates stripped; promote to reference product]',
    `rmd_applicability_flag` BOOLEAN COMMENT 'Indicates whether Required Minimum Distributions under IRC Section 401(a)(9) apply to this product plan. True for qualified plans, traditional IRAs, and tax-deferred annuities. RMDs must begin by April 1 of the year following the year the participant reaches age 73 (as of 2023, per SECURE 2.0 Act). False for Roth IRAs and non-qualified products.',
    `rmd_calculation_method` STRING COMMENT 'The IRS-approved method for calculating required minimum distributions. Uniform Lifetime Table is the default for most account owners. Joint Life and Last Survivor Expectancy Table applies when the sole beneficiary is a spouse more than 10 years younger. Single Life Expectancy Table applies to beneficiaries. Fixed term applies to certain annuity contracts.. Valid values are `uniform_lifetime|joint_life|single_life|fixed_term`',
    `rollover_eligibility_flag` BOOLEAN COMMENT 'Indicates whether distributions from this product plan are eligible for tax-free rollover to another qualified plan or IRA under IRC Section 402(c). True for most qualified plan distributions and traditional IRA distributions. False for required minimum distributions, hardship withdrawals, substantially equal periodic payments, and certain other distributions.',
    `seven_pay_premium_limit` DECIMAL(18,2) COMMENT 'The maximum cumulative premium that can be paid in the first seven policy years (or first seven years after a material change) without causing the policy to become a Modified Endowment Contract (MEC) under IRC 7702A. Calculated as seven times the net level premium required to fund paid-up future benefits.',
    `state_variation_notes` STRING COMMENT 'Free-text notes describing any state-specific variations in the application of IRC 7702 parameters. While IRC 7702 is federal law, states may impose additional requirements or interpretations through insurance regulations. Documents any state-by-state differences in product filing requirements or tax treatment.',
    `tamra_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product plan complies with TAMRA 1988 requirements for MEC testing under IRC 7702A. TAMRA introduced the seven-pay test and material change rules. True indicates the product design and administration procedures meet TAMRA compliance standards.',
    `tax_disclosure_requirement` STRING COMMENT 'Description of the tax disclosure obligations the insurer must provide to policyholders. Includes required notices about tax consequences of distributions, rollovers, MEC status, and withholding elections. Disclosures must be provided at policy issue, at distribution, and when material changes occur.',
    `tax_reporting_code` STRING COMMENT 'The IRS form code used to report distributions, interest, or contributions for this product plan. 1099-R reports distributions from pensions, annuities, retirement plans, IRAs, and life insurance contracts. 1099-INT reports interest income. 1099-MISC reports miscellaneous income. 5498 reports IRA contributions. W-2 reports wages for employer-sponsored plans.. Valid values are `1099-R|1099-INT|1099-MISC|5498|W-2`',
    `withholding_requirement_type` STRING COMMENT 'The type of federal income tax withholding required for distributions from this product plan. Mandatory withholding applies to eligible rollover distributions from qualified plans (20% default). Optional withholding allows the payee to elect withholding. Exempt distributions have no withholding requirement. Backup withholding (24%) applies when the payee fails to provide a valid TIN.. Valid values are `mandatory|optional|exempt|backup`',
    CONSTRAINT pk_irc7702_parameter PRIMARY KEY(`irc7702_parameter_id`)
) COMMENT 'SSOT for all tax qualification status, compliance parameters, and tax reporting requirements for each product plan under applicable IRC sections. Covers IRC 7702 (life insurance definition, CVAT/GPT test selection, guideline single premium, guideline level premium, cash value corridor percentages by attained age, interest rate assumptions, mortality table basis), IRC 7702A (MEC testing, seven-pay premium limits, TAMRA compliance), IRC 72 (annuity taxation), IRC 401/403/408 (qualified plan and IRA eligibility), and ERISA applicability. Captures qualification type, applicable IRC sections, tax reporting codes (1099-R, 1099-INT), withholding requirements, RMD applicability, IRS private letter ruling references, and policyholder tax disclosure obligations. This is the single source of truth for ALL product tax qualification and IRC compliance data — no other product in this domain stores tax qualification parameters.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`crediting_strategy` (
    `crediting_strategy_id` BIGINT COMMENT 'Unique identifier for the crediting strategy. Primary key for the crediting strategy entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Index crediting strategies (IUL/FIA) require specific GL accounts for option costs, hedging expenses, and interest crediting. Required for derivative accounting (ASC 815), expense allocation, and prod',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Crediting strategies for IUL/FIA products involve entity-specific hedging programs tracked via hedging_cost_basis. Option budgets, declared rates, and hedge P&L attribution are managed at the legal en',
    `plan_id` BIGINT COMMENT 'Reference to the parent product (FIA or IUL) to which this crediting strategy is available.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Crediting strategies for FIA/IUL products can change between versions (cap rates, participation rates, new index options). Each version may offer different crediting options. The effective_date and te',
    `allocation_maximum_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of account value that can be allocated to this strategy, expressed as a decimal (e.g., 1.0000 for 100% maximum, or 0.5000 for 50% cap). Null if no maximum.',
    `allocation_minimum_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of account value that must be allocated to this strategy if selected, expressed as a decimal (e.g., 0.0500 for 5% minimum). Null if no minimum.',
    `buffer_rate` DECIMAL(18,2) COMMENT 'Percentage of index loss absorbed by the insurer before policyholder account is affected, expressed as a decimal (e.g., 0.1000 for 10% buffer). Null if no buffer applies.',
    `cap_rate` DECIMAL(18,2) COMMENT 'Maximum interest rate that can be credited in a given period, expressed as a decimal (e.g., 0.0650 for 6.50% cap). Null if no cap applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crediting strategy record was first created in the system.',
    `crediting_method` STRING COMMENT 'The calculation methodology used to determine interest credits: annual point-to-point (index change over 12 months), monthly average (average of monthly index values), monthly sum (sum of monthly changes), participation rate (percentage of index gain), or declared rate (fixed interest rate set by insurer).. Valid values are `annual_point_to_point|monthly_average|monthly_sum|participation_rate|declared_rate`',
    `declared_rate` DECIMAL(18,2) COMMENT 'Fixed interest rate declared by the insurer for fixed account strategies, expressed as a decimal (e.g., 0.0325 for 3.25%). Null for indexed strategies.',
    `effective_date` DATE COMMENT 'Date on which this crediting strategy became available for policyholder selection and allocation.',
    `filing_number` STRING COMMENT 'Regulatory filing or approval number assigned by the state insurance department for this crediting strategy or its parent product.',
    `floor_rate` DECIMAL(18,2) COMMENT 'Minimum interest rate guaranteed for the crediting period, expressed as a decimal (e.g., 0.0000 for 0% floor, ensuring no negative credits). Typically 0% for indexed strategies.',
    `guaranteed_minimum_rate` DECIMAL(18,2) COMMENT 'Contractually guaranteed minimum interest rate over the life of the contract, expressed as a decimal (e.g., 0.0100 for 1.00% guaranteed minimum). Required by state insurance regulations.',
    `hedging_cost_basis` STRING COMMENT 'Internal description of the derivative hedging strategy and cost structure used by the insurer to support this crediting strategy. Used for actuarial pricing and profitability analysis.',
    `historical_average_credit_rate` DECIMAL(18,2) COMMENT 'Average interest rate credited over the historical performance period of this strategy, expressed as a decimal. Used for performance reporting and disclosure. Null for newly launched strategies.',
    `illustration_rate` DECIMAL(18,2) COMMENT 'Interest rate used for policy illustration and sales projection purposes, expressed as a decimal (e.g., 0.0500 for 5.00%). Must comply with NAIC illustration actuary guidelines.',
    `index_calculation_method` STRING COMMENT 'Detailed description of how the index value is calculated, including whether dividends are included, averaging methodology, and any adjustments applied (e.g., price return only, total return, equal-weighted).',
    `index_type` STRING COMMENT 'The market index or benchmark underlying the crediting strategy (e.g., S&P 500, Russell 2000, MSCI EAFE, Nasdaq 100, blended composite, or FIXED for non-indexed strategies). [ENUM-REF-CANDIDATE: SP500|RUSSELL2000|MSCI_EAFE|NASDAQ100|BLENDED|FIXED|CUSTOM — 7 candidates stripped; promote to reference product]',
    `irc_7702_compliant_flag` BOOLEAN COMMENT 'Indicates whether this crediting strategy meets IRC Section 7702 requirements for life insurance tax qualification. True if compliant, False otherwise. Applicable to IUL products.',
    `last_updated_by_user` STRING COMMENT 'User ID or system identifier of the person or process that most recently modified this crediting strategy record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this crediting strategy record was most recently modified.',
    `participation_rate` DECIMAL(18,2) COMMENT 'Percentage of index gain credited to the account, expressed as a decimal (e.g., 0.8500 for 85% participation). Null if participation method is not used.',
    `performance_lookback_start_date` DATE COMMENT 'Start date of the historical performance period used to calculate average credit rates and backtested results for disclosure purposes.',
    `rate_lock_period_months` STRING COMMENT 'Number of months for which the current cap, participation, or spread rates are guaranteed before potential adjustment. Null if rates are guaranteed for contract life.',
    `renewal_rate_adjustment_flag` BOOLEAN COMMENT 'Indicates whether cap, participation, or spread rates are subject to adjustment at renewal periods. True if rates may be adjusted, False if rates are guaranteed for the contract term.',
    `reset_frequency` STRING COMMENT 'Frequency at which index values are measured and interest is credited: annual (12-month period), monthly (1-month period), biennial (24-month period), or custom.. Valid values are `annual|monthly|biennial|custom`',
    `spread_rate` DECIMAL(18,2) COMMENT 'Percentage deducted from index gain before crediting (also called margin or asset fee), expressed as a decimal (e.g., 0.0200 for 2.00% spread). Null if no spread applies.',
    `state_approval_jurisdiction` STRING COMMENT 'Comma-separated list of two-letter state codes where this crediting strategy has received regulatory approval for sale (e.g., NY,CA,TX,FL). ALL for nationwide approval.. Valid values are `^[A-Z]{2}(,[A-Z]{2})*$`',
    `strategy_availability_status` STRING COMMENT 'Current availability status of the crediting strategy: active (available for new and existing allocations), suspended (existing allocations continue but no new allocations), closed (no longer available), pending_approval (awaiting regulatory approval).. Valid values are `active|suspended|closed|pending_approval`',
    `strategy_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the crediting strategy within the product line (e.g., SP500_PTP, RUS2K_MA, FIXED_DCA).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `strategy_description` STRING COMMENT 'Detailed business description of the crediting strategy, including how it works, risk/reward profile, and suitability considerations for policyholder education and disclosure.',
    `strategy_name` STRING COMMENT 'Full business name of the crediting strategy as presented to policyholders and agents (e.g., S&P 500 Annual Point-to-Point with Cap, Fixed Account Declared Rate).',
    `strategy_notes` STRING COMMENT 'Free-form text field for internal notes, special instructions, or additional context about this crediting strategy (e.g., pricing assumptions, competitive positioning, distribution channel restrictions).',
    `strategy_rank_order` STRING COMMENT 'Display order or ranking of this strategy in policyholder materials, agent tools, and online portals. Lower numbers appear first.',
    `strategy_type` STRING COMMENT 'High-level classification of the crediting strategy: indexed (linked to market index), fixed (declared rate), or hybrid (combination).. Valid values are `indexed|fixed|hybrid`',
    `target_market_segment` STRING COMMENT 'Description of the intended policyholder demographic or risk profile for whom this strategy is designed (e.g., conservative investors seeking downside protection, growth-oriented accumulators, income-focused retirees).',
    `termination_date` DATE COMMENT 'Date on which this crediting strategy was discontinued or closed to new allocations. Null if still active.',
    CONSTRAINT pk_crediting_strategy PRIMARY KEY(`crediting_strategy_id`)
) COMMENT 'Defines the interest crediting strategies available for fixed indexed annuity (FIA) and indexed universal life (IUL) products, including strategy name, index type (S&P 500, Russell 2000, MSCI EAFE, blended), crediting method (annual point-to-point, monthly average, monthly cap, participation rate), cap rate, participation rate, spread/margin, floor rate, buffer rate, and declared rate for fixed accounts. Captures strategy availability by product plan, minimum and maximum allocation percentages, and reset frequency.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`charge_schedule` (
    `charge_schedule_id` BIGINT COMMENT 'Primary key for charge_schedule',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Charge schedules (M&E fees, surrender charges, admin fees) must map to specific GL accounts for GAAP revenue recognition and SAP statutory reporting. Finance teams require this link to automate journa',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product to which this charge schedule applies. Links to the product master catalog.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Product charge schedules (surrender charges, fees) are version-specific. Charge changes may trigger new versions. The charge_schedule_version and predecessor_schedule_id suggest version-level tracking',
    `predecessor_schedule_charge_schedule_id` BIGINT COMMENT 'Reference to the previous version of this charge schedule if this is a revision. NULL for the initial version. Enables lineage tracking and historical analysis.',
    `rate_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_filing. Business justification: Surrender charge schedules and expense charges for LTC and annuity products require regulatory rate filing approval. The charge_schedule must reference its governing compliance rate_filing. filing_num',
    `approval_date` DATE COMMENT 'Date on which the state insurance department approved this charge schedule for use. Required for regulatory compliance and audit trails.',
    `charge_amount_flat` DECIMAL(18,2) COMMENT 'Fixed dollar amount of the charge when charge_basis is flat_dollar. Used for per-policy administrative fees or fixed withdrawal processing fees. NULL for percentage-based charges.',
    `charge_basis` STRING COMMENT 'The calculation basis for the charge. Determines how the charge amount is computed: as a percentage of premium paid, percentage of account value (AV), flat dollar amount per policy, per $1,000 of face amount, or percentage of withdrawal amount.. Valid values are `percentage_of_premium|percentage_of_account_value|flat_dollar|per_thousand_face|percentage_of_withdrawal`',
    `charge_cap_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be charged under this schedule, regardless of the calculated charge. Used to limit total charges on high-value policies. NULL if no cap applies.',
    `charge_floor_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount that will be charged under this schedule, regardless of the calculated charge. Used to ensure minimum cost recovery. NULL if no floor applies.',
    `charge_frequency` STRING COMMENT 'Frequency at which the charge is assessed. One-time charges apply at a single event (e.g., surrender); recurring charges apply monthly, quarterly, or annually; per-transaction charges apply each time a specific transaction occurs.. Valid values are `one_time|monthly|quarterly|annual|per_transaction`',
    `charge_schedule_code` STRING COMMENT 'Unique business identifier for the charge schedule. Used in policy administration systems and illustrations to reference specific charge structures.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `charge_schedule_name` STRING COMMENT 'Human-readable name of the charge schedule for business user identification and reporting purposes.',
    `charge_schedule_status` STRING COMMENT 'Current lifecycle status of the charge schedule. Active schedules are in use for new business; pending approval schedules are awaiting regulatory approval; approved schedules are ready for use; inactive schedules are no longer offered; superseded schedules have been replaced by newer versions.. Valid values are `active|pending_approval|approved|inactive|superseded`',
    `charge_type` STRING COMMENT 'Classification of the charge or fee. Surrender charges are back-end loads applied when policies are surrendered; premium loads are front-end charges on premium payments; admin fees are per-policy or per-unit charges; M&E charges are mortality and expense risk charges for variable products; fund management fees are investment management charges; withdrawal fees apply to partial withdrawals.. Valid values are `surrender_charge|premium_load|admin_fee|mortality_expense_charge|fund_management_fee|withdrawal_fee`',
    `competitive_positioning` STRING COMMENT 'Strategic market positioning of this charge schedule. Premium indicates higher charges with enhanced features; competitive indicates market-rate charges; value indicates lower charges for cost-conscious segments. Confidential business strategy.. Valid values are `premium|competitive|value`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this charge schedule record was first created in the system. Used for audit trails and data lineage.',
    `current_charge_rate` DECIMAL(18,2) COMMENT 'The current charge rate being applied to in-force policies. Must be less than or equal to the guaranteed charge rate. For percentage-based charges, expressed as a decimal. For flat charges, expressed in dollars. This rate may be adjusted by the company within guaranteed limits.',
    `dac_tax_treatment` STRING COMMENT 'Tax treatment of this charge for Deferred Acquisition Cost purposes under IRC Section 848. Indicates whether the charge is capitalized and amortized, immediately expensed, or not subject to DAC tax rules.. Valid values are `capitalized|expensed|not_applicable`',
    `effective_date` DATE COMMENT 'Date on which this charge schedule becomes effective for new policies or in-force policy changes. Must align with state approval dates and product filing effective dates.',
    `expiration_date` DATE COMMENT 'Date on which this charge schedule is no longer available for new policies. NULL indicates the schedule is currently active with no planned expiration. In-force policies continue under their original schedule.',
    `free_withdrawal_percentage` DECIMAL(18,2) COMMENT 'The percentage of account value (AV) or cash surrender value (CSV) that can be withdrawn annually without incurring surrender charges. Commonly 10% for annuities. Expressed as a decimal (e.g., 0.10 for 10%). NULL if no free withdrawal provision exists.',
    `gaap_revenue_recognition` STRING COMMENT 'GAAP revenue recognition method for this charge under FASB ASC 944 and LDTI (Long Duration Targeted Improvements). Indicates whether revenue is recognized immediately, deferred, or recognized over the coverage period.. Valid values are `immediate|deferred|over_coverage_period`',
    `guaranteed_charge_rate` DECIMAL(18,2) COMMENT 'The maximum charge rate guaranteed in the policy contract. This is the contractual ceiling that cannot be exceeded. For percentage-based charges, expressed as a decimal (e.g., 0.0125 for 1.25%). For flat charges, expressed in dollars.',
    `illustration_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this charge must be explicitly disclosed in policy illustrations and sales materials. True if disclosure is required by regulation or company policy; False otherwise.',
    `irc_7702_compliant_flag` BOOLEAN COMMENT 'Indicates whether this charge schedule complies with IRC Section 7702 requirements for life insurance tax qualification. Charges must be reasonable and not excessive to maintain tax-favored status. True if compliant; False otherwise.',
    `last_updated_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this charge schedule record. Used for audit trails and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this charge schedule record was last modified. Used for audit trails, change tracking, and data quality monitoring.',
    `mva_applicable_flag` BOOLEAN COMMENT 'Indicates whether a Market Value Adjustment applies to surrenders or withdrawals under this charge schedule. MVA adjusts the surrender value based on interest rate movements. True if MVA applies; False otherwise.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special conditions, or implementation guidance for this charge schedule. Used for business user reference and operational documentation.',
    `policy_duration_max` STRING COMMENT 'Maximum policy duration (in years) for which this charge schedule applies. NULL indicates no upper limit.',
    `policy_duration_min` STRING COMMENT 'Minimum policy duration (in years) for which this charge schedule applies. Used for charges that vary by policy age or duration bands.',
    `policy_year` STRING COMMENT 'The policy year to which this charge applies. Used primarily for surrender charge schedules that decrease over time. Policy year 1 is the first year after issue; NULL indicates the charge applies across all years.',
    `profitability_target_margin` DECIMAL(18,2) COMMENT 'Target profit margin for this charge schedule as a percentage. Used in product profitability tracking and pricing governance. Confidential business metric.',
    `state_jurisdiction` STRING COMMENT 'Two-letter US state code indicating the regulatory jurisdiction for which this charge schedule is approved. Charge schedules may vary by state due to differing regulatory requirements.. Valid values are `^[A-Z]{2}$`',
    `statutory_accounting_treatment` STRING COMMENT 'Statutory accounting treatment of this charge under NAIC Statutory Accounting Principles. Determines how the charge impacts statutory surplus and Risk-Based Capital (RBC) calculations.. Valid values are `admitted_asset|non_admitted|immediate_income`',
    `version` STRING COMMENT 'Version number of this charge schedule. Incremented when the schedule is revised. Used to track changes over time and ensure in-force policies use the correct historical schedule.',
    `waiver_condition` STRING COMMENT 'Condition under which surrender charges or other fees are waived. Common waivers include nursing home confinement, terminal illness diagnosis, total disability, death of the owner/annuitant, or unemployment. none indicates no waiver provisions.. Valid values are `none|nursing_home_confinement|terminal_illness|disability|death|unemployment`',
    `waiver_waiting_period_days` STRING COMMENT 'Number of days that must elapse after the waiver condition is met before the charge waiver takes effect. Common for nursing home or disability waivers (e.g., 90 days). NULL if no waiting period applies.',
    CONSTRAINT pk_charge_schedule PRIMARY KEY(`charge_schedule_id`)
) COMMENT 'SSOT for all product-level charges, fees, and expense schedules for annuity and UL/IUL/VUL products. Covers surrender charges (back-end loads) by policy year with free withdrawal allowances and MVA applicability, premium load percentages, per-policy administrative fees, per-unit expense charges, mortality and expense (M&E) risk charges for variable products, fund management fees, and surrender processing fees. Captures charge type, charge basis (percentage of premium, flat dollar, per $1,000 face), guaranteed maximum charge, current charge, waiver conditions (nursing home, terminal illness), and effective dates. Governs CSV (Cash Surrender Value) calculations, policyholder liquidity provisions, policy illustration compliance, and in-force expense charge administration. This is the single source of truth for ALL product-level charges and expense loads — no other product in this domain stores charge or fee schedules.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`form` (
    `form_id` BIGINT COMMENT 'Unique identifier for the insurance contract form record. Primary key for the product form catalog.',
    `acord_form_id` BIGINT COMMENT 'Foreign key linking to document.acord_form. Business justification: Life insurance product forms are standardized against ACORD form definitions for e-delivery eligibility, NIGO tracking, and state filing compliance. The forms acord_form_number is a denormalized refe',
    `filing_id` BIGINT COMMENT 'Foreign key linking to product.filing. Business justification: Insurance contract forms are submitted to regulators as part of a regulatory filing. The form table has filing_number STRING and filing_date DATE which are denormalized references to the filing record',
    `plan_id` BIGINT COMMENT 'Reference to the insurance product or plan to which this form applies. Links form to product catalog.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Product forms are version-specific contract documents. Each plan version may have different forms (edition_date, effective_date, expiration_date suggest versioning). Forms must match the approved vers',
    `primary_predecessor_form_id` BIGINT COMMENT 'Reference to the previous version of this form that this edition supersedes. Enables form version lineage tracking and historical policy servicing. Nullable for initial form versions.',
    `template_id` BIGINT COMMENT 'Foreign key linking to document.template. Business justification: Life insurance form generation uses document templates to produce state-specific policy and rider forms. The form products document_template_path is a denormalized reference to the template entity. L',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority officially approved the form for use. Nullable if the form has not yet been approved or does not require approval.',
    `base_form_flag` BOOLEAN COMMENT 'Indicates whether this is a base policy form that serves as the primary contract document, as opposed to a rider, endorsement, or supplementary form.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this form record was first created in the system. Audit trail for data lineage and compliance.',
    `distribution_channel` STRING COMMENT 'Comma-separated list of distribution channels authorized to use this form. Examples include career_agent, independent_agent, broker, bank, direct, worksite, online. Supports channel-specific form variations.',
    `edition_date` DATE COMMENT 'The official edition or version date of the form as printed on the document. This date identifies the specific version of the form and is critical for regulatory compliance and policy administration.',
    `effective_date` DATE COMMENT 'The date from which this form becomes valid for use in new business issuance. Represents the start of the forms active lifecycle.',
    `expiration_date` DATE COMMENT 'The date after which this form is no longer valid for use in new business. Nullable for forms that remain active indefinitely until explicitly superseded.',
    `filing_date` DATE COMMENT 'The date on which the form was officially filed with the regulatory authority for approval.',
    `filing_status` STRING COMMENT 'Status of the regulatory filing for this form with state insurance departments. Tracks whether the form has been filed, approved, rejected, or is pending regulatory review.. Valid values are `not_filed|filed|approved|rejected|withdrawn|pending`',
    `form_category` STRING COMMENT 'Business category of the form indicating its primary purpose within the insurance lifecycle. Distinguishes contract documents from administrative, regulatory, marketing, compliance, or operational forms.. Valid values are `contract|administrative|regulatory|marketing|compliance|operational`',
    `form_description` STRING COMMENT 'Detailed business description of the forms purpose, content, and usage within the policy lifecycle. Provides context for underwriters, administrators, and compliance personnel.',
    `form_name` STRING COMMENT 'The official title or name of the insurance form as it appears on the document and in regulatory filings.',
    `form_number` STRING COMMENT 'The official form number or identifier assigned by the insurance company. This is the externally-known unique identifier used in policy documents, filings, and regulatory submissions.',
    `form_status` STRING COMMENT 'Current lifecycle status of the form. Tracks the forms progression through drafting, regulatory approval, active use, and eventual retirement or supersession. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|retired|superseded — 7 candidates stripped; promote to reference product]',
    `form_type` STRING COMMENT 'Classification of the form document type. Categorizes whether this is a base policy form, application form, rider form, amendment endorsement, disclosure form, or other contract document type.. Valid values are `base_policy|application|rider|amendment|endorsement|disclosure`',
    `free_look_period_days` STRING COMMENT 'The number of days after policy delivery during which the policyholder may cancel the policy and receive a full refund, as specified on this form and required by state regulation.',
    `illustration_required_flag` BOOLEAN COMMENT 'Indicates whether a policy illustration conforming to NAIC Life Insurance Illustrations Model Regulation must accompany this form during the sales process.',
    `irc_7702_compliant_flag` BOOLEAN COMMENT 'Indicates whether the form and its associated product structure comply with IRC Section 7702 requirements for life insurance tax qualification. Critical for ensuring policy death benefits remain tax-free.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the language in which the form is written. Supports multilingual form libraries for diverse customer populations. [ENUM-REF-CANDIDATE: ENG|SPA|FRE|CHI|KOR|VIE|RUS|ARA|POR|GER — 10 candidates stripped; promote to reference product]',
    `last_updated_by_user` STRING COMMENT 'User identifier or system account that last modified this form record. Supports change tracking and audit compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this form record was most recently modified. Supports change tracking and audit compliance.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this form must be included with every policy issuance for the associated product, or if it is optional based on customer election or underwriting decisions.',
    `mec_risk_indicator` STRING COMMENT 'Assessment of the risk that policies issued using this form may become Modified Endowment Contracts under IRC Section 7702A, which would subject withdrawals to taxation and penalties.. Valid values are `low|medium|high|not_applicable`',
    `page_count` STRING COMMENT 'The number of pages in the printed or PDF version of this form. Used for document assembly and printing cost estimation.',
    `print_sequence` STRING COMMENT 'The order in which this form should appear in the policy document package when multiple forms are assembled for delivery to the policyholder.',
    `prospectus_required_flag` BOOLEAN COMMENT 'Indicates whether a prospectus must be delivered to the customer along with this form at point of sale, as required for variable insurance products.',
    `retirement_reason` STRING COMMENT 'Explanation of why this form was retired or superseded. Examples include regulatory change, product redesign, compliance update, or business strategy shift. Nullable for active forms.',
    `rider_type` STRING COMMENT 'For rider forms, specifies the type of rider benefit. Examples include Accidental Death Benefit (ADB), Waiver of Premium, Guaranteed Minimum Death Benefit (GMDB), Guaranteed Minimum Income Benefit (GMIB), Guaranteed Minimum Accumulation Benefit (GMAB), Guaranteed Minimum Withdrawal Benefit (GMWB), Long-Term Care (LTC), or Disability Income (DI). Nullable for non-rider forms.',
    `sec_registered_flag` BOOLEAN COMMENT 'Indicates whether this form is associated with a variable product that requires SEC registration and prospectus delivery. Applies to Variable Universal Life (VUL) and Variable Annuity products.',
    `state_jurisdiction` STRING COMMENT 'Comma-separated list of US state postal codes where this form is approved and valid for use. Supports multi-state forms and state-specific variations. Examples: NY, CA, TX or ALL for nationwide forms.',
    `state_specific_flag` BOOLEAN COMMENT 'Indicates whether this form is a state-specific variation required by particular state regulations, or a standard form used across multiple jurisdictions.',
    `usage_notes` STRING COMMENT 'Operational guidance and special instructions for when and how to use this form. May include underwriting rules, state-specific requirements, or system processing notes.',
    CONSTRAINT pk_form PRIMARY KEY(`form_id`)
) COMMENT 'Catalog of all insurance contract forms, policy documents, and endorsement forms associated with each product plan — base policy form, application form, rider forms, amendment endorsements, disclosure forms, and state-specific variations. Captures form number, form type, form title, edition date, applicable states, filing status, superseded form reference, and ACORD form mapping. Governs which contract documents are issued for each product plan in each state.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`separate_account_fund` (
    `separate_account_fund_id` BIGINT COMMENT 'Primary key for separate_account_fund',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Variable annuity separate account funds require dedicated GL structure per SAP rules (separate account assets/liabilities reported off-balance-sheet). Essential for statutory Annual Statement Exhibit ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Separate account funds are legally segregated assets held by a specific licensed insurance legal entity. SEC registration (sec_registration_number), SAP statutory reporting, and RBC calculations are a',
    `plan_id` BIGINT COMMENT 'Reference to the specific variable universal life or variable annuity product plan for which this fund is available as an investment option.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Separate account fund availability can change between product versions (new funds added, funds closed). Each version may offer different fund lineups. The effective_date, termination_date, and closed_',
    `document_id` BIGINT COMMENT 'Foreign key linking to document.document. Business justification: Variable life and annuity separate account funds require SEC-registered prospectus documents for suitability review, compliance, and policyholder disclosure. The funds prospectus_reference is a denor',
    `asset_class` STRING COMMENT 'Primary asset class category of the funds investment holdings, used for portfolio diversification analysis and asset allocation modeling.. Valid values are `equity|fixed_income|balanced|money_market|specialty|alternative`',
    `availability_status` STRING COMMENT 'Indicates whether the fund is currently available for policyholder selection within variable products. Restricted funds may be available only to existing investors; discontinued funds are closed to all new and additional investments.. Valid values are `available|restricted|discontinued`',
    `benchmark_index` STRING COMMENT 'Market index used as the performance benchmark for the fund (e.g., S&P 500, Russell 2000, Bloomberg Barclays Aggregate Bond Index), against which fund returns are measured.',
    `closed_to_new_date` DATE COMMENT 'Date when the fund was closed to new allocations while continuing to service existing investments. Used to track fund capacity management decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this fund record was first created in the separate account fund catalog.',
    `cusip` STRING COMMENT 'Nine-character alphanumeric code that uniquely identifies the fund for securities trading and settlement purposes.. Valid values are `^[0-9A-Z]{9}$`',
    `dollar_cost_averaging_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fund is eligible for automatic dollar cost averaging programs where systematic transfers are made from a stable value fund into this investment option over time.',
    `effective_date` DATE COMMENT 'Date when this fund became available for selection within the companys variable product separate accounts.',
    `expense_ratio_percent` DECIMAL(18,2) COMMENT 'Annual fund operating expense ratio expressed as a percentage of average net assets, representing the cost charged to policyholders for fund management, administrative services, and other operational expenses.',
    `fund_code` STRING COMMENT 'Unique alphanumeric code identifying the separate account fund across all systems and product lines. Used as the operational identifier for fund selection and allocation processing.. Valid values are `^[A-Z0-9]{4,12}$`',
    `fund_description` STRING COMMENT 'Detailed narrative description of the funds investment strategy, holdings, risk profile, and suitability for different investor types. Used in policyholder communications and prospectus materials.',
    `fund_family` STRING COMMENT 'Name of the investment management company or fund family that manages the separate account fund (e.g., Fidelity, Vanguard, BlackRock, PIMCO).',
    `fund_name` STRING COMMENT 'Full legal name of the separate account investment fund as registered with the Securities and Exchange Commission (SEC) and disclosed in product prospectuses.',
    `fund_status` STRING COMMENT 'Current operational status of the separate account fund indicating availability for new allocations and existing account management. Active funds accept new investments; closed funds maintain existing positions but accept no new money; liquidating funds are winding down.. Valid values are `active|closed_to_new|liquidating|merged|terminated`',
    `inception_date` DATE COMMENT 'Date when the fund was first established and began operations, used for calculating fund age and historical performance metrics.',
    `investment_objective` STRING COMMENT 'Primary investment goal of the fund as stated in the prospectus, describing the funds strategy and target outcomes (e.g., long-term capital appreciation, current income, capital preservation).',
    `investment_style` STRING COMMENT 'Investment management style or approach employed by the fund manager, indicating whether the fund follows active management, passive indexing, growth-oriented, or value-oriented strategies.. Valid values are `growth|value|blend|index|active|passive`',
    `last_updated_by_user` STRING COMMENT 'User identifier of the person or system process that most recently modified this fund record, used for audit trail and accountability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this fund record was most recently modified, used for change tracking and data quality auditing.',
    `maximum_allocation_percent` DECIMAL(18,2) COMMENT 'Maximum percentage of total account value that may be allocated to this fund, used to enforce diversification limits and manage concentration risk in policyholder portfolios.',
    `maximum_transfers_per_year` STRING COMMENT 'Maximum number of transfers allowed into or out of this fund within a calendar year, enforced to prevent excessive trading and market timing.',
    `minimum_allocation_percent` DECIMAL(18,2) COMMENT 'Minimum percentage of total account value that must be allocated to this fund if the policyholder chooses to invest in it. Used to enforce diversification requirements and operational minimums.',
    `minimum_initial_investment_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount required for the initial allocation to this fund when a policyholder first selects it as an investment option.',
    `morningstar_category` STRING COMMENT 'Morningstar fund classification category used for peer group comparison and performance benchmarking (e.g., Large Blend, Intermediate Bond, Foreign Large Growth).',
    `morningstar_rating` STRING COMMENT 'Morningstars proprietary star rating for the fund (1-5 stars), based on risk-adjusted returns relative to peer funds. Used for fund selection and marketing materials.',
    `mortality_expense_charge_percent` DECIMAL(18,2) COMMENT 'Mortality and expense risk charge assessed by the insurance company on variable product separate account values, covering insurance guarantees and administrative costs. Expressed as an annual percentage of account value.',
    `nav_calculation_frequency` STRING COMMENT 'Frequency at which the funds net asset value per unit is calculated and published, determining how often policyholder account values are updated.. Valid values are `daily|weekly|monthly`',
    `performance_inception_date` DATE COMMENT 'Date from which fund performance is calculated and reported. May differ from fund inception date if the fund underwent reorganization or name change.',
    `product_line` STRING COMMENT 'Indicates whether this fund is available for Variable Universal Life (VUL) products, variable annuity products, or both product lines.. Valid values are `vul|variable_annuity|both`',
    `prospectus_date` DATE COMMENT 'Effective date of the current fund prospectus, indicating when the disclosed fund information was last updated and filed with the SEC.',
    `rebalancing_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fund can be included in automatic portfolio rebalancing programs that periodically adjust allocations back to target percentages.',
    `risk_rating` STRING COMMENT 'Qualitative assessment of the funds investment risk level based on volatility, asset allocation, and investment strategy. Used for suitability analysis and investor education.. Valid values are `conservative|moderate|aggressive|very_aggressive`',
    `sec_registration_number` STRING COMMENT 'SEC registration number assigned to the investment company or fund, used for regulatory tracking and compliance reporting. Format: 811-XXXXX.. Valid values are `^[0-9]{3}-[0-9]{5}$`',
    `termination_date` DATE COMMENT 'Date when the fund was removed from availability or ceased operations. Null for active funds.',
    `ticker_symbol` STRING COMMENT 'Stock market ticker symbol for the fund, used for public market identification and price quotation.. Valid values are `^[A-Z]{3,5}$`',
    `transfer_restriction_flag` BOOLEAN COMMENT 'Indicates whether the fund has restrictions on the frequency or timing of transfers in and out, used to prevent market timing abuse and protect long-term investors.',
    CONSTRAINT pk_separate_account_fund PRIMARY KEY(`separate_account_fund_id`)
) COMMENT 'Master catalog of separate account investment funds available within variable universal life (VUL) and variable annuity products, including fund name, fund code, fund family, investment objective, asset class, benchmark index, fund manager, expense ratio (M&E charge), minimum and maximum allocation percentage, fund availability by product plan, and SEC registration number. Captures fund status (active, closed to new allocations, liquidating) and prospectus reference. Governs VUL and variable annuity sub-account investment options.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`suitability_rule` (
    `suitability_rule_id` BIGINT COMMENT 'Unique identifier for the product suitability rule record. Primary key for this entity.',
    `plan_id` BIGINT COMMENT 'Reference to the life insurance or annuity product to which this suitability rule applies. Links to the product catalog.',
    `plan_version_id` BIGINT COMMENT 'Foreign key linking to product.plan_version. Business justification: Product suitability rules can change between versions (age limits, income requirements, complexity classification). Each version may have different suitability requirements. The rule_version_number an',
    `predecessor_rule_suitability_rule_id` BIGINT COMMENT 'Reference to the previous version of this suitability rule that this version supersedes. Enables rule lineage tracking.',
    `state_regulation_id` BIGINT COMMENT 'Foreign key linking to compliance.state_regulation. Business justification: Suitability rules are directly driven by state regulations (NAIC Suitability Model Regulation, Reg BI, state-specific senior investor protection laws). Compliance officers must link suitability rules ',
    `approval_date` DATE COMMENT 'Date on which this suitability rule was approved by compliance or legal authority for implementation.',
    `best_interest_obligation_level` STRING COMMENT 'The level of care and diligence standard required when recommending this product. Determines the depth of analysis and documentation required.. Valid values are `SUITABILITY|BEST_INTEREST|FIDUCIARY`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this suitability rule record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this suitability rule becomes effective and must be applied to product recommendations.',
    `expiration_date` DATE COMMENT 'The date on which this suitability rule expires or is superseded by a new version. Null if the rule is currently active with no planned expiration.',
    `investment_experience_required` STRING COMMENT 'Minimum level of investment experience or financial sophistication required for the customer to be suitable for this product. Relevant for variable and indexed products.. Valid values are `NONE|BASIC|INTERMEDIATE|ADVANCED`',
    `investment_objective_alignment` STRING COMMENT 'Pipe-separated list of customer investment objectives that align with this product (e.g., INCOME|GROWTH|PRESERVATION|LEGACY). [ENUM-REF-CANDIDATE: INCOME|GROWTH|PRESERVATION|LEGACY|TAX_DEFERRAL|ESTATE_PLANNING|RETIREMENT_INCOME — promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this suitability rule record was last modified.',
    `liquidity_needs_assessment_required` BOOLEAN COMMENT 'Indicates whether a formal assessment of the customers liquidity needs is required before recommending this product. True for products with significant surrender charges or restricted access.',
    `maximum_age` STRING COMMENT 'Maximum age of the customer for this product to be considered suitable. Part of age-based suitability criteria.',
    `maximum_premium_as_percent_of_income` DECIMAL(18,2) COMMENT 'Maximum allowable premium payment as a percentage of the customers annual income for suitability purposes. Prevents over-commitment of resources.',
    `maximum_premium_as_percent_of_net_worth` DECIMAL(18,2) COMMENT 'Maximum allowable premium payment as a percentage of the customers net worth for suitability purposes. Particularly relevant for single-premium annuities.',
    `minimum_age` STRING COMMENT 'Minimum age of the customer for this product to be considered suitable. Part of age-based suitability criteria.',
    `minimum_annual_income` DECIMAL(18,2) COMMENT 'Minimum annual income threshold required for the customer to meet suitability criteria for this product. Expressed in USD.',
    `minimum_investment_horizon_years` STRING COMMENT 'Minimum investment time horizon in years required for suitability. Critical for products with surrender charges or long-term accumulation features.',
    `minimum_liquid_net_worth` DECIMAL(18,2) COMMENT 'Minimum liquid net worth (assets easily convertible to cash) required for suitability. Critical for annuity products with surrender charges. Expressed in USD.',
    `minimum_net_worth` DECIMAL(18,2) COMMENT 'Minimum net worth threshold required for the customer to meet suitability criteria for this product. Expressed in USD.',
    `product_complexity_classification` STRING COMMENT 'Classification of the product complexity level for suitability assessment purposes. Determines the depth of suitability analysis required.. Valid values are `SIMPLE|MODERATE|COMPLEX|HIGHLY_COMPLEX`',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework or standard that mandates this suitability rule. Determines the compliance obligation level.. Valid values are `NAIC_275|REG_BI|DOL_FIDUCIARY|STATE_SPECIFIC|FINRA_2111|INTERNAL`',
    `replacement_transaction_flag` BOOLEAN COMMENT 'Indicates whether this suitability rule applies specifically to replacement transactions (1035 exchanges or policy replacements), which have heightened suitability requirements.',
    `required_disclosure_documents` STRING COMMENT 'Comma-separated list of disclosure document codes that must be provided to the customer before sale (e.g., prospectus, buyers guide, product illustration, Form CRS).',
    `risk_tolerance_required` STRING COMMENT 'The minimum risk tolerance profile required for the customer to be suitable for this product. Aligns with customer risk assessment.. Valid values are `CONSERVATIVE|MODERATE|AGGRESSIVE|ANY`',
    `rule_code` STRING COMMENT 'Unique business code identifying this suitability rule configuration. Used for operational reference and system integration.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed description of the suitability rule, including the business rationale and compliance requirements it addresses.',
    `rule_name` STRING COMMENT 'Human-readable name of the suitability rule for display and reporting purposes.',
    `rule_notes` STRING COMMENT 'Free-form notes providing additional context, implementation guidance, or special considerations for this suitability rule.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the suitability rule. Determines whether the rule is actively enforced in point-of-sale systems.. Valid values are `DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|RETIRED`',
    `rule_version_number` STRING COMMENT 'Version number of this suitability rule configuration. Incremented when rule parameters are updated to maintain audit trail.',
    `senior_investor_protection_flag` BOOLEAN COMMENT 'Indicates whether enhanced suitability protections for senior investors (typically age 65+) apply to this product under state or federal regulations.',
    `state_specific_override_flag` BOOLEAN COMMENT 'Indicates whether this rule represents a state-specific override of the default national suitability rule for the product.',
    `suitability_questionnaire_required` BOOLEAN COMMENT 'Indicates whether a formal suitability questionnaire must be completed and documented before recommending this product.',
    `supervisory_approval_required` BOOLEAN COMMENT 'Indicates whether supervisory or managerial approval is required before finalizing the sale of this product based on its complexity or risk profile.',
    `tax_status_eligibility` STRING COMMENT 'Pipe-separated list of customer tax status categories for which this product is suitable (e.g., QUALIFIED|NON_QUALIFIED|IRA|ROTH_IRA). [ENUM-REF-CANDIDATE: QUALIFIED|NON_QUALIFIED|IRA|ROTH_IRA|401K|403B|SEP|SIMPLE — promote to reference product]',
    CONSTRAINT pk_suitability_rule PRIMARY KEY(`suitability_rule_id`)
) COMMENT 'Defines product-level suitability and best-interest compliance rules under NAIC Model 275 (Suitability in Annuity Transactions), Regulation Best Interest (Reg BI), and DOL fiduciary standards. Captures minimum suitability criteria (age, income, net worth, risk tolerance, investment horizon, liquidity needs), product complexity classification, required disclosure documents, best-interest obligation level, and state-specific rule overrides. These are product-configuration rules that define what suitability checks must pass before a product can be recommended — distinct from the compliance domains transaction-level suitability evaluation records. Governs point-of-sale compliance for annuity and life product recommendations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`rate_action` (
    `rate_action_id` BIGINT COMMENT 'Unique identifier for the product rate action event. Primary key for this table.',
    `charge_schedule_id` BIGINT COMMENT 'Foreign key linking to product.charge_schedule. Business justification: rate_action tracks in-force rate actions including expense charge and fee changes for annuity and UL/IUL/VUL products. Adding charge_schedule_id as a FK to charge_schedule.charge_schedule_id allows th',
    `coi_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.coi_rate_schedule. Business justification: rate_action tracks in-force rate actions including COI rate changes for UL/IUL/VUL products. Adding coi_rate_schedule_id as a FK to coi_rate_schedule.coi_rate_schedule_id allows the rate action record',
    `crediting_strategy_id` BIGINT COMMENT 'Foreign key linking to product.crediting_strategy. Business justification: rate_action tracks credited interest rate changes for FIA and IUL products. Adding crediting_strategy_id as a FK to crediting_strategy.crediting_strategy_id allows the rate action to reference the spe',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Rate actions (COI increases, crediting rate changes) carry financial_impact_estimate and reinsurance_impact_flag that are reported at the legal entity level for statutory filings and earnings guidance',
    `plan_id` BIGINT COMMENT 'Reference to the product plan affected by this rate action. Links to the product plan master.',
    `plan_version_id` BIGINT COMMENT 'Reference to the specific plan version affected by this rate action. Links to the plan version master.',
    `premium_rate_table_id` BIGINT COMMENT 'Foreign key linking to product.premium_rate_table. Business justification: rate_action tracks in-force rate actions including premium rate changes. Adding premium_rate_table_id as a FK to premium_rate_table.premium_rate_table_id allows the rate action to reference the specif',
    `primary_predecessor_rate_action_id` BIGINT COMMENT 'Reference to the previous rate action that this action supersedes or modifies. Null if this is the first rate action for the product block.',
    `rate_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_filing. Business justification: A rate action (COI increase, crediting rate change) triggers a regulatory rate_filing in affected states. Operations teams must link the business rate_action to its compliance rate_filing for state no',
    `actuarial_justification` STRING COMMENT 'Detailed actuarial rationale and supporting analysis for the rate action. Includes references to experience studies, mortality trends, expense analysis, or investment performance that justify the change.',
    `actuarial_memorandum_reference` STRING COMMENT 'Reference identifier to the formal actuarial memorandum supporting this rate action. Links to document management system.',
    `advance_notice_period_days` STRING COMMENT 'Number of days advance notice provided to policyholders before the rate action becomes effective. Required by state regulations and policy contracts.',
    `announcement_date` DATE COMMENT 'Date when the rate action was announced to internal stakeholders, distribution channels, and policyholders.',
    `approval_date` DATE COMMENT 'Date when the rate action was approved by the state insurance department or regulatory authority. Null if approval is not required or still pending.',
    `approved_by_authority` STRING COMMENT 'Name of the state insurance department or regulatory authority that approved this rate action. May include multiple jurisdictions for multi-state filings.',
    `approved_by_user` STRING COMMENT 'User identifier or name of the individual who provided internal approval for this rate action. Used for audit trail and accountability.',
    `average_rate_change_percent` DECIMAL(18,2) COMMENT 'Average percentage change in rates across all affected policies. Positive values indicate increases, negative values indicate decreases. Expressed as a decimal (e.g., 0.0500 for 5.00% increase).',
    `communication_method` STRING COMMENT 'Primary method used to communicate the rate action to policyholders. May include direct mail, email, policy statement insert, agent notification, website posting, or multiple channels.. Valid values are `DIRECT_MAIL|EMAIL|POLICY_STATEMENT|AGENT_NOTIFICATION|WEBSITE_POSTING|MULTIPLE`',
    `communication_sent_date` DATE COMMENT 'Date when policyholder communications regarding this rate action were sent or initiated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate action record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when the rate action becomes effective and applies to in-force policies. Critical for policy administration and billing systems.',
    `filing_date` DATE COMMENT 'Date when the rate action was filed with the state insurance department or regulatory authority.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated annual financial impact of this rate action on company revenues or expenses. Expressed in USD. Positive values indicate revenue increase or expense decrease, negative values indicate revenue decrease or expense increase.',
    `guaranteed_rate_flag` BOOLEAN COMMENT 'Indicates whether the new rates established by this action are guaranteed (cannot be changed further) or non-guaranteed (subject to future adjustment). True if guaranteed, False if non-guaranteed.',
    `impacted_face_amount_total` DECIMAL(18,2) COMMENT 'Total face amount (death benefit) across all policies affected by this rate action. Expressed in USD. Used for financial impact analysis.',
    `impacted_policy_count` STRING COMMENT 'Number of in-force policies affected by this rate action. Used for impact analysis and communication planning.',
    `irc_7702_impact_flag` BOOLEAN COMMENT 'Indicates whether this rate action has potential impact on IRC Section 7702 life insurance tax qualification. True if the action may affect guideline premium test (GPT) or cash value accumulation test (CVAT) compliance, False otherwise.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate action record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form notes and comments regarding this rate action. May include implementation details, special considerations, or historical context.',
    `opt_out_available_flag` BOOLEAN COMMENT 'Indicates whether policyholders have the option to opt out of the rate action (e.g., by surrendering the policy or converting to a different product). True if opt-out is available, False otherwise.',
    `opt_out_deadline_date` DATE COMMENT 'Last date by which policyholders can exercise their opt-out option if available. Null if no opt-out is available.',
    `policyholder_communication_plan_reference` STRING COMMENT 'Reference identifier to the communication plan document detailing how policyholders will be notified of this rate action. Links to document management system.',
    `profitability_impact_description` STRING COMMENT 'Narrative description of the expected impact on product profitability, including effects on internal rate of return (IRR), new business value (NBV), and embedded value.',
    `rate_action_code` STRING COMMENT 'Unique business code identifying this rate action event. Used for operational reference and reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `rate_action_name` STRING COMMENT 'Descriptive name of the rate action event for business user identification and reporting purposes.',
    `rate_action_status` STRING COMMENT 'Current lifecycle status of the rate action. Tracks progression from draft through regulatory approval to implementation. [ENUM-REF-CANDIDATE: DRAFT|PENDING_APPROVAL|APPROVED|FILED|EFFECTIVE|WITHDRAWN|CANCELLED — 7 candidates stripped; promote to reference product]',
    `rate_action_type` STRING COMMENT 'Classification of the rate action event. Indicates the type of rate or charge being modified: Cost of Insurance (COI) rate changes, credited interest rate adjustments, expense charge modifications, dividend scale changes, mortality table updates, or premium rate adjustments.. Valid values are `COI_RATE_CHANGE|CREDITED_INTEREST_ADJUSTMENT|EXPENSE_CHARGE_MODIFICATION|DIVIDEND_SCALE_CHANGE|MORTALITY_TABLE_UPDATE|PREMIUM_RATE_ADJUSTMENT`',
    `rate_change_direction` STRING COMMENT 'Overall direction of the rate change. Increase indicates rates are going up (higher cost to policyholders), Decrease indicates rates are going down, Mixed indicates some rates increase while others decrease, No Change indicates administrative action without rate impact.. Valid values are `INCREASE|DECREASE|MIXED|NO_CHANGE`',
    `reinsurance_impact_flag` BOOLEAN COMMENT 'Indicates whether this rate action affects reinsurance treaties or cession calculations. True if reinsurance agreements must be updated or renegotiated, False otherwise.',
    `reinsurance_treaty_reference` STRING COMMENT 'Reference identifier to the reinsurance treaty or treaties affected by this rate action. Null if no reinsurance impact.',
    `state_jurisdiction` STRING COMMENT 'Comma-separated list of state jurisdictions where this rate action applies. Uses two-letter state codes (e.g., NY, CA, TX). May be ALL for nationwide actions.',
    `state_notification_required_flag` BOOLEAN COMMENT 'Indicates whether state insurance department notification is required for this rate action. True if regulatory notification is mandatory, False otherwise.',
    CONSTRAINT pk_rate_action PRIMARY KEY(`rate_action_id`)
) COMMENT 'Tracks in-force rate actions applied to existing product blocks — COI rate changes, credited interest rate adjustments, expense charge modifications, and dividend scale changes. Captures action type, effective date, impacted product plan and version, regulatory filing reference, actuarial justification, advance notice period, state notification requirements, and policyholder communication plan. Records the business event of a rate action distinct from the static rate schedule definition.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` (
    `plan_rider_eligibility_id` BIGINT COMMENT 'Primary key for the plan_rider_eligibility association',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the base product plan for which this rider eligibility record applies.',
    `rider_definition_id` BIGINT COMMENT 'Foreign key linking to the rider definition that is eligible for attachment to the referenced base plan.',
    `effective_date` DATE COMMENT 'The date on which this plan-rider eligibility combination became active and available for new business. Belongs to the association because the same rider may become eligible for a plan at a different time than it was originally created.',
    `eligible_base_product_types` STRING COMMENT 'Comma-separated list of base product types (WL, UL, IUL, VUL, YRT, FIA, SPIA) to which this rider can be attached. Defines product compatibility rules. [ENUM-REF-CANDIDATE: WL|UL|IUL|VUL|YRT|FIA|SPIA|GMAB|GMDB|GMIB|GMWB|DI — promote to reference product] [Moved from rider_definition: This comma-separated string on rider_definition is a coarse approximation of plan-level eligibility. With the plan_rider_eligibility association table providing precise plan-by-plan eligibility records, this denormalized field becomes redundant and should be deprecated. The association table supersedes it with proper granularity, effective dating, and mandatory/optional designation.]',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this rider is mandatory (automatically included) or optional (customer-elected) when issued with this specific base plan. This designation can differ by plan — the same rider may be mandatory on one plan and optional on another.',
    `rider_sequence_order` STRING COMMENT 'The display and processing sequence order of this rider relative to other riders on the same base plan. Used by illustration software and policy administration systems to order riders consistently on policy documents and admin screens.',
    `state_availability_override` STRING COMMENT 'Comma-separated list of state codes where this plan-rider combination has availability that differs from the rider definitions general state availability. Allows plan-specific state eligibility rules to override the rider-level defaults.',
    `termination_date` DATE COMMENT 'The date on which this plan-rider eligibility combination was retired and the rider is no longer available for attachment to this plan. Null if currently active. Belongs to the association because a rider may be retired from one plan while remaining active on others.',
    CONSTRAINT pk_plan_rider_eligibility PRIMARY KEY(`plan_rider_eligibility_id`)
) COMMENT 'This association product represents the formal eligibility contract between a base plan and a rider definition in the life insurance product catalog. It captures which riders are available (or mandatory) for attachment to which base plans, with effective dating, state-level availability overrides, and sequencing rules. Each record defines one plan-rider eligibility combination as managed by the product team in the rider availability matrix. This is the operational source of truth for determining which riders can be offered at point-of-sale for a given base plan.. Existence Justification: In life insurance product management, base plans and riders have a genuine many-to-many operational relationship: a single plan (e.g., UL) can have many eligible riders (ADB, LTC, waiver of premium), and a single rider definition (e.g., ADB) can be attached to many different base plans. The business actively manages this eligibility catalog — product managers create, update, and retire plan-rider combinations with effective dating, mandatory/optional designation, and state-level availability overrides. This is a recognized operational concept in life insurance administration systems (OIPA, FAST, Majesco) called plan rider eligibility or rider availability matrix.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` (
    `plan_underwriting_eligibility_id` BIGINT COMMENT 'Primary key for the plan_underwriting_eligibility association',
    `plan_id` BIGINT COMMENT 'Foreign key linking to the product plan for which this underwriting class eligibility is configured.',
    `underwriting_class_id` BIGINT COMMENT 'Foreign key linking to the underwriting risk classification category that is eligible under this plan configuration.',
    `applicable_product_lines` STRING COMMENT 'Comma-separated list of product line codes or categories where this underwriting class is available (e.g., WL, UL, IUL, VUL, YRT, DI). Some classes may be restricted to specific product types based on underwriting complexity or reinsurance treaty terms. [Moved from underwriting_class: This comma-separated string on underwriting_class is a denormalized attempt to capture the plan-class relationship. With the plan_underwriting_eligibility association table in place, the proper relational path exists and this field becomes redundant and should be deprecated. The association table provides a normalized, queryable, and historically accurate representation of which plans each underwriting class applies to.]',
    `effective_date` DATE COMMENT 'The date on which this underwriting class becomes available for new business under this specific plan. May differ from both the plan effective date and the underwriting class effective date, allowing plan-class combinations to be activated independently.',
    `eligibility_override_criteria` STRING COMMENT 'Plan-specific override to the standard underwriting class eligibility criteria defined on the underwriting_class record. Captures additional or modified health, lifestyle, or risk requirements that apply only when this class is used with this plan. Null if no override applies.',
    `expiration_date` DATE COMMENT 'The date on which this underwriting class is no longer available for new business under this specific plan. Null indicates no scheduled expiration. Enables plan-level retirement of specific risk classes without retiring the class globally.',
    `minimum_face_amount_override` DECIMAL(18,2) COMMENT 'Plan-specific minimum death benefit face amount required to qualify for this underwriting class under this plan. Overrides the class-level face_amount_minimum when set. Null if the class-level default applies without modification.',
    `state_specific_restrictions` STRING COMMENT 'Comma-separated list of two-letter state codes where this plan-class combination is restricted or prohibited, beyond the general state approvals on either the plan or the underwriting class. Captures regulatory filing outcomes specific to this combination.',
    CONSTRAINT pk_plan_underwriting_eligibility PRIMARY KEY(`plan_underwriting_eligibility_id`)
) COMMENT 'This association product represents the Contract between plan and underwriting_class defining which risk classification categories are eligible for a given product plan, under what conditions, and during what time window. It captures the plan-specific configuration of underwriting class availability including overrides to standard eligibility criteria, state-specific restrictions, and face amount overrides that exist only in the context of a specific plan-class combination. Each record links one plan to one underwriting_class and is actively managed by product actuaries and product managers during product configuration and maintenance.. Existence Justification: In life insurance product administration, a plan explicitly supports multiple underwriting classes (e.g., a Whole Life plan may offer Preferred Plus Non-Tobacco, Preferred Non-Tobacco, Standard Non-Tobacco, and Table ratings), and a single underwriting class (e.g., Standard Non-Tobacco) is available across many plans. This is not an analytical correlation — product actuaries and product managers actively configure and maintain which underwriting classes are eligible for each plan, with plan-specific overrides for face amount limits, eligibility criteria, and effective dates. The business recognizes this as Plan Underwriting Eligibility or Risk Class Availability and it is managed as a distinct configuration entity in product administration systems.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ADD CONSTRAINT `fk_product_plan_version_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ADD CONSTRAINT `fk_product_plan_version_replacement_plan_version_id` FOREIGN KEY (`replacement_plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ADD CONSTRAINT `fk_product_benefit_structure_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ADD CONSTRAINT `fk_product_benefit_structure_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ADD CONSTRAINT `fk_product_benefit_structure_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ADD CONSTRAINT `fk_product_rider_definition_benefit_structure_id` FOREIGN KEY (`benefit_structure_id`) REFERENCES `life_insurance_ecm`.`product`.`benefit_structure`(`benefit_structure_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ADD CONSTRAINT `fk_product_premium_rate_table_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ADD CONSTRAINT `fk_product_premium_rate_table_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ADD CONSTRAINT `fk_product_premium_rate_table_predecessor_rate_table_premium_rate_table_id` FOREIGN KEY (`predecessor_rate_table_premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ADD CONSTRAINT `fk_product_premium_rate_table_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ADD CONSTRAINT `fk_product_coi_rate_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ADD CONSTRAINT `fk_product_coi_rate_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ADD CONSTRAINT `fk_product_coi_rate_schedule_predecessor_schedule_coi_rate_schedule_id` FOREIGN KEY (`predecessor_schedule_coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ADD CONSTRAINT `fk_product_coi_rate_schedule_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `life_insurance_ecm`.`product`.`filing`(`filing_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ADD CONSTRAINT `fk_product_state_approval_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ADD CONSTRAINT `fk_product_filing_superseded_by_filing_id` FOREIGN KEY (`superseded_by_filing_id`) REFERENCES `life_insurance_ecm`.`product`.`filing`(`filing_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ADD CONSTRAINT `fk_product_irc7702_parameter_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ADD CONSTRAINT `fk_product_irc7702_parameter_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ADD CONSTRAINT `fk_product_crediting_strategy_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ADD CONSTRAINT `fk_product_crediting_strategy_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ADD CONSTRAINT `fk_product_charge_schedule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ADD CONSTRAINT `fk_product_charge_schedule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ADD CONSTRAINT `fk_product_charge_schedule_predecessor_schedule_charge_schedule_id` FOREIGN KEY (`predecessor_schedule_charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `life_insurance_ecm`.`product`.`filing`(`filing_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`form` ADD CONSTRAINT `fk_product_form_primary_predecessor_form_id` FOREIGN KEY (`primary_predecessor_form_id`) REFERENCES `life_insurance_ecm`.`product`.`form`(`form_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ADD CONSTRAINT `fk_product_separate_account_fund_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ADD CONSTRAINT `fk_product_suitability_rule_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ADD CONSTRAINT `fk_product_suitability_rule_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ADD CONSTRAINT `fk_product_suitability_rule_predecessor_rule_suitability_rule_id` FOREIGN KEY (`predecessor_rule_suitability_rule_id`) REFERENCES `life_insurance_ecm`.`product`.`suitability_rule`(`suitability_rule_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_charge_schedule_id` FOREIGN KEY (`charge_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`charge_schedule`(`charge_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_coi_rate_schedule_id` FOREIGN KEY (`coi_rate_schedule_id`) REFERENCES `life_insurance_ecm`.`product`.`coi_rate_schedule`(`coi_rate_schedule_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_crediting_strategy_id` FOREIGN KEY (`crediting_strategy_id`) REFERENCES `life_insurance_ecm`.`product`.`crediting_strategy`(`crediting_strategy_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_plan_version_id` FOREIGN KEY (`plan_version_id`) REFERENCES `life_insurance_ecm`.`product`.`plan_version`(`plan_version_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_premium_rate_table_id` FOREIGN KEY (`premium_rate_table_id`) REFERENCES `life_insurance_ecm`.`product`.`premium_rate_table`(`premium_rate_table_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ADD CONSTRAINT `fk_product_rate_action_primary_predecessor_rate_action_id` FOREIGN KEY (`primary_predecessor_rate_action_id`) REFERENCES `life_insurance_ecm`.`product`.`rate_action`(`rate_action_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ADD CONSTRAINT `fk_product_plan_rider_eligibility_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ADD CONSTRAINT `fk_product_plan_rider_eligibility_rider_definition_id` FOREIGN KEY (`rider_definition_id`) REFERENCES `life_insurance_ecm`.`product`.`rider_definition`(`rider_definition_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ADD CONSTRAINT `fk_product_plan_underwriting_eligibility_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `life_insurance_ecm`.`product`.`plan`(`plan_id`);
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ADD CONSTRAINT `fk_product_plan_underwriting_eligibility_underwriting_class_id` FOREIGN KEY (`underwriting_class_id`) REFERENCES `life_insurance_ecm`.`product`.`underwriting_class`(`underwriting_class_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `life_insurance_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `cash_value_option` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Option');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `contestability_period_years` SET TAGS ('dbx_business_glossary_term' = 'Contestability Period Years');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `dac_amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Amortization Method');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `dac_amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|interest_adjusted|benefit_ratio');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `distribution_channel_availability` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Availability');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `free_look_period_days` SET TAGS ('dbx_business_glossary_term' = 'Free Look Period Days');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `gpt_corridor_factor` SET TAGS ('dbx_business_glossary_term' = 'Guideline Premium Test (GPT) Corridor Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `guaranteed_issue` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Issue');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `illustration_software_code` SET TAGS ('dbx_business_glossary_term' = 'Illustration Software Code');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `illustration_software_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `insurance_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `irc_7702_compliant` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `loan_provision` SET TAGS ('dbx_business_glossary_term' = 'Loan Provision');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `maximum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Face Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `maximum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `maximum_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Premium Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `minimum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Face Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `minimum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `minimum_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Premium Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `naic_product_type_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Product Type Code');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `naic_product_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `participating_product` SET TAGS ('dbx_business_glossary_term' = 'Participating Product');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|filed|approved|suspended|retired|withdrawn');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `premium_mode_options` SET TAGS ('dbx_business_glossary_term' = 'Premium Mode Options');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `profitability_target_irr` SET TAGS ('dbx_business_glossary_term' = 'Profitability Target Internal Rate of Return (IRR)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `profitability_target_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `reinstatement_period_months` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Period Months');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `reinsurance_treaty_code` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Code');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `reinsurance_treaty_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_business_glossary_term' = 'Reserve Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `reserve_basis` SET TAGS ('dbx_value_regex' = 'statutory|gaap|ifrs17|pbr');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'regulatory_change|profitability|market_conditions|product_replacement|strategic_decision');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `simplified_issue` SET TAGS ('dbx_business_glossary_term' = 'Simplified Issue');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `state_approval_count` SET TAGS ('dbx_business_glossary_term' = 'State Approval Count');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `suicide_exclusion_period_years` SET TAGS ('dbx_business_glossary_term' = 'Suicide Exclusion Period Years');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `surrender_charge_schedule` SET TAGS ('dbx_business_glossary_term' = 'Surrender Charge Schedule');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `tax_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Qualification Status');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `tax_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|non_qualified|mec|non_mec');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `underwriting_class_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Eligibility');
ALTER TABLE `life_insurance_ecm`.`product`.`plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `replacement_plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Plan Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `approved_by_authority` SET TAGS ('dbx_business_glossary_term' = 'Approved By Authority');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `closed_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Closed Block Indicator');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `closed_block_transition_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Block Transition Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `communication_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Communication Plan Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `distribution_channel_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Eligibility');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `expected_nbv_per_policy` SET TAGS ('dbx_business_glossary_term' = 'Expected New Business Value (NBV) Per Policy');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `expected_nbv_per_policy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `gpt_compliant` SET TAGS ('dbx_business_glossary_term' = 'Guideline Premium Test (GPT) Compliant');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `inforce_continuation_policy` SET TAGS ('dbx_business_glossary_term' = 'In-Force (Inforce) Continuation Policy');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `inforce_continuation_policy` SET TAGS ('dbx_value_regex' = 'full_servicing|limited_servicing|closed_block|reinsured|sold');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `irc_7702_compliant` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `last_new_business_date` SET TAGS ('dbx_business_glossary_term' = 'Last New Business Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `maximum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Face Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `maximum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `mec_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Risk Indicator');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `minimum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Face Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `minimum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `pbr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `profitability_target_irr` SET TAGS ('dbx_business_glossary_term' = 'Profitability Target Internal Rate of Return (IRR)');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `profitability_target_irr` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `rate_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Table Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `retirement_announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Announcement Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'regulatory_change|profitability|product_redesign|market_exit|competitive_pressure|technology_limitation');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `rider_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Rider Eligibility');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `state_availability` SET TAGS ('dbx_business_glossary_term' = 'State Availability');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `underwriting_class_structure` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Structure');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|superseded|retired|withdrawn');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_version` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'new_filing|amendment|rate_revision|benefit_enhancement|compliance_update|retirement');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_ceiling_value` SET TAGS ('dbx_business_glossary_term' = 'Benefit Ceiling Value');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_floor_value` SET TAGS ('dbx_business_glossary_term' = 'Benefit Floor Value');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_formula_parameters` SET TAGS ('dbx_business_glossary_term' = 'Benefit Formula Parameters');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Code');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Description');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_structure_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Name');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_structure_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Status');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `benefit_structure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|retired');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `cash_value_accumulation_method` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Accumulation Method');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `cash_value_accumulation_method` SET TAGS ('dbx_value_regex' = 'fixed_interest|indexed_crediting|variable_investment|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `coi_structure` SET TAGS ('dbx_business_glossary_term' = 'Cost of Insurance (COI) Structure');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `coi_structure` SET TAGS ('dbx_value_regex' = 'level|increasing|attained_age|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `csv_calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Cash Surrender Value (CSV) Calculation Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `death_benefit_option` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit Option');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `death_benefit_option` SET TAGS ('dbx_value_regex' = 'option_a|option_b|option_c|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `death_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Death Benefit (DB) Type');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `death_benefit_type` SET TAGS ('dbx_value_regex' = 'level|increasing|return_of_premium|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_benefit_offset_rules` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Benefit Offset Rules');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_benefit_period` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Benefit Period');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_benefit_period` SET TAGS ('dbx_value_regex' = '2_year|5_year|to_age_65|to_age_67|lifetime|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_cola_available` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Cost of Living Adjustment (COLA) Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_cola_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Cost of Living Adjustment (COLA) Rate Percent');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_disability_definition` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Disability Definition');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_disability_definition` SET TAGS ('dbx_value_regex' = 'own_occupation|any_occupation|modified_own_occupation|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_disability_definition` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_disability_definition` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_elimination_period_days` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Elimination Period (Days)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_monthly_benefit_maximum` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Monthly Benefit Maximum');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_partial_disability_available` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Partial Disability Benefit Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_partial_disability_available` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_partial_disability_available` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_residual_disability_available` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Residual Disability Benefit Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_residual_disability_available` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_residual_disability_available` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_return_to_work_incentive` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Return-to-Work Incentive Provision');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `di_social_insurance_substitute` SET TAGS ('dbx_business_glossary_term' = 'Disability Income (DI) Social Insurance Substitute Benefit');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `dividend_option` SET TAGS ('dbx_business_glossary_term' = 'Dividend Option');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `dividend_option` SET TAGS ('dbx_value_regex' = 'cash|reduce_premium|paid_up_additions|accumulate_at_interest|one_year_term|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `gmab_available` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Accumulation Benefit (GMAB) Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `gmdb_type` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Death Benefit (GMDB) Type');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `gmdb_type` SET TAGS ('dbx_value_regex' = 'return_of_premium|highest_anniversary_value|earnings_protection|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `gmib_available` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Income Benefit (GMIB) Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `gmwb_available` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Withdrawal Benefit (GMWB) Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `irc_7702_compliant` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `irc_7702_test_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Test Type');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `irc_7702_test_type` SET TAGS ('dbx_value_regex' = 'guideline_premium_test|cash_value_accumulation_test|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `ltc_acceleration_available` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Care (LTC) Acceleration Available');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `nonforfeiture_option_cash_surrender` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option - Cash Surrender Value (CSV)');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `nonforfeiture_option_extended_term` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option - Extended Term Insurance');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `nonforfeiture_option_reduced_paid_up` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Option - Reduced Paid-Up Insurance');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `life_insurance_ecm`.`product`.`benefit_structure` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Termination Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Rider Definition ID');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `benefit_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Structure Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `accelerated_benefit_flag` SET TAGS ('dbx_business_glossary_term' = 'Accelerated Benefit Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Code');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `commission_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `cost_of_insurance_impact` SET TAGS ('dbx_business_glossary_term' = 'COI (Cost of Insurance) Impact');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `cost_of_insurance_impact` SET TAGS ('dbx_value_regex' = 'none|additive|multiplicative|separate_coi');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rider Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Rider Form Number');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `form_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,15}$');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `guaranteed_insurability_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Insurability Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `illustration_required` SET TAGS ('dbx_business_glossary_term' = 'Illustration Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `irc_7702_compliant` SET TAGS ('dbx_business_glossary_term' = 'IRC (Internal Revenue Code) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `ltc_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'LTC (Long-Term Care) Qualified Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `maximum_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `maximum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `mec_impact` SET TAGS ('dbx_business_glossary_term' = 'MEC (Modified Endowment Contract) Impact');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `mec_impact` SET TAGS ('dbx_value_regex' = 'none|potential|always');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `medical_evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Evidence Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `medical_evidence_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `medical_evidence_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `minimum_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Benefit Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `minimum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `predecessor_rider_code` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Rider Code');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `predecessor_rider_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `premium_basis` SET TAGS ('dbx_business_glossary_term' = 'Premium Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `premium_basis` SET TAGS ('dbx_value_regex' = 'per_thousand|flat_rate|percentage_of_premium|percentage_of_benefit|included');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `premium_mode` SET TAGS ('dbx_business_glossary_term' = 'Premium Mode');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `premium_mode` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|single|flexible');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `reinsurance_treaty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Applicable Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `return_of_premium_flag` SET TAGS ('dbx_business_glossary_term' = 'Return of Premium Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_category` SET TAGS ('dbx_business_glossary_term' = 'Rider Category');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_category` SET TAGS ('dbx_value_regex' = 'optional|mandatory|automatic');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Rider Code');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Rider Description');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Rider Status');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|withdrawn|discontinued');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_expiry_age` SET TAGS ('dbx_business_glossary_term' = 'Rider Expiry Age');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_name` SET TAGS ('dbx_business_glossary_term' = 'Rider Name');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_type` SET TAGS ('dbx_business_glossary_term' = 'Rider Type');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `rider_type` SET TAGS ('dbx_value_regex' = 'death_benefit|living_benefit|waiver|return_of_premium|term|disability_income');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `state_availability` SET TAGS ('dbx_business_glossary_term' = 'State Availability');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `surrender_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surrender Charge Applicable Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Rider Termination Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `underwriting_class_required` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rider Version Number');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `waiver_of_premium_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver of Premium Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rider_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `premium_rate_table_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Table ID');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `predecessor_rate_table_premium_rate_table_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Rate Table ID');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `attained_age_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attained Age');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `attained_age_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Attained Age');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `coi_rate_per_thousand` SET TAGS ('dbx_business_glossary_term' = 'Cost of Insurance (COI) Rate Per Thousand');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `face_amount_band_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Face Amount Band');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `face_amount_band_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Face Amount Band');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `flat_extra_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Extra Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|unisex');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `guaranteed_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `irc_7702_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `issue_age_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `issue_age_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `modal_factor` SET TAGS ('dbx_business_glossary_term' = 'Modal Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `mortality_table_basis` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `payment_mode` SET TAGS ('dbx_business_glossary_term' = 'Payment Mode');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `payment_mode` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|single');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `policy_duration_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Policy Duration');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `policy_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Policy Duration');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_basis_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis Description');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Unit');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Type');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_schedule_type` SET TAGS ('dbx_value_regex' = 'guaranteed|current|illustrative|maximum|minimum|projected');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_table_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Table Code');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_table_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_table_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Table Name');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_table_notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Table Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_table_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Table Status');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_table_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|withdrawn');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `rate_version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `table_rating_factor` SET TAGS ('dbx_business_glossary_term' = 'Table Rating Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `tobacco_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Status');
ALTER TABLE `life_insurance_ecm`.`product`.`premium_rate_table` ALTER COLUMN `tobacco_status` SET TAGS ('dbx_value_regex' = 'non_smoker|smoker|tobacco_user|non_tobacco');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `coi_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Insurance (COI) Rate Schedule ID');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `predecessor_schedule_coi_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Schedule ID');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `actuarial_notes` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `attained_age_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attained Age');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `attained_age_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Attained Age');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|unisex');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `illustration_usage_flag` SET TAGS ('dbx_business_glossary_term' = 'Illustration Usage Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `irc_7702_compliant` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `is_current_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Current Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `is_guaranteed_maximum` SET TAGS ('dbx_business_glossary_term' = 'Is Guaranteed Maximum');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `mortality_table_basis` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `mortality_table_basis` SET TAGS ('dbx_value_regex' = '2001_CSO|2017_CSO|1980_CSO|annuity_2000|GAM83|custom');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `profitability_tier` SET TAGS ('dbx_business_glossary_term' = 'Profitability Tier');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `profitability_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|loss_leader');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `rate_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'monthly|annual|quarterly');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `rate_guarantee_period_years` SET TAGS ('dbx_business_glossary_term' = 'Rate Guarantee Period (Years)');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `rate_per_thousand_nar` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Thousand Net Amount at Risk (NAR)');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `state_approval_date` SET TAGS ('dbx_business_glossary_term' = 'State Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `state_approval_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Approval Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `state_approval_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_business_glossary_term' = 'State Filing Number');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `tobacco_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Status');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `tobacco_status` SET TAGS ('dbx_value_regex' = 'tobacco|non_tobacco|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`coi_rate_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `actual_profit_margin` SET TAGS ('dbx_business_glossary_term' = 'Actual Profit Margin Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `actual_profit_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `age_band_maximum` SET TAGS ('dbx_business_glossary_term' = 'Age Band Maximum');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `age_band_minimum` SET TAGS ('dbx_business_glossary_term' = 'Age Band Minimum');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `approved_states_list` SET TAGS ('dbx_business_glossary_term' = 'Approved States List');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `cash_value_accumulation_test_factor` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Accumulation Test (CVAT) Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `class_category` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Category');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `class_category` SET TAGS ('dbx_value_regex' = 'preferred|standard|substandard|declined');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Code');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Name');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `eligibility_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Eligibility Criteria Summary');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `experience_study_mortality_ratio` SET TAGS ('dbx_business_glossary_term' = 'Experience Study Actual-to-Expected (A/E) Mortality Ratio');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `face_amount_maximum` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Maximum');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `face_amount_minimum` SET TAGS ('dbx_business_glossary_term' = 'Face Amount Minimum');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'Gender Specific Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `gender_specific_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `guideline_premium_test_factor` SET TAGS ('dbx_business_glossary_term' = 'Guideline Premium Test (GPT) Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `inforce_policy_count` SET TAGS ('dbx_business_glossary_term' = 'In-Force Policy Count');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `inforce_policy_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `irc_7702_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `last_experience_study_date` SET TAGS ('dbx_business_glossary_term' = 'Last Experience Study Date');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `mortality_loading_factor` SET TAGS ('dbx_business_glossary_term' = 'Mortality Loading Factor');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `new_business_volume_last_year` SET TAGS ('dbx_business_glossary_term' = 'New Business (NB) Policy Count Last Year');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `new_business_volume_last_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `premium_loading_percentage` SET TAGS ('dbx_business_glossary_term' = 'Premium Loading Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `principle_based_reserving_category` SET TAGS ('dbx_business_glossary_term' = 'Principle-Based Reserving (PBR) Risk Category');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `principle_based_reserving_category` SET TAGS ('dbx_value_regex' = 'low_risk|moderate_risk|high_risk|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `profitability_target_margin` SET TAGS ('dbx_business_glossary_term' = 'Profitability Target Margin Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `profitability_target_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `reinsurance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `reinsurance_retention_limit` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Retention Limit');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `state_approval_count` SET TAGS ('dbx_business_glossary_term' = 'State Approval Count');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `superseded_by_class_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Underwriting Class Code');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `table_rating` SET TAGS ('dbx_business_glossary_term' = 'Substandard Table Rating');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `table_rating` SET TAGS ('dbx_value_regex' = '^(TABLE-[A-P]|NONE)$');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `tobacco_status` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Usage Status');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `tobacco_status` SET TAGS ('dbx_value_regex' = 'non-tobacco|tobacco|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `underwriting_class_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Status');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `underwriting_class_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|withdrawn|superseded');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`underwriting_class` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `state_approval_id` SET TAGS ('dbx_business_glossary_term' = 'State Approval Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `actuarial_memorandum_reference` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Memorandum Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'State Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'State Approval Number');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `distribution_channel_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Restrictions');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `doi_examiner_correspondence` SET TAGS ('dbx_business_glossary_term' = 'Department of Insurance (DOI) Examiner Correspondence');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date in State');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Submission Date');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'new_product|rate_revision|form_amendment|rider_addition|benefit_modification|withdrawal');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `finra_review_required` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Review Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `free_look_period_days` SET TAGS ('dbx_business_glossary_term' = 'Free Look Period in Days');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period in Days');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `illustration_actuary_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Illustration Actuary Certification Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `irc_7702_compliance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliance Confirmed Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `maximum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Face Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `maximum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `minimum_face_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Face Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `minimum_issue_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Issue Age');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `nonforfeiture_options_approved` SET TAGS ('dbx_business_glossary_term' = 'Nonforfeiture Options Approved');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `objection_history` SET TAGS ('dbx_business_glossary_term' = 'Objection History');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `policy_loan_provisions_approved` SET TAGS ('dbx_business_glossary_term' = 'Policy Loan Provisions Approved Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `rate_guarantee_period_months` SET TAGS ('dbx_business_glossary_term' = 'Rate Guarantee Period in Months');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `replacement_regulations_apply` SET TAGS ('dbx_business_glossary_term' = 'Replacement Regulations Apply Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `sec_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Filing Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `sec_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Filing Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `serff_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'System for Electronic Rate and Form Filing (SERFF) Tracking Number');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `state_specific_exclusions` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Exclusions');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `state_specific_riders_approved` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Riders Approved');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `submitted_forms_list` SET TAGS ('dbx_business_glossary_term' = 'Submitted Forms List');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `target_states` SET TAGS ('dbx_business_glossary_term' = 'Target States List');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `underwriting_class_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Class Restrictions');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`state_approval` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'State Withdrawal Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Product Filing Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `superseded_by_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Filing Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `actual_review_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Review Duration in Days');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `actuarial_memorandum_reference` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Memorandum Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `approval_correspondence_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Correspondence Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `estimated_review_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Review Duration in Days');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Submission Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Submission Method');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'serff_electronic|state_portal|paper_mail|email');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'new_product|rate_revision|form_amendment|withdrawal|objection_response|resubmission');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `irc_7702_compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliance Certification');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `objection_description` SET TAGS ('dbx_business_glossary_term' = 'Objection Description');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `objection_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Objection Issued Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `objection_response_date` SET TAGS ('dbx_business_glossary_term' = 'Objection Response Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Filing Priority Level');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'expedited|standard|low');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `prospectus_date` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `rate_filing_justification` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Justification');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Rejection Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Filing Rejection Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `sec_file_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) File Number');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `sec_registration_required` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registration Required');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `serff_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'System for Electronic Rate and Form Filing (SERFF) Tracking Number');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `serff_tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-d{6,10}$');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `submitted_forms_list` SET TAGS ('dbx_business_glossary_term' = 'Submitted Forms List');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `target_states` SET TAGS ('dbx_business_glossary_term' = 'Target States for Filing');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Withdrawal Date');
ALTER TABLE `life_insurance_ecm`.`product`.`filing` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Filing Withdrawal Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `irc7702_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) 7702 Parameter Identifier');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Identifier');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `actuarial_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Certification Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `attained_age_basis` SET TAGS ('dbx_business_glossary_term' = 'Attained Age Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `catch_up_contribution_limit` SET TAGS ('dbx_business_glossary_term' = 'Catch-Up Contribution Limit');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `compliance_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer Name');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `compliance_reviewer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `contribution_limit_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Contribution Limit');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `corridor_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Value Corridor Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `cost_basis_recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Recovery Method');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `cost_basis_recovery_method` SET TAGS ('dbx_value_regex' = 'pro_rata|FIFO|LIFO|specific_identification');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `default_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Federal Tax Withholding Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `definition_test_type` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Definition Test Type');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `definition_test_type` SET TAGS ('dbx_value_regex' = 'CVAT|GPT');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `determination_letter_date` SET TAGS ('dbx_business_glossary_term' = 'IRS Determination Letter Date');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `direct_rollover_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Rollover Option Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `early_withdrawal_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Early Withdrawal Penalty Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'IRC Parameter Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `erisa_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Retirement Income Security Act (ERISA) Applicability Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `exclusion_ratio` SET TAGS ('dbx_business_glossary_term' = 'Annuity Exclusion Ratio');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'IRC Parameter Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `guideline_level_premium` SET TAGS ('dbx_business_glossary_term' = 'Guideline Level Premium (GLP)');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `guideline_single_premium` SET TAGS ('dbx_business_glossary_term' = 'Guideline Single Premium (GSP)');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `interest_rate_assumption` SET TAGS ('dbx_business_glossary_term' = 'IRC 7702 Interest Rate Assumption');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `irc_section_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section Code');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `irs_guidance_reference` SET TAGS ('dbx_business_glossary_term' = 'IRS Guidance Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'IRC Parameter Last Updated Date');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `mec_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Status Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `mortality_table_basis` SET TAGS ('dbx_business_glossary_term' = 'Mortality Table Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `naic_model_regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Model Regulation Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'IRC Parameter Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `parameter_version_number` SET TAGS ('dbx_business_glossary_term' = 'IRC Parameter Version Number');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `private_letter_ruling_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Service (IRS) Private Letter Ruling (PLR) Number');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Qualification Type');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'qualified|non-qualified|modified_endowment|tax_deferred|taxable');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `qualified_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Qualified Retirement Plan Type');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `rmd_applicability_flag` SET TAGS ('dbx_business_glossary_term' = 'Required Minimum Distribution (RMD) Applicability Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `rmd_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Required Minimum Distribution (RMD) Calculation Method');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `rmd_calculation_method` SET TAGS ('dbx_value_regex' = 'uniform_lifetime|joint_life|single_life|fixed_term');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `rollover_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Eligibility Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `seven_pay_premium_limit` SET TAGS ('dbx_business_glossary_term' = 'Seven-Pay Premium Limit');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `state_variation_notes` SET TAGS ('dbx_business_glossary_term' = 'State Regulatory Variation Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `tamra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical and Miscellaneous Revenue Act (TAMRA) Compliance Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `tax_disclosure_requirement` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Tax Disclosure Requirement');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `tax_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Form Code');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `tax_reporting_code` SET TAGS ('dbx_value_regex' = '1099-R|1099-INT|1099-MISC|5498|W-2');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `withholding_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Federal Tax Withholding Requirement Type');
ALTER TABLE `life_insurance_ecm`.`product`.`irc7702_parameter` ALTER COLUMN `withholding_requirement_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|exempt|backup');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `crediting_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Crediting Strategy Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `allocation_maximum_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Maximum Percentage (PCT)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `allocation_minimum_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocation Minimum Percentage (PCT)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `buffer_rate` SET TAGS ('dbx_business_glossary_term' = 'Buffer Rate (Downside Protection)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Cap Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `crediting_method` SET TAGS ('dbx_business_glossary_term' = 'Crediting Method');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `crediting_method` SET TAGS ('dbx_value_regex' = 'annual_point_to_point|monthly_average|monthly_sum|participation_rate|declared_rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `declared_rate` SET TAGS ('dbx_business_glossary_term' = 'Declared Rate (Fixed Account)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number (Regulatory)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `floor_rate` SET TAGS ('dbx_business_glossary_term' = 'Floor Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `guaranteed_minimum_rate` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `hedging_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Hedging Cost Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `hedging_cost_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `historical_average_credit_rate` SET TAGS ('dbx_business_glossary_term' = 'Historical Average Credit Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `illustration_rate` SET TAGS ('dbx_business_glossary_term' = 'Illustration Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `index_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Index Calculation Method');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `index_type` SET TAGS ('dbx_business_glossary_term' = 'Index Type');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `irc_7702_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `participation_rate` SET TAGS ('dbx_business_glossary_term' = 'Participation Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `performance_lookback_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Lookback Start Date');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `rate_lock_period_months` SET TAGS ('dbx_business_glossary_term' = 'Rate Lock Period (Months)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `renewal_rate_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Rate Adjustment Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reset Frequency (Crediting Period)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_value_regex' = 'annual|monthly|biennial|custom');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `spread_rate` SET TAGS ('dbx_business_glossary_term' = 'Spread Rate (Margin)');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `state_approval_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Approval Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `state_approval_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}(,[A-Z]{2})*$');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Strategy Availability Status');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_availability_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_approval');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Strategy Code');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Strategy Description');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Strategy Name');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Strategy Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_rank_order` SET TAGS ('dbx_business_glossary_term' = 'Strategy Rank Order');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Strategy Type');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_value_regex' = 'indexed|fixed|hybrid');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `target_market_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Market Segment');
ALTER TABLE `life_insurance_ecm`.`product`.`crediting_strategy` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Identifier');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `predecessor_schedule_charge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Schedule ID');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `rate_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_amount_flat` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount Flat');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_basis` SET TAGS ('dbx_business_glossary_term' = 'Charge Basis');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_basis` SET TAGS ('dbx_value_regex' = 'percentage_of_premium|percentage_of_account_value|flat_dollar|per_thousand_face|percentage_of_withdrawal');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Cap Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_floor_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Floor Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_frequency` SET TAGS ('dbx_business_glossary_term' = 'Charge Frequency');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|annual|per_transaction');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Code');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Name');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Status');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_schedule_status` SET TAGS ('dbx_value_regex' = 'active|pending_approval|approved|inactive|superseded');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'surrender_charge|premium_load|admin_fee|mortality_expense_charge|fund_management_fee|withdrawal_fee');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_business_glossary_term' = 'Competitive Positioning');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_value_regex' = 'premium|competitive|value');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `competitive_positioning` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `current_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Current Charge Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `dac_tax_treatment` SET TAGS ('dbx_business_glossary_term' = 'Deferred Acquisition Cost (DAC) Tax Treatment');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `dac_tax_treatment` SET TAGS ('dbx_value_regex' = 'capitalized|expensed|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `dac_tax_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `dac_tax_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `free_withdrawal_percentage` SET TAGS ('dbx_business_glossary_term' = 'Free Withdrawal Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `gaap_revenue_recognition` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Revenue Recognition');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `gaap_revenue_recognition` SET TAGS ('dbx_value_regex' = 'immediate|deferred|over_coverage_period');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `guaranteed_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Charge Rate');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `illustration_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Illustration Disclosure Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `irc_7702_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `mva_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Value Adjustment (MVA) Applicable Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `policy_duration_max` SET TAGS ('dbx_business_glossary_term' = 'Policy Duration Maximum');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `policy_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Policy Duration Minimum');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `policy_year` SET TAGS ('dbx_business_glossary_term' = 'Policy Year');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `profitability_target_margin` SET TAGS ('dbx_business_glossary_term' = 'Profitability Target Margin');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `profitability_target_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `statutory_accounting_treatment` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Treatment');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `statutory_accounting_treatment` SET TAGS ('dbx_value_regex' = 'admitted_asset|non_admitted|immediate_income');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `statutory_accounting_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `statutory_accounting_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Version');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `waiver_condition` SET TAGS ('dbx_business_glossary_term' = 'Waiver Condition');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `waiver_condition` SET TAGS ('dbx_value_regex' = 'none|nursing_home_confinement|terminal_illness|disability|death|unemployment');
ALTER TABLE `life_insurance_ecm`.`product`.`charge_schedule` ALTER COLUMN `waiver_waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiver Waiting Period Days');
ALTER TABLE `life_insurance_ecm`.`product`.`form` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`form` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_id` SET TAGS ('dbx_business_glossary_term' = 'Product Form Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `acord_form_id` SET TAGS ('dbx_business_glossary_term' = 'Acord Form Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `primary_predecessor_form_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Form Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `base_form_flag` SET TAGS ('dbx_business_glossary_term' = 'Base Form Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `edition_date` SET TAGS ('dbx_business_glossary_term' = 'Edition Date');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|approved|rejected|withdrawn|pending');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_category` SET TAGS ('dbx_business_glossary_term' = 'Form Category');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_category` SET TAGS ('dbx_value_regex' = 'contract|administrative|regulatory|marketing|compliance|operational');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_description` SET TAGS ('dbx_business_glossary_term' = 'Form Description');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_name` SET TAGS ('dbx_business_glossary_term' = 'Form Name');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_type` SET TAGS ('dbx_business_glossary_term' = 'Form Type');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `form_type` SET TAGS ('dbx_value_regex' = 'base_policy|application|rider|amendment|endorsement|disclosure');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `free_look_period_days` SET TAGS ('dbx_business_glossary_term' = 'Free Look Period Days');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `illustration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Illustration Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `irc_7702_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Compliant Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `mec_risk_indicator` SET TAGS ('dbx_business_glossary_term' = 'Modified Endowment Contract (MEC) Risk Indicator');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `mec_risk_indicator` SET TAGS ('dbx_value_regex' = 'low|medium|high|not_applicable');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Print Sequence');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `prospectus_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `rider_type` SET TAGS ('dbx_business_glossary_term' = 'Rider Type');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `sec_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registered Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `state_specific_flag` SET TAGS ('dbx_business_glossary_term' = 'State Specific Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`form` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `separate_account_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Fund Identifier');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Document Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|balanced|money_market|specialty|alternative');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|restricted|discontinued');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `closed_to_new_date` SET TAGS ('dbx_business_glossary_term' = 'Closed to New Investments Date');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{9}$');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `dollar_cost_averaging_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dollar Cost Averaging (DCA) Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `expense_ratio_percent` SET TAGS ('dbx_business_glossary_term' = 'Expense Ratio Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Description');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_family` SET TAGS ('dbx_business_glossary_term' = 'Fund Family');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|closed_to_new|liquidating|merged|terminated');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Inception Date');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `investment_style` SET TAGS ('dbx_business_glossary_term' = 'Investment Style');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `investment_style` SET TAGS ('dbx_value_regex' = 'growth|value|blend|index|active|passive');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `maximum_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `maximum_transfers_per_year` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transfers Per Year');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `minimum_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `minimum_initial_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Initial Investment Amount');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `morningstar_category` SET TAGS ('dbx_business_glossary_term' = 'Morningstar Category');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `morningstar_rating` SET TAGS ('dbx_business_glossary_term' = 'Morningstar Star Rating');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `mortality_expense_charge_percent` SET TAGS ('dbx_business_glossary_term' = 'Mortality and Expense (M&E) Charge Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `nav_calculation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Frequency');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `nav_calculation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `performance_inception_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Inception Date');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'vul|variable_annuity|both');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `prospectus_date` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Date');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `rebalancing_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Eligible Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'conservative|moderate|aggressive|very_aggressive');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `sec_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registration Number');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `sec_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Ticker Symbol');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `life_insurance_ecm`.`product`.`separate_account_fund` ALTER COLUMN `transfer_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `suitability_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Suitability Rule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `predecessor_rule_suitability_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Rule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `state_regulation_id` SET TAGS ('dbx_business_glossary_term' = 'State Regulation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `best_interest_obligation_level` SET TAGS ('dbx_business_glossary_term' = 'Best Interest Obligation Level');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `best_interest_obligation_level` SET TAGS ('dbx_value_regex' = 'SUITABILITY|BEST_INTEREST|FIDUCIARY');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `investment_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Investment Experience Required');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `investment_experience_required` SET TAGS ('dbx_value_regex' = 'NONE|BASIC|INTERMEDIATE|ADVANCED');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `investment_objective_alignment` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective Alignment');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `liquidity_needs_assessment_required` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Needs Assessment Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `maximum_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Customer Age');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `maximum_premium_as_percent_of_income` SET TAGS ('dbx_business_glossary_term' = 'Maximum Premium as Percentage of Income');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `maximum_premium_as_percent_of_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Maximum Premium as Percentage of Net Worth');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `minimum_age` SET TAGS ('dbx_business_glossary_term' = 'Minimum Customer Age');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `minimum_annual_income` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Income');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `minimum_investment_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Investment Horizon (Years)');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `minimum_liquid_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Minimum Liquid Net Worth');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `minimum_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Minimum Net Worth');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `product_complexity_classification` SET TAGS ('dbx_business_glossary_term' = 'Product Complexity Classification');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `product_complexity_classification` SET TAGS ('dbx_value_regex' = 'SIMPLE|MODERATE|COMPLEX|HIGHLY_COMPLEX');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'NAIC_275|REG_BI|DOL_FIDUCIARY|STATE_SPECIFIC|FINRA_2111|INTERNAL');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `replacement_transaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Transaction Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `required_disclosure_documents` SET TAGS ('dbx_business_glossary_term' = 'Required Disclosure Documents');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `risk_tolerance_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Required');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `risk_tolerance_required` SET TAGS ('dbx_value_regex' = 'CONSERVATIVE|MODERATE|AGGRESSIVE|ANY');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Suitability Rule Code');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Suitability Rule Description');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Suitability Rule Name');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|RETIRED');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `rule_version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `senior_investor_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Senior Investor Protection Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `state_specific_override_flag` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Override Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `suitability_questionnaire_required` SET TAGS ('dbx_business_glossary_term' = 'Suitability Questionnaire Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `supervisory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Approval Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`suitability_rule` ALTER COLUMN `tax_status_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Tax Status Eligibility');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` SET TAGS ('dbx_subdomain' = 'actuarial_pricing');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Action Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `charge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `coi_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Coi Rate Schedule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `crediting_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Crediting Strategy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `plan_version_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `premium_rate_table_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Table Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `primary_predecessor_rate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Rate Action Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `actuarial_justification` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Justification');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `actuarial_memorandum_reference` SET TAGS ('dbx_business_glossary_term' = 'Actuarial Memorandum Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `advance_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Period in Days');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Announcement Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `approved_by_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Regulatory Authority');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `average_rate_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Rate Change Percentage');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `communication_method` SET TAGS ('dbx_business_glossary_term' = 'Communication Method');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `communication_method` SET TAGS ('dbx_value_regex' = 'DIRECT_MAIL|EMAIL|POLICY_STATEMENT|AGENT_NOTIFICATION|WEBSITE_POSTING|MULTIPLE');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `communication_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `guaranteed_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Rate Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `impacted_face_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Impacted Face Amount Total');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `impacted_policy_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Policy Count');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `irc_7702_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Code (IRC) Section 7702 Impact Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Notes');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `opt_out_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Available Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `opt_out_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Deadline Date');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `policyholder_communication_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Communication Plan Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `profitability_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Profitability Impact Description');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `profitability_impact_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Code');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Name');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Status');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Action Type');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_action_type` SET TAGS ('dbx_value_regex' = 'COI_RATE_CHANGE|CREDITED_INTEREST_ADJUSTMENT|EXPENSE_CHARGE_MODIFICATION|DIVIDEND_SCALE_CHANGE|MORTALITY_TABLE_UPDATE|PREMIUM_RATE_ADJUSTMENT');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_change_direction` SET TAGS ('dbx_business_glossary_term' = 'Rate Change Direction');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `rate_change_direction` SET TAGS ('dbx_value_regex' = 'INCREASE|DECREASE|MIXED|NO_CHANGE');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `reinsurance_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Impact Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `reinsurance_treaty_reference` SET TAGS ('dbx_business_glossary_term' = 'Reinsurance Treaty Reference');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `state_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'State Jurisdiction');
ALTER TABLE `life_insurance_ecm`.`product`.`rate_action` ALTER COLUMN `state_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'State Notification Required Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` SET TAGS ('dbx_association_edges' = 'product.plan,product.rider_definition');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `plan_rider_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rider Eligibility - Plan Rider Eligibility Id');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rider Eligibility - Plan Id');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `rider_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rider Eligibility - Rider Definition Id');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `eligible_base_product_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Base Product Types');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Rider Flag');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `rider_sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Rider Sequence Order');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `state_availability_override` SET TAGS ('dbx_business_glossary_term' = 'State Availability Override');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_rider_eligibility` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Termination Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` SET TAGS ('dbx_subdomain' = 'plan_design');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` SET TAGS ('dbx_association_edges' = 'product.plan,product.underwriting_class');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `plan_underwriting_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Underwriting Eligibility - Plan Underwriting Eligibility Id');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Underwriting Eligibility - Plan Id');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `underwriting_class_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Underwriting Eligibility - Underwriting Class Id');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `applicable_product_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Lines');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Effective Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `eligibility_override_criteria` SET TAGS ('dbx_business_glossary_term' = 'Plan-Specific Eligibility Override');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Expiration Date');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `minimum_face_amount_override` SET TAGS ('dbx_business_glossary_term' = 'Plan-Class Minimum Face Amount Override');
ALTER TABLE `life_insurance_ecm`.`product`.`plan_underwriting_eligibility` ALTER COLUMN `state_specific_restrictions` SET TAGS ('dbx_business_glossary_term' = 'State-Specific Restrictions');
