-- Schema for Domain: wealth | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`wealth` COMMENT 'Wealth management and private banking including portfolio construction, asset allocation, AUM tracking, NAV calculation, client reporting, rebalancing, and investment policy statements. Manages high-net-worth and ultra-high-net-worth client relationships and suitability assessments. Primary system of record aligned with SimCorp Dimension / BlackRock Aladdin.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`managed_portfolio` (
    `managed_portfolio_id` BIGINT COMMENT 'Unique identifier for the managed portfolio. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Formalizes portfolio benchmark reference for performance attribution, tracking error calculation, Sharpe ratio computation, and client reporting. Replaces string benchmark_code with proper FK to maste',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Portfolio performance is measured against benchmarks for client reporting. Manager evaluation, performance attribution, and client review meetings require valid benchmark reference.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Wealth portfolios maintain linked deposit accounts for cash sweep arrangements, dividend collection, trade settlement proceeds, and liquidity management. Essential for portfolio cash management operat',
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: A managed portfolio operates under a client mandate that defines the scope, terms, and conditions of the advisory or discretionary relationship. The managed_portfolio has mandate_type as a string fiel',
    `risk_rating_id` BIGINT COMMENT 'Foreign key linking to customer.risk_rating. Business justification: Portfolio construction and ongoing compliance require alignment between portfolio risk_profile and the clients formally approved risk_rating (MiFID II, COBS suitability). Portfolio managers and compl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Managed portfolios must be attributed to cost centers for ongoing management accounting, expense allocation, and wealth division P&L reporting. Finance teams require portfolio-level cost center assign',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: Managed portfolios trading derivatives require ISDA master agreements and CSAs for legal framework and collateral terms. Links portfolio authorization to trade under specific agreements, enables margi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Portfolio AUM reporting, FX revaluation, and regulatory capital calculations require base currency as a proper reference entity. A banking expert expects managed_portfolio to reference the currency ma',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Wealth portfolios require funds transfer pricing for management accounting and client profitability analysis. Business process: treasury charges/credits wealth business for liquidity consumed/provided',
    `investment_mandate_id` BIGINT COMMENT 'Reference to the client mandate that defines the contractual terms and investment authority for this portfolio.',
    `statement_id` BIGINT COMMENT 'Reference to the Investment Policy Statement that governs the investment strategy, objectives, constraints, and guidelines for this portfolio.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: When wealth portfolios invest in funds, they require investor account registration at the fund level. Required for subscription/redemption processing, statement generation, tax reporting, and regulato',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Portfolio opening, material changes, or periodic reviews trigger KYC review cycles per CDD/EDD regulatory requirements. Links portfolio lifecycle events to mandatory customer due diligence processes r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Managed portfolios are booked under specific legal entities for regulatory capital reporting, AIFMD/MiFID II compliance, and IFRS consolidated financial statements. A regulatory reporting officer woul',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Managed portfolios with derivatives or leverage operate under ISDA/CSA margin agreements governing collateral obligations. Linking enables EMIR/Dodd-Frank compliance reporting, margin call processing,',
    `model_portfolio_id` BIGINT COMMENT 'Reference to the model portfolio template used for asset allocation targets and rebalancing guidance.',
    `party_id` BIGINT COMMENT 'Reference to the high-net-worth (HNW) or ultra-high-net-worth (UHNW) client who owns this portfolio.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Portfolios are serviced through primary channels (digital platform, branch, private banking). Required for channel preference tracking, service delivery routing, regulatory channel-of-record documenta',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Managed portfolios generate fee revenue and investment income attributed to profit centers for IFRS 8 segment reporting and management P&L. Wealth management reporting requires portfolio-level profit ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Portfolios generate management and performance fee revenue that must post to specific GL revenue accounts for P&L reporting and revenue recognition. Banking operations require mapping each portfolios',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Managed portfolios are subject to portfolio-level risk limits (VaR budget, drawdown limit, leverage limit) set in the risk framework. Direct portfolio-to-limit linkage supports real-time limit utiliza',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: In private banking, each managed portfolio is serviced by a specific branch housing the relationship manager. Branch-level AUM reporting, P&L attribution, and regulatory branch supervision require lin',
    `activation_date` DATE COMMENT 'Date when the portfolio became active and available for trading and management.',
    `aum_amount` DECIMAL(18,2) COMMENT 'Total market value of assets under management in the portfolio, expressed in the base currency. Updated daily based on market valuations.',
    `aum_as_of_date` DATE COMMENT 'Date as of which the AUM amount was calculated, typically the most recent business day.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio record was first created in the system.',
    `derivatives_allowed_flag` BOOLEAN COMMENT 'Indicates whether the portfolio is permitted to invest in derivative instruments (options, futures, swaps).',
    `esg_compliant_flag` BOOLEAN COMMENT 'Indicates whether the portfolio follows ESG investment criteria and sustainability guidelines.',
    `fee_schedule_code` STRING COMMENT 'Code referencing the fee structure and pricing schedule applicable to this portfolio (e.g., management fees, performance fees, custody fees).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `high_water_mark` DECIMAL(18,2) COMMENT 'Highest Net Asset Value (NAV) level reached by the portfolio, used to calculate performance fees. Ensures performance fees are only charged on new gains.',
    `inception_date` DATE COMMENT 'Date when the portfolio was first established and assets were initially allocated.',
    `investment_horizon` STRING COMMENT 'Expected time horizon for the investment: short-term (< 3 years), medium-term (3-10 years), long-term (> 10 years), or perpetual.. Valid values are `short_term|medium_term|long_term|perpetual`',
    `last_rebalance_date` DATE COMMENT 'Date when the portfolio was last rebalanced to target allocations.',
    `leverage_allowed_flag` BOOLEAN COMMENT 'Indicates whether the portfolio is permitted to use leverage or borrowed funds to amplify investment positions.',
    `managed_portfolio_status` STRING COMMENT 'Current lifecycle status of the managed portfolio.. Valid values are `active|suspended|closed|terminated|pending_activation|under_review`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee rate expressed as a decimal (e.g., 0.0150 for 1.50% per annum), charged on AUM.',
    `mandate_type` STRING COMMENT 'Type of investment mandate: discretionary (manager has full authority), advisory (client approves recommendations), or execution-only (client directs all trades).. Valid values are `discretionary|advisory|execution_only`',
    `next_rebalance_date` DATE COMMENT 'Scheduled date for the next portfolio rebalancing review.',
    `performance_fee_rate` DECIMAL(18,2) COMMENT 'Performance fee rate expressed as a decimal, typically charged on returns exceeding the benchmark or hurdle rate. Null if no performance fee applies.',
    `portfolio_name` STRING COMMENT 'Human-readable name or title of the managed portfolio, typically reflecting the client name or investment strategy.',
    `portfolio_number` STRING COMMENT 'Externally-known unique business identifier for the portfolio, used in client communications and regulatory reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `portfolio_strategy` STRING COMMENT 'High-level investment strategy or approach for the portfolio (e.g., growth, income, balanced, capital preservation, ESG-focused).',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the portfolio is reviewed and rebalanced to align with target asset allocation. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|event_driven — 7 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'MiFID II client classification determining the level of regulatory protection and disclosure requirements.. Valid values are `retail|professional|eligible_counterparty`',
    `reporting_frequency` STRING COMMENT 'Frequency at which performance and valuation reports are generated and delivered to the client.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `risk_profile` STRING COMMENT 'Client risk tolerance classification based on suitability assessment, ranging from conservative to aggressive.. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `shariah_compliant_flag` BOOLEAN COMMENT 'Indicates whether the portfolio adheres to Islamic finance principles and Shariah law.',
    `short_selling_allowed_flag` BOOLEAN COMMENT 'Indicates whether the portfolio is permitted to engage in short selling strategies.',
    `source_system` STRING COMMENT 'Name or code of the source system from which this portfolio record originated (e.g., SIMCORP, ALADDIN, LEGACY_WM).. Valid values are `^[A-Z_]{3,30}$`',
    `tax_status` STRING COMMENT 'Tax treatment classification of the portfolio, affecting investment decisions and reporting requirements.. Valid values are `taxable|tax_exempt|tax_deferred|non_resident`',
    `termination_date` DATE COMMENT 'Date when the portfolio was closed or terminated. Null for active portfolios.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio record was last modified in the system.',
    CONSTRAINT pk_managed_portfolio PRIMARY KEY(`managed_portfolio_id`)
) COMMENT 'Core master entity representing a discretionary or advisory investment portfolio managed on behalf of a high-net-worth (HNW) or ultra-high-net-worth (UHNW) client. Captures portfolio strategy, benchmark assignment, base currency, AUM, inception date, mandate type (discretionary/advisory), risk profile, investment horizon, fee structure reference, and portfolio status (active/suspended/closed/terminated). Links to client_mandate for contractual terms, investment_policy_statement for investment strategy and pre-mandate proposals, model_portfolio for template allocation and asset allocation targets, and custodian_account for safekeeping. Primary system of record aligned with SimCorp Dimension / BlackRock Aladdin portfolio master.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`investment_policy_statement` (
    `investment_policy_statement_id` BIGINT COMMENT 'Unique identifier for the investment policy statement record.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: IPS documents are executed and approved at a specific branch in private banking. Branch-level compliance reporting (MiFID II, FCA COBS) requires tracking which branch approved each IPS — distinct from',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: IPS documents specify return objectives, liquidity requirements, and withdrawal amounts in base currency. Suitability assessment and mandate setup require valid currency reference for client constrain',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Links IPS benchmark reference to master benchmark data for suitability assessment, performance monitoring, and regulatory compliance (MiFID II suitability). Enables consistent benchmark usage across p',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: IPS documents reference approved or restricted funds for client portfolios. Required for compliance monitoring, suitability assessment, investment restriction enforcement, and documenting fund-level c',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: IPS must be governed under a specific regulatory jurisdiction for MiFID II, SEC, or local suitability rules. Regulatory compliance reporting and audit trails require the governing jurisdiction entity.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: IPS documents inform KYC risk assessments and suitability determinations. Compliance teams review IPS during KYC cycles to validate investment objectives align with customer profile, risk tolerance, a',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: IPS documents are constructed to satisfy specific regulatory obligations (ERISA prudent investor rule, MiFID II suitability obligations, SEC investment adviser fiduciary duty). Compliance officers rev',
    `party_id` BIGINT COMMENT 'Reference to the client (party) for whom this IPS is established.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: The IPS formally defines risk limits (max drawdown, VaR, concentration) that are operationalized as risk_limit records. Linking IPS to risk_limit supports limit governance, IPS compliance monitoring, ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: IPS documents reference specific stress scenarios used to validate that the portfolio strategy remains viable under adverse conditions. IPS approval requires stress scenario validation — a named Inves',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: An Investment Policy Statement is formally grounded in a suitability assessment — the IPS captures the clients risk tolerance, investment objectives, and constraints that are determined by the suitab',
    `annual_withdrawal_amount` DECIMAL(18,2) COMMENT 'Expected annual withdrawal amount from the portfolio to meet client spending needs.',
    `approval_date` DATE COMMENT 'Date the client formally accepted and signed the IPS.',
    `concentration_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of portfolio value that may be invested in a single security or issuer, expressed as a decimal (e.g., 5.00 for 5%).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IPS record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which the IPS mandate becomes binding and portfolio construction begins.',
    `esg_exclusions` STRING COMMENT 'List of industries, sectors, or activities excluded from the portfolio based on ESG criteria (e.g., tobacco, firearms, fossil fuels).',
    `esg_preference` STRING COMMENT 'Clients preference for ESG integration: none (no ESG consideration), basic (ESG screening), advanced (ESG integration), or impact_focused (mission-driven investing).. Valid values are `none|basic|advanced|impact_focused`',
    `fee_structure` STRING COMMENT 'Type of fee arrangement: AUM-based (percentage of assets under management), flat fee, performance-based, or hybrid.. Valid values are `aum_based|flat_fee|performance_based|hybrid`',
    `geographic_restrictions` STRING COMMENT 'Geographic regions or countries excluded from or required in the portfolio (e.g., no emerging markets, US-only, exclude sanctioned countries).',
    `investment_objective` STRING COMMENT 'Primary investment goal articulated by the client: capital preservation, income generation, balanced growth, capital appreciation, or aggressive growth.. Valid values are `capital_preservation|income_generation|balanced_growth|capital_appreciation|aggressive_growth`',
    `ips_number` STRING COMMENT 'Business identifier for the IPS document, used for external reference and client communication.',
    `ips_status` STRING COMMENT 'Current lifecycle status of the IPS document. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|terminated|superseded — 7 candidates stripped; promote to reference product]',
    `ips_type` STRING COMMENT 'Classification of the IPS lifecycle stage: proposal (pre-acceptance), approved_ips (client-accepted mandate), or amended_ips (revised mandate).. Valid values are `proposal|approved_ips|amended_ips`',
    `ips_version` STRING COMMENT 'Version number of the IPS document, incremented with each amendment or restatement.',
    `liquidity_requirement_description` STRING COMMENT 'Narrative description of the clients liquidity needs, including anticipated withdrawals, emergency reserves, and cash flow requirements.',
    `management_fee_pct` DECIMAL(18,2) COMMENT 'Annual management fee as a percentage of AUM, expressed as a decimal (e.g., 1.00 for 1%).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal IPS review with the client.',
    `performance_fee_pct` DECIMAL(18,2) COMMENT 'Performance-based fee as a percentage of returns above a hurdle rate, expressed as a decimal (e.g., 20.00 for 20%).',
    `prohibited_securities` STRING COMMENT 'Specific securities, issuers, or asset types explicitly prohibited by the client (e.g., employer stock, specific countries, derivatives).',
    `proposal_date` DATE COMMENT 'Date the initial investment proposal was presented to the client.',
    `rebalancing_frequency` STRING COMMENT 'Scheduled frequency for portfolio rebalancing: monthly, quarterly, semi-annual, annual, or threshold-based (triggered by deviation).. Valid values are `monthly|quarterly|semi_annual|annual|threshold_based`',
    `rebalancing_trigger_pct` DECIMAL(18,2) COMMENT 'Percentage deviation from target asset allocation that triggers a portfolio rebalancing action, expressed as a decimal (e.g., 5.00 for 5%).',
    `regulatory_restrictions` STRING COMMENT 'Regulatory or legal constraints applicable to the portfolio, including ERISA fiduciary rules, UCITS limits, or jurisdiction-specific investment restrictions.',
    `return_objective_description` STRING COMMENT 'Narrative description of the clients return expectations, including target return rates, benchmarks, and time horizon considerations.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for periodic review and potential amendment of the IPS.. Valid values are `annual|semi_annual|quarterly|ad_hoc`',
    `risk_capacity` STRING COMMENT 'Clients financial ability to absorb investment losses without materially impacting their financial goals.. Valid values are `low|medium|high`',
    `risk_tolerance` STRING COMMENT 'Clients stated risk tolerance level, ranging from conservative to aggressive.. Valid values are `conservative|moderately_conservative|moderate|moderately_aggressive|aggressive`',
    `sector_exclusions` STRING COMMENT 'List of economic sectors excluded from the portfolio per client mandate (e.g., financials, energy, healthcare).',
    `target_annual_return_pct` DECIMAL(18,2) COMMENT 'Target annualized return percentage specified in the IPS, expressed as a decimal (e.g., 7.50 for 7.5%).',
    `tax_considerations` STRING COMMENT 'Narrative description of tax-related constraints and preferences, including capital gains management, tax-loss harvesting, and jurisdiction-specific tax rules.',
    `tax_status` STRING COMMENT 'Tax treatment of the portfolio: taxable, tax-deferred (e.g., IRA, 401k), or tax-exempt (e.g., municipal bonds).. Valid values are `taxable|tax_deferred|tax_exempt`',
    `termination_date` DATE COMMENT 'Date the IPS mandate was terminated or superseded by a new version.',
    `time_horizon_years` STRING COMMENT 'Investment time horizon in years, representing the period until the client expects to draw down the portfolio.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the IPS record was last modified.',
    CONSTRAINT pk_investment_policy_statement PRIMARY KEY(`investment_policy_statement_id`)
) COMMENT 'Formal Investment Policy Statement (IPS) and pre-mandate investment proposal governing a managed portfolio or client relationship. Captures the full advisory lifecycle from initial proposal (recommended strategy, projected return scenarios, risk metrics, fee illustration, client acceptance status) through approved IPS (asset class ranges, return objectives, risk tolerance, liquidity requirements, time horizon, tax considerations, ESG constraints, prohibited securities, concentration limits, sector exclusions, geographic restrictions, regulatory restrictions, rebalancing triggers, and IPS version history). Serves as the authoritative mandate document for portfolio construction, suitability compliance, and restriction enforcement.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`asset_allocation` (
    `asset_allocation_id` BIGINT COMMENT 'Unique identifier for the asset allocation record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Asset allocations by currency (FX exposure management) require reference to valid currency codes. Portfolio construction, rebalancing, and risk reporting depend on currency allocation tracking against',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Links strategic asset allocation benchmarks to master data for rebalancing triggers, drift monitoring, and performance evaluation. Ensures consistent benchmark definitions across asset allocation fram',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to collateral.eligibility_rule. Business justification: Asset allocation decisions for portfolios with margin/derivatives exposure must respect collateral eligibility rules (HQLA classification, minimum credit rating, eligible asset classes). Linking enabl',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.factor. Business justification: Factor-based asset allocation (equity beta, duration, credit spread) references specific risk factors in construction and rebalancing. This is a core quantitative investment process; the factor drives',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Asset allocation records specify target weights for specific fund classes within a managed portfolio. The fund class determines the applicable NAV, currency, and dealing terms for rebalancing executio',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Asset allocation compliance monitoring checks each allocation line against the applicable fund mandate constraints (sector limits, geographic restrictions, leverage limits, prohibited asset classes). ',
    `investment_policy_statement_id` BIGINT COMMENT 'Reference identifier linking this allocation to the governing Investment Policy Statement document or section.',
    `model_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.model_portfolio. Business justification: The asset_allocation product description explicitly states it records allocations for a managed portfolio or model portfolio. The existing FK covers managed_portfolio_id, but there is no FK to model',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Asset allocation drift thresholds and rebalancing triggers are directly governed by compliance monitoring rules (UCITS 5/10/40 concentration rules, ERISA diversification rules). The drift_threshold_pe',
    `parent_allocation_asset_allocation_id` BIGINT COMMENT 'Reference to the parent asset allocation record in a hierarchical allocation structure (nullable for top-level allocations).',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Asset allocation target/min/max weight bands are governed by risk limits (concentration limits, asset class limits) in the risk framework. Linking allocation to the enforcing risk_limit supports limit',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Asset allocation models are validated against stress scenarios (equity shock, rate shock) to confirm target weights remain within mandate bounds under adverse conditions — a named Investment Committee',
    `actual_weight_percent` DECIMAL(18,2) COMMENT 'Current actual allocation weight as a percentage of total portfolio value, calculated from current holdings and market values.',
    `allocation_hierarchy_level` STRING COMMENT 'Hierarchical level of this allocation within the asset class taxonomy (1=top-level asset class, 2=subclass, 3=granular segment).',
    `allocation_name` STRING COMMENT 'Business-friendly name or label for this asset allocation strategy (e.g., Conservative Growth, Aggressive Equity).',
    `allocation_notes` STRING COMMENT 'Free-text notes or commentary regarding the rationale, constraints, or special considerations for this allocation.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation record (active, inactive, pending approval, under review, archived).. Valid values are `active|inactive|pending|under_review|archived`',
    `allocation_type` STRING COMMENT 'Classification of the allocation approach: strategic (long-term target), tactical (short-term adjustment), dynamic (rules-based rebalancing), or model (template allocation).. Valid values are `strategic|tactical|dynamic|model`',
    `approval_date` DATE COMMENT 'Date when this asset allocation strategy was formally approved by the investment committee or authorized party.',
    `approved_by` STRING COMMENT 'Name or identifier of the investment committee member, portfolio manager, or relationship manager who approved this allocation strategy.',
    `asset_class` STRING COMMENT 'Primary asset class category for this allocation line (equities, fixed income, alternatives, cash, real estate, commodities).. Valid values are `equities|fixed_income|alternatives|cash|real_estate|commodities`',
    `asset_subclass` STRING COMMENT 'Granular sub-classification within the asset class (e.g., large-cap equities, investment-grade bonds, private equity, REITs).',
    `correlation_coefficient` DECIMAL(18,2) COMMENT 'Statistical correlation of this asset class with the overall portfolio or a reference asset class, ranging from -1.000 to +1.000.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset allocation record was first created in the system.',
    `drift_percent` DECIMAL(18,2) COMMENT 'Calculated deviation of actual weight from target weight, expressed as percentage points (actual_weight_percent - target_weight_percent).',
    `drift_threshold_percent` DECIMAL(18,2) COMMENT 'Maximum allowable drift from target weight before rebalancing is triggered, expressed as percentage points.',
    `effective_date` DATE COMMENT 'Date from which this asset allocation target becomes effective and applicable to the portfolio.',
    `esg_alignment_flag` BOOLEAN COMMENT 'Indicator whether this allocation aligns with Environmental, Social, and Governance (ESG) investment criteria (True/False).',
    `expected_return_percent` DECIMAL(18,2) COMMENT 'Projected annualized return for this asset class allocation, used in portfolio optimization and client reporting.',
    `expected_volatility_percent` DECIMAL(18,2) COMMENT 'Projected annualized standard deviation (volatility) for this asset class allocation, used in risk assessment.',
    `expiration_date` DATE COMMENT 'Date on which this asset allocation target expires or is superseded by a new allocation strategy (nullable for open-ended allocations).',
    `geographic_allocation` STRING COMMENT 'Geographic or regional focus of the allocation (e.g., USA, EUR, GBR, emerging markets, global).',
    `last_rebalanced_date` DATE COMMENT 'Date when this allocation was last rebalanced to bring actual weights back in line with target weights.',
    `liquidity_classification` STRING COMMENT 'Liquidity profile of the asset class allocation (highly liquid, liquid, moderately liquid, illiquid) for liquidity risk management.. Valid values are `highly_liquid|liquid|moderately_liquid|illiquid`',
    `maximum_weight_percent` DECIMAL(18,2) COMMENT 'Maximum allowable allocation weight as a percentage, defining the upper bound of the rebalancing band.',
    `minimum_weight_percent` DECIMAL(18,2) COMMENT 'Minimum allowable allocation weight as a percentage, defining the lower bound of the rebalancing band.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this asset allocation strategy and target weights.',
    `rebalancing_frequency` STRING COMMENT 'Scheduled frequency for reviewing and rebalancing this allocation (daily, weekly, monthly, quarterly, semi-annually, annually, event-driven). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annually|annually|event_driven — 7 candidates stripped; promote to reference product]',
    `rebalancing_required_flag` BOOLEAN COMMENT 'Indicator whether this allocation line has breached drift thresholds and requires rebalancing action (True/False).',
    `record_version` STRING COMMENT 'Version number of this allocation record, incremented with each update to support change tracking and audit history.',
    `risk_tolerance_alignment` STRING COMMENT 'Risk profile category that this allocation is designed to support (conservative, moderate, balanced, growth, aggressive).. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `source_system` STRING COMMENT 'Name of the source system from which this allocation record originated (e.g., SimCorp Dimension, BlackRock Aladdin).',
    `source_system_code` STRING COMMENT 'Unique identifier of this allocation record in the source system of record.',
    `target_weight_percent` DECIMAL(18,2) COMMENT 'Strategic or tactical target allocation weight as a percentage of total portfolio value (e.g., 60.00 for 60%).',
    `tax_efficiency_rating` STRING COMMENT 'Qualitative assessment of the tax efficiency of this asset class allocation (high, medium, low) for tax-aware portfolio management.. Valid values are `high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset allocation record was last modified or updated.',
    CONSTRAINT pk_asset_allocation PRIMARY KEY(`asset_allocation_id`)
) COMMENT 'Strategic and tactical asset allocation targets for a managed portfolio or model portfolio. Records target weights, minimum and maximum bands, actual weights, drift thresholds, asset class hierarchy (equities, fixed income, alternatives, cash), currency allocation, geographic allocation, and effective date. Supports rebalancing workflows and IPS compliance monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_holding` (
    `portfolio_holding_id` BIGINT COMMENT 'Unique identifier for each portfolio holding record. Primary key for the portfolio holding entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Portfolio holdings are valued at period-end for balance sheet reporting, regulatory capital calculations (Basel III), and IFRS 9 fair value measurement. Linking holdings to accounting periods enables ',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Portfolio holdings often originate from investment banking offerings (IPOs, secondary offerings). Real business process: tracking offering provenance for holdings to support client reporting, performa',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Individual securities in wealth portfolios are pledged as collateral for credit facilities. Real business process: securities-based lending where specific holdings secure loans. Operations require tra',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Holdings in wealth portfolios have issuer/counterparty credit ratings that determine investment eligibility (investment-grade mandates) and risk-weighted capital reporting. Linking holding to counterp',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Basel III regulatory capital calculations, investment policy compliance monitoring, and credit risk reporting require linking holdings to authoritative credit ratings. risk_rating is a denormalized pl',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: FX exposure reporting, regulatory capital calculations (Basel III), and multi-currency portfolio analytics require holding currency as a proper reference entity. Replaces denormalized currency_code ',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: wealth_portfolio_holding currently stores custodian_account_number as a denormalized STRING field. The custodian_account product is the authoritative record for custodian account details including cus',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Holdings include fund units (mutual funds, ETFs). Required for position reporting, NAV-based valuation, fund-level analytics, and distinguishing fund holdings from direct security holdings. Core wealt',
    `instrument_id` BIGINT COMMENT 'Internal reference to the security master record for this holding.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Holdings have issuer domicile for country risk reporting. Geographic concentration limits, IPS compliance, and country risk exposure analysis require issuer country reference for every security positi',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Enables issuer-level concentration risk monitoring, credit exposure analysis, and regulatory large exposure reporting (CRR Article 392). Supports portfolio risk management by aggregating exposure acro',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio that contains this holding. Links to the portfolio master record.',
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Individual security holdings feed market risk calculations (delta, VaR, stress scenarios). Risk systems aggregate holding-level sensitivities to portfolio/desk/firm VaR for daily risk reporting and re',
    `party_id` BIGINT COMMENT 'Reference to the custodian institution holding the security on behalf of the portfolio.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Daily portfolio valuation, IFRS 13 fair value hierarchy reporting, and regulatory NAV calculations require linking each holding to its authoritative price record in security.price. market_price is a d',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: Wealth holdings with pledged_flag=true are encumbered in repo transactions. Linking to repo_position enables collateral management, LCR encumbrance reporting, and regulatory disclosure of pledged clie',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Individual holdings may breach single-issuer concentration limits or sector limits set in the risk framework. Linking holdings to risk_limit supports holding-level limit breach monitoring and remediat',
    `tax_lot_id` BIGINT COMMENT 'Unique identifier for the specific tax lot within the holding. Enables lot-level tracking for tax optimization strategies.',
    `accrued_income` DECIMAL(18,2) COMMENT 'Income earned but not yet received on the holding, such as accrued interest on bonds or accrued dividends on equities. Included in total portfolio valuation.',
    `acquisition_date` DATE COMMENT 'Date when the security position was originally acquired or established in the portfolio. Used for holding period determination and tax lot tracking.',
    `as_of_date` DATE COMMENT 'Point-in-time date for which this holding record represents the position. Enables historical position reconstruction and time-series analysis.',
    `base_currency_market_value` DECIMAL(18,2) COMMENT 'Market value of the holding converted to the portfolio base currency using the FX rate. Used for consolidated portfolio reporting and Assets Under Management (AUM) calculation.',
    `cost_basis_method` STRING COMMENT 'Accounting method used to determine which tax lots are sold first for capital gains calculation. Critical for tax-loss harvesting and capital gains optimization strategies.. Valid values are `fifo|lifo|specific_identification|average_cost|highest_cost|lowest_cost`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert the security value from its native currency to the portfolio base currency as of the as-of date.',
    `holding_period_classification` STRING COMMENT 'Tax classification based on holding period. Short-term applies to positions held one year or less; long-term applies to positions held more than one year. Determines capital gains tax rate.. Valid values are `short_term|long_term`',
    `income_type` STRING COMMENT 'Tax classification of income generated by the holding. Determines tax treatment and reporting requirements for client tax documents.. Valid values are `qualified_dividend|ordinary_dividend|interest|capital_gain|tax_exempt|return_of_capital`',
    `investment_objective` STRING COMMENT 'Strategic investment goal associated with this holding within the portfolio strategy. Used for suitability assessment and investment policy statement (IPS) compliance.. Valid values are `growth|income|balanced|capital_preservation|aggressive_growth|speculation`',
    `lot_acquisition_date` DATE COMMENT 'Date when this specific tax lot was acquired. Used to determine short-term versus long-term capital gains treatment.',
    `lot_acquisition_price` DECIMAL(18,2) COMMENT 'Per-unit purchase price for this specific tax lot including transaction costs allocated to the lot.',
    `lot_quantity` DECIMAL(18,2) COMMENT 'Number of units in this specific tax lot. Sum of all lot quantities equals the total holding quantity.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the tax lot indicating whether it is still held, has been sold, or affected by corporate actions.. Valid values are `open|closed|partially_closed|transferred|corporate_action`',
    `market_value` DECIMAL(18,2) COMMENT 'Total market value of the holding calculated as quantity multiplied by market price. Primary input for Assets Under Management (AUM) calculation.',
    `pledged_flag` BOOLEAN COMMENT 'Indicates whether the holding is pledged as collateral for margin loans, derivatives positions, or other obligations. Critical for available liquidity calculations.',
    `portfolio_weight` DECIMAL(18,2) COMMENT 'Percentage of total portfolio market value represented by this holding. Used for asset allocation analysis and rebalancing decisions.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares of the security held in the portfolio as of the as-of date. Supports fractional shares for mutual funds and certain securities.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was first created in the portfolio management system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was last modified. Supports change tracking and reconciliation processes.',
    `restricted_flag` BOOLEAN COMMENT 'Indicates whether the holding is subject to trading restrictions such as lock-up periods, regulatory holds, or contractual limitations. Affects liquidity analysis and rebalancing decisions.',
    `settlement_date` DATE COMMENT 'Date when the most recent transaction affecting this holding was settled and ownership transferred. Follows T+1 or T+2 settlement conventions.',
    `source_system` STRING COMMENT 'Name of the upstream system that provided this holding record, such as SimCorp Dimension, BlackRock Aladdin, or custodian feed. Used for data lineage and reconciliation.',
    `total_cost_basis` DECIMAL(18,2) COMMENT 'Total acquisition cost of the holding including commissions and fees. Used for capital gains calculation and performance attribution.',
    `unit_cost_basis` DECIMAL(18,2) COMMENT 'Average cost per unit of the security for tax and performance calculation purposes. Calculated based on the cost basis method applied to all lots.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Difference between market value and total cost basis. Represents paper profit or loss on the holding that has not been realized through sale.',
    `unrealized_gain_loss_percent` DECIMAL(18,2) COMMENT 'Unrealized gain or loss expressed as a percentage of total cost basis. Used for performance reporting and client communication.',
    `wash_sale_flag` BOOLEAN COMMENT 'Indicates whether this holding is subject to wash sale rules, which disallow loss deductions when substantially identical securities are purchased within 30 days before or after a sale at a loss.',
    CONSTRAINT pk_portfolio_holding PRIMARY KEY(`portfolio_holding_id`)
) COMMENT 'Point-in-time and current holdings record for each security position within a managed portfolio, including tax lot-level detail. Captures security identifier (ISIN/CUSIP/SEDOL), quantity held, cost basis, market value, MTM price, unrealized gain/loss, weight in portfolio, settlement date, custodian account, as-of date, and lot-level attributes (acquisition date, acquisition price, lot quantity, cost basis method — FIFO/LIFO/specific identification/average cost, short-term vs long-term classification, wash sale flag, lot status). Primary source for AUM calculation, performance attribution, tax-loss harvesting, and capital gains optimization.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_transaction` (
    `portfolio_transaction_id` BIGINT COMMENT 'Unique identifier for the portfolio transaction record.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or counterparty through which the transaction was executed.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Wealth portfolio transactions booked as trades require linkage to the authoritative trade capture record for booking reconciliation, regulatory trade reporting (UTI/USI matching), and audit trail. Tra',
    `corporate_action_id` BIGINT COMMENT 'Identifier linking this transaction to a corporate action event if the transaction resulted from a corporate action (dividend, stock split, merger, etc.).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Portfolio transactions must be attributed to cost centers for management accounting and transaction cost analysis reporting. Operations and finance teams require transaction-level cost center assignme',
    `custodian_account_id` BIGINT COMMENT 'Identifier of the custodial or investment account associated with this transaction.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to asset.distribution_event. Business justification: Fund income distributions (dividends, capital gains) generate portfolio_transactions recording the receipt. Linking to distribution_event enables income attribution for performance reporting, tax repo',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Transactions execute through specific channels (online platform, mobile app, RM phone order, branch). Required for channel attribution reporting, differential fee calculation by channel, regulatory tr',
    `digital_channel_id` BIGINT COMMENT 'Foreign key linking to channel.digital_channel. Business justification: MiFID II best execution reporting requires identifying the specific digital platform (API, robo-advisory, online portal) through which a portfolio transaction was executed. The existing execution_chan',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Post-trade reconciliation and MiFID II best execution reporting require linking wealth portfolio transactions to their corresponding trade executions. Operations teams reconcile portfolio_transaction ',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: MiFID II best execution reporting and trade reconstruction require linking each portfolio transaction to the authoritative price record at execution time. Role-prefix execution_ distinguishes this f',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Transactions include fund subscriptions, redemptions, and switches. Required for transaction processing, settlement tracking, cost basis calculation, and reconciliation with fund transfer agency. Stan',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Digital wealth transactions require session linkage for fraud detection, impersonation investigation, and regulatory audit trails. Linking a portfolio transaction to the authenticated session that ini',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Portfolio cash transactions (subscriptions, redemptions, dividend receipts) generate payment instructions for settlement. Operations teams track which payment instruction settled each portfolio cash m',
    `instrument_id` BIGINT COMMENT 'Identifier of the security instrument involved in this transaction.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the managed portfolio in which this transaction occurred.',
    `order_id` BIGINT COMMENT 'Identifier of the investment order that generated this transaction, linking back to the original client instruction or portfolio rebalancing decision.',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Conduct risk and suitability compliance require linking trade instructions to the client interaction (advisory call, branch meeting) that originated them. FCA COBS and MiFID II mandate audit trails co',
    `party_id` BIGINT COMMENT 'Identifier of the custodian bank holding the securities and processing the settlement.',
    `rebalancing_order_id` BIGINT COMMENT 'Identifier of the portfolio rebalancing event that triggered this transaction, if applicable.',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: When a wealth manager redeems fund units on behalf of a client, the portfolio_transaction (sell side) directly corresponds to the asset.redemption record. Settlement reconciliation, gate restriction m',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every portfolio transaction must be screened against OFAC, UN, EU sanctions lists before execution. Mandatory regulatory control linking each trade to its screening result for audit trail, blocking de',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Portfolio transactions settle cash legs via deposit accounts for trade execution, dividend payments, interest receipts, and fee debits. Required for trade settlement reconciliation and cash movement t',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Securities portfolio transactions settle the cash leg through specific nostro accounts at correspondent banks. Linking portfolio_transaction to nostro_account enables settlement tracking, nostro recon',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: When a wealth manager subscribes to a fund on behalf of a client, the portfolio_transaction (buy side) directly corresponds to the asset.subscription record (fund administration side). End-to-end trad',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: MiFID II RTS 22 transaction reporting and FX P&L attribution require transaction currency as a proper reference entity. Role-prefixed transaction_currency_id distinguishes from settlement currency. ',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Interest accrued on fixed income securities from the last coupon payment date to the trade date, paid by the buyer to the seller.',
    `action_ratio` STRING COMMENT 'Ratio describing the terms of a corporate action (e.g., 2:1 for a stock split, 1:0.5 for a rights issue). Format varies by action type.',
    `commission` DECIMAL(18,2) COMMENT 'Brokerage commission charged for executing the transaction.',
    `corporate_action_type` STRING COMMENT 'Type of corporate action that generated this transaction, if applicable. [ENUM-REF-CANDIDATE: dividend|stock_split|reverse_split|merger|acquisition|spin_off|rights_issue|tender_offer|redemption|call|conversion|name_change — 12 candidates stripped; promote to reference product]',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original acquisition cost of the securities involved in this transaction, used for capital gains calculation. Applicable for sell transactions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first created in the system.',
    `election_type` STRING COMMENT 'Shareholder election for corporate actions offering multiple options (e.g., cash dividend vs. stock dividend, cash vs. stock in a merger).. Valid values are `cash|stock|mixed|default`',
    `ex_date` DATE COMMENT 'Date on which a security begins trading without the entitlement to a dividend or corporate action benefit. Applicable for corporate action transactions.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Additional fees charged for the transaction, excluding commission (e.g., custody fees, transaction fees, regulatory fees).',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to settlement currency or portfolio base currency. Null if no currency conversion is required.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total transaction value before fees, commissions, and taxes. Calculated as quantity multiplied by price.',
    `income_type` STRING COMMENT 'Tax classification of income received from this transaction, used for accurate tax reporting and client statements. [ENUM-REF-CANDIDATE: qualified_dividend|ordinary_dividend|capital_gain_short_term|capital_gain_long_term|interest|return_of_capital|foreign_tax_paid — 7 candidates stripped; promote to reference product]',
    `net_amount` DECIMAL(18,2) COMMENT 'Net cash impact of the transaction after deducting all commissions, fees, and taxes from the gross amount. This is the amount that affects the portfolio cash balance.',
    `payment_date` DATE COMMENT 'Date on which dividend or corporate action proceeds are paid to entitled shareholders.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares transacted. Positive for purchases and inflows, negative for sales and outflows.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Capital gain or loss realized from this transaction, calculated as the difference between net proceeds and cost basis. Applicable for sell transactions.',
    `record_date` DATE COMMENT 'Date on which shareholders must be registered to be entitled to receive a dividend or participate in a corporate action.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the transaction will settle. May differ from transaction currency for cross-currency trades.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the transaction settles and cash and securities are exchanged. Typically T+1 or T+2 depending on asset class and market.',
    `settlement_instruction` STRING COMMENT 'Method of settlement: Delivery Versus Payment (DVP), Receive Versus Payment (RVP), Free of Payment (FOP), or Against Payment.. Valid values are `dvp|rvp|fop|against_payment`',
    `source_system` STRING COMMENT 'Name of the upstream system that originated this transaction record (e.g., SimCorp Dimension, BlackRock Aladdin, custodian feed).',
    `swift_message_type` STRING COMMENT 'SWIFT message type code used to communicate this transaction or corporate action (e.g., MT564 for corporate action notification, MT566 for corporate action confirmation).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax withheld or charged on the transaction, including withholding tax on dividends and capital gains tax where applicable.',
    `tax_lot_method` STRING COMMENT 'Method used to identify which tax lots are affected by this transaction for cost basis tracking and capital gains calculation.. Valid values are `fifo|lifo|average_cost|specific_identification|highest_cost`',
    `trade_date` DATE COMMENT 'Date on which the transaction was executed or the corporate action event occurred. This is the principal business event date for performance attribution and NAV calculation.',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number for this transaction, used for client reporting and reconciliation.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the transaction indicating its processing state.. Valid values are `pending|confirmed|settled|cancelled|failed|reversed`',
    `transaction_type` STRING COMMENT 'Classification of the transaction activity: trade execution (buy, sell, subscription, redemption), income event (dividend, interest), corporate action (stock split, merger, spin-off, rights issue, tender offer), or portfolio management activity (fee deduction, transfer, dividend reinvestment). [ENUM-REF-CANDIDATE: buy|sell|subscription|redemption|dividend|interest|fee|transfer_in|transfer_out|stock_split|merger|spin_off|rights_issue|tender_offer|dividend_reinvestment|capital_gain_distribution|return_of_capital — 17 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified, capturing status changes, corrections, or amendments.',
    `value_date` DATE COMMENT 'Date from which interest or economic benefit accrues for cash movements, used for accurate performance calculation and interest attribution.',
    CONSTRAINT pk_portfolio_transaction PRIMARY KEY(`portfolio_transaction_id`)
) COMMENT 'Transactional record of all investment activity and corporate action events within a managed portfolio. Captures trade transactions (buys, sells, subscriptions, redemptions, dividend reinvestments, fee deductions, transfers), corporate action events and their portfolio impact (dividends, stock splits, mergers, rights issues, spin-offs, tender offers — with ex-date, record date, payment date, action ratio, cash/stock election, processing status, SWIFT CA messaging source), and common attributes (trade date, settlement date, security, quantity, price, gross/net amount, transaction type, broker, commission, tax lot impact, settlement status). Feeds performance calculation, holdings reconciliation, client reporting, and automated portfolio_holding updates.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`nav_calculation` (
    `nav_calculation_id` BIGINT COMMENT 'Unique identifier for the NAV calculation record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: NAV calculations must align with GL accounting periods for fund accounting close, IFRS/GAAP financial reporting, and period-end reconciliation. Fund accountants require period-stamped NAV records to r',
    `collateral_valuation_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_valuation. Business justification: NAV calculations for portfolios/funds holding pledged assets must incorporate collateral valuations to reflect net asset value accurately. Linking enables fund accounting reconciliation, ensures fair ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: NAV calculations drive fund-level P&L attribution to cost centers for management accounting and profitability reporting. Wealth management operations require cost center assignment on NAV records to a',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: UCITS KIID regulatory NAV reporting and fund accounting require NAV currency as a proper reference entity. Banking experts expect NAV calculations to reference the currency master for cross-currency f',
    `fund_id` BIGINT COMMENT 'Identifier of the investment fund if this NAV calculation is for a pooled fund vehicle.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: NAV calculations generate GL journal entries for accrued income, management fee accruals, and unrealized gain/loss postings. Fund accounting audit trails require tracing each NAV calculation to its co',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the managed portfolio or fund for which NAV is being calculated.',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: NAV calculations are subject to compliance monitoring rules governing fair value hierarchy, pricing source validation, and reconciliation tolerances. The fair_value_hierarchy_level and reconciliation_',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: Wealth management NAV calculations for portfolios holding fund units must reconcile against the official NAV record published by the fund administrator. This fund accounting reconciliation process — m',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: NAV calculations must reference the specific price records used for fund valuation to satisfy fund accounting audit requirements, UCITS/AIFMD regulatory obligations, and valuation committee sign-off. ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: NAV calculations under stress reference the specific stress scenario (shock parameters) applied. This is distinct from the run record — the scenario defines the shocks. Required for scenario-specific ',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Stressed NAV calculations are produced as outputs of stress test runs for regulatory capital and liquidity reporting. Linking nav_calculation to stress_test_run enables traceability of stressed fund/p',
    `accrued_expenses` DECIMAL(18,2) COMMENT 'Expenses incurred but not yet paid as of the valuation date, including management fees, performance fees, custody fees, and other operating expenses.',
    `accrued_income` DECIMAL(18,2) COMMENT 'Income earned but not yet received as of the valuation date, including accrued interest, dividends declared but not paid, and other receivables.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the NAV calculation was formally approved for publication to clients and regulators.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this NAV calculation to detailed audit logs, supporting documentation, and calculation worksheets.',
    `calculation_method` STRING COMMENT 'The NAV calculation method applied. Forward pricing uses end-of-day prices; swing pricing adjusts NAV for dilution; dual pricing separates bid/offer NAVs.. Valid values are `forward_pricing|backward_pricing|swing_pricing|dual_pricing`',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the NAV calculation. Tracks the workflow from initial calculation through approval and publication. [ENUM-REF-CANDIDATE: draft|pending|calculated|approved|published|rejected|recalculated — 7 candidates stripped; promote to reference product]',
    `calculation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this NAV calculation was executed and finalized.',
    `dividend_income` DECIMAL(18,2) COMMENT 'Total dividend income received or accrued during the period ending on the valuation date.',
    `expense_ratio` DECIMAL(18,2) COMMENT 'Total expenses expressed as a percentage of average net assets, typically annualized. A key metric for fund cost transparency.',
    `fair_value_hierarchy_level` STRING COMMENT 'Predominant IFRS 13 / FASB ASC 820 fair value hierarchy level for the portfolios assets. Level 1 = quoted prices in active markets; Level 2 = observable inputs; Level 3 = unobservable inputs.. Valid values are `level_1|level_2|level_3|mixed`',
    `gross_asset_value` DECIMAL(18,2) COMMENT 'Total market value of all assets held in the portfolio or fund at the valuation date, before deducting any liabilities.',
    `interest_income` DECIMAL(18,2) COMMENT 'Total interest income received or accrued from fixed-income securities and cash holdings during the period ending on the valuation date.',
    `management_fee_accrual` DECIMAL(18,2) COMMENT 'Accrued management fees owed to the investment manager as of the valuation date, typically calculated as a percentage of Assets Under Management (AUM).',
    `nav_change_amount` DECIMAL(18,2) COMMENT 'Absolute change in NAV from the prior valuation date to the current valuation date.',
    `nav_change_percent` DECIMAL(18,2) COMMENT 'Percentage change in NAV from the prior valuation date, expressed as a decimal (e.g., 0.0250 for 2.5%).',
    `nav_per_unit` DECIMAL(18,2) COMMENT 'The NAV divided by the number of outstanding units or shares. This is the price at which investors can subscribe or redeem units.',
    `net_asset_value` DECIMAL(18,2) COMMENT 'The net value of the portfolio or fund, calculated as gross asset value minus total liabilities. This is the headline NAV figure used for client reporting and unit pricing.',
    `net_cash_flow` DECIMAL(18,2) COMMENT 'Net cash flow into or out of the fund, calculated as subscriptions minus redemptions.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or special circumstances related to this NAV calculation.',
    `performance_fee_accrual` DECIMAL(18,2) COMMENT 'Accrued performance or incentive fees owed to the investment manager, typically calculated based on returns exceeding a hurdle rate or high-water mark.',
    `pricing_source` STRING COMMENT 'Primary source of market prices and valuations used in this NAV calculation (e.g., Bloomberg, Reuters, custodian bank, fund administrator). [ENUM-REF-CANDIDATE: bloomberg|reuters|internal|custodian|administrator|vendor|composite — 7 candidates stripped; promote to reference product]',
    `prior_nav` DECIMAL(18,2) COMMENT 'The NAV from the previous valuation date, used for period-over-period performance calculation and reconciliation.',
    `publication_timestamp` TIMESTAMP COMMENT 'Date and time when the NAV was published to clients, data vendors, and regulatory reporting systems.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Net realized gains or losses from asset sales and disposals during the period ending on the valuation date.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process between the NAV calculation and custodian or administrator records.. Valid values are `pending|reconciled|variance_identified|escalated|resolved`',
    `redemptions_amount` DECIMAL(18,2) COMMENT 'Total value of investor redemptions (capital outflows) processed on or before the valuation date.',
    `subscriptions_amount` DECIMAL(18,2) COMMENT 'Total value of new investor subscriptions (capital inflows) processed on or before the valuation date.',
    `swing_factor_applied` DECIMAL(18,2) COMMENT 'The swing pricing adjustment factor applied to the NAV to protect existing investors from dilution caused by large subscriptions or redemptions.',
    `total_expenses` DECIMAL(18,2) COMMENT 'Sum of all operating expenses, management fees, performance fees, custody fees, and other costs incurred during the period ending on the valuation date.',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Sum of all liabilities, payables, accrued expenses, and obligations of the portfolio or fund at the valuation date.',
    `units_outstanding` DECIMAL(18,2) COMMENT 'Total number of fund units or shares outstanding at the valuation date. Used to calculate NAV per unit.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Net unrealized gains or losses on the portfolios holdings as of the valuation date, calculated as the difference between current market value and cost basis.',
    `valuation_date` DATE COMMENT 'The business date for which the NAV is calculated. This is the as-of date for all asset valuations and liability assessments included in this calculation.',
    `valuation_methodology` STRING COMMENT 'The primary valuation approach applied to the portfolios assets. Mark-to-market uses observable market prices; mark-to-model uses internal models for illiquid assets.. Valid values are `mark_to_market|mark_to_model|net_asset_value|discounted_cash_flow|comparable_transactions|cost`',
    `variance_amount` DECIMAL(18,2) COMMENT 'Absolute value of any variance identified during reconciliation between internal NAV calculation and external custodian or administrator NAV.',
    `variance_reason` STRING COMMENT 'Explanation of any material variance identified during NAV reconciliation, including root cause and resolution plan.',
    CONSTRAINT pk_nav_calculation PRIMARY KEY(`nav_calculation_id`)
) COMMENT 'Net Asset Value (NAV) calculation record for a managed portfolio or fund at a specific valuation date. Captures gross asset value, total liabilities, NAV per unit/share, number of units outstanding, pricing source, valuation methodology, accrued income, management fee accrual, performance fee accrual, and calculation status. Supports daily NAV publication and client statement generation.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`rebalancing_order` (
    `rebalancing_order_id` BIGINT COMMENT 'Unique identifier for the portfolio rebalancing order record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Rebalancing orders are executed within accounting periods and their transaction costs and tax impacts must be recorded in the correct GL period. Period-close reporting requires linking rebalancing act',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Rebalancing orders require client approval through specific channels (email consent, phone authorization, digital approval). Essential for compliance audit trail, client consent documentation, dispute',
    `digital_channel_id` BIGINT COMMENT 'Foreign key linking to channel.digital_channel. Business justification: Robo-advisory and digital wealth platforms generate rebalancing orders via specific API/digital channels. Linking to the digital_channel instance supports platform performance reporting, API-level aud',
    `asset_allocation_id` BIGINT COMMENT 'Foreign key linking to wealth.asset_allocation. Business justification: A rebalancing order is triggered by drift from target asset allocation (as described in the product definition). The rebalancing_order captures pre_rebalance_drift_percentage and drift_tolerance_perce',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to treasury.cash_flow_forecast. Business justification: Large rebalancing orders generate material cash flows (settlement proceeds and purchase payments) that treasury must incorporate into intraday and short-term liquidity forecasts. This link enables tre',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Rebalancing activity costs (trading commissions, operational overhead) are allocated to specific cost centers for profitability analysis and management reporting. Real banking process: wealth manageme',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade execution cost calculations, regulatory transaction reporting (MiFID II), and multi-currency rebalancing analytics require portfolio base currency as a proper reference entity. Replaces denormal',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Rebalancing orders target specific fund classes for subscription or redemption. The fund class determines dealing cutoff times, settlement periods, entry/exit loads, and the applicable NAV date. Accur',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Rebalancing orders require deposit accounts for funding security purchases and receiving sale proceeds. Essential for portfolio rebalancing execution, cash availability verification, and transaction c',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Rebalancing orders initiated via online wealth portals require session linkage for digital fraud monitoring and conduct risk audit trails. Regulators expect evidence that rebalancing instructions were',
    `investment_policy_statement_id` BIGINT COMMENT 'Foreign key linking to wealth.investment_policy_statement. Business justification: The rebalancing_order has an ips_compliance_flag (BOOLEAN) indicating whether the rebalancing instruction complies with the Investment Policy Statement. This flag is meaningless without a direct refer',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the portfolio being rebalanced.',
    `model_portfolio_id` BIGINT COMMENT 'Reference to the model portfolio template that defines the target asset allocation for this rebalancing order. Null if not using a model portfolio.',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Rebalancing orders are validated against compliance monitoring rules (concentration limits, restricted securities, mandate compliance rules). The ips_compliance_flag on rebalancing_order implies a spe',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: Rebalancing decisions triggered by advisor-client interactions (portfolio review calls, meetings) must be traceable to the originating interaction for conduct risk management and MiFID II suitability ',
    `party_id` BIGINT COMMENT 'Reference to the client who owns the portfolio being rebalanced.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Rebalancing orders are frequently triggered by breach or near-breach of a risk limit (concentration, VaR, drawdown). Linking the order to the triggering risk_limit supports audit trails, limit breach ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Rebalancing orders triggered by stress events reference the stress scenario that drove the trigger. This audit trail is required for regulatory reporting and Investment Committee review of scenario-dr',
    `actual_execution_date` DATE COMMENT 'The actual date on which the rebalancing trades were executed and completed. Null if not yet executed.',
    `actual_transaction_cost` DECIMAL(18,2) COMMENT 'The actual total transaction costs incurred during rebalancing execution. Null if not yet executed.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the rebalancing order received final approval to proceed with execution. Null if not yet approved.',
    `approval_workflow_stage` STRING COMMENT 'Current stage in the multi-level approval workflow for the rebalancing order, indicating which stakeholder group must review and approve next.. Valid values are `not_required|pending_advisor|pending_compliance|pending_client|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rebalancing order record was first created in the system.',
    `drift_tolerance_percentage` DECIMAL(18,2) COMMENT 'The maximum allowable percentage deviation from target asset allocation that triggers a rebalancing order, as defined in the clients Investment Policy Statement (IPS).',
    `estimated_tax_benefit` DECIMAL(18,2) COMMENT 'The estimated tax benefit from realized capital losses through tax-loss harvesting in this rebalancing order. Null if tax-loss harvesting is not applicable.',
    `estimated_transaction_cost` DECIMAL(18,2) COMMENT 'The estimated total transaction costs including brokerage commissions, bid-ask spreads, market impact, and other execution costs for the proposed rebalancing trades.',
    `execution_venue` STRING COMMENT 'The trading venue, broker, or execution platform used to execute the rebalancing trades (e.g., internal trading desk, external broker, algorithmic execution platform).',
    `ips_compliance_flag` BOOLEAN COMMENT 'Indicates whether the proposed rebalancing order is compliant with the clients Investment Policy Statement (IPS) constraints including asset allocation ranges, security restrictions, and risk limits.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rebalancing order record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding the rebalancing order, including special instructions, client preferences, or operational considerations.',
    `order_number` STRING COMMENT 'Business-facing unique order number for the rebalancing instruction, used for client communication and operational tracking.',
    `order_status` STRING COMMENT 'Current lifecycle status of the rebalancing order in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_execution|completed|cancelled|rejected|failed — 8 candidates stripped; promote to reference product]',
    `portfolio_nav_at_execution` DECIMAL(18,2) COMMENT 'The total Net Asset Value (NAV) of the portfolio at the time of rebalancing execution. Null if not yet executed.',
    `portfolio_nav_at_trigger` DECIMAL(18,2) COMMENT 'The total Net Asset Value (NAV) of the portfolio at the time the rebalancing trigger was identified, expressed in the portfolio base currency.',
    `post_rebalance_drift_percentage` DECIMAL(18,2) COMMENT 'The maximum percentage deviation from target asset allocation across all asset classes after rebalancing execution. Null if not yet executed.',
    `pre_rebalance_drift_percentage` DECIMAL(18,2) COMMENT 'The maximum percentage deviation from target asset allocation across all asset classes before rebalancing, measured as the absolute difference between actual and target weights.',
    `proposed_execution_date` DATE COMMENT 'The target date for executing the rebalancing trades, subject to approval and market conditions.',
    `rebalancing_method` STRING COMMENT 'The methodology used to determine rebalancing trades: cash-flow rebalancing (using new contributions/withdrawals), threshold-based (triggered by drift), calendar-based (periodic), or optimization-based (minimizing costs and taxes).. Valid values are `cash_flow|threshold|calendar|optimization`',
    `rejection_reason` STRING COMMENT 'Free-text explanation of why the rebalancing order was rejected during the approval workflow. Null if not rejected.',
    `source_system` STRING COMMENT 'The name of the source system or platform from which this rebalancing order originated (e.g., SimCorp Dimension, BlackRock Aladdin, proprietary wealth management system).',
    `source_system_order_reference` STRING COMMENT 'The unique identifier for this rebalancing order in the originating source system, used for reconciliation and traceability.',
    `tax_loss_harvesting_flag` BOOLEAN COMMENT 'Indicates whether this rebalancing order includes tax-loss harvesting opportunities to realize capital losses for tax optimization purposes.',
    `total_estimated_trade_value` DECIMAL(18,2) COMMENT 'The total estimated market value of all proposed trades (buys and sells) in the rebalancing order, expressed in the portfolio base currency.',
    `trade_instruction_count` STRING COMMENT 'The total number of individual trade instructions (buy and sell orders) included in this rebalancing order.',
    `trigger_date` DATE COMMENT 'The date on which the rebalancing trigger condition was identified or the rebalancing instruction was initiated.',
    `trigger_type` STRING COMMENT 'The business event or condition that initiated the rebalancing order, such as asset allocation drift exceeding threshold, Investment Policy Statement (IPS) mandate change, model portfolio update, explicit client instruction, scheduled periodic review, or tax-loss harvesting opportunity.. Valid values are `drift_threshold|ips_mandate_change|model_portfolio_update|client_instruction|periodic_review|tax_loss_harvesting`',
    `wash_sale_check_status` STRING COMMENT 'Status of the wash sale rule compliance check to ensure that substantially identical securities are not repurchased within 30 days before or after a loss sale, which would disallow the tax loss.. Valid values are `not_applicable|passed|warning|blocked`',
    CONSTRAINT pk_rebalancing_order PRIMARY KEY(`rebalancing_order_id`)
) COMMENT 'Portfolio rebalancing instruction and execution record triggered by drift from target asset allocation, IPS mandate changes, model portfolio updates, or client instructions. Captures rebalancing trigger type, target vs actual weights by asset class, proposed trade list (security, direction, quantity, estimated value), approval workflow status, execution date, pre- and post-rebalance drift metrics, tax-loss harvesting flags, and wash sale avoidance checks. Links to portfolio_transaction records upon execution completion.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`performance_return` (
    `performance_return_id` BIGINT COMMENT 'Unique identifier for the performance return calculation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Performance returns are calculated and reported by accounting period for GIPS compliance, regulatory reporting, and client statements. Linking to accounting_period enables period-based performance att',
    `benchmark_id` BIGINT COMMENT 'Reference to the benchmark index used for relative performance comparison.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: GIPS compliance reporting and client performance statements require performance returns expressed in a specific reference currency. Banking experts expect performance records to reference the currency',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.factor. Business justification: Factor-based performance attribution (Fama-French, Barra) decomposes portfolio returns by risk factor. This is a standard quantitative wealth management process; the factor record drives attribution c',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: GIPS-compliant performance reporting and MiFID II cost/charges disclosure require performance attribution at the fund class level (Class A vs B have different fee structures and net returns). A wealth',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio for which performance is calculated.',
    `party_id` BIGINT COMMENT 'Reference to the high-net-worth or ultra-high-net-worth client who owns the portfolio.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Performance returns are examined during SEC investment adviser examinations and GIPS compliance reviews. The gips_compliant_flag on performance_return signals this regulatory dimension. Compliance off',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Stressed performance returns are produced as outputs of stress test runs (CCAR, DFAST, internal scenarios). Linking performance_return to stress_test_run enables scenario-adjusted return reporting req',
    `active_return` DECIMAL(18,2) COMMENT 'The difference between the portfolio gross return and the benchmark return, representing the value added by active management (alpha).',
    `annualized_return` DECIMAL(18,2) COMMENT 'The geometric average return expressed as an annual rate, standardizing returns across different time periods.',
    `annualized_volatility` DECIMAL(18,2) COMMENT 'The annualized standard deviation of portfolio returns, measuring total risk.',
    `attribution_available_flag` BOOLEAN COMMENT 'Indicates whether detailed performance attribution analysis is available for this return calculation.',
    `beginning_market_value` DECIMAL(18,2) COMMENT 'The total market value of the portfolio at the start of the measurement period.',
    `benchmark_return` DECIMAL(18,2) COMMENT 'The return of the designated benchmark index over the same measurement period.',
    `calculated_by` STRING COMMENT 'The system user or automated process that performed the performance calculation.',
    `calculation_date` DATE COMMENT 'The business date on which the performance return was calculated.',
    `calculation_method` STRING COMMENT 'The specific methodology used to calculate the time-weighted return (Modified Dietz, True TWR with daily valuation, Approximate TWR).. Valid values are `modified_dietz|true_twr|daily_valuation|approximate_twr`',
    `calculation_status` STRING COMMENT 'The status of the performance calculation indicating whether it is preliminary, final, restated, or independently verified.. Valid values are `preliminary|final|restated|verified`',
    `composite_member_flag` BOOLEAN COMMENT 'Indicates whether this portfolio is included as a member of a GIPS composite during this measurement period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance return record was first created in the system.',
    `downside_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of negative returns only, used in Sortino ratio calculation.',
    `ending_market_value` DECIMAL(18,2) COMMENT 'The total market value of the portfolio at the end of the measurement period.',
    `gips_compliant_flag` BOOLEAN COMMENT 'Indicates whether this performance calculation is compliant with GIPS standards for composite membership and reporting.',
    `income_earned` DECIMAL(18,2) COMMENT 'The total income (dividends, interest, coupons) earned by the portfolio during the measurement period.',
    `information_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted active return metric calculated as active return divided by tracking error, measuring manager skill.',
    `management_fees` DECIMAL(18,2) COMMENT 'The investment management fees charged during the measurement period, used to calculate net-of-fee returns.',
    `maximum_drawdown` DECIMAL(18,2) COMMENT 'The largest peak-to-trough decline in portfolio value during the measurement period, expressed as a percentage.',
    `mwr_return` DECIMAL(18,2) COMMENT 'Money-weighted rate of return (also known as Internal Rate of Return or IRR) that accounts for the timing and magnitude of external cash flows.',
    `net_cash_flow` DECIMAL(18,2) COMMENT 'The net external cash flows (contributions minus withdrawals) during the measurement period.',
    `period_end_date` DATE COMMENT 'The end date of the measurement period for this performance return calculation.',
    `period_start_date` DATE COMMENT 'The start date of the measurement period for this performance return calculation.',
    `period_type` STRING COMMENT 'The type of measurement period for the performance calculation (daily, MTD, QTD, YTD, since inception, or custom).. Valid values are `daily|month_to_date|quarter_to_date|year_to_date|since_inception|custom`',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'The total realized capital gains or losses from securities sold during the measurement period.',
    `risk_free_rate` DECIMAL(18,2) COMMENT 'The risk-free rate of return used in risk-adjusted performance calculations (typically based on government securities).',
    `sharpe_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted return metric calculated as (portfolio return - risk-free rate) / standard deviation of portfolio returns.',
    `sortino_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted return metric that uses downside deviation instead of total standard deviation, penalizing only negative volatility.',
    `total_contributions` DECIMAL(18,2) COMMENT 'The total amount of external contributions (deposits) made to the portfolio during the measurement period.',
    `total_withdrawals` DECIMAL(18,2) COMMENT 'The total amount of external withdrawals (distributions) made from the portfolio during the measurement period.',
    `tracking_error` DECIMAL(18,2) COMMENT 'The standard deviation of the difference between portfolio returns and benchmark returns, measuring the consistency of active return.',
    `twr_gross_return` DECIMAL(18,2) COMMENT 'Time-weighted rate of return before deduction of investment management fees, calculated to eliminate the effect of external cash flows.',
    `twr_net_return` DECIMAL(18,2) COMMENT 'Time-weighted rate of return after deduction of investment management fees and expenses.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The change in unrealized capital gains or losses on securities held during the measurement period.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance return record was last modified.',
    CONSTRAINT pk_performance_return PRIMARY KEY(`performance_return_id`)
) COMMENT 'Time-weighted return (TWR) and money-weighted return (MWR/IRR) calculation records for a managed portfolio over defined measurement periods (daily, MTD, QTD, YTD, since inception). Captures gross return, net-of-fee return, benchmark return, active return (alpha), tracking error, Sharpe ratio, Sortino ratio, information ratio, and GIPS-compliant composite membership flag. Supports client reporting and performance attribution.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`client_mandate` (
    `client_mandate_id` BIGINT COMMENT 'Unique identifier for the wealth management client mandate. Primary key.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.appetite. Business justification: Client mandates in discretionary wealth management must align with the firms approved risk appetite framework. Compliance and suitability reviews verify mandate risk profiles against appetite stateme',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Client mandates specify a performance benchmark for fee calculation, performance measurement, and investment policy compliance. benchmark_index is a plain string denormalization of security.benchmark.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Client mandates are assigned to cost centers for wealth management revenue attribution and management P&L reporting. Relationship managers and finance teams require mandate-level cost center assignmen',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Mandate compliance monitoring, AUM measurement, and fee calculation require base currency as a proper reference entity. Banking experts expect client mandates to reference the currency master for regu',
    `investment_policy_statement_id` BIGINT COMMENT 'Reference to the Investment Policy Statement (IPS) that governs the investment strategy, asset allocation, and constraints for this mandate. The IPS is distinct from the mandate itself.',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: Wealth mandate activation and ongoing monitoring requires direct reference to the clients KYC record — AML regulations mandate that mandates are suspended if KYC lapses. Existing kyc_review_id refere',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Mandate establishment and renewal trigger KYC review cycles per regulatory requirements. Links discretionary investment authority documentation to mandatory customer due diligence process for AML/KYC ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Client mandates are executed under specific legal entities determining the applicable regulatory regime (MiFID II, AIFMD), tax treatment, and which entity books the revenue. Compliance and finance tea',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Client mandates authorizing derivatives or leverage require a governing margin agreement defining collateral obligations. Linking enables mandate-level compliance monitoring, ensures derivatives usage',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Client mandates define investment constraints enforced via compliance monitoring rules (mandate-specific concentration limits, prohibited instrument rules, geographic restriction rules). Compliance of',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Mandates typically opened at specific branch for KYC, document notarization, and relationship establishment. Required for branch attribution, geographic regulatory compliance (state/country licensing)',
    `party_id` BIGINT COMMENT 'Reference to the client party who owns this mandate. Links to the customer or party master.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: The client mandate governs the service delivery model for a wealth client. Linking to the primary service channel (digital, branch, relationship manager) supports channel-based client segmentation, se',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Mandate compliance monitoring and performance attribution reporting require the benchmark index as a proper reference entity. Banking experts expect client mandates to reference the rate benchmark mas',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Mandates are classified by product type for regulatory reporting. UCITS/AIF classification, Form ADV reporting, and product governance require product type reference.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Each client mandate has formally set risk limits (max drawdown, concentration, leverage) operationalized in the risk limit framework. Linking mandate to risk_limit supports limit monitoring, breach es',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Client mandates should reference the suitability assessment that validates the mandate terms. This ensures regulatory compliance and links mandate terms to assessed risk tolerance. Removes redundant s',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Mandates specify tax reporting jurisdiction for FATCA/CRS compliance. Regulatory reporting, withholding tax calculation, and cross-border tax treaty application require country reference.',
    `aum_at_inception` DECIMAL(18,2) COMMENT 'Total asset value under management at the time the mandate was established, used for performance tracking and fee calculation baseline.',
    `authorized_signatory_name` STRING COMMENT 'Name of the individual authorized to sign documents and approve transactions on behalf of the client for this mandate.',
    `authorized_signatory_title` STRING COMMENT 'Title or role of the authorized signatory (e.g., Trustee, Power of Attorney, Director).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was first created in the system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the mandate is subject to CRS reporting requirements for automatic exchange of financial account information.',
    `discretionary_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount the wealth manager may invest or trade without explicit client approval, applicable to discretionary mandates.',
    `effective_date` DATE COMMENT 'Date on which the mandate becomes legally binding and investment activities may commence.',
    `fatca_status` STRING COMMENT 'FATCA classification status of the client for this mandate, determining US tax reporting obligations.. Valid values are `us_person|non_us_person|recalcitrant|exempt`',
    `fee_schedule_type` STRING COMMENT 'Classification of the fee structure applied to the mandate: fixed percentage, tiered based on Assets Under Management (AUM), performance-based, hybrid, or flat fee.. Valid values are `fixed|tiered|performance_based|hybrid|flat_fee`',
    `investment_objective` STRING COMMENT 'High-level description of the mandates investment goal, such as capital growth, income generation, capital preservation, or balanced growth and income.',
    `last_review_date` DATE COMMENT 'Date of the most recent suitability or mandate review conducted with the client, as required by MiFID II periodic assessment obligations.',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee rate expressed as a decimal (e.g., 0.01500 for 1.50% per annum). Applicable for fixed or tiered fee schedules.',
    `mandate_name` STRING COMMENT 'Descriptive name or title of the mandate, often reflecting the investment objective or client preference (e.g., Growth Portfolio, Conservative Income Strategy).',
    `mandate_number` STRING COMMENT 'Externally visible unique business identifier for the mandate, used in client communications and regulatory reporting.. Valid values are `^[A-Z0-9]{8,20}$`',
    `mandate_status` STRING COMMENT 'Current lifecycle status of the mandate indicating whether it is operational, suspended, terminated, or awaiting activation.. Valid values are `active|suspended|terminated|pending_activation|under_review|closed`',
    `mandate_type` STRING COMMENT 'Classification of the mandate based on the level of authority granted to the wealth manager: discretionary (full investment authority), advisory (recommendations only), execution-only (client-directed trades), or hybrid (combination).. Valid values are `discretionary|advisory|execution_only|hybrid`',
    `minimum_balance_amount` DECIMAL(18,2) COMMENT 'Minimum asset value required to maintain the mandate. Falling below this threshold may trigger review or termination.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic suitability or mandate review.',
    `performance_fee_rate` DECIMAL(18,2) COMMENT 'Performance-based fee rate expressed as a decimal, typically applied to returns exceeding a benchmark or hurdle rate.',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the portfolio is rebalanced to align with target asset allocation, or indication that rebalancing is threshold-based or at manager discretion.. Valid values are `monthly|quarterly|semi_annually|annually|threshold_based|discretionary`',
    `regulatory_classification` STRING COMMENT 'MiFID II client categorization determining the level of regulatory protection and disclosure requirements applicable to the mandate.. Valid values are `retail|professional|eligible_counterparty|per_se_professional|elective_professional`',
    `reporting_frequency` STRING COMMENT 'Frequency at which portfolio performance and valuation reports are provided to the client.. Valid values are `monthly|quarterly|semi_annually|annually|on_demand`',
    `risk_profile` STRING COMMENT 'Clients risk tolerance classification as assessed during suitability analysis, guiding asset allocation and investment strategy.. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `source_system` STRING COMMENT 'Name of the operational system from which this mandate record originated (e.g., SimCorp Dimension, BlackRock Aladdin).',
    `tax_reporting_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary tax jurisdiction for reporting purposes (e.g., USA, GBR, CHE).. Valid values are `^[A-Z]{3}$`',
    `termination_conditions` STRING COMMENT 'Textual description of the conditions under which the mandate may be terminated by the client or the wealth manager, including breach of terms, regulatory changes, or client request.',
    `termination_date` DATE COMMENT 'Date on which the mandate ends or was terminated. Null for open-ended mandates.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the mandate.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was last modified.',
    CONSTRAINT pk_client_mandate PRIMARY KEY(`client_mandate_id`)
) COMMENT 'Wealth management client mandate defining the scope, terms, and conditions of the advisory or discretionary relationship. Captures mandate type (discretionary/advisory/execution-only), fee schedule, base currency, reporting frequency, custodian details, authorized signatories, mandate start/end dates, termination conditions, and regulatory classification (MiFID II, UHNW suitability tier). Distinct from IPS which governs investment strategy.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`suitability_assessment` (
    `suitability_assessment_id` BIGINT COMMENT 'Unique identifier for the suitability assessment record.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: MiFID II and FCA COBS require branch-level reporting on suitability assessments conducted. Branch compliance officers need visibility into all assessments performed at their branch. The existing asses',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Suitability assessments conducted through specific channels (branch interview, video call, digital questionnaire). Critical for MiFID II/Regulation Best Interest compliance, proving appropriate advice',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: MiFID II appropriateness and suitability testing conducted digitally requires session linkage for regulatory audit trails. Linking the assessment to the authenticated digital session proves the client',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: CRS/FATCA compliance and cross-border suitability reporting require investable assets and net worth denominated in a reference currency entity. Banking experts expect suitability assessments to refere',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: MiFID II and SEC suitability rules require assessing whether a specific fund class (not just a fund) is appropriate for a client — classes differ in minimum investment, investor eligibility, and risk ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Suitability assessments evaluate specific fund recommendations against client risk profile and objectives. Required for regulatory compliance (MiFID II suitability rules, SEC Reg BI), client documenta',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Suitability assessments evaluate whether a funds investment mandate (strategy, risk constraints, permitted asset classes) aligns with the clients risk profile and objectives. MiFID II product govern',
    `individual_profile_id` BIGINT COMMENT 'Foreign key linking to customer.individual_profile. Business justification: MiFID II/COBS suitability assessments must reference the clients individual financial profile (income, employment, net worth). Wealth advisors navigate directly from suitability_assessment to individ',
    `party_id` BIGINT COMMENT 'Reference to the wealth management client for whom this suitability assessment was conducted.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Suitability assessments are conducted under specific compliance policies (MiFID II suitability policy, FINRA Rule 2111 suitability policy). Compliance officers auditing suitability processes need to v',
    `superseded_by_assessment_suitability_assessment_id` BIGINT COMMENT 'Reference to the subsequent suitability assessment that supersedes this record, enabling historical tracking of assessment evolution.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Client tax status varies by jurisdiction for suitability. Tax-efficient investment strategy, municipal bond suitability, and withholding tax planning require country reference for client tax domicile.',
    `alternative_investments_suitability` STRING COMMENT 'Assessment of the clients suitability for alternative investments (hedge funds, private equity, real estate, commodities) based on knowledge, experience, and financial capacity.. Valid values are `not_suitable|suitable_limited|suitable_moderate|suitable_significant`',
    `annual_income_amount` DECIMAL(18,2) COMMENT 'Clients total annual income from all sources, used to assess financial capacity and suitability of investment recommendations.',
    `approval_status` STRING COMMENT 'The approval status of the suitability assessment: pending review, approved by compliance, rejected, or requires escalation to senior management.. Valid values are `pending|approved|rejected|requires_escalation`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the suitability assessment was approved by compliance or supervision.',
    `assessment_date` DATE COMMENT 'The date on which the suitability assessment was performed.',
    `assessment_outcome` STRING COMMENT 'The overall outcome of the suitability assessment: suitable (client profile matches investment strategy), not suitable (mismatch identified), suitable with conditions (restrictions apply), or requires further review.. Valid values are `suitable|not_suitable|suitable_with_conditions|requires_review`',
    `assessment_type` STRING COMMENT 'The type of suitability assessment: initial onboarding assessment, periodic review, triggered review due to life event, or ad-hoc reassessment.. Valid values are `initial|periodic_review|triggered_review|ad_hoc`',
    `assessor_notes` STRING COMMENT 'Free-text notes and observations recorded by the relationship manager or assessor during the suitability assessment process.',
    `complex_products_suitability` STRING COMMENT 'Assessment of the clients suitability for complex financial products (structured products, derivatives, leveraged instruments) based on knowledge and experience.. Valid values are `not_suitable|suitable_limited|suitable_moderate|suitable_full`',
    `concentration_risk_tolerance` STRING COMMENT 'Clients tolerance for concentration risk, indicating willingness to hold large positions in individual securities or sectors.. Valid values are `low|moderate|high`',
    `esg_preference_category` STRING COMMENT 'The type of ESG preference expressed by the client: none, exclusionary screening (avoiding certain sectors), positive screening (favoring ESG leaders), impact investing, or thematic ESG investing.. Valid values are `none|exclusionary|positive_screening|impact_investing|thematic`',
    `esg_preference_flag` BOOLEAN COMMENT 'Indicates whether the client has expressed a preference for Environmental, Social, and Governance (ESG) or sustainable investment criteria.',
    `investable_assets_amount` DECIMAL(18,2) COMMENT 'Total value of assets the client intends to allocate for investment management, forming the basis for Assets Under Management (AUM) calculation.',
    `investment_experience_years` STRING COMMENT 'Number of years the client has been actively investing in financial markets.',
    `investment_knowledge_level` STRING COMMENT 'Clients level of investment knowledge and understanding of financial instruments, ranging from basic to expert.. Valid values are `basic|informed|advanced|expert`',
    `investment_objective_primary` STRING COMMENT 'The clients primary investment objective, which drives portfolio construction and asset allocation strategy.. Valid values are `capital_preservation|income_generation|balanced_growth|capital_appreciation|speculation`',
    `investment_objective_secondary` STRING COMMENT 'The clients secondary investment objective, providing additional context for portfolio construction.. Valid values are `capital_preservation|income_generation|balanced_growth|capital_appreciation|tax_efficiency|liquidity`',
    `investment_time_horizon_years` STRING COMMENT 'The number of years the client expects to maintain the investment before needing to liquidate, influencing asset allocation and risk capacity.',
    `leverage_tolerance` STRING COMMENT 'Clients tolerance for the use of leverage or margin in the investment portfolio.. Valid values are `none|conservative|moderate|aggressive`',
    `liquid_assets_amount` DECIMAL(18,2) COMMENT 'Value of clients liquid assets (cash, marketable securities, money market funds) available for investment, excluding illiquid assets such as real estate or private equity.',
    `liquidity_needs_description` STRING COMMENT 'Textual description of the clients anticipated liquidity needs, including planned withdrawals, major expenses, or cash flow requirements.',
    `loss_capacity_percentage` DECIMAL(18,2) COMMENT 'The maximum percentage loss the client can financially absorb without materially impacting their lifestyle or financial goals, expressed as a percentage of investable assets.',
    `net_worth_amount` DECIMAL(18,2) COMMENT 'Clients total net worth (assets minus liabilities), used to determine high-net-worth (HNW) or ultra-high-net-worth (UHNW) status and investment suitability.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic suitability review, typically annually or as required by regulatory framework.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this suitability assessment record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this suitability assessment record was last modified in the system.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework under which this suitability assessment was conducted (MiFID II for European clients, SEC Regulation Best Interest for US clients, FINRA Rule 2111, IOSCO principles, or local jurisdiction).. Valid values are `mifid_ii|sec_reg_bi|finra_2111|iosco|local`',
    `restrictions_notes` STRING COMMENT 'Textual notes documenting any investment restrictions, limitations, or special conditions identified during the suitability assessment (e.g., sector exclusions, leverage limits, concentration caps).',
    `risk_tolerance_category` STRING COMMENT 'Categorical classification of the clients risk tolerance based on the risk tolerance score and qualitative assessment.. Valid values are `conservative|moderately_conservative|moderate|moderately_aggressive|aggressive`',
    `risk_tolerance_score` DECIMAL(18,2) COMMENT 'Quantitative risk tolerance score derived from client questionnaire, typically on a scale of 0-100, indicating the clients willingness and capacity to accept investment risk.',
    `suitability_score` DECIMAL(18,2) COMMENT 'Quantitative suitability score (0-100) indicating the degree of alignment between the clients profile and the proposed investment strategy or portfolio.',
    `tax_status` STRING COMMENT 'The tax status of the client or account, influencing investment strategy and product selection (taxable, tax-deferred, tax-exempt, or non-resident).. Valid values are `taxable|tax_deferred|tax_exempt|non_resident`',
    `time_horizon_category` STRING COMMENT 'Categorical classification of the investment time horizon: short-term (0-3 years), medium-term (3-10 years), long-term (10+ years), or multi-generational (estate planning).. Valid values are `short_term|medium_term|long_term|multi_generational`',
    `version_number` STRING COMMENT 'Version number of this suitability assessment, incremented with each update or reassessment to maintain audit trail.',
    CONSTRAINT pk_suitability_assessment PRIMARY KEY(`suitability_assessment_id`)
) COMMENT 'Regulatory suitability and appropriateness assessment for a wealth management client. Records assessment date, client risk tolerance score, investment knowledge and experience level, financial situation (income, net worth, liquid assets), investment objectives, time horizon, loss capacity, ESG preferences, assessment outcome (suitable/not suitable), regulatory framework (MiFID II, SEC), assessor ID, and next review date. Mandatory for regulatory compliance.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`model_portfolio` (
    `model_portfolio_id` BIGINT COMMENT 'Unique identifier for the model portfolio template. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Model portfolios are always measured against a security benchmark for performance attribution, client reporting, and mandate compliance. A banking domain expert would expect model_portfolio to referen',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Model portfolios use benchmarks for performance comparison. Investment committee decisions, client proposals, and performance attribution require valid benchmark reference for strategy evaluation.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Model portfolio construction, benchmark comparison, and multi-currency model management require base currency as a proper reference entity. Banking experts expect model portfolios to reference the cur',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.factor. Business justification: Model portfolios are constructed using factor exposures (value, momentum, quality, duration). The primary risk factor driving model construction is a core investment process artifact referenced in mod',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Model portfolios are constructed using specific fund classes as building blocks — the class determines currency, fee load, and hedging characteristics that drive expected return and risk calculations.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Model portfolios must be constructed and maintained under specific regulatory policies (MiFID II suitability policy, UCITS investment restriction policy). Compliance officers reviewing model portfolio',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Model portfolios have risk limits (max allocation per asset class, VaR budget, tracking error limit) formally set in the risk framework. Linking model_portfolio to risk_limit supports model governance',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Model portfolios are validated against stress scenarios before Investment Committee approval and at periodic reviews. The stress scenario used in model validation is a named governance artifact requir',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Model portfolios drive systematic trade generation routed through specific trading books. Linking model_portfolio to trading_book enables risk limit monitoring at the model level, FRTB classification ',
    `active_client_count` STRING COMMENT 'Current number of client accounts assigned to this model portfolio, used for capacity monitoring and performance reporting.',
    `approval_date` DATE COMMENT 'Date on which the investment committee formally approved this model portfolio version for client use.',
    `approval_status` STRING COMMENT 'Current approval status of the model portfolio in the investment committee governance workflow.. Valid values are `draft|pending_review|approved|rejected|suspended|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this model portfolio record was first created in the wealth management platform.',
    `effective_date` DATE COMMENT 'Date on which this model portfolio version becomes active and available for client portfolio construction and rebalancing.',
    `esg_compliant_flag` BOOLEAN COMMENT 'Indicates whether the model portfolio adheres to Environmental, Social, and Governance investment criteria and screening.',
    `expected_return_percent` DECIMAL(18,2) COMMENT 'Annualized expected return percentage for the model portfolio based on capital market assumptions and historical performance.',
    `expected_volatility_percent` DECIMAL(18,2) COMMENT 'Annualized expected volatility (standard deviation of returns) for the model portfolio based on historical data and risk modeling.',
    `inception_date` DATE COMMENT 'Date on which the model portfolio was first created and introduced to the investment platform.',
    `investment_objective` STRING COMMENT 'Primary investment goal of the model portfolio such as capital appreciation, income generation, capital preservation, or balanced growth and income.',
    `investment_policy_statement_url` STRING COMMENT 'URL reference to the formal Investment Policy Statement document governing this model portfolio construction and management.. Valid values are `^https?://.*$`',
    `last_review_date` DATE COMMENT 'Date of the most recent investment committee review of this model portfolio, regardless of whether changes were made.',
    `minimum_investment_amount` DECIMAL(18,2) COMMENT 'Minimum account value required for a client to be assigned to this model portfolio, ensuring adequate diversification and cost efficiency.',
    `model_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the model portfolio in operational systems and client reporting.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `model_name` STRING COMMENT 'Business name of the model portfolio template used for client communication and portfolio construction workflows.',
    `model_portfolio_description` STRING COMMENT 'Comprehensive business description of the model portfolio including investment philosophy, target outcomes, and key differentiators for client communication.',
    `model_version` STRING COMMENT 'Semantic version number of the model portfolio template following major.minor.patch convention to track allocation changes over time.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this model portfolio record was last modified, including allocation changes, status updates, or metadata edits.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next investment committee review of this model portfolio allocation and performance.',
    `rebalancing_frequency` STRING COMMENT 'Standard frequency at which the model portfolio is reviewed and rebalanced to maintain target asset allocation. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annually|annually|event_driven — 7 candidates stripped; promote to reference product]',
    `rebalancing_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage drift threshold from target allocation that triggers a rebalancing event for any asset class within the model portfolio.',
    `retirement_date` DATE COMMENT 'Date on which this model portfolio version is retired and no longer available for new client assignments. Null if currently active.',
    `risk_category` STRING COMMENT 'Risk classification of the model portfolio aligned with client risk tolerance and investment objectives.. Valid values are `conservative|balanced|growth|aggressive|income|capital_preservation`',
    `shariah_compliant_flag` BOOLEAN COMMENT 'Indicates whether the model portfolio complies with Islamic finance principles and Shariah law investment restrictions.',
    `sharpe_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted return metric calculated as excess return over risk-free rate divided by volatility, used to compare model portfolio efficiency.',
    `strategic_allocation_flag` BOOLEAN COMMENT 'Indicates whether this model portfolio uses strategic (long-term) asset allocation. True if strategic, False if tactical or dynamic allocation is primary.',
    `suitability_criteria` STRING COMMENT 'Detailed description of client suitability requirements including risk tolerance, investment horizon, liquidity needs, and regulatory constraints.',
    `tactical_allocation_flag` BOOLEAN COMMENT 'Indicates whether this model portfolio incorporates tactical (short-term) asset allocation overlays to capitalize on market opportunities.',
    `target_aum` DECIMAL(18,2) COMMENT 'Target total assets under management for this model portfolio across all client accounts, used for capacity planning and investment committee oversight.',
    `target_client_segment` STRING COMMENT 'Primary client segment or wealth tier for which this model portfolio is designed, such as high-net-worth, ultra-high-net-worth, mass affluent, or institutional.',
    `tax_optimization_strategy` STRING COMMENT 'Primary tax optimization approach employed in the model portfolio construction and rebalancing to minimize client tax liability.. Valid values are `none|tax_loss_harvesting|municipal_bonds|qualified_dividends|long_term_capital_gains`',
    `total_aum` DECIMAL(18,2) COMMENT 'Current total assets under management across all client accounts using this model portfolio, reported in base currency.',
    CONSTRAINT pk_model_portfolio PRIMARY KEY(`model_portfolio_id`)
) COMMENT 'Standardized model portfolio template and asset allocation framework used as a reference for client portfolio construction and rebalancing. Captures model name, risk category (conservative/balanced/growth/aggressive), benchmark index, strategic and tactical asset allocation targets (target weights, minimum and maximum bands, actual weights, drift thresholds), asset class hierarchy (equities, fixed income, alternatives, cash), currency allocation, geographic allocation, constituent securities with target weights, model version, effective date, retirement date, and approval status. Supports centralized investment committee governance, rebalancing workflows, and IPS compliance monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Unique identifier for the wealth fee schedule record. Primary key for this entity.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Performance-based fee schedules reference a benchmark hurdle rate to determine whether performance fees are earned. Linking wealth_fee_schedule to security.benchmark enables automated fee calculation,',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Wealth management fees are debited from client deposit accounts per fee schedule terms. Required for automated fee billing, payment processing, and revenue recognition in wealth advisory operations.',
    `client_mandate_id` BIGINT COMMENT 'Reference to the client mandate or managed portfolio to which this fee schedule applies. Links fee structure to the investment management agreement.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Regulatory fee disclosure (MiFID II cost and charges), FX conversion of fees, and billing system integration require fee currency as a proper reference entity. Role-prefixed fee_currency_id is appro',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: A wealth fee schedule governs charges applied to a specific managed portfolio. The managed_portfolio has a fee_schedule_code STRING field that denotes which fee schedule applies, but there is no FK fr',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Fee schedules are governed by regulatory obligations (MiFID II cost and charges disclosure, SEC Rule 206(4)-2 fee disclosure, ERISA fee transparency). Compliance officers need to trace each fee schedu',
    `party_id` BIGINT COMMENT 'Reference to the client party (individual or corporate) being billed. Supports high-net-worth (HNW) and ultra-high-net-worth (UHNW) client identification.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee schedules define which GL revenue accounts to credit when fees are billed (management fees vs. performance fees vs. advisory fees). Real banking process: revenue recognition rules require mapping ',
    `accrual_status` STRING COMMENT 'Status of fee accrual for revenue recognition purposes. Accruing indicates fees are being accumulated daily; accrued indicates the period is complete and ready for recognition.. Valid values are `not_accrued|accruing|accrued|reversed`',
    `aum_basis_amount` DECIMAL(18,2) COMMENT 'The total Assets Under Management value used as the basis for fee calculation in this billing period. May be average daily balance, beginning balance, or ending balance depending on agreement terms.',
    `aum_calculation_method` STRING COMMENT 'The method used to determine the AUM basis for fee calculation. Average daily is most precise; beginning or ending balance is simpler but less accurate during volatile periods.. Valid values are `beginning_balance|ending_balance|average_daily|average_monthly`',
    `billing_frequency` STRING COMMENT 'The cadence at which fees are calculated and billed to the client. Monthly and quarterly are most common for management fees; performance fees are typically annual or semi-annual.. Valid values are `monthly|quarterly|semi_annually|annually|per_transaction|on_demand`',
    `billing_in_advance_flag` BOOLEAN COMMENT 'Indicates whether fees are billed at the beginning (true) or end (false) of the billing period. Management fees are commonly billed in advance; performance fees are billed in arrears.',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period for which fees are being calculated. Used in billing execution records.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period for which fees are being calculated. Used in billing execution records.',
    `billing_status` STRING COMMENT 'Current lifecycle status of the fee billing record. Tracks progression from calculation through payment or resolution. [ENUM-REF-CANDIDATE: draft|calculated|invoiced|paid|overdue|waived|disputed — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was first created in the system. Audit trail for record creation.',
    `effective_end_date` DATE COMMENT 'The date on which this fee schedule ceases to be active. Null indicates the schedule is currently in effect with no planned termination.',
    `effective_start_date` DATE COMMENT 'The date from which this fee schedule becomes active and applicable to the client mandate. Supports fee schedule versioning and amendments.',
    `fee_basis` STRING COMMENT 'Method by which the fee is calculated. AUM percentage applies a rate to total assets, flat is a fixed amount, tiered uses breakpoints with different rates per tier, performance-based links to investment returns, transaction-based charges per trade, and hybrid combines multiple methods.. Valid values are `aum_percentage|flat|tiered|performance_based|transaction_based|hybrid`',
    `fee_rate` DECIMAL(18,2) COMMENT 'The percentage rate or basis points (BPS) applied to the fee basis. For AUM-based fees, this is typically expressed as an annual percentage (e.g., 1.00% = 0.010000). For tiered schedules, this represents the rate for the current tier.',
    `fee_schedule_code` STRING COMMENT 'Business identifier for the fee schedule. Used for external reporting and client communication.',
    `fee_type` STRING COMMENT 'Classification of the fee being charged. Management fees are based on Assets Under Management (AUM), performance fees are based on portfolio returns above a hurdle rate, advisory fees are for financial planning services, custody fees are for safekeeping of assets, transaction fees are per-trade charges, and administration fees cover operational services.. Valid values are `management|performance|advisory|custody|transaction|administration`',
    `fee_waiver_amount` DECIMAL(18,2) COMMENT 'The amount of fee waived or discounted for this billing period. May result from promotional arrangements, relationship pricing, or service level adjustments.',
    `fee_waiver_reason` STRING COMMENT 'Business justification for the fee waiver. Examples include new client promotion, service issue compensation, relationship manager discretion, or contractual commitment.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee amount charged when fee_basis is flat. Null for percentage-based or tiered fee structures.',
    `gl_posting_reference` STRING COMMENT 'Reference to the general ledger journal entry or posting batch that recorded this fee revenue. Supports financial reconciliation and audit trail.',
    `gross_fee_amount` DECIMAL(18,2) COMMENT 'The total fee amount calculated before any waivers, discounts, or tax withholding. Represents the contractual fee per the schedule.',
    `high_water_mark` DECIMAL(18,2) COMMENT 'The highest Net Asset Value (NAV) level at which performance fees were previously charged. Performance fees are only charged on gains above this mark. Prevents charging fees on recovery of previous losses.',
    `invoice_date` DATE COMMENT 'The date the invoice was generated and issued to the client.',
    `invoice_reference_number` STRING COMMENT 'The unique invoice number generated for this fee billing. Used for client communication, payment tracking, and reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was last updated. Audit trail for record changes.',
    `negotiated_discount_percentage` DECIMAL(18,2) COMMENT 'Permanent discount percentage negotiated with the client, applied to the standard fee rate. Common for UHNW clients or large institutional mandates.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'The final fee amount billed to the client after waivers and tax withholding. This is the amount that will be deducted from the portfolio or invoiced.',
    `payment_date` DATE COMMENT 'The actual date the fee payment was received or the portfolio deduction was executed. Null if payment is pending.',
    `payment_due_date` DATE COMMENT 'The date by which the client must pay the invoiced fee. Typically 30 days from invoice date unless otherwise specified in the agreement.',
    `payment_method` STRING COMMENT 'The method by which the fee was or will be collected. Portfolio deduction is most common for wealth management fees, where the fee is automatically deducted from the managed assets.. Valid values are `portfolio_deduction|wire_transfer|ach|check|direct_debit`',
    `performance_hurdle_rate` DECIMAL(18,2) COMMENT 'The minimum return threshold that must be exceeded before performance fees are charged. Expressed as an annual percentage. Null for non-performance-based fees.',
    `regulatory_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this fee must be disclosed in regulatory filings such as Form ADV Part 2 (SEC) or MIFID II cost disclosures (EU). True for material fees subject to disclosure requirements.',
    `revenue_recognition_date` DATE COMMENT 'The date on which the fee revenue is recognized in the general ledger. May differ from billing date depending on revenue recognition policy and billing in advance vs arrears.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the fee payment, if applicable. Relevant for cross-border mandates subject to withholding tax treaties.',
    `tier_lower_bound` DECIMAL(18,2) COMMENT 'The minimum AUM threshold for this fee tier. Used in tiered fee structures where different rates apply to different asset levels. Null for non-tiered fee schedules.',
    `tier_upper_bound` DECIMAL(18,2) COMMENT 'The maximum AUM threshold for this fee tier. Null indicates no upper limit (top tier). Used in tiered fee structures.',
    `version` STRING COMMENT 'Version number of the fee schedule. Increments when fee terms are amended. Supports historical tracking of fee changes over the life of the mandate.',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Fee schedule master and billing record governing all charges applied to wealth management client mandates and managed portfolios. Captures the full fee lifecycle: schedule definition (fee type — management, performance, advisory, custody, transaction; fee basis — AUM percentage, flat, tiered; tier breakpoints; performance fee hurdle rate and high-water mark; fee currency; billing frequency; effective date range), billing execution (billing period, applied fee rate, AUM basis for calculation, gross and net fee amounts, tax withholding, invoice reference, payment date, fee waivers, billing status), and accrual/revenue recognition (accrual status, revenue recognition date, general ledger posting reference). Supports client invoicing, management fee reconciliation, and regulatory fee disclosure.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`fee_billing` (
    `fee_billing_id` BIGINT COMMENT 'Unique identifier for the fee billing record. Primary key for the fee billing entity.',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Wealth fee billing reconciliation requires linking each fee_billing record to the account_transaction that executed the debit from the clients deposit account. Auditors and operations teams use this ',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fee billing is period-based and must be reconciled to accounting periods for GL close, revenue recognition cutoff, and regulatory reporting. Period-end fee accrual reconciliation between the wealth su',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fee invoices delivered through client-preferred channels (email, postal mail, digital portal). Required for client preference fulfillment, delivery confirmation tracking, dispute resolution (proof of ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Invoice generation, tax withholding calculations, and MiFID II fee reporting require fee currency as a proper reference entity. Role-prefixed fee_currency_id distinguishes from AUM currency. Replace',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to wealth.wealth_fee_schedule. Business justification: Fee billing records should reference the fee schedule theyre based on. This normalizes fee structure data and ensures billing is traceable to the governing fee schedule. Removes redundant fee structu',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: fee_billing has a denormalized gl_account_code plain-text field. A proper FK to gl_account is required for revenue recognition posting, GL reconciliation, and financial reporting. gl_account_code is a',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or account for which this fee is calculated. Links to the portfolio entity managed by the wealth management system.',
    `party_id` BIGINT COMMENT 'Reference to the wealth management client for whom this fee is being billed. Links to the party entity representing the high-net-worth or ultra-high-net-worth individual or institutional client.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Fee billing invoices are settled via deposit account debits. Essential for fee collection automation, payment reconciliation, and accounts receivable management in wealth management operations.',
    `payment_mandate_id` BIGINT COMMENT 'Foreign key linking to payment.payment_mandate. Business justification: Recurring wealth management fees are collected via direct debit payment mandates. Linking fee_billing to payment_mandate enables automated recurring fee collection workflows, mandate validation before',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Fee billing revenue must be attributed to profit centers for wealth management P&L reporting and segment reporting under IFRS 8. Management accounting requires profit center assignment on fee billing ',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the fee billing was approved by authorized personnel. Required for audit trail and compliance with internal controls over financial reporting.',
    `aum_basis_amount` DECIMAL(18,2) COMMENT 'The total value of assets under management used as the basis for fee calculation. This is the NAV of the portfolio at the measurement point defined by the fee calculation method.',
    `aum_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the AUM basis amount. Typically USD, EUR, GBP, or CHF for wealth management clients.. Valid values are `^[A-Z]{3}$`',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period for which this fee is calculated. Defines the cutoff for AUM calculation and fee accrual.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period for which this fee is calculated. Typically aligned with quarterly or monthly billing cycles.',
    `billing_status` STRING COMMENT 'The current lifecycle status of the fee billing record. Draft indicates calculation in progress, pending approval requires management review, approved is ready for invoicing, invoiced means invoice has been generated, paid indicates client payment received, disputed indicates client challenge, waived means fee was forgiven, and reversed indicates the billing was cancelled and reversed. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|invoiced|paid|disputed|waived|reversed — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee billing record was first created in the system. Used for audit trail and data lineage tracking.',
    `dispute_reason` STRING COMMENT 'Free-text explanation of why the client disputed the fee billing. Examples include AUM calculation discrepancy, Fee rate incorrect, Performance calculation error, or Unauthorized charge. Populated when billing status is disputed.',
    `dispute_resolution_date` DATE COMMENT 'The date the fee dispute was resolved. Resolution may result in fee adjustment, waiver, or confirmation of original billing.',
    `fee_discount_amount` DECIMAL(18,2) COMMENT 'Any discount or reduction applied to the gross fee amount. May result from promotional offers, relationship pricing, fee waivers for underperformance, or negotiated concessions for high-net-worth clients.',
    `fee_waiver_reason` STRING COMMENT 'Free-text explanation for any fee discount or waiver applied. Examples include Performance below benchmark, Client retention offer, Relationship pricing tier, or Promotional period.',
    `gross_fee_amount` DECIMAL(18,2) COMMENT 'The total fee amount calculated before any adjustments, discounts, or tax withholding. Calculated as AUM basis amount multiplied by the applied fee rate (prorated if necessary).',
    `invoice_date` DATE COMMENT 'The date the invoice was generated and sent to the client. Establishes the start of the payment due period per the client service agreement.',
    `invoice_number` STRING COMMENT 'The unique invoice reference number generated for this fee billing. Used for client communication, payment tracking, and accounts receivable reconciliation. Populated when billing status transitions to invoiced.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fee billing record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'The final fee amount charged to the client after applying discounts and tax withholding. This is the amount that will be debited from the client portfolio or invoiced. Calculated as gross fee amount minus discount amount minus tax withholding amount.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this fee billing. May include client-specific billing arrangements, calculation adjustments, or operational notes.',
    `payment_date` DATE COMMENT 'The actual date the fee payment was received or the portfolio debit was executed. Used for cash flow tracking and revenue recognition.',
    `payment_due_date` DATE COMMENT 'The date by which the client is expected to pay the fee or by which the fee will be automatically debited from the portfolio. Typically 30 days from invoice date or immediate debit for in-advance billing.',
    `payment_method` STRING COMMENT 'The method by which the fee was paid. Portfolio debit is the most common method where fees are automatically deducted from the managed assets. Wire transfer, ACH, check, and credit card are used for separately invoiced fees.. Valid values are `portfolio_debit|wire_transfer|ach|check|credit_card`',
    `revenue_recognition_date` DATE COMMENT 'The date on which the fee revenue is recognized in the financial statements. For management fees, this is typically the end of the billing period. For performance fees, recognition may be deferred until the performance measurement period concludes.',
    `reversal_date` DATE COMMENT 'The date the fee billing was reversed. Triggers creation of offsetting general ledger entries and refund processing if payment was already received.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why the fee billing was reversed. Examples include Calculation error, Client account closed, Duplicate billing, or System error. Populated when billing status is reversed.',
    `source_system_code` STRING COMMENT 'Identifier of the source system that generated this fee billing record. Typically the wealth and portfolio management system such as SimCorp Dimension or BlackRock Aladdin. Used for data lineage and reconciliation.',
    `tax_withholding_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the fee, if applicable. Certain jurisdictions require withholding tax on investment management fees, particularly for non-resident clients or cross-border advisory services.',
    `tax_withholding_rate` DECIMAL(18,2) COMMENT 'The tax withholding rate applied, expressed as a decimal. For example, 0.1500 represents a 15% withholding rate. Rate is determined by client tax residency and applicable tax treaties.',
    CONSTRAINT pk_fee_billing PRIMARY KEY(`fee_billing_id`)
) COMMENT 'Actual fee billing and accrual records for wealth management clients. Captures billing period, fee type, AUM basis for calculation, applied fee rate, gross fee amount, tax withholding, net fee charged, billing status, invoice reference, payment date, and fee waiver details. Supports revenue recognition, client invoicing, and management fee reconciliation against the general ledger.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`custodian_account` (
    `custodian_account_id` BIGINT COMMENT 'Unique identifier for the custodian account record. Primary key.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: SWIFT settlement instruction routing and custodian identification for securities settlement require BIC as a proper reference entity. Banking experts expect custodian accounts to reference the BIC dir',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: The custodian institutions credit rating determines custody eligibility and drives credit risk capital calculations. Linking custodian_account to counterparty_rating supports custodian selection gove',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: CASS reconciliation, settlement instruction routing, and multi-currency custody reporting require custodian account base currency as a proper reference entity. Banking experts expect custodian account',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule governing custody fees, transaction fees, and ancillary charges for this account.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Custodian accounts can be fund-specific (omnibus or segregated fund custody accounts). Required for fund position reconciliation, settlement instruction routing, corporate action processing, and custo',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Custodian accounts map to GL control accounts for balance sheet reconciliation and CASS client money/asset reconciliation. Finance and custody operations require this link to reconcile custodian accou',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: A custodian account holding fund units must reconcile against the funds investor_account (unit register). Daily custody-to-register reconciliation — a mandatory fund administration control — requires',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Custodian accounts are held under specific legal entities for CASS (Client Asset Sourcebook) compliance, regulatory reporting, and consolidated balance sheet reporting. A custody operations expert wou',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio that this custodian account serves. Links the custody relationship to the investment portfolio being managed.',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Custodian accounts are the physical settlement and custody vehicle for collateral under margin agreements. Linking enables reconciliation of custody holdings against margin obligations, supports CASS ',
    `omnibus_parent_account_id` BIGINT COMMENT 'Reference to the parent omnibus custodian account if this account is a sub-account within a pooled structure. Null for standalone or top-level accounts.',
    `party_id` BIGINT COMMENT 'Reference to a sub-custodian institution in the custody chain, used when the primary custodian delegates safekeeping to a local custodian in specific markets (common for emerging markets and cross-border holdings).',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: Custodian accounts with securities_lending_enabled or margin_lending_enabled flags have securities encumbered in repo positions. Linking custodian_account to repo_position enables encumbrance tracking',
    `payment_channel_id` BIGINT COMMENT 'Foreign key linking to payment.payment_channel. Business justification: Custodian accounts use designated payment channels (SWIFT, CHAPS, Fedwire) for settlement instructions. Linking custodian_account to payment_channel enables settlement routing configuration, SLA manag',
    `account_opening_documentation_complete` BOOLEAN COMMENT 'Boolean flag indicating whether all required account opening documentation (KYC, service agreements, authorized signatory forms) has been completed and verified.',
    `account_status` STRING COMMENT 'Current operational status of the custodian account: active (fully operational), frozen (temporarily suspended), restricted (limited operations allowed), closed (terminated), or pending_opening (in setup phase).. Valid values are `active|frozen|restricted|closed|pending_opening`',
    `account_type` STRING COMMENT 'Classification of the custodian account indicating its primary function: custody (securities safekeeping), settlement (trade clearing), cash (liquidity management), margin (leveraged positions), omnibus (pooled client assets), or segregated (individual client segregation per CASS/SEC Rule 15c3-3).. Valid values are `custody|settlement|cash|margin|omnibus|segregated`',
    `authorized_signatory_list` STRING COMMENT 'Comma-separated list or reference to individuals authorized to issue instructions on this custodian account. Critical for operational control and audit trail.',
    `cass_classification` STRING COMMENT 'FCA CASS classification for UK-regulated accounts: CASS 5 (designated investment business), CASS 6 (custody assets), CASS 7 (client money), or not_applicable for non-UK accounts.. Valid values are `cass_5|cass_6|cass_7|not_applicable`',
    `closing_date` DATE COMMENT 'The date on which the custodian account was formally closed and all assets transferred out. Null for active accounts.',
    `collateral_management_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this custodian account is used for collateral management purposes, including posting and receiving collateral for derivatives and securities financing transactions.',
    `corporate_action_election_method` STRING COMMENT 'Defines how corporate action elections (dividends, rights issues, tender offers) are handled for securities held in this account: automatic (pre-defined rules), manual (case-by-case instruction), or custodian_discretion (custodian decides per standing instructions).. Valid values are `automatic|manual|custodian_discretion`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this custodian account record was first created in the system.',
    `custodian_account_number` STRING COMMENT 'The external account number assigned by the custodian institution for this custody relationship. Used for trade settlement instructions and reconciliation.',
    `custodian_contact_email` STRING COMMENT 'Email address of the primary custodian contact for operational inquiries and settlement instructions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_contact_name` STRING COMMENT 'Name of the primary relationship manager or operations contact at the custodian institution for this account.',
    `custodian_contact_phone` STRING COMMENT 'Phone number of the primary custodian contact for urgent operational matters and settlement issues.',
    `iban` STRING COMMENT 'International Bank Account Number for the custodian account, used for cross-border payment instructions and settlement. Applicable primarily for European and international accounts.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this custodian account record was last updated.',
    `last_reconciliation_date` DATE COMMENT 'The most recent date on which holdings and cash balances in this custodian account were reconciled against internal portfolio records. Critical for operational risk management and audit.',
    `margin_lending_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this custodian account supports margin lending and leveraged positions.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational considerations related to this custodian account.',
    `opening_date` DATE COMMENT 'The date on which the custodian account was officially opened and became operational for settlement and safekeeping activities.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status indicating whether custodian holdings match internal records: matched (fully reconciled), unmatched (discrepancies identified), pending_review (reconciliation in progress), or exception (requires investigation).. Valid values are `matched|unmatched|pending_review|exception`',
    `regulatory_reporting_jurisdiction` STRING COMMENT 'Three-letter ISO country code indicating the primary regulatory jurisdiction for reporting requirements applicable to this custodian account (e.g., USA for SEC, GBR for FCA).. Valid values are `^[A-Z]{3}$`',
    `securities_lending_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether securities held in this custodian account are eligible for securities lending programs to generate additional revenue.',
    `segregation_requirement` STRING COMMENT 'Regulatory or contractual requirement for asset segregation: client_segregated (individual client assets held separately per CASS/SEC 15c3-3), pooled (omnibus account), or partially_segregated (hybrid model).. Valid values are `client_segregated|pooled|partially_segregated`',
    `settlement_instruction_method` STRING COMMENT 'The primary method used to transmit settlement instructions to the custodian: SWIFT messaging, fax, electronic portal, API integration, or manual delivery.. Valid values are `swift|fax|electronic_portal|api|manual`',
    `sub_custodian_account_number` STRING COMMENT 'The account number at the sub-custodian institution, if applicable. Used for tracking the full custody chain and reconciliation across multiple custodian layers.',
    `tax_lot_method` STRING COMMENT 'The method used by the custodian for tracking cost basis and tax lots: FIFO (first-in-first-out), LIFO (last-in-first-out), specific identification, or average cost. Critical for tax reporting and capital gains calculation.. Valid values are `fifo|lifo|specific_identification|average_cost`',
    CONSTRAINT pk_custodian_account PRIMARY KEY(`custodian_account_id`)
) COMMENT 'Custodian account record linking a managed portfolio to its securities safekeeping and settlement account at a custodian bank or prime broker. Captures custodian institution, custodian account number, account type (custody, settlement, cash, margin), base currency, IBAN/BIC, account status (active, frozen, closed), opening and closing dates, authorized signatories, and sub-custodian chain. Distinct from deposit accounts in the account domain — this entity represents the securities custody relationship required for trade settlement, corporate action processing, and regulatory asset segregation (CASS, SEC Rule 15c3-3).';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`tax_lot` (
    `tax_lot_id` BIGINT COMMENT 'Unique identifier for the tax lot record. Primary key.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: IRS cost basis reporting (Form 1099-B), FATCA/CRS tax reporting, and wash sale calculations require linking each tax lot to the authoritative price record at acquisition. Role-prefix acquisition_ id',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: IRS cost basis reporting (Form 1099-B), wash sale calculations, and cross-currency gain/loss reporting require tax lot currency as a proper reference entity. Banking experts expect tax lots to referen',
    `custodian_account_id` BIGINT COMMENT 'Reference to the custodian account where the security is held.',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Tax lots are created at the point of trade execution; the acquisition price and date derive directly from the execution record. Linking tax_lot to execution supports cost basis tracking, wash sale ana',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Tax lots for fund unit holdings are specific to a fund class — different classes may have different tax treatment (e.g., distributing vs accumulating, hedged vs unhedged affects FX gain/loss). Accurat',
    `instrument_id` BIGINT COMMENT 'Reference to the security held in this tax lot.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio that holds this tax lot.',
    `portfolio_transaction_id` BIGINT COMMENT 'Reference to the transaction that created this tax lot.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Each tax lot for fund units originates from a specific subscription event. The subscription record contains the dealing NAV and cost basis per unit used to establish the tax lot. Specific identificati',
    `wash_sale_reference_lot_id` BIGINT COMMENT 'Reference to the replacement tax lot that triggered the wash sale rule.',
    `accrued_income_amount` DECIMAL(18,2) COMMENT 'Accrued interest or dividend income included in the acquisition cost for fixed income or dividend-bearing securities.',
    `acquisition_date` DATE COMMENT 'Date when the security lot was acquired or purchased.',
    `acquisition_price` DECIMAL(18,2) COMMENT 'Price per unit at which the security was acquired.',
    `adjusted_cost_basis_amount` DECIMAL(18,2) COMMENT 'Cost basis after adjustments for corporate actions, return of capital, or other events.',
    `commission_fee_amount` DECIMAL(18,2) COMMENT 'Commission and transaction fees included in the cost basis of the tax lot.',
    `corporate_action_adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments to cost basis resulting from corporate actions such as stock splits, mergers, spin-offs, or return of capital.',
    `cost_basis_amount` DECIMAL(18,2) COMMENT 'Total cost basis for the tax lot, including acquisition cost and any adjustments.',
    `cost_basis_method` STRING COMMENT 'Method used to calculate cost basis for tax reporting: First In First Out (FIFO), Last In First Out (LIFO), specific identification, average cost, or Highest In First Out (HIFO).. Valid values are `FIFO|LIFO|specific_identification|average_cost|HIFO`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax lot record was first created in the system.',
    `current_market_value` DECIMAL(18,2) COMMENT 'Current market value of the tax lot based on latest available pricing.',
    `disposal_date` DATE COMMENT 'Date when the tax lot was fully or partially disposed of through a sale or other transaction.',
    `disposal_price` DECIMAL(18,2) COMMENT 'Price per unit at which the security was disposed of or sold.',
    `donor_cost_basis_amount` DECIMAL(18,2) COMMENT 'Original cost basis from the donor for gifted securities, used to determine gain or loss upon disposal.',
    `fair_market_value_at_gift_date` DECIMAL(18,2) COMMENT 'Fair market value of the security on the date of gift, used for determining loss basis if lower than donor cost basis.',
    `gift_inheritance_flag` BOOLEAN COMMENT 'Indicates whether this lot was acquired through gift or inheritance, which has special cost basis rules.',
    `holding_period_classification` STRING COMMENT 'Tax classification based on holding period: short-term (held one year or less) or long-term (held more than one year).. Valid values are `short_term|long_term|undetermined`',
    `holding_period_days` STRING COMMENT 'Number of days the security has been held in this lot.',
    `lot_number` STRING COMMENT 'Business identifier for the tax lot, typically assigned by the portfolio management system.',
    `lot_status` STRING COMMENT 'Current status of the tax lot in its lifecycle.. Valid values are `open|closed|partially_closed|pending_settlement|suspended`',
    `lot_type` STRING COMMENT 'Type or origin of the tax lot acquisition. [ENUM-REF-CANDIDATE: purchase|dividend_reinvestment|stock_split|merger|spin_off|return_of_capital|gift|inheritance|transfer_in — 9 candidates stripped; promote to reference product]',
    `noncovered_security_flag` BOOLEAN COMMENT 'Indicates whether the security is noncovered for IRS Form 1099-B reporting purposes, meaning cost basis reporting is not required by the custodian.',
    `original_quantity` DECIMAL(18,2) COMMENT 'Original number of units or shares when the lot was first acquired, before any partial sales or adjustments.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares in this tax lot.',
    `realized_gain_loss_amount` DECIMAL(18,2) COMMENT 'Realized gain or loss from disposal of the tax lot, calculated as proceeds minus adjusted cost basis.',
    `reporting_category` STRING COMMENT 'IRS tax form category for reporting this tax lot.. Valid values are `Form_1099B|Form_8949|Schedule_D|other`',
    `source_system` STRING COMMENT 'Name of the source system that originated this tax lot record, typically the portfolio management or custody system.',
    `specific_identification_flag` BOOLEAN COMMENT 'Indicates whether this lot was specifically identified by the client or advisor for disposal, overriding the default cost basis method.',
    `tax_loss_harvesting_candidate_flag` BOOLEAN COMMENT 'Indicates whether this lot is a candidate for tax-loss harvesting strategy based on unrealized losses and holding period.',
    `tax_treatment_code` STRING COMMENT 'Tax treatment classification for this lot based on account type and security characteristics.. Valid values are `taxable|tax_deferred|tax_exempt|qualified|non_qualified`',
    `unrealized_gain_loss_amount` DECIMAL(18,2) COMMENT 'Unrealized gain or loss calculated as current market value minus adjusted cost basis. Positive values indicate gains, negative values indicate losses.',
    `unrealized_gain_loss_percent` DECIMAL(18,2) COMMENT 'Unrealized gain or loss expressed as a percentage of the adjusted cost basis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax lot record was last modified.',
    `valuation_date` DATE COMMENT 'Date as of which the current market value and unrealized gain/loss were calculated.',
    `wash_sale_disallowed_loss_amount` DECIMAL(18,2) COMMENT 'Amount of loss disallowed due to wash sale rules, which must be added to the cost basis of the replacement security.',
    `wash_sale_flag` BOOLEAN COMMENT 'Indicates whether this lot is subject to wash sale rules, which disallow loss deductions when substantially identical securities are purchased within 30 days before or after a sale at a loss.',
    CONSTRAINT pk_tax_lot PRIMARY KEY(`tax_lot_id`)
) COMMENT 'Tax lot record tracking the acquisition cost, holding period, and tax basis for each lot of a security held within a managed portfolio. Captures acquisition date, acquisition price, quantity, cost basis method (FIFO/LIFO/specific identification/average cost), short-term vs long-term classification, unrealized gain/loss, wash sale flag, and lot status. Supports tax-loss harvesting, capital gains optimization, and tax reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`trust_account` (
    `trust_account_id` BIGINT COMMENT 'Unique identifier for the trust account record. Primary key for the trust account entity.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Trust accounts maintain linked deposit accounts for trust cash management, beneficiary distributions, income collection, and expense payments. Required for fiduciary cash handling and trust administra',
    `client_mandate_id` BIGINT COMMENT 'Foreign key linking to wealth.client_mandate. Business justification: A trust account operates under a wealth management client mandate that defines the investment scope, fee structure, and regulatory classification for the trust relationship. The trust_account has regu',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trust accounting, distribution calculations, and CRS/FATCA reporting require trust account base currency as a proper reference entity. Banking experts expect trust accounts to reference the currency m',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Trusts are governed by specific jurisdiction law for fiduciary duty. Trust administration, legal compliance, and beneficiary rights interpretation require country reference for governing law.',
    `investment_policy_statement_id` BIGINT COMMENT 'Foreign key linking to wealth.investment_policy_statement. Business justification: A trust account requires a formal Investment Policy Statement governing how trust assets are to be invested, including risk tolerance, return objectives, liquidity requirements, and prohibited securit',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Trust accounts are legal structures that must be attributed to legal entities for IFRS consolidation, CRS/FATCA regulatory reporting, and tax reporting. A trust administrator would expect this link to',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: A trust account holds assets that are invested and managed through a managed portfolio. The trust_account tracks AUM (aum_amount, aum_as_of_date) and investment_objective as strings, but has no direct',
    `parent_trust_account_id` BIGINT COMMENT 'Self-referencing FK on trust_account (parent_trust_account_id)',
    `party_id` BIGINT COMMENT 'Reference to the primary client or grantor associated with this trust account.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Trust assets are pledged to secure obligations while maintaining fiduciary duty. Real business process: trust-secured lending where trust holdings collateralize credit facilities. Operations require t',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Trust administration requires a designated primary service channel for beneficiary communications, distribution instructions, and trustee reporting. The existing servicing_branch_id captures the physi',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Trust accounts are subject to OCC trust examinations and state banking department fiduciary examinations. The fiduciary_duty_classification and regulatory_classification on trust_account signal this d',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Trust accounts are subject to fiduciary investment limits and concentration limits per trust deed and regulatory requirements (e.g., Trustee Act). Linking trust_account to risk_limit supports fiduciar',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Trust accounts require sanctions screening of grantors, trustees, and beneficiaries as a distinct event from KYC review. OFAC compliance for trust structures requires linking the account to its sancti',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Trust accounts often have designated servicing branch for fiduciary oversight, trustee meetings, and beneficiary interactions. Required for local jurisdiction compliance, fiduciary duty documentation,',
    `aum_amount` DECIMAL(18,2) COMMENT 'Total market value of assets held within the trust account as of the most recent valuation date.',
    `aum_as_of_date` DATE COMMENT 'Date on which the AUM amount was calculated and reported.',
    `beneficiary_count` STRING COMMENT 'Total number of beneficiaries designated to receive distributions or benefits from the trust.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this trust account record was first created in the wealth management system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the trust account is subject to CRS reporting requirements for automatic exchange of financial account information.',
    `distribution_frequency` STRING COMMENT 'Scheduled frequency at which distributions are made to beneficiaries according to trust terms.. Valid values are `monthly|quarterly|semi_annually|annually|discretionary|event_driven`',
    `distribution_provision_type` STRING COMMENT 'Classification of the distribution rules governing how and when trust assets are distributed to beneficiaries.. Valid values are `discretionary|mandatory|income_only|principal_and_income|unitrust|annuity`',
    `effective_date` DATE COMMENT 'Date on which the trust became operational and began holding assets for beneficiaries.',
    `fatca_status` STRING COMMENT 'FATCA classification status of the trust for US tax reporting and withholding requirements.. Valid values are `us_person|specified_us_person|non_us|exempt|passive_nffe|active_nffe`',
    `fiduciary_duty_classification` STRING COMMENT 'Classification of the fiduciary responsibility and duty of care owed to the trust beneficiaries.. Valid values are `trustee|executor|administrator|guardian|conservator|custodian`',
    `grantor_name` STRING COMMENT 'Full legal name of the individual or entity who established the trust and transferred assets into it.',
    `grantor_tax_identifier` STRING COMMENT 'Tax identification number of the grantor for IRS reporting and tax compliance purposes.',
    `last_review_date` DATE COMMENT 'Date of the most recent comprehensive review of the trust terms, investment strategy, and beneficiary circumstances.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the trust account and investment strategy.',
    `notes` STRING COMMENT 'Free-form text field for recording additional information, special instructions, or administrative notes related to the trust account.',
    `primary_beneficiary_name` STRING COMMENT 'Full legal name of the primary beneficiary entitled to receive distributions from the trust.',
    `regulatory_classification` STRING COMMENT 'Regulatory category of the trust for compliance and reporting purposes under applicable securities and tax laws.. Valid values are `qualified|non_qualified|erisa|charitable|foreign_grantor`',
    `revocable_flag` BOOLEAN COMMENT 'Indicates whether the grantor retains the right to revoke, amend, or terminate the trust during their lifetime.',
    `risk_profile` STRING COMMENT 'Risk tolerance classification for the trust investment strategy based on trust terms and beneficiary requirements.. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `spendthrift_provision_flag` BOOLEAN COMMENT 'Indicates whether the trust includes a spendthrift clause restricting beneficiary ability to transfer or pledge trust interests and protecting assets from creditors.',
    `successor_trustee_name` STRING COMMENT 'Name of the designated successor trustee who will assume fiduciary duties upon the current trustees resignation, incapacity, or death.',
    `tax_treatment_code` STRING COMMENT 'IRS classification code indicating the tax treatment and reporting requirements for the trust.. Valid values are `grantor|simple|complex|charitable|foreign`',
    `termination_date` DATE COMMENT 'Date on which the trust was terminated and all assets were distributed to beneficiaries or transferred according to trust terms.',
    `termination_event` STRING COMMENT 'Description of the event or condition that triggered the termination of the trust, such as beneficiary reaching specified age or grantor death.',
    `trust_account_number` STRING COMMENT 'Externally visible unique account number assigned to the trust account for client communication and regulatory reporting.',
    `trust_instrument_date` DATE COMMENT 'Date on which the trust instrument or declaration was executed and legally established.',
    `trust_name` STRING COMMENT 'Legal name of the trust as registered in the trust instrument or declaration.',
    `trust_purpose` STRING COMMENT 'Stated purpose and intent of the trust as documented in the trust instrument, describing the grantors objectives.',
    `trust_status` STRING COMMENT 'Current operational status of the trust account in its lifecycle.. Valid values are `active|pending|suspended|terminated|in_administration|under_review`',
    `trust_tax_identifier` STRING COMMENT 'Employer Identification Number (EIN) or Tax Identification Number assigned to the trust for tax reporting purposes.',
    `trust_type` STRING COMMENT 'Classification of the trust structure indicating the legal and tax treatment of the trust arrangement. [ENUM-REF-CANDIDATE: revocable|irrevocable|testamentary|living|charitable|special_needs|grantor_retained|qualified_personal_residence — 8 candidates stripped; promote to reference product]',
    `trustee_name` STRING COMMENT 'Full legal name of the individual or institution serving as trustee with fiduciary responsibility for managing trust assets.',
    `trustee_type` STRING COMMENT 'Classification of the trustee role indicating whether the trustee is an individual or institutional fiduciary.. Valid values are `individual|corporate|co_trustee|successor`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this trust account record was last modified.',
    CONSTRAINT pk_trust_account PRIMARY KEY(`trust_account_id`)
) COMMENT 'Trust and fiduciary account record for wealth management clients. Captures trust type, grantor, trustee, beneficiaries, trust terms, distribution provisions, and fiduciary duty classification.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_parent_allocation_asset_allocation_id` FOREIGN KEY (`parent_allocation_asset_allocation_id`) REFERENCES `banking_ecm`.`wealth`.`asset_allocation`(`asset_allocation_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ADD CONSTRAINT `fk_wealth_portfolio_holding_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_rebalancing_order_id` FOREIGN KEY (`rebalancing_order_id`) REFERENCES `banking_ecm`.`wealth`.`rebalancing_order`(`rebalancing_order_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_asset_allocation_id` FOREIGN KEY (`asset_allocation_id`) REFERENCES `banking_ecm`.`wealth`.`asset_allocation`(`asset_allocation_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_superseded_by_assessment_suitability_assessment_id` FOREIGN KEY (`superseded_by_assessment_suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ADD CONSTRAINT `fk_wealth_fee_schedule_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `banking_ecm`.`wealth`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `banking_ecm`.`wealth`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_omnibus_parent_account_id` FOREIGN KEY (`omnibus_parent_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_portfolio_transaction_id` FOREIGN KEY (`portfolio_transaction_id`) REFERENCES `banking_ecm`.`wealth`.`portfolio_transaction`(`portfolio_transaction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_wash_sale_reference_lot_id` FOREIGN KEY (`wash_sale_reference_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_parent_trust_account_id` FOREIGN KEY (`parent_trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`wealth` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`wealth` SET TAGS ('dbx_domain' = 'wealth');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `risk_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Client Risk Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Activation Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `aum_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Amount');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `aum_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `derivatives_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Derivatives Allowed Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `esg_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `high_water_mark` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Inception Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_horizon` SET TAGS ('dbx_business_glossary_term' = 'Investment Horizon');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_horizon` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term|perpetual');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `last_rebalance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rebalance Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `leverage_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Leverage Allowed Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `managed_portfolio_status` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Status');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `managed_portfolio_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|terminated|pending_activation|under_review');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `mandate_type` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `mandate_type` SET TAGS ('dbx_value_regex' = 'discretionary|advisory|execution_only');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `next_rebalance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rebalance Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `performance_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `portfolio_name` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Name');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `portfolio_number` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Number');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `portfolio_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `portfolio_strategy` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Strategy');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'retail|professional|eligible_counterparty');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `shariah_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Shariah Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `short_selling_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Selling Allowed Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = '^[A-Z_]{3,30}$');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Status');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'taxable|tax_exempt|tax_deferred|non_resident');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Termination Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `annual_withdrawal_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Withdrawal Amount');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `annual_withdrawal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `concentration_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `esg_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Exclusions');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `esg_preference` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Preference');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `esg_preference` SET TAGS ('dbx_value_regex' = 'none|basic|advanced|impact_focused');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `fee_structure` SET TAGS ('dbx_value_regex' = 'aum_based|flat_fee|performance_based|hybrid');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restrictions');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `investment_objective` SET TAGS ('dbx_value_regex' = 'capital_preservation|income_generation|balanced_growth|capital_appreciation|aggressive_growth');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `ips_number` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Number');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `ips_status` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Status');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `ips_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Type');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `ips_type` SET TAGS ('dbx_value_regex' = 'proposal|approved_ips|amended_ips');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `ips_version` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Version');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `liquidity_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Requirement Description');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `management_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `management_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `performance_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `performance_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `prohibited_securities` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Securities');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|threshold_based');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `rebalancing_trigger_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `regulatory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Restrictions');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `return_objective_description` SET TAGS ('dbx_business_glossary_term' = 'Return Objective Description');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `risk_capacity` SET TAGS ('dbx_business_glossary_term' = 'Risk Capacity');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `risk_capacity` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `risk_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `risk_tolerance` SET TAGS ('dbx_value_regex' = 'conservative|moderately_conservative|moderate|moderately_aggressive|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `sector_exclusions` SET TAGS ('dbx_business_glossary_term' = 'Sector Exclusions');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `target_annual_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Annual Return Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `tax_considerations` SET TAGS ('dbx_business_glossary_term' = 'Tax Considerations');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Status');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'taxable|tax_deferred|tax_exempt');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `time_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Time Horizon (Years)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `asset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation ID');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Reference ID');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `parent_allocation_asset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Allocation ID');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `actual_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Weight Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Allocation Hierarchy Level');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Name');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Notes');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Status');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|under_review|archived');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Type');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'strategic|tactical|dynamic|model');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equities|fixed_income|alternatives|cash|real_estate|commodities');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `correlation_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Correlation Coefficient');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `drift_percent` SET TAGS ('dbx_business_glossary_term' = 'Drift Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `drift_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Drift Threshold Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `esg_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Alignment Flag');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `expected_return_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `expected_volatility_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Volatility Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `geographic_allocation` SET TAGS ('dbx_business_glossary_term' = 'Geographic Allocation');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `last_rebalanced_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rebalanced Date');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'highly_liquid|liquid|moderately_liquid|illiquid');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `maximum_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `minimum_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Weight Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `rebalancing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Required Flag');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `risk_tolerance_alignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Alignment');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `risk_tolerance_alignment` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `target_weight_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Weight Percent');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `tax_efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Tax Efficiency Rating');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `tax_efficiency_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `portfolio_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Holding Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `as_of_date` SET TAGS ('dbx_business_glossary_term' = 'As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `base_currency_market_value` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `cost_basis_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Method');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `cost_basis_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|specific_identification|average_cost|highest_cost|lowest_cost');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Classification');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_value_regex' = 'short_term|long_term');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `income_type` SET TAGS ('dbx_business_glossary_term' = 'Income Type Classification');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `income_type` SET TAGS ('dbx_value_regex' = 'qualified_dividend|ordinary_dividend|interest|capital_gain|tax_exempt|return_of_capital');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `investment_objective` SET TAGS ('dbx_value_regex' = 'growth|income|balanced|capital_preservation|aggressive_growth|speculation');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `lot_acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Acquisition Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `lot_acquisition_price` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Acquisition Price');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `lot_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|closed|partially_closed|transferred|corporate_action');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `pledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Pledged Collateral Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `portfolio_weight` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Weight Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Holding Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Security Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `total_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `unit_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `unrealized_gain_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_holding` ALTER COLUMN `wash_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Wash Sale Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `portfolio_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Transaction ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Digital Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `rebalancing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Event ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `action_ratio` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `commission` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `corporate_action_type` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'cash|stock|mixed|default');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `ex_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Dividend Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `income_type` SET TAGS ('dbx_business_glossary_term' = 'Income Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `settlement_instruction` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `settlement_instruction` SET TAGS ('dbx_value_regex' = 'dvp|rvp|fop|against_payment');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Message Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Method');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|average_cost|specific_identification|highest_cost');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed|reversed');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `nav_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `collateral_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `accrued_expenses` SET TAGS ('dbx_business_glossary_term' = 'Accrued Expenses');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'forward_pricing|backward_pricing|swing_pricing|dual_pricing');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `dividend_income` SET TAGS ('dbx_business_glossary_term' = 'Dividend Income');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Expense Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|mixed');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `gross_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Asset Value (GAV)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `interest_income` SET TAGS ('dbx_business_glossary_term' = 'Interest Income');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `management_fee_accrual` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Accrual');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `nav_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Change Amount');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `nav_change_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Change Percent');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `net_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `net_cash_flow` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `performance_fee_accrual` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Accrual');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `prior_nav` SET TAGS ('dbx_business_glossary_term' = 'Prior Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance_identified|escalated|resolved');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `redemptions_amount` SET TAGS ('dbx_business_glossary_term' = 'Redemptions Amount');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `subscriptions_amount` SET TAGS ('dbx_business_glossary_term' = 'Subscriptions Amount');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `swing_factor_applied` SET TAGS ('dbx_business_glossary_term' = 'Swing Factor Applied');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `total_expenses` SET TAGS ('dbx_business_glossary_term' = 'Total Expenses');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `units_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Units Outstanding');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_value_regex' = 'mark_to_market|mark_to_model|net_asset_value|discounted_cash_flow|comparable_transactions|cost');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `rebalancing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Order Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Digital Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `asset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `actual_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution Date');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `actual_transaction_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Transaction Cost');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `approval_workflow_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Stage');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `approval_workflow_stage` SET TAGS ('dbx_value_regex' = 'not_required|pending_advisor|pending_compliance|pending_client|approved|rejected');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `drift_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Drift Tolerance Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `estimated_tax_benefit` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Benefit');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `estimated_transaction_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Transaction Cost');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `execution_venue` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `ips_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Compliance Flag');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Order Notes');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Order Number');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Order Status');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `portfolio_nav_at_execution` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Net Asset Value (NAV) at Execution');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `portfolio_nav_at_trigger` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Net Asset Value (NAV) at Trigger');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `post_rebalance_drift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Post-Rebalance Drift Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `pre_rebalance_drift_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pre-Rebalance Drift Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `proposed_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Execution Date');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `rebalancing_method` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Method');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `rebalancing_method` SET TAGS ('dbx_value_regex' = 'cash_flow|threshold|calendar|optimization');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `source_system_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Order Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `tax_loss_harvesting_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax-Loss Harvesting Flag');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `total_estimated_trade_value` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Trade Value');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `trade_instruction_count` SET TAGS ('dbx_business_glossary_term' = 'Trade Instruction Count');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Date');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Type');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `trigger_type` SET TAGS ('dbx_value_regex' = 'drift_threshold|ips_mandate_change|model_portfolio_update|client_instruction|periodic_review|tax_loss_harvesting');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `wash_sale_check_status` SET TAGS ('dbx_business_glossary_term' = 'Wash Sale Check Status');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `wash_sale_check_status` SET TAGS ('dbx_value_regex' = 'not_applicable|passed|warning|blocked');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `performance_return_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Return ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `active_return` SET TAGS ('dbx_business_glossary_term' = 'Active Return (Alpha)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `annualized_return` SET TAGS ('dbx_business_glossary_term' = 'Annualized Return');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `annualized_volatility` SET TAGS ('dbx_business_glossary_term' = 'Annualized Volatility');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `attribution_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Attribution Available Flag');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `beginning_market_value` SET TAGS ('dbx_business_glossary_term' = 'Beginning Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `benchmark_return` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Return');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `calculated_by` SET TAGS ('dbx_business_glossary_term' = 'Calculated By');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'modified_dietz|true_twr|daily_valuation|approximate_twr');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|restated|verified');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `composite_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Composite Member Flag');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `downside_deviation` SET TAGS ('dbx_business_glossary_term' = 'Downside Deviation');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `ending_market_value` SET TAGS ('dbx_business_glossary_term' = 'Ending Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `gips_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Investment Performance Standards (GIPS) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `income_earned` SET TAGS ('dbx_business_glossary_term' = 'Income Earned');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `information_ratio` SET TAGS ('dbx_business_glossary_term' = 'Information Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `management_fees` SET TAGS ('dbx_business_glossary_term' = 'Management Fees');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `maximum_drawdown` SET TAGS ('dbx_business_glossary_term' = 'Maximum Drawdown');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `mwr_return` SET TAGS ('dbx_business_glossary_term' = 'Money-Weighted Return (MWR) / Internal Rate of Return (IRR)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `net_cash_flow` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'daily|month_to_date|quarter_to_date|year_to_date|since_inception|custom');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain/Loss');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `risk_free_rate` SET TAGS ('dbx_business_glossary_term' = 'Risk-Free Rate');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `sharpe_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sharpe Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `sortino_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sortino Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `total_contributions` SET TAGS ('dbx_business_glossary_term' = 'Total Contributions');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `total_withdrawals` SET TAGS ('dbx_business_glossary_term' = 'Total Withdrawals');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `tracking_error` SET TAGS ('dbx_business_glossary_term' = 'Tracking Error');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `twr_gross_return` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR) Gross Return');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `twr_net_return` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR) Net Return');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain/Loss');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `aum_at_inception` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) at Inception');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `authorized_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `discretionary_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Discretionary Limit Amount');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'us_person|non_us_person|recalcitrant|exempt');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_value_regex' = 'fixed|tiered|performance_based|hybrid|flat_fee');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_name` SET TAGS ('dbx_business_glossary_term' = 'Mandate Name');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_number` SET TAGS ('dbx_business_glossary_term' = 'Mandate Reference Number');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_business_glossary_term' = 'Mandate Status');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_activation|under_review|closed');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_value_regex' = 'discretionary|advisory|execution_only|hybrid');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `minimum_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Amount');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `performance_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|threshold_based|discretionary');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'retail|professional|eligible_counterparty|per_se_professional|elective_professional');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|on_demand');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `tax_reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Jurisdiction');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `tax_reporting_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `termination_conditions` SET TAGS ('dbx_business_glossary_term' = 'Termination Conditions');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Termination Date');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment ID');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `individual_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Individual Profile Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `superseded_by_assessment_suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Assessment ID');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `alternative_investments_suitability` SET TAGS ('dbx_business_glossary_term' = 'Alternative Investments Suitability');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `alternative_investments_suitability` SET TAGS ('dbx_value_regex' = 'not_suitable|suitable_limited|suitable_moderate|suitable_significant');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `annual_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Income Amount');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `annual_income_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `annual_income_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|requires_escalation');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `assessment_outcome` SET TAGS ('dbx_value_regex' = 'suitable|not_suitable|suitable_with_conditions|requires_review');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|periodic_review|triggered_review|ad_hoc');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `assessor_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessor Notes');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `complex_products_suitability` SET TAGS ('dbx_business_glossary_term' = 'Complex Products Suitability');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `complex_products_suitability` SET TAGS ('dbx_value_regex' = 'not_suitable|suitable_limited|suitable_moderate|suitable_full');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `concentration_risk_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Concentration Risk Tolerance');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `concentration_risk_tolerance` SET TAGS ('dbx_value_regex' = 'low|moderate|high');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `esg_preference_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Preference Category');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `esg_preference_category` SET TAGS ('dbx_value_regex' = 'none|exclusionary|positive_screening|impact_investing|thematic');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `esg_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Preference Flag');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investable_assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Investable Assets Amount');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investable_assets_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investable_assets_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Investment Experience Years');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_knowledge_level` SET TAGS ('dbx_business_glossary_term' = 'Investment Knowledge Level');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_knowledge_level` SET TAGS ('dbx_value_regex' = 'basic|informed|advanced|expert');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_objective_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_objective_primary` SET TAGS ('dbx_value_regex' = 'capital_preservation|income_generation|balanced_growth|capital_appreciation|speculation');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_objective_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_objective_secondary` SET TAGS ('dbx_value_regex' = 'capital_preservation|income_generation|balanced_growth|capital_appreciation|tax_efficiency|liquidity');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `investment_time_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Investment Time Horizon Years');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `leverage_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Leverage Tolerance');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `leverage_tolerance` SET TAGS ('dbx_value_regex' = 'none|conservative|moderate|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `liquid_assets_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquid Assets Amount');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `liquid_assets_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `liquid_assets_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `liquidity_needs_description` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Needs Description');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `loss_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Loss Capacity Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Worth Amount');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `net_worth_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'mifid_ii|sec_reg_bi|finra_2111|iosco|local');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `restrictions_notes` SET TAGS ('dbx_business_glossary_term' = 'Restrictions Notes');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `risk_tolerance_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Category');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `risk_tolerance_category` SET TAGS ('dbx_value_regex' = 'conservative|moderately_conservative|moderate|moderately_aggressive|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `risk_tolerance_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Score');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `suitability_score` SET TAGS ('dbx_business_glossary_term' = 'Suitability Score');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Status');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `tax_status` SET TAGS ('dbx_value_regex' = 'taxable|tax_deferred|tax_exempt|non_resident');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `tax_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `time_horizon_category` SET TAGS ('dbx_business_glossary_term' = 'Time Horizon Category');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `time_horizon_category` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term|multi_generational');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `active_client_count` SET TAGS ('dbx_business_glossary_term' = 'Active Client Count');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|suspended|retired');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `esg_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `expected_return_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `expected_volatility_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Volatility Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Inception Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `investment_policy_statement_url` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) URL');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `investment_policy_statement_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `minimum_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Investment Amount');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Code');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Name');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_portfolio_description` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Description');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `rebalancing_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Threshold Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'conservative|balanced|growth|aggressive|income|capital_preservation');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `shariah_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Shariah Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `sharpe_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sharpe Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `strategic_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Allocation Flag');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `suitability_criteria` SET TAGS ('dbx_business_glossary_term' = 'Suitability Criteria');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `tactical_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Tactical Allocation Flag');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `target_aum` SET TAGS ('dbx_business_glossary_term' = 'Target Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `target_client_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Client Segment');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `tax_optimization_strategy` SET TAGS ('dbx_business_glossary_term' = 'Tax Optimization Strategy');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `tax_optimization_strategy` SET TAGS ('dbx_value_regex' = 'none|tax_loss_harvesting|municipal_bonds|qualified_dividends|long_term_capital_gains');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `total_aum` SET TAGS ('dbx_business_glossary_term' = 'Total Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Wealth Fee Schedule ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'not_accrued|accruing|accrued|reversed');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `aum_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Basis Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `aum_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Calculation Method');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `aum_calculation_method` SET TAGS ('dbx_value_regex' = 'beginning_balance|ending_balance|average_daily|average_monthly');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|per_transaction|on_demand');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `billing_in_advance_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing In Advance Flag');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'aum_percentage|flat|tiered|performance_based|transaction_based|hybrid');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'management|performance|advisory|custody|transaction|administration');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `gl_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Reference');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `gross_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `high_water_mark` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `invoice_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'portfolio_deduction|wire_transfer|ach|check|direct_debit');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `performance_hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Hurdle Rate');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `regulatory_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Flag');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `tier_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Tier Lower Bound');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `tier_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Tier Upper Bound');
ALTER TABLE `banking_ecm`.`wealth`.`fee_schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Version');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Billing ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Wealth Fee Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `payment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `aum_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Basis Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `aum_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `aum_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Discount Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `gross_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Notes');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'portfolio_debit|wire_transfer|ach|check|credit_card');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `tax_withholding_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Rate');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` SET TAGS ('dbx_subdomain' = 'operational_custody');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Fee Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `omnibus_parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Omnibus Parent Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Custodian Institution Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `payment_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Payment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_opening_documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Documentation Complete Flag');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Status');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|frozen|restricted|closed|pending_opening');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Type');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'custody|settlement|cash|margin|omnibus|segregated');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `authorized_signatory_list` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory List');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `authorized_signatory_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `cass_classification` SET TAGS ('dbx_business_glossary_term' = 'Client Assets Sourcebook (CASS) Classification');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `cass_classification` SET TAGS ('dbx_value_regex' = 'cass_5|cass_6|cass_7|not_applicable');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `collateral_management_enabled` SET TAGS ('dbx_business_glossary_term' = 'Collateral Management Enabled Flag');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `corporate_action_election_method` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Election Method');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `corporate_action_election_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|custodian_discretion');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Email Address');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Name');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Phone Number');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `margin_lending_enabled` SET TAGS ('dbx_business_glossary_term' = 'Margin Lending Enabled Flag');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending_review|exception');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `regulatory_reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Jurisdiction');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `regulatory_reporting_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `securities_lending_enabled` SET TAGS ('dbx_business_glossary_term' = 'Securities Lending Enabled Flag');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_business_glossary_term' = 'Asset Segregation Requirement');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `segregation_requirement` SET TAGS ('dbx_value_regex' = 'client_segregated|pooled|partially_segregated');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `settlement_instruction_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Method');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `settlement_instruction_method` SET TAGS ('dbx_value_regex' = 'swift|fax|electronic_portal|api|manual');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `sub_custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Sub-Custodian Account Number');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `sub_custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Accounting Method');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|specific_identification|average_cost');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` SET TAGS ('dbx_subdomain' = 'operational_custody');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `portfolio_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `wash_sale_reference_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wash Sale Reference Lot Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `accrued_income_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `acquisition_price` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Price');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `adjusted_cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Cost Basis Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `commission_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `corporate_action_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Adjustment Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `cost_basis_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Method');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `cost_basis_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|specific_identification|average_cost|HIFO');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `current_market_value` SET TAGS ('dbx_business_glossary_term' = 'Current Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `disposal_price` SET TAGS ('dbx_business_glossary_term' = 'Disposal Price');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `donor_cost_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Donor Cost Basis Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `fair_market_value_at_gift_date` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) at Gift Date');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `gift_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Inheritance Flag');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Classification');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_value_regex' = 'short_term|long_term|undetermined');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Number');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|closed|partially_closed|pending_settlement|suspended');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `noncovered_security_flag` SET TAGS ('dbx_business_glossary_term' = 'Noncovered Security Flag');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `original_quantity` SET TAGS ('dbx_business_glossary_term' = 'Original Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `realized_gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain Loss Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting Category');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `reporting_category` SET TAGS ('dbx_value_regex' = 'Form_1099B|Form_8949|Schedule_D|other');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `specific_identification_flag` SET TAGS ('dbx_business_glossary_term' = 'Specific Identification Flag');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_loss_harvesting_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Loss Harvesting Candidate Flag');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'taxable|tax_deferred|tax_exempt|qualified|non_qualified');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `unrealized_gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain Loss Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `unrealized_gain_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain Loss Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `wash_sale_disallowed_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Wash Sale Disallowed Loss Amount');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `wash_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Wash Sale Flag');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `parent_trust_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `aum_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Amount');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `aum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `aum_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|discretionary|event_driven');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `distribution_provision_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Provision Type');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `distribution_provision_type` SET TAGS ('dbx_value_regex' = 'discretionary|mandatory|income_only|principal_and_income|unitrust|annuity');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'us_person|specified_us_person|non_us|exempt|passive_nffe|active_nffe');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `fiduciary_duty_classification` SET TAGS ('dbx_business_glossary_term' = 'Fiduciary Duty Classification');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `fiduciary_duty_classification` SET TAGS ('dbx_value_regex' = 'trustee|executor|administrator|guardian|conservator|custodian');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Grantor Tax Identification Number (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Notes');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Name');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `primary_beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'qualified|non_qualified|erisa|charitable|foreign_grantor');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `revocable_flag` SET TAGS ('dbx_business_glossary_term' = 'Revocable Flag');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `spendthrift_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Spendthrift Provision Flag');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `successor_trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Successor Trustee Name');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'grantor|simple|complex|charitable|foreign');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Termination Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `termination_event` SET TAGS ('dbx_business_glossary_term' = 'Trust Termination Event');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_account_number` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Number');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_instrument_date` SET TAGS ('dbx_business_glossary_term' = 'Trust Instrument Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_name` SET TAGS ('dbx_business_glossary_term' = 'Trust Name');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_purpose` SET TAGS ('dbx_business_glossary_term' = 'Trust Purpose');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_status` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Status');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|in_administration|under_review');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Trust Tax Identification Number (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trust_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Type');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trustee_type` SET TAGS ('dbx_business_glossary_term' = 'Trustee Type');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `trustee_type` SET TAGS ('dbx_value_regex' = 'individual|corporate|co_trustee|successor');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
