-- Schema for Domain: wealth | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`wealth` COMMENT 'Wealth management and private banking including portfolio construction, asset allocation, AUM tracking, NAV calculation, client reporting, rebalancing, and investment policy statements. Manages high-net-worth and ultra-high-net-worth client relationships and suitability assessments. Primary system of record aligned with SimCorp Dimension / BlackRock Aladdin.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`managed_portfolio` (
    `managed_portfolio_id` BIGINT COMMENT 'Unique identifier for the managed portfolio. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Formalizes portfolio benchmark reference for performance attribution, tracking error calculation, Sharpe ratio computation, and client reporting. Replaces string benchmark_code with proper FK to maste',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Portfolio performance is measured against benchmarks for client reporting. Manager evaluation, performance attribution, and client review meetings require valid benchmark reference.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Wealth portfolios maintain linked deposit accounts for cash sweep arrangements, dividend collection, trade settlement proceeds, and liquidity management. Essential for portfolio cash management operat',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or private banker responsible for this client portfolio.',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: Managed portfolios trading derivatives require ISDA master agreements and CSAs for legal framework and collateral terms. Links portfolio authorization to trade under specific agreements, enables margi',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Credit-focused portfolios (corporate bonds, loans) create counterparty credit exposure requiring EAD, RWA, and ECL calculations. Risk reporting aggregates exposure by portfolio for concentration monit',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Wealth portfolios require funds transfer pricing for management accounting and client profitability analysis. Business process: treasury charges/credits wealth business for liquidity consumed/provided',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Wealth portfolios commonly hold fund investments (mutual funds, ETFs, hedge funds) as core holdings. Required for portfolio valuation, performance attribution, asset allocation reporting, and regulato',
    `investment_mandate_id` BIGINT COMMENT 'Reference to the client mandate that defines the contractual terms and investment authority for this portfolio.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: When wealth portfolios invest in funds, they require investor account registration at the fund level. Required for subscription/redemption processing, statement generation, tax reporting, and regulato',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Portfolio opening, material changes, or periodic reviews trigger KYC review cycles per CDD/EDD regulatory requirements. Links portfolio lifecycle events to mandatory customer due diligence processes r',
    `liquidity_metric_id` BIGINT COMMENT 'Foreign key linking to risk.liquidity_metric. Business justification: Portfolios with illiquid holdings (alternatives, private equity) impact firm-wide LCR/NSFR calculations. Treasury must track which portfolios contribute to liquidity stress and encumbered asset calcul',
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Trading portfolios generate market risk positions tracked for VaR, stress testing, and regulatory capital (FRTB). Risk systems must link portfolio to its market risk metrics for daily P&L attribution ',
    `model_portfolio_id` BIGINT COMMENT 'Reference to the model portfolio template used for asset allocation targets and rebalancing guidance.',
    `party_id` BIGINT COMMENT 'Reference to the high-net-worth (HNW) or ultra-high-net-worth (UHNW) client who owns this portfolio.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Portfolios are serviced through primary channels (digital platform, branch, private banking). Required for channel preference tracking, service delivery routing, regulatory channel-of-record documenta',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Portfolios generate management and performance fee revenue that must post to specific GL revenue accounts for P&L reporting and revenue recognition. Banking operations require mapping each portfolios',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Portfolio status uses standardized codes (active, closed, suspended) for operational workflow. Portfolio administration, fee billing, and reporting require code list reference for status management.',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: CCAR/DFAST stress testing requires portfolio-level projections of losses, revenues, and capital impact. Each portfolio participates in regulatory stress runs; link enables portfolio-to-stressed-result',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Wealth portfolios executing through institutional trading desks: large block orders and illiquid securities are routed to trading books for execution. Enables portfolio rebalancing workflow tracking a',
    `investment_portfolio_id` BIGINT COMMENT 'Foreign key linking to treasury.investment_portfolio. Business justification: Wealth portfolios allocate client assets into treasury-managed fixed income portfolios (government bonds, corporate bonds) for capital preservation and liquidity management. Required for consolidated ',
    `activation_date` DATE COMMENT 'Date when the portfolio became active and available for trading and management.',
    `aum_amount` DECIMAL(18,2) COMMENT 'Total market value of assets under management in the portfolio, expressed in the base currency. Updated daily based on market valuations.',
    `aum_as_of_date` DATE COMMENT 'Date as of which the AUM amount was calculated, typically the most recent business day.',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency for portfolio valuation and reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio record was first created in the system.',
    `custodian_account_id` BIGINT COMMENT 'Reference to the custodian account where the portfolio assets are held for safekeeping.',
    `derivatives_allowed_flag` BOOLEAN COMMENT 'Indicates whether the portfolio is permitted to invest in derivative instruments (options, futures, swaps).',
    `esg_compliant_flag` BOOLEAN COMMENT 'Indicates whether the portfolio follows ESG investment criteria and sustainability guidelines.',
    `fee_schedule_code` STRING COMMENT 'Code referencing the fee structure and pricing schedule applicable to this portfolio (e.g., management fees, performance fees, custody fees).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `high_water_mark` DECIMAL(18,2) COMMENT 'Highest Net Asset Value (NAV) level reached by the portfolio, used to calculate performance fees. Ensures performance fees are only charged on new gains.',
    `inception_date` DATE COMMENT 'Date when the portfolio was first established and assets were initially allocated.',
    `investment_horizon` STRING COMMENT 'Expected time horizon for the investment: short-term (< 3 years), medium-term (3-10 years), long-term (> 10 years), or perpetual.. Valid values are `short_term|medium_term|long_term|perpetual`',
    `investment_policy_statement_id` BIGINT COMMENT 'Reference to the Investment Policy Statement that governs the investment strategy, objectives, constraints, and guidelines for this portfolio.',
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
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Client IPS risk tolerance must align with firms board-approved risk appetite framework. Compliance reviews verify IPS parameters (leverage, concentration, VaR limits) fall within firm risk appetite t',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: IPS documents require formal approval through specific channels (branch meeting, digital signature, video conference). Essential for MiFID II/Reg BI compliance audit trail, client consent documentatio',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: IPS documents specify return objectives, liquidity requirements, and withdrawal amounts in base currency. Suitability assessment and mandate setup require valid currency reference for client constrain',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Links IPS benchmark reference to master benchmark data for suitability assessment, performance monitoring, and regulatory compliance (MiFID II suitability). Enables consistent benchmark usage across p',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager responsible for this client mandate.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: IPS documents reference approved or restricted funds for client portfolios. Required for compliance monitoring, suitability assessment, investment restriction enforcement, and documenting fund-level c',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: IPS documents inform KYC risk assessments and suitability determinations. Compliance teams review IPS during KYC cycles to validate investment objectives align with customer profile, risk tolerance, a',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: IPS documents are prepared and approved within specific business units for governance oversight, compliance tracking (MiFID II suitability), and audit trail. Required for regulatory examinations and i',
    `party_id` BIGINT COMMENT 'Reference to the client (party) for whom this IPS is established.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio governed by this IPS.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that created the IPS record.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Risk tolerance uses standardized scale (conservative, moderate, aggressive) for suitability. Asset allocation decisions, model portfolio assignment, and IPS compliance require code list reference.',
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
    `suitability_assessment_date` DATE COMMENT 'Date the most recent suitability assessment was completed to ensure the IPS aligns with client circumstances and objectives.',
    `suitability_status` STRING COMMENT 'Current suitability determination: suitable (IPS aligns with client profile), review_required (circumstances changed), or unsuitable (IPS no longer appropriate).. Valid values are `suitable|review_required|unsuitable`',
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
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Asset classes use standardized taxonomy (equity, fixed income, alternatives) for allocation. Portfolio construction, rebalancing, and risk reporting require code list reference for consistent classifi',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Links strategic asset allocation benchmarks to master data for rebalancing triggers, drift monitoring, and performance evaluation. Ensures consistent benchmark definitions across asset allocation fram',
    `investment_policy_statement_id` BIGINT COMMENT 'Reference identifier linking this allocation to the governing Investment Policy Statement document or section.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio or model portfolio to which this asset allocation applies.',
    `parent_allocation_asset_allocation_id` BIGINT COMMENT 'Reference to the parent asset allocation record in a hierarchical allocation structure (nullable for top-level allocations).',
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

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` (
    `wealth_portfolio_holding_id` BIGINT COMMENT 'Unique identifier for each portfolio holding record. Primary key for the portfolio holding entity.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Holdings are classified by asset class for portfolio analytics. Asset allocation reporting, drift analysis, and IPS compliance monitoring require code list reference.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Portfolio holdings often originate from investment banking offerings (IPOs, secondary offerings). Real business process: tracking offering provenance for holdings to support client reporting, performa',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Individual securities in wealth portfolios are pledged as collateral for credit facilities. Real business process: securities-based lending where specific holdings secure loans. Operations require tra',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Holdings include fund units (mutual funds, ETFs). Required for position reporting, NAV-based valuation, fund-level analytics, and distinguishing fund holdings from direct security holdings. Core wealt',
    `instrument_id` BIGINT COMMENT 'Internal reference to the security master record for this holding.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Holdings have issuer domicile for country risk reporting. Geographic concentration limits, IPS compliance, and country risk exposure analysis require issuer country reference for every security positi',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Enables issuer-level concentration risk monitoring, credit exposure analysis, and regulatory large exposure reporting (CRR Article 392). Supports portfolio risk management by aggregating exposure acro',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio that contains this holding. Links to the portfolio master record.',
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Individual security holdings feed market risk calculations (delta, VaR, stress scenarios). Risk systems aggregate holding-level sensitivities to portfolio/desk/firm VaR for daily risk reporting and re',
    `party_id` BIGINT COMMENT 'Reference to the custodian institution holding the security on behalf of the portfolio.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Holdings are identified by ISIN/CUSIP for security master lookup. Corporate action processing, pricing, and regulatory reporting (MiFID II) require valid instrument identifier reference.',
    `tax_lot_id` BIGINT COMMENT 'Unique identifier for the specific tax lot within the holding. Enables lot-level tracking for tax optimization strategies.',
    `investment_portfolio_id` BIGINT COMMENT 'Foreign key linking to treasury.investment_portfolio. Business justification: Individual wealth holdings may represent participations in treasury-managed fixed income funds or bond portfolios. Business process: consolidated position reporting, look-through exposure analysis for',
    `accrued_income` DECIMAL(18,2) COMMENT 'Income earned but not yet received on the holding, such as accrued interest on bonds or accrued dividends on equities. Included in total portfolio valuation.',
    `acquisition_date` DATE COMMENT 'Date when the security position was originally acquired or established in the portfolio. Used for holding period determination and tax lot tracking.',
    `as_of_date` DATE COMMENT 'Point-in-time date for which this holding record represents the position. Enables historical position reconstruction and time-series analysis.',
    `base_currency_market_value` DECIMAL(18,2) COMMENT 'Market value of the holding converted to the portfolio base currency using the FX rate. Used for consolidated portfolio reporting and Assets Under Management (AUM) calculation.',
    `cost_basis_method` STRING COMMENT 'Accounting method used to determine which tax lots are sold first for capital gains calculation. Critical for tax-loss harvesting and capital gains optimization strategies.. Valid values are `fifo|lifo|specific_identification|average_cost|highest_cost|lowest_cost`',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the denomination of the security. Used for foreign exchange (FX) exposure analysis and multi-currency portfolio reporting.. Valid values are `^[A-Z]{3}$`',
    `custodian_account_number` STRING COMMENT 'External account identifier at the custodian bank where the security is held. Used for reconciliation and settlement operations.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert the security value from its native currency to the portfolio base currency as of the as-of date.',
    `holding_period_classification` STRING COMMENT 'Tax classification based on holding period. Short-term applies to positions held one year or less; long-term applies to positions held more than one year. Determines capital gains tax rate.. Valid values are `short_term|long_term`',
    `income_type` STRING COMMENT 'Tax classification of income generated by the holding. Determines tax treatment and reporting requirements for client tax documents.. Valid values are `qualified_dividend|ordinary_dividend|interest|capital_gain|tax_exempt|return_of_capital`',
    `investment_objective` STRING COMMENT 'Strategic investment goal associated with this holding within the portfolio strategy. Used for suitability assessment and investment policy statement (IPS) compliance.. Valid values are `growth|income|balanced|capital_preservation|aggressive_growth|speculation`',
    `lot_acquisition_date` DATE COMMENT 'Date when this specific tax lot was acquired. Used to determine short-term versus long-term capital gains treatment.',
    `lot_acquisition_price` DECIMAL(18,2) COMMENT 'Per-unit purchase price for this specific tax lot including transaction costs allocated to the lot.',
    `lot_quantity` DECIMAL(18,2) COMMENT 'Number of units in this specific tax lot. Sum of all lot quantities equals the total holding quantity.',
    `lot_status` STRING COMMENT 'Current lifecycle status of the tax lot indicating whether it is still held, has been sold, or affected by corporate actions.. Valid values are `open|closed|partially_closed|transferred|corporate_action`',
    `market_price` DECIMAL(18,2) COMMENT 'Current market price per unit of the security as of the as-of date. Used for mark-to-market (MTM) valuation and Net Asset Value (NAV) calculation.',
    `market_value` DECIMAL(18,2) COMMENT 'Total market value of the holding calculated as quantity multiplied by market price. Primary input for Assets Under Management (AUM) calculation.',
    `pledged_flag` BOOLEAN COMMENT 'Indicates whether the holding is pledged as collateral for margin loans, derivatives positions, or other obligations. Critical for available liquidity calculations.',
    `portfolio_weight` DECIMAL(18,2) COMMENT 'Percentage of total portfolio market value represented by this holding. Used for asset allocation analysis and rebalancing decisions.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares of the security held in the portfolio as of the as-of date. Supports fractional shares for mutual funds and certain securities.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was first created in the portfolio management system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was last modified. Supports change tracking and reconciliation processes.',
    `restricted_flag` BOOLEAN COMMENT 'Indicates whether the holding is subject to trading restrictions such as lock-up periods, regulatory holds, or contractual limitations. Affects liquidity analysis and rebalancing decisions.',
    `risk_rating` STRING COMMENT 'Risk classification of the security based on volatility, credit quality, and market risk factors. Used for portfolio risk assessment and client suitability analysis.. Valid values are `low|moderate|high|very_high`',
    `settlement_date` DATE COMMENT 'Date when the most recent transaction affecting this holding was settled and ownership transferred. Follows T+1 or T+2 settlement conventions.',
    `source_system` STRING COMMENT 'Name of the upstream system that provided this holding record, such as SimCorp Dimension, BlackRock Aladdin, or custodian feed. Used for data lineage and reconciliation.',
    `total_cost_basis` DECIMAL(18,2) COMMENT 'Total acquisition cost of the holding including commissions and fees. Used for capital gains calculation and performance attribution.',
    `unit_cost_basis` DECIMAL(18,2) COMMENT 'Average cost per unit of the security for tax and performance calculation purposes. Calculated based on the cost basis method applied to all lots.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Difference between market value and total cost basis. Represents paper profit or loss on the holding that has not been realized through sale.',
    `unrealized_gain_loss_percent` DECIMAL(18,2) COMMENT 'Unrealized gain or loss expressed as a percentage of total cost basis. Used for performance reporting and client communication.',
    `wash_sale_flag` BOOLEAN COMMENT 'Indicates whether this holding is subject to wash sale rules, which disallow loss deductions when substantially identical securities are purchased within 30 days before or after a sale at a loss.',
    CONSTRAINT pk_wealth_portfolio_holding PRIMARY KEY(`wealth_portfolio_holding_id`)
) COMMENT 'Point-in-time and current holdings record for each security position within a managed portfolio, including tax lot-level detail. Captures security identifier (ISIN/CUSIP/SEDOL), quantity held, cost basis, market value, MTM price, unrealized gain/loss, weight in portfolio, settlement date, custodian account, as-of date, and lot-level attributes (acquisition date, acquisition price, lot quantity, cost basis method — FIFO/LIFO/specific identification/average cost, short-term vs long-term classification, wash sale flag, lot status). Primary source for AUM calculation, performance attribution, tax-loss harvesting, and capital gains optimization.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_transaction` (
    `portfolio_transaction_id` BIGINT COMMENT 'Unique identifier for the portfolio transaction record.',
    `aml_alert_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_alert. Business justification: Individual portfolio transactions trigger AML monitoring rules (structuring, rapid movement, high-risk geography) and generate alerts requiring investigation. Core transaction monitoring process linki',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or counterparty through which the transaction was executed.',
    `corporate_action_id` BIGINT COMMENT 'Identifier linking this transaction to a corporate action event if the transaction resulted from a corporate action (dividend, stock split, merger, etc.).',
    `custodian_account_id` BIGINT COMMENT 'Identifier of the custodial or investment account associated with this transaction.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Transactions execute through specific channels (online platform, mobile app, RM phone order, branch). Required for channel attribution reporting, differential fee calculation by channel, regulatory tr',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Transactions include fund subscriptions, redemptions, and switches. Required for transaction processing, settlement tracking, cost basis calculation, and reconciliation with fund transfer agency. Stan',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Portfolio cash transactions (subscriptions, redemptions, dividend receipts) generate payment instructions for settlement. Operations teams track which payment instruction settled each portfolio cash m',
    `instrument_id` BIGINT COMMENT 'Identifier of the security instrument involved in this transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Securities transactions generate journal entries for realized gains/losses, commission expense, settlement cash movements, and tax lot adjustments. Real banking process: trade settlement accounting re',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the managed portfolio in which this transaction occurred.',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Transaction failures (settlement breaks, trade errors, unauthorized trades) are Basel operational risk events requiring loss capture for SMA capital calculation. Link enables root-cause analysis and c',
    `order_id` BIGINT COMMENT 'Identifier of the investment order that generated this transaction, linking back to the original client instruction or portfolio rebalancing decision.',
    `party_id` BIGINT COMMENT 'Identifier of the custodian bank holding the securities and processing the settlement.',
    `rebalancing_order_id` BIGINT COMMENT 'Identifier of the portfolio rebalancing event that triggered this transaction, if applicable.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Transactions reference securities by identifier for trade booking. Settlement instruction generation, regulatory reporting, and security master lookup require valid instrument identifier reference.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every portfolio transaction must be screened against OFAC, UN, EU sanctions lists before execution. Mandatory regulatory control linking each trade to its screening result for audit trail, blocking de',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Portfolio transactions settle cash legs via deposit accounts for trade execution, dividend payments, interest receipts, and fee debits. Required for trade settlement reconciliation and cash movement t',
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
    `price` DECIMAL(18,2) COMMENT 'Price per unit at which the transaction was executed, expressed in the securitys quotation currency.',
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
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the transaction was executed.. Valid values are `^[A-Z]{3}$`',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number for this transaction, used for client reporting and reconciliation.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the transaction indicating its processing state.. Valid values are `pending|confirmed|settled|cancelled|failed|reversed`',
    `transaction_type` STRING COMMENT 'Classification of the transaction activity: trade execution (buy, sell, subscription, redemption), income event (dividend, interest), corporate action (stock split, merger, spin-off, rights issue, tender offer), or portfolio management activity (fee deduction, transfer, dividend reinvestment). [ENUM-REF-CANDIDATE: buy|sell|subscription|redemption|dividend|interest|fee|transfer_in|transfer_out|stock_split|merger|spin_off|rights_issue|tender_offer|dividend_reinvestment|capital_gain_distribution|return_of_capital — 17 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified, capturing status changes, corrections, or amendments.',
    `value_date` DATE COMMENT 'Date from which interest or economic benefit accrues for cash movements, used for accurate performance calculation and interest attribution.',
    CONSTRAINT pk_portfolio_transaction PRIMARY KEY(`portfolio_transaction_id`)
) COMMENT 'Transactional record of all investment activity and corporate action events within a managed portfolio. Captures trade transactions (buys, sells, subscriptions, redemptions, dividend reinvestments, fee deductions, transfers), corporate action events and their portfolio impact (dividends, stock splits, mergers, rights issues, spin-offs, tender offers — with ex-date, record date, payment date, action ratio, cash/stock election, processing status, SWIFT CA messaging source), and common attributes (trade date, settlement date, security, quantity, price, gross/net amount, transaction type, broker, commission, tax lot impact, settlement status). Feeds performance calculation, holdings reconciliation, client reporting, and automated portfolio_holding updates.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`nav_calculation` (
    `nav_calculation_id` BIGINT COMMENT 'Unique identifier for the NAV calculation record. Primary key for this entity.',
    `fund_id` BIGINT COMMENT 'Identifier of the investment fund if this NAV calculation is for a pooled fund vehicle.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the managed portfolio or fund for which NAV is being calculated.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that executed the NAV calculation.',
    `accrued_expenses` DECIMAL(18,2) COMMENT 'Expenses incurred but not yet paid as of the valuation date, including management fees, performance fees, custody fees, and other operating expenses.',
    `accrued_income` DECIMAL(18,2) COMMENT 'Income earned but not yet received as of the valuation date, including accrued interest, dividends declared but not paid, and other receivables.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the NAV calculation was formally approved for publication to clients and regulators.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this NAV calculation to detailed audit logs, supporting documentation, and calculation worksheets.',
    `calculation_method` STRING COMMENT 'The NAV calculation method applied. Forward pricing uses end-of-day prices; swing pricing adjusts NAV for dilution; dual pricing separates bid/offer NAVs.. Valid values are `forward_pricing|backward_pricing|swing_pricing|dual_pricing`',
    `calculation_status` STRING COMMENT 'Current lifecycle status of the NAV calculation. Tracks the workflow from initial calculation through approval and publication. [ENUM-REF-CANDIDATE: draft|pending|calculated|approved|published|rejected|recalculated — 7 candidates stripped; promote to reference product]',
    `calculation_timestamp` TIMESTAMP COMMENT 'The exact date and time when this NAV calculation was executed and finalized.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the NAV is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
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
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Rebalancing orders require client approval through specific channels (email consent, phone authorization, digital approval). Essential for compliance audit trail, client consent documentation, dispute',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or wealth advisor responsible for overseeing this rebalancing order and client relationship.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Rebalancing activity costs (trading commissions, operational overhead) are allocated to specific cost centers for profitability analysis and management reporting. Real banking process: wealth manageme',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Rebalancing orders require deposit accounts for funding security purchases and receiving sale proceeds. Essential for portfolio rebalancing execution, cash availability verification, and transaction c',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the portfolio being rebalanced.',
    `model_portfolio_id` BIGINT COMMENT 'Reference to the model portfolio template that defines the target asset allocation for this rebalancing order. Null if not using a model portfolio.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Order status uses standardized workflow codes (pending, approved, executed, cancelled). Rebalancing workflow, approval routing, and audit trail require code list reference.',
    `party_id` BIGINT COMMENT 'Reference to the client who owns the portfolio being rebalanced.',
    `employee_id` BIGINT COMMENT 'Reference to the user who provided final approval for the rebalancing order. Null if not yet approved.',
    `tertiary_rebalancing_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this rebalancing order record.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Rebalancing orders may be triggered by corporate actions or events related to investment banking deals (M&A, restructuring). Real business process: portfolio rebalancing post-deal to maintain target a',
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
    `portfolio_base_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the base currency of the portfolio for valuation and reporting purposes.. Valid values are `^[A-Z]{3}$`',
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
    `benchmark_id` BIGINT COMMENT 'Reference to the benchmark index used for relative performance comparison.',
    `composite_id` BIGINT COMMENT 'Reference to the GIPS composite to which this portfolio belongs for performance aggregation and reporting.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio for which performance is calculated.',
    `party_id` BIGINT COMMENT 'Reference to the high-net-worth or ultra-high-net-worth client who owns the portfolio.',
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
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which performance returns and values are expressed.. Valid values are `^[A-Z]{3}$`',
    `downside_deviation` DECIMAL(18,2) COMMENT 'The standard deviation of negative returns only, used in Sortino ratio calculation.',
    `ending_market_value` DECIMAL(18,2) COMMENT 'The total market value of the portfolio at the end of the measurement period.',
    `gips_compliant_flag` BOOLEAN COMMENT 'Indicates whether this performance calculation is compliant with GIPS standards for composite membership and reporting.',
    `income_earned` DECIMAL(18,2) COMMENT 'The total income (dividends, interest, coupons) earned by the portfolio during the measurement period.',
    `information_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted active return metric calculated as active return divided by tracking error, measuring manager skill.',
    `management_fees` DECIMAL(18,2) COMMENT 'The investment management fees charged during the measurement period, used to calculate net-of-fee returns.',
    `maximum_drawdown` DECIMAL(18,2) COMMENT 'The largest peak-to-trough decline in portfolio value during the measurement period, expressed as a percentage.',
    `mwr_return` DECIMAL(18,2) COMMENT 'Money-weighted rate of return (also known as Internal Rate of Return or IRR) that accounts for the timing and magnitude of external cash flows.',
    `net_cash_flow` DECIMAL(18,2) COMMENT 'The net external cash flows (contributions minus withdrawals) during the measurement period.',
    `other_expenses` DECIMAL(18,2) COMMENT 'Other portfolio expenses (custody, administration, transaction costs) incurred during the measurement period.',
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
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or wealth advisor responsible for servicing this mandate.',
    `investment_policy_statement_id` BIGINT COMMENT 'Reference to the Investment Policy Statement (IPS) that governs the investment strategy, asset allocation, and constraints for this mandate. The IPS is distinct from the mandate itself.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Mandate establishment and renewal trigger KYC review cycles per regulatory requirements. Links discretionary investment authority documentation to mandatory customer due diligence process for AML/KYC ',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Mandate types use standardized codes (discretionary, advisory, execution-only) for service model. Fee calculation, regulatory reporting, and service delivery require code list reference.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Mandates typically opened at specific branch for KYC, document notarization, and relationship establishment. Required for branch attribution, geographic regulatory compliance (state/country licensing)',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Mandates are booked to business units for revenue recognition, regulatory reporting (MiFID II transaction reporting), segment P&L, and management reporting. Critical for business line performance meas',
    `party_id` BIGINT COMMENT 'Reference to the client party who owns this mandate. Links to the customer or party master.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Mandates are classified by product type for regulatory reporting. UCITS/AIF classification, Form ADV reporting, and product governance require product type reference.',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Client mandates should reference the suitability assessment that validates the mandate terms. This ensures regulatory compliance and links mandate terms to assessed risk tolerance. Removes redundant s',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Mandates specify tax reporting jurisdiction for FATCA/CRS compliance. Regulatory reporting, withholding tax calculation, and cross-border tax treaty application require country reference.',
    `aum_at_inception` DECIMAL(18,2) COMMENT 'Total asset value under management at the time the mandate was established, used for performance tracking and fee calculation baseline.',
    `authorized_signatory_name` STRING COMMENT 'Name of the individual authorized to sign documents and approve transactions on behalf of the client for this mandate.',
    `authorized_signatory_title` STRING COMMENT 'Title or role of the authorized signatory (e.g., Trustee, Power of Attorney, Director).',
    `base_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency for mandate valuation, reporting, and performance measurement.. Valid values are `^[A-Z]{3}$`',
    `benchmark_index` STRING COMMENT 'Name or identifier of the market index or composite benchmark used to measure the mandates investment performance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was first created in the system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the mandate is subject to CRS reporting requirements for automatic exchange of financial account information.',
    `custodian_account_number` STRING COMMENT 'Account number at the custodian institution where the mandate assets are held.',
    `custodian_name` STRING COMMENT 'Name of the financial institution acting as custodian for the assets held under this mandate.',
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
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Client suitability assessments must respect firm risk appetite limits on product complexity, leverage, and concentration. Compliance validates that client risk profiles offered align with board-approv',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Suitability assessments conducted through specific channels (branch interview, video call, digital questionnaire). Critical for MiFID II/Regulation Best Interest compliance, proving appropriate advice',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Assessment outcomes use standardized codes (suitable, unsuitable, conditional) for compliance tracking. Regulatory reporting, audit trail, and investment restriction enforcement require code list refe',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or wealth advisor who conducted the suitability assessment.',
    `employee_id` BIGINT COMMENT 'Reference to the compliance officer or supervisor who approved this suitability assessment.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Suitability assessments for HNW clients may evaluate participation in specific investment banking deals (private placements, structured products). Real business process: suitability review for deal pa',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Suitability assessments evaluate specific fund recommendations against client risk profile and objectives. Required for regulatory compliance (MiFID II suitability rules, SEC Reg BI), client documenta',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Suitability assessments are integral to KYC review process, often conducted together or sequentially. Links investment suitability determination to broader customer due diligence cycle for regulatory ',
    `party_id` BIGINT COMMENT 'Reference to the wealth management client for whom this suitability assessment was conducted.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Suitability assessments follow regulatory frameworks (MiFID II, SEC Reg BI). Compliance documentation, audit trail, and regulatory reporting require taxonomy reference for assessment methodology.',
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
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this assessment (e.g., USD, EUR, GBP, CHF).. Valid values are `^[A-Z]{3}$`',
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
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Model portfolios use benchmarks for performance comparison. Investment committee decisions, client proposals, and performance attribution require valid benchmark reference for strategy evaluation.',
    `investment_committee_id` BIGINT COMMENT 'Reference to the investment committee responsible for approving and overseeing this model portfolio.',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Investment objectives use standardized codes (growth, income, balanced) for client segmentation. Suitability matching, model portfolio selection, and marketing materials require code list reference.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Model portfolios are created and maintained by specific investment teams/business units for governance, accountability, and investment committee oversight. Essential for tracking which business line o',
    `employee_id` BIGINT COMMENT 'Reference to the lead portfolio manager responsible for maintaining and updating the model portfolio allocation.',
    `active_client_count` STRING COMMENT 'Current number of client accounts assigned to this model portfolio, used for capacity monitoring and performance reporting.',
    `approval_date` DATE COMMENT 'Date on which the investment committee formally approved this model portfolio version for client use.',
    `approval_status` STRING COMMENT 'Current approval status of the model portfolio in the investment committee governance workflow.. Valid values are `draft|pending_review|approved|rejected|suspended|retired`',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency for model portfolio valuation and reporting.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` (
    `wealth_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the wealth fee schedule record. Primary key for this entity.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Wealth management fees are debited from client deposit accounts per fee schedule terms. Required for automated fee billing, payment processing, and revenue recognition in wealth advisory operations.',
    `client_mandate_id` BIGINT COMMENT 'Reference to the client mandate or managed portfolio to which this fee schedule applies. Links fee structure to the investment management agreement.',
    `fund_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to asset.fund_fee_schedule. Business justification: Wealth management fee schedules reference underlying fund fee structures for transparency and total cost disclosure. Required for fee disclosure documentation, regulatory reporting (MiFID II cost tran',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Fee schedules are defined and managed by business units for revenue attribution, transfer pricing between divisions, and segment profitability analysis. Essential for management reporting and business',
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
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which fees are denominated and billed (e.g., USD, EUR, GBP, CHF).. Valid values are `^[A-Z]{3}$`',
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
    CONSTRAINT pk_wealth_fee_schedule PRIMARY KEY(`wealth_fee_schedule_id`)
) COMMENT 'Fee schedule master and billing record governing all charges applied to wealth management client mandates and managed portfolios. Captures the full fee lifecycle: schedule definition (fee type — management, performance, advisory, custody, transaction; fee basis — AUM percentage, flat, tiered; tier breakpoints; performance fee hurdle rate and high-water mark; fee currency; billing frequency; effective date range), billing execution (billing period, applied fee rate, AUM basis for calculation, gross and net fee amounts, tax withholding, invoice reference, payment date, fee waivers, billing status), and accrual/revenue recognition (accrual status, revenue recognition date, general ledger posting reference). Supports client invoicing, management fee reconciliation, and regulatory fee disclosure.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`fee_billing` (
    `fee_billing_id` BIGINT COMMENT 'Unique identifier for the fee billing record. Primary key for the fee billing entity.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fee invoices delivered through client-preferred channels (email, postal mail, digital portal). Required for client preference fulfillment, delivery confirmation tracking, dispute resolution (proof of ',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager or financial advisor responsible for this client relationship. Used for commission calculation, performance tracking, and client service accountability.',
    `employee_id` BIGINT COMMENT 'The user identifier of the person who approved the fee billing. Used for audit trail and segregation of duties compliance.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the investment portfolio or account for which this fee is calculated. Links to the portfolio entity managed by the wealth management system.',
    `party_id` BIGINT COMMENT 'Reference to the wealth management client for whom this fee is being billed. Links to the party entity representing the high-net-worth or ultra-high-net-worth individual or institutional client.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Fee billing invoices are settled via deposit account debits. Essential for fee collection automation, payment reconciliation, and accounts receivable management in wealth management operations.',
    `wealth_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to wealth.wealth_fee_schedule. Business justification: Fee billing records should reference the fee schedule theyre based on. This normalizes fee structure data and ensures billing is traceable to the governing fee schedule. Removes redundant fee structu',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the fee billing was approved by authorized personnel. Required for audit trail and compliance with internal controls over financial reporting.',
    `aum_basis_amount` DECIMAL(18,2) COMMENT 'The total value of assets under management used as the basis for fee calculation. This is the NAV of the portfolio at the measurement point defined by the fee calculation method.',
    `aum_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the AUM basis amount. Typically USD, EUR, GBP, or CHF for wealth management clients.. Valid values are `^[A-Z]{3}$`',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period for which this fee is calculated. Defines the cutoff for AUM calculation and fee accrual.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period for which this fee is calculated. Typically aligned with quarterly or monthly billing cycles.',
    `billing_status` STRING COMMENT 'The current lifecycle status of the fee billing record. Draft indicates calculation in progress, pending approval requires management review, approved is ready for invoicing, invoiced means invoice has been generated, paid indicates client payment received, disputed indicates client challenge, waived means fee was forgiven, and reversed indicates the billing was cancelled and reversed. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|invoiced|paid|disputed|waived|reversed — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee billing record was first created in the system. Used for audit trail and data lineage tracking.',
    `dispute_reason` STRING COMMENT 'Free-text explanation of why the client disputed the fee billing. Examples include AUM calculation discrepancy, Fee rate incorrect, Performance calculation error, or Unauthorized charge. Populated when billing status is disputed.',
    `dispute_resolution_date` DATE COMMENT 'The date the fee dispute was resolved. Resolution may result in fee adjustment, waiver, or confirmation of original billing.',
    `fee_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all fee amounts (gross, discount, tax, net). Typically matches the AUM currency but may differ if currency conversion is applied.. Valid values are `^[A-Z]{3}$`',
    `fee_discount_amount` DECIMAL(18,2) COMMENT 'Any discount or reduction applied to the gross fee amount. May result from promotional offers, relationship pricing, fee waivers for underperformance, or negotiated concessions for high-net-worth clients.',
    `fee_waiver_reason` STRING COMMENT 'Free-text explanation for any fee discount or waiver applied. Examples include Performance below benchmark, Client retention offer, Relationship pricing tier, or Promotional period.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this fee revenue is posted. Used for financial reporting, revenue recognition, and reconciliation with the general ledger system.',
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
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified this custodian account record, supporting audit trail and change management.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Custodian accounts can be fund-specific (omnibus or segregated fund custody accounts). Required for fund position reconciliation, settlement instruction routing, corporate action processing, and custo',
    `omnibus_parent_account_id` BIGINT COMMENT 'Reference to the parent omnibus custodian account if this account is a sub-account within a pooled structure. Null for standalone or top-level accounts.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio that this custodian account serves. Links the custody relationship to the investment portfolio being managed.',
    `party_id` BIGINT COMMENT 'Reference to a sub-custodian institution in the custody chain, used when the primary custodian delegates safekeeping to a local custodian in specific markets (common for emerging markets and cross-border holdings).',
    `prime_broker_agreement_id` BIGINT COMMENT 'Reference to the prime brokerage agreement governing this custodian account, if applicable. Prime brokerage accounts provide integrated custody, financing, and execution services for hedge funds and institutional clients.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Wealth custodian accounts settle cross-border transactions and FX trades through the banks nostro accounts at correspondent banks. Business process: international settlement, multi-currency cash mana',
    `wealth_fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule governing custody fees, transaction fees, and ancillary charges for this account.',
    `account_opening_documentation_complete` BOOLEAN COMMENT 'Boolean flag indicating whether all required account opening documentation (KYC, service agreements, authorized signatory forms) has been completed and verified.',
    `account_status` STRING COMMENT 'Current operational status of the custodian account: active (fully operational), frozen (temporarily suspended), restricted (limited operations allowed), closed (terminated), or pending_opening (in setup phase).. Valid values are `active|frozen|restricted|closed|pending_opening`',
    `account_type` STRING COMMENT 'Classification of the custodian account indicating its primary function: custody (securities safekeeping), settlement (trade clearing), cash (liquidity management), margin (leveraged positions), omnibus (pooled client assets), or segregated (individual client segregation per CASS/SEC Rule 15c3-3).. Valid values are `custody|settlement|cash|margin|omnibus|segregated`',
    `authorized_signatory_list` STRING COMMENT 'Comma-separated list or reference to individuals authorized to issue instructions on this custodian account. Critical for operational control and audit trail.',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency denomination for cash balances and valuations in this custodian account.. Valid values are `^[A-Z]{3}$`',
    `bic` STRING COMMENT 'Bank Identifier Code (also known as SWIFT code) identifying the custodian institution for international messaging and settlement instructions.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` (
    `portfolio_corporate_action_id` BIGINT COMMENT 'Primary key for portfolio_corporate_action',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Corporate actions generating securities transactions (cash elections, fractional share sales, rights exercises, tender offers) are captured as trades for settlement and regulatory reporting. Links cor',
    `instrument_id` BIGINT COMMENT 'Reference to the security subject to the corporate action.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio impacted by this corporate action.',
    `new_security_instrument_id` BIGINT COMMENT 'Reference to the new security received as a result of the corporate action (for mergers, spin-offs, stock dividends).',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Corporate actions are security-specific for entitlement calculation. Dividend processing, stock split adjustments, and merger processing require valid instrument identifier reference.',
    `action_ratio_denominator` DECIMAL(18,2) COMMENT 'Denominator of the corporate action ratio (e.g., for a 3-for-2 stock split, this would be 2).',
    `action_ratio_numerator` DECIMAL(18,2) COMMENT 'Numerator of the corporate action ratio (e.g., for a 3-for-2 stock split, this would be 3).',
    `announcement_date` DATE COMMENT 'Date on which the corporate action was publicly announced by the issuer.',
    `cash_amount_per_share` DECIMAL(18,2) COMMENT 'Cash payment amount per share for dividend or cash distribution corporate actions.',
    `corporate_action_number` STRING COMMENT 'Externally-known unique identifier for the corporate action event, typically sourced from SWIFT CA messaging or custodian notification.',
    `corporate_action_type` STRING COMMENT 'Classification of the corporate action event (dividend, stock split, merger, rights issue, spin-off, tender offer, redemption, delisting). [ENUM-REF-CANDIDATE: dividend|stock_split|reverse_split|merger|acquisition|spin_off|rights_issue|tender_offer|redemption|delisting — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for cash proceeds (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `custodian_reference` STRING COMMENT 'Reference number assigned by the custodian bank for tracking the corporate action event.',
    `effective_date` DATE COMMENT 'Date on which the corporate action becomes effective and portfolio holdings are adjusted.',
    `election_deadline` TIMESTAMP COMMENT 'Timestamp by which the portfolio manager must submit their election for voluntary corporate actions.',
    `election_option` STRING COMMENT 'The election made by the portfolio manager for voluntary corporate actions (cash, stock, cash and stock, or no election for mandatory actions).. Valid values are `cash|stock|cash_and_stock|no_election`',
    `election_type` STRING COMMENT 'Indicates whether the corporate action is mandatory (no choice), voluntary (shareholder must elect), or mandatory with options.. Valid values are `mandatory|voluntary|mandatory_with_options`',
    `entitled_cash_amount` DECIMAL(18,2) COMMENT 'Total cash amount the portfolio is entitled to receive as a result of the corporate action.',
    `entitled_shares` DECIMAL(18,2) COMMENT 'Number of new shares the portfolio is entitled to receive as a result of the corporate action.',
    `ex_date` DATE COMMENT 'Ex-dividend or ex-entitlement date; the first trading day on which the security trades without the entitlement to the corporate action.',
    `fractional_share_treatment` STRING COMMENT 'Method for handling fractional shares resulting from the corporate action (cash in lieu, round down, round up, carry forward).. Valid values are `cash_in_lieu|round_down|round_up|carry_forward`',
    `holding_impact_type` STRING COMMENT 'Classification of how the corporate action impacts portfolio holdings (quantity change, security substitution, cash receipt, no impact).. Valid values are `quantity_change|security_substitution|cash_receipt|no_impact`',
    `mandatory_voluntary_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the corporate action is mandatory (True) or voluntary (False).',
    `nav_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual impact of the corporate action on the portfolios Net Asset Value in base currency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or commentary related to the corporate action processing.',
    `notification_sent_flag` BOOLEAN COMMENT 'Boolean flag indicating whether client notification has been sent regarding this corporate action.',
    `payment_date` DATE COMMENT 'Date on which cash proceeds or new securities are distributed to entitled shareholders.',
    `processed_timestamp` TIMESTAMP COMMENT 'Timestamp when the corporate action was fully processed and portfolio holdings were updated.',
    `processing_status` STRING COMMENT 'Current processing status of the corporate action within the portfolio management system. [ENUM-REF-CANDIDATE: pending|election_required|elected|processing|completed|cancelled|failed — 7 candidates stripped; promote to reference product]',
    `rebalancing_trigger_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this corporate action should trigger a portfolio rebalancing review.',
    `record_date` DATE COMMENT 'Date on which shareholders must be registered on the issuers books to be entitled to the corporate action benefit.',
    `shares_held_at_record` DECIMAL(18,2) COMMENT 'Number of shares held in the portfolio as of the record date, determining entitlement to the corporate action.',
    `source_message_reference` STRING COMMENT 'Unique identifier of the source message or notification (e.g., SWIFT message reference) that communicated the corporate action.',
    `source_system` STRING COMMENT 'Name of the source system from which the corporate action event was received (e.g., SWIFT, custodian feed, SimCorp Dimension, BlackRock Aladdin).',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment of the corporate action proceeds (qualified dividend, return of capital, capital gain, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate action record was last modified.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Total withholding tax amount deducted from cash proceeds.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Applicable withholding tax rate applied to cash proceeds, expressed as a decimal (e.g., 0.15 for 15%).',
    CONSTRAINT pk_portfolio_corporate_action PRIMARY KEY(`portfolio_corporate_action_id`)
) COMMENT 'Corporate action event record impacting securities held within managed portfolios. Captures corporate action type (dividend, stock split, merger, rights issue, spin-off, tender offer), ex-date, record date, payment date, action ratio, cash/stock election, impact on portfolio holdings, processing status, and source (SWIFT CA messaging). Drives automated portfolio_holding and portfolio_transaction updates.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`investment_proposal` (
    `investment_proposal_id` BIGINT COMMENT 'Unique identifier for the investment proposal record. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Links proposed investment strategy benchmarks to master data for client presentations, suitability documentation, and proposal-to-portfolio conversion. Ensures benchmark consistency from proposal thro',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Proposals compare projected returns to benchmarks for client presentations. Investment strategy justification and expected return analysis require valid benchmark reference.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager who prepared and presented the proposal.',
    `employee_id` BIGINT COMMENT 'Reference to the portfolio manager responsible for executing the proposed strategy if accepted.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Investment proposals often recommend specific funds to clients. Required for proposal generation, client presentation materials, acceptance tracking, and linking accepted proposals to actual fund inve',
    `model_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.model_portfolio. Business justification: Investment proposals often reference a model portfolio as the proposed strategy template. This links the proposal to the standardized model being recommended. No redundant columns (proposal has propos',
    `party_id` BIGINT COMMENT 'Reference to the wealth management client to whom this proposal is presented.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Proposals presented through specific channels (branch meeting, video conference, digital portal). Required for sales attribution, channel effectiveness analysis, client engagement preference tracking,',
    `suitability_assessment_id` BIGINT COMMENT 'Foreign key linking to wealth.suitability_assessment. Business justification: Investment proposals should reference the suitability assessment that supports them. This normalizes suitability data and ensures proposals are backed by formal assessments. Removes redundant suitabil',
    `acceptance_date` DATE COMMENT 'Date when the client formally accepted the investment proposal, triggering mandate execution or portfolio restructuring.',
    `alternative_allocation_pct` DECIMAL(18,2) COMMENT 'Recommended percentage allocation to alternative investments (hedge funds, private equity, real estate, commodities) in the proposed portfolio.',
    `base_case_return_pct` DECIMAL(18,2) COMMENT 'Expected return percentage under the base case scenario, representing the most likely outcome.',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency for the proposed portfolio and all financial projections.. Valid values are `^[A-Z]{3}$`',
    `cash_allocation_pct` DECIMAL(18,2) COMMENT 'Recommended percentage allocation to cash and cash equivalents in the proposed portfolio.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment proposal record was first created in the system.',
    `equity_allocation_pct` DECIMAL(18,2) COMMENT 'Recommended percentage allocation to equity asset class in the proposed portfolio.',
    `esg_compliant_flag` BOOLEAN COMMENT 'Indicates whether the proposed portfolio adheres to environmental, social, and governance investment criteria.',
    `expiry_date` DATE COMMENT 'Date after which the proposal is no longer valid and must be revised or reissued if the client wishes to proceed.',
    `fee_structure_description` STRING COMMENT 'Detailed description of the fee structure, including management fees, performance fees, transaction costs, and any other charges.',
    `fixed_income_allocation_pct` DECIMAL(18,2) COMMENT 'Recommended percentage allocation to fixed income asset class in the proposed portfolio.',
    `investment_objective` STRING COMMENT 'Primary investment objective of the proposed strategy, such as capital preservation, income generation, growth, or balanced growth and income.',
    `management_fee_pct` DECIMAL(18,2) COMMENT 'Proposed annual management fee percentage charged on assets under management.',
    `max_drawdown_pct` DECIMAL(18,2) COMMENT 'Projected maximum peak-to-trough decline percentage for the proposed portfolio under stress scenarios.',
    `optimistic_return_pct` DECIMAL(18,2) COMMENT 'Projected return percentage under an optimistic market scenario.',
    `other_allocation_pct` DECIMAL(18,2) COMMENT 'Recommended percentage allocation to other asset classes not categorized above.',
    `performance_fee_pct` DECIMAL(18,2) COMMENT 'Proposed performance fee percentage charged on returns exceeding the benchmark or hurdle rate.',
    `pessimistic_return_pct` DECIMAL(18,2) COMMENT 'Projected return percentage under a pessimistic market scenario.',
    `presentation_date` DATE COMMENT 'Date when the proposal was presented to the client for review and decision.',
    `proposal_date` DATE COMMENT 'Date when the investment proposal was formally created and prepared for client presentation.',
    `proposal_name` STRING COMMENT 'Descriptive name or title of the investment proposal, summarizing the strategy or objective.',
    `proposal_number` STRING COMMENT 'Business-facing unique identifier for the investment proposal, used in client communications and documentation.',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the investment proposal: draft, pending review, presented, accepted, rejected, expired, or withdrawn. [ENUM-REF-CANDIDATE: draft|pending_review|presented|accepted|rejected|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `proposal_type` STRING COMMENT 'Classification of the proposal purpose: new mandate, portfolio restructuring, asset allocation change, strategy change, rebalancing, or other.. Valid values are `new_mandate|portfolio_restructuring|asset_allocation_change|strategy_change|rebalancing|other`',
    `proposed_aum_amount` DECIMAL(18,2) COMMENT 'Total assets under management amount proposed for the mandate or portfolio restructuring, in base currency.',
    `proposed_strategy` STRING COMMENT 'Description of the investment strategy recommended in the proposal, including asset classes, risk approach, and investment philosophy.',
    `rejection_date` DATE COMMENT 'Date when the client formally rejected the investment proposal.',
    `risk_profile` STRING COMMENT 'Risk tolerance classification for the proposed portfolio: conservative, moderate, balanced, growth, or aggressive.. Valid values are `conservative|moderate|balanced|growth|aggressive`',
    `shariah_compliant_flag` BOOLEAN COMMENT 'Indicates whether the proposed portfolio adheres to Islamic finance principles and Shariah law.',
    `sharpe_ratio` DECIMAL(18,2) COMMENT 'Projected Sharpe ratio for the proposed portfolio, measuring risk-adjusted return relative to a risk-free rate.',
    `target_annual_return_pct` DECIMAL(18,2) COMMENT 'Projected target annual return percentage for the proposed investment strategy under normal market conditions.',
    `time_horizon_years` STRING COMMENT 'Recommended investment time horizon in years for the proposed strategy, aligned with client goals and liquidity needs.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment proposal record was last modified in the system.',
    `var_95_pct` DECIMAL(18,2) COMMENT 'Value at Risk at 95% confidence level, representing the maximum expected loss over a specified time period under normal market conditions.',
    `volatility_pct` DECIMAL(18,2) COMMENT 'Expected annualized volatility (standard deviation of returns) for the proposed portfolio.',
    CONSTRAINT pk_investment_proposal PRIMARY KEY(`investment_proposal_id`)
) COMMENT 'Formal investment proposal presented to a wealth management client prior to mandate execution or portfolio restructuring. Captures proposal date, proposed strategy, recommended asset allocation, projected return scenarios, risk metrics (VaR, max drawdown), fee illustration, benchmark comparison, suitability confirmation, client acceptance status, and expiry date. Supports the advisory workflow from proposal to mandate execution.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`composite` (
    `composite_id` BIGINT COMMENT 'Unique identifier for the GIPS composite. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Essential for GIPS-compliant composite reporting, performance verification, and third-party performance examination. Links composite benchmark to master data for consistent performance measurement and',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Composite performance is benchmarked for GIPS compliance. Marketing materials, RFP responses, and performance verification require valid benchmark reference for strategy comparison.',
    `employee_id` BIGINT COMMENT 'Identifier of the portfolio manager or investment team responsible for managing the composite strategy.',
    `model_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.model_portfolio. Business justification: GIPS composites may be based on model portfolios. This optional FK links composites to the model portfolio strategy they represent. No redundant columns (composite tracks performance aggregation, mode',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Investment composites are managed by specific divisions/investment teams for GIPS compliance, performance attribution by business line, and marketing materials. Required for regulatory filings and cli',
    `aum` DECIMAL(18,2) COMMENT 'Total market value of all assets managed within the composite as of the most recent valuation date, expressed in base currency.',
    `aum_as_of_date` DATE COMMENT 'Valuation date for the reported composite AUM and portfolio count.',
    `base_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which composite performance and AUM are reported.. Valid values are `^[A-Z]{3}$`',
    `composite_code` STRING COMMENT 'Internal system code or identifier for the composite used in operational systems.',
    `composite_name` STRING COMMENT 'Official name of the composite used in marketing materials and performance presentations.',
    `composite_status` STRING COMMENT 'Current operational status of the composite.. Valid values are `active|inactive|terminated|pending`',
    `composite_type` STRING COMMENT 'Classification of the composite by primary asset class or strategy type.. Valid values are `equity|fixed_income|balanced|alternative|real_estate|multi_asset`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the composite record was first created in the system.',
    `dispersion_calculation_method` STRING COMMENT 'Statistical method used to calculate internal dispersion of portfolio returns within the composite.. Valid values are `standard_deviation|range|interquartile_range`',
    `exclusion_criteria` STRING COMMENT 'Criteria defining which portfolios are excluded from the composite, including significant cash flow rules and other exclusions.',
    `fee_schedule_description` STRING COMMENT 'Description of the fee structure applied to portfolios within the composite for net return calculation.',
    `gips_compliant_flag` BOOLEAN COMMENT 'Indicates whether the composite has been constructed and maintained in compliance with GIPS standards.',
    `gips_verification_status` STRING COMMENT 'Status of independent third-party verification of the firms claim of GIPS compliance for this composite.. Valid values are `verified|not_verified|verification_in_progress`',
    `gross_composite_return_1yr` DECIMAL(18,2) COMMENT 'Trailing one-year composite return before deduction of investment management fees, expressed as a percentage.',
    `gross_composite_return_3yr` DECIMAL(18,2) COMMENT 'Trailing three-year annualized composite return before deduction of investment management fees, expressed as a percentage.',
    `gross_composite_return_5yr` DECIMAL(18,2) COMMENT 'Trailing five-year annualized composite return before deduction of investment management fees, expressed as a percentage.',
    `gross_composite_return_since_inception` DECIMAL(18,2) COMMENT 'Annualized composite return since inception before deduction of investment management fees, expressed as a percentage.',
    `gross_composite_return_ytd` DECIMAL(18,2) COMMENT 'Year-to-date composite return before deduction of investment management fees, expressed as a percentage.',
    `inception_date` DATE COMMENT 'Date when the composite was created and began tracking performance.',
    `inclusion_criteria` STRING COMMENT 'Detailed criteria defining which portfolios are eligible for inclusion in the composite based on mandate, strategy, and investment characteristics.',
    `internal_dispersion` DECIMAL(18,2) COMMENT 'Statistical measure of the spread of individual portfolio returns within the composite, typically expressed as standard deviation or range, indicating consistency of performance across constituent portfolios.',
    `minimum_portfolio_size` DECIMAL(18,2) COMMENT 'Minimum asset size threshold for a portfolio to be eligible for inclusion in the composite, expressed in base currency.',
    `net_composite_return_1yr` DECIMAL(18,2) COMMENT 'Trailing one-year composite return after deduction of investment management fees, expressed as a percentage.',
    `net_composite_return_3yr` DECIMAL(18,2) COMMENT 'Trailing three-year annualized composite return after deduction of investment management fees, expressed as a percentage.',
    `net_composite_return_5yr` DECIMAL(18,2) COMMENT 'Trailing five-year annualized composite return after deduction of investment management fees, expressed as a percentage.',
    `net_composite_return_since_inception` DECIMAL(18,2) COMMENT 'Annualized composite return since inception after deduction of investment management fees, expressed as a percentage.',
    `net_composite_return_ytd` DECIMAL(18,2) COMMENT 'Year-to-date composite return after deduction of investment management fees, expressed as a percentage.',
    `number_of_portfolios` STRING COMMENT 'Current count of portfolios included in the composite as of the most recent reporting period.',
    `significant_cash_flow_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage threshold defining significant cash flows that may trigger temporary exclusion of a portfolio from the composite.',
    `source_system` STRING COMMENT 'Name of the source system from which the composite data originated, typically SimCorp Dimension or BlackRock Aladdin.',
    `strategy_description` STRING COMMENT 'Detailed description of the investment mandate, strategy, and objectives that define the composite.',
    `termination_date` DATE COMMENT 'Date when the composite was closed or discontinued. Null if composite is still active.',
    `three_year_annualized_ex_post_standard_deviation` DECIMAL(18,2) COMMENT 'Three-year annualized standard deviation of composite returns, measuring historical volatility and risk.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the composite record was last updated in the system.',
    `valuation_frequency` STRING COMMENT 'Frequency at which constituent portfolios are valued for composite performance calculation.. Valid values are `daily|monthly|quarterly`',
    `verification_date` DATE COMMENT 'Date of the most recent independent GIPS verification for this composite.',
    `verifier_name` STRING COMMENT 'Name of the independent third-party firm that performed GIPS verification.',
    CONSTRAINT pk_composite PRIMARY KEY(`composite_id`)
) COMMENT 'GIPS (Global Investment Performance Standards) composite grouping managed portfolios with similar investment mandates for standardized performance reporting and institutional marketing. Captures composite name, strategy description, inception date, termination date, benchmark assignment, inclusion/exclusion criteria, number of constituent portfolios, composite AUM, gross and net composite returns, internal dispersion measure, and GIPS verification status. Required for institutional client acquisition, consultant database submissions, and regulatory performance disclosure under SEC Marketing Rule.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`tax_lot` (
    `tax_lot_id` BIGINT COMMENT 'Unique identifier for the tax lot record. Primary key.',
    `custodian_account_id` BIGINT COMMENT 'Reference to the custodian account where the security is held.',
    `instrument_id` BIGINT COMMENT 'Reference to the security held in this tax lot.',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the managed portfolio that holds this tax lot.',
    `portfolio_transaction_id` BIGINT COMMENT 'Reference to the transaction that created this tax lot.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Tax lots track cost basis by security for tax reporting. IRS Form 1099-B generation, wash sale detection, and realized gain/loss calculation require valid instrument identifier reference.',
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
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this tax lot.. Valid values are `^[A-Z]{3}$`',
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
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager responsible for the trust account.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.pledge. Business justification: Trust assets are pledged to secure obligations while maintaining fiduciary duty. Real business process: trust-secured lending where trust holdings collateralize credit facilities. Operations require t',
    `custodian_account_id` BIGINT COMMENT 'Reference to the custodian account where trust assets are held.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Trusts are governed by specific jurisdiction law for fiduciary duty. Trust administration, legal compliance, and beneficiary rights interpretation require country reference for governing law.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Trust accounts require enhanced due diligence and regular KYC reviews due to beneficial ownership complexity and higher AML risk. Links trust structures to mandatory EDD cycles for grantor, trustee, a',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Trust accounts are administered by specific fiduciary business units for regulatory reporting (OCC fiduciary oversight), operational oversight, and segregation of duties. Required for regulatory exami',
    `party_id` BIGINT COMMENT 'Reference to the primary client or grantor associated with this trust account.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Trust accounts often have designated servicing branch for fiduciary oversight, trustee meetings, and beneficiary interactions. Required for local jurisdiction compliance, fiduciary duty documentation,',
    `parent_trust_account_id` BIGINT COMMENT 'Self-referencing FK on trust_account (parent_trust_account_id)',
    `aum_amount` DECIMAL(18,2) COMMENT 'Total market value of assets held within the trust account as of the most recent valuation date.',
    `aum_as_of_date` DATE COMMENT 'Date on which the AUM amount was calculated and reported.',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the primary currency in which trust assets and distributions are denominated.. Valid values are `^[A-Z]{3}$`',
    `beneficiary_count` STRING COMMENT 'Total number of beneficiaries designated to receive distributions or benefits from the trust.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this trust account record was first created in the wealth management system.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the trust account is subject to CRS reporting requirements for automatic exchange of financial account information.',
    `distribution_frequency` STRING COMMENT 'Scheduled frequency at which distributions are made to beneficiaries according to trust terms.. Valid values are `monthly|quarterly|semi_annually|annually|discretionary|event_driven`',
    `distribution_provision_type` STRING COMMENT 'Classification of the distribution rules governing how and when trust assets are distributed to beneficiaries.. Valid values are `discretionary|mandatory|income_only|principal_and_income|unitrust|annuity`',
    `effective_date` DATE COMMENT 'Date on which the trust became operational and began holding assets for beneficiaries.',
    `fatca_status` STRING COMMENT 'FATCA classification status of the trust for US tax reporting and withholding requirements.. Valid values are `us_person|specified_us_person|non_us|exempt|passive_nffe|active_nffe`',
    `fiduciary_duty_classification` STRING COMMENT 'Classification of the fiduciary responsibility and duty of care owed to the trust beneficiaries.. Valid values are `trustee|executor|administrator|guardian|conservator|custodian`',
    `governing_law_jurisdiction` STRING COMMENT 'State or country jurisdiction whose laws govern the interpretation and administration of the trust.',
    `grantor_name` STRING COMMENT 'Full legal name of the individual or entity who established the trust and transferred assets into it.',
    `grantor_tax_identifier` STRING COMMENT 'Tax identification number of the grantor for IRS reporting and tax compliance purposes.',
    `investment_objective` STRING COMMENT 'Stated investment goal and strategy for managing trust assets, aligned with the trust purpose and beneficiary needs.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`estate_plan` (
    `estate_plan_id` BIGINT COMMENT 'Unique identifier for the estate plan record. Primary key.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager responsible for this estate planning engagement.',
    `employee_id` BIGINT COMMENT 'Reference to the estate planning specialist or advisor who prepared the plan.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Estate plans often executed at specific branch with notary, witnesses, and legal counsel present. Required for legal documentation validity, jurisdiction compliance (state-specific estate law), docume',
    `party_id` BIGINT COMMENT 'Reference to the wealth management client for whom this estate plan is created.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Estate plans are subject to jurisdiction-specific estate tax and probate law. Estate tax calculation, asset distribution strategy, and legal document preparation require country reference.',
    `trust_account_id` BIGINT COMMENT 'Foreign key linking to wealth.trust_account. Business justification: Estate plans often involve trust accounts as implementation vehicles. This optional FK links estate planning documents to the trust accounts they govern. No redundant columns to remove (estate plan tr',
    `previous_estate_plan_id` BIGINT COMMENT 'Self-referencing FK on estate_plan (previous_estate_plan_id)',
    `alternate_executor_name` STRING COMMENT 'Full name of the alternate executor if the primary executor is unable to serve.',
    `approval_date` DATE COMMENT 'Date when the estate plan was formally approved by the client.',
    `business_succession_flag` BOOLEAN COMMENT 'Indicates whether the estate plan includes business succession planning provisions.',
    `charitable_beneficiary_count` STRING COMMENT 'Number of charitable organizations designated as beneficiaries in the estate plan.',
    `charitable_giving_flag` BOOLEAN COMMENT 'Indicates whether the estate plan includes charitable giving provisions.',
    `contingent_beneficiary_count` STRING COMMENT 'Number of contingent beneficiaries designated in the estate plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the estate plan record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the estate plan becomes legally effective and binding.',
    `estate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for estate valuation.. Valid values are `^[A-Z]{3}$`',
    `estimated_estate_tax_liability` DECIMAL(18,2) COMMENT 'Estimated estate tax liability based on current estate value and applicable tax laws.',
    `executor_name` STRING COMMENT 'Full name of the primary executor designated to administer the estate.',
    `expiration_date` DATE COMMENT 'Date when the estate plan expires or requires renewal, if applicable.',
    `guardian_name` STRING COMMENT 'Full name of the individual designated as guardian for minor children or dependents.',
    `guardianship_designation_flag` BOOLEAN COMMENT 'Indicates whether the estate plan includes guardianship designations for minor children or dependents.',
    `healthcare_proxy_name` STRING COMMENT 'Full name of the individual designated to make healthcare decisions on behalf of the client.',
    `last_review_date` DATE COMMENT 'Date when the estate plan was last reviewed with the client.',
    `legal_counsel_name` STRING COMMENT 'Name of the law firm or attorney who prepared the estate planning documents.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total life insurance coverage amount designated for estate liquidity and beneficiary support.',
    `living_will_flag` BOOLEAN COMMENT 'Indicates whether a living will or advance healthcare directive is included in the estate plan.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the estate plan.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the estate plan.',
    `plan_name` STRING COMMENT 'Descriptive name or title of the estate plan for identification purposes.',
    `plan_number` STRING COMMENT 'Business identifier for the estate plan, used for external reference and client communication.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the estate plan. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|expired|terminated — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the estate plan based on structure and complexity.. Valid values are `comprehensive|basic|trust_based|will_based|charitable|business_succession`',
    `power_of_attorney_holder` STRING COMMENT 'Full name of the individual designated to hold power of attorney.',
    `power_of_attorney_type` STRING COMMENT 'Type of power of attorney designation included in the estate plan.. Valid values are `durable|general|limited|springing|healthcare|none`',
    `primary_beneficiary_count` STRING COMMENT 'Number of primary beneficiaries designated in the estate plan.',
    `primary_jurisdiction` STRING COMMENT 'Primary legal jurisdiction governing the estate plan, using ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `review_frequency` STRING COMMENT 'Frequency at which the estate plan should be reviewed and updated.. Valid values are `annual|biennial|triennial|event_driven|as_needed`',
    `secondary_jurisdiction` STRING COMMENT 'Secondary legal jurisdiction if the estate spans multiple countries, using ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `tax_minimization_strategy` STRING COMMENT 'Description of the tax minimization strategies employed in the estate plan.',
    `total_estate_value` DECIMAL(18,2) COMMENT 'Total estimated value of the clients estate covered by this plan.',
    `trust_document_reference` STRING COMMENT 'Reference identifier or location of the trust agreement document.',
    `trust_structure_type` STRING COMMENT 'Type of trust structure incorporated into the estate plan, if any.. Valid values are `revocable_living_trust|irrevocable_trust|charitable_trust|special_needs_trust|generation_skipping_trust|none`',
    `trustee_name` STRING COMMENT 'Full name of the primary trustee designated to manage trust assets.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the estate plan record was last updated in the system.',
    `will_document_reference` STRING COMMENT 'Reference identifier or location of the last will and testament document.',
    `will_execution_date` DATE COMMENT 'Date when the will was executed and signed by the client.',
    CONSTRAINT pk_estate_plan PRIMARY KEY(`estate_plan_id`)
) COMMENT 'Estate planning record for wealth management clients capturing estate plan components, beneficiary designations, power of attorney, and succession planning elements.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`alternative_investment` (
    `alternative_investment_id` BIGINT COMMENT 'Unique identifier for the alternative investment holding record. Primary key for this entity.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Alternative investment capital calls, distributions, and secondary market transactions are captured as OTC trades for settlement processing and regulatory reporting (EMIR, Dodd-Frank). Links subscript',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Alternative investments require deposit accounts for capital call funding and distribution receipts in private equity, hedge funds, and real estate investments. Essential for alternative investment ca',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Alternative investments (private equity, hedge funds) are pledged as collateral for credit facilities. Real business process: alternative asset-backed lending where illiquid investments secure credit ',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Alternative investments (hedge funds, private equity, fund-of-funds) create counterparty credit exposure via unfunded commitments and manager default risk. Credit risk calculates EAD on unfunded commi',
    `custodian_account_id` BIGINT COMMENT 'Reference to the custodian account where this alternative investment is held.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Alternative investments (private equity, hedge funds, real estate funds) are typically structured as funds. Required for commitment tracking, capital call processing, NAV valuation, and linking alt in',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Private equity/hedge fund capital calls and distributions execute via payment instructions. Operations teams must track which payment settled each capital call or distribution for commitment tracking,',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Links alternative investments (private equity, hedge funds, structured products) to master security registry when they have formal ISINs or identifiers for regulatory reporting (AIFMD), risk aggregati',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Alternative investments require quarterly fair value adjustments, capital call accounting, and distribution recognition via journal entries. Real banking process: private equity/hedge fund accounting ',
    `managed_portfolio_id` BIGINT COMMENT 'Reference to the wealth management portfolio that holds this alternative investment.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Alternative investment NAV is reported in specific currency by fund manager. Portfolio valuation aggregation, performance reporting, and fair value hierarchy disclosure require valid currency referenc',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Alternative investments (PE, VC funds) are often structured or originated through investment banking deals. Real business process: tracking deal origination for alternative investments to maintain cli',
    `party_id` BIGINT COMMENT 'Reference to the client who owns this alternative investment through their portfolio.',
    `previous_alternative_investment_id` BIGINT COMMENT 'Self-referencing FK on alternative_investment (previous_alternative_investment_id)',
    `carried_interest_rate` DECIMAL(18,2) COMMENT 'Performance fee or carried interest rate earned by the general partner on profits above the hurdle rate, expressed as a decimal (e.g., 0.2000 for 20%).',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Total capital commitment made by the investor to the alternative investment fund. Represents the maximum amount that can be called.',
    `commitment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the commitment amount.. Valid values are `^[A-Z]{3}$`',
    `commitment_date` DATE COMMENT 'Date on which the investor committed capital to the alternative investment fund.',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original cost basis of the alternative investment for tax reporting purposes. Typically equals funded amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this alternative investment record was first created in the system.',
    `distributions_received` DECIMAL(18,2) COMMENT 'Cumulative distributions received from the alternative investment fund to date, including return of capital and profits.',
    `dpi_multiple` DECIMAL(18,2) COMMENT 'Distributions to paid-in capital multiple, calculated as distributions received divided by funded amount. Measures cash returned.',
    `expected_liquidation_date` DATE COMMENT 'Expected date by which the fund will be fully liquidated and all capital returned to investors.',
    `fair_value_amount` DECIMAL(18,2) COMMENT 'Fair value of the alternative investment holding for financial reporting purposes, which may differ from NAV.',
    `fair_value_hierarchy_level` STRING COMMENT 'IFRS 13 fair value hierarchy classification indicating the observability of inputs used in valuation (Level 1: quoted prices, Level 2: observable inputs, Level 3: unobservable inputs).. Valid values are `level_1|level_2|level_3`',
    `fund_manager_identifier` STRING COMMENT 'Regulatory or industry identifier for the fund manager (e.g., SEC CRD number, FCA FRN).',
    `fund_manager_name` STRING COMMENT 'Name of the general partner or fund manager responsible for managing the alternative investment.',
    `fund_term_years` STRING COMMENT 'Total term of the fund in years, including any extension periods.',
    `fund_vintage_year` STRING COMMENT 'The year in which the fund began making investments, used for performance benchmarking and cohort analysis.',
    `funded_amount` DECIMAL(18,2) COMMENT 'Total amount of capital that has been called and funded to date. Sum of all capital calls paid.',
    `hurdle_rate` DECIMAL(18,2) COMMENT 'Minimum return threshold that must be achieved before the general partner earns carried interest, expressed as a decimal.',
    `inception_date` DATE COMMENT 'Date on which the alternative investment fund was established or first began operations.',
    `investment_name` STRING COMMENT 'Full legal or marketing name of the alternative investment fund or vehicle.',
    `investment_number` STRING COMMENT 'Business-facing unique identifier or reference number for this alternative investment holding.',
    `investment_period_end_date` DATE COMMENT 'Date on which the funds investment period ends, after which no new investments can be made.',
    `investment_status` STRING COMMENT 'Current lifecycle status of the alternative investment holding. Tracks progression from commitment through liquidation.. Valid values are `committed|funding|active|harvesting|liquidated|written_off`',
    `investment_strategy` STRING COMMENT 'Detailed description of the investment strategy employed by the fund (e.g., buyout, growth equity, distressed debt, long-short equity, core real estate).',
    `investment_type` STRING COMMENT 'Classification of the alternative investment by asset class. Includes private equity, venture capital, hedge funds, real estate, infrastructure, and commodities.. Valid values are `private_equity|venture_capital|hedge_fund|real_estate|infrastructure|commodities`',
    `irr_percent` DECIMAL(18,2) COMMENT 'Internal rate of return on the alternative investment since inception, expressed as a percentage.',
    `liquidity_classification` STRING COMMENT 'Classification of the alternative investments liquidity profile for portfolio risk management and asset allocation.. Valid values are `illiquid|semi_liquid|liquid`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee rate charged by the fund manager, expressed as a decimal (e.g., 0.0200 for 2.00%).',
    `moic_multiple` DECIMAL(18,2) COMMENT 'Multiple on invested capital, calculated as (distributions received plus NAV) divided by funded amount.',
    `nav_amount` DECIMAL(18,2) COMMENT 'Current net asset value of the alternative investment holding as reported by the fund manager.',
    `nav_as_of_date` DATE COMMENT 'Date as of which the NAV amount was calculated or reported by the fund manager.',
    `nav_reporting_frequency` STRING COMMENT 'Frequency at which the fund manager provides NAV updates for this alternative investment.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Cumulative realized gains or losses from distributions received that exceed the cost basis.',
    `rvpi_multiple` DECIMAL(18,2) COMMENT 'Residual value to paid-in capital multiple, calculated as NAV divided by funded amount. Measures unrealized value.',
    `side_letter_flag` BOOLEAN COMMENT 'Indicates whether a side letter agreement exists that modifies standard fund terms for this investor.',
    `tvpi_multiple` DECIMAL(18,2) COMMENT 'Total value to paid-in capital multiple, calculated as (distributions plus NAV) divided by funded amount. Synonym for MOIC.',
    `unfunded_commitment` DECIMAL(18,2) COMMENT 'Remaining capital commitment that has not yet been called. Calculated as commitment amount minus funded amount.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Unrealized gain or loss on the alternative investment, calculated as fair value minus cost basis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this alternative investment record was last modified in the system.',
    `valuation_method` STRING COMMENT 'Description of the valuation methodology used to determine fair value (e.g., DCF, comparable transactions, market multiples, NAV).',
    CONSTRAINT pk_alternative_investment PRIMARY KEY(`alternative_investment_id`)
) COMMENT 'Alternative investment holding record for private equity, hedge fund, real estate, and other illiquid investments held in wealth management portfolios. Captures commitment, capital calls, distributions, and NAV updates.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`wealth_holding` (
    `wealth_holding_id` BIGINT COMMENT 'Primary key for wealth_holding',
    `wealth_portfolio_holding_id` BIGINT COMMENT 'Unique identifier for this portfolio holding position. Primary key.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument held in this position',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio that holds this position',
    `tax_lot_id` BIGINT COMMENT 'Reference to the specific tax lot for this position, used for tax-efficient harvesting and reporting. Explicitly identified in detection phase as relationship-specific data.',
    `acquisition_date` DATE COMMENT 'Date when this position was acquired or established in the portfolio. Explicitly identified in detection phase as relationship-specific data.',
    `last_valuation_date` DATE COMMENT 'Date when the market value and unrealized gain/loss were last calculated for this position.',
    `market_value` DECIMAL(18,2) COMMENT 'Current market value of this position in the portfolio base currency. Explicitly identified in detection phase as relationship-specific data.',
    `period_classification` STRING COMMENT 'Tax classification of the holding period (short-term < 1 year, long-term >= 1 year) affecting capital gains tax treatment. Explicitly identified in detection phase as relationship-specific data.',
    `portfolio_weight` DECIMAL(18,2) COMMENT 'Percentage of total portfolio AUM represented by this position, used for allocation analysis and rebalancing decisions. Explicitly identified in detection phase as relationship-specific data.',
    `position_status` STRING COMMENT 'Current lifecycle status of this holding position within the portfolio.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares of the instrument held in this position. Explicitly identified in detection phase as relationship-specific data.',
    `unit_cost_basis` DECIMAL(18,2) COMMENT 'Average cost per unit for this position, used for performance calculation and tax reporting. Explicitly identified in detection phase as relationship-specific data.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Difference between current market value and cost basis, representing unrealized profit or loss on this position. Explicitly identified in detection phase as relationship-specific data.',
    CONSTRAINT pk_wealth_holding PRIMARY KEY(`wealth_holding_id`)
) COMMENT 'This association product represents the position or holding relationship between a managed portfolio and a financial instrument. It captures the investment position data that exists only in the context of a specific portfolio holding a specific instrument. Each record represents one instrument position within one portfolio, tracking quantity, cost basis, acquisition details, market value, and tax lot information essential for portfolio management, performance reporting, and tax optimization.. Existence Justification: In wealth management operations, one managed portfolio holds multiple financial instruments simultaneously (equities, bonds, derivatives across asset classes), and one instrument is held by many different client portfolios. Portfolio managers actively create, rebalance, and close positions as part of investment management. The business concept is holding or position - a fundamental operational entity that portfolio managers query daily (show me all holdings in this portfolio, which portfolios hold this security).';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_pledge` (
    `portfolio_pledge_id` BIGINT COMMENT 'Unique identifier for this portfolio-pledge assignment relationship. Primary key.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to the pledge obligation being secured by the portfolio',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio being pledged as collateral security',
    `assignment_effective_date` DATE COMMENT 'The date from which this portfolio-pledge assignment becomes legally effective and enforceable. Required for tracking when each portfolio begins securing each obligation.',
    `assignment_maturity_date` DATE COMMENT 'The date on which this portfolio-pledge assignment expires or is scheduled to be released, if applicable. Supports term-limited collateral arrangements.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this portfolio-pledge assignment record was created.',
    `eligible_collateral_value` DECIMAL(18,2) COMMENT 'The collateral value of this portfolio after applying the haircut, representing the amount eligible to cover this pledge obligation. Moved from pledge entity because it is calculated per portfolio.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to this portfolios market value to determine its eligible collateral value for this specific pledge. Moved from pledge entity because haircut varies by portfolio composition, risk profile, and asset class mix.',
    `last_valuation_date` DATE COMMENT 'The date on which this portfolio was last valued for purposes of monitoring this pledges collateral coverage. Required for LTV and margin monitoring.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'The ratio of the outstanding credit exposure to the current market value of this specific portfolio, expressed as a percentage. Moved from pledge entity because LTV is calculated per portfolio in cross-collateralization arrangements.',
    `margin_call_threshold` DECIMAL(18,2) COMMENT 'The collateral value threshold below which a margin call is triggered for this portfolio-pledge combination. Varies by portfolio risk profile and secured party requirements.',
    `pledge_amount` DECIMAL(18,2) COMMENT 'The monetary value of this specific portfolio pledged to this specific obligation, expressed in the pledge currency. Moved from pledge entity because pledge_amount is portfolio-specific in cross-collateralization scenarios.',
    `pledge_date` DATE COMMENT 'The date on which this specific portfolio was formally pledged to secure this specific obligation. Moved from pledge entity because pledge_date varies by portfolio when multiple portfolios secure the same pledge.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of this portfolio-pledge assignment: active (in force), released (returned to client), substituted (replaced with alternative collateral), enforced (seized), defaulted, suspended. Moved from pledge entity because status can vary by portfolio.',
    `portfolio_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of this portfolios value allocated to secure this specific pledge, used when a portfolio is partially pledged or split across multiple obligations. Supports proportional cross-collateralization.',
    `release_date` DATE COMMENT 'The date on which this specific portfolio was released from this pledge and returned to the client upon satisfaction of the secured obligation or substitution. Moved from pledge entity because release timing varies by portfolio.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the client has the contractual right to substitute this specific portfolio with alternative collateral for this pledge. Moved from pledge entity because substitution rights can vary by portfolio.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this portfolio-pledge assignment record was last updated.',
    CONSTRAINT pk_portfolio_pledge PRIMARY KEY(`portfolio_pledge_id`)
) COMMENT 'This association product represents the operational assignment of a managed investment portfolio as collateral security through a formal pledge arrangement. It captures the specific terms, conditions, and lifecycle of each portfolio-pledge relationship, including pledge-specific haircuts, LTV monitoring, substitution rights, and release conditions. Each record links one managed portfolio to one pledge obligation with attributes that exist only in the context of this collateral assignment relationship. Supports cross-collateralization scenarios where a single portfolio secures multiple credit facilities or a single pledge draws from multiple portfolio sources.. Existence Justification: In wealth management and collateral operations, a single managed portfolio can be pledged to secure multiple distinct credit obligations (margin lending facility, derivatives exposure, repo transactions) with different secured parties, haircuts, and terms. Conversely, a single pledge obligation can be secured by multiple portfolios in cross-collateralization arrangements where the client pools portfolio assets to meet collateral requirements. The business actively manages these portfolio-pledge assignments with portfolio-specific terms including haircuts, LTV monitoring, margin call thresholds, and sequential release conditions.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`holding_pledge` (
    `holding_pledge_id` BIGINT COMMENT 'Unique identifier for this holding-pledge assignment record. Primary key.',
    `collateral_pledge_id` BIGINT COMMENT 'Foreign key linking to the collateral pledge arrangement that this holding secures',
    `wealth_portfolio_holding_id` BIGINT COMMENT 'Foreign key linking to the specific portfolio holding (security position) being pledged as collateral',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding-pledge assignment record was created in the collateral management system.',
    `eligible_value` DECIMAL(18,2) COMMENT 'The collateral value of this specific holding after applying the haircut, representing the amount eligible for credit risk mitigation. Calculated as (pledged_quantity × market_price × (1 - haircut_percentage)).',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to this specific holdings market value to determine its eligible collateral value. May vary by security type, credit quality, and liquidity even within the same pledge arrangement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding-pledge assignment record was last modified (e.g., quantity adjustment, status change, haircut update).',
    `pledge_date` DATE COMMENT 'The date on which this specific holding was assigned to this specific pledge arrangement. May differ from the overall pledge_date if holdings are added to an existing pledge over time.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of this specific holding-pledge assignment: active (currently pledged), released (returned to unpledged status), substituted (replaced with alternative collateral), pending_release (scheduled for release), enforced (seized by secured party).',
    `pledged_quantity` DECIMAL(18,2) COMMENT 'The specific quantity of units from the portfolio holding that are allocated to this pledge. Enables partial pledging where a holding is split across multiple facilities (e.g., 500 shares to Facility A, 300 to Facility B, 200 unpledged).',
    `release_date` DATE COMMENT 'The date on which this specific holding was released from this pledge arrangement and returned to unpledged status. Null if still active.',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether the obligor has the contractual right to substitute this specific holding with alternative collateral under the governing CSA agreement. May vary by security within the same pledge.',
    CONSTRAINT pk_holding_pledge PRIMARY KEY(`holding_pledge_id`)
) COMMENT 'This association product represents the operational assignment of a specific portfolio holding (security position) to a specific collateral pledge arrangement. It captures the granular pledge allocation that exists only in the context of this relationship. Each record links one portfolio holding to one pledge with attributes tracking the quantity pledged, haircut applied, eligible value, and lifecycle status of that specific holding-pledge pairing. Supports partial pledging scenarios where a single holding is split across multiple credit facilities, and basket collateral scenarios where a single pledge encompasses multiple securities.. Existence Justification: In banking collateral operations, a single portfolio holding (e.g., 1000 shares of a security) can be partially pledged across multiple credit facilities or derivative obligations simultaneously (500 shares to Facility A, 300 to Facility B, 200 unpledged). Conversely, a single pledge arrangement frequently encompasses multiple holdings as basket collateral. Collateral operations teams actively manage these granular holding-pledge assignments, tracking pledged quantities, security-specific haircuts, eligible values, and lifecycle status (active, released, substituted) for each holding-pledge pairing.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_servicing` (
    `portfolio_servicing_id` BIGINT COMMENT 'Unique identifier for this portfolio-branch servicing relationship record. Primary key.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to the branch providing servicing',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio being serviced',
    `employee_id` BIGINT COMMENT 'Reference to the employee at this branch who serves as the primary contact for this portfolio. Specific to this portfolio-branch combination.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this servicing relationship record was created.',
    `last_review_date` DATE COMMENT 'Date when this servicing relationship was last reviewed or when the client last met with branch staff. Tracks engagement specific to this portfolio-branch relationship.',
    `portfolio_servicing_status` STRING COMMENT 'Current status of this servicing relationship: active (currently servicing), suspended (temporarily inactive), terminated (permanently ended), pending (awaiting activation).',
    `service_level_tier` STRING COMMENT 'Service level agreement tier for this portfolio at this specific branch. May vary by branch based on local capabilities and client preferences.',
    `servicing_end_date` DATE COMMENT 'Date when this branch ceased providing services to this portfolio. Null for active servicing relationships.',
    `servicing_start_date` DATE COMMENT 'Date when this branch began providing services to this portfolio. Tracks temporal validity of the servicing relationship.',
    `servicing_type` STRING COMMENT 'Classification of the servicing relationship: primary (main servicing branch), secondary (additional service location), trust (trust services), vacation (seasonal location), temporary (short-term arrangement).',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this servicing relationship record was last updated.',
    CONSTRAINT pk_portfolio_servicing PRIMARY KEY(`portfolio_servicing_id`)
) COMMENT 'This association product represents the servicing relationship between a managed portfolio and a branch location. It captures which branches provide wealth management services to which portfolios, including service type (primary/secondary/trust), assigned contacts, service level agreements, and temporal validity. Each record links one managed portfolio to one branch with attributes that exist only in the context of this servicing relationship.. Existence Justification: In wealth management operations, high-net-worth portfolios are commonly serviced by multiple branch locations to accommodate client mobility and specialized service needs. A portfolio may have a primary servicing branch, a vacation location branch for seasonal access, and a trust services branch for specialized fiduciary services. Conversely, each branch services multiple portfolios. The business actively manages these servicing relationships with specific start/end dates, service types, assigned contacts, and service level tiers that vary by portfolio-branch combination.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` (
    `portfolio_broker_relationship_id` BIGINT COMMENT 'Unique identifier for this portfolio-broker relationship record. Primary key.',
    `broker_id` BIGINT COMMENT 'Foreign key linking to the broker providing execution and post-trade services',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio that has established this broker relationship',
    `commission_rate` DECIMAL(18,2) COMMENT 'Negotiated commission rate (in basis points or percentage) specific to this portfolio-broker relationship, which may differ from the brokers default rate based on portfolio AUM, trading volume, or relationship terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio-broker relationship record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this portfolio-broker relationship became active and the broker was approved for executing trades on behalf of this portfolio.',
    `last_trade_date` DATE COMMENT 'Date of the most recent trade executed by this broker for this portfolio, used for relationship monitoring and broker panel review.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special instructions, or relationship-specific terms applicable to this portfolio-broker pairing.',
    `portfolio_broker_relationship_status` STRING COMMENT 'Current operational status of this portfolio-broker relationship: active (approved for trading), suspended (temporarily inactive), terminated (relationship ended), or pending_approval (under review).',
    `preferred_asset_classes` STRING COMMENT 'Comma-separated list of asset classes for which this broker is preferred or approved for execution within this specific portfolio (e.g., equities, fixed_income, derivatives). May be a subset of the brokers overall eligible asset classes based on portfolio strategy and broker expertise.',
    `relationship_type` STRING COMMENT 'Classification of the brokers role in the portfolios broker panel: primary (main execution partner), secondary (alternative execution), tertiary (specialized execution), or backup (contingency).',
    `termination_date` DATE COMMENT 'Date on which this portfolio-broker relationship was terminated or is scheduled to terminate. Null for active relationships.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio-broker relationship record was last modified.',
    `ytd_commission_paid` DECIMAL(18,2) COMMENT 'Total commission fees paid to this broker for trades executed on behalf of this portfolio in the current calendar year.',
    `ytd_trade_volume` DECIMAL(18,2) COMMENT 'Total notional value of trades executed by this broker for this portfolio in the current calendar year, used for commission analysis and broker panel rebalancing.',
    CONSTRAINT pk_portfolio_broker_relationship PRIMARY KEY(`portfolio_broker_relationship_id`)
) COMMENT 'This association product represents the ongoing commercial relationship between a managed portfolio and an executing/prime broker. It captures broker panel management, negotiated commission rates, relationship type (primary/secondary/tertiary), preferred asset classes for execution, and the effective period of the relationship. Each record links one managed portfolio to one broker with attributes that exist only in the context of this specific portfolio-broker arrangement.. Existence Justification: In wealth management operations, portfolio managers actively manage broker panels where each managed portfolio maintains relationships with multiple brokers for execution diversity and best execution compliance, and each broker serves multiple portfolios. The relationship is operationally managed with portfolio-specific negotiated commission rates, relationship type classifications (primary/secondary/tertiary), and preferred asset classes that vary by portfolio-broker combination. This is a recognized business process called broker panel management.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_assignment` (
    `portfolio_assignment_id` BIGINT COMMENT 'Unique identifier for the portfolio assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to the portfolio',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio being assigned',
    `assignment_status` STRING COMMENT 'Current status of the assignment. Active assignments are operational, suspended assignments are temporarily inactive, terminated assignments are historical.',
    `end_date` DATE COMMENT 'Date when the employee assignment to this portfolio ended. Null for active assignments. Used for historical tracking and audit trail.',
    `primary_contact_flag` BOOLEAN COMMENT 'Indicates whether this employee is the primary client contact for this portfolio. Only one employee per portfolio should have this flag set to true at any time.',
    `responsibility_percentage` DECIMAL(18,2) COMMENT 'Percentage of responsibility allocated to this employee for this portfolio. Used for compensation allocation and workload management. Sum across all active assignments for a portfolio should equal 100%.',
    `role_type` STRING COMMENT 'The specific role the employee plays in managing this portfolio. Determines responsibility level and compensation allocation.',
    `start_date` DATE COMMENT 'Date when the employee was assigned to this portfolio. Used for audit trail and compensation calculation.',
    CONSTRAINT pk_portfolio_assignment PRIMARY KEY(`portfolio_assignment_id`)
) COMMENT 'This association product represents the Assignment between managed_portfolio and employee. It captures the team-based wealth management structure where multiple employees (lead advisor, junior advisor, specialist, compliance reviewer) are assigned to a portfolio with specific roles and responsibilities. Each record links one managed_portfolio to one employee with attributes that exist only in the context of this assignment relationship.. Existence Justification: In team-based wealth management operations, portfolios are managed by multiple employees with different roles (lead advisor, junior advisor, specialist, compliance reviewer), and employees manage multiple portfolios. The business actively manages these assignments with specific role types, responsibility percentages for compensation allocation, and assignment dates for audit trail and regulatory compliance. This is a recognized operational relationship in private banking and wealth management.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` (
    `portfolio_stress_application_id` BIGINT COMMENT 'Unique surrogate identifier for this portfolio stress test application record. Primary key.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to the managed portfolio being subjected to stress testing',
    `stress_test_run_id` BIGINT COMMENT 'Reference identifier for the specific stress testing run or batch in which this scenario was applied to this portfolio. Links to stress run execution metadata in the risk platform.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to the stress testing scenario being applied',
    `calculation_status` STRING COMMENT 'Current status of the stress calculation for this portfolio-scenario combination. Values: pending, in_progress, completed, failed, approved.',
    `capital_impact` DECIMAL(18,2) COMMENT 'The estimated capital impact (loss or gain) on the firms regulatory capital resulting from this portfolios performance under this stress scenario. Used for CCAR/DFAST capital adequacy calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio stress application record was created in the risk data warehouse.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio stress application record was last updated or recalculated.',
    `portfolio_scope_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this portfolio is in scope for this particular stress scenario run. True = portfolio included in regulatory submission, False = portfolio excluded or out of scope.',
    `scenario_application_date` DATE COMMENT 'The date on which this stress scenario was applied to this portfolio for stress testing purposes. Represents the as-of date for the stress run.',
    `stressed_portfolio_value` DECIMAL(18,2) COMMENT 'The projected market value of the portfolio under this stress scenario at the scenario horizon, expressed in the portfolios base currency. Represents the stressed AUM after applying scenario shocks.',
    `stressed_return` DECIMAL(18,2) COMMENT 'The portfolio return (percentage) under this stress scenario over the scenario horizon. Calculated as (stressed_portfolio_value - baseline_value) / baseline_value.',
    `submission_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this portfolio-scenario result was included in the regulatory submission to the Fed/OCC/EBA. True = included in official submission.',
    CONSTRAINT pk_portfolio_stress_application PRIMARY KEY(`portfolio_stress_application_id`)
) COMMENT 'This association product represents the application of a regulatory or internal stress testing scenario to a specific managed portfolio. It captures the portfolio-specific stressed outcomes, capital impacts, and scenario participation metadata required for CCAR, DFAST, ICAAP regulatory submissions and ALCO reporting. Each record links one managed portfolio to one stress scenario with attributes that exist only in the context of this stress test application.. Existence Justification: In regulatory stress testing operations, a single managed portfolio must be evaluated under multiple stress scenarios (CCAR baseline, adverse, severely adverse, ICAAP, reverse stress) to meet regulatory requirements. Conversely, each stress scenario is applied to multiple portfolios across the wealth management book to calculate aggregate capital impacts. The relationship represents an operational business process where risk teams actively apply scenarios to portfolios, calculate stressed outcomes, and track results for regulatory submissions.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` (
    `prime_broker_agreement_id` BIGINT COMMENT 'Primary key for prime_broker_agreement',
    `approved_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the prime brokerage agreement for activation, typically a credit officer or authorized signatory.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the business unit or division within the bank responsible for this prime brokerage agreement.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the custodian entity responsible for safeguarding client assets, if custody is provided by a third party. Nullable if prime broker provides custody.',
    `employee_id` BIGINT COMMENT 'Identifier of the relationship manager or coverage officer responsible for managing the client relationship under this agreement.',
    `party_id` BIGINT COMMENT 'Identifier of the client (hedge fund, institutional investor, or high-net-worth individual) entering into the prime brokerage agreement.',
    `prime_broker_entity_id` BIGINT COMMENT 'Identifier of the legal entity within the banking organization acting as the prime broker under this agreement.',
    `previous_prime_broker_agreement_id` BIGINT COMMENT 'Self-referencing FK on prime_broker_agreement (previous_prime_broker_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the prime brokerage agreement, typically used in client communications and regulatory reporting.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the prime brokerage agreement, reflecting its operational validity and enforceability.',
    `agreement_type` STRING COMMENT 'Classification of the prime brokerage agreement structure, indicating the scope and nature of services provided.',
    `aml_kyc_status` STRING COMMENT 'Status of the clients AML and KYC compliance documentation required to maintain the prime brokerage relationship.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the prime brokerage agreement was formally approved and authorized for execution.',
    `client_classification` STRING COMMENT 'MiFID II classification of the client for the purposes of this agreement, determining the level of regulatory protection and disclosure requirements.',
    `collateral_valuation_frequency` STRING COMMENT 'Frequency at which collateral pledged under the agreement is revalued for margin calculation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the prime brokerage agreement record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure the prime broker is willing to extend to the client under this agreement, denominated in the agreement currency.',
    `credit_limit_currency` STRING COMMENT 'Currency in which the credit limit is denominated, represented as ISO 4217 three-letter code.',
    `custody_arrangement` STRING COMMENT 'Structure for holding client assets, indicating whether custody is provided by the prime broker, a third-party custodian, or through a tri-party arrangement.',
    `default_cure_period_days` STRING COMMENT 'Number of days the client has to remedy a default or breach before the prime broker may exercise termination rights.',
    `effective_date` DATE COMMENT 'Date when the prime brokerage agreement becomes legally binding and services commence.',
    `financing_rate_basis` STRING COMMENT 'Benchmark interest rate basis used for calculating financing charges on margin loans and short positions under this agreement.',
    `financing_spread_bps` STRING COMMENT 'Spread in basis points added to the financing rate basis to determine the total financing cost charged to the client.',
    `governing_law` STRING COMMENT 'Jurisdiction whose laws govern the interpretation and enforcement of the agreement, represented as ISO 3166-1 alpha-3 country code.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the prime brokerage agreement is currently active and operational, derived from agreement status for quick filtering.',
    `last_review_date` DATE COMMENT 'Date when the agreement terms, credit limits, and risk parameters were last reviewed and approved by the credit committee or authorized officer.',
    `lei_required` BOOLEAN COMMENT 'Indicates whether the client is required to maintain a valid Legal Entity Identifier for regulatory reporting under this agreement.',
    `margin_call_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum exposure amount that triggers a margin call under this agreement, denominated in the agreement currency.',
    `margin_requirement_percentage` DECIMAL(18,2) COMMENT 'Initial margin percentage required for leveraged positions under this agreement, expressed as a percentage of position value.',
    `master_agreement_type` STRING COMMENT 'Type of master legal framework underpinning the prime brokerage relationship (ISDA for derivatives, GMRA for repo, GMSLA for securities lending).',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum collateral transfer amount required to satisfy a margin call, reducing operational burden for small movements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the prime brokerage agreement record was last modified in the system.',
    `netting_arrangement` STRING COMMENT 'Type of netting agreement in place for offsetting obligations and exposures between the parties, critical for credit risk mitigation.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the agreement terms, credit limits, and risk parameters.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement without cause.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the agreement is subject to regulatory reporting requirements (e.g., EMIR, Dodd-Frank, MiFID II).',
    `rehypothecation_allowed` BOOLEAN COMMENT 'Indicates whether the prime broker is permitted to rehypothecate client assets pledged as collateral under this agreement.',
    `rehypothecation_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of client collateral that may be rehypothecated, if rehypothecation is allowed. Nullable if rehypothecation is not permitted.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the prime broker provides portfolio valuation, position, and risk reports to the client.',
    `risk_rating` STRING COMMENT 'Internal credit and operational risk rating assigned to this prime brokerage agreement, reflecting the clients creditworthiness and operational complexity.',
    `services_scope` STRING COMMENT 'Textual description of the prime brokerage services covered under this agreement (e.g., securities lending, trade execution, custody, reporting, financing).',
    `termination_date` DATE COMMENT 'Date when the prime brokerage agreement ends or is scheduled to end. Nullable for open-ended agreements.',
    `termination_reason` STRING COMMENT 'Textual explanation of the reason for agreement termination, if applicable. Nullable for active agreements.',
    CONSTRAINT pk_prime_broker_agreement PRIMARY KEY(`prime_broker_agreement_id`)
) COMMENT 'Master reference table for prime_broker_agreement. Referenced by prime_broker_agreement_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`wealth`.`investment_committee` (
    `investment_committee_id` BIGINT COMMENT 'Primary key for investment_committee',
    `chair_employee_id` BIGINT COMMENT 'Identifier of the employee serving as the chairperson of the investment committee, responsible for leading meetings and decision-making processes.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who last modified the investment committee record.',
    `escalation_committee_id` BIGINT COMMENT 'Identifier of the committee to which decisions exceeding this committees authority are escalated for approval.',
    `reporting_line_committee_id` BIGINT COMMENT 'Identifier of the parent or oversight committee to which this investment committee reports, if applicable. Null for top-level committees.',
    `secretary_employee_id` BIGINT COMMENT 'Identifier of the employee serving as the secretary of the investment committee, responsible for documentation and administrative support.',
    `parent_investment_committee_id` BIGINT COMMENT 'Self-referencing FK on investment_committee (parent_investment_committee_id)',
    `approval_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary value of investment decisions that the committee is authorized to approve without escalation to higher authority.',
    `approval_limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approval limit amount.',
    `asset_class_scope` STRING COMMENT 'Comma-separated list of asset classes (equities, fixed income, alternatives, real estate, etc.) that fall within the committees purview.',
    `client_segment_scope` STRING COMMENT 'Client wealth segment(s) for which the committee makes investment decisions. HNW = High Net Worth, UHNW = Ultra High Net Worth.',
    `committee_code` STRING COMMENT 'Short alphanumeric code used to identify the committee in operational systems and reports.',
    `committee_name` STRING COMMENT 'Official name of the investment committee as registered within the wealth management organization.',
    `committee_type` STRING COMMENT 'Classification of the committee based on its mandate and scope of authority within the investment governance structure.',
    `compliance_framework` STRING COMMENT 'Regulatory and compliance frameworks that the committee must adhere to (e.g., MiFID II, Dodd-Frank, Basel III).',
    `conflict_of_interest_policy_flag` BOOLEAN COMMENT 'Indicates whether the committee has a formal conflict of interest policy that members must adhere to.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment committee record was first created in the system.',
    `decision_authority_level` STRING COMMENT 'Level of decision-making authority granted to the committee, indicating whether it has full autonomy or requires escalation for certain decisions.',
    `dissolution_date` DATE COMMENT 'Date when the investment committee was formally dissolved or ceased operations. Null for active committees.',
    `documentation_retention_years` STRING COMMENT 'Number of years that committee meeting minutes, decisions, and supporting documentation must be retained per regulatory and internal policy requirements.',
    `effective_from_date` DATE COMMENT 'Date from which the current committee configuration and mandate became effective.',
    `effective_to_date` DATE COMMENT 'Date until which the current committee configuration and mandate remain effective. Null for currently active configurations.',
    `establishment_date` DATE COMMENT 'Date when the investment committee was formally established and authorized to operate.',
    `external_advisor_allowed_flag` BOOLEAN COMMENT 'Indicates whether the committee is permitted to engage external advisors or consultants to support decision-making.',
    `geographic_scope` STRING COMMENT 'Geographic coverage area for which the investment committee has decision-making authority.',
    `investment_policy_statement_version` STRING COMMENT 'Version number of the Investment Policy Statement that governs the committees investment decisions and guidelines.',
    `last_meeting_date` DATE COMMENT 'Date of the most recent meeting held by the investment committee.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment committee record was last updated in the system.',
    `mandate_description` STRING COMMENT 'Detailed description of the committees charter, responsibilities, and decision-making authority within the investment governance framework.',
    `meeting_frequency` STRING COMMENT 'Standard frequency at which the investment committee convenes for regular meetings.',
    `meeting_location` STRING COMMENT 'Primary physical or virtual location where the investment committee conducts its regular meetings.',
    `next_scheduled_meeting_date` DATE COMMENT 'Date of the next scheduled meeting for the investment committee.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special considerations related to the investment committee.',
    `performance_benchmark` STRING COMMENT 'Primary benchmark index or composite used to evaluate the performance of investment decisions made by the committee.',
    `quorum_requirement` STRING COMMENT 'Minimum number of committee members required to be present for the committee to conduct official business and make binding decisions.',
    `record_source_system` STRING COMMENT 'Name of the source system from which the investment committee record originated (e.g., SimCorp Dimension, BlackRock Aladdin).',
    `regulatory_oversight_body` STRING COMMENT 'Name of the regulatory authority or governing body that oversees the committees activities and compliance requirements.',
    `risk_tolerance_level` STRING COMMENT 'Overall risk tolerance profile that guides the committees investment decision-making and asset allocation strategies.',
    `investment_committee_status` STRING COMMENT 'Current operational status of the investment committee indicating whether it is actively meeting and making decisions.',
    `total_member_count` STRING COMMENT 'Current total number of members serving on the investment committee.',
    `voting_threshold_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of affirmative votes required for the committee to approve investment decisions or policy changes.',
    CONSTRAINT pk_investment_committee PRIMARY KEY(`investment_committee_id`)
) COMMENT 'Master reference table for investment_committee. Referenced by investment_committee_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ADD CONSTRAINT `fk_wealth_managed_portfolio_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ADD CONSTRAINT `fk_wealth_investment_policy_statement_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ADD CONSTRAINT `fk_wealth_asset_allocation_parent_allocation_asset_allocation_id` FOREIGN KEY (`parent_allocation_asset_allocation_id`) REFERENCES `banking_ecm`.`wealth`.`asset_allocation`(`asset_allocation_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ADD CONSTRAINT `fk_wealth_wealth_portfolio_holding_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ADD CONSTRAINT `fk_wealth_portfolio_transaction_rebalancing_order_id` FOREIGN KEY (`rebalancing_order_id`) REFERENCES `banking_ecm`.`wealth`.`rebalancing_order`(`rebalancing_order_id`);
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ADD CONSTRAINT `fk_wealth_nav_calculation_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ADD CONSTRAINT `fk_wealth_rebalancing_order_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_composite_id` FOREIGN KEY (`composite_id`) REFERENCES `banking_ecm`.`wealth`.`composite`(`composite_id`);
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ADD CONSTRAINT `fk_wealth_performance_return_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_investment_policy_statement_id` FOREIGN KEY (`investment_policy_statement_id`) REFERENCES `banking_ecm`.`wealth`.`investment_policy_statement`(`investment_policy_statement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ADD CONSTRAINT `fk_wealth_client_mandate_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ADD CONSTRAINT `fk_wealth_suitability_assessment_superseded_by_assessment_suitability_assessment_id` FOREIGN KEY (`superseded_by_assessment_suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ADD CONSTRAINT `fk_wealth_model_portfolio_investment_committee_id` FOREIGN KEY (`investment_committee_id`) REFERENCES `banking_ecm`.`wealth`.`investment_committee`(`investment_committee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ADD CONSTRAINT `fk_wealth_wealth_fee_schedule_client_mandate_id` FOREIGN KEY (`client_mandate_id`) REFERENCES `banking_ecm`.`wealth`.`client_mandate`(`client_mandate_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ADD CONSTRAINT `fk_wealth_fee_billing_wealth_fee_schedule_id` FOREIGN KEY (`wealth_fee_schedule_id`) REFERENCES `banking_ecm`.`wealth`.`wealth_fee_schedule`(`wealth_fee_schedule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_omnibus_parent_account_id` FOREIGN KEY (`omnibus_parent_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_prime_broker_agreement_id` FOREIGN KEY (`prime_broker_agreement_id`) REFERENCES `banking_ecm`.`wealth`.`prime_broker_agreement`(`prime_broker_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ADD CONSTRAINT `fk_wealth_custodian_account_wealth_fee_schedule_id` FOREIGN KEY (`wealth_fee_schedule_id`) REFERENCES `banking_ecm`.`wealth`.`wealth_fee_schedule`(`wealth_fee_schedule_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ADD CONSTRAINT `fk_wealth_portfolio_corporate_action_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ADD CONSTRAINT `fk_wealth_investment_proposal_suitability_assessment_id` FOREIGN KEY (`suitability_assessment_id`) REFERENCES `banking_ecm`.`wealth`.`suitability_assessment`(`suitability_assessment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`composite` ADD CONSTRAINT `fk_wealth_composite_model_portfolio_id` FOREIGN KEY (`model_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`model_portfolio`(`model_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_portfolio_transaction_id` FOREIGN KEY (`portfolio_transaction_id`) REFERENCES `banking_ecm`.`wealth`.`portfolio_transaction`(`portfolio_transaction_id`);
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ADD CONSTRAINT `fk_wealth_tax_lot_wash_sale_reference_lot_id` FOREIGN KEY (`wash_sale_reference_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ADD CONSTRAINT `fk_wealth_trust_account_parent_trust_account_id` FOREIGN KEY (`parent_trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_trust_account_id` FOREIGN KEY (`trust_account_id`) REFERENCES `banking_ecm`.`wealth`.`trust_account`(`trust_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ADD CONSTRAINT `fk_wealth_estate_plan_previous_estate_plan_id` FOREIGN KEY (`previous_estate_plan_id`) REFERENCES `banking_ecm`.`wealth`.`estate_plan`(`estate_plan_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_custodian_account_id` FOREIGN KEY (`custodian_account_id`) REFERENCES `banking_ecm`.`wealth`.`custodian_account`(`custodian_account_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ADD CONSTRAINT `fk_wealth_alternative_investment_previous_alternative_investment_id` FOREIGN KEY (`previous_alternative_investment_id`) REFERENCES `banking_ecm`.`wealth`.`alternative_investment`(`alternative_investment_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ADD CONSTRAINT `fk_wealth_wealth_holding_wealth_portfolio_holding_id` FOREIGN KEY (`wealth_portfolio_holding_id`) REFERENCES `banking_ecm`.`wealth`.`wealth_portfolio_holding`(`wealth_portfolio_holding_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ADD CONSTRAINT `fk_wealth_wealth_holding_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ADD CONSTRAINT `fk_wealth_wealth_holding_tax_lot_id` FOREIGN KEY (`tax_lot_id`) REFERENCES `banking_ecm`.`wealth`.`tax_lot`(`tax_lot_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ADD CONSTRAINT `fk_wealth_portfolio_pledge_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ADD CONSTRAINT `fk_wealth_holding_pledge_wealth_portfolio_holding_id` FOREIGN KEY (`wealth_portfolio_holding_id`) REFERENCES `banking_ecm`.`wealth`.`wealth_portfolio_holding`(`wealth_portfolio_holding_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ADD CONSTRAINT `fk_wealth_portfolio_servicing_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ADD CONSTRAINT `fk_wealth_portfolio_broker_relationship_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ADD CONSTRAINT `fk_wealth_portfolio_assignment_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ADD CONSTRAINT `fk_wealth_portfolio_stress_application_managed_portfolio_id` FOREIGN KEY (`managed_portfolio_id`) REFERENCES `banking_ecm`.`wealth`.`managed_portfolio`(`managed_portfolio_id`);
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ADD CONSTRAINT `fk_wealth_prime_broker_agreement_previous_prime_broker_agreement_id` FOREIGN KEY (`previous_prime_broker_agreement_id`) REFERENCES `banking_ecm`.`wealth`.`prime_broker_agreement`(`prime_broker_agreement_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ADD CONSTRAINT `fk_wealth_investment_committee_escalation_committee_id` FOREIGN KEY (`escalation_committee_id`) REFERENCES `banking_ecm`.`wealth`.`investment_committee`(`investment_committee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ADD CONSTRAINT `fk_wealth_investment_committee_reporting_line_committee_id` FOREIGN KEY (`reporting_line_committee_id`) REFERENCES `banking_ecm`.`wealth`.`investment_committee`(`investment_committee_id`);
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ADD CONSTRAINT `fk_wealth_investment_committee_parent_investment_committee_id` FOREIGN KEY (`parent_investment_committee_id`) REFERENCES `banking_ecm`.`wealth`.`investment_committee`(`investment_committee_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`wealth` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`wealth` SET TAGS ('dbx_domain' = 'wealth');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `liquidity_metric_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Metric Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Status Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Treasury Investment Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Activation Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `aum_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Amount');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `aum_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `derivatives_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Derivatives Allowed Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `esg_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental, Social, and Governance (ESG) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `high_water_mark` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Inception Date');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_horizon` SET TAGS ('dbx_business_glossary_term' = 'Investment Horizon');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_horizon` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term|perpetual');
ALTER TABLE `banking_ecm`.`wealth`.`managed_portfolio` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Identifier');
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
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Tolerance Code List Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `suitability_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `suitability_status` SET TAGS ('dbx_business_glossary_term' = 'Suitability Status');
ALTER TABLE `banking_ecm`.`wealth`.`investment_policy_statement` ALTER COLUMN `suitability_status` SET TAGS ('dbx_value_regex' = 'suitable|review_required|unsuitable');
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
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement (IPS) Reference ID');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`asset_allocation` ALTER COLUMN `parent_allocation_asset_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Allocation ID');
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
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `wealth_portfolio_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Holding Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `investment_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Treasury Investment Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `as_of_date` SET TAGS ('dbx_business_glossary_term' = 'As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `base_currency_market_value` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `cost_basis_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Method');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `cost_basis_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|specific_identification|average_cost|highest_cost|lowest_cost');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Classification');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `holding_period_classification` SET TAGS ('dbx_value_regex' = 'short_term|long_term');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `income_type` SET TAGS ('dbx_business_glossary_term' = 'Income Type Classification');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `income_type` SET TAGS ('dbx_value_regex' = 'qualified_dividend|ordinary_dividend|interest|capital_gain|tax_exempt|return_of_capital');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `investment_objective` SET TAGS ('dbx_value_regex' = 'growth|income|balanced|capital_preservation|aggressive_growth|speculation');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `lot_acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Acquisition Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `lot_acquisition_price` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Acquisition Price');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `lot_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Status');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'open|closed|partially_closed|transferred|corporate_action');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `market_price` SET TAGS ('dbx_business_glossary_term' = 'Market Price (Mark-to-Market)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `pledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Pledged Collateral Flag');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `portfolio_weight` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Weight Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Holding Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Security Flag');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|very_high');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `total_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `unit_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `unrealized_gain_loss_percent` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_portfolio_holding` ALTER COLUMN `wash_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Wash Sale Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `portfolio_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Transaction ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `aml_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Alert Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `rebalancing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Event ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Deposit Account Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price');
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
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed|reversed');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_transaction` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `nav_calculation_id` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Calculated By User ID');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `accrued_expenses` SET TAGS ('dbx_business_glossary_term' = 'Accrued Expenses');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'forward_pricing|backward_pricing|swing_pricing|dual_pricing');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`nav_calculation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `rebalancing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Order Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `tertiary_rebalancing_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `tertiary_rebalancing_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `tertiary_rebalancing_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Deal Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `portfolio_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Base Currency');
ALTER TABLE `banking_ecm`.`wealth`.`rebalancing_order` ALTER COLUMN `portfolio_base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `performance_return_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Return ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `composite_id` SET TAGS ('dbx_business_glossary_term' = 'Composite ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
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
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `downside_deviation` SET TAGS ('dbx_business_glossary_term' = 'Downside Deviation');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `ending_market_value` SET TAGS ('dbx_business_glossary_term' = 'Ending Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `gips_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Investment Performance Standards (GIPS) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `income_earned` SET TAGS ('dbx_business_glossary_term' = 'Income Earned');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `information_ratio` SET TAGS ('dbx_business_glossary_term' = 'Information Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `management_fees` SET TAGS ('dbx_business_glossary_term' = 'Management Fees');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `maximum_drawdown` SET TAGS ('dbx_business_glossary_term' = 'Maximum Drawdown');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `mwr_return` SET TAGS ('dbx_business_glossary_term' = 'Money-Weighted Return (MWR) / Internal Rate of Return (IRR)');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `net_cash_flow` SET TAGS ('dbx_business_glossary_term' = 'Net Cash Flow');
ALTER TABLE `banking_ecm`.`wealth`.`performance_return` ALTER COLUMN `other_expenses` SET TAGS ('dbx_business_glossary_term' = 'Other Expenses');
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
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `investment_policy_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy Statement Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `aum_at_inception` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) at Inception');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Name');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `authorized_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `authorized_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory Title');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`client_mandate` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
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
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager (RM) ID');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluated Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Taxonomy Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`suitability_assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `investment_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective Code List Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `active_client_count` SET TAGS ('dbx_business_glossary_term' = 'Active Client Count');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|suspended|retired');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`wealth`.`model_portfolio` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `wealth_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Wealth Fee Schedule ID');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `client_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Client Mandate ID');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fund_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Fee Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `accrual_status` SET TAGS ('dbx_value_regex' = 'not_accrued|accruing|accrued|reversed');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `aum_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Basis Amount');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `aum_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Calculation Method');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `aum_calculation_method` SET TAGS ('dbx_value_regex' = 'beginning_balance|ending_balance|average_daily|average_monthly');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|per_transaction|on_demand');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `billing_in_advance_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing In Advance Flag');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'aum_percentage|flat|tiered|performance_based|transaction_based|hybrid');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'management|performance|advisory|custody|transaction|administration');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Amount');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `gl_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Reference');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `gross_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `high_water_mark` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `invoice_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'portfolio_deduction|wire_transfer|ach|check|direct_debit');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `performance_hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Hurdle Rate');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `regulatory_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Flag');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `tax_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withholding Amount');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `tier_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Tier Lower Bound');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `tier_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Tier Upper Bound');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_fee_schedule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Version');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Billing ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `wealth_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Wealth Fee Schedule Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Discount Amount');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `fee_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Fee Waiver Reason');
ALTER TABLE `banking_ecm`.`wealth`.`fee_billing` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
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
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `omnibus_parent_account_id` SET TAGS ('dbx_business_glossary_term' = 'Omnibus Parent Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Custodian Institution Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `prime_broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Prime Broker Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `wealth_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Fee Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_opening_documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Documentation Complete Flag');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Status');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|frozen|restricted|closed|pending_opening');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Type');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'custody|settlement|cash|margin|omnibus|segregated');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `authorized_signatory_list` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatory List');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `authorized_signatory_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC) / SWIFT Code');
ALTER TABLE `banking_ecm`.`wealth`.`custodian_account` ALTER COLUMN `bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
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
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `portfolio_corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Corporate Action Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `new_security_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'New Security ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `action_ratio_denominator` SET TAGS ('dbx_business_glossary_term' = 'Action Ratio Denominator');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `action_ratio_numerator` SET TAGS ('dbx_business_glossary_term' = 'Action Ratio Numerator');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `cash_amount_per_share` SET TAGS ('dbx_business_glossary_term' = 'Cash Amount Per Share');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `corporate_action_number` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Number');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `corporate_action_type` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `custodian_reference` SET TAGS ('dbx_business_glossary_term' = 'Custodian Reference');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `election_deadline` SET TAGS ('dbx_business_glossary_term' = 'Election Deadline');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `election_option` SET TAGS ('dbx_business_glossary_term' = 'Election Option');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `election_option` SET TAGS ('dbx_value_regex' = 'cash|stock|cash_and_stock|no_election');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `election_type` SET TAGS ('dbx_business_glossary_term' = 'Election Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `election_type` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|mandatory_with_options');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `entitled_cash_amount` SET TAGS ('dbx_business_glossary_term' = 'Entitled Cash Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `entitled_shares` SET TAGS ('dbx_business_glossary_term' = 'Entitled Shares');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `ex_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_business_glossary_term' = 'Fractional Share Treatment');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_value_regex' = 'cash_in_lieu|round_down|round_up|carry_forward');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `holding_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Holding Impact Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `holding_impact_type` SET TAGS ('dbx_value_regex' = 'quantity_change|security_substitution|cash_receipt|no_impact');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `mandatory_voluntary_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Voluntary Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `nav_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Impact Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processed Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `rebalancing_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Trigger Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `shares_held_at_record` SET TAGS ('dbx_business_glossary_term' = 'Shares Held at Record Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `source_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Message ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_corporate_action` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `investment_proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Proposal Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Presentation Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `suitability_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `alternative_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Alternative Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `base_case_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Case Return Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `cash_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Cash Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `equity_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Equity Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `esg_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `fee_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure Description');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `fee_structure_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `fixed_income_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Fixed Income Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `management_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `management_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `max_drawdown_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Drawdown Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `optimistic_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Optimistic Return Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `other_allocation_pct` SET TAGS ('dbx_business_glossary_term' = 'Other Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `performance_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `performance_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `pessimistic_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Pessimistic Return Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Presentation Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposal_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposal_name` SET TAGS ('dbx_business_glossary_term' = 'Proposal Name');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposal_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Number');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'new_mandate|portfolio_restructuring|asset_allocation_change|strategy_change|rebalancing|other');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposed_aum_amount` SET TAGS ('dbx_business_glossary_term' = 'Proposed Assets Under Management (AUM) Amount');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposed_aum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `proposed_strategy` SET TAGS ('dbx_business_glossary_term' = 'Proposed Investment Strategy');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'conservative|moderate|balanced|growth|aggressive');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `shariah_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Shariah Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `sharpe_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sharpe Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `target_annual_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Annual Return Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `time_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Time Horizon (Years)');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `var_95_pct` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) 95 Percent');
ALTER TABLE `banking_ecm`.`wealth`.`investment_proposal` ALTER COLUMN `volatility_pct` SET TAGS ('dbx_business_glossary_term' = 'Volatility Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`composite` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`composite` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_id` SET TAGS ('dbx_business_glossary_term' = 'Composite Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Composite Manager Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `model_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Model Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `aum` SET TAGS ('dbx_business_glossary_term' = 'Composite Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `aum_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'AUM (Assets Under Management) As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_code` SET TAGS ('dbx_business_glossary_term' = 'Composite Code');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_name` SET TAGS ('dbx_business_glossary_term' = 'Composite Name');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_status` SET TAGS ('dbx_business_glossary_term' = 'Composite Status');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_type` SET TAGS ('dbx_business_glossary_term' = 'Composite Type');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `composite_type` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|balanced|alternative|real_estate|multi_asset');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `dispersion_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Dispersion Calculation Method');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `dispersion_calculation_method` SET TAGS ('dbx_value_regex' = 'standard_deviation|range|interquartile_range');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Exclusion Criteria');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gips_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'GIPS (Global Investment Performance Standards) Compliant Flag');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gips_verification_status` SET TAGS ('dbx_business_glossary_term' = 'GIPS (Global Investment Performance Standards) Verification Status');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gips_verification_status` SET TAGS ('dbx_value_regex' = 'verified|not_verified|verification_in_progress');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gross_composite_return_1yr` SET TAGS ('dbx_business_glossary_term' = 'Gross Composite Return One Year');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gross_composite_return_3yr` SET TAGS ('dbx_business_glossary_term' = 'Gross Composite Return Three Year Annualized');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gross_composite_return_5yr` SET TAGS ('dbx_business_glossary_term' = 'Gross Composite Return Five Year Annualized');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gross_composite_return_since_inception` SET TAGS ('dbx_business_glossary_term' = 'Gross Composite Return Since Inception Annualized');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `gross_composite_return_ytd` SET TAGS ('dbx_business_glossary_term' = 'Gross Composite Return Year-to-Date (YTD)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Composite Inception Date');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Inclusion Criteria');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `internal_dispersion` SET TAGS ('dbx_business_glossary_term' = 'Internal Dispersion Measure');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `minimum_portfolio_size` SET TAGS ('dbx_business_glossary_term' = 'Minimum Portfolio Size for Inclusion');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `net_composite_return_1yr` SET TAGS ('dbx_business_glossary_term' = 'Net Composite Return One Year');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `net_composite_return_3yr` SET TAGS ('dbx_business_glossary_term' = 'Net Composite Return Three Year Annualized');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `net_composite_return_5yr` SET TAGS ('dbx_business_glossary_term' = 'Net Composite Return Five Year Annualized');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `net_composite_return_since_inception` SET TAGS ('dbx_business_glossary_term' = 'Net Composite Return Since Inception Annualized');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `net_composite_return_ytd` SET TAGS ('dbx_business_glossary_term' = 'Net Composite Return Year-to-Date (YTD)');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `number_of_portfolios` SET TAGS ('dbx_business_glossary_term' = 'Number of Constituent Portfolios');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `significant_cash_flow_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Significant Cash Flow Threshold Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy Description');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Composite Termination Date');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `three_year_annualized_ex_post_standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Three Year Annualized Ex-Post Standard Deviation');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Valuation Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'GIPS (Global Investment Performance Standards) Verification Date');
ALTER TABLE `banking_ecm`.`wealth`.`composite` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'GIPS (Global Investment Performance Standards) Verifier Name');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` SET TAGS ('dbx_subdomain' = 'investment_operations');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `portfolio_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`tax_lot` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Servicing Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `parent_trust_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `aum_amount` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Amount');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `aum_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `aum_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Grantor Tax Identification Number (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `grantor_tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`trust_account` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
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
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` SET TAGS ('dbx_subdomain' = 'client_advisory');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `estate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Estate Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Estate Planner Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trust_account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `previous_estate_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `alternate_executor_name` SET TAGS ('dbx_business_glossary_term' = 'Alternate Executor Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `alternate_executor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `business_succession_flag` SET TAGS ('dbx_business_glossary_term' = 'Business Succession Flag');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `charitable_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Charitable Beneficiary Count');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `charitable_giving_flag` SET TAGS ('dbx_business_glossary_term' = 'Charitable Giving Flag');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `contingent_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Contingent Beneficiary Count');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `estate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Estate Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `estate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `estimated_estate_tax_liability` SET TAGS ('dbx_business_glossary_term' = 'Estimated Estate Tax Liability');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `estimated_estate_tax_liability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `executor_name` SET TAGS ('dbx_business_glossary_term' = 'Executor Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `executor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Guardian Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `guardian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `guardianship_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Guardianship Designation Flag');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `healthcare_proxy_name` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Proxy Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `healthcare_proxy_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `living_will_flag` SET TAGS ('dbx_business_glossary_term' = 'Living Will Flag');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Estate Plan Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Estate Plan Number');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Estate Plan Status');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Estate Plan Type');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'comprehensive|basic|trust_based|will_based|charitable|business_succession');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `power_of_attorney_holder` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney Holder');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `power_of_attorney_holder` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `power_of_attorney_type` SET TAGS ('dbx_business_glossary_term' = 'Power of Attorney (POA) Type');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `power_of_attorney_type` SET TAGS ('dbx_value_regex' = 'durable|general|limited|springing|healthcare|none');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `primary_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Count');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `primary_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Primary Jurisdiction');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `primary_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|event_driven|as_needed');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `secondary_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Secondary Jurisdiction');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `secondary_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `tax_minimization_strategy` SET TAGS ('dbx_business_glossary_term' = 'Tax Minimization Strategy');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `tax_minimization_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `total_estate_value` SET TAGS ('dbx_business_glossary_term' = 'Total Estate Value');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `total_estate_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trust_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Trust Document Reference');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trust_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trust_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Trust Structure Type');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trust_structure_type` SET TAGS ('dbx_value_regex' = 'revocable_living_trust|irrevocable_trust|charitable_trust|special_needs_trust|generation_skipping_trust|none');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `trustee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `will_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Will Document Reference');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `will_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`estate_plan` ALTER COLUMN `will_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Will Execution Date');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `alternative_investment_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Investment Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `previous_alternative_investment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `carried_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Rate');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `commitment_currency` SET TAGS ('dbx_business_glossary_term' = 'Commitment Currency Code');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `commitment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Date');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `distributions_received` SET TAGS ('dbx_business_glossary_term' = 'Distributions Received');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `dpi_multiple` SET TAGS ('dbx_business_glossary_term' = 'Distributions to Paid-In (DPI) Multiple');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `expected_liquidation_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Liquidation Date');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fair_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Amount');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fund_manager_identifier` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fund_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Name');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fund_term_years` SET TAGS ('dbx_business_glossary_term' = 'Fund Term in Years');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `fund_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Fund Vintage Year');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `funded_amount` SET TAGS ('dbx_business_glossary_term' = 'Funded Amount');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Rate');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Inception Date');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_name` SET TAGS ('dbx_business_glossary_term' = 'Alternative Investment Name');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Investment Number');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investment Period End Date');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_status` SET TAGS ('dbx_business_glossary_term' = 'Investment Status');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_status` SET TAGS ('dbx_value_regex' = 'committed|funding|active|harvesting|liquidated|written_off');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Investment Type');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `investment_type` SET TAGS ('dbx_value_regex' = 'private_equity|venture_capital|hedge_fund|real_estate|infrastructure|commodities');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `irr_percent` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'illiquid|semi_liquid|liquid');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `moic_multiple` SET TAGS ('dbx_business_glossary_term' = 'Multiple on Invested Capital (MOIC)');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `nav_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Amount');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `nav_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) As-Of Date');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `nav_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Reporting Frequency');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `nav_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `rvpi_multiple` SET TAGS ('dbx_business_glossary_term' = 'Residual Value to Paid-In (RVPI) Multiple');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `side_letter_flag` SET TAGS ('dbx_business_glossary_term' = 'Side Letter Flag');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `tvpi_multiple` SET TAGS ('dbx_business_glossary_term' = 'Total Value to Paid-In (TVPI) Multiple');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `unfunded_commitment` SET TAGS ('dbx_business_glossary_term' = 'Unfunded Commitment');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`alternative_investment` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` SET TAGS ('dbx_association_edges' = 'wealth.managed_portfolio,security.instrument');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `wealth_holding_id` SET TAGS ('dbx_business_glossary_term' = 'wealth_holding Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `wealth_portfolio_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Holding - Instrument Id');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Holding - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `tax_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Position Market Value');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `period_classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Classification');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `portfolio_weight` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Weight Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Position Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `unit_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost Basis');
ALTER TABLE `banking_ecm`.`wealth`.`wealth_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` SET TAGS ('dbx_association_edges' = 'wealth.managed_portfolio,collateral.pledge');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `portfolio_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Pledge Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Pledge - Pledge Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Pledge - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `assignment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `assignment_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Maturity Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Creation Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `eligible_collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Portfolio Collateral Value');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Portfolio-Specific Haircut');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Portfolio Valuation Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Loan-to-Value Ratio');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `margin_call_threshold` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Margin Call Threshold');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `pledge_amount` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Pledge Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Assignment Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Pledge Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `portfolio_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Release Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Substitution Right');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_pledge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Update Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` SET TAGS ('dbx_association_edges' = 'wealth.portfolio_holding,collateral.pledge');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `holding_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Pledge Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `collateral_pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Pledge - Pledge Id');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `wealth_portfolio_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Pledge - Portfolio Holding Id');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `eligible_value` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Value');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Security-Specific Haircut');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Assignment Date');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Pledge Status');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `pledged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pledged Quantity');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Holding Release Date');
ALTER TABLE `banking_ecm`.`wealth`.`holding_pledge` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Indicator');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` SET TAGS ('dbx_association_edges' = 'wealth.managed_portfolio,channel.branch');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `portfolio_servicing_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Servicing Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Servicing - Branch Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Servicing - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Employee');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `portfolio_servicing_status` SET TAGS ('dbx_business_glossary_term' = 'Servicing Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Tier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `servicing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Servicing End Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `servicing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Servicing Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `servicing_type` SET TAGS ('dbx_business_glossary_term' = 'Servicing Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_servicing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` SET TAGS ('dbx_association_edges' = 'wealth.managed_portfolio,trade.broker');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `portfolio_broker_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Broker Relationship ID');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Broker Relationship - Broker Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Broker Relationship - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Commission Rate');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `last_trade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Trade Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `portfolio_broker_relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `preferred_asset_classes` SET TAGS ('dbx_business_glossary_term' = 'Preferred Asset Classes');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Relationship Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Termination Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `ytd_commission_paid` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date Commission Paid');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_broker_relationship` ALTER COLUMN `ytd_trade_volume` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date Trade Volume');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` SET TAGS ('dbx_association_edges' = 'wealth.managed_portfolio,hr.employee');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `portfolio_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Assignment Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Assignment - Employee Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Assignment - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Allocation Percentage');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role Type');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` SET TAGS ('dbx_subdomain' = 'portfolio_management');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` SET TAGS ('dbx_association_edges' = 'wealth.managed_portfolio,risk.stress_scenario');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `portfolio_stress_application_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Stress Application Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Stress Application - Managed Portfolio Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Run Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Stress Application - Stress Scenario Id');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `capital_impact` SET TAGS ('dbx_business_glossary_term' = 'Capital Impact Amount');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `portfolio_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Portfolio In Scope Flag');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `scenario_application_date` SET TAGS ('dbx_business_glossary_term' = 'Scenario Application Date');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `stressed_portfolio_value` SET TAGS ('dbx_business_glossary_term' = 'Stressed Portfolio Value');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `stressed_return` SET TAGS ('dbx_business_glossary_term' = 'Stressed Portfolio Return');
ALTER TABLE `banking_ecm`.`wealth`.`portfolio_stress_application` ALTER COLUMN `submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `prime_broker_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Prime Broker Agreement Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `previous_prime_broker_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `financing_rate_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `financing_spread_bps` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `margin_call_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `margin_requirement_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `rehypothecation_limit_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`prime_broker_agreement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ALTER COLUMN `investment_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Identifier');
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ALTER COLUMN `parent_investment_committee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`wealth`.`investment_committee` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_confidential' = 'true');
