-- Schema for Domain: treasury | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`treasury` COMMENT 'Treasury operations including liquidity management, funds transfer pricing (FTP), ALM, ALCO reporting, interest rate risk management, and balance sheet optimization. Owns LCR, NSFR, CET1 capital ratios, interbank funding, repo/reverse repo funding strategies, and capital planning. Interfaces with ledger and regulatory reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`liquidity_position` (
    `liquidity_position_id` BIGINT COMMENT 'Unique identifier for the liquidity position record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: LCR/NSFR liquidity positions are calculated and reported at each accounting period end for ALCO review and regulatory submission. A banking domain expert expects every period-end liquidity snapshot to',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to treasury.cash_flow_forecast. Business justification: liquidity_position captures daily intraday and end-of-day liquidity positions including forward cash flow projections. cash_flow_forecast is the forward-looking cash flow forecast record that provides',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Liquidity positions reported by business line map to cost centers for ALCO management reporting and liquidity gap analysis by organizational unit. Essential for treasury performance attribution.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Liquidity positions track currency_code for FX risk, LCR/NSFR calculation by currency, and regulatory reporting. Link enables currency validation, minor unit rounding, and jurisdiction-specific liquid',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Liquidity stress testing requires fund-level redemption assumptions, liquidity classification (daily/weekly/monthly dealing), and gate provisions. LCR/NSFR calculations apply specific run-off rates an',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory LCR/NSFR reporting requires liquidity positions at individual legal entity level (Basel III). Banks must report entity-level liquidity ratios to regulators; a direct legal_entity_id is esse',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: ALCO liquidity stress testing for fund-linked positions requires the NAV at the position date to compute realisable liquidity from fund redemptions. Regulatory LCR/NSFR reporting for fund-linked entit',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Liquidity positions (LCR, NSFR, intraday) are reviewed during regulatory examinations (ILAAP, ILSA, Fed liquidity reviews). Examiners assess adequacy of liquidity buffers. A treasury professional woul',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Liquidity positions are calculated under specific stress scenarios (LCR idiosyncratic, market-wide stress). liquidity_position.scenario_type is a denormalized field. Linking to stress_scenario enables',
    `alco_reporting_flag` BOOLEAN COMMENT 'Indicates whether this liquidity position record is included in ALCO reporting packages for senior management and board oversight.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the liquidity position was reviewed and approved by treasury desk or risk management, marking it as final for reporting purposes.',
    `available_liquidity_amount` DECIMAL(18,2) COMMENT 'Total available liquidity calculated as liquid assets plus cash balances plus undrawn facilities plus net cash inflows for the tenor bucket.',
    `behavioral_inflow_amount` DECIMAL(18,2) COMMENT 'Projected cash inflows from behavioral assumptions within the tenor bucket, including expected deposit inflows and credit line repayments based on historical patterns.',
    `behavioral_outflow_amount` DECIMAL(18,2) COMMENT 'Projected cash outflows from behavioral assumptions within the tenor bucket, including deposit runoff rates and credit line drawdown expectations based on historical patterns.',
    `calculation_method` STRING COMMENT 'The methodology or model used to calculate this liquidity position (e.g., Basel III LCR Standard, Internal Liquidity Model, Stress Testing Model).',
    `cash_balance` DECIMAL(18,2) COMMENT 'Total cash balances held across all nostro accounts, correspondent banking accounts, and internal cash accounts in the specified currency.',
    `central_bank_reserve_balance` DECIMAL(18,2) COMMENT 'Balance held in reserve accounts at central banks (e.g., Federal Reserve, ECB), representing the highest quality liquid asset.',
    `comments` STRING COMMENT 'Free-text commentary or notes from treasury desk regarding unusual liquidity conditions, market events, or adjustments made to the position calculation.',
    `contingency_funding_trigger_status` STRING COMMENT 'Current status of contingency funding plan triggers based on liquidity position and market conditions: normal operations, early warning, stress, or crisis.. Valid values are `normal|early_warning|stress|crisis`',
    `contractual_inflow_amount` DECIMAL(18,2) COMMENT 'Projected cash inflows from contractual obligations within the tenor bucket, including loan repayments, bond maturities, coupon payments, and maturing investments.',
    `contractual_outflow_amount` DECIMAL(18,2) COMMENT 'Projected cash outflows from contractual obligations within the tenor bucket, including debt maturities, interest payments, and committed funding obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this liquidity position record was first created in the system.',
    `cumulative_net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Cumulative net cash flow from position date through the end of the tenor bucket, used for forward liquidity gap analysis.',
    `data_source_system` STRING COMMENT 'The upstream operational system or platform from which the liquidity position data was sourced (e.g., Treasury Management System, Risk Platform, Core Banking System).',
    `interbank_funding_amount` DECIMAL(18,2) COMMENT 'Total unsecured interbank borrowing outstanding at the position date, including federal funds purchased and interbank deposits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this liquidity position record was last updated or modified.',
    `lcr_buffer_amount` DECIMAL(18,2) COMMENT 'Excess liquidity buffer above the regulatory minimum LCR requirement, calculated as (LCR ratio - 100%) multiplied by net cash outflows.',
    `lcr_ratio` DECIMAL(18,2) COMMENT 'Liquidity Coverage Ratio calculated as high-quality liquid assets divided by total net cash outflows over the next 30 calendar days, expressed as a percentage. Regulatory minimum is 100% per Basel III.',
    `liquid_asset_balance` DECIMAL(18,2) COMMENT 'Total value of high-quality liquid assets (HQLA) available for immediate liquidation, including Level 1 and Level 2 assets per Basel III LCR framework.',
    `net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Net projected cash flow for the tenor bucket, calculated as total inflows minus total outflows (contractual plus behavioral).',
    `nsfr_buffer_amount` DECIMAL(18,2) COMMENT 'Excess stable funding buffer above the regulatory minimum NSFR requirement, calculated as (NSFR ratio - 100%) multiplied by required stable funding.',
    `nsfr_ratio` DECIMAL(18,2) COMMENT 'Net Stable Funding Ratio calculated as available stable funding divided by required stable funding over a one-year horizon, expressed as a percentage. Regulatory minimum is 100% per Basel III.',
    `position_date` DATE COMMENT 'The business date for which this liquidity position is calculated (end-of-day or intraday snapshot date).',
    `position_status` STRING COMMENT 'Current status of the liquidity position record: preliminary (intraday or initial calculation), final (end-of-day confirmed), adjusted (post-close adjustment), or restated (historical correction).. Valid values are `preliminary|final|adjusted|restated`',
    `position_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this liquidity position snapshot was captured, supporting intraday liquidity monitoring.',
    `position_type` STRING COMMENT 'Classification of the liquidity position: intraday snapshot, end-of-day position, or forward cash flow forecast.. Valid values are `intraday|end_of_day|forward_forecast`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this liquidity position record is used for regulatory reporting submissions to central banks and supervisory authorities.',
    `repo_funding_amount` DECIMAL(18,2) COMMENT 'Total funding obtained through repurchase agreements (repos) outstanding at the position date, representing secured short-term borrowing.',
    `reverse_repo_funding_amount` DECIMAL(18,2) COMMENT 'Total funding provided through reverse repurchase agreements (reverse repos) outstanding at the position date, representing secured short-term lending.',
    `tenor_bucket` STRING COMMENT 'Time horizon bucket for cash flow forecasting: intraday, overnight, 1 week, 2 weeks, 1 month, 3 months, 6 months, or 1 year. [ENUM-REF-CANDIDATE: intraday|overnight|1W|2W|1M|3M|6M|1Y — 8 candidates stripped; promote to reference product]',
    `undrawn_committed_facility_amount` DECIMAL(18,2) COMMENT 'Total amount of undrawn committed credit facilities available to the bank for liquidity purposes, including interbank lines and central bank standing facilities.',
    CONSTRAINT pk_liquidity_position PRIMARY KEY(`liquidity_position_id`)
) COMMENT 'Daily intraday and end-of-day liquidity position and forward cash flow forecast for the bank, capturing available liquid assets, cash balances across nostro accounts, central bank reserves, undrawn committed facilities, and projected inflows/outflows by currency and tenor bucket (intraday, overnight, 1W, 2W, 1M, 3M). Distinguishes contractual cash flows (loan repayments, bond maturities, coupon payments) from behavioral cash flows (deposit runoff, credit line drawdowns) under base and stress scenarios. Includes forward-looking cash flow forecast by business line for liquidity stress testing and contingency funding planning. Serves as the operational heartbeat for ALCO and treasury desk liquidity monitoring. Tracks LCR and NSFR buffer positions against regulatory minimums (Basel III / BCBS). Supports intraday liquidity monitoring per BCBS 248 and contingency funding trigger assessment. Post-merge: this is the single source of truth for liquidity positions and cash flow forecasting — replaces former separate cash_flow_forecast product.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`liquidity_ratio` (
    `liquidity_ratio_id` BIGINT COMMENT 'Primary key for liquidity_ratio',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: LCR and NSFR ratio calculations are period-specific regulatory metrics submitted at each accounting period close. Linking to accounting_period enables period-over-period ratio trend reporting and ensu',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: LCR/NSFR ratios calculated per regulatory jurisdiction (Fed, ECB, PRA). Link enables jurisdiction-specific thresholds, buffer requirements, regulatory submission routing, and Basel framework version l',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity or consolidated group for which the liquidity ratio is calculated. Links to the organizational hierarchy.',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: liquidity_ratio captures the regulatory LCR/NSFR ratio calculations. liquidity_position captures the daily intraday and end-of-day liquidity position and forward cash flow forecasts that feed into the',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: LCR/NSFR ratios reported in specific currency for regulatory submission. Link enables multi-currency consolidation, FX revaluation for base currency reporting, and validation of regulatory currency re',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: LCR/NSFR ratios computed under stress scenarios are produced by specific stress test runs. liquidity_ratio.stress_scenario_type is a denormalized field. Linking to stress_test_run provides regulatory ',
    `alco_approval_status` STRING COMMENT 'The approval status of the liquidity ratio by the ALCO, indicating whether the ratio and any remediation plans have been formally accepted.. Valid values are `pending|approved|rejected|escalated`',
    `alco_review_date` DATE COMMENT 'The date on which the liquidity ratio was reviewed and approved by the Asset-Liability Committee for internal governance and risk management.',
    `available_stable_funding_amount` DECIMAL(18,2) COMMENT 'Total Available Stable Funding calculated by applying ASF factors to liability and capital categories. Numerator of the NSFR calculation.',
    `breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the liquidity ratio is below the regulatory minimum threshold. True indicates a breach requiring immediate remediation and regulatory notification.',
    `breach_severity` STRING COMMENT 'Classification of breach severity based on the magnitude and duration of the shortfall below regulatory minimum. Used for escalation and remediation prioritization.. Valid values are `none|minor|moderate|severe|critical`',
    `buffer_percentage` DECIMAL(18,2) COMMENT 'The buffer above the regulatory minimum threshold, calculated as (Actual Ratio - Regulatory Threshold). Positive values indicate compliance buffer; negative values indicate breach.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the liquidity ratio: standardized approach per Basel III, internal model (if approved by regulator), or hybrid approach.. Valid values are `standardized|internal_model|hybrid`',
    `calculation_timestamp` TIMESTAMP COMMENT 'The timestamp when the liquidity ratio was calculated by the treasury or risk management system.',
    `commentary` STRING COMMENT 'Free-text commentary from treasury or risk management explaining significant movements, breaches, remediation actions, or other material factors affecting the liquidity ratio.',
    `committed_facility_outflow_amount` DECIMAL(18,2) COMMENT 'Expected drawdowns on committed credit and liquidity facilities over the 30-day stress horizon.',
    `consolidation_level` STRING COMMENT 'The level of consolidation for the liquidity ratio calculation: solo entity, fully consolidated group, or sub-consolidated group.. Valid values are `solo|consolidated|sub_consolidated`',
    `contractual_inflow_amount` DECIMAL(18,2) COMMENT 'Expected contractual cash inflows from maturing assets and receivables over the 30-day stress horizon, subject to 75% cap per Basel III.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this liquidity ratio record was first created in the data platform.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A score from 0.00 to 1.00 representing the completeness and accuracy of the underlying data used in the liquidity ratio calculation. Used for data governance and audit trails.',
    `derivative_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from derivative contracts and collateral calls over the 30-day stress horizon.',
    `hqla_level_1_amount` DECIMAL(18,2) COMMENT 'Total value of Level 1 HQLA (cash, central bank reserves, sovereign debt) eligible for LCR numerator with 0% haircut.',
    `hqla_level_2a_amount` DECIMAL(18,2) COMMENT 'Total value of Level 2A HQLA (high-quality corporate bonds, covered bonds) eligible for LCR numerator with 15% haircut.',
    `hqla_level_2b_amount` DECIMAL(18,2) COMMENT 'Total value of Level 2B HQLA (lower-rated corporate bonds, residential mortgage-backed securities, equities) eligible for LCR numerator with haircuts ranging from 25% to 50%.',
    `lcr_percentage` DECIMAL(18,2) COMMENT 'The calculated LCR expressed as a percentage. Calculated as (Total HQLA / Total Net Cash Outflows) * 100. Regulatory minimum is 100%.',
    `nsfr_percentage` DECIMAL(18,2) COMMENT 'The calculated NSFR expressed as a percentage. Calculated as (Available Stable Funding / Required Stable Funding) * 100. Regulatory minimum is 100%.',
    `period_over_period_change_percentage` DECIMAL(18,2) COMMENT 'The percentage point change in the liquidity ratio compared to the prior reporting period. Calculated as (Current Ratio - Prior Period Ratio).',
    `prior_period_ratio_percentage` DECIMAL(18,2) COMMENT 'The liquidity ratio percentage from the previous reporting period, used for trend analysis and variance reporting.',
    `ratio_type` STRING COMMENT 'Discriminator indicating the type of liquidity ratio: LCR (Liquidity Coverage Ratio) for 30-day stress horizon or NSFR (Net Stable Funding Ratio) for one-year structural funding stability.. Valid values are `LCR|NSFR`',
    `record_status` STRING COMMENT 'The lifecycle status of this liquidity ratio record: active (current), superseded (replaced by a corrected version), archived (historical), or deleted (logically removed).. Valid values are `active|superseded|archived|deleted`',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this liquidity ratio record was submitted to regulatory authorities (Federal Reserve, OCC) as part of formal Basel III reporting.',
    `regulatory_threshold_percentage` DECIMAL(18,2) COMMENT 'The regulatory minimum threshold for the ratio (typically 100% for both LCR and NSFR under Basel III).',
    `reporting_date` DATE COMMENT 'The business date for which the liquidity ratio is calculated and reported. Typically daily for LCR and quarterly for NSFR.',
    `reporting_period` STRING COMMENT 'The reporting period identifier (e.g., Q1 2024, 2024-01-31) for regulatory submission and internal ALCO reporting.',
    `required_stable_funding_amount` DECIMAL(18,2) COMMENT 'Total Required Stable Funding calculated by applying RSF factors to asset and off-balance-sheet exposure categories. Denominator of the NSFR calculation.',
    `retail_deposit_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from retail deposits over the 30-day stress horizon, applying run-off rates per Basel III (stable vs. less stable deposits).',
    `secured_funding_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from maturing secured funding transactions (repos, covered bonds) over the 30-day stress horizon.',
    `source_system` STRING COMMENT 'The name of the source system from which the liquidity ratio data originated (e.g., AxiomSL, Wolters Kluwer OneSumX, SAS Risk Management).',
    `submission_date` DATE COMMENT 'The date on which the liquidity ratio was submitted to regulatory authorities for compliance reporting.',
    `total_hqla_amount` DECIMAL(18,2) COMMENT 'Total stock of HQLA after applying haircuts and caps. Numerator of the LCR calculation.',
    `total_net_cash_outflow_amount` DECIMAL(18,2) COMMENT 'Total expected net cash outflows over the 30-day stress scenario. Denominator of the LCR calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this liquidity ratio record was last updated in the data platform.',
    `wholesale_funding_outflow_amount` DECIMAL(18,2) COMMENT 'Expected cash outflows from unsecured wholesale funding (operational deposits, non-operational deposits, unsecured debt) over the 30-day stress horizon.',
    CONSTRAINT pk_liquidity_ratio PRIMARY KEY(`liquidity_ratio_id`)
) COMMENT 'Unified regulatory liquidity ratio record capturing both Liquidity Coverage Ratio (LCR) and Net Stable Funding Ratio (NSFR) calculations per legal entity and consolidated group. For LCR: captures HQLA stock, total net cash outflows over a 30-day stress horizon, and resulting LCR percentage. For NSFR: captures Available Stable Funding (ASF), Required Stable Funding (RSF) by asset/liability category, and resulting NSFR percentage. Supports daily and quarterly regulatory reporting to the Federal Reserve and OCC under Basel III. Tracks breaches, buffers, and trends against the 100% minimum thresholds for both ratios. Includes ratio type discriminator (LCR, NSFR) for unified compliance monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`hqla_inventory` (
    `hqla_inventory_id` BIGINT COMMENT 'Unique identifier for each HQLA inventory record. Primary key for the HQLA inventory master.',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: HQLA inventory must identify which collateral assets qualify as high-quality liquid assets for LCR/NSFR regulatory reporting. Treasury liquidity management requires tracking asset-level eligibility, h',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: HQLA inventory valuation (hqla_value_amount, market_value_amount) is derived from collateral_valuation records applying regulatory haircuts. Linking enables automated HQLA value updates from the colla',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: HQLA assets are managed by specific treasury cost centers for internal FTP liquidity cost allocation and P&L attribution. Treasury operations require cost center assignment on HQLA inventory to alloca',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Basel III LCR mandates minimum credit rating thresholds for HQLA eligibility (e.g., Level 2A requires AA- minimum). Treasury re-runs eligibility assessments when ratings change. Linking to security.cr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: HQLA assets denominated in specific currencies for LCR calculation. Link enables currency-specific haircuts, FX risk assessment, and eligibility validation (e.g., non-convertible currencies excluded f',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to collateral.eligibility_rule. Business justification: HQLA Level 1/2A/2B classification is determined by eligibility rules in collateral.eligibility_rule (minimum credit rating, asset class, jurisdiction, regulatory framework). Linking enables automated ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: HQLA portfolios include money market fund units and UCITS as Level 2B liquid assets for LCR regulatory reporting. Banks must track fund ISIN, haircuts, and eligibility status for Basel III liquidity c',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: HQLA securities are balance sheet assets requiring GL account reconciliation for financial reporting, regulatory filings (LCR), and external audit. Monthly HQLA-to-GL reconciliation is mandatory contr',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: HQLA valuation for LCR purposes applies regulatory haircuts defined in haircut_schedule (Basel III supervisory haircuts by asset class, maturity, credit quality). The haircut_percentage and stress_sce',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: HQLA inventory tracks high-quality liquid asset securities (government bonds, corporate bonds) for LCR regulatory reporting and liquidity stress testing. The isin/cusip columns are denormalized identi',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: HQLA eligibility and risk weighting depend on issuer sovereign rating and jurisdiction. Link enables concentration limit monitoring by country, sovereign risk assessment, and HQLA level determination ',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Basel III LCR eligibility requires issuer-level checks: Level 1 assets must be issued by sovereigns/central banks, Level 2A by qualifying PSEs. Treasury teams monitor HQLA concentration by issuer and ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Basel III LCR rules define HQLA eligibility and haircuts by jurisdiction (ECB, Fed, PRA differ). HQLA classification (hqla_level, eligibility_status, haircut_percentage) is governed by the issuers re',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: HQLA inventory tracks issuer by LEI for counterparty identification. Link enables concentration risk monitoring, ultimate parent lookup, regulatory reporting (e.g., FR 2052a), and sanctions screening.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: HQLA buffers are maintained and reported at legal entity level for LCR compliance. The existing legal_entity_identifier is a denormalized text field; a proper FK to legal_entity enables entity-level H',
    `liquidity_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_ratio. Business justification: hqla_inventory is the master inventory of High-Quality Liquid Assets held for LCR compliance. liquidity_ratio captures the LCR/NSFR ratio calculations including hqla_level_1_amount, hqla_level_2a_amou',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: HQLA inventory is directly reviewed during regulatory examinations (ILAAP, LCR supervisory reviews). Examiners assess asset eligibility, haircuts, and encumbrance status. A banking examiner would expe',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: HQLA inventory is assessed under stress scenarios as part of LCR stress testing; stress-scenario haircuts are applied per run. hqla_inventory.stress_scenario_haircut_percentage is a denormalized resul',
    `acquisition_date` DATE COMMENT 'Date on which the bank acquired or added the security to the HQLA inventory.',
    `business_unit` STRING COMMENT 'Internal organizational unit or treasury desk responsible for managing this HQLA position.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HQLA inventory record was first created in the system.',
    `custodian_account_number` STRING COMMENT 'Account identifier at the custodian where the HQLA asset is held.',
    `custodian_name` STRING COMMENT 'Name of the financial institution or central securities depository holding the HQLA asset on behalf of the bank.',
    `eligibility_status` STRING COMMENT 'Current determination of whether the asset meets all Basel III BCBS 238 criteria for HQLA classification and LCR inclusion.. Valid values are `Eligible|Ineligible|Conditionally Eligible|Under Review`',
    `encumbered_amount` DECIMAL(18,2) COMMENT 'Market value of the asset that is pledged, restricted, or otherwise encumbered and not available for LCR purposes.',
    `encumbrance_status` STRING COMMENT 'Indicates whether the asset is free of legal, regulatory, contractual, or other restrictions that would prevent liquidation or use as collateral.. Valid values are `Unencumbered|Encumbered|Partially Encumbered`',
    `hqla_level` STRING COMMENT 'Classification of the asset under Basel III liquidity framework: Level 1 (central bank reserves, sovereign bonds with 0% haircut), Level 2A (agency MBS, covered bonds with 15% haircut), or Level 2B (corporate bonds, equities with 50% haircut).. Valid values are `Level 1|Level 2A|Level 2B`',
    `hqla_value_amount` DECIMAL(18,2) COMMENT 'Post-haircut value of the asset eligible for LCR calculation, computed as market value multiplied by (1 minus haircut percentage).',
    `ineligibility_reason` STRING COMMENT 'Explanation of why the asset does not qualify for HQLA treatment, if eligibility status is Ineligible or Conditionally Eligible.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this HQLA inventory record, supporting real-time intraday LCR monitoring.',
    `lcr_inclusion_flag` BOOLEAN COMMENT 'Boolean indicator of whether this asset is currently included in the LCR numerator calculation.',
    `maturity_date` DATE COMMENT 'Date on which the security principal is scheduled to be repaid or the security expires.',
    `movement_date` DATE COMMENT 'Date on which the most recent inventory movement or change occurred.',
    `movement_type` STRING COMMENT 'Classification of the most recent change to the HQLA inventory record, tracking asset lifecycle events. [ENUM-REF-CANDIDATE: Addition|Disposal|Substitution|Encumbrance Change|Valuation Adjustment|Maturity|Transfer In|Transfer Out — 8 candidates stripped; promote to reference product]',
    `nominal_amount` DECIMAL(18,2) COMMENT 'Face value or par value of the security holdings in the securitys denomination currency.',
    `nsfr_inclusion_flag` BOOLEAN COMMENT 'Boolean indicator of whether this asset is included in the NSFR available stable funding calculation.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares of the security held in the HQLA inventory.',
    `record_status` STRING COMMENT 'Current lifecycle status of the HQLA inventory record in the data product.. Valid values are `Active|Inactive|Archived|Pending Verification`',
    `source_system` STRING COMMENT 'Name of the upstream operational system from which this HQLA inventory record was sourced (e.g., treasury management system, securities accounting system).',
    `unencumbered_hqla_value_amount` DECIMAL(18,2) COMMENT 'Post-haircut value of the unencumbered portion of the asset that qualifies for LCR numerator calculation.',
    `valuation_date` DATE COMMENT 'Date as of which the market value and HQLA value were determined.',
    CONSTRAINT pk_hqla_inventory PRIMARY KEY(`hqla_inventory_id`)
) COMMENT 'Master inventory of High-Quality Liquid Assets (HQLA) held by the treasury for LCR compliance and liquidity buffer management. Captures Level 1 (central bank reserves, sovereign bonds), Level 2A (agency MBS, covered bonds), and Level 2B (corporate bonds, equities) assets with ISIN, market value, haircut percentage, encumbrance status, custodian, and eligibility classification per BCBS 238 criteria. Tracks asset movements (additions, disposals, substitutions, encumbrance changes) and maintains real-time unencumbered HQLA totals by level for intraday LCR monitoring. Feeds directly into liquidity_position and liquidity_ratio calculations.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`interbank_placement` (
    `interbank_placement_id` BIGINT COMMENT 'Unique identifier for the interbank placement transaction. Primary key for this entity.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Interbank placements originate from trade capture events in the front office. Linking interbank_placement to capture supports trade lifecycle management, regulatory reporting (COREP large exposures), ',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to payment.correspondent_bank. Business justification: Treasury interbank placements with correspondent banks require FK to correspondent_bank for credit limit monitoring, counterparty concentration risk analysis, and ALCO exposure reporting. Replaces den',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Interbank placements are originated by specific treasury desks whose P&L is tracked at cost center level. FTP rate assignment and NIM attribution for interbank placements require a cost center link fo',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Interbank placement limits, pricing spreads, and netting eligibility are driven by the counterparty banks credit rating. interbank_placement has internal_credit_rating and counterparty_credit_rating ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Interbank placements denominated in specific currencies for FX risk and liquidity gap analysis. Link enables currency validation, NSFR ASF/RSF factor lookup by currency, and multi-currency liquidity r',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Interbank placements are balance sheet assets requiring GL account mapping for daily treasury position reconciliation, financial statement preparation, and interest income accrual accounting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Interbank placements require jurisdiction-specific regulatory capital treatment (risk weights, large exposure limits under CRR/Basel). The risk_weight_percent and regulatory fields on interbank_placem',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Secured interbank placements (collateralized deposits, secured lending) are backed by pledged collateral. Linking to collateral_pledge enables regulatory capital calculation under Basel III CRM (Finan',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Interbank placements reference benchmark rates (SOFR, EURIBOR, etc.) for pricing. Link enables daily rate fixing validation, IBOR transition tracking, fallback rate application, and interest accrual c',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Interbank placements with correspondent banks require OFAC/sanctions screening of the counterparty before settlement. BSA/AML compliance requires linking each placement to its sanctions screening resu',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Interest accrued to date on the placement, calculated based on the all-in rate, notional amount, and day count convention.',
    `alco_reporting_category` STRING COMMENT 'Classification category for ALCO reporting purposes, grouping placements by strategic funding or investment bucket for balance sheet management.',
    `all_in_rate` DECIMAL(18,2) COMMENT 'Final effective interest rate for the placement, calculated as benchmark rate plus spread, expressed as a percentage per annum.',
    `benchmark_rate_value` DECIMAL(18,2) COMMENT 'The actual benchmark rate value at trade execution, expressed as a percentage (e.g., 5.25 for 5.25%). Null if placement is fixed rate with no benchmark.',
    `booking_timestamp` TIMESTAMP COMMENT 'Timestamp when the placement transaction was recorded in the treasury management system.',
    `counterparty_concentration_flag` BOOLEAN COMMENT 'Indicates whether this placement contributes to a counterparty concentration risk threshold breach (True) or not (False), used for large exposure monitoring.',
    `day_count_convention` STRING COMMENT 'Method used to calculate interest accrual: ACT/360 (actual days over 360), ACT/365 (actual days over 365), 30/360 (30-day months), or ACT/ACT (actual over actual).. Valid values are `ACT_360|ACT_365|30_360|ACT_ACT`',
    `desk_code` STRING COMMENT 'Code identifying the treasury trading desk responsible for this placement (e.g., money markets desk, funding desk).',
    `expected_credit_loss` DECIMAL(18,2) COMMENT 'Calculated expected credit loss provision for this placement under IFRS 9 or CECL methodology, based on PD, LGD, and EAD.',
    `exposure_at_default` DECIMAL(18,2) COMMENT 'Total exposure amount at risk if the counterparty defaults, including notional principal and accrued interest, used for credit risk capital calculation.',
    `ftp_rate` DECIMAL(18,2) COMMENT 'Internal transfer pricing rate assigned to this placement for cost-of-funds allocation and profitability analysis, expressed as a percentage per annum.',
    `liquidity_classification` STRING COMMENT 'Classification of the placement for Liquidity Coverage Ratio (LCR) purposes: HQLA Level 1 (highest quality), Level 2A, Level 2B, or non-HQLA.. Valid values are `HQLA_level_1|HQLA_level_2A|HQLA_level_2B|non_HQLA`',
    `liquidity_gap_bucket` STRING COMMENT 'Time bucket for liquidity gap analysis based on remaining maturity: overnight, 1-7 days, 8-30 days, 31-90 days, 91-180 days, 181-365 days, or over 1 year. [ENUM-REF-CANDIDATE: overnight|1_7_days|8_30_days|31_90_days|91_180_days|181_365_days|over_1_year — 7 candidates stripped; promote to reference product]',
    `loss_given_default` DECIMAL(18,2) COMMENT 'Estimated percentage of exposure that will be lost if the counterparty defaults, expressed as a decimal (e.g., 0.45 for 45%), used for ECL calculation.',
    `maturity_date` DATE COMMENT 'The date on which the principal amount is scheduled to be repaid or returned. Null for open-ended call money placements.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Principal amount of the interbank placement or borrowing in the transaction currency.',
    `nsfr_asf_factor` DECIMAL(18,2) COMMENT 'Available Stable Funding factor applied to this placement for NSFR calculation, expressed as a decimal (e.g., 0.85 for 85%).',
    `nsfr_rsf_factor` DECIMAL(18,2) COMMENT 'Required Stable Funding factor applied to this placement for NSFR calculation, expressed as a decimal (e.g., 0.50 for 50%).',
    `placement_reference_number` STRING COMMENT 'External business identifier for the interbank placement transaction, used for operational reference and reconciliation with counterparties.',
    `placement_type` STRING COMMENT 'Classification of the interbank placement by tenor structure: overnight (1 day), term (fixed maturity), call money (callable on demand), notice (requires advance notice), or fixed deposit.. Valid values are `overnight|term|call_money|notice|fixed_deposit`',
    `probability_of_default` DECIMAL(18,2) COMMENT 'Estimated probability that the counterparty will default within one year, expressed as a decimal (e.g., 0.0025 for 0.25%), used for Expected Credit Loss (ECL) calculation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated in the data platform.',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'Risk weight percentage applied to the placement exposure for Risk-Weighted Assets (RWA) calculation under Basel III standardized or IRB approach.',
    `rollover_instruction` STRING COMMENT 'Type of rollover instruction: automatic (system-driven rollover), manual (requires explicit approval), or none (no rollover planned).. Valid values are `automatic|manual|none`',
    `rollover_status` STRING COMMENT 'Indicates whether the placement is subject to rollover at maturity: none (no rollover), pending (rollover requested), executed (rolled over), or declined (rollover not agreed).. Valid values are `none|pending|executed|declined`',
    `settlement_date` DATE COMMENT 'Actual date on which the funds were transferred and settlement completed. May differ from value date in case of settlement delays.',
    `settlement_status` STRING COMMENT 'Current settlement status of the placement transaction: pending (awaiting settlement), settled (funds transferred), failed (settlement unsuccessful), or cancelled (transaction voided).. Valid values are `pending|settled|failed|cancelled`',
    `spread_bps` DECIMAL(18,2) COMMENT 'Credit spread added to or subtracted from the benchmark rate, expressed in basis points. Positive for placements (asset), negative for borrowings (liability).',
    `tenor_days` STRING COMMENT 'Number of calendar days between value date and maturity date. 1 for overnight placements.',
    `trade_date` DATE COMMENT 'The date on which the interbank placement transaction was executed and agreed between the bank and the counterparty.',
    `transaction_direction` STRING COMMENT 'Indicates whether the bank is placing funds with a counterparty (asset) or borrowing funds from a counterparty (liability).. Valid values are `placement|borrowing`',
    `value_date` DATE COMMENT 'The date on which the funds are transferred and the placement becomes effective for interest calculation purposes.',
    CONSTRAINT pk_interbank_placement PRIMARY KEY(`interbank_placement_id`)
) COMMENT 'Transactional record of unsecured interbank money market placements and borrowings (overnight, term, call money) with correspondent banks, central banks, and money market counterparties. Captures counterparty BIC/SWIFT, notional amount, currency, tenor, benchmark rate reference (SOFR, Fed Funds, ESTR), spread, all-in rate, value date, maturity date, rollover status, and settlement status. Feeds into daily liquidity gap analysis, FTP cost-of-funds calculations, and counterparty concentration monitoring. Distinct from repo transactions which are secured funding.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`repo_position` (
    `repo_position_id` BIGINT COMMENT 'Unique identifier for the repurchase agreement position record. Primary key for the repo_position product.',
    `clearing_house_id` BIGINT COMMENT 'Foreign key linking to trade.clearing_house. Business justification: Cleared repos are settled through a CCP. The repo_position.clearing_house is a denormalized string. Linking repo_position to clearing_house supports CCP exposure reporting, initial margin management, ',
    `collateral_asset_id` BIGINT COMMENT 'Reference to the collateral asset pledged or received in the repo transaction.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Repo transactions use fund units as collateral in tri-party arrangements. Treasury must track which funds are pledged, their market value, haircuts, and substitution rights for collateral management a',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Repo positions use securities as collateral. Repo desk operations require linking to the instrument master for accurate collateral valuation, margin calls, haircut application, and regulatory reportin',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: Repo positions require daily mark-to-market valuation of underlying collateral for margin call calculations. The collateral_valuation record captures haircut-adjusted net value, LTV ratio, and valuati',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to payment.correspondent_bank. Business justification: Repo positions with correspondent banks as counterparties need FK to correspondent_bank for credit line monitoring, bilateral exposure limits, and regulatory reporting (SFTR, Basel III leverage ratio)',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Repo desk P&L, FTP funding cost allocation, and management accounting require repo positions to be attributed to a cost center. Treasury operations track repo book P&L by desk/cost center for ALCO per',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Repo counterparty credit ratings drive initial margin, haircut requirements, and exposure limits. repo_position has no FK to counterparty_rating despite carrying counterparty credit risk. Linking enab',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Repo positions denominated in specific currencies for FX exposure and liquidity classification. Link enables currency validation, LCR/NSFR treatment by currency, and cross-currency repo valuation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Repo positions are balance sheet items (assets/liabilities) requiring GL account mapping for GAAP/IFRS reporting, balance sheet classification, and daily mark-to-market accounting entries.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Repo regulatory treatment (rwa_amount, lcr_classification, nsfr_classification) and netting enforceability are jurisdiction-specific. GMRA/GMSLA enforceability varies by jurisdiction. Banking repo des',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Repo positions are booked at legal entity level for regulatory capital (RWA), NSFR classification, and financial statement disclosure. Basel III requires entity-level repo exposure reporting; a direct',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Repo positions are governed by a master repo agreement (GMRA/MRA) modeled as margin_agreement. This link is required for margin call processing, MTA/threshold enforcement, and EMIR/Dodd-Frank regulato',
    `netting_set_id` BIGINT COMMENT 'Identifier for the netting set to which this repo position belongs for credit risk and capital calculation purposes.',
    `party_id` BIGINT COMMENT 'Identifier of the counterparty institution or entity involved in the repo transaction.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Repo positions are secured by pledged collateral. Linking to collateral_pledge enables margin management, LTV monitoring, and Basel III regulatory capital relief calculations. Treasury operations and ',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Repo counterparties must be sanctions-screened before position establishment. OFAC compliance requires linking repo positions to their counterparty sanctions screening event. A compliance officer mana',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Repo settlement_date and maturity_date calculations require the applicable market holiday calendar for business day convention adjustments. Banking repo operations teams must reference the correct set',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Repo positions are managed within specific trading books for P&L attribution and risk limit monitoring. Linking repo_position to trading_book supports book-level repo exposure reporting, VaR calculati',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The interest accrued on the repo position from the settlement date to the current valuation date.',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The reference rate used for floating or indexed repo rates (e.g., SOFR, LIBOR, Fed Funds Rate).',
    `collateral_value` DECIMAL(18,2) COMMENT 'The market value of the collateral asset at the time of the opening leg.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this repo position record was first created in the system.',
    `cumulative_pnl` DECIMAL(18,2) COMMENT 'The cumulative profit or loss on the repo position from inception to the current valuation date.',
    `daily_pnl` DECIMAL(18,2) COMMENT 'The daily profit or loss attributed to this repo position, calculated from mark-to-market changes and accrued interest.',
    `direction` STRING COMMENT 'Indicates whether the position is a repo (cash borrowing, collateral lending) or reverse repo (cash lending, collateral borrowing).. Valid values are `repo|reverse_repo`',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the collateral market value to determine the maximum loan amount, expressed as a percentage (e.g., 2.00 for 2%).',
    `initial_margin_amount` DECIMAL(18,2) COMMENT 'The initial margin or over-collateralization amount required at the opening of the repo position.',
    `lcr_classification` STRING COMMENT 'Classification of the collateral for LCR purposes: HQLA Level 1, HQLA Level 2A, HQLA Level 2B, or non-HQLA.. Valid values are `hqla_level_1|hqla_level_2a|hqla_level_2b|non_hqla`',
    `margin_call_status` STRING COMMENT 'Current status of any outstanding margin call on this repo position: none, pending, satisfied, disputed, or overdue.. Valid values are `none|pending|satisfied|disputed|overdue`',
    `maturity_date` DATE COMMENT 'The scheduled date for the closing leg of the repo transaction when the position unwinds. Null for open repos.',
    `mtm_date` DATE COMMENT 'The date as of which the mark-to-market valuation was calculated.',
    `mtm_valuation` DECIMAL(18,2) COMMENT 'The current mark-to-market valuation of the repo position, reflecting changes in collateral value and accrued interest.',
    `nsfr_classification` STRING COMMENT 'Required Stable Funding (RSF) factor classification for NSFR calculation: 0%, 5%, 10%, 15%, 50%, 65%, 85%, or 100%. [ENUM-REF-CANDIDATE: rsf_0|rsf_5|rsf_10|rsf_15|rsf_50|rsf_65|rsf_85|rsf_100 — 8 candidates stripped; promote to reference product]',
    `position_status` STRING COMMENT 'Current lifecycle status of the repo position: open, closed, matured, terminated, defaulted, or pending settlement.. Valid values are `open|closed|matured|terminated|defaulted|pending_settlement`',
    `principal_amount` DECIMAL(18,2) COMMENT 'The cash amount lent or borrowed in the opening leg of the repo transaction.',
    `rate_type` STRING COMMENT 'Classification of the repo rate structure: fixed, floating (linked to benchmark), or indexed.. Valid values are `fixed|floating|indexed`',
    `regulatory_treatment` STRING COMMENT 'The regulatory accounting treatment applied to the repo position: true sale, secured financing, on-balance-sheet, or off-balance-sheet.. Valid values are `true_sale|secured_financing|on_balance_sheet|off_balance_sheet`',
    `repo_rate` DECIMAL(18,2) COMMENT 'The annualized interest rate applied to the repo transaction, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `repo_type` STRING COMMENT 'Classification of the repurchase agreement structure: classic repo, sell/buy-back, tri-party, hold-in-custody, or bilateral.. Valid values are `classic|sell_buy_back|tri_party|hold_in_custody|bilateral`',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The risk-weighted asset amount calculated for this repo position under Basel III capital requirements.',
    `settlement_date` DATE COMMENT 'The date on which the opening leg of the repo transaction settles (cash and collateral exchange).',
    `settlement_method` STRING COMMENT 'The method used for settling the repo transaction: delivery versus payment (DVP), free of payment (FOP), or hold-in-custody.. Valid values are `dvp|fop|hold_in_custody`',
    `settlement_status` STRING COMMENT 'Current settlement status of the repo transaction legs: pending, settled, failed, or partial.. Valid values are `pending|settled|failed|partial`',
    `spread_bps` DECIMAL(18,2) COMMENT 'The spread in basis points (BPS) added to or subtracted from the benchmark rate for floating-rate repos.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether collateral substitution is permitted under the repo agreement terms.',
    `term_type` STRING COMMENT 'Classification of the repo duration: open (no fixed maturity), term (fixed maturity), or overnight.. Valid values are `open|term|overnight`',
    `termination_date` DATE COMMENT 'Actual date the repo position was terminated or closed, if different from the scheduled maturity date.',
    `trade_date` DATE COMMENT 'The date on which the repo transaction was executed and agreed upon by both parties.',
    `tri_party_agent` STRING COMMENT 'The name of the tri-party agent managing collateral for tri-party repo transactions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this repo position record was last modified in the system.',
    `variation_margin_amount` DECIMAL(18,2) COMMENT 'The cumulative variation margin posted or received due to mark-to-market movements in collateral value.',
    CONSTRAINT pk_repo_position PRIMARY KEY(`repo_position_id`)
) COMMENT 'Master and transactional record for repurchase agreement (repo) and reverse repo operations used for short-term secured funding and liquidity management. Master attributes: repo type (classic, sell/buy-back, tri-party), counterparty, GMRA reference, collateral ISIN, haircut, repo rate, open/term flag, start/end dates, margin call status. Transaction-level attributes: individual opening and closing leg records, settlement amounts, accrued interest, MTM valuation, margin call amounts, settlement status (T+1/T+2), and daily P&L attribution for the repo book. Feeds into treasury funding cost ledger and funding plan execution tracking. Interfaces with collateral domain for substitution and margin management. Post-merge: this is the single source of truth for all repo master and transaction data — replaces former separate repo_transaction product.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`repo_transaction` (
    `repo_transaction_id` BIGINT COMMENT 'Primary key for repo_transaction',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Repo transactions in treasury originate from trade capture events. Linking repo_transaction to capture supports trade lifecycle management, SFTR regulatory reporting, and reconciliation between front-',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Transaction-level tracking of fund units used as repo collateral. Required for daily mark-to-market valuation, margin calls, and settlement processing in securities financing operations. Complements p',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Repo transactions book securities as collateral. Trade booking, settlement, P&L attribution, and regulatory transaction reporting (SFTR, Dodd-Frank) require linking to the canonical instrument record.',
    `correspondent_bank_id` BIGINT COMMENT 'Foreign key linking to payment.correspondent_bank. Business justification: Repo transactions with correspondent banks require FK to correspondent_bank for transaction-level credit exposure tracking, settlement coordination via correspondent nostro accounts, and regulatory tr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Repo transactions settled in specific currencies for settlement and FX risk. Link enables currency validation, settlement lag calculation, and cross-currency repo P&L attribution.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Repo transactions generate accounting entries (cash leg, securities leg, accrued interest) that must be posted to specific GL accounts. Every repo transaction requires a GL account reference for suble',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Repo transactions are executed by specific legal entities and must be attributed for regulatory reporting (SFTR, Basel III), financial statement consolidation, and intercompany elimination. Entity-lev',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Each repo transaction is executed under a master repo/margin agreement governing haircuts, MTA, and netting. SFTR and EMIR reporting require linking individual repo transactions to their governing mar',
    `party_id` BIGINT COMMENT 'Identifier of the external counterparty (bank, broker-dealer, central bank, or institutional investor) in this repo transaction.',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: repo_transaction represents individual transaction legs (opening/closing) under a repo agreement. repo_position is the master/header record for the repo agreement. This is a classic header-line relati',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Repo transactions belong to specific trading books for desk-level P&L and risk reporting. Linking repo_transaction to trading_book supports FRTB capital attribution, repo desk profitability reporting,',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The interest amount accrued on the repo transaction from trade date to the current valuation date or maturity.',
    `booking_system` STRING COMMENT 'The name of the source trading or treasury management system where this repo transaction was originally booked (e.g., Murex, Calypso).',
    `business_unit` STRING COMMENT 'The internal business unit or desk responsible for executing and managing this repo transaction (e.g., Treasury Desk, Fixed Income Trading).',
    `clearing_house` STRING COMMENT 'The name of the central counterparty (CCP) or clearing house used for this repo transaction, if centrally cleared.',
    `collateral_market_value` DECIMAL(18,2) COMMENT 'The current market value of the collateral asset as of the valuation date, used for margin call calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this repo transaction record was first created in the treasury system.',
    `funding_cost_amount` DECIMAL(18,2) COMMENT 'The calculated funding cost for this repo transaction, feeding into the treasury funding cost ledger.',
    `funding_cost_rate` DECIMAL(18,2) COMMENT 'The internal funds transfer pricing (FTP) rate applied to this repo transaction for treasury funding cost allocation.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the market value of collateral to determine the loan amount, mitigating counterparty credit risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this repo transaction record was last updated or modified.',
    `lcr_treatment` STRING COMMENT 'Classification of the collateral for Basel III LCR purposes, determining its eligibility as High-Quality Liquid Assets (HQLA).. Valid values are `hqla_level_1|hqla_level_2a|hqla_level_2b|non_hqla`',
    `leg_type` STRING COMMENT 'Indicates whether this is the opening leg (initial cash/collateral exchange) or closing leg (repurchase/return) of the repo transaction.. Valid values are `opening|closing`',
    `margin_call_amount` DECIMAL(18,2) COMMENT 'The additional collateral or cash amount required to be posted due to adverse market movements or collateral value decline.',
    `margin_call_date` DATE COMMENT 'The date on which a margin call was issued for this repo transaction.',
    `maturity_date` DATE COMMENT 'The date on which the repo transaction matures and the closing leg is due for settlement.',
    `mtm_valuation_amount` DECIMAL(18,2) COMMENT 'The mark-to-market valuation of the repo transaction, reflecting current market conditions and collateral value changes.',
    `mtm_valuation_date` DATE COMMENT 'The date on which the mark-to-market valuation was performed for this repo transaction.',
    `nsfr_treatment` STRING COMMENT 'Required Stable Funding (RSF) factor applied to this repo transaction for Basel III NSFR calculation. [ENUM-REF-CANDIDATE: rsf_0|rsf_5|rsf_10|rsf_15|rsf_50|rsf_65|rsf_85|rsf_100 — 8 candidates stripped; promote to reference product]',
    `pnl_amount` DECIMAL(18,2) COMMENT 'The daily profit or loss attributed to this repo transaction, calculated from interest income, MTM changes, and funding costs.',
    `pnl_attribution_date` DATE COMMENT 'The business date for which the PnL amount was calculated and attributed to the repo book.',
    `principal_amount` DECIMAL(18,2) COMMENT 'The cash amount lent or borrowed in the repo transaction at inception (opening leg).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this repo transaction is subject to regulatory reporting requirements (e.g., EMIR, SFTR, Dodd-Frank).',
    `repo_rate` DECIMAL(18,2) COMMENT 'The annualized interest rate applied to the repo transaction, expressed as a decimal (e.g., 0.0525 for 5.25%).',
    `repurchase_amount` DECIMAL(18,2) COMMENT 'The total amount due at maturity, including principal and accrued interest (closing leg).',
    `settlement_date` DATE COMMENT 'The date on which cash and collateral are exchanged for this transaction leg, typically T+1 or T+2.',
    `settlement_method` STRING COMMENT 'The method by which cash and collateral are exchanged: Delivery versus Payment (DvP), Free of Payment (FoP), or Hold in Custody (HIC).. Valid values are `dvp|fop|hold_in_custody`',
    `trade_date` DATE COMMENT 'The date on which the repo transaction was executed and agreed between counterparties.',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number for this repo transaction leg, used for settlement and reconciliation.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the repo transaction leg in the settlement workflow.. Valid values are `pending|settled|failed|cancelled|matured`',
    `transaction_type` STRING COMMENT 'Specifies whether this is a repo (bank borrows cash, posts collateral) or reverse repo (bank lends cash, receives collateral) from the banks perspective.. Valid values are `repo|reverse_repo`',
    `tri_party_agent` STRING COMMENT 'The name of the tri-party agent (custodian bank) managing collateral allocation and settlement for this repo transaction.',
    CONSTRAINT pk_repo_transaction PRIMARY KEY(`repo_transaction_id`)
) COMMENT 'Individual repo and reverse repo transaction leg records under a repo agreement, capturing opening and closing legs, settlement amounts, accrued interest, MTM valuation, margin call amounts, and settlement status (T+1/T+2). Tracks daily P&L attribution for the repo book and feeds into the treasury funding cost ledger.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`ftp_rate` (
    `ftp_rate_id` BIGINT COMMENT 'Unique identifier for the FTP rate record.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: FTP rates built on benchmark rates (SOFR, SONIA, etc.) for curve construction. Link enables daily rate fixing, benchmark transition management, and spread calculation over risk-free rate.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: FTP rates are assigned to cost centers for internal funds transfer pricing P&L attribution. The existing cost_center_code is a denormalized text reference; a proper FK enables automated FTP rate looku',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: FTP rates constructed by currency for multi-currency balance sheet. Link enables currency-specific curve construction, FX-adjusted NIM allocation, and cross-currency funding cost comparison.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: FTP rates applied to GL account balances for profitability analysis and NIM calculation. FTP allocation process uses GL account balances as basis for transfer pricing charges/credits.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: FTP curves incorporate jurisdiction-specific liquidity premiums and regulatory capital costs (liquidity_premium_bps, credit_spread_bps). Banks operating across jurisdictions maintain separate FTP curv',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: FTP rate methodologies are governed by regulatory obligations (IBOR reform/SOFR transition, benchmark regulation EU BMR, FCA rules). Linking FTP rates to their governing compliance obligation enables ',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: FTP rates vary by product type (deposits, loans, mortgages) for NIM allocation. Link enables product-specific FTP curves, profitability analysis by product, and RAROC calculation.',
    `superseded_by_rate_ftp_rate_id` BIGINT COMMENT 'Reference to the FTP rate that supersedes this rate; null if this is the current active rate.',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: FTP methodology constructs base rates and liquidity premiums directly from yield curves (e.g., OIS curve for risk-free base, credit spread curves for liquidity premium). ALCO-approved FTP frameworks e',
    `alco_approval_date` DATE COMMENT 'Date on which the ALCO formally approved this FTP rate for use.',
    `alco_approval_reference` STRING COMMENT 'Reference number or identifier of the ALCO meeting or decision that approved this rate.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTP rate was formally approved for use.',
    `asset_liability_flag` STRING COMMENT 'Indicates whether this FTP rate applies to asset products (loans, investments) or liability products (deposits, borrowings).. Valid values are `asset|liability`',
    `base_rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the base rate component expressed in basis points (BPS) or percentage.',
    `basis_adjustment_bps` DECIMAL(18,2) COMMENT 'Additional basis point adjustment for market basis risk, cross-currency basis, or other technical adjustments.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the FTP rate was calculated or derived from market data and spread components.',
    `comments` STRING COMMENT 'Free-text field for additional notes, assumptions, or business context related to this FTP rate.',
    `composite_rate_bps` DECIMAL(18,2) COMMENT 'Fully loaded FTP rate in basis points, representing the sum of base rate and all spread components.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTP rate record was first created in the system.',
    `credit_spread_bps` DECIMAL(18,2) COMMENT 'Credit risk adjustment component in basis points, capturing expected credit loss or risk premium.',
    `curve_type` STRING COMMENT 'Classification of the FTP curve component: base rate (market benchmark), liquidity spread (bank-specific liquidity premium), credit spread (credit risk adjustment), or composite (fully loaded rate).. Valid values are `base_rate|liquidity_spread|credit_spread|composite`',
    `effective_date` DATE COMMENT 'Date from which this FTP rate becomes effective and applicable to transactions.',
    `expiration_date` DATE COMMENT 'Date on which this FTP rate ceases to be effective; null for open-ended rates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this FTP rate record was last updated or modified.',
    `line_of_business` STRING COMMENT 'Business line or segment to which this FTP rate is assigned (e.g., retail banking, commercial banking, wealth management).',
    `liquidity_premium_bps` DECIMAL(18,2) COMMENT 'Liquidity spread component in basis points, reflecting the bank-specific cost of funding or liquidity premium.',
    `methodology` STRING COMMENT 'FTP calculation methodology applied: matched-maturity (specific tenor matching), pooled (average cost/yield), or hybrid (combination approach).. Valid values are `matched_maturity|pooled|hybrid`',
    `nim_allocation_flag` BOOLEAN COMMENT 'Indicates whether this FTP rate is used for NIM decomposition and profitability analysis.',
    `optionality_charge_bps` DECIMAL(18,2) COMMENT 'Adjustment in basis points for embedded optionality (e.g., prepayment risk, early withdrawal penalties).',
    `raroc_calculation_flag` BOOLEAN COMMENT 'Indicates whether this FTP rate is used in RAROC calculations for risk-adjusted performance measurement.',
    `rate_code` STRING COMMENT 'Business identifier for the FTP rate, used for external reference and reporting.',
    `rate_description` STRING COMMENT 'Detailed textual description of the FTP rate, including methodology notes, assumptions, and business context.',
    `rate_name` STRING COMMENT 'Descriptive name of the FTP rate for business user identification.',
    `rate_source` STRING COMMENT 'Source system or data provider from which the base rate or spread components were obtained (e.g., Bloomberg, Reuters, internal treasury system).',
    `rate_status` STRING COMMENT 'Current lifecycle status of the FTP rate within the approval and activation workflow.. Valid values are `draft|pending_approval|approved|active|superseded|expired`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this FTP rate is used for regulatory reporting purposes (e.g., CCAR, DFAST, Basel III).',
    `tenor_bucket` STRING COMMENT 'Maturity tenor bucket for the FTP rate, representing the time horizon for funds transfer pricing. [ENUM-REF-CANDIDATE: overnight|1M|3M|6M|1Y|2Y|3Y|5Y|7Y|10Y|15Y|20Y|30Y — 13 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Sequential version number for this FTP rate, incremented with each revision or update.',
    CONSTRAINT pk_ftp_rate PRIMARY KEY(`ftp_rate_id`)
) COMMENT 'Comprehensive Funds Transfer Pricing (FTP) product covering the full FTP lifecycle: internal transfer pricing curve construction, rate definition, and account-level allocation. Curve construction: term structure of internal transfer rates by currency, tenor, and curve type (base rate, liquidity spread, credit spread), built from market benchmarks (SOFR, OIS, swap rates) adjusted for bank-specific liquidity premiums, versioned by effective date and ALCO approval. Rate definition: FTP rates assigned to asset and liability products by tenor bucket, currency, and product type, capturing methodology (matched-maturity, pooled, hybrid), base rate index, spread components (liquidity premium, optionality charge, basis adjustment). Allocation: transactional FTP charge/credit records applied to individual loan, deposit, and investment accounts with notional balance, FTP rate, FTP amount, calculation date, and business line cost center. Enables NIM decomposition and RAROC calculation at product, segment, and LOB level. Post-merge: this is the single source of truth for all FTP methodology, curves, rates, and allocations — replaces former separate transfer_pricing_curve and ftp_allocation products.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`ftp_allocation` (
    `ftp_allocation_id` BIGINT COMMENT 'Unique identifier for the FTP allocation record. Primary key for the FTP allocation transaction.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: FTP allocations are posted in specific accounting periods for period-end P&L close. Linking to accounting_period enables period-end FTP reconciliation, ensures allocations are posted in the correct fi',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Channel profitability reporting requires attributing FTP allocations to the origination channel (branch, digital, ATM). Banks produce channel-level NIM and FTP contribution reports for management acco',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: FTP allocation is fundamentally a cost center P&L exercise — every allocation entry must be attributed to a cost center for management accounting. The existing cost_center_code is denormalized; a prop',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: FTP allocations applied to accounts in specific currencies for P&L attribution. Link enables multi-currency NIM reporting, FX-adjusted profitability analysis, and currency-specific funding cost alloca',
    `deposit_account_id` BIGINT COMMENT 'Reference to the account (loan, deposit, or investment) to which this FTP allocation applies. Links to the specific account receiving the FTP charge or credit.',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: ftp_allocation records apply FTP charges and credits to individual loan, deposit, and investment accounts using rates defined in ftp_rate. The ftp_allocation table currently stores ftp_rate as a denor',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: FTP allocations post to GL accounts for P&L attribution and NIM reporting. Monthly FTP journal entries require proper GL account mapping for financial statement preparation and management reporting.',
    `interest_rate_id` BIGINT COMMENT 'Foreign key linking to account.interest_rate. Business justification: FTP allocation spread analysis requires the customer-facing deposit interest rate alongside the FTP rate. Linking ftp_allocation to account.interest_rate enables direct computation of the customer-rat',
    `onboarding_case_id` BIGINT COMMENT 'Foreign key linking to customer.onboarding_case. Business justification: When a new account is opened via an onboarding case, the initial FTP allocation is created for that account. Treasury operations and finance teams trace FTP allocations back to the originating onboard',
    `original_allocation_ftp_allocation_id` BIGINT COMMENT 'Reference to the original FTP allocation ID if this record is a reversal or adjustment. Null for original allocations.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: FTP P&L is reported at profit center level for business line performance measurement and RAROC calculation. Banks allocate FTP charges/credits to profit centers to measure true business line profitabi',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: FTP allocations applied by product type for P&L attribution. Link enables product hierarchy rollup, profitability reporting by product family, and NIM contribution analysis.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: FTP pricing tiers are segment-driven: treasury and ALCO allocate NIM and measure segment profitability by linking each FTP allocation to the customer segment that determined its pricing tier. The deno',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: FTP allocations are made at the trading book level for desk-level profitability reporting. Linking ftp_allocation to trading_book replaces the denormalized cost_center_code and supports NIM contributi',
    `account_type` STRING COMMENT 'The high-level account type classification indicating whether this is a loan (asset), deposit (liability), or investment account.. Valid values are `loan|deposit|investment|trading_asset|trading_liability`',
    `accrual_days` STRING COMMENT 'The number of days in the accrual period for which the FTP allocation is calculated. Used in conjunction with day_count_convention.',
    `alco_reporting_category` STRING COMMENT 'The ALCO reporting category or classification for this FTP allocation. Used for Asset-Liability Management (ALM) and ALCO reporting purposes.',
    `allocation_status` STRING COMMENT 'The current status of the FTP allocation record in its lifecycle. Indicates whether the allocation is draft, confirmed, posted to the general ledger, reversed, or adjusted.. Valid values are `draft|confirmed|posted|reversed|adjusted`',
    `allocation_type` STRING COMMENT 'Indicates whether this allocation represents an FTP charge (cost to the business line) or an FTP credit (benefit to the business line).. Valid values are `charge|credit`',
    `benchmark_rate` DECIMAL(18,2) COMMENT 'The underlying benchmark rate (e.g., Secured Overnight Financing Rate (SOFR), London Interbank Offered Rate (LIBOR)) used as the basis for the FTP curve. Expressed as a decimal.',
    `business_line_code` STRING COMMENT 'The business line or line of business code to which this FTP allocation is attributed. Used for profitability analysis and Net Interest Margin (NIM) decomposition.',
    `calculation_date` DATE COMMENT 'The business date on which the FTP allocation was calculated. Represents the effective date for the FTP charge or credit.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the FTP allocation. Options include matched maturity, pool-based, hybrid, or single rate approaches.. Valid values are `matched_maturity|pool|hybrid|single_rate`',
    `comments` STRING COMMENT 'Free-text comments or notes related to this FTP allocation. Used for manual adjustments, exceptions, or additional context.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this FTP allocation record was first created in the system. Audit trail field for data lineage and compliance.',
    `credit_adjustment_bps` DECIMAL(18,2) COMMENT 'The credit risk adjustment component in basis points included in the FTP rate. Reflects the Expected Credit Loss (ECL) or credit risk premium.',
    `day_count_convention` STRING COMMENT 'The day count convention used to calculate the FTP amount for the period. Determines how interest accrual days are counted.. Valid values are `actual_360|actual_365|30_360|actual_actual`',
    `economic_capital_amount` DECIMAL(18,2) COMMENT 'The economic capital allocated to this account balance. Used for Risk-Adjusted Return on Capital (RAROC) calculation and capital planning.',
    `ftp_amount` DECIMAL(18,2) COMMENT 'The calculated FTP charge or credit amount in the account currency. Computed as notional_balance × ftp_rate × day_count_fraction.',
    `liquidity_premium_bps` DECIMAL(18,2) COMMENT 'The liquidity premium component in basis points included in the FTP rate. Reflects the cost or benefit of liquidity for the tenor and product type.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this FTP allocation record was last modified. Audit trail field for change tracking and compliance.',
    `nim_contribution` DECIMAL(18,2) COMMENT 'The contribution of this FTP allocation to the overall Net Interest Margin (NIM) for the business line or product. Calculated as FTP amount adjusted for actual interest income or expense.',
    `notional_balance` DECIMAL(18,2) COMMENT 'The principal or notional balance amount of the account on which the FTP rate is applied. Represents the base amount for FTP calculation.',
    `posting_date` DATE COMMENT 'The date on which the FTP allocation was posted to the general ledger. May differ from calculation_date due to accounting period close timing.',
    `regulatory_treatment` STRING COMMENT 'The regulatory treatment classification for the account balance. Determines how the position is treated under Basel III, Fundamental Review of the Trading Book (FRTB), and other regulatory frameworks.. Valid values are `banking_book|trading_book|available_for_sale|held_to_maturity`',
    `reversal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this FTP allocation record is a reversal of a previous allocation. True if this is a reversal entry, False otherwise.',
    `risk_weight_percent` DECIMAL(18,2) COMMENT 'The risk weight percentage applied to this account balance for Risk-Weighted Assets (RWA) calculation. Used in RAROC and capital allocation analysis.',
    `source_system` STRING COMMENT 'Identifier of the source system that originated this FTP allocation record (e.g., Treasury Management System, Core Banking System). Enables data lineage tracking.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The spread in basis points added to or subtracted from the benchmark rate to arrive at the FTP rate. Represents liquidity premium, credit risk adjustment, or other factors.',
    `tenor_bucket` STRING COMMENT 'The maturity tenor bucket used to determine the FTP rate from the FTP curve. Represents the expected duration or repricing period of the account balance. [ENUM-REF-CANDIDATE: overnight|1M|3M|6M|1Y|2Y|3Y|5Y|7Y|10Y|15Y|20Y|30Y — 13 candidates stripped; promote to reference product]',
    CONSTRAINT pk_ftp_allocation PRIMARY KEY(`ftp_allocation_id`)
) COMMENT 'Transactional FTP charge and credit allocation records applied to individual loan, deposit, and investment accounts. Captures the account reference, allocated FTP rate, notional balance, FTP charge or credit amount, tenor bucket, currency, calculation date, and business line cost center. Enables NIM decomposition and RAROC calculation at product, segment, and LOB level.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` (
    `interest_rate_risk_position_id` BIGINT COMMENT 'Unique identifier for the interest rate risk position record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: IRRBB positions (EVE/NII sensitivities) are calculated and reported at each accounting period end for ALCO review and Pillar 2 regulatory reporting. Linking to accounting_period enables period-end IRR',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: IRR positions are tracked by cost center for internal risk attribution and FTP optionality charge allocation. Treasury operations require cost center assignment on IRRBB positions to attribute NII sen',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Interest rate risk measured by currency for duration gap and EVE sensitivity. Link enables currency-specific yield curve shocks, multi-currency ALM reporting, and regulatory interest rate risk reporti',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity for which this interest rate risk position is calculated.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: NII sensitivity from IRRBB is reported at profit center level for business line P&L impact analysis. ALCO requires profit center-level NII sensitivity attribution to understand which business lines dr',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: IRR positions measure NII and EVE sensitivity (nii_sensitivity_amount, eve_sensitivity_amount, yield_curve_risk_amount) against specific benchmark rate curves (SOFR, EURIBOR, SONIA). ALCO and regulato',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: IRRBB (Interest Rate Risk in the Banking Book) positions are reviewed during regulatory examinations (SREP, ILAAP). Examiners assess EVE and NII sensitivities. A banking risk officer would expect IRR ',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: IRRBB positions (EVE, NII sensitivities) are measured under stress test runs per EBA IRRBB guidelines and Basel IRRBB standards. interest_rate_risk_position.stress_test_scenario is a denormalized stri',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: IRRBB positions are aggregated and reported at trading book level. Linking interest_rate_risk_position to trading_book supports desk-level interest rate risk reporting, ALCO review, and Basel IRRBB co',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Basel IRRBB standards require disclosure of which yield curve shock scenarios drove EVE and NII sensitivity calculations. ALCO reporting of IRR positions explicitly references the yield curve applied.',
    `alco_reporting_flag` BOOLEAN COMMENT 'Indicates whether this interest rate risk position is included in ALCO reporting and review.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this interest rate risk position was approved by the responsible authority (e.g., ALCO, Risk Committee).',
    `basis_risk_amount` DECIMAL(18,2) COMMENT 'The exposure arising from imperfect correlation between interest rates earned on assets and paid on liabilities with similar repricing characteristics.',
    `behavioral_assumption_set` STRING COMMENT 'The set of behavioral assumptions applied for non-maturity deposits, prepayment rates, and other customer behavior modeling.',
    `business_unit` STRING COMMENT 'The business unit or line of business to which this interest rate risk position is attributed.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the interest rate risk position (duration gap, simulation, earnings at risk, or economic value approach).. Valid values are `duration_gap|simulation|earnings_at_risk|economic_value`',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations, or commentary regarding this interest rate risk position.',
    `consolidation_level` STRING COMMENT 'The level of aggregation for this interest rate risk position (legal entity, consolidated group, business line, or portfolio).. Valid values are `legal_entity|consolidated|business_line|portfolio`',
    `convexity` DECIMAL(18,2) COMMENT 'The measure of the curvature in the relationship between bond prices and interest rates, capturing the non-linear price sensitivity.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this interest rate risk position record was first created in the system.',
    `data_source_system` STRING COMMENT 'The name or identifier of the source system from which the underlying position data was extracted (e.g., SAS Risk Management, Moodys RiskAuthority).',
    `duration_of_equity` DECIMAL(18,2) COMMENT 'The weighted average time to repricing of the banks equity, measuring the sensitivity of economic value to interest rate changes.',
    `eve_sensitivity_amount` DECIMAL(18,2) COMMENT 'The change in the present value of the banks assets minus liabilities (economic value of equity) resulting from interest rate shocks.',
    `eve_sensitivity_percentage` DECIMAL(18,2) COMMENT 'The percentage change in economic value of equity relative to total equity capital under interest rate shock scenarios.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this interest rate risk position record was last updated or modified.',
    `model_version` STRING COMMENT 'The version identifier of the interest rate risk model used to calculate this position.',
    `modified_duration` DECIMAL(18,2) COMMENT 'The measure of the price sensitivity of the banking book portfolio to a 1% change in interest rates.',
    `nii_sensitivity_amount` DECIMAL(18,2) COMMENT 'The projected change in net interest income over a specified time horizon (typically 12 months) resulting from interest rate shocks.',
    `nii_sensitivity_percentage` DECIMAL(18,2) COMMENT 'The percentage change in net interest income relative to baseline NII under interest rate shock scenarios.',
    `optionality_risk_amount` DECIMAL(18,2) COMMENT 'The exposure arising from embedded options in banking book positions, such as prepayment risk on mortgages or early withdrawal risk on deposits.',
    `portfolio_code` STRING COMMENT 'The code identifying the specific portfolio or book for which this interest rate risk position is calculated.',
    `position_date` DATE COMMENT 'The business date for which this interest rate risk position is calculated and reported.',
    `position_status` STRING COMMENT 'The current status of this interest rate risk position record in the reporting workflow.. Valid values are `draft|preliminary|final|approved|superseded`',
    `rate_sensitive_assets_amount` DECIMAL(18,2) COMMENT 'The total value of assets that will reprice or mature within the specified time bucket.',
    `rate_sensitive_liabilities_amount` DECIMAL(18,2) COMMENT 'The total value of liabilities that will reprice or mature within the specified time bucket.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this interest rate risk position is included in regulatory reporting submissions.',
    `repricing_gap_amount` DECIMAL(18,2) COMMENT 'The net difference between rate-sensitive assets and rate-sensitive liabilities within a specific time bucket, representing the exposure to interest rate changes.',
    `shock_scenario_type` STRING COMMENT 'The interest rate shock scenario applied to calculate sensitivity metrics, expressed in basis points (bps) parallel shift.. Valid values are `parallel_up_100bps|parallel_down_100bps|parallel_up_200bps|parallel_down_200bps|parallel_up_300bps|parallel_down_300bps`',
    `time_bucket` STRING COMMENT 'The repricing or maturity time band used to classify rate-sensitive positions for gap analysis. [ENUM-REF-CANDIDATE: overnight|1_7_days|8_30_days|31_90_days|91_180_days|181_365_days|1_2_years|2_3_years|3_5_years|5_10_years|over_10_years — 11 candidates stripped; promote to reference product]',
    `var_amount` DECIMAL(18,2) COMMENT 'The maximum potential loss in economic value from interest rate movements over a specified time horizon at a given confidence level.',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'The statistical confidence level (e.g., 95%, 99%) used to calculate the VaR metric.',
    `var_time_horizon_days` STRING COMMENT 'The number of days over which the VaR is calculated (e.g., 1-day, 10-day).',
    `yield_curve_risk_amount` DECIMAL(18,2) COMMENT 'The exposure arising from changes in the slope and shape of the yield curve, affecting assets and liabilities with different maturity profiles.',
    CONSTRAINT pk_interest_rate_risk_position PRIMARY KEY(`interest_rate_risk_position_id`)
) COMMENT 'Interest rate risk (IRR) position record capturing the banks repricing gap, duration of equity, Economic Value of Equity (EVE) sensitivity, and Net Interest Income (NII) sensitivity across rate shock scenarios (+/-100bps, +/-200bps, +/-300bps). Produced at legal entity and consolidated level for ALCO review and regulatory reporting under BCBS 368 (IRRBB). Tracks basis risk, yield curve risk, and optionality risk components.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`capital_ratio` (
    `capital_ratio_id` BIGINT COMMENT 'Unique identifier for the capital ratio record. Primary key for the capital ratio data product.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Capital ratios (CET1, Tier 1, Total Capital) are calculated at each accounting period end for Basel III regulatory submissions (COREP) and financial statement disclosure. Linking to accounting_period ',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: capital_ratio records the actual/current regulatory capital ratios (CET1, Tier 1, Total Capital). capital_plan is the multi-year capital planning record capturing projected CET1 ratios and RWA growth ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Capital ratios calculated per regulatory jurisdiction for Basel compliance. Link enables jurisdiction-specific capital buffers (CCyB, G-SIB), CCAR/DFAST applicability, and regulatory submission routin',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity for which capital ratios are calculated. Links to the legal entity master.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Capital ratio calculations (CET1, Tier 1, leverage) are reviewed during regulatory examinations (SREP, CCAR) distinct from the regulatory filing. Examiners assess RWA methodology and capital adequacy.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Capital ratios are reported in Call Reports (FFIEC 031/041), FR Y-9C, and Basel III reports. Direct linkage enables audit trail from calculated ratio to submitted filing, essential for regulatory comp',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Capital ratios reported in regulatory currency (USD for US banks, EUR for EU banks). Link enables multi-entity consolidation, FX revaluation for group reporting, and regulatory submission validation.',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Capital ratio records produced under stress scenarios (CCAR, ICAAP) reference the specific stress test run that generated them. Regulatory capital reporting requires traceability from stressed capital',
    `alco_target_cet1_ratio` DECIMAL(18,2) COMMENT 'The internal ALCO-approved target CET1 ratio, typically set above regulatory minimums to provide a management buffer for business volatility and growth.',
    `approval_status` STRING COMMENT 'The approval status of the capital ratio calculation and capital plan within the internal governance process.. Valid values are `draft|pending_review|approved|rejected|resubmitted`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this capital ratio record was approved by the authorized approver.',
    `at1_trigger_breach_flag` BOOLEAN COMMENT 'Indicates whether the CET1 ratio has breached the contractual trigger level for AT1 instrument write-down or conversion (typically 5.125% or 7.0% depending on instrument terms).',
    `calculation_method` STRING COMMENT 'The methodology used to calculate credit risk RWA: Standardized Approach (SA), Internal Ratings-Based Foundation (IRB-F), or Internal Ratings-Based Advanced (IRB-A).. Valid values are `standardized_approach|irb_foundation|irb_advanced`',
    `capital_conservation_buffer` DECIMAL(18,2) COMMENT 'The capital conservation buffer requirement, expressed as a percentage of RWA. Standard requirement is 2.5% of RWA in CET1 capital above the minimum.',
    `capital_issuance_amount` DECIMAL(18,2) COMMENT 'The amount of new capital issuance (common equity, AT1, or Tier 2 instruments) planned or executed during the reporting period.',
    `capital_redemption_amount` DECIMAL(18,2) COMMENT 'The amount of capital instrument redemptions (AT1 or Tier 2 instruments) planned or executed during the reporting period.',
    `cet1_buffer_amount` DECIMAL(18,2) COMMENT 'The absolute amount of CET1 capital held above the minimum regulatory requirement plus buffers, representing the management buffer or excess capital.',
    `cet1_capital_amount` DECIMAL(18,2) COMMENT 'The total Common Equity Tier 1 capital amount, representing the highest quality capital consisting of common shares, retained earnings, and other comprehensive income, net of regulatory adjustments.',
    `cet1_ratio` DECIMAL(18,2) COMMENT 'The CET1 capital ratio, calculated as CET1 capital divided by total RWA, expressed as a percentage. Regulatory minimum is 4.5% under Basel III.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the capital ratio calculation, assumptions, or capital actions for this reporting period.',
    `consolidation_level` STRING COMMENT 'Indicates whether the capital ratio is calculated at consolidated group level, solo legal entity level, or sub-consolidated level.. Valid values are `consolidated|solo|sub_consolidated`',
    `countercyclical_buffer` DECIMAL(18,2) COMMENT 'The countercyclical capital buffer requirement, expressed as a percentage of RWA. Ranges from 0% to 2.5% and varies by jurisdiction based on credit cycle conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this capital ratio record was first created in the system.',
    `credit_rwa_amount` DECIMAL(18,2) COMMENT 'Risk-weighted assets arising from credit risk exposures, calculated using either the Standardized Approach (SA) or Internal Ratings-Based (IRB) approach.',
    `gsib_surcharge` DECIMAL(18,2) COMMENT 'The additional capital surcharge for Global Systemically Important Banks, ranging from 1.0% to 3.5% of RWA based on systemic importance score.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this capital ratio record was last modified or updated.',
    `leverage_ratio` DECIMAL(18,2) COMMENT 'The leverage ratio, calculated as Tier 1 capital divided by total exposure measure (on- and off-balance sheet exposures), expressed as a percentage. Regulatory minimum is 3.0% under Basel III.',
    `market_rwa_amount` DECIMAL(18,2) COMMENT 'Risk-weighted assets arising from market risk exposures in the trading book, calculated under the Fundamental Review of the Trading Book (FRTB) or legacy market risk framework.',
    `operational_rwa_amount` DECIMAL(18,2) COMMENT 'Risk-weighted assets arising from operational risk, calculated using the Standardized Measurement Approach (SMA) or legacy approaches.',
    `planned_buyback_amount` DECIMAL(18,2) COMMENT 'The planned share repurchase amount for the reporting period under the capital plan.',
    `planned_dividend_amount` DECIMAL(18,2) COMMENT 'The planned common stock dividend distribution amount for the reporting period under the capital plan.',
    `projected_cet1_ratio_year1` DECIMAL(18,2) COMMENT 'The projected CET1 ratio for the first year of the capital planning horizon under the specified scenario.',
    `projected_cet1_ratio_year2` DECIMAL(18,2) COMMENT 'The projected CET1 ratio for the second year of the capital planning horizon under the specified scenario.',
    `projected_cet1_ratio_year3` DECIMAL(18,2) COMMENT 'The projected CET1 ratio for the third year of the capital planning horizon under the specified scenario.',
    `projected_rwa_growth_rate` DECIMAL(18,2) COMMENT 'The assumed annual growth rate for RWA in the capital planning scenario, expressed as a percentage.',
    `regulatory_minimum_cet1_ratio` DECIMAL(18,2) COMMENT 'The applicable regulatory minimum CET1 ratio including all buffers, representing the threshold below which capital distribution restrictions apply.',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Indicates whether this capital ratio record was submitted to regulatory authorities as part of formal reporting (CCAR, DFAST, Basel III Pillar 3).',
    `reporting_date` DATE COMMENT 'The date for which the capital ratio is calculated and reported. Typically month-end or quarter-end for regulatory submissions.',
    `reporting_period` STRING COMMENT 'The reporting period identifier in format YYYY-QN for quarterly or YYYY-MNN for monthly reporting cycles.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `scenario_type` STRING COMMENT 'The stress scenario or planning scenario under which the capital ratio is calculated. Actual represents current position, base/adverse/severely_adverse represent CCAR/DFAST stress scenarios.. Valid values are `actual|base|adverse|severely_adverse|management_buffer`',
    `source_system` STRING COMMENT 'The name of the source system from which the capital ratio data was extracted, typically the Risk Management Platform or Regulatory Reporting Platform.',
    `submission_date` DATE COMMENT 'The date on which this capital ratio was submitted to regulatory authorities.',
    `tier1_capital_amount` DECIMAL(18,2) COMMENT 'The total Tier 1 capital amount, comprising CET1 capital plus Additional Tier 1 (AT1) instruments such as perpetual non-cumulative preferred stock.',
    `tier1_ratio` DECIMAL(18,2) COMMENT 'The Tier 1 capital ratio, calculated as Tier 1 capital divided by total RWA, expressed as a percentage. Regulatory minimum is 6.0% under Basel III.',
    `tier2_capital_amount` DECIMAL(18,2) COMMENT 'The total Tier 2 capital amount, comprising subordinated debt, hybrid instruments, and loan loss reserves up to regulatory limits.',
    `total_buffer_requirement` DECIMAL(18,2) COMMENT 'The sum of all capital buffer requirements (conservation, countercyclical, G-SIB surcharge), expressed as a percentage of RWA.',
    `total_capital_amount` DECIMAL(18,2) COMMENT 'The sum of Tier 1 and Tier 2 capital, representing the total regulatory capital available to absorb losses.',
    `total_capital_ratio` DECIMAL(18,2) COMMENT 'The total capital ratio, calculated as total capital divided by total RWA, expressed as a percentage. Regulatory minimum is 8.0% under Basel III.',
    `total_exposure_measure` DECIMAL(18,2) COMMENT 'The total exposure measure used in the leverage ratio calculation, comprising on-balance sheet exposures, derivative exposures, securities financing transaction exposures, and off-balance sheet items.',
    `total_rwa_amount` DECIMAL(18,2) COMMENT 'The sum of credit, market, and operational risk-weighted assets, representing the total risk exposure for capital adequacy calculation.',
    CONSTRAINT pk_capital_ratio PRIMARY KEY(`capital_ratio_id`)
) COMMENT 'Regulatory capital adequacy and planning record capturing current capital ratios (CET1, Tier 1, Total Capital), Risk-Weighted Assets by risk type (credit, market, operational), leverage ratio, and capital buffers (conservation, countercyclical, G-SIB surcharge) at legal entity and consolidated level. Includes multi-year capital planning: projected CET1 trajectories, RWA growth assumptions, dividend/buyback plans, stress scenario capital paths, and capital actions (issuance, redemption, AT1 triggers) under base and adverse scenarios. Produced for CCAR, DFAST, and Basel III Pillar 1 regulatory submissions. Tracks ALCO-approved capital targets and management buffers above regulatory minimums. Post-merge: this is the single source of truth for capital ratios and capital planning — replaces former separate capital_plan product. Note: potential SSOT overlap with risk domain capital/RWA products requires global architect adjudication.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`capital_plan` (
    `capital_plan_id` BIGINT COMMENT 'Unique identifier for the capital plan record. Primary key for the capital plan entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Capital plans prepared for specific reporting periods must align with accounting period close cycles for CCAR/DFAST submissions and board reporting. Links capital planning to fiscal calendar.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: capital_plan has a denormalized currency_code (plain text) for capital projections (planned_capital_issuance_amount, net_income_projection). Normalizing to reference.currency.currency_id enforces refe',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Capital plans are prepared per regulatory jurisdiction (Fed CCAR, ECB SREP, PRA ICAAP). The regulatory_minimum_cet1_ratio and stress scenarios are jurisdiction-specific. Banking capital planning teams',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Capital plans (ICAAP, CCAR/DFAST) are entity-specific regulatory documents submitted per legal entity. The existing legal_entity_identifier is a denormalized text field; a proper FK to legal_entity is',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Capital plans are governed by specific regulatory obligations (Basel III CET1 requirements, CCAR/DFAST rules, ICAAP guidelines). Linking capital plans to their governing obligation enables compliance ',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Capital plans (CCAR, DFAST, ICAAP) are submitted to and reviewed during regulatory examinations. Examiners assess capital adequacy projections and stress scenarios. Banking supervisors expect capital ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Capital plans are built against specific stress scenarios (baseline, adverse, severely adverse per CCAR/ICAAP). capital_plan.scenario_type is a denormalized representation of the stress_scenario entit',
    `alco_approved_target_cet1_ratio` DECIMAL(18,2) COMMENT 'Internal target CET1 ratio approved by the Asset-Liability Committee, typically above regulatory minimums to provide a management buffer.',
    `at1_trigger_threshold` DECIMAL(18,2) COMMENT 'CET1 ratio threshold at which Additional Tier 1 capital instruments would be written down or converted, expressed as a percentage.',
    `baseline_cet1_ratio` DECIMAL(18,2) COMMENT 'Starting Common Equity Tier 1 capital ratio at the beginning of the planning horizon, expressed as a percentage.',
    `baseline_rwa_amount` DECIMAL(18,2) COMMENT 'Starting Risk-Weighted Assets amount at the beginning of the planning horizon, in millions of base currency.',
    `capital_action_description` STRING COMMENT 'Narrative description of planned capital actions including issuances, redemptions, dividends, and buybacks over the planning horizon.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the capital plan, including rationale for key assumptions or regulatory feedback.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital plan record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital plan record was last modified or updated.',
    `management_buffer_above_minimum` DECIMAL(18,2) COMMENT 'Management buffer maintained above the regulatory minimum CET1 ratio, expressed as percentage points.',
    `methodology_description` STRING COMMENT 'Description of the methodologies, models, and assumptions used to develop the capital plan projections.',
    `minimum_cet1_ratio_stressed` DECIMAL(18,2) COMMENT 'Lowest projected CET1 ratio during the planning horizon under the stress scenario, representing the trough capital level.',
    `net_income_projection` DECIMAL(18,2) COMMENT 'Projected net income over the planning horizon under the specified scenario, in millions of base currency.',
    `plan_name` STRING COMMENT 'Descriptive name of the capital plan (e.g., 2024 CCAR Base Scenario, 2025 Annual Capital Plan).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the capital plan in the regulatory submission and approval process.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `plan_version` STRING COMMENT 'Version identifier for the capital plan to track revisions and resubmissions (e.g., v1.0, v2.1 Revised).',
    `planned_capital_issuance_amount` DECIMAL(18,2) COMMENT 'Total planned capital issuance (common equity, preferred stock, subordinated debt) over the planning horizon, in millions of base currency.',
    `planned_capital_redemption_amount` DECIMAL(18,2) COMMENT 'Total planned capital redemptions (preferred stock, subordinated debt) over the planning horizon, in millions of base currency.',
    `planned_common_stock_dividend_amount` DECIMAL(18,2) COMMENT 'Total planned common stock dividend distributions over the planning horizon, in millions of base currency.',
    `planned_dividend_payout_ratio` DECIMAL(18,2) COMMENT 'Planned dividend payout ratio as a percentage of net income over the planning horizon.',
    `planned_share_buyback_amount` DECIMAL(18,2) COMMENT 'Total planned share repurchase amount over the planning horizon, in millions of base currency.',
    `planning_horizon_end_date` DATE COMMENT 'End date of the multi-year capital planning horizon covered by this plan.',
    `planning_horizon_start_date` DATE COMMENT 'Start date of the multi-year capital planning horizon covered by this plan.',
    `pre_provision_net_revenue_projection` DECIMAL(18,2) COMMENT 'Projected pre-provision net revenue over the planning horizon under the specified scenario, in millions of base currency.',
    `projected_cet1_ratio_year_1` DECIMAL(18,2) COMMENT 'Projected CET1 capital ratio at the end of year 1 under the specified scenario, expressed as a percentage.',
    `projected_cet1_ratio_year_2` DECIMAL(18,2) COMMENT 'Projected CET1 capital ratio at the end of year 2 under the specified scenario, expressed as a percentage.',
    `projected_cet1_ratio_year_3` DECIMAL(18,2) COMMENT 'Projected CET1 capital ratio at the end of year 3 under the specified scenario, expressed as a percentage.',
    `projected_rwa_growth_rate_year_1` DECIMAL(18,2) COMMENT 'Projected annual growth rate of RWA in year 1, expressed as a percentage.',
    `projected_rwa_growth_rate_year_2` DECIMAL(18,2) COMMENT 'Projected annual growth rate of RWA in year 2, expressed as a percentage.',
    `projected_rwa_growth_rate_year_3` DECIMAL(18,2) COMMENT 'Projected annual growth rate of RWA in year 3, expressed as a percentage.',
    `provision_for_credit_losses_projection` DECIMAL(18,2) COMMENT 'Projected provision for credit losses over the planning horizon under the specified scenario, in millions of base currency.',
    `regulatory_minimum_cet1_ratio` DECIMAL(18,2) COMMENT 'Regulatory minimum CET1 ratio requirement applicable to the institution, expressed as a percentage.',
    `reporting_entity_name` STRING COMMENT 'Legal name of the bank holding company or financial institution submitting the capital plan.',
    `stress_loss_projection_amount` DECIMAL(18,2) COMMENT 'Total projected losses under the stress scenario over the planning horizon, in millions of base currency.',
    `submission_date` DATE COMMENT 'Date the capital plan was submitted to the Federal Reserve for CCAR/DFAST review.',
    CONSTRAINT pk_capital_plan PRIMARY KEY(`capital_plan_id`)
) COMMENT 'Multi-year capital planning record capturing projected CET1 ratios, RWA growth assumptions, dividend and buyback plans, stress scenario capital trajectories, and capital actions (issuance, redemption, AT1 triggers) under base and adverse scenarios. Submitted to the Federal Reserve as part of CCAR/DFAST annual capital planning cycle. Tracks ALCO-approved capital targets and management buffers above regulatory minimums.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`funding_plan` (
    `funding_plan_id` BIGINT COMMENT 'Unique identifier for the funding plan record. Primary key for the funding plan entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Funding plans executed within specific accounting periods for budget tracking, variance analysis, and cost of funds reporting. Links funding strategy to fiscal period performance measurement.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Funding plans for floating rate instruments reference specific benchmarks for target cost-of-funds calculations and hedging strategy. IBOR transition requires tracking benchmark references in funding ',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: funding_plan captures the treasury funding strategy and debt issuance plan. capital_plan is the multi-year capital planning record that governs overall balance sheet optimization including funding mix',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Funding plans specify issuance currency for debt issuance strategy. Link enables multi-currency funding diversification, FX hedging decisions, and currency-specific cost of funds analysis.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Funding plans are jurisdiction-specific due to TLAC/MREL requirements, regulatory_capital_treatment, and lcr_treatment/nsfr_treatment rules that differ by jurisdiction. Banking treasury teams prepare ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Funding plans are managed at legal entity level for ALCO approval and regulatory liquidity reporting. The existing legal_entity_identifier is denormalized text; a proper FK enables entity-level fundin',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Funding plans are governed by NSFR, LCR, and liquidity coverage regulatory obligations. Linking funding plans to their governing compliance obligation enables tracking of regulatory requirement covera',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: funding_plan has a denormalized reference_rate (plain text) for floating-rate issuances. Normalizing to reference.rate_benchmark.rate_benchmark_id enables proper IBOR transition tracking and benchmark',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Funding plans (NSFR, liquidity stress) are reviewed during regulatory examinations (ILAAP, ILSA). Examiners assess funding stability and concentration. Treasury professionals expect funding plans to b',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Funding plans are stress-tested against specific liquidity and credit stress scenarios for contingency funding planning (CFP). funding_plan.scenario_type is a denormalized representation. Linking to s',
    `actual_cost_of_funds_rate` DECIMAL(18,2) COMMENT 'Actual realized all-in cost of funds rate for this instrument type during the plan period, expressed as a decimal. Tracks execution vs. target pricing.',
    `actual_issuance_amount` DECIMAL(18,2) COMMENT 'Actual notional amount raised through this funding instrument during the plan period, in the plans base currency. Tracks execution vs. plan.',
    `approved_by` STRING COMMENT 'Name or identifier of the ALCO member or executive who approved the funding plan.',
    `business_unit` STRING COMMENT 'Business unit or line of business (LOB) responsible for managing this funding plan or debt issuance (e.g., Corporate Treasury, Capital Markets, Retail Banking).',
    `call_date` DATE COMMENT 'Earliest date on which the issuer can exercise the call option to redeem the debt instrument. Null if not callable.',
    `call_feature_flag` BOOLEAN COMMENT 'Indicates whether the debt instrument includes a call feature allowing the issuer to redeem the instrument before maturity. True if callable, False otherwise.',
    `comments` STRING COMMENT 'Free-text field for additional notes, commentary, or context regarding the funding plan or specific issuance (e.g., market conditions, strategic rationale, execution challenges).',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable percentage of total funding that can be sourced from this instrument type, as defined by ALCO policy. Used to enforce diversification and concentration risk limits.',
    `counterparty_concentration_limit` DECIMAL(18,2) COMMENT 'Maximum notional amount that can be sourced from a single counterparty or investor group for this instrument type, in the plans base currency. Enforces counterparty concentration risk limits.',
    `coupon_rate` DECIMAL(18,2) COMMENT 'Annual coupon rate for the debt instrument, expressed as a decimal (e.g., 0.0425 for 4.25%). For floating-rate instruments, this represents the spread over the reference rate.',
    `coupon_type` STRING COMMENT 'Type of coupon structure for the debt instrument: fixed (constant rate), floating (variable rate linked to benchmark), zero-coupon (no periodic interest), step-up (increasing rate schedule), callable (issuer redemption option), or puttable (investor redemption option).. Valid values are `fixed|floating|zero_coupon|step_up|callable|puttable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this funding plan record was first created in the system. ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `cusip` STRING COMMENT 'Committee on Uniform Securities Identification Procedures (CUSIP) identifier for the specific debt issuance, if applicable. 9-character alphanumeric code used in North America.. Valid values are `^[0-9]{3}[A-Z0-9]{5}[0-9]$`',
    `instrument_type` STRING COMMENT 'Type of funding instrument covered by this plan entry (e.g., senior unsecured bonds, covered bonds, Federal Home Loan Bank (FHLB) advances, repurchase agreements (repo), retail deposits, commercial paper (CP), certificates of deposit (CDs), subordinated debt). [ENUM-REF-CANDIDATE: senior_unsecured|covered_bonds|fhlb_advances|repo|deposits|commercial_paper|certificates_of_deposit|subordinated_debt|tier2_capital|preferred_stock — promote to reference product]',
    `isin` STRING COMMENT 'International Securities Identification Number (ISIN) for the specific debt issuance, if applicable. 12-character alphanumeric code (ISO 6166 standard).. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `issuance_date` DATE COMMENT 'Actual date on which the debt instrument was issued to investors. Represents the trade date for the issuance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this funding plan record was last updated in the system. ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `lcr_treatment` STRING COMMENT 'Classification of the funding source for Liquidity Coverage Ratio (LCR) calculation purposes: stable (retail deposits with low run-off), less-stable (higher run-off), operational (operational deposits), non-operational (wholesale funding), or excluded (not included in LCR).. Valid values are `stable|less_stable|operational|non_operational|excluded`',
    `listing_exchange` STRING COMMENT 'Name of the stock exchange or trading venue where the debt instrument is listed (e.g., New York Stock Exchange (NYSE), London Stock Exchange (LSE), Luxembourg Stock Exchange). Null if unlisted.',
    `maturity_date` DATE COMMENT 'Scheduled maturity date of the debt instrument, when principal repayment is due. May be subject to call/put features.',
    `notional_outstanding` DECIMAL(18,2) COMMENT 'Current outstanding notional principal amount of the debt instrument, in the instruments currency. Tracks amortization and prepayments.',
    `nsfr_treatment` STRING COMMENT 'Classification of the funding source for Net Stable Funding Ratio (NSFR) calculation purposes: stable (high available stable funding factor), less-stable (lower factor), wholesale (institutional funding), or excluded (not included in NSFR).. Valid values are `stable|less_stable|wholesale|excluded`',
    `plan_name` STRING COMMENT 'Business name or title of the funding plan (e.g., FY2024 Q2 Wholesale Funding Strategy, 2024 Annual Debt Issuance Plan).',
    `plan_period_end_date` DATE COMMENT 'The effective end date of the funding plan period (e.g., end of fiscal quarter or year).',
    `plan_period_start_date` DATE COMMENT 'The effective start date of the funding plan period (e.g., beginning of fiscal quarter or year).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the funding plan: draft (under development), approved (ALCO-approved), active (in execution), executed (fully completed), closed (archived), or cancelled (terminated before execution).. Valid values are `draft|approved|active|executed|closed|cancelled`',
    `plan_type` STRING COMMENT 'Classification of the funding plan by strategic purpose: wholesale (institutional funding), retail (deposit-based), hybrid (mixed sources), contingency (stress scenario), or strategic (long-term capital structure).. Valid values are `wholesale|retail|hybrid|contingency|strategic`',
    `put_date` DATE COMMENT 'Earliest date on which the investor can exercise the put option to demand redemption. Null if not puttable.',
    `put_feature_flag` BOOLEAN COMMENT 'Indicates whether the debt instrument includes a put feature allowing the investor to demand early redemption. True if puttable, False otherwise.',
    `regulatory_capital_treatment` STRING COMMENT 'Classification of the funding instrument for regulatory capital purposes: Common Equity Tier 1 (CET1), Additional Tier 1 (Tier1), Tier 2 (Tier2), non-capital (does not qualify), or excluded (not applicable).. Valid values are `cet1|tier1|tier2|non_capital|excluded`',
    `target_cost_of_funds_rate` DECIMAL(18,2) COMMENT 'Planned or target all-in cost of funds rate for this instrument type, expressed as a decimal (e.g., 0.0325 for 3.25% or 325 basis points). Includes coupon, fees, and issuance costs.',
    `target_issuance_amount` DECIMAL(18,2) COMMENT 'Planned or target notional amount to be raised through this funding instrument during the plan period, in the plans base currency.',
    `target_maturity_profile` STRING COMMENT 'Planned maturity profile for the funding instrument: short-term (< 1 year), medium-term (1-5 years), long-term (> 5 years), perpetual (no maturity), or mixed (diversified maturities).. Valid values are `short_term|medium_term|long_term|perpetual|mixed`',
    `target_weighted_average_maturity_years` DECIMAL(18,2) COMMENT 'Planned weighted average maturity of the funding instrument issuances, expressed in years. Used for maturity ladder and duration management.',
    `underwriter_name` STRING COMMENT 'Name of the lead underwriter or bookrunner for the debt issuance (e.g., investment bank managing the offering).',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between actual and target issuance amounts (actual minus target). Positive indicates over-execution; negative indicates under-execution.',
    CONSTRAINT pk_funding_plan PRIMARY KEY(`funding_plan_id`)
) COMMENT 'Treasury funding strategy, execution, and debt issuance record capturing the banks wholesale and retail funding plan by instrument type (senior unsecured, covered bonds, FHLB advances, repo, deposits, commercial paper, CDs), target issuance volumes, maturity profile, currency mix, and cost-of-funds targets. Includes individual debt issuance execution records: ISIN/CUSIP, issuance date, maturity, coupon type/rate, currency, notional outstanding, underwriter, listing exchange, call/put features, and outstanding balance tracking. Tracks actual vs. planned funding execution, concentration limits by counterparty and instrument, and feeds into the funding maturity profile and capital structure reporting. Approved by ALCO and updated quarterly. Post-merge: this is the single source of truth for funding strategy and debt issuance — replaces former separate debt_issuance product.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`debt_issuance` (
    `debt_issuance_id` BIGINT COMMENT 'Unique identifier for the debt issuance record. Primary key for the debt issuance product.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Floating rate debt issuances reference specific benchmarks (SOFR, EURIBOR) for coupon calculation. IBOR transition programs require tracking which benchmark each issuance references. Treasury teams us',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Debt issuances denominated in specific currencies for funding and NSFR. Link enables currency validation, FX hedging, NSFR ASF calculation by currency, and multi-currency funding cost reporting.',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Debt issuance is the execution of a funding plan. The funding_plan product captures the strategic funding plan (target_issuance_amount, target_maturity_profile, target_cost_of_funds_rate), while debt_',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Debt issuances are liabilities requiring GL account mapping for financial reporting, coupon payment accounting, amortization of issuance costs, and balance sheet presentation per GAAP/IFRS.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Debt issuances by the bank ARE securities that must be registered in the instrument master. Funding desk operations, investor relations, prospectus management, regulatory capital reporting (own credit',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: The banks own debt issuances are registered as issuer records in the security master for market data, rating agency tracking, and investor relations. Linking debt_issuance to the banks issuer record',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Debt issuances are governed by jurisdiction-specific prospectus regulations, regulatory_capital_treatment (Tier 2, AT1 eligibility under CRR/Basel), and listing rules. Banking capital markets and trea',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Debt issuances are legal obligations of specific legal entities disclosed in financial statements and regulatory capital reports. The existing legal_entity_identifier is denormalized text; a proper FK',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Debt issuances must comply with specific regulatory obligations (prospectus disclosure rules, covered bond regulations, TLAC/MREL requirements). Linking each issuance to its governing compliance oblig',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: debt_issuance has a denormalized reference_rate (plain text) for floating-rate bonds. Normalizing to reference.rate_benchmark.rate_benchmark_id is essential for IBOR transition management (tracking LI',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Debt issuances require regulatory filings (SEC 424B prospectus, covered bond reporting, TRACE reporting). A debt capital markets professional would expect each issuance to reference its associated reg',
    `booking_system` STRING COMMENT 'Name of the source system where the debt issuance was originally recorded (e.g., Murex, Calypso, Bloomberg AIM). Used for data lineage and reconciliation.',
    `business_unit` STRING COMMENT 'Internal business unit or line of business responsible for managing this debt issuance. Typically Treasury or Corporate Finance.',
    `call_date` DATE COMMENT 'First date on which the issuer may exercise the call option to redeem the debt instrument early. Applicable only when callable_flag is true.',
    `call_price` DECIMAL(18,2) COMMENT 'Price at which the issuer may redeem the debt instrument if the call option is exercised, expressed as a percentage of par value. May include call premium.',
    `callable_flag` BOOLEAN COMMENT 'Indicates whether the issuer has the right to redeem the debt instrument before maturity. True if call option exists; false otherwise.',
    `coupon_rate` DECIMAL(18,2) COMMENT 'Annual interest rate paid on the debt instrument expressed as a decimal percentage. For floating rate instruments, represents the current rate or initial rate at issuance.',
    `coupon_type` STRING COMMENT 'Classification of the interest payment structure. Fixed rate remains constant; floating rate resets periodically based on reference rate; zero coupon pays no periodic interest.. Valid values are `fixed|floating|zero_coupon|step_up|inflation_linked`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this debt issuance record was first created in the system. Used for audit trail and data lineage.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the debt instrument by the rating agency. Reflects the agencys assessment of credit risk and default probability.',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency that assigned the rating to this debt issuance (e.g., Moodys, S&P, Fitch). Multiple agencies may rate the same instrument.',
    `green_bond_flag` BOOLEAN COMMENT 'Indicates whether the debt issuance qualifies as a green bond with proceeds dedicated to environmentally beneficial projects. True if certified green bond; false otherwise.',
    `issuance_date` DATE COMMENT 'Date on which the debt instrument was issued and funds were received by the bank. Settlement date for the issuance transaction.',
    `issuance_status` STRING COMMENT 'Current lifecycle status of the debt issuance from planning through maturity or early termination. [ENUM-REF-CANDIDATE: planned|priced|issued|outstanding|matured|called|defaulted — 7 candidates stripped; promote to reference product]',
    `issue_price` DECIMAL(18,2) COMMENT 'Price at which the debt instrument was issued, expressed as a percentage of par value. Values below 100 indicate discount; above 100 indicate premium.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this debt issuance record was last updated. Tracks the most recent change to any attribute for audit and reconciliation purposes.',
    `lcr_treatment` STRING COMMENT 'Classification of the debt issuance for LCR calculation purposes. Indicates the outflow rate assumption and time bucket for liquidity stress testing.',
    `listing_exchange` STRING COMMENT 'Name of the securities exchange where the debt instrument is listed for trading (e.g., NYSE, LSE, SGX). Null if unlisted or privately placed.',
    `maturity_date` DATE COMMENT 'Scheduled date on which the principal amount of the debt instrument becomes due and payable in full.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Original principal amount of the debt issuance in the instruments currency. Face value at issuance before any amortization or repayment.',
    `nsfr_treatment` STRING COMMENT 'Classification of the debt issuance for NSFR calculation purposes. Indicates the available stable funding factor based on maturity and counterparty type.',
    `original_maturity_tenor` STRING COMMENT 'Time period from issuance date to maturity date expressed in standard market convention (e.g., 5Y, 10Y, 30Y). Used for funding maturity profile analysis.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Current principal amount outstanding after accounting for any partial redemptions, amortization, or calls. Used for balance sheet and capital ratio calculations.',
    `prospectus_url` STRING COMMENT 'URL link to the official prospectus or offering document filed with regulatory authorities. Provides full legal terms and conditions.',
    `put_date` DATE COMMENT 'First date on which the investor may exercise the put option to require early redemption. Applicable only when puttable_flag is true.',
    `puttable_flag` BOOLEAN COMMENT 'Indicates whether the investor has the right to require early redemption of the debt instrument. True if put option exists; false otherwise.',
    `rating_date` DATE COMMENT 'Date on which the credit rating was assigned or last updated by the rating agency.',
    `regulatory_capital_treatment` STRING COMMENT 'Classification of the debt instrument for Basel III regulatory capital purposes. Determines whether it qualifies as Tier 1, Tier 2, or does not count toward capital ratios.. Valid values are `tier_1|tier_2|not_eligible|grandfathered`',
    `spread_bps` DECIMAL(18,2) COMMENT 'Credit spread over the reference rate for floating rate instruments, expressed in basis points. Represents the banks credit premium above the risk-free rate.',
    `syndicate_members` STRING COMMENT 'Comma-separated list of all underwriting syndicate members participating in the debt issuance. Includes co-managers and selling group members.',
    `underwriter_name` STRING COMMENT 'Name of the lead investment bank or financial institution that underwrote and placed the debt issuance. Primary syndicate member.',
    `use_of_proceeds` STRING COMMENT 'Description of how the funds raised from the debt issuance will be used by the bank (e.g., general corporate purposes, refinancing, capital expenditure, green projects).',
    CONSTRAINT pk_debt_issuance PRIMARY KEY(`debt_issuance_id`)
) COMMENT 'Record of wholesale debt instruments issued by the bank for funding purposes, including senior unsecured notes, subordinated debt, covered bonds, FHLB advances, commercial paper, and certificates of deposit. Captures ISIN/CUSIP, issuance date, maturity date, coupon type (fixed/floating), coupon rate, currency, notional outstanding, underwriter, listing exchange, and call/put option features. Feeds into the funding maturity profile and capital structure reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`nostro_account` (
    `nostro_account_id` BIGINT COMMENT 'Primary key for nostro_account',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Nostro accounts identified by correspondent bank BIC for payment routing. Link enables correspondent bank validation, sanctions screening, SWIFT service profile lookup, and payment cut-off time determ',
    `correspondent_bank_id` BIGINT COMMENT 'Identifier of the correspondent bank where this nostro account is held.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Nostro account maintenance costs, FX position management costs, and unmatched item resolution costs are attributed to treasury cost centers for P&L reporting. Banks require cost center assignment on n',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Nostro accounts denominated in specific currencies for FX position management. Link enables currency validation, intraday liquidity monitoring by currency, LCR calculation, and multi-currency cash man',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Nostro accounts are cash assets requiring daily reconciliation to GL accounts for cash management, financial reporting, and intraday liquidity monitoring. Critical for balance sheet accuracy.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Nostro accounts are subject to jurisdiction-specific regulatory reporting requirements (regulatory_reporting_flag), AML obligations, and intraday liquidity monitoring rules. Banking correspondent bank',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Nostro accounts are owned by specific legal entities for intercompany reconciliation, regulatory reporting, and FX position management. The existing legal_entity_identifier is denormalized text; a pro',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Nostro account reconciliation cycles, statement_frequency, and rtgs_settlement_flag depend on the local market holiday calendar. Banking operations teams managing nostro accounts must reference the ap',
    `account_close_date` DATE COMMENT 'Date when the nostro account was closed, if applicable.',
    `account_name` STRING COMMENT 'The official name or title of the nostro account as registered with the correspondent bank.',
    `account_number` STRING COMMENT 'The account number assigned by the correspondent bank for this nostro account.',
    `account_open_date` DATE COMMENT 'Date when the nostro account was opened with the correspondent bank.',
    `account_purpose` STRING COMMENT 'Primary business purpose of the nostro account (e.g., settlement, foreign exchange, securities, general operations, liquidity management).. Valid values are `settlement|fx|securities|general|liquidity`',
    `account_status` STRING COMMENT 'Current operational status of the nostro account.. Valid values are `active|inactive|suspended|closed|pending_activation|restricted`',
    `authorized_signatories` STRING COMMENT 'List or reference to individuals authorized to operate and sign on behalf of this nostro account.',
    `balance_date` DATE COMMENT 'Date as of which the current balance amount is reported.',
    `break_aging_category` STRING COMMENT 'Aging category of unmatched items (breaks) based on the number of days outstanding.. Valid values are `0-1_days|2-5_days|6-10_days|11-30_days|over_30_days`',
    `business_unit` STRING COMMENT 'Business unit or division responsible for managing this nostro account.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this nostro account record was first created in the system.',
    `current_balance_amount` DECIMAL(18,2) COMMENT 'Current balance of the nostro account as per the latest reconciliation or statement.',
    `escalation_trigger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether reconciliation breaks have triggered an escalation process.',
    `fx_position_management_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this nostro account is used for foreign exchange position management.',
    `iban` STRING COMMENT 'International Bank Account Number for the nostro account, if applicable.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `intraday_liquidity_monitoring_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this nostro account is subject to intraday liquidity monitoring under BCBS 248.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this nostro account record was last modified or updated.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent reconciliation performed for this nostro account.',
    `last_statement_date` DATE COMMENT 'Date of the most recent statement received from the correspondent bank.',
    `lcr_inclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether balances in this nostro account are included in Liquidity Coverage Ratio calculations.',
    `nsfr_inclusion_flag` BOOLEAN COMMENT 'Boolean flag indicating whether balances in this nostro account are included in Net Stable Funding Ratio calculations.',
    `overdraft_limit_amount` DECIMAL(18,2) COMMENT 'Maximum overdraft limit authorized by the correspondent bank for this nostro account.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status indicating whether the internal ledger balance matches the correspondent bank statement.. Valid values are `matched|unmatched|partially_matched|pending|escalated`',
    `record_status` STRING COMMENT 'Status of the data record in the lakehouse (active, inactive, archived).. Valid values are `active|inactive|archived`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this nostro account is subject to regulatory reporting requirements.',
    `resolution_action` STRING COMMENT 'Description of actions taken or planned to resolve unmatched items or reconciliation breaks.',
    `rtgs_settlement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this nostro account is used for RTGS payment settlement.',
    `source_system` STRING COMMENT 'Name of the source system from which nostro account master data originates (e.g., core banking system, treasury management system).',
    `statement_frequency` STRING COMMENT 'Frequency at which the correspondent bank provides account statements (e.g., daily MT940/MT950 messages).. Valid values are `daily|weekly|monthly`',
    `unmatched_amount` DECIMAL(18,2) COMMENT 'Total monetary value of unmatched items (breaks) from the last reconciliation.',
    `unmatched_items_count` STRING COMMENT 'Number of unmatched items (breaks) identified during the last reconciliation.',
    CONSTRAINT pk_nostro_account PRIMARY KEY(`nostro_account_id`)
) COMMENT 'Master record and daily reconciliation for the banks nostro accounts held at correspondent banks globally. Master attributes: account number, correspondent bank BIC/SWIFT, currency, account purpose (settlement, FX, securities), authorized signatories, overdraft limit, account status. Reconciliation attributes: daily matching of internal ledger balances against correspondent bank statements (MT940/MT950), matched/unmatched items (breaks), break aging by category, reconciliation status, resolution actions, and escalation triggers. Critical for RTGS and SWIFT payment settlement, FX position management, and intraday liquidity monitoring (BCBS 248). Regulatory requirement under OCC guidance on correspondent banking controls. Post-merge: this is the single source of truth for nostro master data and reconciliation — replaces former separate nostro_reconciliation product.';

