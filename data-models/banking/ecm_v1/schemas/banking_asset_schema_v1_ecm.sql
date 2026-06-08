-- Schema for Domain: asset | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`asset` COMMENT 'Fund and asset management covering mutual funds, ETFs, hedge funds, pension funds, fund accounting, NAV calculation, fund distribution, investor servicing, transfer agency, and fund regulatory reporting. Manages the full fund lifecycle from launch through liquidation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique identifier for the investment fund. Primary key for the fund entity.',
    `party_id` BIGINT COMMENT 'Unique identifier for the external auditor responsible for auditing the funds financial statements.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fund base currency is fundamental to NAV calculation, performance reporting, and investor statements. Every fund must have a base currency for accounting consolidation and regulatory reporting (UCITS,',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Fund domicile determines regulatory framework (Luxembourg UCITS, Irish QIF, Cayman SPC), tax treatment, and supervisory authority. Critical for compliance, licensing, and legal structure.',
    `fund_party_id` BIGINT COMMENT 'Unique identifier for the custodian bank responsible for safekeeping the funds assets.',
    `fund_transfer_agent_party_id` BIGINT COMMENT 'Unique identifier for the transfer agent responsible for maintaining shareholder records and processing subscriptions and redemptions.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Funds are established under specific legal entities for regulatory capital requirements, tax reporting, and consolidated financial statements. Essential for IFRS/GAAP consolidation and regulatory repo',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Funds undergo regulatory stress testing (CCAR for bank-owned funds, AIFMD Article 15 stress tests, UCITS stress testing guidelines). Links fund to applicable stress scenarios. Real process: fund-level',
    `umbrella_fund_id` BIGINT COMMENT 'Unique identifier for the parent umbrella fund structure if this fund is a sub-fund within a larger umbrella arrangement. Null if the fund is standalone.',
    `master_fund_id` BIGINT COMMENT 'Self-referencing FK on fund (master_fund_id)',
    `administrator_id` BIGINT COMMENT 'Unique identifier for the third-party administrator responsible for fund accounting, NAV calculation, and investor servicing.',
    `asset_class` STRING COMMENT 'The primary asset class in which the fund invests: equity, fixed income, money market, multi-asset, alternative investments, or real estate.. Valid values are `equity|fixed_income|money_market|multi_asset|alternative|real_estate`',
    `benchmark_index` STRING COMMENT 'The name of the market index or composite benchmark against which the funds performance is measured.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund record was first created in the system.',
    `cusip` STRING COMMENT 'Nine-character alphanumeric code identifying North American securities.. Valid values are `^[0-9]{3}[0-9A-Z]{5}[0-9]$`',
    `dealing_frequency` STRING COMMENT 'The frequency at which investors can subscribe to or redeem shares from the fund: daily, weekly, monthly, or quarterly.. Valid values are `daily|weekly|monthly|quarterly`',
    `distribution_frequency` STRING COMMENT 'The frequency at which the fund distributes income or capital gains to investors: monthly, quarterly, semi-annually, annually, or none (for accumulating funds).. Valid values are `monthly|quarterly|semi_annual|annual|none`',
    `distribution_policy` STRING COMMENT 'The funds policy regarding income and capital gains: accumulating (reinvested), distributing (paid out to investors), or mixed.. Valid values are `accumulating|distributing|mixed`',
    `fiscal_year_end` STRING COMMENT 'The month and day (MM-DD format) marking the end of the funds fiscal year for accounting and regulatory reporting purposes.. Valid values are `^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$`',
    `fund_name` STRING COMMENT 'The full legal name of the investment fund as registered with regulatory authorities.',
    `fund_status` STRING COMMENT 'The current operational status of the fund: active (accepting subscriptions), soft-closed (limited new subscriptions), hard-closed (no new subscriptions), liquidating (winding down), terminated (closed), or suspended (temporarily halted).. Valid values are `active|soft_closed|hard_closed|liquidating|terminated|suspended`',
    `fund_type` STRING COMMENT 'The primary classification of the fund structure: mutual fund, exchange-traded fund (ETF), hedge fund, pension fund, UCITS (Undertakings for Collective Investment in Transferable Securities), or SICAV (Société dInvestissement à Capital Variable).. Valid values are `mutual_fund|etf|hedge_fund|pension_fund|ucits|sicav`',
    `inception_date` DATE COMMENT 'The date on which the fund was legally established and began operations.',
    `investment_objective` STRING COMMENT 'A detailed description of the funds investment goals, strategy, and target outcomes as disclosed in the prospectus.',
    `investment_strategy` STRING COMMENT 'The primary investment strategy employed by the fund: growth, value, income, balanced, index-tracking, quantitative, or alternative strategies. [ENUM-REF-CANDIDATE: growth|value|income|balanced|index|quantitative|alternative — 7 candidates stripped; promote to reference product]',
    `isin` STRING COMMENT 'The globally unique 12-character alphanumeric code identifying the fund as a security.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `launch_date` DATE COMMENT 'The date on which the fund was first made available for investor subscriptions.',
    `legal_structure` STRING COMMENT 'The legal structure of the fund: open-ended (continuous issuance/redemption), closed-ended (fixed shares), unit trust, investment trust, or limited partnership.. Valid values are `open_ended|closed_ended|unit_trust|investment_trust|limited_partnership`',
    `lei_code` STRING COMMENT 'The 20-character alphanumeric Legal Entity Identifier (LEI) uniquely identifying the fund as a legal entity for regulatory reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'The annual management fee charged by the fund manager, expressed as a decimal percentage of Assets Under Management (AUM). For example, 0.0075 represents 0.75%.',
    `minimum_investment` DECIMAL(18,2) COMMENT 'The minimum amount required for an initial investment in the fund, expressed in the base currency.',
    `minimum_subsequent_investment` DECIMAL(18,2) COMMENT 'The minimum amount required for subsequent investments after the initial subscription, expressed in the base currency.',
    `nav_frequency` STRING COMMENT 'The frequency at which the funds Net Asset Value (NAV) is calculated and published: daily, weekly, monthly, quarterly, or annually.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `performance_fee_rate` DECIMAL(18,2) COMMENT 'The performance or incentive fee charged based on fund returns exceeding a specified hurdle rate, expressed as a decimal percentage. For example, 0.2000 represents 20%.',
    `prospectus_date` DATE COMMENT 'The effective date of the current fund prospectus or offering document.',
    `redemption_notice_period_days` STRING COMMENT 'The number of days advance notice required by investors to redeem shares from the fund.',
    `regulatory_classification` STRING COMMENT 'The regulatory classification of the fund: UCITS (Undertakings for Collective Investment in Transferable Securities), AIF (Alternative Investment Fund), 40 Act (Investment Company Act of 1940), QIF (Qualifying Investor Fund), REIT (Real Estate Investment Trust), or private placement.. Valid values are `ucits|aif|40_act|qif|reit|private_placement`',
    `sedol` STRING COMMENT 'Seven-character alphanumeric code identifying securities traded in the United Kingdom and Ireland.. Valid values are `^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$`',
    `settlement_period_days` STRING COMMENT 'The number of days after a subscription or redemption transaction date (T) by which settlement must occur (e.g., T+3).',
    `short_name` STRING COMMENT 'Abbreviated or marketing name of the fund used for display and reporting purposes.',
    `target_aum` DECIMAL(18,2) COMMENT 'The target or maximum Assets Under Management (AUM) amount the fund aims to reach or maintain, expressed in the base currency.',
    `termination_date` DATE COMMENT 'The date on which the fund was or will be terminated and liquidated. Null for active funds.',
    `total_expense_ratio` DECIMAL(18,2) COMMENT 'The total annual operating expenses of the fund expressed as a percentage of average net assets, including management fees, administrative costs, and other operational expenses.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund record was last modified in the system.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Golden source master record for every investment fund managed, administered, or distributed by the bank. Captures fund type (mutual fund, ETF, hedge fund, pension fund, UCITS, SICAV, closed-end), legal structure, domicile jurisdiction, base currency, inception date, target AUM, investment objective, benchmark index, regulatory classification (UCITS, AIF, 40 Act), fund status (active, soft-closed, liquidating, terminated), fiscal year end, and fund manager assignment. Serves as the SSOT for fund identity across NAV calculation, distribution, and regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_class` (
    `fund_class_id` BIGINT COMMENT 'Unique identifier for the fund share class or unit class. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Share class currency denomination (USD, EUR, GBP hedged classes) drives pricing, FX hedging strategy, and investor suitability. Essential for multi-currency fund structures and currency overlay manage',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Share class domicile may differ from umbrella fund (e.g., Irish umbrella with Luxembourg share class). Determines tax treatment, withholding obligations, and regulatory reporting requirements.',
    `fund_id` BIGINT COMMENT 'Reference to the parent fund to which this share class belongs. A fund may have multiple classes with different fee structures and currencies targeting different investor segments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Share classes may be domiciled in different legal entities for tax optimization (e.g., offshore vs onshore classes). Required for entity-level financial reporting and tax provision calculations.',
    `base_fund_class_id` BIGINT COMMENT 'Self-referencing FK on fund_class (base_fund_class_id)',
    `benchmark_index` STRING COMMENT 'Name of the market index or composite benchmark against which the fund class performance is measured (e.g., S&P 500, MSCI World, Bloomberg Barclays Aggregate). Used for performance attribution and investor reporting.',
    `bloomberg_ticker` STRING COMMENT 'Bloomberg-assigned ticker symbol for the fund class. Used for market data retrieval, pricing, and analytics on Bloomberg Terminal.',
    `class_code` STRING COMMENT 'Short alphanumeric code identifying the share class within the fund (e.g., A, B, I, R, Institutional). Used for internal classification and operational processing.. Valid values are `^[A-Z0-9]{1,10}$`',
    `class_name` STRING COMMENT 'Full descriptive name of the share class (e.g., Institutional Class, Retail Class A, Hedged EUR Class). Human-readable identifier used in client reporting and marketing materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund class record was first created in the system. Used for audit trail and data lineage tracking.',
    `cusip` STRING COMMENT '9-character alphanumeric code identifying the fund class in North American markets. Used for trade settlement and regulatory reporting in the United States and Canada.. Valid values are `^[0-9]{3}[A-Z0-9]{5}[0-9]$`',
    `data_source_system` STRING COMMENT 'Name of the upstream operational system from which this fund class record originated (e.g., SimCorp Dimension, BlackRock Aladdin, proprietary fund accounting system). Used for data lineage and reconciliation.',
    `dealing_cutoff_time` TIMESTAMP COMMENT 'Time of day (HH:MM format) by which subscription and redemption orders must be received to be processed at the next available NAV. Orders received after this time are processed at the subsequent NAV.',
    `dealing_frequency` STRING COMMENT 'Frequency at which investors can subscribe to or redeem from the fund class. Must align with or be less frequent than NAV calculation frequency.. Valid values are `daily|weekly|monthly|quarterly`',
    `distribution_frequency` STRING COMMENT 'Frequency at which income distributions are paid to investors for distributing share classes. Accumulating classes have value none.. Valid values are `monthly|quarterly|semi_annual|annual|none`',
    `distribution_policy` STRING COMMENT 'Indicates whether the fund class distributes income to investors (distributing) or reinvests it (accumulating). Flexible classes may switch based on fund manager discretion.. Valid values are `accumulating|distributing|flexible`',
    `entry_load_rate` DECIMAL(18,2) COMMENT 'Front-end sales charge or entry fee applied when an investor subscribes to the fund class, expressed as a decimal percentage of the subscription amount. May be waived for institutional investors.',
    `exit_load_rate` DECIMAL(18,2) COMMENT 'Back-end sales charge or exit fee applied when an investor redeems shares from the fund class, expressed as a decimal percentage of the redemption amount. Often used to discourage short-term trading.',
    `fund_class_status` STRING COMMENT 'Current operational status of the fund class. Active classes accept subscriptions and redemptions; suspended classes are temporarily closed; closed classes no longer accept new investors; liquidated classes have been wound down.. Valid values are `active|suspended|closed|liquidated|pending_launch`',
    `hedged_flag` BOOLEAN COMMENT 'Indicates whether the fund class employs currency hedging to mitigate foreign exchange risk for investors. True if hedged, False if unhedged.',
    `inception_date` DATE COMMENT 'Date on which the fund class was launched and became available for investor subscriptions. Used to calculate performance track record and regulatory reporting periods.',
    `investor_eligibility` STRING COMMENT 'Classification of investor types eligible to invest in this share class. Determines minimum investment thresholds, fee structures, and regulatory treatment.. Valid values are `retail|institutional|professional|qualified|accredited`',
    `isin` STRING COMMENT '12-character alphanumeric code that uniquely identifies the fund class globally. Required for regulatory reporting and cross-border distribution.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `kiid_url` STRING COMMENT 'Web address (URL) where the Key Investor Information Document (KIID) or Key Information Document (KID) can be accessed. Mandatory pre-contractual disclosure document for UCITS and PRIIPs.',
    `lei_code` STRING COMMENT '20-character alphanumeric code that uniquely identifies the legal entity managing or issuing the fund class. Required for regulatory reporting under MiFID II and EMIR.. Valid values are `^[A-Z0-9]{20}$`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee charged by the fund manager, expressed as a decimal percentage of Assets Under Management (AUM). Accrued daily and deducted from NAV.',
    `minimum_initial_investment` DECIMAL(18,2) COMMENT 'Minimum amount required for an investor to make an initial subscription into the fund class, expressed in the class currency. Used to enforce eligibility and operational thresholds.',
    `minimum_subsequent_investment` DECIMAL(18,2) COMMENT 'Minimum amount required for additional subscriptions after the initial investment. May be lower than the initial minimum to encourage ongoing contributions.',
    `nav_frequency` STRING COMMENT 'Frequency at which the Net Asset Value (NAV) is calculated and published for the fund class. Daily is most common for liquid funds; less frequent for alternative or illiquid strategies.. Valid values are `daily|weekly|monthly|quarterly`',
    `ongoing_charges_figure` DECIMAL(18,2) COMMENT 'Annual charges taken from the fund class excluding transaction costs and performance fees, expressed as a decimal percentage of AUM. Required disclosure metric under UCITS regulations.',
    `performance_fee_rate` DECIMAL(18,2) COMMENT 'Performance-based fee charged when the fund class exceeds a specified benchmark or hurdle rate, expressed as a decimal percentage of outperformance. Common in hedge funds and alternative investment funds.',
    `prospectus_url` STRING COMMENT 'Web address (URL) where the current prospectus or offering document for the fund class can be accessed. Required for investor disclosure and regulatory compliance.',
    `regulatory_classification` STRING COMMENT 'Regulatory category under which the fund class is registered and supervised. Determines applicable rules for investor protection, disclosure, leverage, and distribution. [ENUM-REF-CANDIDATE: UCITS|AIF|ETF|mutual_fund|hedge_fund|private_equity|real_estate — 7 candidates stripped; promote to reference product]',
    `sedol` STRING COMMENT '7-character alphanumeric code used to identify the fund class in UK and Irish markets. Required for trading on London Stock Exchange and other European venues.. Valid values are `^[0-9A-Z]{7}$`',
    `settlement_period_days` STRING COMMENT 'Number of business days between trade date and settlement date for subscriptions and redemptions. Typically T+1 to T+3 for liquid funds, longer for alternative funds.',
    `sfdr_classification` STRING COMMENT 'Classification under EU SFDR indicating the fund class sustainability profile. Article 8 funds promote environmental or social characteristics; Article 9 funds have sustainable investment as their objective; Article 6 funds do not integrate sustainability.. Valid values are `article_6|article_8|article_9`',
    `tax_reporting_status` STRING COMMENT 'Classification of the fund class for tax reporting purposes. Reporting funds provide annual tax information to investors; non-reporting funds may have different tax treatment. Relevant for UK and other jurisdictions.. Valid values are `reporting|non_reporting|transparent|opaque`',
    `termination_date` DATE COMMENT 'Date on which the fund class was closed or liquidated. Null if the class is still active. Used for lifecycle management and historical reporting.',
    `total_expense_ratio` DECIMAL(18,2) COMMENT 'Aggregate of all annual operating expenses (management fees, administrative costs, custody fees) expressed as a decimal percentage of average Assets Under Management (AUM). Key metric for investor cost comparison.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund class record was last modified. Used for change tracking and audit purposes.',
    CONSTRAINT pk_fund_class PRIMARY KEY(`fund_class_id`)
) COMMENT 'Master record for each share class or unit class within a fund. Captures class code, class name, currency, distribution policy (accumulating vs distributing), minimum investment, management fee, performance fee, entry/exit load, ISIN, CUSIP, Bloomberg ticker, hedged/unhedged flag, investor eligibility (retail, institutional, professional), and class inception date. A fund may have multiple classes with different fee structures and currencies targeting different investor segments.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`nav_record` (
    `nav_record_id` BIGINT COMMENT 'Unique identifier for the NAV calculation record. Primary key for the nav_record product.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: NAV calculations must align with accounting period close for consolidated financial statements and regulatory reporting. Critical for period-end reconciliation between fund accounting and general ledg',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: NAV must be expressed in a specific currency for valuation, pricing, and investor reporting. Core requirement for fund accounting and transfer agency operations.',
    `employee_id` BIGINT COMMENT 'Reference to the authorized user who approved and finalized this NAV calculation.',
    `fund_administrator_id` BIGINT COMMENT 'Reference to the fund administrator entity responsible for NAV oversight and publication.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific share class or unit class within the fund for which this NAV applies.',
    `fund_id` BIGINT COMMENT 'Reference to the fund for which this NAV is calculated.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: NAV calculation occurs only on valid dealing days per fund calendar. Business day validation is critical for pricing accuracy, investor dealing, and regulatory compliance (UCITS dealing frequency rule',
    `party_id` BIGINT COMMENT 'Reference to the fund accountant or transfer agent responsible for calculating and certifying this NAV.',
    `previous_nav_record_id` BIGINT COMMENT 'Reference to the prior NAV record for this fund class, enabling time-series analysis and change tracking. Null for the first NAV record.',
    `accrued_expenses` DECIMAL(18,2) COMMENT 'Expenses incurred but not yet paid by the fund, including accrued management fees, performance fees, custody fees, audit fees, and other operating expenses as of the valuation date.',
    `accrued_income` DECIMAL(18,2) COMMENT 'Income earned but not yet received by the fund, including accrued interest, dividends declared but not paid, and other receivable income as of the valuation date.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this NAV calculation was formally approved by an authorized signatory.',
    `calculation_method` STRING COMMENT 'The valuation methodology used for calculating NAV. Amortized cost is used for money market funds; mark-to-market uses current market prices; fair value uses estimated values when market prices unavailable.. Valid values are `amortized_cost|mark_to_market|fair_value`',
    `distribution_per_unit` DECIMAL(18,2) COMMENT 'The amount of income or capital distribution declared per unit/share on this valuation date, if any. Zero if no distribution declared.',
    `ex_distribution_date` DATE COMMENT 'The date on which the fund begins trading without the value of its next distribution payment. Investors purchasing on or after this date are not entitled to the declared distribution.',
    `gross_asset_value` DECIMAL(18,2) COMMENT 'Total market value of all fund assets before deducting liabilities. Represents the sum of all portfolio holdings valued at market prices as of the valuation date.',
    `is_audited` BOOLEAN COMMENT 'Indicates whether this NAV calculation has been subject to external audit verification. True if audited, false otherwise.',
    `management_fee_accrual` DECIMAL(18,2) COMMENT 'Accrued management fee owed to the fund manager for the period up to and including the valuation date, calculated based on the management fee rate and fund assets.',
    `nav_calculation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the NAV calculation was completed and finalized.',
    `nav_change_amount` DECIMAL(18,2) COMMENT 'The absolute change in NAV per unit compared to the previous valuation date, expressed in currency units.',
    `nav_change_percentage` DECIMAL(18,2) COMMENT 'The percentage change in NAV per unit compared to the previous valuation date. Expressed as a percentage (e.g., 2.5000 represents 2.50%).',
    `nav_per_unit` DECIMAL(18,2) COMMENT 'The NAV divided by the number of units outstanding. This is the price at which investors buy and sell fund units. Also known as NAV per share for share-based funds.',
    `nav_publication_timestamp` TIMESTAMP COMMENT 'The date and time when the NAV was officially published and made available to investors and distribution channels.',
    `nav_status` STRING COMMENT 'Current lifecycle status of this NAV calculation. Preliminary indicates initial calculation pending review; final indicates approved and published; restated indicates correction of previously published NAV; suspended indicates NAV calculation halted.. Valid values are `preliminary|final|restated|suspended`',
    `net_asset_value` DECIMAL(18,2) COMMENT 'The net value of the fund calculated as gross asset value minus total liabilities. This is the authoritative NAV figure used for all investor transactions and regulatory reporting.',
    `performance_fee_accrual` DECIMAL(18,2) COMMENT 'Accrued performance fee or incentive fee owed to the fund manager based on fund performance relative to benchmark or high-water mark as of the valuation date.',
    `pricing_basis` STRING COMMENT 'The pricing methodology used for investor transactions. Forward pricing uses the next calculated NAV after order receipt; historic pricing uses the most recent NAV; swing pricing adjusts NAV for dilution.. Valid values are `forward|historic|swing`',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'The realized gain or loss from investment sales and maturities during the period ending on the valuation date.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this NAV record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this NAV record was last modified in the system.',
    `restatement_reason` STRING COMMENT 'Explanation for why this NAV was restated, if applicable. Null for original NAV calculations. Populated when nav_status is restated.',
    `total_expense_ratio` DECIMAL(18,2) COMMENT 'The annualized percentage of fund assets used to cover operating expenses, calculated as total expenses divided by average net assets. Expressed as a percentage (e.g., 1.5000 represents 1.50%).',
    `total_liabilities` DECIMAL(18,2) COMMENT 'Sum of all fund liabilities including accrued expenses, payables, borrowings, and other obligations as of the valuation date.',
    `total_redemptions` DECIMAL(18,2) COMMENT 'Total monetary value of investor redemptions (sales) processed and settled on this valuation date.',
    `total_subscriptions` DECIMAL(18,2) COMMENT 'Total monetary value of new investor subscriptions (purchases) processed and settled on this valuation date.',
    `units_outstanding` DECIMAL(18,2) COMMENT 'Total number of fund units or shares currently issued and held by investors as of the valuation date.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The cumulative unrealized gain or loss on fund investments as of the valuation date, calculated as the difference between current market value and original cost basis.',
    `valuation_date` DATE COMMENT 'The business date for which this NAV calculation was performed. This is the principal business event timestamp for the NAV record.',
    `valuation_frequency` STRING COMMENT 'The regular schedule on which NAV is calculated for this fund class (daily, weekly, monthly, quarterly, or annual).. Valid values are `daily|weekly|monthly|quarterly|annual`',
    CONSTRAINT pk_nav_record PRIMARY KEY(`nav_record_id`)
) COMMENT 'Authoritative Net Asset Value (NAV) calculation record for each fund class at each valuation date. Captures gross asset value, total liabilities, net asset value, NAV per unit/share, number of units outstanding, total subscriptions and redemptions processed, accrued income, accrued expenses, management fee accrual, performance fee accrual, valuation frequency (daily, weekly, monthly), pricing basis (forward/historic), and NAV publication timestamp. Serves as the SSOT for fund pricing used in investor transactions and regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_holding` (
    `fund_holding_id` BIGINT COMMENT 'Unique identifier for the fund holding record. Primary key for the fund holding entity.',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Holdings affected by corporate actions (dividends, splits, mergers) require direct linkage for entitlement calculation, position adjustment, and income accrual. Essential for accurate NAV and investor',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Fund holdings of debt instruments require counterparty credit ratings for risk monitoring and regulatory reporting (UCITS 5/10/40 rules, AIFMD risk management). Real process: credit risk assessment of',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Geographic risk exposure reporting for UCITS 5/10/40 rules, concentration limits, and country risk monitoring. Regulatory requirement for diversification compliance and risk management.',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Fund holdings of loans, bonds, and credit derivatives represent credit exposures requiring EAD, RWA, and ECL calculation for consolidated risk reporting. Real process: aggregating fund credit exposure',
    `derivative_id` BIGINT COMMENT 'Foreign key linking to security.derivative. Business justification: When holding is derivative, direct link enables margin calculation, counterparty exposure aggregation, regulatory reporting (EMIR, Dodd-Frank), and derivatives usage compliance (UCITS commitment appro',
    `employee_id` BIGINT COMMENT 'Identifier of the portfolio manager or investment team responsible for the decision to hold this position. Links to employee or team master data.',
    `equity_id` BIGINT COMMENT 'Foreign key linking to security.equity. Business justification: When holding is equity, direct link enables dividend entitlement calculation, corporate action processing (splits, rights issues), voting rights management, and equity-specific risk analytics (beta, m',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: FX rates for currency conversion in portfolio valuation. Links to official rates (ECB, Fed) for NAV calculation, audit trail, and fair value hierarchy compliance (IFRS 13).',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: Market risk positions in funds are decomposed into risk factors (equity indices, interest rate curves, FX rates) for VaR calculation, stress testing, and FRTB compliance. Real process: market risk fac',
    `fixed_income_id` BIGINT COMMENT 'Foreign key linking to security.fixed_income. Business justification: When holding is fixed income, direct link enables coupon accrual calculation, credit rating monitoring, duration/convexity analytics, and yield-to-maturity tracking. Essential for bond portfolio manag',
    `fund_id` BIGINT COMMENT 'Identifier of the fund that holds this position. Links to the fund master data.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Investment holdings map to specific GL accounts (e.g., equity securities, fixed income) for trial balance and financial statement preparation. Essential for subledger-to-GL reconciliation and SOX cont',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Fund holdings must reference the master security instrument for portfolio valuation, risk analytics, corporate action processing, and regulatory reporting (UCITS diversification, AIFMD transparency). ',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Holdings require issuer reference for concentration risk monitoring (UCITS 5/10/40 rules), credit risk aggregation, sector exposure analysis, and regulatory reporting. Critical for investment complian',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Issuer LEI for concentration limits (UCITS 5% single issuer rule), counterparty risk aggregation, and regulatory reporting (SFTR, EMIR). Critical for issuer-level risk management.',
    `listing_id` BIGINT COMMENT 'Foreign key linking to security.listing. Business justification: Holdings track specific exchange listings for liquidity classification (MiFID II liquid/illiquid), trading venue selection, best execution compliance, and swing pricing threshold determination.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Holdings priced in local currencies (JPY equity, EUR bond) require FX conversion to fund base currency. Fundamental to portfolio valuation and NAV calculation.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Holdings require specific price record reference for NAV calculation audit trail, pricing source verification, fair value hierarchy compliance (IFRS 13), and pricing challenge resolution.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Holdings identified by ISIN/CUSIP for position keeping, corporate actions, pricing, and regulatory reporting (SFTR, MiFID II). Core portfolio management requirement linking holdings to master security',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Sector exposure reporting (GICS, ICB) for risk analytics, concentration monitoring, and investment mandate compliance. Essential for sector allocation analysis and style drift detection.',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Holdings require credit rating reference for investment mandate compliance (investment-grade only), UCITS eligibility (rated debt), risk weighting, and credit risk reporting. Essential for fixed incom',
    `structured_product_id` BIGINT COMMENT 'Foreign key linking to security.structured_product. Business justification: When holding is structured product (CLO, MBS, ABS), direct link enables waterfall modeling, prepayment analysis, credit enhancement tracking, and regulatory capital calculation (CRR securitization fra',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Fixed income holdings require yield curve reference for mark-to-market valuation, duration calculation, scenario analysis, and interest rate risk reporting. Essential for bond portfolio analytics.',
    `previous_fund_holding_id` BIGINT COMMENT 'Self-referencing FK on fund_holding (previous_fund_holding_id)',
    `accrued_income` DECIMAL(18,2) COMMENT 'The amount of income (interest, dividends, or other distributions) that has been earned but not yet received on this holding as of the valuation date, expressed in base currency.',
    `acquisition_date` DATE COMMENT 'The date on which the fund first acquired this holding. Used for holding period analysis and tax reporting.',
    `asset_class` STRING COMMENT 'High-level classification of the asset type: equity, fixed income, cash and cash equivalents, derivatives, commodities, real estate, or alternative investments.. Valid values are `EQUITY|FIXED_INCOME|CASH|DERIVATIVES|COMMODITIES|REAL_ESTATE`',
    `base_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the fund base currency in which NAV is calculated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_basis` DECIMAL(18,2) COMMENT 'The original acquisition cost of the holding in the fund base currency. Used to calculate unrealized gain or loss. May be calculated using FIFO, LIFO, or average cost method.',
    `counterparty_lei` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier of the counterparty for derivative or collateralized transactions. Required for regulatory reporting under EMIR and Dodd-Frank.. Valid values are `^[A-Z0-9]{20}$`',
    `counterparty_name` STRING COMMENT 'The name of the counterparty for derivative instruments or securities lending transactions. Applicable to OTC derivatives, swaps, and collateralized positions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this holding record was first created in the system. Used for audit trail and data lineage.',
    `custodian_account_number` STRING COMMENT 'The account number or identifier at the custodian institution where this holding is held. Used for reconciliation and settlement.',
    `custodian_name` STRING COMMENT 'The name of the custodian bank or depository institution holding the physical or electronic custody of the asset on behalf of the fund.',
    `data_source_system` STRING COMMENT 'The name or identifier of the upstream source system from which this holding record was extracted (e.g., SimCorp Dimension, BlackRock Aladdin, internal portfolio management system).',
    `duration_years` DECIMAL(18,2) COMMENT 'The modified duration or effective duration of the fixed income instrument, expressed in years. Measures the sensitivity of the instrument price to changes in interest rates. Applicable to bonds and other fixed income securities.',
    `fair_value_level` STRING COMMENT 'The IFRS 13 fair value hierarchy level used to determine the market price: Level 1 (quoted prices in active markets), Level 2 (observable inputs other than quoted prices), or Level 3 (unobservable inputs).. Valid values are `LEVEL_1|LEVEL_2|LEVEL_3`',
    `holding_status` STRING COMMENT 'The current lifecycle status of the holding. Indicates whether the position is active, pending settlement, restricted from trading, pledged as collateral, or liquidated.. Valid values are `ACTIVE|PENDING_SETTLEMENT|RESTRICTED|PLEDGED|LIQUIDATED`',
    `investment_strategy` STRING COMMENT 'The investment strategy or mandate under which this holding was acquired (e.g., Growth, Value, Income, Hedging, Tactical Allocation). Used for performance attribution and strategy analysis.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this holding record was last updated in the system. Used for data lineage, audit trail, and change tracking.',
    `liquidity_classification` STRING COMMENT 'Classification of the holding based on its liquidity profile and the ease with which it can be converted to cash without significant price impact. Used for liquidity risk management and regulatory reporting under UCITS and AIFMD.. Valid values are `HIGHLY_LIQUID|MODERATELY_LIQUID|LESS_LIQUID|ILLIQUID`',
    `market_value_base` DECIMAL(18,2) COMMENT 'The total market value of the holding converted to the fund base currency using the FX rate at the valuation date. This is the value used in NAV calculation.',
    `market_value_local` DECIMAL(18,2) COMMENT 'The total market value of the holding in the local currency of the instrument, calculated as quantity held multiplied by market price.',
    `maturity_date` DATE COMMENT 'The date on which the principal amount of a fixed income instrument is due to be repaid. Applicable to bonds, notes, and other debt securities. Null for perpetual instruments or equities.',
    `percentage_of_nav` DECIMAL(18,2) COMMENT 'The market value of this holding expressed as a percentage of the total fund NAV at the valuation date. Used for concentration risk analysis and regulatory reporting.',
    `pricing_source` STRING COMMENT 'The source or vendor from which the market price was obtained (e.g., Bloomberg, Reuters, IDC, internal valuation model). Used for audit trail and price verification.',
    `quantity_held` DECIMAL(18,2) COMMENT 'The number of units, shares, or nominal amount of the instrument held in the fund at the valuation date. For bonds, this may represent face value; for equities, share count.',
    `regulatory_classification` STRING COMMENT 'Classification of the holding for regulatory reporting purposes under UCITS, AIFMD, or other applicable frameworks. May include categories such as transferable securities, money market instruments, derivatives, or other assets.',
    `settlement_date` DATE COMMENT 'The date on which the most recent transaction affecting this holding was settled. Used for trade lifecycle tracking and reconciliation.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The difference between the current market value in base currency and the cost basis, representing the unrealized profit or loss on the holding. Positive values indicate gains, negative values indicate losses.',
    `valuation_date` DATE COMMENT 'The specific date on which this holding position and valuation are recorded. Critical for point-in-time portfolio snapshots and NAV calculation.',
    CONSTRAINT pk_fund_holding PRIMARY KEY(`fund_holding_id`)
) COMMENT 'Point-in-time portfolio holding record for each security or asset position held within a fund at a specific valuation date. Captures instrument identifier, asset class, quantity held, market price, market value in local and base currency, percentage of NAV, cost basis, unrealized gain/loss, accrued income, country of risk, sector classification, credit rating, duration (for fixed income), and liquidity classification. Drives NAV calculation, regulatory reporting (UCITS, AIFMD), and portfolio analytics.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_transaction` (
    `fund_transaction_id` BIGINT COMMENT 'Unique identifier for the fund transaction record. Primary key for the fund transaction entity.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Broker BIC for settlement instructions, SWIFT messaging, and trade confirmation matching. Critical for straight-through processing and payment routing.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or counterparty through which the transaction was executed. Links to broker master entity.',
    `corporate_action_id` BIGINT COMMENT 'Identifier linking this transaction to a corporate action event such as dividend, stock split, merger, or rights issue.',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Trade settlement FX rate for accounting entries and realized gain/loss calculation. Links to official rates for audit trail and fair value compliance.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund to which this transaction belongs. Links to the fund master entity.',
    `instrument_id` BIGINT COMMENT 'Identifier of the financial instrument involved in the transaction. Links to security master for equities, bonds, derivatives, etc.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Transaction-level issuer tracking enables real-time compliance monitoring for issuer concentration limits, pre-trade checks, and post-trade breach detection. Essential for automated investment restric',
    `listing_id` BIGINT COMMENT 'Foreign key linking to security.listing. Business justification: Transactions executed on specific exchanges require listing reference for transaction cost analysis (TCA), best execution reporting (MiFID II RTS 27/28), and venue selection audit trail.',
    `party_id` BIGINT COMMENT 'Identifier of the custodian bank holding the securities for this transaction. Links to custodian master entity.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the portfolio within the fund where this transaction occurred. Links to portfolio master entity.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Transactions reference specific price records for trade valuation verification, fair value compliance, best execution analysis, and audit trail. Links transaction to market data source and pricing met',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement occurs only on valid business days per market calendar (T+2, T+3). Critical for settlement date calculation, failed trade detection, and custodian reconciliation.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade execution currency for settlement, broker confirmation matching, and cash management. Essential for multi-currency trading and FX exposure tracking.',
    `reversal_fund_transaction_id` BIGINT COMMENT 'Self-referencing FK on fund_transaction (reversal_fund_transaction_id)',
    `accounting_date` DATE COMMENT 'Date on which the transaction is recorded in the fund accounting books. May differ from trade date for certain adjustments.',
    `accounting_treatment` STRING COMMENT 'Classification of how the transaction is treated in fund accounting books for financial reporting purposes.. Valid values are `realized_gain_loss|unrealized_gain_loss|income|expense|capital|adjustment`',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Accrued interest amount included in the transaction price for fixed income securities.',
    `base_currency` STRING COMMENT 'ISO 4217 three-letter currency code representing the funds base reporting currency.. Valid values are `^[A-Z]{3}$`',
    `base_currency_gross_amount` DECIMAL(18,2) COMMENT 'Gross transaction amount converted to the funds base currency using the FX rate.',
    `base_currency_net_amount` DECIMAL(18,2) COMMENT 'Net transaction amount converted to the funds base currency using the FX rate. Used for NAV calculation.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Brokerage commission or transaction fee charged for executing the trade.',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original cost basis of the position for realized gain/loss calculation. Applicable for sale transactions.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user or system process that created the transaction record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the fund accounting system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Additional fees associated with the transaction such as custody fees, settlement fees, or regulatory fees.',
    `general_ledger_account_code` STRING COMMENT 'General ledger account code to which this transaction is posted in the fund accounting subledger.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total transaction value before fees, commissions, and taxes. Calculated as quantity multiplied by unit price.',
    `instrument_cusip` STRING COMMENT 'CUSIP identifier for North American securities involved in the transaction.. Valid values are `^[0-9]{3}[0-9A-Z]{5}[0-9]$`',
    `instrument_isin` STRING COMMENT 'International Securities Identification Number uniquely identifying the financial instrument traded in this transaction.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `instrument_sedol` STRING COMMENT 'SEDOL identifier for securities traded on UK and Irish exchanges.. Valid values are `^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user or system process that last modified the transaction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was last modified or updated in the fund accounting system.',
    `nav_date` DATE COMMENT 'NAV calculation date to which this transaction contributes. Critical for daily NAV computation and investor pricing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net transaction value after deducting all commissions, fees, and taxes. This is the amount that impacts fund cash position.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or shares of the instrument involved in the transaction. Positive for purchases/receipts, negative for sales/payments.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Realized gain or loss on the transaction calculated as the difference between sale proceeds and cost basis.',
    `settlement_date` DATE COMMENT 'Date on which the transaction settles and cash or securities are exchanged. Determines when the transaction impacts fund cash position.',
    `settlement_method` STRING COMMENT 'Method used for settling the transaction: Delivery versus Payment (DVP), Receive versus Payment (RVP), Free of Payment (FOP), or Cash.. Valid values are `dvp|rvp|fop|cash`',
    `settlement_status` STRING COMMENT 'Status indicating whether cash and securities have been exchanged and the transaction has settled with the counterparty.. Valid values are `pending|settled|failed|partially_settled|cancelled`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount associated with the transaction, including withholding tax, stamp duty, or transaction tax.',
    `trade_confirmation_number` STRING COMMENT 'Confirmation number received from the broker or exchange confirming the trade execution.',
    `trade_date` DATE COMMENT 'Date on which the transaction was executed or the economic event occurred. Used for NAV calculation and performance attribution.',
    `transaction_notes` STRING COMMENT 'Free-text notes or comments providing additional context or explanation for the transaction.',
    `transaction_reference_number` STRING COMMENT 'External business reference number for the fund transaction, used for reconciliation and audit trail purposes.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the fund transaction indicating settlement and processing state.. Valid values are `pending|settled|cancelled|failed|reversed|suspended`',
    `transaction_type` STRING COMMENT 'Classification of the fund transaction indicating the nature of the accounting entry or portfolio activity. [ENUM-REF-CANDIDATE: purchase|sale|maturity|dividend_income|interest_income|expense_payment|corporate_action|fx_transaction|subscription|redemption|transfer_in|transfer_out|capital_call|distribution — 14 candidates stripped; promote to reference product]',
    CONSTRAINT pk_fund_transaction PRIMARY KEY(`fund_transaction_id`)
) COMMENT 'Transactional record of all fund-level accounting entries and portfolio transactions including security purchases, sales, maturities, corporate action receipts, dividend income, interest income, expense payments, and FX transactions. Captures transaction type, trade date, settlement date, instrument, quantity, price, gross amount, net amount, currency, FX rate, broker, settlement status, and accounting treatment. Feeds fund accounting subledger and NAV calculation.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`investor_account` (
    `investor_account_id` BIGINT COMMENT 'Unique identifier for the investor account in the transfer agency system. Primary key.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the relationship manager or financial advisor assigned to service this account. Applicable for institutional and high-net-worth accounts.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Investor accounts must link to customer.party for KYC/AML compliance, regulatory reporting (FATCA/CRS), beneficial ownership verification, and consolidated customer view across banking and asset manag',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Tax residency determines FATCA, CRS reporting obligations, withholding tax rates, and treaty benefits. Regulatory mandate for tax compliance and investor classification.',
    `linked_investor_account_id` BIGINT COMMENT 'Self-referencing FK on investor_account (linked_investor_account_id)',
    `account_closure_date` DATE COMMENT 'Date when the account was formally closed. Null for active accounts. Closed accounts retain historical data for regulatory retention periods.',
    `account_number` STRING COMMENT 'Externally visible account number assigned to the investor account. Used for client communications and statements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_opening_date` DATE COMMENT 'Date when the investor account was first opened and activated in the transfer agency system. Marks the start of the account lifecycle.',
    `account_status` STRING COMMENT 'Current lifecycle status of the investor account. Controls transaction permissions and servicing activities.. Valid values are `active|suspended|closed|pending_opening|dormant|restricted`',
    `aml_risk_rating` STRING COMMENT 'Risk classification assigned by AML screening and monitoring processes. Determines enhanced due diligence requirements and transaction monitoring thresholds.. Valid values are `low|medium|high|prohibited`',
    `beneficial_owner_count` STRING COMMENT 'Number of underlying beneficial owners represented by this account. Applicable for omnibus and nominee accounts. Null for direct retail accounts.',
    `closure_reason` STRING COMMENT 'Reason code for account closure. Used for operational analytics and regulatory reporting.. Valid values are `investor_request|zero_balance|regulatory|deceased|duplicate|fraud`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the investor account record was first created in the transfer agency database. Audit trail field.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the account is reportable under CRS automatic exchange of information requirements. True if reportable to foreign tax authorities.',
    `distribution_bank_account_number` STRING COMMENT 'Bank account number for cash distribution payments. Required when distribution preference is cash or partial reinvest.',
    `distribution_bank_account_type` STRING COMMENT 'Type of bank account designated for cash distributions. Determines ACH transaction code.. Valid values are `checking|savings`',
    `distribution_bank_routing_number` STRING COMMENT 'ABA routing number for the bank receiving cash distributions. Nine-digit code identifying the financial institution.. Valid values are `^[0-9]{9}$`',
    `distribution_preference` STRING COMMENT 'Investor election for handling fund distributions (dividends, capital gains). Reinvest purchases additional shares; cash pays to bank account.. Valid values are `reinvest|cash|partial_reinvest`',
    `dormancy_flag` BOOLEAN COMMENT 'Indicates whether the account has been classified as dormant due to prolonged inactivity. Triggers escheatment and outreach processes.',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the account is eligible for escheatment to state unclaimed property authorities. Based on dormancy period and jurisdiction rules.',
    `fatca_status` STRING COMMENT 'FATCA classification of the account holder. Determines US tax reporting requirements under FATCA regulations.. Valid values are `us_person|specified_us_person|non_us|exempt|recalcitrant|not_classified`',
    `investor_type` STRING COMMENT 'Classification of the investor account holder. Determines servicing model, fee structure, and regulatory treatment.. Valid values are `retail|institutional|nominee|trust|custodial|corporate`',
    `kyc_next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYC review. Typically based on risk rating and regulatory requirements.',
    `kyc_status` STRING COMMENT 'Current status of KYC verification and documentation. Must be verified before account activation and transactions.. Valid values are `verified|pending|expired|failed|refresh_required`',
    `kyc_verification_date` DATE COMMENT 'Date when KYC verification was last completed successfully. Used to determine refresh requirements per regulatory timelines.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction activity on the account. Used to identify dormant accounts and trigger escheatment reviews.',
    `mailing_address_line1` STRING COMMENT 'First line of the postal mailing address for account correspondence and statements.',
    `mailing_address_line2` STRING COMMENT 'Second line of the postal mailing address (apartment, suite, building number). Optional field.',
    `mailing_city` STRING COMMENT 'City or municipality component of the mailing address.',
    `mailing_country` STRING COMMENT 'Three-letter ISO country code for the mailing address. Determines postal routing and regulatory jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `mailing_postal_code` STRING COMMENT 'Postal or ZIP code component of the mailing address. Format varies by country.',
    `mailing_state_province` STRING COMMENT 'State, province, or region component of the mailing address. Format varies by country.',
    `omnibus_account_flag` BOOLEAN COMMENT 'Indicates whether this is an omnibus account holding positions on behalf of multiple underlying beneficial owners. True for intermediary and nominee accounts.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO currency code for account statements, distributions, and client communications. May differ from fund base currency.. Valid values are `^[A-Z]{3}$`',
    `registration_type` STRING COMMENT 'Legal structure of the account registration. Determines ownership rights, tax treatment, and beneficiary rules. [ENUM-REF-CANDIDATE: individual|joint_tenants|tenants_in_common|trust|corporate|partnership|ira|401k|ugma|utma — 10 candidates stripped; promote to reference product]',
    `restricted_trading_flag` BOOLEAN COMMENT 'Indicates whether trading restrictions are in place on this account. True if the account is subject to market timing controls, redemption fees, or regulatory holds.',
    `restricted_trading_reason` STRING COMMENT 'Explanation for trading restrictions. Examples include excessive trading pattern detection, regulatory hold, or pending investigation.',
    `statement_delivery_method` STRING COMMENT 'Investor preference for receiving account statements and confirmations. Electronic delivery reduces costs and environmental impact.. Valid values are `electronic|postal|both|suppressed`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the investor account record was last modified. Audit trail field for change tracking.',
    CONSTRAINT pk_investor_account PRIMARY KEY(`investor_account_id`)
) COMMENT 'Master record for each investor account registered in the funds transfer agency system. Captures investor type (retail, institutional, nominee), account status, registration details, tax residency, FATCA/CRS classification, AML status, distribution preference (reinvestment vs cash), bank account for distributions, preferred currency, account opening date, and relationship manager. Serves as the SSOT for investor identity within the fund administration and transfer agency function.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Unique identifier for the subscription transaction record. Primary key for the subscription entity.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Subscriptions are placed through specific banking channels (digital, branch, contact center). Essential for channel attribution, performance tracking, and commission calculation. Replaces denormalized',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Subscription payment currency for settlement, FX conversion, and unit allocation. Essential for multi-currency dealing and cash reconciliation.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific share class of the fund being subscribed to (e.g., Class A, Class I, Institutional). Different classes may have different fee structures and minimum investment requirements.',
    `fund_id` BIGINT COMMENT 'Reference to the fund being subscribed to. Links to the fund master record.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Subscriptions in kind (securities as payment) require instrument reference for valuation, settlement, and tax lot creation. Real business scenario for institutional share classes and seed capital.',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account placing the subscription order. Links to the investor account master record.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Subscriptions generate journal entries for cash receipt and unit issuance (debit cash, credit equity). Required for daily cash reconciliation, NAV calculation, and financial statement preparation.',
    `party_id` BIGINT COMMENT 'Reference to the financial intermediary, broker-dealer, or registered investment advisor (RIA) through whom the subscription was placed. Null if direct investor order.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Subscription settlement requires linking the fund investment order to the actual cash payment received. Transfer agents must reconcile subscription orders against payment receipts to allocate units. T',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Subscription settlement on valid business days per fund calendar. Critical for dealing deadline enforcement, NAV application, and transfer agency SLA compliance.',
    `reversal_subscription_id` BIGINT COMMENT 'Self-referencing FK on subscription (reversal_subscription_id)',
    `aml_clearance_date` DATE COMMENT 'Date when the subscription transaction received Anti-Money Laundering (AML) clearance and was approved to proceed.',
    `aml_clearance_status` STRING COMMENT 'Status of Anti-Money Laundering (AML) screening and clearance for this subscription transaction. Pending = screening in progress, Cleared = passed AML checks, Flagged = requires manual review, Rejected = failed AML checks and transaction blocked.. Valid values are `pending|cleared|flagged|rejected`',
    `commission_amount` DECIMAL(18,2) COMMENT 'Dollar amount of commission payable to the intermediary or advisor on this subscription. Calculated from commission_rate and gross_subscription_amount.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Percentage rate of commission payable to the intermediary or advisor on this subscription. Expressed as a decimal. May be zero for direct orders or fee-based accounts.',
    `confirmation_number` STRING COMMENT 'Unique confirmation number issued to the investor upon successful processing of the subscription. Used for investor communication and record-keeping.',
    `confirmation_sent_date` DATE COMMENT 'Date when the trade confirmation was sent to the investor. Required by SEC regulations to be sent promptly after settlement.',
    `cost_basis_per_unit` DECIMAL(18,2) COMMENT 'Tax cost basis per unit for this subscription lot. Calculated as net_investment_amount / units_allotted. Used for future capital gains/loss calculations upon redemption.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscription record was first created in the system. Part of audit trail for data lineage and compliance.',
    `dealing_nav` DECIMAL(18,2) COMMENT 'The Net Asset Value per unit/share applied to this subscription transaction. Determined based on the trade date and fund valuation rules (forward pricing).',
    `entry_load_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the front-end sales load or entry fee deducted from the gross subscription amount. Calculated as gross_subscription_amount * entry_load_rate.',
    `entry_load_rate` DECIMAL(18,2) COMMENT 'Percentage rate of the front-end sales load or entry fee charged on the subscription. Expressed as a decimal (e.g., 0.0575 for 5.75%). May be zero for no-load funds or certain share classes.',
    `gross_subscription_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of the subscription before deducting entry loads or fees. Calculated as requested_amount or (requested_units * dealing_nav).',
    `minimum_investment_waived` BOOLEAN COMMENT 'Indicates whether the fund minimum investment requirement was waived for this subscription (e.g., for systematic investment plans, employer-sponsored plans, or discretionary waivers).',
    `nav_date` DATE COMMENT 'The valuation date of the NAV (Net Asset Value) used for pricing this subscription. Typically matches trade_date for forward-priced funds.',
    `net_investment_amount` DECIMAL(18,2) COMMENT 'Net dollar amount actually invested in the fund after deducting entry loads and fees. Calculated as gross_subscription_amount - entry_load_amount. This is the amount used to calculate units allotted.',
    `notes` STRING COMMENT 'Free-form text field for operational notes, special instructions, or comments related to this subscription transaction. Used for exception handling and audit trail.',
    `order_date` DATE COMMENT 'Date when the subscription order was received and accepted by the transfer agent or fund administrator. This is the business event date for the subscription request.',
    `order_method` STRING COMMENT 'Indicates whether the investor specified a dollar amount to invest or a specific number of units/shares to purchase.. Valid values are `amount|units`',
    `order_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the subscription order was received. Critical for determining applicable NAV (Net Asset Value) pricing based on cut-off times.',
    `payment_method` STRING COMMENT 'Method by which the investor is funding the subscription. Wire = wire transfer, ACH = Automated Clearing House (ACH) electronic transfer, Check = paper check, Debit_card = debit card payment, Internal_transfer = transfer from another account within the same institution.. Valid values are `wire|ach|check|debit_card|internal_transfer`',
    `payment_received_date` DATE COMMENT 'Date when the subscription payment was received by the transfer agent or fund custodian. Critical for determining good order status and settlement timing.',
    `payment_status` STRING COMMENT 'Current status of the payment for this subscription. Pending = awaiting receipt, Received = payment received but not cleared, Cleared = payment fully cleared and available, Failed = payment failed or rejected, Reversed = payment reversed or returned.. Valid values are `pending|received|cleared|failed|reversed`',
    `requested_amount` DECIMAL(18,2) COMMENT 'Gross dollar amount the investor intends to invest before any fees or loads are applied. Populated when order_method is amount.',
    `requested_units` DECIMAL(18,2) COMMENT 'Number of fund units or shares the investor requests to purchase. Populated when order_method is units.',
    `settlement_date` DATE COMMENT 'Date when the subscription transaction settles, payment is received, and units are officially allotted to the investor account. Typically T+1 or T+2 depending on fund rules.',
    `source_of_funds` STRING COMMENT 'Investor declaration or classification of the source of funds for this subscription (e.g., salary, savings, inheritance, business income, investment proceeds). Required for Anti-Money Laundering (AML) compliance and Know Your Customer (KYC) due diligence.',
    `subscription_number` STRING COMMENT 'Business-facing unique order number for the subscription transaction. Used for investor communication and operational tracking.',
    `subscription_status` STRING COMMENT 'Current lifecycle status of the subscription order. Pending = order received awaiting validation, Accepted = order validated and accepted, Processing = order being processed for settlement, Settled = units allotted and transaction complete, Cancelled = order cancelled by investor or system, Rejected = order rejected due to validation failure or compliance issue.. Valid values are `pending|accepted|processing|settled|cancelled|rejected`',
    `subscription_type` STRING COMMENT 'Classification of the subscription order type. Initial = first investment in fund, Additional = subsequent investment, Systematic = recurring automatic investment, Reinvestment = dividend/capital gain reinvestment, Exchange_in = transfer from another fund.. Valid values are `initial|additional|systematic|reinvestment|exchange_in`',
    `tax_lot_method` STRING COMMENT 'Cost basis accounting method elected by the investor for this subscription and future redemptions. FIFO = First In First Out, LIFO = Last In First Out, Average_cost = average cost basis, Specific_identification = investor specifies lots to redeem.. Valid values are `fifo|lifo|average_cost|specific_identification`',
    `trade_date` DATE COMMENT 'Date on which the subscription transaction is executed and the applicable NAV (Net Asset Value) is determined. Typically T+0 for mutual funds if order received before cut-off time.',
    `units_allotted` DECIMAL(18,2) COMMENT 'Number of fund units or shares allotted to the investor account as a result of this subscription. Calculated as net_investment_amount / dealing_nav.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscription record was last modified. Part of audit trail for data lineage and compliance.',
    `waiver_reason` STRING COMMENT 'Business reason or code explaining why minimum investment or other requirements were waived for this subscription (e.g., systematic plan, employer plan, relationship pricing).',
    CONSTRAINT pk_subscription PRIMARY KEY(`subscription_id`)
) COMMENT 'Transactional record of investor subscription (purchase) orders for fund units or shares. Captures investor account, fund class, order date, settlement date, subscription amount or units requested, dealing NAV applied, gross subscription amount, entry load, net investment amount, units allotted, payment method, payment status, source of funds declaration, and AML clearance status. Represents the primary investor inflow event in the fund lifecycle.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`redemption` (
    `redemption_id` BIGINT COMMENT 'Unique identifier for the redemption transaction. Primary key for the redemption record.',
    `broker_id` BIGINT COMMENT 'Reference to the broker, distributor, or financial advisor who submitted the redemption order on behalf of the investor.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Redemptions are processed through banking channels. Critical for operational routing, SLA management, channel performance measurement, and regulatory reporting. Replaces denormalized order_channel cod',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Redemption proceeds currency for payment processing, FX conversion, and investor settlement. Required for multi-currency redemption handling and cash management.',
    `fund_administrator_id` BIGINT COMMENT 'Reference to the transfer agent or fund administrator responsible for processing the redemption.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific share class or unit class within the fund being redeemed (e.g., Class A, Class I, Institutional).',
    `fund_id` BIGINT COMMENT 'Reference to the mutual fund, ETF, hedge fund, or pension fund from which redemption is requested.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Redemptions in kind (paying out securities instead of cash) require instrument reference for transfer processing, valuation, and tax reporting. Common for institutional investors and fund liquidations',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account from which units or shares are being redeemed.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Redemptions generate journal entries for cash payment and unit cancellation (debit equity, credit cash). Required for daily cash reconciliation, NAV calculation, and financial statement preparation.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Redemption settlement tracking requires linking the redemption order to the outbound payment to the investor. Transfer agents must confirm payment execution before finalizing unit cancellation. The ex',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Redemption settlement on valid business days per fund calendar. Critical for payment timing, liquidity management, and transfer agency SLA compliance.',
    `reversal_redemption_id` BIGINT COMMENT 'Self-referencing FK on redemption (reversal_redemption_id)',
    `aml_check_status` STRING COMMENT 'Status of Anti-Money Laundering screening performed on the redemption transaction to detect suspicious activity.. Valid values are `passed|failed|pending|not_required`',
    `amount_requested` DECIMAL(18,2) COMMENT 'Monetary amount requested for redemption when the investor specifies a dollar amount rather than units.',
    `confirmation_number` STRING COMMENT 'Unique confirmation number issued to the investor upon successful processing of the redemption order.',
    `confirmation_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption confirmation was sent to the investor.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption record was first created in the system.',
    `dealing_nav` DECIMAL(18,2) COMMENT 'The Net Asset Value per unit or share applied to calculate the redemption proceeds, typically the NAV as of the trade date.',
    `exit_load_amount` DECIMAL(18,2) COMMENT 'Monetary value of the exit load or redemption fee deducted from gross proceeds.',
    `exit_load_rate` DECIMAL(18,2) COMMENT 'Percentage rate of the exit load or redemption fee charged to the investor, typically applied if redemption occurs within a specified holding period.',
    `gate_percentage_applied` DECIMAL(18,2) COMMENT 'Percentage of the requested redemption that is fulfilled when a gate restriction is in effect, with the remainder deferred.',
    `gate_restriction_flag` BOOLEAN COMMENT 'Indicates whether the redemption is subject to fund-level gate restrictions limiting total redemptions in a period (True = gate applied, False = no gate).',
    `gross_redemption_proceeds` DECIMAL(18,2) COMMENT 'Total proceeds calculated before deducting exit loads, redemption fees, or other charges (redemption_units × dealing_nav).',
    `kyc_verification_status` STRING COMMENT 'Status of Know Your Customer verification for the investor at the time of redemption, ensuring compliance with regulatory requirements.. Valid values are `verified|pending|expired|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption record was last updated, capturing any status changes or corrections.',
    `lock_in_compliance_flag` BOOLEAN COMMENT 'Indicates whether the redemption complies with any lock-in period requirements (True = compliant, False = early redemption).',
    `lock_in_period_end_date` DATE COMMENT 'Date on which any mandatory lock-in or holding period for the redeemed units expires, used to validate early redemption restrictions.',
    `net_redemption_proceeds` DECIMAL(18,2) COMMENT 'Final amount payable to the investor after deducting exit load, fees, and taxes from gross proceeds.',
    `order_date` DATE COMMENT 'Date on which the investor submitted the redemption order.',
    `order_number` STRING COMMENT 'Externally visible business identifier for the redemption order, used for investor communication and reconciliation.',
    `order_timestamp` TIMESTAMP COMMENT 'Precise date and time when the redemption order was received by the transfer agent or fund administrator, used for cut-off time validation.',
    `payment_account_number` STRING COMMENT 'Bank account number or International Bank Account Number (IBAN) to which redemption proceeds are transferred.',
    `payment_method` STRING COMMENT 'Method by which redemption proceeds are paid to the investor (e.g., ACH, wire transfer, check, RTGS, SWIFT).. Valid values are `ach|wire|check|rtgs|swift`',
    `payment_routing_number` STRING COMMENT 'Bank routing number, SWIFT Bank Identifier Code (BIC), or other routing identifier for the payment destination.',
    `payment_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the redemption proceeds payment was initiated to the investor account.',
    `redemption_status` STRING COMMENT 'Current lifecycle status of the redemption order (pending, confirmed, settled, cancelled, rejected, suspended).. Valid values are `pending|confirmed|settled|cancelled|rejected|suspended`',
    `redemption_type` STRING COMMENT 'Indicates whether the redemption is a full liquidation of the investor position or a partial withdrawal.. Valid values are `full|partial`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this redemption transaction must be reported to regulatory authorities (True = reportable, False = not reportable).',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for redemption rejection (e.g., insufficient units, lock-in violation, gate restriction, KYC incomplete).',
    `rejection_reason_description` STRING COMMENT 'Detailed explanation of why the redemption order was rejected, provided to the investor or intermediary.',
    `settlement_date` DATE COMMENT 'Date on which the redemption proceeds are paid to the investor, typically T+1 or T+2 depending on fund rules.',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source on redemption proceeds, if applicable under jurisdiction tax rules (e.g., capital gains tax, withholding tax).',
    `trade_date` DATE COMMENT 'Date on which the redemption transaction is executed and the Net Asset Value (NAV) is applied.',
    `units` DECIMAL(18,2) COMMENT 'Number of fund units or shares requested for redemption by the investor.',
    CONSTRAINT pk_redemption PRIMARY KEY(`redemption_id`)
) COMMENT 'Transactional record of investor redemption (sale) orders for fund units or shares. Captures investor account, fund class, order date, settlement date, redemption units or amount requested, dealing NAV applied, gross redemption proceeds, exit load, net proceeds payable, payment destination account, redemption type (full/partial), lock-up period compliance check, gate restriction flag, and settlement status. Represents the primary investor outflow event in the fund lifecycle.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`distribution_event` (
    `distribution_event_id` BIGINT COMMENT 'Unique identifier for the fund distribution event record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Distributions declared and paid in specific accounting periods for income recognition and retained earnings calculation. Required for financial statement preparation and tax reporting (Form 1099-DIV).',
    `batch_id` BIGINT COMMENT 'Foreign key linking to payment.payment_batch. Business justification: Distribution payment processing requires linking the funds distribution declaration to the payment batch that executes payments to all eligible investors. Transfer agents generate bulk payment files ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Distribution payment currency for dividend/income payments, withholding tax calculation, and investor settlement. Essential for distribution processing and tax reporting.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund share class for which the distribution is declared.',
    `fund_id` BIGINT COMMENT 'Reference to the fund declaring the distribution.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Distribution payments generate journal entries for cash disbursement and dividend payable liability. Required for cash flow statement, balance sheet reconciliation, and audit trail.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Distribution payments made on valid business days per fund calendar. Required for payment scheduling, cash management, and investor servicing.',
    `reversal_distribution_event_id` BIGINT COMMENT 'Self-referencing FK on distribution_event (reversal_distribution_event_id)',
    `accrual_end_date` DATE COMMENT 'End date of the period during which the income or capital gains distributed were earned or realized by the fund. Used for fund accounting and performance attribution.',
    `accrual_start_date` DATE COMMENT 'Start date of the period during which the income or capital gains distributed were earned or realized by the fund. Used for fund accounting and performance attribution.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved the distribution, such as the board of trustees, investment committee, or authorized officer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution event record was first created in the system.',
    `declaration_date` DATE COMMENT 'Date on which the funds board of directors or trustees formally declares the distribution.',
    `distribution_approval_date` DATE COMMENT 'Date on which the distribution was formally approved by the funds board of directors or trustees, or by authorized fund management under delegated authority.',
    `distribution_calculation_method` STRING COMMENT 'Description of the methodology used to calculate the distribution amount, such as percentage of Net Asset Value (NAV), fixed rate, or based on net investment income and realized gains.',
    `distribution_frequency` STRING COMMENT 'Scheduled frequency of distributions for the fund class. Monthly, quarterly, semi-annual, and annual represent regular distribution schedules. Special indicates a one-time or non-recurring distribution event such as a liquidating distribution or special capital gain distribution.. Valid values are `monthly|quarterly|semi_annual|annual|special`',
    `distribution_notice_date` DATE COMMENT 'Date on which the distribution notice was sent to shareholders, intermediaries, and regulatory authorities. Used to track compliance with notice requirements.',
    `distribution_number` STRING COMMENT 'Business identifier for the distribution event, typically assigned by the fund administrator or transfer agent.',
    `distribution_rate_per_unit` DECIMAL(18,2) COMMENT 'Gross distribution amount per fund share or unit before any withholding taxes or adjustments.',
    `distribution_sequence_number` STRING COMMENT 'Sequential number of the distribution within the tax year or fund fiscal year, used to track and order multiple distributions for the same fund class.',
    `distribution_source_description` STRING COMMENT 'Narrative description of the source of the distribution, such as net investment income, realized capital gains, or return of capital. Provides additional context for investor communications and regulatory disclosures.',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the distribution event. Declared indicates the distribution has been announced. Pending approval indicates awaiting regulatory or board approval. Approved indicates ready for payment processing. Paid indicates distribution has been processed and paid to shareholders. Cancelled indicates the distribution was revoked before payment.. Valid values are `declared|pending_approval|approved|paid|cancelled`',
    `distribution_type` STRING COMMENT 'Classification of the distribution for tax and accounting purposes. Income dividend represents ordinary income distributions from interest and dividends earned by the fund. Short-term capital gain represents gains from securities held one year or less. Long-term capital gain represents gains from securities held more than one year. Return of capital represents distributions that exceed the funds earnings and profits. Qualified dividend represents dividends eligible for preferential tax treatment. Non-qualified dividend represents ordinary income dividends taxed at regular rates.. Valid values are `income_dividend|short_term_capital_gain|long_term_capital_gain|return_of_capital|qualified_dividend|non_qualified_dividend`',
    `ex_dividend_date` DATE COMMENT 'Date on which the fund begins trading without the distribution value. Investors purchasing shares on or after this date are not entitled to the declared distribution.',
    `foreign_tax_credit_percentage` DECIMAL(18,2) COMMENT 'Percentage of the distribution eligible for foreign tax credit pass-through to U.S. shareholders, representing foreign taxes paid by the fund on foreign-source income. Expressed as a decimal.',
    `form_1099_div_reportable` BOOLEAN COMMENT 'Indicates whether the distribution must be reported to the Internal Revenue Service (IRS) on Form 1099-DIV for U.S. tax purposes. True for most distributions to U.S. taxable investors.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the distribution event record was last modified in the system.',
    `net_distribution_per_unit` DECIMAL(18,2) COMMENT 'Net distribution amount per share after applying default withholding tax rate. Represents the cash amount paid to investors subject to standard withholding.',
    `payment_date` DATE COMMENT 'Date on which the distribution is paid to eligible shareholders or reinvested in additional fund shares.',
    `payment_method` STRING COMMENT 'Default payment method for the distribution. Cash indicates distribution paid in cash to investor accounts. Reinvestment indicates automatic reinvestment in additional fund shares at the reinvestment NAV. Mixed indicates the fund supports both options based on individual investor elections.. Valid values are `cash|reinvestment|mixed`',
    `qualified_dividend_percentage` DECIMAL(18,2) COMMENT 'Percentage of the distribution that qualifies for preferential tax treatment as qualified dividends under Internal Revenue Code Section 1(h)(11). Expressed as a decimal (e.g., 0.85 for 85%).',
    `record_date` DATE COMMENT 'Date on which the fund determines which shareholders are entitled to receive the distribution. Only shareholders of record as of this date will receive the payment.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing associated with the distribution, such as Securities and Exchange Commission (SEC) Form N-CSR or Form N-PORT filing number.',
    `reinvestment_nav` DECIMAL(18,2) COMMENT 'Net Asset Value per share used to calculate the number of additional shares issued to investors who elect to reinvest their distribution. Typically the NAV as of the ex-dividend date or payment date per fund prospectus.',
    `section_199a_dividend_percentage` DECIMAL(18,2) COMMENT 'Percentage of the distribution that qualifies as Section 199A dividends eligible for the qualified business income deduction. Expressed as a decimal. Applicable to Real Estate Investment Trust (REIT) and certain other fund distributions.',
    `shares_outstanding_at_record` DECIMAL(18,2) COMMENT 'Total number of fund shares outstanding as of the record date, used to calculate the total distribution amount and determine eligible shareholders.',
    `tax_year` STRING COMMENT 'Calendar or fiscal tax year to which the distribution is attributed for tax reporting purposes. Typically the year in which the distribution is paid, but may differ for distributions declared in December and paid in January.',
    `total_distribution_amount` DECIMAL(18,2) COMMENT 'Total gross distribution amount declared for all eligible shares of the fund class, calculated as distribution rate per unit multiplied by total shares outstanding as of record date.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Default withholding tax rate applied to the distribution for non-exempt investors, expressed as a decimal (e.g., 0.15 for 15%). Actual withholding may vary by investor tax status and jurisdiction.',
    CONSTRAINT pk_distribution_event PRIMARY KEY(`distribution_event_id`)
) COMMENT 'Record of fund income distribution events (dividends, interest distributions, capital gain distributions) declared and paid to investors. Captures fund class, ex-dividend date, record date, payment date, distribution type (income/capital gain/return of capital), distribution rate per unit, total distribution amount, reinvestment NAV, withholding tax rate, net distribution per unit, and payment method. Drives investor tax reporting and unit register updates.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`asset_unit_register` (
    `asset_unit_register_id` BIGINT COMMENT 'Unique identifier for the unit register record. Primary key for the authoritative unit/share register.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Unit holdings valued in specific currency for position keeping, investor statements, and unrealized gain/loss calculation. Core transfer agency requirement.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund class in which the investor holds units. Each fund may have multiple share classes with different fee structures and minimum investments.',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account that holds these units. Links to the investor master record in the transfer agency system.',
    `previous_asset_unit_register_id` BIGINT COMMENT 'Self-referencing FK on asset_unit_register (previous_asset_unit_register_id)',
    `aml_risk_rating` STRING COMMENT 'Anti-Money Laundering risk classification assigned to this investor position based on KYC due diligence, transaction patterns, and jurisdiction risk. Used for enhanced monitoring and regulatory reporting.. Valid values are `low|medium|high|prohibited`',
    `average_cost_per_unit` DECIMAL(18,2) COMMENT 'Weighted average cost basis per unit calculated across all purchase transactions. Used for tax reporting and capital gains calculations.',
    `beneficial_owner_flag` BOOLEAN COMMENT 'Indicates whether the registered account holder is the beneficial owner of the units. False indicates the account is held by a nominee or intermediary on behalf of underlying beneficial owners.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether this account is reportable under the OECD Common Reporting Standard for automatic exchange of financial account information. Used for international tax compliance.',
    `current_market_value` DECIMAL(18,2) COMMENT 'Current market value of the investors holdings calculated as units held multiplied by current NAV per unit. Represents the liquidation value at current market prices.',
    `current_nav_per_unit` DECIMAL(18,2) COMMENT 'Most recent Net Asset Value per unit for the fund class. Used to calculate current market value of the investors holdings.',
    `distribution_option` STRING COMMENT 'Investors election for handling fund distributions and dividends. Reinvest automatically purchases additional units, cash pays distributions to the investors bank account, partial reinvest applies a percentage to each option.. Valid values are `reinvest|cash|partial_reinvest`',
    `escheatment_due_date` DATE COMMENT 'Date by which the position must be escheated to the appropriate state authority if the investor cannot be located. Calculated based on dormancy period and state-specific regulations.',
    `escheatment_eligible_flag` BOOLEAN COMMENT 'Indicates whether this position is eligible for escheatment to state unclaimed property authorities due to prolonged dormancy and inability to contact the investor.',
    `fatca_status` STRING COMMENT 'FATCA classification status of the investor account. Determines US tax withholding and IRS reporting obligations for the fund.. Valid values are `exempt|participating_ffi|non_participating_ffi|us_person|recalcitrant|not_applicable`',
    `first_investment_date` DATE COMMENT 'Date of the investors first purchase transaction in this fund class. Used for holding period calculations and investor tenure analysis.',
    `holding_period_days` STRING COMMENT 'Number of days since the first investment date. Used for long-term vs short-term capital gains classification and investor tenure analysis.',
    `last_statement_date` DATE COMMENT 'Date of the most recent investor statement that included this position. Used for statement generation tracking and investor servicing.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent transaction (purchase, redemption, or exchange) affecting this unit register position. Used for dormancy monitoring and investor activity tracking.',
    `last_transaction_type` STRING COMMENT 'Type of the most recent transaction that affected this position. Used for operational tracking and investor behavior analysis.. Valid values are `purchase|redemption|exchange_in|exchange_out|dividend_reinvestment|distribution`',
    `omnibus_account_flag` BOOLEAN COMMENT 'Indicates whether this is an omnibus account holding units on behalf of multiple underlying investors. True for broker-dealer and platform accounts that aggregate multiple client positions.',
    `record_closed_timestamp` TIMESTAMP COMMENT 'Timestamp when this unit register position was closed due to full redemption or account closure. Null for active positions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this unit register record was first created in the system. Represents the initial establishment of the investors position in this fund class.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this unit register record. Updated whenever any transaction or data correction affects the position.',
    `register_status` STRING COMMENT 'Current status of the unit register position. Active indicates normal holdings, closed indicates fully redeemed, suspended indicates temporary restrictions, pending closure indicates redemption in progress, restricted indicates regulatory or compliance holds.. Valid values are `active|closed|suspended|pending_closure|restricted`',
    `registration_type` STRING COMMENT 'Legal registration type of the account holding these units. Determines ownership rights, tax treatment, and distribution handling. [ENUM-REF-CANDIDATE: individual|joint_tenants|tenants_in_common|trust|corporate|custodial|retirement — 7 candidates stripped; promote to reference product]',
    `restriction_code` STRING COMMENT 'Code indicating any restrictions on the investors ability to transact in this position. Examples include regulatory holds, legal restrictions, compliance blocks, or voluntary locks. Empty if no restrictions apply.',
    `restriction_expiry_date` DATE COMMENT 'Date when the current restriction will automatically expire and normal transaction processing will resume. Null if restriction is indefinite or no restriction applies.',
    `restriction_reason` STRING COMMENT 'Detailed explanation of why the position is restricted, if applicable. Provides context for operational staff and compliance teams.',
    `source_system` STRING COMMENT 'Name of the transfer agency or fund accounting system that is the authoritative source for this unit register record. Examples include SimCorp Dimension, BlackRock Aladdin, SS&C GlobeOp.',
    `source_system_record_code` STRING COMMENT 'Unique identifier for this unit register record in the source transfer agency system. Used for reconciliation and audit trail back to the operational system of record.',
    `tax_lot_method` STRING COMMENT 'Method used to determine cost basis when units are redeemed. FIFO (First In First Out), LIFO (Last In First Out), average cost, specific identification, or highest cost first.. Valid values are `fifo|lifo|average_cost|specific_identification|highest_cost`',
    `total_cost_basis` DECIMAL(18,2) COMMENT 'Total amount invested by the investor in this fund class, calculated as units held multiplied by average cost per unit. Represents the investors original investment value for tax purposes.',
    `total_distributions_received` DECIMAL(18,2) COMMENT 'Cumulative amount of all distributions (dividends, capital gains, return of capital) received by the investor since first investment. Used for tax reporting and investor statements.',
    `total_distributions_reinvested` DECIMAL(18,2) COMMENT 'Cumulative amount of distributions that were reinvested to purchase additional units. Subset of total distributions received.',
    `units_held` DECIMAL(18,2) COMMENT 'Current number of fund units or shares held by the investor in this fund class. Represents the investors ownership stake and is used to calculate distributions and redemption proceeds.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Unrealized gain or loss on the position calculated as current market value minus total cost basis. Positive values indicate gains, negative values indicate losses.',
    `unrealized_gain_loss_percentage` DECIMAL(18,2) COMMENT 'Unrealized gain or loss expressed as a percentage of the total cost basis. Calculated as (unrealized gain/loss / total cost basis) * 100.',
    CONSTRAINT pk_asset_unit_register PRIMARY KEY(`asset_unit_register_id`)
) COMMENT 'Authoritative unit/share register record maintaining the current and historical unit holdings for each investor account in each fund class. Captures investor account, fund class, units held, average cost per unit, total cost basis, unrealized gain/loss, first investment date, last transaction date, and register status. Serves as the legal record of fund ownership and is the SSOT for investor unit balances used in redemption processing and distribution calculations.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_expense` (
    `fund_expense_id` BIGINT COMMENT 'Unique identifier for the fund expense record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Expenses must be recognized in correct accounting periods for matching principle and period-end close. Required for monthly/quarterly financial reporting and expense ratio calculations.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Expense incurred currency for invoice processing, accrual accounting, and vendor payment. Required for multi-currency expense management and NAV impact calculation.',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: FX rate for expense currency conversion to fund base currency. Required for accurate NAV calculation and audit trail.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund to which this expense belongs.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Position-specific expenses (custody fees per security, failed trade penalties, borrowing costs for short positions) require instrument linkage for accurate cost attribution and TER calculation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Expense accruals and payments generate journal entries for GL posting. Essential for period-end close, accrual accounting, and financial statement preparation under IFRS/GAAP.',
    `original_expense_fund_expense_id` BIGINT COMMENT 'Reference to the original fund_expense_id if this record is a reversal or adjustment. Null for original entries.',
    `reversal_fund_expense_id` BIGINT COMMENT 'Self-referencing FK on fund_expense (reversal_fund_expense_id)',
    `accrual_basis` STRING COMMENT 'Frequency or method by which the expense is accrued for Net Asset Value (NAV) calculation purposes.. Valid values are `daily|monthly|quarterly|annual|event_driven`',
    `accrual_date` DATE COMMENT 'Date on which the expense was accrued for accounting purposes. This is the business event date for the expense recognition.',
    `annualized_rate` DECIMAL(18,2) COMMENT 'Annualized percentage rate of the expense relative to fund assets, expressed as a decimal (e.g., 0.015 for 1.5%). Used for management fees and other recurring expenses.',
    `approval_date` DATE COMMENT 'Date on which the expense was approved for payment or accrual by an authorized approver.',
    `approved_by` STRING COMMENT 'Identifier or name of the individual who approved the expense.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Expense amount converted to the funds base reporting currency for consolidated financial reporting.',
    `calculation_methodology` STRING COMMENT 'Description of the method used to calculate the expense amount, including any formulas, tiered structures, or performance hurdles.',
    `cost_center` STRING COMMENT 'Cost center or business unit to which the expense is allocated for internal management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this expense record was first created in the system.',
    `expense_amount` DECIMAL(18,2) COMMENT 'Monetary value of the expense in the specified currency. Represents the total cost incurred.',
    `expense_category` STRING COMMENT 'High-level categorization of the expense for financial reporting and analysis purposes.. Valid values are `operating|non_operating|extraordinary`',
    `expense_description` STRING COMMENT 'Detailed textual description of the expense, including the nature of services or goods provided.',
    `expense_ratio_contribution` DECIMAL(18,2) COMMENT 'Contribution of this expense to the funds overall expense ratio, expressed as a percentage of average net assets.',
    `expense_reference_number` STRING COMMENT 'External reference number or invoice number for the expense transaction.',
    `expense_status` STRING COMMENT 'Current lifecycle status of the expense record indicating its processing state.. Valid values are `accrued|paid|reversed|pending_approval|approved|rejected`',
    `expense_type` STRING COMMENT 'Classification of the fund expense by type. Determines the nature of the cost incurred by the fund. [ENUM-REF-CANDIDATE: management_fee|performance_fee|administration_fee|custodian_fee|audit_fee|legal_fee|regulatory_filing_fee|transfer_agent_fee|distribution_fee|trustee_fee|compliance_fee|insurance_fee|other_operating_expense — 13 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this expense is posted for financial accounting and reporting.',
    `invoice_date` DATE COMMENT 'Date on the invoice issued by the payee for this expense.',
    `invoice_number` STRING COMMENT 'Invoice number provided by the payee for this expense. Used for accounts payable reconciliation.',
    `nav_impact_amount` DECIMAL(18,2) COMMENT 'The amount by which this expense reduces the funds Net Asset Value (NAV). Used in daily NAV calculation.',
    `payee_identifier` STRING COMMENT 'Unique identifier for the payee in the vendor or counterparty master system.',
    `payee_name` STRING COMMENT 'Name of the entity or individual to whom the expense is paid (e.g., fund administrator, custodian, auditor).',
    `payment_date` DATE COMMENT 'Date on which the expense was actually paid to the payee. May be null if the expense is accrued but not yet paid.',
    `payment_method` STRING COMMENT 'Method by which the expense payment was made to the payee.. Valid values are `wire_transfer|ach|check|electronic_funds_transfer|debit`',
    `payment_reference` STRING COMMENT 'Reference number or identifier for the payment transaction (e.g., wire confirmation number, check number).',
    `recoupment_eligible_indicator` BOOLEAN COMMENT 'Flag indicating whether the waived expense is eligible for future recoupment by the fund manager under the expense limitation agreement.',
    `recoupment_expiration_date` DATE COMMENT 'Date by which the fund manager must recoup the waived expense, after which the recoupment right expires.',
    `regulatory_reporting_category` STRING COMMENT 'Category code used for regulatory reporting purposes (e.g., SEC Form N-1A, N-CSR expense classifications).',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this expense record represents a reversal or correction of a previously recorded expense.',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this expense record originated (e.g., fund accounting system, portfolio management system).',
    `tax_deductible_indicator` BOOLEAN COMMENT 'Flag indicating whether the expense is tax-deductible for the fund under applicable tax regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this expense record was last modified in the system.',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Amount of the expense that was waived or reimbursed, reducing the net expense borne by the fund.',
    `waiver_indicator` BOOLEAN COMMENT 'Flag indicating whether the expense was waived or reimbursed by the fund manager or sponsor.',
    CONSTRAINT pk_fund_expense PRIMARY KEY(`fund_expense_id`)
) COMMENT 'Record of all fund-level expenses accrued and paid including management fees, performance fees, administration fees, custodian fees, audit fees, legal fees, regulatory filing fees, and other operating expenses. Captures expense type, accrual date, payment date, expense amount, currency, accrual basis, annualized rate, calculation methodology, payee, and GL account mapping. Feeds NAV calculation and fund financial statements.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_mandate` (
    `fund_mandate_id` BIGINT COMMENT 'Unique identifier for the fund mandate record. Primary key.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Fund investment mandates must align with sponsors risk appetite framework, especially for bank-owned funds and pension funds. Required for governance and risk appetite cascading. Real process: ensuri',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Investment mandates specify benchmark indices for performance measurement, tracking error limits, and compliance monitoring. Essential for mandate governance and performance attribution in asset manag',
    `fund_id` BIGINT COMMENT 'Reference to the fund to which this mandate applies.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Mandates may restrict or require specific issuers (government bonds only, investment-grade corporates, exclude tobacco/weapons). Direct issuer link enables mandate compliance monitoring and pre-trade ',
    `party_id` BIGINT COMMENT 'Reference to the investment manager or portfolio manager responsible for executing the mandate.',
    `previous_fund_mandate_id` BIGINT COMMENT 'Self-referencing FK on fund_mandate (previous_fund_mandate_id)',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee that approved the mandate (e.g., Investment Committee, Board of Directors).',
    `approval_date` DATE COMMENT 'Date when the mandate was formally approved by the designated authority.',
    `breach_tolerance_policy` STRING COMMENT 'Policy describing acceptable tolerance levels for temporary breaches of mandate restrictions and required remediation actions.',
    `compliance_monitoring_frequency` STRING COMMENT 'Frequency at which portfolio holdings are monitored for compliance with mandate restrictions.. Valid values are `real_time|daily|weekly|monthly`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was first created in the system.',
    `credit_quality_minimum` STRING COMMENT 'Minimum credit rating required for fixed income investments (e.g., investment grade, BBB- or higher). [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|investment_grade|non_investment_grade — 9 candidates stripped; promote to reference product]',
    `currency_hedging_policy` STRING COMMENT 'Policy regarding foreign exchange risk management (e.g., fully hedged, partially hedged, unhedged, discretionary).. Valid values are `fully_hedged|partially_hedged|unhedged|discretionary`',
    `derivative_usage_policy` STRING COMMENT 'Policy governing the use of derivative instruments (e.g., prohibited, hedging only, efficient portfolio management, speculative trading allowed).. Valid values are `prohibited|hedging_only|efficient_portfolio_management|speculative_allowed`',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the formal mandate document or Investment Policy Statement (IPS).',
    `duration_range_max_years` DECIMAL(18,2) COMMENT 'Maximum portfolio duration in years for fixed income holdings to manage interest rate risk.',
    `duration_range_min_years` DECIMAL(18,2) COMMENT 'Minimum portfolio duration in years for fixed income holdings to manage interest rate risk.',
    `effective_date` DATE COMMENT 'Date when the mandate becomes effective and binding for portfolio management.',
    `esg_constraints` STRING COMMENT 'Environmental, Social, and Governance criteria or exclusions applied to the investment universe (e.g., exclude tobacco, weapons, fossil fuels; require minimum ESG rating).',
    `geographic_restrictions` STRING COMMENT 'Geographic regions or countries where investments are permitted or restricted (e.g., developed markets only, exclude sanctioned countries).',
    `high_water_mark_applicable` BOOLEAN COMMENT 'Indicates whether a high water mark mechanism is used for performance fee calculation to ensure fees are only charged on net new profits.',
    `investment_objective` STRING COMMENT 'Primary investment goal of the fund such as capital appreciation, income generation, capital preservation, or balanced growth.',
    `investment_strategy` STRING COMMENT 'Detailed description of the approach and methodology used to achieve the investment objective.',
    `issuer_concentration_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of fund assets that can be invested in securities of a single issuer to mitigate concentration risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mandate record was last updated.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the mandate by the investment committee or governing body.',
    `leverage_limit_pct` DECIMAL(18,2) COMMENT 'Maximum leverage ratio expressed as a percentage of Net Asset Value (NAV) that the fund is permitted to employ.',
    `liquidity_requirement_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of fund assets that must be held in liquid instruments to meet redemption requests and operational needs.',
    `mandate_code` STRING COMMENT 'Unique business identifier or code for the mandate used in operational systems and regulatory reporting.',
    `mandate_name` STRING COMMENT 'Business name or title of the investment mandate.',
    `mandate_status` STRING COMMENT 'Current lifecycle status of the mandate.. Valid values are `active|suspended|terminated|under_review|pending_approval`',
    `mandate_type` STRING COMMENT 'Classification of the mandate based on the level of discretion and management style.. Valid values are `discretionary|advisory|execution_only|managed_account|collective_investment`',
    `modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified the mandate record.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the mandate.',
    `performance_fee_applicable` BOOLEAN COMMENT 'Indicates whether a performance-based fee structure is applicable to this mandate.',
    `permitted_asset_classes` STRING COMMENT 'Comma-separated list of asset classes the fund is authorized to invest in (e.g., equities, fixed income, commodities, real estate, derivatives, cash equivalents).',
    `prohibited_asset_classes` STRING COMMENT 'Comma-separated list of asset classes explicitly excluded from the investment universe.',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the portfolio is reviewed and rebalanced to maintain alignment with the mandate. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|event_driven — 7 candidates stripped; promote to reference product]',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the mandate (e.g., UCITS, AIFMD, Registered Investment Company, Private Fund) for compliance and reporting purposes.',
    `sector_limits` STRING COMMENT 'Maximum exposure limits by industry sector (e.g., technology max 25%, financials max 20%) to ensure diversification.',
    `sri_constraints` STRING COMMENT 'Socially responsible investment criteria or ethical screening rules applied to portfolio construction.',
    `termination_date` DATE COMMENT 'Date when the mandate is terminated or expires. Null if the mandate is open-ended.',
    `version_number` STRING COMMENT 'Version number of the mandate document to track amendments and revisions over time.',
    CONSTRAINT pk_fund_mandate PRIMARY KEY(`fund_mandate_id`)
) COMMENT 'Investment mandate and policy record governing the investment strategy, constraints, and guidelines for a fund. Captures investment objective, permitted asset classes, geographic restrictions, sector limits, issuer concentration limits, credit quality minimums, duration range, liquidity requirements, leverage limits, derivative usage policy, ESG/SRI constraints, benchmark, and mandate review date. Serves as the compliance reference for portfolio construction and investment restriction monitoring.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`investment_restriction` (
    `investment_restriction_id` BIGINT COMMENT 'Unique identifier for the investment restriction rule record.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund to which this investment restriction applies.',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Investment restrictions enforce mandate limits (concentration, credit quality, duration). Link ties restriction rules to the mandate they implement, enabling mandate-level compliance monitoring and br',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Restrictions frequently target specific issuers (sanctioned entities, excluded sectors, related party transactions). Direct issuer link enables automated pre-trade checks and issuer-level exposure mon',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Jurisdiction-specific investment limits (EU UCITS, US 40 Act, Cayman CIMA rules). Required for multi-jurisdiction fund compliance and regulatory reporting.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the portfolio subject to this restriction rule.',
    `employee_id` BIGINT COMMENT 'Identifier of the portfolio manager responsible for monitoring and remediating this restriction.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Investment restrictions derived from regulatory taxonomy (UCITS diversification, 40 Act concentration limits). Links compliance rules to regulatory framework for automated monitoring.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Investment restrictions operationalize risk limits at fund level (concentration limits, VaR limits, leverage limits). Required for limit monitoring and breach management. Real process: translating ent',
    `superseded_by_restriction_investment_restriction_id` BIGINT COMMENT 'Identifier of the restriction rule that supersedes this one. Null if this is the current version.',
    `superseded_investment_restriction_id` BIGINT COMMENT 'Self-referencing FK on investment_restriction (superseded_investment_restriction_id)',
    `approved_by` STRING COMMENT 'User ID or name of the individual who approved the restriction rule for activation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the restriction rule was approved for activation. Null if still in draft or pending approval.',
    `breach_date` DATE COMMENT 'Date on which the restriction was breached. Null if no breach has occurred.',
    `breach_magnitude` DECIMAL(18,2) COMMENT 'Magnitude of the breach expressed in the same unit as the threshold (e.g., 2.50 for 2.5% over limit). Null if compliant.',
    `breach_status` STRING COMMENT 'Current compliance status of the restriction: compliant, breached, warning (approaching threshold), remediated, waived (approved exception), or under review.. Valid values are `compliant|breached|warning|remediated|waived|under_review`',
    `breach_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the breach was detected, supporting intraday and real-time monitoring.',
    `breach_tolerance` DECIMAL(18,2) COMMENT 'Allowable tolerance or buffer before a breach is triggered (e.g., 0.50 for 0.5% tolerance above threshold).',
    `check_timing` STRING COMMENT 'Indicates whether the restriction is enforced pre-trade (before execution), post-trade (after settlement), or both.. Valid values are `pre_trade|post_trade|both`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment restriction record was first created in the system.',
    `current_exposure` DECIMAL(18,2) COMMENT 'Current measured exposure or utilization against the restriction threshold, expressed in the same unit as the threshold.',
    `effective_date` DATE COMMENT 'Date from which the investment restriction rule becomes effective and enforceable.',
    `enforcement_action` STRING COMMENT 'Action taken when a breach is detected: block (prevent trade), alert (notify), escalate (senior approval), override required, or auto-remediate.. Valid values are `block|alert|escalate|override_required|auto_remediate`',
    `expiry_date` DATE COMMENT 'Date on which the restriction rule expires or is no longer applicable. Null for perpetual restrictions.',
    `last_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance check performed for this restriction.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the restriction rule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the investment restriction record was last modified.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which the restriction is monitored and compliance is checked: real-time, intraday, daily, weekly, monthly, quarterly, or on-demand. [ENUM-REF-CANDIDATE: real_time|intraday|daily|weekly|monthly|quarterly|on_demand — 7 candidates stripped; promote to reference product]',
    `next_check_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next compliance check based on monitoring frequency.',
    `override_allowed` BOOLEAN COMMENT 'Indicates whether manual override of the restriction is permitted under defined circumstances (true/false).',
    `override_authority_level` STRING COMMENT 'Minimum authority level required to approve an override: none, portfolio manager, head of risk, CIO (Chief Investment Officer), board, or regulator.. Valid values are `none|portfolio_manager|head_of_risk|cio|board|regulator`',
    `remediation_deadline` DATE COMMENT 'Date by which a breach must be remediated to restore compliance. Null if no breach or no deadline applies.',
    `remediation_plan` STRING COMMENT 'Description of the remediation plan or actions taken to address the breach.',
    `restriction_category` STRING COMMENT 'Business category of the restriction: concentration, liquidity, leverage, counterparty exposure, asset class, geography, sector, issuer, credit rating, or maturity. [ENUM-REF-CANDIDATE: concentration|liquidity|leverage|counterparty|asset_class|geography|sector|issuer|rating|maturity — 10 candidates stripped; promote to reference product]',
    `restriction_code` STRING COMMENT 'Unique business code identifying the restriction rule within the compliance framework.',
    `restriction_name` STRING COMMENT 'Human-readable name of the investment restriction rule.',
    `restriction_status` STRING COMMENT 'Lifecycle status of the restriction rule: active (in force), suspended (temporarily inactive), expired, superseded (replaced by newer rule), or draft (not yet effective).. Valid values are `active|suspended|expired|superseded|draft`',
    `restriction_type` STRING COMMENT 'Classification of the restriction source: regulatory (UCITS, AIFMD), mandate (prospectus), internal (risk policy), contractual (IMA), statutory (local law), or risk limit (VaR, concentration).. Valid values are `regulatory|mandate|internal|contractual|statutory|risk_limit`',
    `rule_description` STRING COMMENT 'Detailed textual description of the investment restriction rule, including conditions and applicability.',
    `source_system` STRING COMMENT 'Name of the source system from which the restriction rule was ingested (e.g., SimCorp Dimension, BlackRock Aladdin, internal compliance platform).',
    `threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code for absolute amount thresholds (e.g., USD, EUR, GBP). Null for percentage or ratio thresholds.. Valid values are `^[A-Z]{3}$`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value: percentage (%), absolute amount (currency), basis points (bps), ratio, or count.. Valid values are `percentage|absolute_amount|basis_points|ratio|count`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold or limit value for the restriction (e.g., 10.00 for 10% concentration limit).',
    `version_number` STRING COMMENT 'Version number of the restriction rule, incremented with each amendment or update.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the restriction rule record.',
    CONSTRAINT pk_investment_restriction PRIMARY KEY(`investment_restriction_id`)
) COMMENT 'Operational record of investment restriction rules and compliance checks applied to fund portfolios. Captures restriction type (regulatory, mandate, internal), rule description, threshold value, breach tolerance, monitoring frequency, pre-trade vs post-trade flag, breach status, breach date, breach magnitude, remediation deadline, and responsible portfolio manager. Supports UCITS investment restriction monitoring, AIFMD compliance, and internal mandate adherence.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`restriction_breach` (
    `restriction_breach_id` BIGINT COMMENT 'Unique identifier for the restriction breach record. Primary key.',
    `capture_id` BIGINT COMMENT 'Identifier of the trade transaction that triggered the breach, if applicable.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund in which the restriction breach occurred.',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Restriction breaches violate mandate constraints. Link shows which mandate was breached, enabling mandate-level breach tracking, remediation, and regulatory reporting for investment management complia',
    `instrument_id` BIGINT COMMENT 'Identifier of the specific security involved in the breach, if applicable.',
    `investment_restriction_id` BIGINT COMMENT 'Identifier of the investment restriction rule that was breached.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Breaches frequently relate to issuer concentration limits (single issuer >10% NAV). Direct issuer link enables breach resolution tracking, remediation monitoring, and issuer-level exposure aggregation',
    `party_id` BIGINT COMMENT 'Identifier of the counterparty involved in the transaction that caused the breach, if applicable.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the portfolio associated with the breach, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the portfolio manager responsible for the fund at the time of breach.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Breach categorization by regulatory regime for incident reporting, remediation tracking, and regulatory notification. Links breach events to compliance framework.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Restriction breaches trigger risk limit breach workflows, escalation, and remediation tracking. Required for integrated limit breach management across fund operations and enterprise risk. Real process',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Breach tied to specific security for root cause analysis, position monitoring, and compliance reporting. Links breach to master security data.',
    `tertiary_restriction_waiver_granted_by_employee_id` BIGINT COMMENT 'Identifier of the authorized individual who granted the waiver.',
    `previous_restriction_breach_id` BIGINT COMMENT 'Self-referencing FK on restriction_breach (previous_restriction_breach_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value of the metric at the time of breach detection.',
    `breach_category` STRING COMMENT 'Category of investment restriction breached: concentration limits, liquidity requirements, leverage constraints, exposure limits, diversification rules, or asset eligibility criteria.. Valid values are `concentration|liquidity|leverage|exposure|diversification|eligibility`',
    `breach_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary breach values.. Valid values are `^[A-Z]{3}$`',
    `breach_detection_timestamp` TIMESTAMP COMMENT 'Date and time when the restriction breach was detected by the compliance monitoring system.',
    `breach_disposition` STRING COMMENT 'Final disposition of the breach: resolved (corrected and closed), waived (approved exception granted), escalated (elevated for senior decision), pending (awaiting action), or withdrawn (breach determination reversed).. Valid values are `resolved|waived|escalated|pending|withdrawn`',
    `breach_magnitude_unit` STRING COMMENT 'Unit of measure for the breach magnitude: percentage, basis points (BPS), currency amount, number of units, or ratio.. Valid values are `percentage|basis_points|amount|units|ratio`',
    `breach_magnitude_value` DECIMAL(18,2) COMMENT 'Quantitative measure of the breach magnitude, expressed in the unit of measure specified (e.g., percentage points over limit, absolute amount over threshold).',
    `breach_notes` STRING COMMENT 'Free-text notes and comments regarding the breach, remediation, and resolution process.',
    `breach_occurrence_date` DATE COMMENT 'Business date on which the breach actually occurred or was effective.',
    `breach_reference_number` STRING COMMENT 'External reference number assigned to this breach for tracking and reporting purposes.',
    `breach_severity_score` STRING COMMENT 'Numerical severity score assigned to the breach based on magnitude, duration, and regulatory impact (typically 1-10 scale).',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach: open (newly detected), under review (being analyzed), remediation in progress (corrective action underway), resolved (corrected), waived (approved exception), escalated (elevated to senior management), or closed (finalized). [ENUM-REF-CANDIDATE: open|under_review|remediation_in_progress|resolved|waived|escalated|closed — 7 candidates stripped; promote to reference product]',
    `breach_type` STRING COMMENT 'Classification of the breach severity: hard limit (absolute prohibition), soft limit (guideline with tolerance), warning (approaching limit), or threshold (monitoring trigger).. Valid values are `hard_limit|soft_limit|warning|threshold`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this breach record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this breach record was last updated.',
    `monitoring_stage` STRING COMMENT 'Stage at which the breach was detected: pre-trade compliance check, post-trade validation, end-of-day reconciliation, or intraday monitoring.. Valid values are `pre_trade|post_trade|end_of_day|intraday`',
    `portfolio_manager_notified_flag` BOOLEAN COMMENT 'Indicates whether the portfolio manager has been notified of the breach.',
    `portfolio_manager_notified_timestamp` TIMESTAMP COMMENT 'Date and time when the portfolio manager was notified of the breach.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the required regulatory report has been submitted.',
    `regulatory_report_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report was submitted.',
    `regulatory_reporting_deadline_date` DATE COMMENT 'Deadline date by which the breach must be reported to the regulator, if reporting is required.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this breach must be reported to regulatory authorities under UCITS, AIFMD, or other applicable regulations.',
    `remediation_action_type` STRING COMMENT 'Type of remediation action taken to address the breach: trade reversal, position reduction, portfolio rebalancing, waiver granted by authorized party, no action required, or manual override.. Valid values are `trade_reversal|position_reduction|rebalancing|waiver_granted|no_action_required|manual_override`',
    `remediation_description` STRING COMMENT 'Detailed description of the remediation actions taken or planned to resolve the breach.',
    `remediation_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when remediation actions were initiated.',
    `resolution_date` DATE COMMENT 'Date on which the breach was fully resolved and the portfolio returned to compliance.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the breach was resolved.',
    `threshold_limit_value` DECIMAL(18,2) COMMENT 'The regulatory or policy threshold limit that was breached.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a formal waiver was granted for this breach by authorized personnel.',
    `waiver_granted_timestamp` TIMESTAMP COMMENT 'Date and time when the waiver was formally granted.',
    `waiver_justification` STRING COMMENT 'Business justification and rationale for granting the waiver.',
    CONSTRAINT pk_restriction_breach PRIMARY KEY(`restriction_breach_id`)
) COMMENT 'Transactional record of investment restriction breaches identified during pre-trade or post-trade compliance monitoring. Captures fund, restriction rule breached, breach detection date, breach type (hard/soft limit), breach magnitude, portfolio manager notified, remediation action taken, resolution date, regulatory reporting obligation, and breach disposition (resolved, waived, escalated). Supports regulatory reporting under UCITS, AIFMD, and internal governance.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_performance` (
    `fund_performance_id` BIGINT COMMENT 'Unique identifier for the fund performance record.',
    `benchmark_id` BIGINT COMMENT 'Identifier of the benchmark index used for performance comparison (e.g., S&P 500, MSCI World, Bloomberg Barclays Aggregate).',
    `fund_class_id` BIGINT COMMENT 'Identifier of the specific fund share class (e.g., Class A, Class I, Institutional) for which performance is calculated.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund for which performance is being measured.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Performance metrics currency denomination for return calculation and peer comparison. Essential for GIPS compliance and performance attribution.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that performed the performance calculation.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Performance attribution under stress scenarios measures risk-adjusted returns and worst-case performance. Required for AIFMD stress testing disclosure and investor reporting. Real process: stressed pe',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Performance attribution for fixed income funds requires yield curve data for return decomposition (carry, rolldown, spread, curve shift). Essential for explaining bond portfolio returns to investors.',
    `previous_fund_performance_id` BIGINT COMMENT 'Self-referencing FK on fund_performance (previous_fund_performance_id)',
    `active_return_pct` DECIMAL(18,2) COMMENT 'Excess return of the fund relative to the benchmark (fund return minus benchmark return), also known as alpha. Measures the value added by active management.',
    `average_aum` DECIMAL(18,2) COMMENT 'Average total net assets of the fund during the performance period, used for expense ratio and turnover calculations.',
    `beginning_nav` DECIMAL(18,2) COMMENT 'Net Asset Value per share at the start of the performance period.',
    `benchmark_return_pct` DECIMAL(18,2) COMMENT 'Return of the benchmark index over the same performance period, expressed as a percentage.',
    `beta` DECIMAL(18,2) COMMENT 'Measure of the funds sensitivity to benchmark movements. Beta of 1.0 indicates the fund moves in line with the benchmark; >1.0 indicates higher volatility; <1.0 indicates lower volatility.',
    `calculation_date` DATE COMMENT 'Date on which the performance metrics were calculated.',
    `calculation_methodology` STRING COMMENT 'Specific mathematical method used to calculate the performance return: Modified Dietz (approximation), True TWR (daily valuation), Simple TWR (periodic valuation), IRR (money-weighted).. Valid values are `modified_dietz|true_twr|simple_twr|irr`',
    `capital_appreciation_pct` DECIMAL(18,2) COMMENT 'Portion of total return attributable to capital gains (price appreciation), expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was first created in the system.',
    `ending_nav` DECIMAL(18,2) COMMENT 'Net Asset Value per share at the end of the performance period.',
    `expense_ratio_pct` DECIMAL(18,2) COMMENT 'Total annual operating expenses as a percentage of average net assets during the performance period. Includes management fees, administrative costs, and other fund expenses.',
    `gips_compliant_flag` BOOLEAN COMMENT 'Indicates whether the performance calculation and presentation comply with Global Investment Performance Standards established by CFA Institute.',
    `income_return_pct` DECIMAL(18,2) COMMENT 'Portion of total return attributable to income (dividends, interest, distributions), expressed as a percentage.',
    `information_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted active return metric calculated as active return / tracking error. Measures excess return per unit of active risk.',
    `maximum_drawdown_pct` DECIMAL(18,2) COMMENT 'Largest peak-to-trough decline in fund value during the performance period, expressed as a percentage. Measures downside risk and worst-case loss scenario.',
    `mwr_return_pct` DECIMAL(18,2) COMMENT 'Money-weighted return (also known as Internal Rate of Return or IRR) that accounts for the timing and magnitude of cash flows. Reflects the actual investor experience including contribution and withdrawal timing effects.',
    `number_of_holdings` STRING COMMENT 'Total count of distinct securities held in the fund portfolio at the end of the performance period.',
    `performance_attribution_available_flag` BOOLEAN COMMENT 'Indicates whether detailed performance attribution analysis (sector allocation, security selection effects) is available for this performance record.',
    `performance_end_date` DATE COMMENT 'End date of the performance measurement period.',
    `performance_period_type` STRING COMMENT 'Standard reporting period for the performance calculation. ITD = Inception-to-Date (since inception). [ENUM-REF-CANDIDATE: 1M|3M|6M|YTD|1Y|3Y|5Y|ITD — 8 candidates stripped; promote to reference product]',
    `performance_start_date` DATE COMMENT 'Start date of the performance measurement period.',
    `performance_status` STRING COMMENT 'Current status of the performance record in its lifecycle: preliminary (initial calculation), final (confirmed), restated (corrected after finalization), audited (verified by external auditor).. Valid values are `preliminary|final|restated|audited`',
    `r_squared` DECIMAL(18,2) COMMENT 'Statistical measure (0 to 1) indicating how much of the funds movements can be explained by benchmark movements. Higher values indicate greater correlation with the benchmark.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this performance record is used for regulatory reporting purposes (SEC filings, prospectus updates, factsheet disclosures).',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which performance metrics are reported to investors. May differ from base fund currency for multi-currency share classes.. Valid values are `^[A-Z]{3}$`',
    `risk_free_rate_pct` DECIMAL(18,2) COMMENT 'Risk-free rate of return used in risk-adjusted performance calculations (Sharpe ratio, Sortino ratio). Typically based on government treasury securities of comparable duration.',
    `sharpe_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted return metric calculated as (fund return - risk-free rate) / standard deviation of returns. Measures excess return per unit of total risk.',
    `sortino_ratio` DECIMAL(18,2) COMMENT 'Risk-adjusted return metric similar to Sharpe ratio but using downside deviation instead of total standard deviation. Focuses on downside risk only.',
    `total_return_amount` DECIMAL(18,2) COMMENT 'Absolute dollar amount of return generated during the performance period, calculated as ending NAV minus beginning NAV plus distributions.',
    `tracking_error_pct` DECIMAL(18,2) COMMENT 'Standard deviation of the difference between fund returns and benchmark returns, expressed as a percentage. Measures the consistency of active return.',
    `turnover_ratio_pct` DECIMAL(18,2) COMMENT 'Measure of how frequently assets within the fund are bought and sold, expressed as a percentage of average net assets. Higher turnover may indicate more active trading.',
    `twr_gross_return_pct` DECIMAL(18,2) COMMENT 'Time-weighted return before deduction of fees, expressed as a percentage. TWR eliminates the effect of cash flows and measures the compound growth rate of the portfolio.',
    `twr_net_return_pct` DECIMAL(18,2) COMMENT 'Time-weighted return after deduction of all fees and expenses, expressed as a percentage. This is the return actually realized by investors.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was last modified.',
    `volatility_pct` DECIMAL(18,2) COMMENT 'Annualized standard deviation of fund returns over the performance period, expressed as a percentage. Measures total risk and return variability.',
    CONSTRAINT pk_fund_performance PRIMARY KEY(`fund_performance_id`)
) COMMENT 'Periodic fund performance record capturing time-weighted returns (TWR) and money-weighted returns (MWR/IRR) for each fund class over standard reporting periods (1M, 3M, 6M, YTD, 1Y, 3Y, 5Y, since inception). Captures gross and net returns, benchmark return, active return (alpha), tracking error, Sharpe ratio, information ratio, maximum drawdown, volatility, and GIPS compliance flag. Used for investor reporting, fund factsheets, and regulatory disclosures.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_regulatory_report` (
    `fund_regulatory_report_id` BIGINT COMMENT 'Unique identifier for the fund regulatory report record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Regulatory reports (Form PF, AIFMD, UCITS) cover specific accounting periods and must reconcile to audited financial statements. Required for regulatory compliance and period-end certification.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund for which this regulatory report is filed.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Regulatory reports (AIFMD Annex IV, UCITS KIID) require issuer-level aggregation for concentration reporting, top 10 issuers disclosure, and counterparty exposure. Direct link enables automated regula',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Regulatory filing jurisdiction (SEC, FCA, ESMA, CIMA) for submission routing, deadline tracking, and compliance monitoring. Critical for multi-jurisdiction regulatory reporting.',
    `risk_report_id` BIGINT COMMENT 'Foreign key linking to risk.risk_report. Business justification: Fund regulatory reports (AIFMD, UCITS KIID, Form PF) feed into consolidated risk reports for board and regulators. Required for enterprise-wide risk reporting aggregation. Real process: consolidating ',
    `previous_fund_regulatory_report_id` BIGINT COMMENT 'Self-referencing FK on fund_regulatory_report (previous_fund_regulatory_report_id)',
    `acceptance_date` DATE COMMENT 'Date on which the regulator formally accepted the report submission as complete and compliant.',
    `amendment_reason` STRING COMMENT 'Explanation of why the report was amended or resubmitted, including nature of corrections made.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this report to internal audit logs and compliance tracking systems.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context related to this regulatory report submission.',
    `confidentiality_level` STRING COMMENT 'Classification level indicating the sensitivity and access restrictions for this regulatory report.. Valid values are `public|confidential|restricted`',
    `confirmation_number` STRING COMMENT 'Confirmation or acknowledgment number issued by the regulator upon successful receipt of the report.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory report record was first created in the system.',
    `filing_frequency` STRING COMMENT 'Required frequency at which this type of regulatory report must be filed. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory report record was last updated or modified.',
    `late_filing_flag` BOOLEAN COMMENT 'Indicates whether the report was submitted after the regulatory deadline.',
    `late_filing_reason` STRING COMMENT 'Explanation for why the report was filed after the regulatory deadline.',
    `original_submission_reference_number` STRING COMMENT 'Reference number of the original report submission if this is a resubmission or amendment.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed by the regulator for late filing, errors, or non-compliance.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this regulatory report is subject to public disclosure or remains confidential.',
    `regulator_code` STRING COMMENT 'Code identifying the regulatory body or governing authority to which this report is submitted. [ENUM-REF-CANDIDATE: SEC|FINRA|CFTC|FCA|ESMA|EBA|BaFin|AMF|CSSF|MAS — 10 candidates stripped; promote to reference product]',
    `regulator_name` STRING COMMENT 'Full name of the regulatory body or governing authority receiving this report.',
    `rejection_date` DATE COMMENT 'Date on which the regulator rejected the report submission due to errors or non-compliance.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulator for rejecting the report submission.',
    `report_approval_date` DATE COMMENT 'Date on which the regulatory report was internally approved for submission.',
    `report_checksum` STRING COMMENT 'Cryptographic hash or checksum of the report file to ensure data integrity and detect tampering.',
    `report_file_format` STRING COMMENT 'Technical file format in which the regulatory report was submitted.. Valid values are `XML|XBRL|PDF|CSV|JSON`',
    `report_file_name` STRING COMMENT 'Name of the file containing the regulatory report submission, typically in XML, XBRL, or PDF format.',
    `report_file_size_bytes` BIGINT COMMENT 'Size of the submitted report file in bytes.',
    `report_preparer_email` STRING COMMENT 'Email address of the individual responsible for preparing the regulatory report.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `report_preparer_name` STRING COMMENT 'Name of the individual or team responsible for preparing the regulatory report.',
    `report_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this regulatory report submission by the reporting system or regulator.',
    `report_reviewer_name` STRING COMMENT 'Name of the individual who reviewed and approved the regulatory report before submission.',
    `report_status` STRING COMMENT 'Current lifecycle status of the regulatory report submission.. Valid values are `draft|submitted|accepted|rejected|amended`',
    `report_type` STRING COMMENT 'Type of regulatory report being filed. Indicates the specific regulatory framework and form template. [ENUM-REF-CANDIDATE: AIFMD_ANNEX_IV|UCITS_KIID|UCITS_KID|FORM_PF|CPO_PQR|FATCA|CRS|EMIR|SOLVENCY_II — 9 candidates stripped; promote to reference product]',
    `report_version_number` STRING COMMENT 'Version number of this report submission, incremented for each amendment or resubmission.',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this regulatory report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this regulatory report.',
    `resubmission_flag` BOOLEAN COMMENT 'Indicates whether this report is a resubmission or amendment of a previously filed report.',
    `submission_date` DATE COMMENT 'Date on which the regulatory report was submitted to the regulator or governing body.',
    `submission_deadline_date` DATE COMMENT 'Regulatory deadline date by which the report must be submitted to remain compliant.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the regulatory report was submitted to the regulator, including time zone information.',
    CONSTRAINT pk_fund_regulatory_report PRIMARY KEY(`fund_regulatory_report_id`)
) COMMENT 'Regulatory reporting record for fund-level submissions to governing bodies and regulators. Captures report type (AIFMD Annex IV, UCITS KIID/KID, Form PF, CPO-PQR, FATCA/CRS, EMIR, Solvency II look-through), reporting period, submission date, regulator/recipient, report status (draft, submitted, accepted, rejected), submission reference number, and resubmission flag. Tracks the full lifecycle of mandatory fund regulatory filings.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` (
    `fund_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the fund lifecycle event record. Primary key for the fund lifecycle event entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the fund officer or executive responsible for overseeing the execution of this lifecycle event.',
    `fund_class_id` BIGINT COMMENT 'Identifier of the specific share class affected by this lifecycle event. Populated for share class-specific events such as share class launch or termination.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund to which this lifecycle event applies. Links to the master fund entity.',
    `superseded_by_event_fund_lifecycle_event_id` BIGINT COMMENT 'Identifier of the subsequent lifecycle event that supersedes or replaces this event.',
    `previous_fund_lifecycle_event_id` BIGINT COMMENT 'Self-referencing FK on fund_lifecycle_event (previous_fund_lifecycle_event_id)',
    `auditor_firm` STRING COMMENT 'Name of the external auditor firm providing audit or assurance services related to this lifecycle event.',
    `aum_at_event` DECIMAL(18,2) COMMENT 'Total assets under management of the fund at the time of the lifecycle event. Provides context for the scale and impact of the event.',
    `aum_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the AUM at event amount.. Valid values are `^[A-Z]{3}$`',
    `board_approval_date` DATE COMMENT 'Date on which the funds board of directors approved this lifecycle event.',
    `board_resolution_reference` STRING COMMENT 'Reference number or identifier of the board of directors resolution authorizing this lifecycle event.',
    `cancellation_date` DATE COMMENT 'Date on which the lifecycle event was cancelled or withdrawn before becoming effective.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the lifecycle event was cancelled or withdrawn.',
    `completion_date` DATE COMMENT 'Date on which the lifecycle event was fully completed and all associated actions were finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle event record was first created in the system. Audit trail for record creation.',
    `effective_date` DATE COMMENT 'The date on which the lifecycle event becomes legally and operationally effective. May differ from the event date due to regulatory approval or notice periods.',
    `event_category` STRING COMMENT 'High-level categorization of the lifecycle event for reporting and analysis purposes.. Valid values are `operational|regulatory|structural|distribution|strategic|compliance`',
    `event_date` DATE COMMENT 'The date on which the lifecycle event was formally recorded or announced. This is the principal business event timestamp for the lifecycle event.',
    `event_description` STRING COMMENT 'Detailed narrative description of the lifecycle event, including business rationale, impact on investors, and any special conditions or considerations.',
    `event_reason` STRING COMMENT 'Business rationale or justification for the lifecycle event. Explains why the event was initiated.',
    `event_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this lifecycle event for tracking and audit purposes.',
    `event_status` STRING COMMENT 'Current status of the lifecycle event in its approval and execution workflow. [ENUM-REF-CANDIDATE: proposed|pending_approval|approved|effective|completed|cancelled|superseded — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the lifecycle event. Defines the nature of the event in the funds operational lifecycle. [ENUM-REF-CANDIDATE: fund_launch|soft_close|hard_close|reopening|merger|restructuring|share_class_launch|share_class_termination|fund_liquidation|fund_suspension|fund_deregistration|name_change|domicile_change|strategy_change — promote to reference product]',
    `initiated_by` STRING COMMENT 'Name or identifier of the individual, department, or entity that initiated this lifecycle event.',
    `investor_count_at_event` STRING COMMENT 'Total number of investors holding positions in the fund at the time of the lifecycle event.',
    `investor_notification_date` DATE COMMENT 'Date on which investors were formally notified of this lifecycle event. Critical for compliance with disclosure requirements.',
    `investor_notification_method` STRING COMMENT 'Method or channel used to notify investors of this lifecycle event.. Valid values are `prospectus_supplement|shareholder_letter|website_posting|regulatory_filing|email|press_release`',
    `legal_counsel_firm` STRING COMMENT 'Name of the external legal counsel firm advising on this lifecycle event.',
    `merger_exchange_ratio` DECIMAL(18,2) COMMENT 'Exchange ratio applied in fund merger events, representing the number of successor fund shares received per share of the merging fund.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle event record was last modified. Audit trail for record updates.',
    `press_release_date` DATE COMMENT 'Date on which the press release announcing this lifecycle event was issued.',
    `press_release_issued_flag` BOOLEAN COMMENT 'Indicates whether a public press release was issued to announce this lifecycle event.',
    `prospectus_supplement_flag` BOOLEAN COMMENT 'Indicates whether a prospectus supplement was issued to investors in connection with this lifecycle event.',
    `regulatory_approval_date` DATE COMMENT 'Date on which regulatory approval was granted for this lifecycle event.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier of the regulatory approval granted for this lifecycle event. Populated when regulatory approval is obtained.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event requires formal regulatory approval before it can become effective.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body that provided approval or oversight for this lifecycle event (e.g., SEC, FCA, ESMA).',
    `regulatory_filing_date` DATE COMMENT 'Date on which the regulatory filing related to this lifecycle event was submitted to the regulatory authority.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier of the regulatory filing submitted in connection with this lifecycle event (e.g., SEC filing accession number).',
    `shareholder_approval_date` DATE COMMENT 'Date on which shareholders approved this lifecycle event through formal vote.',
    `shareholder_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event requires formal shareholder approval before it can become effective.',
    `source_system` STRING COMMENT 'Name of the operational system from which this lifecycle event record originated (e.g., SimCorp Dimension, BlackRock Aladdin).',
    CONSTRAINT pk_fund_lifecycle_event PRIMARY KEY(`fund_lifecycle_event_id`)
) COMMENT 'Immutable audit log of significant fund lifecycle events from launch through liquidation. Captures event type (fund launch, soft close, hard close, reopening, merger, restructuring, share class launch/termination, fund liquidation), event date, effective date, regulatory approval reference, board resolution reference, investor notification date, and event description. Provides the complete lifecycle history for regulatory, legal, and governance purposes.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_administrator` (
    `fund_administrator_id` BIGINT COMMENT 'Unique identifier for the fund administrator service provider relationship. Primary key for the fund administrator entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Fund administrator relationships require dedicated bank employee oversight for SLA monitoring, regulatory compliance, escalation management, and contract renewal. Banking operations assign relationshi',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Administrator BIC for payment instructions, SWIFT messaging, and cash management. Critical for subscription/redemption settlement and expense payments.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Administrator domicile affects regulatory oversight, service provider due diligence, and operational risk assessment. Required for vendor management and audit.',
    `fund_id` BIGINT COMMENT 'Reference to the fund being serviced by this administrator.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Administrator LEI for regulatory reporting (SFTR, MiFID II), service provider identification, and legal entity verification. Regulatory mandate for counterparty identification.',
    `lead_fund_administrator_id` BIGINT COMMENT 'Self-referencing FK on fund_administrator (lead_fund_administrator_id)',
    `administrator_name` STRING COMMENT 'The full legal name of the fund administration service provider organization.',
    `administrator_type` STRING COMMENT 'Classification of the service provider role in the funds operational infrastructure.. Valid values are `fund_administrator|transfer_agent|custodian|prime_broker|auditor|legal_counsel`',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'The annual base fee charged by the administrator for fund administration services.',
    `audit_opinion` STRING COMMENT 'The opinion issued in the most recent operational audit report of the administrator.. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `aum_fee_basis_points` DECIMAL(18,2) COMMENT 'The fee rate expressed in basis points charged as a percentage of fund assets under management.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of the contract term unless terminated.',
    `business_address_line1` STRING COMMENT 'The first line of the administrators primary business address.',
    `business_address_line2` STRING COMMENT 'The second line of the administrators primary business address (suite, floor, building).',
    `business_city` STRING COMMENT 'The city where the administrators primary business office is located.',
    `business_postal_code` STRING COMMENT 'The postal or ZIP code of the administrators primary business address.',
    `business_state_province` STRING COMMENT 'The state or province where the administrators primary business office is located.',
    `contract_end_date` DATE COMMENT 'The date when the fund administration service contract expires or terminates. Null for open-ended contracts.',
    `contract_start_date` DATE COMMENT 'The date when the fund administration service contract becomes effective.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the fund administration service contract.. Valid values are `active|pending|suspended|terminated|expired|renewal`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund administrator relationship record was first created in the system.',
    `escalation_contact_email` STRING COMMENT 'The email address of the escalation contact person at the administrator.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_name` STRING COMMENT 'The name of the senior contact person at the administrator for escalation of critical issues or service failures.',
    `fee_calculation_method` STRING COMMENT 'Description of how administrator fees are calculated (e.g., percentage of AUM, fixed annual fee, per-transaction pricing, tiered structure).',
    `fee_currency_code` STRING COMMENT 'The currency in which administrator fees are denominated and paid, using ISO 4217 three-letter currency code.. Valid values are `^[A-Z]{3}$`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The amount of professional indemnity or errors and omissions insurance coverage maintained by the administrator.',
    `insurance_currency_code` STRING COMMENT 'The currency in which the administrators insurance coverage is denominated, using ISO 4217 three-letter currency code.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction` STRING COMMENT 'The primary legal jurisdiction where the administrator is domiciled and regulated, using ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `last_audit_date` DATE COMMENT 'The date of the most recent SOC 1 Type II or equivalent operational audit of the administrators controls and processes.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance review of the administrators service delivery.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund administrator relationship record was last modified.',
    `nav_calculation_deadline_time` TIMESTAMP COMMENT 'The contractual time by which the administrator must complete daily NAV calculation and reporting.',
    `payment_frequency` STRING COMMENT 'The frequency at which administrator fees are invoiced and paid.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `performance_rating` STRING COMMENT 'Internal performance rating of the administrator based on service quality, timeliness, accuracy, and responsiveness.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary contact person at the administrator for operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary relationship manager or contact person at the administrator for operational matters.',
    `primary_contact_phone` STRING COMMENT 'The telephone number of the primary contact person at the administrator for urgent operational matters.',
    `regulatory_authority` STRING COMMENT 'The name of the regulatory body that oversees and licenses the fund administrator (e.g., SEC, FCA, FINMA, MAS).',
    `regulatory_authorization_number` STRING COMMENT 'The license or registration number issued by the relevant regulatory authority authorizing the administrator to provide fund services.',
    `service_scope` STRING COMMENT 'Detailed description of the services provided by the administrator, including NAV calculation, fund accounting, investor servicing, regulatory reporting, and other operational functions.',
    `sla_terms` STRING COMMENT 'Detailed service level agreement terms including NAV calculation deadlines, reporting timelines, error resolution commitments, and performance guarantees.',
    `soc_report_type` STRING COMMENT 'The type of service organization control report provided by the administrator to evidence operational controls.. Valid values are `SOC_1_Type_I|SOC_1_Type_II|SOC_2_Type_I|SOC_2_Type_II|ISAE_3402`',
    `termination_notice_days` STRING COMMENT 'The number of days advance notice required by either party to terminate the fund administration service contract.',
    CONSTRAINT pk_fund_administrator PRIMARY KEY(`fund_administrator_id`)
) COMMENT 'Master record for fund administration service provider relationships. Captures administrator name, administrator type (fund administrator, transfer agent, custodian, prime broker, auditor, legal counsel), service scope, contract start date, contract end date, SLA terms, regulatory authorization details, jurisdiction, and primary contact. Tracks all third-party service providers engaged in the funds operational infrastructure.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_benchmark` (
    `fund_benchmark_id` BIGINT COMMENT 'Unique identifier for the fund benchmark association record.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Fund benchmarks must reference the master benchmark definition for return calculation, performance attribution, and hurdle rate determination. Direct lookup relationship required for accurate performa',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund class (share class) to which this benchmark applies. Nullable if the benchmark applies at the fund level rather than class level.',
    `fund_id` BIGINT COMMENT 'Reference to the fund to which this benchmark is assigned.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Performance benchmark (SOFR, SONIA, MSCI World) for relative return calculation, tracking error monitoring, and investment mandate compliance. Core requirement for performance attribution.',
    `superseded_by_benchmark_fund_benchmark_id` BIGINT COMMENT 'Reference to the fund_benchmark_id that replaces this benchmark assignment. Populated when benchmark_status is superseded. Enables tracking of benchmark change history.',
    `previous_fund_benchmark_id` BIGINT COMMENT 'Self-referencing FK on fund_benchmark (previous_fund_benchmark_id)',
    `approval_date` DATE COMMENT 'Date on which the benchmark assignment was formally approved by the governing authority.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this benchmark assignment (e.g., Investment Committee, Board of Directors, Chief Investment Officer).',
    `assignment_reason` STRING COMMENT 'Business rationale for assigning this benchmark to the fund or fund class (e.g., investment strategy alignment, investor request, regulatory requirement, board decision, benchmark change due to index discontinuation).',
    `benchmark_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the benchmark is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `benchmark_methodology_description` STRING COMMENT 'Brief description of the benchmark construction methodology, including weighting scheme (market-cap weighted, equal-weighted, factor-based), rebalancing frequency, and constituent selection criteria.',
    `benchmark_provider` STRING COMMENT 'Name of the organization that publishes and maintains the benchmark index (e.g., S&P Dow Jones Indices, MSCI Inc., FTSE Russell, Bloomberg).',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of the benchmark assignment: active (currently in use), inactive (temporarily suspended), pending (approved but not yet effective), superseded (replaced by a newer benchmark), or discontinued (permanently retired).. Valid values are `active|inactive|pending|superseded|discontinued`',
    `benchmark_type` STRING COMMENT 'Classification of the benchmark role: primary (main performance comparison), secondary (supplemental comparison), absolute return hurdle (minimum return threshold for performance fees), composite (blended benchmark), custom (client-specific), or peer group (universe comparison).. Valid values are `primary|secondary|absolute_return_hurdle|composite|custom|peer_group`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark assignment record was first created in the system.',
    `data_source` STRING COMMENT 'System or vendor from which benchmark return data is sourced (e.g., Bloomberg, FactSet, MSCI Direct, internal calculation). Critical for data lineage and reconciliation.',
    `effective_date` DATE COMMENT 'Date from which this benchmark assignment becomes effective for performance measurement and reporting purposes.',
    `high_water_mark_flag` BOOLEAN COMMENT 'Indicates whether performance fees are subject to a high water mark provision, meaning fees are only charged on net new profits above the highest previous Net Asset Value (NAV). Applicable when performance_fee_applicable_flag is true.',
    `hurdle_rate_percentage` DECIMAL(18,2) COMMENT 'Minimum return threshold (expressed as annualized percentage) that the fund must exceed before performance fees are charged. Applicable only when benchmark_type is absolute_return_hurdle. Null for market index benchmarks.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the benchmark appropriateness by the investment committee or board. Regulatory best practice requires annual benchmark reviews.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark assignment record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of benchmark appropriateness. Typically annual or as specified in fund governance policies.',
    `performance_fee_applicable_flag` BOOLEAN COMMENT 'Indicates whether this benchmark is used to calculate performance-based fees (incentive fees, carried interest). True if the fund charges performance fees based on outperformance versus this benchmark.',
    `prospectus_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this benchmark is disclosed in the fund prospectus or offering documents as the primary or supplemental performance comparison index.',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the benchmark index is reconstituted or rebalanced (e.g., quarterly for most equity indices, monthly for some bond indices).. Valid values are `daily|monthly|quarterly|semi_annually|annually|event_driven`',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether performance relative to this benchmark must be reported to regulatory authorities (e.g., SEC Form N-PORT, UCITS KIID).',
    `return_calculation_method` STRING COMMENT 'Method by which benchmark returns are calculated: total return (includes dividends reinvested), price return (capital appreciation only), net return (after withholding taxes), or gross return (before taxes).. Valid values are `total_return|price_return|net_return|gross_return`',
    `termination_date` DATE COMMENT 'Date on which this benchmark assignment ceases to be effective. Null if the benchmark is currently active.',
    `tracking_error_tolerance_bps` STRING COMMENT 'Maximum acceptable tracking error (standard deviation of the difference between fund returns and benchmark returns) expressed in basis points. Used for index funds and passive strategies to monitor replication quality.',
    `usage_context` STRING COMMENT 'Primary purpose for which this benchmark is used: performance fee calculation (determines incentive fees), IPS mandate (Investment Policy Statement compliance), investor reporting (client communications), regulatory filing (Form N-1A, UCITS KIID), marketing material (prospectus, factsheets), or risk attribution (portfolio analytics).. Valid values are `performance_fee_calculation|ips_mandate|investor_reporting|regulatory_filing|marketing_material|risk_attribution`',
    `weighting_percentage` DECIMAL(18,2) COMMENT 'Percentage weight of this benchmark in a composite or blended benchmark structure. For single benchmarks, this is 100.00. For composite benchmarks, the sum of all benchmark weights for a given fund/class should equal 100.00.',
    CONSTRAINT pk_fund_benchmark PRIMARY KEY(`fund_benchmark_id`)
) COMMENT 'Association record linking funds and fund classes to their designated performance benchmarks and hurdle rates. Captures benchmark type (primary, secondary, absolute return hurdle), benchmark identifier, benchmark name, benchmark currency, weighting, effective date, and usage context (performance fee calculation, IPS mandate, investor reporting). Distinct from the enterprise security.benchmark as this captures the fund-specific benchmark assignment and fee calculation parameters.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`transfer_agency_event` (
    `transfer_agency_event_id` BIGINT COMMENT 'Unique identifier for the transfer agency event record. Primary key for the transfer agency event log.',
    `broker_id` BIGINT COMMENT 'Identifier of the financial intermediary or distributor through which the transfer agency event was submitted.',
    `employee_id` BIGINT COMMENT 'Identifier of the transfer agency operator or system user who processed or initiated the event.',
    `fund_class_id` BIGINT COMMENT 'Identifier of the specific fund share class involved in the transfer agency event.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund for which the transfer agency event was processed.',
    `investor_account_id` BIGINT COMMENT 'Identifier of the investor account for which the transfer agency event was executed.',
    `order_id` BIGINT COMMENT 'Identifier of the investor order that triggered this transfer agency event, if applicable.',
    `parent_event_transfer_agency_event_id` BIGINT COMMENT 'Identifier of the parent transfer agency event if this event is part of a multi-step process.',
    `primary_original_event_transfer_agency_event_id` BIGINT COMMENT 'Identifier of the original transfer agency event that is being reversed or corrected by this event.',
    `previous_transfer_agency_event_id` BIGINT COMMENT 'Self-referencing FK on transfer_agency_event (previous_transfer_agency_event_id)',
    `aml_clearance_status` STRING COMMENT 'Status of the AML screening and clearance process for this transfer agency event.. Valid values are `pending|cleared|flagged|rejected|under_review`',
    `aml_clearance_timestamp` TIMESTAMP COMMENT 'Date and time when AML clearance was completed for this transfer agency event.',
    `confirmation_number` STRING COMMENT 'Unique confirmation number issued to the investor for this transfer agency transaction.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer agency event record was first created in the system.',
    `event_notes` STRING COMMENT 'Free-text notes or comments recorded by transfer agency operators regarding this event.',
    `event_reference_number` STRING COMMENT 'Unique business reference number assigned to the transfer agency event for tracking and audit purposes.',
    `event_sequence_number` STRING COMMENT 'Sequential number indicating the order of this event within a related series of transfer agency events.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the transfer agency event occurred in the processing workflow.',
    `event_type` STRING COMMENT 'Type of transfer agency processing activity captured in this event log entry. [ENUM-REF-CANDIDATE: order_receipt|aml_clearance|nav_application|unit_allotment|unit_cancellation|settlement_confirmation|register_update|statement_generation|redemption_processing|exchange_processing|dividend_reinvestment|systematic_withdrawal — 12 candidates stripped; promote to reference product]',
    `exception_code` STRING COMMENT 'Standardized code identifying the type of exception encountered during processing.',
    `exception_flag` BOOLEAN COMMENT 'Indicator of whether an exception occurred during the processing of this transfer agency event.',
    `exception_reason` STRING COMMENT 'Detailed description of the exception or error that occurred during transfer agency event processing.',
    `kyc_verification_status` STRING COMMENT 'Status of the KYC verification for the investor account at the time of the transfer agency event.. Valid values are `verified|pending|failed|expired`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer agency event record was last modified or updated.',
    `nav_date` DATE COMMENT 'Date of the NAV used for pricing the transaction in this transfer agency event.',
    `nav_per_unit` DECIMAL(18,2) COMMENT 'Net asset value per unit applied to the transaction in this transfer agency event.',
    `order_type` STRING COMMENT 'Type of investor order being processed in this transfer agency event. [ENUM-REF-CANDIDATE: subscription|redemption|exchange|transfer|dividend_reinvestment|systematic_investment|systematic_withdrawal — 7 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'Method used for payment or settlement of funds in this transfer agency event.. Valid values are `ach|wire|check|electronic_funds_transfer`',
    `processing_date` DATE COMMENT 'Business date on which the transfer agency event was processed, used for NAV application and accounting purposes.',
    `processing_priority` STRING COMMENT 'Priority level assigned to this transfer agency event for processing queue management.. Valid values are `high|normal|low`',
    `processing_status` STRING COMMENT 'Current status of the transfer agency event in the processing lifecycle. [ENUM-REF-CANDIDATE: initiated|pending|in_progress|completed|failed|cancelled|suspended|rejected — 8 candidates stripped; promote to reference product]',
    `register_update_timestamp` TIMESTAMP COMMENT 'Date and time when the fund register was updated as a result of this transfer agency event.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this transfer agency event represents a reversal or correction of a previous event.',
    `settlement_date` DATE COMMENT 'Date on which the transfer agency transaction is scheduled to settle or has settled.',
    `settlement_status` STRING COMMENT 'Status of the settlement process for the transfer agency event.. Valid values are `pending|settled|failed|cancelled`',
    `source_system` STRING COMMENT 'Name or identifier of the source system that originated or recorded this transfer agency event.',
    `statement_generation_flag` BOOLEAN COMMENT 'Indicator of whether an investor statement was generated as a result of this transfer agency event.',
    `statement_generation_timestamp` TIMESTAMP COMMENT 'Date and time when the investor statement was generated for this transfer agency event.',
    `stp_indicator` BOOLEAN COMMENT 'Flag indicating whether the transfer agency event was processed automatically without manual intervention.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction being processed in the transfer agency event.',
    `transaction_currency` STRING COMMENT 'Three-letter ISO currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `unit_quantity` DECIMAL(18,2) COMMENT 'Number of fund units or shares involved in the transfer agency event.',
    CONSTRAINT pk_transfer_agency_event PRIMARY KEY(`transfer_agency_event_id`)
) COMMENT 'Operational event log for all transfer agency processing activities including order receipt, AML clearance, NAV application, unit allotment/cancellation, settlement confirmation, register update, and investor statement generation. Captures event type, event timestamp, investor account, fund class, processing status, exception flag, exception reason, STP indicator, and operator ID. Provides the complete audit trail for investor servicing operations.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_fee_schedule` (
    `fund_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fund fee schedule record. Primary key for this entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee calculation currency for management fees, performance fees, and expense accruals. Required for multi-currency fee billing and TER calculation.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund class (share class) to which this fee schedule applies. Different share classes within the same fund may have different fee structures.',
    `fund_id` BIGINT COMMENT 'Reference to the fund to which this fee schedule applies.',
    `superseded_by_schedule_fund_fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule that supersedes this one. Null if this is the current active schedule.',
    `previous_fund_fee_schedule_id` BIGINT COMMENT 'Self-referencing FK on fund_fee_schedule (previous_fund_fee_schedule_id)',
    `approval_date` DATE COMMENT 'Date on which this fee schedule was approved by the fund board or authorized committee.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this fee schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was first created in the system.',
    `crystallization_frequency` STRING COMMENT 'Frequency at which performance fees are calculated and locked in (crystallized). Determines when performance fee liability becomes payable.. Valid values are `daily|monthly|quarterly|annually|at_redemption`',
    `effective_date` DATE COMMENT 'Date from which this fee schedule becomes applicable for fee calculations and investor billing.',
    `entry_load_rate` DECIMAL(18,2) COMMENT 'Front-end load fee charged when an investor subscribes to the fund, expressed as a percentage of the subscription amount. Also known as initial charge or sales load.',
    `entry_load_type` STRING COMMENT 'Structure of the entry load fee. Flat: single rate for all subscriptions. Tiered: rate varies by subscription amount. Waived: no entry load charged.. Valid values are `flat|tiered|waived`',
    `exit_load_holding_period_days` STRING COMMENT 'Number of days an investor must hold the investment before the exit load is reduced or waived. Used to determine applicable exit load tier.',
    `exit_load_rate` DECIMAL(18,2) COMMENT 'Back-end load fee charged when an investor redeems from the fund, expressed as a percentage of the redemption amount. May vary based on holding period.',
    `expiry_date` DATE COMMENT 'Date on which this fee schedule ceases to be applicable. Null indicates an open-ended schedule.',
    `fee_calculation_method` STRING COMMENT 'Methodology used to calculate and accrue fees. Defines the frequency and timing of fee calculations for Net Asset Value (NAV) computation.. Valid values are `daily_accrual|monthly_accrual|quarterly_accrual|annual_accrual`',
    `fee_payment_frequency` STRING COMMENT 'Frequency at which accrued fees are paid to the fund manager or service provider.. Valid values are `daily|monthly|quarterly|semi_annually|annually`',
    `fee_schedule_code` STRING COMMENT 'Business identifier code for this fee schedule, used for operational reference and reporting.',
    `fee_schedule_name` STRING COMMENT 'Descriptive name of the fee schedule, typically indicating the share class and fee structure type.',
    `fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule indicating whether it is currently in use, pending activation, or has been superseded.. Valid values are `active|inactive|pending|superseded`',
    `high_water_mark_flag` BOOLEAN COMMENT 'Indicates whether a high water mark provision applies. When true, performance fees are only charged on net new profits above the highest previous Net Asset Value (NAV) level.',
    `hurdle_rate` DECIMAL(18,2) COMMENT 'Minimum rate of return that must be achieved before performance fees are charged. Expressed as an annual percentage rate.',
    `hurdle_type` STRING COMMENT 'Type of hurdle rate application. Hard hurdle: performance fee applies only to returns above the hurdle. Soft hurdle: performance fee applies to all returns once hurdle is exceeded.. Valid values are `hard|soft|none`',
    `management_fee_basis` STRING COMMENT 'The base amount on which the management fee is calculated, such as total Assets Under Management (AUM), Net Asset Value (NAV), committed capital, or invested capital.. Valid values are `aum|nav|committed_capital|invested_capital`',
    `management_fee_rate` DECIMAL(18,2) COMMENT 'Annual management fee rate expressed as a decimal percentage of Assets Under Management (AUM). Used in Net Asset Value (NAV) calculation and fee accrual.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or explanations related to this fee schedule.',
    `performance_fee_rate` DECIMAL(18,2) COMMENT 'Performance fee rate (also known as incentive fee or carried interest) expressed as a decimal percentage of profits above the hurdle rate. Typically applies to hedge funds and private equity funds.',
    `prospectus_reference` STRING COMMENT 'Reference to the section or page in the fund prospectus where this fee schedule is disclosed to investors.',
    `recoupment_eligible_flag` BOOLEAN COMMENT 'Indicates whether waived fees are eligible for recoupment (recovery) by the fund manager in future periods when expenses fall below the cap.',
    `recoupment_period_months` STRING COMMENT 'Number of months during which waived fees remain eligible for recoupment by the fund manager.',
    `redemption_fee_rate` DECIMAL(18,2) COMMENT 'Fee charged on redemptions to discourage short-term trading and protect long-term investors. Typically retained by the fund rather than paid to the manager. Expressed as a percentage of redemption amount.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the fee schedule for compliance and reporting purposes, such as UCITS-compliant, 40 Act compliant, or AIFMD-compliant.',
    `switching_fee_rate` DECIMAL(18,2) COMMENT 'Fee charged when an investor switches between different funds or share classes within the same fund family. Expressed as a percentage of the switched amount.',
    `ter_cap` DECIMAL(18,2) COMMENT 'Maximum Total Expense Ratio (TER) that can be charged to investors, expressed as an annual percentage. Any expenses above this cap are absorbed by the fund manager.',
    `version_number` STRING COMMENT 'Version number of this fee schedule, incremented when the schedule is amended. Supports fee schedule change history and audit trail.',
    `waiver_expiry_date` DATE COMMENT 'Date on which the fee waiver expires and full fees resume. Null if no waiver is in effect or waiver is indefinite.',
    `waiver_flag` BOOLEAN COMMENT 'Indicates whether the fund manager has voluntarily waived or reduced fees for this schedule. Common during fund launch periods or for strategic investor classes.',
    CONSTRAINT pk_fund_fee_schedule PRIMARY KEY(`fund_fee_schedule_id`)
) COMMENT 'Reference master defining the fee structure and calculation methodology for each fund class. Captures management fee rate, performance fee rate, hurdle rate, high-water mark flag, crystallization frequency, entry load schedule, exit load schedule (with holding period tiers), redemption fee, switching fee, TER cap, and fee currency. Serves as the authoritative reference for fee accrual calculations in NAV computation and investor billing.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_distribution_channel` (
    `fund_distribution_channel_id` BIGINT COMMENT 'Unique identifier for the fund distribution channel relationship record. Primary key for this entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Distributor compensation currency for commission payments, trailer fees, and retrocession. Required for multi-currency distribution agreements and payment processing.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Distributors are legal entities (parties) requiring KYC/AML screening, regulatory approval tracking, commission payment processing, and relationship management. Links distribution agreements to corpor',
    `fund_id` BIGINT COMMENT 'Reference to the fund being distributed through this channel. Links to the fund master record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Distribution channels require dedicated relationship managers (bank employees) for sales target monitoring, commission reconciliation, regulatory compliance oversight, and distributor performance mana',
    `previous_fund_distribution_channel_id` BIGINT COMMENT 'Self-referencing FK on fund_distribution_channel (previous_fund_distribution_channel_id)',
    `agreement_effective_date` DATE COMMENT 'The date when the distribution agreement becomes legally effective and the distributor is authorized to sell fund units.',
    `agreement_expiry_date` DATE COMMENT 'The date when the distribution agreement expires or terminates. Null for open-ended agreements.',
    `aml_responsibility` STRING COMMENT 'Indicates which party is responsible for Anti-Money Laundering (AML) monitoring and compliance for transactions through this channel.. Valid values are `distributor|fund_administrator|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this distribution channel record was first created in the system.',
    `distribution_agreement_reference` STRING COMMENT 'Reference number or identifier for the legal distribution agreement governing this channel relationship.',
    `distribution_status` STRING COMMENT 'Current operational status of the distribution channel relationship. Indicates whether the distributor is actively authorized to sell fund units.. Valid values are `active|suspended|terminated|pending_approval|inactive`',
    `distributor_identifier` STRING COMMENT 'Unique business identifier for the distributor, such as Legal Entity Identifier (LEI), FINRA CRD number, or internal distributor code.',
    `distributor_type` STRING COMMENT 'Classification of the distributor channel type. IFA = Independent Financial Advisor, RIA = Registered Investment Advisor. [ENUM-REF-CANDIDATE: IFA|bank|platform|insurance_wrapper|direct|broker_dealer|RIA — 7 candidates stripped; promote to reference product]',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this distributor has exclusive distribution rights for the fund in the specified geographic scope or investor segment.',
    `geographic_scope` STRING COMMENT 'The geographic regions or countries where this distributor is authorized to sell the fund. Comma-separated list of ISO 3166-1 alpha-3 country codes or regional descriptors.',
    `investor_segment_served` STRING COMMENT 'The target investor segment that this distribution channel serves. HNWI = High Net Worth Individual.. Valid values are `retail|institutional|HNWI|mass_affluent|accredited|qualified_purchaser`',
    `kyc_responsibility` STRING COMMENT 'Indicates which party is responsible for conducting Know Your Customer (KYC) due diligence on end investors in this distribution channel.. Valid values are `distributor|fund_administrator|shared`',
    `last_review_date` DATE COMMENT 'The date when this distribution channel relationship was last reviewed for compliance, performance, and ongoing suitability.',
    `marketing_support_provided` STRING COMMENT 'The level of marketing and promotional support provided by the fund manager to this distribution channel.. Valid values are `full|limited|none`',
    `minimum_investment_amount` DECIMAL(18,2) COMMENT 'The minimum initial investment amount required for subscriptions through this distribution channel, in the fund base currency.',
    `modified_by` STRING COMMENT 'The user identifier or system account that last modified this distribution channel record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this distribution channel record was last modified in the system.',
    `next_review_date` DATE COMMENT 'The date when the next periodic review of this distribution channel relationship is scheduled.',
    `notes` STRING COMMENT 'Free-text notes capturing additional details, special arrangements, or historical context for this distribution channel relationship.',
    `omnibus_account_flag` BOOLEAN COMMENT 'Indicates whether this distributor uses an omnibus account structure where the distributor holds fund units on behalf of multiple underlying investors.',
    `payment_frequency` STRING COMMENT 'The frequency at which trailer fees and commissions are paid to the distributor.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `platform_code` STRING COMMENT 'The platform or system code used by the distributor for fund identification and transaction processing. May include multiple codes separated by semicolons.',
    `regulatory_approval_date` DATE COMMENT 'The date when regulatory approval was granted for this distribution channel arrangement, if applicable.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether regulatory approval is required for this distribution arrangement in the applicable jurisdiction.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or jurisdiction governing this distribution arrangement, such as SEC, FCA, ESMA, or specific country regulators.',
    `retrocession_arrangement` STRING COMMENT 'The type of retrocession or fee-sharing arrangement in place. Describes how distribution fees are paid back to the intermediary.. Valid values are `direct_payment|fee_sharing|rebate|none`',
    `sales_volume_target` DECIMAL(18,2) COMMENT 'The target sales volume or Assets Under Management (AUM) goal for this distribution channel, in the fund base currency.',
    `sub_accounting_agreement_flag` BOOLEAN COMMENT 'Indicates whether a sub-accounting agreement is in place where the distributor maintains detailed investor records on behalf of the fund.',
    `termination_notice_period_days` STRING COMMENT 'The number of days advance notice required by either party to terminate the distribution agreement.',
    `trailer_fee_rate` DECIMAL(18,2) COMMENT 'The ongoing annual trailer fee or commission rate paid to the distributor, expressed as a percentage of Assets Under Management (AUM). Also known as 12b-1 fee in US context.',
    `upfront_commission_rate` DECIMAL(18,2) COMMENT 'The initial sales commission rate paid to the distributor at the point of sale, expressed as a percentage of the subscription amount.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this distribution channel record.',
    CONSTRAINT pk_fund_distribution_channel PRIMARY KEY(`fund_distribution_channel_id`)
) COMMENT 'Master record for fund distribution channel relationships and agreements. Captures distributor name, distributor type (IFA, bank, platform, insurance wrapper, direct), distribution agreement reference, trailer fee rate, retrocession arrangement, geographic scope, investor segment served, platform codes, and distribution status. Tracks the network of intermediaries through which fund units are sold to end investors.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_audit` (
    `fund_audit_id` BIGINT COMMENT 'Unique identifier for the fund audit engagement record. Primary key for the fund audit entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fund audits cover fiscal year-end periods aligned with accounting period structure. Required for audit planning, scope definition, and linking audit findings to specific reporting periods.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Audit fee currency for expense accounting, vendor payment, and TER calculation. Required for multi-currency audit engagement management.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Fund audits require internal bank employee coordination for audit committee reporting, regulatory filing oversight, management letter response, and remediation tracking. Controllers or compliance offi',
    `fund_id` BIGINT COMMENT 'Reference to the fund being audited. Links to the fund master record.',
    `previous_fund_audit_id` BIGINT COMMENT 'Self-referencing FK on fund_audit (previous_fund_audit_id)',
    `audit_committee_approval_date` DATE COMMENT 'Date when the funds audit committee reviewed and approved the audit report and financial statements.',
    `audit_documentation_retention_date` DATE COMMENT 'Date through which audit documentation and working papers must be retained per regulatory requirements (typically 7 years from report date).',
    `audit_engagement_number` STRING COMMENT 'External reference number assigned by the audit firm to this engagement. Used for tracking and correspondence with the auditor.',
    `audit_fee_amount` DECIMAL(18,2) COMMENT 'Total fee charged by the audit firm for the engagement, including all professional services rendered.',
    `audit_firm_name` STRING COMMENT 'Name of the external audit firm conducting the fund audit. Must be a registered public accounting firm.',
    `audit_firm_registration_number` STRING COMMENT 'Registration or license number of the audit firm with the relevant regulatory authority (e.g., PCAOB registration number).',
    `audit_opinion_type` STRING COMMENT 'The type of opinion issued by the auditor. Unqualified (clean) opinion indicates financial statements are fairly presented; qualified opinion indicates exceptions; adverse opinion indicates material misstatements; disclaimer indicates inability to form an opinion.. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `audit_period_end_date` DATE COMMENT 'The ending date of the period covered by this audit engagement.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the period covered by this audit engagement.',
    `audit_report_date` DATE COMMENT 'Date when the auditors report was signed and issued. This is the date through which the auditor has responsibility for subsequent events.',
    `audit_scope` STRING COMMENT 'Description of the scope and boundaries of the audit engagement, including what financial statements, periods, and areas are covered.',
    `audit_status` STRING COMMENT 'Current status of the audit engagement in its lifecycle. Tracks progression from planning through final filing.. Valid values are `planned|in_progress|fieldwork_complete|report_draft|report_issued|filed`',
    `audit_type` STRING COMMENT 'Classification of the audit engagement. Annual statutory audits are required by regulation; interim reviews provide limited assurance; special purpose audits address specific matters; agreed-upon procedures perform specific tests; compliance audits verify regulatory adherence.. Valid values are `annual_statutory|interim_review|special_purpose|agreed_upon_procedures|compliance_audit`',
    `board_approval_date` DATE COMMENT 'Date when the funds board of directors formally approved the audited financial statements for publication and filing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund audit record was first created in the system.',
    `engagement_partner_license_number` STRING COMMENT 'Professional license or certification number of the engagement partner (e.g., CPA license number).',
    `engagement_partner_name` STRING COMMENT 'Name of the lead audit partner responsible for the engagement. The partner signs the audit opinion.',
    `fieldwork_completion_date` DATE COMMENT 'Date when the audit fieldwork and testing procedures were completed.',
    `fieldwork_start_date` DATE COMMENT 'Date when the audit fieldwork and testing procedures commenced.',
    `fiscal_year_end_date` DATE COMMENT 'The fiscal year end date for which this audit is being conducted. Typically aligns with the funds fiscal year end.',
    `going_concern_flag` BOOLEAN COMMENT 'Indicates whether the auditor identified substantial doubt about the funds ability to continue as a going concern.',
    `key_audit_matters` STRING COMMENT 'Description of the key audit matters identified during the engagement. These are matters that required significant auditor attention and judgment.',
    `management_letter_issued_flag` BOOLEAN COMMENT 'Indicates whether the auditor issued a management letter with recommendations for operational improvements or control enhancements.',
    `management_letter_points` STRING COMMENT 'Summary of key points and recommendations included in the management letter, covering operational improvements, control enhancements, and best practice suggestions.',
    `material_weakness_description` STRING COMMENT 'Detailed description of any material weaknesses identified in internal controls, including the nature and potential impact.',
    `material_weakness_identified_flag` BOOLEAN COMMENT 'Indicates whether the auditor identified any material weaknesses in internal controls over financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund audit record was last modified or updated.',
    `opinion_basis` STRING COMMENT 'Detailed explanation of the basis for the auditors opinion, including any qualifications, limitations, or emphasis of matter paragraphs.',
    `regulatory_filing_date` DATE COMMENT 'Date when the audited financial statements and audit report were filed with the regulatory authority.',
    `regulatory_filing_deadline_date` DATE COMMENT 'Regulatory deadline by which the audited financial statements must be filed to maintain compliance.',
    `regulatory_filing_form_type` STRING COMMENT 'Type of regulatory form used for filing the audit report (e.g., Form N-CSR for certified shareholder reports, Form 10-K for annual reports).',
    `regulatory_filing_reference_number` STRING COMMENT 'Reference or accession number assigned by the regulatory authority upon successful filing (e.g., SEC accession number).',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether the audit report must be filed with regulatory authorities such as the Securities and Exchange Commission (SEC).',
    `restatement_description` STRING COMMENT 'Description of the nature and impact of any financial statement restatements required as a result of the audit findings.',
    `restatement_required_flag` BOOLEAN COMMENT 'Indicates whether the audit identified errors requiring restatement of previously issued financial statements.',
    `significant_deficiency_count` STRING COMMENT 'Number of significant deficiencies in internal controls identified during the audit that are less severe than material weaknesses but still warrant attention.',
    `subsequent_events_review_date` DATE COMMENT 'Date through which the auditor reviewed subsequent events that may require adjustment or disclosure in the financial statements.',
    CONSTRAINT pk_fund_audit PRIMARY KEY(`fund_audit_id`)
) COMMENT 'Annual and interim fund audit record capturing the external audit engagement for each fund. Captures audit firm, audit type (annual statutory, interim, special purpose), audit period, engagement partner, audit opinion type (unqualified, qualified, adverse, disclaimer), audit report date, key audit matters identified, management letter points, and regulatory submission date. Supports fund governance, investor disclosure, and regulatory compliance.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`investor_statement` (
    `investor_statement_id` BIGINT COMMENT 'Unique identifier for the investor statement record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Investor statements issued for specific accounting periods (quarterly/annual) must reconcile to NAV and financial statements. Required for investor reporting and regulatory disclosure requirements.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Statement values in investors preferred currency for client servicing and reporting. Required for multi-currency investor communication and regulatory disclosure.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund class or share class for this statement.',
    `fund_id` BIGINT COMMENT 'Reference to the fund associated with this investor statement.',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account for which this statement was generated.',
    `party_id` BIGINT COMMENT 'Reference to the transfer agent responsible for generating and issuing this statement.',
    `previous_investor_statement_id` BIGINT COMMENT 'Self-referencing FK on investor_statement (previous_investor_statement_id)',
    `capital_gains_long_term` DECIMAL(18,2) COMMENT 'Long-term capital gains distributed to the investor during the statement period.',
    `capital_gains_short_term` DECIMAL(18,2) COMMENT 'Short-term capital gains distributed to the investor during the statement period.',
    `closing_nav_per_unit` DECIMAL(18,2) COMMENT 'Net Asset Value per unit at the end of the statement period.',
    `closing_unit_balance` DECIMAL(18,2) COMMENT 'Number of fund units or shares held by the investor at the end of the statement period.',
    `closing_value` DECIMAL(18,2) COMMENT 'Total market value of the investors holdings at the end of the statement period (closing units × closing NAV).',
    `confirmation_number` STRING COMMENT 'Unique confirmation or tracking number for statement delivery and audit purposes.',
    `delivery_address` STRING COMMENT 'Email address or postal address to which the statement was delivered.',
    `delivery_method` STRING COMMENT 'Method by which the statement was delivered to the investor.. Valid values are `email|postal_mail|online_portal|courier`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the statement was successfully delivered to the investor.',
    `fees_deducted` DECIMAL(18,2) COMMENT 'Total fees charged to the investor account during the statement period, including management fees, performance fees, and administrative charges.',
    `generated_timestamp` TIMESTAMP COMMENT 'Date and time when the statement record was created in the system.',
    `income_received` DECIMAL(18,2) COMMENT 'Total income allocated to the investor account during the statement period, including dividends and interest.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the statement record was last updated or reissued.',
    `opening_nav_per_unit` DECIMAL(18,2) COMMENT 'Net Asset Value per unit at the beginning of the statement period.',
    `opening_unit_balance` DECIMAL(18,2) COMMENT 'Number of fund units or shares held by the investor at the beginning of the statement period.',
    `opening_value` DECIMAL(18,2) COMMENT 'Total market value of the investors holdings at the beginning of the statement period (opening units × opening NAV).',
    `ordinary_dividend_amount` DECIMAL(18,2) COMMENT 'Portion of distributions classified as ordinary dividends for tax reporting purposes.',
    `qualified_dividend_amount` DECIMAL(18,2) COMMENT 'Portion of distributions that qualify for preferential tax treatment as qualified dividends.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Actual gains or losses realized from redemption transactions during the statement period.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this statement is subject to regulatory reporting requirements such as FATCA or CRS.',
    `statement_date` DATE COMMENT 'The official date on which the statement was generated and issued to the investor.',
    `statement_format` STRING COMMENT 'File format in which the statement was generated and delivered.. Valid values are `pdf|html|xml|csv`',
    `statement_number` STRING COMMENT 'Unique business identifier for the statement, typically sequential or formatted per transfer agent conventions.',
    `statement_period_end_date` DATE COMMENT 'The last date of the reporting period covered by this statement.',
    `statement_period_start_date` DATE COMMENT 'The first date of the reporting period covered by this statement.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the investor statement.. Valid values are `draft|issued|delivered|reissued|cancelled`',
    `tax_form_reference` STRING COMMENT 'Reference to associated tax forms such as Form 1099-DIV, 1099-B, or equivalent international tax documents.',
    `tax_year` STRING COMMENT 'Tax year to which this statement applies for regulatory and tax reporting purposes.',
    `total_distributions_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all distributions paid or reinvested during the statement period.',
    `total_distributions_units` DECIMAL(18,2) COMMENT 'Total number of fund units issued as distributions (reinvestments) during the statement period.',
    `total_redemptions_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all redemption transactions during the statement period.',
    `total_redemptions_units` DECIMAL(18,2) COMMENT 'Total number of fund units redeemed by the investor during the statement period.',
    `total_subscriptions_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all subscription transactions during the statement period.',
    `total_subscriptions_units` DECIMAL(18,2) COMMENT 'Total number of fund units purchased by the investor during the statement period.',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'Change in market value of holdings during the statement period, excluding transactions (closing value - opening value - net transactions).',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Total tax withheld from distributions during the statement period for regulatory compliance.',
    CONSTRAINT pk_investor_statement PRIMARY KEY(`investor_statement_id`)
) COMMENT 'Periodic investor account statement record generated by the transfer agency for each investor account. Captures statement period, statement date, opening unit balance, closing unit balance, opening value, closing value, transactions during period (subscriptions, redemptions, distributions), income received, fees deducted, unrealized gain/loss, and delivery method (email, post, portal). Serves as the formal investor communication and tax document.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` (
    `fund_valuation_adjustment_id` BIGINT COMMENT 'Unique identifier for the fund valuation adjustment record. Primary key for this entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Swing pricing and dilution adjustments recorded in specific accounting periods for NAV impact and financial reporting. Required for period-end close and fair value accounting under IFRS 13.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Swing pricing/dilution adjustment currency for fair value adjustment and investor protection. Required for anti-dilution mechanism and NAV adjustment calculation.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this adjustment. Required for audit trail and regulatory compliance. Null for automated system approvals within pre-approved parameters.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund share class affected by this adjustment. Different share classes may have different adjustment treatments.',
    `fund_id` BIGINT COMMENT 'Reference to the fund to which this valuation adjustment applies. Links to the fund master record.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Swing pricing and dilution adjustments are triggered by specific illiquid holdings. Direct instrument link enables adjustment calculation based on position size, liquidity, and estimated trading costs',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Valuation adjustments generate journal entries to record NAV impact in general ledger. Required for audit trail, SOX controls, and reconciliation between fund accounting and GL.',
    `nav_record_id` BIGINT COMMENT 'Reference to the NAV calculation record to which this adjustment was applied. Links to the specific NAV calculation event.',
    `original_adjustment_fund_valuation_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment record that this entry reverses. Populated only when reversal_flag is true. Maintains audit trail for adjustment corrections.',
    `previous_fund_valuation_adjustment_id` BIGINT COMMENT 'Self-referencing FK on fund_valuation_adjustment (previous_fund_valuation_adjustment_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The absolute monetary amount of the adjustment applied to the NAV calculation. Positive values increase NAV; negative values decrease NAV. Expressed in the fund base currency.',
    `adjustment_basis` STRING COMMENT 'The calculation basis or methodology used to determine the adjustment amount. Net flow threshold triggers adjustment when net flows exceed a percentage of AUM; gross subscription/redemption bases adjustment on absolute flow amounts; asset illiquidity bases adjustment on portfolio liquidity profile; market volatility uses market conditions; trading cost estimate uses expected transaction costs.. Valid values are `net_flow_threshold|gross_subscription|gross_redemption|asset_illiquidity|market_volatility|trading_cost_estimate`',
    `adjustment_category` STRING COMMENT 'Business category indicating the trigger or reason for the adjustment. Subscription-driven adjustments protect against inflows; redemption-driven protect against outflows; market event adjustments respond to extraordinary market conditions; illiquid asset adjustments address valuation uncertainty; regulatory required adjustments comply with mandates; discretionary adjustments are management decisions.. Valid values are `subscription_driven|redemption_driven|market_event|illiquid_asset|regulatory_required|discretionary`',
    `adjustment_date` DATE COMMENT 'The valuation date on which this adjustment was applied to the fund NAV calculation. This is the business event date for the adjustment.',
    `adjustment_per_unit` DECIMAL(18,2) COMMENT 'The adjustment amount expressed per fund unit or share. This is the impact on the dealing NAV per unit for investors transacting on this valuation date.',
    `adjustment_percentage` DECIMAL(18,2) COMMENT 'The adjustment expressed as a percentage of NAV or transaction value. Used for swing pricing and dilution levy calculations. Positive percentages increase dealing NAV for subscriptions or decrease for redemptions.',
    `adjustment_reference_number` STRING COMMENT 'Business-assigned unique reference number for this valuation adjustment. Used for audit trail and external reporting.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment. Pending adjustments await approval; approved adjustments are authorized but not yet applied; applied adjustments are reflected in NAV; reversed adjustments have been unwound; rejected adjustments were not approved.. Valid values are `pending|approved|applied|reversed|rejected`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Precise date and time when the adjustment calculation was executed and applied to the NAV. Used for audit trail and sequencing of adjustments.',
    `adjustment_type` STRING COMMENT 'Classification of the valuation adjustment mechanism applied. Swing pricing adjusts NAV based on net flows; dilution levy charges incoming/outgoing investors; fair value adjustment corrects stale prices; side pocket segregates illiquid assets; liquidity adjustment reflects market liquidity conditions; anti-dilution levy protects existing investors from trading costs.. Valid values are `swing_pricing|dilution_levy|fair_value_adjustment|side_pocket|liquidity_adjustment|anti_dilution_levy`',
    `approval_authority` STRING COMMENT 'The role or authority level that approved this valuation adjustment. Automated system approvals occur when adjustments fall within pre-approved parameters; manual approvals required for discretionary or material adjustments.. Valid values are `fund_accountant|portfolio_manager|compliance_officer|board_of_directors|administrator|automated_system`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was formally approved. Required for audit trail and to establish the sequence of NAV calculation events.',
    `calculation_methodology` STRING COMMENT 'Detailed description of the mathematical formula or methodology used to calculate the adjustment amount. Includes references to swing pricing models, dilution levy schedules, or fair value adjustment techniques.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this adjustment record was first created in the database. Used for audit trail and data lineage tracking.',
    `dealing_nav_impact` DECIMAL(18,2) COMMENT 'The impact of this adjustment on the dealing NAV per unit used for investor subscriptions and redemptions. This is the NAV that transacting investors receive after adjustment application.',
    `disclosure_text` STRING COMMENT 'Standardized disclosure text describing the adjustment for inclusion in investor communications, fund fact sheets, and regulatory filings. Explains the adjustment mechanism and investor impact in plain language.',
    `estimated_trading_cost_bps` DECIMAL(18,2) COMMENT 'Estimated trading costs in basis points used to calculate the adjustment amount. Represents expected bid-ask spreads, market impact, and transaction fees for portfolio rebalancing.',
    `gross_redemption_amount` DECIMAL(18,2) COMMENT 'Total gross redemption amount on the adjustment date. Used to calculate dilution impact and determine adjustment magnitude for redemption-driven adjustments.',
    `gross_subscription_amount` DECIMAL(18,2) COMMENT 'Total gross subscription amount on the adjustment date. Used to calculate dilution impact and determine adjustment magnitude for subscription-driven adjustments.',
    `illiquid_asset_percentage` DECIMAL(18,2) COMMENT 'Percentage of fund portfolio classified as illiquid assets at the time of adjustment. Used to determine fair value adjustment magnitude and side pocket requirements.',
    `investor_protection_flag` BOOLEAN COMMENT 'Indicates whether this adjustment was applied specifically to protect existing investors from dilution caused by large subscriptions or redemptions. True for anti-dilution mechanisms; false for other adjustment types.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this adjustment record was last modified. Updated whenever any field in the record changes. Used for audit trail and change tracking.',
    `net_flow_amount` DECIMAL(18,2) COMMENT 'The actual net flow amount (subscriptions minus redemptions) on the adjustment date that contributed to triggering the adjustment. Expressed in fund base currency.',
    `net_flow_threshold_percentage` DECIMAL(18,2) COMMENT 'The net flow threshold percentage of Assets Under Management (AUM) that triggered the adjustment. Used in swing pricing mechanisms where adjustments activate when net flows exceed a defined percentage.',
    `notes` STRING COMMENT 'Free-text field for additional context, explanations, or special circumstances related to this adjustment. Used for audit trail and internal documentation.',
    `published_nav_impact` DECIMAL(18,2) COMMENT 'The impact of this adjustment on the published NAV per unit used for performance reporting and regulatory filings. May differ from dealing NAV if swing pricing is applied asymmetrically.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or rule under which this adjustment was made. Examples: SEC Rule 22e-4, ESMA Swing Pricing Guidelines, UCITS Directive, AIFMD.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this adjustment must be disclosed in regulatory filings or investor reports. Material adjustments typically require disclosure under SEC or ESMA rules.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment record represents a reversal of a previously applied adjustment. True for reversal entries; false for original adjustments.',
    `reversal_reason` STRING COMMENT 'Detailed explanation of why the original adjustment was reversed. Required for audit trail and regulatory compliance when adjustments are unwound.',
    `triggering_condition` STRING COMMENT 'Detailed description of the specific condition or threshold that triggered this adjustment. Examples: net redemptions exceeded 2% of AUM; illiquid asset position exceeded 15% of portfolio; market bid-ask spreads widened beyond 50 basis points.',
    CONSTRAINT pk_fund_valuation_adjustment PRIMARY KEY(`fund_valuation_adjustment_id`)
) COMMENT 'Record of fair value adjustments, swing pricing adjustments, and anti-dilution levies applied to fund NAV calculations. Captures adjustment type (swing pricing, dilution levy, fair value adjustment, side pocket), adjustment date, adjustment basis, adjustment amount or percentage, triggering condition (net flow threshold, illiquid asset event), approval authority, and impact on dealing NAV. Protects existing investors from dilution caused by large subscriptions or redemptions.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_switch` (
    `fund_switch_id` BIGINT COMMENT 'Unique identifier for the fund switch transaction. Primary key for the fund switch record.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Fund switches originate from specific channels (digital platform, relationship manager, contact center). Required for channel performance measurement, cross-sell tracking, and investor behavior analys',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Switch transaction currency for processing, FX conversion, and settlement. Required for multi-currency fund switching and transfer agency operations.',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account initiating the fund switch transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Fund switches generate journal entries for simultaneous redemption and subscription accounting across funds. Required for inter-fund transfer accounting, realized gain/loss recognition, and audit trai',
    `party_id` BIGINT COMMENT 'Reference to the financial intermediary or distributor through which the fund switch order was placed.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Switch settlement on valid business days per fund calendar. Critical for dealing deadline enforcement and transfer agency SLA compliance.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund class from which units are being redeemed in the switch transaction.',
    `fund_id` BIGINT COMMENT 'Reference to the fund from which units are being redeemed as part of the switch transaction.',
    `target_fund_class_id` BIGINT COMMENT 'Reference to the specific fund class into which proceeds are being reinvested in the switch transaction.',
    `target_fund_id` BIGINT COMMENT 'Reference to the fund into which proceeds are being reinvested as part of the switch transaction.',
    `transfer_agent_party_id` BIGINT COMMENT 'Reference to the transfer agent responsible for processing the fund switch transaction.',
    `previous_fund_switch_id` BIGINT COMMENT 'Self-referencing FK on fund_switch (previous_fund_switch_id)',
    `aml_check_status` STRING COMMENT 'Status of the Anti-Money Laundering compliance check performed on the fund switch transaction.. Valid values are `passed|failed|pending|not_required`',
    `confirmation_number` STRING COMMENT 'Unique confirmation reference number issued to the investor upon successful processing of the fund switch transaction.',
    `confirmation_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the fund switch confirmation was sent to the investor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fund switch transaction record was first created in the system.',
    `entry_load_amount` DECIMAL(18,2) COMMENT 'Entry load or subscription fee charged on the target fund class as part of the switch transaction.',
    `entry_load_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the entry load on the subscription amount in the target fund class.',
    `exit_load_amount` DECIMAL(18,2) COMMENT 'Exit load or redemption fee charged on the source fund class if the switch occurs before the lock-in period expires.',
    `exit_load_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the exit load on the redemption proceeds from the source fund class.',
    `gross_redemption_proceeds` DECIMAL(18,2) COMMENT 'Total proceeds from the redemption of units from the source fund class before deducting any fees or charges.',
    `kyc_verification_status` STRING COMMENT 'Status of the Know Your Customer verification check performed on the investor account for the fund switch transaction.. Valid values are `verified|pending|failed|not_required`',
    `lock_in_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the fund switch transaction complies with any lock-in period restrictions on the source fund class.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fund switch transaction record was last modified or updated.',
    `net_switch_proceeds` DECIMAL(18,2) COMMENT 'Net proceeds available for reinvestment into the target fund class after deducting switching fees, exit loads, and any applicable taxes.',
    `order_date` DATE COMMENT 'Date on which the investor submitted the fund switch order instruction.',
    `order_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fund switch order was received and recorded by the transfer agent or fund administrator.',
    `realized_gain_loss` DECIMAL(18,2) COMMENT 'Realized capital gain or loss resulting from the redemption leg of the fund switch transaction, calculated as the difference between redemption proceeds and cost basis.',
    `redemption_nav` DECIMAL(18,2) COMMENT 'Net Asset Value per unit of the source fund class applied to calculate the redemption proceeds.',
    `redemption_units` DECIMAL(18,2) COMMENT 'Number of units redeemed from the source fund class as part of the switch transaction.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicator of whether the fund switch transaction requires reporting to regulatory authorities under applicable financial regulations.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for rejection if the fund switch order was not accepted for processing.',
    `rejection_reason_description` STRING COMMENT 'Detailed textual explanation of why the fund switch order was rejected.',
    `settlement_date` DATE COMMENT 'Date on which the fund switch transaction is fully settled and the investors holdings are updated in both source and target fund classes.',
    `subscription_nav` DECIMAL(18,2) COMMENT 'Net Asset Value per unit of the target fund class applied to calculate the number of units subscribed.',
    `subscription_units` DECIMAL(18,2) COMMENT 'Number of units subscribed in the target fund class using the net switch proceeds.',
    `switch_order_number` STRING COMMENT 'Externally-known unique reference number assigned to the fund switch order for tracking and confirmation purposes.',
    `switch_status` STRING COMMENT 'Current lifecycle status of the fund switch transaction indicating its processing stage.. Valid values are `pending|confirmed|settled|rejected|cancelled`',
    `switch_type` STRING COMMENT 'Classification of the switch transaction indicating whether it is a full redemption and reinvestment, partial switch, or part of a systematic switch plan.. Valid values are `full|partial|systematic`',
    `switching_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the fund administrator or transfer agent for processing the fund switch transaction.',
    `switching_fee_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate the switching fee based on the redemption proceeds or subscription amount.',
    `tax_event_flag` BOOLEAN COMMENT 'Indicator of whether the fund switch transaction triggers a taxable event for the investor under applicable tax regulations.',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Total tax amount withheld from the redemption proceeds as required by applicable tax regulations.',
    `trade_date` DATE COMMENT 'Date on which the fund switch transaction is executed and the Net Asset Value (NAV) is applied for both redemption and subscription legs.',
    CONSTRAINT pk_fund_switch PRIMARY KEY(`fund_switch_id`)
) COMMENT 'Transactional record of investor fund switch (exchange) transactions where units in one fund class are redeemed and proceeds are simultaneously reinvested into another fund class. Captures source fund class, target fund class, switch date, units redeemed, redemption NAV, switch proceeds, units subscribed, subscription NAV, switching fee, tax event flag, and settlement status. Distinct from standalone subscriptions and redemptions as the switch is a single atomic investor instruction.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_management_assignment` (
    `fund_management_assignment_id` BIGINT COMMENT 'Unique system identifier for the fund management assignment record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee assigned to manage or support the fund. References the employee master record in the HR domain.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to the investment fund being managed. References the fund master record in the asset domain.',
    `assignment_end_date` DATE COMMENT 'The date on which the employees management or support role for this fund ended. Null for active assignments. Used to track historical management teams and support regulatory disclosures of manager tenure.',
    `assignment_start_date` DATE COMMENT 'The date on which the employee began their management or support role for this fund. Used for regulatory reporting of fund manager changes, performance attribution analysis, and audit trail of management responsibility.',
    `assignment_status` STRING COMMENT 'Current operational status of the management assignment. Active indicates the employee is currently performing the role. On_leave indicates temporary absence (sabbatical, parental leave). Transitioning indicates handover period. Terminated indicates assignment has ended.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the assignment record was created. Used for audit trail and data lineage.',
    `primary_manager_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this employee is the primary or lead manager for the fund (true) or a supporting team member (false). Used for regulatory disclosures, investor communications, and escalation paths. Only one employee per fund should have this flag set to true at any given time for active assignments.',
    `responsibility_percentage` DECIMAL(18,2) COMMENT 'The percentage of management responsibility or time allocation the employee dedicates to this fund, expressed as a decimal (e.g., 25.00 for 25%). Used in matrix organizations where employees manage multiple funds simultaneously. Supports workload balancing, capacity planning, and proportional compensation allocation.',
    `role_type` STRING COMMENT 'The specific role the employee performs for this fund assignment. Distinguishes between lead portfolio managers (primary decision authority), supporting portfolio managers, research analysts, traders executing fund strategies, risk managers, and compliance officers. Critical for regulatory disclosures and operational accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the assignment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_fund_management_assignment PRIMARY KEY(`fund_management_assignment_id`)
) COMMENT 'This association product represents the assignment relationship between employees and investment funds they manage or support. It captures the operational reality of team-based fund management where multiple portfolio managers, analysts, and traders are assigned to a single fund, and individual employees manage portfolios of multiple funds simultaneously. Each record links one employee to one fund with attributes that exist only in the context of this management assignment, including role type, time period, responsibility allocation, and primary manager designation.. Existence Justification: In institutional asset management, investment funds are managed by teams rather than individual managers. A single fund typically has multiple employees assigned in different roles (lead portfolio manager, analysts, traders, risk managers), and individual employees simultaneously manage portfolios of multiple funds. The bank actively manages these assignments as operational records, tracking role types, time periods, responsibility percentages, and primary manager designations for regulatory disclosure, performance attribution, and workload management.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_risk_exposure` (
    `fund_risk_exposure_id` BIGINT COMMENT 'Unique surrogate identifier for each fund-risk factor exposure record. Primary key for the association.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to the specific risk factor (interest rate curve, equity index, FX rate, credit spread) to which the fund has exposure',
    `fund_id` BIGINT COMMENT 'Foreign key linking to the investment fund whose risk exposure is being measured',
    `calculation_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this exposure record was calculated and persisted. Used for audit trail and to distinguish between intraday recalculations.',
    `contribution_to_var` DECIMAL(18,2) COMMENT 'The marginal contribution of this specific risk factor to the funds total Value at Risk (VaR). Calculated using partial derivatives and correlation structure. Expressed in base currency units.',
    `exposure_status` STRING COMMENT 'Current status of this risk factor exposure: active (within limits), breached (exceeds risk limits), monitored (approaching limits), hedged (actively hedged position), closed (position no longer exists).',
    `factor_exposure_amount` DECIMAL(18,2) COMMENT 'Absolute exposure amount of the fund to this risk factor, expressed in the funds base currency. Represents the notional or market value of positions driven by this risk factor.',
    `factor_sensitivity` DECIMAL(18,2) COMMENT 'Quantitative sensitivity of the funds portfolio value to a unit change in the risk factor. For interest rate risk this is DV01 (dollar value of 1 basis point), for equity risk this is delta, for FX risk this is FX delta. Expressed in base currency units per unit change in the risk factor.',
    `hedge_ratio` DECIMAL(18,2) COMMENT 'The proportion of the risk factor exposure that is hedged through derivatives or offsetting positions. Expressed as a decimal (0.0 = unhedged, 1.0 = fully hedged). Used for net exposure calculation and hedge effectiveness monitoring.',
    `measurement_date` DATE COMMENT 'The business date (T) on which this risk factor exposure was measured and calculated. Risk exposures are typically calculated daily for active funds and may be calculated less frequently for closed-end or illiquid funds.',
    `stress_scenario_impact` DECIMAL(18,2) COMMENT 'The estimated profit or loss impact on the fund if the risk factor experiences the regulatory stress scenario shock defined in the risk_factor master. Expressed in base currency units. Used for FRTB stressed VaR and scenario analysis.',
    CONSTRAINT pk_fund_risk_exposure PRIMARY KEY(`fund_risk_exposure_id`)
) COMMENT 'This association product represents the quantitative exposure relationship between a fund and a risk factor. It captures the sensitivity, exposure amount, and risk contribution of each risk factor to each funds portfolio. Each record links one fund to one risk factor with attributes that exist only in the context of this relationship, supporting FRTB risk decomposition, VaR attribution, and regulatory stress testing.. Existence Justification: In investment fund risk management, each fund has exposure to multiple risk factors (interest rate curves, equity indices, FX rates, credit spreads), and each risk factor affects multiple funds across the portfolio. The business actively manages and monitors these exposures through daily risk calculations, VaR decomposition, and regulatory reporting under FRTB and Basel III. Risk teams create, update, and analyze these exposure records as part of operational risk management processes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_umbrella_fund_id` FOREIGN KEY (`umbrella_fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_master_fund_id` FOREIGN KEY (`master_fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_base_fund_class_id` FOREIGN KEY (`base_fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_fund_administrator_id` FOREIGN KEY (`fund_administrator_id`) REFERENCES `banking_ecm`.`asset`.`fund_administrator`(`fund_administrator_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_previous_nav_record_id` FOREIGN KEY (`previous_nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_previous_fund_holding_id` FOREIGN KEY (`previous_fund_holding_id`) REFERENCES `banking_ecm`.`asset`.`fund_holding`(`fund_holding_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_reversal_fund_transaction_id` FOREIGN KEY (`reversal_fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ADD CONSTRAINT `fk_asset_investor_account_linked_investor_account_id` FOREIGN KEY (`linked_investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_reversal_subscription_id` FOREIGN KEY (`reversal_subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_fund_administrator_id` FOREIGN KEY (`fund_administrator_id`) REFERENCES `banking_ecm`.`asset`.`fund_administrator`(`fund_administrator_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_reversal_redemption_id` FOREIGN KEY (`reversal_redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_reversal_distribution_event_id` FOREIGN KEY (`reversal_distribution_event_id`) REFERENCES `banking_ecm`.`asset`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ADD CONSTRAINT `fk_asset_asset_unit_register_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ADD CONSTRAINT `fk_asset_asset_unit_register_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ADD CONSTRAINT `fk_asset_asset_unit_register_previous_asset_unit_register_id` FOREIGN KEY (`previous_asset_unit_register_id`) REFERENCES `banking_ecm`.`asset`.`asset_unit_register`(`asset_unit_register_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_original_expense_fund_expense_id` FOREIGN KEY (`original_expense_fund_expense_id`) REFERENCES `banking_ecm`.`asset`.`fund_expense`(`fund_expense_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ADD CONSTRAINT `fk_asset_fund_expense_reversal_fund_expense_id` FOREIGN KEY (`reversal_fund_expense_id`) REFERENCES `banking_ecm`.`asset`.`fund_expense`(`fund_expense_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_previous_fund_mandate_id` FOREIGN KEY (`previous_fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_superseded_by_restriction_investment_restriction_id` FOREIGN KEY (`superseded_by_restriction_investment_restriction_id`) REFERENCES `banking_ecm`.`asset`.`investment_restriction`(`investment_restriction_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_superseded_investment_restriction_id` FOREIGN KEY (`superseded_investment_restriction_id`) REFERENCES `banking_ecm`.`asset`.`investment_restriction`(`investment_restriction_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_investment_restriction_id` FOREIGN KEY (`investment_restriction_id`) REFERENCES `banking_ecm`.`asset`.`investment_restriction`(`investment_restriction_id`);
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ADD CONSTRAINT `fk_asset_restriction_breach_previous_restriction_breach_id` FOREIGN KEY (`previous_restriction_breach_id`) REFERENCES `banking_ecm`.`asset`.`restriction_breach`(`restriction_breach_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_previous_fund_performance_id` FOREIGN KEY (`previous_fund_performance_id`) REFERENCES `banking_ecm`.`asset`.`fund_performance`(`fund_performance_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ADD CONSTRAINT `fk_asset_fund_regulatory_report_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ADD CONSTRAINT `fk_asset_fund_regulatory_report_previous_fund_regulatory_report_id` FOREIGN KEY (`previous_fund_regulatory_report_id`) REFERENCES `banking_ecm`.`asset`.`fund_regulatory_report`(`fund_regulatory_report_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ADD CONSTRAINT `fk_asset_fund_lifecycle_event_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ADD CONSTRAINT `fk_asset_fund_lifecycle_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ADD CONSTRAINT `fk_asset_fund_lifecycle_event_superseded_by_event_fund_lifecycle_event_id` FOREIGN KEY (`superseded_by_event_fund_lifecycle_event_id`) REFERENCES `banking_ecm`.`asset`.`fund_lifecycle_event`(`fund_lifecycle_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ADD CONSTRAINT `fk_asset_fund_lifecycle_event_previous_fund_lifecycle_event_id` FOREIGN KEY (`previous_fund_lifecycle_event_id`) REFERENCES `banking_ecm`.`asset`.`fund_lifecycle_event`(`fund_lifecycle_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ADD CONSTRAINT `fk_asset_fund_administrator_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ADD CONSTRAINT `fk_asset_fund_administrator_lead_fund_administrator_id` FOREIGN KEY (`lead_fund_administrator_id`) REFERENCES `banking_ecm`.`asset`.`fund_administrator`(`fund_administrator_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ADD CONSTRAINT `fk_asset_fund_benchmark_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ADD CONSTRAINT `fk_asset_fund_benchmark_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ADD CONSTRAINT `fk_asset_fund_benchmark_superseded_by_benchmark_fund_benchmark_id` FOREIGN KEY (`superseded_by_benchmark_fund_benchmark_id`) REFERENCES `banking_ecm`.`asset`.`fund_benchmark`(`fund_benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ADD CONSTRAINT `fk_asset_fund_benchmark_previous_fund_benchmark_id` FOREIGN KEY (`previous_fund_benchmark_id`) REFERENCES `banking_ecm`.`asset`.`fund_benchmark`(`fund_benchmark_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_parent_event_transfer_agency_event_id` FOREIGN KEY (`parent_event_transfer_agency_event_id`) REFERENCES `banking_ecm`.`asset`.`transfer_agency_event`(`transfer_agency_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_primary_original_event_transfer_agency_event_id` FOREIGN KEY (`primary_original_event_transfer_agency_event_id`) REFERENCES `banking_ecm`.`asset`.`transfer_agency_event`(`transfer_agency_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ADD CONSTRAINT `fk_asset_transfer_agency_event_previous_transfer_agency_event_id` FOREIGN KEY (`previous_transfer_agency_event_id`) REFERENCES `banking_ecm`.`asset`.`transfer_agency_event`(`transfer_agency_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ADD CONSTRAINT `fk_asset_fund_fee_schedule_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ADD CONSTRAINT `fk_asset_fund_fee_schedule_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ADD CONSTRAINT `fk_asset_fund_fee_schedule_superseded_by_schedule_fund_fee_schedule_id` FOREIGN KEY (`superseded_by_schedule_fund_fee_schedule_id`) REFERENCES `banking_ecm`.`asset`.`fund_fee_schedule`(`fund_fee_schedule_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ADD CONSTRAINT `fk_asset_fund_fee_schedule_previous_fund_fee_schedule_id` FOREIGN KEY (`previous_fund_fee_schedule_id`) REFERENCES `banking_ecm`.`asset`.`fund_fee_schedule`(`fund_fee_schedule_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ADD CONSTRAINT `fk_asset_fund_distribution_channel_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ADD CONSTRAINT `fk_asset_fund_distribution_channel_previous_fund_distribution_channel_id` FOREIGN KEY (`previous_fund_distribution_channel_id`) REFERENCES `banking_ecm`.`asset`.`fund_distribution_channel`(`fund_distribution_channel_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ADD CONSTRAINT `fk_asset_fund_audit_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ADD CONSTRAINT `fk_asset_fund_audit_previous_fund_audit_id` FOREIGN KEY (`previous_fund_audit_id`) REFERENCES `banking_ecm`.`asset`.`fund_audit`(`fund_audit_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ADD CONSTRAINT `fk_asset_investor_statement_previous_investor_statement_id` FOREIGN KEY (`previous_investor_statement_id`) REFERENCES `banking_ecm`.`asset`.`investor_statement`(`investor_statement_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_original_adjustment_fund_valuation_adjustment_id` FOREIGN KEY (`original_adjustment_fund_valuation_adjustment_id`) REFERENCES `banking_ecm`.`asset`.`fund_valuation_adjustment`(`fund_valuation_adjustment_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ADD CONSTRAINT `fk_asset_fund_valuation_adjustment_previous_fund_valuation_adjustment_id` FOREIGN KEY (`previous_fund_valuation_adjustment_id`) REFERENCES `banking_ecm`.`asset`.`fund_valuation_adjustment`(`fund_valuation_adjustment_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_target_fund_class_id` FOREIGN KEY (`target_fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_target_fund_id` FOREIGN KEY (`target_fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ADD CONSTRAINT `fk_asset_fund_switch_previous_fund_switch_id` FOREIGN KEY (`previous_fund_switch_id`) REFERENCES `banking_ecm`.`asset`.`fund_switch`(`fund_switch_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ADD CONSTRAINT `fk_asset_fund_management_assignment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ADD CONSTRAINT `fk_asset_fund_risk_exposure_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`asset` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `banking_ecm`.`asset`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_transfer_agent_party_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agent Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `umbrella_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Umbrella Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `master_fund_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Administrator Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Primary Asset Class');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|money_market|multi_asset|alternative|real_estate');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index Name');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[0-9A-Z]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `dealing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Dealing Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `dealing_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|none');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `distribution_policy` SET TAGS ('dbx_business_glossary_term' = 'Distribution Policy Type');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `distribution_policy` SET TAGS ('dbx_value_regex' = 'accumulating|distributing|mixed');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fiscal_year_end` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Date (MM-DD)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fiscal_year_end` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Legal Name');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Operational Status');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|soft_closed|hard_closed|liquidating|terminated|suspended');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'mutual_fund|etf|hedge_fund|pension_fund|ucits|sicav');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Inception Date');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective Statement');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Launch Date');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `legal_structure` SET TAGS ('dbx_business_glossary_term' = 'Legal Structure Type');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `legal_structure` SET TAGS ('dbx_value_regex' = 'open_ended|closed_ended|unit_trust|investment_trust|limited_partnership');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `minimum_investment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Initial Investment Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `minimum_subsequent_investment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subsequent Investment Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `nav_frequency` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `nav_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `performance_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Rate (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `prospectus_date` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `redemption_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notice Period (Days)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification Type');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'ucits|aif|40_act|qif|reit|private_placement');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `settlement_period_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period (Days)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Short Name');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `target_aum` SET TAGS ('dbx_business_glossary_term' = 'Target Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Termination Date');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `total_expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Total Expense Ratio (TER)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `base_fund_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `benchmark_index` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Index');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `bloomberg_ticker` SET TAGS ('dbx_business_glossary_term' = 'Bloomberg Ticker Symbol');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Share Class Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `class_name` SET TAGS ('dbx_business_glossary_term' = 'Share Class Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[A-Z0-9]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `dealing_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Dealing Cut-Off Time');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `dealing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Dealing Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `dealing_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|none');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `distribution_policy` SET TAGS ('dbx_business_glossary_term' = 'Distribution Policy');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `distribution_policy` SET TAGS ('dbx_value_regex' = 'accumulating|distributing|flexible');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `entry_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Rate (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `exit_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Rate (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `fund_class_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `fund_class_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|liquidated|pending_launch');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `hedged_flag` SET TAGS ('dbx_business_glossary_term' = 'Currency Hedged Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Class Inception Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `investor_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Investor Eligibility Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `investor_eligibility` SET TAGS ('dbx_value_regex' = 'retail|institutional|professional|qualified|accredited');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `kiid_url` SET TAGS ('dbx_business_glossary_term' = 'Key Investor Information Document (KIID) URL');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `minimum_initial_investment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Initial Investment Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `minimum_subsequent_investment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Subsequent Investment Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `nav_frequency` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `nav_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `ongoing_charges_figure` SET TAGS ('dbx_business_glossary_term' = 'Ongoing Charges Figure (OCF) (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `performance_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Rate (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `prospectus_url` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Document URL');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL) Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{7}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `settlement_period_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period (Days)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `sfdr_classification` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Finance Disclosure Regulation (SFDR) Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `sfdr_classification` SET TAGS ('dbx_value_regex' = 'article_6|article_8|article_9');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `tax_reporting_status` SET TAGS ('dbx_value_regex' = 'reporting|non_reporting|transparent|opaque');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Class Termination Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `total_expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Total Expense Ratio (TER) (Percentage)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Record Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `fund_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Administrator Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Accountant Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `previous_nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Net Asset Value (NAV) Record Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `accrued_expenses` SET TAGS ('dbx_business_glossary_term' = 'Accrued Expenses');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'amortized_cost|mark_to_market|fair_value');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `distribution_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Distribution Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `ex_distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Distribution Date');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `gross_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Asset Value (GAV)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `is_audited` SET TAGS ('dbx_business_glossary_term' = 'Is Audited Flag');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `management_fee_accrual` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Accrual');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Change Amount');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Change Percentage');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Publication Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_status` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Status');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|restated|suspended');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `net_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `performance_fee_accrual` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Accrual');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_value_regex' = 'forward|historic|swing');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `restatement_reason` SET TAGS ('dbx_business_glossary_term' = 'Restatement Reason');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `total_expense_ratio` SET TAGS ('dbx_business_glossary_term' = 'Total Expense Ratio (TER)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `total_liabilities` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `total_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `total_subscriptions` SET TAGS ('dbx_business_glossary_term' = 'Total Subscriptions');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `units_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Units Outstanding');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `fund_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Holding Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Of Risk Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `equity_id` SET TAGS ('dbx_business_glossary_term' = 'Equity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `fixed_income_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Income Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Market Price Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sector Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Security Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `structured_product_id` SET TAGS ('dbx_business_glossary_term' = 'Structured Product Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `previous_fund_holding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'EQUITY|FIXED_INCOME|CASH|DERIVATIVES|COMMODITIES|REAL_ESTATE');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `duration_years` SET TAGS ('dbx_business_glossary_term' = 'Duration in Years');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `fair_value_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `fair_value_level` SET TAGS ('dbx_value_regex' = 'LEVEL_1|LEVEL_2|LEVEL_3');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|PENDING_SETTLEMENT|RESTRICTED|PLEDGED|LIQUIDATED');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'HIGHLY_LIQUID|MODERATELY_LIQUID|LESS_LIQUID|ILLIQUID');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `market_value_base` SET TAGS ('dbx_business_glossary_term' = 'Market Value Base Currency');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `market_value_local` SET TAGS ('dbx_business_glossary_term' = 'Market Value Local Currency');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `percentage_of_nav` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `quantity_held` SET TAGS ('dbx_business_glossary_term' = 'Quantity Held');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `reversal_fund_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_business_glossary_term' = 'Accounting Treatment');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_value_regex' = 'realized_gain_loss|unrealized_gain_loss|income|expense|capital|adjustment');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accounting_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `base_currency_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Gross Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `base_currency_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Net Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[0-9A-Z]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL) Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_sedol` SET TAGS ('dbx_value_regex' = '^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `nav_date` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'dvp|rvp|fop|cash');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|partially_settled|cancelled');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `trade_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `transaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|settled|cancelled|failed|reversed|suspended');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` SET TAGS ('dbx_subdomain' = 'investor_services');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `linked_investor_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closure Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_opening|dormant|restricted');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `beneficial_owner_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Count');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `closure_reason` SET TAGS ('dbx_value_regex' = 'investor_request|zero_balance|regulatory|deceased|duplicate|fraud');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Bank Account Number');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Bank Account Type');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_type` SET TAGS ('dbx_value_regex' = 'checking|savings');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_account_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Bank Routing Number');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_preference` SET TAGS ('dbx_business_glossary_term' = 'Distribution Preference');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `distribution_preference` SET TAGS ('dbx_value_regex' = 'reinvest|cash|partial_reinvest');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `dormancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Dormancy Flag');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'us_person|specified_us_person|non_us|exempt|recalcitrant|not_classified');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `investor_type` SET TAGS ('dbx_business_glossary_term' = 'Investor Type');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `investor_type` SET TAGS ('dbx_value_regex' = 'retail|institutional|nominee|trust|custodial|corporate');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `kyc_next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Next Review Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|expired|failed|refresh_required');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `kyc_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_country` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `omnibus_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnibus Account Flag');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `restricted_trading_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Trading Flag');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `restricted_trading_reason` SET TAGS ('dbx_business_glossary_term' = 'Restricted Trading Reason');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `statement_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Statement Delivery Method');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `statement_delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|postal|both|suppressed');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`subscription` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`subscription` SET TAGS ('dbx_subdomain' = 'investor_services');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `reversal_subscription_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `aml_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Clearance Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `aml_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Clearance Status');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `aml_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|rejected');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `cost_basis_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `dealing_nav` SET TAGS ('dbx_business_glossary_term' = 'Dealing Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `entry_load_amount` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Amount');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `entry_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Rate');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `gross_subscription_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Subscription Amount');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `minimum_investment_waived` SET TAGS ('dbx_business_glossary_term' = 'Minimum Investment Waived Flag');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `nav_date` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `net_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Investment Amount');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Subscription Notes');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `order_method` SET TAGS ('dbx_business_glossary_term' = 'Order Method');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `order_method` SET TAGS ('dbx_value_regex' = 'amount|units');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|debit_card|internal_transfer');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|received|cleared|failed|reversed');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Subscription Amount');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `requested_units` SET TAGS ('dbx_business_glossary_term' = 'Requested Units');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Declaration');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `source_of_funds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Order Number');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|processing|settled|cancelled|rejected');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'initial|additional|systematic|reinvestment|exchange_in');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Method');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|average_cost|specific_identification');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `units_allotted` SET TAGS ('dbx_business_glossary_term' = 'Units Allotted');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`asset`.`redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`redemption` SET TAGS ('dbx_subdomain' = 'investor_services');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `fund_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agent Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `reversal_redemption_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Check Status');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `amount_requested` SET TAGS ('dbx_business_glossary_term' = 'Redemption Amount Requested');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `confirmation_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `dealing_nav` SET TAGS ('dbx_business_glossary_term' = 'Dealing Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `exit_load_amount` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Amount');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `exit_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Rate');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `gate_percentage_applied` SET TAGS ('dbx_business_glossary_term' = 'Gate Percentage Applied');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `gate_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Gate Restriction Flag');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `gross_redemption_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Gross Redemption Proceeds');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|expired|failed');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `lock_in_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Lock-In Compliance Flag');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `lock_in_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lock-In Period End Date');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `net_redemption_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Net Redemption Proceeds');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Order Number');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Account Number');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|rtgs|swift');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Routing Number');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `payment_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Sent Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|rejected|suspended');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Type');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `redemption_type` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Redemption Units');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` SET TAGS ('dbx_subdomain' = 'distribution_operations');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `reversal_distribution_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `accrual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual End Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `accrual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Start Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Calculation Method');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Distribution Frequency');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|special');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Notice Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Number');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rate Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Distribution Sequence Number');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_source_description` SET TAGS ('dbx_business_glossary_term' = 'Distribution Source Description');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'declared|pending_approval|approved|paid|cancelled');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Type');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_type` SET TAGS ('dbx_value_regex' = 'income_dividend|short_term_capital_gain|long_term_capital_gain|return_of_capital|qualified_dividend|non_qualified_dividend');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `ex_dividend_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Dividend Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `foreign_tax_credit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Foreign Tax Credit Percentage');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `form_1099_div_reportable` SET TAGS ('dbx_business_glossary_term' = 'Form 1099-DIV Reportable');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `net_distribution_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Distribution Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|reinvestment|mixed');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `qualified_dividend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Qualified Dividend Percentage');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `reinvestment_nav` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `section_199a_dividend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Section 199A Dividend Percentage');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `shares_outstanding_at_record` SET TAGS ('dbx_business_glossary_term' = 'Shares Outstanding at Record Date');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `total_distribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Distribution Amount');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` SET TAGS ('dbx_subdomain' = 'investor_services');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `asset_unit_register_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Register ID');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class ID');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account ID');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `previous_asset_unit_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `average_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `beneficial_owner_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Flag');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `current_market_value` SET TAGS ('dbx_business_glossary_term' = 'Current Market Value');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `current_nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Current Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `distribution_option` SET TAGS ('dbx_business_glossary_term' = 'Distribution Option');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `distribution_option` SET TAGS ('dbx_value_regex' = 'reinvest|cash|partial_reinvest');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `escheatment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Due Date');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'exempt|participating_ffi|non_participating_ffi|us_person|recalcitrant|not_applicable');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `first_investment_date` SET TAGS ('dbx_business_glossary_term' = 'First Investment Date');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `last_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Type');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `last_transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|redemption|exchange_in|exchange_out|dividend_reinvestment|distribution');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `omnibus_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnibus Account Flag');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `record_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Closed Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `register_status` SET TAGS ('dbx_business_glossary_term' = 'Register Status');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `register_status` SET TAGS ('dbx_value_regex' = 'active|closed|suspended|pending_closure|restricted');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `restriction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiry Date');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Method');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|average_cost|specific_identification|highest_cost');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `total_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Basis');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `total_distributions_received` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Received');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `total_distributions_reinvested` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Reinvested');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `units_held` SET TAGS ('dbx_business_glossary_term' = 'Units Held');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`asset_unit_register` ALTER COLUMN `unrealized_gain_loss_percentage` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `fund_expense_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Expense Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `original_expense_fund_expense_id` SET TAGS ('dbx_business_glossary_term' = 'Original Expense Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `reversal_fund_expense_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `accrual_basis` SET TAGS ('dbx_business_glossary_term' = 'Accrual Basis');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `accrual_basis` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annual|event_driven');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `annualized_rate` SET TAGS ('dbx_business_glossary_term' = 'Annualized Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_category` SET TAGS ('dbx_value_regex' = 'operating|non_operating|extraordinary');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_description` SET TAGS ('dbx_business_glossary_term' = 'Expense Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_ratio_contribution` SET TAGS ('dbx_business_glossary_term' = 'Expense Ratio Contribution');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Expense Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_status` SET TAGS ('dbx_business_glossary_term' = 'Expense Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_status` SET TAGS ('dbx_value_regex' = 'accrued|paid|reversed|pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `nav_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Impact Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payee_identifier` SET TAGS ('dbx_business_glossary_term' = 'Payee Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payee_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|electronic_funds_transfer|debit');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `recoupment_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Eligible Indicator');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `recoupment_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Expiration Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `tax_deductible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Deductible Indicator');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Waiver Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_expense` ALTER COLUMN `waiver_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waiver Indicator');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `previous_fund_mandate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `breach_tolerance_policy` SET TAGS ('dbx_business_glossary_term' = 'Breach Tolerance Policy');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `compliance_monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `compliance_monitoring_frequency` SET TAGS ('dbx_value_regex' = 'real_time|daily|weekly|monthly');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `credit_quality_minimum` SET TAGS ('dbx_business_glossary_term' = 'Credit Quality Minimum');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `currency_hedging_policy` SET TAGS ('dbx_business_glossary_term' = 'Currency Hedging Policy');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `currency_hedging_policy` SET TAGS ('dbx_value_regex' = 'fully_hedged|partially_hedged|unhedged|discretionary');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `derivative_usage_policy` SET TAGS ('dbx_business_glossary_term' = 'Derivative Usage Policy');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `derivative_usage_policy` SET TAGS ('dbx_value_regex' = 'prohibited|hedging_only|efficient_portfolio_management|speculative_allowed');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `duration_range_max_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Range Maximum Years');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `duration_range_min_years` SET TAGS ('dbx_business_glossary_term' = 'Duration Range Minimum Years');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `esg_constraints` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Constraints');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `geographic_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restrictions');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `high_water_mark_applicable` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark Applicable');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `investment_objective` SET TAGS ('dbx_business_glossary_term' = 'Investment Objective');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `investment_strategy` SET TAGS ('dbx_business_glossary_term' = 'Investment Strategy');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `issuer_concentration_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Issuer Concentration Limit Percentage (PCT)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `leverage_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Leverage Limit Percentage (PCT)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `liquidity_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Requirement Percentage (PCT)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `mandate_code` SET TAGS ('dbx_business_glossary_term' = 'Mandate Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `mandate_name` SET TAGS ('dbx_business_glossary_term' = 'Mandate Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_business_glossary_term' = 'Mandate Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `mandate_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|under_review|pending_approval');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_business_glossary_term' = 'Mandate Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `mandate_type` SET TAGS ('dbx_value_regex' = 'discretionary|advisory|execution_only|managed_account|collective_investment');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `performance_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Applicable');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `permitted_asset_classes` SET TAGS ('dbx_business_glossary_term' = 'Permitted Asset Classes');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `prohibited_asset_classes` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Asset Classes');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `sector_limits` SET TAGS ('dbx_business_glossary_term' = 'Sector Limits');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `sri_constraints` SET TAGS ('dbx_business_glossary_term' = 'Socially Responsible Investment (SRI) Constraints');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` SET TAGS ('dbx_subdomain' = 'compliance_risk');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `investment_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Restriction ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Portfolio Manager ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `superseded_by_restriction_investment_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Restriction ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `superseded_investment_restriction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Date');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `breach_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Breach Magnitude');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'compliant|breached|warning|remediated|waived|under_review');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `breach_tolerance` SET TAGS ('dbx_business_glossary_term' = 'Breach Tolerance');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `check_timing` SET TAGS ('dbx_business_glossary_term' = 'Check Timing');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `check_timing` SET TAGS ('dbx_value_regex' = 'pre_trade|post_trade|both');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `current_exposure` SET TAGS ('dbx_business_glossary_term' = 'Current Exposure');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'block|alert|escalate|override_required|auto_remediate');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `last_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Check Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `next_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Check Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Override Authority Level');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `override_authority_level` SET TAGS ('dbx_value_regex' = 'none|portfolio_manager|head_of_risk|cio|board|regulator');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_category` SET TAGS ('dbx_business_glossary_term' = 'Restriction Category');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_name` SET TAGS ('dbx_business_glossary_term' = 'Restriction Name');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|superseded|draft');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'regulatory|mandate|internal|contractual|statutory|risk_limit');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'percentage|absolute_amount|basis_points|ratio|count');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` SET TAGS ('dbx_subdomain' = 'compliance_risk');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `restriction_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Restriction Breach Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `investment_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Restriction Rule Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Security Reference Instrument Identifier Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `tertiary_restriction_waiver_granted_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted By Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `tertiary_restriction_waiver_granted_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `tertiary_restriction_waiver_granted_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `previous_restriction_breach_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_category` SET TAGS ('dbx_business_glossary_term' = 'Breach Category');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_category` SET TAGS ('dbx_value_regex' = 'concentration|liquidity|leverage|exposure|diversification|eligibility');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Breach Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Detection Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_disposition` SET TAGS ('dbx_business_glossary_term' = 'Breach Disposition');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_disposition` SET TAGS ('dbx_value_regex' = 'resolved|waived|escalated|pending|withdrawn');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_magnitude_unit` SET TAGS ('dbx_business_glossary_term' = 'Breach Magnitude Unit of Measure');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_magnitude_unit` SET TAGS ('dbx_value_regex' = 'percentage|basis_points|amount|units|ratio');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_magnitude_value` SET TAGS ('dbx_business_glossary_term' = 'Breach Magnitude Value');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_notes` SET TAGS ('dbx_business_glossary_term' = 'Breach Notes');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Occurrence Date');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_severity_score` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity Score');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'hard_limit|soft_limit|warning|threshold');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `monitoring_stage` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Stage');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `monitoring_stage` SET TAGS ('dbx_value_regex' = 'pre_trade|post_trade|end_of_day|intraday');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `portfolio_manager_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Notified Flag');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `portfolio_manager_notified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Manager Notified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `regulatory_report_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `regulatory_reporting_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Deadline Date');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `remediation_action_type` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Type');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `remediation_action_type` SET TAGS ('dbx_value_regex' = 'trade_reversal|position_reduction|rebalancing|waiver_granted|no_action_required|manual_override');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `remediation_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Description');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `remediation_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Initiated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `threshold_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Limit Value');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `waiver_granted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`restriction_breach` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Performance ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Calculated By User ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `previous_fund_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `active_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Active Return (Alpha) Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `average_aum` SET TAGS ('dbx_business_glossary_term' = 'Average Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `beginning_nav` SET TAGS ('dbx_business_glossary_term' = 'Beginning Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `benchmark_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Return Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `beta` SET TAGS ('dbx_business_glossary_term' = 'Beta');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_value_regex' = 'modified_dietz|true_twr|simple_twr|irr');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `capital_appreciation_pct` SET TAGS ('dbx_business_glossary_term' = 'Capital Appreciation Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `ending_nav` SET TAGS ('dbx_business_glossary_term' = 'Ending Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `expense_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Expense Ratio Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `gips_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Investment Performance Standards (GIPS) Compliant Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `income_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Income Return Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `information_ratio` SET TAGS ('dbx_business_glossary_term' = 'Information Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `maximum_drawdown_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Drawdown Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `mwr_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Money-Weighted Return (MWR) / Internal Rate of Return (IRR) Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `number_of_holdings` SET TAGS ('dbx_business_glossary_term' = 'Number of Holdings');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `performance_attribution_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Attribution Available Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance End Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `performance_period_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Start Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|restated|audited');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `r_squared` SET TAGS ('dbx_business_glossary_term' = 'R-Squared');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `risk_free_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Risk-Free Rate Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `sharpe_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sharpe Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `sortino_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sortino Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `total_return_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Return Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `tracking_error_pct` SET TAGS ('dbx_business_glossary_term' = 'Tracking Error Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `turnover_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Turnover Ratio Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `twr_gross_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR) Gross Return Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `twr_net_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR) Net Return Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `volatility_pct` SET TAGS ('dbx_business_glossary_term' = 'Volatility (Standard Deviation) Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` SET TAGS ('dbx_subdomain' = 'compliance_risk');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `fund_regulatory_report_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Regulatory Report ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `risk_report_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Report Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `previous_fund_regulatory_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `filing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Filing Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `late_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Filing Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `late_filing_reason` SET TAGS ('dbx_business_glossary_term' = 'Late Filing Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `original_submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Original Submission Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `regulator_code` SET TAGS ('dbx_business_glossary_term' = 'Regulator Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `regulator_name` SET TAGS ('dbx_business_glossary_term' = 'Regulator Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_checksum` SET TAGS ('dbx_business_glossary_term' = 'Report Checksum');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_file_format` SET TAGS ('dbx_business_glossary_term' = 'Report File Format');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_file_format` SET TAGS ('dbx_value_regex' = 'XML|XBRL|PDF|CSV|JSON');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_file_name` SET TAGS ('dbx_business_glossary_term' = 'Report File Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Report File Size Bytes');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_business_glossary_term' = 'Report Preparer Email');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_preparer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Report Preparer Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Report Reviewer Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|amended');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `report_version_number` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `resubmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `submission_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_regulatory_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `fund_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Lifecycle Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Share Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `superseded_by_event_fund_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `previous_fund_lifecycle_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `auditor_firm` SET TAGS ('dbx_business_glossary_term' = 'Auditor Firm');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `aum_at_event` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) at Event');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `aum_at_event` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `aum_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `aum_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'operational|regulatory|structural|distribution|strategic|compliance');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_reason` SET TAGS ('dbx_business_glossary_term' = 'Event Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `investor_count_at_event` SET TAGS ('dbx_business_glossary_term' = 'Investor Count at Event');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `investor_count_at_event` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `investor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Investor Notification Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `investor_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Investor Notification Method');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `investor_notification_method` SET TAGS ('dbx_value_regex' = 'prospectus_supplement|shareholder_letter|website_posting|regulatory_filing|email|press_release');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `legal_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Firm');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `merger_exchange_ratio` SET TAGS ('dbx_business_glossary_term' = 'Merger Exchange Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `press_release_date` SET TAGS ('dbx_business_glossary_term' = 'Press Release Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `press_release_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Press Release Issued Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `prospectus_supplement_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Supplement Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `shareholder_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Shareholder Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `shareholder_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Shareholder Approval Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `fund_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Administrator Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Administrator Relationship Manager Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Business Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `lead_fund_administrator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Administrator Legal Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `administrator_type` SET TAGS ('dbx_business_glossary_term' = 'Administrator Service Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `administrator_type` SET TAGS ('dbx_value_regex' = 'fund_administrator|transfer_agent|custodian|prime_broker|auditor|legal_counsel');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `aum_fee_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Fee Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `aum_fee_basis_points` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|expired|renewal');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email Address');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `escalation_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `fee_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Method');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `fee_calculation_method` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `insurance_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `nav_calculation_deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Calculation Deadline Time');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `regulatory_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authorization Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `service_scope` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `sla_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `soc_report_type` SET TAGS ('dbx_business_glossary_term' = 'Service Organization Control (SOC) Report Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `soc_report_type` SET TAGS ('dbx_value_regex' = 'SOC_1_Type_I|SOC_1_Type_II|SOC_2_Type_I|SOC_2_Type_II|ISAE_3402');
ALTER TABLE `banking_ecm`.`asset`.`fund_administrator` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `fund_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Benchmark Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `superseded_by_benchmark_fund_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Benchmark Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `previous_fund_benchmark_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Approved By');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_currency` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Currency Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_provider` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Provider Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|discontinued');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|absolute_return_hurdle|composite|custom|peer_group');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Data Source');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `high_water_mark_flag` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `hurdle_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Rate Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Last Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Next Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `performance_fee_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Applicable Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `prospectus_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Disclosure Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|semi_annually|annually|event_driven');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `return_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Return Calculation Method');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `return_calculation_method` SET TAGS ('dbx_value_regex' = 'total_return|price_return|net_return|gross_return');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Assignment Termination Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `tracking_error_tolerance_bps` SET TAGS ('dbx_business_glossary_term' = 'Tracking Error Tolerance in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Usage Context');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `usage_context` SET TAGS ('dbx_value_regex' = 'performance_fee_calculation|ips_mandate|investor_reporting|regulatory_filing|marketing_material|risk_attribution');
ALTER TABLE `banking_ecm`.`asset`.`fund_benchmark` ALTER COLUMN `weighting_percentage` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Weighting Percentage');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` SET TAGS ('dbx_subdomain' = 'distribution_operations');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `transfer_agency_event_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agency Event ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `parent_event_transfer_agency_event_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Event ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `primary_original_event_transfer_agency_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Event ID');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `previous_transfer_agency_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `aml_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Clearance Status');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `aml_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|rejected|under_review');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `aml_clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Clearance Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|expired');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `nav_date` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Date');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|electronic_funds_transfer');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `processing_date` SET TAGS ('dbx_business_glossary_term' = 'Processing Date');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `processing_priority` SET TAGS ('dbx_business_glossary_term' = 'Processing Priority');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `processing_priority` SET TAGS ('dbx_value_regex' = 'high|normal|low');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `register_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Register Update Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|cancelled');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `statement_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'Statement Generation Flag');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `statement_generation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Statement Generation Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `stp_indicator` SET TAGS ('dbx_business_glossary_term' = 'Straight-Through Processing (STP) Indicator');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`asset`.`transfer_agency_event` ALTER COLUMN `unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unit Quantity');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fund_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Fee Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `superseded_by_schedule_fund_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `previous_fund_fee_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `crystallization_frequency` SET TAGS ('dbx_business_glossary_term' = 'Crystallization Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `crystallization_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annually|at_redemption');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `entry_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `entry_load_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `entry_load_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|waived');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `exit_load_holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Holding Period Days');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `exit_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Method');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_calculation_method` SET TAGS ('dbx_value_regex' = 'daily_accrual|monthly_accrual|quarterly_accrual|annual_accrual');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_payment_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|semi_annually|annually');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `high_water_mark_flag` SET TAGS ('dbx_business_glossary_term' = 'High Water Mark Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `hurdle_rate` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `hurdle_type` SET TAGS ('dbx_business_glossary_term' = 'Hurdle Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `hurdle_type` SET TAGS ('dbx_value_regex' = 'hard|soft|none');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `management_fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Basis');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `management_fee_basis` SET TAGS ('dbx_value_regex' = 'aum|nav|committed_capital|invested_capital');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `management_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Management Fee Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `performance_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance Fee Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `prospectus_reference` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Reference');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `recoupment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Eligible Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `recoupment_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Period Months');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `redemption_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Redemption Fee Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `switching_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Switching Fee Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `ter_cap` SET TAGS ('dbx_business_glossary_term' = 'Total Expense Ratio (TER) Cap');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_fee_schedule` ALTER COLUMN `waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` SET TAGS ('dbx_subdomain' = 'distribution_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `fund_distribution_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Distribution Channel Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Distributor Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `previous_fund_distribution_channel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiry Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `aml_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Responsibility');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `aml_responsibility` SET TAGS ('dbx_value_regex' = 'distributor|fund_administrator|shared');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `distribution_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|inactive');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `distributor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Distributor Business Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `distributor_type` SET TAGS ('dbx_business_glossary_term' = 'Distributor Type Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Arrangement Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Distribution Scope');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `investor_segment_served` SET TAGS ('dbx_business_glossary_term' = 'Investor Segment Served Classification');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `investor_segment_served` SET TAGS ('dbx_value_regex' = 'retail|institutional|HNWI|mass_affluent|accredited|qualified_purchaser');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `kyc_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Responsibility');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `kyc_responsibility` SET TAGS ('dbx_value_regex' = 'distributor|fund_administrator|shared');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `marketing_support_provided` SET TAGS ('dbx_business_glossary_term' = 'Marketing Support Level');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `marketing_support_provided` SET TAGS ('dbx_value_regex' = 'full|limited|none');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `minimum_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Investment Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Notes');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `omnibus_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnibus Account Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Frequency');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Jurisdiction');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `retrocession_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Retrocession Arrangement Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `retrocession_arrangement` SET TAGS ('dbx_value_regex' = 'direct_payment|fee_sharing|rebate|none');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `sales_volume_target` SET TAGS ('dbx_business_glossary_term' = 'Sales Volume Target Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `sub_accounting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Sub-Accounting Agreement Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `trailer_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Trailer Fee Rate Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `upfront_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Upfront Commission Rate Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_distribution_channel` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` SET TAGS ('dbx_subdomain' = 'compliance_risk');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `fund_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Audit Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Liaison Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `previous_fund_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_documentation_retention_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Documentation Retention Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Fee Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Firm Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_firm_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Firm Registration Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_opinion_type` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|fieldwork_complete|report_draft|report_issued|filed');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'annual_statutory|interim_review|special_purpose|agreed_upon_procedures|compliance_audit');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `engagement_partner_license_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Partner License Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `engagement_partner_name` SET TAGS ('dbx_business_glossary_term' = 'Engagement Partner Name');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `fieldwork_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Completion Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `fieldwork_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fieldwork Start Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `fiscal_year_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `going_concern_flag` SET TAGS ('dbx_business_glossary_term' = 'Going Concern Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `key_audit_matters` SET TAGS ('dbx_business_glossary_term' = 'Key Audit Matters (KAM)');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `management_letter_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Letter Issued Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `management_letter_points` SET TAGS ('dbx_business_glossary_term' = 'Management Letter Points');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `material_weakness_description` SET TAGS ('dbx_business_glossary_term' = 'Material Weakness Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `material_weakness_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Weakness Identified Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `opinion_basis` SET TAGS ('dbx_business_glossary_term' = 'Opinion Basis');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `regulatory_filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Deadline Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `regulatory_filing_form_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Form Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `regulatory_filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `restatement_description` SET TAGS ('dbx_business_glossary_term' = 'Restatement Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `restatement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Restatement Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `significant_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Count');
ALTER TABLE `banking_ecm`.`asset`.`fund_audit` ALTER COLUMN `subsequent_events_review_date` SET TAGS ('dbx_business_glossary_term' = 'Subsequent Events Review Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` SET TAGS ('dbx_subdomain' = 'investor_services');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `investor_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Statement ID');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class ID');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account ID');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agent ID');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `previous_investor_statement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `capital_gains_long_term` SET TAGS ('dbx_business_glossary_term' = 'Capital Gains Long Term');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `capital_gains_short_term` SET TAGS ('dbx_business_glossary_term' = 'Capital Gains Short Term');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `closing_nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Closing Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `closing_unit_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Unit Balance');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `closing_value` SET TAGS ('dbx_business_glossary_term' = 'Closing Value');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|online_portal|courier');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `fees_deducted` SET TAGS ('dbx_business_glossary_term' = 'Fees Deducted');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Generated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `income_received` SET TAGS ('dbx_business_glossary_term' = 'Income Received');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `opening_nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Opening Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `opening_unit_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Unit Balance');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `opening_value` SET TAGS ('dbx_business_glossary_term' = 'Opening Value');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `ordinary_dividend_amount` SET TAGS ('dbx_business_glossary_term' = 'Ordinary Dividend Amount');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `qualified_dividend_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualified Dividend Amount');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain Loss');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_business_glossary_term' = 'Statement Format');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_format` SET TAGS ('dbx_value_regex' = 'pdf|html|xml|csv');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period End Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Period Start Date');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|issued|delivered|reissued|cancelled');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `tax_form_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Reference');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `total_distributions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Amount');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `total_distributions_units` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Units');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `total_redemptions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions Amount');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `total_redemptions_units` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions Units');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `total_subscriptions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Subscriptions Amount');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `total_subscriptions_units` SET TAGS ('dbx_business_glossary_term' = 'Total Subscriptions Units');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain Loss');
ALTER TABLE `banking_ecm`.`asset`.`investor_statement` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `fund_valuation_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Valuation Adjustment Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Record Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `original_adjustment_fund_valuation_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Adjustment Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `previous_fund_valuation_adjustment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_basis` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Basis');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_basis` SET TAGS ('dbx_value_regex' = 'net_flow_threshold|gross_subscription|gross_redemption|asset_illiquidity|market_volatility|trading_cost_estimate');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Category');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_value_regex' = 'subscription_driven|redemption_driven|market_event|illiquid_asset|regulatory_required|discretionary');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reference Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|applied|reversed|rejected');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'swing_pricing|dilution_levy|fair_value_adjustment|side_pocket|liquidity_adjustment|anti_dilution_levy');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'fund_accountant|portfolio_manager|compliance_officer|board_of_directors|administrator|automated_system');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `dealing_nav_impact` SET TAGS ('dbx_business_glossary_term' = 'Dealing Net Asset Value (NAV) Impact');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Text');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `estimated_trading_cost_bps` SET TAGS ('dbx_business_glossary_term' = 'Estimated Trading Cost Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `gross_redemption_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Redemption Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `gross_subscription_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Subscription Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `illiquid_asset_percentage` SET TAGS ('dbx_business_glossary_term' = 'Illiquid Asset Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `investor_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Investor Protection Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `net_flow_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Flow Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `net_flow_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Flow Threshold Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `published_nav_impact` SET TAGS ('dbx_business_glossary_term' = 'Published Net Asset Value (NAV) Impact');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `banking_ecm`.`asset`.`fund_valuation_adjustment` ALTER COLUMN `triggering_condition` SET TAGS ('dbx_business_glossary_term' = 'Triggering Condition');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` SET TAGS ('dbx_subdomain' = 'investor_services');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `fund_switch_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Switch Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Source Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `target_fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Target Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `target_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Target Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `transfer_agent_party_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agent Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `previous_fund_switch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Check Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `aml_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `confirmation_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `entry_load_amount` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `entry_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Entry Load Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `exit_load_amount` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `exit_load_rate` SET TAGS ('dbx_business_glossary_term' = 'Exit Load Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `gross_redemption_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Gross Redemption Proceeds');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Verification Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `kyc_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_required');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `lock_in_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Lock-In Compliance Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `net_switch_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Net Switch Proceeds');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `realized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `redemption_nav` SET TAGS ('dbx_business_glossary_term' = 'Redemption Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `redemption_units` SET TAGS ('dbx_business_glossary_term' = 'Redemption Units');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `subscription_nav` SET TAGS ('dbx_business_glossary_term' = 'Subscription Net Asset Value (NAV)');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `subscription_units` SET TAGS ('dbx_business_glossary_term' = 'Subscription Units');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switch_order_number` SET TAGS ('dbx_business_glossary_term' = 'Switch Order Number');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switch_status` SET TAGS ('dbx_business_glossary_term' = 'Switch Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switch_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|rejected|cancelled');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switch_type` SET TAGS ('dbx_business_glossary_term' = 'Switch Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switch_type` SET TAGS ('dbx_value_regex' = 'full|partial|systematic');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switching_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Switching Fee Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `switching_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Switching Fee Rate');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `tax_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Event Flag');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_switch` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` SET TAGS ('dbx_association_edges' = 'hr.employee,asset.fund');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `fund_management_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Management Assignment Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Management Assignment - Employee Id');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Management Assignment - Fund Id');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `primary_manager_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Manager Indicator');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `responsibility_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Allocation Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Management Role Type');
ALTER TABLE `banking_ecm`.`asset`.`fund_management_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` SET TAGS ('dbx_subdomain' = 'compliance_risk');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` SET TAGS ('dbx_association_edges' = 'asset.fund,risk.risk_factor');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `fund_risk_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Risk Exposure Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Risk Exposure - Risk Factor Id');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Risk Exposure - Fund Id');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `contribution_to_var` SET TAGS ('dbx_business_glossary_term' = 'Contribution to Value at Risk');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Status');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `factor_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Exposure Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `factor_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Sensitivity');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `hedge_ratio` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Measurement Date');
ALTER TABLE `banking_ecm`.`asset`.`fund_risk_exposure` ALTER COLUMN `stress_scenario_impact` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Impact');
