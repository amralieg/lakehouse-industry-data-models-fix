-- Schema for Domain: security | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`security` COMMENT 'Master data for all securities and financial instruments including equities, fixed income, derivatives, MBS, ABS, CDS, CLO, CDO, and OTC instruments. Owns instrument master (ISIN, CUSIP, SEDOL), security classification, pricing, corporate actions, and security lifecycle. Provides the golden source instrument reference for trade, investment, and wealth domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the financial instrument. Primary key for the instrument master record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Securities are subject to regulatory obligations (prospectus requirements, disclosure rules, trading restrictions). Compliance teams track which obligations apply to each instrument for regulatory fil',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: SOX controls test security valuation, existence, and classification assertions. Control testing requires sampling specific instruments and documenting test results. Essential for SOX compliance and fi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every instrument trades in a specific currency. Essential for FX risk calculation, P&L reporting, FRTB market risk capital, and Basel regulatory reporting. Replaces denormalized currency_code with pro',
    `irb_model_id` BIGINT COMMENT 'Foreign key linking to risk.irb_model. Business justification: Credit instruments require IRB model assignment for Basel regulatory capital calculation. RWA computation depends on model-derived PD/LGD/EAD parameters. Mandatory for banks using internal ratings-bas',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Country of issuance determines legal jurisdiction, tax treatment, and regulatory reporting requirements. Critical for sanctions screening, country risk limits, and Basel country exposure reporting. Ro',
    `issuer_id` BIGINT COMMENT 'FK to security.issuer',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Trading policies, suitability policies, and product governance policies reference specific instruments or instrument types. Pre-trade compliance checks enforce policy restrictions on securities. Real ',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory changes affect specific instrument types (MiFID II transparency, SFDR classification, FRTB capital treatment). Impact assessment and implementation planning require tracking which instrumen',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory examiners review specific securities holdings, valuations, and classifications during examinations. Exam preparation and response require tracking which instruments were reviewed and cited.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Instruments require stress scenario assignment for CCAR/DFAST regulatory stress testing. Each security must be shocked under supervisory scenarios to project capital adequacy. Mandatory for Federal Re',
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
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Equity positions are fundamental market risk exposures requiring delta/gamma/vega measurement for VaR and stress testing. Trading book positions must be captured for FRTB sensitivities-based approach ',
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
    `issuer_lei` STRING COMMENT 'ISO 17442 standard 20-character alphanumeric code uniquely identifying the issuing legal entity globally.. Valid values are `^[A-Z0-9]{20}$`',
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
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Bond holdings create issuer credit exposure tracked for concentration limits and regulatory capital. IFRS9 ECL provisioning requires exposure quantification. Mandatory for credit risk reporting and la',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Bond denomination currency is fundamental to pricing, accrued interest calculation, and FX hedging strategies. Required for accurate yield calculation and cross-currency bond portfolio analytics in fi',
    `issuer_id` BIGINT COMMENT 'FK to security.issuer',
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
    `cusip` STRING COMMENT '9-character alphanumeric code identifying North American securities. Primary identifier for US and Canadian fixed income instruments.. Valid values are `^[0-9]{3}[A-Z0-9]{5}[0-9]$`',
    `day_count_convention` STRING COMMENT 'Method used to calculate accrued interest between coupon payment dates. Critical for accurate interest accrual, pricing, and settlement calculations.. Valid values are `ACT_360|ACT_365|30_360|ACT_ACT`',
    `duration` DECIMAL(18,2) COMMENT 'Measure of the bonds price sensitivity to changes in interest rates, expressed in years. Critical for interest rate risk management and ALM gap analysis.',
    `face_value` DECIMAL(18,2) COMMENT 'Par value or principal amount of the bond that will be repaid at maturity. Basis for coupon payment calculations and amortization schedules.',
    `first_coupon_date` DATE COMMENT 'Date of the first scheduled coupon payment. May differ from a regular period if the bond has an odd first coupon period.',
    `fixed_income_status` STRING COMMENT 'Current state of the bond in its lifecycle. Active bonds are trading normally, matured bonds have reached their maturity date, called bonds have been redeemed early, defaulted bonds have missed payments.. Valid values are `active|matured|called|defaulted|suspended`',
    `floating_rate_index` STRING COMMENT 'Reference interest rate index to which the coupon rate is linked for floating-rate bonds. Common indices include SOFR, LIBOR, EURIBOR, and Treasury rates.',
    `floating_rate_spread` DECIMAL(18,2) COMMENT 'Fixed spread in basis points added to the reference index rate to determine the coupon rate for floating-rate bonds. Reflects issuer credit risk and market conditions at issuance.',
    `instrument_name` STRING COMMENT 'Full legal name or description of the fixed income security as registered with the issuer and regulatory authorities.',
    `instrument_type` STRING COMMENT 'Classification of the fixed income security by issuer type and structure. Determines regulatory treatment, risk weighting, and accounting classification.. Valid values are `government_bond|corporate_bond|municipal_bond|treasury_bill|treasury_note|inflation_linked_security`',
    `isin` STRING COMMENT '12-character alphanumeric code that uniquely identifies the fixed income security globally. Standard identifier for cross-border trading and settlement.. Valid values are `^[A-Z]{2}[A-Z0-9]{9}[0-9]$`',
    `issue_date` DATE COMMENT 'Date on which the bond was originally issued and became available for purchase in the primary market.',
    `issuer_country_code` STRING COMMENT 'Three-letter ISO country code representing the country of domicile of the bond issuer. Used for country risk assessment and regulatory capital calculations.. Valid values are `^[A-Z]{3}$`',
    `last_coupon_date` DATE COMMENT 'Date of the final scheduled coupon payment before maturity. Typically occurs on or shortly before the maturity date.',
    `market_price` DECIMAL(18,2) COMMENT 'Most recent trading price or valuation of the bond in the secondary market, typically expressed as a percentage of face value. Used for mark-to-market valuation and PnL calculation.',
    `maturity_date` DATE COMMENT 'Date on which the principal amount of the bond becomes due and payable to the bondholder. Final date in the bond lifecycle.',
    `price_date` DATE COMMENT 'Date on which the current market price was observed or calculated. Critical for fair value accounting and regulatory reporting.',
    `put_date` DATE COMMENT 'Earliest date on which the bondholder may exercise the put option to sell the bond back to the issuer. Null if the bond is not puttable.',
    `put_price` DECIMAL(18,2) COMMENT 'Price at which the bondholder may sell the bond back to the issuer if the put option is exercised. Typically at or near par value.',
    `puttable_flag` BOOLEAN COMMENT 'Indicates whether the bondholder has the right to sell the bond back to the issuer before maturity at specified put dates and prices. Provides downside protection to investors.',
    `rating_date` DATE COMMENT 'Date on which the current credit rating was assigned or last affirmed by the rating agency. Used to track rating changes and trigger covenant reviews.',
    `reset_frequency` STRING COMMENT 'Frequency at which the coupon rate is recalculated based on the current reference index rate for floating-rate bonds. Determines interest rate risk exposure.. Valid values are `daily|monthly|quarterly|semi_annual|annual`',
    `sedol` STRING COMMENT '7-character alphanumeric code used to identify securities on the London Stock Exchange and other UK markets.. Valid values are `^[0-9A-Z]{7}$`',
    `sinking_fund_flag` BOOLEAN COMMENT 'Indicates whether the bond has a sinking fund provision requiring the issuer to retire a portion of the bond issue periodically before maturity. Reduces credit risk but may limit upside.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed income instrument record was last modified. Tracks data currency and supports change data capture processes.',
    `yield_to_maturity` DECIMAL(18,2) COMMENT 'Total return anticipated on the bond if held until maturity, expressed as an annual rate. Incorporates coupon payments, principal repayment, and current market price.',
    CONSTRAINT pk_fixed_income PRIMARY KEY(`fixed_income_id`)
) COMMENT 'Master data for fixed income instruments including government bonds, corporate bonds, municipal bonds, treasury bills, notes, and inflation-linked securities, with embedded detailed coupon payment schedules. Captures bond-specific attributes: coupon rate, coupon frequency, coupon type (fixed/floating/zero), maturity date, first coupon date, last coupon date, day count convention (ACT/360, 30/360), yield basis, call/put provisions, sinking fund schedule, credit rating (Moodys, S&P, Fitch), rating date, and bond covenants. Includes the full coupon schedule as embedded detail with accrual start/end dates, payment dates, coupon period number, coupon rate (fixed or floating reset), day count fraction, projected and actual coupon amounts (post-reset for floaters), payment currency, and payment status (scheduled/paid/missed/deferred). Supports NII calculation, cash flow projection, ALM gap analysis, bond analytics (duration, convexity, DV01), IFRS 9 ECL modeling, and NII forecasting.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`derivative` (
    `derivative_id` BIGINT COMMENT 'Unique identifier for the derivative instrument. Primary key.',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: OTC derivatives generate counterparty credit exposure requiring CVA/DVA calculation and capital charges. SA-CCR methodology mandates exposure measurement for bilateral trades. Critical for Basel III c',
    `counterparty_agreement_id` BIGINT COMMENT 'Reference to the ISDA Master Agreement governing the legal terms and conditions of the derivative contract between counterparties.',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the Credit Support Annex that governs collateral posting requirements and margin calculations for the derivative contract.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Notional currency defines derivative contract size and exposure. Critical for risk aggregation, CVA calculation, and regulatory reporting (EMIR, Dodd-Frank). First of four currency FKs needed for deri',
    `party_id` BIGINT COMMENT 'Reference to the legal entity on the opposite side of the derivative transaction. Used for counterparty credit risk (CVA) and exposure calculations.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Credit derivatives (CDS, total return swaps, credit-linked notes) referencing loan facilities as underlying exposure require facility identification for mark-to-market valuation, credit event determin',
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
    `reporting_obligation` STRING COMMENT 'Identifies the regulatory framework under which the derivative must be reported: EMIR (EU), Dodd-Frank (US), MiFID II (EU), SFTR (Securities Financing Transactions Regulation), or none.. Valid values are `emir|dodd_frank|mifid_ii|sftr|none`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`structured_product` (
    `structured_product_id` BIGINT COMMENT 'Unique identifier for the structured finance instrument record.',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Structured products (ABS/MBS/CLO) generate credit exposure requiring IFRS9 ECL provisioning and Basel securitization capital treatment. Tranches must be assessed for credit risk and assigned risk weig',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Structured product denomination currency is essential for waterfall calculations, tranche pricing, and cash flow modeling in securitization platforms. Required for accurate investor reporting and regu',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Structured products (MBS, ABS, CLO, CDO) are financial instruments and should inherit from the instrument master. Pattern matches equity, fixed_income, and derivative which all have instrument_id FKs.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Structured products are issued by SPVs, originators, or financial institutions. Pattern matches equity and fixed_income which both have issuer_id FKs. Essential for tracking the originating entity and',
    `prospectus_id` BIGINT COMMENT 'Foreign key linking to security.prospectus. Business justification: Structured products reference offering documents and prospectuses. The existing prospectus_reference (STRING) should be replaced with a proper FK to the prospectus product for referential integrity an',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Structured products referencing specific loan accounts in their collateral pool (e.g., CLO tranches backed by identified corporate loans) require account-level tracking for performance monitoring, def',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Structured products (CLOs, loan-backed securities, ABS) backed by loan facilities require facility reference for collateral pool tracking, cash flow modeling, and credit risk assessment. Core securiti',
    `capital_treatment` STRING COMMENT 'The regulatory capital approach applied to this structured product: Standardized Approach (SA), Internal Ratings-Based (IRB), or Securitization framework variants.. Valid values are `SA|IRB|SEC-IRBA|SEC-ERBA|SEC-SA`',
    `collateral_type` STRING COMMENT 'Description of the underlying asset class backing the structured product (e.g., residential mortgages, auto loans, commercial real estate, corporate loans).',
    `coupon_rate` DECIMAL(18,2) COMMENT 'The stated interest rate paid to investors on the structured product, expressed as an annual percentage.',
    `coupon_type` STRING COMMENT 'Classification of the interest payment structure.. Valid values are `Fixed|Floating|Step-Up|Zero-Coupon`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this structured product record was first created in the system.',
    `credit_enhancement_level` DECIMAL(18,2) COMMENT 'The percentage of credit protection provided through subordination, overcollateralization, or reserve accounts to protect senior tranches from losses.',
    `credit_rating` STRING COMMENT 'The current credit rating assigned by the rating agency.',
    `current_face_value` DECIMAL(18,2) COMMENT 'The current outstanding principal balance after accounting for amortization, prepayments, and defaults.',
    `deal_name` STRING COMMENT 'The official name or title of the structured finance deal or issuance program.',
    `ead` DECIMAL(18,2) COMMENT 'The total value exposed to loss at the time of default, used for regulatory capital calculations.',
    `ecl_provision` DECIMAL(18,2) COMMENT 'The calculated expected credit loss provision under CECL or IFRS 9 accounting standards.',
    `first_payment_date` DATE COMMENT 'The date of the first scheduled interest or principal payment to investors.',
    `geographic_concentration` STRING COMMENT 'Primary geographic region or country where the underlying collateral is concentrated.',
    `issue_date` DATE COMMENT 'The date on which the structured product was originally issued to investors.',
    `lgd` DECIMAL(18,2) COMMENT 'The estimated percentage of exposure that will be lost if the underlying collateral defaults, used for CECL and IFRS 9 impairment calculations.',
    `maturity_date` DATE COMMENT 'The scheduled final payment date when all remaining principal and interest are due.',
    `original_face_value` DECIMAL(18,2) COMMENT 'The initial principal amount of the structured product at issuance.',
    `payment_frequency` STRING COMMENT 'The frequency at which interest and principal payments are made to investors.. Valid values are `Monthly|Quarterly|Semi-Annual|Annual`',
    `pd` DECIMAL(18,2) COMMENT 'The estimated likelihood that the underlying collateral will default within a specified time horizon, expressed as a percentage.',
    `pool_factor` DECIMAL(18,2) COMMENT 'Ratio of current face value to original face value, representing the remaining principal as a decimal (e.g., 0.85 means 85% remaining).',
    `prepayment_speed_assumption` STRING COMMENT 'The assumed rate of prepayment for the underlying collateral, expressed as PSA (Public Securities Association) percentage or CPR (Constant Prepayment Rate).',
    `product_type` STRING COMMENT 'Classification of the structured finance instrument type.. Valid values are `MBS|ABS|CLO|CDO|CMBS|Covered Bond`',
    `rating_agency` STRING COMMENT 'The name of the credit rating agency that assigned the credit rating (e.g., Moodys, S&P, Fitch).',
    `rating_date` DATE COMMENT 'The date on which the current credit rating was assigned or last updated.',
    `reference_rate` DECIMAL(18,2) COMMENT 'The benchmark interest rate used for floating-rate structured products (e.g., SOFR, LIBOR, EURIBOR).',
    `rwa` DECIMAL(18,2) COMMENT 'The risk-weighted asset value calculated under Basel III standardized or internal ratings-based approach for regulatory capital requirements.',
    `servicer_name` STRING COMMENT 'The name of the financial institution responsible for collecting payments from the underlying collateral and distributing them to investors.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The credit spread added to the reference rate for floating-rate products, expressed in basis points.',
    `structured_product_status` STRING COMMENT 'Current lifecycle status of the structured product.. Valid values are `Active|Matured|Defaulted|Called|Redeemed|Suspended`',
    `tranche_class` STRING COMMENT 'Credit rating or seniority classification of the tranche indicating payment priority and risk level. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|Mezzanine|Equity|Senior|Subordinated — 10 candidates stripped; promote to reference product]',
    `tranche_identifier` STRING COMMENT 'Unique identifier for the specific tranche within the structured product deal.',
    `trustee_name` STRING COMMENT 'The name of the trustee responsible for representing investor interests and ensuring compliance with the indenture agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this structured product record was last modified.',
    `wac` DECIMAL(18,2) COMMENT 'The weighted average interest rate of the underlying collateral pool, expressed as a percentage.',
    `wal` DECIMAL(18,2) COMMENT 'The weighted average time until principal is repaid, expressed in years, accounting for prepayment assumptions.',
    `wam` DECIMAL(18,2) COMMENT 'The weighted average time to maturity of the underlying collateral pool, expressed in months.',
    CONSTRAINT pk_structured_product PRIMARY KEY(`structured_product_id`)
) COMMENT 'Master data for structured finance instruments including MBS, ABS, CLO, CDO, CMBS, and covered bonds. Captures structure-specific attributes: deal name, tranche identifier, tranche class (AAA/AA/mezzanine/equity), original face value, current face value, pool factor, weighted average coupon (WAC), weighted average maturity (WAM), weighted average life (WAL), prepayment speed assumption (PSA/CPR), credit enhancement level, servicer name, trustee, and prospectus reference. Supports CECL/IFRS 9 impairment modeling and regulatory capital (SA/IRB) calculations.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`issuer` (
    `issuer_id` BIGINT COMMENT 'Unique identifier for the security issuer. Primary key for the issuer master data product.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Issuers face regulatory obligations (capital adequacy, reporting requirements, governance standards). Compliance monitors issuer-level regulatory requirements for credit risk management and regulatory',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Every issuer must have internal counterparty rating for credit risk management. Drives exposure limits, collateral requirements, and credit approval workflows. Core to credit portfolio management and ',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Issuer domicile determines tax withholding, regulatory jurisdiction, and country exposure limits. Critical for sanctions screening, country concentration risk management, and Basel Pillar 3 country ex',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Industry classification drives sector concentration limits, stress testing scenarios, and portfolio construction rules. Essential for CCAR/DFAST industry shock scenarios and Basel sectoral risk weight',
    `parent_issuer_id` BIGINT COMMENT 'Reference to the immediate parent entity in the corporate hierarchy. Used for consolidated risk reporting and group exposure aggregation under Basel III.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Credit policies, exposure limits, and counterparty policies reference issuers. Credit risk policy enforcement and issuer exposure monitoring require linking issuers to applicable policies. Essential f',
    `primary_ultimate_parent_issuer_id` BIGINT COMMENT 'Reference to the top-level parent entity in the corporate hierarchy. Critical for ultimate risk aggregation, large exposure monitoring, and CCAR/DFAST stress testing.',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory changes affect issuer reporting or capital treatment requirements. Implementation scope definition requires tracking which issuers are affected. Essential for regulatory change management a',
    `bloomberg_issuer_code` STRING COMMENT 'Bloombergs proprietary issuer identifier used for market data integration, pricing feeds, and reference data synchronization with Bloomberg Terminal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this issuer record was first created in the system. Audit trail for data lineage and regulatory compliance.',
    `cva_adjustment` DECIMAL(18,2) COMMENT 'The market value of counterparty credit risk for derivative exposures with this issuer. Required under Basel III CVA capital charge and IFRS 13 fair value accounting.',
    `effective_date` DATE COMMENT 'Date when this issuer record became effective in the system. Used for temporal queries and historical analysis.',
    `expiration_date` DATE COMMENT 'Date when this issuer record expires or was superseded. Null for currently active records. Supports slowly changing dimension Type 2 history.',
    `fitch_issuer_rating` STRING COMMENT 'Current long-term issuer default rating assigned by Fitch Ratings. Provides third opinion for credit risk triangulation.',
    `fitch_rating_date` DATE COMMENT 'Date when the current Fitch issuer rating was assigned or last affirmed.',
    `fitch_rating_outlook` STRING COMMENT 'Fitchs assessment of the potential direction of the issuer rating over a one to two-year period.. Valid values are `positive|stable|negative|evolving`',
    `gics_sub_industry_code` STRING COMMENT 'Eight-digit GICS sub-industry code providing the most granular level of industry classification for specialized credit analysis.. Valid values are `^[0-9]{8}$`',
    `incorporation_jurisdiction` STRING COMMENT 'The legal jurisdiction (country and state/province if applicable) where the issuer is incorporated or legally established. May differ from domicile country for tax optimization structures.',
    `internal_credit_rating` STRING COMMENT 'Banks internal credit rating assigned through the Internal Ratings-Based (IRB) approach. Used for economic capital allocation, pricing, and portfolio management when approved by regulators.',
    `internal_lgd` DECIMAL(18,2) COMMENT 'Banks estimate of the economic loss as a percentage of Exposure at Default if the issuer defaults. Expressed as percentage (e.g., 45.00 = 45%). Used for IRB capital and expected loss calculations.',
    `internal_pd` DECIMAL(18,2) COMMENT 'Banks estimate of the one-year probability of default for the issuer, expressed as a decimal (e.g., 0.015 = 1.5%). Core input for IRB capital calculations and CECL/IFRS 9 expected credit loss provisioning.',
    `is_financial_institution` BOOLEAN COMMENT 'Boolean indicator whether the issuer is classified as a financial institution under Basel III. Determines interbank exposure treatment and contagion risk assessment.',
    `is_investment_grade` BOOLEAN COMMENT 'Boolean indicator whether the issuers credit rating meets investment grade threshold (BBB-/Baa3 or higher). Used for portfolio mandate compliance and risk appetite limits.',
    `is_public_sector_entity` BOOLEAN COMMENT 'Boolean indicator whether the issuer is a public sector entity eligible for preferential risk weighting under Basel III Standardized Approach.',
    `is_sanctioned_entity` BOOLEAN COMMENT 'Boolean indicator whether the issuer is subject to economic sanctions by OFAC, EU, UN, or other sanctioning authorities. Critical for AML/CFT compliance and transaction screening.',
    `issuer_status` STRING COMMENT 'Current lifecycle status of the issuer entity. Inactive, merged, or bankrupt issuers require special handling for legacy securities and credit event processing.. Valid values are `active|inactive|merged|acquired|liquidated|bankrupt`',
    `issuer_type` STRING COMMENT 'Classification of the issuer entity type. Determines applicable regulatory treatment, credit risk methodology, and capital requirements under Basel III.. Valid values are `corporate|sovereign|municipal|supranational|special_purpose_vehicle|government_agency`',
    `legal_name` STRING COMMENT 'The full legal name of the issuer as registered with the incorporation authority. This is the official name used in legal documents, securities filings, and regulatory submissions.',
    `lei` STRING COMMENT 'The 20-character alphanumeric Legal Entity Identifier assigned by a Local Operating Unit accredited by the Global Legal Entity Identifier Foundation. Required for regulatory reporting under EMIR, MiFID II, and Dodd-Frank.. Valid values are `^[A-Z0-9]{20}$`',
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
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Every price quote requires currency context for valuation and P&L calculation. Essential for multi-currency portfolio valuation, FX translation, and fair value hierarchy reporting under IFRS 13.',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument being priced. Links to the security master for ISIN, CUSIP, SEDOL, and instrument classification.',
    `market_center_id` BIGINT COMMENT 'Foreign key linking to reference.market_center. Business justification: Links price to trading venue for best execution analysis, MiFID II transaction reporting, and market data licensing. Essential for TCA (transaction cost analysis) and systematic internalizer reporting',
    `market_data_source_id` BIGINT COMMENT 'Unique identifier for the external market data vendor or provider (e.g., Bloomberg ticker, Reuters RIC, exchange MIC code).',
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Market risk positions require daily pricing for mark-to-market valuation and VaR calculation. Price feeds drive P&L attribution, risk sensitivities (delta/gamma), and regulatory capital charges under ',
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
    `instrument_id` BIGINT COMMENT 'Reference to the security instrument affected by this corporate action.',
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
    `issuer_lei` STRING COMMENT 'Legal Entity Identifier of the issuer as defined by the Global Legal Entity Identifier Foundation.. Valid values are `^[A-Z0-9]{20}$`',
    `issuer_name` STRING COMMENT 'Legal name of the entity issuing the security and initiating the corporate action.',
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
    `tax_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the tax jurisdiction applying withholding tax.. Valid values are `^[A-Z]{3}$`',
    `updated_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last updated this record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this corporate action record was last modified.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Default withholding tax rate applied to cash distributions, expressed as a decimal (e.g., 0.15 for 15%).',
    CONSTRAINT pk_corporate_action PRIMARY KEY(`corporate_action_id`)
) COMMENT 'Master record for corporate action events affecting securities, including event details, voluntary election options, and beneficial owner election responses. Covers dividends, mergers, tender offers, rights issues, and all election processing.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`classification` (
    `classification_id` BIGINT COMMENT 'Primary key for classification',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Links security-specific classification to canonical reference taxonomy for consistency across systems. Essential for regulatory reporting (FRTB, MiFID II), risk aggregation, and product control classi',
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
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Links position-specific identifier mappings to golden source reference identifiers. Essential for identifier validation, reconciliation, and cross-system instrument matching in securities master data ',
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
    `instrument_id` BIGINT COMMENT 'Reference to the underlying security or financial instrument being listed.',
    `market_center_id` BIGINT COMMENT 'Foreign key linking to reference.market_center. Business justification: Core relationship - every listing exists on specific exchange. Essential for trading hours, circuit breakers, market data subscriptions, and MiFID II venue transparency reporting. Replaces denormalize',
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

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`yield_curve_node` (
    `yield_curve_node_id` BIGINT COMMENT 'Unique identifier for the yield curve node record.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Yield curve nodes often reference benchmark rates (SOFR, LIBOR, Treasury rates) for rate construction. The existing benchmark_reference (STRING) should be replaced with a proper FK to the benchmark pr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Each curve node quote is in specific currency for interpolation and rate calculation. Required for multi-currency curve bootstrapping and cross-currency basis swap pricing in rates trading.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Node-level calendar reference enables accurate forward rate calculations and accrual period adjustments. Essential for tenor-specific business day conventions in multi-currency derivative pricing mode',
    `stress_scenario_id` BIGINT COMMENT 'Optional identifier linking this node to a regulatory or internal stress testing scenario (e.g., CCAR severely adverse scenario, DFAST baseline scenario). Empty for base case curves.',
    `yield_curve_id` BIGINT COMMENT 'Reference to the parent yield curve to which this node belongs. Links to the yield curve master record that defines the curve type, currency, and observation date.',
    `approval_status` STRING COMMENT 'The approval workflow status of this yield curve node. Values include draft (initial calculation), pending_review (awaiting validation), approved (ready for use), rejected (failed validation), superseded (replaced by newer version).. Valid values are `draft|pending_review|approved|rejected|superseded`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this yield curve node was approved for production use. Part of the audit trail for regulatory compliance and model governance.',
    `approved_by` STRING COMMENT 'The user ID or name of the market risk analyst, quant, or system that approved this yield curve node for production use. Part of the audit trail for regulatory compliance.',
    `bid_rate` DECIMAL(18,2) COMMENT 'The bid side of the market quote for this tenor, representing the rate at which market makers are willing to buy the instrument. Expressed as a decimal. Used for bid-offer spread analysis.',
    `business_day_convention` STRING COMMENT 'The convention used to adjust maturity dates that fall on non-business days (e.g., following, modified following, preceding, unadjusted). Ensures consistency with market settlement practices.. Valid values are `following|modified_following|preceding|unadjusted`',
    `compounding_frequency` STRING COMMENT 'The frequency at which interest is compounded for this rate (e.g., continuous, annual, semi-annual, quarterly, monthly, daily). Affects the conversion between different rate quotation conventions.. Valid values are `continuous|annual|semi_annual|quarterly|monthly|daily`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this yield curve node record was first created in the system. Part of the data lineage and audit trail.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of this node rate data. Values include verified (directly observed), estimated (model-derived), interpolated (calculated from adjacent nodes), stale (not updated), or missing (no data available).. Valid values are `verified|estimated|interpolated|stale|missing`',
    `day_count_convention` STRING COMMENT 'The day count convention used to calculate accrued interest and discount factors for this tenor (e.g., ACT/360, ACT/365, 30/360, ACT/ACT). Critical for accurate cash flow calculations.. Valid values are `ACT/360|ACT/365|30/360|ACT/ACT`',
    `discount_factor` DECIMAL(18,2) COMMENT 'The present value of one unit of currency to be received at this tenor, calculated as exp(-zero_rate * tenor_years). Used for discounting future cash flows to present value.',
    `dv01` DECIMAL(18,2) COMMENT 'The sensitivity of the present value of cash flows to a one basis point (0.01%) parallel shift in the yield curve at this tenor. Expressed in base currency units. Used for interest rate risk management and hedging.',
    `effective_date` DATE COMMENT 'The date from which this yield curve node rate becomes effective for pricing and valuation purposes. Typically the trade date or settlement date for the underlying instruments.',
    `forward_rate` DECIMAL(18,2) COMMENT 'The implied forward interest rate starting at this tenor, derived from the zero curve. Expressed as a decimal. Used for forward rate agreement (FRA) pricing and interest rate derivative valuation.',
    `interpolation_method` STRING COMMENT 'The mathematical interpolation technique applied between this node and adjacent nodes to derive rates for non-standard tenors. Common methods include linear, cubic spline, Nelson-Siegel, Svensson, and log-linear interpolation.. Valid values are `linear|cubic_spline|nelson_siegel|svensson|log_linear`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this yield curve node is currently active and should be used for pricing and risk calculations. False indicates the node has been superseded or retired.',
    `liquidity_score` DECIMAL(18,2) COMMENT 'A quantitative measure of market liquidity for this tenor, typically ranging from 0 (illiquid) to 100 (highly liquid). Based on factors such as bid-offer spread, trading volume, and market depth.',
    `market_quote` DECIMAL(18,2) COMMENT 'The raw market-quoted rate for this tenor before any adjustments or transformations. May differ from zero_rate or par_rate depending on quotation convention. Expressed as a decimal.',
    `maturity_date` DATE COMMENT 'The calendar date corresponding to the maturity of this tenor, calculated as effective_date plus tenor_days, adjusted for business day conventions.',
    `mid_rate` DECIMAL(18,2) COMMENT 'The mid-point between the bid and offer rates, calculated as (bid_rate + offer_rate) / 2. Commonly used for fair value pricing and mark-to-market (MTM) valuation. Expressed as a decimal.',
    `model_version` STRING COMMENT 'The version identifier of the valuation model used to generate this node rate. Enables model change tracking and audit trail for regulatory compliance.',
    `node_sequence` STRING COMMENT 'The ordinal position of this node within the yield curve, ordered by increasing tenor. Used for curve traversal and interpolation logic.',
    `observation_timestamp` TIMESTAMP COMMENT 'The precise date and time when this yield curve node rate was observed or calculated. Typically aligned with market close or a specific fixing time (e.g., 4:00 PM London time for LIBOR, SOFR fixing time).',
    `offer_rate` DECIMAL(18,2) COMMENT 'The offer (ask) side of the market quote for this tenor, representing the rate at which market makers are willing to sell the instrument. Expressed as a decimal. Used for bid-offer spread analysis.',
    `par_rate` DECIMAL(18,2) COMMENT 'The coupon rate at which a bond with this maturity would trade at par (face value). Expressed as a decimal (e.g., 0.0350 for 3.50%). Used for pricing coupon-bearing securities.',
    `rate_source` STRING COMMENT 'The market data vendor or authoritative source from which this node rate was obtained (e.g., Bloomberg, Reuters, ICE, CME, Federal Reserve, European Central Bank, internal model). [ENUM-REF-CANDIDATE: bloomberg|reuters|ice|cme|fed|ecb|vendor|internal — 8 candidates stripped; promote to reference product]',
    `rate_type` STRING COMMENT 'The classification of the interest rate represented by this node (e.g., spot rate, forward rate, swap rate, treasury yield, LIBOR, SOFR, EURIBOR, overnight indexed swap rate). [ENUM-REF-CANDIDATE: spot|forward|swap|treasury|libor|sofr|euribor|ois — 8 candidates stripped; promote to reference product]',
    `shock_magnitude_bps` DECIMAL(18,2) COMMENT 'The magnitude of the interest rate shock applied to this tenor in a stress scenario, expressed in basis points. Positive values indicate upward shocks, negative values indicate downward shocks. Null for base case.',
    `spread_adjustment` DECIMAL(18,2) COMMENT 'Any credit spread, liquidity premium, or basis adjustment applied to the base rate for this tenor. Expressed in basis points (bps). Used for credit-adjusted discounting and CVA (Credit Valuation Adjustment) calculations.',
    `tenor_days` STRING COMMENT 'The maturity tenor expressed as the number of calendar days from the curve observation date. Used for precise interpolation and duration calculations.',
    `tenor_label` STRING COMMENT 'Standard market convention label for the maturity point on the yield curve (e.g., 1M for one month, 3M for three months, 1Y for one year, 10Y for ten years, 30Y for thirty years). [ENUM-REF-CANDIDATE: 1M|3M|6M|1Y|2Y|3Y|5Y|7Y|10Y|20Y|30Y — 11 candidates stripped; promote to reference product]',
    `updated_by` STRING COMMENT 'The user ID or system process that last modified this yield curve node record. Part of the audit trail for data governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this yield curve node record was last modified. Used for change tracking and data lineage.',
    `valuation_model` STRING COMMENT 'The quantitative model or methodology used to derive or validate this node rate (e.g., bootstrapping, Nelson-Siegel, cubic spline, Hull-White, Black-Karasinski). Used for model risk management and validation.',
    `zero_rate` DECIMAL(18,2) COMMENT 'The continuously compounded zero-coupon interest rate (spot rate) for this tenor, expressed as a decimal (e.g., 0.0325 for 3.25%). Used for discounting cash flows and pricing zero-coupon instruments.',
    `created_by` STRING COMMENT 'The user ID or system process that created this yield curve node record. Part of the audit trail for data governance.',
    CONSTRAINT pk_yield_curve_node PRIMARY KEY(`yield_curve_node_id`)
) COMMENT 'Individual tenor-rate data points that constitute a yield curve. Each node captures the yield curve reference, tenor label (1M, 3M, 6M, 1Y, 2Y, 5Y, 10Y, 30Y), tenor in days, zero rate, par rate, forward rate, discount factor, and the interpolation method applied between nodes. Enables granular curve analytics, sensitivity calculations (DV01 by tenor bucket), and regulatory stress scenario application across the full term structure.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`credit_rating` (
    `credit_rating_id` BIGINT COMMENT 'Primary key for credit_rating',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: External agency ratings (S&P, Moodys, Fitch) feed internal counterparty rating models for PD calibration and validation. IRB models use external ratings as benchmarking input. Required for model risk',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument being rated.',
    `party_id` BIGINT COMMENT 'Reference to the issuer entity whose creditworthiness is being assessed.',
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

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument_lifecycle` (
    `instrument_lifecycle_id` BIGINT COMMENT 'Unique identifier for the instrument lifecycle status record.',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Lifecycle failures (settlement fails, maturity processing errors, incorrect redemptions) are Basel operational risk events requiring loss capture. SMA capital calculation depends on operational loss d',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Lifecycle event payments (redemptions, calls, defaults) involve currency-specific cash flows. Essential for maturity processing, early redemption calculations, and default recovery processing in credi',
    `instrument_id` BIGINT COMMENT 'Foreign key reference to the financial instrument in the instrument master. Links this lifecycle event to the specific security (equity, bond, derivative, MBS, ABS, CDS, CLO, CDO, or OTC instrument).',
    `announcement_date` DATE COMMENT 'Date on which the lifecycle change was publicly announced by the issuer, exchange, or regulatory authority. May precede the effective date for events like calls or redemptions.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the lifecycle status change was approved. Part of the audit trail for regulatory compliance and internal controls.',
    `approved_by` STRING COMMENT 'User ID or name of the operations or middle office staff member who approved this lifecycle status change. Required for audit trail and SOX compliance.',
    `call_date` DATE COMMENT 'Date on which the issuer exercised the call option. Applicable only for callable instruments in the called lifecycle stage.',
    `call_price` DECIMAL(18,2) COMMENT 'Price at which the instrument was called by the issuer, expressed per unit in the denomination currency. Used for portfolio valuation and yield-to-call calculations.',
    `collateral_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether the instrument remains eligible as collateral for margin, repo, or securities lending. Typically false for defaulted, suspended, or delisted instruments.',
    `comments` STRING COMMENT 'Free-text field for operational notes, special instructions, or additional context about the lifecycle event. Used by operations teams for exception handling and audit documentation.',
    `credit_rating_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this lifecycle event triggered or resulted from a credit rating change. True for defaults, downgrades to distressed levels, or rating withdrawals.',
    `default_date` DATE COMMENT 'Date on which the issuer was declared in default. Triggers credit event processing for Credit Default Swaps (CDS), Expected Credit Loss (ECL) recognition, and Non-Performing Loan (NPL) classification.',
    `effective_date` DATE COMMENT 'Date on which this lifecycle stage became effective. Used for point-in-time valuation, regulatory reporting of instrument status, and corporate actions processing.',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the lifecycle stage change occurred, including time zone. Critical for intraday trading systems, market data feeds, and regulatory trade reporting where exact timing is required.',
    `end_date` DATE COMMENT 'Date on which this lifecycle stage ended and transitioned to the next stage. Null if this is the current active lifecycle stage. Enables temporal queries and historical lifecycle reconstruction.',
    `exchange_ratio` DECIMAL(18,2) COMMENT 'Ratio at which the original instrument is exchanged for the successor instrument in corporate actions. For example, 1.5 means each unit of the original instrument is exchanged for 1.5 units of the successor.',
    `lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the financial instrument. Pre-issuance indicates the instrument is registered but not yet trading; active indicates normal trading status; suspended indicates temporary halt; called indicates issuer has exercised call option; defaulted indicates issuer has failed to meet obligations; matured indicates instrument has reached maturity date; redeemed indicates early redemption; delisted indicates removal from exchange trading. [ENUM-REF-CANDIDATE: pre_issuance|active|suspended|called|defaulted|matured|redeemed|delisted — 8 candidates stripped; promote to reference product]',
    `liquidity_classification` STRING COMMENT 'Basel III Liquidity Coverage Ratio (LCR) classification of the instrument in this lifecycle stage. Level 1 HQLA includes sovereign debt and central bank reserves; Level 2A includes high-quality corporate bonds and covered bonds; Level 2B includes lower-rated corporate bonds and equities; non-HQLA are liquid but not LCR-eligible; illiquid applies to defaulted, suspended, or delisted instruments.. Valid values are `level_1_hqla|level_2a_hqla|level_2b_hqla|non_hqla|illiquid`',
    `maturity_date` DATE COMMENT 'Scheduled maturity date of the instrument. Copied from the instrument master for convenience in lifecycle reporting. Used for duration calculations, yield curve construction, and Asset-Liability Management (ALM).',
    `payment_amount` DECIMAL(18,2) COMMENT 'Per-unit payment amount for redemption, call, or maturity. Expressed in the instruments denomination currency. Used for portfolio cash flow projections and accrual calculations.',
    `payment_date` DATE COMMENT 'Date on which final payment, redemption proceeds, or maturity value is scheduled to be paid to holders. Applicable for matured, redeemed, or called instruments.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the lifecycle stage change. Issuer call indicates issuer exercised call provision; mandatory redemption indicates contractual redemption event; maturity indicates scheduled maturity date reached; issuer default indicates payment default or covenant breach; regulatory suspension indicates regulator-imposed trading halt; exchange delisting indicates exchange-initiated removal; corporate action indicates merger, acquisition, or spin-off; voluntary redemption indicates optional early redemption; credit event indicates CDS trigger event; restructuring indicates debt restructuring. [ENUM-REF-CANDIDATE: issuer_call|mandatory_redemption|maturity|issuer_default|regulatory_suspension|exchange_delisting|corporate_action|voluntary_redemption|credit_event|restructuring — 10 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text description providing additional context and details about the lifecycle stage change. May include references to specific contractual provisions, regulatory orders, or corporate action announcements.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle record was first created in the data warehouse. Part of the technical audit trail for data lineage and reconciliation.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle record was last updated in the data warehouse. Enables change tracking and incremental processing.',
    `recovery_rate` DECIMAL(18,2) COMMENT 'Expected recovery rate for defaulted instruments, expressed as a decimal (e.g., 0.4000 for 40% recovery). Used for Loss Given Default (LGD) calculations, Expected Credit Loss (ECL) provisioning under IFRS 9 and CECL, and Credit Valuation Adjustment (CVA) calculations.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number of the regulatory filing associated with this lifecycle event. May be an SEC Form 8-K filing number, exchange notice number, or other regulatory submission identifier.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this lifecycle event must be reported to regulatory authorities. True for material events like defaults, suspensions, and delistings that trigger FINRA, SEC, or MiFID II reporting obligations.',
    `reporting_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the primary regulatory jurisdiction for this lifecycle event. Determines which regulatory reporting requirements apply.. Valid values are `^[A-Z]{3}$`',
    `risk_weight_adjustment_flag` BOOLEAN COMMENT 'Boolean indicator of whether this lifecycle change requires recalculation of Risk-Weighted Assets (RWA) for regulatory capital purposes under Basel III. True for defaults, rating changes, or maturity changes that affect risk weighting.',
    `settlement_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether existing trades in this instrument can still settle through central clearing. May be false for defaulted or delisted instruments even if trading has ceased.',
    `source_system` STRING COMMENT 'Name of the operational system that initiated or recorded this lifecycle status change. Typically the trading system, corporate actions system, or regulatory reporting platform.',
    `source_system_code` STRING COMMENT 'Unique identifier of this lifecycle record in the source system. Enables traceability and reconciliation back to the originating system of record.',
    `trading_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether the instrument remains eligible for trading in this lifecycle stage. False for suspended, defaulted, matured, redeemed, or delisted instruments; true for active and pre-issuance stages.',
    `triggering_event_reference` STRING COMMENT 'External reference identifier for the event that triggered this lifecycle change. May be a corporate action ID, regulatory filing number, exchange notice number, or credit event determination committee ruling reference.',
    `valuation_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this lifecycle change requires immediate portfolio revaluation. True for events like default, suspension, or delisting that materially affect fair value; false for routine transitions.',
    CONSTRAINT pk_instrument_lifecycle PRIMARY KEY(`instrument_lifecycle_id`)
) COMMENT 'Tracks the complete lifecycle status history of financial instruments from issuance through maturity, redemption, or delisting. Captures lifecycle stage (pre-issuance, active, suspended, called, defaulted, matured, redeemed, delisted), effective date, reason code, triggering event reference, and the source system that initiated the status change. Supports regulatory reporting of instrument status, portfolio valuation adjustments for defaulted/distressed securities, and corporate actions processing workflows.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`coupon_schedule` (
    `coupon_schedule_id` BIGINT COMMENT 'Unique identifier for the coupon payment schedule entry.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Floating rate coupon schedules reference benchmark indices for rate resets. The existing reference_rate_index (STRING) should be replaced with a proper FK to the benchmark product to link to the autho',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Payment date adjustments require calendar reference for accurate settlement date calculation. Essential for cash management, liquidity forecasting, and automated payment processing in securities servi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Each coupon payment settles in specific currency for cash flow forecasting and FX hedging. Essential for multi-currency bond portfolio cash flow projections and liquidity risk management.',
    `instrument_id` BIGINT COMMENT 'Reference to the fixed income security instrument for which this coupon schedule applies.',
    `accrual_end_date` DATE COMMENT 'The date on which interest accrual ends for this coupon period.',
    `accrual_start_date` DATE COMMENT 'The date on which interest accrual begins for this coupon period.',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'The cumulative interest accrued from the accrual start date to the current date or accrual end date, used for Mark-to-Market (MTM) valuation and settlement.',
    `actual_coupon_amount` DECIMAL(18,2) COMMENT 'The actual coupon payment amount after rate reset (for floating rate instruments) or final calculation. Populated after payment determination.',
    `business_day_convention` STRING COMMENT 'The convention used to adjust payment dates that fall on non-business days.. Valid values are `following|modified_following|preceding|unadjusted`',
    `calculation_agent` STRING COMMENT 'The entity responsible for calculating the coupon payment amount, typically the issuer or a designated third party.',
    `coupon_period_number` STRING COMMENT 'Sequential number identifying the coupon period within the instruments lifecycle (e.g., 1, 2, 3...).',
    `coupon_rate` DECIMAL(18,2) COMMENT 'The interest rate applicable to this coupon period, expressed as a decimal (e.g., 0.0525 for 5.25%). For floating rate instruments, this is the reset rate for the period.',
    `coupon_type` STRING COMMENT 'Classification of the coupon rate structure for this period.. Valid values are `fixed|floating|zero|step_up|step_down|variable`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this coupon schedule record was first created in the system.',
    `day_count_convention` STRING COMMENT 'The day count basis used to calculate the accrued interest for this coupon period.. Valid values are `30/360|actual/360|actual/365|actual/actual`',
    `day_count_fraction` DECIMAL(18,2) COMMENT 'The calculated fraction of the year represented by this coupon period based on the day count convention.',
    `ex_dividend_date` DATE COMMENT 'The date on which the security begins trading without the right to receive the upcoming coupon payment.',
    `last_modified_by` STRING COMMENT 'The user or system process that last modified this coupon schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this coupon schedule record was last updated.',
    `net_coupon_amount` DECIMAL(18,2) COMMENT 'The coupon payment amount after deduction of withholding taxes and any other applicable deductions.',
    `payment_date` DATE COMMENT 'The scheduled date on which the coupon payment is due to be paid to the security holder.',
    `payment_frequency` STRING COMMENT 'The frequency at which coupon payments are made for this instrument.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `payment_method` STRING COMMENT 'The method by which the coupon payment is delivered to the security holder.. Valid values are `wire|ach|check|book_entry|euroclear|clearstream`',
    `payment_status` STRING COMMENT 'Current status of the coupon payment indicating whether it has been paid, is scheduled, or has been missed or deferred.. Valid values are `scheduled|paid|missed|deferred|cancelled`',
    `payment_timestamp` TIMESTAMP COMMENT 'The actual date and time when the coupon payment was executed. Null if payment has not yet occurred.',
    `principal_amount` DECIMAL(18,2) COMMENT 'The outstanding principal balance of the security on which the coupon interest is calculated for this period.',
    `projected_coupon_amount` DECIMAL(18,2) COMMENT 'The estimated coupon payment amount calculated at schedule creation time, used for cash flow projection and Net Interest Income (NII) forecasting.',
    `rate_reset_date` DATE COMMENT 'The date on which the floating rate is reset based on the reference rate index. Applicable only to floating rate instruments.',
    `record_date` DATE COMMENT 'The date on which the holder of record is entitled to receive the coupon payment.',
    `reference_rate_value` DECIMAL(18,2) COMMENT 'The observed value of the reference rate index on the rate reset date, used to calculate the floating coupon rate.',
    `source_system` STRING COMMENT 'The operational system from which this coupon schedule record originated (e.g., Murex, Calypso, SimCorp Dimension).',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this coupon schedule entry in the source system.',
    `spread_bps` DECIMAL(18,2) COMMENT 'The fixed spread in basis points (BPS) added to the reference rate for floating rate instruments (e.g., SOFR + 150 bps).',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The tax rate applied to the coupon payment for withholding tax purposes, expressed as a decimal (e.g., 0.15 for 15%).',
    `created_by` STRING COMMENT 'The user or system process that created this coupon schedule record.',
    CONSTRAINT pk_coupon_schedule PRIMARY KEY(`coupon_schedule_id`)
) COMMENT 'Detailed coupon payment schedule for fixed income instruments defining each periodic interest payment. Captures instrument reference, coupon period number, accrual start date, accrual end date, payment date, coupon rate (fixed or floating reset), day count fraction, projected coupon amount, actual coupon amount (post-reset), payment currency, and payment status (scheduled/paid/missed/deferred). Supports cash flow projection, NII forecasting, ALM gap analysis, and bond analytics (duration, convexity, DV01).';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`index_constituent` (
    `index_constituent_id` BIGINT COMMENT 'Unique identifier for the index constituent membership record.',
    `index_instrument_id` BIGINT COMMENT 'Reference to the financial index (S&P 500, MSCI World, Bloomberg Barclays Aggregate, CDX, iTraxx) to which this constituent belongs.',
    `instrument_id` BIGINT COMMENT 'Reference to the security instrument that is a constituent member of the index.',
    `benchmark_eligible_flag` BOOLEAN COMMENT 'Indicates whether this constituent is eligible for use in benchmark attribution and performance measurement.',
    `capping_factor` DECIMAL(18,2) COMMENT 'The capping adjustment factor applied to limit the maximum weight of this constituent in the index, used for diversification requirements.',
    `constituent_status` STRING COMMENT 'Current membership status of the security within the index.. Valid values are `active|pending_inclusion|pending_exclusion|excluded|suspended`',
    `country_classification` STRING COMMENT 'The country classification assigned to this constituent for index purposes, typically based on domicile or primary listing location.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this index constituent record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A quantitative score (0-100) representing the completeness and accuracy of this constituent record.',
    `effective_date` DATE COMMENT 'The date from which this constituent membership record is effective for index calculation and reporting purposes.',
    `etf_creation_basket_flag` BOOLEAN COMMENT 'Indicates whether this constituent is included in the ETF creation/redemption basket for index-tracking ETFs.',
    `exclusion_date` DATE COMMENT 'The date on which the security was removed from the index, if applicable. Null for active constituents.',
    `free_float_factor` DECIMAL(18,2) COMMENT 'The free float adjustment factor applied to this constituent, representing the proportion of shares available for public trading (0 to 1).',
    `inclusion_date` DATE COMMENT 'The date on which the security was added to the index as a constituent member.',
    `index_code` STRING COMMENT 'The standard market code or ticker symbol for the index (e.g., SPX for S&P 500, MXWO for MSCI World).',
    `index_divisor_impact` DECIMAL(18,2) COMMENT 'The impact of this constituent change on the index divisor, used to maintain index continuity during rebalancing events.',
    `index_family` STRING COMMENT 'The family or series to which this index belongs (e.g., S&P 500 family, MSCI World family).',
    `index_provider` STRING COMMENT 'The organization that publishes and maintains the index (e.g., S&P Dow Jones Indices, MSCI, FTSE Russell, Bloomberg).',
    `index_type` STRING COMMENT 'The asset class type of the index to which this constituent belongs.. Valid values are `equity|fixed_income|commodity|credit|multi_asset|alternative`',
    `index_weight` DECIMAL(18,2) COMMENT 'The proportional weight of this constituent within the index, expressed as a decimal (e.g., 0.0325 for 3.25%). Used for weighted index calculations.',
    `industry_classification` STRING COMMENT 'The industry classification of this constituent within the index framework, providing finer granularity than sector.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this index constituent record was last modified or updated.',
    `last_verified_date` DATE COMMENT 'The date on which this constituent membership and attributes were last verified against the index provider source.',
    `liquidity_score` DECIMAL(18,2) COMMENT 'A quantitative score representing the trading liquidity of this constituent, used for index eligibility and weighting decisions.',
    `market_cap_tier` STRING COMMENT 'The market capitalization tier classification of this constituent (large, mid, small, micro cap).. Valid values are `large_cap|mid_cap|small_cap|micro_cap`',
    `market_cap_weight` DECIMAL(18,2) COMMENT 'The market capitalization-based weight of this constituent, used for market-cap weighted indices. Represents the proportion of total index market cap.',
    `minimum_liquidity_threshold` DECIMAL(18,2) COMMENT 'The minimum liquidity threshold (typically measured in average daily trading volume or value) required for this constituent to remain in the index.',
    `par_weight` DECIMAL(18,2) COMMENT 'The par value-based weight for bond index constituents, representing the proportion of total index par value. Applicable primarily to fixed income indices.',
    `passive_investment_eligible_flag` BOOLEAN COMMENT 'Indicates whether this constituent is eligible for inclusion in passive investment strategies and index-tracking portfolios.',
    `rebalancing_event_date` DATE COMMENT 'The date on which the rebalancing event occurred that affected this constituent membership or weight.',
    `rebalancing_event_type` STRING COMMENT 'The type of event that triggered the inclusion, exclusion, or weight adjustment of this constituent. [ENUM-REF-CANDIDATE: scheduled|corporate_action|market_cap_change|liquidity_review|sector_reclassification|ipo_inclusion|delisting|merger|acquisition|spin_off — 10 candidates stripped; promote to reference product]',
    `rebalancing_frequency` STRING COMMENT 'The frequency at which the index reviews and adjusts constituent membership and weights. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|event_driven — 7 candidates stripped; promote to reference product]',
    `region_classification` STRING COMMENT 'The regional classification of this constituent within the index framework.. Valid values are `north_america|europe|asia_pacific|emerging_markets|developed_markets|frontier_markets`',
    `sector_classification` STRING COMMENT 'The sector classification of this constituent within the index framework (e.g., Technology, Financials, Healthcare).',
    `shares_held` DECIMAL(18,2) COMMENT 'The number of shares of this security held in the index for calculation purposes. Used in share-weighted and market-cap weighted indices.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this constituent record in the source system.',
    `source_system` STRING COMMENT 'The system of record from which this index constituent data was sourced (e.g., Bloomberg, MSCI, S&P Capital IQ).',
    `weight_percentage` DECIMAL(18,2) COMMENT 'The weight of this constituent expressed as a percentage of the total index (e.g., 3.25000 for 3.25%). Derived from index_weight for reporting convenience.',
    `weighting_methodology` STRING COMMENT 'The methodology used to calculate the weight of this constituent within the index. [ENUM-REF-CANDIDATE: market_cap|equal_weight|fundamental|price_weighted|float_adjusted|gdp_weighted|revenue_weighted — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_index_constituent PRIMARY KEY(`index_constituent_id`)
) COMMENT 'Membership records defining which securities are constituents of financial indices (S&P 500, MSCI World, Bloomberg Barclays Aggregate, CDX, iTraxx). Captures index identifier, constituent instrument, inclusion date, exclusion date, index weight, market cap weight, par weight (for bond indices), rebalancing frequency, and the rebalancing event that triggered inclusion/exclusion. Supports passive portfolio management, index tracking, benchmark attribution, and ETF creation/redemption basket construction.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`security_watchlist` (
    `security_watchlist_id` BIGINT COMMENT 'Unique identifier for the security watchlist entry.',
    `instrument_id` BIGINT COMMENT 'Reference to the security instrument subject to the watchlist restriction.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Watchlists track restrictions on both instruments and issuers. The existing issuer_lei (STRING) should be supplemented with a proper FK to the issuer product to enable joining to full issuer details i',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Watchlist restrictions are jurisdiction-specific (EU sanctions, OFAC, country-specific regulations). Essential for pre-trade compliance checks, order routing restrictions, and regulatory reporting in ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Banks maintain employee-specific security watchlists for compliance (insider trading, conflicts of interest, personal account restrictions). Pre-trade systems check if employee is restricted from trad',
    `alert_notification_recipients` STRING COMMENT 'Comma-separated list of email addresses or distribution lists to be notified when a transaction triggers this watchlist entry.',
    `applicable_business_units` STRING COMMENT 'Comma-separated list of business units or Lines of Business (LOB) to which this restriction applies (e.g., Wealth Management, Asset Management, Proprietary Trading). Null indicates firm-wide restriction.',
    `applicable_client_segments` STRING COMMENT 'Comma-separated list of client segments to which this restriction applies (e.g., retail, institutional, high_net_worth, pension_funds). Null indicates applies to all client types.',
    `approving_authority` STRING COMMENT 'Name or identifier of the internal authority or committee that approved the watchlist entry (e.g., Chief Compliance Officer, Investment Committee, Risk Committee).',
    `best_execution_impact_flag` BOOLEAN COMMENT 'Indicates whether this restriction impacts best execution analysis and venue selection. True = restriction affects execution strategy, False = no best execution impact.',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to this watchlist restriction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this watchlist entry record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the watchlist restriction becomes active and enforceable.',
    `esg_exclusion_category` STRING COMMENT 'Category of ESG exclusion if the restriction is ESG-related (e.g., fossil fuels, tobacco, weapons, human rights violations, environmental damage). [ENUM-REF-CANDIDATE: fossil_fuels|tobacco|weapons|gambling|adult_entertainment|human_rights_violations|environmental_damage|animal_testing — promote to reference product]',
    `expiry_date` DATE COMMENT 'Date when the watchlist restriction expires and is no longer enforced. Null indicates indefinite restriction.',
    `geographic_scope` STRING COMMENT 'Geographic jurisdictions where this restriction applies using ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, DEU). Null indicates global restriction.',
    `issuer_lei` STRING COMMENT 'Legal Entity Identifier of the issuer subject to the watchlist restriction. Used when the restriction applies to all securities of a specific issuer rather than a single instrument.. Valid values are `^[A-Z0-9]{20}$`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this watchlist entry record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this watchlist entry record was last updated.',
    `last_review_date` DATE COMMENT 'Date when this watchlist entry was last reviewed by compliance or risk management for continued relevance and accuracy.',
    `list_type` STRING COMMENT 'Type of watchlist or restriction list. OFAC = Office of Foreign Assets Control sanctions, SDN = Specially Designated Nationals, restricted_securities = insider trading restrictions, investment_policy_exclusion = internal policy-based exclusions, ESG_exclusion = Environmental Social Governance screens, sector_exclusion = sector-based exclusions, regulatory_restricted = regulatory product governance restrictions. [ENUM-REF-CANDIDATE: OFAC|SDN|restricted_securities|investment_policy_exclusion|ESG_exclusion|sector_exclusion|regulatory_restricted — 7 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this watchlist entry to ensure ongoing compliance and relevance.',
    `override_allowed_flag` BOOLEAN COMMENT 'Indicates whether authorized personnel can override this restriction with proper approval. True = override permitted with documented justification, False = no override allowed.',
    `override_approval_level` STRING COMMENT 'Required approval authority level for override if override_allowed_flag is True (e.g., Compliance Officer, Chief Risk Officer, Investment Committee). Null if override not allowed.',
    `post_trade_monitoring_flag` BOOLEAN COMMENT 'Indicates whether executed trades should be monitored against this restriction for compliance reporting. True = post-trade surveillance active, False = no post-trade monitoring.',
    `pre_trade_check_required_flag` BOOLEAN COMMENT 'Indicates whether this restriction must be checked before trade execution. True = pre-trade compliance check mandatory, False = post-trade monitoring only.',
    `regulatory_authority` STRING COMMENT 'External regulatory body or legal framework that mandated the restriction (e.g., OFAC, SEC, FINRA, MiFID II, SFDR). Null for internal policy-driven restrictions.',
    `regulatory_reference_number` STRING COMMENT 'Official reference number or citation from the regulatory authority for this restriction (e.g., OFAC sanction program number, SEC order number).',
    `restriction_level` STRING COMMENT 'Severity level of the restriction. hard_block = trading is prohibited and will be rejected, soft_alert = trading is allowed but generates compliance alert, advisory = informational only.. Valid values are `hard_block|soft_alert|advisory`',
    `restriction_reason` STRING COMMENT 'Detailed business reason for the restriction including regulatory citation, internal policy reference, or compliance rationale.',
    `restriction_scope` STRING COMMENT 'Scope of transactions affected by the restriction. all_transactions = applies to all buy and sell orders, buy_only = only new purchases restricted, sell_only = only sales restricted, new_positions = only opening new positions restricted, existing_positions = only existing holdings affected.. Valid values are `all_transactions|buy_only|sell_only|new_positions|existing_positions`',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of this watchlist entry. Used to calculate next_review_date.',
    `sector_exclusion_code` STRING COMMENT 'Industry sector code subject to exclusion using standard classification (e.g., GICS sector code, NAICS code). Used for sector-based investment policy restrictions.',
    `security_watchlist_status` STRING COMMENT 'Current lifecycle status of the watchlist entry. active = currently enforced, expired = past expiry date, suspended = temporarily not enforced, pending_approval = awaiting compliance approval, cancelled = permanently removed.. Valid values are `active|expired|suspended|pending_approval|cancelled`',
    `sfdr_classification` STRING COMMENT 'SFDR article classification for ESG-related restrictions. Article_6 = no sustainability objective, Article_8 = promotes environmental or social characteristics, Article_9 = has sustainable investment objective, not_applicable = restriction not related to SFDR.. Valid values are `Article_6|Article_8|Article_9|not_applicable`',
    `source_system` STRING COMMENT 'Name of the source system or platform that originated this watchlist entry (e.g., NICE Actimize, internal compliance system, regulatory feed).',
    `source_system_identifier` STRING COMMENT 'Unique identifier of this watchlist entry in the source system for reconciliation and audit trail purposes.',
    `suitability_assessment_required_flag` BOOLEAN COMMENT 'Indicates whether client suitability assessment must be performed before allowing transactions in this security. True = suitability check mandatory, False = no suitability requirement.',
    `created_by` STRING COMMENT 'User identifier or system account that created this watchlist entry record.',
    CONSTRAINT pk_security_watchlist PRIMARY KEY(`security_watchlist_id`)
) COMMENT 'Regulatory and internal investment restriction watchlists applied to securities and issuers including OFAC/SDN sanctioned securities, restricted securities lists (insider trading restrictions), investment policy exclusion lists (ESG screens, sector exclusions), and regulatory restricted lists (MiFID II product governance, SFDR Article 6/8/9 classification). Captures list type, instrument or issuer reference, restriction reason, restriction level (hard block/soft alert), effective date, expiry date, approving authority, and the regulatory or internal authority that imposed the restriction. Consumed by trade, investment, and wealth domains for pre-trade and post-trade compliance checking, best execution monitoring, and suitability assessment.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument_relationship` (
    `instrument_relationship_id` BIGINT COMMENT 'Unique identifier for the instrument relationship record. Primary key.',
    `instrument_id` BIGINT COMMENT 'Identifier of the source financial instrument in the relationship. For example, the convertible bond in a convertible-to-equity relationship, or the ADR in an ADR-to-ordinary-share relationship.',
    `target_instrument_id` BIGINT COMMENT 'Identifier of the target financial instrument in the relationship. For example, the underlying equity in a convertible-to-equity relationship, or the ordinary share underlying an ADR.',
    `related_instrument_relationship_id` BIGINT COMMENT 'Self-referencing FK on instrument_relationship (related_instrument_relationship_id)',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations, or context regarding the instrument relationship. Used to capture special conditions, exceptions, or clarifications.',
    `conversion_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the conversion price is denominated.. Valid values are `^[A-Z]{3}$`',
    `conversion_price` DECIMAL(18,2) COMMENT 'Price at which the source instrument can be converted into the target instrument. Applicable for convertible bonds, warrants, and similar instruments with conversion features.',
    `conversion_ratio` DECIMAL(18,2) COMMENT 'Numeric ratio defining the conversion or exchange rate between the source and target instruments. For example, the number of ordinary shares received per convertible bond, or the ratio of ADR to underlying ordinary shares. Expressed as a decimal value.',
    `corporate_action_propagation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether corporate actions on the target instrument should be propagated to the source instrument. True if propagation is required, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument relationship record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing the quality and completeness of the instrument relationship data, typically on a scale of 0 to 100. Higher scores indicate higher data quality and confidence.',
    `effective_date` DATE COMMENT 'Date when the instrument relationship becomes effective and valid for use in corporate actions propagation, risk aggregation, and regulatory reporting.',
    `exercise_style` STRING COMMENT 'Exercise style of the conversion or exercise right. American style allows exercise at any time before expiry, European style allows exercise only at expiry, and Bermudan style allows exercise on specific dates.. Valid values are `american|european|bermudan`',
    `expiry_date` DATE COMMENT 'Date when the instrument relationship expires or ceases to be valid. Nullable for relationships without a defined expiration such as perpetual ADR structures.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this instrument relationship record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument relationship record was last updated or modified. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_verified_date` DATE COMMENT 'Date when the instrument relationship data was last verified or validated by a data steward, reference data team, or automated quality process.',
    `look_through_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether regulatory look-through to the underlying instrument is required for transparency and reporting purposes under MiFID II, FRTB, or other regulatory frameworks. True if look-through is required, false otherwise.',
    `mandatory_voluntary_indicator` STRING COMMENT 'Indicates whether the conversion or exercise of the relationship is mandatory (automatic) or voluntary (at the holders discretion).. Valid values are `mandatory|voluntary`',
    `notional_amount` DECIMAL(18,2) COMMENT 'Notional principal amount of the relationship, applicable for derivative-to-underlier relationships where the notional defines the scale of exposure to the underlying instrument.',
    `notional_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the notional amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this instrument relationship must be reported to regulatory authorities for transparency, systemic risk monitoring, or compliance purposes. True if reporting is required, false otherwise.',
    `relationship_direction` STRING COMMENT 'Directionality of the instrument relationship. Source-to-target indicates a one-way relationship from source to target, target-to-source indicates the reverse, and bidirectional indicates a two-way relationship.. Valid values are `source_to_target|target_to_source|bidirectional`',
    `relationship_priority` STRING COMMENT 'Priority ranking of this relationship when multiple relationships exist for the same source instrument. Lower numbers indicate higher priority. Used to determine which relationship to apply in corporate actions and risk calculations.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the instrument relationship. Indicates whether the relationship is currently active, inactive, pending activation, expired, terminated, or temporarily suspended.. Valid values are `active|inactive|pending|expired|terminated|suspended`',
    `relationship_type` STRING COMMENT 'Type of relationship between the source and target instruments. Defines the nature of the linkage such as convertible bond to underlying equity, American Depositary Receipt (ADR) to ordinary share, Global Depositary Receipt (GDR) to ordinary share, warrant to underlying security, Exchange-Traded Fund (ETF) to underlying basket constituent, or derivative to underlier. [ENUM-REF-CANDIDATE: convertible_to_equity|adr_to_ordinary|gdr_to_ordinary|warrant_to_underlying|etf_to_constituent|derivative_to_underlier|option_to_underlying|future_to_underlying|swap_to_reference|cds_to_reference|structured_product_to_collateral|preferred_to_common|rights_to_underlying — promote to reference product]. Valid values are `convertible_to_equity|adr_to_ordinary|gdr_to_ordinary|warrant_to_underlying|etf_to_constituent|derivative_to_underlier`',
    `reporting_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the regulatory jurisdiction to which this instrument relationship must be reported.. Valid values are `^[A-Z]{3}$`',
    `risk_aggregation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether risk exposures should be aggregated across the related instruments for risk management and regulatory capital calculations. True if aggregation is required, false otherwise.',
    `settlement_type` STRING COMMENT 'Method of settlement for the relationship upon conversion or exercise. Physical settlement delivers the underlying instrument, cash settlement pays the cash equivalent, and net share settlement delivers shares net of any exercise cost.. Valid values are `physical|cash|net_share`',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this instrument relationship record originated, such as trading system, reference data platform, or corporate actions system.',
    `source_system_identifier` STRING COMMENT 'Unique identifier or reference number for this instrument relationship record in the source system, used for traceability and reconciliation.',
    `strike_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the strike price is denominated.. Valid values are `^[A-Z]{3}$`',
    `strike_price` DECIMAL(18,2) COMMENT 'Strike or exercise price applicable to warrant-to-underlying or option-to-underlying relationships. The price at which the holder can exercise the right to acquire the underlying instrument.',
    `verification_source` STRING COMMENT 'Source or authority that verified the accuracy of the instrument relationship, such as Bloomberg, Reuters, issuer prospectus, or internal data steward.',
    `weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight of the target instrument within the source instrument, applicable for ETF-to-constituent and index-to-constituent relationships. Expressed as a decimal percentage (e.g., 2.50000 for 2.5%).',
    `created_by` STRING COMMENT 'User identifier or system account that created this instrument relationship record. Used for audit trail and accountability.',
    CONSTRAINT pk_instrument_relationship PRIMARY KEY(`instrument_relationship_id`)
) COMMENT 'Cross-reference records defining relationships between financial instruments such as convertible bond to underlying equity, ADR/GDR to ordinary share, warrant to underlying, ETF to underlying basket, and derivative to underlier. Captures relationship type, source instrument, target instrument, conversion ratio, effective date, and expiry date. Supports corporate actions propagation, risk aggregation across related instruments, and regulatory look-through requirements (MiFID II, FRTB).';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`prospectus` (
    `prospectus_id` BIGINT COMMENT 'Unique identifier for the prospectus record. Primary key.',
    `instrument_id` BIGINT COMMENT 'Reference to the security instrument for which this prospectus was filed.',
    `issuer_id` BIGINT COMMENT 'Reference to the issuer entity that filed this prospectus.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Every prospectus is filed under specific regulatory regime (SEC, FCA, ESMA). Essential for compliance tracking, document retention requirements, and regulatory reporting obligations in capital markets',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Offering terms are currency-specific for subscription processing and allocation. Essential for new issue processing, syndicate management, and investor subscription accounting in investment banking op',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Prospectus errors/omissions trigger regulatory fines, investor lawsuits, and reputational damage - all operational risk events under Basel Event Type 7 (Clients, Products & Business Practices). Requir',
    `superseded_prospectus_id` BIGINT COMMENT 'Reference to the previous prospectus that this document supersedes or amends.',
    `previous_prospectus_id` BIGINT COMMENT 'Self-referencing FK on prospectus (previous_prospectus_id)',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment if this is an amended prospectus.',
    `auditor_name` STRING COMMENT 'Name of the independent auditor who audited the financial statements in the prospectus.',
    `cik_number` STRING COMMENT 'SEC Central Index Key number identifying the issuer.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospectus record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated data quality score for completeness and accuracy of extracted prospectus data.',
    `dividend_policy` STRING COMMENT 'Description of the issuers dividend policy as stated in the prospectus.',
    `document_format` STRING COMMENT 'File format of the prospectus document.. Valid values are `PDF|HTML|XML|XBRL`',
    `document_number` STRING COMMENT 'Official document or filing number assigned by the regulatory authority.',
    `document_url` STRING COMMENT 'URL or file path to the full prospectus document.',
    `effective_date` DATE COMMENT 'Date the prospectus became effective and the offering could commence.',
    `expiration_date` DATE COMMENT 'Date the prospectus expires and is no longer valid for offering securities.',
    `extraction_method` STRING COMMENT 'Method used to extract structured data from the prospectus document.. Valid values are `manual|ocr|api|xml_parse|automated`',
    `filing_date` DATE COMMENT 'Date the prospectus was filed with the regulatory authority.',
    `fiscal_year_end` STRING COMMENT 'Fiscal year end date of the issuer in MM-DD format.. Valid values are `^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$`',
    `greenshoe_option_flag` BOOLEAN COMMENT 'Indicates whether the offering includes an over-allotment or greenshoe option.',
    `greenshoe_shares` BIGINT COMMENT 'Number of additional shares available under the greenshoe option.',
    `incorporation_jurisdiction` STRING COMMENT 'Three-letter country code of the jurisdiction where the issuer is incorporated.. Valid values are `^[A-Z]{3}$`',
    `language_code` STRING COMMENT 'Two-letter ISO language code of the prospectus document.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospectus record was last updated in the system.',
    `legal_counsel_name` STRING COMMENT 'Name of the law firm serving as legal counsel for the offering.',
    `listing_exchange` STRING COMMENT 'Market Identifier Code of the exchange where the security will be listed.',
    `lock_up_period_days` STRING COMMENT 'Number of days insiders are restricted from selling shares after the offering.',
    `offering_amount` DECIMAL(18,2) COMMENT 'Total monetary value of securities being offered under this prospectus.',
    `offering_type` STRING COMMENT 'Type of securities offering described in the prospectus.. Valid values are `ipo|secondary|rights|private_placement|public|follow_on`',
    `page_count` STRING COMMENT 'Total number of pages in the prospectus document.',
    `price_per_share` DECIMAL(18,2) COMMENT 'Offering price per share or unit as stated in the prospectus.',
    `prospectus_status` STRING COMMENT 'Current lifecycle status of the prospectus document. [ENUM-REF-CANDIDATE: draft|filed|effective|withdrawn|expired|amended|superseded — 7 candidates stripped; promote to reference product]',
    `prospectus_type` STRING COMMENT 'Type of prospectus document filed with regulatory authorities. [ENUM-REF-CANDIDATE: preliminary|final|shelf|supplement|base|amended|post-effective — 7 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority with which the prospectus was filed. [ENUM-REF-CANDIDATE: SEC|FCA|ESMA|ASIC|MAS|HKMA|FSA|FINMA — 8 candidates stripped; promote to reference product]',
    `risk_factors_summary` STRING COMMENT 'Summary of key risk factors disclosed in the prospectus.',
    `sec_file_number` STRING COMMENT 'SEC file number assigned to the registration statement.',
    `shares_offered` BIGINT COMMENT 'Number of shares or units being offered under this prospectus.',
    `ticker_symbol` STRING COMMENT 'Trading symbol assigned to the security on the listing exchange.',
    `underwriter_lei` STRING COMMENT 'Legal Entity Identifier of the lead underwriter.. Valid values are `^[A-Z0-9]{20}$`',
    `underwriter_name` STRING COMMENT 'Name of the lead underwriter or investment bank managing the offering.',
    `use_of_proceeds` STRING COMMENT 'Description of how the issuer intends to use the proceeds from the offering.',
    CONSTRAINT pk_prospectus PRIMARY KEY(`prospectus_id`)
) COMMENT 'Security prospectus and offering document record. Captures document type, filing date, effective date, issuer, and key terms extracted from the offering document.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument_channel_availability` (
    `instrument_channel_availability_id` BIGINT COMMENT 'Primary key for the instrument_channel_availability association',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the banking channel through which the instrument is distributed',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument being made available through the channel',
    `authentication_method_required` STRING COMMENT 'Specific authentication method(s) required for this instrument-channel combination. May be more stringent than the channels default authentication for high-value or high-risk instruments.',
    `availability_status` STRING COMMENT 'Current operational status of the instruments availability through this specific channel. Controls whether new transactions can be initiated.',
    `channel_fee_amount` DECIMAL(18,2) COMMENT 'Fixed or base fee amount charged for transacting this instrument through this channel. May be null if fee_schedule_code references a complex fee structure.',
    `customer_segment_restriction` STRING COMMENT 'Comma-separated list of customer segment codes that are permitted to transact this instrument through this channel. Instrument-channel specific restrictions that may be more granular than channel-level restrictions.',
    `effective_date` DATE COMMENT 'Date from which this instrument became available through this channel. Supports temporal queries for distribution history and regulatory reporting.',
    `fee_schedule_code` STRING COMMENT 'Reference code to the fee schedule that applies to transactions of this instrument through this channel. Different instrument-channel combinations may have different fee structures.',
    `geographic_restriction` STRING COMMENT 'Geographic restrictions specific to this instrument-channel combination (e.g., country codes where this instrument cannot be distributed through this channel due to regulatory constraints).',
    `kyc_requirement_level` STRING COMMENT 'Level of Know Your Customer verification required to transact this instrument through this channel. High-risk instruments may require enhanced KYC even through channels that normally support basic KYC.',
    `termination_date` DATE COMMENT 'Date on which this instrument was or will be removed from this channel. Null if currently active with no planned termination.',
    `transaction_limit_daily` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount allowed per customer per day for this instrument through this channel. Overrides the channels default daily limit for this specific instrument.',
    `transaction_limit_per_transaction` DECIMAL(18,2) COMMENT 'Maximum single transaction amount allowed for this instrument through this channel. Instrument-channel specific limit that may differ from channel default.',
    CONSTRAINT pk_instrument_channel_availability PRIMARY KEY(`instrument_channel_availability_id`)
) COMMENT 'This association product represents the distribution configuration between financial instruments and banking channels. It captures the operational rules, limits, fees, and compliance requirements that govern how specific instruments can be traded or accessed through specific channels. Each record links one instrument to one channel with channel-specific transaction limits, fee schedules, KYC requirements, authentication methods, and customer segment restrictions that exist only in the context of this instrument-channel combination. This is essential for MiFID II distribution strategy compliance, omnichannel orchestration, and operational risk management.. Existence Justification: In banking operations, financial instruments are distributed through multiple channels (branch, digital, relationship manager, ATM) with channel-specific operational rules, and each channel offers many instruments. The bank actively manages instrument-channel availability as a distribution strategy, configuring transaction limits, fees, KYC requirements, and customer segment restrictions for each instrument-channel combination. This is an operational business process (not analytical correlation) where relationship managers, product managers, and compliance teams create, update, and monitor these availability configurations.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`security_holding` (
    `security_holding_id` BIGINT COMMENT 'Primary key for security_holding',
    `liquidity_holding_id` BIGINT COMMENT 'Unique identifier for this instrument holding position. Primary key.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument being held',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to the legal entity holding the instrument',
    `acquisition_date` DATE COMMENT 'Date on which the legal entity acquired this position in the instrument. Used for holding period calculations and tax lot tracking.',
    `capital_charge` DECIMAL(18,2) COMMENT 'Regulatory capital charge amount required for this holding under Basel III rules. Calculated based on risk weight, exposure, and regulatory treatment.',
    `classification` STRING COMMENT 'Accounting and regulatory classification of the holding. Determines capital treatment and valuation methodology under Basel III and IFRS 9.',
    `cost_basis` DECIMAL(18,2) COMMENT 'Original acquisition cost of the position in the reporting currency. Used for P&L calculation and tax reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was created.',
    `custodian_account_number` STRING COMMENT 'Account number at the custodian bank where this specific holding is maintained for this legal entity.',
    `holding_status` STRING COMMENT 'Current operational status of the holding position.',
    `last_valuation_date` DATE COMMENT 'Date of the most recent market value update for this holding.',
    `market_value` DECIMAL(18,2) COMMENT 'Current market value of the position in the reporting currency. Updated daily based on market prices.',
    `position_quantity` DECIMAL(18,2) COMMENT 'Number of units of the instrument held by the legal entity. For bonds, represents face value; for equities, number of shares; for derivatives, number of contracts.',
    `regulatory_treatment` STRING COMMENT 'Regulatory capital treatment code for this holding under Basel III framework. Determines risk weighting and capital charge calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this holding record was last updated.',
    CONSTRAINT pk_security_holding PRIMARY KEY(`security_holding_id`)
) COMMENT 'This association product represents the ownership position between a financial instrument and a legal entity within the banking group. It captures the quantity, value, and regulatory treatment of each instrument held by each legal entity. Each record links one instrument to one legal entity with attributes that exist only in the context of this holding relationship, supporting Basel III consolidation, entity-level risk reporting, and regulatory capital calculations.. Existence Justification: In banking operations, a single financial instrument (e.g., US Treasury bond, Apple equity) is routinely held across multiple legal entities within the group for regulatory capital optimization, client segregation, and risk diversification. Conversely, each legal entity maintains a portfolio of many different instruments. The business actively manages these holdings as distinct positions with entity-specific attributes like holding classification (trading vs banking book), cost basis, acquisition date, and regulatory capital treatment that cannot reside on either the instrument or legal entity master records alone.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument_eligibility` (
    `instrument_eligibility_id` BIGINT COMMENT 'Unique identifier for this instrument-eligibility rule pairing. Primary key.',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to the eligibility rule that this instrument satisfies',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument being evaluated for collateral eligibility',
    `concentration_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of total collateral portfolio that can be allocated to this instrument under this rule. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument-eligibility rule relationship was first established in the system.',
    `effective_date` DATE COMMENT 'Date from which this instrument becomes eligible under this specific rule. Explicitly identified in detection phase relationship data.',
    `eligibility_status` STRING COMMENT 'Current status of this instrument-rule eligibility pairing: active (currently eligible), suspended (temporarily ineligible), expired (eligibility period ended), revoked (eligibility withdrawn).',
    `eligible_for_initial_margin` BOOLEAN COMMENT 'Boolean flag indicating whether this instrument is eligible to satisfy initial margin requirements under this specific rule. Explicitly identified in detection phase relationship data.',
    `eligible_for_variation_margin` BOOLEAN COMMENT 'Boolean flag indicating whether this instrument is eligible to satisfy variation margin requirements under this specific rule. Explicitly identified in detection phase relationship data.',
    `expiry_date` DATE COMMENT 'Date on which this instrument ceases to be eligible under this specific rule. Null indicates ongoing eligibility. Explicitly identified in detection phase relationship data.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Valuation discount percentage applied to this instrument when used as collateral under this specific rule. Can vary by instrument-rule combination. Explicitly identified in detection phase relationship data.',
    `last_evaluation_date` DATE COMMENT 'Date when this instrument was last evaluated against this eligibility rule by the collateral optimization engine.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this instrument-eligibility relationship record.',
    CONSTRAINT pk_instrument_eligibility PRIMARY KEY(`instrument_eligibility_id`)
) COMMENT 'This association product represents the eligibility relationship between financial instruments and collateral eligibility rules. It captures which instruments satisfy which eligibility criteria for use as collateral across different arrangements (CSA, repo, secured lending, CCP). Each record links one instrument to one eligibility rule with rule-specific haircuts, concentration limits, margin type eligibility, and effective/expiry dates that exist only in the context of this specific instrument-rule pairing.. Existence Justification: In banking collateral management, a single financial instrument can satisfy multiple eligibility rules simultaneously (e.g., a US Treasury bond may be HQLA Level 1 eligible, CCP-eligible, bilateral CSA-eligible, and repo-eligible), and each eligibility rule applies to many instruments that meet its criteria. The collateral optimization engine actively manages these instrument-rule pairings to determine eligible collateral pools, enforce concentration limits, and optimize collateral allocation across arrangements. This is an operational relationship that humans and systems create, evaluate, and update as part of collateral management business processes.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` (
    `instrument_haircut_applicability_id` BIGINT COMMENT 'Primary key for the instrument_haircut_applicability association',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to the haircut schedule that governs the valuation treatment of this instrument',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument to which this haircut schedule applies',
    `applicable_internal_model_haircut_pct` DECIMAL(18,2) COMMENT 'The specific internal model-derived haircut percentage that applies to this instrument under the banks own VaR methodology. Instrument-specific calculation based on the schedules methodology parameters.',
    `applicable_supervisory_haircut_pct` DECIMAL(18,2) COMMENT 'The specific supervisory haircut percentage from the schedule that applies to this instrument based on its credit quality, maturity, and other characteristics. Captured at the association level because the schedule defines ranges and this records the specific value for this instrument.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the application of this haircut schedule to this instrument was formally approved. Supports regulatory audit requirements.',
    `approved_by` STRING COMMENT 'Identifier of the authorized individual who approved the application of this haircut schedule to this instrument, particularly for overrides or non-standard applications.',
    `calculation_status` STRING COMMENT 'Current operational status of this haircut applicability record. Indicates whether the haircut is actively being applied in margin calculations or is suspended pending review.',
    `effective_date` DATE COMMENT 'The date from which this haircut schedule becomes applicable to this specific instrument. Supports temporal tracking of changing haircut treatments as regulatory frameworks evolve or instrument characteristics change.',
    `expiry_date` DATE COMMENT 'The date on which this haircut schedule ceases to apply to this instrument. Null indicates ongoing applicability. Supports historical tracking of haircut regime changes.',
    `holding_period_days` STRING COMMENT 'The assumed liquidation period for this specific instrument under this haircut schedule. While the schedule provides default holding periods, specific instruments may have adjusted periods based on liquidity characteristics or counterparty agreements.',
    `override_reason` STRING COMMENT 'Business justification for any manual override or adjustment to the standard schedule haircut for this specific instrument. Supports audit trail and governance requirements.',
    `volatility_adjustment_method` STRING COMMENT 'The specific volatility calculation methodology applied to this instrument under this haircut schedule. While the schedule defines available methods, the actual method used for a specific instrument may vary based on data availability and instrument characteristics.',
    CONSTRAINT pk_instrument_haircut_applicability PRIMARY KEY(`instrument_haircut_applicability_id`)
) COMMENT 'This association product represents the application of specific haircut schedules to individual financial instruments for collateral valuation and margin calculation purposes. It captures the effective haircut parameters that apply to each instrument under different regulatory frameworks, transaction types, and counterparty arrangements. Each record links one instrument to one haircut schedule with effective dates and the specific haircut percentages and methodologies that govern how that instruments value is reduced for credit risk mitigation and regulatory capital calculations.. Existence Justification: In banking collateral operations, a single financial instrument can simultaneously be subject to multiple haircut schedules depending on the regulatory framework (Basel III supervisory vs. internal models), transaction type (bilateral CSA vs. CCP-cleared), and counterparty arrangement. Conversely, each haircut schedule applies to many instruments based on their asset class, credit quality, and maturity characteristics. The business actively manages these applicability mappings as regulatory frameworks evolve, instrument characteristics change, and new collateral agreements are negotiated.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`liquidity_holding` (
    `liquidity_holding_id` BIGINT COMMENT 'Unique identifier for this liquidity holding record. Primary key.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument held in the liquidity position',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to the liquidity position snapshot containing this holding',
    `custodian_account` STRING COMMENT 'Custodian account identifier where this instrument holding is maintained, supporting reconciliation and operational liquidity tracking.',
    `encumbrance_status` STRING COMMENT 'Indicates whether the instrument holding is unencumbered (available for liquidity) or encumbered through repo, posted as collateral, or otherwise restricted. Only unencumbered holdings contribute to available liquidity.',
    `fx_rate_to_position_currency` DECIMAL(18,2) COMMENT 'Foreign exchange rate used to convert holding currency to position currency for aggregation. 1.0 if currencies match.',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'Regulatory haircut percentage applied to this instrument for LCR calculation based on HQLA classification. Expressed as decimal (e.g., 0.15 for 15% haircut). Varies by asset class, credit quality, and maturity.',
    `holding_currency` STRING COMMENT 'ISO 4217 3-letter currency code for this holding. May differ from position currency if FX conversion applied.',
    `holding_status` STRING COMMENT 'Operational status of this holding in the liquidity position: active (included in calculations), pending settlement, restricted (excluded from available liquidity), or excluded (not counted).',
    `hqla_value` DECIMAL(18,2) COMMENT 'Post-haircut value of the instrument eligible for inclusion in HQLA for LCR calculation. Calculated as market_value * (1 - haircut_percentage) if instrument qualifies as HQLA, otherwise zero.',
    `liquidity_classification` STRING COMMENT 'Basel III High-Quality Liquid Asset classification for this instrument in this position context. Level 1 (0% haircut), Level 2A (15% haircut), Level 2B (25-50% haircut), or non-HQLA.',
    `market_value` DECIMAL(18,2) COMMENT 'Current market value of the holding in the position currency at the position timestamp. Used as the basis for haircut application.',
    `maturity_bucket` STRING COMMENT 'Time-to-maturity bucket for this instrument holding used in liquidity gap analysis and stress testing (e.g., <30d, 30-90d, 90d-1y, >1y).',
    `nsfr_asf_factor` DECIMAL(18,2) COMMENT 'Available Stable Funding factor applied to this instrument for NSFR calculation, based on asset type and maturity. Expressed as decimal (e.g., 1.0 for 100% ASF).',
    `nsfr_rsf_factor` DECIMAL(18,2) COMMENT 'Required Stable Funding factor applied to this instrument for NSFR calculation, based on asset type, maturity, and encumbrance. Expressed as decimal (e.g., 0.85 for 85% RSF).',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units or nominal amount of the instrument held in this liquidity position. For bonds, represents face value; for equities, represents share count.',
    `valuation_source` STRING COMMENT 'Source system or pricing service used to obtain the market value for this holding (e.g., Bloomberg, Reuters, internal pricing model).',
    CONSTRAINT pk_liquidity_holding PRIMARY KEY(`liquidity_holding_id`)
) COMMENT 'This association product represents the operational holding of financial instruments within liquidity positions for regulatory liquidity coverage and net stable funding calculations. It captures the specific contribution of each instrument to each liquidity position snapshot, including market value, regulatory haircuts, HQLA classification, and encumbrance status. Each record links one instrument to one liquidity position with attributes that exist only in the context of this holding relationship, supporting Basel III LCR/NSFR reporting and ALCO liquidity monitoring.. Existence Justification: In banking treasury operations, liquidity positions aggregate holdings across multiple financial instruments (government bonds, corporate bonds, equities, money market instruments) to calculate regulatory liquidity ratios (LCR/NSFR) and monitor available liquid assets. Each instrument contributes to multiple liquidity position snapshots over time (daily end-of-day positions, intraday snapshots, different scenario types, different tenor buckets, different currencies). The business actively manages these holdings with instrument-specific data including regulatory haircuts, HQLA classification, encumbrance status, and market values that exist only in the context of each position snapshot.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`trading_restriction` (
    `trading_restriction_id` BIGINT COMMENT 'Unique identifier for the trading restriction record. Primary key for the association.',
    `created_by_user_employee_id` BIGINT COMMENT 'User ID of the compliance officer or system process that created the restriction record. Used for audit trail and accountability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is restricted from trading the instrument.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument that is subject to trading restrictions for the employee.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the compliance officer who last modified the restriction record. Used for audit trail and change tracking.',
    `approval_status` STRING COMMENT 'Current workflow status of the restriction record. PENDING indicates awaiting compliance officer review. APPROVED indicates active restriction. REJECTED indicates restriction request denied. EXPIRED indicates restriction passed expiry_date. REVOKED indicates manual early termination. Drives pre-trade compliance logic.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the restriction record was created. Used for audit trail and regulatory examination.',
    `effective_date` DATE COMMENT 'Date from which the trading restriction becomes active and enforceable. Used for pre-trade compliance checks to determine if restriction applies to a proposed trade.',
    `expiry_date` DATE COMMENT 'Date on which the trading restriction automatically expires and is no longer enforceable. Null for indefinite restrictions that require manual removal. Used for automated restriction lifecycle management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the last modification to the restriction record. Used for audit trail and regulatory examination.',
    `pre_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether the employee must obtain explicit compliance approval before executing any trade in this instrument. True for high-risk scenarios (MNPI exposure, investment banking relationships). False for watch-list monitoring without pre-approval requirement. Drives pre-trade compliance workflow routing.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory rule or internal policy that mandates this restriction (e.g., SEC Rule 10b-5, FINRA 5280, Internal Policy PAD-2023-01). Used for regulatory examination and policy compliance reporting.',
    `restriction_reason` STRING COMMENT 'Business justification for imposing the trading restriction. Examples include: Employee has MNPI due to M&A advisory role, Conflict of interest - employee on issuer board, Investment banking relationship, Insider status per Section 16, Research coverage restriction, Personal account dealing rule violation. Used for audit trail and regulatory examination.',
    `restriction_type` STRING COMMENT 'Classification of the trading restriction imposed on the employee for this instrument. BLACKOUT indicates temporary prohibition during material non-public information (MNPI) exposure. PRE_CLEARANCE_REQUIRED mandates approval before trading. PROHIBITED indicates permanent ban due to role-based conflicts. WATCH_LIST indicates heightened monitoring without prohibition. COOLING_OFF indicates post-transaction restriction period.',
    `source_system` STRING COMMENT 'Identifier of the system that originated the restriction (e.g., COMPLIANCE_PORTAL, TRADE_SURVEILLANCE, HR_SYSTEM). Used for data lineage and reconciliation.',
    CONSTRAINT pk_trading_restriction PRIMARY KEY(`trading_restriction_id`)
) COMMENT 'This association product represents the regulatory and compliance-driven restriction relationship between financial instruments and bank employees. It captures personal account dealing rules, insider trading prevention controls, and conflict-of-interest restrictions mandated by SEC Rule 10b-5, FINRA Rule 5280 (Personal Trading), MiFID II Article 19, and internal compliance policies. Each record links one instrument to one employee with restriction type, reason, effective dates, approval workflow status, and pre-clearance requirements. This is the authoritative source for pre-trade compliance checks, restricted list management, and audit trail for employee trading restrictions. Consumed by compliance monitoring, trade surveillance, and personal account dealing systems.. Existence Justification: In banking operations, employees can be restricted from trading multiple securities simultaneously due to material non-public information (MNPI) exposure, role-based conflicts (e.g., investment banking relationships, board memberships), or insider status. Conversely, each security can have multiple restricted employees at any given time based on their roles, project assignments, or information access. This is an operational compliance relationship actively managed by compliance officers through restricted lists, pre-clearance workflows, and trade surveillance systems.';

CREATE OR REPLACE TABLE `banking_ecm`.`security`.`constituent` (
    `constituent_id` BIGINT COMMENT 'Unique identifier for this index constituent membership record. Primary key.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to the benchmark index that contains this instrument as a constituent',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to the financial instrument that is a constituent member of the benchmark index',
    `constituent_status` STRING COMMENT 'Current lifecycle status of this constituent membership record. Active constituents are included in index calculations; pending additions/removals reflect announced but not yet effective changes.',
    `effective_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this constituent record or weight change became effective. Critical for intraday index rebalancing and real-time index calculation.',
    `exclusion_date` DATE COMMENT 'The effective date when this instrument was removed from the benchmark index. Null if the instrument is still an active constituent. Used for historical analysis and rebalancing event tracking.',
    `free_float_factor` DECIMAL(18,2) COMMENT 'The free-float adjustment factor applied to this constituent for indices using free-float market capitalization weighting. Represents the proportion of shares available for public trading (excludes strategic holdings, government ownership, cross-holdings).',
    `inclusion_date` DATE COMMENT 'The effective date when this instrument was added to the benchmark index. Critical for historical index composition reconstruction and performance attribution.',
    `rebalancing_event_type` STRING COMMENT 'Classification of the event that triggered the inclusion, exclusion, or weight change for this constituent (e.g., scheduled quarterly rebalance, corporate action, market cap threshold breach, liquidity screen failure).',
    `source_system` STRING COMMENT 'The system or data provider that published this constituent membership information (e.g., Bloomberg, MSCI, S&P Dow Jones Indices, FTSE Russell).',
    `weight_percentage` DECIMAL(18,2) COMMENT 'The weight of this instrument within the benchmark index expressed as a percentage. Used for index tracking, replication, and attribution calculations. Weight calculation method depends on the benchmarks weighting scheme (market cap, free-float, equal-weight, etc.).',
    CONSTRAINT pk_constituent PRIMARY KEY(`constituent_id`)
) COMMENT 'This association product represents the membership relationship between a financial instrument and a benchmark index. It captures the operational reality that instruments are included in indices with specific weights, inclusion/exclusion dates, and rebalancing events. Each record links one instrument to one benchmark with attributes that exist only in the context of this index membership relationship. This is the authoritative source for index composition used by passive portfolio management, ETF basket construction, benchmark attribution, and index tracking operations.. Existence Justification: In banking operations, financial instruments are constituents of multiple benchmark indices simultaneously (e.g., Apple stock is in S&P 500, NASDAQ-100, MSCI World), and each index contains hundreds or thousands of instrument constituents. Index administrators actively manage constituent membership through scheduled rebalancing events, corporate action adjustments, and liquidity screens. Each instrument-benchmark pairing has unique relationship data including weight percentage, inclusion/exclusion dates, free-float factors, and rebalancing event history that belongs to neither the instrument nor the benchmark alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument` ADD CONSTRAINT `fk_security_instrument_underlying_instrument_id` FOREIGN KEY (`underlying_instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`equity` ADD CONSTRAINT `fk_security_equity_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ADD CONSTRAINT `fk_security_fixed_income_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`derivative` ADD CONSTRAINT `fk_security_derivative_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`structured_product` ADD CONSTRAINT `fk_security_structured_product_prospectus_id` FOREIGN KEY (`prospectus_id`) REFERENCES `banking_ecm`.`security`.`prospectus`(`prospectus_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_parent_issuer_id` FOREIGN KEY (`parent_issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`issuer` ADD CONSTRAINT `fk_security_issuer_primary_ultimate_parent_issuer_id` FOREIGN KEY (`primary_ultimate_parent_issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`price` ADD CONSTRAINT `fk_security_price_superseded_by_price_id` FOREIGN KEY (`superseded_by_price_id`) REFERENCES `banking_ecm`.`security`.`price`(`price_id`);
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ADD CONSTRAINT `fk_security_corporate_action_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`classification` ADD CONSTRAINT `fk_security_classification_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`identifier` ADD CONSTRAINT `fk_security_identifier_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`listing` ADD CONSTRAINT `fk_security_listing_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ADD CONSTRAINT `fk_security_yield_curve_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ADD CONSTRAINT `fk_security_yield_curve_node_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ADD CONSTRAINT `fk_security_yield_curve_node_yield_curve_id` FOREIGN KEY (`yield_curve_id`) REFERENCES `banking_ecm`.`security`.`yield_curve`(`yield_curve_id`);
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ADD CONSTRAINT `fk_security_credit_rating_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ADD CONSTRAINT `fk_security_instrument_lifecycle_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ADD CONSTRAINT `fk_security_coupon_schedule_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ADD CONSTRAINT `fk_security_coupon_schedule_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ADD CONSTRAINT `fk_security_index_constituent_index_instrument_id` FOREIGN KEY (`index_instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ADD CONSTRAINT `fk_security_index_constituent_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ADD CONSTRAINT `fk_security_security_watchlist_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ADD CONSTRAINT `fk_security_security_watchlist_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ADD CONSTRAINT `fk_security_instrument_relationship_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ADD CONSTRAINT `fk_security_instrument_relationship_target_instrument_id` FOREIGN KEY (`target_instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ADD CONSTRAINT `fk_security_instrument_relationship_related_instrument_relationship_id` FOREIGN KEY (`related_instrument_relationship_id`) REFERENCES `banking_ecm`.`security`.`instrument_relationship`(`instrument_relationship_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_issuer_id` FOREIGN KEY (`issuer_id`) REFERENCES `banking_ecm`.`security`.`issuer`(`issuer_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_superseded_prospectus_id` FOREIGN KEY (`superseded_prospectus_id`) REFERENCES `banking_ecm`.`security`.`prospectus`(`prospectus_id`);
ALTER TABLE `banking_ecm`.`security`.`prospectus` ADD CONSTRAINT `fk_security_prospectus_previous_prospectus_id` FOREIGN KEY (`previous_prospectus_id`) REFERENCES `banking_ecm`.`security`.`prospectus`(`prospectus_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ADD CONSTRAINT `fk_security_instrument_channel_availability_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`security_holding` ADD CONSTRAINT `fk_security_security_holding_liquidity_holding_id` FOREIGN KEY (`liquidity_holding_id`) REFERENCES `banking_ecm`.`security`.`liquidity_holding`(`liquidity_holding_id`);
ALTER TABLE `banking_ecm`.`security`.`security_holding` ADD CONSTRAINT `fk_security_security_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ADD CONSTRAINT `fk_security_instrument_eligibility_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ADD CONSTRAINT `fk_security_instrument_haircut_applicability_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ADD CONSTRAINT `fk_security_liquidity_holding_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ADD CONSTRAINT `fk_security_trading_restriction_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);
ALTER TABLE `banking_ecm`.`security`.`constituent` ADD CONSTRAINT `fk_security_constituent_benchmark_id` FOREIGN KEY (`benchmark_id`) REFERENCES `banking_ecm`.`security`.`benchmark`(`benchmark_id`);
ALTER TABLE `banking_ecm`.`security`.`constituent` ADD CONSTRAINT `fk_security_constituent_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `banking_ecm`.`security`.`instrument`(`instrument_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`security` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`security` SET TAGS ('dbx_domain' = 'security');
ALTER TABLE `banking_ecm`.`security`.`instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`instrument` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuance Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `issuer_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`equity` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `equity_id` SET TAGS ('dbx_business_glossary_term' = 'Equity Identifier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Entity Identifier');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `issuer_lei` SET TAGS ('dbx_business_glossary_term' = 'Issuer Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`security`.`equity` ALTER COLUMN `issuer_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
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
ALTER TABLE `banking_ecm`.`security`.`fixed_income` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `fixed_income_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Income Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `issuer_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP) Number');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[A-Z0-9]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'ACT_360|ACT_365|30_360|ACT_ACT');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `duration` SET TAGS ('dbx_business_glossary_term' = 'Modified Duration');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `face_value` SET TAGS ('dbx_business_glossary_term' = 'Face Value');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `first_coupon_date` SET TAGS ('dbx_business_glossary_term' = 'First Coupon Payment Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `fixed_income_status` SET TAGS ('dbx_business_glossary_term' = 'Bond Lifecycle Status');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `fixed_income_status` SET TAGS ('dbx_value_regex' = 'active|matured|called|defaulted|suspended');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `floating_rate_index` SET TAGS ('dbx_business_glossary_term' = 'Floating Rate Reference Index');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `floating_rate_spread` SET TAGS ('dbx_business_glossary_term' = 'Floating Rate Spread');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Fixed Income Instrument Name');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Fixed Income Instrument Type');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'government_bond|corporate_bond|municipal_bond|treasury_bill|treasury_note|inflation_linked_security');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `isin` SET TAGS ('dbx_business_glossary_term' = 'International Securities Identification Number (ISIN)');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `isin` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{9}[0-9]$');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Issue Date');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Code');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL) Code');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{7}$');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `sinking_fund_flag` SET TAGS ('dbx_business_glossary_term' = 'Sinking Fund Provision Flag');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`fixed_income` ALTER COLUMN `yield_to_maturity` SET TAGS ('dbx_business_glossary_term' = 'Yield to Maturity (YTM)');
ALTER TABLE `banking_ecm`.`security`.`derivative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`derivative` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `derivative_id` SET TAGS ('dbx_business_glossary_term' = 'Derivative Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Loan Facility Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Obligation');
ALTER TABLE `banking_ecm`.`security`.`derivative` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_value_regex' = 'emir|dodd_frank|mifid_ii|sftr|none');
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
ALTER TABLE `banking_ecm`.`security`.`structured_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`structured_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `structured_product_id` SET TAGS ('dbx_business_glossary_term' = 'Structured Product Identifier');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `prospectus_id` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Underlying Loan Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `capital_treatment` SET TAGS ('dbx_business_glossary_term' = 'Capital Treatment Approach');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `capital_treatment` SET TAGS ('dbx_value_regex' = 'SA|IRB|SEC-IRBA|SEC-ERBA|SEC-SA');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `capital_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `capital_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'Fixed|Floating|Step-Up|Zero-Coupon');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `credit_enhancement_level` SET TAGS ('dbx_business_glossary_term' = 'Credit Enhancement Level');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `current_face_value` SET TAGS ('dbx_business_glossary_term' = 'Current Face Value');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `deal_name` SET TAGS ('dbx_business_glossary_term' = 'Deal Name');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `ead` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `ecl_provision` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) Provision');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `geographic_concentration` SET TAGS ('dbx_business_glossary_term' = 'Geographic Concentration');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `lgd` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `original_face_value` SET TAGS ('dbx_business_glossary_term' = 'Original Face Value');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `pd` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `pool_factor` SET TAGS ('dbx_business_glossary_term' = 'Pool Factor');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `prepayment_speed_assumption` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Speed Assumption (PSA/CPR)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Mortgage-Backed Securities (MBS) / Asset-Backed Securities (ABS) / Collateralized Loan Obligation (CLO) / Collateralized Debt Obligation (CDO) / Commercial Mortgage-Backed Securities (CMBS) Product Type');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'MBS|ABS|CLO|CDO|CMBS|Covered Bond');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Rating Agency');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `rating_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Date');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `reference_rate` SET TAGS ('dbx_business_glossary_term' = 'Reference Rate');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `rwa` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `servicer_name` SET TAGS ('dbx_business_glossary_term' = 'Servicer Name');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `structured_product_status` SET TAGS ('dbx_business_glossary_term' = 'Structured Product Status');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `structured_product_status` SET TAGS ('dbx_value_regex' = 'Active|Matured|Defaulted|Called|Redeemed|Suspended');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `tranche_class` SET TAGS ('dbx_business_glossary_term' = 'Tranche Class');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `tranche_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tranche Identifier');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `trustee_name` SET TAGS ('dbx_business_glossary_term' = 'Trustee Name');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `wac` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Coupon (WAC)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `wal` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Life (WAL)');
ALTER TABLE `banking_ecm`.`security`.`structured_product` ALTER COLUMN `wam` SET TAGS ('dbx_business_glossary_term' = 'Weighted Average Maturity (WAM)');
ALTER TABLE `banking_ecm`.`security`.`issuer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`issuer` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `parent_issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `primary_ultimate_parent_issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `incorporation_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Jurisdiction');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `internal_lgd` SET TAGS ('dbx_business_glossary_term' = 'Internal Loss Given Default (LGD)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `internal_pd` SET TAGS ('dbx_business_glossary_term' = 'Internal Probability of Default (PD)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_financial_institution` SET TAGS ('dbx_business_glossary_term' = 'Financial Institution Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_investment_grade` SET TAGS ('dbx_business_glossary_term' = 'Investment Grade Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_public_sector_entity` SET TAGS ('dbx_business_glossary_term' = 'Public Sector Entity Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `is_sanctioned_entity` SET TAGS ('dbx_business_glossary_term' = 'Sanctioned Entity Flag');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_status` SET TAGS ('dbx_business_glossary_term' = 'Issuer Status');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|acquired|liquidated|bankrupt');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_type` SET TAGS ('dbx_business_glossary_term' = 'Issuer Type Classification');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `issuer_type` SET TAGS ('dbx_value_regex' = 'corporate|sovereign|municipal|supranational|special_purpose_vehicle|government_agency');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `lei` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`security`.`issuer` ALTER COLUMN `lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
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
ALTER TABLE `banking_ecm`.`security`.`price` SET TAGS ('dbx_subdomain' = 'pricing_valuation');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Identifier');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `market_center_id` SET TAGS ('dbx_business_glossary_term' = 'Market Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `market_data_source_id` SET TAGS ('dbx_business_glossary_term' = 'Market Data Provider Identifier');
ALTER TABLE `banking_ecm`.`security`.`price` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`corporate_action` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action ID');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
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
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `issuer_lei` SET TAGS ('dbx_business_glossary_term' = 'Issuer Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `issuer_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `issuer_name` SET TAGS ('dbx_business_glossary_term' = 'Issuer Name');
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
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`corporate_action` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`security`.`classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`security`.`classification` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Classification Identifier');
ALTER TABLE `banking_ecm`.`security`.`classification` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Classification Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`identifier` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Identifier Identifier');
ALTER TABLE `banking_ecm`.`security`.`identifier` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Instrument Identifier Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`listing` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Identifier');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier');
ALTER TABLE `banking_ecm`.`security`.`listing` ALTER COLUMN `market_center_id` SET TAGS ('dbx_business_glossary_term' = 'Market Center Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`benchmark` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Identifier');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`benchmark` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`yield_curve` SET TAGS ('dbx_subdomain' = 'pricing_valuation');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` SET TAGS ('dbx_subdomain' = 'pricing_valuation');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `yield_curve_node_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Node Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|superseded');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `bid_rate` SET TAGS ('dbx_business_glossary_term' = 'Bid Rate');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|unadjusted');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compounding Frequency');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `compounding_frequency` SET TAGS ('dbx_value_regex' = 'continuous|annual|semi_annual|quarterly|monthly|daily');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|interpolated|stale|missing');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = 'ACT/360|ACT/365|30/360|ACT/ACT');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `discount_factor` SET TAGS ('dbx_business_glossary_term' = 'Discount Factor');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `dv01` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of One Basis Point (DV01)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `forward_rate` SET TAGS ('dbx_business_glossary_term' = 'Forward Interest Rate');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `interpolation_method` SET TAGS ('dbx_business_glossary_term' = 'Interpolation Method');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `interpolation_method` SET TAGS ('dbx_value_regex' = 'linear|cubic_spline|nelson_siegel|svensson|log_linear');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Indicator');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `liquidity_score` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Score');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `market_quote` SET TAGS ('dbx_business_glossary_term' = 'Market Quote Rate');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `mid_rate` SET TAGS ('dbx_business_glossary_term' = 'Mid-Market Rate');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `node_sequence` SET TAGS ('dbx_business_glossary_term' = 'Node Sequence Number');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `offer_rate` SET TAGS ('dbx_business_glossary_term' = 'Offer Rate (Ask Rate)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `par_rate` SET TAGS ('dbx_business_glossary_term' = 'Par Coupon Rate');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Data Source');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type Classification');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `shock_magnitude_bps` SET TAGS ('dbx_business_glossary_term' = 'Shock Magnitude (Basis Points)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `spread_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Spread Adjustment (Basis Points)');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor in Days');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `tenor_label` SET TAGS ('dbx_business_glossary_term' = 'Tenor Label');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `valuation_model` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `zero_rate` SET TAGS ('dbx_business_glossary_term' = 'Zero Coupon Rate');
ALTER TABLE `banking_ecm`.`security`.`yield_curve_node` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Identifier');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`security`.`credit_rating` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Party ID');
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
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `instrument_lifecycle_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Lifecycle ID');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `announcement_date` SET TAGS ('dbx_business_glossary_term' = 'Announcement Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `call_price` SET TAGS ('dbx_business_glossary_term' = 'Call Price');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `collateral_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Eligibility Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `credit_rating_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Impact Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Default Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `exchange_ratio` SET TAGS ('dbx_business_glossary_term' = 'Exchange Ratio');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset (HQLA) Liquidity Classification');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_value_regex' = 'level_1_hqla|level_2a_hqla|level_2b_hqla|non_hqla|illiquid');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `recovery_rate` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `risk_weight_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight Adjustment Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `settlement_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Eligibility Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `trading_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Trading Eligibility Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `triggering_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Reference');
ALTER TABLE `banking_ecm`.`security`.`instrument_lifecycle` ALTER COLUMN `valuation_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Valuation Impact Flag');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` SET TAGS ('dbx_subdomain' = 'pricing_valuation');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `coupon_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Schedule ID');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Instrument ID');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `accrual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual End Date');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `accrual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Start Date');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `actual_coupon_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Coupon Amount');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_business_glossary_term' = 'Business Day Convention');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `business_day_convention` SET TAGS ('dbx_value_regex' = 'following|modified_following|preceding|unadjusted');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `calculation_agent` SET TAGS ('dbx_business_glossary_term' = 'Calculation Agent');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `coupon_period_number` SET TAGS ('dbx_business_glossary_term' = 'Coupon Period Number');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `coupon_rate` SET TAGS ('dbx_business_glossary_term' = 'Coupon Rate');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `coupon_type` SET TAGS ('dbx_business_glossary_term' = 'Coupon Type');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `coupon_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|zero|step_up|step_down|variable');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_business_glossary_term' = 'Day Count Convention');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `day_count_convention` SET TAGS ('dbx_value_regex' = '30/360|actual/360|actual/365|actual/actual');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `day_count_fraction` SET TAGS ('dbx_business_glossary_term' = 'Day Count Fraction');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `ex_dividend_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Dividend Date');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `net_coupon_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Coupon Amount');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire|ach|check|book_entry|euroclear|clearstream');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|paid|missed|deferred|cancelled');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `projected_coupon_amount` SET TAGS ('dbx_business_glossary_term' = 'Projected Coupon Amount');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `rate_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Reset Date');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `reference_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Reference Rate Value');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `spread_bps` SET TAGS ('dbx_business_glossary_term' = 'Spread (Basis Points)');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `banking_ecm`.`security`.`coupon_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Index Constituent Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Index Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `benchmark_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Eligible Flag');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `capping_factor` SET TAGS ('dbx_business_glossary_term' = 'Capping Factor');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `constituent_status` SET TAGS ('dbx_business_glossary_term' = 'Constituent Status');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `constituent_status` SET TAGS ('dbx_value_regex' = 'active|pending_inclusion|pending_exclusion|excluded|suspended');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `country_classification` SET TAGS ('dbx_business_glossary_term' = 'Country Classification');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `etf_creation_basket_flag` SET TAGS ('dbx_business_glossary_term' = 'Exchange-Traded Fund (ETF) Creation Basket Flag');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Date');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `free_float_factor` SET TAGS ('dbx_business_glossary_term' = 'Free Float Factor');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Date');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_code` SET TAGS ('dbx_business_glossary_term' = 'Index Code');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_divisor_impact` SET TAGS ('dbx_business_glossary_term' = 'Index Divisor Impact');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_family` SET TAGS ('dbx_business_glossary_term' = 'Index Family');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_provider` SET TAGS ('dbx_business_glossary_term' = 'Index Provider');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_type` SET TAGS ('dbx_business_glossary_term' = 'Index Type');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_type` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|commodity|credit|multi_asset|alternative');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `index_weight` SET TAGS ('dbx_business_glossary_term' = 'Index Weight');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `industry_classification` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `liquidity_score` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Score');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `market_cap_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Capitalization (Cap) Tier');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `market_cap_tier` SET TAGS ('dbx_value_regex' = 'large_cap|mid_cap|small_cap|micro_cap');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `market_cap_weight` SET TAGS ('dbx_business_glossary_term' = 'Market Capitalization (Cap) Weight');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `minimum_liquidity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Liquidity Threshold');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `par_weight` SET TAGS ('dbx_business_glossary_term' = 'Par Weight');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `passive_investment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Passive Investment Eligible Flag');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `rebalancing_event_date` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Event Date');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `rebalancing_event_type` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Event Type');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `rebalancing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Frequency');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `region_classification` SET TAGS ('dbx_business_glossary_term' = 'Region Classification');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `region_classification` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia_pacific|emerging_markets|developed_markets|frontier_markets');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `shares_held` SET TAGS ('dbx_business_glossary_term' = 'Shares Held');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Weight Percentage');
ALTER TABLE `banking_ecm`.`security`.`index_constituent` ALTER COLUMN `weighting_methodology` SET TAGS ('dbx_business_glossary_term' = 'Weighting Methodology');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `security_watchlist_id` SET TAGS ('dbx_business_glossary_term' = 'Security Watchlist ID');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `alert_notification_recipients` SET TAGS ('dbx_business_glossary_term' = 'Alert Notification Recipients');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `alert_notification_recipients` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `alert_notification_recipients` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `applicable_business_units` SET TAGS ('dbx_business_glossary_term' = 'Applicable Business Units');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `applicable_client_segments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Client Segments');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `best_execution_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Impact Flag');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `esg_exclusion_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Exclusion Category');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `issuer_lei` SET TAGS ('dbx_business_glossary_term' = 'Issuer Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `issuer_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `list_type` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Type');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `override_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `override_approval_level` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Level');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `post_trade_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Trade Monitoring Flag');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `pre_trade_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Trade Check Required Flag');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Restriction Level');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `restriction_level` SET TAGS ('dbx_value_regex' = 'hard_block|soft_alert|advisory');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_value_regex' = 'all_transactions|buy_only|sell_only|new_positions|existing_positions');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `sector_exclusion_code` SET TAGS ('dbx_business_glossary_term' = 'Sector Exclusion Code');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `security_watchlist_status` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Status');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `security_watchlist_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|pending_approval|cancelled');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `sfdr_classification` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Finance Disclosure Regulation (SFDR) Classification');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `sfdr_classification` SET TAGS ('dbx_value_regex' = 'Article_6|Article_8|Article_9|not_applicable');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `suitability_assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Suitability Assessment Required Flag');
ALTER TABLE `banking_ecm`.`security`.`security_watchlist` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `instrument_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Relationship Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Source Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `target_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Target Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `related_instrument_relationship_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `conversion_currency` SET TAGS ('dbx_business_glossary_term' = 'Conversion Currency');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `conversion_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `conversion_price` SET TAGS ('dbx_business_glossary_term' = 'Conversion Price');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `conversion_ratio` SET TAGS ('dbx_business_glossary_term' = 'Conversion Ratio');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `corporate_action_propagation_flag` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Propagation Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `exercise_style` SET TAGS ('dbx_business_glossary_term' = 'Exercise Style');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `exercise_style` SET TAGS ('dbx_value_regex' = 'american|european|bermudan');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `look_through_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Look-Through Required Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `mandatory_voluntary_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mandatory or Voluntary Indicator');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `mandatory_voluntary_indicator` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `notional_currency` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `notional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'source_to_target|target_to_source|bidirectional');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_priority` SET TAGS ('dbx_business_glossary_term' = 'Relationship Priority');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|terminated|suspended');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'convertible_to_equity|adr_to_ordinary|gdr_to_ordinary|warrant_to_underlying|etf_to_constituent|derivative_to_underlier');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `risk_aggregation_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Aggregation Flag');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'physical|cash|net_share');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `strike_currency` SET TAGS ('dbx_business_glossary_term' = 'Strike Currency');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `strike_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Weight Percentage');
ALTER TABLE `banking_ecm`.`security`.`instrument_relationship` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`security`.`prospectus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`security`.`prospectus` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `prospectus_id` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Identifier');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `superseded_prospectus_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Prospectus Identifier');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `previous_prospectus_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Independent Auditor Name');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `cik_number` SET TAGS ('dbx_business_glossary_term' = 'Central Index Key (CIK) Number');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `cik_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `dividend_policy` SET TAGS ('dbx_business_glossary_term' = 'Dividend Policy Description');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format Type');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'PDF|HTML|XML|XBRL');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Document Number');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `extraction_method` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Method');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `extraction_method` SET TAGS ('dbx_value_regex' = 'manual|ocr|api|xml_parse|automated');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `fiscal_year_end` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Date');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `fiscal_year_end` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `greenshoe_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Greenshoe Option Flag');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `greenshoe_shares` SET TAGS ('dbx_business_glossary_term' = 'Greenshoe Option Shares');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `incorporation_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Jurisdiction');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `incorporation_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Name');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `listing_exchange` SET TAGS ('dbx_business_glossary_term' = 'Listing Exchange Code');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `lock_up_period_days` SET TAGS ('dbx_business_glossary_term' = 'Lock-Up Period Days');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `offering_amount` SET TAGS ('dbx_business_glossary_term' = 'Offering Amount');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `offering_type` SET TAGS ('dbx_business_glossary_term' = 'Initial Public Offering (IPO) Type');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `offering_type` SET TAGS ('dbx_value_regex' = 'ipo|secondary|rights|private_placement|public|follow_on');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `price_per_share` SET TAGS ('dbx_business_glossary_term' = 'Price Per Share');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `prospectus_status` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Status');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `prospectus_type` SET TAGS ('dbx_business_glossary_term' = 'Prospectus Document Type');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `risk_factors_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Factors Summary');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `sec_file_number` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) File Number');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `shares_offered` SET TAGS ('dbx_business_glossary_term' = 'Shares Offered Quantity');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Ticker Symbol');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `underwriter_lei` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Underwriter');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `underwriter_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `underwriter_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Underwriter Name');
ALTER TABLE `banking_ecm`.`security`.`prospectus` ALTER COLUMN `use_of_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Use of Proceeds Description');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` SET TAGS ('dbx_association_edges' = 'security.instrument,channel.channel');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `instrument_channel_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Channel Availability - Instrument Channel Availability Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Channel Availability - Banking Channel Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Channel Availability - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `authentication_method_required` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method Required');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `channel_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Channel Fee Amount');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `customer_segment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Restriction');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `kyc_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'KYC Requirement Level');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `banking_ecm`.`security`.`instrument_channel_availability` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Per-Transaction Limit');
ALTER TABLE `banking_ecm`.`security`.`security_holding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`security_holding` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`security_holding` SET TAGS ('dbx_association_edges' = 'security.instrument,ledger.legal_entity');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `security_holding_id` SET TAGS ('dbx_business_glossary_term' = 'security_holding Identifier');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `liquidity_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Holding Identifier');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Holding - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Holding - Legal Entity Id');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `capital_charge` SET TAGS ('dbx_business_glossary_term' = 'Capital Charge');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Holding Classification');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Status');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `last_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Valuation Date');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `position_quantity` SET TAGS ('dbx_business_glossary_term' = 'Position Quantity');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Treatment');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `regulatory_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`security_holding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` SET TAGS ('dbx_association_edges' = 'security.instrument,collateral.eligibility_rule');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `instrument_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Eligibility Identifier');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Eligibility - Eligibility Rule Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Eligibility - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `concentration_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `eligible_for_initial_margin` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Initial Margin');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `eligible_for_variation_margin` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Variation Margin');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Haircut Percentage');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `last_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluation Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_eligibility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` SET TAGS ('dbx_association_edges' = 'security.instrument,collateral.haircut_schedule');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `instrument_haircut_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Haircut Applicability - Instrument Haircut Applicability Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Haircut Applicability - Haircut Schedule Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Haircut Applicability - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `applicable_internal_model_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Applicable Internal Model Haircut Percentage');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `applicable_supervisory_haircut_pct` SET TAGS ('dbx_business_glossary_term' = 'Applicable Supervisory Haircut Percentage');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Applicability Approval Timestamp');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Applicability Approver');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Haircut Calculation Status');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Effective Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `holding_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holding Period Days');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Haircut Override Reason');
ALTER TABLE `banking_ecm`.`security`.`instrument_haircut_applicability` ALTER COLUMN `volatility_adjustment_method` SET TAGS ('dbx_business_glossary_term' = 'Volatility Adjustment Method');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` SET TAGS ('dbx_association_edges' = 'security.instrument,treasury.liquidity_position');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `liquidity_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Holding Identifier');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Holding - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Holding - Liquidity Position Id');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `custodian_account` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `encumbrance_status` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Status');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `fx_rate_to_position_currency` SET TAGS ('dbx_business_glossary_term' = 'FX Rate to Position Currency');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Haircut Percentage');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `holding_currency` SET TAGS ('dbx_business_glossary_term' = 'Holding Currency');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `holding_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Status');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `hqla_value` SET TAGS ('dbx_business_glossary_term' = 'High-Quality Liquid Asset Value');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `liquidity_classification` SET TAGS ('dbx_business_glossary_term' = 'HQLA Classification');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `maturity_bucket` SET TAGS ('dbx_business_glossary_term' = 'Maturity Bucket');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `nsfr_asf_factor` SET TAGS ('dbx_business_glossary_term' = 'NSFR Available Stable Funding Factor');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `nsfr_rsf_factor` SET TAGS ('dbx_business_glossary_term' = 'NSFR Required Stable Funding Factor');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Holding Quantity');
ALTER TABLE `banking_ecm`.`security`.`liquidity_holding` ALTER COLUMN `valuation_source` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` SET TAGS ('dbx_association_edges' = 'security.instrument,hr.employee');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `trading_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction Identifier');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction - Employee Id');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Restriction - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Effective Date');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiry Date');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `pre_clearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Clearance Required Flag');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_business_glossary_term' = 'Restriction Reason');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `restriction_reason` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `banking_ecm`.`security`.`trading_restriction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`constituent` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`security`.`constituent` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `banking_ecm`.`security`.`constituent` SET TAGS ('dbx_association_edges' = 'security.instrument,security.benchmark');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent - Benchmark Id');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent - Instrument Id');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `constituent_status` SET TAGS ('dbx_business_glossary_term' = 'Constituent Status');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Timestamp');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `exclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Index Exclusion Date');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `free_float_factor` SET TAGS ('dbx_business_glossary_term' = 'Free Float Factor');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Index Inclusion Date');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `rebalancing_event_type` SET TAGS ('dbx_business_glossary_term' = 'Rebalancing Event Type');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`security`.`constituent` ALTER COLUMN `weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Constituent Weight Percentage');
