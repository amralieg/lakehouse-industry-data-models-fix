-- Schema for Domain: security | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`security` COMMENT 'Master data for all securities and financial instruments including equities, fixed income, derivatives, MBS, ABS, CDS, CLO, CDO, and OTC instruments. Owns instrument master (ISIN, CUSIP, SEDOL), security classification, pricing, corporate actions, and security lifecycle. Provides the golden source instrument reference for trade, investment, and wealth domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the financial instrument. Primary key for the instrument master record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every instrument trades in a specific currency. Essential for FX risk calculation, P&L reporting, FRTB market risk capital, and Basel regulatory reporting. Replaces denormalized currency_code with pro',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Under IFRS 9 and ASC 320, each financial instrument maps to a specific GL account (e.g., AFS securities, HTM, trading book). This mapping drives balance sheet classification, P&L reporting, and regula',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Country of issuance determines legal jurisdiction, tax treatment, and regulatory reporting requirements. Critical for sanctions screening, country risk limits, and Basel country exposure reporting. Ro',
    `issuer_id` BIGINT COMMENT 'FK to security.issuer',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Instruments are governed by jurisdiction-specific regulatory frameworks (MiFID II, SEC) determining capital treatment, reporting obligations, and eligible investor rules. A banking regulatory capital ',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Instruments must be mapped to reference product types for Basel RWA calculation, IFRS9 portfolio segmentation, FATCA/CRS reportability, and GL account mapping. Banking product control and regulatory r',
    `underlying_instrument_id` BIGINT COMMENT 'Reference to the underlying instrument for derivatives and structured products. Links to another instrument record.',
    `asset_class` STRING COMMENT 'High-level classification of the instrument into major asset categories. [ENUM-REF-CANDIDATE: equity|fixed_income|derivative|fx|commodity|structured_product|money_market — 7 candidates stripped; promote to reference product]',
    `bloomberg_ticker` STRING COMMENT 'Bloomberg proprietary ticker symbol used to identify the instrument in Bloomberg Terminal systems.',
    `callable_flag` BOOLEAN COMMENT 'Indicates whether the issuer has the right to redeem the instrument before maturity.',
    `cfi_code` STRING COMMENT '6-character ISO standard code classifying the instrument by category, group, and attributes.. Valid values are `^[A-Z]{6}$`',
    `convertible_flag` BOOLEAN COMMENT 'Indicates whether the instrument can be converted into another security (typically equity).',
    `country_of_risk` STRING COMMENT '3-letter ISO country code representing the primary country exposure for risk management purposes.. Valid values are `^[A-Z]{3}$`',
    `coupon_frequency` STRING COMMENT 'Frequency at which coupon payments are made to holders of the instrument.. Valid values are `annual|semi_annual|quarterly|monthly|zero_coupon`',
    `coupon_rate` DECIMAL(18,2) COMMENT 'Annual interest rate paid by the instrument expressed as a decimal (e.g., 0.0525 for 5.25%). Applicable to fixed income securities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument master record was first created in the system.',
    `credit_rating` STRING COMMENT 'Current credit rating assigned to the instrument by major rating agencies (e.g., AAA, BBB+, B-).',
    `cusip` STRING COMMENT '9-character alphanumeric code identifying North American financial securities. Format: 6-character issuer code + 2-character issue code + 1 check digit.. Valid values are `^[0-9]{3}[0-9A-Z]{5}[0-9]$`',
    `day_count_convention` STRING COMMENT 'Method used to calculate accrued interest and coupon payments between payment dates.. Valid values are `30_360|actual_360|actual_365|actual_actual`',
    `exchange_code` STRING COMMENT '4-character ISO code identifying the primary exchange or trading venue where the instrument is listed.. Valid values are `^[A-Z]{4}$`',
    `exercise_style` STRING COMMENT 'Defines when the option can be exercised: American (any time), European (at expiry only), or Bermudan (specific dates).. Valid values are `american|european|bermudan`',
    `face_value` DECIMAL(18,2) COMMENT 'Nominal or par value of the instrument at issuance. Represents the principal amount for debt instruments.',
    `figi` STRING COMMENT '12-character alphanumeric code assigned to financial instruments by the Object Management Group (OMG). Provides a universal identifier across asset classes.. Valid values are `^[A-Z0-9]{12}$`',
    `first_coupon_date` DATE COMMENT 'Date of the first coupon payment for fixed income instruments. Applicable to bonds and structured products.',
    `instrument_name` STRING COMMENT 'Full legal name or description of the financial instrument as registered with the issuer or exchange.',
    `instrument_type` STRING COMMENT 'Detailed classification of the instrument within its asset class (e.g., corporate bond, equity option, interest rate swap, MBS, ABS, CDS, CLO, CDO). [ENUM-REF-CANDIDATE: corporate_bond|government_bond|municipal_bond|equity_common|equity_preferred|call_option|put_option|interest_rate_swap|credit_default_swap|fx_forward|fx_option|commodity_future|mbs|abs|clo|cdo|commercial_paper|certificate_of_deposit — promote to reference product]',
    `isin` STRING COMMENT '12-character alphanumeric code that uniquely identifies a security globally. Format: 2-letter country code + 9-character alphanumeric national security identifier + 1 check digit.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `issue_date` DATE COMMENT 'Date on which the instrument was originally issued or created.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument master record was last modified.',
    `lifecycle_status` STRING COMMENT 'Current operational status of the instrument in its lifecycle. Tracks the instrument from pre-issuance through final disposition. [ENUM-REF-CANDIDATE: pre_issuance|active|suspended|called|defaulted|matured|redeemed|delisted — 8 candidates stripped; promote to reference product]',
    `lot_size` STRING COMMENT 'Minimum trading unit or contract size for the instrument. Represents the number of units per lot.',
    `maturity_date` DATE COMMENT 'Date on which the instrument matures or expires. Null for perpetual instruments or equities without expiration.',
    `option_type` STRING COMMENT 'Specifies whether the option is a call (right to buy) or put (right to sell).. Valid values are `call|put`',
    `puttable_flag` BOOLEAN COMMENT 'Indicates whether the holder has the right to sell the instrument back to the issuer before maturity.',
    `reuters_ric` STRING COMMENT 'Reuters proprietary instrument code used to identify the security in Refinitiv systems.',
    `sedol` STRING COMMENT '7-character alphanumeric code identifying securities traded on the London Stock Exchange and other UK exchanges. Format: 6-character identifier + 1 check digit.. Valid values are `^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$`',
    `seniority` STRING COMMENT 'Priority ranking of the instrument in the issuers capital structure for claim settlement in case of default.. Valid values are `senior_secured|senior_unsecured|subordinated|junior`',
    `settlement_convention` STRING COMMENT 'Standard number of business days between trade date and settlement date for this instrument.. Valid values are `T+0|T+1|T+2|T+3`',
    `short_name` STRING COMMENT 'Abbreviated or display name of the instrument used for reporting and user interfaces.',
    `status_effective_date` DATE COMMENT 'Date on which the current lifecycle status became effective.',
    `strike_price` DECIMAL(18,2) COMMENT 'Exercise price for options and warrants. The price at which the holder can buy or sell the underlying asset.',
    `sub_asset_class` STRING COMMENT 'Granular sub-classification within the instrument type for detailed risk and reporting segmentation.',
    `trading_currency` STRING COMMENT '3-letter ISO currency code representing the currency in which the instrument is traded on the exchange.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_instrument PRIMARY KEY(`instrument_id`)
) COMMENT 'Golden source master record for all financial instruments and securities including equities, fixed income, derivatives, structured products (MBS, ABS, CLO, CDO), FX, and OTC instruments. Stores the authoritative instrument identity with ISIN, CUSIP, SEDOL, FIGI, and Bloomberg/Reuters identifiers. Captures instrument type, asset class, sub-asset class, issuer, currency, country of issuance, exchange listing, face value, lot size, settlement convention (T+1, T+2), day count convention, and current lifecycle status. Includes a complete lifecycle status history as an immutable append-only audit trail tracking every status transition (pre-issuance, active, suspended, called, defaulted, matured, redeemed, delisted) with effective dates, reason codes, triggering event references, and source systems. This is the enterprise-wide SSOT for instrument reference data consumed by trade, investment, wealth, risk, collateral, and compliance domains.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`equity` (
    `equity_id` BIGINT COMMENT 'Unique identifier for the equity instrument record. Primary key.',
    `instrument_id` BIGINT COMMENT 'Reference to the parent instrument master record that this equity extends.',
    `issuer_id` BIGINT COMMENT 'Reference to the legal entity (corporation) that issued this equity security.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Equity listing country drives withholding tax rates on dividends, FATCA/CRS reporting obligations, and short-selling restrictions. A tax operations or compliance team needs the primary listing country',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Par value currency determines corporate action entitlements (stock splits, dividends). Distinct from trading currency. Essential for accurate entitlement calculations in multi-currency equity portfoli',
    `adr_ratio` STRING COMMENT 'Ratio expressing how many underlying foreign shares one ADR represents (e.g., 1:5 means one ADR equals five foreign shares).',
    `callable_flag` BOOLEAN COMMENT 'Indicates whether the issuer has the right to redeem or call the equity before maturity (applicable to preferred stock).',
    `convertible_flag` BOOLEAN COMMENT 'Indicates whether this equity is convertible into another class of equity or security.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equity master record was first created in the system.',
    `cumulative_dividend_flag` BOOLEAN COMMENT 'Indicates whether unpaid dividends on preferred stock accumulate and must be paid before common stock dividends.',
    `cusip` STRING COMMENT '9-character alphanumeric code identifying North American securities.. Valid values are `^[0-9]{3}[A-Z0-9]{5}[0-9]$`',
    `delisting_date` DATE COMMENT 'Date on which the equity was removed from exchange listing, if applicable.',
    `depositary_bank` STRING COMMENT 'Name of the financial institution acting as depositary for ADRs or GDRs.',
    `dividend_eligibility` BOOLEAN COMMENT 'Indicates whether this equity class is eligible to receive dividend distributions.',
    `dividend_frequency` STRING COMMENT 'Frequency at which dividends are paid to shareholders.. Valid values are `annual|semi_annual|quarterly|monthly|irregular|none`',
    `dividend_rate` DECIMAL(18,2) COMMENT 'Annual dividend rate per share for preferred stock or fixed-dividend equities, expressed as a percentage of par value or absolute amount.',
    `equity_name` STRING COMMENT 'Full legal name of the equity security as registered with the issuer and exchange.',
    `equity_status` STRING COMMENT 'Current lifecycle status of the equity instrument.. Valid values are `active|suspended|delisted|matured|defaulted|cancelled`',
    `equity_type` STRING COMMENT 'Classification of the equity instrument: common stock, preferred stock, American Depositary Receipt (ADR), Global Depositary Receipt (GDR), Exchange-Traded Fund (ETF), or Real Estate Investment Trust (REIT).. Valid values are `common_stock|preferred_stock|adr|gdr|etf|reit`',
    `float_shares` BIGINT COMMENT 'Number of shares available for public trading, excluding restricted shares held by insiders and large institutional holders.',
    `gics_industry_code` STRING COMMENT 'Six-digit code representing the GICS industry classification of the issuer.. Valid values are `^[0-9]{6}$`',
    `gics_industry_group_code` STRING COMMENT 'Four-digit code representing the GICS industry group classification of the issuer.. Valid values are `^[0-9]{4}$`',
    `gics_sector_code` STRING COMMENT 'Two-digit code representing the GICS sector classification of the issuer (e.g., 10=Energy, 20=Materials, 45=Information Technology).. Valid values are `^[0-9]{2}$`',
    `gics_sub_industry_code` STRING COMMENT 'Eight-digit code representing the most granular GICS sub-industry classification of the issuer.. Valid values are `^[0-9]{8}$`',
    `index_membership` STRING COMMENT 'Comma-separated list of major indices in which this equity is a constituent (e.g., S&P 500, DJIA, NASDAQ-100, MSCI World, Russell 2000).',
    `isin` STRING COMMENT 'ISO 6166 standard 12-character alphanumeric code uniquely identifying the equity security globally.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `listing_date` DATE COMMENT 'Date on which the equity was first listed and began trading on the primary exchange.',
    `market_cap_tier` STRING COMMENT 'Classification of the equity based on market capitalization size: mega-cap (>$200B), large-cap ($10B-$200B), mid-cap ($2B-$10B), small-cap ($300M-$2B), micro-cap ($50M-$300M), nano-cap (<$50M).. Valid values are `mega_cap|large_cap|mid_cap|small_cap|micro_cap|nano_cap`',
    `par_value` DECIMAL(18,2) COMMENT 'Nominal or face value of one share as stated in the corporate charter, used for accounting and legal purposes.',
    `participating_flag` BOOLEAN COMMENT 'Indicates whether preferred stockholders can receive additional dividends beyond the stated rate if common stockholders receive dividends above a certain threshold.',
    `primary_exchange` STRING COMMENT 'Market Identifier Code (MIC) of the primary exchange where the equity is listed and traded.',
    `puttable_flag` BOOLEAN COMMENT 'Indicates whether the holder has the right to sell the equity back to the issuer at a predetermined price (applicable to preferred stock).',
    `sedol` STRING COMMENT '7-character alphanumeric code identifying securities traded on the London Stock Exchange and other UK exchanges.. Valid values are `^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$`',
    `share_class` STRING COMMENT 'Designation of the share class (e.g., Class A, Class B, Class C) indicating different rights, voting power, or dividend structures.',
    `shares_authorized` BIGINT COMMENT 'Maximum number of shares the corporation is legally permitted to issue as defined in the corporate charter.',
    `shares_outstanding` BIGINT COMMENT 'Total number of shares currently issued and held by shareholders, including restricted shares but excluding treasury stock.',
    `ticker_symbol` STRING COMMENT 'Exchange-specific trading symbol used to identify the equity on trading platforms.',
    `trading_status` STRING COMMENT 'Current real-time trading status on the exchange.. Valid values are `normal|halted|suspended|pre_open|post_close|auction`',
    `underlying_security_isin` STRING COMMENT 'ISIN of the underlying foreign security for ADRs and GDRs.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this equity master record was last modified.',
    `voting_rights` STRING COMMENT 'Indicates whether the equity carries voting rights and the type: voting (standard one share one vote), non-voting, limited voting, or super voting (multiple votes per share).. Valid values are `voting|non_voting|limited_voting|super_voting`',
    CONSTRAINT pk_equity PRIMARY KEY(`equity_id`)
) COMMENT 'Master data for equity instruments including common stock, preferred stock, ADRs, GDRs, ETFs, and REITs. Captures equity-specific attributes such as share class, voting rights, par value, shares outstanding, float, dividend eligibility, index membership (S&P 500, MSCI), sector (GICS), industry group, market capitalization tier, and listing exchange. Links to the parent instrument master and issuer entity. Supports securities trading, portfolio management, and corporate actions processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`fixed_income` (
    `fixed_income_id` BIGINT COMMENT 'Unique identifier for the fixed income instrument record. Primary key for the fixed income master data product.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: fixed_income has a floating_rate_index STRING column that stores the reference rate/benchmark for floating rate bonds (e.g., SOFR, EURIBOR 3M, LIBOR 6M). The security.benchmark table is the mast',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Bond holdings create issuer credit exposure tracked for concentration limits and regulatory capital. IFRS9 ECL provisioning requires exposure quantification. Mandatory for credit risk reporting and la',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Bond denomination currency is fundamental to pricing, accrued interest calculation, and FX hedging strategies. Required for accurate yield calculation and cross-currency bond portfolio analytics in fi',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Fixed income coupon payment dates and settlement dates require business day adjustment per the applicable holiday calendar. Operations teams use this link to generate accurate payment schedules and av',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: fixed_income is a subtype of instrument and must link to the instrument master record, exactly as equity.instrument_id → instrument already does. The fixed_income table currently carries denormalized ',
    `issuer_id` BIGINT COMMENT 'FK to security.issuer',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Floating-rate bonds reference an authoritative rate benchmark (SOFR, EURIBOR) for coupon resets. fixed_income has floating_rate_spread and reset_frequency but no FK to the rate benchmark. Operations a',
    `accrued_interest` DECIMAL(18,2) COMMENT 'Interest that has accumulated on the bond since the last coupon payment date but has not yet been paid. Added to the purchase price in bond transactions.',
    `call_date` DATE COMMENT 'Earliest date on which the issuer may exercise the call option to redeem the bond. Null if the bond is not callable.',
    `call_price` DECIMAL(18,2) COMMENT 'Price at which the issuer may redeem the bond if the call option is exercised. Often expressed as a percentage of face value plus accrued interest.',
    `callable_flag` BOOLEAN COMMENT 'Indicates whether the issuer has the right to redeem the bond before maturity at specified call dates and prices. Affects duration, convexity, and valuation.',
    `convexity` DECIMAL(18,2) COMMENT 'Measure of the curvature in the relationship between bond prices and yields. Used to refine duration-based interest rate risk estimates for large rate movements.',
    `coupon_frequency` STRING COMMENT 'Frequency at which coupon interest payments are made to bondholders. Determines the number of payment periods per year and cash flow timing.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `coupon_rate` DECIMAL(18,2) COMMENT 'Annual interest rate paid on the bond face value, expressed as a decimal. For fixed-rate bonds this remains constant; for floating-rate bonds this is the current rate after reset.',
    `coupon_type` STRING COMMENT 'Classification of the coupon payment structure. Fixed coupons pay a constant rate, floating coupons reset periodically based on a reference rate, zero coupon bonds pay no periodic interest.. Valid values are `fixed|floating|zero_coupon`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed income instrument record was first created in the system. Used for data lineage and audit trail purposes.',
    `credit_rating_fitch` STRING COMMENT 'Credit quality assessment assigned by Fitch Ratings. Ranges from AAA (highest quality) to D (default). Used for portfolio risk management and regulatory reporting.',
    `credit_rating_moodys` STRING COMMENT 'Credit quality assessment assigned by Moodys Investors Service. Ranges from Aaa (highest quality) to C (lowest quality). Used for risk-weighted asset calculations and investment policy compliance.',
    `credit_rating_sp` STRING COMMENT 'Credit quality assessment assigned by Standard & Poors. Ranges from AAA (highest quality) to D (default). Critical for regulatory capital requirements under Basel III.',
    `day_count_convention` STRING COMMENT 'Method used to calculate accrued interest between coupon payment dates. Critical for accurate interest accrual, pricing, and settlement calculations.. Valid values are `ACT_360|ACT_365|30_360|ACT_ACT`',
    `duration` DECIMAL(18,2) COMMENT 'Measure of the bonds price sensitivity to changes in interest rates, expressed in years. Critical for interest rate risk management and ALM gap analysis.',
    `face_value` DECIMAL(18,2) COMMENT 'Par value or principal amount of the bond that will be repaid at maturity. Basis for coupon payment calculations and amortization schedules.',
    `first_coupon_date` DATE COMMENT 'Date of the first scheduled coupon payment. May differ from a regular period if the bond has an odd first coupon period.',
    `fixed_income_status` STRING COMMENT 'Current state of the bond in its lifecycle. Active bonds are trading normally, matured bonds have reached their maturity date, called bonds have been redeemed early, defaulted bonds have missed payments.. Valid values are `active|matured|called|defaulted|suspended`',
    `floating_rate_spread` DECIMAL(18,2) COMMENT 'Fixed spread in basis points added to the reference index rate to determine the coupon rate for floating-rate bonds. Reflects issuer credit risk and market conditions at issuance.',
    `issue_date` DATE COMMENT 'Date on which the bond was originally issued and became available for purchase in the primary market.',
    `last_coupon_date` DATE COMMENT 'Date of the final scheduled coupon payment before maturity. Typically occurs on or shortly before the maturity date.',
    `market_price` DECIMAL(18,2) COMMENT 'Most recent trading price or valuation of the bond in the secondary market, typically expressed as a percentage of face value. Used for mark-to-market valuation and PnL calculation.',
    `maturity_date` DATE COMMENT 'Date on which the principal amount of the bond becomes due and payable to the bondholder. Final date in the bond lifecycle.',
    `price_date` DATE COMMENT 'Date on which the current market price was observed or calculated. Critical for fair value accounting and regulatory reporting.',
    `put_date` DATE COMMENT 'Earliest date on which the bondholder may exercise the put option to sell the bond back to the issuer. Null if the bond is not puttable.',
    `put_price` DECIMAL(18,2) COMMENT 'Price at which the bondholder may sell the bond back to the issuer if the put option is exercised. Typically at or near par value.',
    `puttable_flag` BOOLEAN COMMENT 'Indicates whether the bondholder has the right to sell the bond back to the issuer before maturity at specified put dates and prices. Provides downside protection to investors.',
    `rating_date` DATE COMMENT 'Date on which the current credit rating was assigned or last affirmed by the rating agency. Used to track rating changes and trigger covenant reviews.',
    `reset_frequency` STRING COMMENT 'Frequency at which the coupon rate is recalculated based on the current reference index rate for floating-rate bonds. Determines interest rate risk exposure.. Valid values are `daily|monthly|quarterly|semi_annual|annual`',
    `sinking_fund_flag` BOOLEAN COMMENT 'Indicates whether the bond has a sinking fund provision requiring the issuer to retire a portion of the bond issue periodically before maturity. Reduces credit risk but may limit upside.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed income instrument record was last modified. Tracks data currency and supports change data capture processes.',
    `yield_to_maturity` DECIMAL(18,2) COMMENT 'Total return anticipated on the bond if held until maturity, expressed as an annual rate. Incorporates coupon payments, principal repayment, and current market price.',
    CONSTRAINT pk_fixed_income PRIMARY KEY(`fixed_income_id`)
) COMMENT 'Master data for fixed income instruments including government bonds, corporate bonds, municipal bonds, treasury bills, notes, and inflation-linked securities, with embedded detailed coupon payment schedules. Captures bond-specific attributes: coupon rate, coupon frequency, coupon type (fixed/floating/zero), maturity date, first coupon date, last coupon date, day count convention (ACT/360, 30/360), yield basis, call/put provisions, sinking fund schedule, credit rating (Moodys, S&P, Fitch), rating date, and bond covenants. Includes the full coupon schedule as embedded detail with accrual start/end dates, payment dates, coupon period number, coupon rate (fixed or floating reset), day count fraction, projected and actual coupon amounts (post-reset for floaters), payment currency, and payment status (scheduled/paid/missed/deferred). Supports NII calculation, cash flow projection, ALM gap analysis, bond analytics (duration, convexity, DV01), IFRS 9 ECL modeling, and NII forecasting.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`derivative` (
    `derivative_id` BIGINT COMMENT 'Unique identifier for the derivative instrument. Primary key.',
    `counterparty_agreement_id` BIGINT COMMENT 'Reference to the ISDA Master Agreement governing the legal terms and conditions of the derivative contract between counterparties.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Derivative payment dates, reset dates, and expiry dates require business day adjustment per the applicable holiday calendar. Operations and middle office teams use this link to generate accurate cash ',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the Credit Support Annex that governs collateral posting requirements and margin calculations for the derivative contract.',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Derivative transaction surveillance under EMIR/Dodd-Frank requires specific monitoring rules for detecting market abuse and suspicious activity. Compliance teams assign monitoring rules to derivative ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Notional currency defines derivative contract size and exposure. Critical for risk aggregation, CVA calculation, and regulatory reporting (EMIR, Dodd-Frank). First of four currency FKs needed for deri',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Derivatives carry specific regulatory reporting obligations (EMIR Article 9, Dodd-Frank Title VII). derivative.reporting_obligation is a denormalized string; the proper FK to obligation_id links each ',
    `party_id` BIGINT COMMENT 'Reference to the legal entity on the opposite side of the derivative transaction. Used for counterparty credit risk (CVA) and exposure calculations.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Interest rate swaps, FRAs, and caps/floors reference a specific rate benchmark (SOFR, EURIBOR) as the floating leg. Risk and operations teams need this FK to value derivatives, calculate reset payment',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Credit derivatives (CDS, total return swaps, credit-linked notes) referencing loan facilities as underlying exposure require facility identification for mark-to-market valuation, credit event determin',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Derivatives carry a reporting_obligation field and are subject to jurisdiction-specific trade reporting rules (EMIR in EU, Dodd-Frank in US, MAS in Singapore). Compliance teams need the reporting juri',
    `instrument_id` BIGINT COMMENT 'Reference to the underlying asset or instrument upon which the derivative contract is based (equity, bond, commodity, index, currency pair, or another derivative).',
    `asset_class` STRING COMMENT 'Broad asset class of the underlying instrument: interest rate, foreign exchange (FX), equity, commodity, or credit. Used for FRTB capital allocation and risk segmentation.. Valid values are `interest_rate|foreign_exchange|equity|commodity|credit`',
    `barrier_level` DECIMAL(18,2) COMMENT 'Price threshold that activates (knock-in) or deactivates (knock-out) the derivative contract. Used in barrier options and structured products.',
    `barrier_type` STRING COMMENT 'Classification of barrier feature: knock-in (option activates when barrier is breached), knock-out (option terminates when barrier is breached), double-barrier (both upper and lower barriers), or none for non-barrier derivatives.. Valid values are `knock_in|knock_out|double_barrier|none`',
    `ccp_name` STRING COMMENT 'Name of the central clearing house through which the derivative is cleared (e.g., LCH, CME, Eurex Clearing). Applicable only for cleared derivatives.',
    `clearing_status` STRING COMMENT 'Indicates whether the derivative is cleared through a central counterparty (CCP) or remains bilateral between counterparties. Cleared derivatives have lower capital requirements under Basel III.. Valid values are `cleared|bilateral|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the derivative instrument record was first created in the system. Used for audit trail and data lineage.',
    `cusip` STRING COMMENT '9-character alphanumeric code identifying North American securities. Used for clearing and settlement.. Valid values are `^[0-9]{3}[A-Z0-9]{5}[0-9]$`',
    `cva_amount` DECIMAL(18,2) COMMENT 'Adjustment to the mark-to-market value reflecting the counterparty credit risk. Calculated based on probability of default (PD), loss given default (LGD), and exposure at default (EAD).',
    `derivative_type` STRING COMMENT 'Classification of the derivative instrument by contract structure: swap, forward, future, option, swaption, credit default swap (CDS), total return swap, variance swap, or exotic derivative. [ENUM-REF-CANDIDATE: swap|forward|future|option|swaption|credit_default_swap|total_return_swap|variance_swap|exotic — 9 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which the derivative contract becomes legally binding and cash flows or obligations begin to accrue. May differ from trade date for forward-starting contracts.',
    `exercise_style` STRING COMMENT 'Defines when the option holder can exercise the contract: European (only at expiry), American (any time before expiry), Bermudan (on specific dates), or Asian (based on average price over period).. Valid values are `european|american|bermudan|asian`',
    `expiry_date` DATE COMMENT 'The last date on which an option can be exercised. Synonymous with maturity date for options but distinct for other derivative types.',
    `frtb_capital_charge` DECIMAL(18,2) COMMENT 'Market risk capital requirement calculated under the FRTB framework using either the standardized approach (SA) or internal models approach (IMA).',
    `initial_margin` DECIMAL(18,2) COMMENT 'Collateral posted at trade inception to cover potential future exposure. Required for non-cleared derivatives under EMIR and Dodd-Frank margin rules.',
    `isin` STRING COMMENT '12-character alphanumeric code that uniquely identifies the derivative instrument globally. Used for regulatory reporting and trade repository submissions.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `lifecycle_status` STRING COMMENT 'Current state of the derivative contract: active (live and accruing), matured (reached expiry), terminated (early termination), cancelled (voided before effective date), or suspended (temporarily inactive).. Valid values are `active|matured|terminated|cancelled|suspended`',
    `margin_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which initial and variation margin are posted.. Valid values are `^[A-Z]{3}$`',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'Current fair value of the derivative contract based on prevailing market prices and valuation models. Updated daily for profit and loss (PnL) attribution and CVA calculation.',
    `maturity_date` DATE COMMENT 'The date on which the derivative contract expires and final settlement occurs. For options, this is the expiry date; for swaps, this is the termination date.',
    `mtm_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the mark-to-market value is denominated.. Valid values are `^[A-Z]{3}$`',
    `notional_amount` DECIMAL(18,2) COMMENT 'The notional or face value of the derivative contract used to calculate payment obligations. Does not represent actual cash exchanged at inception but is the basis for calculating periodic settlements.',
    `rwa_amount` DECIMAL(18,2) COMMENT 'Capital requirement for the derivative calculated under Basel III standardized approach (SA) or internal ratings-based (IRB) approach. Used for regulatory capital adequacy reporting.',
    `sedol` STRING COMMENT '7-character alphanumeric code identifying securities traded on the London Stock Exchange and other UK exchanges.. Valid values are `^[0-9A-Z]{7}$`',
    `settlement_date` DATE COMMENT 'The date on which cash or physical settlement of the derivative contract occurs. Typically T+1 or T+2 after trade date depending on asset class and market convention.',
    `settlement_type` STRING COMMENT 'Method of settlement at maturity: cash settlement (net cash payment based on market value) or physical delivery (actual transfer of underlying asset).. Valid values are `cash|physical`',
    `strike_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the strike price. Relevant for FX options and cross-currency derivatives.. Valid values are `^[A-Z]{3}$`',
    `strike_price` DECIMAL(18,2) COMMENT 'The predetermined price at which the holder of an option can buy (call) or sell (put) the underlying asset. Applicable to options, swaptions, and structured derivatives with embedded optionality.',
    `subtype` STRING COMMENT 'Granular classification within the derivative type (e.g., interest rate swap, FX forward, equity call option, barrier option, Asian option). Provides detailed product categorization for risk and capital reporting.',
    `termination_date` DATE COMMENT 'Date on which the derivative contract was terminated early, either by mutual agreement or due to a credit event. Null for contracts that reach natural maturity.',
    `trade_date` DATE COMMENT 'The date on which the derivative contract was executed and agreed upon by counterparties. Used for T+1 settlement calculations and trade repository reporting.',
    `trade_repository_reference` STRING COMMENT 'Identifier assigned by the trade repository where the derivative transaction is reported under EMIR or Dodd-Frank regulations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the derivative instrument record. Used for change tracking and audit compliance.',
    `uti` STRING COMMENT 'Globally unique identifier assigned to each derivative transaction for trade repository reporting under EMIR and Dodd-Frank regulations.',
    `variation_margin` DECIMAL(18,2) COMMENT 'Daily collateral exchange based on mark-to-market movements. Ensures that counterparty exposure is fully collateralized on a daily basis.',
    CONSTRAINT pk_derivative PRIMARY KEY(`derivative_id`)
) COMMENT 'Master data for derivative instruments including exchange-traded and OTC derivatives: interest rate swaps, FX forwards, FX options, equity options, futures, CDS, total return swaps, and swaptions. Captures derivative-specific attributes: underlying instrument, derivative type, notional amount, notional currency, strike price, barrier levels, expiry date, exercise style (European/American/Bermudan), settlement type (cash/physical), ISDA master agreement reference, CSA linkage, clearing eligibility (CCP cleared vs bilateral), and trade repository reporting obligation. Supports CVA calculation, FRTB capital, and ISDA/CSA margin management.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`issuer` (
    `issuer_id` BIGINT COMMENT 'Unique identifier for the security issuer. Primary key for the issuer master data product.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Issuer domicile determines tax withholding, regulatory jurisdiction, and country exposure limits. Critical for sanctions screening, country concentration risk management, and Basel Pillar 3 country ex',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Industry classification drives sector concentration limits, stress testing scenarios, and portfolio construction rules. Essential for CCAR/DFAST industry shock scenarios and Basel sectoral risk weight',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Issuer incorporation jurisdiction determines netting enforceability, insolvency regime treatment, and regulatory capital classification. issuer.incorporation_jurisdiction is a plain text denormalizati',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Issuers that are bank subsidiaries or SPVs must be linked to the banks legal entity registry for FINREP/COREP consolidation, intercompany elimination, and large exposure reporting. A banking regulato',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Issuers must have LEI codes for MiFID II, EMIR, and SFTR regulatory reporting. issuer.lei is a plain text denormalization of the authoritative lei_registry entity. Compliance and regulatory reporting ',
    `parent_issuer_id` BIGINT COMMENT 'Reference to the immediate parent entity in the corporate hierarchy. Used for consolidated risk reporting and group exposure aggregation under Basel III.',
    `primary_ultimate_parent_issuer_id` BIGINT COMMENT 'Reference to the top-level parent entity in the corporate hierarchy. Critical for ultimate risk aggregation, large exposure monitoring, and CCAR/DFAST stress testing.',
    `bloomberg_issuer_code` STRING COMMENT 'Bloombergs proprietary issuer identifier used for market data integration, pricing feeds, and reference data synchronization with Bloomberg Terminal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this issuer record was first created in the system. Audit trail for data lineage and regulatory compliance.',
    `cva_adjustment` DECIMAL(18,2) COMMENT 'The market value of counterparty credit risk for derivative exposures with this issuer. Required under Basel III CVA capital charge and IFRS 13 fair value accounting.',
    `effective_date` DATE COMMENT 'Date when this issuer record became effective in the system. Used for temporal queries and historical analysis.',
    `expiration_date` DATE COMMENT 'Date when this issuer record expires or was superseded. Null for currently active records. Supports slowly changing dimension Type 2 history.',
    `fitch_issuer_rating` STRING COMMENT 'Current long-term issuer default rating assigned by Fitch Ratings. Provides third opinion for credit risk triangulation.',
    `fitch_rating_date` DATE COMMENT 'Date when the current Fitch issuer rating was assigned or last affirmed.',
    `fitch_rating_outlook` STRING COMMENT 'Fitchs assessment of the potential direction of the issuer rating over a one to two-year period.. Valid values are `positive|stable|negative|evolving`',
    `gics_sub_industry_code` STRING COMMENT 'Eight-digit GICS sub-industry code providing the most granular level of industry classification for specialized credit analysis.. Valid values are `^[0-9]{8}$`',
    `internal_credit_rating` STRING COMMENT 'Banks internal credit rating assigned through the Internal Ratings-Based (IRB) approach. Used for economic capital allocation, pricing, and portfolio management when approved by regulators.',
    `internal_lgd` DECIMAL(18,2) COMMENT 'Banks estimate of the economic loss as a percentage of Exposure at Default if the issuer defaults. Expressed as percentage (e.g., 45.00 = 45%). Used for IRB capital and expected loss calculations.',
    `internal_pd` DECIMAL(18,2) COMMENT 'Banks estimate of the one-year probability of default for the issuer, expressed as a decimal (e.g., 0.015 = 1.5%). Core input for IRB capital calculations and CECL/IFRS 9 expected credit loss provisioning.',
    `is_financial_institution` BOOLEAN COMMENT 'Boolean indicator whether the issuer is classified as a financial institution under Basel III. Determines interbank exposure treatment and contagion risk assessment.',
    `is_investment_grade` BOOLEAN COMMENT 'Boolean indicator whether the issuers credit rating meets investment grade threshold (BBB-/Baa3 or higher). Used for portfolio mandate compliance and risk appetite limits.',
    `is_public_sector_entity` BOOLEAN COMMENT 'Boolean indicator whether the issuer is a public sector entity eligible for preferential risk weighting under Basel III Standardized Approach.',
    `issuer_status` STRING COMMENT 'Current lifecycle status of the issuer entity. Inactive, merged, or bankrupt issuers require special handling for legacy securities and credit event processing.. Valid values are `active|inactive|merged|acquired|liquidated|bankrupt`',
    `issuer_type` STRING COMMENT 'Classification of the issuer entity type. Determines applicable regulatory treatment, credit risk methodology, and capital requirements under Basel III.. Valid values are `corporate|sovereign|municipal|supranational|special_purpose_vehicle|government_agency`',
    `legal_name` STRING COMMENT 'The full legal name of the issuer as registered with the incorporation authority. This is the official name used in legal documents, securities filings, and regulatory submissions.',
    `moodys_issuer_rating` STRING COMMENT 'Current long-term issuer rating assigned by Moodys Investors Service. Used for credit risk assessment, portfolio limits, and regulatory capital calculations.',
    `moodys_rating_date` DATE COMMENT 'Date when the current Moodys issuer rating was assigned or last affirmed.',
    `moodys_rating_outlook` STRING COMMENT 'Moodys opinion on the likely direction of the issuer rating over the medium term.. Valid values are `positive|stable|negative|rating_under_review`',
    `primary_exchange_code` STRING COMMENT 'ISO 10383 Market Identifier Code (MIC) for the issuers primary listing exchange. Used for market data sourcing and trading venue identification.',
    `regulatory_classification` STRING COMMENT 'Basel III regulatory classification determining capital treatment, risk weighting methodology, and large exposure limits. Financial institutions receive different treatment than non-financial corporates.. Valid values are `financial_institution|non_financial_corporation|public_sector_entity|central_bank|multilateral_development_bank`',
    `sp_issuer_credit_rating` STRING COMMENT 'Current long-term issuer credit rating assigned by Standard & Poors. Used for credit risk assessment, RWA calculation under Standardized Approach, and investment policy compliance.',
    `sp_rating_date` DATE COMMENT 'Date when the current S&P issuer credit rating was assigned or last affirmed. Critical for determining rating staleness in credit risk models.',
    `sp_rating_outlook` STRING COMMENT 'S&Ps forward-looking opinion on the potential direction of the issuer credit rating over the intermediate term (typically 6-24 months).. Valid values are `positive|stable|negative|developing`',
    `ticker_symbol` STRING COMMENT 'Primary stock exchange ticker symbol for publicly traded issuers. Used for market data integration and equity price monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this issuer record was last modified. Critical for change data capture and downstream synchronization.',
    `website_url` STRING COMMENT 'Official corporate website URL for the issuer. Used for investor relations access and ESG data sourcing.',
    CONSTRAINT pk_issuer PRIMARY KEY(`issuer_id`)
) COMMENT 'Master data for security issuers including corporations, sovereign governments, municipalities, supranational entities, and special purpose vehicles (SPVs). Captures issuer legal name, LEI (Legal Entity Identifier), issuer type, domicile country, incorporation jurisdiction, parent entity, ultimate parent, credit ratings by agency, sector classification (GICS/SIC/NAICS), Bloomberg issuer ID, and regulatory classification (financial/non-financial). Serves as the authoritative issuer reference for fixed income, structured products, and credit risk domains. Distinct from the customer domain which owns client/counterparty identity.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`price` (
    `price_id` BIGINT COMMENT 'Unique identifier for each price observation record in the immutable time-series.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: The price table contains spread_to_benchmark_bps — a spread measurement that is only meaningful relative to a specific benchmark (e.g., spread to US Treasury, spread to SOFR). Without a benchmark_id F',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every price quote requires currency context for valuation and P&L calculation. Essential for multi-currency portfolio valuation, FX translation, and fair value hierarchy reporting under IFRS 13.',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument being priced. Links to the security master for ISIN, CUSIP, SEDOL, and instrument classification.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: FRTB P&L attribution and stressed VaR require stressed mark-to-market prices computed under specific stress scenarios. A price record representing a stressed valuation must reference the scenario unde',
    `superseded_by_price_id` BIGINT COMMENT 'Reference to the price_id of the corrected observation that supersedes this record. Null if this is the current valid observation.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The interest accumulated on a fixed income security since the last coupon payment date. Used to calculate dirty price from clean price.',
    `adjusted_close_price` DECIMAL(18,2) COMMENT 'The closing price adjusted for corporate actions (stock splits, dividends, rights issues) to maintain historical price continuity for performance analysis.',
    `ask_price` DECIMAL(18,2) COMMENT 'The lowest price a seller is willing to accept for the security at the observation time. Used for liquidity analysis and bid-ask spread calculation.',
    `basis` STRING COMMENT 'Indicates whether the price is clean (excluding accrued interest) or dirty (including accrued interest). Primarily applicable to fixed income securities.. Valid values are `clean|dirty`',
    `bid_price` DECIMAL(18,2) COMMENT 'The highest price a buyer is willing to pay for the security at the observation time. Used for liquidity analysis and bid-ask spread calculation.',
    `change_amount` DECIMAL(18,2) COMMENT 'The absolute change in price from the previous observation, calculated as current price minus prior price. Used for volatility analysis and market movement tracking.',
    `change_percentage` DECIMAL(18,2) COMMENT 'The percentage change in price from the previous observation, calculated as ((current price - prior price) / prior price) * 100. Used for performance attribution and trend analysis.',
    `confidence_score` DECIMAL(18,2) COMMENT 'A quantitative measure (0.0000 to 1.0000) representing the confidence or reliability of the price observation, derived from source quality, market liquidity, and validation checks.',
    `correction_reason_code` STRING COMMENT 'Standardized code explaining why a price observation was corrected or superseded. Supports audit trail and data quality monitoring.. Valid values are `source_error|corporate_action|manual_adjustment|system_correction|vendor_restatement`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this price record was first created in the lakehouse silver layer. Supports audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A composite score (0.0000 to 1.0000) representing the overall quality of this price record based on completeness, timeliness, consistency, and validation checks.',
    `fair_value_hierarchy_level` STRING COMMENT 'IFRS 13 / FASB ASC 820 fair value hierarchy classification: Level 1 (quoted prices in active markets), Level 2 (observable inputs), Level 3 (unobservable inputs).. Valid values are `level_1|level_2|level_3`',
    `high_price` DECIMAL(18,2) COMMENT 'The highest traded price of the security during the trading session or observation period.',
    `is_superseded` BOOLEAN COMMENT 'Boolean flag indicating whether this price observation has been superseded by a subsequent correction or restatement. Supports immutable append-only architecture.',
    `last_trade_price` DECIMAL(18,2) COMMENT 'The price at which the most recent trade was executed for this instrument. Represents actual market transaction price.',
    `low_price` DECIMAL(18,2) COMMENT 'The lowest traded price of the security during the trading session or observation period.',
    `mid_price` DECIMAL(18,2) COMMENT 'The midpoint between bid and ask prices, calculated as (bid + ask) / 2. Commonly used for fair value estimation and portfolio valuation.',
    `notation` STRING COMMENT 'The format in which the price is expressed: decimal (e.g., 105.50), percentage (e.g., 98.75%), yield (e.g., 3.25%), basis points, or fractional (e.g., 32nds for US Treasuries).. Valid values are `decimal|percentage|yield|basis_points|fractional`',
    `observation_timestamp` TIMESTAMP COMMENT 'The timestamp when this price record was captured and appended to the immutable time-series. Distinct from pricing_timestamp; supports data lineage and audit.',
    `official_close_price` DECIMAL(18,2) COMMENT 'The official closing price published by the exchange or pricing authority at end of trading day. Used for Net Asset Value (NAV) calculation and regulatory reporting.',
    `open_price` DECIMAL(18,2) COMMENT 'The first traded price of the security at the start of the trading session.',
    `price_source` STRING COMMENT 'The originating system or vendor that provided this price observation (e.g., Bloomberg, Reuters/Refinitiv, exchange feed, broker quote, internal valuation model). [ENUM-REF-CANDIDATE: bloomberg|reuters|refinitiv|exchange_feed|broker_quote|internal_model|vendor — 7 candidates stripped; promote to reference product]',
    `price_status` STRING COMMENT 'The current status of pricing for this instrument: active (normal trading), suspended (temporarily halted), halted (trading stopped), delisted (removed from exchange), matured (instrument expired).. Valid values are `active|suspended|halted|delisted|matured`',
    `price_type` STRING COMMENT 'Classification of the price observation: market (actual traded price), model (derived from valuation model), indicative (non-binding quote), official (exchange-published), closing (end-of-day), opening (start-of-day).. Valid values are `market|model|indicative|official|closing|opening`',
    `pricing_date` DATE COMMENT 'The business date for which this price observation is effective. Used for end-of-day valuations and historical analysis.',
    `pricing_timestamp` TIMESTAMP COMMENT 'The precise date and time when this price observation was recorded or became effective. Critical for intraday Mark-to-Market (MTM) and trade execution analysis.',
    `quality_flag` STRING COMMENT 'Indicator of the reliability and timeliness of the price observation. Verified = confirmed by multiple sources; stale = outdated; estimated = model-derived; challenged = disputed or under review.. Valid values are `verified|unverified|stale|estimated|challenged`',
    `regulatory_price_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this price observation is used for regulatory reporting purposes (e.g., CCAR, DFAST, Basel III stress testing, IFRS 9 fair value measurement).',
    `source_system` STRING COMMENT 'The name or identifier of the upstream system that originated this price observation (e.g., Murex, Calypso, Bloomberg Terminal, internal pricing engine).',
    `spread_to_benchmark_bps` DECIMAL(18,2) COMMENT 'The yield spread over a benchmark rate (e.g., LIBOR, SOFR, Treasury) expressed in basis points (BPS). Used for credit risk assessment and relative value analysis.',
    `trading_session` STRING COMMENT 'Identifies the trading session during which the price observation was recorded (pre-market, regular hours, after-hours, overnight).. Valid values are `pre_market|regular|after_hours|overnight`',
    `valuation_method` STRING COMMENT 'The methodology used to derive the price: quoted (exchange-traded), matrix (interpolated from comparable securities), model (internal valuation model), consensus (average of multiple sources), broker quote.. Valid values are `quoted|matrix|model|consensus|broker_quote`',
    `volume` BIGINT COMMENT 'The total number of units (shares, bonds, contracts) traded during the observation period. Used for liquidity assessment and market depth analysis.',
    `vwap` DECIMAL(18,2) COMMENT 'The average price weighted by trading volume over the observation period. Used for execution quality assessment and algorithmic trading benchmarks.',
    `yield_to_maturity` DECIMAL(18,2) COMMENT 'The total return anticipated on a bond if held until maturity, expressed as an annual percentage rate. Critical for fixed income valuation and portfolio analytics.',
    CONSTRAINT pk_price PRIMARY KEY(`price_id`)
) COMMENT 'Immutable append-only time-series of all security price observations for all instruments, serving as the single source of truth for both current and historical pricing. Records bid, ask, mid, last trade, official closing, open, high, low, close, volume, VWAP, and adjusted close (for corporate actions). Stores price source (Bloomberg, Reuters/Refinitiv, exchange feed, broker quote, internal model), price type (market/model/indicative/official), pricing date and time, currency, price basis (clean/dirty for bonds), accrued interest, yield, spread to benchmark, price quality flag, and source system. Prices are never overwritten — corrections are appended with reason codes and supersession flags. Retains the complete historical price archive for all instruments across all time periods. Supports MTM valuation, NAV calculation, portfolio P&L attribution, IFRS 9 fair value measurement, backtesting, VaR historical simulation, performance attribution, regulatory stress testing (CCAR/DFAST), historical trend analysis, and time-series analytics.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`corporate_action` (
    `corporate_action_id` BIGINT COMMENT 'Unique identifier for the corporate action event. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Cash dividend and redemption currency determines entitlement calculations and FX conversion for cross-border corporate actions. Critical for accurate custody accounting and client entitlement processi',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: corporate_action currently stores issuer_lei and issuer_name as denormalized string columns. The security.issuer table is the golden source for issuer master data including lei and legal_name. Adding ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Corporate actions (dividends, mergers, spin-offs) generate mandatory GL journal entries under IFRS/GAAP. Banks must link each corporate action event to its accounting entry for audit trails, financial',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Corporate actions (mergers, dividends, tender offers) trigger mandatory regulatory disclosure obligations under MAR (Market Abuse Regulation) and SEC rules (Form 8-K). Linking corporate_action to obli',
    `instrument_id` BIGINT COMMENT 'Reference to the security instrument affected by this corporate action.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Corporate actions (dividends, mergers) have withholding tax obligations determined by the tax jurisdiction. corporate_action.tax_jurisdiction is a plain text denormalization of the jurisdiction entity',
    `announcement_date` DATE COMMENT 'Date on which the corporate action was officially announced by the issuer or market authority.',
    `cash_rate` DECIMAL(18,2) COMMENT 'Cash amount per share or unit to be distributed as part of the corporate action (e.g., dividend per share).',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether beneficial owners must provide certification (e.g., tax forms, eligibility declarations) to participate.',
    `certification_type` STRING COMMENT 'Type of certification required (e.g., W-8BEN, W-9, beneficial ownership declaration).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate action record was first created in the system.',
    `default_option_code` STRING COMMENT 'Code identifying the default option that will be applied if no election is received from the beneficial owner.',
    `effective_date` DATE COMMENT 'Date on which the corporate action becomes effective and any resulting changes to the security take effect.',
    `election_required_flag` BOOLEAN COMMENT 'Indicates whether beneficial owners must submit an election instruction to participate or receive entitlements.',
    `entitlement_calculation_method` STRING COMMENT 'Method used to calculate beneficial owner entitlements (e.g., based on record date position, average balance, or transaction history).. Valid values are `position_based|transaction_based|average_balance`',
    `event_description` STRING COMMENT 'Detailed narrative description of the corporate action event, including terms, conditions, and instructions for beneficial owners.',
    `event_reference_number` STRING COMMENT 'External reference number assigned by the issuer, agent, or market infrastructure to uniquely identify this corporate action event.',
    `event_status` STRING COMMENT 'Current lifecycle status of the corporate action event. [ENUM-REF-CANDIDATE: announced|confirmed|updated|cancelled|completed|pending_approval|expired — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the corporate action event. Defines the nature of the action affecting the security. [ENUM-REF-CANDIDATE: dividend|stock_split|reverse_split|merger|acquisition|tender_offer|rights_issue|spin_off|redemption|call|conversion|exchange_offer|name_change|delisting|bankruptcy|interest_payment|maturity|coupon_payment — 18 candidates stripped; promote to reference product]',
    `ex_date` DATE COMMENT 'Ex-dividend or ex-entitlement date. The first trading day on which the security trades without the entitlement to participate in the corporate action.',
    `exchange_ratio` DECIMAL(18,2) COMMENT 'Ratio at which the old security is exchanged for the new security in exchange offers, mergers, or conversions.',
    `expiration_date` DATE COMMENT 'Last date on which beneficial owners can submit election instructions for voluntary corporate actions.',
    `fractional_share_treatment` STRING COMMENT 'Method for handling fractional shares resulting from the corporate action.. Valid values are `cash_in_lieu|round_down|round_up|carry_forward`',
    `mandatory_voluntary_indicator` STRING COMMENT 'Indicates whether the corporate action is mandatory for all holders or requires voluntary election by beneficial owners.. Valid values are `mandatory|voluntary|mandatory_with_options`',
    `market_claim_flag` BOOLEAN COMMENT 'Indicates whether market claims are applicable for trades settling after the record date but before the ex-date.',
    `offer_price` DECIMAL(18,2) COMMENT 'Price per share or unit offered in tender offers, buybacks, or rights issues.',
    `offer_price_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the offer price.. Valid values are `^[A-Z]{3}$`',
    `paying_agent_bic` STRING COMMENT 'SWIFT Bank Identifier Code of the paying agent.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `paying_agent_name` STRING COMMENT 'Name of the financial institution acting as paying agent for the distribution of cash or securities.',
    `payment_date` DATE COMMENT 'Date on which cash or securities resulting from the corporate action are distributed to entitled holders.',
    `processing_status` STRING COMMENT 'Internal processing status indicating the stage of corporate action processing within the banks systems.. Valid values are `pending|in_progress|completed|failed|reconciled`',
    `protect_date` DATE COMMENT 'Date by which custodians and intermediaries must submit protect instructions to ensure entitlements are preserved for beneficial owners.',
    `record_date` DATE COMMENT 'Date on which shareholders must be registered on the books to be entitled to participate in the corporate action.',
    `source_event_reference` STRING COMMENT 'Unique identifier assigned to this corporate action event by the source system or data provider.',
    `source_system` STRING COMMENT 'Name of the upstream system or data provider from which the corporate action event was received (e.g., DTCC, Euroclear, Bloomberg).',
    `stock_rate_denominator` DECIMAL(18,2) COMMENT 'Denominator of the stock distribution ratio (e.g., in a 3-for-2 split, this would be 2).',
    `stock_rate_numerator` DECIMAL(18,2) COMMENT 'Numerator of the stock distribution ratio (e.g., in a 3-for-2 split, this would be 3).',
    `updated_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last updated this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate action record was last modified.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Default withholding tax rate applied to cash distributions, expressed as a decimal (e.g., 0.15 for 15%).',
    CONSTRAINT pk_corporate_action PRIMARY KEY(`corporate_action_id`)
) COMMENT 'Master record for corporate action events affecting securities, including event details, voluntary election options, and beneficial owner election responses. Covers dividends, mergers, tender offers, rights issues, and all election processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`classification` (
    `classification_id` BIGINT COMMENT 'Primary key for classification',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to ledger.chart_of_accounts. Business justification: IFRS 9 instrument classification (FVTPL, FVOCI, amortized cost) directly determines which chart of accounts entry governs the instruments accounting treatment. Banks maintain this mapping for automat',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Security classification schemes (FRTB risk buckets, MiFID II product categories, regulatory_classification) are mandated by specific regulatory obligations. Linking classification to the governing obl',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument being classified. Links to the instrument master record containing ISIN, CUSIP, SEDOL identifiers.',
    `asset_class` STRING COMMENT 'High-level asset class categorization for the instrument. Used for risk bucketing, regulatory reporting (EMIR, MiFID II), and portfolio analytics. Aligns with FRTB sensitivities-based approach asset class definitions. [ENUM-REF-CANDIDATE: equity|fixed_income|derivative|fx|commodity|credit|money_market|structured_product|fund|alternative — 10 candidates stripped; promote to reference product]',
    `classification_code` STRING COMMENT 'The specific classification code value within the chosen scheme. For CFI this is a 6-character code (e.g., ESVUFR for equity), for ISDA this is the product type code, for EMIR this is the asset class code, for SFDR this is the sustainability category (Article 6/8/9), for MiFID II this is the product complexity indicator, for FRTB this is the risk bucket identifier.',
    `classification_description` STRING COMMENT 'Human-readable description of the classification code. Provides business-friendly explanation of what the classification represents (e.g., Common Share, Interest Rate Swap, Equity Derivative, Article 8 Fund - Promotes Environmental Characteristics).',
    `classification_level` STRING COMMENT 'Hierarchical level within the classification taxonomy. Level 1 represents the highest level (e.g., asset class), with increasing numbers representing more granular categorization. Supports multi-level taxonomies where instruments are classified at multiple levels of detail.',
    `classification_source` STRING COMMENT 'The authoritative source of this classification. Identifies whether the classification was provided by a vendor (e.g., Bloomberg, Refinitiv), derived internally by the banks reference data team, mandated by a regulatory authority, provided by the exchange, supplied by the issuer, or obtained from a third-party data provider.. Valid values are `vendor|internal|regulatory_authority|exchange|issuer|third_party_data_provider`',
    `classification_status` STRING COMMENT 'Current lifecycle status of the classification record. Active classifications are in use; pending review indicates the classification is under validation; superseded indicates a newer classification has replaced this one; deprecated indicates the classification is no longer valid; under investigation indicates potential data quality issues are being reviewed.. Valid values are `active|pending_review|superseded|deprecated|under_investigation`',
    `complexity_indicator` STRING COMMENT 'MiFID II product complexity classification. Non-complex instruments can be sold without appropriateness assessment; complex instruments require suitability or appropriateness assessment. Critical for investment policy compliance screening and client advisory.. Valid values are `non_complex|complex`',
    `confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00 to 100.00) indicating the reliability or certainty of the classification. Used when classifications are algorithmically derived or when multiple sources provide conflicting classifications. Higher scores indicate greater confidence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this classification record was first created in the system. Supports audit trail and data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality score (0.00 to 100.00) for this classification record. Calculated based on completeness, accuracy, timeliness, and consistency metrics. Used to identify records requiring remediation or enhanced validation.',
    `effective_date` DATE COMMENT 'The date from which this classification becomes effective. Supports temporal classification where an instruments categorization changes over time (e.g., due to regulatory changes, corporate actions, or reclassification events). Format: yyyy-MM-dd.',
    `expiry_date` DATE COMMENT 'The date on which this classification expires or is superseded. Null indicates the classification is currently active with no planned expiry. Enables full classification history tracking for audit and regulatory reporting. Format: yyyy-MM-dd.',
    `frtb_risk_bucket` STRING COMMENT 'FRTB sensitivities-based approach risk bucket assignment. Used for market risk capital calculation under Basel III FRTB framework. Buckets vary by asset class (e.g., interest rate buckets by currency and tenor, equity buckets by sector and market cap, credit buckets by rating and sector).',
    `internal_asset_class` STRING COMMENT 'Internal proprietary asset class hierarchy used for portfolio management, risk reporting, and investment policy compliance. May differ from regulatory classifications to align with the banks internal risk management and business line structure.',
    `internal_product_category` STRING COMMENT 'Internal product categorization for business line reporting, profitability analysis, and operational management. Aligns with the banks line of business (LOB) structure and product governance framework.',
    `is_primary_classification` BOOLEAN COMMENT 'Indicates whether this is the primary or default classification for the instrument within this classification scheme. True when this classification should be used as the authoritative categorization; false for alternative or supplementary classifications.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier that last modified this classification record. Supports audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this classification record was last updated. Tracks the most recent change to any field in the record. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_review_date` DATE COMMENT 'Date when this classification was last reviewed for accuracy and completeness. Supports periodic validation processes required by data governance and regulatory compliance frameworks. Format: yyyy-MM-dd.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this classification. Ensures classifications remain current and accurate. Review frequency may vary by asset class, complexity, and regulatory requirements. Format: yyyy-MM-dd.',
    `override_approval_date` DATE COMMENT 'Date when the classification override was approved. Required when override_indicator is true. Format: yyyy-MM-dd.',
    `override_approved_by` STRING COMMENT 'User ID or name of the authorized person who approved the classification override. Required when override_indicator is true. Supports audit trail and accountability for manual classification decisions.',
    `override_indicator` BOOLEAN COMMENT 'Indicates whether this classification was manually overridden by a reference data analyst or risk manager. True when the classification differs from the system-generated or vendor-provided default. Requires documentation in classification_rationale.',
    `parent_classification_code` STRING COMMENT 'The classification code of the parent category in hierarchical taxonomies. Enables navigation of multi-level classification structures (e.g., Equity as parent of Common Share). Null for top-level classifications.',
    `product_type` STRING COMMENT 'Detailed product type within the asset class. Examples include Interest Rate Swap, Credit Default Swap (CDS), Mortgage-Backed Securities (MBS), Asset-Backed Securities (ABS), Collateralized Loan Obligation (CLO), Collateralized Debt Obligation (CDO), Over-the-Counter (OTC) Option. Supports granular risk and regulatory reporting.',
    `rationale` STRING COMMENT 'Business justification or explanation for the classification assignment. Documents the reasoning, methodology, or criteria used to determine the classification. Particularly important for complex or borderline cases requiring expert judgment.',
    `regulatory_classification` STRING COMMENT 'Classification code required for regulatory reporting purposes. Includes MiFID II product governance classification, EMIR asset class and product type, SFDR sustainability classification (Article 6/8/9), and other jurisdiction-specific regulatory categories.',
    `scheme_code` STRING COMMENT 'The classification framework or taxonomy being applied. Supports CFI (Classification of Financial Instruments ISO 10962), ISDA product taxonomy, ESMA EMIR classification, SFDR (Sustainable Finance Disclosure Regulation) sustainability classification, MiFID II product governance classification, FRTB (Fundamental Review of the Trading Book) sensitivities-based approach, and internal asset class hierarchy. [ENUM-REF-CANDIDATE: CFI|ISDA|EMIR|SFDR|MIFID2|FRTB|INTERNAL — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The specific system or platform that provided this classification (e.g., Bloomberg Terminal, Refinitiv Eikon, Murex, SimCorp Dimension, Internal Reference Data Management System). Supports data lineage and reconciliation.',
    `sustainability_classification` STRING COMMENT 'SFDR sustainability classification for funds and financial products. Article 6 (no sustainability objective), Article 8 (promotes environmental or social characteristics), Article 9 (has sustainable investment as objective). Required for EU regulatory reporting and ESG investment screening.. Valid values are `article_6|article_8|article_9|not_applicable`',
    `version` STRING COMMENT 'Version identifier for the classification scheme or taxonomy being applied. Tracks changes to classification standards over time (e.g., CFI 2021, ISDA Taxonomy v2.0, EMIR RTS 2023). Critical for regulatory reporting and historical analysis.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this classification record. Supports audit trail and accountability.',
    CONSTRAINT pk_classification PRIMARY KEY(`classification_id`)
) COMMENT 'Standardized classification and taxonomy mappings for financial instruments across multiple industry frameworks including CFI (Classification of Financial Instruments ISO 10962), ISDA product taxonomy, ESMA EMIR classification, SFDR sustainability classification, MiFID II product governance classification, and internal asset class hierarchy. Captures classification scheme, classification code, classification description, effective date, expiry date, and the authoritative source. Supports multiple concurrent classification schemes per instrument with full history. Enables regulatory reporting (MiFID II, EMIR, SFDR), risk bucketing (FRTB SA sensitivities-based approach), cross-domain instrument categorization, and investment policy compliance screening.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`identifier` (
    `identifier_id` BIGINT COMMENT 'Primary key for identifier',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Security identifiers (ISIN, CUSIP, SEDOL) are issued by jurisdiction-specific numbering agencies (ANNA members). Operations and data management teams need the issuing jurisdiction FK to validate ident',
    `instrument_id` BIGINT COMMENT 'Foreign key reference to the parent security instrument master record. Links this identifier to the underlying financial instrument.',
    `composite_identifier_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is a composite or concatenated identifier formed from multiple components (e.g., ticker + exchange code). True indicates composite; False indicates atomic identifier.',
    `country_of_issuance` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the identifier was issued or where the issuing authority is domiciled. Examples include USA, GBR, DEU, JPN. Used for regulatory reporting and geographic segmentation.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this identifier record was first created in the system. Supports audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00 to 100.00) representing the assessed quality, completeness, and accuracy of this identifier record. Higher scores indicate higher confidence in the identifier data. Used for data governance and golden source resolution.',
    `effective_date` DATE COMMENT 'Date from which this identifier becomes valid and active for use in trading, reporting, and reconciliation. Supports temporal validity tracking for identifiers that change over the instrument lifecycle due to corporate actions or re-issuance.',
    `exchange_code` STRING COMMENT 'Market Identifier Code (MIC) or exchange code where this identifier is recognized or traded. Examples include XNYS (New York Stock Exchange), XNAS (NASDAQ), XLON (London Stock Exchange). Applicable primarily for ticker symbols and exchange-specific identifiers.',
    `expiry_date` DATE COMMENT 'Date on which this identifier ceases to be valid or is retired. Nullable for identifiers that remain active indefinitely. Used to manage identifier lifecycle and ensure historical accuracy in cross-reference lookups.',
    `identifier_description` STRING COMMENT 'Free-text description or additional context about this identifier. May include notes on usage, special handling instructions, or clarifications on identifier scope and applicability.',
    `identifier_status` STRING COMMENT 'Current lifecycle status of this identifier. Active indicates the identifier is currently valid and in use. Inactive indicates the identifier is no longer valid. Pending indicates the identifier is scheduled for future activation. Retired indicates the identifier has been permanently deactivated. Suspended indicates temporary deactivation.. Valid values are `active|inactive|pending|retired|suspended`',
    `identifier_type` STRING COMMENT 'Type of external identifier. Indicates the classification scheme or issuing authority for this identifier. Common types include ISIN (International Securities Identification Number), CUSIP (Committee on Uniform Securities Identification Procedures), SEDOL (Stock Exchange Daily Official List), FIGI (Financial Instrument Global Identifier), BBGID (Bloomberg ID), RIC (Reuters Instrument Code), Valoren, WKN (Wertpapierkennnummer), CINS (CUSIP International Numbering System), and exchange-specific ticker symbols. [ENUM-REF-CANDIDATE: ISIN|CUSIP|SEDOL|FIGI|BBGID|RIC|Valoren|WKN|CINS|Ticker|IBES|COMMON|RED_CODE — promote to reference product]. Valid values are `ISIN|CUSIP|SEDOL|FIGI|BBGID|RIC`',
    `identifier_value` DECIMAL(18,2) COMMENT 'The actual identifier code or symbol value assigned by the issuing authority. For example, US0378331005 for ISIN, 037833100 for CUSIP, 2046251 for SEDOL, BBG000BLNNH6 for FIGI. This is the golden source lookup key for cross-system instrument resolution.',
    `is_primary` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is the primary or preferred identifier for the instrument within its type category. Used to prioritize identifiers when multiple identifiers of the same type exist. True indicates this is the primary identifier; False indicates secondary or alternate.',
    `issuing_authority` STRING COMMENT 'Name of the organization or agency that issued or maintains this identifier. Examples include CUSIP Global Services, London Stock Exchange (for SEDOL), Bloomberg LP (for FIGI/BBGID), Refinitiv (for RIC), SIX Financial Information (for Valoren), WM Datenservice (for WKN), or specific exchange names for ticker symbols.',
    `last_modified_by` STRING COMMENT 'User ID or system process name that last modified this identifier record. Used for audit and accountability purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this identifier record was last updated or modified. Supports change tracking and audit trail.',
    `last_verified_date` DATE COMMENT 'Date on which this identifier was last verified or validated against the issuing authority or external data vendor. Used to track data freshness and trigger re-verification workflows.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this identifier is required or used for regulatory reporting purposes (e.g., MiFID II transaction reporting, EMIR trade reporting, CFTC reporting). True indicates the identifier is used in regulatory filings; False indicates internal or vendor use only.',
    `source_system` STRING COMMENT 'Name of the upstream system or data vendor from which this identifier was sourced. Examples include Murex, Calypso, Bloomberg, Refinitiv, AxiomSL, or internal reference data management systems. Critical for data lineage and reconciliation.',
    `source_system_identifier` STRING COMMENT 'The unique identifier or record key for this identifier within the source system. Used for traceability and reconciliation back to the originating system of record.',
    `verification_source` STRING COMMENT 'Name of the system, vendor, or process that last verified this identifier. Examples include Bloomberg Data License, Refinitiv DataScope, manual review by reference data team, or automated reconciliation process.',
    `created_by` STRING COMMENT 'User ID or system process name that created this identifier record. Used for audit and accountability purposes.',
    CONSTRAINT pk_identifier PRIMARY KEY(`identifier_id`)
) COMMENT 'Comprehensive cross-reference table mapping all known external identifiers for each instrument including ISIN, CUSIP, SEDOL, FIGI (Financial Instrument Global Identifier), Bloomberg ID (BBGID), Reuters RIC, Valoren, WKN, CINS, and exchange-specific ticker symbols. Captures identifier type, identifier value, issuing authority, effective date, expiry date, and primary flag. Enables instrument lookup and reconciliation across trading systems (Murex/Calypso), data vendors (Bloomberg/Refinitiv), and regulatory reporting platforms (AxiomSL). Critical for golden source instrument resolution.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`listing` (
    `listing_id` BIGINT COMMENT 'Unique identifier for the exchange listing record.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Exchange listings have trading hours and settlement cycles governed by the exchanges holiday calendar. Operations and trading systems need this FK to determine valid trading days, calculate settlemen',
    `instrument_id` BIGINT COMMENT 'Reference to the underlying security or financial instrument being listed.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Exchange listings are subject to jurisdiction-specific securities regulations (prospectus requirements, short-selling rules, MiFID II liquidity classification). Compliance and trading teams need the l',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trading currency determines order entry and execution pricing. Distinct from settlement currency for dual-listed securities. Essential for FX risk management and multi-currency trading desk operations',
    `circuit_breaker_threshold_pct` DECIMAL(18,2) COMMENT 'Price movement threshold percentage that triggers automatic trading halt or circuit breaker for this listing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this listing record was first created in the system.',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active version of the listing record in a slowly changing dimension (SCD) Type 2 history.',
    `delisting_date` DATE COMMENT 'Date when the security was delisted or removed from trading on this exchange. Null if currently listed.',
    `effective_from_timestamp` TIMESTAMP COMMENT 'Timestamp from which this version of the listing record is effective, supporting slowly changing dimension (SCD) Type 2 historization.',
    `effective_to_timestamp` TIMESTAMP COMMENT 'Timestamp until which this version of the listing record is effective. Null indicates current active record.',
    `exchange_ticker_symbol` STRING COMMENT 'Exchange-specific ticker or trading symbol used to identify the security on this particular exchange.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Annual or one-time fee charged by the exchange for maintaining this listing, in the listing currency.',
    `isin_code` STRING COMMENT 'ISO 6166 twelve-character alphanumeric code uniquely identifying the security globally. Included here for denormalized reference and regulatory reporting convenience.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `last_trading_date` DATE COMMENT 'Final date on which the security can be traded on this exchange before expiry or delisting. Applicable primarily to derivatives and structured products.',
    `listing_date` DATE COMMENT 'Date when the security was first listed and became available for trading on this exchange.',
    `listing_status` STRING COMMENT 'Current trading status of the listing on the exchange. Active indicates normal trading; suspended indicates temporary halt due to regulatory or corporate action; halted indicates intraday trading pause; delisted indicates removed from exchange; pending indicates listing application in progress.. Valid values are `active|suspended|halted|delisted|pending`',
    `listing_type` STRING COMMENT 'Classification of the listing relationship. Primary indicates home exchange; secondary indicates additional listing; dual indicates simultaneous primary listing on multiple exchanges; ADR indicates American Depositary Receipt; GDR indicates Global Depositary Receipt.. Valid values are `primary|secondary|dual|adr|gdr`',
    `local_instrument_code` STRING COMMENT 'Exchange-specific instrument identifier or code assigned by the listing exchange for internal reference and order routing.',
    `lot_size` DECIMAL(18,2) COMMENT 'Minimum trading unit or board lot size for this listing. Orders must be in multiples of this quantity.',
    `market_data_subscription_tier` STRING COMMENT 'Exchange-defined tier or package level for market data distribution rights for this listing (e.g., Level 1, Level 2, Premium).',
    `market_maker_required_flag` BOOLEAN COMMENT 'Indicates whether designated market makers or liquidity providers are required for this listing under exchange rules.',
    `mifid_liquid_flag` BOOLEAN COMMENT 'Indicates whether this listing is classified as a liquid instrument under MiFID II transparency and best execution requirements.',
    `price_band_lower_pct` DECIMAL(18,2) COMMENT 'Lower limit percentage for intraday price movement relative to reference price, beyond which orders are rejected or trading is paused.',
    `price_band_upper_pct` DECIMAL(18,2) COMMENT 'Upper limit percentage for intraday price movement relative to reference price, beyond which orders are rejected or trading is paused.',
    `price_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to quoted price to calculate actual contract or notional value. Commonly used for derivatives and structured products.',
    `primary_listing_flag` BOOLEAN COMMENT 'Indicates whether this is the primary or home exchange listing for the security. True for primary listing; false for secondary or cross-listings.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether trades in this listing must be reported to regulatory authorities under MiFIR, EMIR, or equivalent transaction reporting regimes.',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which trades are settled for this listing. May differ from trading currency for certain cross-listed instruments.. Valid values are `^[A-Z]{3}$`',
    `settlement_cycle_days` STRING COMMENT 'Number of business days after trade date (T+N) for standard settlement of trades in this listing. Common values are T+1 or T+2.',
    `short_selling_allowed_flag` BOOLEAN COMMENT 'Indicates whether short selling is permitted for this listing under current exchange and regulatory rules.',
    `sponsor` STRING COMMENT 'Name of the financial institution or broker-dealer sponsoring or facilitating the listing on this exchange.',
    `tick_size` DECIMAL(18,2) COMMENT 'Minimum price increment or tick size for this listing. Prices must move in multiples of this value.',
    `trading_hours_end` STRING COMMENT 'Local exchange time when regular trading session ends for this listing, in HH:MM format.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `trading_hours_start` STRING COMMENT 'Local exchange time when regular trading session begins for this listing, in HH:MM format.. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `trading_phase` STRING COMMENT 'Current intraday trading phase or session state for this listing on the exchange.. Valid values are `pre_open|continuous|closing_auction|post_close|closed`',
    `trading_timezone` STRING COMMENT 'IANA timezone identifier for the exchange trading hours (e.g., America/New_York, Europe/London, Asia/Tokyo).',
    `trading_venue_type` STRING COMMENT 'Classification of the trading venue under MiFID II. Regulated Market indicates traditional exchange; MTF indicates Multilateral Trading Facility; OTF indicates Organised Trading Facility; Systematic Internaliser indicates bank internal crossing.. Valid values are `regulated_market|mtf|otf|systematic_internaliser`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this listing record was last modified.',
    CONSTRAINT pk_listing PRIMARY KEY(`listing_id`)
) COMMENT 'Exchange listing records for securities capturing where and how each instrument is listed and traded across global exchanges. Stores exchange MIC code (ISO 10383), listing date, delisting date, trading currency, lot size, tick size, trading hours, trading status (active/suspended/halted/delisted), primary listing flag, and exchange-specific instrument code. A single instrument may have multiple listings across different exchanges (e.g., dual-listed equities, cross-listed ADRs). Supports order routing, best execution analysis (MiFID II RTS 27/28), market data subscription management, and regulatory transaction reporting (MiFIR).';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`benchmark` (
    `benchmark_id` BIGINT COMMENT 'Unique identifier for the benchmark or reference rate. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Rate benchmarks are currency-specific (SOFR=USD, SONIA=GBP, ESTR=EUR). Essential for derivative pricing, floating rate note valuation, and IBOR transition fallback calculations under ISDA protocols.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: Benchmarks (LIBOR, SOFR, EURIBOR) are fundamental risk factors for interest rate sensitivity measurement. VaR models require benchmark shocks for DV01/CS01 calculation. Critical for FRTB sensitivities',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Many financial benchmarks are themselves tradeable instruments with ISINs (e.g., S&P 500 index ETFs, government bond indices). The benchmark table carries isin, bloomberg_ticker, and reuters_ric — ide',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Benchmarks are regulated under jurisdiction-specific frameworks (EU Benchmarks Regulation, UK BMR). benchmark has iosco_compliant_flag and regulatory_status but no jurisdiction FK. Risk and compliance',
    `administrator_lei` STRING COMMENT 'ISO 17442 Legal Entity Identifier of the benchmark administrator.. Valid values are `^[A-Z0-9]{20}$`',
    `administrator_name` STRING COMMENT 'Name of the organization responsible for administering and publishing the benchmark (e.g., Federal Reserve Bank of New York, ICE Benchmark Administration, S&P Dow Jones Indices).',
    `benchmark_code` STRING COMMENT 'Short code or ticker symbol for the benchmark (e.g., SOFR, EURIBOR, SONIA, SPXT, MXWO).',
    `benchmark_name` STRING COMMENT 'Full official name of the benchmark or reference rate (e.g., Secured Overnight Financing Rate, Euro Interbank Offered Rate, S&P 500 Index).',
    `benchmark_status` STRING COMMENT 'Current lifecycle status of the benchmark (active, legacy, discontinued, suspended).. Valid values are `active|legacy|discontinued|suspended`',
    `benchmark_type` STRING COMMENT 'Classification of the benchmark by asset class or purpose (interest rate, equity index, credit spread index, commodity index, foreign exchange rate, yield curve, volatility index). [ENUM-REF-CANDIDATE: interest_rate|equity_index|credit_spread_index|commodity_index|fx_rate|yield_curve|volatility_index — 7 candidates stripped; promote to reference product]',
    `bloomberg_ticker` STRING COMMENT 'Bloomberg ticker symbol for the benchmark (e.g., SOFRRATE Index, SPX Index).',
    `calculation_methodology` STRING COMMENT 'Method used to calculate the benchmark value (transaction-based, quote-based, committed quote, model-based, market capitalization weighted, price weighted, equal weighted). [ENUM-REF-CANDIDATE: transaction_based|quote_based|committed_quote|model_based|market_cap_weighted|price_weighted|equal_weighted — 7 candidates stripped; promote to reference product]',
    `compounding_method` STRING COMMENT 'Method of compounding for rate calculations (simple, compound, continuous). Applicable to interest rate benchmarks.. Valid values are `simple|compound|continuous`',
    `constituent_count` STRING COMMENT 'Number of constituent instruments or securities included in the index. Applicable to equity and credit indices.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark record was first created in the system.',
    `data_source` STRING COMMENT 'Primary source of underlying data used to calculate the benchmark (e.g., Federal Reserve, ICE, Bloomberg, Markit).',
    `day_count_convention` STRING COMMENT 'Day count convention used for interest accrual calculations (Actual/360, Actual/365, 30/360, Actual/Actual). Applicable to interest rate benchmarks.. Valid values are `actual_360|actual_365|30_360|actual_actual`',
    `discontinuation_date` DATE COMMENT 'Date when the benchmark was or will be discontinued. Null if still active.',
    `geographic_coverage` STRING COMMENT 'Geographic scope of the benchmark or index (e.g., USA, Europe, Global, Emerging Markets). Pipe-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `inception_date` DATE COMMENT 'Date when the benchmark or index was first established and began publication.',
    `index_base_date` DATE COMMENT 'Date on which the index base value was established. Applicable to equity and credit indices.',
    `index_base_value` DECIMAL(18,2) COMMENT 'Base or starting value of the index at inception. Applicable to equity and credit indices.',
    `iosco_compliant_flag` BOOLEAN COMMENT 'Indicates whether the benchmark complies with IOSCO Principles for Financial Benchmarks.',
    `isin` STRING COMMENT 'ISO 6166 ISIN code for the benchmark if it is tradable or has an associated instrument (e.g., index futures, ETFs tracking the benchmark).. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `methodology_document_url` STRING COMMENT 'URL to the official methodology document describing the benchmark calculation and governance.',
    `publication_frequency` STRING COMMENT 'Frequency at which the benchmark rate or index value is published (daily, weekly, monthly, quarterly, real-time, intraday).. Valid values are `daily|weekly|monthly|quarterly|real_time|intraday`',
    `publication_time` TIMESTAMP COMMENT 'Standard time of day when the benchmark is published (e.g., 08:00 EST, 11:00 GMT). Format: HH:MM timezone.',
    `rebalancing_frequency` STRING COMMENT 'Frequency at which the index constituents or weights are rebalanced (daily, monthly, quarterly, semi-annual, annual, event-driven). Applicable to indices.. Valid values are `daily|monthly|quarterly|semi_annual|annual|event_driven`',
    `regulatory_status` STRING COMMENT 'Current regulatory standing of the benchmark (authorized, registered, recognized, legacy, discontinued).. Valid values are `authorized|registered|recognized|legacy|discontinued`',
    `reuters_ric` STRING COMMENT 'Reuters Instrument Code for the benchmark.',
    `sector_coverage` STRING COMMENT 'Industry sectors covered by the benchmark or index (e.g., Technology, Financials, Healthcare, Broad Market). Applicable to equity and credit indices.',
    `spread_adjustment_bps` DECIMAL(18,2) COMMENT 'Fixed spread adjustment in basis points to be added when transitioning to the fallback benchmark (e.g., LIBOR to SOFR transition spread).',
    `tenor` STRING COMMENT 'Maturity or time period for interest rate benchmarks (e.g., overnight, 1M, 3M, 6M, 12M). Null for indices without tenor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this benchmark record was last updated in the system.',
    `usage_restriction` STRING COMMENT 'Any restrictions or licensing requirements for using the benchmark in financial contracts or products.',
    `website_url` STRING COMMENT 'Official website URL of the benchmark administrator where methodology and rates are published.',
    `weighting_scheme` STRING COMMENT 'Method used to weight constituents in the index (market capitalization, free-float adjusted, price, equal, fundamental, risk parity). Applicable to indices.. Valid values are `market_cap|free_float|price|equal|fundamental|risk_parity`',
    CONSTRAINT pk_benchmark PRIMARY KEY(`benchmark_id`)
) COMMENT 'Master data for financial benchmarks, reference rates, and market indices with embedded daily rate observations and index constituent membership records. Covers SOFR, EURIBOR, SONIA, Fed Funds Rate, LIBOR (legacy), Treasury yield curves, credit spread indices (CDX, iTraxx), and equity indices (S&P 500, MSCI World, Bloomberg Barclays Aggregate). Captures benchmark name, administrator, IOSCO compliance status, publication frequency, currency, tenor, fallback rate provisions (LIBOR transition), and regulatory status. Includes daily published rate observations by tenor (overnight, 1M, 3M, 6M, 12M) with compounded rates, spread adjustments (for LIBOR-SOFR transition), and publication source. For indices, records constituent instruments with inclusion/exclusion dates, weights (market cap, par), rebalancing frequency, and rebalancing events. Supports floating rate coupon resets, swap valuation, FTP curve construction, passive portfolio management, index tracking, ETF basket construction, benchmark attribution, and ALM interest rate risk modeling.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`yield_curve` (
    `yield_curve_id` BIGINT COMMENT 'Unique identifier for the yield curve record. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Yield curves are often constructed from or anchored to benchmark rates (e.g., SOFR curve, Treasury curve). The existing benchmark_index (STRING) should be replaced with a proper FK to the benchmark pr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every yield curve is currency-specific for discounting and valuation. Essential for derivative pricing, bond valuation, and FRTB sensitivities calculation. Curves cannot exist without currency context',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Yield curve construction requires business day adjustments for accurate date math in pricing models. Essential for forward rate calculations, accrual period determination, and derivative cash flow sch',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Yield curves are constructed for specific regulatory jurisdictions (ECB EUR curve, Fed USD curve) and used in jurisdiction-specific capital calculations. yield_curve has regulatory_framework as plain ',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Yield curves are constructed from rate benchmark fixings (SOFR OIS curve, EURIBOR curve). yield_curve already links to security.benchmark (market index) but not to reference.rate_benchmark (the author',
    `approval_status` STRING COMMENT 'Workflow approval state for the curve. Approved curves are authorized for use in production valuation and risk systems.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the curve was approved for production use. Supports audit and compliance reporting.',
    `approved_by` STRING COMMENT 'User ID or name of the market risk officer or quant who approved the curve for production use.',
    `collateralization_type` STRING COMMENT 'Collateral arrangement assumed for derivative discounting (e.g., OIS-collateralized for CSA trades, uncollateralized for legacy trades).. Valid values are `uncollateralized|cash_collateralized|ois_collateralized`',
    `comments` STRING COMMENT 'Free-text notes or remarks about the curve construction, data quality issues, or special adjustments applied by the curve builder.',
    `construction_date` DATE COMMENT 'The business date on which the yield curve was constructed. Represents the valuation date for the curve snapshot.',
    `construction_methodology` STRING COMMENT 'Mathematical method used to construct the yield curve from market instrument prices (e.g., bootstrapping, Nelson-Siegel, cubic spline interpolation).. Valid values are `bootstrapping|nelson_siegel|cubic_spline|linear|piecewise_linear|hermite`',
    `construction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the yield curve was constructed or last recalculated, supporting intraday curve updates and audit trails.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the yield curve record was first created in the system. Supports data lineage and audit trails.',
    `credit_rating` STRING COMMENT 'Credit quality classification for credit spread curves (e.g., AAA, AA, A, BBB). Not applicable for government or risk-free curves.',
    `curve_name` STRING COMMENT 'Business name or label for the yield curve (e.g., USD SOFR Swap Curve, EUR Government Curve, USD Corporate AA Spread Curve).',
    `curve_nodes_json` STRING COMMENT 'JSON-serialized array of tenor-rate nodes defining the complete curve shape. Each node includes tenor label, tenor in days, zero rate, par rate, forward rate, discount factor, and interpolation method. Supports full curve reconstruction for valuation and risk analytics.',
    `curve_shift_scenario` STRING COMMENT 'Name of the stress or shock scenario applied to the curve (e.g., +100 bps parallel shift, CCAR Severely Adverse). Null for base case curves.',
    `curve_status` STRING COMMENT 'Current lifecycle status of the yield curve. Active curves are used for valuation; superseded curves are retained for historical analysis.. Valid values are `active|superseded|draft|archived`',
    `curve_type` STRING COMMENT 'Classification of the yield curve by underlying instrument or market segment. Determines the curves application in valuation and risk measurement. [ENUM-REF-CANDIDATE: government|swap|credit_spread|ois|corporate|treasury|libor|sofr|euribor — 9 candidates stripped; promote to reference product]',
    `curve_version` STRING COMMENT 'Version number for the curve construction on a given date. Supports intraday curve revisions and audit trails.',
    `day_count_convention` STRING COMMENT 'Day count basis used for calculating accrued interest and discount factors (e.g., ACT/360, ACT/365, 30/360). Aligns with market conventions for the curves instrument class.. Valid values are `act_360|act_365|30_360|act_act|30e_360`',
    `effective_date` DATE COMMENT 'Date from which the curve is valid for valuation purposes. Typically aligns with construction_date but may differ for forward-starting curves.',
    `expiration_date` DATE COMMENT 'Date after which the curve is no longer valid for valuation. Null for curves that remain active until superseded.',
    `interpolation_method` STRING COMMENT 'Technique applied to interpolate rates between observed tenor nodes on the curve. Critical for pricing instruments with non-standard maturities.. Valid values are `linear|cubic_spline|log_linear|hermite|flat_forward`',
    `is_risk_free` BOOLEAN COMMENT 'Flag indicating whether the curve represents a risk-free rate (e.g., government or OIS curve). True for risk-free curves, false for credit or spread curves.',
    `longest_tenor_days` STRING COMMENT 'Tenor in days of the longest maturity node on the curve (e.g., 10950 for 30 years). Defines the curves maximum extrapolation horizon.',
    `market_data_source` STRING COMMENT 'Vendor or exchange providing the underlying market instrument prices used to construct the curve (e.g., Bloomberg, Refinitiv, ICE, CME).',
    `regulatory_framework` STRING COMMENT 'Regulatory standard or stress scenario applied to the curve (e.g., CCAR Severely Adverse, DFAST, IFRS 9 Stage 2). Applicable for regulatory reporting curves.',
    `sector` STRING COMMENT 'Industry sector for corporate or credit spread curves (e.g., financials, industrials, utilities). Supports sector-specific risk analysis.',
    `shortest_tenor_days` STRING COMMENT 'Tenor in days of the shortest maturity node on the curve (e.g., 1 for overnight, 30 for 1-month).',
    `source_system` STRING COMMENT 'Name of the trading or risk management system that constructed the curve (e.g., Murex, Calypso, Bloomberg, internal curve engine).',
    `tenor_count` STRING COMMENT 'Number of tenor nodes (pillars) defining the curve shape. Typical curves have 8-15 nodes spanning overnight to 30 years.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the yield curve record was last modified. Tracks changes to curve metadata or node data.',
    `valuation_purpose` STRING COMMENT 'Primary business use case for the curve (e.g., trading book mark-to-market, IFRS 9 ECL discounting, FTP curve, regulatory stress testing).. Valid values are `trading|accounting|regulatory|risk_management|ftp`',
    CONSTRAINT pk_yield_curve PRIMARY KEY(`yield_curve_id`)
) COMMENT 'Constructed yield curves and their constituent tenor-rate nodes used for instrument valuation, discounting, and risk measurement. Captures curve name, curve type (government, swap, credit spread, OIS), base currency, construction date, construction methodology (bootstrapping, interpolation method), and the complete set of tenor-rate nodes defining the curve shape. Each embedded node includes tenor label (1M, 3M, 6M, 1Y, 2Y, 5Y, 10Y, 30Y), tenor in days, zero rate, par rate, forward rate, discount factor, and interpolation method applied between nodes. Supports bond pricing, derivative valuation (IRS, CDS), FTP curve construction, IFRS 9 ECL discount rate determination, DV01 sensitivity by tenor bucket, key rate duration analysis, and regulatory stress scenario application across the full term structure.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`credit_rating` (
    `credit_rating_id` BIGINT COMMENT 'Primary key for credit_rating',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: External agency ratings (S&P, Moodys, Fitch) feed internal counterparty rating models for PD calibration and validation. IRB models use external ratings as benchmarking input. Required for model risk',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument being rated.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Credit ratings are assigned to both instruments (already linked via credit_rating.instrument_id → instrument) and to issuers directly (e.g., Moodys rates Apple Inc. as an entity, not just its bonds).',
    `party_id` BIGINT COMMENT 'Reference to the issuer entity whose creditworthiness is being assessed.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Credit ratings used in regulatory capital calculations are governed by CRA Regulation and Basel III/CRR obligations (credit quality step mapping). credit_rating.regulatory_capital_treatment and regula',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: IFRS 9 and CCAR/DFAST require scenario-conditioned credit ratings (stressed PD/LGD under adverse/severely adverse scenarios). A credit rating record produced under a specific stress scenario must refe',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Stressed credit ratings are produced as outputs of specific stress test runs (CCAR, DFAST, EBA stress tests). Linking credit_rating to stress_test_run enables traceability of which run generated a str',
    `basel_credit_quality_step` STRING COMMENT 'Credit quality step (1-6) under Basel III mapping framework for regulatory capital calculation.',
    `basel_risk_weight_pct` DECIMAL(18,2) COMMENT 'Risk weight percentage assigned under Basel III Standardized Approach for Risk-Weighted Assets (RWA) calculation.',
    `cecl_risk_category` STRING COMMENT 'Risk category under US GAAP CECL framework for expected credit loss estimation.. Valid values are `pass|special_mention|substandard|doubtful|loss`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit rating record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the rating data based on whether it is publicly available or proprietary/confidential.. Valid values are `public|internal|confidential`',
    `default_flag` BOOLEAN COMMENT 'Indicates whether the rating represents a default status (D, SD, or equivalent).',
    `effective_date` DATE COMMENT 'Date from which the rating becomes effective for regulatory and risk management purposes.',
    `expiration_date` DATE COMMENT 'Date when the rating expires or is scheduled for review. Null if no expiration.',
    `ifrs9_stage` STRING COMMENT 'IFRS 9 impairment stage classification based on credit rating: Stage 1 (performing), Stage 2 (significant increase in credit risk), Stage 3 (credit-impaired).. Valid values are `stage_1|stage_2|stage_3|not_applicable`',
    `internal_override_flag` BOOLEAN COMMENT 'Indicates whether the bank has applied an internal override to the external rating for risk management purposes.',
    `internal_override_reason` STRING COMMENT 'Explanation for why an internal override was applied to the external rating.',
    `investment_grade_flag` BOOLEAN COMMENT 'Indicates whether the rating qualifies as investment grade (BBB-/Baa3 or higher) versus speculative/high-yield.',
    `long_term_rating` STRING COMMENT 'Long-term credit rating assigned (e.g., AAA, Aaa, AA+, BBB-, Ba1, CCC). Format varies by agency.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the rating.',
    `previous_rating` STRING COMMENT 'The rating that was in effect immediately prior to the current rating action. Used for tracking rating migration.',
    `probability_of_default_pct` DECIMAL(18,2) COMMENT 'Estimated probability of default associated with this rating, expressed as a percentage. Used for Expected Credit Loss (ECL) calculation under IFRS 9 and Current Expected Credit Losses (CECL).',
    `public_rating_flag` BOOLEAN COMMENT 'Indicates whether the rating is publicly disclosed or private/confidential.',
    `rated_entity_type` STRING COMMENT 'Type of entity being rated: instrument-level rating or issuer-level rating.. Valid values are `instrument|issuer|counterparty|sovereign|structured_product|fund`',
    `rating_action_type` STRING COMMENT 'Type of rating action: initial assignment, upgrade, downgrade, affirmation, withdrawal, or review status. [ENUM-REF-CANDIDATE: initial|upgrade|downgrade|affirmed|withdrawn|suspended|under_review — 7 candidates stripped; promote to reference product]',
    `rating_agency_code` STRING COMMENT 'Code identifying the rating agency that assigned the rating (Moodys, S&P, Fitch, DBRS, Kroll, or internal model). [ENUM-REF-CANDIDATE: MOODYS|SP|FITCH|DBRS|KROLL|AM_BEST|JCR|INTERNAL — 8 candidates stripped; promote to reference product]',
    `rating_agency_name` STRING COMMENT 'Full legal name of the rating agency.',
    `rating_change_reason` STRING COMMENT 'Brief description of the primary reason for rating change (e.g., deteriorating financial performance, improved liquidity, sector outlook change).',
    `rating_date` DATE COMMENT 'Date the rating was assigned or last updated by the rating agency.',
    `rating_identifier` STRING COMMENT 'External identifier or reference number assigned by the rating agency to this specific rating.',
    `rating_methodology` STRING COMMENT 'Name or reference to the specific rating methodology applied by the agency (e.g., Corporate Rating Methodology, Structured Finance Methodology).',
    `rating_notch` STRING COMMENT 'Numeric representation of the rating on a standardized scale for quantitative analysis and comparison across agencies.',
    `rating_outlook` STRING COMMENT 'Forward-looking assessment of potential rating direction: positive, stable, negative, watch, or developing. [ENUM-REF-CANDIDATE: positive|stable|negative|developing|watch_positive|watch_negative|not_applicable — 7 candidates stripped; promote to reference product]',
    `rating_rationale` STRING COMMENT 'Summary of the key factors and rationale provided by the rating agency for the assigned rating.',
    `rating_scale_type` STRING COMMENT 'Type of rating scale used (long-term, short-term, fund rating, insurance financial strength, etc.).. Valid values are `long_term|short_term|fund|insurance_financial_strength|bank_financial_strength|sovereign`',
    `rating_source_system` STRING COMMENT 'Source system or data feed from which the rating was obtained (e.g., Bloomberg, Reuters, direct agency feed, internal model).',
    `rating_status` STRING COMMENT 'Current lifecycle status of the rating record.. Valid values are `active|withdrawn|suspended|expired|under_review`',
    `regulatory_capital_treatment` STRING COMMENT 'Description of how this rating affects regulatory capital requirements under applicable frameworks (Basel III, Dodd-Frank, etc.).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this rating is used for regulatory reporting purposes (Basel III, Comprehensive Capital Analysis and Review (CCAR), Dodd-Frank Act Stress Testing (DFAST), etc.).',
    `review_date` DATE COMMENT 'Date of the most recent periodic review of the rating by the agency.',
    `short_term_rating` STRING COMMENT 'Short-term credit rating assigned (e.g., A-1+, P-1, F1, R-1H). Format varies by agency.',
    `solicited_flag` BOOLEAN COMMENT 'Indicates whether the rating was solicited (requested by issuer) or unsolicited (assigned independently by agency).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit rating record was last modified.',
    `watch_list_flag` BOOLEAN COMMENT 'Indicates whether the rating is currently on a watch list for potential upgrade or downgrade.',
    CONSTRAINT pk_credit_rating PRIMARY KEY(`credit_rating_id`)
) COMMENT 'Credit rating records assigned to instruments and issuers by external rating agencies (Moodys, S&P, Fitch, DBRS, Kroll) and internal credit assessment models. Captures rated entity type (instrument or issuer), rating agency, rating scale, long-term rating, short-term rating, outlook (positive/stable/negative/watch), rating action type (initial/upgrade/downgrade/affirm/withdraw), rating date, effective date, and regulatory mapping (Basel III standardized approach risk weight bucket). Supports RWA calculation, ECL staging (IFRS 9/CECL), and investment policy compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_underlying_instrument_id` FOREIGN KEY (`underlying_instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_parent_issuer_id` FOREIGN KEY (`parent_issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_primary_ultimate_parent_issuer_id` FOREIGN KEY (`primary_ultimate_parent_issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_superseded_by_price_id` FOREIGN KEY (`superseded_by_price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`classification` ADD CONSTRAINT `fk_security_classification_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`identifier` ADD CONSTRAINT `fk_security_identifier_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`benchmark` ADD CONSTRAINT `fk_security_benchmark_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`security` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`security` SET TAGS ('dbx_domain' = 'security');
ALTER TABLE `banking_ecm`.`security`.`instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`instrument` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuance Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `issuer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `underlying_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `bloomberg_ticker` SET TAGS ('dbx_business_glossary_term' = 'Bloomberg Ticker Symbol');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `cfi_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Financial Instruments (CFI) Code');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `cfi_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `convertible_flag` SET TAGS ('dbx_business_glossary_term' = 'Convertible Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `country_of_risk` SET TAGS ('dbx_business_glossary_term' = 'Country of Risk');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `country_of_risk` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_business_glossary_term' = 'Coupon Frequency');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|zero_coupon');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[0-9A-Z]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = '30_360|actual_360|actual_365|actual_actual');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Market Identifier Code (MIC)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `exchange_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `exercise_style` SET TAGS ('dbx_business_glossary_term' = 'Exercise Style');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `exercise_style` SET TAGS ('dbx_value_regex' = 'american|european|bermudan');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `figi` SET TAGS ('dbx_business_glossary_term' = 'Financial Instrument Global Identifier (FIGI)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `figi` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `first_coupon_date` SET TAGS ('dbx_business_glossary_term' = 'First Coupon Date');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'call|put');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `puttable_flag` SET TAGS ('dbx_business_glossary_term' = 'Puttable Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `reuters_ric` SET TAGS ('dbx_business_glossary_term' = 'Reuters Instrument Code (RIC)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `seniority` SET TAGS ('dbx_business_glossary_term' = 'Seniority');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `seniority` SET TAGS ('dbx_value_regex' = 'senior_secured|senior_unsecured|subordinated|junior');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `settlement_convention` SET TAGS ('dbx_business_glossary_term' = 'Settlement Convention');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `settlement_convention` SET TAGS ('dbx_value_regex' = 'T+0|T+1|T+2|T+3');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Short Name');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `sub_asset_class` SET TAGS ('dbx_business_glossary_term' = 'Sub-Asset Class');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `trading_currency` SET TAGS ('dbx_business_glossary_term' = 'Trading Currency');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `trading_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`equity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`equity` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_id` SET TAGS ('dbx_business_glossary_term' = 'Equity Identifier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Entity Identifier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Par Value Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `adr_ratio` SET TAGS ('dbx_business_glossary_term' = 'American Depositary Receipt (ADR) Ratio');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Security Flag');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `convertible_flag` SET TAGS ('dbx_business_glossary_term' = 'Convertible Security Flag');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `cumulative_dividend_flag` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Dividend Flag');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[A-Z0-9]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `delisting_date` SET TAGS ('dbx_business_glossary_term' = 'Delisting Date');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `depositary_bank` SET TAGS ('dbx_business_glossary_term' = 'Depositary Bank Name');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `dividend_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Dividend Eligibility Flag');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `dividend_frequency` SET TAGS ('dbx_business_glossary_term' = 'Dividend Payment Frequency');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `dividend_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|irregular|none');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `dividend_rate` SET TAGS ('dbx_business_glossary_term' = 'Dividend Rate');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_name` SET TAGS ('dbx_business_glossary_term' = 'Equity Security Name');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_status` SET TAGS ('dbx_business_glossary_term' = 'Equity Lifecycle Status');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_status` SET TAGS ('dbx_value_regex' = 'active|suspended|delisted|matured|defaulted|cancelled');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_type` SET TAGS ('dbx_business_glossary_term' = 'Equity Instrument Type');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_type` SET TAGS ('dbx_value_regex' = 'common_stock|preferred_stock|adr|gdr|etf|reit');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `float_shares` SET TAGS ('dbx_business_glossary_term' = 'Float Shares');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_industry_code` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Industry Code');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_industry_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_industry_group_code` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Industry Group Code');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_industry_group_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Sector Code');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_sub_industry_code` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Sub-Industry Code');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `gics_sub_industry_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `index_membership` SET TAGS ('dbx_business_glossary_term' = 'Index Membership List');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `listing_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Date');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `market_cap_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Capitalization Tier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `market_cap_tier` SET TAGS ('dbx_value_regex' = 'mega_cap|large_cap|mid_cap|small_cap|micro_cap|nano_cap');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `par_value` SET TAGS ('dbx_business_glossary_term' = 'Par Value');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `participating_flag` SET TAGS ('dbx_business_glossary_term' = 'Participating Preferred Flag');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `primary_exchange` SET TAGS ('dbx_business_glossary_term' = 'Primary Listing Exchange');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `puttable_flag` SET TAGS ('dbx_business_glossary_term' = 'Puttable Security Flag');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL)');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9BCDFGHJKLMNPQRSTVWXYZ]{7}$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `share_class` SET TAGS ('dbx_business_glossary_term' = 'Share Class');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `shares_authorized` SET TAGS ('dbx_business_glossary_term' = 'Shares Authorized');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `shares_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Shares Outstanding');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Ticker Symbol');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `trading_status` SET TAGS ('dbx_business_glossary_term' = 'Trading Status');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `trading_status` SET TAGS ('dbx_value_regex' = 'normal|halted|suspended|pre_open|post_close|auction');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `underlying_security_isin` SET TAGS ('dbx_business_glossary_term' = 'Underlying Security ISIN');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `underlying_security_isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `voting_rights` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Classification');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `voting_rights` SET TAGS ('dbx_value_regex' = 'voting|non_voting|limited_voting|super_voting');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `fixed_income_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Income Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `issuer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'First Call Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `call_price` SET TAGS ('dbx_business_glossary_term' = 'Call Price');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `callable_flag` SET TAGS ('dbx_business_glossary_term' = 'Callable Bond Flag');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `convexity` SET TAGS ('dbx_business_glossary_term' = 'Bond Convexity');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_business_glossary_term' = 'Coupon Payment Frequency');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `coupon_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|zero_coupon');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `credit_rating_fitch` SET TAGS ('dbx_business_glossary_term' = 'Fitch Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `credit_rating_moodys` SET TAGS ('dbx_business_glossary_term' = 'Moodys Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_business_glossary_term' = 'Standard & Poors (S&P) Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'ACT_360|ACT_365|30_360|ACT_ACT');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `duration` SET TAGS ('dbx_business_glossary_term' = 'Modified Duration');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `first_coupon_date` SET TAGS ('dbx_business_glossary_term' = 'First Coupon Payment Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `fixed_income_status` SET TAGS ('dbx_business_glossary_term' = 'Bond Lifecycle Status');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `fixed_income_status` SET TAGS ('dbx_value_regex' = 'active|matured|called|defaulted|suspended');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `floating_rate_spread` SET TAGS ('dbx_business_glossary_term' = 'Floating Rate Spread');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Issue Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `last_coupon_date` SET TAGS ('dbx_business_glossary_term' = 'Last Coupon Payment Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `market_price` SET TAGS ('dbx_business_glossary_term' = 'Current Market Price');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Maturity Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `price_date` SET TAGS ('dbx_business_glossary_term' = 'Market Price Valuation Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `put_date` SET TAGS ('dbx_business_glossary_term' = 'First Put Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `put_price` SET TAGS ('dbx_business_glossary_term' = 'Put Price');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `puttable_flag` SET TAGS ('dbx_business_glossary_term' = 'Puttable Bond Flag');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Effective Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_business_glossary_term' = 'Floating Rate Reset Frequency');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `reset_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|semi_annual|annual');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `sinking_fund_flag` SET TAGS ('dbx_business_glossary_term' = 'Sinking Fund Provision Flag');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `yield_to_maturity` SET TAGS ('dbx_business_glossary_term' = 'Yield to Maturity (YTM)');
ALTER TABLE `banking_ecm`.`security`.`derivative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`derivative` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Loan Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Derivative Asset Class');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'interest_rate|foreign_exchange|equity|commodity|credit');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `barrier_level` SET TAGS ('dbx_business_glossary_term' = 'Barrier Level');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `barrier_type` SET TAGS ('dbx_business_glossary_term' = 'Barrier Type');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `barrier_type` SET TAGS ('dbx_value_regex' = 'knock_in|knock_out|double_barrier|none');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `ccp_name` SET TAGS ('dbx_business_glossary_term' = 'Central Counterparty (CCP) Name');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|bilateral|pending');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[A-Z0-9]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `cva_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA) Amount');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `derivative_type` SET TAGS ('dbx_business_glossary_term' = 'Derivative Instrument Type');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `exercise_style` SET TAGS ('dbx_business_glossary_term' = 'Exercise Style');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `exercise_style` SET TAGS ('dbx_value_regex' = 'european|american|bermudan|asian');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `frtb_capital_charge` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Capital Charge');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `initial_margin` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin Amount');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Derivative Lifecycle Status');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|matured|terminated|cancelled|suspended');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `margin_currency` SET TAGS ('dbx_business_glossary_term' = 'Margin Currency Code');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `margin_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `mtm_currency` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Currency Code');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `mtm_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Principal Amount');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{7}$');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'cash|physical');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `strike_currency` SET TAGS ('dbx_business_glossary_term' = 'Strike Currency Code');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `strike_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Derivative Instrument Subtype');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `trade_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Transaction Identifier (UTI)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `variation_margin` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin Amount');
ALTER TABLE `banking_ecm`.`security`.`issuer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`issuer` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `parent_issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `primary_ultimate_parent_issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `bloomberg_issuer_code` SET TAGS ('dbx_business_glossary_term' = 'Bloomberg Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `cva_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `fitch_issuer_rating` SET TAGS ('dbx_business_glossary_term' = 'Fitch Issuer Rating');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `fitch_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Fitch Rating Date');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `fitch_rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'Fitch Rating Outlook');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `fitch_rating_outlook` SET TAGS ('dbx_value_regex' = 'positive|stable|negative|evolving');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `gics_sub_industry_code` SET TAGS ('dbx_business_glossary_term' = 'Global Industry Classification Standard (GICS) Sub-Industry Code');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `gics_sub_industry_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `internal_lgd` SET TAGS ('dbx_business_glossary_term' = 'Internal Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `internal_pd` SET TAGS ('dbx_business_glossary_term' = 'Internal Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_financial_institution` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_investment_grade` SET TAGS ('dbx_business_glossary_term' = 'Investment Grade Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_public_sector_entity` SET TAGS ('dbx_business_glossary_term' = 'Public Sector Entity Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_status` SET TAGS ('dbx_business_glossary_term' = 'Issuer Status');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|acquired|liquidated|bankrupt');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_type` SET TAGS ('dbx_business_glossary_term' = 'Issuer Type Classification');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_type` SET TAGS ('dbx_value_regex' = 'corporate|sovereign|municipal|supranational|special_purpose_vehicle|government_agency');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `moodys_issuer_rating` SET TAGS ('dbx_business_glossary_term' = 'Moodys Issuer Rating');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `moodys_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Moodys Rating Date');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `moodys_rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'Moodys Rating Outlook');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `moodys_rating_outlook` SET TAGS ('dbx_value_regex' = 'positive|stable|negative|rating_under_review');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `primary_exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Exchange Code');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'financial_institution|non_financial_corporation|public_sector_entity|central_bank|multilateral_development_bank');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `sp_issuer_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Standard & Poors (S&P) Issuer Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `sp_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Standard & Poors (S&P) Rating Date');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `sp_rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'Standard & Poors (S&P) Rating Outlook');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `sp_rating_outlook` SET TAGS ('dbx_value_regex' = 'positive|stable|negative|developing');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Corporate Website URL');
ALTER TABLE `banking_ecm`.`security`.`price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`security`.`price` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Identifier');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `superseded_by_price_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Price Identifier');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `adjusted_close_price` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Close Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `ask_price` SET TAGS ('dbx_business_glossary_term' = 'Ask Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'clean|dirty');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `change_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Change Amount');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `change_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Price Confidence Score');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `correction_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason Code');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `correction_reason_code` SET TAGS ('dbx_value_regex' = 'source_error|corporate_action|manual_adjustment|system_correction|vendor_restatement');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `high_price` SET TAGS ('dbx_business_glossary_term' = 'High Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `is_superseded` SET TAGS ('dbx_business_glossary_term' = 'Is Superseded Flag');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `last_trade_price` SET TAGS ('dbx_business_glossary_term' = 'Last Trade Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `low_price` SET TAGS ('dbx_business_glossary_term' = 'Low Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `mid_price` SET TAGS ('dbx_business_glossary_term' = 'Mid Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `notation` SET TAGS ('dbx_business_glossary_term' = 'Price Notation');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `notation` SET TAGS ('dbx_value_regex' = 'decimal|percentage|yield|basis_points|fractional');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `official_close_price` SET TAGS ('dbx_business_glossary_term' = 'Official Close Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `open_price` SET TAGS ('dbx_business_glossary_term' = 'Open Price');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|suspended|halted|delisted|matured');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'market|model|indicative|official|closing|opening');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `pricing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pricing Timestamp');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Quality Flag');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `quality_flag` SET TAGS ('dbx_value_regex' = 'verified|unverified|stale|estimated|challenged');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `regulatory_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Price Flag');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `spread_to_benchmark_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread to Benchmark (Basis Points)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `trading_session` SET TAGS ('dbx_business_glossary_term' = 'Trading Session');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `trading_session` SET TAGS ('dbx_value_regex' = 'pre_market|regular|after_hours|overnight');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'quoted|matrix|model|consensus|broker_quote');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Trading Volume');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `vwap` SET TAGS ('dbx_business_glossary_term' = 'Volume-Weighted Average Price (VWAP)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `yield_to_maturity` SET TAGS ('dbx_business_glossary_term' = 'Yield to Maturity (YTM)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action ID');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `cash_rate` SET TAGS ('dbx_business_glossary_term' = 'Cash Rate');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `default_option_code` SET TAGS ('dbx_business_glossary_term' = 'Default Option Code');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `election_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Election Required Flag');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `entitlement_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Calculation Method');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `entitlement_calculation_method` SET TAGS ('dbx_value_regex' = 'position_based|transaction_based|average_balance');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Event Type');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `ex_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `exchange_ratio` SET TAGS ('dbx_business_glossary_term' = 'Exchange Ratio');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_business_glossary_term' = 'Fractional Share Treatment');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_value_regex' = 'cash_in_lieu|round_down|round_up|carry_forward');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `fractional_share_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `mandatory_voluntary_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Voluntary Indicator');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `mandatory_voluntary_indicator` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|mandatory_with_options');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `market_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Claim Flag');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `offer_price` SET TAGS ('dbx_business_glossary_term' = 'Offer Price');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `offer_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Offer Price Currency');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `offer_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `paying_agent_bic` SET TAGS ('dbx_business_glossary_term' = 'Paying Agent Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `paying_agent_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `paying_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Paying Agent Name');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `processing_status` SET TAGS ('dbx_business_glossary_term' = 'Processing Status');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `processing_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|reconciled');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `protect_date` SET TAGS ('dbx_business_glossary_term' = 'Protect Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `source_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Event ID');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `stock_rate_denominator` SET TAGS ('dbx_business_glossary_term' = 'Stock Rate Denominator');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `stock_rate_numerator` SET TAGS ('dbx_business_glossary_term' = 'Stock Rate Numerator');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`security`.`classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`security`.`classification` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Classification Identifier');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument ID');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Code');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_description` SET TAGS ('dbx_business_glossary_term' = 'Classification Description');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_level` SET TAGS ('dbx_business_glossary_term' = 'Classification Level');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_source` SET TAGS ('dbx_business_glossary_term' = 'Classification Source');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_source` SET TAGS ('dbx_value_regex' = 'vendor|internal|regulatory_authority|exchange|issuer|third_party_data_provider');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_status` SET TAGS ('dbx_value_regex' = 'active|pending_review|superseded|deprecated|under_investigation');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `complexity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Complexity Indicator');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `complexity_indicator` SET TAGS ('dbx_value_regex' = 'non_complex|complex');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Classification Confidence Score');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `frtb_risk_bucket` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Risk Bucket');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `internal_asset_class` SET TAGS ('dbx_business_glossary_term' = 'Internal Asset Class');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `internal_product_category` SET TAGS ('dbx_business_glossary_term' = 'Internal Product Category');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `is_primary_classification` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Classification');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `override_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Date');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `override_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Override Approved By');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `override_indicator` SET TAGS ('dbx_business_glossary_term' = 'Override Indicator');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `parent_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Classification Code');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Classification Rationale');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Scheme Code');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Classification Source System');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `sustainability_classification` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Finance Disclosure Regulation (SFDR) Classification');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `sustainability_classification` SET TAGS ('dbx_value_regex' = 'article_6|article_8|article_9|not_applicable');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Classification Version');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`security`.`identifier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`security`.`identifier` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Identifier Identifier');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument ID');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `composite_identifier_flag` SET TAGS ('dbx_business_glossary_term' = 'Composite Identifier Flag');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `country_of_issuance` SET TAGS ('dbx_business_glossary_term' = 'Country of Issuance');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `country_of_issuance` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_description` SET TAGS ('dbx_business_glossary_term' = 'Identifier Description');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_status` SET TAGS ('dbx_business_glossary_term' = 'Identifier Status');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|suspended');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Identifier Type');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_value_regex' = 'ISIN|CUSIP|SEDOL|FIGI|BBGID|RIC');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_value` SET TAGS ('dbx_business_glossary_term' = 'Identifier Value');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Identifier Flag');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`security`.`listing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`listing` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Identifier');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `circuit_breaker_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Circuit Breaker Threshold Percentage');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `current_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `delisting_date` SET TAGS ('dbx_business_glossary_term' = 'Delisting Date');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `effective_to_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective To Timestamp');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `exchange_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Exchange Ticker Symbol');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Listing Fee Amount');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `isin_code` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `isin_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `last_trading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Trading Date');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Date');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'active|suspended|halted|delisted|pending');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_business_glossary_term' = 'Listing Type');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|dual|adr|gdr');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `local_instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Local Instrument Code');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `market_data_subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Data Subscription Tier');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `market_maker_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Maker Required Flag');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `mifid_liquid_flag` SET TAGS ('dbx_business_glossary_term' = 'Markets in Financial Instruments Directive (MiFID) II Liquid Flag');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `price_band_lower_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Band Lower Percentage');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `price_band_upper_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Band Upper Percentage');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `price_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Price Multiplier');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `primary_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Listing Flag');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `settlement_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle Days');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `short_selling_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Short Selling Allowed Flag');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `sponsor` SET TAGS ('dbx_business_glossary_term' = 'Listing Sponsor');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `tick_size` SET TAGS ('dbx_business_glossary_term' = 'Tick Size');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_hours_end` SET TAGS ('dbx_business_glossary_term' = 'Trading Hours End Time');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_hours_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_hours_start` SET TAGS ('dbx_business_glossary_term' = 'Trading Hours Start Time');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_hours_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_phase` SET TAGS ('dbx_business_glossary_term' = 'Trading Phase');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_phase` SET TAGS ('dbx_value_regex' = 'pre_open|continuous|closing_auction|post_close|closed');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_timezone` SET TAGS ('dbx_business_glossary_term' = 'Trading Timezone');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_venue_type` SET TAGS ('dbx_business_glossary_term' = 'Trading Venue Type');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `trading_venue_type` SET TAGS ('dbx_value_regex' = 'regulated_market|mtf|otf|systematic_internaliser');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`benchmark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`benchmark` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Identifier');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `administrator_lei` SET TAGS ('dbx_business_glossary_term' = 'Administrator Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `administrator_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Administrator Name');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_code` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Code');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_name` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Name');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Status');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_status` SET TAGS ('dbx_value_regex' = 'active|legacy|discontinued|suspended');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `bloomberg_ticker` SET TAGS ('dbx_business_glossary_term' = 'Bloomberg Ticker');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `compounding_method` SET TAGS ('dbx_business_glossary_term' = 'Compounding Method');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `compounding_method` SET TAGS ('dbx_value_regex' = 'simple|compound|continuous');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `constituent_count` SET TAGS ('dbx_business_glossary_term' = 'Constituent Count');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'actual_360|actual_365|30_360|actual_actual');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Inception Date');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `index_base_date` SET TAGS ('dbx_business_glossary_term' = 'Index Base Date');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `index_base_value` SET TAGS ('dbx_business_glossary_term' = 'Index Base Value');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `iosco_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'International Organization of Securities Commissions (IOSCO) Compliant Flag');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `methodology_document_url` SET TAGS ('dbx_business_glossary_term' = 'Methodology Document Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Publication Frequency');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `publication_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|real_time|intraday');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `publication_time` SET TAGS ('dbx_business_glossary_term' = 'Publication Time');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|semi_annual|annual|event_driven');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'authorized|registered|recognized|legacy|discontinued');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `reuters_ric` SET TAGS ('dbx_business_glossary_term' = 'Reuters Instrument Code (RIC)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `sector_coverage` SET TAGS ('dbx_business_glossary_term' = 'Sector Coverage');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `spread_adjustment_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread Adjustment in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `tenor` SET TAGS ('dbx_business_glossary_term' = 'Tenor');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `usage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Usage Restriction');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `weighting_scheme` SET TAGS ('dbx_business_glossary_term' = 'Weighting Scheme');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `weighting_scheme` SET TAGS ('dbx_value_regex' = 'market_cap|free_float|price|equal|fundamental|risk_parity');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` SET TAGS ('dbx_subdomain' = 'security_master');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `collateralization_type` SET TAGS ('dbx_business_glossary_term' = 'Collateralization Type');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `collateralization_type` SET TAGS ('dbx_value_regex' = 'uncollateralized|cash_collateralized|ois_collateralized');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `construction_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Date');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `construction_methodology` SET TAGS ('dbx_business_glossary_term' = 'Construction Methodology');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `construction_methodology` SET TAGS ('dbx_value_regex' = 'bootstrapping|nelson_siegel|cubic_spline|linear|piecewise_linear|hermite');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `construction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Construction Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_name` SET TAGS ('dbx_business_glossary_term' = 'Curve Name');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_nodes_json` SET TAGS ('dbx_business_glossary_term' = 'Curve Nodes JSON');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_shift_scenario` SET TAGS ('dbx_business_glossary_term' = 'Curve Shift Scenario');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_status` SET TAGS ('dbx_business_glossary_term' = 'Curve Status');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_status` SET TAGS ('dbx_value_regex' = 'active|superseded|draft|archived');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_type` SET TAGS ('dbx_business_glossary_term' = 'Curve Type');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `curve_version` SET TAGS ('dbx_business_glossary_term' = 'Curve Version');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'act_360|act_365|30_360|act_act|30e_360');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `interpolation_method` SET TAGS ('dbx_business_glossary_term' = 'Interpolation Method');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `interpolation_method` SET TAGS ('dbx_value_regex' = 'linear|cubic_spline|log_linear|hermite|flat_forward');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `is_risk_free` SET TAGS ('dbx_business_glossary_term' = 'Is Risk-Free Indicator');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `longest_tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Longest Tenor in Days');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `market_data_source` SET TAGS ('dbx_business_glossary_term' = 'Market Data Source');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `shortest_tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Shortest Tenor in Days');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `tenor_count` SET TAGS ('dbx_business_glossary_term' = 'Tenor Count');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `valuation_purpose` SET TAGS ('dbx_business_glossary_term' = 'Valuation Purpose');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `valuation_purpose` SET TAGS ('dbx_value_regex' = 'trading|accounting|regulatory|risk_management|ftp');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Identifier');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Party ID');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `basel_credit_quality_step` SET TAGS ('dbx_business_glossary_term' = 'Basel Credit Quality Step');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `basel_risk_weight_pct` SET TAGS ('dbx_business_glossary_term' = 'Basel Risk Weight Percentage');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `cecl_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Losses (CECL) Risk Category');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `cecl_risk_category` SET TAGS ('dbx_value_regex' = 'pass|special_mention|substandard|doubtful|loss');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `default_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Flag');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiration Date');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standard 9 (IFRS 9) Stage');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `ifrs9_stage` SET TAGS ('dbx_value_regex' = 'stage_1|stage_2|stage_3|not_applicable');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `internal_override_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Override Flag');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `internal_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Internal Override Reason');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `investment_grade_flag` SET TAGS ('dbx_business_glossary_term' = 'Investment Grade Flag');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `long_term_rating` SET TAGS ('dbx_business_glossary_term' = 'Long-Term Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rating Review Date');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `previous_rating` SET TAGS ('dbx_business_glossary_term' = 'Previous Rating');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `probability_of_default_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Percentage');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `public_rating_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Rating Flag');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rated_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Rated Entity Type');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rated_entity_type` SET TAGS ('dbx_value_regex' = 'instrument|issuer|counterparty|sovereign|structured_product|fund');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_action_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Action Type');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency Code');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency Name');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Rating Change Reason');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_identifier` SET TAGS ('dbx_business_glossary_term' = 'Rating Identifier');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_notch` SET TAGS ('dbx_business_glossary_term' = 'Rating Notch');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'Rating Outlook');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_rationale` SET TAGS ('dbx_business_glossary_term' = 'Rating Rationale');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Type');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_value_regex' = 'long_term|short_term|fund|insurance_financial_strength|bank_financial_strength|sovereign');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_source_system` SET TAGS ('dbx_business_glossary_term' = 'Rating Source System');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|suspended|expired|under_review');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Treatment');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `regulatory_capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Review Date');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `short_term_rating` SET TAGS ('dbx_business_glossary_term' = 'Short-Term Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `solicited_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicited Rating Flag');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `watch_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Watch List Flag');
