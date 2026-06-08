-- Schema for Domain: trade | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`trade` COMMENT 'Securities trading, order management, trade capture, execution, position management, P&L attribution, and post-trade processing for capital markets and trading book activities. Manages the full trade lifecycle from order entry through settlement, MTM valuation, trade confirmations, and FX/OTC derivative execution. Primary system of record aligned with Murex / Calypso.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`order` (
    `order_id` BIGINT COMMENT 'Unique system-generated identifier for the trade order. Primary key for the order entity. Serves as the single source of truth for order identity across all capital markets systems.',
    `branch_id` BIGINT COMMENT 'Reference to the trading desk or business unit responsible for the order. Used for P&L attribution, risk aggregation, and organizational reporting. Aligns with line of business (LOB) hierarchy.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Orders placed during IPO/secondary offering bookbuilding must reference the offering for order book management, allocation decisions, price discovery, demand analysis, and regulatory reporting (SEC Fo',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Order currency must validate against reference currency master for FX rate application, settlement processing, and regulatory reporting. Reference data provides ISO codes, minor units, and settlement ',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Orders executed for investment banking deals (IPO allocations, block trades for M&A, capital markets transactions) require direct linkage for deal P&L attribution, allocation management, and regulator',
    `deposit_account_id` BIGINT COMMENT 'Reference to the specific client account for which the order is placed. Used for segregation of client assets, account-level reporting, and regulatory compliance. Null for proprietary trading orders.',
    `employee_id` BIGINT COMMENT 'Reference to the trader who entered or is responsible for the order. Used for attribution, performance measurement, compliance surveillance, and audit trail. Links to employee master data in Human Capital Management system.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund managers place orders on behalf of funds daily. Essential for attributing trading activity to funds for NAV calculation, performance tracking, and regulatory reporting (MiFID II transaction repor',
    `instrument_id` BIGINT COMMENT 'Reference to the security master record for the instrument being traded. Links to detailed security attributes including ISIN, CUSIP, ticker, issuer, maturity, and security-specific terms.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Order counterparty LEI required for MiFID II transaction reporting, best execution analysis, and regulatory transparency. Reference LEI registry provides legal entity details, jurisdiction, and relati',
    `market_center_id` BIGINT COMMENT 'Reference to the trading venue or exchange where the order is routed for execution. Includes regulated markets, MTFs (Multilateral Trading Facilities), OTF (Organized Trading Facilities), and systematic internalizers. Required for MiFID II best execution reporting.',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Orders trigger transaction monitoring rules for AML/fraud surveillance. Banks screen orders against scenarios for layering, wash trading, and market manipulation - core compliance process in trading o',
    `parent_order_id` BIGINT COMMENT 'Reference to the parent order in hierarchical order structures. Used for algorithmic trading and smart order routing where a parent order is split into multiple child orders for execution. Null for top-level orders.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty for the order. For client orders, the client entity. For inter-dealer trades, the dealer counterparty. Used for credit exposure monitoring, counterparty risk management, and KYC compliance.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Order asset class classification drives execution strategy, venue selection, regulatory treatment, and best execution policy. Reference classification provides asset class hierarchy and regulatory cat',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Orders must reference instrument identifiers for cross-system reconciliation, regulatory reporting, and settlement processing. Reference instrument master provides ISIN, CUSIP, SEDOL mappings required',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Pre-trade compliance requires orders to reference the risk limit being checked (VaR, DV01, notional) for real-time breach detection and regulatory reporting. Essential for front-office risk controls.',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading book or portfolio where the order position will be held. Critical for position management, risk calculations, and regulatory capital requirements under FRTB (Fundamental Review of the Trading Book).',
    `average_execution_price` DECIMAL(18,2) COMMENT 'Volume-weighted average price at which the order was executed. For partially filled orders, average of fills to date. Used for P&L calculation, transaction cost analysis, and client reporting. Expressed in order currency per unit.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the order was cancelled. Null for active or filled orders. Used for order lifecycle analysis and operational metrics. Recorded in UTC.',
    `capacity` STRING COMMENT 'Capacity in which the firm is acting for the order. Principal means trading for own account. Agency means acting as broker for client. Riskless principal means simultaneous offsetting trades. Required for regulatory reporting and best execution analysis.. Valid values are `principal|agency|riskless_principal|matched_principal`',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total commission charged for order execution. Includes broker fees, exchange fees, and clearing fees. Expressed in order currency. Used for revenue recognition, client billing, and transaction cost analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the order record was first created in the database. Used for audit trail, data lineage, and operational monitoring. Recorded in UTC. Distinct from order_entry_timestamp which reflects business event time.',
    `entry_timestamp` TIMESTAMP COMMENT 'Precise date and time when the order was entered into the trading system. Recorded in UTC with microsecond precision. Critical for transaction cost analysis, market abuse surveillance, and regulatory reporting under MiFID II clock synchronization requirements.',
    `execution_strategy` STRING COMMENT 'Name or identifier of the algorithmic execution strategy applied to the order. Examples include VWAP, TWAP, implementation shortfall, liquidity-seeking, dark pool aggregation. Null for manual execution. Used for strategy performance analysis and best execution compliance.',
    `execution_timestamp` TIMESTAMP COMMENT 'Date and time when the order was fully executed. Null for unfilled or partially filled orders. Used for settlement date calculation (T+1, T+2) and performance measurement. Recorded in UTC.',
    `expiry_date` DATE COMMENT 'Date on which the order automatically expires if not filled. Applicable for GTD (Good Till Date) orders. Null for Day, GTC, IOC, and FOK orders. System automatically cancels order at end of expiry date.',
    `filled_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity executed to date. Updated as partial fills occur. When filled_quantity equals quantity, order status transitions to filled. Used to calculate remaining open quantity and order completion percentage.',
    `instruction` STRING COMMENT 'Free-text field for special handling instructions or trader notes. May include client preferences, execution constraints, or operational notes. Not used for automated processing but valuable for audit trail and client service.',
    `is_algorithmic` BOOLEAN COMMENT 'Indicates whether the order was generated or executed by an algorithmic trading system. True for algo orders, false for manual orders. Required for MiFID II algorithmic trading transparency and risk control reporting.',
    `is_discretionary` BOOLEAN COMMENT 'Indicates whether the order was placed under discretionary authority where the firm has latitude in execution timing and price. True for discretionary orders, false for non-discretionary. Impacts regulatory reporting and best execution obligations.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the order record. Updated on status changes, partial fills, amendments, or cancellations. Used for audit trail and change tracking.',
    `limit_price` DECIMAL(18,2) COMMENT 'Maximum price for buy orders or minimum price for sell orders. Only applicable for limit and stop-limit order types. Null for market orders. Expressed in currency per unit of the security.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the order record. Updated on any field change. Used for change data capture, audit trail, and data synchronization. Recorded in UTC.',
    `order_number` STRING COMMENT 'Human-readable business identifier for the order. Externally visible order reference used in confirmations, reports, and client communications. May follow desk-specific or system-specific numbering conventions.',
    `order_status` STRING COMMENT 'Current lifecycle status of the order. Tracks progression from entry through execution or cancellation. Critical for order management, compliance monitoring, and operational reporting. [ENUM-REF-CANDIDATE: new|pending|partially_filled|filled|cancelled|rejected|expired|suspended — 8 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of order execution instruction. Market orders execute immediately at best available price. Limit orders execute only at specified price or better. Stop orders trigger at specified price. IOC (Immediate or Cancel) and FOK (Fill or Kill) define time-in-force behavior.. Valid values are `market|limit|stop|stop_limit|ioc|fok`',
    `origination_channel` STRING COMMENT 'Channel through which the order was received. Electronic includes FIX protocol and API. Voice for phone orders. Algo for algorithmic trading. DMA (Direct Market Access) for client-routed orders. Client portal for self-service platforms. Used for channel analytics and operational efficiency measurement.. Valid values are `electronic|voice|algo|dma|client_portal`',
    `quantity` DECIMAL(18,2) COMMENT 'Total quantity of the security ordered. For equities, typically number of shares. For bonds, face value amount. For FX, base currency amount. For derivatives, number of contracts. Unit of measure depends on asset class and instrument type.',
    `regulatory_trade_flag` STRING COMMENT 'Indicator for special regulatory treatment or reporting requirements. Examples include short sale indicator, large in scale (LIS), pre-trade transparency waiver, algorithmic trading flag. Used for regulatory reporting to FINRA, SEC, ESMA.',
    `rejection_reason` STRING COMMENT 'Explanation for why the order was rejected. Includes system validations (insufficient margin, invalid security), risk limit breaches, compliance blocks, or venue rejections. Null for non-rejected orders. Used for operational issue resolution and client communication.',
    `settlement_date` DATE COMMENT 'Date on which the trade settles and securities and cash are exchanged. Calculated based on execution date and market convention (T+1 for US equities, T+2 for most securities). Critical for cash management and operational planning.',
    `side` STRING COMMENT 'Direction of the trade order. Buy increases position, sell decreases position. Short sell creates negative position. Buy to cover closes short position. Critical for position management and P&L calculation.. Valid values are `buy|sell|short_sell|buy_to_cover`',
    `stop_price` DECIMAL(18,2) COMMENT 'Trigger price for stop and stop-limit orders. Order becomes active when market price reaches this level. Null for market and limit orders. Used for risk management and automated trading strategies.',
    `time_in_force` STRING COMMENT 'Duration for which the order remains active. Day orders expire at market close. GTC (Good Till Cancelled) remains active until filled or cancelled. IOC (Immediate or Cancel) executes immediately or cancels. FOK (Fill or Kill) must fill completely or cancel. GTD (Good Till Date) expires on specified date.. Valid values are `day|gtc|ioc|fok|gtd`',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Core master record for all trade orders entered into the Trading and Order Management System (Murex/Calypso). Captures the full order lifecycle from entry through execution including order type (market, limit, stop, IOC, FOK), asset class (equity, fixed income, FX, OTC derivative), side (buy/sell/short), quantity, price, order status, trader ID, desk, book, counterparty, venue, time-in-force, and origination channel. Supports parent/child order hierarchies for algorithmic and smart order routing. SSOT for trade order identity across capital markets.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`execution` (
    `execution_id` BIGINT COMMENT 'Unique identifier for the trade execution record. Primary key.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Executions are primary audit evidence for transaction testing, trade surveillance, and regulatory examinations. Auditors test execution samples for price reasonableness, venue selection, and timestamp',
    `broker_id` BIGINT COMMENT 'FK to trade.broker',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Executions settling capital markets offerings need offering reference for offering settlement reconciliation, stabilization activity tracking (Reg M compliance), greenshoe option exercise, and final p',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Execution records should link to the authoritative trade booking (capture). Currently execution only links to order, but the booked trade (capture) is the system of record in Murex/Calypso. This compl',
    `code_list_id` BIGINT COMMENT 'Foreign key linking to reference.code_list. Business justification: Execution desk attribution essential for best execution analysis, venue selection monitoring, and MiFID II compliance reporting. Desk reference data ensures consistent organizational hierarchy across ',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Repo and securities lending executions trade collateral assets as underlying instruments. Repo trading desks execute trades where the security IS the collateral, requiring direct linkage for position ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Execution currency validation required for trade capture, settlement processing, and FX exposure calculation. Reference currency master provides rounding rules, settlement lag, and convertibility stat',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Executions tied to investment banking deals (IPO settlements, secondary offerings, block trades supporting M&A) need tracking for deal execution reporting, fee calculation based on executed volume, an',
    `employee_id` BIGINT COMMENT 'Identifier of the internal trader or portfolio manager who initiated the order that led to this execution. Used for attribution analysis and compliance surveillance.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Executions must be attributed to funds for accurate fund accounting, performance measurement, and regulatory compliance. Critical for fund NAV calculation and MiFID II best execution reporting at fund',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security) that was executed. Links to the securities master data.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Execution reporting and best execution analysis require issuer-level aggregation for issuer concentration limits, issuer credit risk assessment in execution decisions, and regulatory reporting by issu',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Execution counterparty LEI validation mandatory for regulatory trade reporting (EMIR, MiFID II, Dodd-Frank). Reference LEI registry provides legal entity name, jurisdiction, and ultimate parent for re',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Links trade executions to wealth portfolios for transaction cost analysis (TCA), performance attribution, and MiFID II best execution reporting. Enables portfolio managers to analyze execution quality',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Executions are screened against monitoring scenarios for market abuse detection (spoofing, layering, front-running). Real-time surveillance systems match executions to rule definitions for alert gener',
    `order_id` BIGINT COMMENT 'Reference to the parent trade order that this execution fulfills (fully or partially). One order may have multiple executions.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Execution asset class needed for best execution analysis, MiFID II reporting, and venue selection monitoring. Reference classification provides regulatory categories and liquidity classification for e',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Executions must map to reference instrument identifiers for regulatory trade reporting (MiFID II, EMIR), settlement instruction generation, and cross-venue reconciliation. Reference data provides auth',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Post-trade limit monitoring tracks which limit each execution consumes for real-time utilization and breach escalation. Critical for intraday risk management and regulatory capital calculations.',
    `best_execution_venue_rank` STRING COMMENT 'Rank of this execution venue in the firms best-execution venue selection process. Used for MiFID II RTS 27 and SEC Rule 606 best-execution reporting.',
    `capacity` STRING COMMENT 'Capacity in which the firm executed the trade: principal (trading for own account), agency (acting as broker), riskless principal, or matched principal. Required for regulatory reporting.. Valid values are `principal|agency|riskless_principal|matched_principal`',
    `clearing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the clearinghouse for clearing and settlement of this execution. Denominated in execution_currency.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Broker commission charged for this execution. Denominated in execution_currency.',
    `counterparty_bic` STRING COMMENT 'SWIFT Bank Identifier Code (BIC) of the counterparty institution. Eight or eleven character code used for international trade settlement.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `counterparty_name` STRING COMMENT 'Name of the counterparty (buyer or seller) on the other side of this execution. For OTC trades, this is the direct counterparty; for exchange trades, this may be the central counterparty or clearing member.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this execution record was first created in the system. Audit trail for data lineage.',
    `exchange_fee` DECIMAL(18,2) COMMENT 'Fee charged by the trading venue or exchange for this execution. Denominated in execution_currency.',
    `executed_quantity` DECIMAL(18,2) COMMENT 'The number of units (shares, contracts, bonds, etc.) filled in this execution. For partial fills, this is less than the order quantity.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the execution record. Tracks progression from fill through settlement.. Valid values are `filled|partially_filled|cancelled|rejected|pending_settlement`',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trade execution occurred in the market. This is the real-world event time, distinct from record creation time. Critical for T+1 settlement calculation and best-execution analysis.',
    `execution_type` STRING COMMENT 'Classification of the execution method. Indicates whether this is a full fill, partial fill, block trade, program trade, algorithmic execution, or manual execution.. Valid values are `full|partial|block|program|algorithmic|manual`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if settlement_currency differs from execution_currency. Null if currencies are the same.',
    `gross_trade_value` DECIMAL(18,2) COMMENT 'Total value of the execution before commissions and fees, calculated as executed_quantity × execution_price. Denominated in execution_currency.',
    `instrument_type` STRING COMMENT 'Detailed classification of the financial instrument (e.g., common stock, corporate bond, interest rate swap, FX forward, equity option, commodity future). [ENUM-REF-CANDIDATE: common_stock|preferred_stock|corporate_bond|government_bond|interest_rate_swap|credit_default_swap|fx_forward|fx_spot|equity_option|equity_future|commodity_future|commodity_option — promote to reference product]',
    `liquidity_indicator` STRING COMMENT 'Indicates whether this execution added liquidity to the market (maker), removed liquidity (taker), or was routed. Affects exchange fee rebates and best-execution analysis.. Valid values are `added|removed|routed`',
    `market_microstructure_indicator` STRING COMMENT 'Classification of the market microstructure where the execution occurred: lit exchange, dark pool, systematic internaliser, over-the-counter (OTC), or request-for-quote (RFQ). Required for MiFID II best-execution reporting.. Valid values are `lit|dark|systematic_internaliser|otc|rfq`',
    `net_trade_value` DECIMAL(18,2) COMMENT 'Total value of the execution after all commissions and fees. Calculated as gross_trade_value ± commission_amount ± exchange_fee ± clearing_fee. Denominated in execution_currency.',
    `price` DECIMAL(18,2) COMMENT 'The price per unit at which this execution was filled. Used to calculate gross trade value and for Mark-to-Market (MTM) valuation.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for this execution, typically assigned by the trading venue or broker. Used for trade confirmations and regulatory reporting.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Total amount to be settled on settlement_date, denominated in settlement_currency. Includes FX conversion if settlement_currency differs from execution_currency.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the trade will settle. May differ from execution_currency if FX conversion is required.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the trade is scheduled to settle. Calculated as execution_timestamp + settlement cycle (e.g., T+1 for equities, T+2 for bonds). Critical for liquidity and collateral management.',
    `trade_reporting_flag` BOOLEAN COMMENT 'Indicates whether this execution has been reported to the relevant trade reporting facility (e.g., FINRA TRACE, EMIR trade repository). True if reported, False if pending.',
    `trade_reporting_timestamp` TIMESTAMP COMMENT 'Date and time when this execution was reported to the trade reporting facility. Null if not yet reported. Used to verify compliance with T+1 reporting deadlines.',
    `trade_side` STRING COMMENT 'Indicates whether this execution is a buy or sell from the perspective of the reporting institution.. Valid values are `buy|sell`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this execution record was last modified. Audit trail for data lineage and change tracking.',
    `venue` STRING COMMENT 'Name or code of the trading venue where the execution occurred (e.g., NYSE, NASDAQ, LSE, OTC, ECN). Critical for best-execution reporting under MiFID II and SEC Rule 606.',
    `venue_mic_code` STRING COMMENT 'Four-character ISO 10383 Market Identifier Code (MIC) for the execution venue. Standardized venue identifier for regulatory reporting.. Valid values are `^[A-Z]{4}$`',
    CONSTRAINT pk_execution PRIMARY KEY(`execution_id`)
) COMMENT 'Transactional record of each individual fill or partial fill against a trade order. Captures execution price, executed quantity, execution venue (exchange, ECN, OTC), execution timestamp, counterparty BIC/LEI, broker, commission, execution type (full/partial), and market microstructure data. Supports T+1 settlement initiation and best-execution regulatory reporting (MiFID II, SEC Rule 606). One order may have multiple executions.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`capture` (
    `capture_id` BIGINT COMMENT 'Unique identifier for the trade capture record. Primary key for the authoritative trade booking record in the trading platform.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Trades are booked in accounting periods for period-end close, trade date accounting, and regulatory reporting by period. Critical for financial close and period attribution.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Trades flagged as suspicious become subject of AML investigations. Case investigators link specific trades to cases for evidence gathering and SAR narrative construction - direct operational linkage i',
    `employee_id` BIGINT COMMENT 'The user ID of the person who approved the trade or amendment. Required for amendments subject to approval workflow. Part of SOX audit trail.',
    `capture_employee_id` BIGINT COMMENT 'The unique identifier of the trader who executed the trade. Used for P&L attribution, performance measurement, and MiFID II trader identification requirements.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Trade booking requires counterparty PD/LGD for CVA calculation, pre-trade credit limit checks, and SA-CCR regulatory capital. Fundamental to counterparty credit risk management.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Trade captures for capital markets transactions (underwriting settlements, syndication trades, stabilization activity) must reference originating deal for deal P&L attribution, regulatory reporting (F',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund trades must be captured with fund attribution for booking to correct fund accounting ledger. Core requirement for fund position reconciliation, NAV calculation, and AIFMD/UCITS regulatory reporti',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Trade capture LEI validation essential for derivatives reporting to trade repositories, regulatory transparency, and counterparty risk management. Reference registry provides legal entity details and ',
    `netting_set_id` BIGINT COMMENT 'Identifier for the legal netting set to which this trade belongs under ISDA Master Agreement. Used for CVA, exposure calculation, and capital optimization.',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex (CSA) or collateral agreement governing margin requirements for this trade. Used for initial margin and variation margin calculations.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Trade asset class classification essential for risk aggregation, capital calculation, regulatory reporting, and booking model determination. Reference classification provides Basel, IFRS9, and MiFID I',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Trade ISIN must validate against reference data for regulatory reporting, settlement processing, and instrument classification. Reference identifier master provides authoritative ISIN mappings and cro',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade currency validation essential for booking, valuation, regulatory reporting, and FX risk calculation. Reference currency master provides ISO codes, central bank data, and convertibility restricti',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Trade product type classification drives booking model, risk categorization, regulatory capital treatment, and P&L attribution. Reference product type master provides Basel, IFRS9, and regulatory repo',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The amount of interest that has accumulated on a fixed income instrument from the last coupon payment date to the trade date. Added to clean price to calculate dirty price.',
    `amended_by` STRING COMMENT 'The user ID of the person who submitted the amendment. Part of the audit trail for trade lifecycle changes and SOX compliance.',
    `amendment_reason` STRING COMMENT 'Free-text explanation of why the trade was amended. Provides business context for audit trail and regulatory inquiries. Required for versions greater than 1.',
    `amendment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the amendment was applied to the trade record. Used for audit trail reconstruction and regulatory reporting of lifecycle events.',
    `amendment_type` STRING COMMENT 'Classification of the lifecycle event that created this version. Economic amendments change trade economics; administrative corrections fix errors; novations transfer to new counterparty; compressions reduce notional.. Valid values are `economic_amendment|administrative_correction|novation|compression|termination|none`',
    `approval_status` STRING COMMENT 'Status of the approval workflow for trade amendments requiring middle office or risk approval. Ensures proper controls over trade modifications.. Valid values are `pending_approval|approved|rejected`',
    `booking_status` STRING COMMENT 'The current lifecycle status of the trade booking record. Tracks progression from initial capture through confirmation, amendment, settlement, or cancellation.. Valid values are `pending|confirmed|amended|cancelled|settled|failed`',
    `ccp_name` STRING COMMENT 'The name of the central counterparty clearing house if the trade is centrally cleared. Examples include LCH, CME, Eurex Clearing. Null for bilateral trades.',
    `clearing_status` STRING COMMENT 'Indicates whether the trade is centrally cleared through a CCP or remains bilateral. Critical for EMIR clearing obligation compliance and capital treatment under Basel III.. Valid values are `cleared|bilateral|pending_clearing`',
    `counterparty_name` STRING COMMENT 'The legal name of the external counterparty organization. Used for trade confirmation, settlement instructions, and operational communication.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade capture record was first created in the trading platform. Part of the audit trail for trade booking and operational reconciliation.',
    `cusip` STRING COMMENT 'The 9-character CUSIP identifier for securities traded in North American markets. Used for US regulatory reporting and settlement instructions.. Valid values are `^[0-9]{3}[0-9A-Z]{5}[0-9]$`',
    `execution_venue` STRING COMMENT 'The trading venue, exchange, or platform where the trade was executed. Required for MiFID II best execution and transparency reporting. Use MIC code where applicable.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade capture record was last updated. Tracks all modifications including amendments, status changes, and data corrections.',
    `legal_entity` STRING COMMENT 'The internal legal entity of the bank that booked the trade. Used for legal netting, capital allocation, and regulatory reporting by entity.',
    `maturity_date` DATE COMMENT 'The date on which the financial instrument matures or expires. Applicable to bonds, derivatives, and term instruments. Null for perpetual or equity instruments.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The principal or face value amount of the trade used for calculating cash flows, interest, and risk exposure. For derivatives, represents the reference amount on which payments are based.',
    `portfolio_code` STRING COMMENT 'The portfolio or strategy code for risk and P&L aggregation. Used for desk-level reporting, risk limit monitoring, and performance attribution.',
    `price` DECIMAL(18,2) COMMENT 'The executed price or rate of the trade. For bonds, represents clean price as percentage of par. For derivatives, represents the fixed rate, strike, or premium. Interpretation depends on product type.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires re-reporting to regulatory trade repositories under EMIR, Dodd-Frank, or MiFID II. Set to true for economic amendments and material corrections.',
    `sedol` STRING COMMENT 'The 7-character SEDOL code used for securities traded on London Stock Exchange and other UK markets. Complements ISIN for UK regulatory reporting.. Valid values are `^[0-9A-Z]{7}$`',
    `settlement_currency` STRING COMMENT 'The currency in which cash settlement will occur. May differ from trade currency for cross-currency transactions. Three-letter ISO 4217 currency code.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'The date on which the trade settles and final transfer of cash and securities occurs. Follows market convention (T+1, T+2, T+3) based on asset class and jurisdiction.',
    `trade_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the trade in trade currency. For cash instruments, equals notional × price. For derivatives, may represent premium or initial margin.',
    `trade_date` DATE COMMENT 'The date on which the trade was executed and agreed between counterparties. Critical for settlement cycle calculation and regulatory reporting.',
    `trade_reference_number` STRING COMMENT 'Internal business identifier for the trade used across front office, middle office, and back office systems. Human-readable reference for trade inquiries and reconciliation.',
    `trade_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the trade was executed, including milliseconds. Required for MiFID II transaction reporting and best execution analysis.',
    `trade_version` STRING COMMENT 'Sequential version number incremented with each amendment or lifecycle event. Version 1 represents the original trade; subsequent versions capture economic amendments, administrative corrections, novations, or compressions.',
    `trading_book` STRING COMMENT 'The trading book or portfolio to which the trade is assigned. Used for P&L attribution, risk limits, and FRTB boundary determination between trading book and banking book.',
    `usi` STRING COMMENT 'US-specific unique identifier for swap transactions required under Dodd-Frank Act reporting rules. Used for CFTC and SEC swap data repository reporting.',
    `uti` STRING COMMENT 'Globally unique identifier for OTC derivative transactions as required by EMIR and Dodd-Frank regulatory reporting. Assigned at trade inception and maintained through lifecycle events.',
    `value_date` DATE COMMENT 'The date on which the trade economically takes effect and cash flows or securities are exchanged. Used for interest accrual and funding calculations.',
    CONSTRAINT pk_capture PRIMARY KEY(`capture_id`)
) COMMENT 'Authoritative trade booking record and single system of record in the trading platform (Murex/Calypso). Represents the confirmed, booked trade after execution, capturing trade date, value date, settlement date, notional amount, price/rate, accrued interest, trade currency, settlement currency, counterparty LEI, legal entity, trading book, and booking status. Supports all asset classes and product types including cash equities, bonds, IRS, CDS, FX spot/forward/swap/NDF, OTC options, equity swaps, and swaptions with product-type-specific attributes (e.g., UTI/USI for OTC derivatives, currency pair/forward points for FX, fixed/floating legs for swaps). Maintains full amendment and versioning history as lifecycle events on the trade record, including amendment type (economic amendment, administrative correction, novation, compression), amended fields with before/after values, amendment reason, approval workflow status, approver, amendment timestamp, and regulatory re-reporting flags for EMIR/Dodd-Frank/MiFID II. Each amendment creates a versioned snapshot preserving the complete audit trail. SSOT for the confirmed trade event, its full amendment audit trail, and all product types across capital markets.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_position` (
    `trade_position_id` BIGINT COMMENT 'Unique identifier for the trade position record. Primary key for the trade position entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Positions are reported as of period-end for period-end position reporting and balance sheet preparation. Required for financial close and regulatory reporting.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Position-level credit exposure calculations require counterparty PD/LGD from rating models for CVA, DVA, and RWA under SA-CCR or IMM. Essential for Basel III capital.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Position currency required for FX revaluation, P&L calculation, and risk reporting. Reference currency master provides FX rates, revaluation frequency, and base currency conversion rules.',
    `employee_id` BIGINT COMMENT 'Reference to the trader responsible for managing this position. Used for P&L attribution and performance tracking.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund positions tracked separately from proprietary trading book positions. Essential for fund NAV calculation, risk reporting (VaR, concentration limits), regulatory reporting (AIFMD leverage calculat',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Position instrument classification required for FRTB sensitivities calculation, risk-weighted assets, and regulatory capital. Reference classification provides CFI codes, risk categories, and capital ',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security, derivative, FX contract) for which this position is held.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Position risk management requires issuer-level concentration monitoring for single-name limits, issuer credit exposure aggregation, and regulatory capital calculations by issuer. Direct FK enables eff',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or books this position. Used for regulatory reporting and capital allocation.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty with whom the position was established. Used for counterparty credit risk and exposure management.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Position instrument mapping to reference data essential for risk aggregation, regulatory capital calculations (FRTB, Basel III), and instrument classification. Reference master provides CFI codes, ass',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Position-level limit monitoring is core to market risk management; positions must reference applicable limits (VaR, stress loss, concentration) for breach detection and ALCO reporting.',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading book under which this position is held. Trading books are used for regulatory capital calculations and risk management segmentation.',
    `accrued_income` DECIMAL(18,2) COMMENT 'The accrued interest, dividends, or coupon income earned but not yet received on the position.',
    `average_cost` DECIMAL(18,2) COMMENT 'The weighted average cost per unit at which the position was acquired. Used for realized P&L calculation.',
    `base_currency_code` STRING COMMENT 'The three-letter ISO currency code of the reporting entitys base currency for P&L and risk reporting.. Valid values are `^[A-Z]{3}$`',
    `base_currency_market_value` DECIMAL(18,2) COMMENT 'The market value of the position converted to the base currency using the FX rate.',
    `base_currency_unrealized_pnl` DECIMAL(18,2) COMMENT 'The unrealized P&L converted to the base currency for consolidated reporting.',
    `break_flag` BOOLEAN COMMENT 'Indicates whether this position has a reconciliation break or discrepancy that requires investigation.',
    `break_reason` STRING COMMENT 'Description of the reason for the position break or reconciliation discrepancy, if applicable.',
    `clean_price` DECIMAL(18,2) COMMENT 'The price of the instrument excluding accrued interest. Used for fixed income securities.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was first created in the system.',
    `delta` DECIMAL(18,2) COMMENT 'The rate of change of the position value with respect to changes in the underlying asset price. Primary Greek for options and derivatives.',
    `dirty_price` DECIMAL(18,2) COMMENT 'The price of the instrument including accrued interest. Used for fixed income securities.',
    `dv01` DECIMAL(18,2) COMMENT 'The dollar change in position value for a one basis point change in interest rates. Key risk sensitivity metric for fixed income positions.',
    `fx_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert position currency to base currency for consolidated reporting.',
    `gamma` DECIMAL(18,2) COMMENT 'The rate of change of delta with respect to changes in the underlying asset price. Second-order Greek for options.',
    `last_revaluation_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent MTM revaluation cycle that updated this positions market value and P&L.',
    `market_price` DECIMAL(18,2) COMMENT 'The current market price of the instrument used for MTM valuation. Updated during each revaluation cycle.',
    `market_value` DECIMAL(18,2) COMMENT 'The total market value of the position calculated as quantity multiplied by market price. Represents the current MTM value.',
    `position_date` DATE COMMENT 'The business date for which this position snapshot is recorded. Represents the end-of-day position as of this date.',
    `position_status` STRING COMMENT 'The current lifecycle status of the position. Open positions are actively managed, closed positions have been fully liquidated.. Valid values are `open|closed|suspended|pending`',
    `position_timestamp` TIMESTAMP COMMENT 'The precise timestamp when this position record was captured or updated. Used for intraday position keeping and real-time risk monitoring.',
    `position_type` STRING COMMENT 'Indicates whether the position is long (bought), short (sold), or flat (no position).. Valid values are `long|short|flat`',
    `quantity` DECIMAL(18,2) COMMENT 'The net quantity of the instrument held in this position. Positive for long positions, negative for short positions. Measured in the instruments native unit (shares, contracts, notional).',
    `quantity_unit` STRING COMMENT 'The unit of measure for the position quantity (e.g., shares for equities, contracts for futures, notional for swaps).. Valid values are `shares|contracts|lots|notional|units`',
    `realized_pnl` DECIMAL(18,2) COMMENT 'The cumulative realized profit or loss from closed or partially closed positions during the current period.',
    `rho` DECIMAL(18,2) COMMENT 'The sensitivity of the position value to changes in the risk-free interest rate. Greek for interest rate sensitivity.',
    `rwa_amount` DECIMAL(18,2) COMMENT 'The risk-weighted asset amount allocated to this position for regulatory capital calculations under Basel III.',
    `settlement_date` DATE COMMENT 'The date on which the most recent trade contributing to this position is scheduled to settle.',
    `theta` DECIMAL(18,2) COMMENT 'The rate of change of the position value with respect to the passage of time (time decay). Key Greek for options positions.',
    `unrealized_pnl` DECIMAL(18,2) COMMENT 'The unrealized profit or loss on the position, calculated as the difference between market value and cost basis. Updated with each MTM revaluation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this position record was last updated. Updated on each trade capture event, corporate action adjustment, or MTM revaluation.',
    `valuation_method` STRING COMMENT 'The method used to determine the market price for MTM valuation (e.g., market observable price, model-derived price, vendor pricing).. Valid values are `market|model|vendor|last_trade`',
    `valuation_source` STRING COMMENT 'The source system or vendor providing the market price used for MTM valuation (e.g., Bloomberg, Reuters, internal model).',
    `var_amount` DECIMAL(18,2) COMMENT 'The estimated maximum loss for this position over a specified time horizon at a given confidence level. Used for market risk management.',
    `vega` DECIMAL(18,2) COMMENT 'The sensitivity of the position value to changes in implied volatility. Key Greek for options positions.',
    CONSTRAINT pk_trade_position PRIMARY KEY(`trade_position_id`)
) COMMENT 'Real-time and end-of-day position record per trading book, instrument, and legal entity. Tracks long/short quantity, average cost, market value, unrealized P&L, realized P&L, accrued income, dirty/clean price, and Greek sensitivities (DV01, delta, gamma, vega, theta). Supports intraday position keeping, risk limit monitoring, regulatory capital calculations (FRTB), and serves as the base record for MTM revaluation and P&L attribution. Updated on each trade capture event, corporate action adjustment, and MTM revaluation cycle. Maintains position history for end-of-day snapshots enabling T-1 comparison and position break investigation.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`pnl_attribution` (
    `pnl_attribution_id` BIGINT COMMENT 'Unique identifier for the P&L attribution record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: P&L is attributed by accounting period for monthly/quarterly P&L reporting and financial close. Core requirement for management reporting and regulatory filings.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: P&L attribution currency must align with trading book base currency from reference data. Reference master provides FX rates for currency translation and consolidated P&L reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the trader responsible for the position and P&L.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: P&L attribution decomposes trading results by risk factors (IR curves, credit spreads, FX rates). This is the fundamental link for risk-based performance analysis and model validation.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund P&L attribution is distinct business requirement for fund performance analysis and reporting to investors. Required for fund performance attribution reports, manager evaluation, and explaining fu',
    `instrument_id` BIGINT COMMENT 'Identifier of the financial instrument for which P&L is attributed.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: P&L attribution product type needed for product-level performance analysis, management reporting, and business line profitability. Reference data provides product hierarchy and cost allocation rules.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: P&L asset class attribution needed for business line performance, risk-adjusted returns, and management reporting. Reference classification provides product hierarchy and performance measurement categ',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: P&L attribution requires instrument classification metadata for product-level performance analysis, risk factor decomposition, and management reporting. Reference data provides asset class, product ty',
    `trade_position_id` BIGINT COMMENT 'Identifier of the trading position associated with this P&L attribution.',
    `trading_book_id` BIGINT COMMENT 'Identifier of the trading book to which this P&L attribution applies.',
    `accrued_income` DECIMAL(18,2) COMMENT 'P&L component representing accrued interest, dividends, or coupon income earned but not yet received.',
    `attribution_method` STRING COMMENT 'Methodology used to calculate the P&L attribution (risk factor-based, scenario-based, hybrid, or full revaluation).. Valid values are `risk_factor|scenario|hybrid|full_revaluation`',
    `attribution_quality_score` DECIMAL(18,2) COMMENT 'Quality score (0-100) indicating the accuracy and completeness of the P&L attribution, with higher scores indicating lower unexplained P&L.',
    `attribution_status` STRING COMMENT 'Current status of the P&L attribution record in the attribution workflow.. Valid values are `preliminary|final|adjusted|reconciled|disputed|approved`',
    `attribution_timestamp` TIMESTAMP COMMENT 'Timestamp when the P&L attribution calculation was performed.',
    `basis_pnl` DECIMAL(18,2) COMMENT 'P&L component arising from basis risk, representing the difference between related but non-identical instruments or markets.',
    `cancellation_pnl` DECIMAL(18,2) COMMENT 'P&L component arising from trade cancellations or amendments during the valuation date.',
    `carry_pnl` DECIMAL(18,2) COMMENT 'P&L component representing the carry or cost of funding a position over time, including funding costs and benefits.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the P&L attribution, including explanations for large unexplained P&L or reconciliation breaks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the P&L attribution record was first created in the system.',
    `credit_spread_pnl` DECIMAL(18,2) COMMENT 'P&L component attributable to changes in credit spreads for credit-sensitive instruments.',
    `delta_pnl` DECIMAL(18,2) COMMENT 'P&L component attributable to changes in the underlying asset price (delta sensitivity).',
    `dividend_pnl` DECIMAL(18,2) COMMENT 'P&L component arising from dividend payments or changes in expected dividend forecasts for equity and equity derivative positions.',
    `fx_translation_pnl` DECIMAL(18,2) COMMENT 'P&L arising from foreign exchange translation effects when converting positions denominated in foreign currencies to the reporting currency.',
    `gamma_pnl` DECIMAL(18,2) COMMENT 'P&L component attributable to changes in delta due to underlying price movements (gamma sensitivity).',
    `mtm_pnl` DECIMAL(18,2) COMMENT 'P&L arising from changes in the mark-to-market valuation of positions held at the end of the valuation date.',
    `new_deal_pnl` DECIMAL(18,2) COMMENT 'P&L component arising from new trades executed during the valuation date.',
    `reconciliation_difference` DECIMAL(18,2) COMMENT 'Difference between front-office attributed P&L and finance-reported P&L, used for reconciliation and control purposes.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between front-office P&L attribution and finance P&L records.. Valid values are `matched|unmatched|pending|exception|resolved`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this P&L attribution record is subject to regulatory reporting requirements under FRTB or other frameworks.',
    `repo_pnl` DECIMAL(18,2) COMMENT 'P&L component arising from repurchase agreement (repo) transactions and related financing activities.',
    `rho_pnl` DECIMAL(18,2) COMMENT 'P&L component attributable to changes in interest rates (rho sensitivity).',
    `risk_factor_count` STRING COMMENT 'Number of risk factors used in the P&L attribution calculation for this record.',
    `source_system` STRING COMMENT 'Name of the source trading system from which the P&L attribution data originated.. Valid values are `murex|calypso|summit|other`',
    `theta_pnl` DECIMAL(18,2) COMMENT 'P&L component attributable to time decay (theta) of options and other time-sensitive derivatives.',
    `total_pnl` DECIMAL(18,2) COMMENT 'Total P&L for the trading book and instrument on the valuation date, representing the sum of all P&L components.',
    `trading_pnl` DECIMAL(18,2) COMMENT 'P&L arising from trading activity, including realized gains and losses from executed trades.',
    `unexplained_pnl` DECIMAL(18,2) COMMENT 'Residual P&L that cannot be attributed to any specific risk factor or component, representing model risk or unidentified factors.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the P&L attribution record was last updated or modified.',
    `valuation_date` DATE COMMENT 'The business date for which the P&L attribution is calculated.',
    `vega_pnl` DECIMAL(18,2) COMMENT 'P&L component attributable to changes in implied volatility (vega sensitivity).',
    CONSTRAINT pk_pnl_attribution PRIMARY KEY(`pnl_attribution_id`)
) COMMENT 'Daily P&L attribution record per trading book and instrument, decomposing total P&L into components: trading P&L, MTM P&L, accrued income, FX translation P&L, carry, theta, delta P&L, vega P&L, and unexplained P&L. Supports front-office P&L explain, finance reconciliation, and regulatory P&L attribution tests under FRTB. Aligned with Murex/Calypso P&L Attribution module.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`mtm_valuation` (
    `mtm_valuation_id` BIGINT COMMENT 'Unique identifier for the mark-to-market valuation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Valuations are performed as of period-end for period-end valuation, financial close, and regulatory reporting. Essential for period-end close process and audit.',
    `balance_sheet_position_id` BIGINT COMMENT 'Foreign key linking to treasury.balance_sheet_position. Business justification: MTM valuations feed balance sheet fair value measurements and unrealized P&L calculations. Required for fair value accounting, EVE sensitivity analysis, capital adequacy assessments, and IFRS 13 fair ',
    `branch_id` BIGINT COMMENT 'Identifier of the trading desk responsible for the position, supporting organizational P&L attribution.',
    `capture_id` BIGINT COMMENT 'Reference to the trade or position being valued.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the valuation, supporting segregation of duties and audit requirements.',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: MTM valuations depend on risk factors (discount curves, volatility surfaces, credit spreads) as pricing inputs. Essential for independent price verification and model risk management.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund holdings require independent MTM valuation for daily NAV calculation. Critical for fair value hierarchy compliance (IFRS 13), fund accounting, and regulatory reporting. Fund valuations may differ',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that holds the position, supporting regulatory reporting and capital allocation.',
    `rate_benchmark_id` BIGINT COMMENT 'Identifier of the discount curve used for present value calculations in derivative and fixed income valuations.',
    `trade_position_id` BIGINT COMMENT 'Reference to the aggregated position being valued, if applicable.',
    `trading_book_id` BIGINT COMMENT 'Identifier of the trading book or portfolio to which the position belongs, supporting P&L aggregation and risk reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Valuation currency validation required for fair value hierarchy compliance, IFRS reporting, and FX revaluation. Reference currency master provides rounding rules, minor units, and regulatory reporting',
    `valuation_model_id` BIGINT COMMENT 'Identifier of the internal valuation model used for mark-to-model calculations, supporting model risk management and audit trails.',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The interest that has accumulated on the security since the last coupon payment date, included in the dirty price calculation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when the valuation was approved and finalized for reporting and P&L calculation, supporting control and audit trails.',
    `clean_price` DECIMAL(18,2) COMMENT 'The price of the security excluding accrued interest, typically used for bonds and fixed income instruments.',
    `correlation_input` DECIMAL(18,2) COMMENT 'The correlation parameter used in multi-asset or basket derivative valuations, expressed as a decimal between -1 and 1.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the valuation record was first created in the system, supporting audit trails and data lineage.',
    `cva_adjustment` DECIMAL(18,2) COMMENT 'Credit Valuation Adjustment reflecting the market value of counterparty credit risk, reducing the fair value to account for the possibility of counterparty default.',
    `dirty_price` DECIMAL(18,2) COMMENT 'The price of the security including accrued interest, representing the total amount paid by the buyer.',
    `dva_adjustment` DECIMAL(18,2) COMMENT 'Debit Valuation Adjustment reflecting the market value of own credit risk, adjusting the fair value to account for the entitys own default risk.',
    `fair_value` DECIMAL(18,2) COMMENT 'The mark-to-market fair value of the position or trade at the valuation date and time, representing the price that would be received to sell an asset or paid to transfer a liability in an orderly transaction.',
    `fair_value_hierarchy_level` STRING COMMENT 'IFRS 9 and FASB ASC 820 fair value hierarchy classification: Level 1 (quoted prices in active markets), Level 2 (observable inputs other than quoted prices), Level 3 (unobservable inputs).. Valid values are `level_1|level_2|level_3`',
    `fva_adjustment` DECIMAL(18,2) COMMENT 'Funding Valuation Adjustment reflecting the cost of funding uncollateralized derivatives, adjusting the fair value for funding costs.',
    `fx_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the instruments native currency to the valuation currency, if applicable.',
    `fx_rate_source` STRING COMMENT 'The source of the FX rate used in the valuation (e.g., Bloomberg, Reuters, ECB, internal treasury rate).',
    `independent_price_verification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the valuation has undergone independent price verification by a separate control function, as required by regulatory standards.',
    `ipv_variance` DECIMAL(18,2) COMMENT 'The variance between the trading desk valuation and the independent price verification valuation, used for control and escalation purposes.',
    `market_price` DECIMAL(18,2) COMMENT 'The observable market price of the instrument at the valuation date and time, used for Level 1 fair value hierarchy instruments.',
    `model_version` STRING COMMENT 'Version number of the valuation model used, supporting model change tracking and regulatory model validation requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the valuation record was last modified, supporting change tracking and audit requirements.',
    `previous_fair_value` DECIMAL(18,2) COMMENT 'The fair value from the previous valuation date, used to calculate daily P&L movements.',
    `pricing_source` STRING COMMENT 'The primary source of pricing data used for the valuation: Bloomberg, Reuters, ICE Data Services, Markit, internal model, broker quote, exchange, or vendor composite. [ENUM-REF-CANDIDATE: bloomberg|reuters|ice|markit|internal_model|broker_quote|exchange|vendor_composite — 8 candidates stripped; promote to reference product]',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or notional amount of the position being valued.',
    `total_valuation_adjustments` DECIMAL(18,2) COMMENT 'The sum of all valuation adjustments (CVA, DVA, FVA, and other XVA components) applied to the fair value.',
    `unrealized_pnl` DECIMAL(18,2) COMMENT 'The unrealized profit or loss calculated as the difference between the current fair value and the previous valuation or book value, supporting daily P&L attribution.',
    `valuation_date` DATE COMMENT 'The business date for which the mark-to-market valuation is calculated.',
    `valuation_methodology` STRING COMMENT 'The methodology used to determine the fair value: mark-to-market (observable market prices), mark-to-model (internal valuation models), net asset value (NAV for funds), consensus pricing, vendor pricing, or internal model.. Valid values are `mark_to_market|mark_to_model|net_asset_value|consensus_pricing|vendor_pricing|internal_model`',
    `valuation_remarks` STRING COMMENT 'Free-text field for additional notes, explanations, or exceptions related to the valuation, supporting audit trails and control documentation.',
    `valuation_source_system` STRING COMMENT 'The name of the source system that generated the valuation (e.g., Murex, Calypso, Bloomberg MARS, internal risk engine).',
    `valuation_status` STRING COMMENT 'The current status of the valuation record in its lifecycle: preliminary (initial calculation), final (approved for reporting), adjusted (post-trade corrections), verified (independent price verification completed), pending review, or rejected.. Valid values are `preliminary|final|adjusted|verified|pending_review|rejected`',
    `valuation_timestamp` TIMESTAMP COMMENT 'The precise date and time when the valuation was performed, supporting intraday revaluation and audit trails.',
    `volatility_input` DECIMAL(18,2) COMMENT 'The volatility parameter used in option pricing models and derivative valuations, expressed as a decimal (e.g., 0.25 for 25% volatility).',
    `yield_rate` DECIMAL(18,2) COMMENT 'The yield to maturity or effective yield rate used in the valuation calculation for fixed income instruments.',
    CONSTRAINT pk_mtm_valuation PRIMARY KEY(`mtm_valuation_id`)
) COMMENT 'Mark-to-Market valuation record for each position or trade at a given valuation date and time. Captures fair value, valuation methodology (mark-to-market, mark-to-model, NAV), pricing source (Bloomberg, Reuters, internal model), clean price, dirty price, accrued interest, FX rate applied, discount curve, and valuation adjustments (CVA, DVA, FVA). Supports IFRS 9 fair value hierarchy disclosures and daily P&L calculation.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`settlement_instruction` (
    `settlement_instruction_id` BIGINT COMMENT 'Unique identifier for the settlement instruction record. Primary key.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Settlement instructions require BIC validation for SWIFT message routing, correspondent bank connectivity, and securities settlement. Reference BIC directory provides institution details, service prof',
    `capture_id` BIGINT COMMENT 'Reference to the parent trade transaction that generated this settlement instruction.',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Trade settlement instructions must specify the custodian account for securities/cash delivery. Critical for DVP settlement processing, SWIFT MT54x message generation, and reconciliation between tradin',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Settlement counterparty LEI needed for regulatory reporting, sanctions screening, and KYC compliance. Reference LEI registry provides legal entity verification, jurisdiction, and regulatory status.',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Settlement instructions create contractual cash inflows/outflows that feed liquidity forecasting and LCR calculations. Required for settlement-driven liquidity forecasting, intraday liquidity monitori',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity involved in this settlement instruction.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Settlement ISIN validation required for CSD matching, securities delivery, and settlement instruction generation. Reference identifier master provides authoritative ISIN and CSD eligibility for settle',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Settlement currency drives payment routing, correspondent bank selection, and SWIFT message generation. Reference data provides settlement conventions, RTGS system codes, and currency restrictions.',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Settlement instructions should reference the trading book for operational routing (which desk/book is settling), reconciliation (matching settlements to book positions), and P&L attribution (settlemen',
    `transfer_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_transfer. Business justification: Settlement instructions for collateral movements (IM/VM posting, substitutions) must link to collateral transfer records. Operations teams reconcile trade settlement instructions with collateral trans',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_account. Business justification: Settlement instructions specify nostro accounts for cash settlement of trades. Required for trade settlement cash management, nostro liquidity forecasting, intraday liquidity monitoring, and nostro re',
    `actual_settlement_date` DATE COMMENT 'Actual date on which the settlement was completed. Null if settlement has not yet occurred.',
    `affirmation_status` STRING COMMENT 'Status indicating whether the institutional investor has affirmed the settlement details.. Valid values are `pending|affirmed|disaffirmed`',
    `affirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement instruction was affirmed by the institutional investor.',
    `buy_in_execution_date` DATE COMMENT 'Date on which the mandatory buy-in was executed to cover the failed settlement.',
    `buy_in_flag` BOOLEAN COMMENT 'Boolean indicator of whether a mandatory buy-in process has been initiated under CSDR settlement discipline regime.',
    `buy_in_status` STRING COMMENT 'Current status of the mandatory buy-in process if initiated.. Valid values are `not_applicable|initiated|executed|cancelled`',
    `cash_correspondent_bic` STRING COMMENT 'SWIFT BIC of the cash correspondent bank handling the cash leg of the settlement.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `csd_name` STRING COMMENT 'Name of the Central Securities Depository or International Central Securities Depository handling the settlement.. Valid values are `DTC|Euroclear|Clearstream|other`',
    `csd_participant_code` STRING COMMENT 'Participant code identifying the entity within the CSD or ICSD system (e.g., DTC participant number, Euroclear participant ID).',
    `csdr_penalty_amount` DECIMAL(18,2) COMMENT 'Total cash penalty charges incurred under CSDR mandatory buy-in and penalty regime for settlement fails.',
    `csdr_penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which CSDR penalties are denominated.. Valid values are `^[A-Z]{3}$`',
    `fail_date` DATE COMMENT 'Date on which the settlement instruction first failed to settle.',
    `fail_duration_days` STRING COMMENT 'Number of business days the settlement instruction has been in a failed state.',
    `fail_flag` BOOLEAN COMMENT 'Boolean indicator of whether this settlement instruction has failed to settle on the intended settlement date.',
    `fail_reason_code` STRING COMMENT 'Standardized code indicating the reason for settlement failure: counterparty default (CPTY), insufficient securities (SECU), cash shortfall (CASH), matching discrepancy (MTCH), technical issue (TECH), or other (OTHR).. Valid values are `CPTY|SECU|CASH|MTCH|TECH|OTHR`',
    `fail_reason_description` STRING COMMENT 'Detailed textual description of the reason for settlement failure.',
    `instruction_created_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement instruction record was first created in the system.',
    `instruction_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement instruction record was last modified.',
    `instruction_reference_number` STRING COMMENT 'Externally visible unique reference number for this settlement instruction, used in SWIFT messaging and counterparty communication.',
    `intended_settlement_date` DATE COMMENT 'Original intended settlement date before any amendments or fails occurred.',
    `matching_status` STRING COMMENT 'Status indicating whether the settlement instruction has been matched with the counterparty instruction.. Valid values are `unmatched|matched|mismatched|alleged`',
    `matching_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement instruction was successfully matched with the counterparty instruction.',
    `nostro_account_iban` STRING COMMENT 'IBAN of the nostro account (our account held at another bank) used for cash settlement.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `resolution_action` STRING COMMENT 'Description of the action taken to resolve the settlement failure (e.g., securities borrowed, cash advanced, trade cancelled).',
    `security_quantity` DECIMAL(18,2) COMMENT 'Quantity of securities to be delivered or received in this settlement instruction.',
    `settlement_agent_bic` STRING COMMENT 'SWIFT BIC of the settlement agent or intermediary bank facilitating the settlement.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Total monetary amount to be settled, including principal and any accrued interest or fees.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle convention applicable to this instruction (e.g., T+1, T+2).. Valid values are `T+0|T+1|T+2|T+3`',
    `settlement_date` DATE COMMENT 'Contractual date on which the settlement of securities and cash is scheduled to occur, following T+1 or T+2 convention.',
    `settlement_method` STRING COMMENT 'Method by which settlement is executed: Central Securities Depository (CSD), International Central Securities Depository (ICSD), bilateral, or triparty.. Valid values are `CSD|ICSD|bilateral|triparty`',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement instruction in the post-trade workflow. [ENUM-REF-CANDIDATE: pending|matched|affirmed|settled|failed|cancelled|partial — 7 candidates stripped; promote to reference product]',
    `settlement_type` STRING COMMENT 'Type of settlement mechanism: Delivery Versus Payment (DVP), Receive Versus Payment (RVP), Free Of Payment (FOP), or Payment Free of Payment (PFP).. Valid values are `DVP|RVP|FOP|PFP`',
    `swift_message_reference` STRING COMMENT 'Unique reference number of the SWIFT message sent or received for this settlement instruction.',
    `swift_message_type` STRING COMMENT 'SWIFT MT54x message type used to communicate this settlement instruction (e.g., MT540 for receive free, MT541 for receive against payment). [ENUM-REF-CANDIDATE: MT540|MT541|MT542|MT543|MT544|MT545|MT546|MT547|MT548|MT549 — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_settlement_instruction PRIMARY KEY(`settlement_instruction_id`)
) COMMENT 'Settlement instruction record generated post-trade for delivery versus payment (DVP), free of payment (FOP), or FX settlement. Captures settlement date, settlement amount, settlement currency, IBAN/SWIFT BIC of custodian, CSD/ICSD (DTC, Euroclear, Clearstream), settlement status (pending, matched, settled, failed), settlement agent, and nostro account. Includes fail tracking attributes: fail date, fail reason (counterparty default, insufficient securities, cash shortfall, matching discrepancy), fail duration, CSDR cash penalty charges, buy-in status, and resolution actions. Supports T+1/T+2 settlement cycles, SWIFT MT54x messaging, CSDR mandatory buy-in compliance, and settlement efficiency reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`confirmation` (
    `confirmation_id` BIGINT COMMENT 'Unique identifier for the trade confirmation record. Primary key for the trade confirmation entity.',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to trade.allocation. Business justification: Confirmations can be generated per allocation for allocated trades (each allocated account may receive a separate confirmation). This links confirmations to specific allocations for affirmation and ma',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to trade.amendment. Business justification: Amendments require new confirmations (amended trade terms must be confirmed with counterparty). This links the confirmation to the amendment, allowing confirmation tracking for amended trades and audi',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Confirmation routing depends on counterparty BIC for SWIFT messaging, trade repository reporting, and affirmation platforms. Reference BIC directory provides institution connectivity and service profi',
    `capture_id` BIGINT COMMENT 'Reference to the underlying trade transaction that this confirmation documents. Links to the trade execution record in the trading system.',
    `counterparty_agreement_id` BIGINT COMMENT 'Reference to the ISDA master agreement governing the legal terms and conditions of OTC derivative transactions with this counterparty.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Confirmation counterparty LEI required for trade repository reporting, regulatory compliance, and counterparty matching. Reference registry provides legal entity name, jurisdiction, and ultimate paren',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the Credit Support Annex that governs collateral posting requirements for this trade under the ISDA framework.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Confirmation currency must validate for counterparty matching, discrepancy resolution, and regulatory reporting. Reference currency master provides ISO codes and rounding rules for confirmation tolera',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity with whom this trade was executed and confirmed. Essential for counterparty risk management and exposure tracking.',
    `swift_message_id` BIGINT COMMENT 'Unique SWIFT message identifier for the confirmation message sent or received via SWIFT network. Used for message tracking and audit trail.',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Confirmations should reference the trading book for operational context (which desk is confirming), reconciliation (matching confirmations to book trades), and audit trail (confirmation status by book',
    `affirmation_status` STRING COMMENT 'Status of institutional trade affirmation process, particularly relevant for securities trades requiring custodian or investment manager affirmation.. Valid values are `affirmed|pending_affirmation|rejected|not_required`',
    `amendment_reason` STRING COMMENT 'Reason for any amendments or corrections made to the original confirmation. Captures business justification for confirmation changes.',
    `asset_class` STRING COMMENT 'The broad asset class category of the trade being confirmed. Determines applicable regulatory requirements and confirmation timelines. [ENUM-REF-CANDIDATE: equity|fixed_income|fx|commodity|credit|rates|otc_derivative — 7 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation of the trade confirmation, if applicable. Includes trade cancellation, error correction, or mutual agreement to unwind.',
    `confirmation_method` STRING COMMENT 'Method by which the trade confirmation was exchanged with the counterparty. Electronic methods include DTCC, MarkitWire, SWIFT MT3xx messages; manual methods include paper, email, fax. [ENUM-REF-CANDIDATE: electronic|paper|swift|dtcc|markit_wire|email|fax — 7 candidates stripped; promote to reference product]',
    `confirmation_number` STRING COMMENT 'Externally-known unique confirmation reference number exchanged with counterparties. Used for reconciliation and dispute resolution.',
    `confirmation_status` STRING COMMENT 'Current lifecycle status of the trade confirmation. Tracks progression from initial unconfirmed state through final confirmed or disputed resolution. [ENUM-REF-CANDIDATE: unconfirmed|confirmed|disputed|cancelled|pending|matched|mismatched — 7 candidates stripped; promote to reference product]',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the trade confirmation was successfully matched and confirmed by both parties. Critical for regulatory timely confirmation requirements under Dodd-Frank and EMIR.',
    `counterparty_confirmation_number` STRING COMMENT 'The confirmation reference number assigned by the counterparty to this trade. Used for bilateral reconciliation and matching.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this confirmation record was first created in the system. Audit trail for record lifecycle tracking.',
    `deadline` TIMESTAMP COMMENT 'Regulatory deadline by which the trade must be confirmed to comply with Dodd-Frank and EMIR timely confirmation requirements. Varies by asset class and trade type.',
    `discrepancy_description` STRING COMMENT 'Detailed description of any economic terms discrepancies identified between internal trade records and counterparty confirmation. Includes field-level differences in price, quantity, dates, or other material terms.',
    `discrepancy_flag` BOOLEAN COMMENT 'Indicates whether any economic terms discrepancies were identified during the confirmation matching process. True if discrepancies exist requiring resolution.',
    `discrepancy_resolution_date` DATE COMMENT 'The date on which any identified discrepancies were resolved and the confirmation was successfully matched. Null if discrepancies remain outstanding.',
    `dtcc_confirmation_reference` STRING COMMENT 'Unique confirmation identifier assigned by DTCC for electronically confirmed trades processed through DTCC Deriv/SERV or other DTCC confirmation platforms.',
    `lei_reporting_entity` STRING COMMENT '20-character Legal Entity Identifier of the reporting entity (the bank) for regulatory trade reporting purposes.. Valid values are `^[A-Z0-9]{20}$`',
    `markit_wire_reference` STRING COMMENT 'Unique reference number assigned by MarkitWire electronic confirmation platform for OTC derivative confirmations processed through MarkitWire.',
    `matching_tolerance_breached` BOOLEAN COMMENT 'Indicates whether the confirmation matching process identified differences that exceeded predefined tolerance thresholds for price, quantity, or other economic terms.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this confirmation record was last modified. Tracks all updates and amendments to the confirmation.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The notional principal amount of the trade as confirmed. For derivatives, this is the reference amount used to calculate cash flows, not the actual cash exchanged.',
    `product_type` STRING COMMENT 'Specific product type within the asset class, such as interest rate swap, credit default swap, equity option, FX forward, etc.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity or number of units traded, applicable for securities and exchange-traded instruments. For OTC derivatives, may represent contract size.',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the counterparty confirmation was received for matching against internal trade records.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this confirmation is subject to regulatory trade reporting requirements under Dodd-Frank, EMIR, or MiFID II. True if reporting is required.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time when the confirmation was initially sent to the counterparty for matching and acknowledgment.',
    `settlement_date` DATE COMMENT 'The date on which the trade is scheduled to settle and cash/securities exchange occurs. Typically T+1 or T+2 depending on asset class and jurisdiction.',
    `source_system` STRING COMMENT 'The source trading or confirmation system that generated this confirmation record, such as Murex, Calypso, or other trading platform.',
    `swift_message_type` STRING COMMENT 'The SWIFT message type used for electronic confirmation, typically MT300 series for FX and derivatives (MT300, MT320, MT330, etc.).',
    `trade_date` DATE COMMENT 'The date on which the trade was executed. Captured on the confirmation for reconciliation and settlement timeline calculation.',
    `trade_price` DECIMAL(18,2) COMMENT 'The execution price of the trade as confirmed by both parties. For securities, this is the per-unit price; for derivatives, may represent strike, rate, or spread.',
    `uti` STRING COMMENT 'Globally unique trade identifier assigned to the trade for regulatory reporting purposes. Required under Dodd-Frank and EMIR for OTC derivatives.',
    `version_number` STRING COMMENT 'Version number of the confirmation record. Increments when amendments or corrections are made to the original confirmation.',
    CONSTRAINT pk_confirmation PRIMARY KEY(`confirmation_id`)
) COMMENT 'Trade confirmation record exchanged with counterparties for OTC derivatives and securities trades. Captures confirmation method (electronic via DTCC/MarkitWire, paper, SWIFT MT3xx), confirmation status (unconfirmed, confirmed, disputed, cancelled), confirmation timestamp, ISDA master agreement reference, CSA reference, and any economic terms discrepancies. Supports Dodd-Frank and EMIR timely confirmation requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trading_book` (
    `trading_book_id` BIGINT COMMENT 'Unique identifier for the trading book. Primary key.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Trading books operate within board-approved risk appetite statements defining acceptable risk levels. This link enforces governance, strategic risk boundaries, and ICAAP/ILAAP frameworks.',
    `balance_sheet_position_id` BIGINT COMMENT 'Foreign key linking to treasury.balance_sheet_position. Business justification: Trading books are balance sheet positions from treasury ALM perspective. Required for trading book to balance sheet reconciliation, FRTB regulatory reporting, capital adequacy calculations, and ALCO r',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Trading books require benchmark assignment for performance measurement (book P&L vs benchmark return), tracking error monitoring, benchmark-relative VaR limits, and investment mandate compliance. Stan',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Trading books are owned by organizational business units for P&L aggregation, risk limit allocation, FRTB regulatory capital calculations, and management reporting hierarchies. Banks track which org_u',
    `parent_book_trading_book_id` BIGINT COMMENT 'Identifier of the parent trading book in the book hierarchy. Null if this is a top-level book. Used for hierarchical risk aggregation.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the head trader or portfolio manager responsible for the book. Used for accountability and limit approval workflows.',
    `profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `quaternary_trading_head_trader_employee_id` BIGINT COMMENT 'FK to hr.employee',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Trading books are stress-tested under regulatory scenarios (CCAR, DFAST, EBA) for stress capital buffer calculations and recovery planning. Essential for FRTB and Pillar 2 capital.',
    `tertiary_trading_approved_by_user_employee_id` BIGINT COMMENT 'User identifier of the risk manager or approver who approved this trading book or its limit framework.',
    `approval_status` STRING COMMENT 'Current approval status of the trading book setup or limit changes. Only approved books can be activated.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this trading book or its limit framework was approved.',
    `asset_class` STRING COMMENT 'Primary asset class traded within this book. Determines applicable risk models, capital requirements, and regulatory treatment.. Valid values are `rates|credit|equity|fx|commodity|structured`',
    `base_currency` STRING COMMENT 'ISO 4217 three-letter currency code representing the base currency for P&L reporting and risk measurement for this book.. Valid values are `^[A-Z]{3}$`',
    `book_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the trading book across systems and regulatory reports. Used in trade capture, risk reporting, and P&L attribution.. Valid values are `^[A-Z0-9]{4,12}$`',
    `book_hierarchy_level` STRING COMMENT 'Numeric level in the trading book hierarchy (1 = top level, 2 = sub-book, etc.). Used for roll-up and drill-down reporting.',
    `book_name` STRING COMMENT 'Human-readable name of the trading book, typically reflecting the desk, asset class, or strategy (e.g., USD Rates Desk, Equity Derivatives EMEA).',
    `book_short_name` STRING COMMENT 'Abbreviated name or acronym for the trading book used in operational systems and trader screens.',
    `book_status` STRING COMMENT 'Current operational status of the trading book. Only active books can accept new trades.. Valid values are `active|inactive|suspended|closed|pending_approval`',
    `concentration_limit_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of book exposure that can be concentrated in a single issuer, counterparty, or instrument. Expressed as percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trading book record was first created in the system.',
    `desk_name` STRING COMMENT 'Name of the trading desk or unit responsible for this book. Used for organizational hierarchy and P&L roll-up.',
    `dv01_limit_amount` DECIMAL(18,2) COMMENT 'Maximum DV01 (dollar value of a one basis point move in interest rates) limit for the book, expressed in base currency. Applicable primarily to rates books.',
    `effective_date` DATE COMMENT 'Date when the trading book became operational and started accepting trades.',
    `frtb_approach` STRING COMMENT 'Capital calculation approach used for this book under FRTB: Standardized Approach (SA) or Internal Models Approach (IMA).. Valid values are `standardized|internal_models|hybrid`',
    `ima_approval_status` STRING COMMENT 'Regulatory approval status for using Internal Models Approach (IMA) for this book. Only approved books can use IMA for capital calculation.. Valid values are `approved|pending|not_applicable|rejected`',
    `is_proprietary_trading` BOOLEAN COMMENT 'Boolean flag indicating whether this book engages in proprietary trading (True) or client-facilitation trading (False). Relevant for Volcker Rule compliance.',
    `last_limit_review_date` DATE COMMENT 'Date when risk limits for this book were last reviewed and approved by the Asset-Liability Committee (ALCO) or risk committee.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trading book record was last modified.',
    `lob_code` STRING COMMENT 'Code identifying the line of business (LOB) to which this trading book belongs. Used for management reporting and profitability analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `lob_name` STRING COMMENT 'Name of the line of business (LOB) to which this trading book belongs.',
    `location_code` STRING COMMENT 'Three-letter code identifying the primary trading location or office for this book (e.g., NYC, LDN, HKG).. Valid values are `^[A-Z]{3}$`',
    `next_limit_review_date` DATE COMMENT 'Scheduled date for the next risk limit review for this book.',
    `notional_limit_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate notional exposure limit for the book, expressed in base currency. Controls gross position size.',
    `region_code` STRING COMMENT 'Geographic region code where the trading book operates. Used for regional risk aggregation and regulatory reporting.. Valid values are `AMER|EMEA|APAC|LATAM`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the book per FRTB framework. Determines capital calculation methodology (market risk vs credit risk).. Valid values are `trading_book|banking_book|correlation_trading|securitization`',
    `stress_loss_limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowable loss under stress scenarios, expressed in base currency. Used for stress testing and CCAR/DFAST compliance.',
    `termination_date` DATE COMMENT 'Date when the trading book was closed or terminated. Null for active books.',
    `trading_strategy` STRING COMMENT 'Primary trading strategy employed by the book (e.g., market making, proprietary trading, client facilitation). Influences risk appetite and limit framework.. Valid values are `market_making|proprietary|flow|arbitrage|hedging|client_facilitation`',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'Confidence level (as percentage) used for VaR calculation, typically 99% or 95%.',
    `var_limit_amount` DECIMAL(18,2) COMMENT 'Maximum Value at Risk (VaR) limit assigned to this trading book, expressed in base currency. Represents the maximum potential loss at a given confidence level.',
    `var_time_horizon_days` STRING COMMENT 'Time horizon in days over which VaR is calculated, typically 1 day or 10 days.',
    `volcker_rule_exemption` STRING COMMENT 'Applicable Volcker Rule exemption category for this book, if any. Determines permissible trading activities under Dodd-Frank.. Valid values are `market_making|underwriting|hedging|trading_on_behalf_of_customers|none`',
    CONSTRAINT pk_trading_book PRIMARY KEY(`trading_book_id`)
) COMMENT 'Master record for each trading book (desk-level portfolio) within the banks trading organization. Captures book name, book code, asset class, trading strategy, responsible desk, head trader, legal entity, regulatory classification (trading book vs banking book per FRTB), risk limits (VaR limit, DV01 limit, notional limit), base currency, and book status. SSOT for trading book hierarchy and limit framework.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the trade amendment record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Amendments are booked in accounting periods for period attribution of corrections and audit trail. Required for financial control and period-end close.',
    `employee_id` BIGINT COMMENT 'Reference to the trader who initiated the amendment request.',
    `party_id` BIGINT COMMENT 'Reference to the new counterparty in case of novation. The party to whom the trade obligation is transferred. Null for non-novation amendments.',
    `amendment_party_id` BIGINT COMMENT 'Reference to the counterparty involved in the trade amendment. May differ from original trade counterparty in case of novation.',
    `approver_employee_id` BIGINT COMMENT 'Reference to the authorized person who approved the amendment. Null if not yet approved.',
    `capture_id` BIGINT COMMENT 'Reference to the original trade that is being amended. Links to the parent trade record in the trading system.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Amendment currency validation required for economic impact calculation, P&L adjustment, and regulatory reporting. Reference data provides FX rates and currency attributes for lifecycle event processin',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Trade amendments with P&L impact generate correcting journal entries for trade correction accounting and audit trail. Required for financial control and regulatory reporting.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Amendment counterparty LEI validation required for lifecycle event reporting to trade repositories and regulatory compliance. Reference registry provides legal entity details for derivatives reporting',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Amendments should reference the trading book for operational context (which desk is amending), P&L impact tracking (amendment P&L by book), and regulatory reporting (amendment activity by book for MiF',
    `amended_field_names` STRING COMMENT 'Comma-separated list of trade fields that were modified in this amendment (e.g., notional_amount, maturity_date, fixed_rate). Supports audit trail and change tracking.',
    `amended_fixed_rate` DECIMAL(18,2) COMMENT 'The new fixed rate after the amendment. Null if rate was not changed.',
    `amended_maturity_date` DATE COMMENT 'The new maturity date after the amendment. Null if maturity was not changed.',
    `amended_notional_amount` DECIMAL(18,2) COMMENT 'The new notional amount after the amendment. Null if notional was not changed.',
    `amended_strike_price` DECIMAL(18,2) COMMENT 'The new strike price after the amendment. Null if strike was not changed.',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment request. Tracks the approval workflow from submission through completion or rejection.. Valid values are `pending|approved|rejected|cancelled|completed`',
    `amendment_timestamp` TIMESTAMP COMMENT 'Date and time when the amendment was executed and became effective. This is the business event timestamp for the modification.',
    `amendment_type` STRING COMMENT 'Classification of the amendment. Economic amendments change trade economics (price, notional, rate); administrative corrections fix data errors; novations transfer obligations; compressions reduce gross notional; terminations close positions. [ENUM-REF-CANDIDATE: economic_amendment|administrative_correction|novation|compression|partial_termination|full_termination|rate_reset|notional_adjustment — 8 candidates stripped; promote to reference product]',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the amendment was approved by authorized personnel. Null if not yet approved or if rejected.',
    `booking_entity` STRING COMMENT 'Legal entity or trading desk where the amended trade is booked. May change in case of novation or internal transfer.',
    `comments` STRING COMMENT 'Free-text field for additional notes, instructions, or context related to the amendment. Used for operational communication and audit trail.',
    `compression_cycle_code` STRING COMMENT 'Reference to the portfolio compression cycle if this amendment is part of a multilateral compression exercise. Null for non-compression amendments.',
    `confirmation_status` STRING COMMENT 'Status of trade confirmation with the counterparty following the amendment. Tracks whether both parties have agreed to the amended terms.. Valid values are `pending|confirmed|disputed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this amendment record was first created in the system. Audit trail for record creation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this amendment record was last updated. Audit trail for record modifications.',
    `mtm_impact_amount` DECIMAL(18,2) COMMENT 'The change in mark-to-market valuation resulting from the amendment. Positive values indicate gains, negative values indicate losses.',
    `original_fixed_rate` DECIMAL(18,2) COMMENT 'The fixed rate (expressed as a decimal, e.g., 0.0325 for 3.25%) before the amendment. Applicable to interest rate swaps and fixed-income derivatives.',
    `original_maturity_date` DATE COMMENT 'The maturity date of the trade before the amendment. Captured for audit trail when maturity is extended or shortened.',
    `original_notional_amount` DECIMAL(18,2) COMMENT 'The notional amount of the trade before the amendment. Captured for audit trail and regulatory reporting of economic changes.',
    `original_strike_price` DECIMAL(18,2) COMMENT 'The strike price before the amendment. Applicable to options and structured products.',
    `pnl_impact_amount` DECIMAL(18,2) COMMENT 'The realized profit or loss impact of the amendment on the trading book. Captures economic gain or loss from the modification.',
    `product_type` STRING COMMENT 'Classification of the derivative or security product being amended (e.g., Interest Rate Swap, FX Forward, Credit Default Swap, Equity Option).',
    `reason` STRING COMMENT 'Detailed business justification for the amendment. Captures the rationale for modifying the original trade terms, required for audit and regulatory reporting.',
    `reference_number` STRING COMMENT 'Business identifier for the amendment, typically generated by the trading system (Murex/Calypso) for external reference and audit trail.',
    `regulatory_report_timestamp` TIMESTAMP COMMENT 'Date and time when the amendment was reported to the trade repository or regulatory authority. Null if not yet reported.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires re-reporting to regulatory authorities under EMIR, Dodd-Frank, or MiFID II. True if re-reporting is required.',
    `settlement_date` DATE COMMENT 'Settlement date of the amended trade. May differ from original settlement date if amendment affects settlement terms.',
    `source_system` STRING COMMENT 'Trading system that originated the amendment record (e.g., Murex, Calypso). Supports data lineage and reconciliation.. Valid values are `murex|calypso|summit|other`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the amendment request was initially submitted for approval.',
    `trade_date` DATE COMMENT 'Original trade date of the parent trade. Included for reference and audit trail.',
    `uti` STRING COMMENT 'Unique Trade Identifier assigned to the amended trade for regulatory reporting. May be the same as original trade UTI or a new UTI depending on amendment type.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Record of post-trade amendments and modifications to booked trades. Captures amendment type (economic amendment, administrative correction, novation, compression), original trade reference, amended fields, amendment reason, amendment timestamp, approval status, approver, and regulatory re-reporting flag. Supports audit trail for trade lifecycle management and regulatory reporting obligations under EMIR/Dodd-Frank.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Unique identifier for the trade allocation record. Primary key for the trade allocation entity.',
    `capture_id` BIGINT COMMENT 'Reference to the parent block trade that is being allocated across multiple accounts or sub-portfolios.',
    `allocation_capture_id` BIGINT COMMENT 'Reference to the underlying trade execution record from the trading system.',
    `broker_id` BIGINT COMMENT 'Reference to the broker responsible for clearing and settlement of this allocation.',
    `party_id` BIGINT COMMENT 'Reference to the custodian bank holding the securities for the allocated account, used for settlement instruction routing.',
    `allocation_executing_broker_id` BIGINT COMMENT 'Reference to the broker who executed the original block trade before allocation.',
    `allocation_give_up_broker_id` BIGINT COMMENT 'Reference to the broker receiving the give-up allocation in step-out workflows, where execution is transferred to another broker for clearing.',
    `allocation_party_id` BIGINT COMMENT 'Reference to the institutional client on whose behalf the allocation is made, used in prime brokerage and institutional trading.',
    `branch_id` BIGINT COMMENT 'Reference to the trading desk responsible for the allocation, used for P&L (Profit and Loss) attribution and risk management.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Allocation currency needed for commission calculation, net settlement amount, and fund accounting. Reference currency master provides minor units, rounding rules, and settlement conventions.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Block trade allocations to institutional investors in IPOs/secondaries require deal linkage for IPO allocation management, greenshoe exercise tracking, allocation fairness reviews, and regulatory fili',
    `employee_id` BIGINT COMMENT 'Reference to the trader who performed the allocation, used for audit trail and performance attribution.',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund receiving this allocation, used in asset management and wealth management contexts.',
    `gl_account_id` BIGINT COMMENT 'Reference to the sub-portfolio or sleeve within a fund structure receiving this allocation.',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security, derivative, FX (Foreign Exchange) contract) being allocated.',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.mandate. Business justification: Allocations under advisory mandates (managed account trades, discretionary portfolio management) require mandate tracking for mandate compliance verification, discretionary trading authorization, suit',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Block orders are allocated post-execution across multiple accounts/funds. The allocation should reference the original order for audit trail, order management context, and regulatory reporting (linkin',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Allocation asset class must align with reference classification for risk reporting, regulatory capital, and fund accounting. Reference classification master provides CFI codes, FRTB treatment, and reg',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Allocated instrument must resolve to reference identifiers for settlement instruction generation, custodian routing, and regulatory reporting. Reference data provides ISIN, CUSIP, SEDOL mappings requi',
    `settlement_instruction_id` BIGINT COMMENT 'Reference to the settlement instruction record specifying how this allocation will settle, including delivery versus payment (DVP) details.',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading book where the allocation is recorded for regulatory capital and risk reporting under FRTB (Fundamental Review of the Trading Book).',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The accrued interest amount included in the allocation for fixed income instruments, calculated from last coupon date to trade date.',
    `affirmation_platform` STRING COMMENT 'The name of the affirmation platform used to confirm the allocation, such as OASYS, ALERT, Omgeo Central Trade Manager (CTM), or Bloomberg AIM.',
    `affirmation_status` STRING COMMENT 'The status of the allocation in the affirmation workflow. Pending awaits counterparty confirmation, affirmed is matched, unmatched has discrepancies, exception requires manual intervention, cancelled is voided.. Valid values are `pending|affirmed|unmatched|exception|cancelled`',
    `affirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was affirmed by the counterparty or custodian through OASYS, ALERT, or similar affirmation platform.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The total notional value of the allocation, calculated as allocated quantity multiplied by allocated price.',
    `allocated_price` DECIMAL(18,2) COMMENT 'The price at which the allocated quantity is assigned to this account. May be average price or specific fill price depending on allocation method.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'The quantity of the security or instrument allocated to this account or fund from the block trade.',
    `allocation_method` STRING COMMENT 'The method used to distribute the block trade across accounts. Pro-rata allocates proportionally, manual is trader-specified, step-out is give-up to another broker, average price uses weighted average, specific fill assigns exact executions, FIFO (First In First Out) uses order sequence.. Valid values are `pro_rata|manual|step_out|average_price|specific_fill|fifo`',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the allocation. Pending awaits affirmation, affirmed is confirmed by counterparty, rejected is declined, cancelled is voided, amended is modified, settled is completed.. Valid values are `pending|affirmed|rejected|cancelled|amended|settled`',
    `allocation_timestamp` TIMESTAMP COMMENT 'The date and time when the allocation was created and submitted for processing.',
    `amendment_reason` STRING COMMENT 'Free-text explanation of why the allocation was amended after initial submission, used for audit trail and compliance.',
    `comments` STRING COMMENT 'Free-text comments or notes about the allocation, used for operational communication and exception handling.',
    `commission_amount` DECIMAL(18,2) COMMENT 'The commission charged for this allocation, allocated proportionally from the block trade commission.',
    `commission_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the commission amount.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was first created in the system, used for audit trail and data lineage.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net settlement amount for this allocation after commissions, fees, and accrued interest, representing the cash flow to or from the account.',
    `percentage` DECIMAL(18,2) COMMENT 'The percentage of the total block trade allocated to this account, expressed as a decimal (e.g., 25.50 for 25.5%).',
    `product_type` STRING COMMENT 'The specific product type within the asset class, such as corporate bond, equity option, interest rate swap, or FX (Foreign Exchange) forward.',
    `reference` STRING COMMENT 'External business reference number for the allocation, used for client communication and affirmation workflows.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this allocation must be reported to regulatory authorities under MiFID II, Dodd-Frank, or other trade reporting regimes.',
    `rejection_reason` STRING COMMENT 'Free-text explanation of why the allocation was rejected by the counterparty or failed affirmation, used for exception management.',
    `settlement_date` DATE COMMENT 'The date on which the allocated trade is scheduled to settle, typically T+1 or T+2 depending on asset class and market.',
    `side` STRING COMMENT 'Indicates whether the allocation is a buy or sell from the perspective of the allocated account.. Valid values are `buy|sell`',
    `source_system` STRING COMMENT 'The name of the trading or order management system that generated the allocation record, such as Murex, Calypso, or Bloomberg EMSX.',
    `trade_date` DATE COMMENT 'The date on which the original block trade was executed, used for settlement cycle calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation record was last modified, used for audit trail and change tracking.',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Post-execution trade allocation record distributing a block trade across multiple accounts, funds, or sub-portfolios. Captures block trade reference, allocated account, allocated quantity, allocated price, allocation method (pro-rata, manual, step-out), allocation percentage, allocation status (pending, affirmed, rejected), give-up broker, and settlement instruction reference. Supports institutional client give-up workflows, fund accounting, OASYS/ALERT affirmation processes, and average price allocation for multi-fill block trades.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_margin_call` (
    `trade_margin_call_id` BIGINT COMMENT 'Unique identifier for the margin call record. Primary key for the trade margin call entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Margin calls are settled in accounting periods for period-end margin reconciliation and collateral accounting. Required for balance sheet reporting and regulatory compliance.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Margin call currency validation required for collateral valuation, settlement processing, and CSA agreement compliance. Reference data provides FX rates and currency restrictions for margin calculatio',
    `capture_id` BIGINT COMMENT 'Reference to the underlying trade or derivative contract that triggered this margin call.',
    `collateral_margin_call_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_call. Business justification: Trade margin calls (front-office OTC derivatives) and collateral margin calls (collateral management system) represent the same business event. Critical for daily reconciliation between trading system',
    `counterparty_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex agreement governing the collateral terms for this margin call.',
    `credit_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.credit_exposure. Business justification: Margin calls are triggered by credit exposure breaches under CSA agreements. This link connects collateral management to exposure monitoring for operational and regulatory compliance.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Margin call counterparty LEI needed for collateral reporting, regulatory transparency, and CSA agreement identification. Reference registry provides legal entity verification and jurisdiction for marg',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Margin calls create immediate liquidity outflows that must be reflected in intraday and daily liquidity positions. Required for LCR monitoring, intraday liquidity risk management, and contingency fund',
    `party_id` BIGINT COMMENT 'Reference to the counterparty involved in the margin call, either issuing or receiving the call.',
    `trade_position_id` BIGINT COMMENT 'Foreign key linking to trade.trade_position. Business justification: Margin calls are triggered by position exposure (MTM value, concentration, VaR). Currently only links to capture (individual trade) and party. Adding position link allows margin calculation based on a',
    `booking_entity_lei` STRING COMMENT 'The 20-character Legal Entity Identifier of the bank entity booking this margin call.. Valid values are `^[A-Z0-9]{20}$`',
    `call_amount` DECIMAL(18,2) COMMENT 'The total amount of collateral or cash being called or returned in the margin call.',
    `call_date` DATE COMMENT 'The date on which the margin call was issued or received.',
    `call_direction` STRING COMMENT 'Indicates whether the margin call was issued by the bank to the counterparty or received from the counterparty.. Valid values are `issued|received`',
    `call_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the margin call was generated, supporting intraday margin call workflows.',
    `call_type` STRING COMMENT 'Type of margin call: variation margin (VM) to cover mark-to-market exposure, initial margin (IM) for potential future exposure, additional margin for increased risk, or return of excess collateral.. Valid values are `variation_margin|initial_margin|additional_margin|return_excess`',
    `clearing_house_code` BIGINT COMMENT 'Reference to the central counterparty clearing house if this is a cleared margin call.',
    `clearing_house_flag` BOOLEAN COMMENT 'Indicates whether this margin call is for a centrally cleared derivative (true) or a bilateral OTC derivative (false).',
    `collateral_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the collateral pledged.. Valid values are `^[A-Z]{3}$`',
    `collateral_held_amount` DECIMAL(18,2) COMMENT 'The total value of collateral currently held against the exposure prior to this margin call.',
    `collateral_pledged_amount` DECIMAL(18,2) COMMENT 'The total value of collateral pledged in response to this margin call.',
    `collateral_type` STRING COMMENT 'The primary type of collateral pledged or called: cash, government bonds, corporate bonds, equities, or other eligible securities.. Valid values are `cash|government_bonds|corporate_bonds|equities|other_securities`',
    `comments` STRING COMMENT 'Free-text field for additional notes, instructions, or context regarding the margin call.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this margin call record was first created in the system.',
    `custodian_account_reference` STRING COMMENT 'Reference to the third-party custodian account where segregated initial margin is held.',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The amount in dispute between the parties regarding the margin call calculation.',
    `dispute_raised_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute was formally raised by the counterparty.',
    `dispute_reason` STRING COMMENT 'Description of the reason for disputing the margin call, such as valuation disagreement, collateral eligibility, or calculation error.',
    `dispute_resolved_timestamp` TIMESTAMP COMMENT 'Timestamp when the margin call dispute was resolved between the parties.',
    `dispute_status` STRING COMMENT 'Indicates whether the margin call is disputed by the counterparty and the current state of dispute resolution.. Valid values are `no_dispute|disputed|under_review|resolved|escalated`',
    `eligible_collateral_schedule` STRING COMMENT 'Reference to the schedule in the CSA defining which types of collateral are acceptable for this margin call.',
    `exposure_amount` DECIMAL(18,2) COMMENT 'The current mark-to-market exposure or net present value of the derivative position that drives the margin call calculation.',
    `frequency` STRING COMMENT 'Frequency at which margin calls are calculated and issued as per the CSA agreement: daily, intraday, weekly, or on-demand.. Valid values are `daily|intraday|weekly|on_demand`',
    `haircut_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied to the market value of collateral to account for potential price volatility and liquidation risk.',
    `independent_amount` DECIMAL(18,2) COMMENT 'Additional collateral amount required independent of mark-to-market exposure, often used for initial margin purposes.',
    `isda_agreement_reference` STRING COMMENT 'Reference number of the master ISDA agreement under which this margin call is executed.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum amount that must be transferred in a margin call as specified in the CSA agreement.',
    `net_margin_call_amount` DECIMAL(18,2) COMMENT 'The net amount to be transferred after accounting for existing collateral, threshold, and minimum transfer amount.',
    `reference_number` STRING COMMENT 'External business identifier for the margin call used for reconciliation and communication with counterparties.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this margin call must be reported to regulatory authorities under EMIR or Dodd-Frank requirements.',
    `response_deadline_timestamp` TIMESTAMP COMMENT 'The deadline by which the counterparty must respond to and settle the margin call.',
    `segregation_requirement_flag` BOOLEAN COMMENT 'Indicates whether regulatory initial margin segregation is required for this margin call under BCBS-IOSCO UMR.',
    `settlement_date` DATE COMMENT 'The date by which the collateral transfer must be completed.',
    `settlement_status` STRING COMMENT 'Current settlement status of the margin call indicating whether collateral has been transferred.. Valid values are `pending|partially_settled|fully_settled|failed|cancelled`',
    `source_system` STRING COMMENT 'The operational system that generated this margin call record, typically the trading or risk management platform such as Murex or Calypso.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The threshold amount defined in the CSA below which no margin call is triggered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this margin call record was last modified.',
    `valuation_date` DATE COMMENT 'The date on which the exposure and collateral values were calculated for this margin call.',
    CONSTRAINT pk_trade_margin_call PRIMARY KEY(`trade_margin_call_id`)
) COMMENT 'Margin call record for OTC derivatives (variation margin, initial margin) and securities financing transactions under bilateral and cleared arrangements. Captures call date, call type (VM/IM), call direction (issued/received), call amount, call currency, CSA/ISDA agreement reference, eligible collateral schedule, dispute status, dispute reason, dispute amount, collateral pledged, collateral type (cash, government bonds, eligible securities), settlement status, margin call response deadline, and margin call frequency (daily/intraday). Supports BCBS-IOSCO UMR (Uncleared Margin Rules) compliance, EMIR margin requirements, daily margin operations, margin dispute resolution workflows, regulatory initial margin (IM) segregation requirements, and margin call reconciliation with counterparties.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`regulatory_report` (
    `regulatory_report_id` BIGINT COMMENT 'Unique identifier for the regulatory trade report record. Primary key for the trade regulatory report entity.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to trade.amendment. Business justification: Amendments must be reported to regulators (EMIR/Dodd-Frank require reporting of trade modifications). This links the regulatory report to the amendment, allowing amendment reporting and audit trail.',
    `capture_id` BIGINT COMMENT 'Reference to the underlying trade transaction being reported to regulatory authorities.',
    `clearing_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.clearing_instruction. Business justification: Cleared trades must be reported with clearing details (CCP name, clearing member, clearing status) under EMIR/Dodd-Frank. This links the regulatory report to the clearing instruction, allowing cleared',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Trade reports fulfill specific regulatory obligations (EMIR Article 9, MiFID II RTS 22, Dodd-Frank Part 43). Banks map reports to obligations for compliance attestation and obligation tracking - core ',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Some regulatory regimes require execution-level reporting (e.g., trade reporting per fill under EMIR/Dodd-Frank). Currently only links to capture (aggregated trade). Adding execution_id allows granula',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Regulatory reports can be filed at order level for pre-execution reporting under MiFID II (order record keeping). Currently only links to capture (post-trade). Adding order_id allows pre-trade regulat',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Regulatory reports (EMIR, MiFID II, Dodd-Frank) are reviewed during exams as evidence of compliance. Examiners sample reports to validate accuracy and timeliness - direct examination scope linkage in ',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Regulatory trade reports (EMIR, Dodd-Frank, SFTR) include stress scenario identifiers for systemic risk monitoring by regulators and trade repositories. Required for ESMA/CFTC reporting.',
    `trade_lifecycle_event_id` BIGINT COMMENT 'Foreign key linking to trade.trade_lifecycle_event. Business justification: Lifecycle events (novations, terminations, compressions, early terminations) must be reported to regulators under EMIR/Dodd-Frank. This links the regulatory report to the lifecycle event, allowing lif',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Regulatory reports should reference the trading book for regulatory capital reporting (RWA by book), position reporting (large position reporting by book), and Volcker Rule compliance (proprietary tra',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the trade repository or regulatory authority acknowledged receipt and acceptance of the regulatory report.',
    `action_type` STRING COMMENT 'Type of action being reported to the regulatory authority - new trade, modification, cancellation, correction, termination, error correction, or valuation update. [ENUM-REF-CANDIDATE: new|modify|cancel|correct|terminate|error|valuation — 7 candidates stripped; promote to reference product]',
    `asset_class` STRING COMMENT 'Broad asset class category of the trade being reported - interest rate derivatives, credit derivatives, equity derivatives, foreign exchange, or commodity derivatives.. Valid values are `interest_rate|credit|equity|fx|commodity`',
    `clearing_house_lei` STRING COMMENT '20-character Legal Entity Identifier of the central counterparty (CCP) clearing house if the trade is centrally cleared.. Valid values are `^[A-Z0-9]{20}$`',
    `clearing_status` STRING COMMENT 'Indicates whether the trade is centrally cleared through a CCP, remains uncleared (bilateral OTC), or is intended to be cleared. Critical for regulatory capital and margin requirements under EMIR and Dodd-Frank.. Valid values are `cleared|uncleared|intended_to_clear`',
    `collateral_portfolio_code` STRING COMMENT 'Identifier for the collateral portfolio or margin account associated with this trade for uncleared derivatives subject to margin requirements under EMIR and Dodd-Frank.',
    `compression_flag` BOOLEAN COMMENT 'Boolean indicator of whether this trade was part of a portfolio compression exercise to reduce notional outstanding and operational risk.',
    `confirmation_status` STRING COMMENT 'Status of trade confirmation between counterparties. Regulators monitor confirmation timeliness as part of operational risk oversight.. Valid values are `confirmed|unconfirmed|disputed`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the trade was confirmed between counterparties, either electronically or manually.',
    `counterparty_lei` STRING COMMENT '20-character Legal Entity Identifier of the counterparty to the trade. Mandatory field for regulatory reporting to enable counterparty risk aggregation and systemic risk monitoring.. Valid values are `^[A-Z0-9]{20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory report record was first created in the data warehouse or reporting system.',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trade was executed, required for high-frequency trading and algorithmic trading regulatory reporting under MiFID II.',
    `intragroup_flag` BOOLEAN COMMENT 'Boolean indicator of whether this trade is between entities within the same corporate group. Intragroup trades may be exempt from certain clearing and margin requirements.',
    `maturity_date` DATE COMMENT 'Final maturity or expiration date of the derivative contract being reported. Used for tenor analysis and exposure management by regulators.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Notional principal amount of the derivative contract being reported, expressed in the contract currency. Used for risk aggregation and systemic risk monitoring by regulators.',
    `notional_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the notional amount of the derivative contract.. Valid values are `^[A-Z]{3}$`',
    `product_type` STRING COMMENT 'Specific product type or instrument classification of the trade being reported, such as swap, option, future, forward, CDS, or other derivative product.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory regime or jurisdiction under which this trade report is being submitted, such as EMIR (EU), Dodd-Frank (US), MiFID II (EU), SFTR (EU), or other regional regulatory frameworks. [ENUM-REF-CANDIDATE: EMIR|DODD_FRANK|MIFID_II|SFTR|ASIC|MAS|HKMA|JFSA — 8 candidates stripped; promote to reference product]',
    `rejection_code` STRING COMMENT 'Standardized error code assigned by the trade repository indicating the specific validation rule or data quality check that failed.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the trade repository or regulatory authority for why the report was rejected, including error codes and validation failure messages.',
    `rejection_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report was rejected by the trade repository or regulatory authority due to validation errors or data quality issues.',
    `report_reference_number` STRING COMMENT 'Unique business identifier assigned to this regulatory report submission for tracking and reconciliation purposes.',
    `report_status` STRING COMMENT 'Current lifecycle status of the regulatory report submission indicating whether it is pending submission, submitted to repository, accepted by regulator, rejected, acknowledged, or cancelled.. Valid values are `pending|submitted|accepted|rejected|acknowledged|cancelled`',
    `report_type` STRING COMMENT 'Classification of the regulatory report submission indicating whether it is a new trade report, modification, cancellation, error correction, valuation update, position report, collateral report, or lifecycle event. [ENUM-REF-CANDIDATE: new|modify|cancel|error|valuation|position|collateral|lifecycle — 8 candidates stripped; promote to reference product]',
    `report_version` STRING COMMENT 'Version number of the regulatory report for the same trade, incremented with each modification or correction submission to track the reporting history.',
    `reporting_counterparty_lei` STRING COMMENT '20-character Legal Entity Identifier of the counterparty responsible for submitting this regulatory report to the trade repository or regulatory authority.. Valid values are `^[A-Z0-9]{20}$`',
    `reporting_entity_lei` STRING COMMENT '20-character Legal Entity Identifier of the legal entity within the bank that is submitting this report on behalf of the reporting counterparty.. Valid values are `^[A-Z0-9]{20}$`',
    `reporting_obligation` STRING COMMENT 'Classification of the reporting requirement indicating whether the report is mandatory under regulation, voluntary, delegated to a third party, or requires dual-sided reporting by both counterparties.. Valid values are `mandatory|voluntary|delegated|dual_sided`',
    `reporting_side` STRING COMMENT 'Indicates which side of the trade this report represents - buy side, sell side, or both sides for dual-sided reporting requirements.. Valid values are `buy|sell|both`',
    `reporting_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report was generated and prepared for submission to the trade repository or regulatory authority.',
    `source_system` STRING COMMENT 'Name of the upstream trading or risk management system from which the trade data was extracted for regulatory reporting (e.g., Murex, Calypso, AxiomSL).',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the regulatory report was actually submitted to the trade repository (DTCC GTR, REGIS-TR, UnaVista) or regulatory authority.',
    `trade_date` DATE COMMENT 'Date on which the trade was executed and agreed between counterparties. Critical for determining reporting deadlines under T+1 or T+2 regulatory requirements.',
    `trade_repository_code` STRING COMMENT 'Unique identifier assigned by the trade repository to this specific report submission for tracking and reconciliation purposes.',
    `trade_repository_name` STRING COMMENT 'Name of the authorized trade repository to which this regulatory report was submitted, such as DTCC GTR, REGIS-TR, UnaVista, CME SDR, ICE Trade Vault, or Bloomberg SDR.. Valid values are `DTCC_GTR|REGIS_TR|UNAVISTA|CME_SDR|ICE_TRADE_VAULT|BLOOMBERG_SDR`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this regulatory report record was last modified or updated in the data warehouse or reporting system.',
    `usi` STRING COMMENT 'Unique identifier for swap transactions as required by CFTC under Dodd-Frank. Used for US regulatory reporting of OTC derivatives.',
    `uti` STRING COMMENT 'Globally unique identifier for the trade as defined by CPMI-IOSCO standards. Used for cross-border trade reconciliation and regulatory reporting under EMIR and Dodd-Frank.',
    `venue_of_execution` STRING COMMENT 'Market Identifier Code (MIC) or name of the trading venue where the trade was executed - exchange, MTF, OTF, SEF, or OTC bilateral.',
    CONSTRAINT pk_regulatory_report PRIMARY KEY(`regulatory_report_id`)
) COMMENT 'Regulatory trade reporting record submitted to trade repositories and regulators (DTCC GTR, REGIS-TR, UnaVista) under EMIR, Dodd-Frank, MiFID II, and SFTR. Captures report type, UTI/USI, reporting timestamp, submission status (accepted, rejected, pending), rejection reason, report version, reporting counterparty LEI, and regulatory jurisdiction. Supports compliance with mandatory trade reporting obligations.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_fee` (
    `trade_fee_id` BIGINT COMMENT 'Unique identifier for the trade fee record. Primary key for the trade fee entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fees are accrued/recognized in accounting periods for period-end accrual and revenue recognition. Essential for financial close and revenue reporting.',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to trade.allocation. Business justification: Fees can be allocated across multiple accounts/funds (e.g., block trade commission allocated pro-rata). This links fees to specific allocations, allowing fee allocation and billing per account/fund.',
    `broker_id` BIGINT COMMENT 'Reference to the executing broker associated with the fee. Relevant for brokerage commission and best execution analysis.',
    `capture_id` BIGINT COMMENT 'Reference to the parent trade transaction to which this fee applies. Links fee to the underlying trade execution.',
    `clearing_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.clearing_instruction. Business justification: Clearing fees (CCP fees, clearing member fees, default fund contributions) are associated with clearing instructions. This is a missing link for clearing fee tracking. Currently trade_fee only links t',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or business unit to which the fee is charged. Supports management accounting and cost allocation.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee currency validation required for accrual, invoicing, payment processing, and P&L attribution. Reference data provides currency attributes for fee calculation and cost allocation.',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Execution fees (broker commissions, exchange fees, clearing fees) are incurred at execution time, not just at capture. This allows fee tracking per fill, which is critical for transaction cost analysi',
    `fee_arrangement_id` BIGINT COMMENT 'Reference to the master fee agreement or commission schedule governing this fee. Links to contractual terms and rate cards.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Trade execution fees (commissions, exchange fees, clearing fees) must be allocated to wealth portfolios for accurate net performance calculation and fee disclosure under MiFID II. Enables portfolio-le',
    `party_id` BIGINT COMMENT 'Reference to the counterparty or broker to whom the fee is paid or from whom it is received. Links to party master for Legal Entity Identifier (LEI) and regulatory reporting.',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.settlement_instruction. Business justification: Settlement fees (custodian fees, CSD fees, CSDR penalties) are associated with settlement instructions. This is a missing link for post-trade fee tracking. Currently trade_fee only links to capture, b',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading book or portfolio to which the fee is allocated. Supports Profit and Loss (P&L) attribution and desk-level cost analysis.',
    `accrual_date` DATE COMMENT 'Date on which the fee was accrued for accounting purposes. Typically trade date or settlement date depending on accounting policy.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the fee charged in the fee currency. Gross fee before any adjustments or rebates.',
    `basis` STRING COMMENT 'Calculation methodology for the fee. Indicates whether fee is charged per trade, per share, as basis points on notional, flat rate, tiered structure, or ad valorem percentage.. Valid values are `per_trade|per_share|notional_bps|flat|tiered|ad_valorem`',
    `booking_entity` STRING COMMENT 'Legal entity that books the fee for accounting and regulatory capital purposes. Supports multi-entity consolidation and regulatory reporting.',
    `comments` STRING COMMENT 'Free-text notes or comments regarding the fee. Captures exceptions, disputes, or special handling instructions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee record was first created in the system. Supports audit trail and data lineage.',
    `due_date` DATE COMMENT 'Date by which the fee payment is due per contractual terms. Used for aging analysis and collections management.',
    `external_fee_reference` STRING COMMENT 'Fee identifier from the source system. Supports reconciliation and lineage tracking back to operational systems.',
    `fee_category` STRING COMMENT 'High-level grouping of fee types for aggregated cost reporting and analysis. Supports PRIIPs cost disclosure and MiFID II ex-ante/ex-post cost reporting.. Valid values are `execution|post_trade|custody|regulatory|advisory|other`',
    `fee_status` STRING COMMENT 'Current lifecycle state of the fee. Tracks progression from accrual through invoicing, payment, or waiver. Supports accounts payable/receivable reconciliation.. Valid values are `accrued|invoiced|paid|waived|disputed|reversed`',
    `fee_type` STRING COMMENT 'Classification of the fee charged. Distinguishes between brokerage commission, exchange fee, clearing fee, settlement fee, custody fee, and prime brokerage fee for cost analysis and regulatory reporting.. Valid values are `brokerage_commission|exchange_fee|clearing_fee|settlement_fee|custody_fee|prime_brokerage_fee`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the fee is posted. Links fee to chart of accounts for financial reporting and reconciliation.',
    `invoice_date` DATE COMMENT 'Date on which the fee was invoiced to the client or received from the counterparty. Supports accounts receivable and payable tracking.',
    `invoice_number` STRING COMMENT 'Invoice number issued by the counterparty or broker for this fee. Supports accounts payable matching and reconciliation.',
    `net_fee_amount` DECIMAL(18,2) COMMENT 'Net fee amount after rebates, discounts, or adjustments. Represents the actual cost or revenue recognized for P&L purposes.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Notional or principal amount on which the fee is calculated. Relevant for BPS-based and ad valorem fee structures. Expressed in trade currency.',
    `payment_date` DATE COMMENT 'Date on which the fee was paid or received. Actual cash settlement date for the fee transaction.',
    `payment_reference` STRING COMMENT 'Payment transaction reference or confirmation number. Links fee to cash movement in treasury or payment systems.',
    `pnl_impact_amount` DECIMAL(18,2) COMMENT 'Impact of the fee on trading desk Profit and Loss (P&L). May differ from fee_amount due to allocation rules or internal transfer pricing.',
    `quantity` DECIMAL(18,2) COMMENT 'Number of shares, contracts, or units on which the fee is calculated. Relevant for per-share and per-contract fee structures.',
    `rate` DECIMAL(18,2) COMMENT 'Rate or percentage applied to calculate the fee amount. For BPS-based fees, expressed in basis points. For percentage fees, expressed as decimal (e.g., 0.0025 for 0.25%).',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Rebate or discount applied to the gross fee. Supports volume-based rebate programs and fee negotiation tracking.',
    `reference_number` STRING COMMENT 'External business identifier for the fee record, used for reconciliation and client reporting. May be invoice number or fee confirmation reference.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this fee must be included in regulatory cost and charges disclosure. True for MiFID II ex-ante/ex-post reporting and PRIIPs Key Information Document (KID).',
    `source_system` STRING COMMENT 'Name of the upstream system from which the fee record originated. Typically trading platform (Murex, Calypso) or fee management system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax or regulatory levy amount included in or added to the fee. Supports Value Added Tax (VAT), Goods and Services Tax (GST), and Financial Transaction Tax (FTT) reporting.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate applied to the fee, expressed as a decimal. Supports tax calculation verification and audit.',
    `tca_eligible_flag` BOOLEAN COMMENT 'Indicates whether this fee is included in Transaction Cost Analysis (TCA) for best execution monitoring and broker performance evaluation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee record was last modified. Supports change tracking and audit requirements.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the person who approved the fee waiver. Supports governance and audit requirements.',
    `waiver_reason` STRING COMMENT 'Business justification for waiving the fee. Populated when fee_status is waived. Supports audit trail and exception reporting.',
    CONSTRAINT pk_trade_fee PRIMARY KEY(`trade_fee_id`)
) COMMENT 'Fee and commission record associated with trade execution and post-trade services. Captures fee type (brokerage commission, exchange fee, clearing fee, settlement fee, custody fee, prime brokerage fee, regulatory levy), fee amount, fee currency, fee basis (per trade, per share, notional BPS, flat), fee status (accrued, invoiced, paid, waived), counterparty/broker, and fee agreement reference. Supports trade cost analysis (TCA), P&L attribution, MiFID II cost and charges disclosure (ex-ante and ex-post), PRIIPs cost reporting, and best-execution cost benchmarking. SSOT for all trade-related fees and commissions.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`clearing_instruction` (
    `clearing_instruction_id` BIGINT COMMENT 'Unique identifier for the clearing instruction record. Primary key for the clearing instruction entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Clearing occurs in accounting periods for period-end clearing reconciliation and margin accounting. Essential for CCP reconciliation and financial close.',
    `capture_id` BIGINT COMMENT 'Reference to the underlying trade that is subject to clearing. Links this clearing instruction to the originating trade transaction.',
    `compression_cycle_id` BIGINT COMMENT 'Identifier of the portfolio compression cycle in which this trade participated. Portfolio compression reduces gross notional and operational risk by terminating offsetting trades.',
    `broker_id` BIGINT COMMENT 'Identifier of the executing broker who gives up the trade to the clearing member. Common in agency clearing arrangements.',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Clearing house margin requirements (initial and variation margin) are significant liquidity outflows tracked in LCR and NSFR calculations. Required for CCP margin liquidity management, regulatory liqu',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Clearing margin currency must validate for CCP margin calculation, settlement processing, and collateral management. Reference data provides currency attributes for initial and variation margin proces',
    `netting_set_id` BIGINT COMMENT 'Identifier for the portfolio or netting set to which this cleared trade belongs. Used for portfolio margining and risk offset calculations at the CCP.',
    `party_id` BIGINT COMMENT 'Identifier of the clearing member firm that holds the clearing account and acts as intermediary between the trading party and the CCP.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Clearing asset class determines CCP eligibility, margin methodology, default fund contribution, and clearing mandate compliance. Reference classification provides regulatory categories and clearing el',
    `trade_repository_id` BIGINT COMMENT 'Identifier of the registered trade repository to which this clearing instruction was reported for regulatory purposes.',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Clearing instructions should reference the trading book for operational context (which desk is clearing), limit tracking (cleared notional against book limits), and regulatory capital calculation (cle',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the CCP formally accepted the clearing instruction and confirmed clearing eligibility.',
    `booking_entity_lei` STRING COMMENT '20-character Legal Entity Identifier of the legal entity that booked the trade and is submitting it for clearing.. Valid values are `^[A-Z0-9]{20}$`',
    `ccp_name` STRING COMMENT 'Name of the central counterparty clearing house responsible for clearing this trade. Major CCPs include LCH (London Clearing House), CME (Chicago Mercantile Exchange), Eurex, ICE Clear, and JSCC (Japan Securities Clearing Corporation). [ENUM-REF-CANDIDATE: LCH|CME|Eurex|ICE Clear|JSCC|OCC|HKEX|SGX|ASX|Nasdaq Clearing — 10 candidates stripped; promote to reference product]',
    `clearing_eligibility_flag` BOOLEAN COMMENT 'Boolean indicator of whether the trade is eligible for central clearing based on product type, jurisdiction, and regulatory requirements. True indicates the trade meets mandatory clearing obligations under Dodd-Frank or EMIR.',
    `clearing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the CCP for clearing services. Typically based on notional amount, product type, and clearing member tier.',
    `clearing_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the clearing fee amount.. Valid values are `^[A-Z]{3}$`',
    `clearing_member_lei` STRING COMMENT '20-character Legal Entity Identifier of the clearing member as defined by the Global LEI Foundation. Required for regulatory reporting under EMIR and Dodd-Frank.. Valid values are `^[A-Z0-9]{20}$`',
    `clearing_reference_number` STRING COMMENT 'External reference number assigned by the clearing system or central counterparty for tracking and reconciliation purposes.',
    `clearing_status` STRING COMMENT 'Current lifecycle status of the clearing instruction. Submitted indicates instruction sent to CCP. Accepted means CCP has validated and accepted. Rejected indicates CCP declined. Novated means original trade replaced by two CCP-facing trades. Compressed indicates portfolio compression applied. Backloaded means historical trade loaded into clearing system.. Valid values are `submitted|accepted|rejected|novated|compressed|backloaded`',
    `clearing_timestamp` TIMESTAMP COMMENT 'Date and time when the trade was accepted for clearing by the CCP. Represents the moment of novation when the CCP becomes the legal counterparty to both sides of the trade.',
    `clearing_venue` STRING COMMENT 'Type of venue where the trade was executed before clearing. Exchange-traded products clear automatically. SEF-executed swaps clear under Dodd-Frank. Bilateral OTC trades may be voluntarily cleared.. Valid values are `exchange|swap_execution_facility|bilateral`',
    `client_account_type` STRING COMMENT 'Classification of the clearing account structure. House accounts hold the clearing members proprietary positions. Client accounts hold customer positions. Omnibus accounts aggregate multiple clients. Individual Segregated Accounts (ISA) provide full segregation for each client.. Valid values are `house|client|omnibus|individual_segregated`',
    `collateral_amount` DECIMAL(18,2) COMMENT 'Total value of collateral posted to the CCP for this cleared position, including both initial and variation margin.',
    `collateral_type` STRING COMMENT 'Type of collateral posted to meet margin requirements at the CCP. Cash is most common, but CCPs also accept high-quality securities with appropriate haircuts.. Valid values are `cash|government_securities|corporate_bonds|equities|letters_of_credit`',
    `comments` STRING COMMENT 'Free-text field for operational notes, special instructions, or exception handling related to this clearing instruction.',
    `compression_flag` BOOLEAN COMMENT 'Boolean indicator of whether this trade has been subject to portfolio compression. True indicates the trade was included in a compression exercise.',
    `counterparty_lei` STRING COMMENT '20-character Legal Entity Identifier of the original counterparty to the trade before novation to the CCP.. Valid values are `^[A-Z0-9]{20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this clearing instruction record was first created in the system.',
    `default_fund_contribution` DECIMAL(18,2) COMMENT 'Clearing members contribution to the CCPs default fund (also called guarantee fund). Used to mutualize losses in the event of a clearing member default that exceeds initial margin.',
    `initial_margin_amount` DECIMAL(18,2) COMMENT 'Initial margin requirement posted to the CCP to cover potential future exposure on the cleared position. Calculated using CCPs risk model (typically SPAN or VaR-based).',
    `mandatory_clearing_flag` BOOLEAN COMMENT 'Boolean indicator of whether this trade is subject to mandatory clearing obligations under Dodd-Frank or EMIR regulations. True indicates regulatory requirement to clear through a CCP.',
    `product_type` STRING COMMENT 'Classification of the financial product being cleared. Examples include interest rate swap, credit default swap, equity option, futures contract, or foreign exchange forward.',
    `regulatory_report_timestamp` TIMESTAMP COMMENT 'Date and time when the clearing instruction was reported to the trade repository or regulatory authority.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this clearing instruction has been reported to regulatory authorities as required by EMIR, Dodd-Frank, or other trade reporting regimes.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating why the CCP rejected the clearing instruction. Common reasons include insufficient margin, ineligible product, or data validation failure.',
    `rejection_reason_description` STRING COMMENT 'Detailed text explanation of why the clearing instruction was rejected by the CCP.',
    `rejection_timestamp` TIMESTAMP COMMENT 'Date and time when the CCP rejected the clearing instruction. Null if instruction was not rejected.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated this clearing instruction record. Typically the trading and order management system such as Murex or Calypso.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the clearing instruction was submitted to the CCP for processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this clearing instruction record was last modified.',
    `uti` STRING COMMENT 'Globally unique identifier for the trade as defined by CFTC and EMIR regulations. Used for cross-border trade reporting and reconciliation.',
    `variation_margin_amount` DECIMAL(18,2) COMMENT 'Daily variation margin payment reflecting mark-to-market profit or loss on the cleared position. Exchanged daily to settle current exposure.',
    CONSTRAINT pk_clearing_instruction PRIMARY KEY(`clearing_instruction_id`)
) COMMENT 'Central counterparty clearing (CCP) instruction record for cleared OTC derivatives and exchange-traded products. Captures CCP name (LCH, CME, Eurex, ICE Clear, JSCC), clearing member, client account type (house/client/omnibus/ISA), clearing status (submitted, accepted, rejected, novated, compressed, backloaded), initial margin requirement, variation margin, default fund contribution, clearing timestamp, netting set identifier, and clearing eligibility determination. Supports Dodd-Frank/EMIR mandatory clearing obligations, CCP risk management, portfolio compression workflows, clearing member default management, and trade-level clearing status tracking for regulatory reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`counterparty_agreement` (
    `counterparty_agreement_id` BIGINT COMMENT 'Unique identifier for the counterparty trading agreement record. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Agreement base currency defines threshold amounts, minimum transfer amounts, and collateral valuation for CSA/ISDA agreements. Reference data provides FX rates and currency attributes for margin calcu',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the relationship manager responsible for this counterparty agreement.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: ISDA/CSA agreements reference counterparty credit ratings for threshold calculations, collateral triggers, and credit rating downgrade provisions. Core to bilateral credit risk management.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the bank legal entity that is party to this agreement.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Agreement counterparty LEI validation required for credit risk reporting, netting set identification, and regulatory compliance. Reference registry provides legal entity details and relationship hiera',
    `party_id` BIGINT COMMENT 'Identifier of the external counterparty party to this agreement.',
    `previous_counterparty_agreement_id` BIGINT COMMENT 'Self-referencing FK on counterparty_agreement (previous_counterparty_agreement_id)',
    `agreement_reference_number` STRING COMMENT 'External business identifier for the agreement, used in legal documentation and counterparty communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the counterparty agreement.. Valid values are `Draft|Pending Approval|Active|Suspended|Terminated|Expired`',
    `agreement_type` STRING COMMENT 'Classification of the legal agreement governing trading relationship. ISDA = International Swaps and Derivatives Association Master Agreement, GMRA = Global Master Repurchase Agreement, GMSLA = Global Master Securities Lending Agreement, CSA = Credit Support Annex. [ENUM-REF-CANDIDATE: ISDA Master Agreement|GMRA|GMSLA|Prime Brokerage Agreement|CSA|Clearing Agreement|Netting Agreement|Collateral Agreement — 8 candidates stripped; promote to reference product]',
    `amendment_count` STRING COMMENT 'Total number of amendments made to the original agreement.',
    `booking_entity_lei` STRING COMMENT '20-character ISO 17442 Legal Entity Identifier of the bank legal entity that is party to this agreement.. Valid values are `^[A-Z0-9]{20}$`',
    `clearing_requirement_flag` BOOLEAN COMMENT 'Indicates whether trades under this agreement are subject to mandatory central clearing requirements.',
    `collateral_arrangement_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes collateral or margin posting requirements.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special provisions, or operational instructions related to the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was first created in the system.',
    `credit_rating_trigger_flag` BOOLEAN COMMENT 'Indicates whether the agreement contains provisions triggered by credit rating downgrades.',
    `cross_default_provision_flag` BOOLEAN COMMENT 'Indicates whether default under other agreements triggers default under this agreement.',
    `dispute_resolution_method` STRING COMMENT 'Primary method specified in the agreement for resolving disputes between parties.. Valid values are `Arbitration|Litigation|Mediation|Negotiation`',
    `document_repository_reference` STRING COMMENT 'Reference identifier or URI to the physical or electronic storage location of the signed agreement document.',
    `effective_date` DATE COMMENT 'Date from which the agreement terms become legally binding and operational.',
    `eligible_collateral_types` STRING COMMENT 'Comma-separated list of asset types acceptable as collateral under the agreement (e.g., Cash, Government Bonds, Corporate Bonds, Equities).',
    `execution_date` DATE COMMENT 'Date when the agreement was legally executed and signed by all parties.',
    `governing_law` STRING COMMENT 'Jurisdiction whose laws govern the interpretation and enforcement of the agreement. [ENUM-REF-CANDIDATE: New York|English|Japanese|German|French|Swiss|Singapore|Hong Kong — 8 candidates stripped; promote to reference product]',
    `independent_amount` DECIMAL(18,2) COMMENT 'Fixed collateral amount required to be posted regardless of mark-to-market exposure.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement terms.',
    `margin_call_frequency` STRING COMMENT 'Frequency at which margin calls may be issued under the agreement.. Valid values are `Daily|Weekly|Intraday|On Demand`',
    `master_confirmation_flag` BOOLEAN COMMENT 'Indicates whether a master confirmation agreement exists that pre-defines economic terms for specific product types.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'Minimum collateral transfer amount required for a margin call under the agreement.',
    `mtm_limit_amount` DECIMAL(18,2) COMMENT 'Maximum mark-to-market exposure permitted under the agreement. Null if no limit applies.',
    `netting_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes close-out netting provisions for offsetting obligations upon default or termination.',
    `notional_limit_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate notional amount of outstanding trades permitted under the agreement. Null if no limit applies.',
    `product_scope` STRING COMMENT 'Comma-separated list of product types covered by this agreement (e.g., Interest Rate Derivatives, FX Derivatives, Equity Derivatives, Credit Derivatives, Repos, Securities Lending).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether trades under this agreement are subject to regulatory trade reporting requirements.',
    `review_date` DATE COMMENT 'Date when the agreement is scheduled for periodic legal and credit review.',
    `settlement_time` TIMESTAMP COMMENT 'Standard settlement timeframe for collateral transfers under the agreement, expressed as trade date plus number of business days.',
    `termination_date` DATE COMMENT 'Date when the agreement ceases to be in force. Null for open-ended agreements.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Exposure threshold below which no collateral is required to be posted under the agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was last modified in the system.',
    `valuation_frequency` STRING COMMENT 'Frequency at which mark-to-market valuations are performed for collateral calculation purposes.. Valid values are `Daily|Weekly|Monthly|On Demand`',
    CONSTRAINT pk_counterparty_agreement PRIMARY KEY(`counterparty_agreement_id`)
) COMMENT 'Master record for trading counterparty legal agreements including ISDA Master Agreements, GMRA, GMSLA, and prime brokerage agreements. Captures agreement type, execution date, governing law, and netting provisions.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` (
    `trade_lifecycle_event_id` BIGINT COMMENT 'Unique identifier for the trade lifecycle event record. Primary key for the immutable event log.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Lifecycle events are booked in accounting periods for period attribution of terminations/novations and P&L recognition. Critical for financial close and reporting.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to trade.amendment. Business justification: Amendments are a type of lifecycle event (economic amendment, administrative amendment). This links the lifecycle event record to the specific amendment details, providing full audit trail and allowin',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or risk manager who approved the lifecycle event. Required for events exceeding trader authority limits.',
    `capture_id` BIGINT COMMENT 'Reference to the parent trade that this lifecycle event applies to. Links the event to the original trade capture record.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Lifecycle event product type classification required for regulatory reporting, operational processing, and event routing. Reference product type master provides regulatory categories and processing ru',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Lifecycle events (terminations, novations, compressions) generate accounting entries for event-driven accounting and P&L recognition. Critical for trade lifecycle accounting.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Lifecycle event counterparty LEI mandatory for derivatives reporting, regulatory compliance, and trade repository submissions. Reference registry provides legal entity name and jurisdiction for event ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Lifecycle event currency validation required for economic impact assessment, P&L calculation, and regulatory reporting. Reference data provides currency attributes for event processing and trade repos',
    `primary_trade_employee_id` BIGINT COMMENT 'Identifier of the trader who initiated or approved the lifecycle event. Used for audit trail and performance attribution.',
    `party_id` BIGINT COMMENT 'Identifier of the new counterparty assuming obligations in a novation event. Null for non-novation events.',
    `instrument_classification_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_classification. Business justification: Lifecycle event asset class classification required for regulatory reporting, operational routing, and trade repository submissions. Reference classification provides regulatory categories for event p',
    `trade_party_id` BIGINT COMMENT 'Identifier of the counterparty involved in the lifecycle event. For novations, this may represent the transferring or receiving party.',
    `trading_book_id` BIGINT COMMENT 'Identifier of the trading book to which this lifecycle event is attributed. Used for profit and loss attribution and risk management.',
    `previous_trade_lifecycle_event_id` BIGINT COMMENT 'Self-referencing FK on trade_lifecycle_event (previous_trade_lifecycle_event_id)',
    `booking_entity_lei` STRING COMMENT 'Legal Entity Identifier of the internal legal entity booking this lifecycle event. Used for regulatory reporting and internal risk aggregation.. Valid values are `^[A-Z0-9]{20}$`',
    `cash_settlement_amount` DECIMAL(18,2) COMMENT 'Actual cash amount exchanged between counterparties as a result of the lifecycle event. Includes termination fees, novation premiums, or compression payments.',
    `cash_settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the cash settlement amount.. Valid values are `^[A-Z]{3}$`',
    `ccp_name` STRING COMMENT 'Name of the central counterparty clearing house if the lifecycle event involves a cleared trade. Examples include LCH, CME, Eurex.',
    `clearing_status` STRING COMMENT 'Indicates whether the lifecycle event affects a cleared or uncleared trade. For novations, tracks whether the successor trade is cleared.. Valid values are `cleared|uncleared|pending|rejected`',
    `comments` STRING COMMENT 'Free-text field for operational notes, special instructions, or additional context regarding the lifecycle event.',
    `compression_cycle_code` STRING COMMENT 'Identifier of the portfolio compression cycle if this event is part of a multilateral compression exercise. Null for non-compression events.',
    `compression_service_provider` STRING COMMENT 'Name of the third-party service provider facilitating the portfolio compression. Examples include TriOptima, LCH, CME.',
    `confirmation_status` STRING COMMENT 'Status of trade confirmation between counterparties for this lifecycle event. Tracks whether both parties have agreed to the event terms.. Valid values are `pending|confirmed|disputed|cancelled`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when counterparty confirmation was received for this lifecycle event. Null if not yet confirmed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this lifecycle event record was first created in the data platform. Immutable audit field.',
    `economic_impact_amount` DECIMAL(18,2) COMMENT 'Net cash or mark-to-market impact resulting from the lifecycle event. Positive values represent gains, negative values represent losses.',
    `economic_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the economic impact amount.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the lifecycle event becomes legally and economically effective. Used for valuation and accounting cutoff purposes.',
    `event_reference_number` STRING COMMENT 'Business reference number assigned to this lifecycle event for operational tracking and audit purposes.',
    `event_status` STRING COMMENT 'Current processing status of the lifecycle event. Tracks the event through its operational workflow from initiation to settlement.. Valid values are `pending|confirmed|rejected|cancelled|settled`',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the lifecycle event occurred in the real world. This is the business event time, distinct from system recording time.',
    `event_type` STRING COMMENT 'Classification of the lifecycle event. Defines the nature of the post-trade action applied to the original trade. [ENUM-REF-CANDIDATE: novation|termination|compression|partial_termination|amendment|exercise|maturity|cancellation — 8 candidates stripped; promote to reference product]',
    `external_event_reference` STRING COMMENT 'Identifier assigned to this lifecycle event by an external system or counterparty. Used for cross-system reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this lifecycle event record was last updated. Used for change tracking and audit purposes.',
    `notional_amount` DECIMAL(18,2) COMMENT 'Notional principal amount affected by the lifecycle event. For partial terminations, represents the terminated portion. For compressions, represents the reduced notional.',
    `portfolio_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event was identified and processed as part of a portfolio reconciliation exercise between counterparties.',
    `reconciliation_discrepancy_flag` BOOLEAN COMMENT 'Indicates whether a discrepancy was identified during portfolio reconciliation that triggered this lifecycle event.',
    `regulatory_report_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event was reported to the trade repository or regulatory authority. Null if not yet reported.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this lifecycle event must be reported to trade repositories or regulatory authorities under EMIR, Dodd-Frank, or other regimes.',
    `settlement_date` DATE COMMENT 'Date on which cash or collateral movements resulting from the lifecycle event are settled between counterparties.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated this lifecycle event record. Examples include Murex, Calypso, Summit.',
    `successor_counterparty_lei` STRING COMMENT 'Legal Entity Identifier of the successor counterparty in a novation. Required for regulatory reporting of novation events.. Valid values are `^[A-Z0-9]{20}$`',
    `termination_reason` STRING COMMENT 'Business reason for trade termination or cancellation. Provides context for audit and regulatory reporting purposes.. Valid values are `mutual_agreement|early_exercise|credit_event|regulatory_requirement|portfolio_optimization|other`',
    `trade_repository_code` STRING COMMENT 'Identifier of the trade repository to which this lifecycle event was reported. Examples include DTCC, Regis-TR, KDPW.',
    `uti` STRING COMMENT 'Globally unique trade identifier assigned per regulatory requirements. Used for cross-system trade reconciliation and regulatory reporting.',
    CONSTRAINT pk_trade_lifecycle_event PRIMARY KEY(`trade_lifecycle_event_id`)
) COMMENT 'Immutable event log capturing all post-trade lifecycle events including novations, terminations, compressions, and portfolio reconciliation results. Captures event type, effective date, and economic impact.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`broker` (
    `broker_id` BIGINT COMMENT 'Unique identifier for the broker entity. Primary key for the broker master registry.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Broker BIC must validate against SWIFT directory for payment routing, securities settlement, and give-up processing. Reference data provides institution details, regulatory status, and service capabil',
    `clearing_house_id` BIGINT COMMENT 'Identifier of the central counterparty (CCP) or clearing house through which this broker clears trades.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Broker commission currency validation required for cost accrual, payment processing, and commission schedule management. Reference data provides currency attributes for broker payment instructions.',
    `commission_schedule_id` BIGINT COMMENT 'Reference to the commission rate schedule or fee structure applicable to trades executed through this broker.',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Brokers undergo KYC due diligence as counterparties before onboarding. Banks link broker entities to KYC reviews for periodic refresh, sanctions screening, and AML risk assessment - mandatory counterp',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Brokers are external counterparties requiring KYC/AML compliance, credit limit monitoring, sanctions screening, and regulatory reporting. Banks must maintain brokers as parties in customer domain for ',
    `parent_broker_id` BIGINT COMMENT 'Self-referencing FK on broker (parent_broker_id)',
    `aml_screening_status` STRING COMMENT 'Result of Anti-Money Laundering (AML) screening against sanctions lists and watchlists: cleared (no matches), flagged (potential match requiring review), pending (screening in progress), or not screened.. Valid values are `cleared|flagged|pending|not_screened`',
    `broker_code` STRING COMMENT 'Internal business identifier or mnemonic code assigned to the broker for operational reference and reporting purposes.',
    `broker_status` STRING COMMENT 'Current operational status of the broker relationship: active (approved for trading), inactive (not currently used), suspended (temporarily restricted), pending approval (under review), or terminated (relationship ended).. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `broker_type` STRING COMMENT 'Classification of the broker based on the primary service provided: executing broker (trade execution), prime broker (financing and custody), clearing broker (post-trade clearing), introducing broker (client referral), custodian broker (asset custody), or agency broker (agent capacity).. Valid values are `executing_broker|prime_broker|clearing_broker|introducing_broker|custodian_broker|agency_broker`',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational remarks related to the broker relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker record was first created in the system, used for audit trail and data lineage purposes.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure or trading limit approved for this broker, used for risk management and exposure monitoring.',
    `credit_limit_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit is denominated.. Valid values are `^[A-Z]{3}$`',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the broker by a recognized rating agency (e.g., Moodys, S&P, Fitch) for counterparty risk assessment.',
    `custodian_account_number` STRING COMMENT 'Account number at the custodian or settlement agent where securities and cash are held for trades executed through this broker.',
    `default_commission_rate` DECIMAL(18,2) COMMENT 'Standard commission rate (in basis points or percentage) charged by the broker for trade execution when no specific schedule applies.',
    `effective_date` DATE COMMENT 'Date from which the broker relationship and associated terms (commission schedule, credit limits) became effective.',
    `eligible_asset_classes` STRING COMMENT 'Comma-separated list of asset classes for which this broker is approved to execute trades (e.g., equities, fixed_income, derivatives, fx, commodities).',
    `eligible_markets` STRING COMMENT 'Comma-separated list of trading venues or market identifiers (MIC codes) where this broker is authorized to execute trades.',
    `kyc_status` STRING COMMENT 'Status of the Know Your Customer (KYC) due diligence process for the broker: complete (all documentation verified), pending (awaiting information), expired (requires refresh), or under review (currently being assessed).. Valid values are `complete|pending|expired|under_review`',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of the broker relationship, including compliance, performance, and credit assessment.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the broker relationship as per internal compliance and risk management policies.',
    `onboarding_date` DATE COMMENT 'Date on which the broker was onboarded and approved for trading activity following due diligence and compliance review.',
    `primary_regulator` STRING COMMENT 'Name of the primary regulatory authority overseeing the broker (e.g., SEC, FCA, FINRA, ESMA).',
    `registration_number` STRING COMMENT 'Official registration or license number issued by the primary regulatory authority.',
    `regulatory_status` STRING COMMENT 'Regulatory standing of the broker with relevant authorities: registered (compliant and authorized), approved (passed due diligence), restricted (limited trading permissions), sanctioned (under regulatory action), or delisted (authorization revoked).. Valid values are `registered|approved|restricted|sanctioned|delisted`',
    `relationship_type` STRING COMMENT 'Nature of the business relationship with the broker: direct (direct trading relationship), indirect (via intermediary), give-up (execution with allocation to another broker), or correspondent (settlement services).. Valid values are `direct|indirect|give_up|correspondent`',
    `settlement_agent_bic` STRING COMMENT 'SWIFT BIC of the settlement agent or custodian bank used by the broker for post-trade settlement and cash movements.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the broker used for display and operational purposes.',
    `termination_date` DATE COMMENT 'Date on which the broker relationship was terminated or is scheduled to terminate. Null if the relationship is ongoing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker record was last modified, used for audit trail and change tracking purposes.',
    CONSTRAINT pk_broker PRIMARY KEY(`broker_id`)
) COMMENT 'Master registry of executing brokers, prime brokers, and clearing brokers used for trade execution and post-trade services. Captures broker ID, BIC, relationship type, commission schedule, and regulatory status.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`best_execution` (
    `best_execution_id` BIGINT COMMENT 'Unique identifier for the best execution analysis record. Primary key for this entity.',
    `branch_id` BIGINT COMMENT 'Reference to the trading desk responsible for the execution.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.capture. Business justification: Best execution analysis should link to the booked trade (capture) in addition to execution and order. This provides full trade lifecycle context for best execution reporting and allows analysis of exe',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Best execution analysis fulfills MiFID II Article 27 and Reg NMS Rule 605/606 obligations. Banks link execution quality reports to specific obligations for compliance evidence and regulatory attestati',
    `execution_id` BIGINT COMMENT 'Reference to the underlying trade execution that this best execution analysis evaluates.',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument that was executed.',
    `order_id` BIGINT COMMENT 'Reference to the parent order for which best execution is being assessed.',
    `employee_id` BIGINT COMMENT 'Reference to the trader responsible for executing the order and ensuring best execution.',
    `instrument_identifier_id` BIGINT COMMENT 'Foreign key linking to reference.instrument_identifier. Business justification: Best execution analysis depends on instrument classification and liquidity characteristics from reference data. Reference master provides asset class, venue eligibility, and regulatory categorization ',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the compliance officer who reviewed this best execution analysis.',
    `previous_best_execution_id` BIGINT COMMENT 'Self-referencing FK on best_execution (previous_best_execution_id)',
    `alternative_venue_count` STRING COMMENT 'Number of alternative execution venues that were evaluated during the best execution analysis.',
    `analysis_reference_number` STRING COMMENT 'External reference number for the best execution analysis record, used for regulatory reporting and audit trails.',
    `analysis_status` STRING COMMENT 'Current status of the best execution analysis workflow, tracking progression from initial assessment through regulatory approval.. Valid values are `pending|in_progress|completed|failed|under_review|approved`',
    `analysis_timestamp` TIMESTAMP COMMENT 'Date and time when the best execution analysis was performed, representing the principal business event for this record.',
    `asset_class` STRING COMMENT 'Asset class of the instrument being executed, used to apply asset-class-specific best execution criteria.. Valid values are `equity|fixed_income|fx|commodity|derivative`',
    `benchmark_price` DECIMAL(18,2) COMMENT 'Reference price used as the benchmark for best execution comparison, typically the mid-market price at time of execution or arrival price.',
    `benchmark_type` STRING COMMENT 'Type of benchmark price used for best execution comparison, defining the reference point for execution quality assessment.. Valid values are `arrival_price|mid_market|vwap|twap|closing_price|opening_price`',
    `client_instruction_details` STRING COMMENT 'Details of any specific client instructions that influenced venue selection or execution approach.',
    `client_order_type` STRING COMMENT 'Classification of the client placing the order under MiFID II, determining the level of best execution obligation.. Valid values are `retail|professional|eligible_counterparty`',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the execution met the firms best execution policy requirements. True indicates compliance, False indicates potential breach.',
    `counterparty_lei` STRING COMMENT 'ISO 17442 Legal Entity Identifier of the counterparty or client for whom best execution was provided.. Valid values are `^[A-Z0-9]{20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this best execution record was first created in the system, supporting audit trail requirements.',
    `exception_reason` STRING COMMENT 'Explanation for any deviation from best execution policy or failure to achieve expected execution quality, required for compliance review.',
    `executed_quantity` DECIMAL(18,2) COMMENT 'Quantity of the instrument that was executed in this transaction.',
    `execution_cost` DECIMAL(18,2) COMMENT 'Total cost of execution including explicit costs (commissions, fees, taxes) and implicit costs (market impact, spread, opportunity cost).',
    `execution_quality_score` DECIMAL(18,2) COMMENT 'Composite score (0-100) assessing overall execution quality based on price improvement, speed, likelihood of execution, and cost factors.',
    `explicit_cost` DECIMAL(18,2) COMMENT 'Direct, observable costs of execution including commissions, exchange fees, clearing fees, and transaction taxes.',
    `factors` STRING COMMENT 'Comma-separated list of factors considered in the best execution determination (price, cost, speed, likelihood of execution, settlement, size, nature, or other relevant considerations).',
    `implicit_cost` DECIMAL(18,2) COMMENT 'Indirect costs of execution including market impact, bid-ask spread, and opportunity cost from delayed or partial fills.',
    `market_impact_cost` DECIMAL(18,2) COMMENT 'Cost attributable to the price movement caused by the execution of the order itself, measuring the orders effect on market prices.',
    `opportunity_cost` DECIMAL(18,2) COMMENT 'Cost of delayed or incomplete execution, measured as the price movement between order submission and final execution.',
    `price_improvement` DECIMAL(18,2) COMMENT 'Difference between execution price and benchmark price, expressed in the trade currency. Positive values indicate favorable execution.',
    `price_improvement_bps` DECIMAL(18,2) COMMENT 'Price improvement expressed in basis points relative to the benchmark price, providing a normalized measure of execution quality.',
    `regulatory_regime` STRING COMMENT 'Primary regulatory framework governing the best execution obligation for this trade (MiFID II for EU, Reg NMS for US).. Valid values are `mifid_ii|reg_nms|other`',
    `reporting_timestamp` TIMESTAMP COMMENT 'Date and time when the best execution analysis was reported to the relevant regulatory authority or made available for client reporting.',
    `review_status` STRING COMMENT 'Status of the compliance review process for this best execution record.. Valid values are `not_reviewed|under_review|approved|escalated|remediated`',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance review was completed.',
    `specific_client_instruction_flag` BOOLEAN COMMENT 'Indicates whether the client provided specific instructions that may have prevented the firm from following its best execution policy.',
    `spread_cost` DECIMAL(18,2) COMMENT 'Cost attributable to crossing the bid-ask spread at the time of execution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this best execution record was last modified, supporting audit trail and data lineage requirements.',
    `venue_mic_code` STRING COMMENT 'ISO 10383 Market Identifier Code for the execution venue, providing standardized venue identification for regulatory reporting.. Valid values are `^[A-Z]{4}$`',
    `venue_rank` STRING COMMENT 'Ranking of the selected execution venue among all eligible venues for this order, based on pre-trade analysis (1 = best venue).',
    CONSTRAINT pk_best_execution PRIMARY KEY(`best_execution_id`)
) COMMENT 'Best execution analysis record documenting compliance with MiFID II/Reg NMS best execution obligations. Captures execution venue, price achieved, benchmark price, and execution quality metrics.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`commission_schedule` (
    `commission_schedule_id` BIGINT COMMENT 'Primary key for commission_schedule',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this commission schedule for operational use.',
    `superseded_by_schedule_id` BIGINT COMMENT 'Reference to the commission schedule that replaces this one, maintaining version lineage.',
    `previous_commission_schedule_id` BIGINT COMMENT 'Self-referencing FK on commission_schedule (previous_commission_schedule_id)',
    `approval_status` STRING COMMENT 'Approval workflow status indicating whether the schedule has been reviewed and authorized for use.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the commission schedule was approved, supporting audit and compliance requirements.',
    `asset_class` STRING COMMENT 'The asset class to which this commission schedule applies, defining the scope of applicability.',
    `base_commission_rate` DECIMAL(18,2) COMMENT 'The base commission rate applied before any adjustments, expressed as a decimal or basis points depending on schedule type.',
    `calculation_basis` STRING COMMENT 'The basis on which commission is calculated, defining the denominator for rate application.',
    `client_tier` STRING COMMENT 'Client classification tier to which this commission schedule applies, enabling tiered pricing strategies.',
    `counterparty_type` STRING COMMENT 'Type of counterparty for which this commission schedule is designed, enabling role-based pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this commission schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code in which commission amounts are denominated.',
    `commission_schedule_description` STRING COMMENT 'Detailed textual description of the commission schedule purpose, applicability, and special conditions.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base commission rate for promotional or relationship-based pricing.',
    `effective_from_date` DATE COMMENT 'Date when this commission schedule becomes active and applicable to trades.',
    `effective_to_date` DATE COMMENT 'Date when this commission schedule ceases to be active. Null indicates open-ended validity.',
    `execution_venue_code` STRING COMMENT 'Four-character Market Identifier Code (MIC) of the execution venue to which this schedule applies.',
    `frequency_threshold_count` STRING COMMENT 'Number of trades within a period that triggers volume-based commission adjustments.',
    `instrument_type` STRING COMMENT 'Specific instrument type or category within the asset class that this schedule covers.',
    `market_segment` STRING COMMENT 'Market segment or venue classification for which this commission schedule is applicable.',
    `maximum_commission_amount` DECIMAL(18,2) COMMENT 'Maximum commission amount charged per trade regardless of calculated commission, providing cap protection.',
    `minimum_commission_amount` DECIMAL(18,2) COMMENT 'Minimum commission amount charged per trade regardless of calculated commission, ensuring floor pricing.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this commission schedule record was last modified, supporting change tracking.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the commission schedule, capturing operational context and exceptions.',
    `rebate_eligible_flag` BOOLEAN COMMENT 'Indicates whether trades under this schedule are eligible for commission rebates or volume incentives.',
    `regulatory_fee_included_flag` BOOLEAN COMMENT 'Indicates whether regulatory fees and levies are included in the commission or charged separately.',
    `schedule_code` STRING COMMENT 'Business identifier code for the commission schedule, used for external reference and reporting.',
    `schedule_name` STRING COMMENT 'Human-readable name of the commission schedule describing its purpose or target segment.',
    `schedule_type` STRING COMMENT 'Classification of the commission calculation methodology used in this schedule.',
    `settlement_cycle_days` STRING COMMENT 'Number of business days in the settlement cycle for trades under this schedule, affecting commission timing.',
    `commission_schedule_status` STRING COMMENT 'Current lifecycle status of the commission schedule indicating its operational state.',
    `tier_structure_json` STRING COMMENT 'JSON representation of tiered commission structure defining breakpoints and rates for tiered schedules.',
    `trade_direction` STRING COMMENT 'Trade direction to which this commission schedule applies, allowing asymmetric buy/sell pricing.',
    `version_number` STRING COMMENT 'Version number of the commission schedule, enabling change tracking and historical analysis.',
    `volume_threshold_amount` DECIMAL(18,2) COMMENT 'Trading volume threshold amount that triggers preferential commission rates or tier changes.',
    CONSTRAINT pk_commission_schedule PRIMARY KEY(`commission_schedule_id`)
) COMMENT 'Master reference table for commission_schedule. Referenced by commission_schedule_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`clearing_house` (
    `clearing_house_id` BIGINT COMMENT 'Primary key for clearing_house',
    `parent_clearing_house_id` BIGINT COMMENT 'Self-referencing FK on clearing_house (parent_clearing_house_id)',
    `address_line_1` STRING COMMENT 'Primary street address line for the clearing house headquarters.',
    `address_line_2` STRING COMMENT 'Secondary street address line for the clearing house headquarters (suite, floor, building).',
    `bic_code` STRING COMMENT 'ISO 9362 Business Identifier Code used for SWIFT messaging and settlement instructions with the clearing house.',
    `clearing_house_code` STRING COMMENT 'Unique external code or identifier assigned to the clearing house by regulatory or industry bodies.',
    `clearing_house_type` STRING COMMENT 'Classification of the clearing house based on the asset classes and services it provides.',
    `clearing_model` STRING COMMENT 'The clearing and settlement model employed by the clearing house.',
    `connectivity_protocol` STRING COMMENT 'Primary technical connectivity protocol used for trade submission and clearing (e.g., FIX, SWIFT, proprietary API).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearing house record was first created in the system.',
    `default_fund_required` BOOLEAN COMMENT 'Indicates whether clearing members are required to contribute to a default fund or guarantee fund.',
    `effective_date` DATE COMMENT 'Date when the clearing house became operational or was added to the reference data system.',
    `email_address` STRING COMMENT 'Primary contact email address for the clearing house.',
    `headquarters_city` STRING COMMENT 'City where the clearing house headquarters is located.',
    `headquarters_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the clearing house headquarters is located.',
    `jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the legal jurisdiction where the clearing house is domiciled.',
    `last_review_date` DATE COMMENT 'Date when the clearing house reference data was last reviewed and validated.',
    `lei_code` STRING COMMENT 'ISO 17442 Legal Entity Identifier for the clearing house, a 20-character alphanumeric code used for regulatory reporting.',
    `margin_model` STRING COMMENT 'The margin calculation methodology used by the clearing house for risk management.',
    `membership_required` BOOLEAN COMMENT 'Indicates whether direct membership is required to clear trades through this clearing house.',
    `mic_code` STRING COMMENT 'ISO 10383 four-character Market Identifier Code uniquely identifying the clearing house in global markets.',
    `minimum_capital_requirement` DECIMAL(18,2) COMMENT 'Minimum capital requirement for clearing members in the settlement currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearing house record was last modified in the system.',
    `clearing_house_name` STRING COMMENT 'Full legal name of the clearing house organization.',
    `netting_eligible` BOOLEAN COMMENT 'Indicates whether the clearing house supports multilateral netting of trades.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and validation of clearing house reference data.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the clearing house.',
    `operating_hours` STRING COMMENT 'Standard operating hours of the clearing house, including time zone.',
    `parent_organization` STRING COMMENT 'Name of the parent company or holding entity that owns or operates the clearing house.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the clearing house.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the clearing house headquarters address.',
    `primary_regulator` STRING COMMENT 'Name of the primary regulatory body overseeing the clearing house operations.',
    `regulatory_status` STRING COMMENT 'Regulatory authorization status of the clearing house with relevant financial authorities.',
    `settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the primary settlement currency used by the clearing house.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for trades cleared through this clearing house (e.g., T+0, T+1, T+2).',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name of the clearing house for operational reference.',
    `clearing_house_status` STRING COMMENT 'Current operational status of the clearing house in the trading and settlement ecosystem.',
    `supported_asset_classes` STRING COMMENT 'Comma-separated list of asset classes supported by the clearing house (e.g., equities, fixed income, derivatives, commodities, FX).',
    `termination_date` DATE COMMENT 'Date when the clearing house ceased operations or was decommissioned. Null if still active.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the clearing house operational time zone.',
    `trade_reporting_required` BOOLEAN COMMENT 'Indicates whether trades cleared through this clearing house must be reported to trade repositories.',
    `website_url` STRING COMMENT 'Official website URL of the clearing house.',
    CONSTRAINT pk_clearing_house PRIMARY KEY(`clearing_house_id`)
) COMMENT 'Master reference table for clearing_house. Referenced by clearing_house_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`compression_cycle` (
    `compression_cycle_id` BIGINT COMMENT 'Primary key for compression_cycle',
    `previous_compression_cycle_id` BIGINT COMMENT 'Self-referencing FK on compression_cycle (previous_compression_cycle_id)',
    `approval_deadline_timestamp` TIMESTAMP COMMENT 'Date and time by which participants must approve or reject compression results. Applicable only when approval is required.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether participant approval is required before finalizing compression results. If true, participants must explicitly accept results before settlement.',
    `asset_class` STRING COMMENT 'The asset class category for which this compression cycle is executed. Determines the type of derivatives being compressed.',
    `base_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the base currency for notional amounts and cash flows in this compression cycle.',
    `booking_entity` STRING COMMENT 'Legal entity under which the compressed and replacement trades are booked. Important for regulatory capital and legal entity reporting.',
    `business_unit` STRING COMMENT 'Internal business unit or trading desk responsible for managing this compression cycle, such as rates trading, credit trading, or central risk management.',
    `cash_settlement_amount` DECIMAL(18,2) COMMENT 'Total net cash amount to be settled as a result of the compression, expressed in the base currency. Represents economic adjustments required to maintain portfolio equivalence.',
    `clearing_house` STRING COMMENT 'Name of the central counterparty clearing house facilitating the compression cycle, such as LCH, CME, ICE Clear, or Eurex Clearing.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the compression cycle.',
    `compressed_notional_amount` DECIMAL(18,2) COMMENT 'Total gross notional amount eliminated through compression, expressed in the base currency. Represents the reduction in notional exposure.',
    `compression_algorithm_version` STRING COMMENT 'Version identifier of the compression algorithm or methodology used for this cycle. Important for audit trail and reproducibility.',
    `compression_methodology` STRING COMMENT 'Detailed description of the compression methodology applied, including algorithm type, optimization constraints, and calculation approach.',
    `compression_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of notional amount successfully compressed relative to the total submitted notional. Key performance indicator for compression efficiency.',
    `compression_service_provider` STRING COMMENT 'Third-party service provider or platform facilitating the compression cycle, such as TriOptima, Quantile, or internal bank compression desk.',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created this compression cycle record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compression cycle record was first created in the system.',
    `cycle_code` STRING COMMENT 'Business identifier code for the compression cycle, used for external reference and reporting.',
    `cycle_name` STRING COMMENT 'Human-readable name or label for the compression cycle, typically describing the scope or purpose of the cycle.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the compression cycle. Draft indicates initial setup, scheduled means planned for future execution, open allows participant submissions, in_progress indicates active processing, completed means successfully finished, cancelled indicates termination before completion, and failed indicates unsuccessful execution.',
    `cycle_type` STRING COMMENT 'Classification of the compression cycle based on the methodology and scope. Bilateral involves two counterparties, multilateral involves multiple counterparties, portfolio compression reduces notional across a portfolio, tear-up eliminates offsetting positions, novation replaces existing trades, and termination closes out positions.',
    `execution_end_timestamp` TIMESTAMP COMMENT 'Date and time when the compression algorithm completes processing and final results are available.',
    `execution_start_timestamp` TIMESTAMP COMMENT 'Date and time when the compression algorithm begins processing submitted trades and calculating optimal compression results.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary regulatory jurisdiction governing this compression cycle.',
    `last_modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this compression cycle record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compression cycle record was last updated or modified.',
    `legal_documentation_reference` STRING COMMENT 'Reference to the legal documentation governing this compression cycle, such as ISDA protocol adherence letters, bilateral agreements, or clearing house rulebooks.',
    `optimization_objective` STRING COMMENT 'Primary goal of the compression algorithm. Maximize notional reduction prioritizes largest gross notional elimination, minimize cash payments reduces settlement amounts, minimize replacement trades reduces new trade count, and balanced optimizes across multiple objectives.',
    `participant_count` STRING COMMENT 'Total number of distinct counterparties or legal entities participating in this compression cycle.',
    `product_type` STRING COMMENT 'Specific product type within the asset class being compressed, such as interest rate swaps, credit default swaps, equity options, FX forwards, or commodity futures.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this compression cycle requires regulatory reporting to authorities such as trade repositories under EMIR, Dodd-Frank, or MiFID II.',
    `remaining_notional_amount` DECIMAL(18,2) COMMENT 'Total gross notional amount remaining after compression, expressed in the base currency. Calculated as submitted notional minus compressed notional.',
    `risk_tolerance_level` STRING COMMENT 'Risk appetite setting for the compression cycle. Conservative maintains strict economic equivalence, moderate allows minor deviations within tolerance, and aggressive maximizes compression with higher tolerance for economic changes.',
    `settlement_date` DATE COMMENT 'The business date on which the compressed trades are settled and the original trades are terminated or novated.',
    `submission_end_timestamp` TIMESTAMP COMMENT 'Date and time when the compression cycle closes for participant submissions. No further trade nominations are accepted after this time.',
    `submission_start_timestamp` TIMESTAMP COMMENT 'Date and time when the compression cycle opens for participant submissions and trade nominations.',
    `submitted_notional_amount` DECIMAL(18,2) COMMENT 'Total gross notional amount of all trades submitted for compression, expressed in the base currency.',
    `tolerance_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum acceptable cash payment or economic deviation that participants are willing to accept to achieve compression, expressed in the base currency.',
    `total_compressed_trades` STRING COMMENT 'Total number of trades successfully compressed or eliminated as a result of this compression cycle.',
    `total_replacement_trades` STRING COMMENT 'Total number of new replacement trades created as a result of the compression to maintain economic equivalence.',
    `total_submitted_trades` STRING COMMENT 'Total number of trades submitted by all participants for inclusion in this compression cycle.',
    CONSTRAINT pk_compression_cycle PRIMARY KEY(`compression_cycle_id`)
) COMMENT 'Master reference table for compression_cycle. Referenced by compression_cycle_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_repository` (
    `trade_repository_id` BIGINT COMMENT 'Primary key for trade_repository',
    `parent_trade_repository_id` BIGINT COMMENT 'Self-referencing FK on trade_repository (parent_trade_repository_id)',
    `active_participant_count` STRING COMMENT 'Number of active reporting entities or participants currently submitting trade reports to this repository.',
    `asset_classes_supported` STRING COMMENT 'Comma-separated list of asset classes that the trade repository is authorized to accept for reporting (e.g., interest rate derivatives, credit derivatives, equity derivatives, FX, commodities).',
    `average_processing_time_seconds` DECIMAL(18,2) COMMENT 'Average time in seconds taken by the repository to process and acknowledge a trade report submission.',
    `billing_currency` STRING COMMENT 'Three-letter ISO currency code representing the currency in which the trade repository invoices its clients.',
    `business_continuity_plan_tested_date` DATE COMMENT 'Date on which the trade repositorys business continuity and disaster recovery plan was last tested.',
    `certification_iso_27001` BOOLEAN COMMENT 'Indicates whether the trade repository holds ISO 27001 certification for information security management.',
    `certification_soc2` BOOLEAN COMMENT 'Indicates whether the trade repository has achieved SOC 2 Type II certification for security, availability, and confidentiality controls.',
    `connectivity_protocol` STRING COMMENT 'Technical protocol or messaging standard used for submitting trade reports to this repository (e.g., ISO 20022, FIX, FpML, proprietary API).',
    `contact_email` STRING COMMENT 'Primary email address for operational and regulatory inquiries related to the trade repository.',
    `contact_phone` STRING COMMENT 'Primary phone number for operational support and regulatory communication with the trade repository.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade repository record was first created in the system.',
    `data_retention_period_days` STRING COMMENT 'Number of days that trade data must be retained by the repository as mandated by regulatory requirements.',
    `fees_per_transaction` DECIMAL(18,2) COMMENT 'Fee charged by the trade repository per trade report submission, typically in the repositorys billing currency.',
    `headquarters_address` STRING COMMENT 'Physical address of the trade repositorys headquarters or principal place of business.',
    `headquarters_city` STRING COMMENT 'City where the trade repositorys headquarters is located.',
    `headquarters_country` STRING COMMENT 'Three-letter ISO country code of the country where the trade repositorys headquarters is located.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the primary legal jurisdiction under which the trade repository operates.',
    `last_audit_date` DATE COMMENT 'Date of the most recent regulatory or independent audit conducted on the trade repositorys operations and controls.',
    `legal_entity_identifier` STRING COMMENT 'ISO 17442 compliant 20-character Legal Entity Identifier uniquely identifying the trade repository as a legal entity.',
    `maximum_daily_submission_volume` BIGINT COMMENT 'Maximum number of trade reports that the repository can process in a single business day based on capacity planning.',
    `next_audit_scheduled_date` DATE COMMENT 'Scheduled date for the next regulatory or independent audit of the trade repository.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the trade repository.',
    `operational_status` STRING COMMENT 'Current operational state of the trade repository indicating whether it is actively accepting trade reports.',
    `public_access_available` BOOLEAN COMMENT 'Indicates whether the trade repository provides public access to aggregated or anonymized trade data for transparency purposes.',
    `reconciliation_tolerance_threshold` DECIMAL(18,2) COMMENT 'Percentage threshold used by the repository for matching and reconciling trade reports submitted by counterparties.',
    `registration_date` DATE COMMENT 'Date on which the trade repository was officially registered with the regulatory authority.',
    `registration_expiry_date` DATE COMMENT 'Date on which the current registration of the trade repository expires and requires renewal. Nullable for indefinite registrations.',
    `registration_status` STRING COMMENT 'Current regulatory registration status of the trade repository with the relevant supervisory authority.',
    `regulatory_authority` STRING COMMENT 'Name of the primary regulatory authority or supervisory body that oversees and regulates this trade repository.',
    `regulatory_reporting_frequency` STRING COMMENT 'Frequency at which the trade repository must submit aggregated reports to regulatory authorities.',
    `reporting_obligation_scope` STRING COMMENT 'Scope of transactions that must be reported to this trade repository under applicable regulatory frameworks.',
    `repository_code` STRING COMMENT 'Unique alphanumeric code assigned to the trade repository by regulatory authorities for identification purposes.',
    `repository_name` STRING COMMENT 'Official legal name of the trade repository entity.',
    `repository_type` STRING COMMENT 'Classification of the trade repository based on the asset classes it supports for trade reporting.',
    `service_level_agreement_uptime_pct` DECIMAL(18,2) COMMENT 'Contractual uptime percentage guaranteed by the trade repository for its reporting services.',
    `submission_endpoint_url` STRING COMMENT 'Primary URL endpoint for submitting trade reports to the repository via electronic messaging.',
    `total_trades_reported_ytd` BIGINT COMMENT 'Cumulative number of trade reports submitted to the repository from the beginning of the current calendar year.',
    `unique_transaction_identifier_format` STRING COMMENT 'Standard format used by the repository for Unique Transaction Identifiers to ensure global uniqueness of trade records.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade repository record was last modified or updated.',
    `website_url` STRING COMMENT 'Official website URL of the trade repository providing information on services, documentation, and regulatory compliance.',
    CONSTRAINT pk_trade_repository PRIMARY KEY(`trade_repository_id`)
) COMMENT 'Master reference table for trade_repository. Referenced by trade_repository_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`isda_master_agreement` (
    `isda_master_agreement_id` BIGINT COMMENT 'Primary key for isda_master_agreement',
    `party_id` BIGINT COMMENT 'Reference to the legal entity that is the counterparty to this ISDA Master Agreement.',
    `additional_termination_events` STRING COMMENT 'Description of any additional termination events beyond standard ISDA events that have been negotiated and included in the Schedule.',
    `agreement_number` STRING COMMENT 'The externally-known unique business identifier for this ISDA Master Agreement, used in legal documentation and trade confirmations.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the ISDA Master Agreement indicating its operational state.',
    `agreement_type` STRING COMMENT 'The type or version of ISDA Master Agreement (e.g., 1992 ISDA, 2002 ISDA, customized bilateral, cleared derivatives).',
    `amendment_count` STRING COMMENT 'The total number of amendments that have been executed to this ISDA Master Agreement since its original execution.',
    `automatic_early_termination_flag` BOOLEAN COMMENT 'Indicates whether automatic early termination provisions apply upon the occurrence of specified events of default or termination events.',
    `base_currency` STRING COMMENT 'The primary currency used for calculations, payments, and close-out netting under this agreement. Three-letter ISO 4217 currency code.',
    `calculation_agent` STRING COMMENT 'The party or entity responsible for performing calculations under derivative transactions governed by this agreement.',
    `clearing_obligation_flag` BOOLEAN COMMENT 'Indicates whether transactions under this agreement are subject to mandatory central clearing requirements under applicable regulations.',
    `collateral_eligible_flag` BOOLEAN COMMENT 'Indicates whether this ISDA Master Agreement includes provisions for collateral posting (typically via a Credit Support Annex).',
    `comments` STRING COMMENT 'Free-text field for additional notes, special provisions, or operational comments related to this ISDA Master Agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ISDA Master Agreement record was first created in the system.',
    `credit_event_upon_merger_flag` BOOLEAN COMMENT 'Indicates whether a merger or consolidation of either party that results in credit deterioration constitutes a termination event.',
    `credit_support_annex_type` STRING COMMENT 'The type or jurisdiction of the Credit Support Annex attached to this ISDA Master Agreement, if applicable.',
    `cross_default_applicable_flag` BOOLEAN COMMENT 'Indicates whether cross-default provisions are included, allowing termination if either party defaults on other obligations.',
    `cross_default_threshold` DECIMAL(18,2) COMMENT 'The minimum amount of defaulted obligations that triggers a cross-default event under this agreement.',
    `dispute_resolution_method` STRING COMMENT 'The agreed method for resolving disputes arising under this ISDA Master Agreement (e.g., arbitration, litigation, mediation).',
    `document_custodian` STRING COMMENT 'The party or entity responsible for maintaining the original executed copy of the ISDA Master Agreement and related documentation.',
    `effective_date` DATE COMMENT 'The date from which the ISDA Master Agreement becomes legally binding and operative.',
    `execution_date` DATE COMMENT 'The date on which the ISDA Master Agreement was signed and executed by both parties.',
    `governing_law` STRING COMMENT 'The legal jurisdiction whose laws govern the interpretation and enforcement of this ISDA Master Agreement (e.g., English law, New York law, Japanese law).',
    `independent_amount` DECIMAL(18,2) COMMENT 'A fixed amount of collateral that must be posted regardless of mark-to-market exposure, as specified in the Credit Support Annex (CSA).',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment to this ISDA Master Agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ISDA Master Agreement record was last updated in the system.',
    `legal_entity_identifier_party_a` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier for Party A to this ISDA Master Agreement.',
    `legal_entity_identifier_party_b` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier for Party B (the counterparty) to this ISDA Master Agreement.',
    `minimum_transfer_amount` DECIMAL(18,2) COMMENT 'The minimum amount of collateral that must be transferred in any single collateral movement under the Credit Support Annex (CSA).',
    `multibranch_party_flag` BOOLEAN COMMENT 'Indicates whether either party is designated as a Multibranch Party, allowing multiple offices to enter into transactions under this agreement.',
    `netting_eligible_flag` BOOLEAN COMMENT 'Indicates whether close-out netting is permitted under this agreement, allowing offsetting of obligations upon termination.',
    `notification_time` STRING COMMENT 'The deadline time by which collateral call notifications must be sent under the Credit Support Annex.',
    `payment_netting_flag` BOOLEAN COMMENT 'Indicates whether payment netting is enabled, allowing offsetting of payment obligations due on the same date in the same currency.',
    `regulatory_regime` STRING COMMENT 'The primary regulatory framework applicable to derivatives traded under this agreement (e.g., Dodd-Frank, EMIR, MiFID II).',
    `setoff_applicable_flag` BOOLEAN COMMENT 'Indicates whether setoff rights are included, allowing parties to offset amounts owed under this agreement against other obligations.',
    `specified_entities` STRING COMMENT 'List or description of specified entities (subsidiaries, affiliates) whose credit events may trigger provisions under this agreement.',
    `termination_date` DATE COMMENT 'The date on which the ISDA Master Agreement terminates or was terminated. Nullable for open-ended agreements.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'The minimum exposure amount below which collateral is not required to be posted under the Credit Support Annex (CSA).',
    `trade_reporting_party` STRING COMMENT 'The party responsible for reporting derivative transactions to trade repositories under regulatory requirements.',
    `valuation_agent` STRING COMMENT 'The party or entity responsible for determining mark-to-market valuations of derivative positions under this agreement.',
    `valuation_time` STRING COMMENT 'The specified time of day (and timezone) at which valuations are performed for collateral and close-out calculations.',
    `waiting_period_days` STRING COMMENT 'The number of days that must elapse after a potential event of default before it becomes an actual event of default.',
    CONSTRAINT pk_isda_master_agreement PRIMARY KEY(`isda_master_agreement_id`)
) COMMENT 'Master reference table for isda_master_agreement. Referenced by isda_master_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_parent_order_id` FOREIGN KEY (`parent_order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ADD CONSTRAINT `fk_trade_pnl_attribution_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `banking_ecm`.`trade`.`allocation`(`allocation_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `banking_ecm`.`trade`.`amendment`(`amendment_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_parent_book_trading_book_id` FOREIGN KEY (`parent_book_trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`amendment` ADD CONSTRAINT `fk_trade_amendment_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_capture_id` FOREIGN KEY (`allocation_capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_executing_broker_id` FOREIGN KEY (`allocation_executing_broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_give_up_broker_id` FOREIGN KEY (`allocation_give_up_broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ADD CONSTRAINT `fk_trade_trade_margin_call_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `banking_ecm`.`trade`.`amendment`(`amendment_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_clearing_instruction_id` FOREIGN KEY (`clearing_instruction_id`) REFERENCES `banking_ecm`.`trade`.`clearing_instruction`(`clearing_instruction_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_trade_lifecycle_event_id` FOREIGN KEY (`trade_lifecycle_event_id`) REFERENCES `banking_ecm`.`trade`.`trade_lifecycle_event`(`trade_lifecycle_event_id`);
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ADD CONSTRAINT `fk_trade_regulatory_report_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `banking_ecm`.`trade`.`allocation`(`allocation_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_clearing_instruction_id` FOREIGN KEY (`clearing_instruction_id`) REFERENCES `banking_ecm`.`trade`.`clearing_instruction`(`clearing_instruction_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_compression_cycle_id` FOREIGN KEY (`compression_cycle_id`) REFERENCES `banking_ecm`.`trade`.`compression_cycle`(`compression_cycle_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_trade_repository_id` FOREIGN KEY (`trade_repository_id`) REFERENCES `banking_ecm`.`trade`.`trade_repository`(`trade_repository_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ADD CONSTRAINT `fk_trade_clearing_instruction_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_previous_counterparty_agreement_id` FOREIGN KEY (`previous_counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `banking_ecm`.`trade`.`amendment`(`amendment_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ADD CONSTRAINT `fk_trade_trade_lifecycle_event_previous_trade_lifecycle_event_id` FOREIGN KEY (`previous_trade_lifecycle_event_id`) REFERENCES `banking_ecm`.`trade`.`trade_lifecycle_event`(`trade_lifecycle_event_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_clearing_house_id` FOREIGN KEY (`clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_commission_schedule_id` FOREIGN KEY (`commission_schedule_id`) REFERENCES `banking_ecm`.`trade`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ADD CONSTRAINT `fk_trade_best_execution_previous_best_execution_id` FOREIGN KEY (`previous_best_execution_id`) REFERENCES `banking_ecm`.`trade`.`best_execution`(`best_execution_id`);
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` ADD CONSTRAINT `fk_trade_commission_schedule_superseded_by_schedule_id` FOREIGN KEY (`superseded_by_schedule_id`) REFERENCES `banking_ecm`.`trade`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` ADD CONSTRAINT `fk_trade_commission_schedule_previous_commission_schedule_id` FOREIGN KEY (`previous_commission_schedule_id`) REFERENCES `banking_ecm`.`trade`.`commission_schedule`(`commission_schedule_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_parent_clearing_house_id` FOREIGN KEY (`parent_clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` ADD CONSTRAINT `fk_trade_compression_cycle_previous_compression_cycle_id` FOREIGN KEY (`previous_compression_cycle_id`) REFERENCES `banking_ecm`.`trade`.`compression_cycle`(`compression_cycle_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ADD CONSTRAINT `fk_trade_trade_repository_parent_trade_repository_id` FOREIGN KEY (`parent_trade_repository_id`) REFERENCES `banking_ecm`.`trade`.`trade_repository`(`trade_repository_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`trade` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`trade` SET TAGS ('dbx_domain' = 'trade');
ALTER TABLE `banking_ecm`.`trade`.`order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Order Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Order Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `market_center_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `parent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Order Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Order Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `average_execution_price` SET TAGS ('dbx_business_glossary_term' = 'Average Execution Price');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Order Capacity');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `capacity` SET TAGS ('dbx_value_regex' = 'principal|agency|riskless_principal|matched_principal');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Entry Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `execution_strategy` SET TAGS ('dbx_business_glossary_term' = 'Execution Strategy');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Order Expiry Date');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `filled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Filled Quantity');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `instruction` SET TAGS ('dbx_business_glossary_term' = 'Order Instruction');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `is_algorithmic` SET TAGS ('dbx_business_glossary_term' = 'Algorithmic Trading Flag');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `is_discretionary` SET TAGS ('dbx_business_glossary_term' = 'Discretionary Order Flag');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `limit_price` SET TAGS ('dbx_business_glossary_term' = 'Limit Price');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'market|limit|stop|stop_limit|ioc|fok');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `origination_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Origination Channel');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `origination_channel` SET TAGS ('dbx_value_regex' = 'electronic|voice|algo|dma|client_portal');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `regulatory_trade_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Trade Flag');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `side` SET TAGS ('dbx_business_glossary_term' = 'Order Side');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `side` SET TAGS ('dbx_value_regex' = 'buy|sell|short_sell|buy_to_cover');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `stop_price` SET TAGS ('dbx_business_glossary_term' = 'Stop Price');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `time_in_force` SET TAGS ('dbx_business_glossary_term' = 'Time In Force (TIF)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `time_in_force` SET TAGS ('dbx_value_regex' = 'day|gtc|ioc|fok|gtd');
ALTER TABLE `banking_ecm`.`trade`.`execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`execution` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `code_list_id` SET TAGS ('dbx_business_glossary_term' = 'Desk Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `best_execution_venue_rank` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Venue Rank');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Execution Capacity');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `capacity` SET TAGS ('dbx_value_regex' = 'principal|agency|riskless_principal|matched_principal');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `clearing_fee` SET TAGS ('dbx_business_glossary_term' = 'Clearing Fee');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `counterparty_bic` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `counterparty_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `counterparty_bic` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `exchange_fee` SET TAGS ('dbx_business_glossary_term' = 'Exchange Fee');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `executed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Executed Quantity');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'filled|partially_filled|cancelled|rejected|pending_settlement');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_type` SET TAGS ('dbx_business_glossary_term' = 'Execution Type');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_type` SET TAGS ('dbx_value_regex' = 'full|partial|block|program|algorithmic|manual');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `gross_trade_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Trade Value');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `liquidity_indicator` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Indicator');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `liquidity_indicator` SET TAGS ('dbx_value_regex' = 'added|removed|routed');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `market_microstructure_indicator` SET TAGS ('dbx_business_glossary_term' = 'Market Microstructure Indicator');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `market_microstructure_indicator` SET TAGS ('dbx_value_regex' = 'lit|dark|systematic_internaliser|otc|rfq');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `net_trade_value` SET TAGS ('dbx_business_glossary_term' = 'Net Trade Value');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Execution Price');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Execution Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `trade_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Trade Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `trade_reporting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Reporting Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `trade_side` SET TAGS ('dbx_business_glossary_term' = 'Trade Side');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `trade_side` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `venue` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `venue_mic_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Market Identifier Code (MIC)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `venue_mic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`trade`.`capture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`capture` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `capture_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `capture_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `capture_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Agreement ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Isin Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `amended_by` SET TAGS ('dbx_business_glossary_term' = 'Amended By User ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `amendment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'economic_amendment|administrative_correction|novation|compression|termination|none');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `booking_status` SET TAGS ('dbx_business_glossary_term' = 'Booking Status');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `booking_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|amended|cancelled|settled|failed');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `ccp_name` SET TAGS ('dbx_business_glossary_term' = 'Central Counterparty (CCP) Name');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|bilateral|pending_clearing');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `cusip` SET TAGS ('dbx_business_glossary_term' = 'Committee on Uniform Securities Identification Procedures (CUSIP)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `cusip` SET TAGS ('dbx_value_regex' = '^[0-9]{3}[0-9A-Z]{5}[0-9]$');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `execution_venue` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Code');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Trade Price');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Re-Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `sedol` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Daily Official List (SEDOL)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `sedol` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{7}$');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Amount');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Execution Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_version` SET TAGS ('dbx_business_glossary_term' = 'Trade Version Number');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `usi` SET TAGS ('dbx_business_glossary_term' = 'Unique Swap Identifier (USI)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Transaction Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Position Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Position Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Position Classification Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Position Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `average_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Cost Basis');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Code');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `base_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `base_currency_market_value` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Market Value');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `base_currency_unrealized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Unrealized Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `break_flag` SET TAGS ('dbx_business_glossary_term' = 'Position Break Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `break_reason` SET TAGS ('dbx_business_glossary_term' = 'Position Break Reason');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `clean_price` SET TAGS ('dbx_business_glossary_term' = 'Clean Price');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `delta` SET TAGS ('dbx_business_glossary_term' = 'Delta');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `dirty_price` SET TAGS ('dbx_business_glossary_term' = 'Dirty Price');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `dv01` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of One Basis Point (DV01)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `gamma` SET TAGS ('dbx_business_glossary_term' = 'Gamma');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `last_revaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Revaluation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `market_price` SET TAGS ('dbx_business_glossary_term' = 'Market Price (Mark-to-Market)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `market_value` SET TAGS ('dbx_business_glossary_term' = 'Market Value');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `position_date` SET TAGS ('dbx_business_glossary_term' = 'Position Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|pending');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `position_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'long|short|flat');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Position Quantity');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'shares|contracts|lots|notional|units');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `realized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Realized Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `rho` SET TAGS ('dbx_business_glossary_term' = 'Rho');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `rwa_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `theta` SET TAGS ('dbx_business_glossary_term' = 'Theta');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `unrealized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'market|model|vendor|last_trade');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `valuation_source` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `var_amount` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `vega` SET TAGS ('dbx_business_glossary_term' = 'Vega');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `pnl_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Attribution ID');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader ID');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Pnl Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Pnl Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Attribution Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book ID');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `accrued_income` SET TAGS ('dbx_business_glossary_term' = 'Accrued Income');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_business_glossary_term' = 'Attribution Method');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `attribution_method` SET TAGS ('dbx_value_regex' = 'risk_factor|scenario|hybrid|full_revaluation');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `attribution_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Quality Score');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_business_glossary_term' = 'Attribution Status');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `attribution_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|adjusted|reconciled|disputed|approved');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `attribution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attribution Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `basis_pnl` SET TAGS ('dbx_business_glossary_term' = 'Basis Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `cancellation_pnl` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `carry_pnl` SET TAGS ('dbx_business_glossary_term' = 'Carry Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `credit_spread_pnl` SET TAGS ('dbx_business_glossary_term' = 'Credit Spread Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `delta_pnl` SET TAGS ('dbx_business_glossary_term' = 'Delta Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `dividend_pnl` SET TAGS ('dbx_business_glossary_term' = 'Dividend Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `fx_translation_pnl` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Translation Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `gamma_pnl` SET TAGS ('dbx_business_glossary_term' = 'Gamma Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `mtm_pnl` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `new_deal_pnl` SET TAGS ('dbx_business_glossary_term' = 'New Deal Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `reconciliation_difference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Difference');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|pending|exception|resolved');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `repo_pnl` SET TAGS ('dbx_business_glossary_term' = 'Repurchase Agreement (Repo) Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `rho_pnl` SET TAGS ('dbx_business_glossary_term' = 'Rho Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `risk_factor_count` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Count');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'murex|calypso|summit|other');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `theta_pnl` SET TAGS ('dbx_business_glossary_term' = 'Theta Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `total_pnl` SET TAGS ('dbx_business_glossary_term' = 'Total Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `trading_pnl` SET TAGS ('dbx_business_glossary_term' = 'Trading Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `unexplained_pnl` SET TAGS ('dbx_business_glossary_term' = 'Unexplained Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`trade`.`pnl_attribution` ALTER COLUMN `vega_pnl` SET TAGS ('dbx_business_glossary_term' = 'Vega Profit and Loss (P&L)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `mtm_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `balance_sheet_position_id` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Desk ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Curve ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Book ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_model_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Model ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `clean_price` SET TAGS ('dbx_business_glossary_term' = 'Clean Price');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `correlation_input` SET TAGS ('dbx_business_glossary_term' = 'Correlation Input');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `cva_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `dirty_price` SET TAGS ('dbx_business_glossary_term' = 'Dirty Price');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `dva_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Debit Valuation Adjustment (DVA)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fair_value` SET TAGS ('dbx_business_glossary_term' = 'Fair Value');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fva_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Funding Valuation Adjustment (FVA)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fx_rate_source` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate Source');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `independent_price_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Independent Price Verification (IPV) Flag');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `ipv_variance` SET TAGS ('dbx_business_glossary_term' = 'Independent Price Verification (IPV) Variance');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `market_price` SET TAGS ('dbx_business_glossary_term' = 'Market Price');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `previous_fair_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Fair Value');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Pricing Source');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `total_valuation_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Valuation Adjustments');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `unrealized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Profit and Loss (PnL)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_value_regex' = 'mark_to_market|mark_to_model|net_asset_value|consensus_pricing|vendor_pricing|internal_model');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_remarks` SET TAGS ('dbx_business_glossary_term' = 'Valuation Remarks');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_source_system` SET TAGS ('dbx_business_glossary_term' = 'Valuation Source System');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|adjusted|verified|pending_review|rejected');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `volatility_input` SET TAGS ('dbx_business_glossary_term' = 'Volatility Input');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `yield_rate` SET TAGS ('dbx_business_glossary_term' = 'Yield Rate');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Bic Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Security Isin Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Transfer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Treasury Nostro Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `affirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Affirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `affirmation_status` SET TAGS ('dbx_value_regex' = 'pending|affirmed|disaffirmed');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `affirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Affirmation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `buy_in_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Buy-In Execution Date');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `buy_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Buy-In Flag');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `buy_in_status` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Buy-In Status');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `buy_in_status` SET TAGS ('dbx_value_regex' = 'not_applicable|initiated|executed|cancelled');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `cash_correspondent_bic` SET TAGS ('dbx_business_glossary_term' = 'Cash Correspondent Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `cash_correspondent_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `csd_name` SET TAGS ('dbx_business_glossary_term' = 'Central Securities Depository (CSD) Name');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `csd_name` SET TAGS ('dbx_value_regex' = 'DTC|Euroclear|Clearstream|other');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `csd_participant_code` SET TAGS ('dbx_business_glossary_term' = 'Central Securities Depository (CSD) Participant Code');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `csdr_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Central Securities Depositories Regulation (CSDR) Cash Penalty Amount');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `csdr_penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Central Securities Depositories Regulation (CSDR) Penalty Currency');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `csdr_penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `fail_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fail Date');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `fail_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fail Duration in Days');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `fail_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fail Flag');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `fail_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fail Reason Code');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `fail_reason_code` SET TAGS ('dbx_value_regex' = 'CPTY|SECU|CASH|MTCH|TECH|OTHR');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `fail_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fail Reason Description');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `instruction_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `instruction_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `instruction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `intended_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Intended Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `matching_status` SET TAGS ('dbx_business_glossary_term' = 'Matching Status');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `matching_status` SET TAGS ('dbx_value_regex' = 'unmatched|matched|mismatched|alleged');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `matching_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Matching Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account International Bank Account Number (IBAN)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `nostro_account_iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fail Resolution Action');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `security_quantity` SET TAGS ('dbx_business_glossary_term' = 'Security Quantity');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_agent_bic` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agent Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_agent_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'T+0|T+1|T+2|T+3');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'CSD|ICSD|bilateral|triparty');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'DVP|RVP|FOP|PFP');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Reference');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `swift_message_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bic Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `swift_message_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `affirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Affirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `affirmation_status` SET TAGS ('dbx_value_regex' = 'affirmed|pending_affirmation|rejected|not_required');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Method');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Number');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `counterparty_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Confirmation Number');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `deadline` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Deadline');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Flag');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `discrepancy_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Resolution Date');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `dtcc_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'Depository Trust and Clearing Corporation (DTCC) Confirmation Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `lei_reporting_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Reporting Entity');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `lei_reporting_entity` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `markit_wire_reference` SET TAGS ('dbx_business_glossary_term' = 'MarkitWire Reference');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `matching_tolerance_breached` SET TAGS ('dbx_business_glossary_term' = 'Matching Tolerance Breached Flag');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Source System');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Message Type');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `swift_message_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `trade_price` SET TAGS ('dbx_business_glossary_term' = 'Trade Price');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Trade Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book ID');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `balance_sheet_position_id` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `parent_book_trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trading Book ID');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Head Trader ID');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `quaternary_trading_head_trader_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `tertiary_trading_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `tertiary_trading_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `tertiary_trading_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'rates|credit|equity|fx|commodity|structured');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `base_currency` SET TAGS ('dbx_business_glossary_term' = 'Base Currency');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `base_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Code');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Hierarchy Level');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Name');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_short_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Short Name');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_status` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Status');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `book_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_approval');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `concentration_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percentage');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `concentration_limit_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `desk_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk Name');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `dv01_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Dollar Value of One Basis Point (DV01) Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `dv01_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `frtb_approach` SET TAGS ('dbx_business_glossary_term' = 'Fundamental Review of the Trading Book (FRTB) Approach');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `frtb_approach` SET TAGS ('dbx_value_regex' = 'standardized|internal_models|hybrid');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `ima_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Models Approach (IMA) Approval Status');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `ima_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not_applicable|rejected');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `is_proprietary_trading` SET TAGS ('dbx_business_glossary_term' = 'Is Proprietary Trading Flag');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `last_limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Limit Review Date');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `lob_code` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `lob_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `lob_name` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Name');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `next_limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Limit Review Date');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `notional_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `notional_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'AMER|EMEA|APAC|LATAM');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'trading_book|banking_book|correlation_trading|securitization');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `stress_loss_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Stress Loss Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `stress_loss_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `trading_strategy` SET TAGS ('dbx_business_glossary_term' = 'Trading Strategy');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `trading_strategy` SET TAGS ('dbx_value_regex' = 'market_making|proprietary|flow|arbitrage|hedging|client_facilitation');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `var_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `var_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon Days');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `volcker_rule_exemption` SET TAGS ('dbx_business_glossary_term' = 'Volcker Rule Exemption');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `volcker_rule_exemption` SET TAGS ('dbx_value_regex' = 'market_making|underwriting|hedging|trading_on_behalf_of_customers|none');
ALTER TABLE `banking_ecm`.`trade`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`amendment` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Amendment Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Novation Successor Party Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amendment_party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Original Trade Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amended_field_names` SET TAGS ('dbx_business_glossary_term' = 'Amended Field Names');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amended_fixed_rate` SET TAGS ('dbx_business_glossary_term' = 'Amended Fixed Rate');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amended_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Amended Maturity Date');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amended_notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Amended Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amended_strike_price` SET TAGS ('dbx_business_glossary_term' = 'Amended Strike Price');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|completed');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amendment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `booking_entity` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Amendment Comments');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `compression_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Compression Cycle Identifier');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|cancelled');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `mtm_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Impact Amount');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `original_fixed_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Fixed Rate');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `original_maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Original Maturity Date');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `original_notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `original_strike_price` SET TAGS ('dbx_business_glossary_term' = 'Original Strike Price');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `pnl_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (PnL) Impact Amount');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `regulatory_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'murex|calypso|summit|other');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`amendment` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Trade Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`allocation` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allocation Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Block Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_executing_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Executing Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_give_up_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Give-Up Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Portfolio Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `accrued_interest` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `affirmation_platform` SET TAGS ('dbx_business_glossary_term' = 'Affirmation Platform');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `affirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Affirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `affirmation_status` SET TAGS ('dbx_value_regex' = 'pending|affirmed|unmatched|exception|cancelled');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `affirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Affirmation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocated_price` SET TAGS ('dbx_business_glossary_term' = 'Allocated Price');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'pro_rata|manual|step_out|average_price|specific_fill|fifo');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'pending|affirmed|rejected|cancelled|amended|settled');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Allocation Comments');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `commission_currency` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Code');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `commission_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `side` SET TAGS ('dbx_business_glossary_term' = 'Trade Side');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `side` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `trade_margin_call_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Margin Call Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Call Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_margin_call_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Margin Call Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_direction` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Direction');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_direction` SET TAGS ('dbx_value_regex' = 'issued|received');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Type');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'variation_margin|initial_margin|additional_margin|return_excess');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `clearing_house_code` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `clearing_house_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_currency` SET TAGS ('dbx_business_glossary_term' = 'Collateral Currency');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_held_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Held Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_pledged_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledged Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|government_bonds|corporate_bonds|equities|other_securities');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Comments');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `custodian_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Reference');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Dispute Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `dispute_raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Dispute Reason');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `dispute_resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolved Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Dispute Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|disputed|under_review|resolved|escalated');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `eligible_collateral_schedule` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Schedule');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Frequency');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'daily|intraday|weekly|on_demand');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `haircut_percentage` SET TAGS ('dbx_business_glossary_term' = 'Collateral Haircut Percentage');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount (IA)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `isda_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Agreement Reference');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `net_margin_call_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Margin Call Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `response_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Response Deadline Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `segregation_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Segregation Requirement Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Settlement Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|partially_settled|fully_settled|failed|cancelled');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Threshold Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_margin_call` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `regulatory_report_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Regulatory Report ID');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade ID');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `clearing_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `trade_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Lifecycle Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'interest_rate|credit|equity|fx|commodity');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `clearing_house_lei` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `clearing_house_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|uncleared|intended_to_clear');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `collateral_portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Collateral Portfolio Code');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `compression_flag` SET TAGS ('dbx_business_glossary_term' = 'Compression Flag');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|unconfirmed|disputed');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `intragroup_flag` SET TAGS ('dbx_business_glossary_term' = 'Intragroup Flag');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `notional_currency` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `notional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `rejection_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Code');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected|acknowledged|cancelled');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `report_version` SET TAGS ('dbx_business_glossary_term' = 'Report Version');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_counterparty_lei` SET TAGS ('dbx_business_glossary_term' = 'Reporting Counterparty Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_counterparty_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_entity_lei` SET TAGS ('dbx_business_glossary_term' = 'Reporting Entity Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_entity_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_business_glossary_term' = 'Reporting Obligation');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_obligation` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|delegated|dual_sided');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_side` SET TAGS ('dbx_business_glossary_term' = 'Reporting Side');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_side` SET TAGS ('dbx_value_regex' = 'buy|sell|both');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `reporting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reporting Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `trade_repository_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository ID');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `trade_repository_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository Name');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `trade_repository_name` SET TAGS ('dbx_value_regex' = 'DTCC_GTR|REGIS_TR|UNAVISTA|CME_SDR|ICE_TRADE_VAULT|BLOOMBERG_SDR');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `usi` SET TAGS ('dbx_business_glossary_term' = 'Unique Swap Identifier (USI)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Trade Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`regulatory_report` ALTER COLUMN `venue_of_execution` SET TAGS ('dbx_business_glossary_term' = 'Venue of Execution');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `trade_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Fee Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `clearing_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `accrual_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `basis` SET TAGS ('dbx_value_regex' = 'per_trade|per_share|notional_bps|flat|tiered|ad_valorem');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `booking_entity` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `external_fee_reference` SET TAGS ('dbx_business_glossary_term' = 'External Fee Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_category` SET TAGS ('dbx_value_regex' = 'execution|post_trade|custody|regulatory|advisory|other');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_status` SET TAGS ('dbx_value_regex' = 'accrued|invoiced|paid|waived|disputed|reversed');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'brokerage_commission|exchange_fee|clearing_fee|settlement_fee|custody_fee|prime_brokerage_fee');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `net_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fee Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `pnl_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Impact Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Fee Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `tca_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Transaction Cost Analysis (TCA) Eligible Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `compression_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Compression Cycle Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Give-Up Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Member Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `party_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `party_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `trade_repository_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `ccp_name` SET TAGS ('dbx_business_glossary_term' = 'Central Counterparty (CCP) Name');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearing Eligibility Flag');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Clearing Fee Amount');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Clearing Fee Currency');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_member_lei` SET TAGS ('dbx_business_glossary_term' = 'Clearing Member Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_member_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|novated|compressed|backloaded');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_venue` SET TAGS ('dbx_business_glossary_term' = 'Clearing Venue');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `clearing_venue` SET TAGS ('dbx_value_regex' = 'exchange|swap_execution_facility|bilateral');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `client_account_type` SET TAGS ('dbx_business_glossary_term' = 'Client Account Type');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `client_account_type` SET TAGS ('dbx_value_regex' = 'house|client|omnibus|individual_segregated');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `collateral_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Amount');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|government_securities|corporate_bonds|equities|letters_of_credit');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `compression_flag` SET TAGS ('dbx_business_glossary_term' = 'Compression Flag');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `default_fund_contribution` SET TAGS ('dbx_business_glossary_term' = 'Default Fund Contribution');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `initial_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Margin (IM) Amount');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `mandatory_clearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Clearing Flag');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `regulatory_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Trade Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_instruction` ALTER COLUMN `variation_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Variation Margin (VM) Amount');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `previous_counterparty_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Approval|Active|Suspended|Terminated|Expired');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `clearing_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Clearing Requirement Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `collateral_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Arrangement Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `credit_rating_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Trigger Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `cross_default_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Default Provision Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'Arbitration|Litigation|Mediation|Negotiation');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `document_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Reference');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `eligible_collateral_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Collateral Types');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `independent_amount` SET TAGS ('dbx_business_glossary_term' = 'Independent Amount');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `margin_call_frequency` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Frequency');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `margin_call_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Intraday|On Demand');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `master_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Confirmation Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `minimum_transfer_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transfer Amount (MTA)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `mtm_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `netting_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Provision Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `notional_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `settlement_time` SET TAGS ('dbx_business_glossary_term' = 'Settlement Time');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Threshold Amount');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Frequency');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `valuation_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly|On Demand');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `trade_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Lifecycle Event ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Event Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Event Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `primary_trade_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `primary_trade_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `primary_trade_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Counterparty ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `instrument_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Event Asset Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `previous_trade_lifecycle_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `booking_entity_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `cash_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Settlement Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `cash_settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Cash Settlement Currency');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `cash_settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `ccp_name` SET TAGS ('dbx_business_glossary_term' = 'Central Counterparty (CCP) Name');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'cleared|uncleared|pending|rejected');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `compression_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Compression Cycle ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `compression_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Compression Service Provider');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|cancelled');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `economic_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Economic Impact Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `economic_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Economic Impact Currency');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `economic_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected|cancelled|settled');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `external_event_reference` SET TAGS ('dbx_business_glossary_term' = 'External Event ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `portfolio_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Reconciliation Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `reconciliation_discrepancy_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Discrepancy Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `regulatory_report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `successor_counterparty_lei` SET TAGS ('dbx_business_glossary_term' = 'Successor Counterparty Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `successor_counterparty_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'mutual_agreement|early_exercise|credit_event|regulatory_requirement|portfolio_optimization|other');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `trade_repository_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository ID');
ALTER TABLE `banking_ecm`.`trade`.`trade_lifecycle_event` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Trade Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`broker` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Bic Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Screening Status');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `aml_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_code` SET TAGS ('dbx_business_glossary_term' = 'Broker Code');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_business_glossary_term' = 'Broker Status');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_business_glossary_term' = 'Broker Type');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_type` SET TAGS ('dbx_value_regex' = 'executing_broker|prime_broker|clearing_broker|introducing_broker|custodian_broker|agency_broker');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Number');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `custodian_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `default_commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Commission Rate');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `eligible_asset_classes` SET TAGS ('dbx_business_glossary_term' = 'Eligible Asset Classes');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `eligible_markets` SET TAGS ('dbx_business_glossary_term' = 'Eligible Markets');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'complete|pending|expired|under_review');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `primary_regulator` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulator');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Number');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'registered|approved|restricted|sanctioned|delisted');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|give_up|correspondent');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `settlement_agent_bic` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agent Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `settlement_agent_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Short Name');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` SET TAGS ('dbx_subdomain' = 'execution_processing');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `best_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Best Execution ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `instrument_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer ID');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `previous_best_execution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `alternative_venue_count` SET TAGS ('dbx_business_glossary_term' = 'Alternative Venue Count');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `analysis_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Analysis Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Analysis Status');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `analysis_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|under_review|approved');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Analysis Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'equity|fixed_income|fx|commodity|derivative');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `benchmark_price` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Price');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Type');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `benchmark_type` SET TAGS ('dbx_value_regex' = 'arrival_price|mid_market|vwap|twap|closing_price|opening_price');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `client_instruction_details` SET TAGS ('dbx_business_glossary_term' = 'Client Instruction Details');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `client_order_type` SET TAGS ('dbx_business_glossary_term' = 'Client Order Type');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `client_order_type` SET TAGS ('dbx_value_regex' = 'retail|professional|eligible_counterparty');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Compliance Flag');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Legal Entity Identifier (LEI)');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `counterparty_lei` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Exception Reason');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `executed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Executed Quantity');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `execution_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Execution Cost');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `execution_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Execution Quality Score');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `explicit_cost` SET TAGS ('dbx_business_glossary_term' = 'Explicit Execution Cost');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `factors` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Factors Considered');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `implicit_cost` SET TAGS ('dbx_business_glossary_term' = 'Implicit Execution Cost');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `market_impact_cost` SET TAGS ('dbx_business_glossary_term' = 'Market Impact Cost');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `opportunity_cost` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Cost');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `price_improvement` SET TAGS ('dbx_business_glossary_term' = 'Price Improvement Amount');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `price_improvement_bps` SET TAGS ('dbx_business_glossary_term' = 'Price Improvement in Basis Points (BPS)');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Regime');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `regulatory_regime` SET TAGS ('dbx_value_regex' = 'mifid_ii|reg_nms|other');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `reporting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|approved|escalated|remediated');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `specific_client_instruction_flag` SET TAGS ('dbx_business_glossary_term' = 'Specific Client Instruction Flag');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `spread_cost` SET TAGS ('dbx_business_glossary_term' = 'Bid-Ask Spread Cost');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `venue_mic_code` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier Code (MIC)');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `venue_mic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `banking_ecm`.`trade`.`best_execution` ALTER COLUMN `venue_rank` SET TAGS ('dbx_business_glossary_term' = 'Venue Rank');
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` ALTER COLUMN `commission_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Schedule Identifier');
ALTER TABLE `banking_ecm`.`trade`.`commission_schedule` ALTER COLUMN `previous_commission_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `parent_clearing_house_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` ALTER COLUMN `compression_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Compression Cycle Identifier');
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` ALTER COLUMN `previous_compression_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` ALTER COLUMN `created_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`compression_cycle` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `trade_repository_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Repository Identifier');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `parent_trade_repository_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `fees_per_transaction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trade_repository` ALTER COLUMN `submission_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`isda_master_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`isda_master_agreement` SET TAGS ('dbx_subdomain' = 'reference_data');
