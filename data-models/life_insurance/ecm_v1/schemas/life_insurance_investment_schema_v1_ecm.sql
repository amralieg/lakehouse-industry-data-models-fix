-- Schema for Domain: investment | Business: Life Insurance | Version: v1_ecm
-- Generated on: 2026-05-04 03:46:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `life_insurance_ecm`.`investment` COMMENT 'Manages the general account and separate account investment portfolio supporting policy reserves and ALM objectives. Owns fixed income, equity, and alternative asset positions, trade execution records, FMV/NAV valuations, portfolio compliance monitoring (RBC, NAIC investment guidelines), performance attribution, CDR tracking, and investment income allocation. Supports ALM duration matching, variable product unit value calculations, and RBC investment risk charges.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`portfolio` (
    `portfolio_id` BIGINT COMMENT 'Unique surrogate identifier for each investment portfolio record in the general account or separate account. Primary key for the portfolio master record.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to investment.benchmark. Business justification: portfolio currently has benchmark_index and benchmark_index_code as STRING attributes, but there is a benchmark master table with full benchmark metadata (provider, methodology, constituents, duration',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Custodians are vendors providing safekeeping and settlement services. Business processes: custody fee reconciliation, asset reconciliation, regulatory reporting (Schedule D), vendor risk assessment, S',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee serving as portfolio manager',
    `group_sponsor_id` BIGINT COMMENT 'Foreign key linking to policyholder.group_sponsor. Business justification: Group variable life and group variable annuity products invest sponsor premiums in dedicated portfolios. Sponsors require quarterly performance reporting for participant communications and ERISA fiduc',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Portfolios are owned by legal entities for statutory reporting, RBC calculations, and NAIC Annual Statement preparation. Essential for SAP/GAAP consolidation and regulatory filings.',
    `liability_segment_id` BIGINT COMMENT 'Identifier of the insurance liability segment (e.g., whole life reserves, annuity reserves, UL account values) that this portfolio is designated to support under the ALM framework. Links to the actuarial liability segmentation model.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Portfolios are structured around product liability profiles for ALM matching. Investment mandates, duration targets, and asset allocation strategies are designed to support specific product lines cas',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Investment portfolios backing variable insurance products require producer attribution for sales tracking and commission allocation based on investment performance. Supports variable product distribut',
    `segment_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.segment_definition. Business justification: Portfolios are segmented for IFRS 17 contract groups, GAAP product lines, statutory line of business reporting. Real business need: portfolio-to-segment mapping for segmented financial reporting and r',
    `separate_account_fund_id` BIGINT COMMENT 'Identifier linking this separate account portfolio to the specific variable product fund (sub-account) it supports for VUL or variable annuity unit value calculations. Null for general account portfolios.',
    `actual_duration_years` DECIMAL(18,2) COMMENT 'Current measured modified duration of the portfolio in years as of the valuation date. Compared against target duration to assess ALM duration gap and trigger rebalancing actions.',
    `actual_market_value` DECIMAL(18,2) COMMENT 'Total Fair Market Value (FMV) of all assets held in the portfolio as of the most recent valuation date. Represents the principal quantitative measure of portfolio size. Used in RBC calculations, NAIC statutory reporting, and performance attribution.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of portfolio management responsibility allocated to this manager for performance attribution purposes. For portfolios with multiple managers, allocation percentages sum to 100%. Used in compensation calculations and performance reviews.',
    `alm_classification` STRING COMMENT 'Classifies the portfolios role within the Asset Liability Management (ALM) framework. Indicates whether the portfolio is duration-matched to specific policy reserve liabilities, held as surplus, maintained as a liquidity reserve, or supports variable product unit value calculations.. Valid values are `duration_matched|liability_driven|surplus|liquidity_reserve|variable_product_support`',
    `asset_class` STRING COMMENT 'Primary asset class of the portfolio (e.g., fixed income, equity, alternative assets, real estate). Determines investment mandate constraints, NAIC Schedule classification, and RBC investment risk charge category.. Valid values are `fixed_income|equity|alternative|real_estate|cash_equivalent|multi_asset`',
    `assignment_approval_date` DATE COMMENT 'Date on which the investment committee formally approved this manager assignment. Required for fiduciary responsibility documentation and regulatory compliance.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the manager assignment. Active assignments are operational; pending assignments are approved but not yet effective; suspended assignments are temporarily inactive; terminated assignments are historical.',
    `benchmark_ytd_pct` DECIMAL(18,2) COMMENT 'Year-to-date total return percentage of the designated benchmark index as of the most recent valuation date. Used alongside portfolio YTD performance to compute active return (alpha) in performance attribution.',
    `cdr_tracking_enabled` BOOLEAN COMMENT 'Indicates whether Conditional Default Rate (CDR) tracking is enabled for this portfolio. When true, the portfolio is subject to CDR monitoring for structured credit assets (e.g., RMBS, CMBS, ABS) per NAIC structured securities guidelines.',
    `closure_date` DATE COMMENT 'The date on which the portfolio was formally closed and all assets were liquidated or transferred. Null for active portfolios. Used for lifecycle management and historical performance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the portfolio master record was first created in the investment management system. Used for audit trail, data lineage, and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the portfolio is denominated (e.g., USD, EUR, GBP). Required for multi-currency ALM reporting and foreign exchange risk monitoring.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date on which this manager assignment became effective. Used for succession planning, performance attribution period determination, and regulatory fiduciary responsibility documentation.',
    `end_date` DATE COMMENT 'The date on which this manager assignment ended. Null for currently active assignments. Used for historical performance attribution and succession planning analysis.',
    `inception_date` DATE COMMENT 'The date on which the portfolio was formally established and began accepting assets. Used as the start date for performance measurement, GIPS-compliant composite reporting, and DAC amortization schedules.',
    `investment_committee_approval_date` DATE COMMENT 'Date on which the investment committee formally approved the portfolios investment mandate, strategic asset allocation, and risk parameters. Required for governance documentation and SOX compliance.',
    `investment_income_allocation_method` STRING COMMENT 'Method used to allocate investment income from this portfolio to insurance product lines or liability segments (e.g., direct attribution to a specific policy block, pro-rata allocation, segmented portfolio method). Impacts GAAP/SAP income statement reporting.. Valid values are `direct_attribution|pro_rata|segmented|pooled`',
    `investment_mandate` STRING COMMENT 'Narrative description of the portfolios investment mandate, including permitted asset types, credit quality constraints, duration targets, yield objectives, and any ESG or sector restrictions. Governs portfolio manager decision-making and compliance monitoring.',
    `is_compliant` BOOLEAN COMMENT 'Indicates whether the portfolio is currently in compliance with all investment mandate constraints, NAIC investment guidelines, and RBC requirements as of the last compliance check. False triggers a compliance breach workflow in the investment management system.',
    `last_compliance_check_date` DATE COMMENT 'Date on which the most recent automated or manual compliance check was performed against the portfolios investment mandate and regulatory constraints. Used to ensure compliance monitoring cadence meets NAIC and internal governance requirements.',
    `last_rebalancing_date` DATE COMMENT 'Date on which the most recent rebalancing of the portfolio was executed. Used to determine next scheduled rebalancing date and to assess compliance with rebalancing frequency policy.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the portfolio master record. Used for change data capture (CDC), audit trail, and data freshness monitoring in the Databricks Silver Layer.',
    `manager_role` STRING COMMENT 'The specific role this employee plays in managing this portfolio. Distinguishes between lead portfolio managers (primary fiduciary responsibility) and supporting managers (sector specialists, junior PMs). Critical for investment committee reporting and performance attribution.',
    `max_single_issuer_concentration_pct` DECIMAL(18,2) COMMENT 'Maximum allowable percentage of portfolio market value that may be invested in securities of a single issuer. Defined in the investment policy statement to manage concentration risk per NAIC investment guidelines.',
    `min_credit_quality_rating` STRING COMMENT 'Minimum permissible credit quality rating (S&P/Moodys equivalent) for assets held in this portfolio, as defined in the investment mandate. Enforced by the compliance monitoring module to prevent below-mandate credit quality drift.. Valid values are `^(AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC|CC|C|D|NR)$`',
    `naic_schedule_classification` STRING COMMENT 'Regulatory classification of the portfolio per NAIC Annual Statement schedules: Schedule D (bonds and stocks), Schedule E (cash and short-term investments), Schedule BA (other long-term invested assets). Required for statutory reporting under SAP.. Valid values are `schedule_d|schedule_e|schedule_ba|schedule_b|schedule_a`',
    `performance_ytd_pct` DECIMAL(18,2) COMMENT 'Year-to-date total return percentage for the portfolio as of the most recent valuation date. Calculated gross of fees. Used in performance attribution reporting and investment committee reviews. Not a derived aggregate — sourced directly from the investment management system.',
    `portfolio_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the portfolio within the investment management system. Used in trade execution, bordereaux reporting, and regulatory filings (NAIC Schedule D/E/BA).. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `portfolio_name` STRING COMMENT 'Human-readable name of the investment portfolio (e.g., General Account Fixed Income Core, Separate Account Equity Growth). Used in reporting, performance attribution, and ALM dashboards.',
    `portfolio_status` STRING COMMENT 'Current lifecycle status of the portfolio: active (fully operational), pending_approval (awaiting investment committee approval), inactive (temporarily not trading), suspended (regulatory or compliance hold), or closed (terminated). Governs trade execution eligibility.. Valid values are `active|inactive|pending_approval|closed|suspended`',
    `portfolio_type` STRING COMMENT 'Classifies the portfolio by account structure: general account (insurers own assets backing policyholder liabilities), separate account (assets held for variable product policyholders), or alternative asset portfolio. Drives regulatory treatment and RBC charge category.. Valid values are `general_account|separate_account|variable_product|alternative_asset|reinsurance_trust`',
    `primary_manager_flag` BOOLEAN COMMENT 'Boolean indicator identifying the lead portfolio manager with primary fiduciary responsibility. Exactly one assignment per portfolio should have this flag set to true at any point in time. Used for regulatory reporting and investment committee documentation.',
    `rbc_charge_category` STRING COMMENT 'Designates the Risk-Based Capital (RBC) charge category applicable to this portfolio per NAIC RBC instructions. C-1 covers asset default risk, C-3 covers interest rate and market risk for general account portfolios. Drives capital adequacy calculations and ORSA reporting.. Valid values are `c1_asset_risk|c2_insurance_risk|c3_interest_rate_risk|c4_business_risk`',
    `rebalancing_frequency` STRING COMMENT 'Scheduled frequency at which the portfolio is reviewed and rebalanced to strategic asset allocation targets. May be calendar-based or trigger-based (drift threshold breach). Governs trade execution scheduling.. Valid values are `daily|weekly|monthly|quarterly|annual|trigger_based`',
    `rebalancing_trigger_threshold_pct` DECIMAL(18,2) COMMENT 'Maximum allowable percentage drift from strategic asset allocation targets before a mandatory rebalancing event is triggered. Defined in the investment policy statement and monitored by the compliance module.',
    `risk_tolerance_tier` STRING COMMENT 'Categorical risk tolerance classification assigned to the portfolio by the investment committee. Drives permitted asset allocation ranges, maximum credit quality thresholds, and duration band constraints within the investment mandate.. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `strategic_alternative_target_pct` DECIMAL(18,2) COMMENT 'Long-term strategic target allocation percentage for alternative assets (private equity, hedge funds, real estate, infrastructure) within this portfolio. Subject to NAIC Schedule BA reporting and RBC C-1 charges.',
    `strategic_equity_target_pct` DECIMAL(18,2) COMMENT 'Long-term strategic target allocation percentage for equity assets within this portfolio, as approved by the investment committee. Used in rebalancing trigger calculations and ALM compliance monitoring.',
    `strategic_fixed_income_target_pct` DECIMAL(18,2) COMMENT 'Long-term strategic target allocation percentage for fixed income assets within this portfolio. Core to ALM duration matching and liability-driven investment strategy for general account portfolios.',
    `tactical_equity_weight_pct` DECIMAL(18,2) COMMENT 'Current tactical allocation weight for equity assets, reflecting short-term market views and deviations from the strategic target. Compared against strategic target to compute rebalancing drift.',
    `tactical_fixed_income_weight_pct` DECIMAL(18,2) COMMENT 'Current tactical allocation weight for fixed income assets, reflecting short-term positioning relative to the strategic target. Used in ALM duration drift monitoring.',
    `target_duration_years` DECIMAL(18,2) COMMENT 'Target modified duration of the portfolio in years, set by the ALM committee to match the duration of corresponding insurance policy reserve liabilities. Core to interest rate risk management and C-3 RBC charge calculations.',
    `valuation_date` DATE COMMENT 'The as-of date for the most recent Fair Market Value (FMV) or Net Asset Value (NAV) calculation of the portfolio. Critical for statutory reporting, GAAP/IFRS financial statements, and variable product unit value calculations.',
    CONSTRAINT pk_portfolio PRIMARY KEY(`portfolio_id`)
) COMMENT 'Master record for each investment portfolio managed within the general account or separate account. Tracks portfolio type (general account fixed income, separate account equity, alternative assets), ALM classification, investment mandate, benchmark index, risk tolerance tier, regulatory classification (NAIC Schedule D/E/BA), RBC charge category, inception date, portfolio manager assignment, strategic and tactical asset allocation targets, actual allocation weights, and rebalancing triggers. Serves as the SSOT for all portfolio-level investment positions, asset allocation governance, and performance attribution.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`asset_holding` (
    `asset_holding_id` BIGINT COMMENT 'Unique surrogate identifier for each individual investment position record held within a portfolio at a point in time. Primary key for the asset_holding data product. ROLE: MASTER_RESOURCE.',
    `alternative_asset_id` BIGINT COMMENT 'Foreign key linking to investment.alternative_asset. Business justification: asset_holding represents positions in all asset types including alternatives (private equity, hedge funds, real estate funds). When the asset_class is Alternative, the holding should reference the a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Asset holdings must be attributed to legal entities for Schedule D reporting, RBC C1 calculations, and statutory financial statements required by state insurance regulators.',
    `mortgage_loan_id` BIGINT COMMENT 'Foreign key linking to investment.mortgage_loan. Business justification: asset_holding represents positions in all asset types including mortgages. When the asset_class is Mortgage Loan, the holding should reference the mortgage_loan master record. asset_holding currentl',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: General account asset holdings must be allocated to specific product lines for statutory Schedule D reporting, RBC calculation, and asset adequacy testing. Each holding supports specific product liabi',
    `contract_owner_id` BIGINT COMMENT 'Foreign key linking to policyholder.contract_owner. Business justification: Variable life insurance policies require contract owners to receive Schedule K-1 tax reporting on underlying asset holdings in separate accounts. Link enables tax document generation, cost basis track',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio (general account or separate account) in which this asset position is held. Used to aggregate holdings by portfolio for ALM, RBC, and performance attribution.',
    `security_id` BIGINT COMMENT 'Foreign key linking to investment.security. Business justification: CRITICAL missing link. asset_holding has cusip and isin attributes but no FK to security master. Holdings must reference the authoritative security catalog. The security table contains cusip, isin, se',
    `statutory_exhibit_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_exhibit. Business justification: Asset holdings populate statutory exhibits (Schedule D for bonds/stocks, Schedule BA for other invested assets). Real business need: traceability from individual holding to exhibit line item for regul',
    `account_type` STRING COMMENT 'Indicates whether the investment position is held in the general account (insurers own assets backing policyholder reserves and surplus) or a separate account (assets held for the benefit of variable product policyholders, segregated from general account). Critical for statutory reporting, RBC, and variable product unit value calculations.. Valid values are `general_account|separate_account`',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The interest earned on a fixed income security since the last coupon payment date but not yet received. Included in the total carrying value for NAIC Schedule D reporting and investment income accrual under both SAP and GAAP.',
    `acquisition_date` DATE COMMENT 'The date on which the investment position was originally acquired or purchased. Used for holding period calculations, cost basis determination, NAIC Schedule D reporting, and tax lot accounting under IRC Section 1221.',
    `amortized_cost` DECIMAL(18,2) COMMENT 'The acquisition cost of a fixed income security adjusted for the systematic amortization of premium or accretion of discount over the holding period using the effective interest method. Represents the GAAP/SAP carrying value for held-to-maturity and available-for-sale bonds.',
    `as_of_date` DATE COMMENT 'The valuation or reporting date as of which this holding record represents the position snapshot. Critical for point-in-time portfolio composition reporting, NAIC Schedule D filing, and RBC calculation. Enables historical position reconstruction.',
    `asset_class` STRING COMMENT 'Broad investment asset class classification of the holding. Drives NAIC Schedule assignment, RBC investment risk charge category, and ALM duration bucketing. [ENUM-REF-CANDIDATE: fixed_income|equity|mortgage_loan|alternative|short_term|derivative|other — promote to reference product]',
    `asset_subtype` STRING COMMENT 'Granular subtype classification within the asset class (e.g., corporate bond, government bond, agency MBS, CMBS, common stock, preferred stock, private equity, hedge fund, real estate, infrastructure, Schedule BA other). Used for detailed NAIC Schedule D-1, D-2, E, BA, B classification and RBC charge calculation. [ENUM-REF-CANDIDATE: corporate_bond|government_bond|agency_mbs|cmbs|abs|common_stock|preferred_stock|private_equity|hedge_fund|real_estate|infrastructure|schedule_ba_other — promote to reference product]',
    `book_value` DECIMAL(18,2) COMMENT 'The carrying value of the investment on the companys statutory balance sheet, representing the original cost adjusted for amortization, accretion, and impairments under SAP. Used for statutory financial reporting and RBC calculations.',
    `convexity` DECIMAL(18,2) COMMENT 'The convexity measure of a fixed income security, representing the second-order sensitivity of the bonds price to interest rate changes. Used alongside duration for more precise ALM interest rate risk hedging and scenario analysis in actuarial valuation systems.',
    `coupon_frequency` STRING COMMENT 'The frequency at which interest payments are made on a fixed income security. Used for investment income accrual scheduling, cash flow projection, and ALM cash flow matching.. Valid values are `annual|semi_annual|quarterly|monthly|at_maturity|zero_coupon`',
    `coupon_rate` DECIMAL(18,2) COMMENT 'The annual interest rate stated on a fixed income security, expressed as a decimal (e.g., 0.045 for 4.5%). Used for investment income accrual, cash flow projection in actuarial valuation, and ALM duration calculations. Null for equity and non-interest-bearing instruments.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this asset holding record was first created in the data platform. Used for data lineage, audit trail, and record management in the Databricks Silver Layer.',
    `credit_rating` STRING COMMENT 'The credit quality rating assigned by a Nationally Recognized Statistical Rating Organization (NRSRO) such as Moodys, S&P, or Fitch (e.g., AAA, Aa1, BBB-, Ba2). Used alongside NAIC designation for credit risk assessment, RBC investment risk charge calculation, and investment policy compliance monitoring.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the investment is denominated (e.g., USD, EUR, GBP). Required for foreign currency translation, FX risk reporting, and NAIC Schedule D foreign investment disclosures.. Valid values are `^[A-Z]{3}$`',
    `dividend_rate` DECIMAL(18,2) COMMENT 'The annual dividend rate for equity securities or preferred stock, expressed as a decimal or per-share amount. Used for investment income projection and portfolio yield analysis. Null for fixed income and non-dividend-paying instruments.',
    `duration_years` DECIMAL(18,2) COMMENT 'The modified duration of the fixed income security expressed in years, measuring the price sensitivity of the bond to changes in interest rates. Core input for ALM duration matching, interest rate risk management, and RBC C-3 (interest rate risk) charge calculations.',
    `fair_market_value` DECIMAL(18,2) COMMENT 'The estimated market value of the investment position at the as-of date, representing the price at which the asset could be exchanged between knowledgeable, willing parties. Used for GAAP reporting under FASB ASC 820, separate account unit value calculations, and NAIC Schedule D FMV column.',
    `holding_status` STRING COMMENT 'Current lifecycle status of the investment position. Active indicates the position is currently held; sold indicates the position has been disposed of; matured indicates a fixed income security that has reached its maturity date; defaulted indicates the issuer has defaulted; written_off indicates the position has been fully impaired.. Valid values are `active|sold|matured|defaulted|written_off`',
    `impairment_amount` DECIMAL(18,2) COMMENT 'The cumulative impairment loss recognized on the investment position, representing the write-down from amortized cost to estimated recoverable value. Reported in NAIC Schedule D and GAAP financial statements. Null if impairment_flag is false.',
    `impairment_flag` BOOLEAN COMMENT 'Indicates whether the investment has been identified as other-than-temporarily impaired (OTTI) under FASB ASC 320 or credit-impaired under FASB ASC 326 (CECL). Triggers recognition of impairment loss in the income statement and disclosure in NAIC Schedule D.',
    `is_144a_eligible` BOOLEAN COMMENT 'Indicates whether the security was issued under SEC Rule 144A, allowing resale to Qualified Institutional Buyers (QIBs) without SEC registration. Relevant for liquidity classification, investment policy compliance, and NAIC Schedule D private placement reporting.',
    `is_private_placement` BOOLEAN COMMENT 'Indicates whether the security is a privately placed instrument not registered with the SEC. Private placements require separate NAIC Schedule D-1 reporting, SVO filing, and may carry higher RBC charges due to reduced liquidity.',
    `issuer_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the issuers domicile. Used for foreign investment concentration limits, country risk assessment, NAIC Schedule D foreign investment disclosures, and ORSA country risk reporting.. Valid values are `^[A-Z]{3}$`',
    `issuer_sector` STRING COMMENT 'The economic sector or industry classification of the security issuer using NAIC or GICS taxonomy (e.g., financial, utilities, technology, government, sovereign). Used for sector concentration monitoring, investment policy compliance, and portfolio diversification analytics. [ENUM-REF-CANDIDATE: government|financial|utilities|technology|healthcare|energy|consumer|industrial|real_estate|sovereign — promote to reference product]',
    `liquidity_classification` STRING COMMENT 'Classification of the investments liquidity profile indicating how quickly the position can be converted to cash without significant price impact. Used for ALM liquidity stress testing, ORSA liquidity risk reporting, and alternative asset lock-up period management.. Valid values are `liquid|semi_liquid|illiquid|locked_up`',
    `maturity_date` DATE COMMENT 'The contractual date on which a fixed income securitys principal is scheduled to be repaid in full. Used for ALM duration matching, cash flow projection in actuarial valuation systems, and NAIC Schedule D reporting. Null for equity and perpetual instruments.',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation assigned to fixed income securities (1 through 6, where 1 is highest quality and 6 is in or near default). Drives statutory reserve requirements, RBC investment risk charges, and investment eligibility under state insurance regulations. Blank for non-fixed-income assets.. Valid values are `1|2|3|4|5|6`',
    `naic_rbc_factor` DECIMAL(18,2) COMMENT 'The NAIC-prescribed RBC investment risk charge factor applicable to this asset based on its asset class, NAIC designation, and issuer type. Multiplied by the book value or amortized cost to calculate the C-1 (asset default) risk charge component in the RBC formula.',
    `naic_schedule_code` STRING COMMENT 'NAIC Annual Statement Schedule classification code indicating which statutory schedule this asset is reported on: D-1 (bonds owned), D-2 (bonds acquired/disposed), E (cash and short-term investments), BA (other long-term invested assets), B (mortgage loans). Mandatory for statutory financial reporting.. Valid values are `D-1|D-2|E|BA|B`',
    `par_value` DECIMAL(18,2) COMMENT 'The face or nominal value of the security as stated on the instrument, representing the principal amount for bonds or the stated value for equities. Used in NAIC Schedule D reporting, amortized cost calculations, and coupon income accrual.',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units, shares, or contracts held for this investment position. For bonds, represents the face amount in units; for equities, the number of shares; for fund interests, the number of units or partnership interests. Core measurement field for the resource.',
    `rating_agency` STRING COMMENT 'The Nationally Recognized Statistical Rating Organization (NRSRO) that assigned the credit rating for this security. Required for NAIC SVO cross-reference and regulatory credit quality validation.. Valid values are `Moodys|SP|Fitch|DBRS|Kroll|AM_Best`',
    `source_system_code` STRING COMMENT 'The unique identifier assigned to this investment position record in the originating investment management system (e.g., Charles River IMS position ID, SimCorp Dimension holding reference). Used for data lineage, reconciliation between the lakehouse and source systems, and audit trail.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The difference between the fair market value and the amortized cost (or book value) of the investment position, representing the mark-to-market gain or loss not yet realized through sale. Reported in NAIC Schedule D and used for GAAP OCI reporting under FASB ASC 320.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this asset holding record was most recently updated in the data platform, reflecting the latest valuation refresh, status change, or data correction. Used for incremental data processing and audit trail in the Databricks Silver Layer.',
    `yield_to_maturity` DECIMAL(18,2) COMMENT 'The total annualized return anticipated on a fixed income security if held to maturity, expressed as a decimal. Used for investment income projection, portfolio yield reporting, and ALM asset-liability spread analysis.',
    CONSTRAINT pk_asset_holding PRIMARY KEY(`asset_holding_id`)
) COMMENT 'Represents an individual investment position held within a portfolio at a point in time, covering all asset classes including fixed income, equity, mortgage loans, alternative investments (private equity, hedge funds, real estate, infrastructure), and other Schedule BA assets. Captures CUSIP/ISIN identifier, asset class and subtype, NAIC designation, book value, amortized cost, FMV, par value, quantity/units held, acquisition date, maturity date, coupon/dividend rate, credit rating, NAIC Schedule classification (D-1, D-2, E, BA, B). For mortgage loans: property type, LTV ratio, DSCR, amortization type, loan status, appraisal value. For alternative assets: fund manager, commitment/funded/unfunded amounts, vintage year, investment strategy, liquidity classification, lock-up period. Core operational record for portfolio composition, RBC investment risk charge calculations, and NAIC Schedule reporting across all asset types.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`security` (
    `security_id` BIGINT COMMENT 'Unique surrogate identifier for each security record in the enterprise master catalog. Primary key for the security data product used across trade execution, valuation, and compliance systems.',
    `report_line_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_line_definition. Business justification: Securities map to specific statutory report lines based on NAIC designation, asset class, and schedule classification. Real business need: automated population of statutory schedules with correct line',
    `asset_class` STRING COMMENT 'Broad asset class grouping of the security used for portfolio allocation, ALM analysis, and RBC investment risk charge categorization. Supports general account and separate account investment policy compliance monitoring.. Valid values are `fixed_income|equity|alternative|cash_equivalent|real_estate|derivative`',
    `benchmark_index` STRING COMMENT 'Reference index against which the securitys performance is measured or to which a floating rate coupon is linked (e.g., Bloomberg US Aggregate, SOFR, LIBOR, S&P 500). Used for performance attribution in SimCorp Dimension and floating rate coupon reset calculations.',
    `call_date` DATE COMMENT 'Earliest date on which the issuer may exercise the call option to redeem the security at the call price. Used in yield-to-call calculations, OAS valuation, and ALM scenario analysis for callable bond portfolios. Null if callable_flag is false.',
    `call_price` DECIMAL(18,2) COMMENT 'Price at which the issuer may redeem the security upon exercise of the call option, expressed as a percentage of par (e.g., 101.00 = 101% of par). Used in yield-to-call calculations and ALM cash flow modeling for callable securities.',
    `callable_flag` BOOLEAN COMMENT 'Indicates whether the issuer has the right to redeem the security before its scheduled maturity date. Callable securities require option-adjusted spread (OAS) valuation and introduce reinvestment risk in ALM cash flow projections.',
    `cdr_rate` DECIMAL(18,2) COMMENT 'Annualized rate at which the underlying collateral pool of a structured security (MBS, ABS, CMO) is expected to default, expressed as a decimal. Used in cash flow modeling for structured products, NAIC designation determination, and actuarial reserve projections.',
    `convertible_flag` BOOLEAN COMMENT 'Indicates whether the security can be converted into a predetermined number of equity shares at the holders option. Convertible securities require bifurcated accounting treatment under FASB ASC 470-20 and specific NAIC designation handling.',
    `convexity` DECIMAL(18,2) COMMENT 'Second-order measure of the sensitivity of the securitys duration to changes in interest rates. Used alongside modified duration in ALM hedging strategies and interest rate scenario analysis for general account portfolio management.',
    `coupon_frequency` STRING COMMENT 'Frequency at which coupon interest payments are made to the security holder. Used for investment income accrual scheduling, cash flow projection, and ALM liability matching in the actuarial valuation system.. Valid values are `annual|semi_annual|quarterly|monthly|at_maturity`',
    `coupon_rate` DECIMAL(18,2) COMMENT 'Annual interest rate expressed as a decimal (e.g., 0.03250 for 3.250%) paid by the issuer to bondholders. Used for investment income accrual, cash flow projection in actuarial valuation systems (AXIS, Prophet), and ALM duration/convexity calculations.',
    `coupon_type` STRING COMMENT 'Classification of the interest payment structure of the security. Determines cash flow modeling approach in actuarial valuation (MoSes, AXIS, Prophet) and ALM interest rate sensitivity analysis. Fixed coupons provide predictable income; floating coupons introduce interest rate risk.. Valid values are `fixed|floating|zero_coupon|step_up|payment_in_kind|variable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the security record was first created in the enterprise master catalog. Supports data lineage, audit trail requirements, and SOX compliance for investment data governance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the security is denominated (e.g., USD, EUR, GBP). Used for foreign currency exposure reporting, FMV translation to functional currency, and NAIC Schedule D currency risk disclosure.. Valid values are `^[A-Z]{3}$`',
    `cusip` STRING COMMENT 'Nine-character alphanumeric identifier assigned by the American Bankers Association to uniquely identify North American securities. Primary external identifier used in trade settlement, NAIC reporting, and regulatory filings.. Valid values are `^[0-9A-Z]{9}$`',
    `day_count_convention` STRING COMMENT 'Method used to calculate accrued interest between coupon payment dates (e.g., 30/360, Actual/360, Actual/365, Actual/Actual). Critical for accurate investment income accrual, trade settlement calculations, and NAIC Schedule D amortized cost reporting.. Valid values are `30_360|actual_360|actual_365|actual_actual`',
    `duration_years` DECIMAL(18,2) COMMENT 'Modified duration of the security expressed in years, measuring price sensitivity to a 1% change in interest rates. Core input for ALM duration matching between general account assets and insurance policy liabilities, and for RBC interest rate risk charge calculations.',
    `effective_date` DATE COMMENT 'Date from which the security record became active and eligible for use in trade execution, valuation, and compliance systems. Supports point-in-time reporting and audit trail requirements for NAIC and SEC regulatory submissions.',
    `exchange_code` STRING COMMENT 'ISO 10383 Market Identifier Code (MIC) of the primary exchange on which the security is listed (e.g., XNYS for NYSE, XNAS for NASDAQ). Used for trade execution routing in Charles River IMS and market data feed mapping.. Valid values are `^[A-Z]{2,6}$`',
    `first_coupon_date` DATE COMMENT 'Date of the first scheduled coupon payment after issuance. Used to calculate the initial accrued interest period, which may be a short or long first coupon period, for accurate investment income accrual and cash flow modeling.',
    `fitch_rating` STRING COMMENT 'Credit quality rating assigned by Fitch Ratings (e.g., AAA, AA+, BBB-, BB+). Used as a third-party credit opinion for NAIC designation determination and investment policy compliance monitoring when Moodys or S&P ratings are unavailable or split-rated.',
    `gics_industry_group` STRING COMMENT 'Second-level GICS industry group classification providing more granular sector segmentation (e.g., Banks, Insurance, Diversified Financials). Supports detailed sector exposure reporting and investment guideline compliance checks.',
    `gics_sector` STRING COMMENT 'Top-level sector classification per the MSCI/S&P Global Industry Classification Standard (GICS) framework (e.g., Financials, Energy, Health Care). Used for sector concentration monitoring, performance attribution, and investment policy compliance in SimCorp Dimension.',
    `isin` STRING COMMENT 'Twelve-character alphanumeric code conforming to ISO 6166 that uniquely identifies a security globally. Used for cross-border trade execution, reinsurance reporting, and international portfolio compliance.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `issue_date` DATE COMMENT 'Date on which the security was originally issued by the issuer. Used to calculate seasoning for MBS/ABS prepayment modeling, determine accrued interest at purchase, and support NAIC Schedule D historical reporting.',
    `issuer_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country of domicile of the issuing entity. Used for geographic concentration analysis, sovereign risk assessment, and cross-border regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `issuer_name` STRING COMMENT 'Legal name of the entity that issued the security (e.g., corporation, government, special purpose vehicle). Used for issuer concentration limit monitoring, credit exposure aggregation, and NAIC Schedule D reporting.',
    `maturity_date` DATE COMMENT 'Date on which the principal amount of a fixed income security is scheduled to be repaid to the holder. Critical for ALM duration matching, cash flow projection in actuarial systems, and NAIC Schedule D reporting. Null for perpetual or equity instruments.',
    `moodys_rating` STRING COMMENT 'Credit quality rating assigned by Moodys Investors Service (e.g., Aaa, Aa1, Aa2, A1, Baa3, Ba1, Caa1). Used for NAIC designation mapping, RBC credit risk charge calculation, and investment policy compliance monitoring. [ENUM-REF-CANDIDATE: Aaa|Aa1|Aa2|Aa3|A1|A2|A3|Baa1|Baa2|Baa3|Ba1|Ba2|Ba3|B1|B2|B3|Caa1|Caa2|Caa3|Ca|C|NR — promote to reference product]',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation (1 through 6) assigned to fixed income securities for statutory reporting and RBC capital charge calculation. Designation 1 represents highest quality (investment grade); Designation 6 represents lowest quality (in or near default). Drives SAP reserve and capital requirements.. Valid values are `1|2|3|4|5|6`',
    `naic_designation_modifier` STRING COMMENT 'Modifier appended to the NAIC designation for structured securities (e.g., E for equity-like treatment under NAIC filing exempt methodology, * for securities subject to AVR/IMR). Refines the RBC capital charge and statutory reserve treatment for ABS, MBS, and CMO instruments.. Valid values are `E|*|`',
    `par_value` DECIMAL(18,2) COMMENT 'Nominal or face value of the security as stated by the issuer, typically $1,000 for corporate bonds or $1.00 for equities. Used as the basis for coupon payment calculations, NAIC Schedule D amortized cost reporting, and statutory reserve calculations.',
    `prepayment_speed` DECIMAL(18,2) COMMENT 'Assumed prepayment rate for mortgage-backed or asset-backed securities expressed as a percentage of the Public Securities Association (PSA) standard or Constant Prepayment Rate (CPR). Used in MBS/ABS cash flow modeling for ALM and actuarial valuation.',
    `private_placement_flag` BOOLEAN COMMENT 'Indicates whether the security is a privately placed instrument not registered with the SEC (e.g., NAIC Schedule D Part 4 private placements). Private placements require enhanced credit analysis, illiquidity premium assessment, and specific NAIC statutory reporting treatment.',
    `putable_flag` BOOLEAN COMMENT 'Indicates whether the holder has the right to sell the security back to the issuer before maturity at a predetermined price. Putable securities affect ALM duration calculations and require option-adjusted valuation in the investment management system.',
    `rule_144a_flag` BOOLEAN COMMENT 'Indicates whether the security was issued under SEC Rule 144A as a private placement to qualified institutional buyers (QIBs). Rule 144A securities have restricted transferability and specific NAIC Schedule D reporting requirements as private placements.',
    `sec_registration_status` STRING COMMENT 'Registration status of the security with the U.S. Securities and Exchange Commission. Determines transferability restrictions, disclosure requirements, and eligibility for inclusion in variable product separate accounts under SEC and FINRA regulations.. Valid values are `registered|exempt|144a|regulation_s|unregistered`',
    `security_name` STRING COMMENT 'Full legal or descriptive name of the security as registered with the issuer or exchange (e.g., Apple Inc. 3.250% Senior Notes due 2029, US Treasury Note 2.875% 05/15/2032). Human-readable identifier used in reporting, statements, and compliance documentation.',
    `security_status` STRING COMMENT 'Current lifecycle status of the security in the enterprise master catalog. Active securities are eligible for trading and portfolio inclusion; matured/called/defaulted securities are retained for historical reporting and NAIC Schedule D reconciliation.. Valid values are `active|inactive|matured|called|defaulted|suspended`',
    `security_type` STRING COMMENT 'Classification of the security by instrument category. Drives valuation methodology, RBC capital charge calculation, NAIC designation assignment, and ALM duration matching. [ENUM-REF-CANDIDATE: corporate_bond|government_bond|mbs|abs|cmo|common_equity|preferred_equity|private_placement|structured_note|municipal_bond|convertible_bond|agency_bond|treasury_bill|commercial_paper — promote to reference product]',
    `sedol` STRING COMMENT 'Seven-character alphanumeric identifier issued by the London Stock Exchange for securities traded on UK and Irish exchanges. Used for international equity and fixed income identification in global portfolios.. Valid values are `^[A-Z0-9]{7}$`',
    `sp_rating` STRING COMMENT 'Credit quality rating assigned by S&P Global Ratings (e.g., AAA, AA+, AA, A+, BBB-, BB+, CCC+). Used alongside Moodys and Fitch ratings for NAIC designation determination, RBC capital charge calculation, and investment guideline compliance. [ENUM-REF-CANDIDATE: AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|D|NR — promote to reference product]',
    `spread_basis_points` DECIMAL(18,2) COMMENT 'Yield spread of the security over its benchmark index expressed in basis points (e.g., 125 bps over the 10-year Treasury). Used for relative value analysis, credit risk monitoring, and investment income attribution in the investment management system.',
    `ticker_symbol` STRING COMMENT 'Exchange-assigned alphabetic abbreviation used to identify a publicly traded security on a stock exchange. Used in equity portfolio management, performance attribution, and market data feeds within Charles River IMS and SimCorp Dimension.. Valid values are `^[A-Z]{1,10}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the security record was most recently modified in the enterprise master catalog. Used for change data capture (CDC) in the Databricks Silver Layer ETL pipeline and audit trail compliance under SOX.',
    CONSTRAINT pk_security PRIMARY KEY(`security_id`)
) COMMENT 'Master catalog of all investable securities and instruments recognized by the enterprise. Stores CUSIP, ISIN, SEDOL, ticker symbol, security type (corporate bond, government bond, MBS, ABS, CMO, common equity, preferred equity, private placement, structured note), issuer name, sector/industry classification (GICS), credit rating (Moodys, S&P, Fitch), NAIC designation, coupon type, maturity date, callable flag, 144A flag, and SEC registration status. SSOT for security reference data used across trade execution, valuation, and compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`trade` (
    `trade_id` BIGINT COMMENT 'Primary key for trade',
    `employee_id` BIGINT COMMENT 'Reference to the trader or portfolio manager who initiated the order. Used for performance attribution, audit trails, and trader activity analysis.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Trades execute within legal entity books for statutory accounting, settlement, and intercompany reconciliation. Required for regulatory reporting and audit trail.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio (general account or separate account) for which this trade is executed. Links to portfolio master data for Asset Liability Management (ALM) and Risk-Based Capital (RBC) reporting.',
    `report_exception_id` BIGINT COMMENT 'Foreign key linking to reporting.report_exception. Business justification: Trade compliance breaches, pricing anomalies, or settlement failures generate report exceptions requiring resolution before filing. Real business need: audit trail from trade event to reporting except',
    `security_id` BIGINT COMMENT 'Reference to the security being traded (bond, equity, alternative asset). Links to security master data containing CUSIP, ISIN, and NAIC designation.',
    `suitability_review_id` BIGINT COMMENT 'Foreign key linking to compliance.suitability_review. Business justification: Variable annuity trades require suitability review under FINRA Reg BI and state insurance regulations. Real business process: variable product sales supervision, suitability determination documentatio',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty borrowing the security in a securities lending transaction. Null for non-lending trades. Links to counterparty master data for credit risk monitoring.',
    `trade_counterparty_id` BIGINT COMMENT 'Reference to the broker-dealer firm executing the trade. Links to broker master data containing FINRA CRD number and SEC registration details.',
    `alm_duration_impact` DECIMAL(18,2) COMMENT 'Change in portfolio duration resulting from this trade, measured in years. Used for Asset Liability Management (ALM) duration matching to ensure investment portfolio duration aligns with policy liability duration.',
    `broker_confirmation_number` STRING COMMENT 'Unique confirmation number assigned by the broker-dealer for this execution. Used for trade reconciliation and settlement matching.',
    `collateral_type` STRING COMMENT 'Type of collateral received for securities lending transaction: cash (cash collateral reinvested), securities (non-cash collateral), letter_of_credit (bank guarantee). Null for non-lending trades.. Valid values are `cash|securities|letter_of_credit`',
    `collateral_value` DECIMAL(18,2) COMMENT 'Fair Market Value (FMV) of collateral received for securities lending transaction. Typically 102-105% of lent security value. Null for non-lending trades. Monitored daily for margin calls.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Broker commission charged for executing the trade. Included in total transaction cost for performance attribution and best execution analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade order record was first created in the Investment Management System. Used for audit trails and data lineage.',
    `executed_price` DECIMAL(18,2) COMMENT 'Actual price per unit at which the trade was executed. For bonds, typically expressed as percentage of par. For equities, price per share. Used for Fair Market Value (FMV) and Net Asset Value (NAV) calculations.',
    `executed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of the security executed in this trade record. For partial fills, multiple execution records exist per order, each with its own executed quantity. Sum of executed quantities across all fills equals order quantity when fully filled.',
    `execution_date` DATE COMMENT 'Date the trade was executed by the broker-dealer. May differ from order date for orders placed after market close or multi-day orders. Used for trade date accounting.',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time the trade was executed on the exchange or over-the-counter market. Sourced from broker confirmation. Critical for best execution analysis and transaction cost analysis (TCA).',
    `execution_venue` STRING COMMENT 'Market or exchange where the trade was executed (e.g., NYSE, NASDAQ, OTC, private placement). Required for best execution reporting and SEC Rule 606 compliance.',
    `lending_fee_rate` DECIMAL(18,2) COMMENT 'Annual fee rate earned on securities lending transaction, expressed as decimal (e.g., 0.0050 for 50 basis points). Null for non-lending trades. Fee income allocated to investment income.',
    `limit_price` DECIMAL(18,2) COMMENT 'Maximum price (for buy orders) or minimum price (for sell orders) at which the order may be executed. Null for market orders. Used for best execution compliance.',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation of the security at time of trade (e.g., NAIC 1 for highest quality bonds, NAIC 6 for in or near default). Determines RBC charges and investment limit compliance.',
    `order_date` DATE COMMENT 'Date the trade order was initiated by the portfolio manager or trader. Used for trade date accounting and settlement cycle calculation (T+1, T+2).',
    `order_number` STRING COMMENT 'Business-facing unique order number assigned by the Investment Management System (IMS) for external reference and reconciliation. Used in broker confirmations and audit trails.',
    `order_price_type` STRING COMMENT 'Pricing instruction for the order: market (execute at current market price), limit (execute at specified price or better), stop (trigger at stop price), stop_limit (trigger at stop, execute at limit).. Valid values are `market|limit|stop|stop_limit`',
    `order_quantity` DECIMAL(18,2) COMMENT 'Quantity of the security ordered (number of shares for equity, par value for bonds, units for alternatives). Supports fractional quantities for certain asset types.',
    `order_status` STRING COMMENT 'Current lifecycle status of the trade order: pending (awaiting submission), submitted (sent to broker), partially_filled (partial execution), filled (fully executed), cancelled (order cancelled), rejected (failed compliance or broker rejection), expired (time limit exceeded). [ENUM-REF-CANDIDATE: pending|submitted|partially_filled|filled|cancelled|rejected|expired — 7 candidates stripped; promote to reference product]',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time the trade order was created in the Investment Management System. Critical for best execution analysis and regulatory audit trails.',
    `order_type` STRING COMMENT 'Type of trade order: buy (acquire security), sell (dispose security), short (borrow and sell), cover (buy to close short), securities_lending (lend security to counterparty), securities_recall (recall lent security).. Valid values are `buy|sell|short|cover|securities_lending|securities_recall`',
    `post_trade_compliance_notes` STRING COMMENT 'Detailed notes from post-trade compliance review, including any exceptions, remediation actions, or escalations to the investment committee.',
    `post_trade_compliance_status` STRING COMMENT 'Result of post-trade compliance review verifying the executed trade complies with investment policy, RBC limits, and NAIC guidelines. Failed status triggers remediation workflow.. Valid values are `passed|failed|under_review`',
    `pre_trade_compliance_notes` STRING COMMENT 'Detailed notes from pre-trade compliance screening, including any warnings, limit breaches, or override justifications. Critical for regulatory exam defense.',
    `pre_trade_compliance_status` STRING COMMENT 'Result of pre-trade compliance checks against investment policy limits, RBC constraints, NAIC investment guidelines, and concentration limits. Override indicates manual approval by compliance officer.. Valid values are `passed|failed|override|not_required`',
    `rationale` STRING COMMENT 'Business justification for the trade documented by the portfolio manager (e.g., ALM rebalancing, yield enhancement, credit upgrade, liquidity management). Required for investment committee reporting and regulatory exams.',
    `rbc_investment_risk_charge` DECIMAL(18,2) COMMENT 'Incremental Risk-Based Capital (RBC) C-1 investment risk charge resulting from this trade. Used to monitor RBC ratio impact and ensure compliance with NAIC RBC requirements.',
    `recall_date` DATE COMMENT 'Date when lent securities are recalled from the borrower. Null for non-lending trades or open-ended lending agreements. Triggers securities_recall order creation.',
    `reinvestment_details` STRING COMMENT 'Description of how cash collateral from securities lending is reinvested (e.g., money market funds, short-term bonds). Null for non-cash collateral or non-lending trades. Required for NAIC Schedule DL disclosure.',
    `securities_lending_flag` BOOLEAN COMMENT 'Indicates whether this trade is part of a securities lending transaction. True for securities_lending and securities_recall order types. Triggers additional NAIC Schedule DL disclosure requirements.',
    `settlement_date` DATE COMMENT 'Date when cash and securities are exchanged to settle the trade. Typically T+1 or T+2 depending on security type and market. Used for cash flow projections and liquidity management.',
    `settlement_status` STRING COMMENT 'Current status of trade settlement: pending (awaiting settlement date), settled (cash and securities exchanged), failed (settlement did not complete), cancelled (trade cancelled before settlement).. Valid values are `pending|settled|failed|cancelled`',
    `stop_price` DECIMAL(18,2) COMMENT 'Trigger price for stop or stop-limit orders. When market price reaches this level, the order becomes active. Null for market and limit orders.',
    `total_transaction_cost` DECIMAL(18,2) COMMENT 'Sum of commission and transaction fees. Used for transaction cost analysis (TCA) and performance attribution. Does not include market impact or opportunity cost.',
    `transaction_fee_amount` DECIMAL(18,2) COMMENT 'Additional transaction fees including exchange fees, clearing fees, and regulatory fees (SEC fees, FINRA TAF). Separate from broker commission.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade order record was last modified. Tracks status changes, execution updates, and settlement events. Used for audit trails and change data capture.',
    CONSTRAINT pk_trade PRIMARY KEY(`trade_id`)
) COMMENT 'Records the full trade lifecycle from order initiation through execution and settlement for all investment transaction types including buy/sell orders, short/cover trades, and securities lending transactions. Captures order details (order type, security, portfolio, quantity, limit/market price, order date/time, trader ID, broker-dealer, compliance pre-trade check), execution details (executed price, executed quantity, execution timestamp, broker confirmation number, commission, transaction costs, execution venue, post-trade compliance check), and for securities lending: security lent, borrower counterparty, collateral type and value, lending fee rate, recall date, reinvestment details. Supports partial fills (multiple execution records per order), trade cost analysis, best execution reporting, SEC/FINRA compliance, and NAIC Schedule D securities lending disclosure.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`trade_execution` (
    `trade_execution_id` BIGINT COMMENT 'Unique identifier for the trade execution record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the investment professional who placed or managed the trade order that resulted in this execution. Used for performance attribution and compliance monitoring.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio (general account or separate account) for which this trade was executed. Critical for variable product unit value calculations and Asset Liability Management (ALM) tracking.',
    `counterparty_id` BIGINT COMMENT 'Reference to the broker-dealer firm that executed this trade. Critical for best execution analysis and counterparty risk monitoring.',
    `security_id` BIGINT COMMENT 'Reference to the security that was traded in this execution.',
    `trade_id` BIGINT COMMENT 'Reference to the parent trade order that generated this execution. One order may result in multiple partial executions.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'For fixed income securities, the interest accrued from the last coupon payment date to the trade date, paid by the buyer to the seller.',
    `allocation_method` STRING COMMENT 'For executions that need to be allocated across multiple portfolios or accounts, this indicates the allocation methodology used.. Valid values are `pro_rata|fifo|lifo|specific_lot|average_cost`',
    `alm_bucket` STRING COMMENT 'The duration or maturity bucket assigned to this trade for Asset Liability Management (ALM) purposes. Used to match asset cash flows with policy liability cash flows.',
    `asset_class` STRING COMMENT 'High-level classification of the security traded. Supports Asset Liability Management (ALM) duration matching and portfolio diversification analysis.. Valid values are `equity|fixed_income|derivative|alternative|cash_equivalent|real_estate`',
    `average_price_flag` BOOLEAN COMMENT 'Indicates whether this execution is part of a volume-weighted average price (VWAP) or time-weighted average price (TWAP) algorithmic strategy.',
    `best_execution_flag` BOOLEAN COMMENT 'Indicates whether this execution met the firms best execution criteria based on price, speed, and likelihood of execution. Required for Securities and Exchange Commission (SEC) Rule 606 reporting.',
    `block_trade_flag` BOOLEAN COMMENT 'Indicates whether this execution qualifies as a block trade (typically 10,000+ shares or $200,000+ value). Block trades may receive special handling and reporting treatment.',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when this execution was recorded in the investment management system. Used for audit trail and operational monitoring.',
    `commission_amount` DECIMAL(18,2) COMMENT 'The brokerage commission charged for executing this trade. Part of total transaction cost analysis.',
    `compliance_check_result` STRING COMMENT 'Result of automated post-trade compliance checks against Risk-Based Capital (RBC) limits, National Association of Insurance Commissioners (NAIC) investment guidelines, and internal investment policy constraints.. Valid values are `passed|failed|warning|pending|override_approved`',
    `compliance_rule_violated` STRING COMMENT 'If compliance check failed or returned a warning, this field captures the specific rule or limit that was breached. Empty if compliance passed.',
    `confirmation_number` STRING COMMENT 'The unique confirmation number provided by the broker-dealer for this trade execution. Used for reconciliation and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the trade execution. Typically USD for US-domiciled insurers, but may vary for international investments.. Valid values are `^[A-Z]{3}$`',
    `exchange_code` STRING COMMENT 'The Market Identifier Code (MIC) of the exchange where the trade was executed, if applicable. Empty for Over-The-Counter (OTC) trades.',
    `executed_price` DECIMAL(18,2) COMMENT 'The actual price per unit at which the trade was executed. This is the fill price, which may differ from the order limit price.',
    `executed_quantity` DECIMAL(18,2) COMMENT 'The number of units (shares, bonds, contracts) actually filled in this execution. For partial fills, this will be less than the original order quantity.',
    `execution_capacity` STRING COMMENT 'Indicates whether the broker-dealer acted as principal (trading from own inventory) or agent (matching buyer and seller) in this execution.. Valid values are `principal|agency|riskless_principal|mixed`',
    `execution_method` STRING COMMENT 'The method by which the trade was executed. Supports analysis of execution quality and operational efficiency.. Valid values are `electronic|manual|algorithmic|voice|direct_market_access`',
    `execution_status` STRING COMMENT 'Current lifecycle status of the trade execution in the post-trade workflow. [ENUM-REF-CANDIDATE: executed|partially_filled|cancelled|rejected|pending_settlement|settled|failed — 7 candidates stripped; promote to reference product]',
    `execution_timestamp` TIMESTAMP COMMENT 'The precise date and time when the trade was executed in the market. This is the actual fill time, distinct from order placement or settlement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this execution record was last updated. Supports change tracking and audit requirements.',
    `naic_designation` STRING COMMENT 'The National Association of Insurance Commissioners (NAIC) credit quality designation for fixed income securities (1-6 scale) or equity designation. Used for statutory reporting and Risk-Based Capital (RBC) calculations.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'The total cash amount to be settled, including principal, accrued interest, commissions, and fees. Positive for purchases (cash outflow), negative for sales (cash inflow).',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about the execution, including special circumstances, manual overrides, or compliance exceptions.',
    `order_type` STRING COMMENT 'The type of order that resulted in this execution. Inherited from the parent trade order for execution analysis. [ENUM-REF-CANDIDATE: market|limit|stop|stop_limit|trailing_stop|fill_or_kill|immediate_or_cancel — 7 candidates stripped; promote to reference product]',
    `price_improvement_amount` DECIMAL(18,2) COMMENT 'The dollar amount of price improvement achieved versus the National Best Bid and Offer (NBBO) at the time of execution. Positive values indicate favorable execution.',
    `principal_amount` DECIMAL(18,2) COMMENT 'The gross trade value before commissions and fees, calculated as executed_quantity × executed_price. Represents the market value of the securities traded.',
    `rbc_category` STRING COMMENT 'The National Association of Insurance Commissioners (NAIC) Risk-Based Capital (RBC) investment category assigned to this security for capital adequacy calculations. Determines the RBC charge factor.',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this trade was executed for a separate account supporting variable products (Variable Universal Life (VUL), Variable Annuity (VA)) versus the general account. Critical for unit value calculations and Securities and Exchange Commission (SEC) reporting.',
    `settlement_date` DATE COMMENT 'The date on which the trade is scheduled to settle and securities/cash are exchanged. Typically T+1 or T+2 depending on asset class and jurisdiction.',
    `time_in_force` STRING COMMENT 'The duration for which the order remains active. Inherited from the parent trade order.. Valid values are `day|good_till_cancel|immediate_or_cancel|fill_or_kill|good_till_date`',
    `trade_date` DATE COMMENT 'The calendar date on which the trade was executed. Used for accounting, performance attribution, and regulatory reporting. Distinct from settlement date.',
    `trade_side` STRING COMMENT 'Indicates whether this execution represents a buy or sell transaction from the insurers perspective.. Valid values are `buy|sell|short_sell|cover`',
    `trade_venue` STRING COMMENT 'The type of market venue where the trade was executed. Critical for best execution reporting and Securities and Exchange Commission (SEC) / Financial Industry Regulatory Authority (FINRA) compliance.. Valid values are `exchange|otc|dark_pool|crossing_network|dealer|direct`',
    `transaction_fee` DECIMAL(18,2) COMMENT 'Additional fees charged for the trade execution, including exchange fees, clearing fees, and regulatory fees (SEC fees, FINRA TAF).',
    CONSTRAINT pk_trade_execution PRIMARY KEY(`trade_execution_id`)
) COMMENT 'Records the actual execution of a trade order, capturing fill details including executed price, executed quantity, execution timestamp, broker-dealer confirmation number, commission and transaction costs, settlement date, counterparty, trade venue (exchange, OTC, dark pool), and post-trade compliance check result. One trade order may result in multiple partial executions. Supports trade cost analysis, best execution reporting, and SEC/FINRA compliance for variable product separate accounts.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`valuation` (
    `valuation_id` BIGINT COMMENT 'Unique identifier for the investment position valuation record.',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: Valuation records are daily FMV assessments of specific asset holdings (positions). The existing position_id attribute semantically refers to asset_holding. Adding explicit asset_holding_id FK and rem',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fair value measurements require independent validation separate from pricing source for Level 2/3 assets. SOX controls and actuarial standards of practice mandate tracking the validator for audit trai',
    `valuation_run_id` BIGINT COMMENT 'Reference to the batch valuation run or process that generated this valuation record.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The amount of interest income that has accrued on fixed income securities since the last coupon payment date.',
    `adjustment_reason` STRING COMMENT 'For adjusted valuations, the business reason or explanation for the manual adjustment or override.',
    `amortized_cost` DECIMAL(18,2) COMMENT 'The book value of the investment position calculated using the amortized cost method, adjusted for premium/discount amortization.',
    `ask_price` DECIMAL(18,2) COMMENT 'The lowest price a seller is willing to accept for the security at the valuation date.',
    `bid_price` DECIMAL(18,2) COMMENT 'The highest price a buyer is willing to pay for the security at the valuation date.',
    `collateral_balance` DECIMAL(18,2) COMMENT 'For derivative positions, the amount of collateral posted or received under the collateral agreement at the valuation date.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the valuation is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cva` DECIMAL(18,2) COMMENT 'For derivative positions, the adjustment to fair value to account for counterparty credit risk.',
    `delta` DECIMAL(18,2) COMMENT 'For derivative positions, the rate of change of the option value with respect to changes in the underlying asset price.',
    `dv01` DECIMAL(18,2) COMMENT 'For fixed income and derivative positions, the change in value for a one basis point change in interest rates.',
    `dva` DECIMAL(18,2) COMMENT 'For derivative positions, the adjustment to fair value to account for the entitys own credit risk.',
    `fair_value_hierarchy_level` STRING COMMENT 'The ASC 820 fair value hierarchy tier: Level 1 (quoted prices in active markets), Level 2 (observable inputs), or Level 3 (unobservable inputs).. Valid values are `Level 1|Level 2|Level 3`',
    `fmv_per_unit` DECIMAL(18,2) COMMENT 'The fair market value of a single unit of the investment position (e.g., price per share, price per bond).',
    `gamma` DECIMAL(18,2) COMMENT 'For derivative positions, the rate of change of delta with respect to changes in the underlying asset price.',
    `hedge_effectiveness_test_result` STRING COMMENT 'For derivative positions designated as hedges, the result of the ASC 815 hedge effectiveness test.. Valid values are `Highly Effective|Not Effective|Not Applicable`',
    `market_value_including_accrued` DECIMAL(18,2) COMMENT 'The total market value of the position including accrued interest (dirty price for bonds).',
    `mid_price` DECIMAL(18,2) COMMENT 'The midpoint between the bid and ask prices, often used as the fair value estimate.',
    `model_used` STRING COMMENT 'For positions valued using internal models, the name or identifier of the valuation model applied (e.g., Black-Scholes, Monte Carlo, Binomial Tree).',
    `naic_valuation_method` STRING COMMENT 'The NAIC-prescribed valuation method for statutory accounting purposes (e.g., market, amortized cost, fair value option).. Valid values are `Market|Amortized Cost|Fair Value Option|Equity Method`',
    `nav_per_share` DECIMAL(18,2) COMMENT 'For separate account or mutual fund positions, the net asset value per share or unit at the valuation date.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or explanations related to the valuation.',
    `price_source_identifier` STRING COMMENT 'The specific identifier or ticker symbol used by the pricing source to identify the security (e.g., Bloomberg ticker, CUSIP, ISIN).',
    `pricing_method` STRING COMMENT 'The methodology used to determine the fair market value (e.g., market quote, discounted cash flow model, matrix pricing).. Valid values are `Market Quote|Model Valuation|Matrix Pricing|Broker Quote|NAV|Amortized Cost`',
    `pricing_source` STRING COMMENT 'The source system or vendor that provided the valuation price (e.g., Bloomberg, ICE Data Services, internal actuarial model). [ENUM-REF-CANDIDATE: Bloomberg|ICE|Reuters|Internal Model|Vendor Quote|Broker Quote|Matrix Pricing — 7 candidates stripped; promote to reference product]',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units held in the investment position at the valuation date.',
    `rbc_charge` DECIMAL(18,2) COMMENT 'The calculated RBC charge for this investment position, used in statutory capital adequacy reporting.',
    `rbc_factor` DECIMAL(18,2) COMMENT 'The NAIC risk-based capital factor applied to this investment position for RBC calculation purposes.',
    `theta` DECIMAL(18,2) COMMENT 'For derivative positions, the rate of change of the option value with respect to the passage of time (time decay).',
    `total_fmv` DECIMAL(18,2) COMMENT 'The total fair market value of the position, calculated as FMV per unit multiplied by quantity.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The difference between total FMV and amortized cost, representing unrealized gains or losses on the position.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was last modified in the system.',
    `valuation_date` DATE COMMENT 'The business date on which this valuation was performed.',
    `valuation_status` STRING COMMENT 'The current status of the valuation record in the valuation workflow (e.g., final, preliminary, pending review, adjusted).. Valid values are `Final|Preliminary|Pending Review|Adjusted|Rejected`',
    `valuation_timestamp` TIMESTAMP COMMENT 'The precise date and time when this valuation was calculated.',
    `variation_margin_call` DECIMAL(18,2) COMMENT 'For derivative positions, the amount of variation margin called or owed based on mark-to-market changes.',
    `vega` DECIMAL(18,2) COMMENT 'For derivative positions, the sensitivity of the option value to changes in the volatility of the underlying asset.',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Daily or periodic fair market value (FMV), NAV, and mark-to-market valuation records for all investment positions including cash securities, derivative contracts, and separate account units. Captures valuation date, asset or derivative reference, pricing source (Bloomberg, ICE, internal model), FMV per unit, total FMV, amortized cost, unrealized gain/loss, NAIC valuation method, ASC 820 fair value hierarchy tier (Level 1/2/3). For derivative valuations: greeks (delta, gamma, vega, theta), DV01, CVA (credit valuation adjustment), DVA (debit valuation adjustment), collateral balance, variation margin call, and valuation model used. Supports GAAP/SAP financial reporting, LDTI reserve calculations, ASC 815 hedge effectiveness testing, NAIC Schedule D and DB reporting, variable product unit value computations, and counterparty credit risk monitoring. Unified SSOT for all investment position valuations regardless of asset type.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`separate_account` (
    `separate_account_id` BIGINT COMMENT 'Unique identifier for the separate account. Primary key for the separate account master record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Separate accounts are registered products of specific legal entities, required for SEC registration tracking, state insurance department filings, and variable annuity regulatory compliance.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Separate accounts are product-specific investment vehicles for variable annuities and variable life insurance. Each separate account is registered under specific product plans for SEC and state insura',
    `policy_form_approval_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_form_approval. Business justification: Variable separate accounts require state insurance department form approval before sale (prospectus, contract forms, disclosure documents). Real business process: product filing, state approval tracki',
    `producer_id` BIGINT COMMENT 'Foreign key linking to agent.producer. Business justification: Variable annuity and variable life separate account funds are sold by licensed producers. FINRA Rule 2320 requires tracking selling producer for variable product suitability supervision. Essential for',
    `rate_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.rate_filing. Business justification: Variable product mortality & expense charges and administrative fees require rate filing approval in many states. Real business process: fee schedule filing, state regulatory approval, rate compliance',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Sub-advisers are vendors managing separate account assets. Business processes: sub-advisory fee calculation, performance attribution, regulatory filings (Form N-4, ADV), vendor due diligence, contract',
    `account_name` STRING COMMENT 'Full legal name of the separate account as registered with the SEC and state insurance departments. Appears on prospectus and policy documents.',
    `account_number` STRING COMMENT 'Business identifier for the separate account, used in policy statements and regulatory filings. Externally visible account number.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_short_name` STRING COMMENT 'Abbreviated name used for internal reporting and policyholder statements. Marketing-friendly display name.',
    `accumulation_unit_value` DECIMAL(18,2) COMMENT 'Current value of one accumulation unit for variable life (VUL) and variable annuity accumulation phase contracts. Calculated daily as NAV divided by units outstanding, net of expenses.',
    `annuity_unit_value` DECIMAL(18,2) COMMENT 'Current value of one annuity unit for variable annuity contracts in payout phase. Calculated daily, adjusted for assumed investment return (AIR).',
    `assumed_investment_return` DECIMAL(18,2) COMMENT 'Assumed investment return rate used for annuity unit value calculations during payout phase, expressed as a decimal (e.g., 0.035 for 3.5%). Determines baseline annuity payment adjustments.',
    `benchmark_index` STRING COMMENT 'Market index used to measure relative performance of the separate account. Examples: S&P 500, Russell 2000, Bloomberg Barclays Aggregate Bond Index.',
    `closure_date` DATE COMMENT 'Date the separate account was closed to new allocations or terminated. Null for active accounts.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this separate account record was first created in the system. Used for audit trail and data lineage.',
    `cusip` STRING COMMENT 'Nine-character CUSIP identifier for the separate account, if applicable. Used for securities identification and regulatory reporting.. Valid values are `^[0-9]{9}$`',
    `daily_return_rate` DECIMAL(18,2) COMMENT 'Daily investment return rate for the separate account, expressed as a decimal (e.g., 0.0125 for 1.25% return). Used to calculate unit value changes and policyholder account value growth.',
    `expense_ratio` DECIMAL(18,2) COMMENT 'Annual operating expense ratio of the separate account, expressed as a decimal (e.g., 0.0075 for 0.75%). Includes investment management fees, administrative costs, and fund expenses. Disclosed in prospectus.',
    `finra_oversight_flag` BOOLEAN COMMENT 'Indicates whether the separate account is subject to FINRA broker-dealer oversight and suitability requirements. True for variable products sold through registered representatives.',
    `fund_type` STRING COMMENT 'Primary asset class classification of the separate account investment portfolio. Determines investment strategy and risk profile. [ENUM-REF-CANDIDATE: equity|bond|money_market|balanced|specialty|index|target_date — 7 candidates stripped; promote to reference product]',
    `guaranteed_benefit_flag` BOOLEAN COMMENT 'Indicates whether the separate account supports guaranteed minimum benefit riders (GMDB, GMIB, GMWB, GMAB). True if any guaranteed benefit calculations reference this separate account performance.',
    `inception_date` DATE COMMENT 'Date the separate account was established and began operations. Used for performance history calculations and regulatory reporting.',
    `investment_objective` STRING COMMENT 'Stated investment goal and strategy of the separate account as disclosed in the prospectus. Defines risk tolerance, return targets, and investment approach.',
    `isin` STRING COMMENT 'Twelve-character ISIN for the separate account, used for international securities identification and cross-border reporting.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent independent financial audit of the separate account. Required annually for SEC-registered separate accounts.',
    `maximum_allocation_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of a policyholder account value that may be allocated to this separate account, expressed as a percentage (e.g., 100.00 for 100%). Used to enforce diversification requirements.',
    `minimum_allocation_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount required for initial or subsequent allocations to this separate account. Enforced at policy servicing level.',
    `mortality_and_expense_charge` DECIMAL(18,2) COMMENT 'Annual mortality and expense risk charge assessed against the separate account, expressed as a decimal (e.g., 0.0125 for 1.25%). Covers insurance guarantees and administrative expenses. Deducted from daily unit value calculations.',
    `naic_investment_category` STRING COMMENT 'NAIC investment category classification for regulatory reporting. Maps to NAIC Annual Statement Schedule D investment categories.',
    `pricing_date` DATE COMMENT 'Business date for which the current unit values and NAV are calculated. Typically the most recent market close date.',
    `pricing_source` STRING COMMENT 'Name of the third-party pricing vendor or internal system providing daily NAV and unit value calculations. Examples: Bloomberg, NAIC SVO, internal valuation system.',
    `pricing_timestamp` TIMESTAMP COMMENT 'Exact date and time when the daily unit value calculation was completed and published. Used for audit trail and regulatory compliance.',
    `prospectus_date` DATE COMMENT 'Effective date of the current prospectus governing this separate account. Used to ensure policyholders receive current disclosure documents.',
    `rbc_investment_risk_charge` DECIMAL(18,2) COMMENT 'NAIC Risk-Based Capital investment risk charge factor for this separate account, expressed as a decimal. Used in company-level RBC calculations to determine required capital for variable product guarantees.',
    `sec_registered_flag` BOOLEAN COMMENT 'Indicates whether the separate account is registered with the SEC as an investment company under the Investment Company Act of 1940. True for all variable product separate accounts.',
    `sec_registration_number` STRING COMMENT 'SEC-assigned registration number for the separate account under the Investment Company Act of 1940. Required for all variable product separate accounts.. Valid values are `^[0-9]{3}-[0-9]{5}$`',
    `separate_account_status` STRING COMMENT 'Current operational status of the separate account. Active accounts accept new allocations; closed accounts maintain existing positions but accept no new money; terminated accounts are fully liquidated.. Valid values are `active|closed_to_new|suspended|liquidating|terminated`',
    `total_nav` DECIMAL(18,2) COMMENT 'Current total net asset value of the separate account in USD. Sum of all policyholder account values allocated to this separate account. Updated daily after market close.',
    `transfer_restriction_flag` BOOLEAN COMMENT 'Indicates whether transfers into or out of this separate account are subject to restrictions (e.g., market timing restrictions, round-trip limits). True if restrictions apply.',
    `units_outstanding` DECIMAL(18,2) COMMENT 'Total number of accumulation units or annuity units outstanding across all policyholders. Used to calculate unit value (NAV / units outstanding).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this separate account record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_separate_account PRIMARY KEY(`separate_account_id`)
) COMMENT 'Master record for each separate account maintained for variable life (VUL) and variable annuity products, including daily accumulation unit value (AUV) pricing history. Tracks separate account name, SEC registration number, fund type (equity, bond, money market, balanced), investment objective, benchmark index, total NAV, expense ratio, sub-adviser name, regulatory status (SEC-registered, FINRA oversight). Daily pricing records capture: accumulation unit value, annuity unit value, total net assets, units outstanding, daily return, expense deductions (M&E charges, fund expenses), and pricing source. Used to calculate policyholder account values for VUL and variable annuity contracts, support GMDB/GMIB/GMWB benefit base calculations, and meet SEC/FINRA daily pricing requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`unit_value` (
    `unit_value_id` BIGINT COMMENT 'Unique identifier for the unit value record. Primary key.',
    `annuitant_id` BIGINT COMMENT 'Foreign key linking to policyholder.annuitant. Business justification: Unit value records drive annuitant-specific benefit base calculations for GMDB/GMIB/GMWB riders. System must link unit values to annuitants for daily benefit base updates, RMD calculations, and annuit',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Separate account unit values require approval before publication to policyholders and SEC/FINRA reporting. Regulatory requirements mandate tracking the approver for audit trail and to ensure independe',
    `separate_account_id` BIGINT COMMENT 'Identifier of the separate account fund to which this unit value applies. Links to the separate account master.',
    `accumulation_unit_value` DECIMAL(18,2) COMMENT 'The calculated value of one accumulation unit on the calculation date. Used to determine policyholder account values for VUL and variable annuity contracts in the accumulation phase.',
    `adjustment_reason` STRING COMMENT 'Business reason for any manual adjustment or correction applied to the unit value calculation. Required for audit trail when status is adjusted.',
    `administrative_charge` DECIMAL(18,2) COMMENT 'Daily administrative charge deducted from the unit value. Expressed as a percentage rate. Covers policy servicing and recordkeeping costs.',
    `annuity_unit_value` DECIMAL(18,2) COMMENT 'The calculated value of one annuity unit on the calculation date. Used to determine benefit payments for variable annuity contracts in the payout phase.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit value was approved and finalized. Marks the point at which the value becomes official for policyholder account value calculations.',
    `approved_by` STRING COMMENT 'User ID or name of the individual who approved the final unit value. Required for SOX compliance and audit trail.',
    `calculation_date` DATE COMMENT 'Business date for which the unit value is calculated. Represents the valuation date per SEC/FINRA daily pricing requirements.',
    `calculation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the unit value calculation was completed. Used for audit trail and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit value record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code in which the unit value is denominated.. Valid values are `^[A-Z]{3}$`',
    `daily_return` DECIMAL(18,2) COMMENT 'Daily investment return percentage for the fund. Calculated as (current unit value - prior unit value) / prior unit value. Used for performance reporting and GMDB/GMIB/GMWB benefit base calculations.',
    `finra_reporting_indicator` BOOLEAN COMMENT 'Flag indicating whether this unit value is subject to FINRA reporting requirements for variable products sold through broker-dealers.',
    `fund_code` STRING COMMENT 'Business identifier for the separate account fund. Used for external reporting and policyholder communications.. Valid values are `^[A-Z0-9]{4,12}$`',
    `fund_expense_ratio` DECIMAL(18,2) COMMENT 'Daily fund management expense ratio deducted from the unit value. Expressed as a percentage rate. Covers investment management fees and fund operating expenses.',
    `fund_name` STRING COMMENT 'Full legal name of the separate account fund.',
    `gmdb_benefit_base_factor` DECIMAL(18,2) COMMENT 'Factor applied to unit value for GMDB benefit base calculations. Used to determine guaranteed death benefit amounts for variable annuity contracts with GMDB riders.',
    `gmib_benefit_base_factor` DECIMAL(18,2) COMMENT 'Factor applied to unit value for GMIB benefit base calculations. Used to determine guaranteed income benefit amounts for variable annuity contracts with GMIB riders.',
    `gmwb_benefit_base_factor` DECIMAL(18,2) COMMENT 'Factor applied to unit value for GMWB benefit base calculations. Used to determine guaranteed withdrawal benefit amounts for variable annuity contracts with GMWB riders.',
    `inception_date` DATE COMMENT 'Date when the separate account fund was first established. Used for performance inception-to-date calculations.',
    `inception_to_date_return` DECIMAL(18,2) COMMENT 'Cumulative investment return percentage from fund inception to the calculation date. Used for long-term performance reporting.',
    `inception_unit_value` DECIMAL(18,2) COMMENT 'Initial unit value assigned at fund inception. Typically set to a standard value such as 10.00 or 1.00.',
    `mortality_and_expense_charge` DECIMAL(18,2) COMMENT 'Daily mortality and expense risk charge deducted from the unit value. Expressed as a percentage rate. Covers insurance guarantees and administrative expenses.',
    `nav_per_share` DECIMAL(18,2) COMMENT 'Net asset value per share of the underlying mutual fund or investment vehicle. Used as input to unit value calculation when the separate account invests in external funds.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, explanations, or special circumstances related to the unit value calculation.',
    `price_source_identifier` STRING COMMENT 'External identifier from the pricing source (e.g., Bloomberg ticker, CUSIP, ISIN) used to retrieve asset prices.',
    `pricing_method` STRING COMMENT 'Methodology used to determine the fair market value of underlying assets for unit value calculation.. Valid values are `market_close|fair_value|model_based|vendor_quote|matrix_pricing`',
    `pricing_source` STRING COMMENT 'Source system or vendor that provided the underlying asset prices used in the unit value calculation. [ENUM-REF-CANDIDATE: bloomberg|reuters|morningstar|internal_valuation|custodian|fund_company|third_party_administrator — 7 candidates stripped; promote to reference product]',
    `prior_day_unit_value` DECIMAL(18,2) COMMENT 'Unit value from the previous business day. Used to calculate daily return and validate calculation continuity.',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit value was published to downstream systems and made available for policyholder inquiries and account value calculations.',
    `rider_charge` DECIMAL(18,2) COMMENT 'Daily charge for optional riders (GMDB, GMIB, GMWB, etc.) deducted from the unit value. Expressed as a percentage rate.',
    `sec_filing_indicator` BOOLEAN COMMENT 'Flag indicating whether this unit value is subject to SEC reporting requirements. True for registered variable products.',
    `total_expense_deduction` DECIMAL(18,2) COMMENT 'Total daily expense deduction percentage applied to the unit value. Sum of M&E charge, fund expense ratio, administrative charge, and rider charges.',
    `total_net_assets` DECIMAL(18,2) COMMENT 'Total net asset value of the separate account fund on the calculation date. Represents the aggregate fair market value of all fund holdings less liabilities.',
    `unit_value_status` STRING COMMENT 'Current status of the unit value record in the calculation and approval workflow.. Valid values are `final|preliminary|adjusted|suspended|pending_approval|rejected`',
    `units_outstanding` DECIMAL(18,2) COMMENT 'Total number of accumulation or annuity units outstanding for the fund on the calculation date. Used in NAV per unit calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the unit value record was last modified. Used for audit trail and change tracking.',
    `year_to_date_return` DECIMAL(18,2) COMMENT 'Cumulative investment return percentage from the beginning of the calendar year to the calculation date. Used for performance reporting.',
    CONSTRAINT pk_unit_value PRIMARY KEY(`unit_value_id`)
) COMMENT 'Daily accumulation unit value (AUV) records for each separate account fund. Captures calculation date, accumulation unit value, annuity unit value, total net assets, units outstanding, daily return, expense deductions (M&E charges, fund expenses), and pricing source. Used to calculate policyholder account values for VUL and variable annuity contracts, support GMDB/GMIB/GMWB benefit base calculations, and meet SEC/FINRA daily pricing requirements.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`income_allocation` (
    `income_allocation_id` BIGINT COMMENT 'Primary key for income_allocation',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Investment income recognition (dividends, interest, amortization) requires approval for SAP/GAAP classification, Schedule D line item assignment, and separate account unit value impact. SOX controls m',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: Investment income (interest, dividends) is earned on specific asset holdings. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing position_i',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Investment income allocations generate journal entries for GL booking, SAP/GAAP income recognition, and reconciliation between investment and accounting systems. Critical for financial statement prepa',
    `original_income_income_allocation_id` BIGINT COMMENT 'Reference to the original income allocation record if this is a reversal or adjustment entry.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Investment income must be allocated to product lines for statutory accounting (SAP Schedule D), dividend scale calculations for participating products, and crediting rate determination for universal l',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which this income belongs.',
    `report_line_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_line_definition. Business justification: Investment income allocates to specific statutory report lines (Schedule D Part 4, IMR calculations). Real business need: income classification for statutory reporting, ensuring correct line item popu',
    `tax_lot_id` BIGINT COMMENT 'Reference to the specific tax lot associated with this income allocation for cost basis tracking.',
    `accrual_date` DATE COMMENT 'Date on which the income was earned or accrued for accounting purposes.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Interest income that has been earned but not yet received as of the reporting date.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Dollar amount of income allocated based on the allocation basis and percentage.',
    `allocation_basis` STRING COMMENT 'Basis for allocating investment income: policy reserve, surplus, separate account, general account, or unallocated.. Valid values are `policy_reserve|surplus|separate_account|general_account|unallocated`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of income allocated to the specified basis (e.g., 100% to policy reserves, 50% to surplus).',
    `alm_segment` STRING COMMENT 'ALM segment or product line to which this income is allocated for duration matching and cash flow projection.',
    `amortization_amount` DECIMAL(18,2) COMMENT 'Amount of premium or discount amortized during the period, affecting net investment income.',
    `amortization_method` STRING COMMENT 'Method used for amortizing bond premium or discount: straight-line, effective interest, or scientific method.. Valid values are `straight_line|effective_interest|scientific`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment income allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the income amount.. Valid values are `^[A-Z]{3}$`',
    `ex_dividend_date` DATE COMMENT 'Date on which a security begins trading without the right to receive the declared dividend.',
    `gaap_income_classification` STRING COMMENT 'Classification of income for GAAP financial reporting purposes per FASB ASC 944.',
    `gross_income_amount` DECIMAL(18,2) COMMENT 'Total income amount before any deductions, withholdings, or adjustments.',
    `income_notes` STRING COMMENT 'Additional notes or comments regarding the income allocation, including special circumstances or adjustments.',
    `income_recognition_method` STRING COMMENT 'Method used to recognize investment income: accrual basis, cash basis, or modified cash basis.. Valid values are `accrual|cash|modified_cash`',
    `income_status` STRING COMMENT 'Current status of the income allocation record in its lifecycle.. Valid values are `accrued|received|pending|reversed|adjusted`',
    `income_subtype` STRING COMMENT 'Detailed classification of income within the primary type (e.g., qualified dividend, non-qualified dividend, coupon interest, accrued interest).',
    `income_type` STRING COMMENT 'Classification of investment income: interest income, dividend income, rental income (real estate), partnership income (alternatives), securities lending fee income, or amortization of premium/discount.. Valid values are `interest|dividend|rental|partnership|securities_lending_fee|amortization_premium_discount`',
    `investment_income_due` DECIMAL(18,2) COMMENT 'Amount of investment income due and accrued but not yet received as of the reporting date.',
    `naic_designation` STRING COMMENT 'NAIC quality designation for the investment asset (1-6 scale, with modifiers).. Valid values are `^[1-6][A-Z]?$`',
    `net_income_amount` DECIMAL(18,2) COMMENT 'Income amount after deducting withholding taxes and other adjustments.',
    `payment_date` DATE COMMENT 'Date on which the income payment was received or is expected to be received.',
    `product_line` STRING COMMENT 'Insurance product line supported by this investment income (e.g., whole life, universal life, annuities).',
    `rbc_category` STRING COMMENT 'NAIC Risk-Based Capital category for the asset generating this income, used for RBC calculations.',
    `record_date` DATE COMMENT 'Date of record for determining entitlement to the income payment (applicable for dividends and distributions).',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this income allocation has been reversed or adjusted.',
    `reversal_reason` STRING COMMENT 'Explanation for why the income allocation was reversed or adjusted.',
    `sap_income_classification` STRING COMMENT 'Classification of income for statutory accounting purposes per NAIC guidelines (e.g., investment income, realized capital gains).',
    `schedule_d_line_item` STRING COMMENT 'NAIC Annual Statement Schedule D line item reference for statutory income reporting.',
    `separate_account_code` STRING COMMENT 'Code identifying the separate account if income is allocated to variable product separate accounts.',
    `unit_value_impact` DECIMAL(18,2) COMMENT 'Impact of this income allocation on the unit value calculation for variable product separate accounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment income allocation record was last modified.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source from the income payment (e.g., foreign withholding tax).',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Percentage rate of tax withheld from the gross income amount.',
    CONSTRAINT pk_income_allocation PRIMARY KEY(`income_allocation_id`)
) COMMENT 'Records investment income earned and allocated from portfolio assets, including interest income, dividend income, rental income (real estate), partnership income (alternatives), securities lending fee income, and amortization of premium/discount. Captures income type, accrual date, payment date, gross income amount, withholding tax, net income, allocation basis (policy reserve, surplus, separate account), and SAP/GAAP income classification. Supports investment income allocation to policy reserves, actuarial cash flow projections, statutory Schedule D income reporting, and investment income statement preparation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`alm_analysis` (
    `alm_analysis_id` BIGINT COMMENT 'Primary key for alm_analysis',
    `cohort_definition_id` BIGINT COMMENT 'Reference to the liability cohort that this portfolio segment is matched against for duration and cash flow alignment.',
    `orsa_report_id` BIGINT COMMENT 'Foreign key linking to compliance.orsa_report. Business justification: ALM interest rate risk analysis feeds ORSA risk assessment and capital adequacy conclusions. Real business process: ORSA report preparation, interest rate risk quantification, regulatory filing. Requi',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: ALM duration targets and gap measurements are designed around specific product liability characteristics (term life vs. whole life vs. annuities). Product-specific ALM strategies drive investment poli',
    `portfolio_segment_id` BIGINT COMMENT 'Reference to the investment portfolio segment being analyzed for ALM purposes. Links to the specific portfolio grouping aligned to liability cohorts.',
    `valuation_run_id` BIGINT COMMENT 'Identifier for the batch or run that produced this ALM measurement. Enables traceability and reconciliation of ALM calculations across portfolio segments.',
    `alm_committee_decision` STRING COMMENT 'The decision or action taken by the ALM committee following review of this duration gap measurement. Documents governance oversight.. Valid values are `approved|escalated|remediation_plan_required|monitoring_continued`',
    `alm_committee_review_date` DATE COMMENT 'The date on which the ALM committee reviewed this duration gap measurement and approved or escalated the findings. Supports governance and oversight requirements.',
    `alm_strategy_type` STRING COMMENT 'The ALM strategy employed for this portfolio segment and liability cohort pairing. Defines the approach used to manage interest rate risk and ensure asset-liability alignment.. Valid values are `immunization|cash_flow_matching|dynamic_hedging|duration_matching|hybrid`',
    `asset_duration` DECIMAL(18,2) COMMENT 'The actual measured Macaulay or modified duration (in years) of the portfolio segment as of the measurement date. Represents the weighted average time to receive cash flows from the asset portfolio.',
    `convexity_gap` DECIMAL(18,2) COMMENT 'The difference between asset convexity and liability convexity. Measures the mismatch in non-linear interest rate sensitivity between assets and liabilities.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ALM analysis record was first created in the system. Audit trail for record creation.',
    `dollar_duration` DECIMAL(18,2) COMMENT 'The dollar change in portfolio value for a 1 basis point parallel shift in interest rates. Expressed in currency units. Combines duration and portfolio size to quantify absolute interest rate risk.',
    `duration_band_maximum` DECIMAL(18,2) COMMENT 'The maximum acceptable duration (in years) for the portfolio segment. Defines the upper bound of the duration tolerance band.',
    `duration_band_minimum` DECIMAL(18,2) COMMENT 'The minimum acceptable duration (in years) for the portfolio segment. Defines the lower bound of the duration tolerance band.',
    `duration_gap` DECIMAL(18,2) COMMENT 'The difference between asset duration and liability duration (asset_duration minus liability_duration). A positive gap indicates assets are longer than liabilities; a negative gap indicates the opposite. Critical metric for interest rate risk exposure.',
    `dv01` DECIMAL(18,2) COMMENT 'The dollar value change in the portfolio for a one basis point change in yield. Also known as PV01 or basis point value. Key metric for hedging and risk management.',
    `gap_status` STRING COMMENT 'The status of the duration gap relative to the defined tolerance band. Indicates whether the gap is acceptable or requires management action.. Valid values are `within_tolerance|breach_minor|breach_major|under_review|remediation_required`',
    `interest_rate_sensitivity_parallel_shift_down_100bp` DECIMAL(18,2) COMMENT 'The estimated change in portfolio value (in currency units) under a parallel downward shift of 100 basis points across the entire yield curve. Used for stress testing and RBC C-3 calculations.',
    `interest_rate_sensitivity_parallel_shift_up_100bp` DECIMAL(18,2) COMMENT 'The estimated change in portfolio value (in currency units) under a parallel upward shift of 100 basis points across the entire yield curve. Used for stress testing and RBC C-3 calculations.',
    `interest_rate_sensitivity_twist_flattening` DECIMAL(18,2) COMMENT 'The estimated change in portfolio value (in currency units) under a yield curve flattening scenario (short rates up, long rates down). Captures non-parallel yield curve risk.',
    `interest_rate_sensitivity_twist_steepening` DECIMAL(18,2) COMMENT 'The estimated change in portfolio value (in currency units) under a yield curve steepening scenario (short rates down, long rates up). Captures non-parallel yield curve risk.',
    `key_rate_duration_10yr` DECIMAL(18,2) COMMENT 'Target key rate duration for the 10-year maturity point on the yield curve. Measures sensitivity to parallel shifts at this specific tenor.',
    `key_rate_duration_1yr` DECIMAL(18,2) COMMENT 'Target key rate duration for the 1-year maturity point on the yield curve. Measures sensitivity to parallel shifts at this specific tenor.',
    `key_rate_duration_20yr` DECIMAL(18,2) COMMENT 'Target key rate duration for the 20-year maturity point on the yield curve. Measures sensitivity to parallel shifts at this specific tenor.',
    `key_rate_duration_30yr` DECIMAL(18,2) COMMENT 'Target key rate duration for the 30-year maturity point on the yield curve. Measures sensitivity to parallel shifts at this specific tenor.',
    `key_rate_duration_5yr` DECIMAL(18,2) COMMENT 'Target key rate duration for the 5-year maturity point on the yield curve. Measures sensitivity to parallel shifts at this specific tenor.',
    `liability_duration` DECIMAL(18,2) COMMENT 'The actual measured Macaulay or modified duration (in years) of the liability cohort as of the measurement date. Represents the weighted average time to pay cash flows to policyholders.',
    `measurement_date` DATE COMMENT 'The date on which the ALM duration gap measurement was performed. Represents the as-of date for all calculated metrics in this record.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when this ALM duration gap measurement was calculated. Provides audit trail for calculation timing.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, assumptions, or context related to this ALM measurement. Captures qualitative information not represented in structured fields.',
    `orsa_interest_rate_risk_scenario` STRING COMMENT 'The ORSA scenario identifier or description applied to this ALM measurement. Links the ALM analysis to enterprise risk management and ORSA reporting requirements.',
    `rbc_c3_interest_rate_risk_charge` DECIMAL(18,2) COMMENT 'The calculated RBC C-3 interest rate risk charge (in currency units) for this portfolio segment and liability cohort pairing. Used for statutory capital adequacy reporting.',
    `remediation_plan_description` STRING COMMENT 'Narrative description of the remediation plan or corrective actions to be taken if the duration gap is outside tolerance. Documents management response to identified risks.',
    `target_convexity` DECIMAL(18,2) COMMENT 'The target convexity measure for the portfolio segment. Convexity captures the curvature of the price-yield relationship and is critical for managing non-linear interest rate risk.',
    `target_duration` DECIMAL(18,2) COMMENT 'The target Macaulay or modified duration (in years) that the portfolio segment should maintain to match the liability cohort duration. Central metric for duration matching strategies.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this ALM analysis record was last modified. Audit trail for record updates.',
    CONSTRAINT pk_alm_analysis PRIMARY KEY(`alm_analysis_id`)
) COMMENT 'Comprehensive ALM (Asset Liability Management) record covering both duration matching targets/constraints and periodic gap measurement results for each portfolio segment aligned to liability cohorts. For targets: stores target duration, duration band (min/max), convexity target, key rate duration targets, liability cohort reference, ALM strategy type (immunization, cash flow matching, dynamic hedging). For measurements: captures measurement date, asset duration, liability duration, duration gap, convexity gap, dollar duration, DV01, interest rate sensitivity by scenario (parallel shift, twist, steepening), and gap status (within tolerance, breach). Supports duration gap monitoring, interest rate risk management, RBC C-3 interest rate risk charge calculations, ORSA interest rate risk reporting, and ALM committee governance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` (
    `alm_gap_measurement_id` BIGINT COMMENT 'Unique identifier for the ALM gap measurement record.',
    `portfolio_id` BIGINT COMMENT 'Identifier of the investment portfolio being measured for ALM gap analysis.',
    `report_definition_id` BIGINT COMMENT 'Foreign key linking to reporting.report_definition. Business justification: ALM gap measurements feed specific regulatory reports (C-3 interest rate risk, ORSA scenarios, ALM committee reports). Real business need: which ALM analysis supports which regulatory filing for risk ',
    `stochastic_scenario_id` BIGINT COMMENT 'Identifier of the interest rate scenario or stress test scenario applied in this measurement.',
    `alm_committee_decision` STRING COMMENT 'The decision or action taken by the ALM committee in response to this gap measurement.. Valid values are `approved|action_required|escalated|deferred|monitoring`',
    `alm_committee_review_date` DATE COMMENT 'The date on which the ALM committee reviewed this gap measurement.',
    `asset_convexity` DECIMAL(18,2) COMMENT 'The convexity measure of the asset portfolio, capturing the curvature of the price-yield relationship.',
    `asset_dollar_duration` DECIMAL(18,2) COMMENT 'The dollar value change in the asset portfolio for a 1% change in interest rates.',
    `asset_duration` DECIMAL(18,2) COMMENT 'The effective duration of the asset portfolio in years, measuring sensitivity to interest rate changes.',
    `asset_market_value` DECIMAL(18,2) COMMENT 'The total market value of the asset portfolio at the measurement date.',
    `base_yield_curve` STRING COMMENT 'The reference yield curve used as the baseline for this ALM gap measurement (e.g., US Treasury, LIBOR, SOFR).',
    `convexity_gap` DECIMAL(18,2) COMMENT 'The difference between asset convexity and liability convexity, indicating second-order interest rate risk exposure.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ALM gap measurement record was first created in the system.',
    `dollar_duration_gap` DECIMAL(18,2) COMMENT 'The difference between asset dollar duration and liability dollar duration, representing the net dollar exposure to interest rate movements.',
    `duration_gap` DECIMAL(18,2) COMMENT 'The difference between asset duration and liability duration (asset_duration minus liability_duration), indicating interest rate risk exposure.',
    `dv01_asset` DECIMAL(18,2) COMMENT 'The dollar value change in the asset portfolio for a 1 basis point (0.01%) change in interest rates.',
    `dv01_gap` DECIMAL(18,2) COMMENT 'The difference between asset DV01 and liability DV01, representing the net dollar exposure to a 1 basis point interest rate change.',
    `dv01_liability` DECIMAL(18,2) COMMENT 'The dollar value change in the liability portfolio for a 1 basis point (0.01%) change in interest rates.',
    `gap_status` STRING COMMENT 'The status of the ALM gap relative to established risk tolerance thresholds and policy limits.. Valid values are `within_tolerance|minor_breach|major_breach|critical_breach|under_review|remediation_required`',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'The proportion of the ALM gap that is hedged through derivatives or other risk mitigation instruments.',
    `liability_convexity` DECIMAL(18,2) COMMENT 'The convexity measure of the liability portfolio, capturing the curvature of the price-yield relationship.',
    `liability_dollar_duration` DECIMAL(18,2) COMMENT 'The dollar value change in the liability portfolio for a 1% change in interest rates.',
    `liability_duration` DECIMAL(18,2) COMMENT 'The effective duration of the liability portfolio in years, measuring sensitivity to interest rate changes.',
    `liability_market_value` DECIMAL(18,2) COMMENT 'The total market value of the liability portfolio at the measurement date.',
    `measurement_date` DATE COMMENT 'The date on which the ALM gap measurement was performed.',
    `measurement_methodology` STRING COMMENT 'The methodology used to calculate duration and convexity measures (effective duration, modified duration, key rate duration, option-adjusted duration).. Valid values are `effective_duration|modified_duration|key_rate_duration|option_adjusted_duration`',
    `measurement_notes` STRING COMMENT 'Additional notes, assumptions, or commentary regarding this ALM gap measurement.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the ALM gap measurement was calculated.',
    `measurement_type` STRING COMMENT 'The type or purpose of the ALM gap measurement (scheduled periodic measurement, ad-hoc analysis, stress test scenario, regulatory reporting).. Valid values are `scheduled|ad_hoc|stress_test|regulatory|quarterly|annual`',
    `parallel_shift_down_100bp_impact` DECIMAL(18,2) COMMENT 'The net impact on surplus from a parallel downward shift of 100 basis points across the entire yield curve.',
    `parallel_shift_up_100bp_impact` DECIMAL(18,2) COMMENT 'The net impact on surplus from a parallel upward shift of 100 basis points across the entire yield curve.',
    `rbc_c3_charge` DECIMAL(18,2) COMMENT 'The calculated RBC C-3 interest rate risk charge associated with this ALM gap measurement.',
    `reporting_period` STRING COMMENT 'The reporting period to which this ALM gap measurement applies (e.g., Q1 2024, FY 2024).',
    `surplus_at_risk` DECIMAL(18,2) COMMENT 'The estimated maximum loss to surplus under adverse interest rate scenarios, based on this ALM gap measurement.',
    `tolerance_threshold_dollar_duration` DECIMAL(18,2) COMMENT 'The maximum allowable dollar duration gap as defined by the companys ALM policy and risk appetite.',
    `tolerance_threshold_duration` DECIMAL(18,2) COMMENT 'The maximum allowable duration gap as defined by the companys ALM policy and risk appetite.',
    `twist_flattening_impact` DECIMAL(18,2) COMMENT 'The net impact on surplus from a yield curve flattening scenario (short rates up, long rates down).',
    `twist_steepening_impact` DECIMAL(18,2) COMMENT 'The net impact on surplus from a yield curve steepening scenario (short rates down, long rates up).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ALM gap measurement record was last updated in the system.',
    CONSTRAINT pk_alm_gap_measurement PRIMARY KEY(`alm_gap_measurement_id`)
) COMMENT 'Periodic measurement records of the ALM duration gap between asset and liability portfolios. Captures measurement date, asset duration, liability duration, duration gap, convexity gap, dollar duration, DV01 (dollar value of 1 basis point), interest rate sensitivity by scenario (parallel shift, twist, steepening), and gap status (within tolerance, breach). Supports ORSA interest rate risk reporting, RBC C-3 stress testing, and ALM committee governance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`compliance_rule` (
    `compliance_rule_id` BIGINT COMMENT 'Unique identifier for the investment compliance rule. Primary key for the compliance rule entity.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to investment.guideline. Business justification: compliance_rule is the operational enforcement layer (monitoring, breach detection); guideline is the policy/IPS layer (strategic limits, investment policy statement). A compliance rule IMPLEMENTS a g',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Investment compliance rules are often product-specific: separate account investment restrictions per prospectus, qualified plan asset requirements for annuities, and state-mandated investment limitati',
    `portfolio_id` BIGINT COMMENT 'Specific portfolio identifier when the rule applies to a single named portfolio. Null if the rule applies broadly across multiple portfolios.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance rules require designated business owners for maintenance, review cycles, and regulatory attestation in L&A operations. Investment committee governance and SOX controls mandate tracking rule',
    `approval_authority` STRING COMMENT 'The governing body or individual who approved this compliance rule (e.g., Board of Directors, Investment Committee, Chief Investment Officer, State Insurance Commissioner).',
    `approval_date` DATE COMMENT 'Date when this compliance rule was formally approved by the approval authority.',
    `asset_class` STRING COMMENT 'The investment asset class to which this compliance rule applies. [ENUM-REF-CANDIDATE: fixed_income|equity|real_estate|mortgage_loan|policy_loan|cash_equivalent|alternative_investment|derivative — 8 candidates stripped; promote to reference product]',
    `breach_action` STRING COMMENT 'Action to be taken when this compliance rule is breached: alert (notify compliance officer), block (prevent trade execution), escalate (require senior approval), report (include in compliance report), auto_rebalance (trigger automatic portfolio rebalancing).. Valid values are `alert|block|escalate|report|auto_rebalance`',
    `breach_tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable tolerance percentage before a breach action is triggered (e.g., 1% over limit triggers alert, 2% over limit triggers block). Null if zero tolerance.',
    `calculation_methodology` STRING COMMENT 'Detailed explanation of how compliance with this rule is calculated, including formulas, data sources, and aggregation methods.',
    `covariance_adjustment_factor` DECIMAL(18,2) COMMENT 'Covariance adjustment factor applied in RBC calculations to account for diversification benefits across risk categories. Null if not applicable to this rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance rule record was first created in the system.',
    `credit_quality_requirement` STRING COMMENT 'Minimum credit quality or rating requirement for fixed income securities (e.g., NAIC 1, NAIC 2, BBB- or higher, Investment Grade). Applicable to credit quality floor rules.',
    `duration_constraint_years` DECIMAL(18,2) COMMENT 'Duration constraint value in years for Asset Liability Management (ALM) duration matching rules (e.g., portfolio duration must be within +/- 2 years of liability duration).',
    `effective_date` DATE COMMENT 'Date when this compliance rule becomes effective and enforceable.',
    `exception_criteria` STRING COMMENT 'Conditions under which exceptions to this compliance rule may be granted, including approval requirements and documentation standards.',
    `expiration_date` DATE COMMENT 'Date when this compliance rule expires or is superseded. Null for rules with indefinite duration.',
    `last_review_date` DATE COMMENT 'Date when this compliance rule was last reviewed for continued relevance and accuracy.',
    `maximum_value` DECIMAL(18,2) COMMENT 'Maximum allowable value for allocation range rules (e.g., maximum 10% allocation to below investment grade bonds). Null for rules that only specify a minimum or single threshold.',
    `minimum_value` DECIMAL(18,2) COMMENT 'Minimum allowable value for allocation range rules (e.g., minimum 20% allocation to investment grade bonds). Null for rules that only specify a maximum or single threshold.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which compliance with this rule is monitored and evaluated. [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|annual|on_demand — 7 candidates stripped; promote to reference product]',
    `naic_designation_requirement` STRING COMMENT 'Required NAIC designation for securities subject to this rule. NAIC 1 and 2 are investment grade; NAIC 3-6 are below investment grade. [ENUM-REF-CANDIDATE: naic_1|naic_2|naic_3|naic_4|naic_5|naic_6|not_applicable — 7 candidates stripped; promote to reference product]',
    `naic_schedule_category` STRING COMMENT 'The NAIC Annual Statement schedule category to which this rule applies (Schedule A: Real Estate, Schedule B: Mortgage Loans, Schedule BA: Other Long-Term Invested Assets, Schedule D: Bonds and Stocks, Schedule DA: Short-Term Investments, Schedule DB: Derivative Instruments). [ENUM-REF-CANDIDATE: schedule_a|schedule_b|schedule_ba|schedule_d|schedule_da|schedule_db|not_applicable — 7 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this compliance rule.',
    `portfolio_scope` STRING COMMENT 'Indicates which investment portfolios this compliance rule applies to (general account supporting policy reserves, separate accounts for variable products, or specific named portfolios).. Valid values are `general_account|separate_account|all_portfolios|specific_portfolio`',
    `post_trade_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this rule is monitored after trade execution for ongoing portfolio compliance (true) or only at pre-trade (false).',
    `pre_trade_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this rule is enforced at pre-trade compliance check (true) or only monitored post-trade (false).',
    `rbc_component` STRING COMMENT 'The specific RBC component category this rule applies to: C-0 (affiliate risk), C-1 (asset risk), C-2 (insurance risk), C-3 (interest rate/market risk), C-4 (business risk).. Valid values are `c0|c1|c2|c3|c4|not_applicable`',
    `rbc_factor` DECIMAL(18,2) COMMENT 'The Risk-Based Capital factor applied to calculate the capital charge for this asset class or security type under NAIC RBC formula (C-1 for asset risk, C-3 for interest rate risk). Expressed as a decimal (e.g., 0.003 for 0.3% charge).',
    `regulatory_citation` STRING COMMENT 'Specific reference to the regulatory statute, code section, or policy document that mandates this rule (e.g., NAIC Model Law Section 5, State Code 38-2-1, IPS Section 4.2.1).',
    `rule_category` STRING COMMENT 'High-level category indicating the source and purpose of the compliance rule.. Valid values are `regulatory|ips_directive|internal_policy|rbc_calculation|strategic_allocation|risk_management`',
    `rule_code` STRING COMMENT 'Business identifier code for the compliance rule, used for external reference and reporting (e.g., IPS-CONC-001, NAIC-SCH-D-LMT, RBC-C1-BOND).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `rule_description` STRING COMMENT 'Detailed textual description of the compliance rule, including its purpose, scope, calculation methodology, and any special conditions or exceptions.',
    `rule_name` STRING COMMENT 'Descriptive name of the compliance rule (e.g., Corporate Bond Concentration Limit, Below Investment Grade Restriction, Real Estate Allocation Cap).',
    `rule_notes` STRING COMMENT 'Additional notes, clarifications, or historical context regarding this compliance rule, including rationale for parameter values or special handling instructions.',
    `rule_priority` STRING COMMENT 'Numeric priority ranking for this rule when multiple rules conflict or when determining order of compliance checks (lower number = higher priority).',
    `rule_source` STRING COMMENT 'Origin of the compliance rule indicating the governing authority or policy document (e.g., Investment Policy Statement, NAIC regulation, state insurance department directive, internal risk committee policy). [ENUM-REF-CANDIDATE: ips|naic_regulation|state_regulation|sec_regulation|internal_policy|rbc_formula|alm_policy — 7 candidates stripped; promote to reference product]',
    `rule_status` STRING COMMENT 'Current lifecycle status of the compliance rule indicating whether it is actively enforced.. Valid values are `active|inactive|pending_approval|superseded|suspended`',
    `rule_type` STRING COMMENT 'Classification of the compliance rule type governing portfolio construction and capital adequacy. [ENUM-REF-CANDIDATE: concentration_limit|credit_quality_floor|prohibited_security|naic_schedule_limit|diversification_requirement|duration_constraint|allocation_range|rbc_charge_calculation|liquidity_requirement|counterparty_limit — 10 candidates stripped; promote to reference product]',
    `target_allocation_percentage` DECIMAL(18,2) COMMENT 'Strategic target allocation percentage for asset class allocation rules, representing the optimal portfolio mix per the Investment Policy Statement.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value (e.g., percentage of total assets, basis points, years for duration, dollar amount, rating notches, count of securities).. Valid values are `percentage|basis_points|years|dollars|rating_notches|count`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold or limit value for the compliance rule (e.g., maximum concentration percentage, minimum credit rating score, duration limit in years).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance rule record was last modified.',
    CONSTRAINT pk_compliance_rule PRIMARY KEY(`compliance_rule_id`)
) COMMENT 'Unified SSOT for all investment compliance rules, investment policy statement (IPS) guidelines, regulatory constraints, and RBC risk charge calculations governing portfolio construction and capital adequacy. Covers NAIC investment guidelines, state insurance regulations, internal IPS directives, strategic asset allocation limits, credit quality requirements, duration constraints, prohibited investments, and NAIC RBC factor applications. Captures rule/guideline type (concentration limit, credit quality floor, prohibited security, NAIC Schedule limit, diversification requirement, duration constraint, allocation range, rbc_charge_calculation), rule parameter values, target allocation percentages, min/max ranges, applicable portfolio scope, regulatory citation, rule source (IPS, regulatory, internal policy, NAIC RBC formula), effective date, approval authority, breach action (alert, block, escalate), and for RBC calculations: asset class, NAIC Schedule category, applicable RBC factor (C-1, C-3), calculated charge, and covariance adjustment. SSOT for all investment constraints, governance frameworks, and regulatory capital calculations used by compliance monitoring modules.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`compliance_breach` (
    `compliance_breach_id` BIGINT COMMENT 'Unique identifier for the investment compliance breach record. Primary key for the compliance breach entity.',
    `compliance_rule_id` BIGINT COMMENT 'Foreign key linking to investment.compliance_rule. Business justification: Compliance breaches are violations of specific compliance rules. The existing compliance_rule_code and compliance_rule_name attributes identify the rule but lack FK to compliance_rule master. Adding c',
    `portfolio_id` BIGINT COMMENT 'Identifier of the investment portfolio in which the compliance breach occurred. Links to the portfolio master data.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that detected the compliance breach. For automated detections, this may be a system identifier. For manual detections, this is the user ID of the compliance analyst or portfolio manager.',
    `report_exception_id` BIGINT COMMENT 'Foreign key linking to reporting.report_exception. Business justification: Investment compliance breaches (guideline violations, concentration limits) become report exceptions requiring disclosure or remediation before filing. Real business need: escalation from investment b',
    `security_id` BIGINT COMMENT 'Identifier of the specific security involved in the compliance breach. Links to the security master data.',
    `trade_id` BIGINT COMMENT 'Identifier of the trade order that caused or would have caused the compliance breach. Populated for pre-trade breaches. Nullable for post-trade breaches detected during monitoring.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value or percentage of the exposure at the time of breach detection. Used in conjunction with limit_threshold to calculate the breach amount and percentage.',
    `alm_impact_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the compliance breach has implications for Asset Liability Management (ALM) duration matching or interest rate risk management. True if the breach affects ALM objectives; false otherwise.',
    `asset_class` STRING COMMENT 'High-level asset class of the security involved in the breach. Examples include fixed income, equity, real estate, alternative investments, derivatives. Supports breach trend analysis by asset class.',
    `breach_amount` DECIMAL(18,2) COMMENT 'Monetary amount by which the compliance limit was exceeded, expressed in the portfolio base currency. For concentration breaches, this is the excess market value. For other breach types, this may represent the notional exposure or Fair Market Value (FMV) of the non-compliant position.',
    `breach_date` DATE COMMENT 'The date on which the compliance breach was detected or occurred. For pre-trade breaches, this is the date the order was submitted. For post-trade breaches, this is the date the breach condition was identified during monitoring.',
    `breach_notes` STRING COMMENT 'Free-form notes providing additional context about the compliance breach. May include root cause analysis, mitigating factors, or special circumstances. Supports regulatory examination responses and internal governance documentation.',
    `breach_number` STRING COMMENT 'Business-facing unique reference number assigned to the compliance breach for tracking and reporting purposes. Used in regulatory correspondence and internal governance documentation.',
    `breach_percentage` DECIMAL(18,2) COMMENT 'Percentage by which the compliance limit was exceeded. For example, if a concentration limit is 10% and the actual exposure is 12%, the breach percentage is 2.00. Expressed as a percentage value (e.g., 2.00 for 2%).',
    `breach_severity` STRING COMMENT 'Severity classification of the compliance breach. Warning indicates a minor or threshold breach; violation indicates a material breach requiring remediation; critical indicates a severe breach requiring immediate escalation and regulatory notification.. Valid values are `warning|violation|critical`',
    `breach_status` STRING COMMENT 'Current status of the compliance breach in the remediation workflow. Tracks the lifecycle from detection through resolution or escalation.. Valid values are `open|under review|remediation in progress|resolved|escalated|waived`',
    `breach_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the compliance breach was detected by the investment compliance monitoring system. Supports audit trail and regulatory examination response.',
    `breach_type` STRING COMMENT 'Classification of the type of compliance breach. Categorizes the nature of the violation for reporting and trend analysis purposes.. Valid values are `concentration limit exceeded|prohibited security|credit rating violation|liquidity constraint|duration mismatch|sector limit exceeded`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance breach record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the breach amount and limit threshold. Typically the base currency of the portfolio or USD for consolidated reporting.. Valid values are `^[A-Z]{3}$`',
    `detection_method` STRING COMMENT 'The method by which the compliance breach was detected. Indicates whether the breach was caught by automated pre-trade controls, post-trade monitoring, manual review, periodic reconciliation, or during a regulatory examination.. Valid values are `pre-trade automated|post-trade automated|manual review|periodic reconciliation|regulatory examination`',
    `investment_committee_decision` STRING COMMENT 'Decision or recommendation made by the investment committee or ALM committee regarding the compliance breach. Examples include approve remediation plan, request waiver, escalate to board, or accept residual risk.',
    `investment_committee_review_date` DATE COMMENT 'Date on which the compliance breach was reviewed by the investment committee or Asset Liability Management (ALM) committee. Nullable if the breach did not require committee review.',
    `limit_threshold` DECIMAL(18,2) COMMENT 'The maximum allowable value or percentage defined by the compliance rule that was breached. Provides context for the magnitude of the breach.',
    `naic_designation` STRING COMMENT 'NAIC designation of the security involved in the breach. Used to assess Risk-Based Capital (RBC) implications and regulatory reporting requirements. Examples include NAIC 1 through NAIC 6 for bonds.',
    `rbc_category` STRING COMMENT 'Risk-Based Capital category of the security involved in the breach. Used to assess the capital charge implications of the non-compliant position. Examples include C1 (asset risk), C3 (interest rate risk).',
    `rbc_charge_impact` DECIMAL(18,2) COMMENT 'Estimated incremental Risk-Based Capital charge resulting from the compliance breach. Quantifies the regulatory capital impact of the non-compliant position.',
    `regulatory_escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the compliance breach was escalated to regulatory authorities. True if the breach was reported to NAIC, state Department of Insurance (DOI), or other governing bodies; false otherwise.',
    `regulatory_reference_number` STRING COMMENT 'Reference number assigned by the regulatory authority for the reported compliance breach. Used to track correspondence and follow-up with NAIC or state DOI. Nullable if not escalated.',
    `regulatory_report_date` DATE COMMENT 'Date on which the compliance breach was reported to regulatory authorities. Nullable if the breach did not require regulatory escalation.',
    `remediation_action` STRING COMMENT 'Description of the remediation action taken or planned to resolve the compliance breach. Examples include trade cancellation, position reduction, rebalancing, waiver request, or policy exception approval.',
    `remediation_deadline` DATE COMMENT 'Target date by which the compliance breach must be remediated. Set based on breach severity and regulatory requirements. Nullable for breaches that are waived or do not require remediation.',
    `resolution_date` DATE COMMENT 'Date on which the compliance breach was fully resolved or closed. Nullable for breaches that remain open or under review.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution of the compliance breach. Includes actions taken, approvals obtained, and any residual risk or follow-up items. Supports regulatory examination responses.',
    `separate_account_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the compliance breach occurred in a separate account portfolio supporting variable products. True if the breach is in a separate account; false if in the general account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance breach record was last modified. Supports audit trail and change tracking for regulatory examination purposes.',
    `waiver_approved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a waiver or exception was approved for the compliance breach. True if the breach was granted a policy exception; false otherwise.',
    `waiver_expiration_date` DATE COMMENT 'Expiration date of the approved waiver or exception. After this date, the position must be brought into compliance or a new waiver must be requested. Nullable if no waiver was granted.',
    CONSTRAINT pk_compliance_breach PRIMARY KEY(`compliance_breach_id`)
) COMMENT 'Operational records of investment compliance rule breaches detected during pre-trade or post-trade monitoring. Captures breach date, rule violated, portfolio and security involved, breach type (limit exceeded, prohibited security, concentration breach), breach severity (warning, violation, critical), breach amount/percentage, remediation action taken, resolution date, and regulatory escalation flag. Supports NAIC examination responses, state DOI reporting, and internal investment governance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`performance_attribution` (
    `performance_attribution_id` BIGINT COMMENT 'Unique identifier for the performance attribution record.',
    `run_id` BIGINT COMMENT 'The identifier of the batch run or calculation process that generated this attribution record.',
    `benchmark_id` BIGINT COMMENT 'The identifier of the benchmark index used for performance comparison (e.g., Bloomberg Barclays Aggregate Bond Index, S&P 500).',
    `management_report_config_id` BIGINT COMMENT 'Foreign key linking to reporting.management_report_config. Business justification: Performance attribution analysis feeds management reports on portfolio performance for investment committee and executive dashboards. Real business need: attribution analysis configuration for managem',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio being analyzed for performance attribution.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Separate account performance must be disclosed in regulatory filings (SEC Form N-4, state insurance department reports). Real business process: variable product performance reporting, regulatory discl',
    `active_return` DECIMAL(18,2) COMMENT 'The active return (alpha) representing the portfolio return minus the benchmark return, expressed as a decimal.',
    `allocation_effect` DECIMAL(18,2) COMMENT 'The contribution to active return from asset allocation decisions (overweight/underweight positions relative to benchmark), expressed as a decimal.',
    `alm_segment` STRING COMMENT 'The ALM segment or duration bucket to which this portfolio belongs for asset-liability matching purposes.',
    `asset_class_contribution` DECIMAL(18,2) COMMENT 'The contribution to total return from asset class positioning and performance, expressed as a decimal.',
    `attribution_calculation_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance attribution calculation was executed.',
    `attribution_frequency` STRING COMMENT 'The frequency at which performance attribution is calculated (daily, monthly, quarterly, annual).. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `attribution_methodology` STRING COMMENT 'The methodology used for performance attribution calculation (e.g., Brinson-Hood-Beebower, Brinson-Fachler, Carino, geometric linking).. Valid values are `brinson_hood_beebower|brinson_fachler|attribution_smoothing|carino|geometric`',
    `attribution_notes` STRING COMMENT 'Free-text notes providing additional context, explanations, or commentary on the performance attribution results.',
    `attribution_period_end_date` DATE COMMENT 'The end date of the performance attribution measurement period.',
    `attribution_period_start_date` DATE COMMENT 'The start date of the performance attribution measurement period.',
    `attribution_status` STRING COMMENT 'The current status of the performance attribution record in its lifecycle (draft, preliminary, final, approved, archived).. Valid values are `draft|preliminary|final|approved|archived`',
    `base_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the attribution returns are expressed (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `benchmark_return` DECIMAL(18,2) COMMENT 'The benchmark return for the attribution period, expressed as a decimal.',
    `capital_gain_contribution` DECIMAL(18,2) COMMENT 'The contribution to total return from realized and unrealized capital gains, expressed as a decimal.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance attribution record was first created in the system.',
    `currency_effect` DECIMAL(18,2) COMMENT 'The contribution to active return from currency exposure and hedging decisions, expressed as a decimal.',
    `income_contribution` DECIMAL(18,2) COMMENT 'The contribution to total return from investment income (dividends, interest, coupons), expressed as a decimal.',
    `interaction_effect` DECIMAL(18,2) COMMENT 'The interaction effect between allocation and selection decisions, expressed as a decimal.',
    `investment_committee_decision` STRING COMMENT 'The decision or action taken by the investment committee based on this performance attribution analysis.',
    `investment_committee_review_date` DATE COMMENT 'The date when the investment committee reviewed this performance attribution analysis.',
    `net_cash_flow` DECIMAL(18,2) COMMENT 'The net cash flow (contributions minus withdrawals) during the attribution period.',
    `portfolio_beginning_market_value` DECIMAL(18,2) COMMENT 'The market value of the portfolio at the beginning of the attribution period.',
    `portfolio_ending_market_value` DECIMAL(18,2) COMMENT 'The market value of the portfolio at the end of the attribution period.',
    `rbc_category` STRING COMMENT 'The RBC investment risk category applicable to this portfolio for regulatory capital calculation purposes.',
    `reporting_period` STRING COMMENT 'The reporting period label for this attribution record (e.g., Q1 2024, FY 2023, January 2024).',
    `sector_contribution` DECIMAL(18,2) COMMENT 'The contribution to total return from sector-level positioning and performance, expressed as a decimal.',
    `selection_effect` DECIMAL(18,2) COMMENT 'The contribution to active return from security selection decisions within asset classes, expressed as a decimal.',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this attribution is for a separate account (variable product) portfolio (True) or general account portfolio (False).',
    `total_return` DECIMAL(18,2) COMMENT 'The total portfolio return for the attribution period, expressed as a decimal (e.g., 0.0523 for 5.23%).',
    `transaction_cost_impact` DECIMAL(18,2) COMMENT 'The negative impact on return from transaction costs (commissions, fees, bid-ask spreads), expressed as a decimal.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance attribution record was last modified.',
    CONSTRAINT pk_performance_attribution PRIMARY KEY(`performance_attribution_id`)
) COMMENT 'Periodic investment performance attribution records decomposing portfolio returns into contributing factors. Captures attribution period (daily, monthly, quarterly), total return, benchmark return, active return (alpha), allocation effect, selection effect, interaction effect, sector/asset class contribution, currency effect, and attribution methodology (Brinson-Hood-Beebower). Sourced from Charles River IMS or SimCorp performance attribution module. Supports investment committee reporting and portfolio manager evaluation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` (
    `credit_default_rate_id` BIGINT COMMENT 'Unique identifier for the credit default rate measurement record.',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: CDR tracking and credit loss assessments are performed on specific asset holdings. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing posit',
    `employee_id` BIGINT COMMENT 'The identifier of the individual or team who validated the CDR measurement, supporting accountability and audit trail.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio (general account or separate account) containing the asset subject to CDR measurement.',
    `stochastic_scenario_id` BIGINT COMMENT 'Reference to the economic or stress scenario under which this CDR measurement was calculated, supporting ORSA and stress testing requirements.',
    `security_id` BIGINT COMMENT 'Reference to the underlying security or structured product for which credit default rate is being tracked.',
    `actual_default_event_flag` BOOLEAN COMMENT 'Indicates whether an actual default event occurred for this security during the reporting period.',
    `actual_loss_amount` DECIMAL(18,2) COMMENT 'The actual realized credit loss amount in base currency if a default event occurred and was settled during the reporting period.',
    `alm_segment` STRING COMMENT 'The ALM segment or liability cohort to which this asset is matched, supporting duration matching and surplus-at-risk analysis.',
    `asset_class` STRING COMMENT 'The broad investment asset class category of the security subject to credit default rate measurement. [ENUM-REF-CANDIDATE: corporate_bond|municipal_bond|government_bond|mortgage_backed_security|asset_backed_security|collateralized_loan_obligation|structured_product|private_placement|other_fixed_income — 9 candidates stripped; promote to reference product]',
    `asset_subclass` STRING COMMENT 'The detailed sub-classification within the asset class, providing granular segmentation for credit risk analysis (e.g., investment grade corporate, high yield, CMBS, RMBS).',
    `calculation_methodology` STRING COMMENT 'The methodology used to calculate or derive the conditional default rate, supporting transparency and auditability of credit risk measurements.. Valid values are `historical_default_rate|market_implied|credit_model|rating_transition_matrix|expert_judgment|vendor_model`',
    `cdr_basis_points` STRING COMMENT 'The conditional default rate expressed in basis points (1 basis point = 0.01%), providing an alternative representation for fixed income professionals.',
    `cdr_value` DECIMAL(18,2) COMMENT 'The calculated conditional default rate expressed as a decimal percentage, representing the probability of default over a specified time horizon given the security has not yet defaulted.',
    `cecl_provision_amount` DECIMAL(18,2) COMMENT 'The credit loss provision amount recorded under GAAP CECL accounting standard (ASC 326) for this security or position.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit default rate record was first created in the system.',
    `credit_migration_direction` STRING COMMENT 'Indicates whether the security experienced a credit rating upgrade, downgrade, or no change during the reporting period.. Valid values are `upgrade|downgrade|no_change`',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the exposure and credit loss amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The source system or vendor from which the CDR data was obtained (e.g., internal actuarial model, Bloomberg, Moodys Analytics, vendor credit model).',
    `default_event_date` DATE COMMENT 'The date on which the actual default event occurred, if applicable.',
    `default_type` STRING COMMENT 'The classification of the default event, indicating the nature of the credit event that triggered default status.. Valid values are `payment_default|bankruptcy|restructuring|covenant_breach|other`',
    `expected_credit_loss_amount` DECIMAL(18,2) COMMENT 'The calculated expected credit loss amount in base currency, computed as exposure at default multiplied by probability of default multiplied by loss given default, supporting CECL and IFRS 9 compliance.',
    `exposure_at_default` DECIMAL(18,2) COMMENT 'The total exposure amount at risk of default, typically the amortized cost or carrying value of the security at the measurement date.',
    `external_credit_rating` STRING COMMENT 'The credit rating assigned by an external rating agency (e.g., Moodys, S&P, Fitch) at the measurement date.',
    `ldti_credit_loss_assumption` DECIMAL(18,2) COMMENT 'The credit loss assumption amount used in actuarial cash flow projections under GAAP LDTI standard (ASC 944) for long-duration insurance contracts.',
    `measurement_date` DATE COMMENT 'The specific date on which the credit default rate was measured or calculated.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the CDR calculation was performed, supporting audit trail and version control.',
    `model_name` STRING COMMENT 'The name or identifier of the credit risk model or vendor model used to calculate the CDR, if applicable.',
    `model_version` STRING COMMENT 'The version number of the credit risk model used, supporting model governance and change tracking.',
    `naic_designation` STRING COMMENT 'The NAIC credit quality designation assigned to the security, ranging from 1 (highest quality) to 6 (in or near default), used for statutory reporting and RBC calculations.. Valid values are `1|2|3|4|5|6`',
    `naic_designation_change_flag` BOOLEAN COMMENT 'Indicates whether the NAIC designation changed during the reporting period, signaling credit migration.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, assumptions, or qualitative information related to the CDR measurement.',
    `previous_naic_designation` STRING COMMENT 'The NAIC designation held prior to any change during the reporting period, supporting credit migration tracking.. Valid values are `1|2|3|4|5|6`',
    `rating_agency` STRING COMMENT 'The credit rating agency that provided the external credit rating.. Valid values are `moodys|sp|fitch|am_best|dbrs|other`',
    `rbc_c1_asset_risk_charge` DECIMAL(18,2) COMMENT 'The statutory RBC C-1 asset default risk charge amount calculated for this security based on its NAIC designation and asset class, supporting regulatory capital adequacy requirements.',
    `rbc_factor` DECIMAL(18,2) COMMENT 'The risk-based capital factor applied to the carrying value to calculate the C-1 asset risk charge, expressed as a decimal percentage.',
    `recovery_rate` DECIMAL(18,2) COMMENT 'The expected recovery rate expressed as a decimal percentage, representing the proportion of exposure expected to be recovered in the event of default (complement of severity rate).',
    `reporting_period` STRING COMMENT 'The financial reporting period for which this CDR measurement applies, expressed as YYYY-QN for quarterly, YYYY-MM for monthly, or YYYY for annual.. Valid values are `^d{4}-Q[1-4]$|^d{4}-d{2}$|^d{4}$`',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this security is held in a separate account (variable product) versus the general account, affecting credit risk allocation and unit value calculations.',
    `severity_rate` DECIMAL(18,2) COMMENT 'The expected loss severity rate (loss given default) expressed as a decimal percentage, representing the proportion of exposure expected to be lost if default occurs.',
    `time_horizon_months` STRING COMMENT 'The forward-looking time horizon in months over which the conditional default rate is projected, typically 12 months for CECL lifetime loss calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit default rate record was last modified, supporting audit trail and data lineage.',
    `validation_date` DATE COMMENT 'The date on which the CDR measurement was validated and approved.',
    `validation_status` STRING COMMENT 'The validation status of the CDR measurement, indicating whether it has been reviewed and approved by risk management or actuarial teams.. Valid values are `pending|validated|rejected|under_review`',
    CONSTRAINT pk_credit_default_rate PRIMARY KEY(`credit_default_rate_id`)
) COMMENT 'Tracks CDR (Conditional Default Rate) and credit loss experience for fixed income and structured product holdings. Captures reporting period, security/asset class, CDR value, severity rate, expected credit loss (ECL), actual default events, credit migration (rating upgrade/downgrade), NAIC designation change, and CECL/LDTI credit loss provision. Supports actuarial cash flow projections, GAAP LDTI credit loss assumptions, and RBC C-1 asset default risk charge calculations.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`risk_charge` (
    `risk_charge_id` BIGINT COMMENT 'Primary key for risk_charge',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: RBC investment risk charges are calculated per asset holding. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing position_id. This links RB',
    `orsa_report_id` BIGINT COMMENT 'Foreign key linking to compliance.orsa_report. Business justification: RBC investment risk charges (C1, C3) are disclosed in ORSA reports as part of capital adequacy assessment and stress testing. Real business process: ORSA capital projection, risk charge aggregation, r',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: RBC C-1 and C-3 charges are calculated and reported at product line level for statutory annual statements. Asset risk charges must be allocated to products for profitability analysis, pricing validati',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio for which this RBC charge is calculated. Links to the portfolio master data.',
    `rbc_calculation_id` BIGINT COMMENT 'Foreign key linking to finance.rbc_calculation. Business justification: RBC investment charges (C1/C3 components) roll up to entity-level RBC calculations for regulatory capital adequacy reporting and NAIC Annual Statement preparation.',
    `rbc_filing_id` BIGINT COMMENT 'Foreign key linking to reporting.rbc_filing. Business justification: RBC investment charges (C-1 asset default, C-3 interest rate) roll up to RBC filings by component. Real business need: detailed support for filed RBC amounts, enabling drill-down from filing to indivi',
    `stochastic_scenario_id` BIGINT COMMENT 'Reference to the specific economic or stress scenario used for scenario-based or stochastic RBC calculations, supporting ORSA and stress testing.',
    `adjusted_rbc_charge` DECIMAL(18,2) COMMENT 'The final RBC charge after applying covariance adjustments and any other regulatory modifications, representing the capital requirement for this position.',
    `alm_segment` STRING COMMENT 'The ALM segment or liability cohort this asset is matched against for duration management and C-3 risk calculation purposes.',
    `approval_date` DATE COMMENT 'The date the RBC calculation was approved by the state Department of Insurance or internal compliance review, confirming regulatory acceptance.',
    `asset_class` STRING COMMENT 'High-level classification of the investment asset type for RBC calculation purposes, aligning with NAIC Schedule categories. [ENUM-REF-CANDIDATE: bonds|preferred_stock|common_stock|mortgage_loans|real_estate|cash_equivalents|derivatives|other_invested_assets|short_term_investments|policy_loans — 10 candidates stripped; promote to reference product]',
    `base_rbc_charge` DECIMAL(18,2) COMMENT 'The calculated RBC charge before any covariance adjustments, computed as BACV multiplied by the applicable RBC factor.',
    `book_adjusted_carrying_value` DECIMAL(18,2) COMMENT 'The statutory accounting book value of the asset adjusted for any required valuation reserves or impairments, serving as the base for RBC charge calculation.',
    `c1_asset_default_charge` DECIMAL(18,2) COMMENT 'The portion of the RBC charge attributable to asset default risk (C-1 component), covering credit risk and issuer default probability.',
    `c3_interest_rate_charge` DECIMAL(18,2) COMMENT 'The portion of the RBC charge attributable to interest rate risk (C-3 component), covering asset-liability mismatch and duration gap risk.',
    `calculation_date` DATE COMMENT 'The specific date on which the RBC charge calculation was performed, may differ from reporting period for interim calculations.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the RBC charge: standard NAIC formula, scenario-based testing, stochastic modeling, or principle-based approach (PBR).. Valid values are `standard_formula|scenario_based|stochastic_modeling|principle_based`',
    `calculation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the RBC charge calculation was executed, supporting audit trail and version control.',
    `calculation_version` STRING COMMENT 'Version number of the RBC calculation for this position and reporting period, incremented when recalculations or corrections are performed.',
    `concentration_factor` DECIMAL(18,2) COMMENT 'Additional risk factor applied when a single issuer or asset concentration exceeds regulatory thresholds, increasing the RBC charge for concentration risk.',
    `covariance_adjustment_factor` DECIMAL(18,2) COMMENT 'The factor applied to recognize diversification benefits across different risk categories in the total RBC calculation, typically applied at portfolio level.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RBC charge record was first created in the system, supporting audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the asset and RBC charge amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fair_market_value` DECIMAL(18,2) COMMENT 'The current fair market value of the asset as of the reporting period, used for certain RBC calculations and disclosure purposes.',
    `filing_date` DATE COMMENT 'The date this RBC charge data was submitted to the state Department of Insurance as part of the annual or quarterly RBC filing.',
    `filing_status` STRING COMMENT 'Current status of the RBC charge in the regulatory filing workflow, tracking progression from draft calculation through final submission to state DOI.. Valid values are `draft|preliminary|final|filed|amended|approved`',
    `hedge_adjustment` DECIMAL(18,2) COMMENT 'Reduction in RBC charge due to qualifying hedging instruments that offset the risk of the underlying asset, subject to NAIC hedge effectiveness criteria.',
    `hedge_effectiveness_percentage` DECIMAL(18,2) COMMENT 'The percentage of risk offset by hedging instruments, used to calculate the hedge adjustment to the RBC charge (0-100%).',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation for bonds and preferred stock (1=highest quality, 6=in or near default), used to determine applicable RBC factors. [ENUM-REF-CANDIDATE: 1|2|3|4|5|6|exempt|not_rated — 8 candidates stripped; promote to reference product]',
    `naic_schedule_category` STRING COMMENT 'The specific NAIC Annual Statement schedule category where this asset is reported (e.g., Schedule D for bonds, Schedule BA for other long-term invested assets). [ENUM-REF-CANDIDATE: schedule_a|schedule_b|schedule_ba|schedule_d_part_1|schedule_d_part_2|schedule_d_part_3|schedule_d_part_4|schedule_d_part_5|schedule_d_part_6 — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional comments, assumptions, or explanations related to the RBC charge calculation, supporting documentation and audit trail.',
    `orsa_stress_scenario` STRING COMMENT 'The ORSA stress scenario name or identifier if this RBC charge is calculated under a specific stress condition for enterprise risk management purposes.',
    `override_approved_by` STRING COMMENT 'Name or identifier of the authorized individual who approved the RBC charge override, supporting segregation of duties and audit requirements.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether the RBC charge was manually overridden from the system-calculated value, requiring additional documentation and approval.',
    `override_reason` STRING COMMENT 'Business justification for any manual override of the calculated RBC charge, required for audit trail and regulatory examination purposes.',
    `product_line` STRING COMMENT 'The insurance product line or business segment this investment supports (e.g., term life, whole life, fixed annuity, variable annuity), used for product-level RBC allocation.',
    `rbc_component` STRING COMMENT 'The specific RBC risk component category this charge contributes to: C-1 (asset default risk), C-3 (interest rate risk), C-1cs (common stock risk), or C-1o (other asset risk).. Valid values are `c1_asset_risk|c3_interest_rate_risk|c1cs_common_stock_risk|c1o_other_asset_risk`',
    `rbc_factor` DECIMAL(18,2) COMMENT 'The applicable RBC risk factor percentage applied to the asset value based on asset class, NAIC designation, and risk component (e.g., 0.003 for NAIC 1 bonds, 0.30 for common stock).',
    `reporting_period` DATE COMMENT 'The reporting period end date for which this RBC charge is calculated, typically quarterly or annual for regulatory filing purposes.',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this asset is held in a separate account (variable product) versus general account, affecting RBC treatment and capital requirements.',
    `statement_value` DECIMAL(18,2) COMMENT 'The value of the asset as reported on the statutory financial statement, may differ from BACV due to admitted asset rules.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RBC charge record was last modified, supporting change tracking and audit trail requirements.',
    CONSTRAINT pk_risk_charge PRIMARY KEY(`risk_charge_id`)
) COMMENT 'Calculates and stores RBC (Risk-Based Capital) investment risk charges for each asset class per NAIC RBC formula. Captures reporting period, asset class, NAIC Schedule category, book/adjusted carrying value (BACV), applicable RBC factor (C-1 asset default, C-3 interest rate), calculated RBC charge, covariance adjustment, and total C-1/C-3 contribution. Supports NAIC RBC filing, state DOI capital adequacy review, and ORSA capital modeling.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` (
    `mortgage_loan_id` BIGINT COMMENT 'Unique identifier for the mortgage loan investment asset record. Primary key for the mortgage loan product.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Mortgage loans are Schedule B assets owned by specific legal entities, required for NAIC Annual Statement reporting and RBC C1 asset risk calculations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Commercial mortgage loans in L&A portfolios require assigned loan officers for ongoing servicing, covenant monitoring, property inspections, and workout management. Critical for Schedule B reporting a',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio that holds this mortgage loan asset. Links to the general account portfolio structure.',
    `statutory_exhibit_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_exhibit. Business justification: Mortgage loans populate Schedule B of statutory filings. Real business need: loan-level detail for statutory exhibit, supporting regulatory disclosure of mortgage portfolio composition and credit qual',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the loan servicer. Links to servicer master data for contact and performance tracking.',
    `acquisition_date` DATE COMMENT 'Date when the insurer acquired the mortgage loan investment. May differ from origination date if purchased on secondary market.',
    `acquisition_price` DECIMAL(18,2) COMMENT 'Purchase price paid by the insurer to acquire the mortgage loan. Used for premium/discount amortization and return calculations.',
    `allowance_for_credit_losses` DECIMAL(18,2) COMMENT 'GAAP allowance for expected credit losses under ASC 326 CECL. Reduces the carrying value of the mortgage loan on the balance sheet.',
    `amortization_type` STRING COMMENT 'Structure of principal repayment over the loan term. Fully amortizing loans pay down to zero; balloon loans require lump sum at maturity; interest-only defer principal.. Valid values are `fully_amortizing|partially_amortizing|interest_only|balloon|negative_amortization`',
    `amortized_cost` DECIMAL(18,2) COMMENT 'Amortized cost basis of the mortgage loan under Generally Accepted Accounting Principles (GAAP). Reflects purchase price adjusted for premium/discount amortization and credit losses.',
    `appraisal_date` DATE COMMENT 'Date of the most recent property appraisal. Regulatory guidelines require periodic reappraisals for commercial mortgages.',
    `appraisal_value` DECIMAL(18,2) COMMENT 'Most recent appraised Fair Market Value (FMV) of the property securing the mortgage loan. Used for LTV ratio calculations and impairment testing.',
    `book_value` DECIMAL(18,2) COMMENT 'Carrying value of the mortgage loan on the general account balance sheet under Statutory Accounting Principles (SAP). May differ from outstanding principal due to premium/discount amortization.',
    `borrower_name` STRING COMMENT 'Legal name of the borrower or mortgagor. For commercial loans may be an entity name; for residential loans is an individual name.',
    `borrower_tin` STRING COMMENT 'Taxpayer Identification Number (TIN) or Employer Identification Number (EIN) for the borrower. Used for tax reporting and Know Your Customer (KYC) compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this mortgage loan record was first created in the investment management system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts. Supports international mortgage investments and foreign exchange risk management.. Valid values are `^[A-Z]{3}$`',
    `dscr` DECIMAL(18,2) COMMENT 'Debt Service Coverage Ratio for commercial mortgage loans. Measures the propertys net operating income relative to debt service obligations. Key underwriting and risk metric.',
    `impairment_status` STRING COMMENT 'Current impairment classification under GAAP ASC 326 Current Expected Credit Loss (CECL) or SAP guidance. Drives allowance for credit losses and income recognition.. Valid values are `not_impaired|impaired|credit_loss_recognized`',
    `interest_rate` DECIMAL(18,2) COMMENT 'Current annual interest rate on the mortgage loan expressed as a decimal percentage. Used for income accrual and Asset Liability Management (ALM) duration calculations.',
    `interest_rate_type` STRING COMMENT 'Classification of the interest rate structure. Fixed rates remain constant; variable/adjustable rates change based on index; hybrid combines both.. Valid values are `fixed|variable|adjustable|hybrid`',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the borrower. Used to calculate delinquency status and days past due.',
    `loan_number` STRING COMMENT 'External loan number or identifier assigned by the originator or servicer. Business identifier for the mortgage loan.',
    `loan_status` STRING COMMENT 'Current payment and performance status of the mortgage loan. Delinquency stages track days past due. Real Estate Owned (REO) indicates foreclosed property. Drives reserve requirements and RBC charges. [ENUM-REF-CANDIDATE: current|delinquent_30|delinquent_60|delinquent_90|in_foreclosure|reo|paid_off — 7 candidates stripped; promote to reference product]',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-Value ratio expressed as a percentage. Calculated as outstanding principal balance divided by current appraised property value. Critical risk metric for NAIC Schedule B classification and RBC charges.',
    `maturity_date` DATE COMMENT 'Scheduled date when the mortgage loan principal is due in full. Critical for Asset Liability Management (ALM) duration matching and cash flow projections.',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation for the mortgage loan ranging from 1 (highest quality) to 6 (in or near default). Determines RBC C-1 risk charge factors.. Valid values are `1|2|3|4|5|6`',
    `naic_schedule_b_line` STRING COMMENT 'Specific line item classification on NAIC Schedule B annual statement where this mortgage loan is reported. Supports regulatory financial reporting.',
    `next_payment_due_date` DATE COMMENT 'Scheduled date for the next principal and interest payment. Used for cash flow forecasting and delinquency monitoring.',
    `original_loan_amount` DECIMAL(18,2) COMMENT 'Principal amount of the mortgage loan at origination. Used for Loan-to-Value (LTV) ratio calculations and historical tracking.',
    `origination_date` DATE COMMENT 'Date when the mortgage loan was originally funded and the note was executed. Used for age-based risk analysis and amortization calculations.',
    `outstanding_principal_balance` DECIMAL(18,2) COMMENT 'Current unpaid principal balance of the mortgage loan. Key metric for Risk-Based Capital (RBC) C-1 mortgage risk charge calculations.',
    `prepayment_penalty_flag` BOOLEAN COMMENT 'Indicates whether the mortgage loan includes prepayment penalties. True if penalties apply; False if borrower can prepay without penalty. Impacts ALM prepayment risk modeling.',
    `property_address_line1` STRING COMMENT 'First line of the street address for the property securing the mortgage loan.',
    `property_address_line2` STRING COMMENT 'Second line of the street address for the property securing the mortgage loan (suite, unit, building).',
    `property_city` STRING COMMENT 'City where the property securing the mortgage loan is located.',
    `property_country_code` STRING COMMENT 'Three-letter ISO country code for the property location. Supports international mortgage investments.. Valid values are `^[A-Z]{3}$`',
    `property_postal_code` STRING COMMENT 'Postal code or ZIP code for the property securing the mortgage loan.',
    `property_state` STRING COMMENT 'State or province where the property securing the mortgage loan is located. Two-letter state code.',
    `property_type` STRING COMMENT 'Classification of the property securing the mortgage loan. Determines risk assessment and regulatory capital treatment.. Valid values are `commercial|residential|agricultural|mixed_use|industrial|multifamily`',
    `rbc_c1_charge` DECIMAL(18,2) COMMENT 'Risk-Based Capital charge for asset default risk (C-1 component) calculated for this mortgage loan. Based on NAIC designation and property type. Critical for solvency monitoring.',
    `rbc_factor` DECIMAL(18,2) COMMENT 'RBC factor percentage applied to the outstanding balance to calculate the C-1 risk charge. Varies by NAIC designation and property type.',
    `recourse_flag` BOOLEAN COMMENT 'Indicates whether the loan is recourse or non-recourse. True if lender has recourse to borrower assets beyond collateral; False if limited to property collateral only. Affects credit risk assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this mortgage loan record. Supports change tracking and audit compliance.',
    CONSTRAINT pk_mortgage_loan PRIMARY KEY(`mortgage_loan_id`)
) COMMENT 'Master record for commercial and residential mortgage loans held as invested assets in the general account. Captures loan number, property type (commercial, residential, agricultural), property address, original loan amount, outstanding balance, interest rate, loan-to-value (LTV) ratio, debt service coverage ratio (DSCR), origination date, maturity date, amortization type, loan status (current, delinquent, in foreclosure, REO), NAIC Schedule B classification, and appraisal value. Supports NAIC Schedule B reporting and RBC C-1 mortgage risk charges.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`alternative_asset` (
    `alternative_asset_id` BIGINT COMMENT 'Unique identifier for the alternative asset investment record. Primary key for the alternative asset master table.',
    `counterparty_id` BIGINT COMMENT 'Reference to the fund manager or general partner entity record. Links to counterparty master data for due diligence, performance tracking, and relationship management.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Alternative investments (Schedule BA) must be attributed to legal entities for statutory reporting, RBC C1 calculations, and regulatory capital adequacy monitoring.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio that holds this alternative asset. Links to the portfolio master record for general account or separate account classification.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Alternative investments (private equity, hedge funds) require dedicated relationship managers for capital calls, distribution processing, quarterly valuations, and manager due diligence. Essential for',
    `statutory_exhibit_id` BIGINT COMMENT 'Foreign key linking to reporting.statutory_exhibit. Business justification: Alternative assets (private equity, hedge funds, real estate) populate Schedule BA of statutory filings. Real business need: asset-level detail for statutory exhibit, supporting regulatory disclosure ',
    `acquisition_date` DATE COMMENT 'Date on which the initial capital commitment was made or the first capital call was funded for this alternative investment.',
    `alternative_asset_status` STRING COMMENT 'Current lifecycle status of the alternative investment. Indicates whether the fund is actively investing, harvesting returns, or winding down operations.. Valid values are `active|commitment_period|harvesting|liquidating|closed|defaulted`',
    `alternative_asset_type` STRING COMMENT 'Primary classification of the alternative investment type. Determines regulatory treatment, valuation methodology, and Risk-Based Capital (RBC) C-1 charge calculation.. Valid values are `private_equity|hedge_fund|real_estate_equity|infrastructure|commodities|venture_capital`',
    `asset_identifier` STRING COMMENT 'External unique identifier for the alternative asset such as fund code, partnership registration number, or internal asset tracking code used for reconciliation and reporting.',
    `asset_name` STRING COMMENT 'Full legal name or title of the alternative investment asset, fund, or partnership as registered with the fund manager or general partner.',
    `auditor_name` STRING COMMENT 'Name of the independent accounting firm that audits the alternative investment funds financial statements.',
    `capital_call_amount_ytd` DECIMAL(18,2) COMMENT 'Cumulative capital calls funded during the current calendar year. Represents cash outflows for new investments and fund expenses.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Total capital commitment amount pledged by the insurance company to the alternative investment fund or partnership. Represents the maximum capital that may be called over the investment period.',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original cost basis of the alternative investment for statutory accounting purposes. Used to calculate unrealized gains and losses for Schedule D reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this alternative asset record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the alternative investment denomination. Used for foreign exchange risk assessment and reporting.. Valid values are `^[A-Z]{3}$`',
    `custodian_name` STRING COMMENT 'Name of the financial institution serving as custodian for the alternative investment assets and cash flows.',
    `distribution_amount_ytd` DECIMAL(18,2) COMMENT 'Cumulative cash distributions received from the alternative investment during the current calendar year. Includes return of capital, realized gains, and income distributions.',
    `expected_return_rate` DECIMAL(18,2) COMMENT 'Expected annualized internal rate of return (IRR) or target return percentage for the alternative investment as stated in the fund offering documents or investment policy statement.',
    `fund_manager_name` STRING COMMENT 'Name of the investment management firm, general partner, or fund manager responsible for managing the alternative asset investment.',
    `funded_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of capital that has been called and funded to date by the fund manager. Represents actual cash deployed into the alternative investment.',
    `gate_provision_flag` BOOLEAN COMMENT 'Indicates whether the fund has gate provisions that allow the fund manager to limit or suspend redemptions during periods of market stress or high redemption volume.',
    `geographic_focus` STRING COMMENT 'Primary geographic region or market focus of the alternative investment strategy such as North America, Europe, Asia-Pacific, or Global. Used for geographic diversification analysis.',
    `investment_strategy` STRING COMMENT 'Detailed description of the investment strategy, approach, and objectives employed by the fund manager for this alternative asset, including sector focus, geographic concentration, and return targets.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audited financial statements for the alternative investment fund. Used for due diligence and compliance monitoring.',
    `last_valuation_date` DATE COMMENT 'Most recent date on which the alternative investment was formally valued by the fund manager or independent valuation firm.',
    `leverage_ratio` DECIMAL(18,2) COMMENT 'Fund-level leverage ratio expressed as total debt divided by total assets or equity. Indicates the degree of financial leverage employed by the fund manager.',
    `liquidity_classification` STRING COMMENT 'Classification of the alternative assets liquidity profile based on redemption terms, lock-up periods, and secondary market availability. Critical for Asset Liability Management (ALM) duration matching and liquidity stress testing.. Valid values are `liquid|semi_liquid|illiquid|locked`',
    `lock_up_expiration_date` DATE COMMENT 'Date on which the initial lock-up period expires and redemption rights become available subject to fund terms and conditions.',
    `lock_up_period_months` STRING COMMENT 'Number of months during which the investment cannot be redeemed or withdrawn. Represents the minimum holding period before liquidity becomes available.',
    `maturity_date` DATE COMMENT 'Expected maturity or termination date of the alternative investment fund or partnership. May be extended subject to fund terms and limited partner approval.',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation assigned to the alternative investment if applicable. Used for statutory accounting treatment and Risk-Based Capital (RBC) calculation.',
    `naic_schedule_ba_category` STRING COMMENT 'NAIC Schedule BA reporting sub-category code that classifies the alternative asset for statutory accounting and annual statement filing purposes.',
    `nav` DECIMAL(18,2) COMMENT 'Current Net Asset Value (NAV) of the alternative investment position as reported by the fund manager or general partner. Represents Fair Market Value (FMV) for statutory accounting and Risk-Based Capital (RBC) calculation purposes.',
    `nav_date` DATE COMMENT 'As-of date for the reported Net Asset Value (NAV). Alternative assets typically report NAV on a quarterly lag basis.',
    `next_valuation_date` DATE COMMENT 'Expected date of the next formal valuation report from the fund manager. Used for valuation monitoring and reporting schedule planning.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special terms, investment restrictions, or other relevant information about the alternative investment.',
    `rbc_c1_charge` DECIMAL(18,2) COMMENT 'Calculated Risk-Based Capital (RBC) C-1 asset risk charge for this alternative investment. Computed as Net Asset Value (NAV) multiplied by the applicable RBC C-1 factor.',
    `rbc_c1_factor` DECIMAL(18,2) COMMENT 'Risk-Based Capital (RBC) C-1 asset risk factor applied to the alternative investment for calculating the required capital charge. Factor varies by alternative asset type and NAIC designation.',
    `redemption_frequency` STRING COMMENT 'Frequency at which redemption requests can be submitted and processed by the fund manager. Determines liquidity availability for Asset Liability Management (ALM) planning.. Valid values are `daily|monthly|quarterly|annually|at_maturity|none`',
    `redemption_notice_days` STRING COMMENT 'Number of days advance notice required to submit a redemption request. Impacts liquidity planning and cash flow forecasting.',
    `sector_focus` STRING COMMENT 'Primary industry sector or economic sector focus of the alternative investment such as technology, healthcare, energy, or real estate. Used for sector concentration risk monitoring.',
    `side_pocket_flag` BOOLEAN COMMENT 'Indicates whether the fund utilizes side pocket provisions to segregate illiquid or hard-to-value assets from the main portfolio. Affects Net Asset Value (NAV) calculation and redemption rights.',
    `unfunded_commitment` DECIMAL(18,2) COMMENT 'Remaining capital commitment that has not yet been called or funded. Calculated as commitment_amount minus funded_amount. Represents future liquidity obligation and contingent liability for Asset Liability Management (ALM) planning.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Unrealized gain or loss on the alternative investment calculated as the difference between current Net Asset Value (NAV) and cost basis. Reported on NAIC Schedule D for statutory accounting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this alternative asset record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `vintage_year` STRING COMMENT 'The year in which the alternative investment fund or partnership was established and began accepting capital commitments. Used for performance benchmarking and cohort analysis.',
    CONSTRAINT pk_alternative_asset PRIMARY KEY(`alternative_asset_id`)
) COMMENT 'Master record for alternative investments held in the general account including private equity, hedge funds, real estate equity, infrastructure, and other Schedule BA assets. Captures asset name, alternative asset type, fund manager, commitment amount, funded amount, unfunded commitment, NAV, vintage year, investment strategy, liquidity classification, NAIC Schedule BA sub-category, expected return, and lock-up period. Supports NAIC Schedule BA reporting, illiquidity premium analysis, and RBC C-1 alternative asset charges.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`derivative_contract` (
    `derivative_contract_id` BIGINT COMMENT 'Unique identifier for the derivative contract record. Primary key.',
    `broker_dealer_counterparty_id` BIGINT COMMENT 'Reference to the broker-dealer that facilitated the derivative transaction, if applicable.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity with whom the derivative contract is executed.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Derivatives (Schedule DB) are held by specific legal entities for regulatory reporting, collateral management, RBC calculations, and hedge accounting documentation.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to product.product_plan. Business justification: Derivatives hedge product-specific risks: equity index options for GMDB/GMWB guarantees on variable annuities, interest rate swaps for fixed annuity crediting rates, and currency forwards for internat',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio that holds this derivative position.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Derivative contracts require tracking the executing trader for trade attribution, best execution analysis, and SOX segregation of duties. Distinct from derivative_valuation.employee_id which tracks th',
    `security_id` BIGINT COMMENT 'Foreign key linking to investment.security. Business justification: Derivative contracts reference underlying securities (stocks, bonds, indices). The existing underlying_cusip attribute identifies the underlying but lacks FK to security master. Adding underlying_secu',
    `alm_segment` STRING COMMENT 'Asset Liability Management segment or bucket to which this derivative is assigned for duration matching and interest rate risk management purposes.',
    `collateral_posted` DECIMAL(18,2) COMMENT 'The amount of collateral posted by the company to the counterparty to secure the derivative obligation.',
    `collateral_received` DECIMAL(18,2) COMMENT 'The amount of collateral received from the counterparty to secure their derivative obligation to the company.',
    `collateral_type` STRING COMMENT 'Type of collateral used to secure the derivative contract obligations.. Valid values are `cash|government_securities|corporate_bonds|letters_of_credit|none`',
    `contract_notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special terms related to the derivative contract.',
    `contract_number` STRING COMMENT 'Business identifier for the derivative contract, typically assigned by the investment management system or counterparty.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the derivative contract indicating whether it is active, matured, terminated, cancelled, or pending execution.. Valid values are `active|matured|terminated|cancelled|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this derivative contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the notional amount and contract payments.. Valid values are `^[A-Z]{3}$`',
    `current_fmv` DECIMAL(18,2) COMMENT 'The current fair market value of the derivative contract as of the most recent valuation date, representing the amount that would be received or paid to terminate the contract.',
    `derivative_subtype` STRING COMMENT 'Further classification of the derivative instrument providing additional detail beyond the primary type (e.g., payer swap, receiver swap, call option, put option).',
    `derivative_type` STRING COMMENT 'Classification of the derivative instrument type used for hedging or replication purposes. [ENUM-REF-CANDIDATE: interest_rate_swap|swaption|cap|floor|collar|credit_default_swap|equity_option|currency_forward|futures — 9 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which the derivative contract becomes effective and obligations begin.',
    `fair_value_hierarchy_level` STRING COMMENT 'Classification of the fair value measurement input level under GAAP (Level 1: quoted prices, Level 2: observable inputs, Level 3: unobservable inputs).. Valid values are `level_1|level_2|level_3`',
    `floating_rate_index` STRING COMMENT 'The benchmark interest rate index used for floating rate calculations (e.g., SOFR, LIBOR, Fed Funds Rate).',
    `gmdb_hedge_flag` BOOLEAN COMMENT 'Indicator of whether this derivative is used to hedge Guaranteed Minimum Death Benefit exposure on variable annuity contracts.',
    `gmwb_hedge_flag` BOOLEAN COMMENT 'Indicator of whether this derivative is used to hedge Guaranteed Minimum Withdrawal Benefit exposure on variable annuity contracts.',
    `hedge_designation` STRING COMMENT 'Accounting classification of the hedge relationship under GAAP or SAP, indicating whether the derivative qualifies for hedge accounting treatment.. Valid values are `fair_value_hedge|cash_flow_hedge|net_investment_hedge|economic_hedge|no_hedge_designation`',
    `hedge_effectiveness_test_result` STRING COMMENT 'Result of the most recent hedge effectiveness assessment, determining whether the derivative continues to qualify for hedge accounting.. Valid values are `highly_effective|not_effective|not_tested`',
    `isda_master_agreement_date` DATE COMMENT 'The effective date of the ISDA Master Agreement governing the derivative contract terms and conditions.',
    `isda_master_agreement_version` STRING COMMENT 'Version of the ISDA Master Agreement under which the derivative contract is documented (e.g., 1992, 2002).',
    `maturity_date` DATE COMMENT 'The date on which the derivative contract expires or reaches final settlement.',
    `naic_designation` STRING COMMENT 'NAIC quality rating designation for the derivative contract or underlying reference entity, used for regulatory capital calculations.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The principal amount upon which derivative payments are calculated. This amount is not exchanged but serves as the basis for calculating cash flows.',
    `payment_frequency` STRING COMMENT 'Frequency at which cash flows or settlements occur under the derivative contract.. Valid values are `monthly|quarterly|semi_annually|annually|at_maturity`',
    `rbc_category` STRING COMMENT 'Risk-Based Capital category classification for the derivative contract used in calculating C-1, C-2, or C-3 risk charges.',
    `rbc_charge` DECIMAL(18,2) COMMENT 'The calculated Risk-Based Capital charge amount for this derivative position, contributing to the companys total RBC requirement.',
    `schedule_db_reporting_flag` BOOLEAN COMMENT 'Indicator of whether this derivative contract must be reported on NAIC Schedule DB (Derivative Instruments) in the Annual Statement.',
    `separate_account_flag` BOOLEAN COMMENT 'Indicator of whether this derivative is held in a separate account (variable product account) versus the general account.',
    `strike_rate` DECIMAL(18,2) COMMENT 'The fixed interest rate, strike price, or reference rate specified in the derivative contract (e.g., fixed rate in an interest rate swap, strike price in an option).',
    `termination_date` DATE COMMENT 'The actual date on which the derivative contract was terminated or closed out prior to maturity, if applicable.',
    `termination_reason` STRING COMMENT 'Business reason for early termination of the derivative contract (e.g., hedge no longer needed, counterparty credit concerns, portfolio rebalancing).',
    `trade_date` DATE COMMENT 'The date on which the derivative contract was executed and agreed upon by both parties.',
    `underlying_reference` STRING COMMENT 'Description or identifier of the underlying asset, index, rate, or reference entity upon which the derivative value is based (e.g., LIBOR, S&P 500, specific bond CUSIP).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this derivative contract record was last modified in the system.',
    CONSTRAINT pk_derivative_contract PRIMARY KEY(`derivative_contract_id`)
) COMMENT 'Master record for derivative instruments used for hedging or replication purposes including interest rate swaps, swaptions, caps/floors, credit default swaps, equity options, and currency forwards. Captures derivative type, notional amount, counterparty, trade date, effective date, maturity date, hedge designation (fair value hedge, cash flow hedge, economic hedge), underlying reference, strike/fixed rate, current FMV, collateral posted/received, and ISDA master agreement reference. Supports ALM hedging programs, GMDB/GMWB hedge accounting, and NAIC derivative reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` (
    `derivative_valuation_id` BIGINT COMMENT 'Unique identifier for each derivative valuation record. Primary key for the derivative valuation product.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity for this derivative contract. Used for counterparty credit risk monitoring and concentration risk analysis.',
    `derivative_contract_id` BIGINT COMMENT 'Reference to the underlying derivative contract being valued. Links to the derivative contract master record.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this valuation record. Supports audit trail and segregation of duties requirements.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio that holds this derivative position.',
    `valuation_run_id` BIGINT COMMENT 'Identifier for the batch valuation run that produced this record. Supports batch processing reconciliation and reprocessing.',
    `alm_segment` STRING COMMENT 'The ALM segment or liability cohort that this derivative is hedging. Used for duration matching and interest rate risk management.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this valuation record was approved. Required for financial close audit trail.',
    `collateral_balance` DECIMAL(18,2) COMMENT 'The current balance of collateral posted or received under the Credit Support Annex (CSA) or collateral agreement. Used to mitigate counterparty credit exposure.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this valuation record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amounts. Supports multi-currency derivative portfolios.. Valid values are `^[A-Z]{3}$`',
    `cva` DECIMAL(18,2) COMMENT 'The adjustment to the derivative fair value to account for counterparty credit risk. Represents the market value of counterparty default risk.',
    `delta` DECIMAL(18,2) COMMENT 'The rate of change of the derivative value with respect to changes in the underlying asset price. First-order Greek used for hedge ratio calculation and risk management.',
    `dv01` DECIMAL(18,2) COMMENT 'The dollar change in derivative value for a one basis point parallel shift in interest rates. Used for interest rate risk management and Asset Liability Management (ALM) duration matching.',
    `dva` DECIMAL(18,2) COMMENT 'The adjustment to the derivative fair value to account for own credit risk. Represents the market value of the companys own default risk on derivative liabilities.',
    `fair_value_hierarchy_level` STRING COMMENT 'The GAAP ASC 820 fair value hierarchy classification. Level 1: quoted prices in active markets; Level 2: observable inputs; Level 3: unobservable inputs.. Valid values are `level_1|level_2|level_3`',
    `fmv` DECIMAL(18,2) COMMENT 'The fair market value of the derivative contract at the valuation date. Can be positive (asset) or negative (liability). Used for GAAP ASC 815 hedge accounting and NAIC Schedule DB reporting.',
    `gaap_classification` STRING COMMENT 'The GAAP accounting classification for this derivative. Determines income statement and balance sheet presentation.. Valid values are `trading|hedging|other`',
    `gamma` DECIMAL(18,2) COMMENT 'The rate of change of delta with respect to changes in the underlying asset price. Second-order Greek used for convexity risk assessment.',
    `hedge_designation` STRING COMMENT 'The hedge accounting designation under GAAP ASC 815. Determines accounting treatment and effectiveness testing requirements.. Valid values are `fair_value_hedge|cash_flow_hedge|net_investment_hedge|economic_hedge|not_designated`',
    `hedge_effectiveness_test_result` STRING COMMENT 'The result of the most recent hedge effectiveness test. Required for hedge accounting qualification under GAAP ASC 815.. Valid values are `highly_effective|effective|ineffective|not_tested|not_applicable`',
    `hedge_ineffectiveness_amount` DECIMAL(18,2) COMMENT 'The dollar amount of hedge ineffectiveness recognized in earnings. Required disclosure for hedge accounting under GAAP ASC 815.',
    `naic_designation` STRING COMMENT 'The NAIC credit quality designation for the derivative counterparty. Used for statutory accounting and RBC charge calculation.. Valid values are `^(1|2|3|4|5|6)$`',
    `naic_schedule_db_line_number` STRING COMMENT 'The line number on NAIC Schedule DB (Derivative Instruments) where this position is reported. Supports statutory reporting reconciliation.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The notional principal amount of the derivative contract. Used to calculate exposure and for regulatory capital calculations under Risk-Based Capital (RBC) requirements.',
    `pricing_source` STRING COMMENT 'The source of market data or pricing used for the valuation. Supports fair value hierarchy classification and pricing transparency. [ENUM-REF-CANDIDATE: bloomberg|reuters|ice|cme|internal_model|counterparty_quote|broker_quote|consensus_pricing|other — 9 candidates stripped; promote to reference product]',
    `rbc_charge` DECIMAL(18,2) COMMENT 'The dollar amount of RBC charge attributed to this derivative position. Contributes to total company RBC requirement.',
    `rbc_factor` DECIMAL(18,2) COMMENT 'The RBC factor applied to this derivative position for C-1 (credit risk) or C-3 (interest rate risk) capital charge calculation.',
    `sap_classification` STRING COMMENT 'The SAP accounting classification for this derivative under NAIC guidance. Determines statutory statement presentation.. Valid values are `hedging|income_generation|replication|other`',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this derivative is held in a separate account (variable product) or general account. True if separate account; false if general account.',
    `theta` DECIMAL(18,2) COMMENT 'The rate of change of the derivative value with respect to the passage of time (time decay). Used for time-based risk assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this valuation record was last modified. Supports audit trail and change tracking requirements.',
    `valuation_adjustment_reason` STRING COMMENT 'Free-text explanation for any manual adjustments made to the model-generated valuation. Required for audit trail and model override documentation.',
    `valuation_date` DATE COMMENT 'The business date for which this derivative valuation was performed. Used for mark-to-market reporting and financial statement preparation.',
    `valuation_model_used` STRING COMMENT 'The pricing model or methodology used to calculate the derivative fair market value. Critical for model risk management and audit trail. [ENUM-REF-CANDIDATE: black_scholes|binomial_tree|monte_carlo|finite_difference|hull_white|black_derman_toy|libor_market_model|vendor_model|other — 9 candidates stripped; promote to reference product]',
    `valuation_notes` STRING COMMENT 'Additional free-text notes or comments regarding this valuation. Used for documenting unusual circumstances, model limitations, or data quality issues.',
    `valuation_status` STRING COMMENT 'The approval status of this valuation record. Supports valuation workflow and financial close process.. Valid values are `preliminary|final|adjusted|under_review|approved`',
    `valuation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the valuation calculation was executed. Supports intraday valuation tracking and audit trail requirements.',
    `variation_margin_call` DECIMAL(18,2) COMMENT 'The amount of variation margin called or posted based on daily mark-to-market movements. Positive values indicate margin to be received; negative values indicate margin to be posted.',
    `vega` DECIMAL(18,2) COMMENT 'The sensitivity of the derivative value to changes in implied volatility of the underlying asset. Used for volatility risk management.',
    CONSTRAINT pk_derivative_valuation PRIMARY KEY(`derivative_valuation_id`)
) COMMENT 'Periodic mark-to-market valuation records for each derivative contract. Captures valuation date, FMV (positive/negative), delta, gamma, vega, theta, DV01, CVA (credit valuation adjustment), DVA (debit valuation adjustment), collateral balance, variation margin call, and valuation model used. Supports GAAP ASC 815 hedge effectiveness testing, NAIC Schedule DB reporting, and counterparty credit risk monitoring.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`guideline` (
    `guideline_id` BIGINT COMMENT 'Unique identifier for the investment guideline record. Primary key.',
    `compliance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Investment guidelines implement compliance policies (investment policy statement, fiduciary standards, prudent investor rules). Real business process: policy governance, guideline maintenance, complia',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Investment guidelines have designated owners responsible for periodic review, exception approval, and alignment with investment policy statements. Required for investment governance and fiduciary over',
    `portfolio_id` BIGINT COMMENT 'Specific portfolio to which this guideline applies. Null if guideline applies to all portfolios within the scope.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Guidelines enforce specific regulatory obligations (NAIC Model Investment Law, state insurance codes, DOL fiduciary rules for ERISA plans). Real business process: regulatory compliance mapping, obliga',
    `superseded_guideline_id` BIGINT COMMENT 'Reference to the prior investment guideline that this guideline replaces, maintaining historical lineage for audit and governance purposes.',
    `approval_authority` STRING COMMENT 'The governance body or role that approved this guideline (e.g., Board of Directors, Investment Committee, Chief Investment Officer, Asset Liability Committee).',
    `approval_date` DATE COMMENT 'The date on which the approval authority formally approved this investment guideline.',
    `asset_class` STRING COMMENT 'The broad asset class category to which this guideline applies, aligning with NAIC Schedule classifications. [ENUM-REF-CANDIDATE: fixed_income|equity|real_estate|mortgage_loan|policy_loan|cash_equivalent|alternative|derivative — 8 candidates stripped; promote to reference product]',
    `asset_subclass` STRING COMMENT 'More granular asset classification within the asset class (e.g., corporate bonds, municipal bonds, common stock, preferred stock, commercial mortgage, residential mortgage).',
    `breach_action` STRING COMMENT 'Required action when the guideline is breached, defining the remediation workflow and escalation path.. Valid values are `immediate_rebalance|notify_committee|escalate_cio|file_regulatory_report|waiver_required`',
    `breach_tolerance_percentage` DECIMAL(18,2) COMMENT 'Permissible deviation from the guideline threshold before a formal breach is triggered, allowing for minor market-driven fluctuations.',
    `calculation_methodology` STRING COMMENT 'Detailed description of how compliance with this guideline is measured, including valuation basis (book value, fair market value, statement value), aggregation rules, and exclusions.',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of portfolio that may be invested in a single issuer, sector, geography, or other concentration dimension.',
    `concentration_limit_type` STRING COMMENT 'The dimension along which concentration is measured and limited (e.g., single issuer exposure, sector concentration, geographic concentration).. Valid values are `single_issuer|sector|geography|currency|counterparty|security_type`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this investment guideline record was first created in the data platform.',
    `credit_quality_requirement` STRING COMMENT 'Minimum credit quality standard required for investments, expressed as rating agency designation (e.g., investment grade, BBB- or higher, A or higher).',
    `duration_constraint_maximum_years` DECIMAL(18,2) COMMENT 'Maximum portfolio duration in years permitted to control interest rate risk exposure.',
    `duration_constraint_minimum_years` DECIMAL(18,2) COMMENT 'Minimum portfolio duration in years required to match liability duration for Asset Liability Management (ALM) purposes.',
    `effective_date` DATE COMMENT 'The date on which this investment guideline becomes active and enforceable for portfolio management and compliance monitoring.',
    `exception_criteria` STRING COMMENT 'Conditions under which an exception to this guideline may be granted, defining the circumstances and approval requirements for deviations.',
    `expiration_date` DATE COMMENT 'The date on which this investment guideline ceases to be active. Null for guidelines with indefinite duration subject to periodic review.',
    `guideline_code` STRING COMMENT 'Business identifier code for the investment guideline, used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `guideline_description` STRING COMMENT 'Comprehensive business description of the guideline purpose, rationale, and application, providing context for portfolio managers and compliance officers.',
    `guideline_name` STRING COMMENT 'Descriptive name of the investment guideline for business user identification.',
    `guideline_status` STRING COMMENT 'Current lifecycle status of the investment guideline indicating whether it is in force, awaiting approval, or no longer applicable.. Valid values are `active|inactive|pending_approval|superseded|expired`',
    `guideline_type` STRING COMMENT 'Classification of the guideline defining its purpose: strategic asset allocation sets long-term targets, tactical range defines permissible deviations, credit floor establishes minimum credit quality, concentration limit caps exposure to single issuer or sector, duration constraint manages interest rate risk, prohibited investment lists excluded securities.. Valid values are `strategic_asset_allocation|tactical_range|credit_floor|concentration_limit|duration_constraint|prohibited_investment`',
    `last_review_date` DATE COMMENT 'The most recent date on which this guideline was reviewed by the governance body, even if no changes were made.',
    `maximum_allocation_percentage` DECIMAL(18,2) COMMENT 'The maximum permissible allocation percentage for the asset class or sector, defining the upper bound of the tactical range and concentration limit.',
    `minimum_allocation_percentage` DECIMAL(18,2) COMMENT 'The minimum permissible allocation percentage for the asset class or sector, defining the lower bound of the tactical range.',
    `naic_designation_requirement` STRING COMMENT 'Required NAIC designation for securities subject to this guideline. NAIC 1 and 2 are investment grade; NAIC 3-6 are below investment grade with increasing risk.. Valid values are `NAIC_1|NAIC_2|NAIC_3|NAIC_4|NAIC_5|NAIC_6`',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this guideline by the governance body.',
    `notes` STRING COMMENT 'Additional operational notes, clarifications, or special instructions related to the application or interpretation of this guideline.',
    `portfolio_scope` STRING COMMENT 'Defines whether the guideline applies to general account investments, separate account investments, or all portfolios.. Valid values are `general_account|separate_account|all_portfolios`',
    `post_trade_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this guideline is monitored after trade execution for compliance reporting and breach detection.',
    `pre_trade_enforcement_flag` BOOLEAN COMMENT 'Indicates whether this guideline must be enforced in the pre-trade compliance system, blocking trades that would violate the guideline.',
    `priority` STRING COMMENT 'Numeric priority ranking used to resolve conflicts when multiple guidelines apply to the same investment decision. Lower numbers indicate higher priority.',
    `product_line` STRING COMMENT 'Insurance product line for which this guideline governs investments (e.g., whole life, universal life, fixed annuity, variable annuity, term life). Used when guidelines differ by product liability characteristics.',
    `rbc_component` STRING COMMENT 'The RBC component that this guideline is designed to manage or constrain (C1 for asset default risk, C3 for interest rate risk, C4 for business risk).. Valid values are `C1_asset_risk|C3_interest_rate_risk|C4_business_risk`',
    `rbc_factor_threshold` DECIMAL(18,2) COMMENT 'Maximum weighted average RBC factor permitted for the portfolio or asset class under this guideline, used to control capital charges.',
    `regulatory_basis` STRING COMMENT 'The regulatory authority or statute that mandates or influences this guideline (e.g., State Investment Law, NAIC Model Regulation, Prudent Person Rule, RBC Requirements).',
    `regulatory_citation` STRING COMMENT 'Specific legal or regulatory citation reference (e.g., statute section, regulation number, NAIC model act section) that establishes the requirement.',
    `review_frequency` STRING COMMENT 'The required frequency at which this guideline must be reviewed by the governance body to ensure continued appropriateness.. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc`',
    `target_allocation_percentage` DECIMAL(18,2) COMMENT 'The strategic target allocation percentage for the asset class or sector within the portfolio, expressed as a percentage of total invested assets.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this investment guideline record was last modified, supporting audit trail and change tracking.',
    CONSTRAINT pk_guideline PRIMARY KEY(`guideline_id`)
) COMMENT 'Defines the investment policy statement (IPS) and portfolio-level investment guidelines governing asset allocation, sector limits, credit quality requirements, duration constraints, and prohibited investments. Captures guideline type (strategic asset allocation, tactical range, credit floor, concentration limit), target allocation percentage, minimum/maximum range, asset class scope, effective date, approval authority, and regulatory basis (state investment law, NAIC model regulation). Serves as the governance framework for compliance rule generation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`asset_allocation` (
    `asset_allocation_id` BIGINT COMMENT 'Unique identifier for the asset allocation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or investment officer who approved this asset allocation record.',
    `guideline_id` BIGINT COMMENT 'Foreign key linking to investment.guideline. Business justification: asset_allocation records actual and target allocations for portfolios; guideline defines the investment policy limits and targets. An asset_allocation record should reference the guideline it is measu',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio for which this allocation applies.',
    `active_weight_percentage` DECIMAL(18,2) COMMENT 'The difference between actual allocation and benchmark allocation, calculated as (actual_weight_percentage - benchmark_weight_percentage), indicating active positioning.',
    `actual_duration_years` DECIMAL(18,2) COMMENT 'The actual weighted average duration in years of holdings in this asset class at the allocation date.',
    `actual_market_value` DECIMAL(18,2) COMMENT 'The total market value of holdings in this asset class at the allocation date, expressed in the portfolio base currency.',
    `actual_weight_percentage` DECIMAL(18,2) COMMENT 'The actual allocation percentage for this asset class at the allocation date, calculated from current market values.',
    `allocation_date` DATE COMMENT 'The date on which this asset allocation snapshot was recorded or became effective.',
    `allocation_notes` STRING COMMENT 'Free-text notes or commentary regarding this asset allocation, including rationale for deviations, special circumstances, or investment committee guidance.',
    `allocation_status` STRING COMMENT 'Current status of the asset allocation record in its approval and monitoring lifecycle.. Valid values are `draft|pending_approval|approved|active|breached|under_review`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the asset allocation was calculated or recorded, supporting intraday allocation tracking.',
    `allocation_type` STRING COMMENT 'Indicates whether this record represents a strategic (long-term policy), tactical (short-term adjustment), or actual (current snapshot) allocation.. Valid values are `strategic|tactical|actual`',
    `alm_segment` STRING COMMENT 'The ALM segment or liability cohort that this asset allocation supports (e.g., general account, separate account, specific product line).',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset allocation was formally approved.',
    `asset_class` STRING COMMENT 'The broad asset class category for this allocation record (e.g., fixed income, equity, real estate, alternative investments, cash equivalents).. Valid values are `fixed_income|equity|real_estate|alternative|cash_equivalents|other`',
    `asset_subclass` STRING COMMENT 'More granular classification within the asset class (e.g., corporate bonds, government bonds, large-cap equity, small-cap equity, commercial real estate).',
    `benchmark_weight_percentage` DECIMAL(18,2) COMMENT 'The allocation percentage of this asset class in the portfolios benchmark index, used for performance attribution and relative positioning analysis.',
    `compliance_breach_flag` BOOLEAN COMMENT 'Indicates whether the actual allocation breaches any regulatory or policy limits for this asset class.',
    `compliance_limit_percentage` DECIMAL(18,2) COMMENT 'The maximum allocation percentage allowed by regulatory or internal policy for this asset class.',
    `compliance_limit_type` STRING COMMENT 'The type of regulatory or policy limit that applies to this asset class (e.g., statutory limit, policy limit, concentration limit).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the portfolio base currency in which market values and allocations are expressed.. Valid values are `^[A-Z]{3}$`',
    `deviation_from_target_percentage` DECIMAL(18,2) COMMENT 'The difference between actual weight and target weight, calculated as (actual_weight_percentage - target_weight_percentage). Positive values indicate overweight positions; negative values indicate underweight positions.',
    `duration_target_years` DECIMAL(18,2) COMMENT 'The target duration in years for this asset class allocation, supporting ALM duration matching objectives.',
    `investment_committee_decision` STRING COMMENT 'Summary of the investment committees decision or action regarding this asset allocation (e.g., approved, approved with conditions, rebalancing required, under monitoring).',
    `investment_committee_review_date` DATE COMMENT 'The date on which the investment committee reviewed and approved this asset allocation strategy or snapshot.',
    `maximum_weight_percentage` DECIMAL(18,2) COMMENT 'The maximum allowable allocation percentage for this asset class, defining the upper bound of the allocation corridor.',
    `minimum_weight_percentage` DECIMAL(18,2) COMMENT 'The minimum allowable allocation percentage for this asset class, defining the lower bound of the allocation corridor.',
    `naic_designation_requirement` STRING COMMENT 'The minimum NAIC designation or credit quality requirement for securities within this asset class allocation (e.g., NAIC 1, NAIC 2).',
    `rbc_category` STRING COMMENT 'The RBC component category for this asset class (e.g., C1, C3), used for regulatory capital charge calculations.',
    `rbc_charge_amount` DECIMAL(18,2) COMMENT 'The total RBC charge amount associated with this asset class allocation, calculated per NAIC RBC formulas.',
    `rebalancing_threshold_percentage` DECIMAL(18,2) COMMENT 'The maximum allowable deviation from target weight before rebalancing is required, as defined by investment policy.',
    `rebalancing_trigger_flag` BOOLEAN COMMENT 'Indicates whether the deviation from target has exceeded the rebalancing threshold, triggering a need for portfolio rebalancing action.',
    `reporting_period` STRING COMMENT 'The reporting period to which this asset allocation record applies (e.g., 2024-Q1, 2024-03, 2024).',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this allocation applies to a separate account (variable product) portfolio versus general account.',
    `target_weight_percentage` DECIMAL(18,2) COMMENT 'The strategic or tactical target allocation percentage for this asset class as approved by the investment committee or Asset Liability Management (ALM) policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset allocation record was last modified.',
    CONSTRAINT pk_asset_allocation PRIMARY KEY(`asset_allocation_id`)
) COMMENT 'Records the strategic and tactical asset allocation targets and actual allocations for each portfolio at a point in time. Captures allocation date, asset class, target weight, minimum weight, maximum weight, actual weight, actual market value, deviation from target, rebalancing trigger flag, and allocation approval status. Supports ALM strategic asset allocation governance, investment committee reporting, and NAIC investment diversification compliance.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`counterparty` (
    `counterparty_id` BIGINT COMMENT 'Unique identifier for the investment counterparty. Primary key for the counterparty master record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Investment counterparties may be affiliated legal entities requiring intercompany elimination, related-party disclosure, and consolidation adjustments for financial statement preparation.',
    `employee_id` BIGINT COMMENT 'Internal employee identifier for the relationship manager responsible for this counterparty. Used for accountability and escalation.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Counterparties (broker-dealers, custodians, fund managers) are vendors from enterprise vendor management perspective. Business processes: vendor risk assessment, SOC2 compliance tracking, contract man',
    `address_line1` STRING COMMENT 'First line of the counterpartys registered business address. Used for legal correspondence and regulatory reporting.',
    `address_line2` STRING COMMENT 'Second line of the counterpartys registered business address (suite, floor, building name).',
    `aml_kyc_status` STRING COMMENT 'Current status of AML and KYC due diligence for this counterparty. Must be compliant before executing transactions.. Valid values are `compliant|pending|expired|failed|under_review`',
    `approved_asset_classes` STRING COMMENT 'Comma-separated list of asset classes approved for trading with this counterparty (e.g., fixed_income, equity, derivatives, alternatives). Used for pre-trade compliance checks. [ENUM-REF-CANDIDATE: fixed_income|equity|derivatives|alternatives|real_estate|commodities|structured_products — promote to reference product]',
    `approved_trading_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate exposure amount approved for trading with this counterparty. Enforced by pre-trade compliance checks to manage counterparty concentration risk.',
    `city` STRING COMMENT 'City of the counterpartys registered business address.',
    `counterparty_status` STRING COMMENT 'Current operational status of the counterparty relationship. Controls whether new trades and transactions can be executed with this counterparty.. Valid values are `active|inactive|suspended|pending_approval|terminated|under_review`',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty role in investment operations. Determines applicable compliance rules, credit limits, and operational workflows.. Valid values are `broker_dealer|swap_counterparty|custodian_bank|fund_manager|securities_lending_agent|sub_custodian`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the counterpartys domicile. Used for regulatory reporting and cross-border risk assessment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this counterparty record was first created in the system. Used for audit trail and data lineage.',
    `credit_rating` STRING COMMENT 'Current credit rating assigned by external rating agencies (e.g., Moodys, S&P, Fitch). Used for counterparty risk assessment and RBC calculations.',
    `csa_type` STRING COMMENT 'Type of Credit Support Annex governing collateral arrangements for derivative transactions. Bilateral requires both parties to post collateral; unilateral requires only one party.. Valid values are `bilateral|unilateral|none`',
    `custodian_account_number` STRING COMMENT 'Account number assigned by the custodian bank for holding securities. Applicable when counterparty_type is custodian_bank or sub_custodian.',
    `fatca_status` STRING COMMENT 'FATCA classification status for foreign counterparties. Determines withholding and reporting obligations under US tax law.. Valid values are `participating_ffi|deemed_compliant|exempt|non_participating|not_applicable`',
    `finra_registration_number` STRING COMMENT 'FINRA Central Registration Depository (CRD) number for broker-dealers. Required for broker-dealer counterparties.',
    `form_expiration_date` DATE COMMENT 'Expiration date of the W-8 or W-9 form on file. W-8 forms typically expire after three years; W-9 forms do not expire but require updates when information changes.',
    `isda_agreement_date` DATE COMMENT 'The date when the ISDA Master Agreement was executed. Null if no ISDA agreement exists.',
    `isda_agreement_flag` BOOLEAN COMMENT 'Indicates whether an ISDA Master Agreement is in place with this counterparty. Required for derivative and swap transactions.',
    `kyc_next_review_date` DATE COMMENT 'Scheduled date for the next KYC review. Typically annual or risk-based frequency.',
    `kyc_review_date` DATE COMMENT 'Date of the most recent KYC review. Used to trigger periodic re-verification workflows per regulatory requirements.',
    `legal_name` STRING COMMENT 'The full legal name of the counterparty as registered with regulatory authorities. Used for legal documentation, contracts, and regulatory reporting.',
    `lei` STRING COMMENT 'ISO 17442 standard 20-character Legal Entity Identifier used for global counterparty identification in financial transactions and regulatory reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `limit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the approved trading limit. Typically USD for US-domiciled insurers.. Valid values are `^[A-Z]{3}$`',
    `naic_designation_override` STRING COMMENT 'Manual NAIC designation override applied to securities issued by this counterparty. Used when SVO designation differs from external ratings.',
    `notes` STRING COMMENT 'Free-text notes capturing additional information about the counterparty, special handling instructions, or historical context.',
    `onboarding_date` DATE COMMENT 'Date when the counterparty was approved and onboarded for trading. Marks the start of the business relationship.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the counterpartys registered business address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person. Used for trade confirmations, settlement instructions, and operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person at the counterparty organization for operational and trading matters.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact person for urgent operational matters and trade execution.',
    `rating_agency` STRING COMMENT 'The rating agency that provided the credit rating. Multiple agencies may rate the same counterparty; this field captures the primary rating source used for risk decisions.. Valid values are `moodys|sp|fitch|am_best|dbrs`',
    `rating_date` DATE COMMENT 'The date when the current credit rating became effective. Used to track rating staleness and trigger review workflows.',
    `rbc_concentration_factor` DECIMAL(18,2) COMMENT 'RBC concentration adjustment factor applied to positions with this counterparty. Higher factors increase capital charges for concentrated exposures.',
    `sec_registration_number` STRING COMMENT 'SEC registration number for investment advisers, broker-dealers, or fund managers. Used to verify regulatory standing.',
    `short_name` STRING COMMENT 'Abbreviated or common name used for operational purposes and system displays.',
    `state_province` STRING COMMENT 'State or province of the counterpartys registered business address. Two-letter state code for US addresses.',
    `tax_identification_number` STRING COMMENT 'Tax identification number (EIN for US entities, equivalent for foreign entities). Used for tax reporting and IRS Form 1099 generation.',
    `termination_date` DATE COMMENT 'Date when the counterparty relationship was terminated. Null for active relationships.',
    `termination_reason` STRING COMMENT 'Reason for terminating the counterparty relationship (e.g., credit downgrade, regulatory action, business decision, counterparty request).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this counterparty record was last modified. Used for audit trail and change tracking.',
    `w8_w9_form_on_file_flag` BOOLEAN COMMENT 'Indicates whether a valid IRS Form W-8 (for foreign entities) or W-9 (for US entities) is on file. Required for tax withholding compliance.',
    CONSTRAINT pk_counterparty PRIMARY KEY(`counterparty_id`)
) COMMENT 'Master record for all investment counterparties including broker-dealers, swap counterparties, custodian banks, fund managers, securities lending agents, and sub-custodians. Captures counterparty legal name, LEI (Legal Entity Identifier), counterparty type, credit rating, ISDA agreement reference, approved trading limits, collateral agreement type (CSA), custodian account details, AML/KYC status, regulatory registration (FINRA, SEC), and relationship manager. SSOT for investment counterparty identity within the investment domain; distinct from policyholder or agent counterparties in other domains.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`securities_lending` (
    `securities_lending_id` BIGINT COMMENT 'Unique identifier for the securities lending transaction.',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: Securities lending transactions involve lending specific asset holdings to borrowers. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing po',
    `portfolio_id` BIGINT COMMENT 'Reference to the portfolio containing the lent securities.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity borrowing the securities.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Securities lending programs require designated managers for collateral monitoring, recall decisions, counterparty exposure limits, and fee income optimization. Critical for Schedule DL reporting and c',
    `security_id` BIGINT COMMENT 'Reference to the security being lent in this transaction.',
    `accrued_fee_income` DECIMAL(18,2) COMMENT 'Cumulative lending fee income accrued on this loan from initiation to the current valuation date.',
    `actual_return_date` DATE COMMENT 'Date when the borrower actually returned the lent securities to the lender.',
    `alm_segment` STRING COMMENT 'ALM segment classification for the lent securities, used for duration matching and interest rate risk management.',
    `collateral_margin_percentage` DECIMAL(18,2) COMMENT 'Percentage of over-collateralization required, expressed as a percentage above 100 percent. For example, 102 percent means collateral must be 102 percent of loan value.',
    `collateral_type` STRING COMMENT 'Type of collateral posted by the borrower to secure the loan. Common types include cash, government securities, corporate bonds, or letters of credit.. Valid values are `cash|government_securities|corporate_bonds|letters_of_credit|other`',
    `collateral_value` DECIMAL(18,2) COMMENT 'Current market value of the collateral held against the securities loan.',
    `counterparty_exposure_amount` DECIMAL(18,2) COMMENT 'Net exposure to the borrower counterparty, calculated as the difference between the market value of lent securities and collateral value.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this securities lending record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transaction.. Valid values are `^[A-Z]{3}$`',
    `indemnification_flag` BOOLEAN COMMENT 'Indicates whether the lending agent provides indemnification against borrower default.',
    `lending_fee_rate` DECIMAL(18,2) COMMENT 'Annual fee rate charged to the borrower for lending the securities, expressed as a decimal percentage of the loan value.',
    `loan_initiation_date` DATE COMMENT 'Date when the securities lending transaction was initiated and securities were transferred to the borrower.',
    `loan_initiation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the securities lending transaction was executed.',
    `loan_notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special conditions related to the securities lending transaction.',
    `loan_number` STRING COMMENT 'Business identifier for the securities lending transaction, typically assigned by the lending agent or internal system.',
    `loan_status` STRING COMMENT 'Current lifecycle status of the securities lending transaction.. Valid values are `open|recalled|returned|defaulted|terminated`',
    `loan_term_type` STRING COMMENT 'Classification of the loan duration structure. Open loans have no fixed maturity, term loans have a specified end date, overnight loans mature the next business day.. Valid values are `open|term|overnight`',
    `market_value_at_loan` DECIMAL(18,2) COMMENT 'Fair market value of the securities lent at the time of loan initiation.',
    `maturity_date` DATE COMMENT 'Scheduled maturity or termination date of the securities lending transaction. May be open-ended for on-demand loans.',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation assigned to the lent security, used for regulatory capital calculations.',
    `quantity_lent` DECIMAL(18,2) COMMENT 'Number of shares, units, or par value amount of the security lent to the borrower.',
    `rbc_charge` DECIMAL(18,2) COMMENT 'Regulatory capital charge associated with the securities lending transaction, calculated per NAIC RBC instructions.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Interest rate paid to the borrower on cash collateral, expressed as an annual percentage rate. Applicable only when collateral type is cash.',
    `recall_date` DATE COMMENT 'Date when the lender recalled the securities from the borrower, requesting return of the lent securities.',
    `reinvestment_income` DECIMAL(18,2) COMMENT 'Income earned from reinvesting cash collateral, net of rebate paid to borrower.',
    `reinvestment_vehicle` STRING COMMENT 'Description of the investment vehicle or strategy used to reinvest cash collateral received from the borrower.',
    `schedule_d_line_item` STRING COMMENT 'NAIC Annual Statement Schedule D line item reference for regulatory reporting of the securities lending transaction.',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether the lent securities originate from a separate account portfolio supporting variable products.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this securities lending record was last modified.',
    CONSTRAINT pk_securities_lending PRIMARY KEY(`securities_lending_id`)
) COMMENT 'Records securities lending transactions where portfolio assets are lent to borrowers in exchange for collateral and lending fees. Captures loan initiation date, maturity date, security lent (CUSIP/ISIN), quantity lent, borrower counterparty, collateral type (cash, government securities), collateral value, collateral margin percentage, lending fee rate, accrued fee income, recall date, loan status (open, recalled, returned), and reinvestment details for cash collateral. Supports investment income enhancement tracking, NAIC Schedule D securities lending disclosure, and counterparty exposure monitoring.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` (
    `gain_loss_event_id` BIGINT COMMENT 'Primary key for gain_loss_event',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Realized gains/losses require approval for SAP/GAAP recognition, tax lot selection validation, and Schedule D reporting. SOX controls mandate segregation between trade execution and gain/loss recognit',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: Realized gain/loss events occur on specific asset holdings. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing position_id. This links G/L ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Realized gains/losses create journal entries for financial statement recognition, Schedule D Part 4 reporting, and income statement preparation under SAP and GAAP.',
    `original_event_gain_loss_event_id` BIGINT COMMENT 'Reference to the original gain/loss event being reversed or corrected, if applicable.',
    `portfolio_id` BIGINT COMMENT 'Reference to the portfolio holding the security at the time of the event.',
    `security_id` BIGINT COMMENT 'Reference to the security involved in this gain/loss event.',
    `tax_lot_id` BIGINT COMMENT 'Identifier of the specific tax lot used for cost basis calculation in the gain/loss event.',
    `trade_id` BIGINT COMMENT 'Foreign key linking to investment.trade. Business justification: gain_loss_event records accounting events from security disposals, impairments, and other value changes. When event_type is Disposal or Sale, the event is triggered by a trade execution. Linking g',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Accrued interest included in the proceeds or settlement amount at the time of the event.',
    `alm_segment` STRING COMMENT 'ALM segment or liability cohort that the security was supporting at the time of the event.',
    `amortized_cost` DECIMAL(18,2) COMMENT 'Amortized cost basis of the security at the event date, reflecting premium/discount amortization.',
    `approval_status` STRING COMMENT 'Approval status of the gain/loss event in the accounting workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the gain/loss event was approved for final accounting recognition.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the gain/loss event for final booking.',
    `book_value` DECIMAL(18,2) COMMENT 'Carrying value or amortized cost basis of the security at the time of the event.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gain/loss event record was first created in the system.',
    `credit_loss_component` DECIMAL(18,2) COMMENT 'Portion of OTTI impairment attributable to credit losses, recognized in earnings under ASC 320 or CECL provision under ASC 326.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this event.',
    `disposal_method` STRING COMMENT 'Method by which the security was disposed of, if applicable to the event type. [ENUM-REF-CANDIDATE: open_market_sale|tender_offer|called|matured|exchanged|foreclosure|other — 7 candidates stripped; promote to reference product]',
    `event_date` DATE COMMENT 'The date on which the gain/loss event occurred (sale date, maturity date, or impairment recognition date).',
    `event_number` STRING COMMENT 'Business identifier for the gain/loss event, used for external reference and reporting.',
    `event_status` STRING COMMENT 'Current processing status of the gain/loss event in the accounting workflow.. Valid values are `pending|confirmed|settled|reversed|adjusted`',
    `event_subtype` STRING COMMENT 'Detailed classification of the event: sale, maturity, call, exchange, OTTI credit component, OTTI non-credit component, CECL provision, etc.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the gain/loss event was executed or recognized.',
    `event_type` STRING COMMENT 'Classification of the gain/loss event: realized gain/loss from sale or maturity, impairment, credit loss assessment, or recovery.. Valid values are `realized_gain|realized_loss|impairment|credit_loss|recovery|other_than_temporary_impairment`',
    `gaap_classification` STRING COMMENT 'Classification of the gain/loss event under US GAAP for financial statement reporting.. Valid values are `realized_gain_loss|otti_credit_loss|otti_non_credit_oci|cecl_provision|recovery`',
    `gain_loss_amount` DECIMAL(18,2) COMMENT 'Net realized gain or loss amount calculated as proceeds minus book value, or impairment charge amount. Positive for gains, negative for losses.',
    `holding_period_classification` STRING COMMENT 'Tax classification of the holding period: short-term (<=1 year) or long-term (>1 year).. Valid values are `short_term|long_term`',
    `holding_period_days` STRING COMMENT 'Number of days the security was held from acquisition to disposal or impairment date.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Total impairment charge recognized for other-than-temporary impairment (OTTI) or credit loss events.',
    `naic_designation_after` STRING COMMENT 'NAIC designation of the security immediately after the event, if applicable (e.g., after impairment).',
    `naic_designation_before` STRING COMMENT 'NAIC designation of the security immediately before the gain/loss event.',
    `naic_schedule_line` STRING COMMENT 'NAIC Schedule D Part 4 line item reference for realized capital gains and losses reporting.',
    `net_proceeds` DECIMAL(18,2) COMMENT 'Net proceeds after deducting transaction costs from gross proceeds.',
    `non_credit_oci_component` DECIMAL(18,2) COMMENT 'Portion of OTTI impairment attributable to non-credit factors (e.g., interest rate changes), recognized in OCI under GAAP.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, rationale, or documentation for the gain/loss event.',
    `original_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost of the security or tax lot involved in the event.',
    `proceeds_amount` DECIMAL(18,2) COMMENT 'Gross proceeds received from the sale or disposal of the security, before transaction costs.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares involved in the gain/loss event.',
    `rbc_category` STRING COMMENT 'RBC asset category of the security for capital charge calculation purposes.',
    `rbc_impact` DECIMAL(18,2) COMMENT 'Impact of the gain/loss event on the companys RBC calculation and capital position.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from a previously impaired security, reversing prior credit loss provisions.',
    `reporting_period` STRING COMMENT 'Financial reporting period (YYYY-MM or YYYY-QQ) in which the gain/loss event is recognized.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this event is a reversal or correction of a previously recorded gain/loss event.',
    `sap_classification` STRING COMMENT 'Classification of the gain/loss event under NAIC Statutory Accounting Principles for regulatory reporting.. Valid values are `realized_capital_gain|realized_capital_loss|impairment_loss|otti_credit|otti_non_credit`',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether the gain/loss event occurred in a separate account (variable product) portfolio.',
    `tax_lot_method` STRING COMMENT 'Method used to identify the tax lot for cost basis: FIFO, LIFO, specific identification, or average cost.. Valid values are `FIFO|LIFO|specific_identification|average_cost`',
    `transaction_cost` DECIMAL(18,2) COMMENT 'Brokerage commissions, fees, and other transaction costs incurred in the disposal.',
    `transaction_type` STRING COMMENT 'The type of transaction that triggered the gain/loss event. [ENUM-REF-CANDIDATE: sale|maturity|call|exchange|disposal|writedown|recovery — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this gain/loss event record was last modified.',
    CONSTRAINT pk_gain_loss_event PRIMARY KEY(`gain_loss_event_id`)
) COMMENT 'Records all investment accounting events that affect the carrying value of securities, including realized capital gains and losses from sale/maturity/disposal, other-than-temporary impairments (OTTI), and credit loss assessments (CECL). Captures event date, event type (realized gain/loss, impairment, credit loss), security and portfolio reference, proceeds (for sales), book/amortized cost basis, gain/loss or impairment amount, holding period classification, tax lot identification method (FIFO, specific identification), SAP/GAAP classification, impairment subtype (credit loss component, non-credit OCI component), recovery amounts, NAIC designation impact, and ASC 326 CECL provision. Supports NAIC Schedule D Part 4 realized gain/loss reporting, GAAP/SAP impairment reporting, LDTI credit loss assumptions, tax reporting, and investment income statement preparation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`impairment` (
    `impairment_id` BIGINT COMMENT 'Unique identifier for the impairment assessment record.',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: OTTI impairment assessments are performed on specific asset holdings. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing position_id. This ',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the final impairment assessment.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Impairment events generate journal entries for reserve adjustments and income statement impact, required for OTTI/CECL accounting and regulatory reporting.',
    `original_impairment_id` BIGINT COMMENT 'Reference to the original impairment record if this entry represents a reversal or adjustment.',
    `portfolio_id` BIGINT COMMENT 'Reference to the portfolio containing the impaired security.',
    `security_id` BIGINT COMMENT 'Reference to the underlying security subject to impairment assessment.',
    `alm_segment` STRING COMMENT 'Asset Liability Management (ALM) segment or duration bucket to which the impaired security is assigned for ALM analysis and reporting.',
    `amount` DECIMAL(18,2) COMMENT 'Total impairment charge recognized, representing the decline in value deemed other-than-temporary or expected credit loss.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the impairment assessment was formally approved.',
    `assessment_date` DATE COMMENT 'Date on which the impairment assessment was performed.',
    `assessment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the impairment assessment was completed.',
    `asset_class` STRING COMMENT 'Broad asset class category of the impaired security: corporate bond, municipal bond, government bond, mortgage-backed security, asset-backed security, or equity. [ENUM-REF-CANDIDATE: corporate_bond|municipal_bond|government_bond|mortgage_backed_security|asset_backed_security|equity|preferred_stock|common_stock — promote to reference product]. Valid values are `corporate_bond|municipal_bond|government_bond|mortgage_backed_security|asset_backed_security|equity`',
    `cecl_provision_amount` DECIMAL(18,2) COMMENT 'Allowance for credit losses established under GAAP ASC 326 Current Expected Credit Losses (CECL) methodology for this security.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the impairment record was first created in the system.',
    `credit_loss_component` DECIMAL(18,2) COMMENT 'Portion of the impairment attributable to credit deterioration, recognized in earnings under GAAP ASC 326 CECL.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the impairment amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `gaap_classification` STRING COMMENT 'GAAP accounting classification of the security: held-to-maturity, available-for-sale, or trading.. Valid values are `held_to_maturity|available_for_sale|trading`',
    `impairment_status` STRING COMMENT 'Current workflow status of the impairment assessment: draft, pending review, approved, reversed, or final.. Valid values are `draft|pending_review|approved|reversed|final`',
    `impairment_type` STRING COMMENT 'Classification of the impairment: Other-Than-Temporary Impairment (OTTI), credit loss under ASC 326 Current Expected Credit Losses (CECL), intent to sell, CECL provision, temporary decline, or fair value hedge adjustment. [ENUM-REF-CANDIDATE: OTTI|credit_loss|intent_to_sell|CECL_provision|temporary_decline|fair_value_hedge|market_value_decline — promote to reference product]. Valid values are `OTTI|credit_loss|intent_to_sell|CECL_provision|temporary_decline|fair_value_hedge`',
    `intent_to_sell_flag` BOOLEAN COMMENT 'Indicator of whether management has the intent to sell the security before recovery of its amortized cost basis, triggering full impairment recognition.',
    `investment_committee_decision` STRING COMMENT 'Summary of the investment committees decision regarding the impairment, including any remediation actions or hold/sell decisions.',
    `investment_committee_review_date` DATE COMMENT 'Date on which the investment committee reviewed and approved the impairment assessment.',
    `ldti_credit_loss_assumption` DECIMAL(18,2) COMMENT 'Credit loss assumption rate used in Long Duration Targeted Improvements (LDTI) liability valuation, influenced by this impairment assessment.',
    `more_likely_than_not_sale_flag` BOOLEAN COMMENT 'Indicator of whether it is more likely than not that the entity will be required to sell the security before recovery, per GAAP ASC 320 guidance.',
    `naic_designation_change_flag` BOOLEAN COMMENT 'Indicator of whether the NAIC designation changed as a result of the impairment assessment.',
    `naic_designation_post_impairment` STRING COMMENT 'NAIC designation of the security after the impairment event, reflecting updated credit quality assessment.. Valid values are `1|2|3|4|5|6`',
    `naic_designation_pre_impairment` STRING COMMENT 'NAIC designation of the security before the impairment event, ranging from 1 (highest quality) to 6 (lowest quality).. Valid values are `1|2|3|4|5|6`',
    `naic_schedule_reference` STRING COMMENT 'Reference to the specific NAIC Annual Statement schedule and line item where the impairment is reported (e.g., Schedule D Part 1, Line 10).',
    `non_credit_loss_component` DECIMAL(18,2) COMMENT 'Portion of the impairment attributable to non-credit factors such as interest rate changes or market liquidity, recognized in Other Comprehensive Income (OCI) under GAAP.',
    `notes` STRING COMMENT 'Additional free-form notes or comments regarding the impairment assessment, supporting documentation, or special circumstances.',
    `oci_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount reclassified from accumulated Other Comprehensive Income (OCI) to earnings as part of the impairment recognition.',
    `post_impairment_carrying_value` DECIMAL(18,2) COMMENT 'Adjusted book value or amortized cost of the security after the impairment charge has been applied.',
    `pre_impairment_carrying_value` DECIMAL(18,2) COMMENT 'Book value or amortized cost of the security immediately before the impairment charge was recorded.',
    `rbc_c1_charge_impact` DECIMAL(18,2) COMMENT 'Change in the Risk-Based Capital (RBC) C1 asset risk charge resulting from the impairment and any associated NAIC designation change.',
    `reason` STRING COMMENT 'Detailed narrative explanation of the factors and circumstances leading to the impairment determination, including credit events, market conditions, or management intent.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered subsequent to impairment recognition, representing reversal or partial recovery of previously recognized credit losses.',
    `recovery_date` DATE COMMENT 'Date on which a recovery of previously impaired value was recognized.',
    `regulatory_report_date` DATE COMMENT 'Date on which the impairment was reported to regulatory authorities or included in statutory financial statements.',
    `reversal_flag` BOOLEAN COMMENT 'Indicator of whether this record represents a reversal of a previously recognized impairment.',
    `sap_classification` STRING COMMENT 'Statutory Accounting Principles (SAP) classification of the security for NAIC Annual Statement reporting.. Valid values are `bonds|preferred_stock|common_stock|mortgage_loan|real_estate`',
    `separate_account_flag` BOOLEAN COMMENT 'Indicator of whether the impaired security is held in a separate account supporting variable annuity or variable life products.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the impairment record was last modified.',
    CONSTRAINT pk_impairment PRIMARY KEY(`impairment_id`)
) COMMENT 'Records other-than-temporary impairment (OTTI) and credit loss assessments for investment securities. Captures assessment date, security, impairment type (credit loss, intent to sell, OTTI), pre-impairment carrying value, impairment amount, post-impairment carrying value, credit loss component, non-credit loss component (OCI), recovery amount, NAIC designation impact, and GAAP ASC 326 CECL provision. Supports GAAP/SAP impairment reporting, LDTI credit loss assumptions, and NAIC examination documentation.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`investment_transaction` (
    `investment_transaction_id` BIGINT COMMENT 'Unique identifier for the investment transaction record. Primary key.',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: Investment cash movements and settlement events affect specific asset holdings. The existing position_id semantically refers to asset_holding. Adding explicit asset_holding_id FK and removing position',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty involved in the transaction (e.g., broker-dealer, custodian, borrower, lender).',
    `original_transaction_investment_transaction_id` BIGINT COMMENT 'Reference to the original transaction that this record reverses or corrects, if applicable.',
    `portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio to which this transaction belongs.',
    `security_id` BIGINT COMMENT 'Reference to the security involved in this transaction, if applicable.',
    `trade_id` BIGINT COMMENT 'Reference to the originating trade order that resulted in this transaction, if applicable.',
    `reversal_investment_transaction_id` BIGINT COMMENT 'Self-referencing FK on investment_transaction (reversal_investment_transaction_id)',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The amount of interest that has accumulated on a fixed income security since the last coupon payment date, included in the transaction settlement.',
    `alm_segment` STRING COMMENT 'The ALM segment or liability cohort to which this transaction is allocated for duration matching and interest rate risk management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the transaction is denominated.. Valid values are `^[A-Z]{3}$`',
    `custodian_account_number` STRING COMMENT 'The custodian account identifier where the transaction was processed. Critical for custodian reconciliation.',
    `custodian_reference_number` STRING COMMENT 'The unique reference number assigned by the custodian to this transaction, used for reconciliation and dispute resolution.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees associated with the transaction, including custodian fees, transaction fees, and other charges.',
    `gaap_classification` STRING COMMENT 'Classification of the transaction for GAAP financial reporting purposes under FASB ASC 944.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total amount of the investment transaction before any deductions, fees, or withholdings. Represents the full value of the cash movement.',
    `naic_schedule_line_item` STRING COMMENT 'The specific line item on the NAIC Annual Statement investment schedule where this transaction should be reported.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net cash amount after deducting all fees, taxes, and withholdings from the gross amount. This is the actual cash impact to the portfolio.',
    `notes` STRING COMMENT 'Free-text field for additional context, explanations, or special instructions related to the transaction.',
    `payment_date` DATE COMMENT 'The date on which the payment is scheduled to be made or was actually received by the portfolio.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'The price per unit, share, or par value at which the transaction was executed, if applicable.',
    `product_line` STRING COMMENT 'The insurance product line (e.g., individual life, group annuity, variable universal life) to which investment income from this transaction should be allocated.',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units, shares, or par value involved in the transaction, if applicable to the transaction type.',
    `reconciliation_date` DATE COMMENT 'The date on which the transaction was reconciled with custodian records.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the transaction has been successfully reconciled with custodian records and internal books.. Valid values are `reconciled|unreconciled|pending_review|exception|disputed`',
    `record_date` DATE COMMENT 'The date on which ownership must be established to be entitled to receive the payment (e.g., dividend record date, coupon record date).',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal or correction of a previously recorded transaction.',
    `sap_classification` STRING COMMENT 'Classification of the transaction for statutory accounting and NAIC Annual Statement reporting purposes.',
    `separate_account_flag` BOOLEAN COMMENT 'Indicates whether this transaction pertains to a separate account (variable product) or the general account.',
    `settlement_date` DATE COMMENT 'The date on which the cash movement is settled and funds are transferred between parties. Critical for cash flow tracking and liquidity management.',
    `subtype` STRING COMMENT 'Further granular classification of the transaction type, providing additional detail for specialized transaction categories.',
    `transaction_date` DATE COMMENT 'The date on which the investment transaction event occurred or was initiated. This is the business event date for accounting recognition.',
    `transaction_number` STRING COMMENT 'Externally-known unique business identifier for this investment transaction, used for custodian reconciliation and audit trails.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the investment transaction, tracking its progression from initiation through settlement and reconciliation. [ENUM-REF-CANDIDATE: pending|settled|failed|cancelled|reversed|reconciled|unreconciled — 7 candidates stripped; promote to reference product]',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the investment transaction event occurred, used for intraday sequencing and audit trails.',
    `transaction_type` STRING COMMENT 'Classification of the investment cash movement event. Determines the nature of the transaction for accounting and reporting purposes. [ENUM-REF-CANDIDATE: trade_settlement|coupon_receipt|dividend_receipt|principal_payment|interest_payment|margin_call|collateral_transfer|securities_lending_fee|capital_call|distribution|custodian_fee|redemption|maturity_proceeds — 13 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction record was last modified. Audit trail field.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source from the transaction proceeds, typically applicable to foreign securities or certain domestic income types.',
    CONSTRAINT pk_investment_transaction PRIMARY KEY(`investment_transaction_id`)
) COMMENT 'Records all investment cash movements and settlement events including trade settlements (delivery vs. payment), coupon and dividend receipts, margin calls and collateral transfers, securities lending fee receipts, mortgage loan principal and interest payments, capital calls for alternative assets, and custodian fee debits. Captures transaction date, settlement date, transaction type, amount, currency, counterparty, custodian account, portfolio, related trade or asset reference, and reconciliation status. SSOT for investment cash flow tracking, custodian reconciliation, and statutory investment income/expense reporting.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` (
    `portfolio_segment_id` BIGINT COMMENT 'Primary key for portfolio_segment',
    `liability_segment_id` BIGINT COMMENT 'Reference to the liability segment this portfolio segment is matched against for ALM purposes.',
    `employee_id` BIGINT COMMENT 'Reference to the internal or external investment manager responsible for this portfolio segment.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or system process that last modified this record.',
    `vendor_id` BIGINT COMMENT 'Reference to the custodian bank or institution holding assets for this portfolio segment.',
    `parent_portfolio_segment_id` BIGINT COMMENT 'Self-referencing FK on portfolio_segment (parent_portfolio_segment_id)',
    `accounting_method` STRING COMMENT 'Primary accounting method used for valuation and reporting of this portfolio segment.',
    `asset_class` STRING COMMENT 'Primary asset class category for investments held within this portfolio segment.',
    `benchmark_index` STRING COMMENT 'Primary benchmark index used to measure performance of this portfolio segment.',
    `compliance_monitoring_required` BOOLEAN COMMENT 'Indicates whether this portfolio segment requires active regulatory compliance monitoring.',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of segment assets that can be invested in a single issuer or security.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio segment record was first created in the system.',
    `credit_quality_minimum` STRING COMMENT 'Minimum credit quality rating required for fixed income investments in this segment.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the base currency of the portfolio segment.',
    `portfolio_segment_description` STRING COMMENT 'Detailed description of the portfolio segment purpose, strategy, and characteristics.',
    `effective_date` DATE COMMENT 'Date when the portfolio segment became or will become active and operational.',
    `income_allocation_method` STRING COMMENT 'Method used to allocate investment income from this segment to policy reserves or accounts.',
    `investment_strategy` STRING COMMENT 'Description of the investment strategy and objectives for this portfolio segment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio segment record was last updated.',
    `liquidity_requirement_days` STRING COMMENT 'Number of days within which a specified percentage of segment assets must be liquidatable.',
    `management_fee_basis_points` DECIMAL(18,2) COMMENT 'Annual management fee expressed in basis points charged for managing this portfolio segment.',
    `maximum_allocation_percentage` DECIMAL(18,2) COMMENT 'Maximum allowable allocation percentage for this portfolio segment per investment policy constraints.',
    `minimum_allocation_percentage` DECIMAL(18,2) COMMENT 'Minimum allowable allocation percentage for this portfolio segment per investment policy constraints.',
    `naic_designation_required` BOOLEAN COMMENT 'Indicates whether investments in this segment require NAIC quality designations.',
    `performance_fee_applicable` BOOLEAN COMMENT 'Indicates whether performance-based fees apply to this portfolio segment.',
    `rbc_category` STRING COMMENT 'NAIC Risk-Based Capital category assignment for capital charge calculation.',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the portfolio segment is reviewed and rebalanced to target allocations.',
    `rebalancing_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage deviation from target allocation that triggers a rebalancing action.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification code for statutory reporting and compliance purposes.',
    `risk_profile` STRING COMMENT 'Risk tolerance and profile classification for the portfolio segment.',
    `segment_code` STRING COMMENT 'Business identifier code for the portfolio segment used in external reporting and communications.',
    `segment_name` STRING COMMENT 'Full descriptive name of the portfolio segment.',
    `segment_type` STRING COMMENT 'Classification of the portfolio segment indicating the account structure and investment approach.',
    `portfolio_segment_status` STRING COMMENT 'Current lifecycle status of the portfolio segment.',
    `target_allocation_percentage` DECIMAL(18,2) COMMENT 'Target allocation percentage of total portfolio assets to be held in this segment.',
    `target_duration_years` DECIMAL(18,2) COMMENT 'Target duration in years for Asset Liability Management (ALM) matching objectives.',
    `tax_treatment` STRING COMMENT 'Tax treatment classification for income and gains generated by this portfolio segment.',
    `termination_date` DATE COMMENT 'Date when the portfolio segment was closed or is scheduled to close. Null for open-ended segments.',
    `unit_value_calculation_required` BOOLEAN COMMENT 'Indicates whether unit values must be calculated for variable product policyholder allocations.',
    `valuation_frequency` STRING COMMENT 'Frequency at which fair market value or net asset value is calculated for this segment.',
    CONSTRAINT pk_portfolio_segment PRIMARY KEY(`portfolio_segment_id`)
) COMMENT 'Master reference table for portfolio_segment. Referenced by portfolio_segment_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`tax_lot` (
    `tax_lot_id` BIGINT COMMENT 'Primary key for tax_lot',
    `asset_holding_id` BIGINT COMMENT 'Foreign key linking to investment.asset_holding. Business justification: tax_lot tracks cost basis and tax accounting for investment positions. Each tax lot represents a specific acquisition of a security and must reference the asset_holding (position) it belongs to. tax_l',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio. Business justification: tax_lot currently has account_id (BIGINT) but no portfolio_id. In the investment domain, account is semantically equivalent to portfolio - both refer to the investment account/portfolio that holds',
    `security_id` BIGINT COMMENT 'Reference to the security or asset held in this tax lot (bond, equity, alternative investment).',
    `split_from_tax_lot_id` BIGINT COMMENT 'Self-referencing FK on tax_lot (split_from_tax_lot_id)',
    `acquisition_date` DATE COMMENT 'The date on which the securities in this tax lot were acquired or purchased.',
    `acquisition_method` STRING COMMENT 'The method by which the securities in this tax lot were acquired.',
    `adjusted_cost_basis` DECIMAL(18,2) COMMENT 'The current adjusted cost basis after accounting for amortization, accretion, return of capital, and other adjustments.',
    `alm_duration_contribution` DECIMAL(18,2) COMMENT 'The contribution of this tax lot to the overall portfolio duration for asset-liability management (ALM) duration matching purposes.',
    `amortization_accretion_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of premium amortization or discount accretion applied to the cost basis for fixed income securities.',
    `asset_class` STRING COMMENT 'High-level asset class classification of the security held in this tax lot.',
    `asset_valuation_reserve_amount` DECIMAL(18,2) COMMENT 'The amount allocated to the Asset Valuation Reserve for this tax lot to provide a reserve against potential investment losses.',
    `book_value` DECIMAL(18,2) COMMENT 'The statutory book value of this tax lot as reported on the NAIC Annual Statement Schedule D, which may differ from adjusted cost basis due to statutory accounting rules.',
    `cost_basis_method` STRING COMMENT 'The accounting method used to determine which tax lots are disposed when securities are sold (FIFO, LIFO, specific identification, average cost, HIFO).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax lot record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the currency in which this tax lot is denominated.',
    `current_market_value` DECIMAL(18,2) COMMENT 'The current fair market value (FMV) or net asset value (NAV) of the securities in this tax lot based on the most recent valuation.',
    `current_quantity` DECIMAL(18,2) COMMENT 'The current remaining number of units or shares in this tax lot after any partial disposals or adjustments.',
    `custodian_code` STRING COMMENT 'Code identifying the custodian bank or institution holding the physical or electronic securities for this tax lot.',
    `disposal_date` DATE COMMENT 'The date on which the securities in this tax lot were fully disposed or sold. Null if the lot is still open.',
    `disposal_method` STRING COMMENT 'The method by which the securities in this tax lot were disposed. Null if the lot is still open.',
    `holding_period_type` STRING COMMENT 'Classification of the holding period for tax purposes: short-term (held one year or less) or long-term (held more than one year).',
    `interest_maintenance_reserve_amount` DECIMAL(18,2) COMMENT 'The amount allocated to the Interest Maintenance Reserve for this tax lot to defer realized capital gains and losses on fixed income securities sold before maturity.',
    `investment_strategy_code` STRING COMMENT 'Code identifying the investment strategy or mandate under which this tax lot was acquired (e.g., core fixed income, growth equity, ALM matching).',
    `lot_number` STRING COMMENT 'Business identifier for the tax lot, typically assigned sequentially or by acquisition date for tracking purposes.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the tax lot indicating whether it is still held, fully disposed, or partially disposed.',
    `naic_designation` STRING COMMENT 'NAIC credit quality designation assigned to the security for regulatory capital (RBC) calculation purposes (e.g., NAIC 1, NAIC 2).',
    `original_cost_basis` DECIMAL(18,2) COMMENT 'The total original cost basis of the securities in this tax lot at acquisition, including purchase price and transaction costs.',
    `original_quantity` DECIMAL(18,2) COMMENT 'The original number of units or shares acquired in this tax lot at acquisition date.',
    `portfolio_segment` STRING COMMENT 'Classification of the portfolio segment to which this tax lot belongs (general account, separate account fixed, separate account variable, alternatives).',
    `rbc_factor` DECIMAL(18,2) COMMENT 'The risk-based capital factor applied to this tax lot for calculating the C-1 investment risk charge under NAIC RBC requirements.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'The realized gain or loss recognized upon disposal of the securities in this tax lot. Null if the lot is still open.',
    `return_of_capital_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of return of capital distributions received that reduce the cost basis of this tax lot.',
    `settlement_date` DATE COMMENT 'The settlement date of the original acquisition transaction for this tax lot, when ownership and payment were exchanged.',
    `source_system_code` STRING COMMENT 'Code identifying the source system of record from which this tax lot data originated (e.g., investment accounting system, portfolio management system).',
    `statement_value` DECIMAL(18,2) COMMENT 'The statutory statement value of this tax lot for regulatory reporting, calculated per NAIC valuation rules.',
    `trade_confirmation_number` STRING COMMENT 'The trade confirmation or ticket number from the original acquisition transaction that created this tax lot.',
    `unit_cost_basis` DECIMAL(18,2) COMMENT 'The per-unit or per-share cost basis, calculated as adjusted cost basis divided by current quantity.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The unrealized gain or loss on this tax lot, calculated as current market value minus adjusted cost basis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax lot record was last updated in the system.',
    `valuation_date` DATE COMMENT 'The date as of which the current market value and unrealized gain/loss were calculated for this tax lot.',
    `wash_sale_disallowed_loss` DECIMAL(18,2) COMMENT 'The amount of loss disallowed due to wash sale rules, which is added to the cost basis of the replacement securities.',
    `wash_sale_indicator` BOOLEAN COMMENT 'Flag indicating whether this tax lot is subject to wash sale rules, which disallow loss recognition if substantially identical securities are purchased within 30 days before or after the sale.',
    CONSTRAINT pk_tax_lot PRIMARY KEY(`tax_lot_id`)
) COMMENT 'Master reference table for tax_lot. Referenced by tax_lot_id.';

CREATE OR REPLACE TABLE `life_insurance_ecm`.`investment`.`benchmark` (
    `benchmark_id` BIGINT COMMENT 'Primary key for benchmark',
    `composite_benchmark_id` BIGINT COMMENT 'Self-referencing FK on benchmark (composite_benchmark_id)',
    `alm_usage_flag` BOOLEAN COMMENT 'Indicates whether this benchmark is used for Asset Liability Management (ALM) duration matching and portfolio management (True/False).',
    `average_maturity_years` DECIMAL(18,2) COMMENT 'Weighted average maturity of securities in the benchmark, applicable for fixed income benchmarks.',
    `base_currency` STRING COMMENT 'Three-letter ISO currency code in which the benchmark is denominated (e.g., USD, EUR, GBP).',
    `benchmark_category` STRING COMMENT 'Secondary classification by market scope (broad market, sector-specific, regional, global, domestic, international).',
    `benchmark_code` STRING COMMENT 'Externally-known unique code for the benchmark (e.g., S&P500, RUSSELL2000, MSCI_WORLD). Used for identification in investment systems and reporting.',
    `benchmark_name` STRING COMMENT 'Full descriptive name of the benchmark (e.g., S&P 500 Index, Russell 2000 Index, MSCI World Index).',
    `benchmark_type` STRING COMMENT 'Classification of the benchmark by asset class (equity, fixed income, balanced, alternative, commodity, real estate).',
    `bloomberg_ticker` STRING COMMENT 'Bloomberg ticker symbol for the benchmark used in Bloomberg Terminal and data feeds.',
    `constituent_count` STRING COMMENT 'Number of securities or holdings included in the benchmark composition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark record was first created in the system.',
    `credit_quality_rating` STRING COMMENT 'Average credit quality or rating profile of the benchmark constituents for fixed income benchmarks (e.g., AAA, AA, A, BBB, High Yield).',
    `cusip` STRING COMMENT 'CUSIP identifier for the benchmark if applicable (primarily for US securities).',
    `data_source` STRING COMMENT 'Primary data source or vendor from which benchmark values and constituent data are obtained (e.g., Bloomberg, Refinitiv, direct from provider).',
    `benchmark_description` STRING COMMENT 'Detailed textual description of the benchmark, its methodology, and its intended use cases.',
    `dividend_yield_percent` DECIMAL(18,2) COMMENT 'Current dividend yield of the benchmark expressed as a percentage, applicable for equity benchmarks.',
    `duration_years` DECIMAL(18,2) COMMENT 'Average duration of the benchmark in years, applicable for fixed income benchmarks. Measures interest rate sensitivity.',
    `effective_date` DATE COMMENT 'Date from which this benchmark record is effective and valid for use in investment reporting and analysis.',
    `expiration_date` DATE COMMENT 'Date when this benchmark record expires or is no longer valid for use. Null for currently active benchmarks.',
    `geographic_focus` STRING COMMENT 'Geographic region or market that the benchmark covers (e.g., North America, Europe, Asia Pacific, Emerging Markets, Global).',
    `inception_date` DATE COMMENT 'Date when the benchmark was first established and began tracking performance.',
    `index_family` STRING COMMENT 'Name of the broader index family or series to which this benchmark belongs (e.g., S&P Indices, MSCI World Series, Russell US Indices).',
    `isin` STRING COMMENT 'International Securities Identification Number (ISIN) for the benchmark if applicable.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the benchmark reference data was last updated in the system.',
    `market_capitalization_usd` DECIMAL(18,2) COMMENT 'Total market capitalization of all benchmark constituents in USD, applicable for equity benchmarks.',
    `market_segment` STRING COMMENT 'Specific market segment or sector focus of the benchmark (e.g., Large Cap, Small Cap, Growth, Value, Technology, Healthcare).',
    `methodology_url` STRING COMMENT 'Web URL link to the official benchmark methodology documentation published by the provider.',
    `naic_designation` STRING COMMENT 'NAIC designation or classification applicable to this benchmark for regulatory reporting and compliance monitoring.',
    `performance_attribution_flag` BOOLEAN COMMENT 'Indicates whether this benchmark is used for investment performance attribution analysis (True/False).',
    `price_to_earnings_ratio` DECIMAL(18,2) COMMENT 'Weighted average price-to-earnings ratio of the benchmark constituents, applicable for equity benchmarks.',
    `provider_code` STRING COMMENT 'Standardized code for the benchmark provider (e.g., SPDJI, MSCI, FTSE, BBGB).',
    `provider_name` STRING COMMENT 'Name of the organization that publishes and maintains the benchmark (e.g., S&P Dow Jones Indices, MSCI, FTSE Russell, Bloomberg Barclays).',
    `rbc_applicable_flag` BOOLEAN COMMENT 'Indicates whether this benchmark is used for Risk-Based Capital (RBC) investment risk charge calculations (True/False).',
    `rebalance_frequency` STRING COMMENT 'How often the benchmark composition is reviewed and rebalanced (daily, weekly, monthly, quarterly, semi-annual, annual).',
    `return_calculation_method` STRING COMMENT 'Method used to calculate benchmark returns (price return only, total return including dividends, net return after fees, gross return before fees).',
    `reuters_ric` STRING COMMENT 'Reuters Instrument Code (RIC) for the benchmark used in Refinitiv data systems.',
    `sedol` STRING COMMENT 'SEDOL identifier for the benchmark if applicable (primarily for UK securities).',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of the benchmark (active, inactive, discontinued, suspended).',
    `variable_product_flag` BOOLEAN COMMENT 'Indicates whether this benchmark is used for variable annuity or variable life product unit value calculations (True/False).',
    `weighting_methodology` STRING COMMENT 'Method used to weight constituent securities within the benchmark (market capitalization, equal weight, fundamental, factor-based, custom).',
    `yield_to_maturity_percent` DECIMAL(18,2) COMMENT 'Current yield to maturity of the benchmark expressed as a percentage, applicable for fixed income benchmarks.',
    CONSTRAINT pk_benchmark PRIMARY KEY(`benchmark_id`)
) COMMENT 'Master reference table for benchmark. Referenced by benchmark_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ADD CONSTRAINT `fk_investment_portfolio_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `life_insurance_ecm`.`investment`.`benchmark`(`benchmark_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_alternative_asset_id` FOREIGN KEY (`alternative_asset_id`) REFERENCES `life_insurance_ecm`.`investment`.`alternative_asset`(`alternative_asset_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_mortgage_loan_id` FOREIGN KEY (`mortgage_loan_id`) REFERENCES `life_insurance_ecm`.`investment`.`mortgage_loan`(`mortgage_loan_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ADD CONSTRAINT `fk_investment_asset_holding_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ADD CONSTRAINT `fk_investment_trade_trade_counterparty_id` FOREIGN KEY (`trade_counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ADD CONSTRAINT `fk_investment_trade_execution_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ADD CONSTRAINT `fk_investment_trade_execution_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ADD CONSTRAINT `fk_investment_trade_execution_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ADD CONSTRAINT `fk_investment_trade_execution_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ADD CONSTRAINT `fk_investment_valuation_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ADD CONSTRAINT `fk_investment_unit_value_separate_account_id` FOREIGN KEY (`separate_account_id`) REFERENCES `life_insurance_ecm`.`investment`.`separate_account`(`separate_account_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_original_income_income_allocation_id` FOREIGN KEY (`original_income_income_allocation_id`) REFERENCES `life_insurance_ecm`.`investment`.`income_allocation`(`income_allocation_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ADD CONSTRAINT `fk_investment_income_allocation_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `life_insurance_ecm`.`investment`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ADD CONSTRAINT `fk_investment_alm_analysis_portfolio_segment_id` FOREIGN KEY (`portfolio_segment_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio_segment`(`portfolio_segment_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ADD CONSTRAINT `fk_investment_alm_gap_measurement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `life_insurance_ecm`.`investment`.`guideline`(`guideline_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ADD CONSTRAINT `fk_investment_compliance_rule_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_compliance_rule_id` FOREIGN KEY (`compliance_rule_id`) REFERENCES `life_insurance_ecm`.`investment`.`compliance_rule`(`compliance_rule_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ADD CONSTRAINT `fk_investment_compliance_breach_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ADD CONSTRAINT `fk_investment_performance_attribution_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `life_insurance_ecm`.`investment`.`benchmark`(`benchmark_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ADD CONSTRAINT `fk_investment_performance_attribution_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ADD CONSTRAINT `fk_investment_credit_default_rate_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ADD CONSTRAINT `fk_investment_credit_default_rate_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ADD CONSTRAINT `fk_investment_credit_default_rate_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ADD CONSTRAINT `fk_investment_risk_charge_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ADD CONSTRAINT `fk_investment_mortgage_loan_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ADD CONSTRAINT `fk_investment_alternative_asset_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ADD CONSTRAINT `fk_investment_alternative_asset_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_broker_dealer_counterparty_id` FOREIGN KEY (`broker_dealer_counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ADD CONSTRAINT `fk_investment_derivative_contract_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ADD CONSTRAINT `fk_investment_derivative_valuation_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ADD CONSTRAINT `fk_investment_derivative_valuation_derivative_contract_id` FOREIGN KEY (`derivative_contract_id`) REFERENCES `life_insurance_ecm`.`investment`.`derivative_contract`(`derivative_contract_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ADD CONSTRAINT `fk_investment_derivative_valuation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ADD CONSTRAINT `fk_investment_guideline_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ADD CONSTRAINT `fk_investment_guideline_superseded_guideline_id` FOREIGN KEY (`superseded_guideline_id`) REFERENCES `life_insurance_ecm`.`investment`.`guideline`(`guideline_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ADD CONSTRAINT `fk_investment_asset_allocation_guideline_id` FOREIGN KEY (`guideline_id`) REFERENCES `life_insurance_ecm`.`investment`.`guideline`(`guideline_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ADD CONSTRAINT `fk_investment_asset_allocation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ADD CONSTRAINT `fk_investment_securities_lending_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ADD CONSTRAINT `fk_investment_securities_lending_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ADD CONSTRAINT `fk_investment_securities_lending_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ADD CONSTRAINT `fk_investment_securities_lending_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_original_event_gain_loss_event_id` FOREIGN KEY (`original_event_gain_loss_event_id`) REFERENCES `life_insurance_ecm`.`investment`.`gain_loss_event`(`gain_loss_event_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `life_insurance_ecm`.`investment`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ADD CONSTRAINT `fk_investment_gain_loss_event_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ADD CONSTRAINT `fk_investment_impairment_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ADD CONSTRAINT `fk_investment_impairment_original_impairment_id` FOREIGN KEY (`original_impairment_id`) REFERENCES `life_insurance_ecm`.`investment`.`impairment`(`impairment_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ADD CONSTRAINT `fk_investment_impairment_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ADD CONSTRAINT `fk_investment_impairment_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `life_insurance_ecm`.`investment`.`counterparty`(`counterparty_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_original_transaction_investment_transaction_id` FOREIGN KEY (`original_transaction_investment_transaction_id`) REFERENCES `life_insurance_ecm`.`investment`.`investment_transaction`(`investment_transaction_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `life_insurance_ecm`.`investment`.`trade`(`trade_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ADD CONSTRAINT `fk_investment_investment_transaction_reversal_investment_transaction_id` FOREIGN KEY (`reversal_investment_transaction_id`) REFERENCES `life_insurance_ecm`.`investment`.`investment_transaction`(`investment_transaction_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ADD CONSTRAINT `fk_investment_portfolio_segment_parent_portfolio_segment_id` FOREIGN KEY (`parent_portfolio_segment_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio_segment`(`portfolio_segment_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ADD CONSTRAINT `fk_investment_tax_lot_asset_holding_id` FOREIGN KEY (`asset_holding_id`) REFERENCES `life_insurance_ecm`.`investment`.`asset_holding`(`asset_holding_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ADD CONSTRAINT `fk_investment_tax_lot_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `life_insurance_ecm`.`investment`.`portfolio`(`portfolio_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ADD CONSTRAINT `fk_investment_tax_lot_security_id` FOREIGN KEY (`security_id`) REFERENCES `life_insurance_ecm`.`investment`.`security`(`security_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ADD CONSTRAINT `fk_investment_tax_lot_split_from_tax_lot_id` FOREIGN KEY (`split_from_tax_lot_id`) REFERENCES `life_insurance_ecm`.`investment`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `life_insurance_ecm`.`investment`.`benchmark` ADD CONSTRAINT `fk_investment_benchmark_composite_benchmark_id` FOREIGN KEY (`composite_benchmark_id`) REFERENCES `life_insurance_ecm`.`investment`.`benchmark`(`benchmark_id`);

-- ========= TAGS =========
ALTER SCHEMA `life_insurance_ecm`.`investment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `life_insurance_ecm`.`investment` SET TAGS ('dbx_domain' = 'investment');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Assignment - Employee Id');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `group_sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Group Sponsor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `liability_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Segment ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `segment_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `separate_account_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Variable Product Fund ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `actual_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Actual Portfolio Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `actual_market_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Portfolio Market Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `actual_market_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `alm_classification` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `alm_classification` SET TAGS ('dbx_value_regex' = 'duration_matched|liability_driven|surplus|liquidity_reserve|variable_product_support');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'fixed_income|equity|alternative|real_estate|cash_equivalent|multi_asset');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `assignment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `benchmark_ytd_pct` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Year-to-Date (YTD) Return Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `cdr_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Conditional Default Rate (CDR) Tracking Enabled');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Closure Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Inception Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `investment_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Approval Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `investment_income_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Investment Income Allocation Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `investment_income_allocation_method` SET TAGS ('dbx_value_regex' = 'direct_attribution|pro_rata|segmented|pooled');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `investment_mandate` SET TAGS ('dbx_business_glossary_term' = 'Investment Mandate');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Compliance Status Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Portfolio Compliance Check Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `last_rebalancing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Portfolio Rebalancing Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `manager_role` SET TAGS ('dbx_business_glossary_term' = 'Manager Role');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `max_single_issuer_concentration_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Single Issuer Concentration Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `min_credit_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Quality Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `min_credit_quality_rating` SET TAGS ('dbx_value_regex' = '^(AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC|CC|C|D|NR)$');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `naic_schedule_classification` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `naic_schedule_classification` SET TAGS ('dbx_value_regex' = 'schedule_d|schedule_e|schedule_ba|schedule_b|schedule_a');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `performance_ytd_pct` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Year-to-Date (YTD) Performance Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_name` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_status` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|closed|suspended');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'general_account|separate_account|variable_product|alternative_asset|reinsurance_trust');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `primary_manager_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Manager Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `rbc_charge_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `rbc_charge_category` SET TAGS ('dbx_value_regex' = 'c1_asset_risk|c2_insurance_risk|c3_interest_rate_risk|c4_business_risk');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Rebalancing Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|trigger_based');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `rebalancing_trigger_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Threshold Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `risk_tolerance_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Tier');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `risk_tolerance_tier` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `strategic_alternative_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Strategic Asset Allocation (SAA) Alternative Assets Target Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `strategic_equity_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Strategic Asset Allocation (SAA) Equity Target Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `strategic_fixed_income_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Strategic Asset Allocation (SAA) Fixed Income Target Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `tactical_equity_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Tactical Asset Allocation (TAA) Equity Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `tactical_fixed_income_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Tactical Asset Allocation (TAA) Fixed Income Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `target_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Target Portfolio Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Valuation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `alternative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `mortgage_loan_id` SET TAGS ('dbx_business_glossary_term' = 'Mortgage Loan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `contract_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Policyholder Contract Owner Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `statutory_exhibit_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Exhibit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (General Account / Separate Account)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'general_account|separate_account');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `amortized_cost` SET TAGS ('dbx_business_glossary_term' = 'Amortized Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `amortized_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `amortized_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `as_of_date` SET TAGS ('dbx_business_glossary_term' = 'As-Of Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `asset_subtype` SET TAGS ('dbx_business_glossary_term' = 'Asset Subtype');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Book Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `book_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `convexity` SET TAGS ('dbx_business_glossary_term' = 'Convexity');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_business_glossary_term' = 'Coupon Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|at_maturity|zero_coupon');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `dividend_rate` SET TAGS ('dbx_business_glossary_term' = 'Dividend Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `duration_years` SET TAGS ('dbx_business_glossary_term' = 'Modified Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `fair_market_value` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `fair_market_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `fair_market_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_value_regex' = 'active|sold|matured|defaulted|written_off');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `impairment_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `is_144a_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rule 144A Eligible Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `is_private_placement` SET TAGS ('dbx_business_glossary_term' = 'Private Placement Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `issuer_sector` SET TAGS ('dbx_business_glossary_term' = 'Issuer Sector / Industry Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'liquid|semi_liquid|illiquid|locked_up');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `naic_designation` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `naic_rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Risk-Based Capital (RBC) Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `naic_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `naic_schedule_code` SET TAGS ('dbx_value_regex' = 'D-1|D-2|E|BA|B');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `par_value` SET TAGS ('dbx_business_glossary_term' = 'Par Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `par_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `par_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity / Units Held');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `rating_agency` SET TAGS ('dbx_value_regex' = 'Moodys|SP|Fitch|DBRS|Kroll|AM_Best');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain / Loss');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_holding` ALTER COLUMN `yield_to_maturity` SET TAGS ('dbx_business_glossary_term' = 'Yield to Maturity (YTM)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `report_line_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Line Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'fixed_income|equity|alternative|cash_equivalent|real_estate|derivative');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'First Call Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `call_price` SET TAGS ('dbx_business_glossary_term' = 'Call Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `cdr_rate` SET TAGS ('dbx_business_glossary_term' = 'Conditional Default Rate (CDR)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `convertible_flag` SET TAGS ('dbx_business_glossary_term' = 'Convertible Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `convexity` SET TAGS ('dbx_business_glossary_term' = 'Convexity');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_business_glossary_term' = 'Coupon Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|at_maturity');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|zero_coupon|step_up|payment_in_kind|variable');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{9}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = '30_360|actual_360|actual_365|actual_actual');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `duration_years` SET TAGS ('dbx_business_glossary_term' = 'Modified Duration (Years)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code (MIC)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `exchange_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `first_coupon_date` SET TAGS ('dbx_business_glossary_term' = 'First Coupon Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `fitch_rating` SET TAGS ('dbx_business_glossary_term' = 'Fitch Credit Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `gics_industry_group` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Industry Group');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `gics_sector` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Sector');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `issuer_country` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country of Domicile');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `issuer_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `issuer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuer Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `moodys_rating` SET TAGS ('dbx_business_glossary_term' = 'Moodys Credit Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `naic_designation` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `naic_designation_modifier` SET TAGS ('dbx_business_glossary_term' = 'NAIC Designation Modifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `naic_designation_modifier` SET TAGS ('dbx_value_regex' = 'E|*|');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `par_value` SET TAGS ('dbx_business_glossary_term' = 'Par Value (Face Value)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `prepayment_speed` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Speed (PSA/CPR)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `private_placement_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Placement Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `putable_flag` SET TAGS ('dbx_business_glossary_term' = 'Putable Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `rule_144a_flag` SET TAGS ('dbx_business_glossary_term' = 'Rule 144A Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `sec_registration_status` SET TAGS ('dbx_business_glossary_term' = 'SEC Registration Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `sec_registration_status` SET TAGS ('dbx_value_regex' = 'registered|exempt|144a|regulation_s|unregistered');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `security_name` SET TAGS ('dbx_business_glossary_term' = 'Security Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `security_status` SET TAGS ('dbx_business_glossary_term' = 'Security Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `security_status` SET TAGS ('dbx_value_regex' = 'active|inactive|matured|called|defaulted|suspended');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `security_type` SET TAGS ('dbx_business_glossary_term' = 'Security Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL) Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{7}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `sp_rating` SET TAGS ('dbx_business_glossary_term' = 'S&P Global Credit Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `spread_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Spread Over Benchmark (Basis Points)');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Ticker Symbol');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,10}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`security` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` SET TAGS ('dbx_subdomain' = 'trading_operations');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `report_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Report Exception Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `suitability_review_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Review Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Counterparty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `trade_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `alm_duration_impact` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Duration Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `broker_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Broker Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|securities|letter_of_credit');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `executed_price` SET TAGS ('dbx_business_glossary_term' = 'Executed Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `executed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Executed Quantity');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `execution_venue` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `lending_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Lending Fee Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `limit_price` SET TAGS ('dbx_business_glossary_term' = 'Limit Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_price_type` SET TAGS ('dbx_business_glossary_term' = 'Order Price Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_price_type` SET TAGS ('dbx_value_regex' = 'market|limit|stop|stop_limit');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'buy|sell|short|cover|securities_lending|securities_recall');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `post_trade_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Post-Trade Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `post_trade_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Trade Compliance Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `post_trade_compliance_status` SET TAGS ('dbx_value_regex' = 'passed|failed|under_review');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `pre_trade_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trade Compliance Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `pre_trade_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trade Compliance Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `pre_trade_compliance_status` SET TAGS ('dbx_value_regex' = 'passed|failed|override|not_required');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Trade Rationale');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `rbc_investment_risk_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Investment Risk Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `reinvestment_details` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Details');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `securities_lending_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities Lending Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `stop_price` SET TAGS ('dbx_business_glossary_term' = 'Stop Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `total_transaction_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `transaction_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` SET TAGS ('dbx_subdomain' = 'trading_operations');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Execution Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Order Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'pro_rata|fifo|lifo|specific_lot|average_cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `alm_bucket` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Bucket');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|derivative|alternative|cash_equivalent|real_estate');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `average_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Average Price Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `best_execution_flag` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `block_trade_flag` SET TAGS ('dbx_business_glossary_term' = 'Block Trade Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `compliance_check_result` SET TAGS ('dbx_business_glossary_term' = 'Post-Trade Compliance Check Result');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `compliance_check_result` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|pending|override_approved');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `compliance_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Violated');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Broker-Dealer Confirmation Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `executed_price` SET TAGS ('dbx_business_glossary_term' = 'Executed Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `executed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Executed Quantity');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `execution_capacity` SET TAGS ('dbx_business_glossary_term' = 'Execution Capacity');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `execution_capacity` SET TAGS ('dbx_value_regex' = 'principal|agency|riskless_principal|mixed');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `execution_method` SET TAGS ('dbx_business_glossary_term' = 'Execution Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `execution_method` SET TAGS ('dbx_value_regex' = 'electronic|manual|algorithmic|voice|direct_market_access');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Execution Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `price_improvement_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Improvement Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `time_in_force` SET TAGS ('dbx_business_glossary_term' = 'Time In Force');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `time_in_force` SET TAGS ('dbx_value_regex' = 'day|good_till_cancel|immediate_or_cancel|fill_or_kill|good_till_date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_side` SET TAGS ('dbx_business_glossary_term' = 'Trade Side');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_side` SET TAGS ('dbx_value_regex' = 'buy|sell|short_sell|cover');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_venue` SET TAGS ('dbx_business_glossary_term' = 'Trade Venue');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `trade_venue` SET TAGS ('dbx_value_regex' = 'exchange|otc|dark_pool|crossing_network|dealer|direct');
ALTER TABLE `life_insurance_ecm`.`investment`.`trade_execution` ALTER COLUMN `transaction_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `amortized_cost` SET TAGS ('dbx_business_glossary_term' = 'Amortized Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `ask_price` SET TAGS ('dbx_business_glossary_term' = 'Ask Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `collateral_balance` SET TAGS ('dbx_business_glossary_term' = 'Collateral Balance');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `cva` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `delta` SET TAGS ('dbx_business_glossary_term' = 'Delta (Option Greek)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `dv01` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of One Basis Point (DV01)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `dva` SET TAGS ('dbx_business_glossary_term' = 'Debit Valuation Adjustment (DVA)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level (ASC 820)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'Level 1|Level 2|Level 3');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `fmv_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Per Unit');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `gamma` SET TAGS ('dbx_business_glossary_term' = 'Gamma (Option Greek)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `hedge_effectiveness_test_result` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Result (ASC 815)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `hedge_effectiveness_test_result` SET TAGS ('dbx_value_regex' = 'Highly Effective|Not Effective|Not Applicable');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `market_value_including_accrued` SET TAGS ('dbx_business_glossary_term' = 'Market Value Including Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `mid_price` SET TAGS ('dbx_business_glossary_term' = 'Mid Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `model_used` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model Used');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `naic_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Valuation Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `naic_valuation_method` SET TAGS ('dbx_value_regex' = 'Market|Amortized Cost|Fair Value Option|Equity Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `nav_per_share` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Per Share');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `price_source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Price Source Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'Market Quote|Model Valuation|Matrix Pricing|Broker Quote|NAV|Amortized Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Position Quantity');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `rbc_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `theta` SET TAGS ('dbx_business_glossary_term' = 'Theta (Option Greek)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `total_fmv` SET TAGS ('dbx_business_glossary_term' = 'Total Fair Market Value (FMV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'Final|Preliminary|Pending Review|Adjusted|Rejected');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `variation_margin_call` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Call');
ALTER TABLE `life_insurance_ecm`.`investment`.`valuation` ALTER COLUMN `vega` SET TAGS ('dbx_business_glossary_term' = 'Vega (Option Greek)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `policy_form_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Form Approval Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `producer_id` SET TAGS ('dbx_business_glossary_term' = 'Producer Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `rate_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Sub Adviser Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `account_short_name` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Short Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `accumulation_unit_value` SET TAGS ('dbx_business_glossary_term' = 'Accumulation Unit Value (AUV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `annuity_unit_value` SET TAGS ('dbx_business_glossary_term' = 'Annuity Unit Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `assumed_investment_return` SET TAGS ('dbx_business_glossary_term' = 'Assumed Investment Return (AIR)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Closure Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `daily_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Return Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Expense Ratio');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `finra_oversight_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Oversight Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `guaranteed_benefit_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Benefit Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Inception Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `maximum_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `minimum_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Allocation Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `mortality_and_expense_charge` SET TAGS ('dbx_business_glossary_term' = 'Mortality and Expense (M&E) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `naic_investment_category` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Investment Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `pricing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `prospectus_date` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `rbc_investment_risk_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Investment Risk Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `sec_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registered Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `sec_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registration Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `sec_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{5}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `separate_account_status` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `separate_account_status` SET TAGS ('dbx_value_regex' = 'active|closed_to_new|suspended|liquidating|terminated');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `total_nav` SET TAGS ('dbx_business_glossary_term' = 'Total Net Asset Value (NAV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `transfer_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `units_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Units Outstanding');
ALTER TABLE `life_insurance_ecm`.`investment`.`separate_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `unit_value_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Value ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `annuitant_id` SET TAGS ('dbx_business_glossary_term' = 'Annuitant Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `separate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Separate Account ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `accumulation_unit_value` SET TAGS ('dbx_business_glossary_term' = 'Accumulation Unit Value (AUV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `administrative_charge` SET TAGS ('dbx_business_glossary_term' = 'Administrative Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `annuity_unit_value` SET TAGS ('dbx_business_glossary_term' = 'Annuity Unit Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `daily_return` SET TAGS ('dbx_business_glossary_term' = 'Daily Return');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `finra_reporting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Reporting Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `fund_expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Fund Expense Ratio');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `gmdb_benefit_base_factor` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Death Benefit (GMDB) Benefit Base Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `gmib_benefit_base_factor` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Income Benefit (GMIB) Benefit Base Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `gmwb_benefit_base_factor` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Withdrawal Benefit (GMWB) Benefit Base Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Inception Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `inception_to_date_return` SET TAGS ('dbx_business_glossary_term' = 'Inception-to-Date Return');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `inception_unit_value` SET TAGS ('dbx_business_glossary_term' = 'Inception Unit Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `mortality_and_expense_charge` SET TAGS ('dbx_business_glossary_term' = 'Mortality and Expense (M&E) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `nav_per_share` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Per Share');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `price_source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Price Source Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'market_close|fair_value|model_based|vendor_quote|matrix_pricing');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `prior_day_unit_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Day Unit Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `rider_charge` SET TAGS ('dbx_business_glossary_term' = 'Rider Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `sec_filing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Filing Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `total_expense_deduction` SET TAGS ('dbx_business_glossary_term' = 'Total Expense Deduction');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `total_net_assets` SET TAGS ('dbx_business_glossary_term' = 'Total Net Assets');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `unit_value_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Value Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `unit_value_status` SET TAGS ('dbx_value_regex' = 'final|preliminary|adjusted|suspended|pending_approval|rejected');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `units_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Units Outstanding');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`unit_value` ALTER COLUMN `year_to_date_return` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Return');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Income Allocation Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `original_income_income_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Investment Income ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `report_line_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Line Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'policy_reserve|surplus|separate_account|general_account|unallocated');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Amortization Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|effective_interest|scientific');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `ex_dividend_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Dividend Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `gaap_income_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Income Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `gross_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Income Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_notes` SET TAGS ('dbx_business_glossary_term' = 'Income Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Income Recognition Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_recognition_method` SET TAGS ('dbx_value_regex' = 'accrual|cash|modified_cash');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_status` SET TAGS ('dbx_business_glossary_term' = 'Income Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_status` SET TAGS ('dbx_value_regex' = 'accrued|received|pending|reversed|adjusted');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_subtype` SET TAGS ('dbx_business_glossary_term' = 'Income Subtype');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_type` SET TAGS ('dbx_business_glossary_term' = 'Income Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `income_type` SET TAGS ('dbx_value_regex' = 'interest|dividend|rental|partnership|securities_lending_fee|amortization_premium_discount');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `investment_income_due` SET TAGS ('dbx_business_glossary_term' = 'Investment Income Due (IID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `naic_designation` SET TAGS ('dbx_value_regex' = '^[1-6][A-Z]?$');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `net_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Income Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `sap_income_classification` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Income Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `schedule_d_line_item` SET TAGS ('dbx_business_glossary_term' = 'Schedule D Line Item');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `separate_account_code` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `unit_value_impact` SET TAGS ('dbx_business_glossary_term' = 'Unit Value Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`income_allocation` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `alm_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Alm Analysis Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `cohort_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Cohort Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `orsa_report_id` SET TAGS ('dbx_business_glossary_term' = 'Orsa Report Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `portfolio_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Segment Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Run Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `alm_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Committee Decision');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `alm_committee_decision` SET TAGS ('dbx_value_regex' = 'approved|escalated|remediation_plan_required|monitoring_continued');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `alm_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Committee Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `alm_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Strategy Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `alm_strategy_type` SET TAGS ('dbx_value_regex' = 'immunization|cash_flow_matching|dynamic_hedging|duration_matching|hybrid');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `asset_duration` SET TAGS ('dbx_business_glossary_term' = 'Asset Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `convexity_gap` SET TAGS ('dbx_business_glossary_term' = 'Convexity Gap');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `dollar_duration` SET TAGS ('dbx_business_glossary_term' = 'Dollar Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `duration_band_maximum` SET TAGS ('dbx_business_glossary_term' = 'Duration Band Maximum');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `duration_band_minimum` SET TAGS ('dbx_business_glossary_term' = 'Duration Band Minimum');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `duration_gap` SET TAGS ('dbx_business_glossary_term' = 'Duration Gap');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `dv01` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of One Basis Point (DV01)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'within_tolerance|breach_minor|breach_major|under_review|remediation_required');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `interest_rate_sensitivity_parallel_shift_down_100bp` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Sensitivity Parallel Shift Down 100 Basis Points (bp)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `interest_rate_sensitivity_parallel_shift_up_100bp` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Sensitivity Parallel Shift Up 100 Basis Points (bp)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `interest_rate_sensitivity_twist_flattening` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Sensitivity Twist Flattening');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `interest_rate_sensitivity_twist_steepening` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Sensitivity Twist Steepening');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `key_rate_duration_10yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration (KRD) 10-Year');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `key_rate_duration_1yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration (KRD) 1-Year');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `key_rate_duration_20yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration (KRD) 20-Year');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `key_rate_duration_30yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration (KRD) 30-Year');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `key_rate_duration_5yr` SET TAGS ('dbx_business_glossary_term' = 'Key Rate Duration (KRD) 5-Year');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `liability_duration` SET TAGS ('dbx_business_glossary_term' = 'Liability Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `orsa_interest_rate_risk_scenario` SET TAGS ('dbx_business_glossary_term' = 'Own Risk and Solvency Assessment (ORSA) Interest Rate Risk Scenario');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `rbc_c3_interest_rate_risk_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C-3 Interest Rate Risk Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `remediation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Description');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `target_convexity` SET TAGS ('dbx_business_glossary_term' = 'Target Convexity');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `target_duration` SET TAGS ('dbx_business_glossary_term' = 'Target Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `alm_gap_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Gap Measurement ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `report_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Report Definition Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `alm_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Committee Decision');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `alm_committee_decision` SET TAGS ('dbx_value_regex' = 'approved|action_required|escalated|deferred|monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `alm_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Committee Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `asset_convexity` SET TAGS ('dbx_business_glossary_term' = 'Asset Convexity');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `asset_dollar_duration` SET TAGS ('dbx_business_glossary_term' = 'Asset Dollar Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `asset_duration` SET TAGS ('dbx_business_glossary_term' = 'Asset Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `asset_market_value` SET TAGS ('dbx_business_glossary_term' = 'Asset Market Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `base_yield_curve` SET TAGS ('dbx_business_glossary_term' = 'Base Yield Curve');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `convexity_gap` SET TAGS ('dbx_business_glossary_term' = 'Convexity Gap');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `dollar_duration_gap` SET TAGS ('dbx_business_glossary_term' = 'Dollar Duration Gap');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `duration_gap` SET TAGS ('dbx_business_glossary_term' = 'Duration Gap');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `dv01_asset` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of 1 Basis Point (DV01) Asset');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `dv01_gap` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of 1 Basis Point (DV01) Gap');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `dv01_liability` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of 1 Basis Point (DV01) Liability');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'within_tolerance|minor_breach|major_breach|critical_breach|under_review|remediation_required');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `liability_convexity` SET TAGS ('dbx_business_glossary_term' = 'Liability Convexity');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `liability_dollar_duration` SET TAGS ('dbx_business_glossary_term' = 'Liability Dollar Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `liability_duration` SET TAGS ('dbx_business_glossary_term' = 'Liability Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `liability_market_value` SET TAGS ('dbx_business_glossary_term' = 'Liability Market Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_value_regex' = 'effective_duration|modified_duration|key_rate_duration|option_adjusted_duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|stress_test|regulatory|quarterly|annual');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `parallel_shift_down_100bp_impact` SET TAGS ('dbx_business_glossary_term' = 'Parallel Shift Down 100 Basis Points (BP) Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `parallel_shift_up_100bp_impact` SET TAGS ('dbx_business_glossary_term' = 'Parallel Shift Up 100 Basis Points (BP) Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `rbc_c3_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C-3 Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `surplus_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Surplus at Risk');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `tolerance_threshold_dollar_duration` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Dollar Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `tolerance_threshold_duration` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Duration');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `twist_flattening_impact` SET TAGS ('dbx_business_glossary_term' = 'Twist Flattening Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `twist_steepening_impact` SET TAGS ('dbx_business_glossary_term' = 'Twist Steepening Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`alm_gap_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `compliance_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Guideline Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Breach Action');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'alert|block|escalate|report|auto_rebalance');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `breach_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Tolerance Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `covariance_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Covariance Adjustment Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `credit_quality_requirement` SET TAGS ('dbx_business_glossary_term' = 'Credit Quality Requirement');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `duration_constraint_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Constraint in Years');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `naic_designation_requirement` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Requirement');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `naic_schedule_category` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_value_regex' = 'general_account|separate_account|all_portfolios|specific_portfolio');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `post_trade_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Trade Monitoring Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `pre_trade_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trade Enforcement Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rbc_component` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rbc_component` SET TAGS ('dbx_value_regex' = 'c0|c1|c2|c3|c4|not_applicable');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'regulatory|ips_directive|internal_policy|rbc_calculation|strategic_allocation|risk_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_source` SET TAGS ('dbx_business_glossary_term' = 'Rule Source');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|suspended');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `target_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'percentage|basis_points|years|dollars|rating_notches|count');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `compliance_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `compliance_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Detected By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `report_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Report Exception Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Order Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Exposure Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `alm_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Impact Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_amount` SET TAGS ('dbx_business_glossary_term' = 'Breach Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Occurrence Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_notes` SET TAGS ('dbx_business_glossary_term' = 'Breach Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Reference Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Level');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'warning|violation|critical');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Resolution Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|under review|remediation in progress|resolved|escalated|waived');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Detection Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'concentration limit exceeded|prohibited security|credit rating violation|liquidity constraint|duration mismatch|sector limit exceeded');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Breach Detection Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'pre-trade automated|post-trade automated|manual review|periodic reconciliation|regulatory examination');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `investment_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Decision');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `investment_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `limit_threshold` SET TAGS ('dbx_business_glossary_term' = 'Compliance Limit Threshold');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `rbc_charge_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `regulatory_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Escalation Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Resolution Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `waiver_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`compliance_breach` ALTER COLUMN `waiver_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiration Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `performance_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Attribution ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Run ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `management_report_config_id` SET TAGS ('dbx_business_glossary_term' = 'Management Report Config Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `active_return` SET TAGS ('dbx_business_glossary_term' = 'Active Return (Alpha)');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `allocation_effect` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effect');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `asset_class_contribution` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Contribution');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attribution Calculation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Attribution Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_value_regex' = 'brinson_hood_beebower|brinson_fachler|attribution_smoothing|carino|geometric');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_notes` SET TAGS ('dbx_business_glossary_term' = 'Attribution Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Period End Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Attribution Period Start Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|approved|archived');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `benchmark_return` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Return');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `capital_gain_contribution` SET TAGS ('dbx_business_glossary_term' = 'Capital Gain Contribution');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `currency_effect` SET TAGS ('dbx_business_glossary_term' = 'Currency Effect');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `income_contribution` SET TAGS ('dbx_business_glossary_term' = 'Income Contribution');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `interaction_effect` SET TAGS ('dbx_business_glossary_term' = 'Interaction Effect');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `investment_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Decision');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `investment_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `net_cash_flow` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `portfolio_beginning_market_value` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Beginning of Year (BOY) Market Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `portfolio_ending_market_value` SET TAGS ('dbx_business_glossary_term' = 'Portfolio End of Year (EOY) Market Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `sector_contribution` SET TAGS ('dbx_business_glossary_term' = 'Sector Contribution');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `selection_effect` SET TAGS ('dbx_business_glossary_term' = 'Selection Effect');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `total_return` SET TAGS ('dbx_business_glossary_term' = 'Total Return');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `transaction_cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Transaction Cost Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`performance_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `credit_default_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Default Rate (CDR) Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `actual_default_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Actual Default Event Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `actual_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Loss Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'historical_default_rate|market_implied|credit_model|rating_transition_matrix|expert_judgment|vendor_model');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `cdr_basis_points` SET TAGS ('dbx_business_glossary_term' = 'CDR Basis Points');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `cdr_value` SET TAGS ('dbx_business_glossary_term' = 'Conditional Default Rate (CDR) Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `cecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Loss (CECL) Provision Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `credit_migration_direction` SET TAGS ('dbx_business_glossary_term' = 'Credit Migration Direction');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `credit_migration_direction` SET TAGS ('dbx_value_regex' = 'upgrade|downgrade|no_change');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `default_event_date` SET TAGS ('dbx_business_glossary_term' = 'Default Event Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `default_type` SET TAGS ('dbx_business_glossary_term' = 'Default Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `default_type` SET TAGS ('dbx_value_regex' = 'payment_default|bankruptcy|restructuring|covenant_breach|other');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `expected_credit_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `exposure_at_default` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `ldti_credit_loss_assumption` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Credit Loss Assumption');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `naic_designation` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `naic_designation_change_flag` SET TAGS ('dbx_business_glossary_term' = 'NAIC Designation Change Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `previous_naic_designation` SET TAGS ('dbx_business_glossary_term' = 'Previous NAIC Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `previous_naic_designation` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `rating_agency` SET TAGS ('dbx_value_regex' = 'moodys|sp|fitch|am_best|dbrs|other');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `rbc_c1_asset_risk_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C-1 Asset Default Risk Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'RBC Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `recovery_rate` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `reporting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$|^d{4}-d{2}$|^d{4}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `severity_rate` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Severity Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `time_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Time Horizon in Months');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`credit_default_rate` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected|under_review');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `risk_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Charge Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `orsa_report_id` SET TAGS ('dbx_business_glossary_term' = 'Orsa Report Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `rbc_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Rbc Calculation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `rbc_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rbc Filing Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `stochastic_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Scenario Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `adjusted_rbc_charge` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Risk-Based Capital (RBC) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `base_rbc_charge` SET TAGS ('dbx_business_glossary_term' = 'Base Risk-Based Capital (RBC) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `book_adjusted_carrying_value` SET TAGS ('dbx_business_glossary_term' = 'Book Adjusted Carrying Value (BACV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `c1_asset_default_charge` SET TAGS ('dbx_business_glossary_term' = 'C-1 Asset Default Risk Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `c3_interest_rate_charge` SET TAGS ('dbx_business_glossary_term' = 'C-3 Interest Rate Risk Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'standard_formula|scenario_based|stochastic_modeling|principle_based');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `calculation_version` SET TAGS ('dbx_business_glossary_term' = 'Calculation Version Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `concentration_factor` SET TAGS ('dbx_business_glossary_term' = 'Concentration Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `covariance_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Covariance Adjustment Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `fair_market_value` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|filed|amended|approved');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `hedge_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Hedge Adjustment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `hedge_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `naic_schedule_category` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calculation Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `orsa_stress_scenario` SET TAGS ('dbx_business_glossary_term' = 'Own Risk and Solvency Assessment (ORSA) Stress Scenario');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `override_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Override Approved By');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `rbc_component` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `rbc_component` SET TAGS ('dbx_value_regex' = 'c1_asset_risk|c3_interest_rate_risk|c1cs_common_stock_risk|c1o_other_asset_risk');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `statement_value` SET TAGS ('dbx_business_glossary_term' = 'Statement Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`risk_charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `mortgage_loan_id` SET TAGS ('dbx_business_glossary_term' = 'Mortgage Loan Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Officer Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `statutory_exhibit_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Exhibit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Servicer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `acquisition_price` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Price');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `allowance_for_credit_losses` SET TAGS ('dbx_business_glossary_term' = 'Allowance for Credit Losses');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Amortization Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'fully_amortizing|partially_amortizing|interest_only|balloon|negative_amortization');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `amortized_cost` SET TAGS ('dbx_business_glossary_term' = 'Amortized Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `appraisal_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `appraisal_value` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Book Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `borrower_name` SET TAGS ('dbx_business_glossary_term' = 'Borrower Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `borrower_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `borrower_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `borrower_tin` SET TAGS ('dbx_business_glossary_term' = 'Borrower Taxpayer Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `borrower_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `borrower_tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `impairment_status` SET TAGS ('dbx_business_glossary_term' = 'Impairment Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `impairment_status` SET TAGS ('dbx_value_regex' = 'not_impaired|impaired|credit_loss_recognized');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `interest_rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|adjustable|hybrid');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `loan_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `naic_designation` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `naic_schedule_b_line` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule B Line Item');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `original_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Loan Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Origination Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `outstanding_principal_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Principal Balance');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `prepayment_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 1');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Property Address Line 2');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_city` SET TAGS ('dbx_business_glossary_term' = 'Property City');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_country_code` SET TAGS ('dbx_business_glossary_term' = 'Property Country Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Property Postal Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_state` SET TAGS ('dbx_business_glossary_term' = 'Property State');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_type` SET TAGS ('dbx_business_glossary_term' = 'Property Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `property_type` SET TAGS ('dbx_value_regex' = 'commercial|residential|agricultural|mixed_use|industrial|multifamily');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `rbc_c1_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C-1 Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `recourse_flag` SET TAGS ('dbx_business_glossary_term' = 'Recourse Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`mortgage_loan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `alternative_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `statutory_exhibit_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Exhibit Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `alternative_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `alternative_asset_status` SET TAGS ('dbx_value_regex' = 'active|commitment_period|harvesting|liquidating|closed|defaulted');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `alternative_asset_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `alternative_asset_type` SET TAGS ('dbx_value_regex' = 'private_equity|hedge_fund|real_estate_equity|infrastructure|commodities|venture_capital');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Identifier Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `capital_call_amount_ytd` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Capital Call Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `distribution_amount_ytd` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Distribution Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `expected_return_rate` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Rate Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `fund_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Funded Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `gate_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Gate Provision Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus Region');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy Description');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Leverage Ratio');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'liquid|semi_liquid|illiquid|locked');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `lock_up_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period Expiration Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `lock_up_period_months` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period in Months');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `naic_schedule_ba_category` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule BA Sub-Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `nav` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `nav_date` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Valuation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `next_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Expected Valuation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Alternative Asset Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `rbc_c1_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C-1 Charge Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `rbc_c1_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C-1 Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `redemption_frequency` SET TAGS ('dbx_business_glossary_term' = 'Redemption Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `redemption_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|at_maturity|none');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `redemption_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notice Period in Days');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `sector_focus` SET TAGS ('dbx_business_glossary_term' = 'Sector Focus');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `side_pocket_flag` SET TAGS ('dbx_business_glossary_term' = 'Side Pocket Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `unfunded_commitment` SET TAGS ('dbx_business_glossary_term' = 'Unfunded Commitment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`alternative_asset` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` SET TAGS ('dbx_subdomain' = 'trading_operations');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `derivative_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `broker_dealer_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Dealer Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `collateral_posted` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `collateral_received` SET TAGS ('dbx_business_glossary_term' = 'Collateral Received Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|government_securities|corporate_bonds|letters_of_credit|none');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `contract_notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Derivative Contract Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Derivative Contract Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|matured|terminated|cancelled|pending');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `current_fmv` SET TAGS ('dbx_business_glossary_term' = 'Current Fair Market Value (FMV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `derivative_subtype` SET TAGS ('dbx_business_glossary_term' = 'Derivative Instrument Subtype');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `derivative_type` SET TAGS ('dbx_business_glossary_term' = 'Derivative Instrument Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `floating_rate_index` SET TAGS ('dbx_business_glossary_term' = 'Floating Rate Index');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `gmdb_hedge_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Death Benefit (GMDB) Hedge Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `gmwb_hedge_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Minimum Withdrawal Benefit (GMWB) Hedge Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'fair_value_hedge|cash_flow_hedge|net_investment_hedge|economic_hedge|no_hedge_designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `hedge_effectiveness_test_result` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Result');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `hedge_effectiveness_test_result` SET TAGS ('dbx_value_regex' = 'highly_effective|not_effective|not_tested');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `isda_master_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `isda_master_agreement_version` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Version');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|at_maturity');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `rbc_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `schedule_db_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Schedule DB Reporting Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `strike_rate` SET TAGS ('dbx_business_glossary_term' = 'Strike Rate or Fixed Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `underlying_reference` SET TAGS ('dbx_business_glossary_term' = 'Underlying Reference Asset or Index');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `derivative_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Valuation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `derivative_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Contract Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_run_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `collateral_balance` SET TAGS ('dbx_business_glossary_term' = 'Collateral Balance');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `cva` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `delta` SET TAGS ('dbx_business_glossary_term' = 'Delta');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `dv01` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of One Basis Point (DV01)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `dva` SET TAGS ('dbx_business_glossary_term' = 'Debit Valuation Adjustment (DVA)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `fmv` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV)');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_value_regex' = 'trading|hedging|other');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `gamma` SET TAGS ('dbx_business_glossary_term' = 'Gamma');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'fair_value_hedge|cash_flow_hedge|net_investment_hedge|economic_hedge|not_designated');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `hedge_effectiveness_test_result` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Result');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `hedge_effectiveness_test_result` SET TAGS ('dbx_value_regex' = 'highly_effective|effective|ineffective|not_tested|not_applicable');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `hedge_ineffectiveness_amount` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ineffectiveness Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `naic_designation` SET TAGS ('dbx_value_regex' = '^(1|2|3|4|5|6)$');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `naic_schedule_db_line_number` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule DB Line Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `rbc_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `rbc_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `sap_classification` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `sap_classification` SET TAGS ('dbx_value_regex' = 'hedging|income_generation|replication|other');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `theta` SET TAGS ('dbx_business_glossary_term' = 'Theta');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_model_used` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model Used');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_notes` SET TAGS ('dbx_business_glossary_term' = 'Valuation Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|adjusted|under_review|approved');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `variation_margin_call` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Call');
ALTER TABLE `life_insurance_ecm`.`investment`.`derivative_valuation` ALTER COLUMN `vega` SET TAGS ('dbx_business_glossary_term' = 'Vega');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Guideline Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `compliance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Guideline Owner Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `superseded_guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Guideline Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Breach Action');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'immediate_rebalance|notify_committee|escalate_cio|file_regulatory_report|waiver_required');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `breach_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Tolerance Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `concentration_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `concentration_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `concentration_limit_type` SET TAGS ('dbx_value_regex' = 'single_issuer|sector|geography|currency|counterparty|security_type');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `credit_quality_requirement` SET TAGS ('dbx_business_glossary_term' = 'Credit Quality Requirement');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `duration_constraint_maximum_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Constraint Maximum Years');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `duration_constraint_minimum_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Constraint Minimum Years');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_code` SET TAGS ('dbx_business_glossary_term' = 'Guideline Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_description` SET TAGS ('dbx_business_glossary_term' = 'Guideline Description');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_name` SET TAGS ('dbx_business_glossary_term' = 'Guideline Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_status` SET TAGS ('dbx_business_glossary_term' = 'Guideline Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|superseded|expired');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_type` SET TAGS ('dbx_business_glossary_term' = 'Guideline Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `guideline_type` SET TAGS ('dbx_value_regex' = 'strategic_asset_allocation|tactical_range|credit_floor|concentration_limit|duration_constraint|prohibited_investment');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `maximum_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `minimum_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `naic_designation_requirement` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Requirement');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `naic_designation_requirement` SET TAGS ('dbx_value_regex' = 'NAIC_1|NAIC_2|NAIC_3|NAIC_4|NAIC_5|NAIC_6');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Guideline Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Scope');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `portfolio_scope` SET TAGS ('dbx_value_regex' = 'general_account|separate_account|all_portfolios');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `post_trade_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Trade Monitoring Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `pre_trade_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trade Enforcement Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Guideline Priority');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `rbc_component` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `rbc_component` SET TAGS ('dbx_value_regex' = 'C1_asset_risk|C3_interest_rate_risk|C4_business_risk');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `rbc_factor_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Factor Threshold');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `target_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Allocation Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`guideline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `asset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `guideline_id` SET TAGS ('dbx_business_glossary_term' = 'Guideline Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `active_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Active Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `actual_duration_years` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Years');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `actual_market_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Market Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `actual_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|breached|under_review');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'strategic|tactical|actual');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'fixed_income|equity|real_estate|alternative|cash_equivalents|other');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `benchmark_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `compliance_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `compliance_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Limit Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `compliance_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Limit Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `deviation_from_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Target Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `duration_target_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Target Years');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `investment_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Decision');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `investment_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `maximum_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `minimum_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `naic_designation_requirement` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Requirement');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `rbc_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `rebalancing_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Threshold Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `rebalancing_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `target_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Weight Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`asset_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` SET TAGS ('dbx_subdomain' = 'trading_operations');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliated Legal Entity Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Address Line 1');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Address Line 2');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) and Know Your Customer (KYC) Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `aml_kyc_status` SET TAGS ('dbx_value_regex' = 'compliant|pending|expired|failed|under_review');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `approved_asset_classes` SET TAGS ('dbx_business_glossary_term' = 'Approved Asset Classes');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `approved_trading_limit` SET TAGS ('dbx_business_glossary_term' = 'Approved Trading Limit Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Counterparty City');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated|under_review');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'broker_dealer|swap_counterparty|custodian_bank|fund_manager|securities_lending_agent|sub_custodian');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Country Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `csa_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `csa_type` SET TAGS ('dbx_value_regex' = 'bilateral|unilateral|none');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'participating_ffi|deemed_compliant|exempt|non_participating|not_applicable');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `finra_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Industry Regulatory Authority (FINRA) Registration Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `form_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Expiration Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `isda_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Agreement Execution Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `isda_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Agreement Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `kyc_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Last Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `lei` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Limit Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `naic_designation_override` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Override');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Onboarding Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Postal Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `rating_agency` SET TAGS ('dbx_value_regex' = 'moodys|sp|fitch|am_best|dbrs');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Effective Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `rbc_concentration_factor` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Concentration Factor');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `sec_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Registration Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Short Name');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Counterparty State or Province');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Relationship Termination Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Termination Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`counterparty` ALTER COLUMN `w8_w9_form_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'IRS Form W-8 or W-9 On File Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` SET TAGS ('dbx_subdomain' = 'trading_operations');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `securities_lending_id` SET TAGS ('dbx_business_glossary_term' = 'Securities Lending Transaction ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Counterparty ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `accrued_fee_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Fee Income');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `collateral_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Collateral Margin Percentage');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|government_securities|corporate_bonds|letters_of_credit|other');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `counterparty_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Exposure Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `indemnification_flag` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `lending_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Lending Fee Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Initiation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loan Initiation Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_notes` SET TAGS ('dbx_business_glossary_term' = 'Loan Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Securities Loan Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_status` SET TAGS ('dbx_value_regex' = 'open|recalled|returned|defaulted|terminated');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_term_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Term Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `loan_term_type` SET TAGS ('dbx_value_regex' = 'open|term|overnight');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `market_value_at_loan` SET TAGS ('dbx_business_glossary_term' = 'Market Value at Loan Initiation');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Maturity Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `naic_designation` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `quantity_lent` SET TAGS ('dbx_business_glossary_term' = 'Quantity of Securities Lent');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `rbc_charge` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Charge');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `reinvestment_income` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Income');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `reinvestment_vehicle` SET TAGS ('dbx_business_glossary_term' = 'Cash Collateral Reinvestment Vehicle');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `schedule_d_line_item` SET TAGS ('dbx_business_glossary_term' = 'NAIC Schedule D Line Item');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`securities_lending` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `gain_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Gain Loss Event Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `original_event_gain_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Event ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot ID');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `amortized_cost` SET TAGS ('dbx_business_glossary_term' = 'Amortized Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Book Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `credit_loss_component` SET TAGS ('dbx_business_glossary_term' = 'Credit Loss Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|reversed|adjusted');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_subtype` SET TAGS ('dbx_business_glossary_term' = 'Event Subtype');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'realized_gain|realized_loss|impairment|credit_loss|recovery|other_than_temporary_impairment');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_value_regex' = 'realized_gain_loss|otti_credit_loss|otti_non_credit_oci|cecl_provision|recovery');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gain Loss Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_value_regex' = 'short_term|long_term');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `naic_designation_after` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation After');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `naic_designation_before` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Before');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `naic_schedule_line` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Line');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `net_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Net Proceeds');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `non_credit_oci_component` SET TAGS ('dbx_business_glossary_term' = 'Non-Credit Other Comprehensive Income (OCI) Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `proceeds_amount` SET TAGS ('dbx_business_glossary_term' = 'Proceeds Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `rbc_category` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Category');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `rbc_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `sap_classification` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `sap_classification` SET TAGS ('dbx_value_regex' = 'realized_capital_gain|realized_capital_loss|impairment_loss|otti_credit|otti_non_credit');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Method');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|specific_identification|average_cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `transaction_cost` SET TAGS ('dbx_business_glossary_term' = 'Transaction Cost');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`gain_loss_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `impairment_id` SET TAGS ('dbx_business_glossary_term' = 'Impairment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `original_impairment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Impairment Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'corporate_bond|municipal_bond|government_bond|mortgage_backed_security|asset_backed_security|equity');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `cecl_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Losses (CECL) Provision Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `credit_loss_component` SET TAGS ('dbx_business_glossary_term' = 'Credit Loss Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_value_regex' = 'held_to_maturity|available_for_sale|trading');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `impairment_status` SET TAGS ('dbx_business_glossary_term' = 'Impairment Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `impairment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|reversed|final');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `impairment_type` SET TAGS ('dbx_business_glossary_term' = 'Impairment Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `impairment_type` SET TAGS ('dbx_value_regex' = 'OTTI|credit_loss|intent_to_sell|CECL_provision|temporary_decline|fair_value_hedge');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `intent_to_sell_flag` SET TAGS ('dbx_business_glossary_term' = 'Intent to Sell Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `investment_committee_decision` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Decision');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `investment_committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Review Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `ldti_credit_loss_assumption` SET TAGS ('dbx_business_glossary_term' = 'Long Duration Targeted Improvements (LDTI) Credit Loss Assumption');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `more_likely_than_not_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'More Likely Than Not Sale Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `naic_designation_change_flag` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Change Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `naic_designation_post_impairment` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Post-Impairment');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `naic_designation_post_impairment` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `naic_designation_pre_impairment` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Designation Pre-Impairment');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `naic_designation_pre_impairment` SET TAGS ('dbx_value_regex' = '1|2|3|4|5|6');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `naic_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Reference');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `non_credit_loss_component` SET TAGS ('dbx_business_glossary_term' = 'Non-Credit Loss Component');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `oci_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Other Comprehensive Income (OCI) Adjustment Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `post_impairment_carrying_value` SET TAGS ('dbx_business_glossary_term' = 'Post-Impairment Carrying Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `pre_impairment_carrying_value` SET TAGS ('dbx_business_glossary_term' = 'Pre-Impairment Carrying Value');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `rbc_c1_charge_impact` SET TAGS ('dbx_business_glossary_term' = 'Risk-Based Capital (RBC) C1 Charge Impact');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Impairment Reason');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `sap_classification` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `sap_classification` SET TAGS ('dbx_value_regex' = 'bonds|preferred_stock|common_stock|mortgage_loan|real_estate');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`impairment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` SET TAGS ('dbx_subdomain' = 'trading_operations');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `investment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `original_transaction_investment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `security_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Order Identifier (ID)');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `reversal_investment_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `alm_segment` SET TAGS ('dbx_business_glossary_term' = 'Asset Liability Management (ALM) Segment');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `custodian_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Reference Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `gaap_classification` SET TAGS ('dbx_business_glossary_term' = 'Generally Accepted Accounting Principles (GAAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `naic_schedule_line_item` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Schedule Line Item');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|pending_review|exception|disputed');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `sap_classification` SET TAGS ('dbx_business_glossary_term' = 'Statutory Accounting Principles (SAP) Classification');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `separate_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Separate Account Flag');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Transaction Subtype');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `life_insurance_ecm`.`investment`.`investment_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ALTER COLUMN `portfolio_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Segment Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ALTER COLUMN `parent_portfolio_segment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`portfolio_segment` ALTER COLUMN `management_fee_basis_points` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` SET TAGS ('dbx_subdomain' = 'risk_accounting');
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ALTER COLUMN `asset_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Holding Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `life_insurance_ecm`.`investment`.`tax_lot` ALTER COLUMN `split_from_tax_lot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `life_insurance_ecm`.`investment`.`benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `life_insurance_ecm`.`investment`.`benchmark` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `life_insurance_ecm`.`investment`.`benchmark` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Identifier');
ALTER TABLE `life_insurance_ecm`.`investment`.`benchmark` ALTER COLUMN `composite_benchmark_id` SET TAGS ('dbx_self_ref_fk' = 'true');
