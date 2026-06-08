-- Schema for Domain: reference | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`reference` COMMENT 'Centralized golden source for all enterprise reference and master data including currency codes (ISO 4217), country codes, interest rate benchmarks (SOFR, LIBOR transition), instrument classification codes (ISIN, CUSIP, SEDOL, FIGI), exchange rates, holiday calendars, BIC codes, market data, and regulatory reporting taxonomies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`currency` (
    `currency_id` BIGINT COMMENT 'Unique identifier for the currency record. Primary key.',
    `benchmark_rate_type` STRING COMMENT 'The primary interest rate benchmark associated with this currency (e.g., Secured Overnight Financing Rate (SOFR) for USD, Euro Short-Term Rate (ESTR) for EUR, Sterling Overnight Index Average (SONIA) for GBP). Used for pricing loans, derivatives, and other financial instruments. Reflects the transition from London Interbank Offered Rate (LIBOR) to alternative reference rates.',
    `central_bank_name` STRING COMMENT 'Name of the central bank or monetary authority responsible for issuing and regulating this currency (e.g., Federal Reserve System for USD, European Central Bank for EUR, Bank of England for GBP). Used for regulatory reporting and monetary policy reference.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this currency record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_name` STRING COMMENT 'Full official name of the currency (e.g., United States Dollar, Euro, British Pound Sterling, Japanese Yen).',
    `currency_status` STRING COMMENT 'Current lifecycle status of the currency. Active currencies are currently in circulation and available for transactions. Inactive currencies are temporarily suspended. Deprecated currencies are being phased out (e.g., legacy currencies replaced by EUR). Historical currencies are no longer in use but retained for historical transaction reference. Pending currencies are approved but not yet in circulation.. Valid values are `active|inactive|deprecated|historical|pending`',
    `currency_type` STRING COMMENT 'Classification of the currency by its fundamental nature. Fiat currencies are government-issued legal tender. Commodity currencies are backed by physical commodities. Digital currencies include cryptocurrencies and central bank digital currencies. Fund represents investment fund units. Special Drawing Right (SDR) is the International Monetary Fund (IMF) reserve asset.. Valid values are `fiat|commodity|digital|fund|special_drawing_right`',
    `effective_from_date` DATE COMMENT 'Date from which this currency record becomes effective and available for use in financial transactions. For new currencies, this is the introduction date. For currency updates, this is the date the change takes effect.',
    `effective_to_date` DATE COMMENT 'Date until which this currency record is effective. Nullable for currently active currencies with no planned end date. For deprecated or historical currencies, this represents the date the currency ceased to be legal tender or was replaced.',
    `is_base_currency` BOOLEAN COMMENT 'Indicates whether this currency serves as a base currency for the enterprises financial reporting and consolidation. Typically the functional currency of the parent company. Used for General Ledger (GL) consolidation and financial statement preparation.',
    `is_convertible` BOOLEAN COMMENT 'Indicates whether this currency is freely convertible on international foreign exchange markets without significant restrictions. True for major reserve currencies and freely traded currencies. False for currencies with limited convertibility or capital controls.',
    `is_crypto_currency` BOOLEAN COMMENT 'Indicates whether this is a cryptocurrency or digital asset rather than a fiat currency issued by a central bank. Used to apply different regulatory treatment, risk controls, and processing rules for digital assets.',
    `is_fund_currency` BOOLEAN COMMENT 'Indicates whether this currency code represents a fund or investment vehicle unit rather than a traditional currency. Used for mutual funds, exchange-traded funds, and other investment products that have their own unit pricing.',
    `is_legal_tender` BOOLEAN COMMENT 'Indicates whether this currency is currently recognized as legal tender in its issuing jurisdiction. True for currencies that must be accepted for payment of debts. False for commemorative, historical, or non-legal tender currencies.',
    `is_precious_metal` BOOLEAN COMMENT 'Indicates whether this currency code represents a precious metal (e.g., XAU for gold, XAG for silver, XPT for platinum) used as a store of value or trading instrument. ISO 4217 includes codes for precious metals alongside traditional currencies.',
    `is_restricted` BOOLEAN COMMENT 'Indicates whether this currency is subject to capital controls, exchange restrictions, or regulatory limitations that restrict its convertibility or cross-border movement. True for currencies with government-imposed restrictions. Used for compliance and risk management.',
    `iso_code` STRING COMMENT 'Three-letter alphabetic currency code as defined by ISO 4217 standard (e.g., USD, EUR, GBP, JPY). This is the primary business identifier used across all financial systems for currency denomination.. Valid values are `^[A-Z]{3}$`',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country or jurisdiction that issues this currency (e.g., USA for USD, DEU for EUR in Germany context). For supranational currencies like EUR, this may represent the primary issuing authority or be left as a representative member state.. Valid values are `^[A-Z]{3}$`',
    `last_revaluation_date` DATE COMMENT 'Date when currency balances denominated in this currency were last revalued for financial reporting purposes. Used in foreign currency revaluation processes for General Ledger (GL) and to track compliance with accounting standards requiring periodic revaluation.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this currency record was last modified. Used for audit trail, change tracking, and data synchronization across systems.',
    `minor_unit` STRING COMMENT 'Number of decimal places used for the currencys minor unit. Indicates the relationship between the major currency unit and its minor unit (e.g., 2 for USD cents, 0 for JPY which has no minor unit, 3 for certain Middle Eastern currencies). Critical for accurate financial calculations and rounding.',
    `notes` STRING COMMENT 'Free-form text field for additional information, special handling instructions, regulatory notes, or historical context about the currency. May include information about currency reforms, redenominations, or special processing requirements.',
    `numeric_code` STRING COMMENT 'Three-digit numeric currency code as defined by ISO 4217 standard (e.g., 840 for USD, 978 for EUR). Used in systems where alphabetic codes are not suitable.. Valid values are `^[0-9]{3}$`',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the relative importance or usage frequency of this currency within the enterprise. Lower numbers indicate higher priority. Used to determine default currencies, optimize system performance, and prioritize currency pair availability in FX trading systems.',
    `rounding_method` STRING COMMENT 'Standard rounding method to be applied for this currency in financial calculations. Standard uses mathematical rounding (0.5 rounds up). Bankers rounding rounds 0.5 to the nearest even number. Up always rounds up. Down always rounds down. Truncate drops decimal places without rounding. Critical for ensuring consistent calculation results across systems.. Valid values are `standard|bankers|up|down|truncate`',
    `settlement_lag_days` STRING COMMENT 'Standard number of business days required for settlement of foreign exchange (FX) transactions involving this currency. Typically 2 days (T+2) for major currencies, but can vary. Used for calculating settlement dates in FX trading and payment processing.',
    `source_system` STRING COMMENT 'Identifier of the source system or data provider from which this currency record originated (e.g., Core Banking System, Market Data Provider, ISO 4217 Registry). Used for data lineage and reconciliation.',
    `symbol` STRING COMMENT 'Graphical symbol used to represent the currency in financial displays and reports (e.g., $, €, £, ¥). Used for user interface presentation and customer-facing documents.',
    `version_number` STRING COMMENT 'Version number of this currency record, incremented with each update. Used for optimistic locking, change tracking, and maintaining historical versions of currency attributes.',
    CONSTRAINT pk_currency PRIMARY KEY(`currency_id`)
) COMMENT 'ISO 4217 currency master — authoritative golden record for all currencies used across the enterprise. Captures currency code, numeric code, minor unit (decimal places), currency name, issuing country, active/inactive status, and effective dates. Used by payments, FX, GL, and all financial domains for currency denomination and conversion.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`country` (
    `country_id` BIGINT COMMENT 'Unique identifier for the country record. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Countries have official currencies. The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve currency_name, minor_unit, and other curr',
    `ach_system_name` STRING COMMENT 'Name of the countrys automated clearing house system for retail payments (e.g., ACH for USA, Bacs for UK, SEPA for Eurozone). Used for batch payment processing, direct debit operations, and retail payment routing.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this country record is currently active and should be used in operational systems. Inactive countries are retained for historical reference but excluded from customer onboarding and new transaction processing.',
    `aml_risk_rating` STRING COMMENT 'Overall AML risk classification for the country based on regulatory framework strength, corruption indices, FATF assessments, and financial crime prevalence. Used in customer risk scoring, transaction monitoring thresholds, and enhanced due diligence triggers.. Valid values are `low|medium|high|very_high|prohibited`',
    `basel_committee_member_flag` BOOLEAN COMMENT 'Indicates whether the country is represented on the Basel Committee on Banking Supervision. Signals adoption of Basel III capital and liquidity standards, relevant for counterparty risk assessment and regulatory capital calculations.',
    `business_day_convention` STRING COMMENT 'Standard business day convention code used for financial calculations in this country (e.g., Following, Modified Following, Preceding). Used in interest accrual, payment scheduling, and derivative valuation.',
    `calling_code` STRING COMMENT 'International dialing prefix for the country (e.g., +1 for USA, +44 for UK). Used for phone number validation, customer contact data standardization, and communication routing.',
    `capital_city` STRING COMMENT 'Name of the countrys capital city. Used for geographic reference, branch location planning, and regulatory correspondence addressing.',
    `country_name` STRING COMMENT 'Official short-form name of the country in English (e.g., United States of America, United Kingdom, Germany). Used for customer-facing displays, reports, and regulatory filings.',
    `crs_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether the country is a CRS participating jurisdiction requiring automatic exchange of financial account information. Essential for global tax compliance and regulatory reporting.',
    `crs_reportable_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether accounts held by residents of this country must be reported under CRS. Used in customer classification and regulatory reporting workflows.',
    `eea_member_flag` BOOLEAN COMMENT 'Indicates whether the country is a member of the European Economic Area (EU plus Iceland, Liechtenstein, Norway). Relevant for passporting rights, regulatory equivalence, and data protection frameworks.',
    `effective_from_date` DATE COMMENT 'Date from which this country record becomes effective. Used for managing country code changes, new country creation, and historical data accuracy.',
    `effective_to_date` DATE COMMENT 'Date until which this country record is effective. Null for currently active countries. Used for managing country dissolution, mergers, or code changes (e.g., Yugoslavia, Czechoslovakia).',
    `eu_member_flag` BOOLEAN COMMENT 'Indicates whether the country is a current member of the European Union. Used for regulatory compliance (GDPR, MiFID II), cross-border payment processing (SEPA), and risk classification.',
    `fatca_giin_required_flag` BOOLEAN COMMENT 'Indicates whether financial institutions in this country must obtain a GIIN for FATCA compliance. Used in onboarding and due diligence processes for institutional counterparties.',
    `fatca_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether the country is a FATCA reporting jurisdiction requiring financial institutions to report US person accounts to the IRS. Critical for compliance with US tax regulations and customer onboarding workflows.',
    `fatf_high_risk_flag` BOOLEAN COMMENT 'Indicates whether the country is identified by FATF as a high-risk jurisdiction with strategic AML/CFT deficiencies. Triggers enhanced due diligence requirements and elevated risk ratings in customer onboarding and transaction monitoring.',
    `fatf_member_flag` BOOLEAN COMMENT 'Indicates whether the country is a member of the Financial Action Task Force. Used for assessing AML/CFT framework strength and country risk rating in financial crime compliance.',
    `iban_length` STRING COMMENT 'Standard length of IBAN for this country (e.g., 22 for Germany, 27 for France). Used for IBAN validation and account number format checking.',
    `iban_required_flag` BOOLEAN COMMENT 'Indicates whether IBAN format is required for bank account numbers in this country. Used for payment validation, account number formatting, and cross-border payment processing.',
    `intermediate_region` STRING COMMENT 'Intermediate-level geographic classification between region and sub-region where applicable (e.g., Caribbean, Channel Islands). Used for specialized regional analytics and compliance grouping.',
    `iso_alpha_2_code` STRING COMMENT 'Two-letter country code as defined by ISO 3166-1 alpha-2 standard (e.g., US, GB, DE). Primary business identifier for country lookup in KYC, AML, and regulatory reporting systems.. Valid values are `^[A-Z]{2}$`',
    `iso_alpha_3_code` STRING COMMENT 'Three-letter country code as defined by ISO 3166-1 alpha-3 standard (e.g., USA, GBR, DEU). Used in SWIFT messaging, trade finance, and cross-border payment processing.. Valid values are `^[A-Z]{3}$`',
    `iso_numeric_code` STRING COMMENT 'Three-digit numeric country code as defined by ISO 3166-1 numeric standard (e.g., 840 for USA, 826 for GBR). Used in systems requiring language-independent country representation.. Valid values are `^[0-9]{3}$`',
    `oecd_member_flag` BOOLEAN COMMENT 'Indicates whether the country is a member of the OECD. Used for assessing regulatory standards, tax treaty eligibility, and country risk classification.',
    `ofac_sanctions_flag` BOOLEAN COMMENT 'Indicates whether the country is subject to comprehensive OFAC sanctions programs. Critical for transaction screening, customer onboarding, and AML compliance.',
    `ofac_sanctions_program` STRING COMMENT 'Name of the specific OFAC sanctions program applicable to this country (e.g., Iran Sanctions, North Korea Sanctions). Used for detailed compliance screening and risk assessment.',
    `official_name` STRING COMMENT 'Official long-form name of the country including full legal designation (e.g., United States of America, United Kingdom of Great Britain and Northern Ireland). Used in legal contracts, regulatory submissions, and formal documentation.',
    `region` STRING COMMENT 'High-level geographic region classification (e.g., Americas, Europe, Asia, Africa, Oceania). Used for regional risk aggregation, portfolio analysis, and management reporting.',
    `risk_rating` STRING COMMENT 'Composite country risk rating incorporating political stability, economic strength, regulatory environment, and credit risk. Used for credit underwriting, exposure limits, provisioning calculations (ECL), and portfolio risk management.. Valid values are `low|medium|high|very_high`',
    `rtgs_system_name` STRING COMMENT 'Name of the countrys real-time gross settlement system for high-value payments (e.g., Fedwire for USA, CHAPS for UK, TARGET2 for Eurozone). Used for payment routing, liquidity management, and settlement risk assessment.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for securities transactions in this country (e.g., T+1, T+2, T+3). Used for trade settlement processing, liquidity planning, and operational risk management.',
    `sovereign_credit_rating` STRING COMMENT 'Long-term foreign currency sovereign credit rating from major rating agencies (e.g., AAA, AA+, BBB-, CCC). Used for risk-weighted asset (RWA) calculations, credit valuation adjustment (CVA), and investment grade classification.',
    `sovereign_rating_agency` STRING COMMENT 'Name of the rating agency providing the sovereign credit rating (e.g., S&P, Moodys, Fitch). Used for rating source attribution and multi-agency rating reconciliation.',
    `sovereign_rating_date` DATE COMMENT 'Date of the most recent sovereign credit rating assessment. Used for rating staleness checks and triggering rating review workflows.',
    `sovereign_status` STRING COMMENT 'Indicates the political sovereignty status of the country or territory. Critical for determining applicable regulatory frameworks, tax treaties, and legal jurisdiction in cross-border transactions.. Valid values are `sovereign|dependent_territory|special_administrative_region|disputed`',
    `sub_region` STRING COMMENT 'Detailed sub-region classification within the broader region (e.g., Northern America, Western Europe, South-Eastern Asia). Used for granular geographic segmentation and risk analysis.',
    `tax_haven_flag` BOOLEAN COMMENT 'Indicates whether the country is classified as a tax haven or low-tax jurisdiction. Used for enhanced due diligence, beneficial ownership verification, and tax evasion risk assessment.',
    `time_zone` STRING COMMENT 'Primary time zone identifier for the country in IANA Time Zone Database format (e.g., America/New_York, Europe/London). Used for trade settlement timing, payment cut-off calculations, and business day determination.',
    CONSTRAINT pk_country PRIMARY KEY(`country_id`)
) COMMENT 'ISO 3166-1 country master — golden source for all country codes, country names, alpha-2, alpha-3, and numeric codes. Includes region, sub-region, sovereign status, FATCA jurisdiction flag, CRS jurisdiction flag, OFAC sanctions flag, and EU membership indicator. Referenced by KYC, AML, regulatory reporting, and customer onboarding.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`rate_benchmark` (
    `rate_benchmark_id` BIGINT COMMENT 'Unique identifier for the interest rate benchmark record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Interest rate benchmarks are currency-specific (e.g., USD SOFR, EUR ESTR). The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve cu',
    `fallback_rate_benchmark_id` BIGINT COMMENT 'Reference to the alternative benchmark that serves as the fallback rate if this benchmark is discontinued (e.g., SOFR as fallback for USD LIBOR).',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Rate benchmarks reference holiday calendars for business day conventions. The holiday_calendar_code STRING column should be replaced with a proper FK to holiday_calendar.holiday_calendar_id. This enab',
    `administrator_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the administrators regulatory jurisdiction (e.g., USA, GBR, EUR).. Valid values are `^[A-Z]{3}$`',
    `administrator_name` STRING COMMENT 'Name of the organization responsible for calculating and publishing the benchmark (e.g., Federal Reserve Bank of New York, ICE Benchmark Administration, European Money Markets Institute).',
    `alternative_benchmark_names` STRING COMMENT 'Comma-separated list of alternative names or abbreviations for the benchmark (e.g., Fed Funds, Federal Funds Rate, Effective Federal Funds Rate).',
    `benchmark_code` STRING COMMENT 'Standardized short code for the benchmark (e.g., SOFR, LIBOR_USD_3M, EURIBOR_6M, SONIA, ESTR, FED_FUNDS).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `benchmark_family` STRING COMMENT 'Grouping of related benchmarks under a common family name (e.g., LIBOR family includes USD LIBOR, GBP LIBOR, EUR LIBOR; SOFR family includes SOFR, Term SOFR).',
    `benchmark_name` STRING COMMENT 'Full legal name of the interest rate benchmark (e.g., Secured Overnight Financing Rate, London Interbank Offered Rate).',
    `benchmark_status` STRING COMMENT 'Current operational status of the benchmark: active (currently published and usable), inactive (temporarily not published), suspended (publication halted pending review), discontinued (permanently ceased), under_review (regulatory or administrator review in progress).. Valid values are `active|inactive|suspended|discontinued|under_review`',
    `benchmark_type` STRING COMMENT 'Classification of the benchmark by rate structure: overnight (daily), term (fixed tenor), interbank (bank-to-bank), risk-free (secured), or central bank (policy rate).. Valid values are `overnight|term|interbank|risk_free|central_bank`',
    `business_day_convention` STRING COMMENT 'Rule for adjusting payment dates that fall on non-business days: following (next business day), modified_following (next business day unless it crosses month-end), preceding (prior business day), modified_preceding (prior business day unless it crosses month-start), unadjusted (no adjustment).. Valid values are `following|modified_following|preceding|modified_preceding|unadjusted`',
    `calculation_methodology` STRING COMMENT 'Description of how the benchmark rate is calculated (e.g., volume-weighted median of overnight repo transactions, trimmed mean of panel bank submissions).',
    `compounding_convention` STRING COMMENT 'Method for aggregating overnight rates into term rates: simple (arithmetic average), compounded (geometric compounding), averaged (simple average), none (single rate, not compounded).. Valid values are `simple|compounded|averaged|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0-100) representing the completeness, accuracy, and timeliness of the benchmark reference data. Used for data governance and quality monitoring.',
    `data_source_description` STRING COMMENT 'Description of the underlying data sources used to calculate the benchmark (e.g., tri-party repo transactions cleared through FICC, panel bank submissions, central bank policy rate).',
    `day_count_convention` STRING COMMENT 'Method used to calculate interest accrual periods for the benchmark (e.g., Actual/360, Actual/365, 30/360, Actual/Actual).. Valid values are `actual_360|actual_365|30_360|actual_actual`',
    `discontinuation_date` DATE COMMENT 'Date when the benchmark was or will be discontinued (e.g., June 30, 2023 for most USD LIBOR tenors). Null if the benchmark is still active.',
    `effective_date` DATE COMMENT 'Date when the benchmark was first published or became effective for use in financial contracts.',
    `fallback_spread_adjustment` DECIMAL(18,2) COMMENT 'Fixed spread (in basis points) added to the fallback rate to account for historical differences between the original benchmark and the fallback benchmark.',
    `ibor_transition_status` STRING COMMENT 'Current status of the benchmark in the context of IBOR reform: active (current use), legacy (being phased out, e.g., LIBOR), discontinued (no longer published), transition_phase (migration underway), fallback_activated (fallback rate in use).. Valid values are `active|legacy|discontinued|transition_phase|fallback_activated`',
    `is_risk_free_rate` BOOLEAN COMMENT 'Indicates whether the benchmark is classified as a risk-free rate (e.g., SOFR, SONIA, ESTR) as opposed to a credit-sensitive rate (e.g., LIBOR). True for RFRs, False otherwise.',
    `is_secured_rate` BOOLEAN COMMENT 'Indicates whether the benchmark is based on secured transactions (e.g., repo transactions for SOFR) as opposed to unsecured lending (e.g., LIBOR). True for secured rates, False for unsecured.',
    `last_publication_date` DATE COMMENT 'Most recent date on which a rate was published for this benchmark. Used to track currency of data and identify stale benchmarks.',
    `lookback_period_days` STRING COMMENT 'Number of business days prior to the payment date used to determine the applicable rate (common in SOFR-based loans to allow operational time for rate fixing).',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or historical context about the benchmark (e.g., transition milestones, regulatory announcements, usage restrictions).',
    `observation_shift_days` STRING COMMENT 'Number of days the observation period is shifted backward relative to the interest period (alternative to lookback for SOFR and other overnight rates).',
    `panel_bank_count` STRING COMMENT 'Number of contributing banks or institutions in the benchmark panel (for panel-based benchmarks like legacy LIBOR). Null for transaction-based benchmarks.',
    `payment_delay_days` STRING COMMENT 'Standard number of business days between rate fixing and payment date (e.g., T+2 for some benchmarks).',
    `publication_source` STRING COMMENT 'Official source or platform where the benchmark rate is published (e.g., Federal Reserve website, Bloomberg, Reuters, ICE portal).',
    `publication_time` TIMESTAMP COMMENT 'Standard time of day when the benchmark rate is published, in the administrators local timezone (e.g., 08:00 EST, 11:00 CET).',
    `regulatory_recognition_status` STRING COMMENT 'Regulatory approval status of the benchmark: authorized (approved by regulator), recognized (accepted for regulatory purposes), non_recognized (not approved), under_review (pending regulatory assessment).. Valid values are `authorized|recognized|non_recognized|under_review`',
    `regulatory_regime` STRING COMMENT 'Primary regulatory framework governing the benchmark (e.g., EU Benchmark Regulation, UK Benchmark Regulation, IOSCO Principles).',
    `regulatory_reporting_code` STRING COMMENT 'Standardized code used for regulatory reporting purposes (e.g., CFTC reporting, EMIR reporting, MiFID II transaction reporting).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `source_system_code` STRING COMMENT 'Code identifying the upstream system or data provider from which this benchmark reference data was sourced (e.g., BLOOMBERG, REUTERS, FED_RESERVE, ICE_ADMIN).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tenor_convention` STRING COMMENT 'Standard maturity or term structure for the benchmark (e.g., overnight, 1-month, 3-month, 6-month, 12-month). Overnight benchmarks use overnight; term benchmarks specify the period. [ENUM-REF-CANDIDATE: overnight|1_week|1_month|3_month|6_month|12_month|spot|custom — 8 candidates stripped; promote to reference product]',
    `transaction_volume_threshold` DECIMAL(18,2) COMMENT 'Minimum daily transaction volume (in currency units) required for the benchmark to be published. Used to assess benchmark robustness and representativeness.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark record was last modified in the system.',
    `usage_scope` STRING COMMENT 'Description of typical use cases for the benchmark (e.g., loan pricing, derivatives valuation, asset-liability management, mortgage indexing, corporate debt).',
    CONSTRAINT pk_rate_benchmark PRIMARY KEY(`rate_benchmark_id`)
) COMMENT 'Interest rate benchmark master covering SOFR, LIBOR (legacy), EURIBOR, SONIA, ESTR, Fed Funds, and other reference rates. Stores benchmark name, administrator, currency, tenor conventions, publication source, IBOR transition status, fallback rate linkage, and regulatory recognition status. Critical for loan pricing, derivatives valuation, and ALM.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` (
    `benchmark_rate_fixing_id` BIGINT COMMENT 'Unique identifier for each benchmark rate fixing record. Primary key for the benchmark_rate_fixing product.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Rate fixings are denominated in specific currencies. The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve iso_code, currency_name,',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Rate fixings reference holiday calendars for business day conventions. The holiday_calendar STRING column should be replaced with a proper FK to holiday_calendar.holiday_calendar_id. This enables JOIN',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key reference to the parent rate benchmark master record (e.g., SOFR, EURIBOR, SONIA, LIBOR). Links this fixing to its benchmark definition.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this rate fixing to audit logs, data lineage records, or external verification sources. Used for regulatory audit and data quality assurance.',
    `business_day_convention` STRING COMMENT 'The convention for adjusting dates that fall on non-business days (e.g., following, modified following). Used in derivative and loan contract calculations.. Valid values are `following|modified_following|preceding|modified_preceding`',
    `compounding_method` STRING COMMENT 'The calculation methodology used to derive the rate fixing when based on multiple observations (e.g., simple average, compound, weighted average). Set to none for single-observation spot rates.. Valid values are `simple|compound|weighted_average|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this benchmark rate fixing record was first created in the data platform. Used for data lineage and audit purposes.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated data quality score (0-100) assessing the completeness, accuracy, and timeliness of this rate fixing record. Used for data governance and reconciliation monitoring.',
    `day_count_convention` STRING COMMENT 'The day count convention used for interest accrual calculations with this rate (e.g., ACT/360 for USD SOFR, ACT/365 for GBP SONIA). Critical for accurate interest computation.. Valid values are `ACT/360|ACT/365|30/360|ACT/ACT`',
    `effective_date` DATE COMMENT 'The date from which this rate fixing becomes effective for contractual calculations. Typically the same as fixing_date but may differ for backdated corrections.',
    `fallback_methodology` STRING COMMENT 'Description of the fallback calculation methodology applied if this is a fallback rate (e.g., compounded SOFR plus spread adjustment). Null if not a fallback.',
    `fallback_rate_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this rate is a fallback or substitute rate used when the primary benchmark is unavailable (e.g., LIBOR transition fallbacks). True if this is a fallback rate.',
    `fixing_date` DATE COMMENT 'The business date on which the benchmark rate was fixed and published by the rate authority. This is the effective date for the rate value.',
    `is_business_day` BOOLEAN COMMENT 'Boolean flag indicating whether the fixing date is a business day in the relevant market. False if the fixing date falls on a weekend or holiday, which may affect rate applicability.',
    `is_revised` BOOLEAN COMMENT 'Boolean flag indicating whether this fixing is a revision or correction of a previously published rate. True if this record supersedes an earlier fixing for the same date and tenor.',
    `number_of_transactions` STRING COMMENT 'The count of individual transactions used to calculate the benchmark rate, if published by the rate authority. Indicates market breadth. Null if not disclosed.',
    `observation_period_end` DATE COMMENT 'The end date of the observation period used to calculate the rate fixing. Null for spot rates.',
    `observation_period_start` DATE COMMENT 'The start date of the observation period used to calculate the rate fixing, applicable for compounded or averaged rates (e.g., SOFR averages). Null for spot rates.',
    `publication_timestamp` TIMESTAMP COMMENT 'The exact date and time when the rate fixing was officially published by the rate authority. Used for audit trails and to determine which rate applies for time-sensitive calculations.',
    `rate_basis_points` DECIMAL(18,2) COMMENT 'The rate value expressed in basis points for convenience (e.g., 525.00 BPS for 5.25%). One basis point equals 0.01%. Commonly used in trading and risk reporting.',
    `rate_status` STRING COMMENT 'The lifecycle status of the rate fixing. Published is the standard state; preliminary indicates subject to revision; final indicates no further changes expected; corrected indicates a revision; withdrawn indicates the rate was retracted.. Valid values are `published|preliminary|final|corrected|withdrawn`',
    `rate_value` DECIMAL(18,2) COMMENT 'The published benchmark interest rate value expressed as a decimal (e.g., 0.05250000 for 5.25%). This is the official fixing rate used for loan accrual, derivative settlement, and mark-to-market calculations.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process comparing this rate fixing against multiple source feeds or vendor data. Matched indicates agreement across sources; exception indicates discrepancies requiring investigation.. Valid values are `matched|unmatched|pending|exception`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this rate fixing must be included in regulatory reports (e.g., CCAR, DFAST, Basel III). True if required for compliance reporting.',
    `revision_reason` STRING COMMENT 'Explanation provided by the rate authority for why the rate was revised or corrected. Null if not a revision.',
    `revision_sequence` STRING COMMENT 'Sequential number indicating the revision iteration for this fixing date and tenor. Initial publication is 1, first revision is 2, etc. Null if never revised.',
    `source_authority` STRING COMMENT 'The official organization or entity that published the benchmark rate fixing (e.g., Federal Reserve Bank of New York for SOFR, European Money Markets Institute for EURIBOR, Bank of England for SONIA).',
    `source_system` STRING COMMENT 'The system or data feed from which the rate fixing was ingested (e.g., Bloomberg, Reuters, direct API feed from rate authority). Used for data lineage and reconciliation.',
    `spread_adjustment` DECIMAL(18,2) COMMENT 'The spread adjustment (in decimal form) added to the fallback rate to align it with the discontinued benchmark. Used in LIBOR transition scenarios. Null if not applicable.',
    `superseded_rate_value` DECIMAL(18,2) COMMENT 'The previous rate value that this fixing replaces, if this is a revision. Null for initial publications. Used for audit trails and impact analysis of rate corrections.',
    `tenor_code` STRING COMMENT 'The maturity period for which the rate applies. Standard tenors include overnight (O/N), tomorrow-next (T/N), spot-next (S/N), and term periods (1W, 1M, 3M, 6M, 12M). Critical for matching rates to loan and derivative contract terms. [ENUM-REF-CANDIDATE: O/N|T/N|S/N|1W|2W|1M|2M|3M|6M|9M|12M — 11 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this benchmark rate fixing record was last modified. Used for change tracking and audit trails.',
    `volume_traded` DECIMAL(18,2) COMMENT 'The total transaction volume (in currency units) underlying the rate calculation, if published by the rate authority. Provides transparency on market depth. Null if not disclosed.',
    CONSTRAINT pk_benchmark_rate_fixing PRIMARY KEY(`benchmark_rate_fixing_id`)
) COMMENT 'Daily published fixing values for interest rate benchmarks by tenor and fixing date. Each record links to its parent rate_benchmark (SOFR, EURIBOR, SONIA, etc.) and captures fixing date, tenor (O/N, 1M, 3M, 6M, 12M), published rate value, source authority, publication timestamp, revision indicator, and superseded rate (for corrections). Serves as the transactional time-series complement to the rate_benchmark master. Used for loan interest accrual, derivative settlement, mark-to-market calculations, and regulatory rate audit trails across trading, loan, and treasury domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`exchange_rate` (
    `exchange_rate_id` BIGINT COMMENT 'Unique identifier for the exchange rate record. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Exchange rates have a base currency. The base_currency_code STRING column should be replaced with a proper FK to currency.currency_id. This is the first of two FKs from exchange_rate to currency, labe',
    `benchmark_rate_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate is an official benchmark rate used for regulatory reporting, financial statement revaluation, or contractual reference (e.g., WM/Reuters 4pm London Fix). Benchmark rates have heightened governance and audit requirements.',
    `comments` STRING COMMENT 'Free-text field for additional context, notes, or explanations about this exchange rate. May include information about market conditions, data quality issues, manual adjustments, or special circumstances affecting the rate.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate record was first created in the data platform. Used for audit trail and data lineage tracking. Distinct from publication_timestamp and effective_timestamp.',
    `cross_rate_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate is a cross rate (derived from two other currency pairs) rather than a directly traded pair. For example, EUR/GBP may be derived from EUR/USD and GBP/USD. Cross rates may have wider spreads.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the assessed quality and reliability of this rate record based on source reputation, timeliness, completeness, and validation checks. Scores below threshold may trigger alerts or prevent automated use.',
    `ecb_published_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate was published by the European Central Bank as an official ECB reference rate. ECB rates are used for regulatory reporting and accounting revaluations in the Eurozone.',
    `effective_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate becomes effective and valid for use in transactions, valuations, and revaluations. This is the business event timestamp representing when the rate was published or became active in the market.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate expires and is no longer valid for use. For spot rates this may be end-of-day, for forward rates this is the forward settlement date. Null indicates an open-ended rate.',
    `fed_published_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate was published by the U.S. Federal Reserve as an official Fed reference rate. Fed rates are used for regulatory reporting and accounting revaluations in the United States.',
    `gl_revaluation_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate is approved for use in general ledger foreign currency revaluation processes. GL revaluation rates must meet accounting policy standards and audit requirements.',
    `holiday_adjusted_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate has been adjusted for banking holidays in either the base or quote currency jurisdiction. Holiday adjustments affect settlement dates and may impact rate calculations.',
    `inverse_rate_value` DECIMAL(18,2) COMMENT 'The inverse of the rate_value, representing the exchange rate when the base and quote currencies are swapped. Calculated as 1 / rate_value. Stored for performance optimization in bidirectional FX calculations.',
    `publication_timestamp` TIMESTAMP COMMENT 'The date and time when the rate was officially published or released by the source provider. May differ from effective_timestamp in cases where rates are published in advance of their effective date.',
    `quote_currency_code` STRING COMMENT 'The quote currency (counter currency) in the exchange rate pair, represented as a three-letter ISO 4217 currency code. This is the currency in which the base currency is priced.. Valid values are `^[A-Z]{3}$`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the exchange rate record. Active rates are currently valid for use, superseded rates have been replaced by newer rates, preliminary rates are initial publications subject to revision, final rates are confirmed and will not change, and cancelled rates were published in error.. Valid values are `active|superseded|preliminary|final|cancelled`',
    `rate_type` STRING COMMENT 'Classification of the exchange rate type. Spot rates are for immediate settlement (T+2), forward rates are for future settlement dates, mid rates are the average of bid and ask, bid rates are the price at which the market maker will buy the base currency, ask rates are the price at which the market maker will sell the base currency, and fixing rates are official daily reference rates published by central banks.. Valid values are `spot|forward|mid|bid|ask|fixing`',
    `rate_value` DECIMAL(18,2) COMMENT 'The numerical exchange rate value representing how many units of the quote currency are needed to purchase one unit of the base currency. Precision of 8 decimal places supports accurate FX calculations for large transactions.',
    `regulatory_reporting_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this rate is approved for use in regulatory reporting submissions (e.g., Basel III, CCAR, DFAST, IFRS 9, CECL). Only rates from approved sources and meeting regulatory standards are eligible.',
    `settlement_date` DATE COMMENT 'The value date when the FX transaction using this rate would settle. For spot rates this is typically T+2 (trade date plus two business days), for forward rates this is the forward maturity date. Used by treasury and payment processing systems.',
    `source_provider` STRING COMMENT 'The name or identifier of the market data provider or central bank that published this exchange rate (e.g., Bloomberg, Reuters, ECB, Federal Reserve, WM/Reuters Closing Spot Rates). Critical for audit trail and rate validation.',
    `source_system_code` STRING COMMENT 'The unique identifier or reference code for this rate in the source providers system. Enables traceability back to the original market data feed or central bank publication.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The bid-ask spread expressed in basis points (1 BPS = 0.01%). Represents the difference between the bid and ask rates as a percentage of the mid rate. Used for liquidity analysis and transaction cost assessment.',
    `tenor` STRING COMMENT 'The time period for forward exchange rates, expressed in standard market conventions. ON=Overnight, TN=Tom-Next, SN=Spot-Next, W=Weeks, M=Months, Y=Years. SPOT indicates a spot rate with no forward tenor. Used primarily for forward rates and FX swaps.. Valid values are `^(ON|TN|SN|1W|2W|1M|2M|3M|6M|9M|1Y|2Y|3Y|5Y|10Y|SPOT)$`',
    `trading_session` STRING COMMENT 'The global FX trading session during which this rate was captured or published. FX markets operate 24 hours across major financial centers. Continuous indicates a real-time streaming rate not tied to a specific session. [ENUM-REF-CANDIDATE: london_open|london_close|ny_open|ny_close|tokyo_open|tokyo_close|sydney_open|sydney_close|continuous — 9 candidates stripped; promote to reference product]',
    `triangulation_method` STRING COMMENT 'The method used to calculate this rate if it is a cross rate. Via_usd indicates the rate was triangulated through USD as the vehicle currency. Not_applicable indicates a directly traded pair. Triangulation method affects precision and spread.. Valid values are `direct|via_usd|via_eur|via_gbp|not_applicable`',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this exchange rate record was last modified in the data platform. Used for audit trail and change tracking. Updated whenever any attribute value changes.',
    `version_number` STRING COMMENT 'Sequential version number for this exchange rate record. Incremented each time the record is updated. Supports historical tracking and audit requirements. Version 1 is the initial publication.',
    `volatility_indicator` STRING COMMENT 'Qualitative assessment of the market volatility level at the time this rate was published. High or extreme volatility may trigger additional risk management controls or require manual review before use in automated systems.. Valid values are `low|normal|high|extreme`',
    CONSTRAINT pk_exchange_rate PRIMARY KEY(`exchange_rate_id`)
) COMMENT 'FX spot and forward exchange rate records published daily (or intraday) for all currency pairs. Captures base currency, quote currency, rate type (spot, forward, mid, bid, ask), tenor, rate value, source provider, effective timestamp, and ECB/Fed publication flag. Used by payments, treasury, GL revaluation, and risk domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`holiday_calendar` (
    `holiday_calendar_id` BIGINT COMMENT 'Unique identifier for the holiday calendar. Primary key for the holiday calendar entity.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Holiday calendars are associated with specific currency markets. The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve currency_nam',
    `applies_to_derivatives` BOOLEAN COMMENT 'Indicates whether this calendar is used for derivatives contract settlement, coupon payment dates, and option expiry calculations (e.g., interest rate swaps, Credit Default Swaps (CDS), foreign exchange (FX) forwards). True for calendars referenced in International Swaps and Derivatives Association (ISDA) documentation.',
    `applies_to_loans` BOOLEAN COMMENT 'Indicates whether this calendar is used for loan payment scheduling, interest accrual period calculations, and covenant compliance date computations. True for banking calendars used in commercial lending and credit origination.',
    `applies_to_payments` BOOLEAN COMMENT 'Indicates whether this calendar is used for payment processing and funds transfer date calculations (e.g., Automated Clearing House (ACH), wire transfers, Real-Time Gross Settlement (RTGS), Society for Worldwide Interbank Financial Telecommunication (SWIFT) payments). True for payment system and banking calendars.',
    `applies_to_securities` BOOLEAN COMMENT 'Indicates whether this calendar is used for securities settlement date calculations (e.g., equity trades, bond settlements, derivatives). True for exchange and clearing calendars; may be false for payment-only or banking-only calendars.',
    `business_day_convention` STRING COMMENT 'Default convention for adjusting payment or settlement dates that fall on non-business days. Following: move to next business day. Modified Following: move to next business day unless it crosses month boundary, then move to preceding business day. Preceding: move to previous business day. Modified Preceding: move to previous business day unless it crosses month boundary, then move to following business day. Nearest: move to nearest business day. Unadjusted: no adjustment. Used for coupon date adjustment and payment scheduling.. Valid values are `following|modified_following|preceding|modified_preceding|nearest|unadjusted`',
    `calendar_code` STRING COMMENT 'Unique business identifier code for the holiday calendar (e.g., TARGET2, NYSE, SIFMA, LME, FED, ECB). Used as the externally-known reference key for settlement and payment systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `calendar_name` STRING COMMENT 'Full descriptive name of the holiday calendar (e.g., Trans-European Automated Real-time Gross Settlement Express Transfer System, New York Stock Exchange, Securities Industry and Financial Markets Association).',
    `calendar_source_system` STRING COMMENT 'Name of the upstream system or data provider from which this calendar is sourced (e.g., Bloomberg, Reuters, SWIFT, internal treasury system, regulatory authority website). Used for data lineage and reconciliation.',
    `calendar_status` STRING COMMENT 'Current lifecycle status of the holiday calendar. Active calendars are in use for settlement and payment calculations. Inactive calendars are no longer used but retained for historical reference. Deprecated calendars are being phased out (e.g., LIBOR-based calendars transitioning to SOFR). Pending calendars are scheduled for future activation.. Valid values are `active|inactive|deprecated|pending`',
    `calendar_type` STRING COMMENT 'Classification of the calendar by its primary business purpose: settlement (for trade settlement systems), exchange (for securities exchanges), banking (for commercial banking operations), clearing (for clearing houses), payment (for payment systems), public (for national public holidays), or custom (for institution-specific calendars). [ENUM-REF-CANDIDATE: settlement|exchange|banking|clearing|payment|public|custom — 7 candidates stripped; promote to reference product]',
    `calendar_url` STRING COMMENT 'Web address of the official source where the authoritative holiday calendar is published (e.g., central bank website, exchange website, SIFMA holiday schedule page). Used for reference and validation.. Valid values are `^https?://.*$`',
    `calendar_version` STRING COMMENT 'Version identifier for this calendar publication (e.g., 2024, 1.0, 2.3). Calendars are versioned annually or when significant changes occur (e.g., addition of new public holidays, changes in weekend patterns). Used to track calendar updates and ensure correct historical calculations.. Valid values are `^[0-9]{4}$|^[0-9]+.[0-9]+$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this holiday calendar record was first created in the system. Used for audit trails and data lineage tracking.',
    `effective_from_date` DATE COMMENT 'The date from which this holiday calendar version becomes effective and should be used for settlement date calculations, accrual computations, and payment scheduling. Supports calendar versioning and historical accuracy.',
    `effective_to_date` DATE COMMENT 'The date until which this holiday calendar version remains effective. Nullable for open-ended calendars. Used to manage calendar transitions and ensure correct historical settlement date calculations.',
    `financial_center_code` STRING COMMENT 'ISO 10383 Market Identifier Code (MIC) or ISO 3166-1 alpha-2 country code representing the financial center or market to which this calendar applies (e.g., XNYS for NYSE, XLON for London Stock Exchange, US for United States, GB for United Kingdom).. Valid values are `^[A-Z]{2,4}$`',
    `governing_authority` STRING COMMENT 'Name of the regulatory body, central bank, exchange, or industry association that publishes and maintains this calendar (e.g., European Central Bank, Federal Reserve System, New York Stock Exchange, Securities Industry and Financial Markets Association, Bank of England).',
    `is_default_calendar` BOOLEAN COMMENT 'Indicates whether this is the default holiday calendar for the institution or financial center when no specific calendar is designated. Typically true for the primary banking calendar of the institutions home country or the main exchange calendar for securities operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this holiday calendar record was last updated in the system. Used for change tracking, audit trails, and data quality monitoring.',
    `last_updated_date` DATE COMMENT 'The date on which this calendar record was last modified in the system. Used for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or exceptions related to this calendar (e.g., notes about calendar transitions, special observances, regional variations, or coordination with other calendars for cross-border transactions).',
    `publication_date` DATE COMMENT 'The date on which this calendar version was officially published or released by the governing authority. Used for audit trails and to determine when calendar updates became available to market participants.',
    `regulatory_reporting_code` STRING COMMENT 'Code used to reference this calendar in regulatory reports (e.g., Basel III Liquidity Coverage Ratio (LCR) reporting, Comprehensive Capital Analysis and Review (CCAR), Dodd-Frank Act Stress Testing (DFAST), Foreign Account Tax Compliance Act (FATCA), Common Reporting Standard (CRS)). Ensures consistency in regulatory submissions.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `settlement_cycle_days` STRING COMMENT 'Standard number of business days for settlement in this market (e.g., 1 for T+1, 2 for T+2). Used as the default settlement period for securities trades, foreign exchange (FX) transactions, and payment instructions when calculating settlement dates using this calendar.',
    `supports_partial_days` BOOLEAN COMMENT 'Indicates whether this calendar supports partial business days (e.g., early close days for exchanges on days before major holidays, half-day trading sessions). True if the calendar includes partial day holiday entries; false if all non-business days are full-day closures.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the financial center (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for precise timestamp interpretation in trade settlement, payment cut-off times, and Real-Time Gross Settlement (RTGS) processing.. Valid values are `^[A-Za-z]+/[A-Za-z_]+$`',
    `weekend_pattern` STRING COMMENT 'Standard weekend days for this financial center or market. Most Western markets observe Saturday-Sunday; Middle Eastern markets may observe Friday-Saturday or Thursday-Friday. Used in conjunction with holiday dates to determine non-business days for settlement calculations.. Valid values are `saturday_sunday|friday_saturday|sunday|friday|thursday_friday|none`',
    CONSTRAINT pk_holiday_calendar PRIMARY KEY(`holiday_calendar_id`)
) COMMENT 'Business day holiday calendar master defining non-business days for financial centers, exchanges, and clearing systems (e.g., TARGET2, SIFMA, NYSE, LME). Captures calendar name, financial center, calendar type, governing authority, applicable currency or market, and all individual holiday date entries (specific non-business dates, holiday names, holiday types — public, exchange, settlement — and partial day indicators). Used for settlement date calculation (T+1, T+2), accrual period computation, payment scheduling, and coupon date adjustment across loan, payment, trade, and treasury domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`holiday_date` (
    `holiday_date_id` BIGINT COMMENT 'Unique identifier for the holiday date record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Holiday dates are country-specific. The country_code STRING column should be replaced with a proper FK to country.country_id. This enables JOIN to retrieve country_name, region, and other country attr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Holiday dates affect specific currency markets. The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve currency_name and other curre',
    `holiday_calendar_id` BIGINT COMMENT 'Reference to the holiday calendar to which this date belongs (e.g., NYSE, TARGET2, UK Banking, USD Settlement).',
    `actual_holiday_date` DATE COMMENT 'The actual calendar date of the holiday before any substitution or observance adjustment. Populated when observance_rule is substitute and the observed date differs from the actual date.',
    `affects_accrual` BOOLEAN COMMENT 'Indicates whether this holiday affects interest accrual calculations for loans, deposits, and fixed income securities. True if accrual is suspended or adjusted, False otherwise.',
    `affects_payment` BOOLEAN COMMENT 'Indicates whether this holiday affects scheduled payment processing (loan payments, coupon payments, dividends). True if payments are deferred to the next business day, False otherwise.',
    `affects_settlement` BOOLEAN COMMENT 'Indicates whether this holiday affects securities settlement and trade date plus one (T+1) or T+2 calculations. True if settlement is impacted, False otherwise.',
    `announcement_date` DATE COMMENT 'The date on which this holiday was officially announced or published by the governing authority (exchange, central bank, government).',
    `business_day_convention` STRING COMMENT 'The convention used to adjust dates that fall on this holiday. Following: move to next business day. Modified Following: move to next business day unless it crosses month-end, then move to preceding. Preceding: move to prior business day. Modified Preceding: move to prior business day unless it crosses month-start, then move to following. Unadjusted: no adjustment.. Valid values are `following|modified_following|preceding|modified_preceding|unadjusted`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this holiday date record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'The date from which this holiday date record becomes effective and should be used in calculations. Supports advance loading of future holiday calendars.',
    `expiration_date` DATE COMMENT 'The date after which this holiday date record is no longer valid. Null if the record has no expiration. Used for historical calendar versioning.',
    `holiday_date` DATE COMMENT 'The specific non-business date observed as a holiday. Used for settlement date calculations, accrual period adjustments, and payment scheduling across loan, securities, and treasury operations.',
    `holiday_name` STRING COMMENT 'The official name or description of the holiday (e.g., New Years Day, Christmas, Good Friday, Independence Day, Market Closure).',
    `holiday_type` STRING COMMENT 'Classification of the holiday type. Public: national/regional public holiday. Exchange: securities exchange closure. Settlement: payment system closure (ACH, RTGS, SWIFT). Bank: banking institution closure. Custom: client-specific or internal calendar event. Regulatory: regulatory reporting deadline adjustment.. Valid values are `public|exchange|settlement|bank|custom|regulatory`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this holiday date is currently active and should be applied in business day calculations. False if the holiday has been cancelled, superseded, or is no longer observed.',
    `is_partial_day` BOOLEAN COMMENT 'Indicates whether the holiday is a partial day (e.g., early market close, half-day banking). True if partial, False if full-day closure.',
    `last_modified_by` STRING COMMENT 'The user ID or system process that last modified this holiday date record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this holiday date record was last updated. Used for change tracking and audit trail.',
    `market_identifier_code` STRING COMMENT 'ISO 10383 Market Identifier Code (MIC) for the exchange or trading venue to which this holiday applies (e.g., XNYS for NYSE, XLON for London Stock Exchange). Null if not exchange-specific.. Valid values are `^[A-Z]{4}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or exceptions related to this holiday date (e.g., Early close at 1:00 PM ET, Bond market open, equity market closed).',
    `observance_rule` STRING COMMENT 'Indicates how the holiday date is determined. Fixed: same calendar date each year. Floating: varies by rule (e.g., third Monday of January). Calculated: computed based on lunar calendar or other algorithm. Substitute: observed on a different date when the actual holiday falls on a weekend.. Valid values are `fixed|floating|calculated|substitute`',
    `partial_day_close_time` TIMESTAMP COMMENT 'The closing time for partial day holidays in HH:mm format (24-hour). Null if not a partial day or if closed all day.',
    `partial_day_open_time` TIMESTAMP COMMENT 'The opening time for partial day holidays in HH:mm format (24-hour). Null if not a partial day or if closed all day.',
    `payment_system_code` STRING COMMENT 'Code identifying the payment or settlement system affected by this holiday (e.g., FEDWIRE, CHIPS, TARGET2, CHAPS, ACH). Used for payment scheduling and liquidity management.',
    `recurring_pattern` STRING COMMENT 'Description of the recurrence pattern for floating holidays (e.g., Third Monday in January, Last Friday in March, Easter Sunday + 1 day). Null for fixed-date holidays.',
    `region_code` STRING COMMENT 'Sub-national region or state code where the holiday applies (e.g., NY for New York, CA for California). Null if the holiday applies nationwide.',
    `regulatory_reference` STRING COMMENT 'Reference to the regulatory rule, statute, or official gazette that establishes this holiday (e.g., Federal Reserve Board Regulation D, UK Banking Act 1971 Schedule 1).',
    `source_system` STRING COMMENT 'The system or authoritative source from which this holiday date was obtained (e.g., Bloomberg, Reuters, Central Bank, Exchange Official Calendar, Internal Treasury).',
    `year` STRING COMMENT 'The calendar year in which this holiday occurs. Facilitates year-based filtering and multi-year calendar generation.',
    `created_by` STRING COMMENT 'The user ID or system process that created this holiday date record. Used for audit trail and accountability.',
    CONSTRAINT pk_holiday_date PRIMARY KEY(`holiday_date_id`)
) COMMENT 'Individual holiday date entries within a holiday calendar. Captures the specific non-business date, holiday name, calendar reference, holiday type (public, exchange, settlement), and whether it is a partial day. Enables precise settlement date and accrual period calculations across loan, payment, and trade domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`instrument_identifier` (
    `instrument_identifier_id` BIGINT COMMENT 'Primary key for instrument_identifier',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Financial instruments are denominated in specific currencies. The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve currency_name, ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Financial instruments are issued in specific countries. The issuer_country_code STRING column should be replaced with a proper FK to country.country_id. This enables JOIN to retrieve country_name, reg',
    `issuer_id` BIGINT COMMENT 'FK to security.issuer',
    `instrument_classification_id` BIGINT COMMENT 'FK to reference.instrument_classification',
    `bloomberg_ticker` STRING COMMENT 'Bloomberg proprietary ticker symbol used to identify securities within the Bloomberg Terminal system. Format varies by asset class and exchange.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument identifier record was first created in the reference data system.',
    `cusip` STRING COMMENT '9-character alphanumeric code identifying North American financial instruments. Format: 6-character issuer code + 2-character issue code + 1 check digit.. Valid values are `^[0-9]{3}[A-Z0-9]{5}[0-9]$`',
    `effective_date` DATE COMMENT 'Date from which this identifier is valid and active for use in trading, risk, and reporting systems.',
    `expiry_date` DATE COMMENT 'Date on which this identifier ceases to be valid. Null for identifiers that remain active indefinitely.',
    `figi` STRING COMMENT '12-character alphanumeric code providing a unique identifier for financial instruments across asset classes and markets. Formerly known as Bloomberg Global Identifier (BBGID).. Valid values are `^[A-Z0-9]{12}$`',
    `identifier_type` STRING COMMENT 'Classification of the identifier record indicating its role in the cross-reference hierarchy. Primary identifiers are the golden source; alternate identifiers provide cross-system mapping.. Valid values are `primary|alternate|legacy|vendor_specific|internal`',
    `instrument_identifier_status` STRING COMMENT 'Current lifecycle status of the instrument identifier record indicating whether it is actively traded, matured, called, defaulted, or suspended.. Valid values are `active|inactive|matured|called|defaulted|suspended`',
    `internal_instrument_code` STRING COMMENT 'Bank-specific internal code or mnemonic used to identify the instrument within proprietary trading, risk, and accounting systems.',
    `is_primary_identifier` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is the primary golden-source identifier for the instrument. Only one identifier per instrument should be marked as primary.',
    `is_tradable` BOOLEAN COMMENT 'Boolean flag indicating whether the instrument is currently available for trading in the banks trading systems.',
    `isin` STRING COMMENT 'ISO 6166 standard 12-character alphanumeric code uniquely identifying a financial instrument globally. Format: 2-letter country code + 9-character alphanumeric national security identifier + 1 check digit.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `issue_date` DATE COMMENT 'Date on which the instrument was originally issued or created.',
    `issuing_authority` STRING COMMENT 'Name of the organization or agency that issued or maintains the identifier (e.g., CUSIP Global Services, London Stock Exchange, Bloomberg L.P.).',
    `last_verified_date` DATE COMMENT 'Date on which the identifier and classification attributes were last verified or validated against authoritative sources.',
    `listing_exchange` STRING COMMENT 'Name or Market Identifier Code (MIC) of the primary exchange or trading venue where the instrument is listed or traded.',
    `maturity_date` DATE COMMENT 'Date on which the instrument matures or expires. Applicable to fixed income securities, derivatives, and structured products. Null for perpetual instruments.',
    `reuters_ric` STRING COMMENT 'Reuters proprietary ticker-like code used to identify financial instruments within the Refinitiv (formerly Thomson Reuters) system.',
    `sedol` STRING COMMENT '7-character alphanumeric code identifying securities traded on the London Stock Exchange and other UK exchanges. Format: 6-character base code + 1 check digit.. Valid values are `^[B-DF-HJ-NP-TV-Z0-9]{6}[0-9]$`',
    `source_system` STRING COMMENT 'Name of the upstream system or data vendor that provided this identifier record (e.g., Murex, Calypso, Bloomberg, Refinitiv, internal reference data system).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument identifier record was last modified or updated.',
    CONSTRAINT pk_instrument_identifier PRIMARY KEY(`instrument_identifier_id`)
) COMMENT 'Authoritative instrument reference master — golden source for financial instrument identifiers and classification. Captures cross-reference identifiers (ISIN, CUSIP, SEDOL, FIGI, Bloomberg ticker, Reuters RIC), identifier type, issuing authority, effective/expiry dates, and primary flag. Also captures classification attributes: CFI code (ISO 10962), asset class (equity, fixed income, derivative, FX, commodity, structured product), sub-asset class, instrument type, FRTB trading book/banking book classification, IFRS 9 measurement category (amortized cost, FVOCI, FVTPL), and MiFID II instrument categorization. Enables instrument lookup, cross-system reconciliation, golden-source identifier resolution, and consistent instrument categorization across trading, securities, risk, and regulatory reporting domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`instrument_classification` (
    `instrument_classification_id` BIGINT COMMENT 'Primary key for instrument_classification',
    `approval_date` DATE COMMENT 'Date on which the classification was formally approved by the authorized governance body. Required for regulatory audit and internal control validation.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this classification. Used for governance and audit trail.',
    `asset_class` STRING COMMENT 'Top-level asset class categorization of the financial instrument. Primary dimension for portfolio allocation, risk management, and regulatory capital treatment.. Valid values are `equity|fixed_income|derivative|foreign_exchange|commodity|structured_product`',
    `central_clearing_eligible` BOOLEAN COMMENT 'Flag indicating whether the instrument is eligible for central clearing through a central counterparty (CCP). Impacts margin requirements and capital charges.',
    `cfi_code` STRING COMMENT 'Six-character ISO 10962 CFI code that classifies the financial instrument by category, group, and attributes. Used globally for instrument identification and regulatory reporting.. Valid values are `^[A-Z]{6}$`',
    `classification_effective_date` DATE COMMENT 'Date from which this classification becomes effective. Used for point-in-time regulatory reporting and historical analysis.',
    `classification_end_date` DATE COMMENT 'Date on which this classification ceases to be effective. Null for currently active classifications. Supports temporal classification changes.',
    `classification_rationale` STRING COMMENT 'Business justification and regulatory basis for the assigned classification. Documents the decision-making process for audit and compliance purposes.',
    `classification_status` STRING COMMENT 'Current lifecycle status of the classification record. Used to manage classification updates and regulatory changes.. Valid values are `active|inactive|pending_review|superseded`',
    `classification_version` STRING COMMENT 'Version number of the classification record. Incremented when classification attributes are updated due to regulatory changes or internal policy revisions.',
    `complex_product_indicator` BOOLEAN COMMENT 'Flag indicating whether the instrument is classified as a complex product under MiFID II, requiring enhanced client suitability assessment and disclosure.',
    `counterparty_credit_risk_category` STRING COMMENT 'Classification for counterparty credit risk exposure calculation, including CVA, DVA, and FVA. Determines exposure methodology and capital treatment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the classification record was first created in the reference data system. Used for audit trail and data lineage.',
    `credit_risk_mitigation_eligible` BOOLEAN COMMENT 'Flag indicating whether the instrument is eligible for credit risk mitigation under Basel III standardized or internal ratings-based approaches. Affects risk-weighted asset calculation.',
    `derivative_indicator` BOOLEAN COMMENT 'Flag indicating whether the instrument is a derivative contract. Used for derivative-specific regulatory reporting, margin requirements, and central clearing obligations.',
    `exchange_traded_indicator` BOOLEAN COMMENT 'Flag indicating whether the instrument is traded on a regulated exchange or multilateral trading facility. Affects transparency requirements and best execution obligations.',
    `fair_value_hierarchy_level` STRING COMMENT 'IFRS 13 / ASC 820 fair value hierarchy level indicating the observability of valuation inputs. Level 1 uses quoted prices, Level 2 uses observable inputs, Level 3 uses unobservable inputs.. Valid values are `level_1|level_2|level_3|not_applicable`',
    `frtb_book_classification` STRING COMMENT 'Regulatory classification determining whether the instrument belongs to the trading book or banking book under FRTB rules. Critical for capital calculation and risk-weighted asset determination.. Valid values are `trading_book|banking_book|not_applicable`',
    `ifrs9_measurement_category` STRING COMMENT 'IFRS 9 accounting measurement category determining how the instrument is valued and how gains/losses are recognized. Drives financial statement presentation and expected credit loss calculation.. Valid values are `amortized_cost|fair_value_oci|fair_value_pl|not_applicable`',
    `instrument_type` STRING COMMENT 'Specific instrument type descriptor providing business-friendly categorization (e.g., equity option, convertible bond, credit default swap). Used by trading desks and product teams.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the classification record. Supports change tracking and data quality monitoring.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the classification. Used to ensure classifications remain current with regulatory changes and business practices.',
    `liquidity_classification` STRING COMMENT 'Classification of the instrument for liquidity coverage ratio (LCR) and net stable funding ratio (NSFR) calculations. Determines eligibility as high-quality liquid asset and applicable haircuts.. Valid values are `high_quality_liquid_asset_level_1|high_quality_liquid_asset_level_2a|high_quality_liquid_asset_level_2b|non_hqla|not_applicable`',
    `market_risk_category` STRING COMMENT 'Market risk classification for VaR, stressed VaR, and incremental risk charge calculations. Used by market risk management and trading desk risk limits.',
    `mifid2_instrument_category` STRING COMMENT 'MiFID II regulatory categorization for European market transparency and reporting requirements. Determines transaction reporting obligations and best execution rules.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the classification. Supports proactive governance and compliance monitoring.',
    `otc_indicator` BOOLEAN COMMENT 'Flag indicating whether the instrument is traded over-the-counter rather than on an exchange. Impacts clearing requirements, margin rules, and trade reporting obligations.',
    `product_control_category` STRING COMMENT 'Internal product control classification used by finance and product management teams for P&L attribution, valuation hierarchy, and product lifecycle management.',
    `regulatory_capital_treatment` STRING COMMENT 'Description of how the instrument is treated for regulatory capital purposes under Basel III, including risk-weighting approach and capital charge methodology.',
    `regulatory_reporting_category` STRING COMMENT 'Standardized category code used for regulatory reporting submissions (e.g., FINREP, COREP, CCAR, DFAST). Maps to specific reporting taxonomy line items.',
    `risk_weight_percentage` DECIMAL(18,2) COMMENT 'Standard risk weight percentage applied to the instrument under the Basel III standardized approach for credit risk. Used to calculate risk-weighted assets (RWA).',
    `securitization_indicator` BOOLEAN COMMENT 'Flag indicating whether the instrument is a securitization (e.g., MBS, ABS, CDO, CLO). Triggers specific capital treatment and risk retention requirements.',
    `source_system` STRING COMMENT 'Name of the upstream system or data provider that supplied the classification data (e.g., Bloomberg, Refinitiv, internal product control system).',
    `stress_testing_category` STRING COMMENT 'Classification used for CCAR, DFAST, and internal stress testing scenarios. Determines which stress factors and shocks are applied to the instrument.',
    `structured_product_indicator` BOOLEAN COMMENT 'Flag indicating whether the instrument is a structured product combining multiple underlying instruments or derivatives. Used for risk decomposition and valuation.',
    `sub_asset_class` STRING COMMENT 'Granular sub-classification within the asset class (e.g., common stock, corporate bond, interest rate swap, FX forward). Used for detailed risk segmentation and product management.',
    `valuation_methodology` STRING COMMENT 'Primary valuation approach used for the instrument class. Determines fair value hierarchy level and valuation control requirements.. Valid values are `mark_to_market|mark_to_model|mark_to_cost|not_applicable`',
    `volcker_rule_covered` BOOLEAN COMMENT 'Flag indicating whether the instrument is subject to Volcker Rule proprietary trading restrictions. Used for compliance monitoring and permitted market-making activities.',
    CONSTRAINT pk_instrument_classification PRIMARY KEY(`instrument_classification_id`)
) COMMENT 'Financial instrument classification taxonomy using CFI (ISO 10962), asset class hierarchies, and regulatory categorizations. Captures CFI code, asset class (equity, fixed income, derivative, FX, commodity, structured product), sub-asset class, instrument type, FRTB trading book/banking book classification, IFRS 9 measurement category (amortized cost, FVOCI, FVTPL), and MiFID II instrument categorization. Used by risk, trading, regulatory reporting, and product management domains for consistent instrument categorization across the enterprise.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`bic_directory` (
    `bic_directory_id` BIGINT COMMENT 'Unique identifier for the BIC directory record. Primary key for the BIC directory golden source.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: BIC codes are assigned to financial institutions in specific countries. The country_code STRING column should be replaced with a proper FK to country.country_id. This enables JOIN to retrieve country_',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: BIC directory cross-references LEI codes for legal entity identification. The lei_code STRING column should be replaced with a proper FK to lei_registry.lei_registry_id. This enables JOIN to retrieve ',
    `address_line_1` STRING COMMENT 'The primary street address of the institution or branch. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Additional address information such as building name, floor, or suite number. Organizational contact data classified as confidential.',
    `bic11` STRING COMMENT 'The 11-character BIC code including the 3-character branch code suffix. Used for branch-level identification in SWIFT messaging.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}[A-Z0-9]{3}$`',
    `bic8` STRING COMMENT 'The 8-character BIC code identifying the institution, comprising institution code (4 chars), country code (2 chars), and location code (2 chars). Used for head office identification.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}$`',
    `bic_code` STRING COMMENT 'The SWIFT BIC code (8 or 11 characters). BIC8 format identifies the institution and country; BIC11 includes branch code. Also known as SWIFT code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `branch_name` STRING COMMENT 'The name of the specific branch or office identified by the BIC11 code. Null for head office BIC8 entries.',
    `business_day_convention` STRING COMMENT 'The convention used for adjusting payment dates that fall on non-business days. Following moves to next business day; modified_following moves to next unless it crosses month-end; preceding moves to prior business day.. Valid values are `following|modified_following|preceding|modified_preceding`',
    `city` STRING COMMENT 'The city where the institution or branch is located. Used for correspondent banking and payment routing.',
    `connectivity_status` STRING COMMENT 'The current operational status of the BIC code in the SWIFT network. Live indicates active production use; test indicates sandbox environment; inactive indicates decommissioned; suspended indicates temporarily disabled.. Valid values are `live|test|inactive|suspended`',
    `correspondent_banking_role` STRING COMMENT 'The role this institution plays in correspondent banking relationships. Nostro indicates the institution holds accounts at other banks; vostro indicates other banks hold accounts here; both indicates bidirectional relationships; none indicates no correspondent banking.. Valid values are `nostro|vostro|both|none`',
    `cut_off_time_local` STRING COMMENT 'The local time (HH:MM format) by which payment instructions must be received for same-day value. Used by payment processing hubs for scheduling.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score (0.00 to 100.00) representing the completeness and accuracy of this BIC record. Based on presence of optional fields, validation against SWIFT directory, and recency of updates.',
    `effective_date` DATE COMMENT 'The date from which this BIC code became active in the SWIFT directory. Used for historical payment routing validation.',
    `expiry_date` DATE COMMENT 'The date on which this BIC code was or will be deactivated. Null for currently active BIC codes. Used for payment routing validation and historical analysis.',
    `iban_supported` BOOLEAN COMMENT 'Indicates whether the institution supports IBAN format for account identification. Mandatory in SEPA countries; optional elsewhere.',
    `institution_name` STRING COMMENT 'The legal name of the financial institution associated with this BIC code. Used for correspondent banking identification and payment processing.',
    `institution_type` STRING COMMENT 'The classification of the institution holding this BIC code. Determines the types of SWIFT services and message types available.. Valid values are `bank|broker_dealer|clearing_house|securities_firm|investment_manager|corporate`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this BIC code is currently active and should be used for payment routing. Derived from connectivity_status and expiry_date. False indicates the BIC should not be used for new transactions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this BIC directory record was last modified. Used for change data capture and synchronization with upstream SWIFT directory feeds.',
    `national_identifier_code` STRING COMMENT 'The national registration or license number assigned by the domestic banking regulator. Format varies by jurisdiction (e.g., FDIC Certificate Number in USA, Financial Conduct Authority (FCA) number in UK).',
    `payment_services_enabled` BOOLEAN COMMENT 'Indicates whether this BIC is enabled for payment processing services including wire transfers, Automated Clearing House (ACH), and Real-Time Gross Settlement (RTGS).',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the institution address. Organizational contact data classified as confidential.',
    `regulatory_status` STRING COMMENT 'The regulatory standing of the institution for cross-border transactions. Sanctioned indicates Office of Foreign Assets Control (OFAC) or other sanctions apply; restricted indicates regulatory limitations; under_review indicates pending regulatory action.. Valid values are `authorized|restricted|sanctioned|under_review`',
    `routing_number` STRING COMMENT 'The domestic routing or sort code used for local payment clearing. Examples include American Bankers Association (ABA) routing number (USA), sort code (UK), Bankleitzahl (Germany). Null for institutions without domestic clearing participation.',
    `securities_services_enabled` BOOLEAN COMMENT 'Indicates whether this BIC is enabled for securities settlement, custody, and clearing services. Relevant for broker-dealers and custodian banks.',
    `sepa_participant` BOOLEAN COMMENT 'Indicates whether the institution is a participant in the Single Euro Payments Area for euro-denominated payments. Applicable to European Economic Area (EEA) institutions.',
    `source_system` STRING COMMENT 'The name of the system or feed that provided this BIC record. Typically SWIFT BIC Directory feed, but may include manual entries or third-party data providers.',
    `state_province` STRING COMMENT 'The state, province, or administrative region where the institution is located. Applicable for countries with sub-national divisions.',
    `swift_service_profile` STRING COMMENT 'Comma-separated list of SWIFT service types supported by this BIC. Examples include FIN (financial messaging), FileAct (file transfer), InterAct (real-time messaging), and Browse (information retrieval).',
    `time_zone` STRING COMMENT 'The IANA time zone identifier for the institution location. Used for cut-off time calculations and same-day value dating in payment processing.',
    `trade_finance_services_enabled` BOOLEAN COMMENT 'Indicates whether this BIC is enabled for trade finance services including letters of credit, guarantees, and documentary collections.',
    CONSTRAINT pk_bic_directory PRIMARY KEY(`bic_directory_id`)
) COMMENT 'SWIFT BIC (Bank Identifier Code) directory — golden source for all BIC codes used in SWIFT messaging and correspondent banking. Captures BIC8/BIC11, institution name, branch name, city, country, address, connectivity status (live/test), and SWIFT service profile. Used by payment processing, correspondent banking, and trade finance domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`lei_registry` (
    `lei_registry_id` BIGINT COMMENT 'Unique identifier for the LEI registry record. Primary key for the LEI registry data product.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: LEI entities are registered in specific legal jurisdictions. The jurisdiction_code STRING column should be replaced with a proper FK to jurisdiction.jurisdiction_id. This enables JOIN to retrieve juri',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: LEI entities have legal addresses in specific countries. The legal_address_country_code STRING column should be replaced with a proper FK to country.country_id. This is the first of two FKs from lei_r',
    `bic_code` STRING COMMENT 'The ISO 9362 Business Identifier Code (BIC), also known as SWIFT code, assigned to the entity if it is a financial institution participating in the SWIFT network. Used for international payment routing and messaging.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `data_source` STRING COMMENT 'The source system or data provider from which this LEI registry record was obtained or synchronized (e.g., GLEIF API, LOU direct feed, regulatory reporting platform).',
    `entity_category` STRING COMMENT 'The category classification of the entity as defined by GLEIF, indicating the type of legal entity (e.g., BRANCH for branch offices, FUND for investment funds, GENERAL for standard legal entities). [ENUM-REF-CANDIDATE: BRANCH|FUND|SOLE_PROPRIETOR|RESIDENT_GOVERNMENT_ENTITY|NON_RESIDENT_GOVERNMENT_ENTITY|INTERNATIONAL_ORGANIZATION|GENERAL — 7 candidates stripped; promote to reference product]',
    `entity_expiration_date` DATE COMMENT 'The date on which the legal entity is scheduled to expire, dissolve, or terminate, if applicable. This is relevant for entities with a defined lifespan such as special purpose vehicles, project companies, or entities in liquidation.',
    `entity_expiration_reason` STRING COMMENT 'The reason for the entitys expiration or termination, if applicable. Indicates the business or legal event that led to the entitys cessation.. Valid values are `DISSOLVED|MERGED|LIQUIDATION|CORPORATE_ACTION|OTHER`',
    `entity_registration_number` STRING COMMENT 'The unique registration number or identifier assigned to the entity by the registration authority in its jurisdiction of incorporation or registration.',
    `entity_status` STRING COMMENT 'The operational status of the legal entity as reported by the registration authority. ACTIVE indicates the entity is currently operating; INACTIVE indicates the entity has ceased operations, been dissolved, or is otherwise non-operational.. Valid values are `ACTIVE|INACTIVE`',
    `headquarters_address_city` STRING COMMENT 'The city or municipality component of the headquarters address.',
    `headquarters_address_country_code` STRING COMMENT 'The ISO 3166-1 alpha-2 two-letter country code representing the country of the headquarters address.. Valid values are `^[A-Z]{2}$`',
    `headquarters_address_line_1` STRING COMMENT 'The first line of the headquarters address where the entity conducts its primary business operations, which may differ from the legal address.',
    `headquarters_address_line_2` STRING COMMENT 'The second line of the headquarters address, containing additional address details.',
    `headquarters_address_postal_code` STRING COMMENT 'The postal code or ZIP code component of the headquarters address.',
    `headquarters_address_region` STRING COMMENT 'The region, state, province, or administrative subdivision component of the headquarters address.',
    `initial_registration_date` DATE COMMENT 'The date when the LEI was first issued to the entity by a Local Operating Unit (LOU). This represents the original registration date in the GLEIF system.',
    `last_update_date` DATE COMMENT 'The date when the LEI record was last updated in the GLEIF system, reflecting changes to entity information, status, or other attributes.',
    `legal_address_city` STRING COMMENT 'The city or municipality component of the legal address.',
    `legal_address_line_1` STRING COMMENT 'The first line of the legal address of the entity as registered with the relevant registration authority. This is the official address for legal and regulatory purposes.',
    `legal_address_line_2` STRING COMMENT 'The second line of the legal address, typically containing additional address details such as suite, floor, or building information.',
    `legal_address_postal_code` STRING COMMENT 'The postal code or ZIP code component of the legal address.',
    `legal_address_region` STRING COMMENT 'The region, state, province, or administrative subdivision component of the legal address.',
    `legal_entity_name` STRING COMMENT 'The official legal name of the entity as registered with the relevant registration authority. This is the primary legal name under which the entity operates and is recognized in legal and regulatory contexts.',
    `legal_entity_name_local` STRING COMMENT 'The legal name of the entity in the local language and script of the jurisdiction of registration, if different from the transliterated or English version.',
    `legal_form_code` STRING COMMENT 'The code representing the legal form of the entity (e.g., corporation, partnership, trust) as defined by the Entity Legal Forms (ELF) code list maintained by GLEIF.',
    `legal_form_name` STRING COMMENT 'The descriptive name of the legal form corresponding to the legal form code (e.g., Public Limited Company, Limited Liability Company).',
    `lei_code` STRING COMMENT 'The 20-character alphanumeric ISO 17442 Legal Entity Identifier code assigned to the legal entity by a Local Operating Unit (LOU) under the Global Legal Entity Identifier Foundation (GLEIF) framework. Required for MiFID II, EMIR, and Dodd-Frank regulatory reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `lei_status` STRING COMMENT 'The current status of the LEI code itself within the GLEIF system. ISSUED indicates an active LEI; LAPSED indicates the LEI has not been renewed; MERGED, RETIRED, ANNULLED, CANCELLED indicate various termination states; TRANSFERRED and PENDING_TRANSFER indicate LEI management changes between LOUs. [ENUM-REF-CANDIDATE: ISSUED|LAPSED|MERGED|RETIRED|ANNULLED|CANCELLED|TRANSFERRED|PENDING_TRANSFER|PENDING_ARCHIVAL — 9 candidates stripped; promote to reference product]',
    `managing_lou_code` STRING COMMENT 'The code identifying the Local Operating Unit (LOU) that currently manages and maintains the LEI record. LOUs are accredited organizations authorized by GLEIF to issue and manage LEIs.',
    `managing_lou_name` STRING COMMENT 'The name of the Local Operating Unit (LOU) that currently manages the LEI record (e.g., London Stock Exchange, Bloomberg Finance L.P., DTCC).',
    `next_renewal_date` DATE COMMENT 'The date by which the LEI must be renewed to maintain its ISSUED status. LEIs must be renewed annually; failure to renew results in a LAPSED status.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this LEI registry record was first created in the enterprise data lakehouse. Represents the initial load or ingestion time.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this LEI registry record was last updated in the enterprise data lakehouse. Reflects the most recent synchronization or modification.',
    `registration_authority_code` STRING COMMENT 'The identifier of the registration authority (business registry) where the entity is officially registered. This is typically a code from the Registration Authorities Code List (RAL) maintained by GLEIF.',
    `registration_authority_name` STRING COMMENT 'The name of the registration authority or business registry where the entity is officially registered (e.g., Companies House UK, Delaware Division of Corporations).',
    `relationship_last_update_date` DATE COMMENT 'The date when the parent-child relationship information (direct parent and ultimate parent LEIs) was last updated or validated in the GLEIF system.',
    `relationship_status` STRING COMMENT 'The status of the parent-child relationship data reported to GLEIF. ACTIVE indicates current, valid relationship information; INACTIVE indicates the relationship data is no longer current or has been superseded.. Valid values are `ACTIVE|INACTIVE`',
    `successor_lei` STRING COMMENT 'The LEI code of the successor entity, if this entity has been merged, acquired, or otherwise succeeded by another legal entity. Used to maintain continuity in regulatory reporting and relationship tracking.. Valid values are `^[A-Z0-9]{20}$`',
    `ultimate_parent_lei` STRING COMMENT 'The LEI code of the ultimate parent entity at the top of the corporate ownership hierarchy. This represents the highest-level parent entity that is not itself owned or controlled by another entity, as reported under GLEIF Level 2 relationship data. Required for consolidated regulatory reporting and risk assessment.. Valid values are `^[A-Z0-9]{20}$`',
    `validation_source` STRING COMMENT 'The level of validation and corroboration applied to the relationship data. FULLY_CORROBORATED indicates both parent and child have confirmed the relationship; PARTIALLY_CORROBORATED indicates one party has confirmed; ENTITY_SUPPLIED_ONLY indicates self-reported data without external validation; PENDING indicates validation is in progress.. Valid values are `FULLY_CORROBORATED|PARTIALLY_CORROBORATED|ENTITY_SUPPLIED_ONLY|PENDING`',
    CONSTRAINT pk_lei_registry PRIMARY KEY(`lei_registry_id`)
) COMMENT 'Legal Entity Identifier (LEI) registry — authoritative source for LEI codes assigned to legal entities under the GLEIF framework. Captures LEI code, legal entity name, legal address, headquarters country, registration authority, LEI status, renewal date, and ultimate parent LEI. Required for MiFID II, EMIR, and Dodd-Frank regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`market_data_source` (
    `market_data_source_id` BIGINT COMMENT 'Unique identifier for the market data source provider or feed. Primary key.',
    `fallback_source_market_data_source_id` BIGINT COMMENT 'Reference to the alternative market data source to be used if this source becomes unavailable or fails quality checks. Self-referential foreign key to another market_data_source record.',
    `annual_cost_usd` DECIMAL(18,2) COMMENT 'Total annual subscription or licensing cost for this market data source in USD. Used for vendor cost management and budgeting.',
    `asset_class_coverage` STRING COMMENT 'Comma-separated list of asset classes covered by this source (e.g., equities, fixed income, FX, commodities, derivatives, credit, structured products). Indicates scope of market data provided.',
    `business_owner_lob` STRING COMMENT 'Primary line of business or division that owns and funds this market data source (e.g., Trading, Asset Management, Risk, Treasury). Used for cost allocation and accountability.',
    `connectivity_method` STRING COMMENT 'Technical delivery mechanism for the data feed: API (REST/SOAP), FTP/SFTP batch transfer, real-time streaming protocol, message queue (e.g., Kafka, MQ), direct market feed, or web service. [ENUM-REF-CANDIDATE: API|FTP|SFTP|real-time-stream|message-queue|direct-feed|web-service — 7 candidates stripped; promote to reference product]',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate the cost of this data source across business units or cost centers: direct charge, allocated by usage, shared equally, or via Funds Transfer Pricing (FTP).. Valid values are `direct|allocated|shared|FTP`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this market data source record was first created in the system.',
    `data_frequency` STRING COMMENT 'Granularity or update frequency of the market data feed: tick-by-tick, per-second, per-minute, hourly, daily, weekly, or monthly. [ENUM-REF-CANDIDATE: tick|second|minute|hourly|daily|weekly|monthly — 7 candidates stripped; promote to reference product]',
    `data_quality_tier` STRING COMMENT 'Enterprise classification of the sources data quality and reliability: tier-1 (highest quality, regulatory-grade), tier-2 (standard quality), tier-3 (lower quality or unverified), or internal (proprietary pricing desk).. Valid values are `tier-1|tier-2|tier-3|internal`',
    `data_retention_days` STRING COMMENT 'Number of days historical data from this source is retained in the enterprise data lake or warehouse. Driven by regulatory requirements, storage costs, and business needs.',
    `data_steward_email` STRING COMMENT 'Email address of the data steward responsible for this market data source.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `data_steward_name` STRING COMMENT 'Name of the enterprise data steward or data owner responsible for governance, quality monitoring, and vendor relationship management for this source.',
    `feed_type` STRING COMMENT 'Classification of the data feed delivery frequency and latency: real-time streaming, delayed quotes, end-of-day batch, intraday snapshots, evaluated pricing, or composite aggregated feeds.. Valid values are `real-time|delayed|end-of-day|intraday|evaluated|composite`',
    `instrument_type_coverage` STRING COMMENT 'Specific instrument types or security classifications covered by this source (e.g., listed equities, corporate bonds, government securities, interest rate swaps, FX forwards, commodity futures). Complements asset_class_coverage with granular detail.',
    `last_review_date` DATE COMMENT 'Date of the most recent governance or vendor review for this data source. Used to track periodic assessments of data quality, cost-effectiveness, and regulatory compliance.',
    `license_end_date` DATE COMMENT 'Expiration or renewal date of the current license agreement. Null if perpetual or rolling subscription.',
    `license_start_date` DATE COMMENT 'Effective start date of the current license agreement or subscription term with this provider.',
    `license_type` STRING COMMENT 'Licensing model governing usage rights: enterprise-wide, per-user subscription, per-device, display-only (for human viewing), non-display (for automated systems), or internal-use only.. Valid values are `enterprise|per-user|per-device|display-only|non-display|internal-use`',
    `market_coverage` STRING COMMENT 'Geographic markets or exchanges covered by this source (e.g., NYSE, LSE, XETRA, TSE, global OTC). Comma-separated list of market identifiers or regions.',
    `market_data_source_status` STRING COMMENT 'Current operational status of the market data source: active (in production use), inactive (temporarily disabled), suspended (service issue), decommissioned (retired), pilot (testing phase), or pending-approval (awaiting governance approval).. Valid values are `active|inactive|suspended|decommissioned|pilot|pending-approval`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next governance or vendor review. Ensures periodic reassessment of source performance and alignment with enterprise needs.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, known issues, or historical context about this market data source.',
    `onboarding_date` DATE COMMENT 'Date when this market data source was first onboarded and integrated into the enterprise data infrastructure.',
    `override_governance_rule` STRING COMMENT 'Description of the governance process and approval requirements for overriding prices from this source. Defines who can override, under what conditions, and audit trail requirements.',
    `pricing_methodology` STRING COMMENT 'Description of how prices are determined by this source: exchange last trade, composite average (e.g., BGN composite), evaluated/model-based pricing, broker quotes, internal desk pricing, or consensus pricing.',
    `provider_code` STRING COMMENT 'Short alphanumeric code or ticker symbol uniquely identifying the provider within the enterprise (e.g., BBG, RFTV, ICE, MKIT).',
    `provider_name` STRING COMMENT 'Legal or trading name of the market data provider (e.g., Bloomberg, Refinitiv, ICE Data Services, IHS Markit, SIX Financial Information).',
    `regulatory_approved_flag` BOOLEAN COMMENT 'Indicates whether this source is approved for use in regulatory reporting, capital calculations, or official valuations (e.g., CCAR, DFAST, Basel III, IFRS 9). True if approved, False otherwise.',
    `sla_data_accuracy_pct` DECIMAL(18,2) COMMENT 'Contractually committed data accuracy rate (e.g., 99.99%). Measures correctness of prices, reference data, and corporate actions.',
    `sla_latency_ms` STRING COMMENT 'Maximum guaranteed latency in milliseconds for real-time or intraday feeds. Critical for trading and risk systems requiring low-latency market data.',
    `sla_uptime_pct` DECIMAL(18,2) COMMENT 'Contractually committed uptime percentage for the data feed (e.g., 99.95%). Used to monitor vendor performance and trigger service credits.',
    `source_designation` STRING COMMENT 'Role of this source in the enterprise data hierarchy: primary (authoritative default), fallback (used when primary unavailable), supplementary (additional validation), or reference-only (not used for valuation).. Valid values are `primary|fallback|supplementary|reference-only`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this market data source record was last modified. Used for audit trail and change tracking.',
    `valuation_use_case` STRING COMMENT 'Comma-separated list of valuation contexts where this source is authoritative: MTM (mark-to-market), NAV (net asset value), risk valuation, regulatory reporting, client reporting, collateral valuation, or internal management reporting.',
    `vendor_contact_email` STRING COMMENT 'Email address of the primary vendor contact for support, escalations, and service issues.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the primary vendor account manager or technical contact for this data source.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the primary vendor contact for urgent support and escalations.',
    CONSTRAINT pk_market_data_source PRIMARY KEY(`market_data_source_id`)
) COMMENT 'Master registry of external market data providers, pricing sources, and data feeds used across the enterprise — including Bloomberg, Refinitiv, ICE, IHS Markit, SIX Financial, and internal pricing desks. Captures provider name, feed type, asset class coverage, data frequency, licensing terms, SLA commitments, connectivity method (API, FTP, real-time), data quality tier, pricing methodology (e.g., BGN composite, exchange last trade, evaluated/model-based), primary/fallback source designation per instrument type and market, and override governance rules. Governs which source is authoritative for each data type, valuation use case, and regulatory context. Used by MTM, NAV calculation, risk valuation, and all downstream market data consumers.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` (
    `regulatory_taxonomy_id` BIGINT COMMENT 'Unique identifier for the regulatory taxonomy record.',
    `jurisdiction_id` BIGINT COMMENT 'FK to reference.jurisdiction',
    `primary_predecessor_taxonomy_regulatory_taxonomy_id` BIGINT COMMENT 'Reference to the previous version of this taxonomy that this version supersedes. Null if this is the first version.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Regulatory taxonomies have asset thresholds denominated in specific currencies. The threshold_currency STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to r',
    `applicable_entity_types` STRING COMMENT 'Comma-separated list of entity types or institution categories to which this taxonomy applies (e.g., Bank Holding Company, Savings and Loan, Investment Bank, Broker-Dealer, Insurance Company).',
    `asset_threshold_minimum` DECIMAL(18,2) COMMENT 'Minimum total asset threshold (in reporting currency) for institutions required to report using this taxonomy. Null if no threshold applies.',
    `change_summary` STRING COMMENT 'Summary of key changes, additions, or deletions in this taxonomy version compared to the predecessor version.',
    `compliance_notes` STRING COMMENT 'Free-text field for internal notes, observations, or action items related to compliance with this taxonomy.',
    `contact_email` STRING COMMENT 'Email address for inquiries or support related to this taxonomy, typically provided by the issuing authority or internal regulatory reporting team.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory taxonomy record was first created in the system.',
    `data_point_count` STRING COMMENT 'Total number of individual data points or reporting codes defined within this taxonomy version.',
    `effective_date` DATE COMMENT 'The date from which this taxonomy version becomes effective and must be used for regulatory reporting.',
    `expiration_date` DATE COMMENT 'The date on which this taxonomy version is superseded or retired. Null if currently active.',
    `hierarchical_structure` STRING COMMENT 'Indicates whether the taxonomy has a flat structure or a hierarchical/multi-level structure with parent-child code relationships (flat, hierarchical, multi-level, dimensional).. Valid values are `flat|hierarchical|multi_level|dimensional`',
    `implementation_guidance_url` STRING COMMENT 'URL or reference to official implementation guidance, FAQs, or technical documentation provided by the issuing authority.',
    `internal_owner` STRING COMMENT 'Name or identifier of the internal business unit, team, or individual responsible for maintaining the mapping and compliance with this taxonomy.',
    `issuing_authority` STRING COMMENT 'The regulatory body or governing authority that issued and maintains this taxonomy (e.g., Federal Reserve, BCBS, EBA, SEC, FINRA, CFTC, FinCEN).',
    `last_review_date` DATE COMMENT 'The date on which the taxonomy mapping and compliance were last reviewed by the internal regulatory reporting team.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the use of this taxonomy is mandatory for regulated entities within the applicable jurisdiction (True) or optional/voluntary (False).',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of the taxonomy mapping and compliance.',
    `publication_date` DATE COMMENT 'The date on which the taxonomy or its version was officially published by the issuing authority.',
    `regulatory_framework` STRING COMMENT 'The overarching regulatory framework or legislation under which this taxonomy is defined (e.g., Basel III, CCAR, DFAST, FATCA, CRS, MiFID II, EMIR, FRTB). [ENUM-REF-CANDIDATE: Basel III|Basel IV|CCAR|DFAST|FATCA|CRS|MiFID II|EMIR|FRTB|IFRS 9|CECL|Dodd-Frank|SOX|BSA|AML — 15 candidates stripped; promote to reference product]',
    `reporting_frequency` STRING COMMENT 'The required frequency at which reports using this taxonomy must be submitted to the regulatory authority (daily, weekly, monthly, quarterly, semi-annual, annual, ad-hoc). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `reporting_platform_code` STRING COMMENT 'Internal code or identifier used by the regulatory reporting platform (e.g., AxiomSL, OneSumX) to reference this taxonomy in mapping and transformation logic.',
    `schedule_count` STRING COMMENT 'Total number of schedules, forms, or report sections defined within this taxonomy.',
    `schema_location_url` STRING COMMENT 'URL or file path to the official schema definition file (XSD, JSON schema, etc.) for this taxonomy.',
    `source_document_reference` STRING COMMENT 'Reference to the official regulatory document, circular, or publication that defines this taxonomy (e.g., BCBS document number, Federal Register citation, EBA guideline reference).',
    `submission_method` STRING COMMENT 'The technical format or method required for submitting reports based on this taxonomy (e.g., XBRL, XML, CSV, PDF, API, portal).. Valid values are `XBRL|XML|CSV|PDF|API|portal`',
    `taxonomy_code` STRING COMMENT 'Unique code or identifier assigned to the taxonomy by the issuing regulatory authority (e.g., BCBS239, FFIEC031, SEC10K).',
    `taxonomy_description` STRING COMMENT 'Detailed description of the purpose, scope, and content of the regulatory taxonomy, including the types of data points and schedules it covers.',
    `taxonomy_name` STRING COMMENT 'Official name of the regulatory taxonomy or reporting framework (e.g., Basel III Pillar 3, CCAR Schedule A, DFAST FR Y-14Q, FATCA Form 8966).',
    `taxonomy_status` STRING COMMENT 'Current lifecycle status of the taxonomy version (draft, active, superseded, retired, under_review).. Valid values are `draft|active|superseded|retired|under_review`',
    `taxonomy_type` STRING COMMENT 'The category or domain of regulatory reporting this taxonomy addresses (e.g., capital adequacy, liquidity, credit risk, market risk, operational risk, stress testing, tax compliance, trade reporting, financial statement). [ENUM-REF-CANDIDATE: capital_adequacy|liquidity|credit_risk|market_risk|operational_risk|stress_testing|tax_compliance|trade_reporting|financial_statement — 9 candidates stripped; promote to reference product]',
    `taxonomy_version` STRING COMMENT 'Version number or release identifier of the taxonomy schema (e.g., v3.1, 2023Q4, Release 5.0).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory taxonomy record was last updated in the system.',
    `validation_rules_url` STRING COMMENT 'URL or reference to the official validation rules, business rules, or edit checks document for this taxonomy.',
    `xbrl_namespace` STRING COMMENT 'The XBRL namespace URI for this taxonomy if XBRL is the submission format. Null if not applicable.',
    CONSTRAINT pk_regulatory_taxonomy PRIMARY KEY(`regulatory_taxonomy_id`)
) COMMENT 'Regulatory reporting taxonomy and code list master covering Basel III/IV, CCAR, DFAST, FATCA, CRS, MiFID II, EMIR, and FRTB reporting schemas. Captures taxonomy name, regulatory framework, version, issuing authority, effective date, hierarchical code structure, and granular reporting code entries (individual line items, data point codes, schedule references, code values, labels, parent codes, data types, validation rules, and mapping notes). Serves as the single source of truth for both taxonomy-level metadata and individual reporting code entries used by the regulatory reporting platform (AxiomSL/OneSumX) to map internal GL and risk data to regulatory report cells and schedules.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`reporting_code` (
    `reporting_code_id` BIGINT COMMENT 'Unique identifier for the regulatory reporting code entry. Primary key for the reporting code table.',
    `parent_code_reporting_code_id` BIGINT COMMENT 'Reference to the parent reporting code in hierarchical taxonomies. Enables navigation of nested reporting structures (e.g., schedule > section > line item). Null for top-level codes.',
    `primary_superseded_by_code_reporting_code_id` BIGINT COMMENT 'Reference to the reporting code that replaces this code when it is superseded or deprecated. Enables seamless transition during regulatory changes.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Reference to the parent regulatory reporting taxonomy that this code belongs to (e.g., Basel III, CCAR, DFAST, FATCA/CRS).',
    `aggregation_method` STRING COMMENT 'Method for aggregating child code values to calculate this code (e.g., sum for balance sheet items, weighted average for rates). Supports automated roll-ups.. Valid values are `sum|average|maximum|minimum|count|weighted_average`',
    `business_definition` STRING COMMENT 'Detailed business definition and interpretation guidance for this reporting code. Provides context for data stewards and analysts mapping source data.',
    `calculation_formula` STRING COMMENT 'Formula or expression defining how this reporting code value should be calculated from source data or other codes. Enables automated report generation.',
    `code_label` STRING COMMENT 'Human-readable label or description of the reporting code as it appears in regulatory documentation. Provides business context for the technical code value.',
    `code_level` STRING COMMENT 'Numeric level in the reporting taxonomy hierarchy (e.g., 1 for schedule, 2 for section, 3 for line item). Facilitates hierarchical queries and roll-ups.',
    `code_path` STRING COMMENT 'Full hierarchical path from root to this code (e.g., /CCAR/Schedule_A/Section_1/Line_10). Enables efficient ancestor and descendant queries.',
    `code_value` DECIMAL(18,2) COMMENT 'The actual code value or identifier used in regulatory submissions (e.g., line item number, data point code, schedule reference). This is the technical code that appears in regulatory filings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reporting code record was first created in the system. Supports audit trail and change tracking.',
    `data_quality_threshold` DECIMAL(18,2) COMMENT 'Minimum acceptable data quality score (as percentage) for values reported under this code. Drives data quality monitoring and remediation workflows.',
    `data_type` STRING COMMENT 'Expected data type for values reported under this code. Guides validation and formatting of regulatory submissions. [ENUM-REF-CANDIDATE: monetary|percentage|count|text|date|boolean|ratio — 7 candidates stripped; promote to reference product]',
    `effective_from_date` DATE COMMENT 'Date from which this reporting code becomes effective and must be used in regulatory submissions. Supports regulatory change management.',
    `effective_to_date` DATE COMMENT 'Date until which this reporting code remains effective. Null for currently active codes. Enables historical reporting and regulatory change tracking.',
    `example_value` DECIMAL(18,2) COMMENT 'Sample or example value for this reporting code to illustrate expected format and content. Aids in user training and system testing.',
    `gl_account_mapping` STRING COMMENT 'Comma-separated list or pattern of General Ledger (GL) account codes that feed into this reporting code. Enables traceability from source to regulatory report.',
    `is_calculated` BOOLEAN COMMENT 'Indicates whether this code value is calculated from other codes (true) or directly sourced from operational systems (false). Guides data lineage and validation.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether data reported under this code is considered confidential or sensitive by the regulatory authority. Drives access control and data handling.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this reporting code is mandatory (true) or optional (false) for regulatory submissions. Drives validation and completeness checks.',
    `mapping_notes` STRING COMMENT 'Detailed notes on how internal General Ledger (GL) accounts, risk data, or other source systems map to this reporting code. Critical for accurate regulatory submissions.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body that requires this reporting code (e.g., Federal Reserve, OCC, SEC, EBA). Identifies the governing authority for compliance.',
    `regulatory_reference` STRING COMMENT 'Citation or reference to the specific regulatory document, instruction guide, or legal text that defines this reporting code (e.g., Basel III paragraph 49, FR Y-14A instructions page 12).',
    `report_schedule_name` STRING COMMENT 'Name of the regulatory report schedule or form that contains this code (e.g., FR Y-14A, Call Report Schedule RC-R, FINREP F01.01). Provides report context.',
    `reporting_code_status` STRING COMMENT 'Current lifecycle status of the reporting code. Active codes are used in current submissions; deprecated codes are phased out; proposed codes are pending implementation.. Valid values are `active|deprecated|proposed|superseded|retired`',
    `reporting_frequency` STRING COMMENT 'Required frequency for reporting this code to regulators (e.g., quarterly for CCAR, monthly for liquidity reports). Drives reporting calendar and workflow. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi-annually|annually|ad-hoc — 7 candidates stripped; promote to reference product]',
    `rounding_rule` STRING COMMENT 'Rounding convention for reported values (e.g., round to nearest thousand, round up, truncate). Ensures compliance with regulatory formatting requirements.',
    `sign_convention` STRING COMMENT 'Convention for reporting positive or negative values (e.g., assets positive, liabilities negative, or absolute values only). Ensures consistent interpretation.. Valid values are `positive|negative|absolute|net`',
    `taxonomy_version` STRING COMMENT 'Version identifier of the regulatory taxonomy (e.g., 2023.1, v4.2). Critical for tracking regulatory changes and ensuring correct mapping over time.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for numeric reporting codes (e.g., USD thousands, basis points, percentage, count). Essential for correct interpretation and aggregation.',
    `updated_by_user` STRING COMMENT 'Identifier of the user or system process that last updated this reporting code record. Supports accountability and audit requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this reporting code record was last modified. Enables change detection and version control.',
    `validation_rule` STRING COMMENT 'Business rule or formula for validating reported values (e.g., must be >= 0, sum of child codes, cross-schedule validation). Supports automated quality checks.',
    `xbrl_tag` STRING COMMENT 'XBRL tag or element name associated with this reporting code for electronic regulatory filings. Enables automated XBRL report generation.',
    CONSTRAINT pk_reporting_code PRIMARY KEY(`reporting_code_id`)
) COMMENT 'Granular regulatory reporting code entries within a taxonomy — individual line items, data point codes, and schedule references used in regulatory submissions. Captures code value, code label, parent code, taxonomy version, data type, validation rules, and mapping notes. Enables precise mapping of internal GL and risk data to regulatory report cells.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`product_type` (
    `product_type_id` BIGINT COMMENT 'Primary key for product_type',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Banking product types have default currencies. The currency_code STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve currency_name, iso_code, and o',
    `aml_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether transactions for this product type require anti-money laundering transaction monitoring, suspicious activity report (SAR) screening, and currency transaction report (CTR) filing.',
    `asset_class` STRING COMMENT 'Financial asset class to which this product type belongs (loan, deposit, equity, fixed income, derivative, foreign exchange, commodity, other). Used for risk aggregation and capital allocation. [ENUM-REF-CANDIDATE: loan|deposit|equity|fixed_income|derivative|fx|commodity|other — 8 candidates stripped; promote to reference product]',
    `benchmark_rate_type` STRING COMMENT 'The interest rate benchmark or reference rate typically used for pricing this product type (e.g., SOFR, LIBOR legacy, Prime Rate, Fed Funds Rate, Treasury Yield). Applicable for interest-bearing products.',
    `booking_model` STRING COMMENT 'Accounting treatment and valuation methodology applied to this product type (accrual, fair value, amortized cost, held for trading, available for sale). Determines how the product is measured and reported in the general ledger.. Valid values are `accrual|fair_value|amortized_cost|held_for_trading|available_for_sale`',
    `ccar_dfast_category` STRING COMMENT 'Product classification used in CCAR and DFAST stress testing scenarios for capital planning and regulatory submissions to the Federal Reserve.',
    `cecl_portfolio_segment` STRING COMMENT 'Portfolio segment assignment for CECL expected credit loss calculation and allowance for credit losses (ACL) estimation under FASB ASC 326.',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether this product type typically requires collateral or security (true for secured lending products, false for unsecured products).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this product type reference record was first created in the system. Used for audit trail and data lineage.',
    `credit_risk_flag` BOOLEAN COMMENT 'Indicates whether this product type carries credit risk exposure requiring probability of default (PD), loss given default (LGD), and exposure at default (EAD) calculations for capital adequacy purposes.',
    `crs_reportable_flag` BOOLEAN COMMENT 'Indicates whether accounts or transactions under this product type are subject to Common Reporting Standard (CRS) reporting for automatic exchange of financial account information between jurisdictions.',
    `effective_end_date` DATE COMMENT 'The date on which this product type was discontinued or retired from the product catalog. Null for currently active products. Used for temporal validity and product lifecycle management.',
    `effective_start_date` DATE COMMENT 'The date from which this product type became available for booking and customer origination. Used for temporal validity and historical product analysis.',
    `fatca_reportable_flag` BOOLEAN COMMENT 'Indicates whether accounts or transactions under this product type are subject to FATCA reporting requirements for U.S. tax compliance.',
    `fee_schedule_type` STRING COMMENT 'Reference to the applicable fee schedule or pricing model for this product type (e.g., Standard Commercial Lending Fees, Wealth Management Advisory Fees, Transaction Banking Fees). Used to link product types to fee structures.',
    `gl_account_mapping` STRING COMMENT 'Reference to the general ledger account code(s) or chart of accounts segment used for booking transactions of this product type. Enables financial reporting and reconciliation.',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether this product type accrues or pays interest (true for interest-bearing products like loans and deposits, false for non-interest products like guarantees and advisory services).',
    `kyc_requirement_level` STRING COMMENT 'The level of customer due diligence and KYC documentation required for this product type (standard, enhanced for high-risk products, simplified for low-risk, or not required for non-customer-facing products).. Valid values are `standard|enhanced|simplified|not_required`',
    `liquidity_risk_flag` BOOLEAN COMMENT 'Indicates whether this product type contributes to liquidity risk metrics such as Liquidity Coverage Ratio (LCR) and Net Stable Funding Ratio (NSFR).',
    `lob_ownership` STRING COMMENT 'The primary line of business or business unit responsible for managing, marketing, and servicing this product type (e.g., Commercial Banking, Investment Banking, Wealth Management, Treasury).',
    `market_risk_flag` BOOLEAN COMMENT 'Indicates whether this product type is subject to market risk (interest rate, foreign exchange, equity, commodity price movements) requiring Value at Risk (VaR) and stress testing.',
    `maximum_amount` DECIMAL(18,2) COMMENT 'The maximum transaction or account balance amount allowed for this product type, expressed in the banks base currency. Used for product eligibility, risk limits, and regulatory compliance.',
    `minimum_amount` DECIMAL(18,2) COMMENT 'The minimum transaction or account balance amount required for this product type, expressed in the banks base currency. Used for product eligibility and origination controls.',
    `multi_currency_flag` BOOLEAN COMMENT 'Indicates whether this product type supports multiple currencies (true for multi-currency accounts and foreign exchange products, false for single-currency products).',
    `operational_risk_flag` BOOLEAN COMMENT 'Indicates whether this product type is subject to operational risk capital requirements under the Standardized Measurement Approach (SMA) or Advanced Measurement Approach (AMA).',
    `product_family` STRING COMMENT 'High-level grouping of product types into major business lines (lending, deposit, investment, trading, advisory, payment, guarantee, custody, other). [ENUM-REF-CANDIDATE: lending|deposit|investment|trading|advisory|payment|guarantee|custody|other — 9 candidates stripped; promote to reference product]',
    `product_lifecycle_status` STRING COMMENT 'Current lifecycle state of the product type in the banks product catalog (active for current offerings, inactive for temporarily unavailable, discontinued for retired products, pending approval for new products under review, sunset for products being phased out).. Valid values are `active|inactive|discontinued|pending_approval|sunset`',
    `product_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the product type across all bank systems. Used as the business key for product classification in regulatory reporting and internal systems.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `product_type_description` STRING COMMENT 'Detailed business description of the product type, including key features, typical use cases, target customer segments, and distinguishing characteristics.',
    `product_type_name` STRING COMMENT 'Full business name of the product type as recognized by business users and customers (e.g., Term Loan, Revolving Credit Facility, Demand Deposit Account, Interest Rate Swap).',
    `regulatory_product_category_basel` STRING COMMENT 'Product classification according to Basel III regulatory framework for capital adequacy and risk-weighted asset (RWA) calculation (e.g., Corporate Exposure, Retail Exposure, Sovereign Exposure).',
    `regulatory_product_category_ifrs9` STRING COMMENT 'Product classification according to IFRS 9 accounting standard for financial instruments, determining measurement basis (amortized cost, fair value through other comprehensive income, fair value through profit or loss) and expected credit loss (ECL) calculation approach.',
    `regulatory_reporting_category` STRING COMMENT 'Standardized category code used for regulatory reporting submissions to Federal Reserve, OCC, FDIC, SEC, or other governing bodies (e.g., Call Report schedule codes, FR Y-9C line items).',
    `rwa_approach` STRING COMMENT 'The Basel III approach used to calculate risk-weighted assets for this product type (standardized approach, foundation internal ratings-based, advanced internal ratings-based, or not applicable for non-credit products).. Valid values are `standardized|foundation_irb|advanced_irb|not_applicable`',
    `sla_service_level` STRING COMMENT 'The service level commitment associated with this product type, defining response times, processing speeds, and support availability (standard, priority, premium, or not applicable for non-service products).. Valid values are `standard|priority|premium|not_applicable`',
    `sub_product_type` STRING COMMENT 'Granular sub-classification within the product type (e.g., for Term Loan: Senior Secured, Subordinated; for Deposit: Savings, Checking, Money Market).',
    `tax_reporting_category` STRING COMMENT 'Tax classification for this product type used for IRS Form 1099 reporting, withholding tax calculations, and tax compliance (e.g., interest income, dividend income, capital gains).',
    `typical_term_months` STRING COMMENT 'The standard or most common term length in months for this product type (e.g., 60 months for a 5-year term loan, 12 months for a 1-year certificate of deposit). Null for demand or perpetual products.',
    `updated_by_user` STRING COMMENT 'The user ID or system identifier of the person or process that last updated this product type record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this product type reference record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    CONSTRAINT pk_product_type PRIMARY KEY(`product_type_id`)
) COMMENT 'Enterprise-wide banking product type taxonomy — authoritative classification of all financial products offered by the bank (term loans, revolving credit, demand deposits, time deposits, interest rate swaps, FX forwards, letters of credit, guarantees, etc.). Captures product type code, product family, asset class, sub-product type, regulatory product category (Basel, IFRS 9), line of business ownership, booking model, and applicable fee schedule type. Used for regulatory reporting bucketing, risk aggregation, product catalog management, and cross-domain product identification.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'Unique identifier for the jurisdiction record. Primary key.',
    `parent_jurisdiction_id` BIGINT COMMENT 'Reference to the parent jurisdiction for hierarchical relationships (e.g., New York States parent is United States). Null for top-level jurisdictions.',
    `accounting_standard` STRING COMMENT 'Primary accounting standard required for financial reporting in this jurisdiction: International Financial Reporting Standards (IFRS), United States Generally Accepted Accounting Principles (US GAAP), local GAAP, or mixed.. Valid values are `IFRS|US GAAP|local GAAP|mixed`',
    `aml_authority` STRING COMMENT 'Name of the primary anti-money laundering and financial crime enforcement authority in this jurisdiction (e.g., Financial Crimes Enforcement Network, Financial Intelligence Unit).',
    `basel_implementation_status` STRING COMMENT 'Status of Basel III/IV capital and liquidity framework implementation in this jurisdiction. Critical for Risk-Weighted Assets (RWA) and capital adequacy calculations.. Valid values are `basel III compliant|basel IV compliant|partial|non-compliant|not applicable`',
    `bic_country_code` STRING COMMENT 'Two-letter ISO 3166-1 alpha-2 country code used in Bank Identifier Codes (BIC) and International Bank Account Numbers (IBAN) for this jurisdiction.. Valid values are `^[A-Z]{2}$`',
    `business_day_convention` STRING COMMENT 'Standard business day convention used in this jurisdiction for financial calculations (e.g., following, modified following, preceding). Critical for interest accrual and settlement date calculations.',
    `capital_adequacy_framework` STRING COMMENT 'The approach to capital adequacy calculation permitted or mandated in this jurisdiction: Standardized Approach (SA), Internal Ratings-Based (IRB) Approach, Advanced IRB, or other.. Valid values are `standardized approach|internal ratings-based|advanced|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was first created in the system.',
    `credit_loss_methodology` STRING COMMENT 'Required methodology for credit loss provisioning: Current Expected Credit Losses (CECL), IFRS 9 Expected Credit Loss (ECL), incurred loss model, or other.. Valid values are `CECL|IFRS 9 ECL|incurred loss|other`',
    `crs_status` STRING COMMENT 'Classification of the jurisdictions participation in the OECD Common Reporting Standard for automatic exchange of financial account information.. Valid values are `participating|committed|non-participating`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the official currency of this jurisdiction (e.g., USD, EUR, GBP, JPY). For jurisdictions with multiple official currencies, the primary currency is listed.. Valid values are `^[A-Z]{3}$`',
    `data_privacy_regime` STRING COMMENT 'Primary data protection and privacy regulatory framework applicable in this jurisdiction (e.g., General Data Protection Regulation (GDPR), California Consumer Privacy Act (CCPA), Personal Data Protection Act (PDPA)).',
    `effective_from_date` DATE COMMENT 'Date from which this jurisdiction record is effective and valid for use in banking operations and regulatory reporting.',
    `effective_to_date` DATE COMMENT 'Date until which this jurisdiction record is effective. Null for currently active jurisdictions with no planned end date.',
    `fatca_status` STRING COMMENT 'Classification of the jurisdictions participation in FATCA: Model 1 Intergovernmental Agreement (IGA), Model 2 IGA, non-IGA compliant, or not applicable.. Valid values are `model 1 IGA|model 2 IGA|non-IGA|not applicable`',
    `high_risk_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this jurisdiction is classified as high-risk for Anti-Money Laundering (AML) or Counter-Terrorist Financing (CTF) purposes by international bodies such as the Financial Action Task Force (FATF).',
    `holiday_calendar_code` STRING COMMENT 'Reference code to the holiday calendar used for determining non-business days in this jurisdiction (e.g., NYSE, TARGET, JIBOR). Links to the holiday calendar reference data.',
    `iban_supported_flag` BOOLEAN COMMENT 'Indicates whether this jurisdiction uses the International Bank Account Number (IBAN) standard for bank account identification.',
    `insolvency_regime_type` STRING COMMENT 'Classification of the insolvency and bankruptcy framework in this jurisdiction (e.g., debtor-friendly, creditor-friendly, administrative, judicial). Impacts Loss Given Default (LGD) and recovery rate assumptions.',
    `jurisdiction_code` STRING COMMENT 'Standardized code identifying the jurisdiction. Uses ISO 3166-1 alpha-2/alpha-3 for national jurisdictions, with optional subdivision codes (e.g., US-NY for New York State, EU for European Union).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{1,3})?$`',
    `jurisdiction_level` STRING COMMENT 'Hierarchical level of the jurisdiction: national (country-level), sub-national (state/province/region), supranational (multi-country bodies like EU or Basel Committee), or territorial (dependent territories).. Valid values are `national|sub-national|supranational|territorial`',
    `jurisdiction_name` STRING COMMENT 'Full legal name of the jurisdiction (e.g., United States of America, State of New York, European Union).',
    `jurisdiction_status` STRING COMMENT 'Current operational status of the jurisdiction record: active (currently in use), inactive (no longer used for new transactions), historical (archived), or pending (under review for activation).. Valid values are `active|inactive|historical|pending`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was most recently updated.',
    `legal_system_type` STRING COMMENT 'The foundational legal system governing the jurisdiction: common law (precedent-based), civil law (code-based), Sharia law (Islamic principles), mixed (combination), customary law, or other.. Valid values are `common law|civil law|sharia law|mixed|customary law|other`',
    `netting_enforceability_flag` BOOLEAN COMMENT 'Indicates whether close-out netting provisions in derivative contracts are legally enforceable in this jurisdiction under insolvency or default scenarios. Critical for collateral and credit risk management.',
    `netting_opinion_date` DATE COMMENT 'Date of the most recent legal opinion confirming netting enforceability in this jurisdiction. Used to track currency of legal assessments.',
    `primary_regulator` STRING COMMENT 'Name of the primary banking regulatory authority in this jurisdiction (e.g., Federal Reserve System, Office of the Comptroller of the Currency, European Central Bank, Prudential Regulation Authority).',
    `regulatory_framework` STRING COMMENT 'Primary banking and financial regulatory frameworks applicable in this jurisdiction (e.g., Basel III, Basel IV, Dodd-Frank Act, MiFID II, MAS Notice 637). Multiple frameworks separated by semicolons.',
    `rtgs_system_name` STRING COMMENT 'Name of the Real-Time Gross Settlement (RTGS) payment system operated in this jurisdiction (e.g., Fedwire, CHAPS, TARGET2). Null if no RTGS system exists.',
    `sanctions_regime_flag` BOOLEAN COMMENT 'Indicates whether this jurisdiction is subject to international economic sanctions or embargoes that restrict banking and financial transactions.',
    `securities_regulator` STRING COMMENT 'Name of the primary securities and capital markets regulatory authority in this jurisdiction (e.g., Securities and Exchange Commission, Financial Conduct Authority, European Securities and Markets Authority).',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the jurisdiction (e.g., USA, New York, EU).',
    `sovereign_credit_rating` STRING COMMENT 'Most recent sovereign credit rating for this jurisdiction from a major rating agency (e.g., AAA, AA+, BBB-). Used for country risk assessment and Probability of Default (PD) modeling.',
    `sovereign_rating_agency` STRING COMMENT 'Name of the rating agency that issued the sovereign credit rating (e.g., Standard & Poors, Moodys, Fitch Ratings).',
    `sovereign_rating_date` DATE COMMENT 'Date of the most recent sovereign credit rating assessment.',
    `stress_testing_requirement` STRING COMMENT 'Mandatory stress testing framework applicable in this jurisdiction: Comprehensive Capital Analysis and Review (CCAR), Dodd-Frank Act Stress Testing (DFAST), European Banking Authority (EBA) stress test, local framework, or none.. Valid values are `CCAR|DFAST|EBA stress test|local framework|none`',
    `tax_haven_classification` STRING COMMENT 'Classification of the jurisdictions tax regime: tax haven (minimal or no taxation), low-tax (preferential tax rates), standard (typical tax rates), or not classified.. Valid values are `tax haven|low-tax|standard|not classified`',
    `tax_treaty_network_flag` BOOLEAN COMMENT 'Indicates whether this jurisdiction participates in international tax treaty networks for withholding tax relief and double taxation avoidance.',
    `time_zone` STRING COMMENT 'Primary time zone for this jurisdiction in IANA Time Zone Database format (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for trade settlement and market hours.',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Legal and regulatory jurisdiction master covering national, sub-national (state/province), and supranational (EU, Basel Committee) jurisdictions relevant to banking operations. Captures jurisdiction code, jurisdiction name, jurisdiction level (national, state, supranational), governing law system (common law, civil law, Sharia), applicable regulatory frameworks (Basel III/IV, MiFID II, Dodd-Frank, MAS), close-out netting enforceability flag, insolvency regime type, data privacy regime (GDPR, CCPA), and withholding tax treaty status. Used by compliance, legal, collateral (netting opinions), tax, and cross-border transaction processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`market_center` (
    `market_center_id` BIGINT COMMENT 'Unique identifier for the market center or trading venue. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Market centers and exchanges are located in specific countries. The country_code STRING column should be replaced with a proper FK to country.country_id. This enables JOIN to retrieve country_name, re',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Market centers have LEI codes for legal entity identification. The lei_code STRING column should be replaced with a proper FK to lei_registry.lei_registry_id. This enables JOIN to retrieve legal_entit',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Market centers have primary trading currencies. The trading_currency STRING column should be replaced with a proper FK to currency.currency_id. This enables JOIN to retrieve currency_name, iso_code, a',
    `best_execution_venue_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this market center is designated as a best execution venue for order routing and execution quality reporting (True) or not (False).',
    `city` STRING COMMENT 'City where the market center is headquartered or primarily operates (e.g., New York, London, Tokyo, Frankfurt).',
    `clearing_house_name` STRING COMMENT 'Name of the central counterparty (CCP) or clearing house that clears and settles trades executed on this market (e.g., DTCC, LCH, Eurex Clearing).',
    `comments` STRING COMMENT 'Free-text field for additional notes, special operating conditions, or historical context about the market center.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this market center record was first created in the system (yyyy-MM-ddTHH:mm:ss.SSSXXX format).',
    `effective_date` DATE COMMENT 'Date when this market center record became effective or when the market center commenced operations (yyyy-MM-dd format).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the market center is currently operational and accepting trades (True) or inactive/closed (False).',
    `market_category` STRING COMMENT 'Primary asset class or category traded on this market center (equities, fixed income, derivatives, commodities, foreign exchange, crypto, or multi-asset). [ENUM-REF-CANDIDATE: equities|fixed_income|derivatives|commodities|foreign_exchange|crypto|multi_asset — 7 candidates stripped; promote to reference product]',
    `market_center_status` STRING COMMENT 'Current operational status of the market center: active (operating normally), suspended (temporarily halted), closed (permanently ceased operations), merged (consolidated into another venue), or decommissioned.. Valid values are `active|suspended|closed|merged|decommissioned`',
    `market_data_vendor_code` STRING COMMENT 'Proprietary code or identifier used by market data vendors (Bloomberg, Reuters, FactSet) to reference this market center in their data feeds.',
    `market_name` STRING COMMENT 'Full legal or commonly recognized name of the market center, exchange, or trading venue (e.g., New York Stock Exchange, London Stock Exchange, Chicago Mercantile Exchange).',
    `market_type` STRING COMMENT 'Classification of the trading venue type: regulated exchange, multilateral trading facility (MTF), organized trading facility (OTF), systematic internalizer (SI), over-the-counter (OTC), or dark pool.. Valid values are `exchange|multilateral_trading_facility|organized_trading_facility|systematic_internalizer|otc|dark_pool`',
    `mic_code` STRING COMMENT 'ISO 10383 four-character alphanumeric code uniquely identifying the market center, exchange, or trading venue (e.g., XNYS for New York Stock Exchange, XLON for London Stock Exchange).. Valid values are `^[A-Z]{4}$`',
    `mifid2_trading_venue_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this market center is classified as a trading venue under MiFID II regulations (True) or not (False).',
    `operating_hours_close` STRING COMMENT 'Standard market closing time in local timezone (HH:mm format, e.g., 16:00 for NYSE, 16:30 for LSE).. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operating_hours_open` STRING COMMENT 'Standard market opening time in local timezone (HH:mm format, e.g., 09:30 for NYSE, 08:00 for LSE).. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `operating_mic` STRING COMMENT 'Operating MIC code representing the entity operating the market infrastructure, which may differ from the segment MIC for multi-segment exchanges.. Valid values are `^[A-Z]{4}$`',
    `parent_exchange_group` STRING COMMENT 'Name of the parent exchange group or holding company that owns or operates this market center (e.g., Intercontinental Exchange, Euronext, CME Group).',
    `post_trading_session_end` STRING COMMENT 'End time of after-hours or post-close trading session in local timezone (HH:mm format), if applicable.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `pre_trading_session_start` STRING COMMENT 'Start time of pre-market or pre-opening auction session in local timezone (HH:mm format), if applicable.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `regulatory_authority` STRING COMMENT 'Name of the primary regulatory body or financial authority overseeing this market center (e.g., SEC, FCA, BaFin, FINMA, JFSA).',
    `regulatory_status` STRING COMMENT 'Regulatory classification or authorization status of the market center (regulated, authorized, recognized, exempt, or unregulated).. Valid values are `regulated|authorized|recognized|exempt|unregulated`',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for trades executed on this market, expressed as T+N (e.g., T+1, T+2, T+0 for same-day settlement).. Valid values are `^T+[0-9]$`',
    `termination_date` DATE COMMENT 'Date when the market center ceased operations, was merged, or was decommissioned (yyyy-MM-dd format). Null if still active.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the market centers operating hours (e.g., America/New_York, Europe/London, Asia/Tokyo).',
    `trade_reporting_facility_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this market center operates as a trade reporting facility for off-exchange transactions (True) or not (False).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this market center record was last modified or updated (yyyy-MM-ddTHH:mm:ss.SSSXXX format).',
    `website_url` STRING COMMENT 'Official website URL of the market center for reference and market data access.',
    CONSTRAINT pk_market_center PRIMARY KEY(`market_center_id`)
) COMMENT 'Financial market center and exchange master — authoritative registry of exchanges, trading venues, and clearing houses (NYSE, LSE, CME, LME, Euronext, etc.). Captures MIC code (ISO 10383), market name, market type (exchange, MTF, OTC), country, operating hours, currency, clearing house, and regulatory status. Used by trading, securities, and settlement domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`code_list` (
    `code_list_id` BIGINT COMMENT 'Unique identifier for the code list entry. Primary key. [ROLE: REFERENCE_LOOKUP — _canonical_skip_reason: This is a reference/lookup entity serving as a flexible registry for standardized enumeration values; minimum field categories do not apply to REFERENCE_LOOKUP role per canonical-attrs-enforced v0.8.5.]',
    `parent_code_list_id` BIGINT COMMENT 'Self-referencing FK on code_list (parent_code_list_id)',
    `approval_date` DATE COMMENT 'The date when this code value was formally approved for production use. Supports audit trails and regulatory compliance documentation.',
    `approval_status` STRING COMMENT 'Current approval workflow state of this code value. Supports formal change control and governance processes for reference data modifications.. Valid values are `draft|pending_approval|approved|rejected|retired`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this code value for production use. Provides accountability and audit trail for reference data changes.',
    `business_owner` STRING COMMENT 'Name or identifier of the business unit, line of business (LOB), or functional area responsible for defining and maintaining this code value. Establishes accountability for code list governance.',
    `code_description` STRING COMMENT 'Detailed business definition and explanation of the code value, including usage context, calculation rules, and business implications. Provides comprehensive documentation for business users and analysts.',
    `code_label` STRING COMMENT 'Human-readable short label or display name for the code value, used in user interfaces and reports (e.g., Actual/360, Corporate Counterparty, Investment Grade).',
    `code_level` STRING COMMENT 'Hierarchical level or depth of the code within its taxonomy (e.g., 1 for top-level, 2 for sub-category, 3 for detail). Used for hierarchical navigation and aggregation logic.',
    `code_list_type` STRING COMMENT 'The category or domain of the code list (e.g., day_count_convention, settlement_instruction_type, counterparty_type, credit_rating_scale, gl_account_type, nace_sector_code, sic_sector_code). Serves as the primary discriminator for grouping related code values.',
    `code_value` DECIMAL(18,2) COMMENT 'The actual code or key value used in operational systems and data models (e.g., ACT/360, 30/360, T+1, CORP, GOVT). This is the machine-readable identifier that applications reference.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this code list entry was first created in the system. Supports audit trails and data lineage tracking.',
    `data_classification` STRING COMMENT 'Security classification level of the code value and its associated metadata, determining access controls and handling requirements. Most reference codes are public or internal; confidential/restricted applies to proprietary or sensitive classification schemes.. Valid values are `public|internal|confidential|restricted`',
    `data_steward` STRING COMMENT 'Name or identifier of the individual or team responsible for the operational maintenance, quality assurance, and lifecycle management of this code value.',
    `effective_date` DATE COMMENT 'The date from which this code value becomes valid and available for use in operational systems and reporting. Supports temporal validity and regulatory transition management (e.g., LIBOR to SOFR transition).',
    `expiry_date` DATE COMMENT 'The date after which this code value is no longer valid for new transactions or bookings. Null indicates no planned expiration. Supports regulatory phase-outs and product lifecycle management.',
    `external_code_mapping` STRING COMMENT 'Cross-reference to equivalent codes in external systems, vendor platforms, or industry standards (e.g., mapping internal credit rating codes to S&P, Moodys, and Fitch scales). Supports data integration and regulatory reporting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this code value is currently active and available for use in operational systems. False indicates deprecated or retired codes that should not be used for new transactions but may exist in historical data.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this code value should be used as the default selection in user interfaces or system processes when no explicit value is provided. Only one code per code_list_type should be marked as default.',
    `is_system_generated` BOOLEAN COMMENT 'Indicates whether this code value was automatically generated by system processes (true) or manually created by data stewards (false). Supports audit trails and data lineage tracking.',
    `last_review_date` DATE COMMENT 'The date when this code value was last reviewed and validated by the data steward or business owner. Supports periodic review cycles and data quality assurance processes.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this code value. Ensures ongoing validation and relevance of reference data in alignment with governance policies.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, implementation guidance, special handling instructions, or historical context related to this code value. Supports knowledge transfer and operational documentation.',
    `parent_code_value` DECIMAL(18,2) COMMENT 'Reference to the parent code value for hierarchical code lists (e.g., NACE/SIC sector hierarchies, GL account type hierarchies). Null for top-level codes. Enables drill-down and roll-up analytics.',
    `regulatory_framework` STRING COMMENT 'The regulatory regime or standard that defines or mandates this code value (e.g., Basel III, IFRS 9, CECL, MiFID II, FATCA, CRS). Links code values to their authoritative regulatory source.',
    `sort_order` STRING COMMENT 'Numeric sequence for controlling display order in user interfaces, reports, and dropdown lists. Lower numbers appear first. Enables business-driven presentation logic independent of alphabetical sorting.',
    `source_authority` STRING COMMENT 'The authoritative body, standard-setting organization, or system of record that publishes or maintains this code value (e.g., ISDA, ISO, FASB, Federal Reserve, internal enterprise data governance team).',
    `source_system` STRING COMMENT 'Identifier of the operational system or platform from which this code value originated (e.g., Temenos T24, Murex, SAS Risk Management, AxiomSL). Supports data lineage and integration troubleshooting.',
    `superseded_by_code_value` DECIMAL(18,2) COMMENT 'Reference to the replacement code value when this code is deprecated or retired (e.g., LIBOR codes superseded by SOFR codes). Enables automated migration and data remediation processes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this code list entry was last modified. Supports change tracking, audit trails, and data quality monitoring.',
    `usage_context` STRING COMMENT 'Description of the business processes, systems, or domains where this code value is applicable (e.g., Used in loan origination for day count calculations, Applied to derivatives pricing and valuation, Required for Basel III regulatory capital reporting).',
    `version_number` STRING COMMENT 'Sequential version number for tracking changes to this code list entry over time. Incremented with each modification to support change management and audit requirements.',
    CONSTRAINT pk_code_list PRIMARY KEY(`code_list_id`)
) COMMENT 'Enterprise-wide generic reference code list master — a flexible, extensible registry for all standardized lookup values that do not warrant their own first-class entity. Consolidates thin type tables including day count conventions (ACT/360, ACT/365, 30/360), settlement instruction types, counterparty types, NACE/SIC sector codes, credit rating scales (S&P, Moodys, Fitch mappings), GL account types, and other banking-specific enumerations. Each entry captures code list type, code value, code label, description, sort order, parent code (for hierarchies), effective/expiry dates, regulatory framework reference, source authority, and active flag. Maintains full auditability and versioning while reducing proliferation of single-purpose lookup tables.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`industry_code` (
    `industry_code_id` BIGINT COMMENT 'Unique identifier for the industry classification code record. Primary key.',
    `parent_industry_code_id` BIGINT COMMENT 'Self-referencing FK on industry_code (parent_industry_code_id)',
    `aml_risk_rating` STRING COMMENT 'The inherent AML risk rating assigned to this industry based on money laundering and terrorist financing risk factors, informing customer due diligence requirements.. Valid values are `low|medium|high|very_high`',
    `classification_system` STRING COMMENT 'The industry classification system or taxonomy used (Standard Industrial Classification, North American Industry Classification System, Global Industry Classification Standard, Industry Classification Benchmark).. Valid values are `SIC|NAICS|GICS|ICB`',
    `climate_risk_exposure` STRING COMMENT 'The level of physical and transition climate risk exposure associated with this industry, used for climate stress testing and scenario analysis.. Valid values are `low|medium|high`',
    `code_description` STRING COMMENT 'Full textual description of the industry classification code, providing detailed explanation of the industry segment or activity covered.',
    `code_path` STRING COMMENT 'Full hierarchical path from root to current code, typically pipe or slash delimited (e.g., Financials|Banks|Diversified Banks), enabling efficient hierarchy queries.',
    `code_short_name` STRING COMMENT 'Abbreviated or short name for the industry classification code, used for display and reporting purposes.',
    `code_value` DECIMAL(18,2) COMMENT 'The actual industry classification code value within the specified system (e.g., 522110 for Commercial Banking in NAICS, 4020 for Banks in GICS).',
    `concentration_risk_flag` BOOLEAN COMMENT 'Indicates whether exposures to this industry are subject to concentration risk monitoring and limits under the banks risk appetite framework and regulatory guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this industry code record was first created in the system, supporting audit trail and data lineage requirements.',
    `cyclical_sensitivity` STRING COMMENT 'The sensitivity of this industry to economic cycles, informing credit risk modeling, stress testing, and portfolio diversification strategies.. Valid values are `defensive|neutral|cyclical|highly_cyclical`',
    `effective_date` DATE COMMENT 'The date from which this industry code classification becomes effective and should be used for new classifications and reporting.',
    `esg_risk_category` STRING COMMENT 'The Environmental, Social, and Governance risk category assigned to this industry, supporting sustainable finance and climate risk assessment.',
    `expiration_date` DATE COMMENT 'The date on which this industry code classification expires or is superseded by a new code, supporting historical analysis and code migration.',
    `gics_equivalent_code` STRING COMMENT 'Cross-mapping to the equivalent GICS code, enabling global equity market analysis and portfolio classification.',
    `hierarchy_level` STRING COMMENT 'The hierarchical level of this code within the classification system (e.g., 1=Sector, 2=Industry Group, 3=Industry, 4=Sub-Industry for GICS; 2-digit, 3-digit, 4-digit, 6-digit for NAICS).',
    `high_risk_industry_flag` BOOLEAN COMMENT 'Indicates whether this industry is classified as high-risk for Anti-Money Laundering (AML), sanctions, fraud, or credit risk purposes, triggering enhanced due diligence requirements.',
    `icb_equivalent_code` STRING COMMENT 'Cross-mapping to the equivalent ICB code, enabling FTSE Russell index alignment and international market analysis.',
    `industry_code_status` STRING COMMENT 'The current lifecycle status of this industry code, indicating whether it is actively used, deprecated, superseded by another code, or proposed for future adoption.. Valid values are `active|deprecated|superseded|proposed`',
    `industry_group_name` STRING COMMENT 'The mid-level industry group name within the sector hierarchy, providing intermediate classification granularity.',
    `last_review_date` DATE COMMENT 'The date when this industry code classification was last reviewed and validated by data stewards or governance teams.',
    `naics_equivalent_code` STRING COMMENT 'Cross-mapping to the equivalent NAICS code, enabling regulatory reporting alignment and North American market analysis.',
    `parent_code_value` DECIMAL(18,2) COMMENT 'The code value of the parent industry classification in the hierarchy, enabling drill-up aggregation and hierarchical navigation.',
    `regulatory_reporting_category` STRING COMMENT 'The regulatory reporting category or segment to which this industry code maps for Basel III, CCAR, DFAST, and other prudential reporting requirements.',
    `risk_weight_category` STRING COMMENT 'The risk weight category assigned to exposures in this industry for regulatory capital calculation under Basel III standardized or internal ratings-based approaches.',
    `sanctions_exposure_flag` BOOLEAN COMMENT 'Indicates whether this industry has heightened exposure to OFAC or international sanctions regimes, requiring enhanced screening and monitoring.',
    `sector_name` STRING COMMENT 'The top-level economic sector name to which this industry code belongs (e.g., Financials, Industrials, Technology).',
    `sic_equivalent_code` STRING COMMENT 'Cross-mapping to the equivalent Standard Industrial Classification code, enabling legacy system integration and historical analysis.',
    `source_system` STRING COMMENT 'The source system or data provider from which this industry code record was obtained, supporting data lineage and reconciliation.',
    `sub_industry_name` STRING COMMENT 'The most granular sub-industry name, providing detailed industry segment classification for specialized analysis.',
    `superseded_by_code_value` DECIMAL(18,2) COMMENT 'The code value that supersedes this industry code when it is deprecated or replaced, enabling automated code migration and historical mapping.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this industry code record was last updated, supporting change tracking and data quality monitoring.',
    `usage_notes` STRING COMMENT 'Free-text notes providing guidance on proper usage, interpretation, or special considerations for this industry code classification.',
    `version_number` STRING COMMENT 'The version number of the classification system from which this code is sourced (e.g., NAICS 2022, GICS 2023), ensuring temporal consistency in analysis.',
    CONSTRAINT pk_industry_code PRIMARY KEY(`industry_code_id`)
) COMMENT 'Industry classification code reference table covering SIC, NAICS, GICS, and ICB classification systems. Captures code, description, hierarchy level, and cross-mapping between systems.';

CREATE OR REPLACE TABLE `banking_ecm`.`reference`.`geographic_region` (
    `geographic_region_id` BIGINT COMMENT 'Unique identifier for the geographic region. Primary key for the geographic region reference table.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Geographic regions have base currencies for operational purposes. The base_currency_code STRING column should be replaced with a proper FK to currency.currency_id. This is the first of two FKs from ge',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Geographic regions have headquarters located in specific countries. The headquarters_country_code STRING column should be replaced with a proper FK to country.country_id. This enables JOIN to retrieve',
    `parent_region_geographic_region_id` BIGINT COMMENT 'Reference to the parent region in the hierarchical structure. Null for top-level regions.',
    `parent_geographic_region_id` BIGINT COMMENT 'Self-referencing FK on geographic_region (parent_geographic_region_id)',
    `aml_risk_rating` STRING COMMENT 'Anti-Money Laundering risk rating for the geographic region based on Financial Action Task Force (FATF) assessments, sanctions regimes, and internal risk models.. Valid values are `low|medium|high|very_high`',
    `basel_implementation_status` STRING COMMENT 'Indicates which Basel Accord framework is implemented in this geographic region for capital adequacy and risk management purposes.. Valid values are `basel_i|basel_ii|basel_iii|basel_iv|not_applicable`',
    `country_codes` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes that belong to this geographic region. Enables mapping between regions and countries for reporting and risk aggregation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic region record was first created in the system. Used for audit trail and data lineage.',
    `data_residency_requirement` BOOLEAN COMMENT 'Indicates whether the geographic region has data residency or data localization requirements mandating that customer data must be stored within the region. True if requirements exist, False otherwise.',
    `data_steward_name` STRING COMMENT 'Name of the individual or team responsible for maintaining and governing this geographic region reference data.',
    `effective_from_date` DATE COMMENT 'Date from which this geographic region definition became effective in the banks hierarchy. Used for temporal reporting and historical analysis.',
    `effective_to_date` DATE COMMENT 'Date until which this geographic region definition is effective. Null for currently active regions. Used for temporal reporting and historical analysis.',
    `headquarters_city` STRING COMMENT 'City where the regional headquarters or primary office for this geographic region is located.',
    `ifrs_adoption_status` STRING COMMENT 'Accounting standard framework adopted in this geographic region (e.g., full IFRS, IFRS-converged standards, local GAAP, US GAAP).. Valid values are `full_ifrs|ifrs_converged|local_gaap|us_gaap`',
    `is_reporting_region` BOOLEAN COMMENT 'Indicates whether this geographic region is used as a primary reporting dimension for management and regulatory reporting. True if used for reporting, False otherwise.',
    `is_risk_aggregation_unit` BOOLEAN COMMENT 'Indicates whether this geographic region is used as a unit for risk aggregation and Risk-Weighted Assets (RWA) calculation. True if used for risk aggregation, False otherwise.',
    `last_review_date` DATE COMMENT 'Date when this geographic region definition was last reviewed and validated by the data steward or governance team.',
    `lob_ownership` STRING COMMENT 'Primary line of business or business unit responsible for this geographic region (e.g., Retail Banking, Investment Banking, Wealth Management).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and validation of this geographic region definition.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the geographic region definition.',
    `operational_status` STRING COMMENT 'Current operational status of the geographic region within the banks organizational structure. Active indicates the region is currently operational.. Valid values are `active|inactive|suspended|planned|discontinued`',
    `region_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the geographic region within the banks internal hierarchy. Used for reporting, risk aggregation, and organizational alignment.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `region_level` STRING COMMENT 'Numeric level in the geographic hierarchy (e.g., 1 for global, 2 for super region, 3 for region, etc.). Used for hierarchical rollup and aggregation.',
    `region_name` STRING COMMENT 'Full descriptive name of the geographic region (e.g., North America, EMEA, Asia Pacific, Latin America).',
    `region_path` STRING COMMENT 'Full hierarchical path from root to current region, typically pipe or slash delimited (e.g., Global|Americas|North America). Enables efficient hierarchical queries.',
    `region_short_name` STRING COMMENT 'Abbreviated or short form of the region name for display and reporting purposes.',
    `region_type` STRING COMMENT 'Classification of the region within the geographic hierarchy (e.g., global, super region, region, sub-region, territory, market).. Valid values are `global|super_region|region|sub_region|territory|market`',
    `regional_manager_email` STRING COMMENT 'Email address of the regional manager for operational communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regional_manager_name` STRING COMMENT 'Name of the senior executive or regional manager responsible for this geographic region.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction or authority governing this geographic region (e.g., Federal Reserve, European Central Bank, Bank of England).',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for regulatory and management reporting for this region. May differ from base currency.. Valid values are `^[A-Z]{3}$`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the geographic region based on country risk, regulatory risk, operational risk, and geopolitical factors. Used for risk aggregation and capital allocation.. Valid values are `low|medium|high|very_high`',
    `sanctions_flag` BOOLEAN COMMENT 'Indicates whether the geographic region is subject to international sanctions or embargoes (e.g., OFAC sanctions). True if sanctions apply, False otherwise.',
    `sort_order` STRING COMMENT 'Numeric value used to control the display order of geographic regions in reports and user interfaces.',
    `source_system` STRING COMMENT 'Name or code of the source system from which this geographic region reference data originated (e.g., MDM, ERP, Manual Entry).',
    `stress_testing_regime` STRING COMMENT 'Regulatory stress testing framework applicable to this geographic region (e.g., CCAR, DFAST, EBA Stress Test, APRA Stress Test).',
    `time_zone` STRING COMMENT 'Primary time zone for the geographic region in IANA Time Zone Database format (e.g., America/New_York, Europe/London, Asia/Tokyo). Used for operational scheduling and reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this geographic region record was last updated. Used for audit trail and change tracking.',
    CONSTRAINT pk_geographic_region PRIMARY KEY(`geographic_region_id`)
) COMMENT 'Geographic region and territory reference table defining the banks internal geographic hierarchy for reporting, risk aggregation, and organizational alignment. Captures region code, name, parent region, and country mappings.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`reference`.`country` ADD CONSTRAINT `fk_reference_country_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ADD CONSTRAINT `fk_reference_rate_benchmark_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ADD CONSTRAINT `fk_reference_rate_benchmark_fallback_rate_benchmark_id` FOREIGN KEY (`fallback_rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ADD CONSTRAINT `fk_reference_rate_benchmark_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ADD CONSTRAINT `fk_reference_benchmark_rate_fixing_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ADD CONSTRAINT `fk_reference_benchmark_rate_fixing_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ADD CONSTRAINT `fk_reference_benchmark_rate_fixing_rate_benchmark_id` FOREIGN KEY (`rate_benchmark_id`) REFERENCES `banking_ecm`.`reference`.`rate_benchmark`(`rate_benchmark_id`);
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ADD CONSTRAINT `fk_reference_exchange_rate_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ADD CONSTRAINT `fk_reference_holiday_calendar_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ADD CONSTRAINT `fk_reference_holiday_date_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ADD CONSTRAINT `fk_reference_holiday_date_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ADD CONSTRAINT `fk_reference_holiday_date_holiday_calendar_id` FOREIGN KEY (`holiday_calendar_id`) REFERENCES `banking_ecm`.`reference`.`holiday_calendar`(`holiday_calendar_id`);
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ADD CONSTRAINT `fk_reference_instrument_identifier_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ADD CONSTRAINT `fk_reference_instrument_identifier_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ADD CONSTRAINT `fk_reference_instrument_identifier_instrument_classification_id` FOREIGN KEY (`instrument_classification_id`) REFERENCES `banking_ecm`.`reference`.`instrument_classification`(`instrument_classification_id`);
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ADD CONSTRAINT `fk_reference_bic_directory_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ADD CONSTRAINT `fk_reference_bic_directory_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ADD CONSTRAINT `fk_reference_lei_registry_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ADD CONSTRAINT `fk_reference_lei_registry_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ADD CONSTRAINT `fk_reference_market_data_source_fallback_source_market_data_source_id` FOREIGN KEY (`fallback_source_market_data_source_id`) REFERENCES `banking_ecm`.`reference`.`market_data_source`(`market_data_source_id`);
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ADD CONSTRAINT `fk_reference_regulatory_taxonomy_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ADD CONSTRAINT `fk_reference_regulatory_taxonomy_primary_predecessor_taxonomy_regulatory_taxonomy_id` FOREIGN KEY (`primary_predecessor_taxonomy_regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ADD CONSTRAINT `fk_reference_regulatory_taxonomy_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ADD CONSTRAINT `fk_reference_reporting_code_parent_code_reporting_code_id` FOREIGN KEY (`parent_code_reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ADD CONSTRAINT `fk_reference_reporting_code_primary_superseded_by_code_reporting_code_id` FOREIGN KEY (`primary_superseded_by_code_reporting_code_id`) REFERENCES `banking_ecm`.`reference`.`reporting_code`(`reporting_code_id`);
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ADD CONSTRAINT `fk_reference_reporting_code_regulatory_taxonomy_id` FOREIGN KEY (`regulatory_taxonomy_id`) REFERENCES `banking_ecm`.`reference`.`regulatory_taxonomy`(`regulatory_taxonomy_id`);
ALTER TABLE `banking_ecm`.`reference`.`product_type` ADD CONSTRAINT `fk_reference_product_type_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ADD CONSTRAINT `fk_reference_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `banking_ecm`.`reference`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `banking_ecm`.`reference`.`market_center` ADD CONSTRAINT `fk_reference_market_center_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`reference`.`market_center` ADD CONSTRAINT `fk_reference_market_center_lei_registry_id` FOREIGN KEY (`lei_registry_id`) REFERENCES `banking_ecm`.`reference`.`lei_registry`(`lei_registry_id`);
ALTER TABLE `banking_ecm`.`reference`.`market_center` ADD CONSTRAINT `fk_reference_market_center_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`code_list` ADD CONSTRAINT `fk_reference_code_list_parent_code_list_id` FOREIGN KEY (`parent_code_list_id`) REFERENCES `banking_ecm`.`reference`.`code_list`(`code_list_id`);
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ADD CONSTRAINT `fk_reference_industry_code_parent_industry_code_id` FOREIGN KEY (`parent_industry_code_id`) REFERENCES `banking_ecm`.`reference`.`industry_code`(`industry_code_id`);
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ADD CONSTRAINT `fk_reference_geographic_region_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `banking_ecm`.`reference`.`currency`(`currency_id`);
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ADD CONSTRAINT `fk_reference_geographic_region_country_id` FOREIGN KEY (`country_id`) REFERENCES `banking_ecm`.`reference`.`country`(`country_id`);
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ADD CONSTRAINT `fk_reference_geographic_region_parent_region_geographic_region_id` FOREIGN KEY (`parent_region_geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ADD CONSTRAINT `fk_reference_geographic_region_parent_geographic_region_id` FOREIGN KEY (`parent_geographic_region_id`) REFERENCES `banking_ecm`.`reference`.`geographic_region`(`geographic_region_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`reference` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`reference` SET TAGS ('dbx_domain' = 'reference');
ALTER TABLE `banking_ecm`.`reference`.`currency` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`currency` SET TAGS ('dbx_subdomain' = 'currency_management');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Identifier');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `benchmark_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Interest Rate Type');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `central_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Central Bank Name');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Currency Name');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `currency_status` SET TAGS ('dbx_business_glossary_term' = 'Currency Status');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `currency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|historical|pending');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type Classification');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'fiat|commodity|digital|fund|special_drawing_right');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_convertible` SET TAGS ('dbx_business_glossary_term' = 'Freely Convertible Currency Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_crypto_currency` SET TAGS ('dbx_business_glossary_term' = 'Cryptocurrency Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_fund_currency` SET TAGS ('dbx_business_glossary_term' = 'Fund Currency Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_legal_tender` SET TAGS ('dbx_business_glossary_term' = 'Legal Tender Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_precious_metal` SET TAGS ('dbx_business_glossary_term' = 'Precious Metal Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `is_restricted` SET TAGS ('dbx_business_glossary_term' = 'Restricted Currency Indicator');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `iso_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 4217 Currency Code');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `iso_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `last_revaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revaluation Date');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `minor_unit` SET TAGS ('dbx_business_glossary_term' = 'Minor Unit (Decimal Places)');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Currency Notes');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) 4217 Numeric Currency Code');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Currency Priority Rank');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `rounding_method` SET TAGS ('dbx_business_glossary_term' = 'Rounding Method');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `rounding_method` SET TAGS ('dbx_value_regex' = 'standard|bankers|up|down|truncate');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `settlement_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Lag Days');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `symbol` SET TAGS ('dbx_business_glossary_term' = 'Currency Symbol');
ALTER TABLE `banking_ecm`.`reference`.`currency` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `banking_ecm`.`reference`.`country` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`country` SET TAGS ('dbx_subdomain' = 'regulatory_taxonomy');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Identifier');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `ach_system_name` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) System Name');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high|prohibited');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `basel_committee_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Basel Committee on Banking Supervision (BCBS) Member Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `calling_code` SET TAGS ('dbx_business_glossary_term' = 'International Calling Code');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `capital_city` SET TAGS ('dbx_business_glossary_term' = 'Capital City');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Official Country Name');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `crs_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Jurisdiction Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `crs_reportable_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Jurisdiction Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `eea_member_flag` SET TAGS ('dbx_business_glossary_term' = 'European Economic Area (EEA) Member Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `eu_member_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Member Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `fatca_giin_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Global Intermediary Identification Number (GIIN) Required Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `fatca_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Jurisdiction Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `fatf_high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Action Task Force (FATF) High-Risk Jurisdiction Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `fatf_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Action Task Force (FATF) Member Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iban_length` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN) Length');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iban_length` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iban_length` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iban_required_flag` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN) Required Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iban_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iban_required_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `intermediate_region` SET TAGS ('dbx_business_glossary_term' = 'Intermediate Geographic Region');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-2 Country Code');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-3 Country Code');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Numeric Country Code');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `oecd_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Organisation for Economic Co-operation and Development (OECD) Member Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `ofac_sanctions_flag` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Sanctions Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `ofac_sanctions_program` SET TAGS ('dbx_business_glossary_term' = 'Office of Foreign Assets Control (OFAC) Sanctions Program Name');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `official_name` SET TAGS ('dbx_business_glossary_term' = 'Country Official Long-Form Name');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Country Risk Rating');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `rtgs_system_name` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Gross Settlement (RTGS) System Name');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Securities Settlement Cycle');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `sovereign_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Credit Rating');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `sovereign_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Credit Rating Agency');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `sovereign_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Credit Rating Date');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `sovereign_status` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Status');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `sovereign_status` SET TAGS ('dbx_value_regex' = 'sovereign|dependent_territory|special_administrative_region|disputed');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `sub_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Sub-Region');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `tax_haven_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Haven Jurisdiction Flag');
ALTER TABLE `banking_ecm`.`reference`.`country` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Primary Time Zone');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` SET TAGS ('dbx_subdomain' = 'currency_management');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `fallback_rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Rate Benchmark Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `administrator_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Administrator Jurisdiction');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `administrator_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Administrator Name');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `alternative_benchmark_names` SET TAGS ('dbx_business_glossary_term' = 'Alternative Benchmark Names');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Code');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_family` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Family');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Name');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Status');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|under_review');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'overnight|term|interbank|risk_free|central_bank');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|modified_preceding|unadjusted');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `compounding_convention` SET TAGS ('dbx_business_glossary_term' = 'Compounding Convention');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `compounding_convention` SET TAGS ('dbx_value_regex' = 'simple|compounded|averaged|none');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `data_source_description` SET TAGS ('dbx_business_glossary_term' = 'Data Source Description');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360|actual_actual');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `fallback_spread_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Fallback Spread Adjustment');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `ibor_transition_status` SET TAGS ('dbx_business_glossary_term' = 'Interbank Offered Rate (IBOR) Transition Status');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `ibor_transition_status` SET TAGS ('dbx_value_regex' = 'active|legacy|discontinued|transition_phase|fallback_activated');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `is_risk_free_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Risk-Free Rate (RFR)');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `is_secured_rate` SET TAGS ('dbx_business_glossary_term' = 'Is Secured Rate');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `last_publication_date` SET TAGS ('dbx_business_glossary_term' = 'Last Publication Date');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `lookback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lookback Period Days');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `observation_shift_days` SET TAGS ('dbx_business_glossary_term' = 'Observation Shift Days');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `panel_bank_count` SET TAGS ('dbx_business_glossary_term' = 'Panel Bank Count');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `payment_delay_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Delay Days');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `publication_source` SET TAGS ('dbx_business_glossary_term' = 'Publication Source');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `publication_time` SET TAGS ('dbx_business_glossary_term' = 'Publication Time');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `regulatory_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Recognition Status');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `regulatory_recognition_status` SET TAGS ('dbx_value_regex' = 'authorized|recognized|non_recognized|under_review');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Regime');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `tenor_convention` SET TAGS ('dbx_business_glossary_term' = 'Tenor Convention');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `transaction_volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Threshold');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`rate_benchmark` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` SET TAGS ('dbx_subdomain' = 'currency_management');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `benchmark_rate_fixing_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Fixing Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|modified_preceding');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `compounding_method` SET TAGS ('dbx_business_glossary_term' = 'Compounding Method');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `compounding_method` SET TAGS ('dbx_value_regex' = 'simple|compound|weighted_average|none');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'ACT/360|ACT/365|30/360|ACT/ACT');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `fallback_methodology` SET TAGS ('dbx_business_glossary_term' = 'Fallback Methodology');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `fallback_rate_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fallback Rate Indicator');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `fixing_date` SET TAGS ('dbx_business_glossary_term' = 'Fixing Date');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `is_business_day` SET TAGS ('dbx_business_glossary_term' = 'Is Business Day Indicator');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `is_revised` SET TAGS ('dbx_business_glossary_term' = 'Is Revised Indicator');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `number_of_transactions` SET TAGS ('dbx_business_glossary_term' = 'Number of Transactions');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `observation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Observation Period End Date');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `observation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Observation Period Start Date');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `rate_basis_points` SET TAGS ('dbx_business_glossary_term' = 'Rate in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'published|preliminary|final|corrected|withdrawn');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending|exception');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `revision_sequence` SET TAGS ('dbx_business_glossary_term' = 'Revision Sequence Number');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `spread_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Spread Adjustment');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `superseded_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Superseded Rate Value');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `tenor_code` SET TAGS ('dbx_business_glossary_term' = 'Tenor Code');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`benchmark_rate_fixing` ALTER COLUMN `volume_traded` SET TAGS ('dbx_business_glossary_term' = 'Volume Traded');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` SET TAGS ('dbx_subdomain' = 'currency_management');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate ID');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `benchmark_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Rate Comments');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `cross_rate_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross Rate Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `ecb_published_flag` SET TAGS ('dbx_business_glossary_term' = 'European Central Bank (ECB) Published Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expiry Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `fed_published_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Reserve (Fed) Published Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `gl_revaluation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revaluation Eligible Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `holiday_adjusted_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Adjusted Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `inverse_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Inverse Exchange Rate Value');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `quote_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Quote Currency Code');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `quote_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|superseded|preliminary|final|cancelled');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'spot|forward|mid|bid|ask|fixing');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Value');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `regulatory_reporting_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Eligible Flag');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `source_provider` SET TAGS ('dbx_business_glossary_term' = 'Rate Source Provider');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `tenor` SET TAGS ('dbx_business_glossary_term' = 'Forward Tenor');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `tenor` SET TAGS ('dbx_value_regex' = '^(ON|TN|SN|1W|2W|1M|2M|3M|6M|9M|1Y|2Y|3Y|5Y|10Y|SPOT)$');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `trading_session` SET TAGS ('dbx_business_glossary_term' = 'Trading Session');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `triangulation_method` SET TAGS ('dbx_business_glossary_term' = 'Triangulation Method');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `triangulation_method` SET TAGS ('dbx_value_regex' = 'direct|via_usd|via_eur|via_gbp|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `volatility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Market Volatility Indicator');
ALTER TABLE `banking_ecm`.`reference`.`exchange_rate` ALTER COLUMN `volatility_indicator` SET TAGS ('dbx_value_regex' = 'low|normal|high|extreme');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` SET TAGS ('dbx_subdomain' = 'currency_management');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `applies_to_derivatives` SET TAGS ('dbx_business_glossary_term' = 'Applies to Derivatives Indicator');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `applies_to_loans` SET TAGS ('dbx_business_glossary_term' = 'Applies to Loans Indicator');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `applies_to_payments` SET TAGS ('dbx_business_glossary_term' = 'Applies to Payments Indicator');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `applies_to_securities` SET TAGS ('dbx_business_glossary_term' = 'Applies to Securities Indicator');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|modified_preceding|nearest|unadjusted');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_source_system` SET TAGS ('dbx_business_glossary_term' = 'Calendar Source System');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_url` SET TAGS ('dbx_business_glossary_term' = 'Calendar Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_version` SET TAGS ('dbx_business_glossary_term' = 'Calendar Version');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `calendar_version` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$|^[0-9]+.[0-9]+$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `financial_center_code` SET TAGS ('dbx_business_glossary_term' = 'Financial Center Code');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `financial_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `governing_authority` SET TAGS ('dbx_business_glossary_term' = 'Governing Authority');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `is_default_calendar` SET TAGS ('dbx_business_glossary_term' = 'Is Default Calendar Indicator');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Calendar Notes');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `settlement_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Days');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `supports_partial_days` SET TAGS ('dbx_business_glossary_term' = 'Supports Partial Days Indicator');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `time_zone` SET TAGS ('dbx_value_regex' = '^[A-Za-z]+/[A-Za-z_]+$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `weekend_pattern` SET TAGS ('dbx_business_glossary_term' = 'Weekend Pattern');
ALTER TABLE `banking_ecm`.`reference`.`holiday_calendar` ALTER COLUMN `weekend_pattern` SET TAGS ('dbx_value_regex' = 'saturday_sunday|friday_saturday|sunday|friday|thursday_friday|none');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` SET TAGS ('dbx_subdomain' = 'currency_management');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `holiday_date_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Date ID');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar ID');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `actual_holiday_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Holiday Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `affects_accrual` SET TAGS ('dbx_business_glossary_term' = 'Affects Accrual');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `affects_payment` SET TAGS ('dbx_business_glossary_term' = 'Affects Payment');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `affects_settlement` SET TAGS ('dbx_business_glossary_term' = 'Affects Settlement');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|modified_preceding|unadjusted');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `holiday_date` SET TAGS ('dbx_business_glossary_term' = 'Holiday Date');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `holiday_name` SET TAGS ('dbx_business_glossary_term' = 'Holiday Name');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `holiday_type` SET TAGS ('dbx_business_glossary_term' = 'Holiday Type');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `holiday_type` SET TAGS ('dbx_value_regex' = 'public|exchange|settlement|bank|custom|regulatory');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `is_partial_day` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Day Holiday');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `market_identifier_code` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier Code (MIC)');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `market_identifier_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Holiday Notes');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `observance_rule` SET TAGS ('dbx_business_glossary_term' = 'Observance Rule');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `observance_rule` SET TAGS ('dbx_value_regex' = 'fixed|floating|calculated|substitute');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `partial_day_close_time` SET TAGS ('dbx_business_glossary_term' = 'Partial Day Close Time');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `partial_day_open_time` SET TAGS ('dbx_business_glossary_term' = 'Partial Day Open Time');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `payment_system_code` SET TAGS ('dbx_business_glossary_term' = 'Payment System Code');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `recurring_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurring Pattern');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Holiday Year');
ALTER TABLE `banking_ecm`.`reference`.`holiday_date` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier Identifier');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `issuer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `bloomberg_ticker` SET TAGS ('dbx_business_glossary_term' = 'Bloomberg Ticker Symbol');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[A-Z0-9]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `figi` SET TAGS ('dbx_business_glossary_term' = 'Financial Instrument Global Identifier (FIGI)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `figi` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'primary|alternate|legacy|vendor_specific|internal');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `instrument_identifier_status` SET TAGS ('dbx_business_glossary_term' = 'Instrument Status');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `instrument_identifier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|matured|called|defaulted|suspended');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `internal_instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Instrument Code');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `is_primary_identifier` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identifier Flag');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `is_tradable` SET TAGS ('dbx_business_glossary_term' = 'Is Tradable Flag');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `listing_exchange` SET TAGS ('dbx_business_glossary_term' = 'Listing Exchange');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `reuters_ric` SET TAGS ('dbx_business_glossary_term' = 'Reuters Instrument Code (RIC)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL)');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[B-DF-HJ-NP-TV-Z0-9]{6}[0-9]$');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`instrument_identifier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Classification Identifier');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|derivative|foreign_exchange|commodity|structured_product');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `central_clearing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Central Clearing Eligible');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `cfi_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Financial Instruments (CFI) Code');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `cfi_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}$');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `classification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `classification_end_date` SET TAGS ('dbx_business_glossary_term' = 'Classification End Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `classification_rationale` SET TAGS ('dbx_business_glossary_term' = 'Classification Rationale');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review|superseded');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `classification_version` SET TAGS ('dbx_business_glossary_term' = 'Classification Version');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `complex_product_indicator` SET TAGS ('dbx_business_glossary_term' = 'Complex Product Indicator');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `counterparty_credit_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Risk Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `credit_risk_mitigation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Mitigation Eligible');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `derivative_indicator` SET TAGS ('dbx_business_glossary_term' = 'Derivative Indicator');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `exchange_traded_indicator` SET TAGS ('dbx_business_glossary_term' = 'Exchange Traded Indicator');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `frtb_book_classification` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Book Classification');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `frtb_book_classification` SET TAGS ('dbx_value_regex' = 'trading_book|banking_book|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `ifrs9_measurement_category` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 9 (IFRS 9) Measurement Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `ifrs9_measurement_category` SET TAGS ('dbx_value_regex' = 'amortized_cost|fair_value_oci|fair_value_pl|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Classification');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'high_quality_liquid_asset_level_1|high_quality_liquid_asset_level_2a|high_quality_liquid_asset_level_2b|non_hqla|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `market_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `mifid2_instrument_category` SET TAGS ('dbx_business_glossary_term' = 'Markets in Financial Instruments Directive II (MiFID II) Instrument Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `otc_indicator` SET TAGS ('dbx_business_glossary_term' = 'Over-the-Counter (OTC) Indicator');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `product_control_category` SET TAGS ('dbx_business_glossary_term' = 'Product Control Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `risk_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `securitization_indicator` SET TAGS ('dbx_business_glossary_term' = 'Securitization Indicator');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `stress_testing_category` SET TAGS ('dbx_business_glossary_term' = 'Stress Testing Category');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `structured_product_indicator` SET TAGS ('dbx_business_glossary_term' = 'Structured Product Indicator');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `sub_asset_class` SET TAGS ('dbx_business_glossary_term' = 'Sub-Asset Class');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_value_regex' = 'mark_to_market|mark_to_model|mark_to_cost|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`instrument_classification` ALTER COLUMN `volcker_rule_covered` SET TAGS ('dbx_business_glossary_term' = 'Volcker Rule Covered');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC) Directory ID');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic11` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code 11 (BIC11)');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic11` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}[A-Z0-9]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic8` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code 8 (BIC8)');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic8` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}$');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Branch Name');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|modified_preceding');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `connectivity_status` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Status');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `connectivity_status` SET TAGS ('dbx_value_regex' = 'live|test|inactive|suspended');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `correspondent_banking_role` SET TAGS ('dbx_business_glossary_term' = 'Correspondent Banking Role');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `correspondent_banking_role` SET TAGS ('dbx_value_regex' = 'nostro|vostro|both|none');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `cut_off_time_local` SET TAGS ('dbx_business_glossary_term' = 'Cut-Off Time Local');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `cut_off_time_local` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `iban_supported` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN) Supported');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `iban_supported` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `iban_supported` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `institution_name` SET TAGS ('dbx_business_glossary_term' = 'Institution Name');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `institution_type` SET TAGS ('dbx_business_glossary_term' = 'Institution Type');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `institution_type` SET TAGS ('dbx_value_regex' = 'bank|broker_dealer|clearing_house|securities_firm|investment_manager|corporate');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `national_identifier_code` SET TAGS ('dbx_business_glossary_term' = 'National Identifier');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `national_identifier_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `national_identifier_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `payment_services_enabled` SET TAGS ('dbx_business_glossary_term' = 'Payment Services Enabled');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'authorized|restricted|sanctioned|under_review');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `securities_services_enabled` SET TAGS ('dbx_business_glossary_term' = 'Securities Services Enabled');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `sepa_participant` SET TAGS ('dbx_business_glossary_term' = 'Single Euro Payments Area (SEPA) Participant');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `swift_service_profile` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Service Profile');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `swift_service_profile` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `swift_service_profile` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`reference`.`bic_directory` ALTER COLUMN `trade_finance_services_enabled` SET TAGS ('dbx_business_glossary_term' = 'Trade Finance Services Enabled');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Registry ID');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Address Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `bic_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_category` SET TAGS ('dbx_business_glossary_term' = 'Entity Category');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Entity Expiration Date');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Entity Expiration Reason');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_expiration_reason` SET TAGS ('dbx_value_regex' = 'DISSOLVED|MERGED|LIQUIDATION|CORPORATE_ACTION|OTHER');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Entity Registration Number');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address City');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Country Code');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Postal Code');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_region` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Region');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_region` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `headquarters_address_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `initial_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Initial Registration Date');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `last_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Update Date');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_city` SET TAGS ('dbx_business_glossary_term' = 'Legal Address City');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Legal Address Line 1');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Legal Address Line 2');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Address Postal Code');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_region` SET TAGS ('dbx_business_glossary_term' = 'Legal Address Region');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_region` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_address_region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_entity_name_local` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (Local Language)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_form_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Form Code');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `legal_form_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Form Name');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `lei_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Status');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `managing_lou_code` SET TAGS ('dbx_business_glossary_term' = 'Managing Local Operating Unit (LOU) Code');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `managing_lou_name` SET TAGS ('dbx_business_glossary_term' = 'Managing Local Operating Unit (LOU) Name');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `registration_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Authority Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `registration_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Registration Authority Name');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `relationship_last_update_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Last Update Date');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|INACTIVE');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `successor_lei` SET TAGS ('dbx_business_glossary_term' = 'Successor Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `successor_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `ultimate_parent_lei` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `ultimate_parent_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source');
ALTER TABLE `banking_ecm`.`reference`.`lei_registry` ALTER COLUMN `validation_source` SET TAGS ('dbx_value_regex' = 'FULLY_CORROBORATED|PARTIALLY_CORROBORATED|ENTITY_SUPPLIED_ONLY|PENDING');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `market_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Market Data Source Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `fallback_source_market_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Fallback Source Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `annual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Cost United States Dollars (USD)');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `annual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `asset_class_coverage` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Coverage');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `business_owner_lob` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `connectivity_method` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Method');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|allocated|shared|FTP');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Frequency');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'tier-1|tier-2|tier-3|internal');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_retention_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Days');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Email');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_steward_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `feed_type` SET TAGS ('dbx_business_glossary_term' = 'Feed Type');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `feed_type` SET TAGS ('dbx_value_regex' = 'real-time|delayed|end-of-day|intraday|evaluated|composite');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `instrument_type_coverage` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type Coverage');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `license_end_date` SET TAGS ('dbx_business_glossary_term' = 'License End Date');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `license_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Start Date');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'enterprise|per-user|per-device|display-only|non-display|internal-use');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `market_coverage` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `market_data_source_status` SET TAGS ('dbx_business_glossary_term' = 'Source Status');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `market_data_source_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|decommissioned|pilot|pending-approval');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `override_governance_rule` SET TAGS ('dbx_business_glossary_term' = 'Override Governance Rule');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `pricing_methodology` SET TAGS ('dbx_business_glossary_term' = 'Pricing Methodology');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Code');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Name');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `regulatory_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approved Flag');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `sla_data_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Data Accuracy Percentage');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `sla_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Latency Milliseconds (ms)');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `sla_uptime_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `source_designation` SET TAGS ('dbx_business_glossary_term' = 'Source Designation');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `source_designation` SET TAGS ('dbx_value_regex' = 'primary|fallback|supplementary|reference-only');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `valuation_use_case` SET TAGS ('dbx_business_glossary_term' = 'Valuation Use Case');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone');
ALTER TABLE `banking_ecm`.`reference`.`market_data_source` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` SET TAGS ('dbx_subdomain' = 'regulatory_taxonomy');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy ID');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `primary_predecessor_taxonomy_regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Taxonomy ID');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `applicable_entity_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Entity Types');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `asset_threshold_minimum` SET TAGS ('dbx_business_glossary_term' = 'Asset Threshold Minimum');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `data_point_count` SET TAGS ('dbx_business_glossary_term' = 'Data Point Count');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `hierarchical_structure` SET TAGS ('dbx_business_glossary_term' = 'Hierarchical Structure');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `hierarchical_structure` SET TAGS ('dbx_value_regex' = 'flat|hierarchical|multi_level|dimensional');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `implementation_guidance_url` SET TAGS ('dbx_business_glossary_term' = 'Implementation Guidance Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `internal_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `reporting_platform_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Platform Code');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `schedule_count` SET TAGS ('dbx_business_glossary_term' = 'Schedule Count');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `schema_location_url` SET TAGS ('dbx_business_glossary_term' = 'Schema Location Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'XBRL|XML|CSV|PDF|API|portal');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_code` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Code');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_description` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Description');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_name` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Name');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_status` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Status');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|retired|under_review');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_type` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Type');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Version');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `validation_rules_url` SET TAGS ('dbx_business_glossary_term' = 'Validation Rules Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`reference`.`regulatory_taxonomy` ALTER COLUMN `xbrl_namespace` SET TAGS ('dbx_business_glossary_term' = 'Extensible Business Reporting Language (XBRL) Namespace');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` SET TAGS ('dbx_subdomain' = 'regulatory_taxonomy');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code ID');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `parent_code_reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Reporting Code ID');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `primary_superseded_by_code_reporting_code_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Code ID');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy ID');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Method');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `aggregation_method` SET TAGS ('dbx_value_regex' = 'sum|average|maximum|minimum|count|weighted_average');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `business_definition` SET TAGS ('dbx_business_glossary_term' = 'Business Definition');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `calculation_formula` SET TAGS ('dbx_business_glossary_term' = 'Calculation Formula');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `code_label` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code Label');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `code_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code Hierarchy Level');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `code_path` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code Hierarchical Path');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `code_value` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code Value');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `data_quality_threshold` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Threshold Percentage');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Data Type');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `example_value` SET TAGS ('dbx_business_glossary_term' = 'Example Value');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `gl_account_mapping` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Mapping');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `is_calculated` SET TAGS ('dbx_business_glossary_term' = 'Calculated Field Indicator');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Data Indicator');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Reporting Indicator');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `mapping_notes` SET TAGS ('dbx_business_glossary_term' = 'Mapping Notes');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Citation');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `report_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Report Schedule Name');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `reporting_code_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Code Status');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `reporting_code_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|proposed|superseded|retired');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `sign_convention` SET TAGS ('dbx_business_glossary_term' = 'Sign Convention');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `sign_convention` SET TAGS ('dbx_value_regex' = 'positive|negative|absolute|net');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `taxonomy_version` SET TAGS ('dbx_business_glossary_term' = 'Taxonomy Version');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `validation_rule` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Expression');
ALTER TABLE `banking_ecm`.`reference`.`reporting_code` ALTER COLUMN `xbrl_tag` SET TAGS ('dbx_business_glossary_term' = 'Extensible Business Reporting Language (XBRL) Tag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`product_type` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Identifier');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `aml_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Monitoring Required Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `benchmark_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Type');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `booking_model` SET TAGS ('dbx_business_glossary_term' = 'Booking Model');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `booking_model` SET TAGS ('dbx_value_regex' = 'accrual|fair_value|amortized_cost|held_for_trading|available_for_sale');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `ccar_dfast_category` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) / Dodd-Frank Act Stress Testing (DFAST) Category');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `cecl_portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Losses (CECL) Portfolio Segment');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `credit_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `crs_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Reportable Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `fatca_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Reportable Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `fee_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `gl_account_mapping` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Mapping');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `kyc_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Requirement Level');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `kyc_requirement_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|simplified|not_required');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `liquidity_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Risk Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `lob_ownership` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Ownership');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `market_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `maximum_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Amount');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `minimum_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Amount');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `multi_currency_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Currency Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `operational_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Flag');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval|sunset');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_type_code` SET TAGS ('dbx_business_glossary_term' = 'Product Type Code');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_type_description` SET TAGS ('dbx_business_glossary_term' = 'Product Type Description');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `product_type_name` SET TAGS ('dbx_business_glossary_term' = 'Product Type Name');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `regulatory_product_category_basel` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Category - Basel');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `regulatory_product_category_ifrs9` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Product Category - International Financial Reporting Standard 9 (IFRS 9)');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `rwa_approach` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Approach');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `rwa_approach` SET TAGS ('dbx_value_regex' = 'standardized|foundation_irb|advanced_irb|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `sla_service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Service Level');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `sla_service_level` SET TAGS ('dbx_value_regex' = 'standard|priority|premium|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `sub_product_type` SET TAGS ('dbx_business_glossary_term' = 'Sub-Product Type');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `tax_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Category');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `typical_term_months` SET TAGS ('dbx_business_glossary_term' = 'Typical Term in Months');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`reference`.`product_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'regulatory_taxonomy');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Identifier');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `parent_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction Identifier');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US GAAP|local GAAP|mixed');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `aml_authority` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Authority');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `basel_implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Basel Framework Implementation Status');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `basel_implementation_status` SET TAGS ('dbx_value_regex' = 'basel III compliant|basel IV compliant|partial|non-compliant|not applicable');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `bic_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC) Country Code');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `bic_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `capital_adequacy_framework` SET TAGS ('dbx_business_glossary_term' = 'Capital Adequacy Framework');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `capital_adequacy_framework` SET TAGS ('dbx_value_regex' = 'standardized approach|internal ratings-based|advanced|other');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `credit_loss_methodology` SET TAGS ('dbx_business_glossary_term' = 'Credit Loss Provisioning Methodology');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `credit_loss_methodology` SET TAGS ('dbx_value_regex' = 'CECL|IFRS 9 ECL|incurred loss|other');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `crs_status` SET TAGS ('dbx_business_glossary_term' = 'Common Reporting Standard (CRS) Status');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `crs_status` SET TAGS ('dbx_value_regex' = 'participating|committed|non-participating');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Official Currency Code');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `data_privacy_regime` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Regime');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `fatca_status` SET TAGS ('dbx_business_glossary_term' = 'Foreign Account Tax Compliance Act (FATCA) Status');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `fatca_status` SET TAGS ('dbx_value_regex' = 'model 1 IGA|model 2 IGA|non-IGA|not applicable');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `high_risk_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'High-Risk Jurisdiction Flag');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `holiday_calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Code');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `iban_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN) Supported Flag');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `iban_supported_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `iban_supported_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `insolvency_regime_type` SET TAGS ('dbx_business_glossary_term' = 'Insolvency Regime Type');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{1,3})?$');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'national|sub-national|supranational|territorial');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Status');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|historical|pending');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `legal_system_type` SET TAGS ('dbx_business_glossary_term' = 'Legal System Type');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `legal_system_type` SET TAGS ('dbx_value_regex' = 'common law|civil law|sharia law|mixed|customary law|other');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `netting_enforceability_flag` SET TAGS ('dbx_business_glossary_term' = 'Close-Out Netting Enforceability Flag');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `netting_opinion_date` SET TAGS ('dbx_business_glossary_term' = 'Netting Legal Opinion Date');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `primary_regulator` SET TAGS ('dbx_business_glossary_term' = 'Primary Banking Regulator');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `rtgs_system_name` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Gross Settlement (RTGS) System Name');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `sanctions_regime_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Regime Flag');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `securities_regulator` SET TAGS ('dbx_business_glossary_term' = 'Securities Regulator');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Short Name');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `sovereign_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Credit Rating');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `sovereign_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Rating Agency');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `sovereign_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Sovereign Rating Date');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `stress_testing_requirement` SET TAGS ('dbx_business_glossary_term' = 'Stress Testing Requirement');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `stress_testing_requirement` SET TAGS ('dbx_value_regex' = 'CCAR|DFAST|EBA stress test|local framework|none');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `tax_haven_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Haven Classification');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `tax_haven_classification` SET TAGS ('dbx_value_regex' = 'tax haven|low-tax|standard|not classified');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `tax_treaty_network_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Treaty Network Participation Flag');
ALTER TABLE `banking_ecm`.`reference`.`jurisdiction` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Primary Time Zone');
ALTER TABLE `banking_ecm`.`reference`.`market_center` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`market_center` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_center_id` SET TAGS ('dbx_business_glossary_term' = 'Market Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `best_execution_venue_flag` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Venue Flag');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `clearing_house_name` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Name');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_category` SET TAGS ('dbx_business_glossary_term' = 'Market Category');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_center_status` SET TAGS ('dbx_business_glossary_term' = 'Market Center Status');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_center_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|merged|decommissioned');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_data_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Market Data Vendor Code');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Center Name');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'exchange|multilateral_trading_facility|organized_trading_facility|systematic_internalizer|otc|dark_pool');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `mic_code` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier Code (MIC)');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `mic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `mifid2_trading_venue_flag` SET TAGS ('dbx_business_glossary_term' = 'Markets in Financial Instruments Directive II (MiFID II) Trading Venue Flag');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `operating_hours_close` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Close');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `operating_hours_close` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `operating_hours_open` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Open');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `operating_hours_open` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `operating_mic` SET TAGS ('dbx_business_glossary_term' = 'Operating Market Identifier Code (MIC)');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `operating_mic` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `parent_exchange_group` SET TAGS ('dbx_business_glossary_term' = 'Parent Exchange Group');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `post_trading_session_end` SET TAGS ('dbx_business_glossary_term' = 'Post-Trading Session End Time');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `post_trading_session_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `pre_trading_session_start` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trading Session Start Time');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `pre_trading_session_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'regulated|authorized|recognized|exempt|unregulated');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = '^T+[0-9]$');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `trade_reporting_facility_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Reporting Facility (TRF) Flag');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`market_center` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`reference`.`code_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`reference`.`code_list` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Code List ID');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `parent_code_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|retired');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `business_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Owner');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `code_description` SET TAGS ('dbx_business_glossary_term' = 'Code Description');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `code_label` SET TAGS ('dbx_business_glossary_term' = 'Code Label');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `code_level` SET TAGS ('dbx_business_glossary_term' = 'Code Level');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `code_list_type` SET TAGS ('dbx_business_glossary_term' = 'Code List Type');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `code_value` SET TAGS ('dbx_business_glossary_term' = 'Code Value');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `data_steward` SET TAGS ('dbx_business_glossary_term' = 'Data Steward');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `external_code_mapping` SET TAGS ('dbx_business_glossary_term' = 'External Code Mapping');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Flag');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `is_system_generated` SET TAGS ('dbx_business_glossary_term' = 'Is System Generated Flag');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `parent_code_value` SET TAGS ('dbx_business_glossary_term' = 'Parent Code Value');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `source_authority` SET TAGS ('dbx_business_glossary_term' = 'Source Authority');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `superseded_by_code_value` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Code Value');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `banking_ecm`.`reference`.`code_list` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` SET TAGS ('dbx_subdomain' = 'regulatory_taxonomy');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code ID');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `parent_industry_code_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `classification_system` SET TAGS ('dbx_business_glossary_term' = 'Classification System');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `classification_system` SET TAGS ('dbx_value_regex' = 'SIC|NAICS|GICS|ICB');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `climate_risk_exposure` SET TAGS ('dbx_business_glossary_term' = 'Climate Risk Exposure');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `climate_risk_exposure` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `code_description` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Description');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `code_path` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Hierarchical Path');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `code_short_name` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Short Name');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `code_value` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Value');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `concentration_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Concentration Risk Flag');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `cyclical_sensitivity` SET TAGS ('dbx_business_glossary_term' = 'Economic Cyclical Sensitivity');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `cyclical_sensitivity` SET TAGS ('dbx_value_regex' = 'defensive|neutral|cyclical|highly_cyclical');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `esg_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Risk Category');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `gics_equivalent_code` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Equivalent Code');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `high_risk_industry_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Industry Flag');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `icb_equivalent_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Benchmark (ICB) Equivalent Code');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `industry_code_status` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Status');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `industry_code_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|superseded|proposed');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `industry_group_name` SET TAGS ('dbx_business_glossary_term' = 'Industry Group Name');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `naics_equivalent_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System (NAICS) Equivalent Code');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `parent_code_value` SET TAGS ('dbx_business_glossary_term' = 'Parent Industry Code Value');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `regulatory_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Category');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `risk_weight_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Category');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `sanctions_exposure_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Exposure Flag');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `sector_name` SET TAGS ('dbx_business_glossary_term' = 'Economic Sector Name');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `sic_equivalent_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Industrial Classification (SIC) Equivalent Code');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `sub_industry_name` SET TAGS ('dbx_business_glossary_term' = 'Sub-Industry Name');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `superseded_by_code_value` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Code Value');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `banking_ecm`.`reference`.`industry_code` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Classification System Version Number');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` SET TAGS ('dbx_subdomain' = 'regulatory_taxonomy');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `parent_region_geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Geographic Region Identifier (ID)');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `parent_geographic_region_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `basel_implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Basel Implementation Status');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `basel_implementation_status` SET TAGS ('dbx_value_regex' = 'basel_i|basel_ii|basel_iii|basel_iv|not_applicable');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `country_codes` SET TAGS ('dbx_business_glossary_term' = 'Country Codes Mapping');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `data_residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Requirement Flag');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Data Steward Name');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Regional Headquarters City');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `ifrs_adoption_status` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Adoption Status');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `ifrs_adoption_status` SET TAGS ('dbx_value_regex' = 'full_ifrs|ifrs_converged|local_gaap|us_gaap');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `is_reporting_region` SET TAGS ('dbx_business_glossary_term' = 'Reporting Region Flag');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `is_risk_aggregation_unit` SET TAGS ('dbx_business_glossary_term' = 'Risk Aggregation Unit Flag');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `lob_ownership` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Ownership');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|discontinued');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_level` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Hierarchy Level');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Name');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_path` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Hierarchy Path');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_short_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Short Name');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Type');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `region_type` SET TAGS ('dbx_value_regex' = 'global|super_region|region|sub_region|territory|market');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Regional Manager Email Address');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `regional_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Manager Name');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk Rating');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `sanctions_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Flag');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `stress_testing_regime` SET TAGS ('dbx_business_glossary_term' = 'Stress Testing Regime');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Primary Time Zone');
ALTER TABLE `banking_ecm`.`reference`.`geographic_region` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
