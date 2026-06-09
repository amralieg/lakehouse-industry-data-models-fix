-- Schema for Domain: collateral | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`collateral` COMMENT 'Collateral management for secured lending, derivatives (ISDA CSA), repo/reverse repo transactions, and margin requirements. Owns collateral valuation, haircut schedules, margin calls, substitution rights, CSA agreement tracking, collateral eligibility rules, and initial/variation margin calculations under Basel III.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_asset` (
    `collateral_asset_id` BIGINT COMMENT 'Unique identifier for the collateral asset. Primary key for the collateral asset master registry.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Custodian identification requires BIC reference for payment instructions, securities settlement, and SWIFT messaging. Creating custodian_bic_code FK to replace custodian_name.',
    `classification_id` BIGINT COMMENT 'Foreign key linking to security.classification. Business justification: HQLA classification and LCR reporting require collateral assets to reference the authoritative security classification. Collateral eligibility engines consume security.classification for FRTB risk buc',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Collateral eligibility determination and Basel III haircut schedules require formal credit rating linkage. Collateral managers apply issuer/instrument credit ratings to determine eligible collateral v',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code representing the denomination currency of the collateral asset value.',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to collateral.eligibility_rule. Business justification: A collateral asset is governed by a specific eligibility rule that determines whether it qualifies as acceptable collateral for secured lending, repo, or derivatives margining. Linking collateral_asse',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Collateral eligibility assessment and haircut determination require fund class granularity — Class A vs Class B shares have different liquidity, fees, and NAV frequencies. Regulatory capital treatment',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Collateral assets frequently include fund units/shares pledged as security for credit facilities. Real business process: secured lending against investment portfolios, margin lending for fund investme',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Collateral assets must be recorded on balance sheet with specific GL accounts for regulatory capital calculations, HQLA classification, IFRS 9 financial reporting, and month-end close reconciliation. ',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: A collateral asset is subject to a specific haircut schedule based on its asset class, credit quality, and residual maturity. Linking collateral_asset to haircut_schedule identifies the governing sche',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Custody location and jurisdiction determine applicable holiday calendar for settlement, valuation frequency, and margin call deadlines. Creating new holiday_calendar_id FK.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities are primary collateral type in banking. Daily valuation, margin calls, corporate action processing, and regulatory capital calculations (Basel III, FRTB) require direct instrument reference',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Collateral eligibility assessment and haircut determination require the issuers current credit rating. collateral_asset.credit_rating and internal_rating are denormalized copies of counterparty_ratin',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: For equity collateral, issuer industry classification is critical for concentration limit monitoring and sector risk management. Creating new issuer_industry_code_id FK.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Jurisdiction determines legal perfection, enforcement, and Basel sovereign risk weights. Required for sanctions screening and regulatory capital treatment. Creating jurisdiction_country_id FK to repla',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Basel III collateral eligibility and regulatory capital treatment depend on jurisdiction-level netting enforceability, legal system type, and regulatory framework. A banking expert expects collateral ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Collateral assets must be attributed to a legal entity for LCR/NSFR HQLA buffer reporting, Pillar 3 disclosures, and IFRS consolidation. The existing owner_party_id covers the counterparty but not the',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Asset ownership tracking is fundamental for collateral perfection, lien priority determination, regulatory capital treatment (Basel III), and legal enforceability. Banking operations require definitiv',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Collateral onboarding mandates sanctions screening of the asset owner before acceptance. OFAC/EU sanctions compliance requires screening the pledging party. This is a distinct step from KYC review. Ro',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Collateral eligibility classification under Basel III/EMIR requires mapping assets to regulatory product categories (RWA approach, HQLA classification, Basel product category). reference.product_type ',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Floating rate collateral assets (bonds, loans) reference benchmark rates for coupon calculations and valuation. Creating new benchmark_rate_id FK for floating rate instruments.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Cash collateral management: when a deposit account is the collateral asset (e.g., cash margin posted), the collateral_asset record must reference the specific deposit account for daily reconciliation,',
    `acquisition_date` DATE COMMENT 'Date on which the bank or counterparty acquired the collateral asset for pledging purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the collateral asset indicating its availability and encumbrance state. [ENUM-REF-CANDIDATE: eligible|pledged|released|ineligible|under_review|restricted|substituted — 7 candidates stripped; promote to reference product]',
    `basel_eligible_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset qualifies as eligible collateral under Basel III capital and liquidity frameworks.',
    `collateral_value` DECIMAL(18,2) COMMENT 'Net collateral value after applying haircut to the market value. This is the value available for margin and credit risk mitigation.',
    `concentration_limit_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset is subject to concentration limits under Basel III or internal risk policy.',
    `condition` STRING COMMENT 'Assessment of the physical or credit condition of the collateral asset. Impacts valuation and haircut application.. Valid values are `excellent|good|fair|poor|impaired|defaulted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral asset record was first created in the system.',
    `custody_location` STRING COMMENT 'Physical or electronic location where the collateral asset is held (custodian name, vault location, depository, or registry).',
    `data_source_system` STRING COMMENT 'Name of the source system from which the collateral asset data originated (e.g., Murex, Calypso, Collateral Management System).',
    `eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether the collateral asset meets the banks eligibility criteria for acceptance under Basel III, EMIR, and internal credit policy.',
    `emir_eligible_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset meets EMIR eligibility requirements for central clearing and bilateral margin.',
    `encumbrance_status` STRING COMMENT 'Indicates whether the collateral asset is free of liens or has existing encumbrances that affect its availability for pledging.. Valid values are `unencumbered|encumbered|partially_encumbered|cross_collateralized`',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the market value of the collateral asset to determine its collateral value. Reflects credit risk, market risk, and liquidity risk.',
    `hqla_classification` STRING COMMENT 'Classification of the collateral asset under Basel III Liquidity Coverage Ratio (LCR) framework as Level 1, Level 2A, Level 2B, or non-HQLA.. Valid values are `level_1|level_2a|level_2b|non_hqla`',
    `issue_date` DATE COMMENT 'Date on which the collateral asset was originally issued or created (e.g., bond issue date, property acquisition date).',
    `legal_description` STRING COMMENT 'Formal legal description of the collateral asset as documented in legal agreements, deeds, or certificates. Includes property descriptions, security identifiers (ISIN, CUSIP), or instrument details.',
    `lien_position` STRING COMMENT 'Priority ranking of the banks security interest in the collateral asset relative to other creditors. Critical for Loss Given Default (LGD) calculations.. Valid values are `first|second|third|subordinated|senior|pari_passu`',
    `market_value` DECIMAL(18,2) COMMENT 'Current market value of the collateral asset in the reporting currency. Updated based on mark-to-market (MTM) or appraisal.',
    `maturity_date` DATE COMMENT 'Maturity or expiration date of the collateral asset, if applicable (e.g., bond maturity, letter of credit expiry). Null for perpetual or non-maturing assets.',
    `pledged_date` DATE COMMENT 'Date on which the collateral asset was pledged to the bank or counterparty under a collateral agreement.',
    `reference_number` STRING COMMENT 'External business identifier or reference number assigned to the collateral asset for tracking and reporting purposes across systems.',
    `rehypothecation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the bank is permitted to rehypothecate (re-pledge) the collateral asset to third parties under the collateral agreement terms.',
    `release_date` DATE COMMENT 'Date on which the collateral asset was released from pledge and returned to the owner. Null if currently pledged.',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to the collateral asset for Risk-Weighted Assets (RWA) calculation under Basel III.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset can be substituted with another eligible asset under the terms of the collateral agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral asset record was last updated in the system.',
    `valuation_date` DATE COMMENT 'Date on which the market value and collateral value were last determined or updated.',
    `valuation_method` STRING COMMENT 'Methodology used to determine the market value of the collateral asset (e.g., mark-to-market for securities, appraisal for real estate).. Valid values are `mark_to_market|appraisal|model|index|cost`',
    CONSTRAINT pk_collateral_asset PRIMARY KEY(`collateral_asset_id`)
) COMMENT 'Master registry of all collateral assets pledged or eligible for pledging across secured lending, derivatives (ISDA CSA), repo/reverse repo, and margin arrangements. Captures asset type (real estate, securities, cash, commodities, receivables, letters of credit, bank guarantees), legal description, ownership details, lien position, encumbrance status, jurisdiction, custody location, asset condition, and eligibility flags per Basel III, EMIR, and internal credit policy. This is the SSOT for collateral asset identity across the bank — every valuation, pledge, position, transfer, and lifecycle event references this master.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`pledge` (
    `pledge_id` BIGINT COMMENT 'Unique identifier for the collateral pledge record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Pledge creation, substitution, and release events generate accounting entries that must be period-stamped for IFRS 7 off-balance-sheet disclosure and regulatory capital relief calculations. Period att',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: collateral_pledge.currency is a plain denormalized currency code. A proper FK to reference.currency enforces referential integrity for pledge currency, supports multi-currency margin reporting, and en',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Pledges secure credit obligations using fund holdings. Business process: portfolio-based lending where clients pledge fund investments, wealth management credit lines secured by fund portfolios, margi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Pledges create balance sheet entries for secured lending positions, collateral posted/received accounts. Required for subledger reconciliation, financial statement preparation, and regulatory capital ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Pledge agreements frequently involve securities collateral. Enables covenant monitoring, substitution eligibility checks, and position reconciliation. Essential for secured lending and derivatives col',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Pledges from new obligors or high-risk jurisdictions trigger enhanced KYC reviews per BSA/AML requirements. The review references the specific pledge arrangement to assess source of collateral and ben',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the governing ISDA Credit Support Annex agreement under which this pledge is made, if applicable to derivatives collateral.',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: AML/KYC compliance requires verifying the pledgors KYC status before accepting a collateral pledge. Regulators (EMIR, Basel III) mandate KYC clearance at pledge creation and periodic review. Role-pre',
    `risk_rating_id` BIGINT COMMENT 'Foreign key linking to customer.risk_rating. Business justification: Credit risk management requires the pledgors risk rating to determine haircut percentages, LTV ratios, and pledge eligibility at origination and review. Basel III credit risk mitigation rules tie col',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Collateral pledges for secured loans are originated at specific branches. Branch-level pledge origination reporting is a standard banking operational and regulatory requirement, enabling branch perfor',
    `onboarding_case_id` BIGINT COMMENT 'Foreign key linking to customer.onboarding_case. Business justification: Secured product onboarding creates both an onboarding_case and a collateral_pledge simultaneously. Operations and compliance teams trace pledges back to originating onboarding cases for audit, SLA tra',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Perfection jurisdiction determines legal enforceability and priority. Required for netting opinions, insolvency regime assessment, and regulatory capital relief eligibility. Creating perfection_jurisd',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Pledge perfection legal enforceability and Basel III capital relief recognition require jurisdiction-level netting enforceability status and legal opinion validity. reference.jurisdiction.netting_enfo',
    `pledge_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge_agreement. Business justification: A collateral pledge is made under a pledge agreement (the umbrella master legal agreement for secured lending). The existing margin_agreement_id covers margin-based pledges, but secured lending pledge',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: CD-secured and savings-secured lending: a deposit account is frequently pledged as collateral. The pledge record must reference the specific deposit account to enforce holds, calculate eligible collat',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Before accepting a pledge, the pledging counterparty must be sanctions-screened (OFAC, EU, UN lists). This is a distinct compliance step from KYC (already linked). Role-prefix pledgor_ identifies th',
    `party_id` BIGINT COMMENT 'Reference to the third-party custodian or depository holding the pledged collateral on behalf of the secured party.',
    `tertiary_collateral_pledge_secured_party_id` BIGINT COMMENT 'Reference to the party receiving the collateral (the secured party or beneficiary).',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the collateral pledged, expressed in the pledge currency.',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'The ratio of eligible collateral value to the credit exposure, expressed as a percentage, indicating the degree of over-collateralization or under-collateralization.',
    `created_by_user` STRING COMMENT 'The identifier of the user or system process that created this pledge record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which the pledge becomes legally effective and enforceable.',
    `eligible_collateral_value` DECIMAL(18,2) COMMENT 'The collateral value after applying the haircut, representing the amount eligible for regulatory capital relief under Basel III CRM framework.',
    `enforcement_date` DATE COMMENT 'The date on which the secured party exercised its right to seize and liquidate the pledged collateral due to obligor default.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the collateral market value to determine its eligible collateral value for credit risk mitigation purposes under Basel III.',
    `initial_margin_amount` DECIMAL(18,2) COMMENT 'The initial margin amount posted as collateral at the inception of the derivative or repo transaction, as required under the CSA or margin agreement.',
    `legal_perfection_status` STRING COMMENT 'Indicates whether the security interest has been legally perfected (enforceable against third parties): perfected (fully enforceable), pending (perfection in progress), unperfected (not yet enforceable), disputed (under legal challenge).. Valid values are `perfected|pending|unperfected|disputed`',
    `lien_rank` STRING COMMENT 'The priority ranking of this pledge relative to other liens on the same collateral: first (highest priority), second, subordinate, pari passu (equal ranking), junior, senior.. Valid values are `first|second|subordinate|pari_passu|junior|senior`',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'The ratio of the outstanding credit exposure to the current market value of the pledged collateral, expressed as a percentage, used to monitor collateral coverage adequacy.',
    `maturity_date` DATE COMMENT 'The date on which the pledge expires or is scheduled to be released, if applicable.',
    `notes` STRING COMMENT 'Free-text notes capturing additional operational or legal details about the pledge, including special terms, conditions, or exceptions.',
    `perfection_date` DATE COMMENT 'The date on which the security interest was legally perfected through filing, registration, or other required action.',
    `perfection_method` STRING COMMENT 'The legal method used to perfect the security interest: UCC filing, control agreement, physical possession, securities registration, or certificate notation.. Valid values are `ucc_filing|control_agreement|possession|registration|notation`',
    `pledge_date` DATE COMMENT 'The date on which the collateral was formally pledged to secure the obligation.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of the pledge: active (in force), released (returned to obligor), substituted (replaced with alternative collateral), enforced (collateral seized), defaulted (obligor in default), pending (awaiting perfection).. Valid values are `active|released|substituted|enforced|defaulted|pending`',
    `pledge_type` STRING COMMENT 'The type of obligation being secured by this pledge: loan collateral (secured lending), derivative margin (ISDA CSA), repo collateral (repo/reverse repo), guarantee backing, letter of credit collateral.. Valid values are `loan_collateral|derivative_margin|repo_collateral|guarantee_backing|letter_of_credit`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or number of units of the collateral asset pledged (e.g., number of shares, bonds, or other securities).',
    `reference_number` STRING COMMENT 'External business reference number or identifier for the pledge, used in legal documentation and operational tracking.',
    `regulatory_capital_relief_amount` DECIMAL(18,2) COMMENT 'The amount of regulatory capital relief recognized under Basel III CRM framework as a result of this collateral pledge, reducing Risk-Weighted Assets (RWA).',
    `release_date` DATE COMMENT 'The date on which the pledged collateral was released back to the obligor upon satisfaction of the secured obligation.',
    `rwa_reduction_amount` DECIMAL(18,2) COMMENT 'The reduction in Risk-Weighted Assets attributable to this collateral pledge under Basel III capital adequacy calculations.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the obligor has the contractual right to substitute this collateral with alternative eligible collateral.',
    `substitution_date` DATE COMMENT 'The date on which this collateral was substituted with alternative collateral, if applicable.',
    `updated_by_user` STRING COMMENT 'The identifier of the user or system process that last modified this pledge record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was last modified in the system.',
    `valuation_date` DATE COMMENT 'The date on which the collateral was last valued for pledge amount and coverage calculation purposes.',
    `valuation_method` STRING COMMENT 'The method used to determine the current value of the pledged collateral: market (observable market price), model (internal valuation model), appraisal (third-party appraisal), cost (historical cost), fair value (IFRS 13 fair value).. Valid values are `market|model|appraisal|cost|fair_value`',
    `variation_margin_amount` DECIMAL(18,2) COMMENT 'The variation margin amount posted or received to reflect daily mark-to-market changes in the value of the underlying derivative or repo transaction.',
    CONSTRAINT pk_pledge PRIMARY KEY(`pledge_id`)
) COMMENT 'Operational record of a collateral pledge — the formal assignment of a specific collateral asset to secure a specific credit exposure, derivative obligation, or repo transaction. Tracks pledge date, pledge amount/quantity, lien rank (first, second, subordinate), pledge status (active, released, substituted, enforced, defaulted), legal perfection status, obligor, secured party, and the governing collateral agreement. Links collateral assets to the underlying credit or trading obligation. Supports LTV monitoring, collateral coverage calculations, and regulatory capital recognition of credit risk mitigation under Basel III CRM framework.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`margin_call` (
    `margin_call_id` BIGINT COMMENT 'Unique identifier for the margin call transaction. Primary key for the margin call record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Margin call activity (VM settlements, IM movements) must be bucketed by accounting period for EMIR/Dodd-Frank regulatory reporting, period-end P&L recognition, and collateral accounting close processe',
    `collateral_position_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_position. Business justification: A margin call results in changes to collateral positions — when a margin call is issued, it affects the collateral_posted_amount and collateral_received_amount in the position. Linking collateral_marg',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: A margin call is triggered by a collateral valuation — specifically when the net_collateral_value falls below the threshold or when mark-to-market exposure changes. Linking collateral_margin_call to t',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: collateral_margin_call.currency is a plain denormalized code. A proper FK to reference.currency is required for EMIR/UMR margin call settlement currency validation, multi-currency margin reporting, an',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: EMIR and Dodd-Frank require documentation of how margin calls are communicated to counterparties. Tracking the delivery channel (SWIFT, portal, email, phone) for each margin call is a named compliance',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Delivery deadline calculation requires holiday calendar for business day adjustment per CSA terms. Creating new holiday_calendar_id FK.',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the CSA agreement governing the margin terms for this call.',
    `netting_set_id` BIGINT COMMENT 'Reference to the netting set under which this margin call is calculated, grouping trades subject to the same CSA or master agreement.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty involved in the margin call transaction.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: A margin call is issued against a specific collateral pledge — the formal assignment of a collateral asset to secure an obligation. Linking collateral_margin_call to collateral_pledge identifies which',
    `amount` DECIMAL(18,2) COMMENT 'The total amount of margin called or settled in the transaction currency.',
    `call_date` DATE COMMENT 'The business date on which the margin call was calculated and issued or received.',
    `call_direction` STRING COMMENT 'Indicates whether the margin call was issued by the institution to a counterparty or received from a counterparty.. Valid values are `issued|received`',
    `call_timestamp` TIMESTAMP COMMENT 'Precise date and time when the margin call was generated and communicated to the counterparty.',
    `collateral_posted_amount` DECIMAL(18,2) COMMENT 'The total amount of collateral posted by the institution to the counterparty as of the call date.',
    `collateral_received_amount` DECIMAL(18,2) COMMENT 'The total amount of collateral received by the institution from the counterparty as of the call date.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the margin call record was first created in the collateral management system.',
    `daily_vm_requirement_flag` BOOLEAN COMMENT 'Indicates whether this margin call is subject to daily Variation Margin exchange requirements per regulatory rules.',
    `delivery_deadline_date` DATE COMMENT 'The date by which the margin must be delivered to satisfy the call, per CSA or CCP rules.',
    `delivery_deadline_timestamp` TIMESTAMP COMMENT 'Precise date and time by which the margin must be delivered, including intraday deadlines for VM settlements.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the margin call is currently under dispute by either party.',
    `dispute_raised_date` DATE COMMENT 'The date on which the dispute was formally raised by either party.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the reason for the margin call dispute, including valuation disagreements, calculation errors, or collateral eligibility issues.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the dispute was formally resolved and the margin call status was updated accordingly.',
    `dispute_resolution_status` STRING COMMENT 'Current status of the dispute resolution process from initial dispute through final resolution or withdrawal.. Valid values are `open|under_review|escalated|resolved|withdrawn`',
    `dodd_frank_compliance_flag` BOOLEAN COMMENT 'Indicates whether this margin call is subject to and compliant with Dodd-Frank Act margin requirements for uncleared swaps.',
    `emir_compliance_flag` BOOLEAN COMMENT 'Indicates whether this margin call is subject to and compliant with EMIR margin requirements for OTC derivatives.',
    `im_calculation_methodology` STRING COMMENT 'The methodology used to calculate Initial Margin: ISDA SIMM (Standard Initial Margin Model), schedule-based approach, internal model, or CCP-prescribed method.. Valid values are `isda_simm|schedule_based|internal_model|ccp_prescribed`',
    `im_custodian_identifier` STRING COMMENT 'Legal Entity Identifier (LEI) or other unique identifier for the IM custodian.',
    `im_custodian_name` STRING COMMENT 'Name of the third-party custodian holding the segregated Initial Margin collateral.',
    `im_segregation_status` STRING COMMENT 'Indicates whether the Initial Margin is held in a segregated account per regulatory requirements (UMR, Dodd-Frank, EMIR).. Valid values are `segregated|non_segregated|partially_segregated`',
    `independent_amount` DECIMAL(18,2) COMMENT 'Additional margin amount required beyond mark-to-market exposure, often used as a buffer for potential future exposure or credit risk mitigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the margin call record was last updated, tracking any status changes, settlements, or dispute updates.',
    `margin_call_status` STRING COMMENT 'Current lifecycle status of the margin call from issuance through settlement or dispute resolution. [ENUM-REF-CANDIDATE: pending|issued|acknowledged|partially_settled|fully_settled|disputed|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `margin_call_type` STRING COMMENT 'Classification of the margin arrangement: bilateral (under CSA), central counterparty (CCP), or tri-party collateral management.. Valid values are `bilateral|ccp|tri_party`',
    `margin_type` STRING COMMENT 'Classification of margin activity: Initial Margin (IM) requirement, IM posted, IM received, Variation Margin (VM) call, or VM settlement.. Valid values are `initial_margin_requirement|initial_margin_posted|initial_margin_received|variation_margin_call|variation_margin_settlement`',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum amount that must be transferred to satisfy a margin call, per CSA terms, to reduce operational burden of small transfers.',
    `net_exposure_amount` DECIMAL(18,2) COMMENT 'The net mark-to-market exposure of the netting set after netting all trades, used as the basis for margin calculation.',
    `reference_number` STRING COMMENT 'Business identifier for the margin call, used for external communication and reconciliation with counterparties.',
    `settlement_confirmation_reference` STRING COMMENT 'External reference number or confirmation identifier from the settlement system or counterparty acknowledging receipt of margin.',
    `settlement_date` DATE COMMENT 'The date on which the margin was actually delivered and settled, confirming completion of the call.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the margin settlement was confirmed and recorded.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The CSA threshold amount below which no margin call is required, representing the unsecured credit exposure limit.',
    `umr_compliance_flag` BOOLEAN COMMENT 'Indicates whether this margin call is subject to and compliant with Uncleared Margin Rules (UMR) requirements.',
    `umr_phase` STRING COMMENT 'The regulatory phase under which this margin call falls per the phased implementation of Uncleared Margin Rules (UMR) based on counterparty aggregate average notional amount (AANA). [ENUM-REF-CANDIDATE: phase_1|phase_2|phase_3|phase_4|phase_5|phase_6|not_applicable — 7 candidates stripped; promote to reference product]',
    `valuation_date` DATE COMMENT 'The date on which the underlying portfolio or exposure was valued to determine the margin requirement.',
    `vm_settlement_status` STRING COMMENT 'Current status of the Variation Margin settlement process from call issuance through final settlement confirmation.. Valid values are `pending|in_transit|settled|failed|reversed`',
    CONSTRAINT pk_margin_call PRIMARY KEY(`margin_call_id`)
) COMMENT 'Transactional record of all margin activity — margin calls, initial margin (IM) requirements and balances, and variation margin (VM) daily settlements — under CSA, CCP, and bilateral margin arrangements. Captures call/settlement date, margin type (IM requirement, IM posted/received, VM call, VM settlement), call direction (issued, received), amount, currency, delivery deadline, IM calculation methodology (ISDA SIMM, schedule-based), IM segregation status and custodian details, VM settlement status, netting set reference, dispute flag, dispute reason, dispute resolution status, settlement confirmation, UMR phase compliance, and regulatory flags (UMR, EMIR, Dodd-Frank daily VM). Tracks the full margin lifecycle from requirement calculation through call issuance, delivery, dispute resolution, and settlement confirmation per BCBS/IOSCO margin rules. This is the SSOT for all margin activity including IM balances and VM settlements.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_valuation` (
    `collateral_valuation_id` BIGINT COMMENT 'Unique identifier for the collateral valuation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Collateral valuations drive IFRS 13 fair value disclosures and period-end balance sheet entries. Linking to accounting_period enables period-close reconciliation between the collateral subledger and G',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Cash collateral valuation: valuations of cash collateral must reference the deposit account to pull the authoritative balance for net collateral value calculation. Valuation agents and risk systems re',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset being valued.',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Collateral valuation applies credit quality adjustments (haircuts, eligible value calculations) based on formal credit ratings. Basel III and EMIR require credit quality step linkage in collateral val',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the collateral is denominated (e.g., USD, EUR, GBP, JPY).',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Valuations of fund units used as collateral require fund-level reference. Business process: applying haircuts to fund NAVs for collateral eligibility calculations, mark-to-market valuation of pledged ',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: collateral_valuation applies a haircut to compute net_collateral_value from gross_market_value. The haircut_schedule is the authoritative reference defining haircut percentages by asset class, residua',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Valuation process requires instrument master data for pricing methodology selection, haircut application, and mark-to-market calculations. Critical for daily margin call generation and regulatory repo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Valuation adjustments (haircut changes, mark-to-market movements) generate journal entries for P&L or OCI impact under IFRS 13 fair value accounting. Required for financial close, valuation audit trai',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Collateral valuations are performed in the context of a specific margin agreement — the agreement defines valuation frequency, valuation agent, and methodology. Linking collateral_valuation directly t',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: Collateral valuation of fund shares directly uses the NAV record as the authoritative pricing source. Linking collateral_valuation to nav_record enables automated valuation updates, margin call trigge',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA CSA agreement governing the collateral terms for derivatives transactions, if applicable.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Collateral valuations are performed in the context of specific pledge instances for LTV monitoring and margin calculations. The existing pledge_agreement_id links to the master agreement, but valuatio',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Collateral valuation must be traceable to the source market price for EMIR/Dodd-Frank audit trails and margin dispute resolution. Regulators require collateral valuations to reference the specific pri',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Floating-rate collateral assets (FRNs, ABS, CLOs) require a rate benchmark reference for fair value calculation. The valuation model uses the benchmark to discount cash flows. A banking expert expects',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory exams (Fed, OCC, ECB) specifically review collateral valuation methodologies, model versions, and override practices for fair value and capital adequacy compliance. Examiners request valuat',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: CCAR/DFAST require collateral valuations under supervisory stress scenarios. Stressed collateral values drive LGD, RWA, and capital projections. Essential for regulatory stress testing submissions and',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Stress test runs produce stressed collateral valuations used in CCAR/DFAST and ICAAP reporting. Linking collateral_valuation to stress_test_run provides execution traceability — auditors and regulator',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when the valuation was formally approved and became effective for margin calculations and regulatory reporting.',
    `collateral_asset_class` STRING COMMENT 'The broad asset class category of the collateral being valued, determining applicable haircut schedules and eligibility rules under Basel III. [ENUM-REF-CANDIDATE: cash|government_securities|corporate_bonds|equities|real_estate|commodities|derivatives|other — 8 candidates stripped; promote to reference product]',
    `concentration_limit_breach` BOOLEAN COMMENT 'Flag indicating whether accepting this collateral valuation would breach concentration limits defined in the CSA agreement or internal risk policies.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the valuation, representing the minimum expected value within the statistical confidence range (typically 95% or 99%).',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the valuation, representing the maximum expected value within the statistical confidence range.',
    `confidence_level_percentage` DECIMAL(18,2) COMMENT 'The statistical confidence level used for the valuation interval, typically 0.95 (95%) or 0.99 (99%), indicating the probability that the true value falls within the stated range.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was first created in the system.',
    `eligible_for_central_bank` BOOLEAN COMMENT 'Indicates whether this collateral asset is eligible for use in central bank operations (e.g., Fed discount window, ECB refinancing operations).',
    `frequency` STRING COMMENT 'The scheduled frequency at which this collateral asset is revalued. Daily MTM for liquid securities and derivatives, periodic for real estate and illiquid assets, event-driven for trigger-based revaluations, or continuous for real-time pricing. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|event_driven|continuous — 7 candidates stripped; promote to reference product]',
    `gross_market_value` DECIMAL(18,2) COMMENT 'The unadjusted market value of the collateral asset before applying any haircuts or adjustments.',
    `haircut_amount` DECIMAL(18,2) COMMENT 'The absolute monetary value of the haircut applied, calculated as gross market value multiplied by haircut percentage.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage reduction applied to the gross market value to account for market volatility, liquidity risk, and potential value decline during liquidation. Expressed as a decimal (e.g., 0.15 for 15%).',
    `liquidity_classification` STRING COMMENT 'The Basel III HQLA classification for the collateral asset. Level 1 (highest quality, 0% haircut), Level 2A (high quality, 15% haircut), Level 2B (lower quality, 25-50% haircut), or Non-HQLA (not eligible for LCR).. Valid values are `level_1|level_2a|level_2b|non_hqla`',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'The loan-to-value ratio calculated using this collateral valuation, representing the outstanding loan amount divided by the net collateral value. Critical for secured lending risk assessment.',
    `margin_type` STRING COMMENT 'The type of margin this valuation supports. Initial margin for upfront collateral, variation margin for daily MTM adjustments, independent amount for additional buffer, or minimum transfer amount for threshold calculations.. Valid values are `initial_margin|variation_margin|independent_amount|minimum_transfer_amount`',
    `maturity_date` DATE COMMENT 'The maturity or expiration date of the collateral asset, if applicable (e.g., bond maturity, option expiration). Null for perpetual or non-maturing assets like equities or real estate.',
    `model_version` STRING COMMENT 'The version identifier of the internal pricing model used for valuation, supporting model governance and audit trail requirements.',
    `net_collateral_value` DECIMAL(18,2) COMMENT 'The adjusted collateral value after applying haircuts, representing the effective value available for margin coverage and LTV (Loan-to-Value) calculations.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether the valuation was manually overridden by a risk officer or valuation specialist, requiring additional documentation and approval.',
    `override_reason` STRING COMMENT 'Detailed explanation for why the valuation was manually overridden, including reference to supporting documentation and approver identity.',
    `previous_net_value` DECIMAL(18,2) COMMENT 'The net collateral value from the previous valuation, used to calculate value changes and trigger margin calls when thresholds are breached.',
    `previous_valuation_date` DATE COMMENT 'The date of the immediately preceding valuation for this collateral asset, enabling time-series analysis and value change tracking.',
    `purpose` STRING COMMENT 'The business purpose for which this valuation was performed, such as margin call calculation, LTV monitoring, regulatory reporting (Basel III, CCAR, DFAST), credit underwriting decision, portfolio review, or stress testing scenario.. Valid values are `margin_call|ltv_monitoring|regulatory_reporting|credit_decision|portfolio_review|stress_testing`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was last modified.',
    `valuation_date` DATE COMMENT 'The date on which the collateral valuation was performed.',
    `valuation_method` STRING COMMENT 'The methodology used to determine the collateral value. Mark-to-market for liquid securities, appraisal for real estate, model-based for complex instruments, index-based for commodities, broker quote for illiquid assets, or internal model for proprietary valuations.. Valid values are `mark_to_market|appraisal|model_based|index_based|broker_quote|internal_model`',
    `valuation_source` STRING COMMENT 'The origin of the valuation data, indicating whether it came from an internal pricing model, third-party appraiser, exchange pricing feed, market data vendor, broker quote, or index provider.. Valid values are `internal_model|third_party_appraiser|exchange_price|vendor_feed|broker_quote|index_provider`',
    `valuation_status` STRING COMMENT 'The current status of the valuation record. Final indicates approved and active, preliminary for initial calculations, pending review for valuations awaiting approval, disputed for challenged valuations, overridden for manually adjusted values, stale for outdated valuations requiring refresh.. Valid values are `final|preliminary|pending_review|disputed|overridden|stale`',
    `valuation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the valuation was calculated, supporting intraday MTM (Mark-to-Market) for derivatives and trading book positions.',
    `value_change_amount` DECIMAL(18,2) COMMENT 'The absolute change in net collateral value since the previous valuation, calculated as current net value minus previous net value.',
    `value_change_percentage` DECIMAL(18,2) COMMENT 'The percentage change in net collateral value since the previous valuation, expressed as a decimal (e.g., 0.0523 for 5.23% increase).',
    CONSTRAINT pk_collateral_valuation PRIMARY KEY(`collateral_valuation_id`)
) COMMENT 'Time-series record of collateral asset valuations used for margin calculations, LTV monitoring, and regulatory reporting. Captures valuation date, valuation method (MTM, appraisal, model-based, index-based), gross market value, haircut applied, net collateral value, valuation source (internal model, third-party appraiser, exchange price), currency, and confidence interval. Supports daily MTM for derivatives and periodic appraisal for real estate and illiquid assets.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`haircut_schedule` (
    `haircut_schedule_id` BIGINT COMMENT 'Unique identifier for the haircut schedule entry. Primary key for this reference table.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Haircut schedules vary by currency due to FX volatility and liquidity. Central banks publish currency-specific haircut tables for regulatory capital and margin calculations. Creating new FK.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Haircut schedules are jurisdiction-specific under BCBS/IOSCO, EMIR, and Dodd-Frank. reference.jurisdiction.regulatory_framework and netting_enforceability_flag determine which haircut schedule applies',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Interest rate collateral haircut schedules under BCBS/IOSCO are benchmark-specific (SOFR vs EURIBOR vs SONIA). The volatility_adjustment_method and holding_period_days in haircut_schedule depend on th',
    `approval_status` STRING COMMENT 'Current approval state of this haircut schedule entry within the governance workflow. Only approved schedules are used in production calculations.. Valid values are `draft|pending_approval|approved|superseded|retired`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this haircut schedule entry was formally approved. Supports audit trail and regulatory examination requirements.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized individual who approved this haircut schedule entry. Required for regulatory audit and SOX compliance.',
    `asset_class` STRING COMMENT 'The broad category of collateral asset to which this haircut applies. Aligns with Basel III asset classification for credit risk mitigation. [ENUM-REF-CANDIDATE: equity|government_bond|corporate_bond|covered_bond|asset_backed_security|cash|gold — 7 candidates stripped; promote to reference product]',
    `asset_subclass` STRING COMMENT 'Granular sub-category within the asset class (e.g., sovereign bond, municipal bond, investment-grade corporate bond, high-yield bond). Provides additional segmentation for haircut determination.',
    `bilateral_csa_haircut_pct` DECIMAL(18,2) COMMENT 'Negotiated haircut percentage specified in a bilateral Credit Support Annex under an ISDA Master Agreement. May differ from supervisory haircuts based on counterparty agreement.',
    `ccp_haircut_pct` DECIMAL(18,2) COMMENT 'Haircut percentage applied by a qualifying central counterparty (QCCP) for cleared derivatives and securities financing transactions. Reflects CCP-specific margin methodology.',
    `collateral_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this asset class is eligible as collateral under the applicable regulatory framework and internal policy. True if eligible, False if ineligible.',
    `concentration_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of total collateral pool that can be composed of this asset class. Prevents over-concentration in single asset types.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level used in VaR-based haircut calculations. Basel III requires 99% confidence level for own-estimate haircuts.',
    `credit_quality_step` STRING COMMENT 'The credit quality step assigned to the collateral asset under the standardized approach, mapping external credit ratings to regulatory risk buckets. CQS 1 represents highest credit quality (e.g., AAA to AA-), CQS 6 represents lowest investment grade. [ENUM-REF-CANDIDATE: CQS_1|CQS_2|CQS_3|CQS_4|CQS_5|CQS_6|unrated — 7 candidates stripped; promote to reference product]',
    `currency_mismatch_addon_pct` DECIMAL(18,2) COMMENT 'Additional haircut percentage applied when collateral and exposure currencies differ. Typically 8% under Basel III standardized approach for major currency pairs.',
    `currency_mismatch_indicator` BOOLEAN COMMENT 'Flag indicating whether the collateral currency differs from the exposure currency. True if mismatch exists, requiring an additional haircut add-on per Basel III.',
    `effective_date` DATE COMMENT 'The date from which this haircut schedule entry becomes active and applicable to collateral valuations and margin calculations.',
    `expiry_date` DATE COMMENT 'The date on which this haircut schedule entry ceases to be valid. Null indicates an open-ended schedule with no defined expiration.',
    `holding_period_days` STRING COMMENT 'Assumed liquidation period for the collateral asset, used to scale haircuts. Longer holding periods require higher haircuts. Basel III specifies minimum holding periods by transaction type.',
    `initial_margin_haircut_pct` DECIMAL(18,2) COMMENT 'Haircut applied to collateral posted as initial margin for non-cleared derivatives under the BCBS-IOSCO margin framework. Protects against potential future exposure.',
    `internal_model_haircut_pct` DECIMAL(18,2) COMMENT 'Haircut percentage derived from the banks own internal Value-at-Risk (VaR) model under the own-estimate approach, subject to regulatory approval and minimum floors.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this haircut schedule entry. Basel III and internal policy require regular review of haircut parameters.',
    `liquidity_category` STRING COMMENT 'Classification of the collateral asset based on market depth, trading volume, and ease of liquidation. Highly liquid assets (e.g., G7 sovereign bonds) receive lower haircuts.. Valid values are `highly_liquid|liquid|less_liquid|illiquid`',
    `lookback_period_days` STRING COMMENT 'Number of historical days used to calculate volatility and haircut estimates under internal models. Basel III requires minimum 1-year lookback for own-estimate approach.',
    `minimum_haircut_floor_pct` DECIMAL(18,2) COMMENT 'Regulatory minimum haircut percentage that must be applied regardless of internal model estimates. Ensures prudent collateral valuation under all circumstances.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of this haircut schedule entry. Ensures ongoing appropriateness of haircut parameters.',
    `notes` STRING COMMENT 'Free-text field for additional context, rationale, or special instructions related to this haircut schedule entry. Supports operational transparency and knowledge transfer.',
    `regulatory_framework` STRING COMMENT 'The primary regulatory regime under which this haircut schedule is defined. Different frameworks may prescribe different haircut methodologies and floors.. Valid values are `basel_iii|emir|dodd_frank|mifid_ii|sftr|ucits`',
    `residual_maturity_bucket` STRING COMMENT 'The time-to-maturity band of the collateral instrument. Longer maturities typically attract higher haircuts due to increased interest rate and market risk.. Valid values are `less_than_1_year|1_to_5_years|5_to_10_years|over_10_years|perpetual`',
    `source_system` STRING COMMENT 'The upstream system or platform from which this haircut schedule was sourced (e.g., SAS Risk Management, Murex, internal risk engine). Supports data lineage and reconciliation.',
    `supervisory_haircut_pct` DECIMAL(18,2) COMMENT 'The standardized haircut percentage prescribed by the Basel III supervisory framework for this asset class, credit quality, and maturity combination. Used under the standardized approach for credit risk mitigation.',
    `transaction_type` STRING COMMENT 'The type of collateralized transaction to which this haircut applies. Different transaction types may have different haircut requirements under Basel III.. Valid values are `repo|reverse_repo|securities_lending|derivatives_margin|secured_loan`',
    `variation_margin_haircut_pct` DECIMAL(18,2) COMMENT 'Haircut applied to collateral posted as variation margin for non-cleared derivatives. Typically lower than initial margin haircuts as VM covers current exposure.',
    `version_number` STRING COMMENT 'Sequential version identifier for this haircut schedule entry. Increments with each revision to support audit trail and historical analysis.',
    `volatility_adjustment_method` STRING COMMENT 'The statistical or econometric method used to calculate volatility-based haircut adjustments. Relevant for internal model approaches and dynamic haircut schedules.. Valid values are `historical_simulation|parametric_var|monte_carlo|ewma|garch`',
    CONSTRAINT pk_haircut_schedule PRIMARY KEY(`haircut_schedule_id`)
) COMMENT 'Reference table defining haircut percentages applied to collateral asset categories for margin and exposure calculations. Covers Basel III standardized approach supervisory haircuts, internal model-based haircuts (own-estimate approach), CCP-specific haircuts, and bilateral CSA-negotiated haircuts. Captures asset class, credit quality step (CQS), residual maturity bucket, currency mismatch add-on, liquidity category, volatility adjustment methodology, regulatory framework (Basel III, EMIR, Dodd-Frank), effective date, and expiry date. Governs the reduction in collateral value recognized for credit risk mitigation and regulatory capital purposes.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'Unique identifier for the collateral eligibility rule. Primary key for the eligibility rule entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Eligibility rules operationalize regulatory obligations (central bank eligibility criteria, CCP requirements, Basel HQLA definitions). Each rule maps to specific regulatory citations and compliance ob',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Eligibility rules specify currency restrictions (e.g., only G10 currencies eligible for VM under BCBS/IOSCO). The plain currency_code column is a denormalized reference.currency representation. A pr',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: Eligibility rules define what collateral is acceptable and at what haircut. The haircut_schedule is the reference table defining haircut percentages by asset class and regulatory framework. An eligibi',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Collateral eligibility rules are jurisdiction-specific (EMIR vs Dodd-Frank vs APRA regimes). reference.jurisdiction.regulatory_framework and capital_adequacy_framework determine rule applicability. Th',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Collateral eligibility rules are derived from and must conform to the banks Collateral Eligibility Policy. Compliance officers link eligibility rules to governing policies for audit, policy change ma',
    `approval_authority` STRING COMMENT 'Name or identifier of the business unit, committee, or individual who approved this eligibility rule. Typically includes risk management, credit committee, or ALCO (Asset-Liability Committee).',
    `approval_date` DATE COMMENT 'Date on which the eligibility rule was formally approved by the designated approval authority.',
    `asset_class` STRING COMMENT 'The asset class to which this eligibility rule applies. Defines the broad category of collateral instruments covered by the rule, such as cash, government bonds, corporate bonds, equities, mortgage-backed securities (MBS), asset-backed securities (ABS), collateralized loan obligations (CLO), collateralized debt obligations (CDO), credit default swaps (CDS), or repo transactions. [ENUM-REF-CANDIDATE: cash|government_bond|corporate_bond|equity|mbs|abs|clo|cdo|cds|repo|other — 11 candidates stripped; promote to reference product]',
    `asset_type` STRING COMMENT 'More granular asset type specification within the asset class, such as specific instrument types, security subtypes, or product categories. Provides additional detail beyond the broad asset class.',
    `breach_action` STRING COMMENT 'Action to be taken when the eligibility rule or concentration limit is breached: hard_stop (prevent transaction), soft_warning (alert but allow), escalation (notify risk management), or auto_rebalance (trigger automatic portfolio rebalancing).. Valid values are `hard_stop|soft_warning|escalation|auto_rebalance`',
    `concentration_limit_absolute_amount` DECIMAL(18,2) COMMENT 'Maximum absolute monetary amount that can be allocated to the specified concentration dimension, expressed in the base currency of the collateral arrangement. Used when limits are defined in absolute terms rather than percentages.',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of total collateral portfolio value that can be allocated to the specified concentration dimension (e.g., no more than 25% from a single issuer). Expressed as a percentage with two decimal places.',
    `concentration_limit_type` STRING COMMENT 'Dimension along which the concentration limit is applied: issuer (single issuer exposure), asset_class (exposure to one asset class), currency (single currency exposure), counterparty (exposure to one counterparty), jurisdiction (geographic concentration), or sector (industry sector concentration).. Valid values are `issuer|asset_class|currency|counterparty|jurisdiction|sector`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility rule record was first created in the collateral management system.',
    `effective_date` DATE COMMENT 'Date from which the eligibility rule becomes active and enforceable. Rules are not applied to collateral arrangements before this date.',
    `eligible_for_ccp` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible for posting to a central counterparty (CCP) for cleared derivatives transactions. True if eligible, false otherwise.',
    `eligible_for_initial_margin` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible to satisfy initial margin (IM) requirements under uncleared derivatives margin rules (UMR). True if eligible, false otherwise.',
    `eligible_for_repo` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible for use in repurchase (repo) or reverse repurchase (reverse repo) transactions. True if eligible, false otherwise.',
    `eligible_for_secured_lending` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible for secured lending transactions, including securities lending and collateralized loans. True if eligible, false otherwise.',
    `eligible_for_variation_margin` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible to satisfy variation margin (VM) requirements under derivatives margining frameworks. True if eligible, false otherwise.',
    `expiry_date` DATE COMMENT 'Date on which the eligibility rule ceases to be active. Null indicates the rule has no expiration and remains in effect indefinitely unless explicitly deactivated.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Valuation discount percentage applied to collateral assets meeting this eligibility rule, reflecting market risk, liquidity risk, and credit risk. Expressed as a percentage (e.g., 5.00 means a 5% haircut).',
    `issuer_type` STRING COMMENT 'Classification of the issuer of the collateral asset: sovereign (government), supranational (international organizations), agency (government-sponsored entities), corporate (non-financial corporations), financial institution (banks, insurers), municipal (local government), or other. [ENUM-REF-CANDIDATE: sovereign|supranational|agency|corporate|financial_institution|municipal|other — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the eligibility rule record, capturing any updates to rule parameters, status, or metadata.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the eligibility rule. Rules are typically reviewed annually or when regulatory requirements change.',
    `limit_scope` STRING COMMENT 'Scope of application for the eligibility or concentration rule: portfolio-wide (applies across all collateral arrangements), agreement-specific (applies to a single CSA or collateral agreement), counterparty-specific (applies to all arrangements with one counterparty), or product-specific (applies to a specific product type).. Valid values are `portfolio_wide|agreement_specific|counterparty_specific|product_specific`',
    `maximum_maturity_days` STRING COMMENT 'Maximum remaining time to maturity in days for collateral assets to be eligible under this rule. Assets with longer maturity are excluded.',
    `minimum_credit_rating` STRING COMMENT 'Minimum acceptable credit rating for collateral assets under this rule, expressed in standard rating agency notation (e.g., AAA, AA+, A-, BBB). Assets below this rating are ineligible. NR indicates no rating requirement.. Valid values are `^(AAA|AA[+-]?|A[+-]?|BBB[+-]?|BB[+-]?|B[+-]?|CCC[+-]?|CC|C|D|NR)$`',
    `minimum_maturity_days` STRING COMMENT 'Minimum remaining time to maturity in days for collateral assets to be eligible under this rule. Assets with shorter maturity are excluded.',
    `modified_by_user` STRING COMMENT 'User identifier or name of the individual who last modified the eligibility rule record. Used for audit trail and accountability purposes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the eligibility rule to ensure continued relevance and regulatory compliance.',
    `regulatory_framework` STRING COMMENT 'Regulatory framework or compliance regime that mandates or influences this eligibility rule: Basel III (capital and liquidity standards), EMIR (European Market Infrastructure Regulation), UMR (Uncleared Margin Rules), Dodd-Frank (US derivatives regulation), MiFID II (Markets in Financial Instruments Directive), internal credit policy, CCAR (Comprehensive Capital Analysis and Review), DFAST (Dodd-Frank Act Stress Testing), or IFRS 9 (International Financial Reporting Standard 9). [ENUM-REF-CANDIDATE: basel_iii|emir|umr|dodd_frank|mifid_ii|internal_policy|ccar|dfast|ifrs_9 — 9 candidates stripped; promote to reference product]',
    `rule_code` STRING COMMENT 'Business identifier code for the eligibility rule, used for external reference and reporting. Typically follows internal naming conventions for rule identification.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `rule_description` STRING COMMENT 'Detailed textual description of the eligibility rule, including its business rationale, specific conditions, exceptions, and any additional context not captured in structured fields.',
    `rule_name` STRING COMMENT 'Human-readable name of the eligibility rule describing its purpose and scope.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the eligibility rule indicating whether it is actively enforced, pending approval, temporarily suspended, or expired.. Valid values are `active|inactive|pending_approval|suspended|expired`',
    `rule_type` STRING COMMENT 'Classification of the rule defining its functional purpose: eligibility criterion (what assets qualify), concentration limit (diversification requirements), jurisdiction restriction (geographic constraints), haircut rule (valuation discount), rating threshold (minimum credit quality), or maturity constraint (time-to-maturity limits).. Valid values are `eligibility_criterion|concentration_limit|jurisdiction_restriction|haircut_rule|rating_threshold|maturity_constraint`',
    `substitution_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether collateral assets meeting this rule can be substituted with other eligible collateral during the life of the collateral arrangement. True if substitution rights are granted, false otherwise.',
    `version_number` STRING COMMENT 'Version number of the eligibility rule, incremented with each modification. Supports rule change tracking and historical analysis.',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Business rules, eligibility criteria, and concentration limits defining what collateral is acceptable and how diversified collateral portfolios must be across all arrangements (CSA, repo, secured lending, CCP). Captures rule type (eligibility criterion, concentration limit, jurisdiction restriction), asset type, minimum credit rating, issuer type, currency, maturity constraints, concentration limit thresholds (issuer, asset class, currency, counterparty — percentage or absolute), limit scope (portfolio-wide, agreement-specific), breach action (hard stop, soft warning), regulatory framework applicability (EMIR, UMR, Basel III, internal credit policy), and effective/expiry dates. Used by the collateral optimization engine to determine eligible collateral pools, enforce portfolio diversification requirements, and prevent over-reliance on any single issuer, asset class, or currency. SSOT for all collateral constraint and eligibility rules.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`margin_agreement` (
    `margin_agreement_id` BIGINT COMMENT 'Unique identifier for the margin agreement record. Primary key.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Interest on cash collateral typically references benchmark rate for accrual calculations and settlement. Creating cash_collateral_rate_benchmark_id FK for benchmark-linked interest.',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for the threshold amount.',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: margin_agreement has eligible_collateral_schedule_id (BIGINT) which appears to reference a schedule defining eligible collateral and haircuts. haircut_schedule is the reference table in the collateral',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Governing law jurisdiction determines contract enforceability, dispute resolution, and UMR phase-in applicability. Creating jurisdiction_country_id FK to replace jurisdiction code.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: ISDA CSA/CSD enforceability and regulatory margin regime applicability depend on jurisdiction-level netting enforceability status and legal opinion date. reference.jurisdiction.netting_enforceability_',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: CSA agreements are legal entity-specific for netting enforceability, capital treatment, and financial reporting. Required for entity-level exposure reporting, consolidation, regulatory capital calcula',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Counterparty LEI is required for UMR compliance, regulatory reporting, and credit risk assessment. Creating new counterparty_lei FK.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Margin agreements (CSAs, IMAs) must conform to the banks internal Margin Policy and Collateral Management Policy. Compliance officers link each agreement to the governing policy for audit and policy ',
    `party_id` BIGINT COMMENT 'Reference to the custodian or third-party agent holding segregated collateral under this agreement, if applicable.',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Cash collateral posted under ISDA CSA margin agreements accrues interest that posts to a dedicated collateral subledger. Linking margin_agreement to subledger enables automated cash collateral interes',
    `acceleration_clause` BOOLEAN COMMENT 'Indicates whether the agreement contains an acceleration clause allowing immediate termination and full collateral call upon default. True = acceleration allowed, False = no acceleration.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the margin agreement, used in legal documentation and counterparty communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the margin agreement. DRAFT = under negotiation, PENDING_APPROVAL = awaiting internal or counterparty approval, ACTIVE = in force, SUSPENDED = temporarily inactive, TERMINATED = ended by mutual agreement or default, EXPIRED = reached natural end date.. Valid values are `DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|TERMINATED|EXPIRED`',
    `agreement_type` STRING COMMENT 'Classification of the collateral agreement type. CSA_BILATERAL = ISDA Credit Support Annex bilateral, CSA_UNILATERAL = ISDA CSA unilateral, CCP_CLEARING = Central Counterparty clearing agreement, GMRA = Global Master Repurchase Agreement, GMSLA = Global Master Securities Lending Agreement, PLEDGE = pledge agreement, SECURITY_AGREEMENT = security agreement, HYPOTHECATION = hypothecation agreement, CHARGE = charge agreement for secured commercial lending. [ENUM-REF-CANDIDATE: CSA_BILATERAL|CSA_UNILATERAL|CCP_CLEARING|GMRA|GMSLA|PLEDGE|SECURITY_AGREEMENT|HYPOTHECATION|CHARGE — 9 candidates stripped; promote to reference product]',
    `collateral_account_number` STRING COMMENT 'Account number or identifier for the segregated collateral account associated with this margin agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this margin agreement record was first created in the system.',
    `cross_default_provision` BOOLEAN COMMENT 'Indicates whether a default under this agreement triggers default under other agreements with the same counterparty. True = cross-default applies, False = standalone agreement.',
    `dispute_resolution_terms` STRING COMMENT 'Free-text description of the dispute resolution process and escalation procedures defined in the agreement, including timeframes and arbitration clauses.',
    `effective_date` DATE COMMENT 'Date on which the margin agreement becomes legally binding and enforceable.',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the margin agreement. [ENUM-REF-CANDIDATE: ENGLISH_LAW|NEW_YORK_LAW|JAPANESE_LAW|GERMAN_LAW|FRENCH_LAW|SWISS_LAW|SINGAPORE_LAW|HONG_KONG_LAW|OTHER — 9 candidates stripped; promote to reference product]',
    `independent_amount` DECIMAL(18,2) COMMENT 'Fixed collateral amount required to be posted regardless of exposure, providing additional credit protection. Also known as Initial Margin (IM) in some contexts.',
    `independent_amount_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the independent amount.. Valid values are `^[A-Z]{3}$`',
    `initial_margin_methodology` STRING COMMENT 'Methodology used to calculate initial margin requirements. ISDA_SIMM = ISDA Standard Initial Margin Model, SCHEDULE_BASED = fixed schedule approach, CCP_GRID = central counterparty grid-based calculation, INTERNAL_MODEL = proprietary internal model, STANDARDIZED = regulatory standardized approach.. Valid values are `ISDA_SIMM|SCHEDULE_BASED|CCP_GRID|INTERNAL_MODEL|STANDARDIZED`',
    `interest_rate_on_cash_collateral` DECIMAL(18,2) COMMENT 'Annual interest rate paid on cash collateral posted under this agreement, typically based on a benchmark rate such as SOFR or EONIA.',
    `lien_priority` STRING COMMENT 'Priority ranking of the security interest relative to other creditors. FIRST = first lien, SECOND = second lien, THIRD = third lien, SUBORDINATED = subordinated to other creditors, PARI_PASSU = equal ranking with other creditors.. Valid values are `FIRST|SECOND|THIRD|SUBORDINATED|PARI_PASSU`',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum collateral transfer amount required to trigger a margin call. Transfers below this threshold are not executed to reduce operational burden.',
    `mta_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the minimum transfer amount.. Valid values are `^[A-Z]{3}$`',
    `perfection_method` STRING COMMENT 'Legal mechanism used to perfect the security interest in collateral. UCC_FILING = Uniform Commercial Code filing, MORTGAGE_REGISTRATION = real estate mortgage, CHARGE_REGISTRATION = charge over assets, CONTROL_AGREEMENT = control over securities accounts, POSSESSION = physical possession, TITLE_TRANSFER = outright title transfer.. Valid values are `UCC_FILING|MORTGAGE_REGISTRATION|CHARGE_REGISTRATION|CONTROL_AGREEMENT|POSSESSION|TITLE_TRANSFER`',
    `regulatory_margin_regime` STRING COMMENT 'Applicable regulatory margin framework governing this agreement. UMR = Uncleared Margin Rules phases 1-6, EMIR = European Market Infrastructure Regulation, DODD_FRANK = Dodd-Frank Act margin rules, NONE = no specific regulatory regime applies. [ENUM-REF-CANDIDATE: UMR_PHASE_1|UMR_PHASE_2|UMR_PHASE_3|UMR_PHASE_4|UMR_PHASE_5|UMR_PHASE_6|EMIR|DODD_FRANK|NONE — 9 candidates stripped; promote to reference product]',
    `rehypothecation_rights` BOOLEAN COMMENT 'Indicates whether the collateral taker has the right to rehypothecate (reuse) posted collateral for its own purposes. True = rehypothecation allowed, False = collateral must be segregated.',
    `renewal_date` DATE COMMENT 'Date on which the margin agreement is scheduled for renewal or renegotiation. Nullable for agreements without automatic renewal.',
    `review_date` DATE COMMENT 'Scheduled date for periodic review of the margin agreement terms, typically annual or biennial.',
    `rounding_convention` STRING COMMENT 'Method used to round collateral transfer amounts. NEAREST = round to nearest unit, UP = always round up, DOWN = always round down, NONE = no rounding applied.. Valid values are `NEAREST|UP|DOWN|NONE`',
    `rounding_precision` DECIMAL(18,2) COMMENT 'Precision unit for rounding collateral transfer amounts, typically expressed in the settlement currency (e.g., 1000 for rounding to nearest thousand).',
    `source_system` STRING COMMENT 'Name of the operational system from which this margin agreement record originated (e.g., Murex, Calypso, SAS Risk Management).',
    `substitution_rights` BOOLEAN COMMENT 'Indicates whether the collateral provider has the right to substitute posted collateral with other eligible collateral. True = substitution allowed, False = no substitution permitted.',
    `termination_date` DATE COMMENT 'Date on which the margin agreement terminates or is scheduled to terminate. Nullable for open-ended agreements.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Minimum exposure amount below which no collateral is required to be posted. Part of the Credit Support Annex (CSA) terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this margin agreement record was last modified in the system.',
    `valuation_agent` STRING COMMENT 'Entity responsible for determining the value of collateral and exposure. PARTY_A = bank, PARTY_B = counterparty, THIRD_PARTY = independent valuation service, MUTUAL = both parties agree on valuation.. Valid values are `PARTY_A|PARTY_B|THIRD_PARTY|MUTUAL`',
    `valuation_frequency` STRING COMMENT 'Frequency at which collateral and exposure are revalued for margin call purposes.. Valid values are `DAILY|WEEKLY|MONTHLY|ON_DEMAND`',
    `variation_margin_settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which variation margin is settled daily to reflect mark-to-market exposure changes.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_margin_agreement PRIMARY KEY(`margin_agreement_id`)
) COMMENT 'Unified master record for ALL collateral-governing legal agreements across the bank — ISDA Credit Support Annexes (CSA, bilateral and unilateral), CCP clearing agreements, GMRA for repo, GMSLA for securities lending, pledge agreements, security agreements, hypothecation agreements, and charge agreements for secured commercial lending. Captures agreement type, governing law (English, New York, local), jurisdiction, counterparty, threshold amounts, minimum transfer amounts (MTA), independent amounts (IA), IM methodology (ISDA SIMM, schedule-based, CCP grid), VM settlement currency, eligible collateral schedules, rounding conventions, valuation agent, dispute resolution terms, rehypothecation rights, perfection method (UCC filing, mortgage registration, charge registration), lien priority, cross-default provisions, acceleration clauses, regulatory margin regime (UMR phase 1-6, EMIR, Dodd-Frank), and review/renewal dates. SSOT for all collateral agreement terms across secured lending, derivatives, and securities financing. Replaces separate CSA and pledge agreement records with a single type-discriminated master.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_position` (
    `collateral_position_id` BIGINT COMMENT 'Unique identifier for the collateral position record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Collateral positions are period-end snapshots used in Basel III regulatory capital adequacy calculations and IFRS 7 off-balance-sheet disclosures. Linking to accounting_period is required for period-c',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Cash collateral position reconciliation: collateral positions representing cash must reference the specific deposit account holding the cash. Required for daily position reconciliation, intraday liqui',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the specific collateral asset (security, cash deposit, letter of credit, physical asset) that forms this position.',
    `currency_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code in which the market value, face value, and haircut value are denominated.',
    `fund_holding_id` BIGINT COMMENT 'Foreign key linking to asset.fund_holding. Business justification: Collateral positions representing pledged fund holdings must reconcile against the underlying fund_holding records for daily mark-to-market, concentration limit monitoring, and regulatory reporting. P',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Collateral positions track fund holdings used as collateral on a position-date basis. Business process: daily collateral valuation for margin monitoring, mark-to-market of fund-backed exposures, HQLA ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Daily collateral positions must reconcile to GL balances for subledger control accounts. Essential for daily subledger reconciliation, SOX control testing, and ensuring collateral subledger ties to ge',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: A collateral position applies a haircut to compute haircut_value from market_value. The haircut_schedule is the authoritative reference defining the applicable haircut percentages. Linking collateral_',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Position management tracks security holdings as collateral. Enables exposure aggregation, concentration limit monitoring, and regulatory filings (Securities Financing Transactions Regulation). Essenti',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Collateral position RWA calculation and regulatory capital treatment depend on jurisdiction-level regulatory framework and capital adequacy approach. Basel III Pillar 3 reporting requires jurisdiction',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: A collateral position is calculated and maintained under a specific margin agreement (ISDA CSA, pledge agreement, etc.). The margin_agreement governs the threshold amounts, MTA, and haircut rules that',
    `margin_exposure_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_exposure. Business justification: collateral_position is the inventory/position snapshot while margin_exposure is the calculated net mark-to-market exposure record. Linking the position to its corresponding exposure calculation allows',
    `netting_set_id` BIGINT COMMENT 'Foreign key linking to collateral.netting_set. Business justification: A collateral position is calculated within the context of a netting set — the group of derivative transactions with a single counterparty subject to a legally enforceable netting agreement. The nettin',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: collateral_position has arrangement_id (BIGINT) which is a generic placeholder FK with no clear target. In collateral management, positions represent current inventory and exposure snapshots for colla',
    `party_id` BIGINT COMMENT 'Reference to the custodian bank or depository institution holding the physical or book-entry collateral asset.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory exams review collateral positions for LCR/HQLA classification, capital adequacy (RWA), and margin compliance. Examiners assess position-level data for Basel III/CRR compliance. Default PK n',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Collateral positions are tracked in a dedicated collateral subledger that reconciles daily to the GL. Collateral subledger reconciliation is a named daily operational process in banking; this link ena',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The interest accrued on the collateral asset (for interest-bearing securities or cash collateral) from the last coupon payment date to the position date. Included in net collateral value calculations.',
    `collateral_posted_value` DECIMAL(18,2) COMMENT 'The total haircut-adjusted value of collateral already posted to the counterparty as of the position date. Applicable to exposure-type positions.',
    `collateral_received_value` DECIMAL(18,2) COMMENT 'The total haircut-adjusted value of collateral received from the counterparty as of the position date. Applicable to exposure-type positions.',
    `concentration_limit_breach` BOOLEAN COMMENT 'Boolean flag indicating whether this collateral position breaches concentration limits defined in the collateral agreement (e.g., maximum percentage of a single issuer or asset class).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this collateral position record was first created in the system.',
    `credit_valuation_adjustment` DECIMAL(18,2) COMMENT 'The adjustment to the fair value of derivative positions to account for counterparty credit risk. Represents the market value of counterparty default risk. Applicable to exposure-type positions.',
    `eligibility_status` STRING COMMENT 'Indicates whether the collateral asset meets the eligibility criteria defined in the collateral agreement or regulatory framework: eligible (accepted), ineligible (rejected), restricted (conditionally accepted), pending_review (under evaluation).. Valid values are `eligible|ineligible|restricted|pending_review`',
    `exposure_date` DATE COMMENT 'For exposure-type positions, the date on which the counterparty credit exposure was calculated. Typically aligns with position_date but may differ for forward-looking exposure calculations.',
    `face_value` DECIMAL(18,2) COMMENT 'The nominal or par value of the collateral asset at issuance or contract inception, expressed in the assets denomination currency.',
    `gross_negative_exposure` DECIMAL(18,2) COMMENT 'The total mark-to-market value of all derivative and repo positions with the counterparty where the bank owes money, before netting or collateral offsets. Applicable to exposure-type positions.',
    `gross_positive_exposure` DECIMAL(18,2) COMMENT 'The total mark-to-market value of all derivative and repo positions with the counterparty where the bank is owed money, before netting or collateral offsets. Applicable to exposure-type positions.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the market value of the collateral to account for market risk, liquidity risk, and potential price volatility. Expressed as a decimal (e.g., 0.15 for 15%).',
    `haircut_value` DECIMAL(18,2) COMMENT 'The collateral value after applying the haircut percentage. Calculated as market_value * (1 - haircut_percentage). This is the risk-adjusted collateral value recognized for margin and capital purposes.',
    `hqla_classification` STRING COMMENT 'The Basel III liquidity classification of the collateral asset: level_1 (highest quality, 0% haircut), level_2a (high quality, 15% haircut), level_2b (lower quality, 25-50% haircut), or non_hqla (not eligible for LCR).. Valid values are `level_1|level_2a|level_2b|non_hqla`',
    `independent_amount` DECIMAL(18,2) COMMENT 'An additional fixed or formula-based collateral amount required by one party regardless of current exposure, often used to cover potential future exposure or as initial margin. Applicable to exposure-type positions.',
    `initial_margin` DECIMAL(18,2) COMMENT 'The upfront collateral required to cover potential future exposure over the margin period of risk, calculated using regulatory models (SIMM, grid-based) or internal models. Applicable to non-centrally cleared derivatives under margin reform rules.',
    `market_value` DECIMAL(18,2) COMMENT 'The current fair market value of the collateral asset as of the position date, based on observable market prices or valuation models.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The smallest increment of collateral that can be transferred under the collateral agreement. Collateral calls below this amount are not executed. Applicable to exposure-type positions.',
    `net_collateral_value` DECIMAL(18,2) COMMENT 'The net value of collateral available after haircuts, accrued interest, fees, and any other adjustments. This is the effective collateral coverage amount.',
    `net_current_exposure` DECIMAL(18,2) COMMENT 'The net mark-to-market exposure after bilateral netting under a qualifying master netting agreement (e.g., ISDA Master Agreement). Calculated as max(GPE - GNE, 0). Applicable to exposure-type positions.',
    `net_margin_requirement` DECIMAL(18,2) COMMENT 'The net amount of additional collateral required (positive) or excess collateral available for return (negative) after considering threshold, MTA, independent amount, and collateral already posted/received. Applicable to exposure-type positions.',
    `position_date` DATE COMMENT 'The business date for which this collateral position snapshot is recorded. Represents the valuation date for inventory and exposure calculations.',
    `position_type` STRING COMMENT 'Classification of the collateral position: held (owned but not pledged), posted (delivered to counterparty), received (accepted from counterparty), pledged (committed but not yet delivered), rehypothecated (received collateral reused), or exposure (calculated margin requirement record).. Valid values are `held|posted|received|pledged|rehypothecated|exposure`',
    `potential_future_exposure` DECIMAL(18,2) COMMENT 'An estimate of the maximum exposure that could arise in the future due to market movements, calculated using regulatory or internal models. Used for capital and margin calculations. Applicable to exposure-type positions.',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units or nominal amount of the collateral asset in this position. For securities, this is the number of shares or bonds; for cash, this is the principal amount.',
    `rehypothecation_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether the collateral receiver is permitted to rehypothecate (reuse) the received collateral under the terms of the collateral agreement.',
    `risk_weighted_assets` DECIMAL(18,2) COMMENT 'The regulatory capital requirement for this collateral position, calculated by applying risk weights to the exposure amount under Basel III standardized or internal ratings-based approaches. Applicable to exposure-type positions.',
    `settlement_date` DATE COMMENT 'The date on which the collateral transfer was or is expected to be settled and ownership or control transferred.',
    `settlement_status` STRING COMMENT 'The current settlement state of the collateral position: pending (awaiting delivery), in_transit (delivery initiated), settled (delivery confirmed), failed (settlement did not complete), recalled (collateral substitution or return in progress).. Valid values are `pending|in_transit|settled|failed|recalled`',
    `substitution_right_exercised` BOOLEAN COMMENT 'Boolean flag indicating whether the collateral provider has exercised their right to substitute this collateral asset with another eligible asset under the terms of the CSA.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The minimum exposure level specified in the CSA or collateral agreement below which no collateral is required to be posted. Applicable to exposure-type positions.',
    `threshold_breach_amount` DECIMAL(18,2) COMMENT 'The amount by which the net current exposure exceeds the threshold amount, triggering a margin call requirement. Calculated as max(NCE - threshold_amount, 0). Applicable to exposure-type positions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this collateral position record was last modified in the system.',
    `variation_margin` DECIMAL(18,2) COMMENT 'The collateral exchanged daily to reflect changes in the mark-to-market value of derivative positions. Represents the current exposure component of margin. Applicable to exposure-type positions.',
    CONSTRAINT pk_collateral_position PRIMARY KEY(`collateral_position_id`)
) COMMENT 'Current inventory snapshot, calculated exposure record, and margin exposure view for collateral held, posted, or received across all arrangements. Captures position date, collateral asset, arrangement reference, position type (held, posted, received, pledged, rehypothecated, exposure), quantity, face value, market value, haircut value, net collateral value, settlement status, custodian, and — for exposure positions — exposure date, gross positive exposure (GPE), gross negative exposure (GNE), net current exposure (NCE), potential future exposure (PFE), threshold breach amount, collateral already posted/received, net margin requirement, and regulatory capital impact (CVA, RWA). Provides the real-time collateral inventory, margin exposure view feeding margin call generation, and regulatory reporting view (LCR HQLA pool, Basel III SA-CCR). SSOT for collateral positions and margin exposures.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`margin_exposure` (
    `margin_exposure_id` BIGINT COMMENT 'Unique identifier for the margin exposure calculation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Margin exposure calculations feed period-end CVA/DVA P&L entries under IFRS 9 and SA-CCR regulatory capital (Basel III). Accounting teams must tie each exposure snapshot to an accounting period for fi',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: margin_exposure is a calculated exposure record representing net mark-to-market exposure. It is computed using collateral valuations as inputs — the collateral_valuation provides the net_collateral_va',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: margin_exposure.exposure_currency_code is a denormalized currency code. A proper FK to reference.currency is required for multi-currency exposure aggregation, CVA/DVA calculation currency conversion, ',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the margin agreement or Credit Support Annex (CSA) under which this exposure is calculated.',
    `netting_set_id` BIGINT COMMENT 'Identifier for the group of transactions that are subject to bilateral netting under the ISDA Master Agreement. All trades within a netting set are netted together for exposure calculation.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity with whom the margin exposure exists.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Margin exposure cash settlement: the deposit account used to fund or receive margin exposure settlements must be linked to the exposure record for intraday liquidity management, settlement failure mon',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Liquidity stress testing projects margin calls under adverse scenarios. Stressed margin exposure drives liquidity buffer sizing and LCR/NSFR projections. Required for regulatory liquidity stress tests',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Stressed margin exposure calculations are produced as part of stress test runs for CCAR/DFAST and counterparty credit risk stress testing. margin_exposure.stress_scenario_id already links to the scena',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the margin exposure and requirements. SIMM (Standard Initial Margin Model) is the industry standard for initial margin; other methods may be used for variation margin or under specific CSA terms.. Valid values are `standard|simm|grid|schedule|internal_model`',
    `calculation_run_code` STRING COMMENT 'Identifier for the batch calculation run that produced this exposure record. Used for audit trail and reconciliation purposes.',
    `collateral_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the eligible collateral currency specified in the CSA. Determines the currency in which collateral must be posted.. Valid values are `^[A-Z]{3}$`',
    `collateral_posted_amount` DECIMAL(18,2) COMMENT 'The current market value of collateral that the bank has posted to the counterparty to cover exposure. Includes cash and securities adjusted for haircuts.',
    `collateral_received_amount` DECIMAL(18,2) COMMENT 'The current market value of collateral that the bank has received from the counterparty to cover their exposure to the bank. Includes cash and securities adjusted for haircuts.',
    `collateral_segregation_required` BOOLEAN COMMENT 'Indicates whether initial margin collateral must be held in a segregated account at a third-party custodian, as required by regulatory mandates for certain counterparties and jurisdictions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this margin exposure record was first created in the system.',
    `cva_amount` DECIMAL(18,2) COMMENT 'The adjustment to the fair value of derivative positions to account for counterparty credit risk. Represents the market value of counterparty default risk and is used for regulatory capital calculations.',
    `dispute_threshold_amount` DECIMAL(18,2) COMMENT 'The minimum exposure difference amount that can trigger a formal dispute resolution process under the CSA. Valuation differences below this amount are typically resolved informally.',
    `dva_amount` DECIMAL(18,2) COMMENT 'The adjustment to the fair value of derivative positions to account for the banks own credit risk. Represents the benefit the bank receives from its own default risk.',
    `ead_amount` DECIMAL(18,2) COMMENT 'The estimated exposure amount at the time of counterparty default, used for regulatory capital calculations. Incorporates current exposure and potential future exposure.',
    `exposure_date` DATE COMMENT 'The business date on which this margin exposure was calculated, typically the valuation date for mark-to-market positions.',
    `exposure_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the margin exposure calculation was performed, including time zone information.',
    `gne_amount` DECIMAL(18,2) COMMENT 'The total mark-to-market value of all positions where the bank has a negative exposure to the counterparty (bank owes the counterparty). Represents the gross liability before netting and collateral.',
    `gpe_amount` DECIMAL(18,2) COMMENT 'The total mark-to-market value of all positions where the bank has a positive exposure to the counterparty (counterparty owes the bank). Represents the gross amount at risk before netting and collateral.',
    `independent_amount` DECIMAL(18,2) COMMENT 'Additional collateral required beyond the current exposure, often used as a buffer for potential future exposure or as initial margin. Also known as Initial Margin (IM) under regulatory frameworks.',
    `initial_margin_amount` DECIMAL(18,2) COMMENT 'The collateral amount required to cover potential future exposure over the margin period of risk, calculated using regulatory models (SIMM) or internal models. Required for non-cleared derivatives under regulatory mandates.',
    `last_margin_call_date` DATE COMMENT 'The date on which the most recent margin call was issued for this margin agreement and counterparty.',
    `margin_call_direction` STRING COMMENT 'Indicates the direction of the margin call: whether the bank is calling for collateral from the counterparty, the counterparty is calling from the bank, or no call is required.. Valid values are `call_from_counterparty|call_to_counterparty|no_call|bilateral`',
    `margin_call_status` STRING COMMENT 'The current status of the margin call process for this exposure calculation. Tracks whether a margin call has been issued, satisfied, or is in dispute.. Valid values are `pending|issued|satisfied|disputed|overdue|waived`',
    `margin_period_of_risk_days` STRING COMMENT 'The number of days between the last margin call and the closeout of positions following a counterparty default. Used in calculating initial margin requirements. Typically 10 days for standard CSAs.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum amount of collateral that must be transferred in a single margin call. Margin calls below this amount are not executed to reduce operational burden.',
    `nce_amount` DECIMAL(18,2) COMMENT 'The net mark-to-market exposure after bilateral netting of all positions under the margin agreement. Calculated as GPE minus GNE. Positive values indicate the bank is owed; negative values indicate the bank owes.',
    `net_collateral_position` DECIMAL(18,2) COMMENT 'The net collateral position calculated as collateral received minus collateral posted. Positive values indicate the bank holds net collateral; negative values indicate the bank has posted net collateral.',
    `net_margin_requirement` DECIMAL(18,2) COMMENT 'The net amount of additional collateral required to be posted or returned based on the current exposure, threshold, and existing collateral. Positive values indicate the bank must post more collateral; negative values indicate the bank can request collateral return.',
    `next_margin_call_date` DATE COMMENT 'The next scheduled date on which a margin call may be issued based on the CSA terms. Typically daily for most CSAs but may be less frequent for certain counterparties.',
    `pfe_amount` DECIMAL(18,2) COMMENT 'The estimated maximum exposure that could arise in the future due to market movements, calculated using regulatory or internal models. Used for regulatory capital calculations and risk management.',
    `regulatory_im_model` STRING COMMENT 'The regulatory model used to calculate initial margin requirements. SIMM (Standard Initial Margin Model) is the industry standard; grid and schedule are simplified approaches; internal models require regulatory approval.. Valid values are `simm|grid|schedule|internal`',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The risk-weighted asset amount calculated for this exposure under Basel III regulatory capital requirements. Used to determine the capital charge for counterparty credit risk.',
    `source_system` STRING COMMENT 'The name of the upstream system that calculated or provided this margin exposure data (e.g., Murex, Calypso, SAS Risk Management).',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The contractual threshold amount specified in the CSA below which no margin call is required. Exposure must exceed this amount before collateral posting obligations are triggered.',
    `threshold_breach_amount` DECIMAL(18,2) COMMENT 'The amount by which the net current exposure exceeds the contractual threshold. This is the exposure amount that triggers a margin call obligation. Calculated as NCE minus threshold amount (if positive).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this margin exposure record was last modified or recalculated.',
    `valuation_agent` STRING COMMENT 'Identifies which party is responsible for calculating the exposure valuation under the CSA terms. May be the bank, counterparty, a third-party service, or bilateral (both parties calculate independently).. Valid values are `bank|counterparty|third_party|bilateral`',
    `variation_margin_amount` DECIMAL(18,2) COMMENT 'The collateral amount required to cover the current mark-to-market exposure, calculated daily based on changes in position values. Distinct from initial margin which covers potential future exposure.',
    CONSTRAINT pk_margin_exposure PRIMARY KEY(`margin_exposure_id`)
) COMMENT 'Calculated exposure record representing the net mark-to-market exposure under a margin agreement or CSA, used to determine margin call obligations. Captures exposure date, gross positive exposure (GPE), gross negative exposure (GNE), net current exposure (NCE), potential future exposure (PFE), threshold breach amount, collateral already posted/received, net margin requirement, and regulatory capital impact (CVA, RWA). Feeds the margin call generation process.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`pledge_agreement` (
    `pledge_agreement_id` BIGINT COMMENT 'Primary key for pledge_agreement',
    `counterparty_agreement_id` BIGINT COMMENT 'Identifier of the parent master agreement under which this pledge agreement operates, if part of a broader relationship framework.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the secured obligation amount.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Pledge agreements are executed by specific legal entities for regulatory capital treatment, consolidation, and entity-level financial statements. Essential for legal entity reporting, regulatory submi',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Obligor LEI is required for regulatory reporting and credit risk management. Creating new obligor_lei FK.',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: A pledge agreement (security agreement, charge, hypothecation) operates under or is associated with a margin agreement (ISDA CSA, GMRA, etc.). The margin_agreement defines the overarching collateral t',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Pledge agreements for commercial and retail secured lending are executed at originating branches. Branch-level tracking of pledge agreements supports relationship management reporting, branch credit p',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Perfection jurisdiction determines legal validity and regulatory capital treatment. Creating perfection_jurisdiction_country_id FK to replace perfection_jurisdiction code.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Pledge agreement enforceability for Basel III capital relief requires jurisdiction-level netting enforceability status and insolvency regime type. reference.jurisdiction.netting_enforceability_flag an',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Pledge agreement over deposit accounts: the legal pledge agreement must identify the specific deposit account being pledged. Required for lien perfection filings, UCC searches, legal enforceability re',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Pledge agreements must conform to the banks Collateral Acceptance Policy and Legal Documentation Policy. Compliance teams link pledge agreements to governing policies for audit trail and policy compl',
    `party_id` BIGINT COMMENT 'Identifier of the party pledging collateral (borrower or debtor) under this agreement.',
    `tertiary_pledge_custodian_party_id` BIGINT COMMENT 'Identifier of the third-party custodian or trustee holding the collateral assets on behalf of the secured party.',
    `acceleration_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement contains acceleration provisions allowing the secured party to demand immediate payment of all obligations upon default.',
    `agreement_notes` STRING COMMENT 'Free-form text field for additional comments, special terms, exceptions, or operational notes related to this pledge agreement.',
    `agreement_reference_number` STRING COMMENT 'External business reference number or contract identifier for the pledge agreement, used in legal documentation and correspondence.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the pledge agreement indicating its operational state.. Valid values are `draft|active|suspended|terminated|matured|defaulted`',
    `agreement_type` STRING COMMENT 'Classification of the collateral legal agreement structure governing the secured lending relationship.. Valid values are `pledge_agreement|security_agreement|hypothecation_agreement|charge_agreement|mortgage|debenture`',
    `collateral_description` STRING COMMENT 'Detailed textual description of the collateral assets covered by this pledge agreement, including asset types, identifiers, and any specific inclusions or exclusions.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this pledge agreement record was first created in the data platform.',
    `cross_default_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes cross-default clauses that trigger default if the obligor defaults on other obligations.',
    `effective_date` DATE COMMENT 'Date when the pledge agreement becomes legally binding and enforceable.',
    `execution_date` DATE COMMENT 'Date when the pledge agreement was signed by all parties.',
    `filing_reference_number` STRING COMMENT 'Official registration or filing number assigned by the relevant authority (e.g., UCC filing number, land registry number).',
    `governing_law` STRING COMMENT 'Legal jurisdiction and body of law that governs the interpretation and enforcement of the pledge agreement (e.g., New York Law, English Law, Delaware Law).',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Standard percentage reduction applied to collateral market value to determine eligible collateral value, accounting for market risk and liquidation costs.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where disputes will be resolved and where the agreement is enforceable.',
    `lien_priority` STRING COMMENT 'Priority ranking of this security interest relative to other liens on the same collateral, determining order of payment in default scenarios.. Valid values are `first|second|third|subordinated|pari_passu`',
    `margin_call_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum collateral value shortfall that triggers a margin call requiring additional collateral to be posted.',
    `maturity_date` DATE COMMENT 'Date when the pledge agreement expires or the secured obligation is expected to be satisfied. Nullable for open-ended agreements.',
    `minimum_collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'Required minimum ratio of collateral value to secured obligation amount, expressed as a percentage (e.g., 125.00 means 125% coverage required).',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum monetary amount for any single collateral transfer or margin call, below which no transfer is required.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Indicates whether this pledge agreement is part of a master netting arrangement allowing offset of obligations across multiple transactions.',
    `perfection_date` DATE COMMENT 'Date when the security interest was legally perfected through filing, registration, or other required method.',
    `perfection_method` STRING COMMENT 'Legal mechanism used to perfect the security interest and establish priority over other creditors (e.g., UCC-1 filing, mortgage registration, control agreement).. Valid values are `ucc_filing|mortgage_registration|charge_registration|control_agreement|possession|notation`',
    `perfection_status` STRING COMMENT 'Current state of the legal perfection process indicating whether the security interest has been properly registered and is enforceable against third parties.. Valid values are `perfected|unperfected|pending|lapsed|renewed`',
    `regulatory_capital_treatment` STRING COMMENT 'Classification of how this collateral arrangement is treated for regulatory capital calculations under Basel III framework.. Valid values are `eligible_collateral|ineligible_collateral|partial_recognition|full_recognition`',
    `rehypothecation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the secured party is permitted to reuse or repledge the collateral for its own financing purposes.',
    `renewal_date` DATE COMMENT 'Date when the pledge agreement is scheduled for renewal or extension, if applicable.',
    `review_date` DATE COMMENT 'Scheduled date for periodic review of the pledge agreement terms, collateral adequacy, and obligor creditworthiness.',
    `rwa_reduction_percentage` DECIMAL(18,2) COMMENT 'Percentage reduction in Risk-Weighted Assets (RWA) achieved through this collateral arrangement for regulatory capital purposes.',
    `secured_obligation_amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the debt or obligation secured by this pledge agreement.',
    `substitution_rights_flag` BOOLEAN COMMENT 'Indicates whether the obligor has the right to substitute collateral assets with equivalent eligible assets during the agreement term.',
    `termination_date` DATE COMMENT 'Actual date when the pledge agreement was terminated, either through satisfaction of obligations, mutual agreement, or default enforcement.',
    `termination_reason` STRING COMMENT 'Business reason or trigger event that caused the pledge agreement to be terminated. [ENUM-REF-CANDIDATE: obligation_satisfied|mutual_agreement|default|breach|maturity|refinanced|substituted — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this pledge agreement record was last modified in the data platform.',
    `valuation_frequency` STRING COMMENT 'Scheduled frequency at which collateral assets are revalued to assess coverage adequacy and margin requirements.. Valid values are `daily|weekly|monthly|quarterly|on_demand|event_driven`',
    `valuation_method` STRING COMMENT 'Methodology used to determine the fair value of collateral assets for coverage and margin calculations.. Valid values are `mark_to_market|mark_to_model|independent_appraisal|cost_basis|net_asset_value`',
    CONSTRAINT pk_pledge_agreement PRIMARY KEY(`pledge_agreement_id`)
) COMMENT 'Umbrella master record for all types of collateral legal agreements (pledge agreements, security agreements, hypothecation agreements, charge agreements) governing secured lending relationships. Captures agreement type, governing law, jurisdiction, perfection method (UCC filing, mortgage registration, charge registration), lien priority, cross-default provisions, acceleration clauses, and review/renewal dates. Distinct from CSA (derivatives) and GMRA (repo) — covers secured commercial lending collateral.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`netting_set` (
    `netting_set_id` BIGINT COMMENT 'Unique identifier for the netting set. Primary key for the netting set master record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Netting sets have a primary settlement currency for net exposure calculation. A proper FK to reference.currency (distinct from the role-specific independent_amount_currency, mta_currency fields) enabl',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Governing law jurisdiction determines netting enforceability and regulatory capital recognition. Creating governing_law_jurisdiction_country_id FK to replace jurisdiction code.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Netting set regulatory recognition under Basel III/CRR requires jurisdiction-level netting enforceability status and legal opinion validity date. reference.jurisdiction.netting_enforceability_flag and',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Netting sets are legally enforceable only within a specific legal entitys jurisdiction. Basel III capital relief for close-out netting requires legal entity identification. Regulatory reporting (EMIR',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Counterparty LEI is required for netting opinion validation and regulatory reporting. Creating new counterparty_lei FK.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Netting sets carry explicit EMIR/Dodd-Frank compliance flags (emir_compliance_flag, dodd_frank_compliance_flag, umr_compliance_flag) indicating they are governed by specific regulatory obligations. Li',
    `party_id` BIGINT COMMENT 'Reference to the third-party custodian holding segregated initial margin collateral for this netting set, if segregation is required.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory exams review netting set legal enforceability opinions and regulatory recognition status for capital relief (Basel III SA-CCR, CRR Art.295). Examiners specifically assess netting_enforceabi',
    `capital_treatment_approach` STRING COMMENT 'Regulatory approach used for calculating counterparty credit risk capital requirements for this netting set: SA-CCR (Standardized Approach for Counterparty Credit Risk), IMM (Internal Models Method), CEM (Current Exposure Method), or Standardized Approach.. Valid values are `sa_ccr|imm|cem|standardized`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the netting set record was first created in the system. Audit trail for record creation.',
    `dodd_frank_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the netting set is compliant with Dodd-Frank Act requirements for margin and swap dealer registration.',
    `effective_date` DATE COMMENT 'Date on which the netting set became effective and began to govern the netting of derivative transactions with the counterparty.',
    `emir_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the netting set is compliant with European Market Infrastructure Regulation (EMIR) requirements for margin and reporting.',
    `independent_amount` DECIMAL(18,2) COMMENT 'Fixed collateral amount required to be posted regardless of mark-to-market exposure, providing additional credit protection. Also known as initial margin in some contexts.',
    `independent_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the independent amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `initial_margin_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether initial margin is required for this netting set under the applicable margin agreement or regulatory requirements (e.g., UMR).',
    `last_valuation_date` DATE COMMENT 'Most recent date on which derivative positions within the netting set were valued for exposure and margin call calculation purposes.',
    `legal_opinion_date` DATE COMMENT 'Date on which the legal opinion confirming netting enforceability was issued or last reviewed by legal counsel.',
    `margin_agreement_type` STRING COMMENT 'Type of margin agreement governing collateral exchange: bilateral (both parties post collateral), unilateral (only one party posts), or no margin agreement in place.. Valid values are `bilateral|unilateral|no_margin`',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum collateral amount that must be transferred in a single margin call. Margin calls below this amount are not executed to reduce operational burden.',
    `mta_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum transfer amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `netting_enforceability_status` STRING COMMENT 'Legal opinion status indicating whether close-out netting under the ISDA Master Agreement is legally enforceable in the relevant jurisdiction. Critical for regulatory capital treatment.. Valid values are `enforceable|not_enforceable|under_review|conditional`',
    `netting_set_status` STRING COMMENT 'Current lifecycle status of the netting set indicating whether it is actively used for netting derivative exposures or has been suspended or terminated.. Valid values are `active|suspended|terminated|pending|inactive`',
    `next_valuation_date` DATE COMMENT 'Next scheduled date on which derivative positions within the netting set will be valued for exposure and margin call calculation purposes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or operational notes related to the netting set that do not fit into structured fields.',
    `notification_time` TIMESTAMP COMMENT 'Deadline by which margin call notifications must be sent to the counterparty, typically expressed as a time of day in a specific time zone.',
    `product_scope` STRING COMMENT 'Comma-separated list of derivative product types included in this netting set (e.g., rates, FX, credit, equity, commodities). Defines the breadth of transactions subject to netting.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number or code assigned to the netting set for operational identification and reporting purposes.',
    `regulatory_recognition_status` STRING COMMENT 'Status indicating whether the netting set is recognized for regulatory capital purposes under Basel III SA-CCR or Internal Models Method (IMM). Determines eligibility for capital relief.. Valid values are `recognized|not_recognized|conditional|pending`',
    `rehypothecation_rights_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the secured party has the right to rehypothecate (reuse) collateral posted by the counterparty for its own purposes.',
    `rounding_amount` DECIMAL(18,2) COMMENT 'Amount to which margin call calculations are rounded to simplify collateral transfers and reduce operational complexity.',
    `rounding_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the rounding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `segregation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether initial margin must be segregated with a third-party custodian to protect against counterparty default, as required under UMR.',
    `substitution_rights_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the posting party has the right to substitute posted collateral with other eligible collateral of equivalent value.',
    `termination_date` DATE COMMENT 'Date on which the netting set was terminated or is scheduled to terminate, after which no new transactions can be added and existing transactions are closed out.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Minimum exposure amount below which collateral posting is not required under the CSA agreement. Exposure must exceed this threshold before margin calls are triggered.',
    `threshold_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the threshold amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `umr_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the netting set is compliant with applicable Uncleared Margin Rules (UMR) requirements for initial and variation margin.',
    `umr_phase` STRING COMMENT 'Phase of the Uncleared Margin Rules (UMR) implementation schedule to which this netting set is subject, based on the aggregate average notional amount (AANA) of non-cleared derivatives. [ENUM-REF-CANDIDATE: phase_1|phase_2|phase_3|phase_4|phase_5|phase_6|not_applicable — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the netting set record was last modified in the system. Audit trail for record updates.',
    `valuation_agent` STRING COMMENT 'Party responsible for calculating mark-to-market valuations of derivative positions within the netting set for margin call purposes.. Valid values are `bank|counterparty|third_party|bilateral`',
    `valuation_time` TIMESTAMP COMMENT 'Specified time of day (e.g., close of business, 4:00 PM New York time) at which derivative positions are valued for margin call calculations.',
    `variation_margin_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether variation margin is required for this netting set to cover mark-to-market exposure fluctuations.',
    CONSTRAINT pk_netting_set PRIMARY KEY(`netting_set_id`)
) COMMENT 'Master record defining netting sets — groups of derivative transactions with a single counterparty subject to legally enforceable close-out netting under an ISDA Master Agreement. Captures netting set identifier, governing ISDA agreement, counterparty, netting enforceability legal opinion status, jurisdiction, product scope (rates, FX, credit, equity, commodities), and regulatory recognition status for capital purposes (Basel III SA-CCR, IMM). Fundamental to exposure calculation, CVA computation, RWA determination, and margin call netting. The netting set is the atomic unit for margin agreement exposure aggregation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `banking_ecm`.`collateral`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ADD CONSTRAINT `fk_collateral_collateral_asset_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ADD CONSTRAINT `fk_collateral_pledge_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_collateral_position_id` FOREIGN KEY (`collateral_position_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_position`(`collateral_position_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ADD CONSTRAINT `fk_collateral_margin_call_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ADD CONSTRAINT `fk_collateral_eligibility_rule_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_margin_exposure_id` FOREIGN KEY (`margin_exposure_id`) REFERENCES `banking_ecm`.`collateral`.`margin_exposure`(`margin_exposure_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `banking_ecm`.`collateral`.`pledge`(`pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_collateral_valuation_id` FOREIGN KEY (`collateral_valuation_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_valuation`(`collateral_valuation_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ADD CONSTRAINT `fk_collateral_pledge_agreement_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`collateral` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`collateral` SET TAGS ('dbx_domain' = 'collateral');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` SET TAGS ('dbx_subdomain' = 'collateral_inventory');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Bic Code (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Source Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `basel_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Basel III Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `concentration_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|impaired|defaulted');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `custody_location` SET TAGS ('dbx_business_glossary_term' = 'Custody Location');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `emir_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'European Market Infrastructure Regulation (EMIR) Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_value_regex' = 'unencumbered|encumbered|partially_encumbered|cross_collateralized');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Classification');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_value_regex' = 'level_1|level_2a|level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `lien_position` SET TAGS ('dbx_business_glossary_term' = 'Lien Position');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `lien_position` SET TAGS ('dbx_value_regex' = 'first|second|third|subordinated|senior|pari_passu');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `pledged_date` SET TAGS ('dbx_business_glossary_term' = 'Pledged Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `rehypothecation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|appraisal|model|index|cost');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` SET TAGS ('dbx_subdomain' = 'pledge_operations');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `risk_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Risk Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Onboarding Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Pledged Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pledgor Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `tertiary_collateral_pledge_secured_party_id` SET TAGS ('dbx_business_glossary_term' = 'Secured Party Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Pledge Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `eligible_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `enforcement_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `initial_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `legal_perfection_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Perfection Status');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `legal_perfection_status` SET TAGS ('dbx_value_regex' = 'perfected|pending|unperfected|disputed');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `lien_rank` SET TAGS ('dbx_business_glossary_term' = 'Lien Rank');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `lien_rank` SET TAGS ('dbx_value_regex' = 'first|second|subordinate|pari_passu|junior|senior');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Maturity Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pledge Notes');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `perfection_date` SET TAGS ('dbx_business_glossary_term' = 'Perfection Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `perfection_method` SET TAGS ('dbx_business_glossary_term' = 'Perfection Method');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `perfection_method` SET TAGS ('dbx_value_regex' = 'ucc_filing|control_agreement|possession|registration|notation');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_value_regex' = 'active|released|substituted|enforced|defaulted|pending');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_business_glossary_term' = 'Pledge Type');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_value_regex' = 'loan_collateral|derivative_margin|repo_collateral|guarantee_backing|letter_of_credit');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Pledge Quantity');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pledge Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `regulatory_capital_relief_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `rwa_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Reduction Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `substitution_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'market|model|appraisal|cost|fair_value');
ALTER TABLE `banking_ecm`.`collateral`.`pledge` ALTER COLUMN `variation_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_call_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Margin Call Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `collateral_position_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `call_direction` SET TAGS ('dbx_business_glossary_term' = 'Call Direction');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `call_direction` SET TAGS ('dbx_value_regex' = 'issued|received');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `call_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `collateral_posted_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `collateral_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Received Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `daily_vm_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Daily Variation Margin (VM) Requirement Flag');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `delivery_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved|withdrawn');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `dodd_frank_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Dodd-Frank Act Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `emir_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'European Market Infrastructure Regulation (EMIR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `im_calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Calculation Methodology');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `im_calculation_methodology` SET TAGS ('dbx_value_regex' = 'isda_simm|schedule_based|internal_model|ccp_prescribed');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `im_custodian_identifier` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Custodian Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `im_custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Custodian Name');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `im_segregation_status` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Segregation Status');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `im_segregation_status` SET TAGS ('dbx_value_regex' = 'segregated|non_segregated|partially_segregated');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Status');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_call_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Type');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_call_type` SET TAGS ('dbx_value_regex' = 'bilateral|ccp|tri_party');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Type');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `margin_type` SET TAGS ('dbx_value_regex' = 'initial_margin_requirement|initial_margin_posted|initial_margin_received|variation_margin_call|variation_margin_settlement');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `net_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `settlement_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Reference');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `umr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `umr_phase` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Phase');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `vm_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`margin_call` ALTER COLUMN `vm_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|settled|failed|reversed');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` SET TAGS ('dbx_subdomain' = 'collateral_inventory');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Collateral Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_asset_class` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Class');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `concentration_limit_breach` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Breach Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `confidence_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `eligible_for_central_bank` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Central Bank Collateral');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `gross_market_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `haircut_amount` SET TAGS ('dbx_business_glossary_term' = 'Haircut Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Classification');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'level_1|level_2a|level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `margin_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `margin_type` SET TAGS ('dbx_value_regex' = 'initial_margin|variation_margin|independent_amount|minimum_transfer_amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Collateral Maturity Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model Version');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `net_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Net Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Valuation Override Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `previous_net_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Net Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `previous_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Previous Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Valuation Purpose');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'margin_call|ltv_monitoring|regulatory_reporting|credit_decision|portfolio_review|stress_testing');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|appraisal|model_based|index_based|broker_quote|internal_model');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_source` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_source` SET TAGS ('dbx_value_regex' = 'internal_model|third_party_appraiser|exchange_price|vendor_feed|broker_quote|index_provider');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'final|preliminary|pending_review|disputed|overridden|stale');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `value_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Value Change Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `value_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Value Change Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule ID');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|superseded|retired');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `bilateral_csa_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Credit Support Annex (CSA) Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `ccp_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Central Counterparty (CCP) Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `collateral_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Eligibility Flag');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `concentration_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `credit_quality_step` SET TAGS ('dbx_business_glossary_term' = 'Credit Quality Step (CQS)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `currency_mismatch_addon_pct` SET TAGS ('dbx_business_glossary_term' = 'Currency Mismatch Add-On Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `currency_mismatch_indicator` SET TAGS ('dbx_business_glossary_term' = 'Currency Mismatch Indicator');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `initial_margin_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `internal_model_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Internal Model Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `liquidity_category` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Category');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `liquidity_category` SET TAGS ('dbx_value_regex' = 'highly_liquid|liquid|less_liquid|illiquid');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `lookback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Period Days');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `minimum_haircut_floor_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Haircut Floor Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'basel_iii|emir|dodd_frank|mifid_ii|sftr|ucits');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `residual_maturity_bucket` SET TAGS ('dbx_business_glossary_term' = 'Residual Maturity Bucket');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `residual_maturity_bucket` SET TAGS ('dbx_value_regex' = 'less_than_1_year|1_to_5_years|5_to_10_years|over_10_years|perpetual');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `supervisory_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'repo|reverse_repo|securities_lending|derivatives_margin|secured_loan');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `variation_margin_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `volatility_adjustment_method` SET TAGS ('dbx_business_glossary_term' = 'Volatility Adjustment Methodology');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `volatility_adjustment_method` SET TAGS ('dbx_value_regex' = 'historical_simulation|parametric_var|monte_carlo|ewma|garch');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'pledge_operations');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Breach Action');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'hard_stop|soft_warning|escalation|auto_rebalance');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `concentration_limit_absolute_amount` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Absolute Amount');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `concentration_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `concentration_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Type');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `concentration_limit_type` SET TAGS ('dbx_value_regex' = 'issuer|asset_class|currency|counterparty|jurisdiction|sector');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_ccp` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Central Counterparty (CCP)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_initial_margin` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Initial Margin (IM)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_repo` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Repurchase Agreement (Repo)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_secured_lending` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Secured Lending');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_variation_margin` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Variation Margin (VM)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `issuer_type` SET TAGS ('dbx_business_glossary_term' = 'Issuer Type');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `limit_scope` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `limit_scope` SET TAGS ('dbx_value_regex' = 'portfolio_wide|agreement_specific|counterparty_specific|product_specific');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `maximum_maturity_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Maturity Days');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `minimum_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Rating');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `minimum_credit_rating` SET TAGS ('dbx_value_regex' = '^(AAA|AA[+-]?|A[+-]?|BBB[+-]?|BB[+-]?|B[+-]?|CCC[+-]?|CC|C|D|NR)$');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `minimum_maturity_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Maturity Days');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|expired');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'eligibility_criterion|concentration_limit|jurisdiction_restriction|haircut_rule|rating_threshold|maturity_constraint');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Collateral Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Lei (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `acceleration_clause` SET TAGS ('dbx_business_glossary_term' = 'Acceleration Clause');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|ACTIVE|SUSPENDED|TERMINATED|EXPIRED');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `collateral_account_number` SET TAGS ('dbx_business_glossary_term' = 'Collateral Account Number');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `collateral_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `cross_default_provision` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Provision');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `dispute_resolution_terms` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Terms');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `independent_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA) Currency');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `independent_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `initial_margin_methodology` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Methodology');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `initial_margin_methodology` SET TAGS ('dbx_value_regex' = 'ISDA_SIMM|SCHEDULE_BASED|CCP_GRID|INTERNAL_MODEL|STANDARDIZED');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `interest_rate_on_cash_collateral` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate on Cash Collateral');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `lien_priority` SET TAGS ('dbx_business_glossary_term' = 'Lien Priority');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `lien_priority` SET TAGS ('dbx_value_regex' = 'FIRST|SECOND|THIRD|SUBORDINATED|PARI_PASSU');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `mta_currency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA) Currency');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `mta_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `perfection_method` SET TAGS ('dbx_business_glossary_term' = 'Perfection Method');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `perfection_method` SET TAGS ('dbx_value_regex' = 'UCC_FILING|MORTGAGE_REGISTRATION|CHARGE_REGISTRATION|CONTROL_AGREEMENT|POSSESSION|TITLE_TRANSFER');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `regulatory_margin_regime` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Margin Regime');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `rehypothecation_rights` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Rights');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `rounding_convention` SET TAGS ('dbx_business_glossary_term' = 'Rounding Convention');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `rounding_convention` SET TAGS ('dbx_value_regex' = 'NEAREST|UP|DOWN|NONE');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `rounding_precision` SET TAGS ('dbx_business_glossary_term' = 'Rounding Precision');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `substitution_rights` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rights');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `valuation_agent` SET TAGS ('dbx_business_glossary_term' = 'Valuation Agent');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `valuation_agent` SET TAGS ('dbx_value_regex' = 'PARTY_A|PARTY_B|THIRD_PARTY|MUTUAL');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_value_regex' = 'DAILY|WEEKLY|MONTHLY|ON_DEMAND');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `variation_margin_settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Currency');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `variation_margin_settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` SET TAGS ('dbx_subdomain' = 'collateral_inventory');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_position_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Position ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Collateral Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `fund_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Holding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `margin_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_posted_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_received_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Received Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `concentration_limit_breach` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Breach Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `credit_valuation_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Collateral Eligibility Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|restricted|pending_review');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `exposure_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `gross_negative_exposure` SET TAGS ('dbx_business_glossary_term' = 'Gross Negative Exposure (GNE)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `gross_positive_exposure` SET TAGS ('dbx_business_glossary_term' = 'Gross Positive Exposure (GPE)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `haircut_value` SET TAGS ('dbx_business_glossary_term' = 'Haircut Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Classification');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_value_regex' = 'level_1|level_2a|level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `initial_margin` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `net_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Net Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `net_current_exposure` SET TAGS ('dbx_business_glossary_term' = 'Net Current Exposure (NCE)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `net_margin_requirement` SET TAGS ('dbx_business_glossary_term' = 'Net Margin Requirement');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `position_date` SET TAGS ('dbx_business_glossary_term' = 'Position Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'held|posted|received|pledged|rehypothecated|exposure');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `potential_future_exposure` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Collateral Quantity');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `rehypothecation_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `risk_weighted_assets` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|settled|failed|recalled');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `substitution_right_exercised` SET TAGS ('dbx_business_glossary_term' = 'Substitution Right Exercised Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `threshold_breach_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `variation_margin` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Exposure Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Exposure Calculation Method');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'standard|simm|grid|schedule|internal_model');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `calculation_run_code` SET TAGS ('dbx_business_glossary_term' = 'Calculation Run Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `collateral_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Collateral Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `collateral_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `collateral_posted_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `collateral_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Received Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `collateral_segregation_required` SET TAGS ('dbx_business_glossary_term' = 'Collateral Segregation Required Flag');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `cva_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `dispute_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `dva_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Valuation Adjustment (DVA) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `ead_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `exposure_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure Calculation Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `exposure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exposure Calculation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `gne_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Negative Exposure (GNE) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `gpe_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Positive Exposure (GPE) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `initial_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `last_margin_call_date` SET TAGS ('dbx_business_glossary_term' = 'Last Margin Call Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_call_direction` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Direction');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_call_direction` SET TAGS ('dbx_value_regex' = 'call_from_counterparty|call_to_counterparty|no_call|bilateral');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Status');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_value_regex' = 'pending|issued|satisfied|disputed|overdue|waived');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_period_of_risk_days` SET TAGS ('dbx_business_glossary_term' = 'Margin Period of Risk (MPOR) Days');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `nce_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Current Exposure (NCE) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `net_collateral_position` SET TAGS ('dbx_business_glossary_term' = 'Net Collateral Position');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `net_margin_requirement` SET TAGS ('dbx_business_glossary_term' = 'Net Margin Requirement');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `next_margin_call_date` SET TAGS ('dbx_business_glossary_term' = 'Next Margin Call Date');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `pfe_amount` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `regulatory_im_model` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Initial Margin (IM) Model');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `regulatory_im_model` SET TAGS ('dbx_value_regex' = 'simm|grid|schedule|internal');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `threshold_breach_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Amount');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `valuation_agent` SET TAGS ('dbx_business_glossary_term' = 'Valuation Agent');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `valuation_agent` SET TAGS ('dbx_value_regex' = 'bank|counterparty|third_party|bilateral');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `variation_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` SET TAGS ('dbx_subdomain' = 'pledge_operations');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Secured Obligation Currency');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Lei (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Pledged Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Party ID');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `tertiary_pledge_custodian_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party ID');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `acceleration_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Acceleration Clause Flag');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `agreement_notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|matured|defaulted');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'pledge_agreement|security_agreement|hypothecation_agreement|charge_agreement|mortgage|debenture');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `collateral_description` SET TAGS ('dbx_business_glossary_term' = 'Collateral Description');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `cross_default_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Provision Flag');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `lien_priority` SET TAGS ('dbx_business_glossary_term' = 'Lien Priority');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `lien_priority` SET TAGS ('dbx_value_regex' = 'first|second|third|subordinated|pari_passu');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `margin_call_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `minimum_collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Minimum Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `perfection_date` SET TAGS ('dbx_business_glossary_term' = 'Perfection Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `perfection_method` SET TAGS ('dbx_business_glossary_term' = 'Perfection Method');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `perfection_method` SET TAGS ('dbx_value_regex' = 'ucc_filing|mortgage_registration|charge_registration|control_agreement|possession|notation');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `perfection_status` SET TAGS ('dbx_business_glossary_term' = 'Perfection Status');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `perfection_status` SET TAGS ('dbx_value_regex' = 'perfected|unperfected|pending|lapsed|renewed');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_value_regex' = 'eligible_collateral|ineligible_collateral|partial_recognition|full_recognition');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `rehypothecation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `rwa_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Reduction Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `secured_obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Secured Obligation Amount');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `substitution_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rights Flag');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|on_demand|event_driven');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|mark_to_model|independent_appraisal|cost_basis|net_asset_value');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Lei (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `capital_treatment_approach` SET TAGS ('dbx_business_glossary_term' = 'Capital Treatment Approach');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `capital_treatment_approach` SET TAGS ('dbx_value_regex' = 'sa_ccr|imm|cem|standardized');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `capital_treatment_approach` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `capital_treatment_approach` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `dodd_frank_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Dodd-Frank Act Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `emir_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'European Market Infrastructure Regulation (EMIR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `independent_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount Currency');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `independent_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `initial_margin_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Required Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `legal_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Opinion Date');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `margin_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Type');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `margin_agreement_type` SET TAGS ('dbx_value_regex' = 'bilateral|unilateral|no_margin');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `mta_currency` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA) Currency');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `mta_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `netting_enforceability_status` SET TAGS ('dbx_business_glossary_term' = 'Netting Enforceability Status');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `netting_enforceability_status` SET TAGS ('dbx_value_regex' = 'enforceable|not_enforceable|under_review|conditional');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `netting_set_status` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Status');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `netting_set_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|inactive');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `next_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Notes');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `notification_time` SET TAGS ('dbx_business_glossary_term' = 'Notification Time');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `regulatory_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Recognition Status');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `regulatory_recognition_status` SET TAGS ('dbx_value_regex' = 'recognized|not_recognized|conditional|pending');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `rehypothecation_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Rights Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `rounding_amount` SET TAGS ('dbx_business_glossary_term' = 'Rounding Amount');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `rounding_currency` SET TAGS ('dbx_business_glossary_term' = 'Rounding Currency');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `rounding_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `segregation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Segregation Required Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `substitution_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rights Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `umr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `umr_phase` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Phase');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `valuation_agent` SET TAGS ('dbx_business_glossary_term' = 'Valuation Agent');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `valuation_agent` SET TAGS ('dbx_value_regex' = 'bank|counterparty|third_party|bilateral');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `valuation_time` SET TAGS ('dbx_business_glossary_term' = 'Valuation Time');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `variation_margin_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Required Flag');
