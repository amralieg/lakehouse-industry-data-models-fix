-- Schema for Domain: asset | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`asset` COMMENT 'Fund and asset management covering mutual funds, ETFs, hedge funds, pension funds, fund accounting, NAV calculation, fund distribution, investor servicing, transfer agency, and fund regulatory reporting. Manages the full fund lifecycle from launch through liquidation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique identifier for the investment fund. Primary key for the fund entity.',
    `party_id` BIGINT COMMENT 'Unique identifier for the external auditor responsible for auditing the funds financial statements.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fund base currency is fundamental to NAV calculation, performance reporting, and investor statements. Every fund must have a base currency for accounting consolidation and regulatory reporting (UCITS,',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Fund-level benchmark is mandatory for KIID/UCITS disclosure, performance attribution reporting, and regulatory filings. fund.benchmark_index is a denormalized text field; replacing with FK to security',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Funds are attributed to cost centers for management accounting, expense allocation, and transfer pricing. Asset management operations require cost center attribution at fund level for P&L reporting, m',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Fund domicile determines regulatory framework (Luxembourg UCITS, Irish QIF, Cayman SPC), tax treatment, and supervisory authority. Critical for compliance, licensing, and legal structure.',
    `fund_party_id` BIGINT COMMENT 'Unique identifier for the custodian bank responsible for safekeeping the funds assets.',
    `fund_transfer_agent_party_id` BIGINT COMMENT 'Unique identifier for the transfer agent responsible for maintaining shareholder records and processing subscriptions and redemptions.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Funds are established under specific legal entities for regulatory capital requirements, tax reporting, and consolidated financial statements. Essential for IFRS/GAAP consolidation and regulatory repo',
    `master_fund_id` BIGINT COMMENT 'Self-referencing FK on fund (master_fund_id)',
    `primary_umbrella_fund_id` BIGINT COMMENT 'Unique identifier for the parent umbrella fund structure if this fund is a sub-fund within a larger umbrella arrangement. Null if the fund is standalone.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Funds must be classified against the authoritative product type registry for regulatory capital treatment (Basel RWA), IFRS9 portfolio segmentation, FATCA/CRS reportability, and fee schedule assignmen',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Funds are attributed to profit centers for revenue attribution and segment reporting. Investment banking/asset management operations require profit center attribution at fund level for IFRS 8 segment ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Funds undergo regulatory stress testing (CCAR for bank-owned funds, AIFMD Article 15 stress tests, UCITS stress testing guidelines). Links fund to applicable stress scenarios. Real process: fund-level',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Each fund maintains a dedicated investment subledger for NAV accounting. The fund-to-subledger link is fundamental for subledger-to-GL reconciliation (SOX control), period-close processing, and audit ',
    `asset_class` STRING COMMENT 'The primary asset class in which the fund invests: equity, fixed income, money market, multi-asset, alternative investments, or real estate.. Valid values are `equity|fixed_income|money_market|multi_asset|alternative|real_estate`',
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
    `base_fund_class_id` BIGINT COMMENT 'Self-referencing FK on fund_class (base_fund_class_id)',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Share class benchmark is required for KIID/PRIIPS disclosure at the class level (e.g., hedged vs unhedged classes may reference different benchmarks). fund_class.benchmark_index is a denormalized text',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Share class currency denomination (USD, EUR, GBP hedged classes) drives pricing, FX hedging strategy, and investor suitability. Essential for multi-currency fund structures and currency overlay manage',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Each fund share class has a specific dealing calendar that determines valid subscription and redemption dates. The dealing_cutoff_time and dealing_frequency on fund_class are only meaningful relative ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Share class domicile may differ from umbrella fund (e.g., Irish umbrella with Luxembourg share class). Determines tax treatment, withholding obligations, and regulatory reporting requirements.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Fund classes can be registered in different jurisdictions than the parent fund (e.g., Luxembourg SICAV with Irish-domiciled share classes). AIFMD and UCITS regulatory reporting, netting enforceability',
    `fund_id` BIGINT COMMENT 'Reference to the parent fund to which this share class belongs. A fund may have multiple classes with different fee structures and currencies targeting different investor segments.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Share classes may be domiciled in different legal entities for tax optimization (e.g., offshore vs onshore classes). Required for entity-level financial reporting and tax provision calculations.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Fund share classes can have distinct regulatory classifications (e.g., retail UCITS vs. institutional AIF class). product_type provides authoritative regulatory_product_category_ifrs9 and FATCA/CRS re',
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
    `fund_class_id` BIGINT COMMENT 'Reference to the specific share class or unit class within the fund for which this NAV applies.',
    `fund_id` BIGINT COMMENT 'Reference to the fund for which this NAV is calculated.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: NAV calculation occurs only on valid dealing days per fund calendar. Business day validation is critical for pricing accuracy, investor dealing, and regulatory compliance (UCITS dealing frequency rule',
    `party_id` BIGINT COMMENT 'Reference to the fund accountant or transfer agent responsible for calculating and certifying this NAV.',
    `previous_nav_record_id` BIGINT COMMENT 'Reference to the prior NAV record for this fund class, enabling time-series analysis and change tracking. Null for the first NAV record.',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Fixed income fund NAV calculation uses a specific yield curve for bond pricing on each valuation date. Fund accountants and auditors require this link to reproduce NAV calculations, satisfy IFRS 13 fa',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fund holdings are snapshotted at period-end for NAV calculation, financial statement disclosure, and regulatory reporting (UCITS, AIFMD). Linking holdings to accounting_period enables period-over-peri',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Holdings affected by corporate actions (dividends, splits, mergers) require direct linkage for entitlement calculation, position adjustment, and income accrual. Essential for accurate NAV and investor',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Fund holdings of debt instruments require counterparty credit ratings for risk monitoring and regulatory reporting (UCITS 5/10/40 rules, AIFMD risk management). Real process: credit risk assessment of',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Geographic risk exposure reporting for UCITS 5/10/40 rules, concentration limits, and country risk monitoring. Regulatory requirement for diversification compliance and risk management.',
    `debt_issuance_id` BIGINT COMMENT 'Foreign key linking to treasury.debt_issuance. Business justification: Basel III requires banks to deduct own-issued debt held in their funds from regulatory capital. Linking fund_holding to debt_issuance enables identification and reporting of self-held issuances for ca',
    `derivative_id` BIGINT COMMENT 'Foreign key linking to security.derivative. Business justification: When holding is derivative, direct link enables margin calculation, counterparty exposure aggregation, regulatory reporting (EMIR, Dodd-Frank), and derivatives usage compliance (UCITS commitment appro',
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
    `previous_fund_holding_id` BIGINT COMMENT 'Self-referencing FK on fund_holding (previous_fund_holding_id)',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Holdings require specific price record reference for NAV calculation audit trail, pricing source verification, fair value hierarchy compliance (IFRS 13), and pricing challenge resolution.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Floating rate fixed income and derivative holdings in a fund are valued using specific benchmark rates (SOFR, EURIBOR). Daily mark-to-market valuation, accrued income calculation, and risk reporting r',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Sector exposure reporting (GICS, ICB) for risk analytics, concentration monitoring, and investment mandate compliance. Essential for sector allocation analysis and style drift detection.',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Holdings require credit rating reference for investment mandate compliance (investment-grade only), UCITS eligibility (rated debt), risk weighting, and credit risk reporting. Essential for fixed incom',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Fixed income holdings require yield curve reference for mark-to-market valuation, duration calculation, scenario analysis, and interest rate risk reporting. Essential for bond portfolio analytics.',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fund transactions must be booked to a specific accounting period for period-close processing, financial statement preparation, and regulatory reporting. Asset managers require period-level transaction',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Broker BIC for settlement instructions, SWIFT messaging, and trade confirmation matching. Critical for straight-through processing and payment routing.',
    `broker_id` BIGINT COMMENT 'Identifier of the broker or counterparty through which the transaction was executed. Links to broker master entity.',
    `corporate_action_id` BIGINT COMMENT 'Identifier linking this transaction to a corporate action event such as dividend, stock split, merger, or rights issue.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Fund transactions are attributed to cost centers for management accounting and P&L reporting. Required for expense allocation, transfer pricing, and management fee calculation in asset management oper',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Trade settlement FX rate for accounting entries and realized gain/loss calculation. Links to official rates for audit trail and fair value compliance.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund to which this transaction belongs. Links to the fund master entity.',
    `instrument_id` BIGINT COMMENT 'Identifier of the financial instrument involved in the transaction. Links to security master for equities, bonds, derivatives, etc.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Transaction-level issuer tracking enables real-time compliance monitoring for issuer concentration limits, pre-trade checks, and post-trade breach detection. Essential for automated investment restric',
    `listing_id` BIGINT COMMENT 'Foreign key linking to security.listing. Business justification: Transactions executed on specific exchanges require listing reference for transaction cost analysis (TCA), best execution reporting (MiFID II RTS 27/28), and venue selection audit trail.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the portfolio within the fund where this transaction occurred. Links to portfolio master entity.',
    `party_id` BIGINT COMMENT 'Identifier of the custodian bank holding the securities for this transaction. Links to custodian master entity.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Transactions reference specific price records for trade valuation verification, fair value compliance, best execution analysis, and audit trail. Links transaction to market data source and pricing met',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Fund transactions are attributed to profit centers for revenue recognition and P&L reporting. Required for IFRS 8 segment reporting, management reporting, and RAROC calculations. Asset managers track ',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: Fund transactions include unit cancellation entries triggered by investor redemptions. Linking redemption_id to the originating redemption record creates a direct audit trail from the portfolio accoun',
    `reversal_fund_transaction_id` BIGINT COMMENT 'Self-referencing FK on fund_transaction (reversal_fund_transaction_id)',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Fund subscription/redemption settlements generate deposit account debits/credits. Operations and finance teams reconcile fund_transactions to account_transactions for settlement confirmation, break re',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement occurs only on valid business days per market calendar (T+2, T+3). Critical for settlement date calculation, failed trade detection, and custodian reconciliation.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: Fund transactions include unit creation entries triggered by investor subscriptions. Linking subscription_id to the originating subscription record creates a direct audit trail from the portfolio acco',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade execution currency for settlement, broker confirmation matching, and cash management. Essential for multi-currency trading and FX exposure tracking.',
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
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Investor account origination channel is required for AML source-of-business reporting, channel attribution analytics, and regulatory audit. Banks must record through which channel (branch, digital, ad',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Investor accounts are opened under a specific legal entity (fund management company or custodian). Required for CRS/FATCA regulatory reporting, AML compliance, and legal entity-level financial reporti',
    `onboarding_case_id` BIGINT COMMENT 'Foreign key linking to customer.onboarding_case. Business justification: Investor account opening is the direct outcome of a customer onboarding case (onboarding_case.product_applied_for). Fund administrators must trace each investor account back to its originating onboard',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: Digital onboarding compliance and fraud prevention require capturing the exact session during which an investor account was opened online. Role-prefix opening_ distinguishes this from any future ses',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Investor accounts must link to customer.party for KYC/AML compliance, regulatory reporting (FATCA/CRS), beneficial ownership verification, and consolidated customer view across banking and asset manag',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Fund subscription/redemption settlement and distribution payments require linking the investor account to its designated deposit account. Regulatory AML/KYC and operational settlement processes depend',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Tax residency determines FATCA, CRS reporting obligations, withholding tax rates, and treaty benefits. Regulatory mandate for tax compliance and investor classification.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: CRS and FATCA regulatory reporting obligations are determined at jurisdiction level, not just country level. investor_account.crs_reportable_flag and fatca_status require the authoritative jurisdictio',
    `account_closure_date` DATE COMMENT 'Date when the account was formally closed. Null for active accounts. Closed accounts retain historical data for regulatory retention periods.',
    `account_number` STRING COMMENT 'Externally visible account number assigned to the investor account. Used for client communications and statements.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_opening_date` DATE COMMENT 'Date when the investor account was first opened and activated in the transfer agency system. Marks the start of the account lifecycle.',
    `account_status` STRING COMMENT 'Current lifecycle status of the investor account. Controls transaction permissions and servicing activities.. Valid values are `active|suspended|closed|pending_opening|dormant|restricted`',
    `aml_risk_rating` STRING COMMENT 'Risk classification assigned by AML screening and monitoring processes. Determines enhanced due diligence requirements and transaction monitoring thresholds.. Valid values are `low|medium|high|prohibited`',
    `beneficial_owner_count` STRING COMMENT 'Number of underlying beneficial owners represented by this account. Applicable for omnibus and nominee accounts. Null for direct retail accounts.',
    `closure_reason` STRING COMMENT 'Reason code for account closure. Used for operational analytics and regulatory reporting.. Valid values are `investor_request|zero_balance|regulatory|deceased|duplicate|fraud`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the investor account record was first created in the transfer agency database. Audit trail field.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether the account is reportable under CRS automatic exchange of information requirements. True if reportable to foreign tax authorities.',
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
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch-level fund sales reporting and regulatory origination tracking require knowing which branch originated each subscription. Banks must report fund distribution by branch for sales performance man',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Subscriptions are placed through specific banking channels (digital, branch, contact center). Essential for channel attribution, performance tracking, and commission calculation. Replaces denormalized',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Subscription payment currency for settlement, FX conversion, and unit allocation. Essential for multi-currency dealing and cash reconciliation.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: The specific price record used to calculate dealing NAV for unit allotment is a mandatory audit trail item for trade confirmation, investor statements, and regulatory reporting (UCITS/AIFMD). Role-pre',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific share class of the fund being subscribed to (e.g., Class A, Class I, Institutional). Different classes may have different fee structures and minimum investment requirements.',
    `fund_id` BIGINT COMMENT 'Reference to the fund being subscribed to. Links to the fund master record.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Subscriptions in kind (securities as payment) require instrument reference for valuation, settlement, and tax lot creation. Real business scenario for institutional share classes and seed capital.',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account placing the subscription order. Links to the investor account master record.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Subscriptions generate journal entries for cash receipt and unit issuance (debit cash, credit equity). Required for daily cash reconciliation, NAV calculation, and financial statement preparation.',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: Subscription AML clearance (subscription.aml_clearance_status/date) must reference the specific KYC record version active at order time. Regulators require fund administrators to evidence which KYC re',
    `listing_id` BIGINT COMMENT 'Foreign key linking to security.listing. Business justification: ETF subscription orders are executed on a specific exchange listing, determining settlement currency, settlement cycle, tick size, and regulatory reporting venue. Order management and settlement syste',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: A subscription is priced at a specific published NAV. Linking nav_record_id to the authoritative nav_record used for unit allotment pricing creates a direct audit trail from the subscription order to ',
    `party_id` BIGINT COMMENT 'Reference to the financial intermediary, broker-dealer, or registered investment advisor (RIA) through whom the subscription was placed. Null if direct investor order.',
    `reversal_subscription_id` BIGINT COMMENT 'Self-referencing FK on subscription (reversal_subscription_id)',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: AML audit trail and digital fraud detection require linking each fund subscription order to the exact digital session in which it was placed. Regulators and compliance teams use session-level data to ',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Subscription settlement on valid business days per fund calendar. Critical for dealing deadline enforcement, NAV application, and transfer agency SLA compliance.',
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
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: Branch-level redemption reporting and AML source-of-business tracking require knowing which branch processed each redemption. Compliance and operations teams use this for branch performance reporting,',
    `broker_id` BIGINT COMMENT 'Reference to the broker, distributor, or financial advisor who submitted the redemption order on behalf of the investor.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Redemptions are processed through banking channels. Critical for operational routing, SLA management, channel performance measurement, and regulatory reporting. Replaces denormalized order_channel cod',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Redemption proceeds currency for payment processing, FX conversion, and investor settlement. Required for multi-currency redemption handling and cash management.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: The specific price record used to calculate redemption proceeds is a mandatory audit trail for investor statements, tax reporting, and regulatory oversight (UCITS/AIFMD). Role-prefix dealing_ distin',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific share class or unit class within the fund being redeemed (e.g., Class A, Class I, Institutional).',
    `fund_id` BIGINT COMMENT 'Reference to the mutual fund, ETF, hedge fund, or pension fund from which redemption is requested.',
    `investor_account_id` BIGINT COMMENT 'Reference to the investor account from which units or shares are being redeemed.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Redemptions generate journal entries for cash payment and unit cancellation (debit equity, credit cash). Required for daily cash reconciliation, NAV calculation, and financial statement preparation.',
    `listing_id` BIGINT COMMENT 'Foreign key linking to security.listing. Business justification: ETF redemption orders are executed on a specific exchange listing, determining settlement currency, settlement cycle, and regulatory reporting venue. Settlement and compliance systems require this FK ',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: A redemption is settled at a specific published NAV. Linking nav_record_id to the authoritative nav_record used for unit redemption pricing provides a direct audit trail. dealing_nav is retained as an',
    `reversal_redemption_id` BIGINT COMMENT 'Self-referencing FK on redemption (reversal_redemption_id)',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: AML monitoring and fraud detection for fund redemptions require the exact digital session context. Compliance teams must verify authentication level and device fingerprint at time of redemption order,',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Redemption settlement on valid business days per fund calendar. Critical for payment timing, liquidity management, and transfer agency SLA compliance.',
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
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Fund distributions triggered by underlying security corporate actions (dividend pass-through, rights issues) require this link for income attribution, withholding tax processing, and regulatory income',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Distribution payment currency for dividend/income payments, withholding tax calculation, and investor settlement. Essential for distribution processing and tax reporting.',
    `fund_class_id` BIGINT COMMENT 'Reference to the specific fund share class for which the distribution is declared.',
    `fund_id` BIGINT COMMENT 'Reference to the fund declaring the distribution.',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: A distribution event references a specific NAV record for reinvestment pricing (the reinvestment_nav field captures the NAV at which distributions are reinvested into additional units). Linking nav_re',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Fund distributions (dividends, income) credited to investor deposit accounts generate account_transactions. Operations reconcile distribution_events to account_transactions for payment confirmation, t',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Distribution payments made on valid business days per fund calendar. Required for payment scheduling, cash management, and investor servicing.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Fund distribution cash disbursements are executed as payment transactions. Fund administrators reconcile distribution payments against payment_transaction records for regulatory reporting (Form 1099-D',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: The specific price record used for dividend reinvestment unit allotment is required for tax lot tracking, Form 1099-DIV reporting, and investor cost basis calculations. distribution_event.reinvestment',
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

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`unit_register` (
    `unit_register_id` BIGINT COMMENT 'Unique identifier for the unit register record. Primary key for the authoritative unit/share register.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: The unit register is closed and snapshotted at each accounting period-end for unitholder reporting, CRS/FATCA regulatory filings, and financial statement disclosure of units outstanding. Period-end un',
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
    CONSTRAINT pk_unit_register PRIMARY KEY(`unit_register_id`)
) COMMENT 'Authoritative unit/share register record maintaining the current and historical unit holdings for each investor account in each fund class. Captures investor account, fund class, units held, average cost per unit, total cost basis, unrealized gain/loss, first investment date, last transaction date, and register status. Serves as the legal record of fund ownership and is the SSOT for investor unit balances used in redemption processing and distribution calculations.';

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_mandate` (
    `fund_mandate_id` BIGINT COMMENT 'Unique identifier for the fund mandate record. Primary key.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Fund investment mandates must align with sponsors risk appetite framework, especially for bank-owned funds and pension funds. Required for governance and risk appetite cascading. Real process: ensuri',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Investment mandates specify benchmark indices for performance measurement, tracking error limits, and compliance monitoring. Essential for mandate governance and performance attribution in asset manag',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: In multi-class fund structures, investment mandates can be defined at the share class level (e.g., hedged vs. unhedged classes may have different currency hedging mandates, or institutional vs. retail',
    `fund_id` BIGINT COMMENT 'Reference to the fund to which this mandate applies.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Mandates may restrict or require specific issuers (government bonds only, investment-grade corporates, exclude tobacco/weapons). Direct issuer link enables mandate compliance monitoring and pre-trade ',
    `previous_fund_mandate_id` BIGINT COMMENT 'Self-referencing FK on fund_mandate (previous_fund_mandate_id)',
    `party_id` BIGINT COMMENT 'Reference to the investment manager or portfolio manager responsible for executing the mandate.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Fund mandates specify which stress scenarios must be applied for mandate compliance testing (e.g., UCITS/AIFMD require funds to demonstrate resilience under defined stress scenarios). Mandate document',
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
    `classification_id` BIGINT COMMENT 'Foreign key linking to security.classification. Business justification: Investment restrictions are frequently defined by security classification category (e.g., no complex products, no sub-investment-grade instruments, SFDR Article 8/9 constraints). Compliance monito',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Investment restrictions can be applied at the share class level, not just the fund level. For example, investor eligibility restrictions, SFDR classification constraints, or currency exposure limits m',
    `fund_id` BIGINT COMMENT 'Identifier of the fund to which this investment restriction applies.',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Investment restrictions enforce mandate limits (concentration, credit quality, duration). Link ties restriction rules to the mandate they implement, enabling mandate-level compliance monitoring and br',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Investment restrictions are frequently defined at the individual instrument level (e.g., no more than 5% in ISIN XS1234567890). Compliance monitoring systems require this FK to perform automated pre',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Restrictions frequently target specific issuers (sanctioned entities, excluded sectors, related party transactions). Direct issuer link enables automated pre-trade checks and issuer-level exposure mon',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Jurisdiction-specific investment limits (EU UCITS, US 40 Act, Cayman CIMA rules). Required for multi-jurisdiction fund compliance and regulatory reporting.',
    `managed_portfolio_id` BIGINT COMMENT 'Identifier of the portfolio subject to this restriction rule.',
    `primary_superseded_by_restriction_investment_restriction_id` BIGINT COMMENT 'Identifier of the restriction rule that supersedes this one. Null if this is the current version.',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Investment restrictions operationalize risk limits at fund level (concentration limits, VaR limits, leverage limits). Required for limit monitoring and breach management. Real process: translating ent',
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

CREATE OR REPLACE TABLE `banking_ecm`.`asset`.`fund_performance` (
    `fund_performance_id` BIGINT COMMENT 'Unique identifier for the fund performance record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fund performance records are aligned to accounting periods for GIPS-compliant reporting, MiFID II cost and charges disclosure, and regulatory filings. Period-level performance attribution requires lin',
    `nav_record_id` BIGINT COMMENT 'Foreign key linking to asset.nav_record. Business justification: Fund performance is calculated between two NAV points. beginning_nav_record_id links to the nav_record representing the start-of-period NAV used in TWR/MWR calculations. This creates a direct audit tr',
    `benchmark_id` BIGINT COMMENT 'Identifier of the benchmark index used for performance comparison (e.g., S&P 500, MSCI World, Bloomberg Barclays Aggregate).',
    `fund_class_id` BIGINT COMMENT 'Identifier of the specific fund share class (e.g., Class A, Class I, Institutional) for which performance is calculated.',
    `fund_id` BIGINT COMMENT 'Identifier of the fund for which performance is being measured.',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Fund performance must be evaluated against the investment mandate in effect during the performance period. Linking fund_mandate_id to fund_mandate enables direct comparison of actual returns against m',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Performance metrics currency denomination for return calculation and peer comparison. Essential for GIPS compliance and performance attribution.',
    `previous_fund_performance_id` BIGINT COMMENT 'Self-referencing FK on fund_performance (previous_fund_performance_id)',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Sharpe ratio, Sortino ratio, and GIPS-compliant performance reporting require identifying the specific risk-free rate benchmark used (e.g., SOFR, Fed Funds). risk_free_rate_pct is a denormalized value',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Performance attribution under stress scenarios measures risk-adjusted returns and worst-case performance. Required for AIFMD stress testing disclosure and investor reporting. Real process: stressed pe',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Performance attribution for fixed income funds requires yield curve data for return decomposition (carry, rolldown, spread, curve shift). Essential for explaining bond portfolio returns to investors.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_master_fund_id` FOREIGN KEY (`master_fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund` ADD CONSTRAINT `fk_asset_fund_primary_umbrella_fund_id` FOREIGN KEY (`primary_umbrella_fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_base_fund_class_id` FOREIGN KEY (`base_fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ADD CONSTRAINT `fk_asset_fund_class_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ADD CONSTRAINT `fk_asset_nav_record_previous_nav_record_id` FOREIGN KEY (`previous_nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ADD CONSTRAINT `fk_asset_fund_holding_previous_fund_holding_id` FOREIGN KEY (`previous_fund_holding_id`) REFERENCES `banking_ecm`.`asset`.`fund_holding`(`fund_holding_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_reversal_fund_transaction_id` FOREIGN KEY (`reversal_fund_transaction_id`) REFERENCES `banking_ecm`.`asset`.`fund_transaction`(`fund_transaction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ADD CONSTRAINT `fk_asset_fund_transaction_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`subscription` ADD CONSTRAINT `fk_asset_subscription_reversal_subscription_id` FOREIGN KEY (`reversal_subscription_id`) REFERENCES `banking_ecm`.`asset`.`subscription`(`subscription_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`redemption` ADD CONSTRAINT `fk_asset_redemption_reversal_redemption_id` FOREIGN KEY (`reversal_redemption_id`) REFERENCES `banking_ecm`.`asset`.`redemption`(`redemption_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ADD CONSTRAINT `fk_asset_distribution_event_reversal_distribution_event_id` FOREIGN KEY (`reversal_distribution_event_id`) REFERENCES `banking_ecm`.`asset`.`distribution_event`(`distribution_event_id`);
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ADD CONSTRAINT `fk_asset_unit_register_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ADD CONSTRAINT `fk_asset_unit_register_investor_account_id` FOREIGN KEY (`investor_account_id`) REFERENCES `banking_ecm`.`asset`.`investor_account`(`investor_account_id`);
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ADD CONSTRAINT `fk_asset_unit_register_previous_asset_unit_register_id` FOREIGN KEY (`previous_asset_unit_register_id`) REFERENCES `banking_ecm`.`asset`.`unit_register`(`unit_register_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ADD CONSTRAINT `fk_asset_fund_mandate_previous_fund_mandate_id` FOREIGN KEY (`previous_fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ADD CONSTRAINT `fk_asset_investment_restriction_primary_superseded_by_restriction_investment_restriction_id` FOREIGN KEY (`primary_superseded_by_restriction_investment_restriction_id`) REFERENCES `banking_ecm`.`asset`.`investment_restriction`(`investment_restriction_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_nav_record_id` FOREIGN KEY (`nav_record_id`) REFERENCES `banking_ecm`.`asset`.`nav_record`(`nav_record_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_fund_class_id` FOREIGN KEY (`fund_class_id`) REFERENCES `banking_ecm`.`asset`.`fund_class`(`fund_class_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `banking_ecm`.`asset`.`fund`(`fund_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_fund_mandate_id` FOREIGN KEY (`fund_mandate_id`) REFERENCES `banking_ecm`.`asset`.`fund_mandate`(`fund_mandate_id`);
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ADD CONSTRAINT `fk_asset_fund_performance_previous_fund_performance_id` FOREIGN KEY (`previous_fund_performance_id`) REFERENCES `banking_ecm`.`asset`.`fund_performance`(`fund_performance_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`asset` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `banking_ecm`.`asset`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `fund_transfer_agent_party_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Agent Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `master_fund_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `primary_umbrella_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Umbrella Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Primary Asset Class');
ALTER TABLE `banking_ecm`.`asset`.`fund` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|money_market|multi_asset|alternative|real_estate');
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
ALTER TABLE `banking_ecm`.`asset`.`fund_class` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `base_fund_class_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Dealing Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_class` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`nav_record` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Value (NAV) Record Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Accountant Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `previous_nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Net Asset Value (NAV) Record Identifier');
ALTER TABLE `banking_ecm`.`asset`.`nav_record` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `fund_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Holding Identifier');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Of Risk Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `debt_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `previous_fund_holding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Sector Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Security Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_holding` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `fund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `reversal_fund_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`investor_account` SET TAGS ('dbx_subdomain' = 'investor_account');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Opening Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investor_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Residency Jurisdiction Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`subscription` SET TAGS ('dbx_subdomain' = 'investor_account');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Dealing Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Identifier');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `reversal_subscription_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`subscription` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`redemption` SET TAGS ('dbx_subdomain' = 'investor_account');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Dealing Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Identifier');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `reversal_redemption_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`redemption` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Holiday Calendar Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` SET TAGS ('dbx_subdomain' = 'investor_account');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Account Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`distribution_event` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Reinvestment Price Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`unit_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` SET TAGS ('dbx_subdomain' = 'investor_account');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `unit_register_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Register ID');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class ID');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account ID');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `previous_asset_unit_register_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `average_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `beneficial_owner_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Flag');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `current_market_value` SET TAGS ('dbx_business_glossary_term' = 'Current Market Value');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `current_nav_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Current Net Asset Value (NAV) Per Unit');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `distribution_option` SET TAGS ('dbx_business_glossary_term' = 'Distribution Option');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `distribution_option` SET TAGS ('dbx_value_regex' = 'reinvest|cash|partial_reinvest');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `escheatment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Due Date');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `escheatment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Eligible Flag');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'exempt|participating_ffi|non_participating_ffi|us_person|recalcitrant|not_applicable');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `first_investment_date` SET TAGS ('dbx_business_glossary_term' = 'First Investment Date');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `last_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Type');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `last_transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|redemption|exchange_in|exchange_out|dividend_reinvestment|distribution');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `omnibus_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Omnibus Account Flag');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `record_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Closed Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `register_status` SET TAGS ('dbx_business_glossary_term' = 'Register Status');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `register_status` SET TAGS ('dbx_value_regex' = 'active|closed|suspended|pending_closure|restricted');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `restriction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiry Date');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Lot Method');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `tax_lot_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|average_cost|specific_identification|highest_cost');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `total_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Total Cost Basis');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `total_distributions_received` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Received');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `total_distributions_reinvested` SET TAGS ('dbx_business_glossary_term' = 'Total Distributions Reinvested');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `units_held` SET TAGS ('dbx_business_glossary_term' = 'Units Held');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `banking_ecm`.`asset`.`unit_register` ALTER COLUMN `unrealized_gain_loss_percentage` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `previous_fund_mandate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`asset`.`fund_mandate` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `investment_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Restriction ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `primary_superseded_by_restriction_investment_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Restriction ID');
ALTER TABLE `banking_ecm`.`asset`.`investment_restriction` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` SET TAGS ('dbx_subdomain' = 'fund_operations');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Performance ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `nav_record_id` SET TAGS ('dbx_business_glossary_term' = 'Beginning Nav Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Nav Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `previous_fund_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Free Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `sharpe_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sharpe Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `sortino_ratio` SET TAGS ('dbx_business_glossary_term' = 'Sortino Ratio');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `total_return_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Return Amount');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `tracking_error_pct` SET TAGS ('dbx_business_glossary_term' = 'Tracking Error Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `turnover_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Turnover Ratio Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `twr_gross_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR) Gross Return Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `twr_net_return_pct` SET TAGS ('dbx_business_glossary_term' = 'Time-Weighted Return (TWR) Net Return Percentage');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`asset`.`fund_performance` ALTER COLUMN `volatility_pct` SET TAGS ('dbx_business_glossary_term' = 'Volatility (Standard Deviation) Percentage');
