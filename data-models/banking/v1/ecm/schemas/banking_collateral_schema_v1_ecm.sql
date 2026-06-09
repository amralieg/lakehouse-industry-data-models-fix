-- Schema for Domain: collateral | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`collateral` COMMENT 'Collateral management for secured lending, derivatives (ISDA CSA), repo/reverse repo transactions, and margin requirements. Owns collateral valuation, haircut schedules, margin calls, substitution rights, CSA agreement tracking, collateral eligibility rules, and initial/variation margin calculations under Basel III.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_asset` (
    `collateral_asset_id` BIGINT COMMENT 'Unique identifier for the collateral asset. Primary key for the collateral asset master registry.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Custodian identification requires BIC reference for payment instructions, securities settlement, and SWIFT messaging. Creating custodian_bic_code FK to replace custodian_name.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code representing the denomination currency of the collateral asset value.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Collateral assets frequently include fund units/shares pledged as security for credit facilities. Real business process: secured lending against investment portfolios, margin lending for fund investme',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Collateral assets must be recorded on balance sheet with specific GL accounts for regulatory capital calculations, HQLA classification, IFRS 9 financial reporting, and month-end close reconciliation. ',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Custody location and jurisdiction determine applicable holiday calendar for settlement, valuation frequency, and margin call deadlines. Creating new holiday_calendar_id FK.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Asset type and subtype should reference classification master for regulatory capital treatment, HQLA classification, and risk weighting. Creating new instrument_classification_id FK.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Securities are primary collateral type in banking. Daily valuation, margin calls, corporate action processing, and regulatory capital calculations (Basel III, FRTB) require direct instrument reference',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: For equity collateral, issuer industry classification is critical for concentration limit monitoring and sector risk management. Creating new issuer_industry_code_id FK.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Jurisdiction determines legal perfection, enforcement, and Basel sovereign risk weights. Required for sanctions screening and regulatory capital treatment. Creating jurisdiction_country_id FK to repla',
    `market_data_source_id` BIGINT COMMENT 'Source of the valuation data (e.g., Bloomberg, Reuters, independent appraiser, internal model).',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Asset ownership tracking is fundamental for collateral perfection, lien priority determination, regulatory capital treatment (Basel III), and legal enforceability. Banking operations require definitiv',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Floating rate collateral assets (bonds, loans) reference benchmark rates for coupon calculations and valuation. Creating new benchmark_rate_id FK for floating rate instruments.',
    `acquisition_date` DATE COMMENT 'Date on which the bank or counterparty acquired the collateral asset for pledging purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the collateral asset indicating its availability and encumbrance state. [ENUM-REF-CANDIDATE: eligible|pledged|released|ineligible|under_review|restricted|substituted — 7 candidates stripped; promote to reference product]',
    `asset_type` STRING COMMENT 'Classification of the collateral asset by type. Determines eligibility rules, haircut schedules, and valuation methodology. [ENUM-REF-CANDIDATE: real_estate|securities|cash|commodities|receivables|letter_of_credit|bank_guarantee|inventory|equipment|other — 10 candidates stripped; promote to reference product]',
    `basel_eligible_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset qualifies as eligible collateral under Basel III capital and liquidity frameworks.',
    `collateral_value` DECIMAL(18,2) COMMENT 'Net collateral value after applying haircut to the market value. This is the value available for margin and credit risk mitigation.',
    `concentration_limit_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset is subject to concentration limits under Basel III or internal risk policy.',
    `condition` STRING COMMENT 'Assessment of the physical or credit condition of the collateral asset. Impacts valuation and haircut application.. Valid values are `excellent|good|fair|poor|impaired|defaulted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral asset record was first created in the system.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the collateral asset by a recognized rating agency. Used for eligibility determination and haircut calculation.',
    `custody_location` STRING COMMENT 'Physical or electronic location where the collateral asset is held (custodian name, vault location, depository, or registry).',
    `data_source_system` STRING COMMENT 'Name of the source system from which the collateral asset data originated (e.g., Murex, Calypso, Collateral Management System).',
    `eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether the collateral asset meets the banks eligibility criteria for acceptance under Basel III, EMIR, and internal credit policy.',
    `emir_eligible_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset meets EMIR eligibility requirements for central clearing and bilateral margin.',
    `encumbrance_status` STRING COMMENT 'Indicates whether the collateral asset is free of liens or has existing encumbrances that affect its availability for pledging.. Valid values are `unencumbered|encumbered|partially_encumbered|cross_collateralized`',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the market value of the collateral asset to determine its collateral value. Reflects credit risk, market risk, and liquidity risk.',
    `hqla_classification` STRING COMMENT 'Classification of the collateral asset under Basel III Liquidity Coverage Ratio (LCR) framework as Level 1, Level 2A, Level 2B, or non-HQLA.. Valid values are `level_1|level_2a|level_2b|non_hqla`',
    `internal_rating` STRING COMMENT 'Internal credit rating assigned to the collateral asset under the banks Internal Ratings-Based (IRB) approach.',
    `issue_date` DATE COMMENT 'Date on which the collateral asset was originally issued or created (e.g., bond issue date, property acquisition date).',
    `legal_description` STRING COMMENT 'Formal legal description of the collateral asset as documented in legal agreements, deeds, or certificates. Includes property descriptions, security identifiers (ISIN, CUSIP), or instrument details.',
    `lien_position` STRING COMMENT 'Priority ranking of the banks security interest in the collateral asset relative to other creditors. Critical for Loss Given Default (LGD) calculations.. Valid values are `first|second|third|subordinated|senior|pari_passu`',
    `market_value` DECIMAL(18,2) COMMENT 'Current market value of the collateral asset in the reporting currency. Updated based on mark-to-market (MTM) or appraisal.',
    `maturity_date` DATE COMMENT 'Maturity or expiration date of the collateral asset, if applicable (e.g., bond maturity, letter of credit expiry). Null for perpetual or non-maturing assets.',
    `pledged_date` DATE COMMENT 'Date on which the collateral asset was pledged to the bank or counterparty under a collateral agreement.',
    `rating_agency` STRING COMMENT 'Name of the external credit rating agency providing the credit rating for the collateral asset (e.g., Moodys, S&P, Fitch).',
    `reference_number` STRING COMMENT 'External business identifier or reference number assigned to the collateral asset for tracking and reporting purposes across systems.',
    `rehypothecation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the bank is permitted to rehypothecate (re-pledge) the collateral asset to third parties under the collateral agreement terms.',
    `release_date` DATE COMMENT 'Date on which the collateral asset was released from pledge and returned to the owner. Null if currently pledged.',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to the collateral asset for Risk-Weighted Assets (RWA) calculation under Basel III.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset can be substituted with another eligible asset under the terms of the collateral agreement.',
    `subtype` STRING COMMENT 'Granular classification within the asset type (e.g., residential real estate, corporate bonds, government securities, gold, accounts receivable).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral asset record was last updated in the system.',
    `valuation_date` DATE COMMENT 'Date on which the market value and collateral value were last determined or updated.',
    `valuation_method` STRING COMMENT 'Methodology used to determine the market value of the collateral asset (e.g., mark-to-market for securities, appraisal for real estate).. Valid values are `mark_to_market|appraisal|model|index|cost`',
    CONSTRAINT pk_collateral_asset PRIMARY KEY(`collateral_asset_id`)
) COMMENT 'Master registry of all collateral assets pledged or eligible for pledging across secured lending, derivatives (ISDA CSA), repo/reverse repo, and margin arrangements. Captures asset type (real estate, securities, cash, commodities, receivables, letters of credit, bank guarantees), legal description, ownership details, lien position, encumbrance status, jurisdiction, custody location, asset condition, and eligibility flags per Basel III, EMIR, and internal credit policy. This is the SSOT for collateral asset identity across the bank — every valuation, pledge, position, transfer, and lifecycle event references this master.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_pledge` (
    `collateral_pledge_id` BIGINT COMMENT 'Unique identifier for the collateral pledge record.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the specific collateral asset being pledged to secure the obligation.',
    `party_id` BIGINT COMMENT 'Reference to the third-party custodian or depository holding the pledged collateral on behalf of the secured party.',
    `collateral_pledge_obligor_party_id` BIGINT COMMENT 'Reference to the party providing the collateral (the pledgor or obligor).',
    `collateral_pledge_secured_party_id` BIGINT COMMENT 'Reference to the party receiving the collateral (the secured party or beneficiary).',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Pledge covenant breaches (LTV violations, perfection failures, concentration limit breaches) generate compliance breach records referencing the specific pledge. Required for regulatory reporting and r',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Pledges secure credit obligations using fund holdings. Business process: portfolio-based lending where clients pledge fund investments, wealth management credit lines secured by fund portfolios, margi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Pledges create balance sheet entries for secured lending positions, collateral posted/received accounts. Required for subledger reconciliation, financial statement preparation, and regulatory capital ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Pledge agreements frequently involve securities collateral. Enables covenant monitoring, substitution eligibility checks, and position reconciliation. Essential for secured lending and derivatives col',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Pledges from new obligors or high-risk jurisdictions trigger enhanced KYC reviews per BSA/AML requirements. The review references the specific pledge arrangement to assess source of collateral and ben',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the governing ISDA Credit Support Annex agreement under which this pledge is made, if applicable to derivatives collateral.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Perfection jurisdiction determines legal enforceability and priority. Required for netting opinions, insolvency regime assessment, and regulatory capital relief eligibility. Creating perfection_jurisd',
    `pledge_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge_agreement. Business justification: A collateral pledge is made under a pledge agreement (the umbrella master legal agreement for secured lending). The existing margin_agreement_id covers margin-based pledges, but secured lending pledge',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value of the collateral pledged, expressed in the pledge currency.',
    `collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'The ratio of eligible collateral value to the credit exposure, expressed as a percentage, indicating the degree of over-collateralization or under-collateralization.',
    `created_by_user` STRING COMMENT 'The identifier of the user or system process that created this pledge record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was first created in the system.',
    `currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the pledge amount is denominated.. Valid values are `^[A-Z]{3}$`',
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
    CONSTRAINT pk_collateral_pledge PRIMARY KEY(`collateral_pledge_id`)
) COMMENT 'Operational record of a collateral pledge — the formal assignment of a specific collateral asset to secure a specific credit exposure, derivative obligation, or repo transaction. Tracks pledge date, pledge amount/quantity, lien rank (first, second, subordinate), pledge status (active, released, substituted, enforced, defaulted), legal perfection status, obligor, secured party, and the governing collateral agreement. Links collateral assets to the underlying credit or trading obligation. Supports LTV monitoring, collateral coverage calculations, and regulatory capital recognition of credit risk mitigation under Basel III CRM framework.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_margin_call` (
    `collateral_margin_call_id` BIGINT COMMENT 'Unique identifier for the margin call transaction. Primary key for the margin call record.',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Missed margin call deadlines or disputed calls that violate CSA terms are tracked as compliance breaches. Required for counterparty escalation, regulatory reporting (EMIR, UMR), and remediation tracki',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Delivery deadline calculation requires holiday calendar for business day adjustment per CSA terms. Creating new holiday_calendar_id FK.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Margin calls trigger accounting entries for collateral movements and variation margin settlements. Essential for daily VM settlement accounting, subledger-to-GL reconciliation, and audit trail linking',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the CSA agreement governing the margin terms for this call.',
    `netting_set_id` BIGINT COMMENT 'Reference to the netting set under which this margin call is calculated, grouping trades subject to the same CSA or master agreement.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty involved in the margin call transaction.',
    `amount` DECIMAL(18,2) COMMENT 'The total amount of margin called or settled in the transaction currency.',
    `call_date` DATE COMMENT 'The business date on which the margin call was calculated and issued or received.',
    `call_direction` STRING COMMENT 'Indicates whether the margin call was issued by the institution to a counterparty or received from a counterparty.. Valid values are `issued|received`',
    `call_timestamp` TIMESTAMP COMMENT 'Precise date and time when the margin call was generated and communicated to the counterparty.',
    `collateral_posted_amount` DECIMAL(18,2) COMMENT 'The total amount of collateral posted by the institution to the counterparty as of the call date.',
    `collateral_received_amount` DECIMAL(18,2) COMMENT 'The total amount of collateral received by the institution from the counterparty as of the call date.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the margin call record was first created in the collateral management system.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the margin call amount.. Valid values are `^[A-Z]{3}$`',
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
    CONSTRAINT pk_collateral_margin_call PRIMARY KEY(`collateral_margin_call_id`)
) COMMENT 'Transactional record of all margin activity — margin calls, initial margin (IM) requirements and balances, and variation margin (VM) daily settlements — under CSA, CCP, and bilateral margin arrangements. Captures call/settlement date, margin type (IM requirement, IM posted/received, VM call, VM settlement), call direction (issued, received), amount, currency, delivery deadline, IM calculation methodology (ISDA SIMM, schedule-based), IM segregation status and custodian details, VM settlement status, netting set reference, dispute flag, dispute reason, dispute resolution status, settlement confirmation, UMR phase compliance, and regulatory flags (UMR, EMIR, Dodd-Frank daily VM). Tracks the full margin lifecycle from requirement calculation through call issuance, delivery, dispute resolution, and settlement confirmation per BCBS/IOSCO margin rules. This is the SSOT for all margin activity including IM balances and VM settlements.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_valuation` (
    `collateral_valuation_id` BIGINT COMMENT 'Unique identifier for the collateral valuation record.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Valuation methodologies, haircut schedules, and mark-to-market processes are audited for model validation, independent price verification, and regulatory compliance (EMIR, Dodd-Frank). Critical for fa',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset being valued.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Collateral valuations are performed in the context of specific pledge instances for LTV monitoring and margin calculations. The existing pledge_agreement_id links to the master agreement, but valuatio',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: SOX 404 controls over collateral valuation (pricing source validation, haircut application, override approvals) are tested against specific valuation records. Control testing samples valuations to ver',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the collateral is denominated (e.g., USD, EUR, GBP, JPY).',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this valuation, supporting segregation of duties and audit trail requirements.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Valuations of fund units used as collateral require fund-level reference. Business process: applying haircuts to fund NAVs for collateral eligibility calculations, mark-to-market valuation of pledged ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Valuation process requires instrument master data for pricing methodology selection, haircut application, and mark-to-market calculations. Critical for daily margin call generation and regulatory repo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Valuation adjustments (haircut changes, mark-to-market movements) generate journal entries for P&L or OCI impact under IFRS 13 fair value accounting. Required for financial close, valuation audit trai',
    `market_data_source_id` BIGINT COMMENT 'Specific identifier for the valuation source, such as appraiser license number, vendor system ID, exchange code, or model version identifier.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA CSA agreement governing the collateral terms for derivatives transactions, if applicable.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: CCAR/DFAST require collateral valuations under supervisory stress scenarios. Stressed collateral values drive LGD, RWA, and capital projections. Essential for regulatory stress testing submissions and',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when the valuation was formally approved and became effective for margin calculations and regulatory reporting.',
    `collateral_asset_class` STRING COMMENT 'The broad asset class category of the collateral being valued, determining applicable haircut schedules and eligibility rules under Basel III. [ENUM-REF-CANDIDATE: cash|government_securities|corporate_bonds|equities|real_estate|commodities|derivatives|other — 8 candidates stripped; promote to reference product]',
    `concentration_limit_breach` BOOLEAN COMMENT 'Flag indicating whether accepting this collateral valuation would breach concentration limits defined in the CSA agreement or internal risk policies.',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'The lower bound of the confidence interval for the valuation, representing the minimum expected value within the statistical confidence range (typically 95% or 99%).',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'The upper bound of the confidence interval for the valuation, representing the maximum expected value within the statistical confidence range.',
    `confidence_level_percentage` DECIMAL(18,2) COMMENT 'The statistical confidence level used for the valuation interval, typically 0.95 (95%) or 0.99 (99%), indicating the probability that the true value falls within the stated range.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was first created in the system.',
    `credit_quality_step` STRING COMMENT 'The Basel III credit quality step assigned to the collateral asset, ranging from 1 (highest quality) to 6 (lowest quality), determining risk weights and haircuts.',
    `eligible_for_central_bank` BOOLEAN COMMENT 'Indicates whether this collateral asset is eligible for use in central bank operations (e.g., Fed discount window, ECB refinancing operations).',
    `external_rating` STRING COMMENT 'The external credit rating assigned to the collateral asset by a recognized rating agency (e.g., AAA, AA+, BBB-), used for credit quality assessment and haircut determination.',
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
    `rating_agency` STRING COMMENT 'The name of the external credit rating agency that provided the rating (e.g., Moodys, S&P, Fitch, DBRS).',
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
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Haircut schedules implement regulatory obligations (Basel III capital rules, EMIR margin requirements, UMR initial margin). The obligation drives the schedule requirements and supervisory haircut floo',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Haircut schedules vary by currency due to FX volatility and liquidity. Central banks publish currency-specific haircut tables for regulatory capital and margin calculations. Creating new FK.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Asset class and subclass determine applicable haircut; requires classification reference for consistency with regulatory frameworks. Creating new instrument_classification_id FK.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Regulatory framework field should reference taxonomy master for consistent reporting across Basel, EMIR, UMR regimes. Creating new regulatory_taxonomy_id FK.',
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
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or regulatory authority under which this haircut schedule applies (e.g., USA, GBR, EUR, CHE). Three-letter ISO 3166-1 alpha-3 country code.',
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
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Eligibility rules are key controls audited for Basel III HQLA classification, EMIR eligible collateral requirements, and internal policy compliance. Auditors test rule logic, breach actions, and appro',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Eligibility rules operationalize regulatory obligations (central bank eligibility criteria, CCP requirements, Basel HQLA definitions). Each rule maps to specific regulatory citations and compliance ob',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Eligibility rules govern what collateral can be accepted, directly impacting financial statement assertions (valuation, rights). SOX controls ensure rules are properly approved, documented, and consis',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Asset class and type in eligibility rules should reference classification master for consistent application across collateral management. Creating new instrument_classification_id FK.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Regulatory framework field should reference taxonomy master for rule versioning and regulatory change management. Creating new regulatory_taxonomy_id FK.',
    `approval_authority` STRING COMMENT 'Name or identifier of the business unit, committee, or individual who approved this eligibility rule. Typically includes risk management, credit committee, or ALCO (Asset-Liability Committee).',
    `approval_date` DATE COMMENT 'Date on which the eligibility rule was formally approved by the designated approval authority.',
    `asset_class` STRING COMMENT 'The asset class to which this eligibility rule applies. Defines the broad category of collateral instruments covered by the rule, such as cash, government bonds, corporate bonds, equities, mortgage-backed securities (MBS), asset-backed securities (ABS), collateralized loan obligations (CLO), collateralized debt obligations (CDO), credit default swaps (CDS), or repo transactions. [ENUM-REF-CANDIDATE: cash|government_bond|corporate_bond|equity|mbs|abs|clo|cdo|cds|repo|other — 11 candidates stripped; promote to reference product]',
    `asset_type` STRING COMMENT 'More granular asset type specification within the asset class, such as specific instrument types, security subtypes, or product categories. Provides additional detail beyond the broad asset class.',
    `breach_action` STRING COMMENT 'Action to be taken when the eligibility rule or concentration limit is breached: hard_stop (prevent transaction), soft_warning (alert but allow), escalation (notify risk management), or auto_rebalance (trigger automatic portfolio rebalancing).. Valid values are `hard_stop|soft_warning|escalation|auto_rebalance`',
    `concentration_limit_absolute_amount` DECIMAL(18,2) COMMENT 'Maximum absolute monetary amount that can be allocated to the specified concentration dimension, expressed in the base currency of the collateral arrangement. Used when limits are defined in absolute terms rather than percentages.',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of total collateral portfolio value that can be allocated to the specified concentration dimension (e.g., no more than 25% from a single issuer). Expressed as a percentage with two decimal places.',
    `concentration_limit_type` STRING COMMENT 'Dimension along which the concentration limit is applied: issuer (single issuer exposure), asset_class (exposure to one asset class), currency (single currency exposure), counterparty (exposure to one counterparty), jurisdiction (geographic concentration), or sector (industry sector concentration).. Valid values are `issuer|asset_class|currency|counterparty|jurisdiction|sector`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the eligibility rule record was first created in the collateral management system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code specifying the currency denomination requirement for eligible collateral under this rule. If null, the rule applies to all currencies.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the eligibility rule becomes active and enforceable. Rules are not applied to collateral arrangements before this date.',
    `eligible_for_ccp` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible for posting to a central counterparty (CCP) for cleared derivatives transactions. True if eligible, false otherwise.',
    `eligible_for_initial_margin` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible to satisfy initial margin (IM) requirements under uncleared derivatives margin rules (UMR). True if eligible, false otherwise.',
    `eligible_for_repo` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible for use in repurchase (repo) or reverse repurchase (reverse repo) transactions. True if eligible, false otherwise.',
    `eligible_for_secured_lending` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible for secured lending transactions, including securities lending and collateralized loans. True if eligible, false otherwise.',
    `eligible_for_variation_margin` BOOLEAN COMMENT 'Boolean flag indicating whether collateral meeting this rule is eligible to satisfy variation margin (VM) requirements under derivatives margining frameworks. True if eligible, false otherwise.',
    `expiry_date` DATE COMMENT 'Date on which the eligibility rule ceases to be active. Null indicates the rule has no expiration and remains in effect indefinitely unless explicitly deactivated.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Valuation discount percentage applied to collateral assets meeting this eligibility rule, reflecting market risk, liquidity risk, and credit risk. Expressed as a percentage (e.g., 5.00 means a 5% haircut).',
    `issuer_type` STRING COMMENT 'Classification of the issuer of the collateral asset: sovereign (government), supranational (international organizations), agency (government-sponsored entities), corporate (non-financial corporations), financial institution (banks, insurers), municipal (local government), or other. [ENUM-REF-CANDIDATE: sovereign|supranational|agency|corporate|financial_institution|municipal|other — 7 candidates stripped; promote to reference product]',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code specifying the jurisdiction or country of issuance for eligible collateral. Used to enforce geographic diversification or restriction requirements.. Valid values are `^[A-Z]{3}$`',
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
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: CSA agreement breaches (missed margin calls, threshold violations, unauthorized rehypothecation) are tracked as compliance breaches. Required for counterparty notification, regulatory reporting, and d',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: CSA agreements must comply with UMR, EMIR, Dodd-Frank margin obligations. The agreement implements specific regulatory requirements (phase-in thresholds, segregation, eligible collateral). Required fo',
    `currency_id` BIGINT COMMENT 'ISO 4217 three-letter currency code for the threshold amount.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this margin agreement record.',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: margin_agreement has eligible_collateral_schedule_id (BIGINT) which appears to reference a schedule defining eligible collateral and haircuts. haircut_schedule is the reference table in the collateral',
    `isda_master_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.isda_master_agreement. Business justification: Margin agreements (CSAs) are executed as annexes under ISDA Master Agreements. The ISDA Master Agreement is the parent legal framework governing derivatives transactions, and the margin agreement (CSA',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Governing law jurisdiction determines contract enforceability, dispute resolution, and UMR phase-in applicability. Creating jurisdiction_country_id FK to replace jurisdiction code.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Onboarding a new CSA counterparty requires KYC review per ISDA and UMR requirements. The review is tied to the specific margin agreement being established for risk rating and due diligence documentati',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: CSA agreements are legal entity-specific for netting enforceability, capital treatment, and financial reporting. Required for entity-level exposure reporting, consolidation, regulatory capital calcula',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Counterparty LEI is required for UMR compliance, regulatory reporting, and credit risk assessment. Creating new counterparty_lei FK.',
    `netting_set_id` BIGINT COMMENT 'Reference to the master netting agreement (e.g., ISDA Master Agreement) under which this margin agreement operates, enabling close-out netting upon default.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity with whom this margin agreement is established.',
    `primary_margin_party_id` BIGINT COMMENT 'Reference to the custodian or third-party agent holding segregated collateral under this agreement, if applicable.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Regulatory margin regime (UMR, EMIR, Dodd-Frank) should reference taxonomy for compliance tracking and reporting. Creating new regulatory_taxonomy_id FK.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last updated this margin agreement record.',
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
    `collateral_asset_id` BIGINT COMMENT 'Reference to the specific collateral asset (security, cash deposit, letter of credit, physical asset) that forms this position.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: collateral_position has arrangement_id (BIGINT) which is a generic placeholder FK with no clear target. In collateral management, positions represent current inventory and exposure snapshots for colla',
    `currency_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code in which the market value, face value, and haircut value are denominated.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Collateral positions track fund holdings used as collateral on a position-date basis. Business process: daily collateral valuation for margin monitoring, mark-to-market of fund-backed exposures, HQLA ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Daily collateral positions must reconcile to GL balances for subledger control accounts. Essential for daily subledger reconciliation, SOX control testing, and ensuring collateral subledger ties to ge',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Position management tracks security holdings as collateral. Enables exposure aggregation, concentration limit monitoring, and regulatory filings (Securities Financing Transactions Regulation). Essenti',
    `party_id` BIGINT COMMENT 'Reference to the counterparty (customer, broker-dealer, central counterparty) with whom this collateral position is held or exchanged.',
    `primary_collateral_party_id` BIGINT COMMENT 'Reference to the custodian bank or depository institution holding the physical or book-entry collateral asset.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`substitution` (
    `substitution_id` BIGINT COMMENT 'Unique identifier for the collateral substitution transaction. Primary key for the collateral substitution record.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Substitution processes audited for approval workflow compliance, eligibility check effectiveness, counterparty consent requirements, and cheapest-to-deliver optimization controls. Operational risk and',
    `collateral_margin_call_id` BIGINT COMMENT 'Reference to the margin call that triggered or is associated with this collateral substitution, if applicable.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Substitution workflows require instrument-level tracking for eligibility validation, value equivalence checks, and cheapest-to-deliver optimization. Links original security being replaced in collatera',
    `party_id` BIGINT COMMENT 'Reference to the counterparty with whom the collateral substitution is being executed.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the master collateral agreement or Credit Support Annex (CSA) under which this substitution is executed.',
    `primary_substitution_party_id` BIGINT COMMENT 'Reference to the custodian or triparty agent responsible for holding and transferring the collateral assets in this substitution transaction.',
    `employee_id` BIGINT COMMENT 'Reference to the user who initiated or created the collateral substitution request in the system.',
    `substitution_employee_id` BIGINT COMMENT 'Reference to the internal user or approver who authorized the collateral substitution request.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the original pledged or posted collateral asset being replaced in this substitution transaction.',
    `substitution_replacement_collateral_asset_id` BIGINT COMMENT 'Reference to the new collateral asset being substituted in place of the original asset.',
    `substitution_updated_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the collateral substitution record.',
    `approval_workflow_status` STRING COMMENT 'Current status of the internal approval workflow for the substitution request, tracking progression through risk review, credit approval, and operational authorization stages.. Valid values are `draft|submitted|under_review|approved|rejected|cancelled`',
    `cheapest_to_deliver_flag` BOOLEAN COMMENT 'Boolean indicator of whether this substitution is part of a cheapest-to-deliver optimization strategy (True) or driven by other operational or risk factors (False).',
    `collateral_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the collateral valuation amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `concentration_limit_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the substitution was triggered by a concentration limit breach in the collateral pool (True) or for other reasons (False).',
    `cost_savings_amount` DECIMAL(18,2) COMMENT 'Estimated or actual cost savings achieved through the collateral substitution, typically measured as the difference in funding costs or opportunity costs between the original and replacement assets.',
    `cost_savings_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost savings amount.. Valid values are `^[A-Z]{3}$`',
    `counterparty_consent_comments` STRING COMMENT 'Free-text comments or conditions provided by the counterparty regarding their consent decision, including any stipulations for conditional approval.',
    `counterparty_consent_date` DATE COMMENT 'Date on which the counterparty provided their consent decision (approval or rejection) for the substitution request.',
    `counterparty_consent_status` STRING COMMENT 'Current status of counterparty consent for the collateral substitution request. Tracks whether the counterparty has approved, rejected, conditionally approved, or is still reviewing the substitution request.. Valid values are `pending|approved|rejected|conditional_approval|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collateral substitution record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the collateral substitution becomes effective and the replacement collateral officially replaces the original collateral in the agreement.',
    `eligibility_check_date` DATE COMMENT 'Date on which the eligibility verification for the replacement collateral asset was completed.',
    `eligibility_check_status` STRING COMMENT 'Status of the eligibility verification process for the replacement collateral asset, confirming it meets all criteria defined in the collateral agreement (asset class, credit rating, maturity, concentration limits).. Valid values are `passed|failed|pending|waived`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the counterparty or custodian for processing the collateral substitution request, if applicable per the collateral agreement terms.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the substitution fee amount.. Valid values are `^[A-Z]{3}$`',
    `internal_approval_date` DATE COMMENT 'Date on which internal approval was granted for the collateral substitution request, following completion of risk and credit review processes.',
    `original_collateral_adjusted_value_amount` DECIMAL(18,2) COMMENT 'Post-haircut value of the original collateral asset, representing the effective collateral coverage amount.',
    `original_collateral_haircut_rate` DECIMAL(18,2) COMMENT 'Haircut percentage applied to the original collateral asset based on asset class, credit quality, and liquidity characteristics. Expressed as a decimal (e.g., 0.0500 for 5%).',
    `original_collateral_value_amount` DECIMAL(18,2) COMMENT 'Market value of the original collateral asset at the time of substitution request, before application of haircut.',
    `reason_code` STRING COMMENT 'Categorical code indicating the primary business reason for the collateral substitution request. Common reasons include cost optimization (cheapest-to-deliver strategy), approaching maturity of original asset, eligibility criteria change, credit rating downgrade, concentration limit breach, or liquidity management needs.. Valid values are `cost_optimization|approaching_maturity|eligibility_change|rating_downgrade|concentration_breach|liquidity_management`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the business rationale and circumstances driving the collateral substitution request.',
    `replacement_collateral_adjusted_value_amount` DECIMAL(18,2) COMMENT 'Post-haircut value of the replacement collateral asset, representing the effective collateral coverage amount after substitution.',
    `replacement_collateral_haircut_rate` DECIMAL(18,2) COMMENT 'Haircut percentage applied to the replacement collateral asset based on asset class, credit quality, and liquidity characteristics. Expressed as a decimal (e.g., 0.0500 for 5%).',
    `replacement_collateral_value_amount` DECIMAL(18,2) COMMENT 'Market value of the replacement collateral asset at the time of substitution request, before application of haircut.',
    `request_date` DATE COMMENT 'Date on which the collateral substitution request was initiated by the requesting party.',
    `request_number` STRING COMMENT 'Business identifier for the substitution request, used for tracking and reference in operational workflows and counterparty communications.',
    `settlement_confirmation_number` STRING COMMENT 'Unique confirmation reference number issued by the settlement system or custodian upon successful completion of the collateral transfer.',
    `settlement_date` DATE COMMENT 'Date on which the physical or book-entry transfer of collateral assets is completed, finalizing the substitution transaction.',
    `settlement_method` STRING COMMENT 'Method used for settling the collateral substitution transaction. Options include Delivery versus Payment (DVP), Free of Payment (FOP), triparty arrangement, or bilateral settlement.. Valid values are `dvp|fop|triparty|bilateral`',
    `settlement_status` STRING COMMENT 'Current status of the settlement process for the collateral substitution, tracking the operational completion of asset transfers.. Valid values are `pending|in_progress|settled|failed|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this collateral substitution record was last modified in the system.',
    CONSTRAINT pk_substitution PRIMARY KEY(`substitution_id`)
) COMMENT 'Transactional record of collateral substitution events where one pledged or posted asset is replaced by another under the terms of a collateral agreement, CSA, or repo arrangement. Captures substitution request date, original collateral asset, replacement collateral asset, substitution reason (cost optimization, approaching maturity, eligibility change, rating downgrade, concentration breach), counterparty consent status, effective date, approval workflow status, and settlement confirmation. Tracks the full substitution lifecycle from request through counterparty approval to settlement. Critical for collateral optimization and cheapest-to-deliver strategies.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`margin_exposure` (
    `margin_exposure_id` BIGINT COMMENT 'Unique identifier for the margin exposure calculation record.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Margin exposure calculations audited for CVA/DVA accuracy, PFE modeling validation, threshold breach detection, and regulatory IM model compliance. Critical for counterparty credit risk and model vali',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the margin agreement or Credit Support Annex (CSA) under which this exposure is calculated.',
    `netting_set_id` BIGINT COMMENT 'Identifier for the group of transactions that are subject to bilateral netting under the ISDA Master Agreement. All trades within a netting set are netted together for exposure calculation.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity with whom the margin exposure exists.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Liquidity stress testing projects margin calls under adverse scenarios. Stressed margin exposure drives liquidity buffer sizing and LCR/NSFR projections. Required for regulatory liquidity stress tests',
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
    `exposure_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the exposure amounts are denominated. All monetary amounts in this record are expressed in this currency.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`repo_agreement` (
    `repo_agreement_id` BIGINT COMMENT 'Unique identifier for the repurchase agreement transaction.',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Repo agreements are secured by collateral assets. repo_agreement is currently SILOED with no in-domain FKs. The table has collateral_basket_description and collateral_market_value which are redundant ',
    `collateral_basket_id` BIGINT COMMENT 'Identifier of the collateral basket pledged or received under this repo agreement.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Repo counterparty credit quality determines haircuts, concentration limits, and eligible counterparty lists. Rating downgrades trigger repo unwind provisions. Standard treasury and credit risk managem',
    `currency_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code for the near leg cash amount.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Repo agreements can use fund units as collateral in securities financing transactions. Business process: repo market operations with fund shares as collateral, securities lending programs using fund h',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Repo transactions require specific GL treatment for cash vs securities legs, repo interest accrual, and balance sheet classification. Essential for treasury accounting, SFTR reporting, and financial s',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement date calculation for near/far legs requires holiday calendar per market convention. Creating new holiday_calendar_id FK.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Repo transactions are security-backed financing. Instrument link enables coupon pass-through calculations, corporate action handling, substitution rights validation, and settlement instruction generat',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Repo agreements are executed via trade orders on repo trading desks. Links master repo agreement terms to specific execution orders, enabling traders to verify order compliance with agreement limits a',
    `party_id` BIGINT COMMENT 'Identifier of the counterparty institution or entity participating in the repo transaction.',
    `primary_repo_party_id` BIGINT COMMENT 'Identifier of the custodian bank or tri-party agent managing collateral settlement and safekeeping.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Repo rate often references benchmark (SOFR + spread) for pricing and accrual calculations. Creating repo_rate_benchmark_id FK for benchmark-linked repos.',
    `coupon_pass_through_flag` BOOLEAN COMMENT 'Indicates whether coupon or dividend payments on the collateral securities are passed through to the cash lender during the repo term. True if pass-through applies, False otherwise.',
    `coupon_payment_date` DATE COMMENT 'The date on which any coupon or dividend payment on the collateral is due to be passed through, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this repo agreement record was first created in the system.',
    `fail_reason` STRING COMMENT 'Textual description of the reason for settlement failure, such as insufficient collateral, cash shortfall, or operational error.',
    `fail_resolution_date` DATE COMMENT 'The date on which a failed trade was resolved and settlement completed.',
    `failed_trade_flag` BOOLEAN COMMENT 'Indicates whether the repo transaction has experienced a settlement failure on either leg. True if failed, False otherwise.',
    `far_leg_amount` DECIMAL(18,2) COMMENT 'The total repurchase amount on the far leg, including principal and accrued repo interest.',
    `far_leg_confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the far leg settlement was confirmed by the custodian or settlement system.',
    `far_leg_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the far leg repurchase amount.. Valid values are `^[A-Z]{3}$`',
    `far_leg_repurchase_date` DATE COMMENT 'The scheduled maturity or repurchase date for the far leg when collateral is returned and cash plus interest is repaid. Null for open repos until termination notice is given.',
    `far_leg_settlement_reference` STRING COMMENT 'SWIFT message reference or RTGS transaction identifier for the far leg repurchase settlement.',
    `far_leg_settlement_status` STRING COMMENT 'Current settlement status of the far leg: pending (awaiting maturity), settled (completed), failed (settlement failure), or cancelled.. Valid values are `pending|settled|failed|cancelled`',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the market value of collateral to determine the loan amount, expressed as a percentage (e.g., 2.00 for 2% haircut).',
    `initial_margin_amount` DECIMAL(18,2) COMMENT 'The initial margin posted at trade inception to cover potential exposure, calculated per Basel III margin requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this repo agreement record was last updated.',
    `margin_call_threshold` DECIMAL(18,2) COMMENT 'The minimum collateral value shortfall that triggers a margin call under the repo agreement.',
    `near_leg_amount` DECIMAL(18,2) COMMENT 'The principal cash amount exchanged on the near leg settlement date.',
    `near_leg_confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the near leg settlement was confirmed by the custodian or settlement system.',
    `near_leg_settlement_date` DATE COMMENT 'The settlement date for the initial cash and collateral exchange (near leg) of the repo transaction, typically T+1 or T+0.',
    `near_leg_settlement_reference` STRING COMMENT 'SWIFT message reference or RTGS transaction identifier for the near leg cash settlement.',
    `near_leg_settlement_status` STRING COMMENT 'Current settlement status of the near leg: pending (awaiting settlement), settled (completed), failed (settlement failure), or cancelled.. Valid values are `pending|settled|failed|cancelled`',
    `open_term_flag` BOOLEAN COMMENT 'Indicates whether the repo is open-ended (callable on demand) or term (fixed maturity). True for open repo, False for term repo.',
    `repo_agreement_number` STRING COMMENT 'Externally-known business identifier or reference number for the repo transaction, used for trade confirmation and settlement messaging.',
    `repo_direction` STRING COMMENT 'Indicates whether the institution is borrowing cash (repo) or lending cash (reverse repo).. Valid values are `repo|reverse_repo`',
    `repo_rate` DECIMAL(18,2) COMMENT 'The annualized interest rate applied to the repo transaction, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `repo_rate_basis` STRING COMMENT 'The day count convention used to calculate repo interest: actual/360, actual/365, or 30/360.. Valid values are `actual_360|actual_365|30_360`',
    `repo_status` STRING COMMENT 'Current lifecycle status of the repo agreement: active (in force), matured (far leg settled), terminated (early termination), cancelled (voided before settlement), or defaulted (counterparty default).. Valid values are `active|matured|terminated|cancelled|defaulted`',
    `repo_type` STRING COMMENT 'Classification of the repo structure: classic repo (legal title transfer with repurchase obligation), sell/buy-back (two separate sale transactions), tri-party (custodian-managed collateral), or hold-in-custody (bilateral custody).. Valid values are `classic_repo|sell_buyback|tri_party|hold_in_custody`',
    `substitution_rights_flag` BOOLEAN COMMENT 'Indicates whether the cash borrower has the right to substitute collateral during the repo term. True if substitution is permitted, False otherwise.',
    `termination_date` DATE COMMENT 'The date on which the repo agreement was terminated, either at maturity or through early termination.',
    `termination_reason` STRING COMMENT 'Textual description of the reason for early termination, such as counterparty request, default event, or regulatory requirement.',
    `trade_date` DATE COMMENT 'The date on which the repo agreement was executed and confirmed between counterparties.',
    `variation_margin_amount` DECIMAL(18,2) COMMENT 'The current variation margin amount reflecting mark-to-market changes in collateral value or exposure.',
    CONSTRAINT pk_repo_agreement PRIMARY KEY(`repo_agreement_id`)
) COMMENT 'Master record of repurchase agreement (repo) and reverse repo transactions with embedded near-leg and far-leg settlement details. Captures repo type (classic repo, sell/buy-back, tri-party), trade date, near-leg settlement date/amount/currency/status, far-leg repurchase date/amount/currency/status, repo rate, haircut, collateral basket description, open/term flag, counterparty, coupon pass-through terms and dates, each legs SWIFT/RTGS settlement reference, custodian instructions per leg, settlement confirmation status per leg, and failed trade status with fail reason and resolution. Supports treasury liquidity management, T+1 settlement tracking per leg, failed trade management, and LCR/NSFR regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`repo_leg` (
    `repo_leg_id` BIGINT COMMENT 'Unique identifier for the repo leg. Primary key.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Repo settlement legs audited for failed trade resolution, SWIFT instruction accuracy, custodian reconciliation, and SFTR UTI reporting. Operational risk and settlement process audit scope.',
    `bic_directory_id` BIGINT COMMENT 'Bank Identifier Code (BIC) of the settlement agent responsible for processing this legs settlement.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the settlement amount (e.g., USD, EUR, GBP).',
    `party_id` BIGINT COMMENT 'Reference to the custodian institution responsible for holding and settling the securities for this leg.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement date adjustment requires holiday calendar for payment system availability and business day conventions. Creating new holiday_calendar_id FK.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Each repo leg involves specific securities for settlement. Enables ISIN/CUSIP population in SWIFT messages, custodian instruction routing, and DVP settlement confirmation. Essential for repo operation',
    `netting_set_id` BIGINT COMMENT 'Identifier for the netting set to which this leg belongs, used for exposure calculation and risk management under Basel III.',
    `repo_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.repo_agreement. Business justification: repo_leg represents individual settlement legs (near leg and far leg) of a repo transaction. repo_leg currently only has repo_transaction_id pointing to treasury.repo_transaction (cross-domain). Withi',
    `repo_transaction_id` BIGINT COMMENT 'Reference to the parent repo transaction that this leg belongs to.',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.settlement_instruction. Business justification: Each repo leg (near/far) generates settlement instructions for cash and securities. Operations teams match repo leg settlements to trade settlement instructions to reconcile nostro movements, resolve ',
    `transfer_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_transfer. Business justification: Repo settlement legs trigger collateral transfers: near leg delivers collateral, far leg returns it. Operational settlement requires linking repo leg to corresponding collateral movement for reconcili',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'The amount of interest accrued on the underlying securities between the last coupon payment and the settlement date of this leg.',
    `actual_settlement_amount` DECIMAL(18,2) COMMENT 'The actual monetary amount that was settled for this leg, which may differ from the scheduled amount due to adjustments or partial settlements.',
    `actual_settlement_date` DATE COMMENT 'The actual date on which this leg settled, which may differ from the scheduled settlement date in case of delays or early settlement.',
    `counterparty_settlement_account` STRING COMMENT 'The counterpartys account number or IBAN used for settlement of this leg.',
    `coupon_payment_amount` DECIMAL(18,2) COMMENT 'The coupon payment amount passed through to the counterparty for this leg, if applicable to coupon pass-through legs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this repo leg record was first created in the system.',
    `custodian_account_number` STRING COMMENT 'The account number at the custodian institution where securities are held for this leg.',
    `custodian_instruction_reference` STRING COMMENT 'Reference number for the settlement instruction sent to the custodian for this leg.',
    `failed_settlement_date` DATE COMMENT 'The date on which the settlement failure was recorded for this leg.',
    `failed_settlement_reason` STRING COMMENT 'Reason code or description explaining why the settlement failed, if applicable (e.g., insufficient funds, securities unavailable, system error).',
    `haircut_adjustment_amount` DECIMAL(18,2) COMMENT 'The haircut adjustment applied to the collateral value for this leg, reflecting the discount applied to mitigate market risk.',
    `leg_notes` STRING COMMENT 'Free-text notes or comments related to this specific leg, capturing operational details, exceptions, or special instructions.',
    `leg_reference_number` STRING COMMENT 'External business reference number for this specific leg, used for operational tracking and reconciliation.',
    `leg_sequence_number` STRING COMMENT 'Sequential ordering of this leg within the parent repo transaction (1 for near leg, 2 for far leg, etc.).',
    `leg_type` STRING COMMENT 'Type of repo leg: near leg (initial purchase/sale), far leg (repurchase/resale), or coupon pass-through leg.. Valid values are `near|far|coupon_pass_through`',
    `margin_call_adjustment_amount` DECIMAL(18,2) COMMENT 'Any margin call adjustment amount applied to this legs settlement, reflecting variation margin requirements.',
    `next_retry_date` DATE COMMENT 'The scheduled date for the next settlement retry attempt, if the leg has failed settlement.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this leg requires regulatory reporting under Basel III, SFTR, or other regulatory frameworks.',
    `rtgs_reference_number` STRING COMMENT 'Real-Time Gross Settlement system reference number for this legs payment settlement.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The monetary amount to be settled for this leg, including principal and any accrued interest or adjustments.',
    `settlement_confirmation_date` DATE COMMENT 'The date on which settlement confirmation was received from the custodian or settlement system for this leg.',
    `settlement_confirmation_reference` STRING COMMENT 'Reference number from the settlement confirmation message received for this leg.',
    `settlement_date` DATE COMMENT 'The date on which this leg is scheduled to settle. For near leg, this is the initial settlement date; for far leg, this is the repurchase/resale date.',
    `settlement_fee_amount` DECIMAL(18,2) COMMENT 'Fees charged by the settlement agent, custodian, or payment system for processing this legs settlement.',
    `settlement_instruction_date` DATE COMMENT 'The date on which settlement instructions were issued to the custodian or settlement agent for this leg.',
    `settlement_method` STRING COMMENT 'Method of settlement: DVP (Delivery Versus Payment), FOP (Free of Payment), or RVP (Receive Versus Payment).. Valid values are `dvp|fop|rvp`',
    `settlement_retry_count` STRING COMMENT 'Number of times settlement has been attempted for this leg after initial failure.',
    `settlement_status` STRING COMMENT 'Current status of the settlement for this leg: pending (awaiting settlement), settled (successfully completed), failed (settlement failed), cancelled (leg cancelled), or partially settled (partial completion).. Valid values are `pending|settled|failed|cancelled|partially_settled`',
    `settlement_system` STRING COMMENT 'The payment or securities settlement system used for this leg (e.g., SWIFT, RTGS, ACH, Fedwire, CHIPS, TARGET2, CREST). [ENUM-REF-CANDIDATE: swift|rtgs|ach|fedwire|chips|target2|crest — 7 candidates stripped; promote to reference product]',
    `settlement_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the scheduled settlement amount and the actual settlement amount, capturing any discrepancies or adjustments.',
    `sftr_reporting_status` STRING COMMENT 'Status of SFTR regulatory reporting for this leg: not required, pending submission, submitted, accepted by regulator, or rejected.. Valid values are `not_required|pending|submitted|accepted|rejected`',
    `sftr_uti` STRING COMMENT 'Unique Transaction Identifier assigned for SFTR regulatory reporting purposes for this leg.',
    `swift_message_reference` STRING COMMENT 'SWIFT message reference number (e.g., MT202, MT300) associated with this legs settlement instruction.',
    `trade_repository_reference` STRING COMMENT 'Reference number assigned by the trade repository where this legs transaction details are reported.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this repo leg record was last updated in the system.',
    CONSTRAINT pk_repo_leg PRIMARY KEY(`repo_leg_id`)
) COMMENT 'Individual settlement leg of a repo or reverse repo transaction, capturing the near leg (initial purchase/sale) and far leg (repurchase/resale) settlement details. Tracks leg type (near, far, coupon pass-through), settlement date, settlement amount, settlement currency, settlement status (pending, settled, failed), SWIFT/RTGS settlement reference, and custodian instruction details. Enables T+1 settlement tracking and failed trade management.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`pledge_agreement` (
    `pledge_agreement_id` BIGINT COMMENT 'Primary key for pledge_agreement',
    `counterparty_agreement_id` BIGINT COMMENT 'Identifier of the parent master agreement under which this pledge agreement operates, if part of a broader relationship framework.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the secured obligation amount.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Pledge agreements are executed by specific legal entities for regulatory capital treatment, consolidation, and entity-level financial statements. Essential for legal entity reporting, regulatory submi',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Obligor LEI is required for regulatory reporting and credit risk management. Creating new obligor_lei FK.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Perfection jurisdiction determines legal validity and regulatory capital treatment. Creating perfection_jurisdiction_country_id FK to replace perfection_jurisdiction code.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`initial_margin` (
    `initial_margin_id` BIGINT COMMENT 'Unique identifier for the initial margin record. Primary key for the initial margin data product.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Initial margin calculations audited for SIMM model validation, UMR phase-in compliance, segregation requirement adherence, and AANA threshold accuracy. Key for derivatives regulatory compliance audits',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Initial margin calculations implement UMR phase-in obligations (BCBS-IOSCO framework). The IM record must reference the specific regulatory obligation for phase-in date, AANA threshold, and methodolog',
    `currency_id` BIGINT COMMENT 'The three-letter ISO 4217 currency code in which the initial margin amounts are denominated (e.g., USD, EUR, GBP).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Initial margin posted/received must be recorded in specific balance sheet accounts per IFRS 9 and regulatory capital rules. Essential for UMR compliance reporting, balance sheet presentation, and segr',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity for which initial margin is calculated and exchanged under bilateral OTC derivative transactions.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex agreement governing the initial margin terms, including segregation, substitution, and dispute resolution provisions.',
    `primary_initial_custodian_party_id` BIGINT COMMENT 'Reference to the third-party custodian or triparty agent holding the segregated initial margin collateral on behalf of the posting party.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: UMR compliance requires initial margin sizing under stressed market conditions. SIMM methodology incorporates historical stress periods. Regulatory capital models (SA-CCR) use stressed IM for EAD calc',
    `trade_position_id` BIGINT COMMENT 'Foreign key linking to trade.trade_position. Business justification: Initial margin requirements are calculated by aggregating trade positions in the netting set. Risk and margin teams drill down from IM requirements to underlying positions for SIMM sensitivity analysi',
    `aana_amount` DECIMAL(18,2) COMMENT 'The aggregate average notional amount of uncleared derivatives for the counterparty group, calculated over a specified period (typically March, April, May of the prior year). AANA determines UMR phase-in applicability.',
    `aana_calculation_date` DATE COMMENT 'The date on which the AANA was calculated for the counterparty group, used to determine UMR phase-in eligibility.',
    `calculation_date` DATE COMMENT 'The business date on which the initial margin requirement was calculated. This is the valuation date for the underlying derivative portfolio used in the IM calculation.',
    `calculation_methodology` STRING COMMENT 'The methodology used to calculate the initial margin requirement. ISDA SIMM (Standard Initial Margin Model) is the industry-standard risk-based approach; Schedule-Based uses fixed percentages by asset class per regulatory schedules; Internal Model refers to proprietary approved models.. Valid values are `ISDA SIMM|Schedule-Based|Grid-Based|Internal Model|Hybrid`',
    `compliance_status` STRING COMMENT 'The compliance status of the initial margin arrangement with respect to UMR requirements. Non-Compliant status indicates a breach requiring remediation.. Valid values are `Compliant|Non-Compliant|Pending Review|Exempted`',
    `concentration_limit_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the initial margin collateral portfolio breaches concentration limits defined in the CSA or regulatory requirements (e.g., single issuer limits, asset class limits).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this initial margin record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `custodian_account_number` STRING COMMENT 'The account number at the custodian institution where the initial margin collateral is held. This is business-confidential information.',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The amount of initial margin under dispute between the entity and the counterparty due to calculation differences, valuation disagreements, or operational errors. Null if no dispute exists.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the initial margin dispute, including details of the calculation or valuation disagreement.',
    `eligible_collateral_types` STRING COMMENT 'Comma-separated list of collateral asset types eligible for posting as initial margin under the CSA agreement (e.g., Cash, Government Bonds, Corporate Bonds, Equities). Eligibility is defined by the CSA and regulatory requirements.',
    `haircut_schedule_applied` STRING COMMENT 'The name or identifier of the haircut schedule applied to non-cash collateral posted as initial margin. Haircuts reduce the collateral value to account for market risk and liquidity risk.',
    `im_posted_amount` DECIMAL(18,2) COMMENT 'The actual initial margin amount posted by the entity to the counterparty as of the calculation date. This represents collateral delivered to meet the IM requirement.',
    `im_received_amount` DECIMAL(18,2) COMMENT 'The actual initial margin amount received by the entity from the counterparty as of the calculation date. This represents collateral received to cover the counterpartys IM obligation.',
    `im_requirement_amount` DECIMAL(18,2) COMMENT 'The total initial margin amount required to be posted by the entity to the counterparty, calculated based on the agreed methodology and the risk profile of the uncleared OTC derivative portfolio.',
    `independent_amount` DECIMAL(18,2) COMMENT 'An additional fixed or formula-based margin amount agreed bilaterally in the CSA, independent of the mark-to-market exposure or SIMM calculation. Often used for credit risk mitigation.',
    `interest_rate_on_cash_collateral` DECIMAL(18,2) COMMENT 'The interest rate applied to cash collateral posted as initial margin, as agreed in the CSA. Typically based on an overnight rate such as SOFR or ESTR.',
    `last_margin_call_date` DATE COMMENT 'The date of the most recent initial margin call issued to or by the counterparty due to a change in the IM requirement exceeding the minimum transfer amount.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum amount of initial margin change that triggers a collateral transfer. Amounts below the MTA are not called or returned to reduce operational burden.',
    `model_approval_status` STRING COMMENT 'The regulatory approval status of the internal model used for initial margin calculation, if applicable. ISDA SIMM is generally pre-approved; proprietary models require explicit regulatory approval.. Valid values are `Approved|Pending Approval|Rejected|Under Review`',
    `model_validation_date` DATE COMMENT 'The date of the most recent independent validation of the initial margin calculation model, as required by model governance and regulatory standards.',
    `net_im_exposure` DECIMAL(18,2) COMMENT 'The net initial margin exposure after netting posted and received amounts. Positive values indicate the entity has a net IM receivable; negative values indicate a net IM payable.',
    `next_scheduled_review_date` DATE COMMENT 'The date of the next scheduled review of the initial margin methodology, model parameters, or CSA terms, as required by internal governance or regulatory standards.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context related to the initial margin record, including operational issues, special agreements, or audit trail information.',
    `phase_in_date` DATE COMMENT 'The effective date on which the counterparty relationship became subject to UMR initial margin requirements, based on the applicable regulatory phase.',
    `reconciliation_date` DATE COMMENT 'The date on which the most recent reconciliation of initial margin calculations and balances was performed with the counterparty.',
    `reconciliation_status` STRING COMMENT 'The status of the daily reconciliation process between the entity and the counterparty for initial margin calculations and balances. Matched indicates agreement; Unmatched or Disputed indicates discrepancies requiring resolution.. Valid values are `Matched|Unmatched|Disputed|Pending|Resolved`',
    `regulatory_phase` STRING COMMENT 'The UMR phase-in category to which the counterparty relationship belongs, based on aggregate average notional amount (AANA) thresholds. Phase 1 applies to the largest entities; Phase 6 to smaller entities. Out of Scope indicates the relationship does not meet UMR thresholds. [ENUM-REF-CANDIDATE: Phase 1|Phase 2|Phase 3|Phase 4|Phase 5|Phase 6|Out of Scope — 7 candidates stripped; promote to reference product]',
    `rehypothecation_allowed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the receiving party is permitted to rehypothecate (reuse) the initial margin collateral. UMR generally prohibits rehypothecation of IM collateral to ensure segregation and protection.',
    `reporting_jurisdiction` STRING COMMENT 'The regulatory jurisdiction(s) to which this initial margin record must be reported (e.g., US, EU, UK, Japan). Multiple jurisdictions may apply for cross-border transactions.',
    `segregation_status` STRING COMMENT 'Indicates whether the initial margin collateral is held in a segregated account (isolated from the custodians own assets and other clients assets) or commingled. Segregation is a key regulatory requirement under UMR to protect against custodian insolvency.. Valid values are `Segregated|Commingled|Partially Segregated`',
    `simm_version` STRING COMMENT 'The version of the ISDA SIMM methodology applied for the calculation (e.g., SIMM 2.6, SIMM 2.5). Null if a non-SIMM methodology is used.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the posting party has the right to substitute initial margin collateral with other eligible assets, as defined in the CSA agreement.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The bilateral threshold amount agreed in the CSA below which initial margin is not required to be posted. Regulatory maximum is typically 50 million in the base currency of the CSA.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this initial margin record was last updated in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_initial_margin PRIMARY KEY(`initial_margin_id`)
) COMMENT 'Record of initial margin (IM) requirements and balances for uncleared OTC derivatives under BCBS/IOSCO Uncleared Margin Rules (UMR). Captures IM calculation methodology (ISDA SIMM, schedule-based), IM requirement amount, IM posted amount, IM received amount, segregation status (segregated, commingled), custodian details, regulatory phase, and daily reconciliation status. Tracks compliance with UMR phase-in requirements and SIMM model governance.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`variation_margin` (
    `variation_margin_id` BIGINT COMMENT 'Unique identifier for the variation margin settlement record.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Variation margin processes audited for daily settlement accuracy, portfolio MTM validation, dispute resolution effectiveness, and regulatory regime compliance. Operational risk and counterparty credit',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Variation margin practices implement EMIR/Dodd-Frank margin obligations (daily exchange, threshold limits, eligible collateral). VM records trace to specific regulatory requirements for compliance att',
    `currency_id` BIGINT COMMENT 'The ISO 4217 three-letter currency code in which the variation margin is denominated and settled.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement date calculation requires holiday calendar for business day adjustment per CSA terms. Creating new holiday_calendar_id FK.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Daily variation margin settlements generate journal entries for cash/securities movements. Required for daily mark-to-market accounting, P&L attribution, and subledger reconciliation. Complements exis',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity of the reporting institution that is party to the CSA agreement and variation margin exchange.',
    `netting_set_id` BIGINT COMMENT 'Reference to the netting set under which this variation margin is calculated. A netting set groups derivative trades that can be offset for margin purposes under a single CSA agreement.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty with whom the variation margin is exchanged.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex agreement governing the variation margin terms between counterparties.',
    `primary_variation_party_id` BIGINT COMMENT 'Reference to the central clearing house if the variation margin is for a cleared derivative transaction (e.g., LCH, CME, ICE Clear).',
    `trade_position_id` BIGINT COMMENT 'Foreign key linking to trade.trade_position. Business justification: Variation margin is calculated from mark-to-market of trade positions. Daily VM calls are driven by position-level MTM changes; collateral teams require position-level detail to explain VM movements t',
    `business_unit` STRING COMMENT 'The internal business unit or trading desk responsible for managing this variation margin relationship.',
    `calculation_agent` STRING COMMENT 'The party responsible for calculating the variation margin amount, as designated in the CSA. Typically one of the counterparties or a third-party agent.. Valid values are `reporting_party|counterparty|third_party|clearing_house`',
    `calculation_date` DATE COMMENT 'The business date on which the variation margin calculation was performed, typically based on end-of-day mark-to-market valuations.',
    `collateral_type` STRING COMMENT 'The type of collateral used to satisfy the variation margin requirement. Cash is most common for VM; some CSAs allow securities with appropriate haircuts.. Valid values are `cash|securities|government_bonds|corporate_bonds|equities|mixed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this variation margin record was first created in the system.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the variation margin calculation or settlement is under dispute between counterparties.',
    `dispute_reason` STRING COMMENT 'Description of the reason for the variation margin dispute, such as valuation disagreement, calculation error, or settlement timing issue.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the variation margin dispute was resolved and agreed upon by both counterparties.',
    `fx_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert the portfolio mark-to-market value to the variation margin settlement currency, if different.',
    `fx_rate_source` STRING COMMENT 'The source of the FX rate used for currency conversion, such as Bloomberg, Reuters, ECB reference rates, or as specified in the CSA.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to non-cash collateral to account for market risk and liquidity risk, as specified in the CSA schedule.',
    `independent_amount` DECIMAL(18,2) COMMENT 'An additional fixed margin amount required by one party independent of the mark-to-market exposure, often used for credit risk mitigation.',
    `interest_accrual_flag` BOOLEAN COMMENT 'Indicates whether interest accrues on the variation margin cash balance held, as specified in the CSA terms.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The interest rate applied to variation margin cash balances, typically based on an overnight rate such as SOFR, EONIA, or as specified in the CSA.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum amount that must be transferred when a margin call is made, as specified in the CSA. Margin calls below this amount are not executed.',
    `notes` STRING COMMENT 'Free-text field for additional comments, exceptions, or operational notes related to this variation margin settlement.',
    `notification_timestamp` TIMESTAMP COMMENT 'The timestamp when the variation margin call notification was sent to the counterparty.',
    `portfolio_mtm_value` DECIMAL(18,2) COMMENT 'The total mark-to-market value of the derivative portfolio within the netting set at the calculation date, used as the basis for variation margin calculation.',
    `previous_vm_balance` DECIMAL(18,2) COMMENT 'The cumulative variation margin balance from the previous calculation date, used to determine the incremental margin call amount.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this variation margin settlement meets the daily VM exchange requirements mandated by EMIR, Dodd-Frank, and other regulatory frameworks.',
    `regulatory_regime` STRING COMMENT 'The primary regulatory framework governing this variation margin requirement, such as EMIR (EU), Dodd-Frank (US), Basel III, or Uncleared Margin Rules.. Valid values are `emir|dodd_frank|basel_iii|mifid_ii|uncleared_margin_rules`',
    `response_deadline` TIMESTAMP COMMENT 'The deadline by which the counterparty must respond to or fulfill the variation margin call, as specified in the CSA.',
    `rounding_amount` DECIMAL(18,2) COMMENT 'The rounding increment specified in the CSA for variation margin calculations, typically rounding to the nearest specified amount (e.g., $100,000).',
    `settlement_date` DATE COMMENT 'The date on which the variation margin cash flow is scheduled to be settled between counterparties, typically T+1 for cleared derivatives and as per CSA terms for bilateral trades.',
    `settlement_method` STRING COMMENT 'The payment mechanism used to settle the variation margin, such as wire transfer, ACH, RTGS, SWIFT, or through a central clearing house.. Valid values are `wire_transfer|ach|rtgs|swift|internal_transfer|clearing_house`',
    `settlement_status` STRING COMMENT 'Current status of the variation margin settlement process. Tracks whether the margin call has been fulfilled, is pending, or encountered issues.. Valid values are `pending|settled|failed|disputed|cancelled|partially_settled`',
    `settlement_timestamp` TIMESTAMP COMMENT 'The actual timestamp when the variation margin settlement was completed and cash was transferred.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The threshold amount specified in the CSA below which variation margin is not called. Only exposure exceeding this threshold triggers a margin call.',
    `trade_population_count` STRING COMMENT 'The number of derivative trades included in the netting set for this variation margin calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this variation margin record was last updated in the system.',
    `valuation_source` STRING COMMENT 'The source of the mark-to-market valuation used for variation margin calculation, such as internal pricing model, third-party vendor, exchange settlement prices, or counterparty-provided valuations.. Valid values are `internal_model|vendor_pricing|exchange_settlement|counterparty_valuation|consensus_pricing`',
    `valuation_timestamp` TIMESTAMP COMMENT 'The precise timestamp at which the mark-to-market valuation was captured for variation margin calculation.',
    `vm_amount` DECIMAL(18,2) COMMENT 'The calculated variation margin amount to be exchanged. Positive values indicate amounts receivable by the reporting entity; negative values indicate amounts payable.',
    `vm_direction` STRING COMMENT 'Indicates whether the reporting entity is paying or receiving the variation margin. Pay indicates cash outflow; receive indicates cash inflow.. Valid values are `pay|receive`',
    CONSTRAINT pk_variation_margin PRIMARY KEY(`variation_margin_id`)
) COMMENT 'Daily variation margin (VM) settlement record capturing the mark-to-market cash flows exchanged between counterparties under CSA and cleared derivative arrangements. Captures VM calculation date, VM amount (pay/receive), settlement currency, settlement date, settlement status, netting set reference, and regulatory compliance flag (EMIR, Dodd-Frank daily VM requirement). Provides the audit trail for daily VM settlement and regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`optimization` (
    `optimization_id` BIGINT COMMENT 'Unique identifier for the collateral optimization allocation record.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Optimization algorithms audited for allocation logic accuracy, HQLA treatment correctness, funding cost calculation, and RWA reduction validation. Model risk and treasury management audit scope.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the specific collateral asset being allocated in this optimization decision.',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Collateral optimization decisions (allocation algorithms, substitution approvals, cost calculations) are subject to SOX controls over model governance, parameter approval, and override authorization. ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Collateral optimization decisions have P&L impact (funding cost, opportunity cost) allocated to specific cost centers. Required for management accounting, cost allocation, profitability analysis, and ',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for the allocated market value.',
    `party_id` BIGINT COMMENT 'Reference to the custodian or third-party agent holding the allocated collateral on behalf of the secured party.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Collateral optimization allocates fund holdings to meet margin/collateral requirements efficiently. Business process: cheapest-to-deliver selection from fund portfolios, HQLA optimization for regulato',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: Optimization decisions apply haircut schedules to calculate net collateral value. The optimization product currently has haircut_percentage as a denormalized value. Adding haircut_schedule_id FK allow',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Optimization algorithms select securities based on HQLA classification, haircuts, funding costs, and opportunity costs. Requires instrument master data for eligibility screening and cost-benefit analy',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the ISDA CSA agreement governing this collateral allocation, if applicable to derivatives margin.',
    `obligation_id` BIGINT COMMENT 'Reference to the specific obligation (margin agreement, pledge, repo transaction) that this collateral allocation satisfies.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Collateral allocation optimization considers stress scenarios to ensure resilience. Treasury optimizes collateral usage balancing funding costs with stress liquidity needs. Links optimization decision',
    `allocated_haircut_value` DECIMAL(18,2) COMMENT 'Eligible collateral value after applying the haircut, representing the net contribution to the obligation coverage.',
    `allocated_market_value` DECIMAL(18,2) COMMENT 'Market value of the allocated collateral quantity at the time of allocation, before haircut application.',
    `allocation_cost` DECIMAL(18,2) COMMENT 'Estimated cost of allocating this collateral, including opportunity cost, funding cost, and operational cost.',
    `allocation_cost_currency` STRING COMMENT 'Three-letter ISO currency code for the allocation cost.. Valid values are `^[A-Z]{3}$`',
    `allocation_effective_date` DATE COMMENT 'Date on which this collateral allocation becomes effective and the collateral is legally pledged or transferred.',
    `allocation_expiry_date` DATE COMMENT 'Date on which this collateral allocation expires or is scheduled for release, if applicable.',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments regarding this specific collateral allocation decision, including any exceptions or special conditions.',
    `allocation_priority_rank` STRING COMMENT 'Priority ranking assigned by the optimization algorithm, with lower numbers indicating higher priority for allocation.',
    `allocation_quantity` DECIMAL(18,2) COMMENT 'Quantity of the collateral asset allocated to satisfy the obligation, expressed in the assets native unit of measure.',
    `allocation_sequence` STRING COMMENT 'Sequential order of this allocation within the optimization run, indicating priority ranking.',
    `allocation_status` STRING COMMENT 'Current status of this allocation decision in the collateral management workflow.. Valid values are `proposed|approved|allocated|rejected|reversed`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Date and time when this allocation decision was made by the optimization engine.',
    `allocation_unit` STRING COMMENT 'Unit of measure for the allocated quantity (shares for equities, nominal value for bonds, troy ounces for gold, etc.). [ENUM-REF-CANDIDATE: shares|units|nominal_value|face_value|troy_ounces|kilograms|contracts — 7 candidates stripped; promote to reference product]',
    `concentration_limit_breach_flag` BOOLEAN COMMENT 'Indicates whether this allocation breaches concentration limits defined in the CSA or internal risk policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collateral optimization allocation record was first created in the system.',
    `funding_cost` DECIMAL(18,2) COMMENT 'Funding cost associated with holding or acquiring this collateral for allocation purposes.',
    `hqla_category` STRING COMMENT 'Classification of the allocated collateral under Basel III HQLA categories (Level 1, Level 2A, Level 2B, or non-HQLA).. Valid values are `level_1|level_2a|level_2b|non_hqla`',
    `hqla_eligible_flag` BOOLEAN COMMENT 'Indicates whether this allocation satisfies a regulatory High-Quality Liquid Asset (HQLA) requirement under Basel III Liquidity Coverage Ratio (LCR) rules.',
    `initial_margin_flag` BOOLEAN COMMENT 'Indicates whether this allocation satisfies an initial margin requirement under derivatives margin rules.',
    `net_collateral_contribution` DECIMAL(18,2) COMMENT 'Net value contributed by this allocation toward satisfying the obligation requirement, after all adjustments including haircut and concentration limits.',
    `opportunity_cost` DECIMAL(18,2) COMMENT 'Opportunity cost of allocating this collateral asset instead of using it for alternative purposes or investments.',
    `optimization_run_code` BIGINT COMMENT 'Reference to the parent optimization run that generated this allocation decision.',
    `regulatory_capital_relief_amount` DECIMAL(18,2) COMMENT 'Amount of regulatory capital relief obtained through this collateral allocation under Basel III rules.',
    `repo_eligible_flag` BOOLEAN COMMENT 'Indicates whether this allocation is eligible for use in repurchase (repo) or reverse repo transactions.',
    `rwa_reduction_amount` DECIMAL(18,2) COMMENT 'Reduction in Risk-Weighted Assets (RWA) achieved through this collateral allocation under Basel III capital rules.',
    `score` DECIMAL(18,2) COMMENT 'Numerical score assigned by the optimization algorithm reflecting the efficiency and cost-effectiveness of this allocation decision.',
    `substitution_eligible_flag` BOOLEAN COMMENT 'Indicates whether this allocated collateral is eligible for substitution under the governing agreement terms.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this collateral optimization allocation record was last updated in the system.',
    `valuation_date` DATE COMMENT 'Date on which the collateral asset was valued for the purpose of this allocation decision.',
    `valuation_method` STRING COMMENT 'Method used to determine the market value of the allocated collateral asset.. Valid values are `mark_to_market|mark_to_model|third_party_pricing|internal_model`',
    `variation_margin_flag` BOOLEAN COMMENT 'Indicates whether this allocation satisfies a variation margin requirement under derivatives margin rules.',
    CONSTRAINT pk_optimization PRIMARY KEY(`optimization_id`)
) COMMENT 'Granular record of each individual collateral asset allocation decision within an optimization run, mapping a specific collateral asset to a specific obligation (margin agreement, pledge, repo). Captures allocated quantity, allocated market value, allocated haircut value, net collateral contribution, allocation priority rank, and whether the allocation satisfies a regulatory HQLA requirement. Provides the line-item detail supporting the optimization run summary.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`lien_filing` (
    `lien_filing_id` BIGINT COMMENT 'Unique identifier for the lien filing record. Primary key for the lien filing entity.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: UCC lien filings audited for perfection compliance, continuation filing timeliness, termination accuracy, and legal enforceability. Critical for secured lending legal risk and regulatory capital relie',
    `collateral_pledge_id` BIGINT COMMENT 'Reference to the collateral pledge that this lien filing legally perfects.',
    `employee_id` BIGINT COMMENT 'Reference to the credit administration officer responsible for monitoring this lien filing and ensuring timely continuation or termination.',
    `party_id` BIGINT COMMENT 'Reference to the internal party identifier for the secured party (typically the bank or lending entity).',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Examiners verify lien perfection by sampling UCC filings for completeness, timeliness, and continuation. Exam workpapers reference specific filings reviewed. Perfection deficiencies are common exam fi',
    `amendment_count` STRING COMMENT 'The number of UCC-3 amendments filed against this lien filing record.',
    `collateral_classification` STRING COMMENT 'The UCC or PPSA classification of the collateral type (e.g., inventory, equipment, accounts, general intangibles, farm products, consumer goods).',
    `collateral_description` STRING COMMENT 'Detailed description of the collateral covered by this lien filing, as recorded in the filing document (e.g., all inventory, equipment, accounts receivable, specific property description).',
    `continuation_due_date` DATE COMMENT 'The date by which a continuation filing (UCC-3 continuation) must be filed to maintain perfection (typically within 6 months before expiry).',
    `continuation_filed_date` DATE COMMENT 'The date on which a continuation filing was submitted to extend the lien perfection period.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this lien filing record was first created in the system.',
    `debtor_address` STRING COMMENT 'The legal address of the debtor as recorded on the lien filing.',
    `debtor_name` STRING COMMENT 'The legal name of the debtor (borrower or obligor) against whom the lien is filed.',
    `expiry_date` DATE COMMENT 'The date on which the lien filing will lapse or expire if not continued (typically 5 years from filing date for UCC filings).',
    `filing_authority` STRING COMMENT 'The name of the government agency or registry office that accepted and recorded the lien filing (e.g., Delaware Secretary of State, Ontario Personal Property Security Registration, Companies House).',
    `filing_date` DATE COMMENT 'The date on which the lien filing was submitted to and accepted by the filing authority. This is the date of legal perfection.',
    `filing_document_reference` STRING COMMENT 'Reference to the physical or electronic filing document stored in the document management system.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'The fee paid to the filing authority to record this lien filing.',
    `filing_fee_currency` STRING COMMENT 'The currency in which the filing fee was paid, in ISO 4217 three-letter code format (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `filing_jurisdiction` STRING COMMENT 'The legal jurisdiction (state, province, country) where the lien filing was registered (e.g., Delaware, Ontario, England and Wales).',
    `filing_notes` STRING COMMENT 'Free-text notes or comments regarding this lien filing, including special instructions, exceptions, or historical context.',
    `filing_reference_number` STRING COMMENT 'The externally-known unique filing number or registration number assigned by the filing authority (e.g., UCC filing number, mortgage registration number, charge registration number).',
    `filing_status` STRING COMMENT 'Current lifecycle status of the lien filing (active, expired, terminated, pending, rejected, lapsed).. Valid values are `Active|Expired|Terminated|Pending|Rejected|Lapsed`',
    `filing_type` STRING COMMENT 'The type of lien filing or perfection action taken (e.g., UCC-1 initial financing statement, UCC-3 amendment, mortgage registration, PPSA filing). [ENUM-REF-CANDIDATE: UCC-1|UCC-3 Amendment|UCC-3 Continuation|UCC-3 Termination|Mortgage Registration|Charge Registration|PPSA Filing|Security Agreement|Pledge Agreement|Other — 10 candidates stripped; promote to reference product]',
    `last_amendment_date` DATE COMMENT 'The date of the most recent UCC-3 amendment filed against this lien filing.',
    `legal_enforceability_flag` BOOLEAN COMMENT 'Indicates whether the lien filing is currently legally enforceable (true) or has lapsed/expired/been terminated (false).',
    `lien_priority_rank` STRING COMMENT 'The priority ranking of this lien relative to other liens on the same collateral (1 = first lien, 2 = second lien, etc.). Lower numbers indicate higher priority.',
    `original_filing_date` DATE COMMENT 'The date of the original UCC-1 or initial filing, used to establish priority. For continuation or amendment filings, this preserves the original perfection date.',
    `perfection_method` STRING COMMENT 'The method by which the security interest was perfected (filing, possession, control, automatic perfection, temporary perfection).. Valid values are `Filing|Possession|Control|Automatic|Temporary`',
    `regulatory_capital_relief_flag` BOOLEAN COMMENT 'Indicates whether this perfected lien filing qualifies the collateral for regulatory capital relief under Basel III Risk-Weighted Asset (RWA) calculations.',
    `termination_date` DATE COMMENT 'The date on which the lien filing was terminated (UCC-3 termination filed), releasing the security interest.',
    `termination_reason` STRING COMMENT 'The business reason for terminating the lien filing (e.g., loan paid off, collateral released, refinanced, error correction).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this lien filing record was last modified in the system.',
    CONSTRAINT pk_lien_filing PRIMARY KEY(`lien_filing_id`)
) COMMENT 'Legal perfection record tracking UCC financing statement filings (UCC-1, UCC-3 amendments), mortgage registrations, charge registrations, PPSA filings (Canada), and other lien perfection actions taken to legally secure collateral interests. Captures filing jurisdiction, filing date, filing number, filing type, secured party, debtor, collateral description, expiry date, continuation filing schedule, amendment history, and termination status. Critical for legal enforceability of collateral in default and insolvency scenarios. Supports the credit administration teams perfection monitoring and renewal workflow.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`review` (
    `review_id` BIGINT COMMENT 'Unique identifier for the collateral review event. Primary key for the collateral review record.',
    `employee_id` BIGINT COMMENT 'Reference to the senior credit officer or risk manager who approved the review. Identifies the authority who validated the review findings.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Periodic collateral reviews are audit evidence and themselves audited for trigger event accuracy, LTV ratio calculation, coverage shortfall identification, and recommended action appropriateness. Cred',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the specific collateral asset being reviewed. Identifies the underlying asset subject to revaluation.',
    `collateral_pledge_id` BIGINT COMMENT 'Reference to the collateral pledge being reviewed. Links this review to the specific pledge arrangement under evaluation.',
    `credit_exposure_id` BIGINT COMMENT 'Reference to the credit exposure secured by the collateral. Links the review to the underlying lending or derivative exposure.',
    `review_employee_id` BIGINT COMMENT 'Reference to the credit officer or risk analyst who conducted the review. Identifies the responsible party for the review assessment.',
    `party_id` BIGINT COMMENT 'Reference to the borrower or counterparty whose obligation is secured by the collateral. Identifies the party whose credit exposure is being reviewed.',
    `review_secured_party_id` BIGINT COMMENT 'Reference to the lender or secured party holding the collateral interest. Identifies the bank or entity whose interest is protected by the collateral.',
    `action_rationale` STRING COMMENT 'Detailed explanation of the rationale for the recommended action. Captures the credit risk assessment and business justification for the proposed remediation.',
    `actual_collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'Actual collateral coverage ratio calculated at the time of review. Represents the eligible collateral value divided by the outstanding exposure, expressed as a percentage.',
    `approval_date` DATE COMMENT 'Date when the review was approved by the designated authority. Represents the formal validation timestamp for the review conclusions.',
    `approval_status` STRING COMMENT 'Approval status of the review findings and recommended actions. Indicates whether the review conclusions have been validated by senior credit authority.. Valid values are `pending|approved|rejected|conditional_approval`',
    `collateral_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the collateral valuation. Identifies the denomination currency of the collateral asset value.. Valid values are `^[A-Z]{3}$`',
    `collateral_market_value` DECIMAL(18,2) COMMENT 'Current market value of the collateral asset at the time of review. Represents the fair market value before application of haircuts.',
    `covenant_compliance_flag` BOOLEAN COMMENT 'Indicates whether the collateral coverage meets all covenant requirements at the time of review. True if compliant, false if in breach.',
    `coverage_excess_amount` DECIMAL(18,2) COMMENT 'Amount by which the actual collateral coverage exceeds the required coverage. Represents the surplus collateral value that may be eligible for release or substitution.',
    `coverage_shortfall_amount` DECIMAL(18,2) COMMENT 'Amount by which the actual collateral coverage falls short of the required coverage. Represents the additional collateral value needed to meet covenant requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral review record was first created in the system. Supports audit trail and data lineage tracking.',
    `department` STRING COMMENT 'Department or business unit responsible for conducting the review. Identifies the organizational unit performing the collateral assessment.',
    `eligible_collateral_value` DECIMAL(18,2) COMMENT 'Collateral value after application of haircut. Represents the amount of collateral value recognized for credit risk mitigation purposes.',
    `exposure_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the outstanding exposure. Identifies the denomination currency of the credit exposure.. Valid values are `^[A-Z]{3}$`',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the collateral market value to determine eligible collateral value. Reflects the risk adjustment for asset volatility and liquidity.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-value ratio calculated at the time of review. Represents the outstanding exposure divided by the eligible collateral value, expressed as a percentage.',
    `margin_call_amount` DECIMAL(18,2) COMMENT 'Amount of additional collateral required if a margin call is recommended. Represents the value of collateral that must be posted to restore adequate coverage.',
    `margin_call_due_date` DATE COMMENT 'Date by which the margin call must be satisfied. Represents the deadline for the obligor to post additional collateral.',
    `next_scheduled_review_date` DATE COMMENT 'Date when the next scheduled collateral review is due. Supports proactive collateral monitoring and review planning.',
    `notes` STRING COMMENT 'Free-text notes and observations from the review. Captures qualitative assessments, risk factors, and additional context not captured in structured fields.',
    `outstanding_exposure_amount` DECIMAL(18,2) COMMENT 'Total credit exposure amount outstanding at the time of review. Represents the principal, accrued interest, and fees owed by the obligor.',
    `prior_ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-value ratio from the previous review. Enables trend analysis of collateral coverage deterioration or improvement.',
    `prior_review_date` DATE COMMENT 'Date of the previous collateral review. Provides historical context for tracking changes in collateral adequacy over time.',
    `recommended_action` STRING COMMENT 'Recommended remediation action based on the review findings. Indicates the next step required to address any collateral adequacy issues or optimize collateral usage. [ENUM-REF-CANDIDATE: no_action|margin_call|top_up_required|substitution|partial_release|full_release|covenant_waiver|exposure_reduction — 8 candidates stripped; promote to reference product]',
    `reference_number` STRING COMMENT 'Business identifier for the collateral review event. Externally visible reference number used in communications and reporting.. Valid values are `^CR-[0-9]{8}-[A-Z0-9]{6}$`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this review event must be included in regulatory reporting. True if the review findings trigger regulatory disclosure requirements.',
    `required_collateral_coverage_ratio` DECIMAL(18,2) COMMENT 'Minimum collateral coverage ratio required by the credit agreement or regulatory framework. Represents the threshold below which a margin call or remediation is triggered.',
    `review_date` DATE COMMENT 'Date when the collateral review was conducted. Represents the business event date for the review activity.',
    `review_status` STRING COMMENT 'Current lifecycle status of the collateral review. Tracks the review through its workflow from initiation to completion. [ENUM-REF-CANDIDATE: initiated|in_progress|pending_approval|approved|rejected|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `review_type` STRING COMMENT 'Classification of the review event. Indicates whether the review was scheduled (annual, quarterly) or triggered by a specific event (covenant breach, credit deterioration). [ENUM-REF-CANDIDATE: annual|semi_annual|quarterly|triggered|covenant_breach|credit_event|ad_hoc — 7 candidates stripped; promote to reference product]',
    `reviewer_name` STRING COMMENT 'Full name of the credit officer or risk analyst who conducted the review. Provides human-readable identification of the reviewer.',
    `trigger_event` STRING COMMENT 'Description of the event that triggered the review, if applicable. Captures the specific covenant breach, credit rating downgrade, or market event that necessitated the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral review record was last modified. Tracks the most recent change to the review data for audit and reconciliation purposes.',
    `valuation_method` STRING COMMENT 'Method used to determine the collateral market value during the review. Indicates the valuation approach applied to assess the current worth of the collateral asset.. Valid values are `mark_to_market|appraisal|model_based|third_party_valuation|index_based`',
    `valuation_source` STRING COMMENT 'Source of the collateral valuation data. Identifies the pricing service, appraiser, or market data provider used for the valuation.',
    CONSTRAINT pk_review PRIMARY KEY(`review_id`)
) COMMENT 'Periodic collateral review and revaluation event record for secured lending portfolios, capturing scheduled and triggered reviews of collateral adequacy. Captures review date, review type (annual, triggered, covenant breach), reviewer, LTV ratio at review, required collateral coverage, actual collateral coverage, coverage shortfall, recommended action (top-up call, substitution, release), and approval status. Supports credit risk management and covenant monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`netting_set` (
    `netting_set_id` BIGINT COMMENT 'Unique identifier for the netting set. Primary key for the netting set master record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Governing law jurisdiction determines netting enforceability and regulatory capital recognition. Creating governing_law_jurisdiction_country_id FK to replace jurisdiction code.',
    `isda_master_agreement_id` BIGINT COMMENT 'Reference to the governing ISDA Master Agreement under which this netting set is established. Links to the master agreement that defines the legal framework for close-out netting.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Counterparty LEI is required for netting opinion validation and regulatory reporting. Creating new counterparty_lei FK.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty with whom the netting set is established. All derivative transactions within this netting set are with this single counterparty.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the Credit Support Annex (CSA) agreement that governs collateral posting and margin requirements for this netting set. Links to the collateral management framework.',
    `primary_netting_custodian_party_id` BIGINT COMMENT 'Reference to the third-party custodian holding segregated initial margin collateral for this netting set, if segregation is required.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`transfer` (
    `transfer_id` BIGINT COMMENT 'Unique identifier for the collateral transfer settlement instruction and confirmation record.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Transfer processes audited for settlement accuracy, SWIFT instruction compliance, segregation status validation, and UMR regulatory reporting. Operational risk and settlement process audit scope.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the specific collateral asset being transferred.',
    `collateral_margin_call_id` BIGINT COMMENT 'Reference to the margin call that triggered this collateral transfer, if applicable.',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Failed or late collateral transfers violate CSA terms and regulatory settlement requirements (EMIR, UMR). Breach records track settlement failures for regulatory reporting and remediation.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code in which the settlement amount is denominated.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Transfer instructions require instrument identifiers (ISIN, CUSIP, SEDOL) for settlement system routing and custodian processing. Essential for margin call settlement and collateral movement tracking.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Physical collateral movements trigger accounting entries (debit/credit collateral accounts, settlement entries). Required for daily settlement accounting, nostro reconciliation, and audit trail linkin',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex agreement governing this collateral transfer.',
    `pledge_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge_agreement. Business justification: Collateral transfers can occur under pledge agreements (secured lending collateral movements). The existing margin_agreement_id and proposed repo_agreement_id cover other transfer types. This FK compl',
    `party_id` BIGINT COMMENT 'Reference to the custodian bank or depository that will hold the collateral on behalf of the receiving party after settlement.',
    `receiving_party_id` BIGINT COMMENT 'Reference to the legal entity or counterparty receiving the collateral in this transfer.',
    `repo_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.repo_agreement. Business justification: Collateral transfers can occur under repo agreements (near-leg and far-leg settlement). The existing margin_agreement_id covers margin-based transfers, but repo transfers need their own agreement refe',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every collateral transfer must be screened against OFAC/EU sanctions lists in real-time before settlement. Regulatory mandate. The screening event must reference the specific transfer to support block',
    `sending_party_id` BIGINT COMMENT 'Reference to the legal entity or counterparty delivering the collateral in this transfer.',
    `substitution_id` BIGINT COMMENT 'Reference to the collateral substitution request that initiated this transfer, if applicable.',
    `transfer_party_id` BIGINT COMMENT 'Reference to the custodian bank or depository holding the collateral on behalf of the sending party.',
    `asset_type` STRING COMMENT 'Classification of the collateral asset being transferred: cash, government bond, corporate bond, equity, mortgage-backed securities (MBS), asset-backed securities (ABS), collateralized loan obligation (CLO), collateralized debt obligation (CDO), or other security. [ENUM-REF-CANDIDATE: cash|government_bond|corporate_bond|equity|mbs|abs|clo|cdo|other_security — 9 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Explanation or code describing why the collateral transfer was cancelled before settlement (e.g., margin call withdrawn, substitution declined, operational error).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this collateral transfer record was first created in the system.',
    `direction` STRING COMMENT 'Direction of the collateral movement from the perspective of the reporting entity: inbound (receiving collateral) or outbound (delivering collateral).. Valid values are `inbound|outbound`',
    `eligible_collateral_value` DECIMAL(18,2) COMMENT 'Post-haircut value of the transferred collateral that counts toward margin or credit exposure coverage, calculated as valuation amount minus haircut.',
    `failure_reason` STRING COMMENT 'Explanation or code describing why the collateral transfer failed to settle, if applicable (e.g., insufficient assets, account mismatch, system error, counterparty rejection).',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the market value of the collateral to determine its eligible collateral value, reflecting credit and liquidity risk.',
    `margin_type` STRING COMMENT 'Classification of the margin obligation this transfer satisfies: initial margin (IM), variation margin (VM), or independent amount (IA).. Valid values are `initial_margin|variation_margin|independent_amount`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, or comments related to the collateral transfer.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the asset being transferred, expressed in units appropriate to the asset type (number of securities, nominal amount for bonds, face value for cash).',
    `reason` STRING COMMENT 'Business rationale or trigger for the collateral transfer, such as margin call satisfaction, substitution request, portfolio rebalancing, or contractual obligation.',
    `receiving_account_number` STRING COMMENT 'Custodian account number or securities account identifier to which the collateral is being transferred.',
    `reference_number` STRING COMMENT 'External business reference number for the collateral transfer, used for operational tracking and reconciliation.',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory regime governing this collateral transfer: Uncleared Margin Rules (UMR), European Market Infrastructure Regulation (EMIR), Dodd-Frank, Basel III, or other jurisdiction-specific requirements. [ENUM-REF-CANDIDATE: umr|emir|dodd_frank|basel_iii|mifid_ii|sftr|cftc|sec|pra|eba — promote to reference product]',
    `rehypothecation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the receiving party is permitted to rehypothecate (reuse) the transferred collateral for their own purposes under the CSA agreement.',
    `segregation_status` STRING COMMENT 'Indicates whether the transferred collateral is held in a segregated account (isolated from other assets), unsegregated (commingled), or partially segregated.. Valid values are `segregated|unsegregated|partially_segregated`',
    `sending_account_number` STRING COMMENT 'Custodian account number or securities account identifier from which the collateral is being transferred.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary value of the collateral transfer at settlement, representing the market value or agreed valuation of the transferred asset.',
    `settlement_confirmation_reference` STRING COMMENT 'Reference number or identifier provided by the custodian or settlement system confirming successful completion of the transfer.',
    `settlement_confirmation_status` STRING COMMENT 'Status of settlement confirmation from the custodian or counterparty: confirmed (both parties agree), pending (awaiting confirmation), unconfirmed (no response), mismatched (discrepancy), or rejected (declined).. Valid values are `confirmed|pending|unconfirmed|mismatched|rejected`',
    `settlement_date` DATE COMMENT 'Expected or actual date on which the collateral transfer settles and ownership/title transfers.',
    `settlement_method` STRING COMMENT 'Mechanism used to settle the collateral transfer: delivery versus payment (DVP), free of payment (FOP), real-time gross settlement (RTGS), automated clearing house (ACH), wire transfer, or internal book transfer.. Valid values are `dvp|fop|rtgs|ach|wire|book_transfer`',
    `settlement_system` STRING COMMENT 'Name or identifier of the settlement infrastructure or clearing system used to execute the transfer (e.g., Fedwire, SWIFT, DTC, Euroclear, Clearstream).',
    `settlement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the collateral transfer was confirmed as settled by the custodian or settlement system.',
    `swift_instruction_reference` STRING COMMENT 'Unique SWIFT message reference number assigned to the settlement instruction for tracking and reconciliation.',
    `swift_message_type` STRING COMMENT 'SWIFT message type code used for the settlement instruction (e.g., MT540 for receive free, MT541 for receive against payment, MT542 for deliver free, MT543 for deliver against payment).',
    `title_transfer_flag` BOOLEAN COMMENT 'Indicates whether this transfer involves a full title transfer (ownership change) or a security interest (lien without ownership transfer).',
    `transfer_date` DATE COMMENT 'Business date on which the collateral transfer was initiated or instructed.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the collateral transfer: pending (awaiting instruction), instructed (sent to custodian), in_transit (processing), settled (completed), failed (unsuccessful), cancelled (withdrawn), or rejected (declined by counterparty). [ENUM-REF-CANDIDATE: pending|instructed|in_transit|settled|failed|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the collateral transfer action: delivery (initial pledge), return (release), substitution (exchange), recall (demand back), rebalancing (portfolio adjustment), or adjustment (correction).. Valid values are `delivery|return|substitution|recall|rebalancing|adjustment`',
    `umr_compliance_flag` BOOLEAN COMMENT 'Indicates whether this collateral transfer is subject to and compliant with Uncleared Margin Rules for non-cleared derivatives.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this collateral transfer record was last modified.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Market valuation of the transferred collateral at the time of transfer instruction, used for margin calculation and exposure management.',
    CONSTRAINT pk_transfer PRIMARY KEY(`transfer_id`)
) COMMENT 'Settlement instruction and confirmation record for physical collateral movements — cash transfers, securities deliveries, and title transfers executed to satisfy margin calls, pledge obligations, or substitution requests. Captures transfer date, transfer type (delivery, return, substitution), asset transferred, quantity, settlement amount, settlement currency, sending custodian, receiving custodian, SWIFT/RTGS instruction reference, and settlement confirmation status.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`concentration_limit` (
    `concentration_limit_id` BIGINT COMMENT 'Unique identifier for the concentration limit record. Primary key for the concentration limit reference data.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Concentration limits audited for breach monitoring effectiveness, regulatory framework alignment, override control testing, and reporting accuracy. Risk management and regulatory compliance audit scop',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Concentration limits operationalize regulatory obligations (large exposure rules, single-name limits, wrong-way risk). Each limit implements a specific regulatory citation (CRR, Basel III) and complia',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the absolute threshold amount. Required when threshold is expressed in monetary terms.',
    `industry_code_id` BIGINT COMMENT 'Industry sector classification when the concentration limit applies to sector exposure. Used for sector-level concentration constraints.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to specific CSA agreement when the concentration limit applies to a particular bilateral collateral arrangement.',
    `applicable_margin_type` STRING COMMENT 'Type of margin calculation to which this concentration limit applies. Distinguishes between initial margin and variation margin constraints.. Valid values are `initial_margin|variation_margin|both|not_applicable`',
    `approval_authority` STRING COMMENT 'Name or identifier of the governance body or individual who approved this concentration limit rule. Establishes accountability for limit setting.',
    `approval_date` DATE COMMENT 'Date when the concentration limit rule was formally approved by the designated authority.',
    `arrangement_scope` STRING COMMENT 'Defines the scope of collateral arrangements to which this concentration limit applies. Determines whether the limit is global or specific to certain transaction types.. Valid values are `all_arrangements|csa_only|repo_only|secured_lending_only|specific_agreement`',
    `asset_class` STRING COMMENT 'Asset class to which this concentration limit applies. Defines the scope of collateral assets subject to this limit rule.',
    `breach_action` STRING COMMENT 'Automated or manual action to be taken when the concentration limit is breached. Defines the operational response to limit violations.. Valid values are `hard_stop|soft_warning|escalation|auto_rebalance|manual_review`',
    `breach_tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable tolerance buffer above the threshold before breach action is triggered. Provides operational flexibility for minor exceedances.',
    `counterparty_identifier` STRING COMMENT 'Unique identifier of the counterparty when the concentration limit applies to counterparty exposure. Used for counterparty-level concentration constraints.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the concentration limit record was first created in the system. Supports audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date from which the concentration limit becomes active and enforceable in collateral management operations.',
    `expiry_date` DATE COMMENT 'Date on which the concentration limit ceases to be active. Nullable for limits with indefinite duration.',
    `hqla_classification` STRING COMMENT 'HQLA classification level when the concentration limit applies to liquidity coverage ratio eligible collateral. Used for LCR compliance.. Valid values are `level_1|level_2a|level_2b|non_hqla`',
    `issuer_identifier` STRING COMMENT 'Unique identifier of the issuer entity when the concentration limit applies to a specific issuer. Used for issuer-level concentration constraints.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166 country code when the concentration limit applies to geographic exposure. Used for jurisdiction-level concentration constraints.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the concentration limit record was most recently updated. Tracks the recency of limit rule changes.',
    `last_review_date` DATE COMMENT 'Date when the concentration limit was most recently reviewed by risk management or governance authority.',
    `limit_code` STRING COMMENT 'Business identifier code for the concentration limit rule. Used for external reference and reporting purposes.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `limit_description` STRING COMMENT 'Detailed textual description of the concentration limit rule, including business rationale, scope, and any special conditions or exceptions.',
    `limit_name` STRING COMMENT 'Descriptive name of the concentration limit rule for business user identification and reporting.',
    `limit_status` STRING COMMENT 'Current lifecycle status of the concentration limit rule. Indicates whether the limit is currently enforced in collateral management operations.. Valid values are `active|inactive|suspended|pending_approval|expired`',
    `limit_type` STRING COMMENT 'Classification of the concentration limit by the dimension being constrained. Determines what aspect of the collateral portfolio is being limited to prevent over-reliance.. Valid values are `issuer_concentration|asset_class_concentration|currency_concentration|counterparty_concentration|geographic_concentration|sector_concentration`',
    `modified_by_user` STRING COMMENT 'Identifier of the user or system process that last modified the concentration limit record. Establishes accountability for changes.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which compliance with this concentration limit is monitored and reported. Determines operational surveillance cadence.. Valid values are `real_time|intraday|daily|weekly`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the concentration limit rule.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether authorized users can override this concentration limit under exceptional circumstances. Controls operational flexibility.',
    `override_approval_level` STRING COMMENT 'Required approval authority level for overriding this concentration limit. Defines escalation path for limit exceptions.',
    `priority_rank` STRING COMMENT 'Numeric priority ranking when multiple concentration limits may apply to the same collateral. Lower numbers indicate higher priority in conflict resolution.',
    `regulatory_framework` STRING COMMENT 'Regulatory or policy framework that mandates or informs this concentration limit. Indicates the source authority for the limit rule.. Valid values are `basel_iii|dodd_frank|emir|ucits|aifmd|internal_policy`',
    `reporting_line` STRING COMMENT 'Business unit or reporting line responsible for monitoring and managing compliance with this concentration limit.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for periodic review and validation of the concentration limit rule. Ensures limits remain appropriate for current risk environment.. Valid values are `daily|weekly|monthly|quarterly|annually|ad_hoc`',
    `threshold_absolute_amount` DECIMAL(18,2) COMMENT 'Maximum allowable concentration expressed as an absolute monetary amount. Used when limit is defined as a fixed value rather than percentage.',
    `threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable concentration expressed as a percentage of total collateral portfolio value. Used when limit is defined as a relative measure.',
    `umr_phase` STRING COMMENT 'Phase of the Uncleared Margin Rules implementation schedule to which this limit applies. Relevant for phased regulatory compliance.',
    `version_number` STRING COMMENT 'Version number of the concentration limit rule. Incremented with each amendment to maintain audit trail of limit changes.',
    CONSTRAINT pk_concentration_limit PRIMARY KEY(`concentration_limit_id`)
) COMMENT 'Reference record defining concentration limits on collateral portfolios to prevent over-reliance on a single issuer, asset class, currency, or counterparty. Captures limit type (issuer concentration, asset class concentration, currency concentration), limit threshold (percentage or absolute amount), applicable arrangement scope, regulatory basis (Basel III, internal credit policy), breach action (hard stop, soft warning), and effective/expiry dates.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` (
    `collateral_lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event',
    `employee_id` BIGINT COMMENT 'Identifier of the senior officer or manager who approved the recommended action for this collateral lifecycle event.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Lifecycle events audited for trigger accuracy, action timeliness, coverage shortfall response, and regulatory reporting completeness. Operational risk and collateral management process audit scope.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset affected by this lifecycle event.',
    `collateral_pledge_id` BIGINT COMMENT 'Reference to the collateral pledge arrangement associated with this event, if applicable.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Collateral lifecycle events (corporate actions, maturity events, rating changes) can occur under margin agreements. The existing pledge_agreement_id is too narrow - it only covers secured lending even',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA CSA agreement governing the collateral arrangement affected by this event.',
    `primary_collateral_employee_id` BIGINT COMMENT 'Identifier of the collateral desk analyst or risk officer who reviewed this lifecycle event and determined the recommended action.',
    `repo_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.repo_agreement. Business justification: Collateral lifecycle events can occur under repo agreements (e.g., coupon payments on repo collateral, substitution events). The existing pledge_agreement_id only covers secured lending. Adding repo_a',
    `action_completion_date` DATE COMMENT 'The date on which the action in response to this event was completed and closed.',
    `action_deadline_date` DATE COMMENT 'The deadline date by which the recommended action must be completed to maintain compliance or mitigate risk.',
    `action_taken` STRING COMMENT 'Description of the actual action taken in response to this collateral lifecycle event, including any deviations from the recommended action.',
    `actual_collateral_coverage` DECIMAL(18,2) COMMENT 'The actual collateral value available at the time of this event, after applying haircuts and eligibility adjustments.',
    `approval_date` DATE COMMENT 'The date on which the recommended action for this collateral lifecycle event was formally approved.',
    `approval_status` STRING COMMENT 'Status indicating whether the recommended action or resolution for this event has been approved by the appropriate authority.. Valid values are `pending|approved|rejected|conditional`',
    `approver_name` STRING COMMENT 'Full name of the individual who approved the action for this collateral lifecycle event.',
    `capital_relief_impact_amount` DECIMAL(18,2) COMMENT 'The change in regulatory capital relief resulting from this collateral lifecycle event, such as loss of collateral eligibility or enforcement.',
    `counterparty_notification_date` DATE COMMENT 'The date on which the counterparty was notified of this collateral lifecycle event.',
    `counterparty_notified_flag` BOOLEAN COMMENT 'Indicates whether the counterparty has been formally notified of this collateral lifecycle event and any required actions.',
    `coverage_excess_amount` DECIMAL(18,2) COMMENT 'The calculated excess of actual collateral coverage over required coverage, indicating over-collateralization. Positive values may trigger release or substitution opportunities.',
    `coverage_shortfall_amount` DECIMAL(18,2) COMMENT 'The calculated shortfall between required and actual collateral coverage, indicating under-collateralization. Positive values indicate a shortfall requiring action.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this collateral lifecycle event record was first created in the system.',
    `event_date` DATE COMMENT 'The calendar date on which the collateral lifecycle event occurred or was identified.',
    `event_description` STRING COMMENT 'Detailed narrative description of the collateral lifecycle event, including context, circumstances, and any relevant background information.',
    `event_notes` STRING COMMENT 'Additional free-text notes, comments, or observations related to this collateral lifecycle event, capturing context not covered by structured fields.',
    `event_reference_number` STRING COMMENT 'Externally visible unique reference number for this collateral lifecycle event, used for tracking and audit purposes.',
    `event_source` STRING COMMENT 'The origin or channel through which the collateral lifecycle event was identified or received. [ENUM-REF-CANDIDATE: internal_monitoring|external_notification|corporate_action_feed|rating_agency|regulatory_filing|counterparty_notice|automated_trigger|manual_identification — 8 candidates stripped; promote to reference product]',
    `event_status` STRING COMMENT 'Current workflow status of the collateral lifecycle event indicating its progression through the review and resolution process. [ENUM-REF-CANDIDATE: identified|under_review|pending_approval|approved|actioned|resolved|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `event_subtype` STRING COMMENT 'Detailed sub-classification of the event type providing additional granularity for specific corporate actions or review triggers.',
    `event_timestamp` TIMESTAMP COMMENT 'The precise date and time when the collateral lifecycle event occurred or was recorded in the system.',
    `event_type` STRING COMMENT 'Classification of the collateral lifecycle event. Includes corporate actions affecting pledged securities, default events, enforcement actions, regulatory triggers, and periodic or triggered reviews. [ENUM-REF-CANDIDATE: corporate_action|default_event|enforcement_action|regulatory_trigger|scheduled_review|triggered_review|covenant_breach_review|rating_downgrade|eligibility_change|margin_call_trigger|substitution_event|release_event|maturity_event|coupon_payment|call_event|conversion_event — promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'The monetary value of the financial impact resulting from this collateral lifecycle event, such as change in collateral value, margin call amount, or loss exposure.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'The loan-to-value ratio calculated at the time of this event, representing the ratio of credit exposure to collateral value. Applicable for review events.',
    `recommended_action` STRING COMMENT 'The recommended course of action determined during the review or assessment of this collateral lifecycle event. [ENUM-REF-CANDIDATE: top_up_call|substitution|release|enforcement|no_action|monitor|escalate — 7 candidates stripped; promote to reference product]',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework applicable to this collateral lifecycle event, determining reporting and compliance requirements. [ENUM-REF-CANDIDATE: basel_iii|emir|dodd_frank|mifid_ii|sftr|umr|other — 7 candidates stripped; promote to reference product]',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this collateral lifecycle event triggers a regulatory reporting obligation under Basel III, EMIR, Dodd-Frank, or other applicable frameworks.',
    `required_collateral_coverage` DECIMAL(18,2) COMMENT 'The minimum collateral value required to adequately cover the credit exposure at the time of this event, based on applicable haircuts and margin requirements.',
    `resolution_status` STRING COMMENT 'Current status of the resolution process for this collateral lifecycle event, tracking progress from identification through closure.. Valid values are `pending|in_progress|resolved|escalated|deferred|cancelled`',
    `review_date` DATE COMMENT 'The date on which the collateral lifecycle event was formally reviewed and assessed by the collateral desk.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed this collateral lifecycle event.',
    `risk_impact_assessment` STRING COMMENT 'Qualitative assessment of the risk impact of this collateral lifecycle event on the institutions credit exposure, capital adequacy, or liquidity position.. Valid values are `low|medium|high|critical`',
    `rwa_impact_amount` DECIMAL(18,2) COMMENT 'The estimated change in risk-weighted assets resulting from this collateral lifecycle event, affecting regulatory capital calculations under Basel III.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this collateral lifecycle event record was last modified or updated.',
    CONSTRAINT pk_collateral_lifecycle_event PRIMARY KEY(`collateral_lifecycle_event_id`)
) COMMENT 'Record of all significant collateral lifecycle events including corporate actions affecting pledged securities (coupon payments, maturities, calls, conversions), collateral default events, enforcement actions, regulatory trigger events, and periodic collateral reviews and revaluations. Captures event type (corporate action, default, enforcement, regulatory trigger, scheduled review, triggered review, covenant breach review, rating downgrade, eligibility change), event date, affected collateral asset, financial impact, review-specific fields (LTV ratio, required vs actual collateral coverage, coverage shortfall, recommended action — top-up call, substitution, release), reviewer, approval status, action deadline, and resolution status. Ensures the collateral desk responds to all events affecting collateral value, eligibility, or adequacy. SSOT for all collateral lifecycle events including periodic reviews.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`insurance_policy` (
    `insurance_policy_id` BIGINT COMMENT 'Unique identifier for the insurance policy record. Primary key for the insurance policy entity.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Insurance policies audited for coverage adequacy, premium payment compliance, loss payee clause accuracy, and collateral eligibility impact. Asset protection and collateral valuation audit scope.',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset that is covered by this insurance policy. Links the policy to the specific asset requiring insurance coverage.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Insurance on securities collateral (e.g., catastrophe bonds, structured products) requires instrument linkage for coverage validation, claim processing, and collateral eligibility impact assessment. S',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Insured party identification is required for insurance claims processing, coverage verification during collateral valuation, loss payee clause enforcement, and regulatory compliance (e.g., flood insur',
    `previous_insurance_policy_id` BIGINT COMMENT 'Self-referencing FK on insurance_policy (previous_insurance_policy_id)',
    `additional_insured_parties` STRING COMMENT 'List of additional parties named as insured under the policy beyond the primary insured. May include co-lenders, servicers, trustees, or other parties with an insurable interest in the collateral.',
    `beneficiary_name` STRING COMMENT 'The name of the party designated to receive insurance proceeds in the event of a claim. For collateral insurance, this is typically the secured lender or creditor with a loss payee clause.',
    `broker_contact` STRING COMMENT 'Contact information for the insurance broker, including phone number and email address. Used for policy servicing, renewals, and claims coordination.',
    `broker_name` STRING COMMENT 'The name of the insurance broker or agent who facilitated the placement of the policy. The broker acts as an intermediary between the insured and the insurance carrier.',
    `cancellation_date` DATE COMMENT 'The date on which the insurance policy was cancelled or terminated before its scheduled expiry date. Null if the policy has not been cancelled.',
    `cancellation_reason` STRING COMMENT 'The reason for policy cancellation, such as non-payment of premium, collateral asset disposal, policy replacement, or mutual agreement. Required for audit trail and regulatory reporting when a policy is cancelled.',
    `certificate_of_insurance_reference` STRING COMMENT 'Reference identifier for the certificate of insurance (COI) document that provides evidence of coverage. The COI is typically required by secured lenders to verify that adequate insurance is in place.',
    `claim_count` STRING COMMENT 'The total number of claims filed against this insurance policy since inception. High claim frequency may impact renewal terms, premium pricing, or insurability of the collateral asset.',
    `collateral_description` STRING COMMENT 'Description of the collateral asset that is insured under this policy. This should match the legal description of the asset and may include property address, asset identification numbers, or other identifying characteristics.',
    `collateral_eligibility_impact` STRING COMMENT 'Indicates how the insurance policy status affects the eligibility of the collateral asset for use in secured lending, derivatives margining, or repo transactions. Eligible means the asset meets insurance requirements, ineligible means it does not, and conditional means additional documentation or coverage is needed.. Valid values are `eligible|ineligible|conditional`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The maximum amount the insurance policy will pay in the event of a covered loss. This represents the face value or limit of the policy and should align with the collateral value to ensure adequate protection.',
    `coverage_currency` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the coverage amount and premium are denominated.. Valid values are `^[A-Z]{3}$`',
    `coverage_description` STRING COMMENT 'Detailed description of what is covered under the insurance policy, including specific perils, exclusions, and coverage limits. This provides clarity on the scope of protection for the collateral asset.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this insurance policy record was first created in the system. Used for audit trail and data lineage tracking.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The amount the insured party must pay out-of-pocket before the insurance coverage begins to pay for a covered loss. Higher deductibles typically result in lower premium costs.',
    `effective_date` DATE COMMENT 'The date on which the insurance policy coverage begins. Claims for losses occurring before this date are not covered under the policy.',
    `expiry_date` DATE COMMENT 'The date on which the insurance policy coverage terminates. The policy must be renewed before this date to maintain continuous coverage. For collateral management, gaps in coverage may trigger margin calls or covenant breaches.',
    `insurer_identifier` STRING COMMENT 'Unique identifier for the insurance carrier, such as National Association of Insurance Commissioners (NAIC) number or other regulatory identifier. Used for regulatory reporting and carrier verification.',
    `insurer_name` STRING COMMENT 'The legal name of the insurance company or carrier that underwrites and issues the policy. This is the entity responsible for paying claims under the policy terms.',
    `issue_date` DATE COMMENT 'The date on which the insurance carrier formally issued the policy document. This may differ from the effective date if the policy is issued retroactively or in advance.',
    `last_premium_payment_date` DATE COMMENT 'The date on which the most recent premium payment was received by the insurance carrier. Used to track payment status and identify policies at risk of lapse due to non-payment.',
    `loss_payee_clause` STRING COMMENT 'The contractual clause that designates the secured lender or creditor as the party to receive insurance proceeds in the event of a loss. This protects the lenders collateral interest by ensuring claim payments are directed to the secured party.',
    `mortgagee_clause_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the policy includes a mortgagee clause (also known as standard mortgage clause) that protects the lenders interest even if the borrower violates policy terms. True indicates the clause is present, false indicates it is not.',
    `next_premium_due_date` DATE COMMENT 'The date on which the next premium payment is due. Failure to pay by this date may result in policy lapse or cancellation, creating a coverage gap that affects collateral protection.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of the insurance policy. Regular reviews ensure that coverage remains adequate as collateral values change and that policies are renewed before expiry.',
    `policy_document_reference` STRING COMMENT 'Reference identifier or location of the physical or electronic insurance policy document. Used to retrieve the full policy terms, conditions, and endorsements for review or audit purposes.',
    `policy_notes` STRING COMMENT 'Free-form text field for recording additional information, special conditions, endorsements, or operational notes related to the insurance policy. Used for documenting exceptions, coverage modifications, or communication history with the insurer.',
    `policy_number` STRING COMMENT 'The externally-known unique policy number assigned by the insurance carrier. This is the business identifier used for claims, renewals, and correspondence with the insurer.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the insurance policy. Active policies provide coverage, pending policies are awaiting approval or payment, expired policies have reached their termination date, cancelled policies were terminated before expiry, lapsed policies were not renewed, and suspended policies have temporarily halted coverage.. Valid values are `active|pending|expired|cancelled|lapsed|suspended`',
    `policy_type` STRING COMMENT 'Classification of the insurance policy based on the type of coverage provided. Property insurance covers physical assets, title insurance protects against ownership defects, marine cargo insurance covers goods in transit, liability insurance protects against third-party claims, fidelity insurance covers employee dishonesty, and business interruption insurance covers loss of income.. Valid values are `property|title|marine_cargo|liability|fidelity|business_interruption`',
    `premium_amount` DECIMAL(18,2) COMMENT 'The total cost paid to the insurance carrier for the policy coverage. This may be paid annually, semi-annually, quarterly, or monthly depending on the payment frequency terms.',
    `premium_frequency` STRING COMMENT 'The frequency at which insurance premium payments are due. Annual premiums are paid once per year, semi-annual twice per year, quarterly four times per year, and monthly twelve times per year.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the insurance policy meets all applicable regulatory requirements for collateral insurance under Basel III, Dodd-Frank, or other relevant frameworks. True indicates compliance, false indicates non-compliance or pending review.',
    `renewal_date` DATE COMMENT 'The date by which the policy must be renewed to maintain continuous coverage. Typically occurs 30-60 days before the expiry date to allow time for renewal processing.',
    `review_date` DATE COMMENT 'The date on which the insurance policy was last reviewed by collateral management or risk management teams to verify adequacy of coverage, compliance with loan covenants, and alignment with collateral value.',
    `total_claims_paid_amount` DECIMAL(18,2) COMMENT 'The cumulative amount paid by the insurance carrier for all claims under this policy. This metric helps assess the loss history and risk profile of the insured collateral asset.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this insurance policy record was most recently modified. Used for audit trail, change tracking, and data quality monitoring.',
    CONSTRAINT pk_insurance_policy PRIMARY KEY(`insurance_policy_id`)
) COMMENT 'Insurance policy record for collateral assets requiring insurance coverage (property insurance, title insurance, marine cargo insurance). Captures policy number, insurer, coverage amount, premium, and expiry date.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`stress_valuation` (
    `stress_valuation_id` BIGINT COMMENT 'Unique identifier for this collateral asset stress valuation record. Primary key.',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to the collateral asset being stress tested',
    `stress_scenario_cfp_id` BIGINT COMMENT 'Foreign key linking to the stress scenario definition',
    `calculation_method` STRING COMMENT 'Methodology used to calculate the stressed valuation for this asset-scenario combination (e.g., historical shock, regulatory prescribed shock, internal model).',
    `central_bank_eligible_flag` BOOLEAN COMMENT 'Indicates whether this collateral asset is eligible for central bank discount window borrowing under this stress scenario.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stress valuation record was created in the system.',
    `fhlb_eligible_flag` BOOLEAN COMMENT 'Indicates whether this collateral asset is eligible for Federal Home Loan Bank advance borrowing under this stress scenario.',
    `fire_sale_discount_percentage` DECIMAL(18,2) COMMENT 'Additional discount percentage applied for emergency asset monetization under this stress scenario. Reflects illiquidity premium and forced sale conditions.',
    `lcr_treatment_code` STRING COMMENT 'Basel III Liquidity Coverage Ratio treatment classification for this asset under this stress scenario (Level 1, Level 2A, Level 2B, or ineligible).',
    `monetization_capacity_amount` DECIMAL(18,2) COMMENT 'Estimated liquidity that can be raised from this collateral asset under this stress scenario through asset sales, repo, or central bank borrowing. Used in contingency funding plan calculations.',
    `scenario_specific_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the collateral asset remains eligible for liquidity purposes under this specific stress scenario. Eligibility may change due to rating downgrades, concentration limits, or counterparty stress assumptions.',
    `stressed_eligible_value_amount` DECIMAL(18,2) COMMENT 'Net eligible collateral value after applying stressed market value and stressed haircut. This is the value available for liquidity purposes under the stress scenario.',
    `stressed_haircut_percentage` DECIMAL(18,2) COMMENT 'Haircut percentage applied to the collateral asset under this stress scenario. Combines base haircut with scenario-specific additional haircuts for secured funding stress.',
    `stressed_market_value_amount` DECIMAL(18,2) COMMENT 'Market value of the collateral asset after applying the scenario-specific market value shock. Represents the estimated value under stress conditions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this stress valuation record was last updated.',
    `valuation_date` DATE COMMENT 'Date on which this stress valuation was calculated or last updated. Used for version control and regulatory reporting timestamps.',
    CONSTRAINT pk_stress_valuation PRIMARY KEY(`stress_valuation_id`)
) COMMENT 'This association product represents the stress-tested valuation and eligibility assessment of each collateral asset under each liquidity stress scenario. It captures scenario-specific market value shocks, haircut adjustments, eligibility changes, and monetization capacity used for LCR stress testing, CLAR reporting, and resolution planning. Each record links one collateral asset to one stress scenario with valuation parameters that exist only in the context of that specific stress test.. Existence Justification: In treasury liquidity stress testing, each collateral asset must be revalued under multiple stress scenarios (CCAR severely adverse, idiosyncratic, market-wide) with scenario-specific market value shocks, haircuts, and eligibility determinations. Conversely, each stress scenario applies different shock parameters to the entire collateral portfolio. Treasury actively manages and updates these scenario-specific valuations quarterly for LCR stress testing, CLAR reporting, and resolution planning submissions to regulators.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`isda_master_agreement` (
    `isda_master_agreement_id` BIGINT COMMENT 'Primary key for isda_master_agreement',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity with whom this ISDA Master Agreement is executed.',
    `previous_isda_master_agreement_id` BIGINT COMMENT 'Self-referencing FK on isda_master_agreement (previous_isda_master_agreement_id)',
    `additional_termination_events` STRING COMMENT 'Free-text description of any additional termination events specified in the Schedule to the ISDA Master Agreement beyond standard events.',
    `agreement_number` STRING COMMENT 'The externally-known unique business identifier for this ISDA Master Agreement, used in legal documentation and counterparty communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the ISDA Master Agreement indicating its operational state.',
    `agreement_type` STRING COMMENT 'The type or version of ISDA Master Agreement (e.g., 1992 ISDA, 2002 ISDA, customized bilateral agreement, cleared derivatives agreement).',
    `automatic_early_termination_indicator` BOOLEAN COMMENT 'Indicates whether early termination occurs automatically upon occurrence of a termination event, without requiring notice.',
    `calculation_agent` STRING COMMENT 'The party or entity designated to perform calculations under the ISDA Master Agreement (e.g., Party A, Party B, third-party agent, or joint determination).',
    `comments` STRING COMMENT 'Free-text field for additional notes, special terms, or operational comments related to this ISDA Master Agreement.',
    `counterparty_legal_entity_identifier` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier of the counterparty entity to this ISDA Master Agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ISDA Master Agreement record was first created in the system.',
    `credit_event_upon_merger_indicator` BOOLEAN COMMENT 'Indicates whether a merger or consolidation of the counterparty that results in credit deterioration constitutes a termination event.',
    `credit_support_annex_indicator` BOOLEAN COMMENT 'Indicates whether a Credit Support Annex (CSA) is attached to this ISDA Master Agreement, governing collateral posting requirements.',
    `cross_default_provision_indicator` BOOLEAN COMMENT 'Indicates whether a default under other agreements with the counterparty triggers a default under this ISDA Master Agreement.',
    `cross_default_threshold_amount` DECIMAL(18,2) COMMENT 'The minimum default amount under other agreements that would trigger a cross-default event under this ISDA Master Agreement.',
    `csa_type` STRING COMMENT 'The type of Credit Support Annex arrangement: bilateral (both parties post collateral), one-way (only one party posts), or none (no CSA attached).',
    `dispute_resolution_period_days` STRING COMMENT 'The number of business days allowed for resolving valuation disputes under the ISDA Master Agreement.',
    `early_termination_provision_indicator` BOOLEAN COMMENT 'Indicates whether the agreement includes provisions for early termination upon occurrence of specified events (e.g., default, credit event).',
    `effective_date` DATE COMMENT 'The date from which the ISDA Master Agreement becomes legally binding and operational.',
    `eligible_collateral_types` STRING COMMENT 'Comma-separated list of collateral asset types eligible for posting under this agreement (e.g., cash, government bonds, corporate bonds, equities).',
    `execution_date` DATE COMMENT 'The date on which the ISDA Master Agreement was formally executed and signed by both parties.',
    `governing_law` STRING COMMENT 'The legal jurisdiction whose laws govern the interpretation and enforcement of this ISDA Master Agreement (e.g., English law, New York law, Japanese law).',
    `independent_amount` DECIMAL(18,2) COMMENT 'A fixed collateral amount required to be posted regardless of mark-to-market exposure, providing additional credit protection.',
    `initial_margin_model_type` STRING COMMENT 'The methodology used to calculate initial margin requirements: Standard Initial Margin Model (SIMM), grid-based, schedule-based, or internal model.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ISDA Master Agreement record was last updated in the system.',
    `last_review_date` DATE COMMENT 'The date when this ISDA Master Agreement was last reviewed for accuracy, compliance, and continued relevance.',
    `legal_entity_identifier` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier of the bank entity that is party to this ISDA Master Agreement.',
    `master_confirmation_agreement_indicator` BOOLEAN COMMENT 'Indicates whether a Master Confirmation Agreement is in place to streamline the confirmation process for specific transaction types.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum collateral amount that must be transferred in any single margin call under the Credit Support Annex.',
    `netting_provision_indicator` BOOLEAN COMMENT 'Indicates whether close-out netting provisions are included in this ISDA Master Agreement, allowing offsetting of obligations upon default or termination.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this ISDA Master Agreement.',
    `notification_time` STRING COMMENT 'The time of day by which margin call notifications must be sent under the Credit Support Annex (e.g., 12:00 PM New York time).',
    `payment_netting_indicator` BOOLEAN COMMENT 'Indicates whether payments due on the same date in the same currency are netted to a single payment obligation.',
    `regulatory_regime` STRING COMMENT 'The primary regulatory framework applicable to this ISDA Master Agreement (e.g., Dodd-Frank, EMIR, Basel III, MiFID II).',
    `rehypothecation_rights_indicator` BOOLEAN COMMENT 'Indicates whether the collateral taker has the right to rehypothecate (reuse) posted collateral for its own purposes.',
    `specified_entities` STRING COMMENT 'Comma-separated list of affiliated entities whose credit events or defaults would trigger termination rights under this agreement.',
    `substitution_rights_indicator` BOOLEAN COMMENT 'Indicates whether the collateral provider has the right to substitute posted collateral with other eligible collateral of equivalent value.',
    `termination_date` DATE COMMENT 'The date on which the ISDA Master Agreement terminates or is scheduled to terminate. Nullable for open-ended agreements.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The exposure amount below which no collateral is required to be posted under the Credit Support Annex.',
    `threshold_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the threshold amount is denominated.',
    `valuation_frequency` STRING COMMENT 'The frequency at which derivative positions under this ISDA Master Agreement are revalued for collateral calculation purposes.',
    `variation_margin_frequency` STRING COMMENT 'The frequency at which variation margin is calculated and exchanged to reflect changes in mark-to-market exposure.',
    CONSTRAINT pk_isda_master_agreement PRIMARY KEY(`isda_master_agreement_id`)
) COMMENT 'Master reference table for isda_master_agreement. Referenced by isda_master_agreement_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`collateral_basket` (
    `collateral_basket_id` BIGINT COMMENT 'Primary key for collateral_basket',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division responsible for managing this collateral basket.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty or client associated with this collateral basket.',
    `csa_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex agreement governing this collateral basket for derivatives transactions.',
    `set_id` BIGINT COMMENT 'Reference to the collateral eligibility rule set that defines which asset types and criteria are acceptable for this basket.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created the collateral basket record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system that last modified the collateral basket record.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the bank that owns or manages this collateral basket.',
    `party_id` BIGINT COMMENT 'Reference to the custodian institution responsible for holding and safeguarding collateral assets in this basket.',
    `parent_collateral_basket_id` BIGINT COMMENT 'Self-referencing FK on collateral_basket (parent_collateral_basket_id)',
    `basket_code` STRING COMMENT 'Externally-known unique business identifier for the collateral basket used in operational systems and reporting.',
    `basket_name` STRING COMMENT 'Human-readable name or title of the collateral basket for identification and reporting purposes.',
    `basket_status` STRING COMMENT 'Current lifecycle status of the collateral basket indicating its operational state.',
    `basket_type` STRING COMMENT 'Classification of the collateral basket by its primary business purpose or transaction type.',
    `collateral_account_number` STRING COMMENT 'Account number at the custodian where collateral assets for this basket are held.',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of the basket that can be allocated to a single asset class or issuer to manage concentration risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral basket record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency for collateral valuation in this basket.',
    `collateral_basket_description` STRING COMMENT 'Detailed textual description of the collateral basket purpose, composition, and any special terms or conditions.',
    `effective_date` DATE COMMENT 'Date when the collateral basket becomes active and eligible for use in collateral management operations.',
    `expiration_date` DATE COMMENT 'Date when the collateral basket ceases to be valid or is scheduled for termination. Nullable for open-ended baskets.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Standard haircut percentage applied to collateral assets in this basket to account for market risk and volatility.',
    `initial_margin_amount` DECIMAL(18,2) COMMENT 'Initial margin requirement amount for this collateral basket under Basel III or CSA terms.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the collateral basket is currently active and available for operational use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the collateral basket record was last updated or modified.',
    `last_valuation_date` DATE COMMENT 'Date when the collateral basket was last valued or marked-to-market.',
    `margin_call_threshold` DECIMAL(18,2) COMMENT 'Threshold amount below which a margin call is triggered requiring additional collateral to be posted.',
    `minimum_collateral_value` DECIMAL(18,2) COMMENT 'Minimum required collateral value that must be maintained in the basket to meet margin or coverage requirements.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum collateral amount that must be transferred in a single margin call or collateral movement.',
    `next_valuation_date` DATE COMMENT 'Scheduled date for the next collateral valuation or mark-to-market calculation.',
    `regulatory_treatment` STRING COMMENT 'Description of how this collateral basket is treated for regulatory capital and liquidity reporting purposes under Basel III.',
    `rehypothecation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the bank has the right to rehypothecate or reuse collateral assets in this basket.',
    `risk_rating` STRING COMMENT 'Credit or risk rating assigned to the collateral basket based on asset quality and counterparty risk.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether collateral substitution rights are permitted for assets within this basket per agreement terms.',
    `total_adjusted_value` DECIMAL(18,2) COMMENT 'Total collateral value after applying haircuts and adjustments, representing the effective collateral coverage.',
    `total_market_value` DECIMAL(18,2) COMMENT 'Current aggregate market value of all collateral assets held within the basket, expressed in the basket currency.',
    `valuation_frequency` STRING COMMENT 'Frequency at which collateral assets in the basket are revalued for margin and risk management purposes.',
    `variation_margin_amount` DECIMAL(18,2) COMMENT 'Variation margin amount calculated based on daily mark-to-market changes for derivatives positions.',
    `version_number` STRING COMMENT 'Version number of the collateral basket record for tracking changes and maintaining audit history.',
    CONSTRAINT pk_collateral_basket PRIMARY KEY(`collateral_basket_id`)
) COMMENT 'Master reference table for collateral_basket. Referenced by collateral_basket_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`collateral`.`csa_agreement` (
    `csa_agreement_id` BIGINT COMMENT 'Primary key for csa_agreement',
    `party_id` BIGINT COMMENT 'Identifier of the counterparty entity with whom this CSA agreement is established.',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: CSA (Credit Support Annex) agreements are a specific type of margin agreement under ISDA. The margin_agreement product is described as the unified master record for ALL collateral-governing legal agr',
    `isda_master_agreement_id` BIGINT COMMENT 'Reference to the parent ISDA Master Agreement under which this CSA operates as an annex.',
    `previous_csa_agreement_id` BIGINT COMMENT 'Self-referencing FK on csa_agreement (previous_csa_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for the CSA agreement, typically referenced in legal documentation and operational systems.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the CSA agreement indicating its operational state and enforceability.',
    `agreement_type` STRING COMMENT 'Classification of the CSA agreement structure. Bilateral agreements require both parties to post collateral, unilateral requires only one party, and tri-party involves a third-party custodian.',
    `amendment_count` STRING COMMENT 'Number of amendments made to the original CSA agreement, tracking the evolution of terms over time.',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency for collateral valuation and threshold calculations.',
    `business_unit` STRING COMMENT 'Internal business unit or division responsible for managing this CSA agreement.',
    `concentration_limits_applied` BOOLEAN COMMENT 'Indicates whether concentration limits are enforced on collateral composition to prevent over-reliance on specific asset types or issuers.',
    `counterparty_legal_entity_identifier` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier for the counterparty entity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CSA agreement record was first created in the system.',
    `credit_rating_threshold` STRING COMMENT 'Minimum credit rating required to maintain current threshold and minimum transfer amount terms. Downgrades may trigger term adjustments.',
    `custodian_account_number` STRING COMMENT 'Account number at the custodian where collateral is held for this CSA agreement.',
    `custodian_name` STRING COMMENT 'Name of the third-party custodian holding collateral, applicable for tri-party CSA agreements.',
    `dispute_resolution_period_days` STRING COMMENT 'Number of business days allowed for resolving valuation disputes between counterparties.',
    `effective_date` DATE COMMENT 'Date when the CSA agreement becomes legally binding and operational for collateral posting requirements.',
    `eligible_collateral_types` STRING COMMENT 'Comma-separated list of asset types eligible for posting as collateral under this CSA agreement (e.g., cash, government bonds, corporate bonds, equities).',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the CSA agreement.',
    `independent_amount` DECIMAL(18,2) COMMENT 'Fixed collateral amount required to be posted regardless of exposure, serving as additional credit protection.',
    `initial_margin_required` BOOLEAN COMMENT 'Indicates whether initial margin is required under this CSA agreement, typically mandated for non-centrally cleared derivatives under regulatory reform.',
    `interest_rate_basis_points` DECIMAL(18,2) COMMENT 'Interest rate applied to cash collateral, expressed in basis points. Applicable when interest_rate_type is fixed or floating.',
    `interest_rate_type` STRING COMMENT 'Type of interest rate applied to cash collateral held under the CSA agreement.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the CSA agreement terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CSA agreement record was last updated in the system.',
    `legal_entity_identifier` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier for the bank entity that is party to this CSA agreement.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Smallest increment of collateral that can be transferred in a single margin call, expressed in base currency.',
    `netting_agreement_reference` STRING COMMENT 'Reference to the netting agreement that allows offsetting of exposures across multiple transactions covered by this CSA.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of CSA agreement terms and conditions.',
    `notification_time` STRING COMMENT 'Deadline by which margin call notifications must be delivered to the counterparty.',
    `regulatory_initial_margin_model` STRING COMMENT 'Methodology used to calculate regulatory initial margin requirements. SIMM (Standard Initial Margin Model) is the industry standard for non-cleared derivatives.',
    `rehypothecation_allowed` BOOLEAN COMMENT 'Indicates whether the receiving party is permitted to reuse or repledge the posted collateral.',
    `relationship_manager` STRING COMMENT 'Name of the relationship manager responsible for the counterparty relationship and CSA agreement oversight.',
    `rounding_amount` DECIMAL(18,2) COMMENT 'Increment to which collateral transfer amounts are rounded for operational convenience.',
    `substitution_rights_allowed` BOOLEAN COMMENT 'Indicates whether the posting party has the right to substitute posted collateral with other eligible assets.',
    `termination_date` DATE COMMENT 'Date when the CSA agreement ceases to be in effect. Nullable for open-ended agreements.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Minimum exposure amount below which no collateral is required to be posted, expressed in base currency.',
    `valuation_frequency` STRING COMMENT 'Frequency at which collateral and exposure valuations are performed under the CSA agreement.',
    `valuation_time` STRING COMMENT 'Specific time of day when collateral and exposure valuations are performed, typically expressed in a specific timezone.',
    `variation_margin_required` BOOLEAN COMMENT 'Indicates whether variation margin is required to cover mark-to-market exposure fluctuations.',
    `version_number` STRING COMMENT 'Version number of this CSA agreement record, incremented with each modification for audit trail purposes.',
    CONSTRAINT pk_csa_agreement PRIMARY KEY(`csa_agreement_id`)
) COMMENT 'Master reference table for csa_agreement. Referenced by csa_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ADD CONSTRAINT `fk_collateral_collateral_pledge_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ADD CONSTRAINT `fk_collateral_collateral_margin_call_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ADD CONSTRAINT `fk_collateral_collateral_margin_call_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ADD CONSTRAINT `fk_collateral_collateral_valuation_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_isda_master_agreement_id` FOREIGN KEY (`isda_master_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`isda_master_agreement`(`isda_master_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ADD CONSTRAINT `fk_collateral_margin_agreement_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ADD CONSTRAINT `fk_collateral_collateral_position_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_collateral_margin_call_id` FOREIGN KEY (`collateral_margin_call_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_margin_call`(`collateral_margin_call_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ADD CONSTRAINT `fk_collateral_substitution_substitution_replacement_collateral_asset_id` FOREIGN KEY (`substitution_replacement_collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ADD CONSTRAINT `fk_collateral_margin_exposure_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ADD CONSTRAINT `fk_collateral_repo_agreement_collateral_basket_id` FOREIGN KEY (`collateral_basket_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_basket`(`collateral_basket_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_repo_agreement_id` FOREIGN KEY (`repo_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`repo_agreement`(`repo_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ADD CONSTRAINT `fk_collateral_repo_leg_transfer_id` FOREIGN KEY (`transfer_id`) REFERENCES `banking_ecm`.`collateral`.`transfer`(`transfer_id`);
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ADD CONSTRAINT `fk_collateral_initial_margin_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_netting_set_id` FOREIGN KEY (`netting_set_id`) REFERENCES `banking_ecm`.`collateral`.`netting_set`(`netting_set_id`);
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ADD CONSTRAINT `fk_collateral_variation_margin_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_haircut_schedule_id` FOREIGN KEY (`haircut_schedule_id`) REFERENCES `banking_ecm`.`collateral`.`haircut_schedule`(`haircut_schedule_id`);
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ADD CONSTRAINT `fk_collateral_optimization_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ADD CONSTRAINT `fk_collateral_lien_filing_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`review` ADD CONSTRAINT `fk_collateral_review_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_isda_master_agreement_id` FOREIGN KEY (`isda_master_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`isda_master_agreement`(`isda_master_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ADD CONSTRAINT `fk_collateral_netting_set_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_collateral_margin_call_id` FOREIGN KEY (`collateral_margin_call_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_margin_call`(`collateral_margin_call_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_repo_agreement_id` FOREIGN KEY (`repo_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`repo_agreement`(`repo_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ADD CONSTRAINT `fk_collateral_transfer_substitution_id` FOREIGN KEY (`substitution_id`) REFERENCES `banking_ecm`.`collateral`.`substitution`(`substitution_id`);
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ADD CONSTRAINT `fk_collateral_concentration_limit_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_collateral_pledge_id` FOREIGN KEY (`collateral_pledge_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_pledge`(`collateral_pledge_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_pledge_agreement_id` FOREIGN KEY (`pledge_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`pledge_agreement`(`pledge_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ADD CONSTRAINT `fk_collateral_collateral_lifecycle_event_repo_agreement_id` FOREIGN KEY (`repo_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`repo_agreement`(`repo_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ADD CONSTRAINT `fk_collateral_insurance_policy_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ADD CONSTRAINT `fk_collateral_insurance_policy_previous_insurance_policy_id` FOREIGN KEY (`previous_insurance_policy_id`) REFERENCES `banking_ecm`.`collateral`.`insurance_policy`(`insurance_policy_id`);
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ADD CONSTRAINT `fk_collateral_stress_valuation_collateral_asset_id` FOREIGN KEY (`collateral_asset_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_asset`(`collateral_asset_id`);
ALTER TABLE `banking_ecm`.`collateral`.`isda_master_agreement` ADD CONSTRAINT `fk_collateral_isda_master_agreement_previous_isda_master_agreement_id` FOREIGN KEY (`previous_isda_master_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`isda_master_agreement`(`isda_master_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_csa_agreement_id` FOREIGN KEY (`csa_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`csa_agreement`(`csa_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ADD CONSTRAINT `fk_collateral_collateral_basket_parent_collateral_basket_id` FOREIGN KEY (`parent_collateral_basket_id`) REFERENCES `banking_ecm`.`collateral`.`collateral_basket`(`collateral_basket_id`);
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ADD CONSTRAINT `fk_collateral_csa_agreement_margin_agreement_id` FOREIGN KEY (`margin_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`margin_agreement`(`margin_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ADD CONSTRAINT `fk_collateral_csa_agreement_isda_master_agreement_id` FOREIGN KEY (`isda_master_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`isda_master_agreement`(`isda_master_agreement_id`);
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ADD CONSTRAINT `fk_collateral_csa_agreement_previous_csa_agreement_id` FOREIGN KEY (`previous_csa_agreement_id`) REFERENCES `banking_ecm`.`collateral`.`csa_agreement`(`csa_agreement_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`collateral` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`collateral` SET TAGS ('dbx_domain' = 'collateral');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Bic Code (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `market_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `basel_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Basel III Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `concentration_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|impaired|defaulted');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `custody_location` SET TAGS ('dbx_business_glossary_term' = 'Custody Location');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `emir_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'European Market Infrastructure Regulation (EMIR) Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_value_regex' = 'unencumbered|encumbered|partially_encumbered|cross_collateralized');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Classification');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_value_regex' = 'level_1|level_2a|level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `internal_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `lien_position` SET TAGS ('dbx_business_glossary_term' = 'Lien Position');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `lien_position` SET TAGS ('dbx_value_regex' = 'first|second|third|subordinated|senior|pari_passu');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `pledged_date` SET TAGS ('dbx_business_glossary_term' = 'Pledged Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `rehypothecation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Subtype');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_asset` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|appraisal|model|index|cost');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` SET TAGS ('dbx_subdomain' = 'legal_agreements');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `collateral_pledge_obligor_party_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Party Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `collateral_pledge_secured_party_id` SET TAGS ('dbx_business_glossary_term' = 'Secured Party Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Pledge Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Pledge Currency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `eligible_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `enforcement_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `initial_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `legal_perfection_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Perfection Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `legal_perfection_status` SET TAGS ('dbx_value_regex' = 'perfected|pending|unperfected|disputed');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `lien_rank` SET TAGS ('dbx_business_glossary_term' = 'Lien Rank');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `lien_rank` SET TAGS ('dbx_value_regex' = 'first|second|subordinate|pari_passu|junior|senior');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Maturity Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pledge Notes');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `perfection_date` SET TAGS ('dbx_business_glossary_term' = 'Perfection Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `perfection_method` SET TAGS ('dbx_business_glossary_term' = 'Perfection Method');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `perfection_method` SET TAGS ('dbx_value_regex' = 'ucc_filing|control_agreement|possession|registration|notation');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_value_regex' = 'active|released|substituted|enforced|defaulted|pending');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_business_glossary_term' = 'Pledge Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_value_regex' = 'loan_collateral|derivative_margin|repo_collateral|guarantee_backing|letter_of_credit');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Pledge Quantity');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Pledge Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `regulatory_capital_relief_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `rwa_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Reduction Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `substitution_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'market|model|appraisal|cost|fair_value');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_pledge` ALTER COLUMN `variation_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `collateral_margin_call_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Margin Call Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `call_direction` SET TAGS ('dbx_business_glossary_term' = 'Call Direction');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `call_direction` SET TAGS ('dbx_value_regex' = 'issued|received');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `call_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `collateral_posted_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `collateral_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Received Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Currency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `daily_vm_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Daily Variation Margin (VM) Requirement Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `delivery_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `delivery_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dispute_resolution_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved|withdrawn');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `dodd_frank_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Dodd-Frank Act Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `emir_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'European Market Infrastructure Regulation (EMIR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `im_calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Calculation Methodology');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `im_calculation_methodology` SET TAGS ('dbx_value_regex' = 'isda_simm|schedule_based|internal_model|ccp_prescribed');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `im_custodian_identifier` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Custodian Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `im_custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Custodian Name');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `im_segregation_status` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Segregation Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `im_segregation_status` SET TAGS ('dbx_value_regex' = 'segregated|non_segregated|partially_segregated');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `margin_call_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `margin_call_type` SET TAGS ('dbx_value_regex' = 'bilateral|ccp|tri_party');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `margin_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `margin_type` SET TAGS ('dbx_value_regex' = 'initial_margin_requirement|initial_margin_posted|initial_margin_received|variation_margin_call|variation_margin_settlement');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `net_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `settlement_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Reference');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `umr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `umr_phase` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Phase');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `vm_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_margin_call` ALTER COLUMN `vm_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|settled|failed|reversed');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `market_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `collateral_asset_class` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Class');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `concentration_limit_breach` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Breach Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `confidence_level_percentage` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `credit_quality_step` SET TAGS ('dbx_business_glossary_term' = 'Credit Quality Step (CQS)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `eligible_for_central_bank` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Central Bank Collateral');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `external_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
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
ALTER TABLE `banking_ecm`.`collateral`.`collateral_valuation` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency');
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
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule ID');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`collateral`.`haircut_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
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
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_ccp` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Central Counterparty (CCP)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_initial_margin` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Initial Margin (IM)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_repo` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Repurchase Agreement (Repo)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_secured_lending` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Secured Lending');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `eligible_for_variation_margin` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Variation Margin (VM)');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `issuer_type` SET TAGS ('dbx_business_glossary_term' = 'Issuer Type');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`collateral`.`eligibility_rule` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `isda_master_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Isda Master Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Lei (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `primary_margin_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`margin_agreement` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` SET TAGS ('dbx_subdomain' = 'legal_agreements');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_position_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Position ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_position` ALTER COLUMN `primary_collateral_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian ID');
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
ALTER TABLE `banking_ecm`.`collateral`.`substitution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` SET TAGS ('dbx_subdomain' = 'repo_operations');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Substitution Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `collateral_margin_call_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Original Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `primary_substitution_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Original Collateral Asset Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_replacement_collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Collateral Asset Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `substitution_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|cancelled');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `cheapest_to_deliver_flag` SET TAGS ('dbx_business_glossary_term' = 'Cheapest-to-Deliver (CTD) Flag');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `collateral_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Collateral Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `collateral_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `concentration_limit_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Breach Flag');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `cost_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Amount');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `cost_savings_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Savings Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `cost_savings_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `counterparty_consent_comments` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Consent Comments');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `counterparty_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Consent Date');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `counterparty_consent_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Consent Status');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `counterparty_consent_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional_approval|withdrawn');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `eligibility_check_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Date');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `eligibility_check_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Check Status');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `eligibility_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Substitution Fee Amount');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Fee Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `internal_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Approval Date');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `original_collateral_adjusted_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Collateral Adjusted Value Amount');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `original_collateral_haircut_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Collateral Haircut Rate');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `original_collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Collateral Value Amount');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'cost_optimization|approaching_maturity|eligibility_change|rating_downgrade|concentration_breach|liquidity_management');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Description');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `replacement_collateral_adjusted_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Replacement Collateral Adjusted Value Amount');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `replacement_collateral_haircut_rate` SET TAGS ('dbx_business_glossary_term' = 'Replacement Collateral Haircut Rate');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `replacement_collateral_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Replacement Collateral Value Amount');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Substitution Request Date');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Substitution Request Number');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `settlement_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Number');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'dvp|fop|triparty|bilateral');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|failed|cancelled');
ALTER TABLE `banking_ecm`.`collateral`.`substitution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Exposure Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `exposure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`margin_exposure` ALTER COLUMN `exposure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` SET TAGS ('dbx_subdomain' = 'repo_operations');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `collateral_basket_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Basket ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Near Leg Currency');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `primary_repo_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `coupon_pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Coupon Pass-Through Flag');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `coupon_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Coupon Payment Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `fail_reason` SET TAGS ('dbx_business_glossary_term' = 'Fail Reason');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `fail_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Fail Resolution Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `failed_trade_flag` SET TAGS ('dbx_business_glossary_term' = 'Failed Trade Flag');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_amount` SET TAGS ('dbx_business_glossary_term' = 'Far Leg Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Far Leg Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_currency` SET TAGS ('dbx_business_glossary_term' = 'Far Leg Currency');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_repurchase_date` SET TAGS ('dbx_business_glossary_term' = 'Far Leg Repurchase Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Far Leg Settlement Reference');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Far Leg Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `far_leg_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `initial_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `margin_call_threshold` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Threshold');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `near_leg_amount` SET TAGS ('dbx_business_glossary_term' = 'Near Leg Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `near_leg_confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Near Leg Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `near_leg_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Near Leg Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `near_leg_settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Near Leg Settlement Reference');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `near_leg_settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Near Leg Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `near_leg_settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `open_term_flag` SET TAGS ('dbx_business_glossary_term' = 'Open Term Flag');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement Number');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_direction` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement Direction');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_direction` SET TAGS ('dbx_value_regex' = 'repo|reverse_repo');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_rate` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Rate');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Rate Day Count Basis');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_rate_basis` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_status` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement Status');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_status` SET TAGS ('dbx_value_regex' = 'active|matured|terminated|cancelled|defaulted');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_type` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement Type');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `repo_type` SET TAGS ('dbx_value_regex' = 'classic_repo|sell_buyback|tri_party|hold_in_custody');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `substitution_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Rights Flag');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_agreement` ALTER COLUMN `variation_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` SET TAGS ('dbx_subdomain' = 'repo_operations');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `repo_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Leg ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agent BIC (Bank Identifier Code)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `repo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `repo_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Transaction ID');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Transfer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `actual_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `counterparty_settlement_account` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Settlement Account');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `counterparty_settlement_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `coupon_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Coupon Payment Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `custodian_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Custodian Instruction Reference');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `failed_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Failed Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `failed_settlement_reason` SET TAGS ('dbx_business_glossary_term' = 'Failed Settlement Reason');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `haircut_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Haircut Adjustment Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `leg_notes` SET TAGS ('dbx_business_glossary_term' = 'Leg Notes');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `leg_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `leg_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_business_glossary_term' = 'Leg Type');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_value_regex' = 'near|far|coupon_pass_through');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `margin_call_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Adjustment Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `next_retry_date` SET TAGS ('dbx_business_glossary_term' = 'Next Retry Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `rtgs_reference_number` SET TAGS ('dbx_business_glossary_term' = 'RTGS (Real-Time Gross Settlement) Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Reference');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_instruction_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Date');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'dvp|fop|rvp');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_retry_count` SET TAGS ('dbx_business_glossary_term' = 'Settlement Retry Count');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled|partially_settled');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_system` SET TAGS ('dbx_business_glossary_term' = 'Settlement System');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `settlement_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Variance Amount');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `sftr_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'SFTR (Securities Financing Transactions Regulation) Reporting Status');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `sftr_reporting_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|submitted|accepted|rejected');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `sftr_uti` SET TAGS ('dbx_business_glossary_term' = 'SFTR (Securities Financing Transactions Regulation) UTI (Unique Transaction Identifier)');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'SWIFT (Society for Worldwide Interbank Financial Telecommunication) Message Reference');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `trade_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository Reference');
ALTER TABLE `banking_ecm`.`collateral`.`repo_leg` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` SET TAGS ('dbx_subdomain' = 'legal_agreements');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Secured Obligation Currency');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Lei (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`pledge_agreement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Perfection Jurisdiction Country Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `initial_margin_id` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Currency');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `primary_initial_custodian_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `aana_amount` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Average Notional Amount (AANA)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `aana_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Average Notional Amount (AANA) Calculation Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Calculation Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Calculation Methodology');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'ISDA SIMM|Schedule-Based|Grid-Based|Internal Model|Hybrid');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Compliance Status');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Pending Review|Exempted');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `concentration_limit_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Breach Flag');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Dispute Amount');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Dispute Reason');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `eligible_collateral_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Types for Initial Margin (IM)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `haircut_schedule_applied` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Applied to Initial Margin (IM) Collateral');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `im_posted_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Posted Amount');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `im_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Received Amount');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `im_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Requirement Amount');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `interest_rate_on_cash_collateral` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate on Cash Collateral');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `last_margin_call_date` SET TAGS ('dbx_business_glossary_term' = 'Last Initial Margin (IM) Call Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `model_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Model Approval Status');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `model_approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending Approval|Rejected|Under Review');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `model_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Model Validation Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `net_im_exposure` SET TAGS ('dbx_business_glossary_term' = 'Net Initial Margin (IM) Exposure');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `next_scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Initial Margin (IM) Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Notes');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `phase_in_date` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Phase-In Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Reconciliation Date');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Reconciliation Status');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Matched|Unmatched|Disputed|Pending|Resolved');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `regulatory_phase` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Regulatory Phase');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `rehypothecation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction for Initial Margin (IM)');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `segregation_status` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Segregation Status');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `segregation_status` SET TAGS ('dbx_value_regex' = 'Segregated|Commingled|Partially Segregated');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `simm_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Initial Margin Model (SIMM) Version');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`initial_margin` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `variation_margin_id` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Currency');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `primary_variation_party_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `calculation_agent` SET TAGS ('dbx_business_glossary_term' = 'Calculation Agent');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `calculation_agent` SET TAGS ('dbx_value_regex' = 'reporting_party|counterparty|third_party|clearing_house');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Calculation Date');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|securities|government_bonds|corporate_bonds|equities|mixed');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `fx_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate Source');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `interest_accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Flag');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Notes');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Notification Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `portfolio_mtm_value` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Mark-to-Market (MTM) Value');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `previous_vm_balance` SET TAGS ('dbx_business_glossary_term' = 'Previous Variation Margin (VM) Balance');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Regime');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_value_regex' = 'emir|dodd_frank|basel_iii|mifid_ii|uncleared_margin_rules');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Response Deadline');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `rounding_amount` SET TAGS ('dbx_business_glossary_term' = 'Rounding Amount');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Method');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|rtgs|swift|internal_transfer|clearing_house');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Status');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|disputed|cancelled|partially_settled');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Settlement Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Threshold Amount');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `trade_population_count` SET TAGS ('dbx_business_glossary_term' = 'Trade Population Count');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `valuation_source` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `valuation_source` SET TAGS ('dbx_value_regex' = 'internal_model|vendor_pricing|exchange_settlement|counterparty_valuation|consensus_pricing');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `vm_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Amount');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `vm_direction` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Direction');
ALTER TABLE `banking_ecm`.`collateral`.`variation_margin` ALTER COLUMN `vm_direction` SET TAGS ('dbx_value_regex' = 'pay|receive');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `optimization_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Optimization ID');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset ID');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated Market Value Currency');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party ID');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocated_haircut_value` SET TAGS ('dbx_business_glossary_term' = 'Allocated Haircut Value');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocated_market_value` SET TAGS ('dbx_business_glossary_term' = 'Allocated Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_cost` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cost');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cost Currency');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Rank');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Quantity');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Allocation Sequence Number');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'proposed|approved|allocated|rejected|reversed');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `allocation_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Unit of Measure');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `concentration_limit_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Breach Flag');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `funding_cost` SET TAGS ('dbx_business_glossary_term' = 'Funding Cost');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `hqla_category` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Category');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `hqla_category` SET TAGS ('dbx_value_regex' = 'level_1|level_2a|level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `hqla_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `initial_margin_flag` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin Flag');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `net_collateral_contribution` SET TAGS ('dbx_business_glossary_term' = 'Net Collateral Contribution');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `opportunity_cost` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Cost');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `optimization_run_code` SET TAGS ('dbx_business_glossary_term' = 'Optimization Run ID');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `regulatory_capital_relief_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Amount');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `repo_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement (Repo) Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `rwa_reduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Asset (RWA) Reduction Amount');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Optimization Score');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `substitution_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|mark_to_model|third_party_pricing|internal_model');
ALTER TABLE `banking_ecm`.`collateral`.`optimization` ALTER COLUMN `variation_margin_flag` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Flag');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` SET TAGS ('dbx_subdomain' = 'legal_agreements');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `lien_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Lien Filing Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Secured Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `collateral_classification` SET TAGS ('dbx_business_glossary_term' = 'Collateral Classification');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `collateral_description` SET TAGS ('dbx_business_glossary_term' = 'Collateral Description');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `continuation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Continuation Due Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `continuation_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Continuation Filed Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `debtor_address` SET TAGS ('dbx_business_glossary_term' = 'Debtor Address');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `debtor_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `debtor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `debtor_name` SET TAGS ('dbx_business_glossary_term' = 'Debtor Name');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `debtor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `debtor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_authority` SET TAGS ('dbx_business_glossary_term' = 'Filing Authority');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Filing Document Reference');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'Active|Expired|Terminated|Pending|Rejected|Lapsed');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `legal_enforceability_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Enforceability Flag');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `lien_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Lien Priority Rank');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `original_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `perfection_method` SET TAGS ('dbx_business_glossary_term' = 'Perfection Method');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `perfection_method` SET TAGS ('dbx_value_regex' = 'Filing|Possession|Control|Automatic|Temporary');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `regulatory_capital_relief_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Relief Flag');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`collateral`.`lien_filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`review` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Review ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Obligor Party ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_secured_party_id` SET TAGS ('dbx_business_glossary_term' = 'Secured Party ID');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `action_rationale` SET TAGS ('dbx_business_glossary_term' = 'Action Rationale');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `actual_collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Actual Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional_approval');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `collateral_currency` SET TAGS ('dbx_business_glossary_term' = 'Collateral Currency');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `collateral_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `collateral_market_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `covenant_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Covenant Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `coverage_excess_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Excess Amount');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `coverage_shortfall_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Shortfall Amount');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Review Department');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `eligible_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `exposure_currency` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `exposure_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `margin_call_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Amount');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `margin_call_due_date` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Due Date');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `next_scheduled_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `outstanding_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Exposure Amount');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `prior_ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Prior Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `prior_review_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Review Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^CR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `required_collateral_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Required Collateral Coverage Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|appraisal|model_based|third_party_valuation|index_based');
ALTER TABLE `banking_ecm`.`collateral`.`review` ALTER COLUMN `valuation_source` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` SET TAGS ('dbx_subdomain' = 'legal_agreements');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `isda_master_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Lei (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`netting_set` ALTER COLUMN `primary_netting_custodian_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Party Identifier (ID)');
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
ALTER TABLE `banking_ecm`.`collateral`.`transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` SET TAGS ('dbx_subdomain' = 'repo_operations');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Transfer Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `collateral_margin_call_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `receiving_party_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `repo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `sending_party_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `substitution_id` SET TAGS ('dbx_business_glossary_term' = 'Substitution Request Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `transfer_party_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Transfer Direction');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `eligible_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `margin_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Type');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `margin_type` SET TAGS ('dbx_value_regex' = 'initial_margin|variation_margin|independent_amount');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `receiving_account_number` SET TAGS ('dbx_business_glossary_term' = 'Receiving Account Number');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `receiving_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `rehypothecation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rehypothecation Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `segregation_status` SET TAGS ('dbx_business_glossary_term' = 'Segregation Status');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `segregation_status` SET TAGS ('dbx_value_regex' = 'segregated|unsegregated|partially_segregated');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `sending_account_number` SET TAGS ('dbx_business_glossary_term' = 'Sending Account Number');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `sending_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Reference');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Confirmation Status');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|pending|unconfirmed|mismatched|rejected');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'dvp|fop|rtgs|ach|wire|book_transfer');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_system` SET TAGS ('dbx_business_glossary_term' = 'Settlement System');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `swift_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Instruction Reference');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `swift_instruction_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `swift_instruction_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `title_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Title Transfer Flag');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'delivery|return|substitution|recall|rebalancing|adjustment');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `umr_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Compliance Flag');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`transfer` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `concentration_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `applicable_margin_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Margin Type');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `applicable_margin_type` SET TAGS ('dbx_value_regex' = 'initial_margin|variation_margin|both|not_applicable');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `arrangement_scope` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Scope');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `arrangement_scope` SET TAGS ('dbx_value_regex' = 'all_arrangements|csa_only|repo_only|secured_lending_only|specific_agreement');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Applicable Asset Class');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Breach Action');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'hard_stop|soft_warning|escalation|auto_rebalance|manual_review');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `breach_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Tolerance Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `counterparty_identifier` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Classification');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `hqla_classification` SET TAGS ('dbx_value_regex' = 'level_1|level_2a|level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `issuer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Code');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_description` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Description');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Name');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Status');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|expired');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Type');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'issuer_concentration|asset_class_concentration|currency_concentration|counterparty_concentration|geographic_concentration|sector_concentration');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'real_time|intraday|daily|weekly');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `override_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Level');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'basel_iii|dodd_frank|emir|ucits|aifmd|internal_policy');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually|ad_hoc');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `threshold_absolute_amount` SET TAGS ('dbx_business_glossary_term' = 'Concentration Threshold Absolute Amount');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Concentration Threshold Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `umr_phase` SET TAGS ('dbx_business_glossary_term' = 'Uncleared Margin Rules (UMR) Phase');
ALTER TABLE `banking_ecm`.`collateral`.`concentration_limit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` SET TAGS ('dbx_subdomain' = 'legal_agreements');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `collateral_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `primary_collateral_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `primary_collateral_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `primary_collateral_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `repo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `action_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Action Deadline Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `actual_collateral_coverage` SET TAGS ('dbx_business_glossary_term' = 'Actual Collateral Coverage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `capital_relief_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Relief Impact Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `counterparty_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Notification Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `counterparty_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Notified Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `coverage_excess_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Excess Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `coverage_shortfall_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Shortfall Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_subtype` SET TAGS ('dbx_business_glossary_term' = 'Event Subtype');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `required_collateral_coverage` SET TAGS ('dbx_business_glossary_term' = 'Required Collateral Coverage');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved|escalated|deferred|cancelled');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `risk_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Impact Assessment');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `risk_impact_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `rwa_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Impact Amount');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_lifecycle_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `insurance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Identifier (ID)');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Insured Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `previous_insurance_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `additional_insured_parties` SET TAGS ('dbx_business_glossary_term' = 'Additional Insured Parties');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Beneficiary Name');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `broker_contact` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Contact Information');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `broker_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Broker Name');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Cancellation Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Cancellation Reason');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `certificate_of_insurance_reference` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Insurance Reference');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `claim_count` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Count');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `collateral_description` SET TAGS ('dbx_business_glossary_term' = 'Insured Collateral Description');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `collateral_eligibility_impact` SET TAGS ('dbx_business_glossary_term' = 'Collateral Eligibility Impact Status');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `collateral_eligibility_impact` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|conditional');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Currency Code');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Description');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Deductible Amount');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Effective Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Expiry Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `insurer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `insurer_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Issue Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `last_premium_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Premium Payment Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `loss_payee_clause` SET TAGS ('dbx_business_glossary_term' = 'Insurance Loss Payee Clause');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `mortgagee_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Mortgagee Clause Indicator Flag');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `next_premium_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Premium Due Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Insurance Policy Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Document Reference');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Notes');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Status');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|cancelled|lapsed|suspended');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Type');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'property|title|marine_cargo|liability|fidelity|business_interruption');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Amount');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Insurance Premium Payment Frequency');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Indicator Flag');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Renewal Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Review Date');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `total_claims_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Paid Amount');
ALTER TABLE `banking_ecm`.`collateral`.`insurance_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` SET TAGS ('dbx_subdomain' = 'margin_management');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` SET TAGS ('dbx_association_edges' = 'collateral.collateral_asset,treasury.stress_scenario_cfp');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `stress_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Stress Valuation ID');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Stress Valuation - Collateral Asset Id');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `stress_scenario_cfp_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Stress Valuation - Treasury Stress Scenario Id');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `central_bank_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Central Bank Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `fhlb_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'FHLB Eligible Flag');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `fire_sale_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fire Sale Discount');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `lcr_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'LCR Treatment Code');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `lcr_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `lcr_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `monetization_capacity_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetization Capacity');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `scenario_specific_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Scenario Eligibility Flag');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `stressed_eligible_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Eligible Value');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `stressed_haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Stressed Haircut Percentage');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `stressed_market_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Stressed Market Value');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`collateral`.`stress_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Stress Valuation Date');
ALTER TABLE `banking_ecm`.`collateral`.`isda_master_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`isda_master_agreement` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`isda_master_agreement` ALTER COLUMN `isda_master_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Isda Master Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`isda_master_agreement` ALTER COLUMN `previous_isda_master_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ALTER COLUMN `collateral_basket_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Basket Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ALTER COLUMN `parent_collateral_basket_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`collateral_basket` ALTER COLUMN `collateral_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ALTER COLUMN `csa_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Csa Agreement Identifier');
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ALTER COLUMN `previous_csa_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`collateral`.`csa_agreement` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