CREATE OR REPLACE TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` (
    `cash_flow_forecast_id` BIGINT COMMENT 'Unique identifier for the cash flow forecast record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Cash flow forecasts are prepared for specific accounting periods for ALCO review, regulatory liquidity reporting (ILAAP), and period-end liquidity position reconciliation. Linking to accounting_period',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Cash flow forecasts produced by currency for liquidity planning. Link enables multi-currency liquidity forecasting, FX scenario analysis, currency-specific LCR projection, and contingency funding plan',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Cash flow forecasts model expected fund redemptions/subscriptions as behavioral inflows/outflows by tenor bucket. Required for contingency funding planning and ILAAP (Internal Liquidity Adequacy Asses',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: LCR/NSFR cash flow forecasts apply jurisdiction-specific run-off rates and inflow caps (regulatory_reporting_flag, scenario_type). Basel III implementation differs by jurisdiction (e.g., EU CRR vs US ',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity for which the cash flow forecast is prepared.',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Cash flow forecasts must include projected margin call settlements (variation margin, initial margin) driven by margin agreements. The margin_agreement governs MTA, threshold, and settlement currency ',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Cash flow forecasts are reviewed during ILAAP and ILSA regulatory examinations. Examiners assess behavioral assumptions, stress scenarios, and forecast accuracy. A treasury liquidity manager would exp',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Cash flow forecasts are generated under specific stress scenarios for liquidity risk management and contingency funding planning. cash_flow_forecast.scenario_type is a denormalized field. Linking to s',
    `alco_review_date` DATE COMMENT 'Date when the forecast was reviewed by the Asset-Liability Committee.',
    `alco_review_status` STRING COMMENT 'Status of the forecast review by the Asset-Liability Committee for liquidity planning and contingency funding decisions.. Valid values are `pending|reviewed|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the forecast was approved for use in liquidity management and contingency planning.',
    `behavioral_inflow_amount` DECIMAL(18,2) COMMENT 'Projected behavioral cash inflows modeled from historical patterns such as deposit inflows, fee income, and trading revenues.',
    `behavioral_outflow_amount` DECIMAL(18,2) COMMENT 'Projected behavioral cash outflows including deposit runoff, credit line drawdowns, and operational expenses based on historical behavior.',
    `bond_maturity_inflow_amount` DECIMAL(18,2) COMMENT 'Projected cash inflows from bond maturities and coupon payments on held-to-maturity securities.',
    `business_line` STRING COMMENT 'The line of business generating the cash flow (e.g., Retail Banking, Investment Banking, Wealth Management, Treasury).',
    `cash_flow_category` STRING COMMENT 'Classification of the cash flow as contractual (legally binding), behavioral (modeled based on historical patterns), or contingent (conditional on events).. Valid values are `contractual|behavioral|contingent`',
    `commentary` STRING COMMENT 'Free-text commentary providing context, assumptions, and explanations for significant forecast variances or unusual patterns.',
    `confidence_level` STRING COMMENT 'Assessment of the forecast accuracy and reliability based on data quality, model performance, and market conditions.. Valid values are `high|medium|low`',
    `contingency_funding_trigger_status` STRING COMMENT 'Status indicating whether contingency funding plan triggers have been activated based on the forecast results.. Valid values are `normal|early_warning|crisis|recovery`',
    `contingent_inflow_amount` DECIMAL(18,2) COMMENT 'Projected contingent cash inflows dependent on specific events such as asset sales, securitization proceeds, or central bank facilities.',
    `contingent_outflow_amount` DECIMAL(18,2) COMMENT 'Projected contingent cash outflows including margin calls, collateral top-ups, guarantees called, and off-balance-sheet commitments.',
    `contractual_inflow_amount` DECIMAL(18,2) COMMENT 'Projected contractual cash inflows including loan repayments, bond maturities, coupon payments, and committed credit line repayments.',
    `contractual_outflow_amount` DECIMAL(18,2) COMMENT 'Projected contractual cash outflows including debt maturities, coupon payments, committed facility drawdowns, and collateral posting obligations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash flow forecast record was first created in the system.',
    `credit_line_drawdown_outflow_amount` DECIMAL(18,2) COMMENT 'Projected cash outflows from expected drawdowns on committed credit facilities and revolving lines of credit.',
    `cumulative_net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Cumulative net cash flow from the forecast start date through the current tenor bucket, used for liquidity gap analysis.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numerical score representing the completeness, accuracy, and timeliness of the source data used in the forecast calculation.',
    `deposit_runoff_outflow_amount` DECIMAL(18,2) COMMENT 'Projected cash outflows from deposit withdrawals modeled using behavioral runoff rates by deposit type and stability.',
    `derivative_settlement_net_amount` DECIMAL(18,2) COMMENT 'Net projected cash flows from derivative settlements including foreign exchange forwards, interest rate swaps, and options.',
    `flow_direction` STRING COMMENT 'Indicates whether the forecast represents a cash inflow or outflow.. Valid values are `inflow|outflow`',
    `forecast_date` DATE COMMENT 'The date for which the cash flow forecast is projected.',
    `forecast_reference_number` STRING COMMENT 'Business identifier for the cash flow forecast used for tracking and audit purposes.. Valid values are `^CF-[0-9]{8}-[A-Z0-9]{6}$`',
    `forecast_run_timestamp` TIMESTAMP COMMENT 'The timestamp when the forecast calculation was executed.',
    `forecast_type` STRING COMMENT 'Classification of the forecast by time horizon: intraday, overnight, short-term, medium-term, or long-term.. Valid values are `intraday|overnight|short_term|medium_term|long_term`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash flow forecast record was last updated or modified.',
    `loan_repayment_inflow_amount` DECIMAL(18,2) COMMENT 'Projected cash inflows from scheduled loan principal and interest repayments.',
    `model_version` STRING COMMENT 'Version identifier of the cash flow forecasting model used to generate the projection.',
    `net_cash_flow_amount` DECIMAL(18,2) COMMENT 'Net projected cash flow calculated as total inflows minus total outflows for the tenor bucket.',
    `operational_expense_outflow_amount` DECIMAL(18,2) COMMENT 'Projected cash outflows for operational expenses including payroll, rent, technology costs, and other recurring expenses.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this forecast is used for regulatory reporting purposes such as LCR, NSFR, or stress testing submissions.',
    `repo_funding_net_amount` DECIMAL(18,2) COMMENT 'Net projected cash flows from repurchase and reverse repurchase agreements maturing in the tenor bucket.',
    `source_system` STRING COMMENT 'Name of the source system or platform that generated the cash flow forecast data.',
    `tenor_bucket` STRING COMMENT 'Time bucket for the cash flow projection (intraday, overnight, 1 week, 2 weeks, 1 month, 3 months, 6 months, 1 year, beyond 1 year). [ENUM-REF-CANDIDATE: intraday|overnight|1W|2W|1M|3M|6M|1Y|beyond_1Y — 9 candidates stripped; promote to reference product]',
    `wholesale_funding_outflow_amount` DECIMAL(18,2) COMMENT 'Projected cash outflows from maturing wholesale funding including interbank borrowings, commercial paper, and certificates of deposit.',
    CONSTRAINT pk_cash_flow_forecast PRIMARY KEY(`cash_flow_forecast_id`)
) COMMENT 'Forward-looking cash flow forecast record capturing projected inflows and outflows by currency, tenor bucket (intraday, overnight, 1W, 2W, 1M, 3M), and business line for liquidity stress testing and contingency funding planning. Distinguishes contractual cash flows (loan repayments, bond maturities, coupon payments) from behavioral cash flows (deposit runoff, credit line drawdowns) under base and stress scenarios.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ADD CONSTRAINT `fk_treasury_liquidity_position_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `banking_ecm`.`treasury`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ADD CONSTRAINT `fk_treasury_liquidity_ratio_liquidity_position_id` FOREIGN KEY (`liquidity_position_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_position`(`liquidity_position_id`);
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ADD CONSTRAINT `fk_treasury_hqla_inventory_liquidity_ratio_id` FOREIGN KEY (`liquidity_ratio_id`) REFERENCES `banking_ecm`.`treasury`.`liquidity_ratio`(`liquidity_ratio_id`);
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ADD CONSTRAINT `fk_treasury_repo_transaction_repo_position_id` FOREIGN KEY (`repo_position_id`) REFERENCES `banking_ecm`.`treasury`.`repo_position`(`repo_position_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ADD CONSTRAINT `fk_treasury_ftp_rate_superseded_by_rate_ftp_rate_id` FOREIGN KEY (`superseded_by_rate_ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_ftp_rate_id` FOREIGN KEY (`ftp_rate_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_rate`(`ftp_rate_id`);
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ADD CONSTRAINT `fk_treasury_ftp_allocation_original_allocation_ftp_allocation_id` FOREIGN KEY (`original_allocation_ftp_allocation_id`) REFERENCES `banking_ecm`.`treasury`.`ftp_allocation`(`ftp_allocation_id`);
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ADD CONSTRAINT `fk_treasury_capital_ratio_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ADD CONSTRAINT `fk_treasury_funding_plan_capital_plan_id` FOREIGN KEY (`capital_plan_id`) REFERENCES `banking_ecm`.`treasury`.`capital_plan`(`capital_plan_id`);
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ADD CONSTRAINT `fk_treasury_debt_issuance_funding_plan_id` FOREIGN KEY (`funding_plan_id`) REFERENCES `banking_ecm`.`treasury`.`funding_plan`(`funding_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`treasury` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`treasury` SET TAGS ('dbx_domain' = 'treasury');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position ID');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `alco_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `available_liquidity_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Liquidity Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `behavioral_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `behavioral_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `cash_balance` SET TAGS ('dbx_business_glossary_term' = 'Cash Balance');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `central_bank_reserve_balance` SET TAGS ('dbx_business_glossary_term' = 'Central Bank Reserve Balance');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `contingency_funding_trigger_status` SET TAGS ('dbx_business_glossary_term' = 'Contingency Funding Trigger Status');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `contingency_funding_trigger_status` SET TAGS ('dbx_value_regex' = 'normal|early_warning|stress|crisis');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `contractual_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `contractual_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `cumulative_net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Net Cash Flow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `interbank_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Interbank Funding Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `lcr_buffer_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Buffer Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `lcr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `liquid_asset_balance` SET TAGS ('dbx_business_glossary_term' = 'Liquid Asset Balance');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `nsfr_buffer_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Buffer Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `nsfr_ratio` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `position_date` SET TAGS ('dbx_business_glossary_term' = 'Position Date');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|adjusted|restated');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `position_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'intraday|end_of_day|forward_forecast');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `repo_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement (Repo) Funding Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `reverse_repo_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Reverse Repurchase Agreement (Reverse Repo) Funding Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `tenor_bucket` SET TAGS ('dbx_business_glossary_term' = 'Tenor Bucket');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_position` ALTER COLUMN `undrawn_committed_facility_amount` SET TAGS ('dbx_business_glossary_term' = 'Undrawn Committed Facility Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `liquidity_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Ratio Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `alco_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Approval Status');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `alco_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `alco_review_date` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Review Date');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `available_stable_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Stable Funding (ASF) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|severe|critical');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `buffer_percentage` SET TAGS ('dbx_business_glossary_term' = 'Buffer Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'standardized|internal_model|hybrid');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'Commentary');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `committed_facility_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Facility Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Level');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'solo|consolidated|sub_consolidated');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `contractual_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `derivative_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Derivative Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `hqla_level_1_amount` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Level 1 Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `hqla_level_2a_amount` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Level 2A Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `hqla_level_2b_amount` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Assets (HQLA) Level 2B Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `lcr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `nsfr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `period_over_period_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Period-Over-Period Change Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `prior_period_ratio_percentage` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Ratio Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `ratio_type` SET TAGS ('dbx_business_glossary_term' = 'Ratio Type');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `ratio_type` SET TAGS ('dbx_value_regex' = 'LCR|NSFR');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|superseded|archived|deleted');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `regulatory_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `required_stable_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Required Stable Funding (RSF) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `retail_deposit_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Retail Deposit Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `secured_funding_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Secured Funding Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `total_hqla_amount` SET TAGS ('dbx_business_glossary_term' = 'Total High-Quality Liquid Assets (HQLA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `total_net_cash_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Cash Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`liquidity_ratio` ALTER COLUMN `wholesale_funding_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Funding Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `hqla_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Inventory ID');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `liquidity_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'Eligible|Ineligible|Conditionally Eligible|Under Review');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `encumbered_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbered Amount');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Status');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_value_regex' = 'Unencumbered|Encumbered|Partially Encumbered');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `hqla_level` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Level');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `hqla_level` SET TAGS ('dbx_value_regex' = 'Level 1|Level 2A|Level 2B');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `hqla_value_amount` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Value Amount');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `ineligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Ineligibility Reason');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `lcr_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Inclusion Flag');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `movement_date` SET TAGS ('dbx_business_glossary_term' = 'Movement Date');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `nominal_amount` SET TAGS ('dbx_business_glossary_term' = 'Nominal Amount');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `nsfr_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Inclusion Flag');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Archived|Pending Verification');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `unencumbered_hqla_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Unencumbered High-Quality Liquid Asset (HQLA) Value Amount');
ALTER TABLE `banking_ecm`.`treasury`.`hqla_inventory` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `interbank_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Interbank Placement Identifier (ID)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `alco_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Category');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `all_in_rate` SET TAGS ('dbx_business_glossary_term' = 'All-In Interest Rate (Percentage)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `benchmark_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Value (Percentage)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `counterparty_concentration_flag` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Concentration Flag');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'ACT_360|ACT_365|30_360|ACT_ACT');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `desk_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk Code');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `expected_credit_loss` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `exposure_at_default` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `ftp_rate` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate (Percentage)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification (High-Quality Liquid Assets - HQLA)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'HQLA_level_1|HQLA_level_2A|HQLA_level_2B|non_HQLA');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `liquidity_gap_bucket` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Gap Bucket');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `loss_given_default` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Principal Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `nsfr_asf_factor` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Available Stable Funding (ASF) Factor');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `nsfr_rsf_factor` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Required Stable Funding (RSF) Factor');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `placement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Placement Reference Number');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Type');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `placement_type` SET TAGS ('dbx_value_regex' = 'overnight|term|call_money|notice|fixed_deposit');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `probability_of_default` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `risk_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage (Risk-Weighted Assets - RWA)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `rollover_instruction` SET TAGS ('dbx_business_glossary_term' = 'Rollover Instruction');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `rollover_instruction` SET TAGS ('dbx_value_regex' = 'automatic|manual|none');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `rollover_status` SET TAGS ('dbx_business_glossary_term' = 'Rollover Status');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `rollover_status` SET TAGS ('dbx_value_regex' = 'none|pending|executed|declined');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor in Days');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `transaction_direction` SET TAGS ('dbx_business_glossary_term' = 'Transaction Direction');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `transaction_direction` SET TAGS ('dbx_value_regex' = 'placement|borrowing');
ALTER TABLE `banking_ecm`.`treasury`.`interbank_placement` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position ID');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset ID');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set ID');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `cumulative_pnl` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Profit and Loss (PnL)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `daily_pnl` SET TAGS ('dbx_business_glossary_term' = 'Daily Profit and Loss (PnL)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Repo Direction');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'repo|reverse_repo');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `initial_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `lcr_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Classification');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `lcr_classification` SET TAGS ('dbx_value_regex' = 'hqla_level_1|hqla_level_2a|hqla_level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Status');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_value_regex' = 'none|pending|satisfied|disputed|overdue');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `mtm_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `mtm_valuation` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `nsfr_classification` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Classification');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|closed|matured|terminated|defaulted|pending_settlement');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|indexed');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_value_regex' = 'true_sale|secured_financing|on_balance_sheet|off_balance_sheet');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `repo_rate` SET TAGS ('dbx_business_glossary_term' = 'Repo Rate');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `repo_type` SET TAGS ('dbx_business_glossary_term' = 'Repo Type');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `repo_type` SET TAGS ('dbx_value_regex' = 'classic|sell_buy_back|tri_party|hold_in_custody|bilateral');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'dvp|fop|hold_in_custody');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|partial');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Term Type');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'open|term|overnight');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `tri_party_agent` SET TAGS ('dbx_business_glossary_term' = 'Tri-Party Agent');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`repo_position` ALTER COLUMN `variation_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `repo_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Transaction Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `booking_system` SET TAGS ('dbx_business_glossary_term' = 'Booking System');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `clearing_house` SET TAGS ('dbx_business_glossary_term' = 'Clearing House');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `collateral_market_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Market Value');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `funding_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Funding Cost Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `funding_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Funding Cost Rate');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_value_regex' = 'hqla_level_1|hqla_level_2a|hqla_level_2b|non_hqla');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `leg_type` SET TAGS ('dbx_business_glossary_term' = 'Leg Type');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `leg_type` SET TAGS ('dbx_value_regex' = 'opening|closing');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `margin_call_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `margin_call_date` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `mtm_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `mtm_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `pnl_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (PnL) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `pnl_attribution_date` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (PnL) Attribution Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `repo_rate` SET TAGS ('dbx_business_glossary_term' = 'Repo Rate');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `repurchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Amount');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'dvp|fop|hold_in_custody');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled|matured');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'repo|reverse_repo');
ALTER TABLE `banking_ecm`.`treasury`.`repo_transaction` ALTER COLUMN `tri_party_agent` SET TAGS ('dbx_business_glossary_term' = 'Tri-Party Agent');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` SET TAGS ('dbx_subdomain' = 'capital_funding');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Rate ID');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `superseded_by_rate_ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate ID');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `alco_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Approval Date');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `alco_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'ALCO Approval Reference');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `asset_liability_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset/Liability Flag');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `asset_liability_flag` SET TAGS ('dbx_value_regex' = 'asset|liability');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `base_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Value');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `basis_adjustment_bps` SET TAGS ('dbx_business_glossary_term' = 'Basis Adjustment (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `composite_rate_bps` SET TAGS ('dbx_business_glossary_term' = 'Composite Rate (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `credit_spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Credit Spread (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `curve_type` SET TAGS ('dbx_business_glossary_term' = 'Curve Type');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `curve_type` SET TAGS ('dbx_value_regex' = 'base_rate|liquidity_spread|credit_spread|composite');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `liquidity_premium_bps` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Premium (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'FTP Methodology');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'matched_maturity|pooled|hybrid');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `nim_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Margin (NIM) Allocation Flag');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `optionality_charge_bps` SET TAGS ('dbx_business_glossary_term' = 'Optionality Charge (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `raroc_calculation_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk-Adjusted Return on Capital (RAROC) Calculation Flag');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'FTP Rate Code');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Description');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'FTP Rate Name');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|superseded|expired');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `tenor_bucket` SET TAGS ('dbx_business_glossary_term' = 'Tenor Bucket');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` SET TAGS ('dbx_subdomain' = 'capital_funding');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `ftp_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Allocation ID');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `interest_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `original_allocation_ftp_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original FTP Allocation ID');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'loan|deposit|investment|trading_asset|trading_liability');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `accrual_days` SET TAGS ('dbx_business_glossary_term' = 'Accrual Days');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `alco_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Category');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|confirmed|posted|reversed|adjusted');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'FTP Allocation Type');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'charge|credit');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `benchmark_rate` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `business_line_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'FTP Calculation Date');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'FTP Calculation Method');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'matched_maturity|pool|hybrid|single_rate');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Allocation Comments');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `credit_adjustment_bps` SET TAGS ('dbx_business_glossary_term' = 'Credit Adjustment in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360|actual_actual');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `economic_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Economic Capital Amount');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `ftp_amount` SET TAGS ('dbx_business_glossary_term' = 'Funds Transfer Pricing (FTP) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `liquidity_premium_bps` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Premium in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `nim_contribution` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Margin (NIM) Contribution');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `notional_balance` SET TAGS ('dbx_business_glossary_term' = 'Notional Balance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Treatment Classification');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_value_regex' = 'banking_book|trading_book|available_for_sale|held_to_maturity');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `risk_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`ftp_allocation` ALTER COLUMN `tenor_bucket` SET TAGS ('dbx_business_glossary_term' = 'Tenor Bucket');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` SET TAGS ('dbx_subdomain' = 'risk_analytics');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `interest_rate_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Risk (IRR) Position ID');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `alco_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `basis_risk_amount` SET TAGS ('dbx_business_glossary_term' = 'Basis Risk Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `behavioral_assumption_set` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Assumption Set');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'duration_gap|simulation|earnings_at_risk|economic_value');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Level');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'legal_entity|consolidated|business_line|portfolio');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `convexity` SET TAGS ('dbx_business_glossary_term' = 'Convexity');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `duration_of_equity` SET TAGS ('dbx_business_glossary_term' = 'Duration of Equity');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `eve_sensitivity_amount` SET TAGS ('dbx_business_glossary_term' = 'Economic Value of Equity (EVE) Sensitivity Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `eve_sensitivity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Economic Value of Equity (EVE) Sensitivity Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `modified_duration` SET TAGS ('dbx_business_glossary_term' = 'Modified Duration');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `nii_sensitivity_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Income (NII) Sensitivity Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `nii_sensitivity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Interest Income (NII) Sensitivity Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `optionality_risk_amount` SET TAGS ('dbx_business_glossary_term' = 'Optionality Risk Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Code');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `position_date` SET TAGS ('dbx_business_glossary_term' = 'Position Date');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|approved|superseded');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `rate_sensitive_assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Sensitive Assets Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `rate_sensitive_liabilities_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Sensitive Liabilities Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `repricing_gap_amount` SET TAGS ('dbx_business_glossary_term' = 'Repricing Gap Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `shock_scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Shock Scenario Type');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `shock_scenario_type` SET TAGS ('dbx_value_regex' = 'parallel_up_100bps|parallel_down_100bps|parallel_up_200bps|parallel_down_200bps|parallel_up_300bps|parallel_down_300bps');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `time_bucket` SET TAGS ('dbx_business_glossary_term' = 'Time Bucket');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `var_amount` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon Days');
ALTER TABLE `banking_ecm`.`treasury`.`interest_rate_risk_position` ALTER COLUMN `yield_curve_risk_amount` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Risk Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` SET TAGS ('dbx_subdomain' = 'risk_analytics');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `capital_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Ratio Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `alco_target_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Target Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|resubmitted');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `at1_trigger_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Additional Tier 1 (AT1) Trigger Breach Flag');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Calculation Method');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'standardized_approach|irb_foundation|irb_advanced');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `capital_conservation_buffer` SET TAGS ('dbx_business_glossary_term' = 'Capital Conservation Buffer');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `capital_issuance_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Issuance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `capital_redemption_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Redemption Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `cet1_buffer_amount` SET TAGS ('dbx_business_glossary_term' = 'Common Equity Tier 1 (CET1) Buffer Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `cet1_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Common Equity Tier 1 (CET1) Capital Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Level');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'consolidated|solo|sub_consolidated');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `countercyclical_buffer` SET TAGS ('dbx_business_glossary_term' = 'Countercyclical Capital Buffer');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `credit_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `gsib_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Global Systemically Important Bank (G-SIB) Surcharge');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Leverage Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `market_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Market Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `operational_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `planned_buyback_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Share Buyback Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `planned_dividend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Dividend Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `projected_cet1_ratio_year1` SET TAGS ('dbx_business_glossary_term' = 'Projected Common Equity Tier 1 (CET1) Ratio Year 1');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `projected_cet1_ratio_year2` SET TAGS ('dbx_business_glossary_term' = 'Projected Common Equity Tier 1 (CET1) Ratio Year 2');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `projected_cet1_ratio_year3` SET TAGS ('dbx_business_glossary_term' = 'Projected Common Equity Tier 1 (CET1) Ratio Year 3');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `projected_rwa_growth_rate` SET TAGS ('dbx_business_glossary_term' = 'Projected Risk-Weighted Assets (RWA) Growth Rate');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `regulatory_minimum_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Minimum Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Date');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `scenario_type` SET TAGS ('dbx_business_glossary_term' = 'Scenario Type');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `scenario_type` SET TAGS ('dbx_value_regex' = 'actual|base|adverse|severely_adverse|management_buffer');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `tier1_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Capital Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `tier1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Capital Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `tier2_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Capital Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `total_buffer_requirement` SET TAGS ('dbx_business_glossary_term' = 'Total Buffer Requirement');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `total_capital_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `total_capital_ratio` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `total_exposure_measure` SET TAGS ('dbx_business_glossary_term' = 'Total Exposure Measure');
ALTER TABLE `banking_ecm`.`treasury`.`capital_ratio` ALTER COLUMN `total_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` SET TAGS ('dbx_subdomain' = 'capital_funding');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `alco_approved_target_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Approved Target Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `at1_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Additional Tier 1 (AT1) Trigger Threshold');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `baseline_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Baseline Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `baseline_rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `capital_action_description` SET TAGS ('dbx_business_glossary_term' = 'Capital Action Description');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Comments');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `management_buffer_above_minimum` SET TAGS ('dbx_business_glossary_term' = 'Management Buffer Above Regulatory Minimum');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Capital Planning Methodology Description');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `minimum_cet1_ratio_stressed` SET TAGS ('dbx_business_glossary_term' = 'Minimum Common Equity Tier 1 (CET1) Ratio Under Stress');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `net_income_projection` SET TAGS ('dbx_business_glossary_term' = 'Net Income Projection');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Name');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Status');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Version');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planned_capital_issuance_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Capital Issuance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planned_capital_redemption_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Capital Redemption Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planned_common_stock_dividend_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Common Stock Dividend Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planned_dividend_payout_ratio` SET TAGS ('dbx_business_glossary_term' = 'Planned Dividend Payout Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planned_share_buyback_amount` SET TAGS ('dbx_business_glossary_term' = 'Planned Share Buyback Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planning_horizon_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `planning_horizon_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `pre_provision_net_revenue_projection` SET TAGS ('dbx_business_glossary_term' = 'Pre-Provision Net Revenue (PPNR) Projection');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `projected_cet1_ratio_year_1` SET TAGS ('dbx_business_glossary_term' = 'Projected Common Equity Tier 1 (CET1) Ratio Year 1');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `projected_cet1_ratio_year_2` SET TAGS ('dbx_business_glossary_term' = 'Projected Common Equity Tier 1 (CET1) Ratio Year 2');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `projected_cet1_ratio_year_3` SET TAGS ('dbx_business_glossary_term' = 'Projected Common Equity Tier 1 (CET1) Ratio Year 3');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `projected_rwa_growth_rate_year_1` SET TAGS ('dbx_business_glossary_term' = 'Projected Risk-Weighted Assets (RWA) Growth Rate Year 1');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `projected_rwa_growth_rate_year_2` SET TAGS ('dbx_business_glossary_term' = 'Projected Risk-Weighted Assets (RWA) Growth Rate Year 2');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `projected_rwa_growth_rate_year_3` SET TAGS ('dbx_business_glossary_term' = 'Projected Risk-Weighted Assets (RWA) Growth Rate Year 3');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `provision_for_credit_losses_projection` SET TAGS ('dbx_business_glossary_term' = 'Provision for Credit Losses Projection');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `regulatory_minimum_cet1_ratio` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Minimum Common Equity Tier 1 (CET1) Ratio');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `reporting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Name');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `stress_loss_projection_amount` SET TAGS ('dbx_business_glossary_term' = 'Stress Loss Projection Amount');
ALTER TABLE `banking_ecm`.`treasury`.`capital_plan` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` SET TAGS ('dbx_subdomain' = 'capital_funding');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan ID');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `actual_cost_of_funds_rate` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost of Funds Rate (Basis Points)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `actual_issuance_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Issuance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `call_feature_flag` SET TAGS ('dbx_business_glossary_term' = 'Call Feature Flag');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `concentration_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `counterparty_concentration_limit` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Concentration Limit');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate (Percentage)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|zero_coupon|step_up|callable|puttable');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[A-Z0-9]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Instrument Type');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_value_regex' = 'stable|less_stable|operational|non_operational|excluded');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `listing_exchange` SET TAGS ('dbx_business_glossary_term' = 'Listing Exchange');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Debt Maturity Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `notional_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Notional Outstanding Amount');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_value_regex' = 'stable|less_stable|wholesale|excluded');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Name');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Period End Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Period Start Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Status');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|executed|closed|cancelled');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Type');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'wholesale|retail|hybrid|contingency|strategic');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `put_date` SET TAGS ('dbx_business_glossary_term' = 'Put Date');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `put_feature_flag` SET TAGS ('dbx_business_glossary_term' = 'Put Feature Flag');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_value_regex' = 'cet1|tier1|tier2|non_capital|excluded');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `target_cost_of_funds_rate` SET TAGS ('dbx_business_glossary_term' = 'Target Cost of Funds Rate (Basis Points)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `target_issuance_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Issuance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `target_maturity_profile` SET TAGS ('dbx_business_glossary_term' = 'Target Maturity Profile');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `target_maturity_profile` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term|perpetual|mixed');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `target_weighted_average_maturity_years` SET TAGS ('dbx_business_glossary_term' = 'Target Weighted Average Maturity (Years)');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Underwriter Name');
ALTER TABLE `banking_ecm`.`treasury`.`funding_plan` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` SET TAGS ('dbx_subdomain' = 'capital_funding');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `debt_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `booking_system` SET TAGS ('dbx_business_glossary_term' = 'Booking System');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `call_price` SET TAGS ('dbx_business_glossary_term' = 'Call Price');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Flag');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|zero_coupon|step_up|inflation_linked');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `green_bond_flag` SET TAGS ('dbx_business_glossary_term' = 'Green Bond Flag');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `issuance_status` SET TAGS ('dbx_business_glossary_term' = 'Issuance Status');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `issue_price` SET TAGS ('dbx_business_glossary_term' = 'Issue Price');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `lcr_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `listing_exchange` SET TAGS ('dbx_business_glossary_term' = 'Listing Exchange');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `nsfr_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `original_maturity_tenor` SET TAGS ('dbx_business_glossary_term' = 'Original Maturity Tenor');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `prospectus_url` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `put_date` SET TAGS ('dbx_business_glossary_term' = 'Put Date');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `puttable_flag` SET TAGS ('dbx_business_glossary_term' = 'Puttable Flag');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|not_eligible|grandfathered');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `syndicate_members` SET TAGS ('dbx_business_glossary_term' = 'Syndicate Members');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Underwriter Name');
ALTER TABLE `banking_ecm`.`treasury`.`debt_issuance` ALTER COLUMN `use_of_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Use of Proceeds');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` SET TAGS ('dbx_subdomain' = 'capital_funding');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Identifier');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `correspondent_bank_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Bank ID');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Name');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Number');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Account Purpose');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_value_regex' = 'settlement|fx|securities|general|liquidity');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_activation|restricted');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatories');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `balance_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Date');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `break_aging_category` SET TAGS ('dbx_business_glossary_term' = 'Break Aging Category');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `break_aging_category` SET TAGS ('dbx_value_regex' = '0-1_days|2-5_days|6-10_days|11-30_days|over_30_days');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Balance Amount');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `current_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `escalation_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Trigger Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `fx_position_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Position Management Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `intraday_liquidity_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Intraday Liquidity Monitoring Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `lcr_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Coverage Ratio (LCR) Inclusion Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `nsfr_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Stable Funding Ratio (NSFR) Inclusion Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit Amount');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `overdraft_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|pending|escalated');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `rtgs_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Gross Settlement (RTGS) Settlement Flag');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `unmatched_amount` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Amount');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `unmatched_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`treasury`.`nostro_account` ALTER COLUMN `unmatched_items_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Items Count');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` SET TAGS ('dbx_subdomain' = 'liquidity_management');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast ID');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `alco_review_date` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Review Date');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `alco_review_status` SET TAGS ('dbx_business_glossary_term' = 'Asset-Liability Committee (ALCO) Review Status');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `alco_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|approved|rejected');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `behavioral_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `behavioral_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `bond_maturity_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Maturity Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Business Line');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Category');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `cash_flow_category` SET TAGS ('dbx_value_regex' = 'contractual|behavioral|contingent');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `commentary` SET TAGS ('dbx_business_glossary_term' = 'Commentary');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `confidence_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `contingency_funding_trigger_status` SET TAGS ('dbx_business_glossary_term' = 'Contingency Funding Trigger Status');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `contingency_funding_trigger_status` SET TAGS ('dbx_value_regex' = 'normal|early_warning|crisis|recovery');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `contingent_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingent Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `contingent_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingent Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `contractual_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `contractual_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Contractual Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `credit_line_drawdown_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Line Drawdown Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `cumulative_net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Net Cash Flow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `deposit_runoff_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Runoff Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `derivative_settlement_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Derivative Settlement Net Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `flow_direction` SET TAGS ('dbx_business_glossary_term' = 'Flow Direction');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `flow_direction` SET TAGS ('dbx_value_regex' = 'inflow|outflow');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Date');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `forecast_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Reference Number');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `forecast_reference_number` SET TAGS ('dbx_value_regex' = '^CF-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `forecast_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Type');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `forecast_type` SET TAGS ('dbx_value_regex' = 'intraday|overnight|short_term|medium_term|long_term');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `loan_repayment_inflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Repayment Inflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `net_cash_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `operational_expense_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Operational Expense Outflow Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `repo_funding_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Repo Funding Net Amount');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `tenor_bucket` SET TAGS ('dbx_business_glossary_term' = 'Tenor Bucket');
ALTER TABLE `banking_ecm`.`treasury`.`cash_flow_forecast` ALTER COLUMN `wholesale_funding_outflow_amount` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Funding Outflow Amount');
