-- Schema for Domain: trade | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`trade` COMMENT 'Securities trading, order management, trade capture, execution, position management, P&L attribution, and post-trade processing for capital markets and trading book activities. Manages the full trade lifecycle from order entry through settlement, MTM valuation, trade confirmations, and FX/OTC derivative execution. Primary system of record aligned with Murex / Calypso.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`order` (
    `order_id` BIGINT COMMENT 'Unique system-generated identifier for the trade order. Primary key for the order entity. Serves as the single source of truth for order identity across all capital markets systems.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Orders must be mapped to accounting periods for trade-date P&L attribution, MiFID II transaction reporting, and financial close. A banking operations expert expects every order to be period-stamped fo',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Orders placed by parties under active AML investigation must be flagged or blocked. AML investigators require direct traceability from order to AML case for suspicious activity analysis and regulatory',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Orders placed during IPO/secondary offering bookbuilding must reference the offering for order book management, allocation decisions, price discovery, demand analysis, and regulatory reporting (SEC Fo',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Orders for repo, securities lending, and collateral transformation transactions reference a specific collateral asset. Order management systems must validate collateral asset eligibility, haircut, and',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Order currency must validate against reference currency master for FX rate application, settlement processing, and regulatory reporting. Reference data provides ISO codes, minor units, and settlement ',
    `deposit_account_id` BIGINT COMMENT 'Reference to the specific client account for which the order is placed. Used for segregation of client assets, account-level reporting, and regulatory compliance. Null for proprietary trading orders.',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Fund subscription and redemption orders are placed at the fund class level, as different share classes have distinct dealing NAVs, currencies, fee structures, and settlement terms. Order routing and d',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund managers place orders on behalf of funds daily. Essential for attributing trading activity to funds for NAV calculation, performance tracking, and regulatory reporting (MiFID II transaction repor',
    `instrument_id` BIGINT COMMENT 'Reference to the security master record for the instrument being traded. Links to detailed security attributes including ISIN, CUSIP, ticker, issuer, maturity, and security-specific terms.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Orders are placed by a specific legal entity — required for entity-level regulatory reporting (EMIR, Dodd-Frank), legal entity P&L attribution, and Volcker Rule compliance monitoring at the entity lev',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Order counterparty LEI required for MiFID II transaction reporting, best execution analysis, and regulatory transparency. Reference LEI registry provides legal entity details, jurisdiction, and relati',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Orders placed for discretionary managed portfolios must reference the portfolio for pre-trade compliance checks against investment mandates, order routing logic, and client-level order reporting. Weal',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Orders for margin-financed trades (repo, securities lending, margin equity) must reference the governing margin agreement to enforce collateral requirements at order entry. Order management systems va',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Orders trigger transaction monitoring rules for AML/fraud surveillance. Banks screen orders against scenarios for layering, wash trading, and market manipulation - core compliance process in trading o',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: MiFID II suitability and appropriateness obligations require documenting the client interaction (branch, contact center, or digital) that led to a trade order. Linking order to the originating interac',
    `session_id` BIGINT COMMENT 'Foreign key linking to channel.session. Business justification: MiFID II best execution and fraud investigation require linking each trade order to the digital/channel session that originated it. origination_channel (plain attr) is a denormalized representation of',
    `parent_order_id` BIGINT COMMENT 'Reference to the parent order in hierarchical order structures. Used for algorithmic trading and smart order routing where a parent order is split into multiple child orders for execution. Null for top-level orders.',
    `party_id` BIGINT COMMENT 'Reference to the counterparty for the order. For client orders, the client entity. For inter-dealer trades, the dealer counterparty. Used for credit exposure monitoring, counterparty risk management, and KYC compliance.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: MiFID II order routing, regulatory classification, and RTS 28 best execution reporting require product type on orders. A banking domain expert would expect orders to carry a product type FK for downst',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Executions generate immediate realized P&L and must be mapped to an accounting period for daily P&L reporting, FRTB capital calculations, and financial close. Banking operations require execution-leve',
    `broker_id` BIGINT COMMENT 'FK to trade.broker',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Executions settling capital markets offerings need offering reference for offering settlement reconciliation, stabilization activity tracking (Reg M compliance), greenshoe option exercise, and final p',
    `clearing_house_id` BIGINT COMMENT 'Foreign key linking to trade.clearing_house. Business justification: Exchange-traded and centrally cleared OTC executions are cleared through a specific CCP (Central Counterparty Clearing House). Linking execution directly to clearing_house enables post-trade processin',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Repo and securities lending executions trade collateral assets as underlying instruments. Repo trading desks execute trades where the security IS the collateral, requiring direct linkage for position ',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: OTC derivative and bilateral securities executions are governed by ISDA Master Agreements, GMRA, or GMSLA counterparty agreements. Linking execution to counterparty_agreement enables XVA calculation, ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Execution currency validation required for trade capture, settlement processing, and FX exposure calculation. Reference currency master provides rounding rules, settlement lag, and convertibility stat',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Executions tied to investment banking deals (IPO settlements, secondary offerings, block trades supporting M&A) need tracking for deal execution reporting, fee calculation based on executed volume, an',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: FX execution reconciliation and MiFID II/EMIR regulatory reporting require linking each execution to the official exchange rate record used for currency conversion. Supports P&L attribution audit trai',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Every trade execution incurs a funding cost priced via FTP. Linking execution to ftp_rate supports RAROC calculation, desk-level profitability reporting, and internal transfer pricing — ALCO requires ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Executions must be attributed to funds for accurate fund accounting, performance measurement, and regulatory compliance. Critical for fund NAV calculation and MiFID II best execution reporting at fund',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security) that was executed. Links to the securities master data.',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Execution reporting and best execution analysis require issuer-level aggregation for issuer concentration limits, issuer credit risk assessment in execution decisions, and regulatory reporting by issu',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Executions are booked to a legal entity for FRTB regulatory capital reporting, entity-level P&L, and trade reporting obligations (EMIR/MiFIR). Entity attribution at execution level is a core banking r',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Execution counterparty LEI validation mandatory for regulatory trade reporting (EMIR, MiFID II, Dodd-Frank). Reference LEI registry provides legal entity name, jurisdiction, and ultimate parent for re',
    `listing_id` BIGINT COMMENT 'Foreign key linking to security.listing. Business justification: Executions occur on specific exchange listings. MiFID II venue reporting and best execution analysis require linking each execution to the exact listing (exchange, trading phase, tick size). execution',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Links trade executions to wealth portfolios for transaction cost analysis (TCA), performance attribution, and MiFID II best execution reporting. Enables portfolio managers to analyze execution quality',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Executions are screened against monitoring scenarios for market abuse detection (spoofing, layering, front-running). Real-time surveillance systems match executions to rule definitions for alert gener',
    `order_id` BIGINT COMMENT 'Reference to the parent trade order that this execution fulfills (fully or partially). One order may have multiple executions.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: MiFID II Article 26 transaction reporting requires client identification at execution level, not just order level. execution currently has no direct party FK (only order_id→order which has party_id). ',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: MiFID II RTS 22 transaction reporting mandates product type classification on every execution. instrument_type is a denormalized plain string; a proper FK to product_type supports regulatory reporting',
    `redemption_id` BIGINT COMMENT 'Foreign key linking to asset.redemption. Business justification: When a fund redemption is executed (units redeemed at dealing NAV), the trade execution record corresponds to the redemption record. Fund administrators reconcile executions to redemptions for proceed',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: MiFID II best execution (RTS 27/28) and Transaction Cost Analysis (TCA) require comparing execution price against a reference security price. Role-prefixed reference_price_id distinguishes from the ',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Post-trade limit monitoring tracks which limit each execution consumes for real-time utilization and breach escalation. Critical for intraday risk management and regulatory capital calculations.',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Executions involving sanctioned instruments, venues, or counterparties trigger sanctions screening events. MiFID II transaction reporting and OFAC compliance require traceability from execution to scr',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to asset.subscription. Business justification: When a fund subscription is executed (units allotted at dealing NAV), the trade execution record corresponds to the subscription record. Fund transfer agents reconcile executions to subscriptions for ',
    `syndication_id` BIGINT COMMENT 'Foreign key linking to investment.investment_syndication. Business justification: Executions of syndicated securities must reference the syndication record for syndication desk selldown tracking and regulatory disclosure of syndicated exposure. Syndication teams require execution-l',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Executions occur within the context of a specific trading book for P&L attribution, position management, and regulatory reporting. While the order already carries trading_book_id, having it directly o',
    `underwriting_id` BIGINT COMMENT 'Foreign key linking to investment.underwriting. Business justification: Stabilization trades and greenshoe exercises executed under underwriting commitments must reference the underwriting agreement. SEC Rule 10b-7 stabilization reporting and underwriting P&L attribution ',
    `best_execution_venue_rank` STRING COMMENT 'Rank of this execution venue in the firms best-execution venue selection process. Used for MiFID II RTS 27 and SEC Rule 606 best-execution reporting.',
    `capacity` STRING COMMENT 'Capacity in which the firm executed the trade: principal (trading for own account), agency (acting as broker), riskless principal, or matched principal. Required for regulatory reporting.. Valid values are `principal|agency|riskless_principal|matched_principal`',
    `clearing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the clearinghouse for clearing and settlement of this execution. Denominated in execution_currency.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Broker commission charged for this execution. Denominated in execution_currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this execution record was first created in the system. Audit trail for data lineage.',
    `exchange_fee` DECIMAL(18,2) COMMENT 'Fee charged by the trading venue or exchange for this execution. Denominated in execution_currency.',
    `executed_quantity` DECIMAL(18,2) COMMENT 'The number of units (shares, contracts, bonds, etc.) filled in this execution. For partial fills, this is less than the order quantity.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the execution record. Tracks progression from fill through settlement.. Valid values are `filled|partially_filled|cancelled|rejected|pending_settlement`',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trade execution occurred in the market. This is the real-world event time, distinct from record creation time. Critical for T+1 settlement calculation and best-execution analysis.',
    `execution_type` STRING COMMENT 'Classification of the execution method. Indicates whether this is a full fill, partial fill, block trade, program trade, algorithmic execution, or manual execution.. Valid values are `full|partial|block|program|algorithmic|manual`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied if settlement_currency differs from execution_currency. Null if currencies are the same.',
    `gross_trade_value` DECIMAL(18,2) COMMENT 'Total value of the execution before commissions and fees, calculated as executed_quantity × execution_price. Denominated in execution_currency.',
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
    CONSTRAINT pk_execution PRIMARY KEY(`execution_id`)
) COMMENT 'Transactional record of each individual fill or partial fill against a trade order. Captures execution price, executed quantity, execution venue (exchange, ECN, OTC), execution timestamp, counterparty BIC/LEI, broker, commission, execution type (full/partial), and market microstructure data. Supports T+1 settlement initiation and best-execution regulatory reporting (MiFID II, SEC Rule 606). One order may have multiple executions.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`capture` (
    `capture_id` BIGINT COMMENT 'Unique identifier for the trade capture record. Primary key for the authoritative trade booking record in the trading platform.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Trades are booked in accounting periods for period-end close, trade date accounting, and regulatory reporting by period. Critical for financial close and period attribution.',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to treasury.cash_flow_forecast. Business justification: Trade captures generate contractual cash flows that are direct inputs to treasury cash flow forecasting. This link supports LCR contractual inflow/outflow calculation and intraday liquidity monitoring',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Corporate actions (dividends, splits, mergers, rights issues) generate mandatory trade bookings in the capture system. Linking capture to the originating corporate_action supports corporate action pro',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Trade booking requires counterparty PD/LGD for CVA calculation, pre-trade credit limit checks, and SA-CCR regulatory capital. Fundamental to counterparty credit risk management.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: EMIR and MiFID II require the execution venue to be identified by BIC/MIC code in trade reports. execution_venue is a plain string denormalization; linking to bic_directory provides the authoritative ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund trades must be captured with fund attribution for booking to correct fund accounting ledger. Core requirement for fund position reconciliation, NAV calculation, and AIFMD/UCITS regulatory reporti',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Settlement date and value date validation during trade capture requires the applicable holiday calendar. Banking operations teams use this to auto-validate settlement_date and value_date fields agains',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Every booked trade references a specific financial instrument. EMIR/MiFID II regulatory reporting requires instrument-level trade data. capture.cusip and capture.sedol are denormalized instrument iden',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: EMIR, CFTC, and MAS regulatory reporting obligations on trade captures are jurisdiction-specific. The reporting jurisdiction determines which trade repository to use and which fields are mandatory; a ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Trade captures are booked to a legal entity — fundamental for EMIR UTI reporting, Dodd-Frank entity-level reporting, and legal entity P&L. The existing plain attribute legal_entity is a denormalizatio',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Trade capture LEI validation essential for derivatives reporting to trade repositories, regulatory transparency, and counterparty risk management. Reference registry provides legal entity details and ',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Trade captures for wealth management clients must reference the managed portfolio for P&L attribution, regulatory reporting, and portfolio accounting. The existing portfolio_code plain attribute is a ',
    `netting_set_id` BIGINT COMMENT 'Identifier for the legal netting set to which this trade belongs under ISDA Master Agreement. Used for CVA, exposure calculation, and capital optimization.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Trade capture records the counterparty as a denormalized text field (counterparty_name). Regulatory reporting (EMIR UTI/USI, MiFID II transaction reports) requires a structured party reference. A bank',
    `pledge_agreement_id` BIGINT COMMENT 'Reference to the ISDA Credit Support Annex (CSA) or collateral agreement governing margin requirements for this trade. Used for initial margin and variation margin calculations.',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Floating rate trade capture (IRS, FRNs, floating rate loans) requires the reference benchmark rate (SOFR, EURIBOR) for coupon calculation and IBOR transition tracking. Critical for LIBOR transition re',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: Repo trade captures in trade.capture must reference the treasury repo_position they contribute to. This link supports repo book reconciliation, P&L attribution, and SFTR regulatory reporting — a stand',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trade currency validation essential for booking, valuation, regulatory reporting, and FX risk calculation. Reference currency master provides ISO codes, central bank data, and convertibility restricti',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Trade product type classification drives booking model, risk categorization, regulatory capital treatment, and P&L attribution. Reference product type master provides Basel, IFRS9, and regulatory repo',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: The capture table contains a denormalized `trading_book: STRING` column that stores the trading book identifier as a free-text string. Adding a proper FK `trading_book_id` to `trade.trading_book` norm',
    `transaction_structure_id` BIGINT COMMENT 'Foreign key linking to investment.transaction_structure. Business justification: Trade captures for structured products must reference the transaction structure for EMIR/Dodd-Frank regulatory reporting, P&L attribution, and deal accounting. Banking operations teams require this li',
    `accrued_interest` DECIMAL(18,2) COMMENT 'The amount of interest that has accumulated on a fixed income instrument from the last coupon payment date to the trade date. Added to clean price to calculate dirty price.',
    `amended_by` STRING COMMENT 'The user ID of the person who submitted the amendment. Part of the audit trail for trade lifecycle changes and SOX compliance.',
    `amendment_reason` STRING COMMENT 'Free-text explanation of why the trade was amended. Provides business context for audit trail and regulatory inquiries. Required for versions greater than 1.',
    `amendment_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the amendment was applied to the trade record. Used for audit trail reconstruction and regulatory reporting of lifecycle events.',
    `amendment_type` STRING COMMENT 'Classification of the lifecycle event that created this version. Economic amendments change trade economics; administrative corrections fix errors; novations transfer to new counterparty; compressions reduce notional.. Valid values are `economic_amendment|administrative_correction|novation|compression|termination|none`',
    `approval_status` STRING COMMENT 'Status of the approval workflow for trade amendments requiring middle office or risk approval. Ensures proper controls over trade modifications.. Valid values are `pending_approval|approved|rejected`',
    `booking_status` STRING COMMENT 'The current lifecycle status of the trade booking record. Tracks progression from initial capture through confirmation, amendment, settlement, or cancellation.. Valid values are `pending|confirmed|amended|cancelled|settled|failed`',
    `ccp_name` STRING COMMENT 'The name of the central counterparty clearing house if the trade is centrally cleared. Examples include LCH, CME, Eurex Clearing. Null for bilateral trades.',
    `clearing_status` STRING COMMENT 'Indicates whether the trade is centrally cleared through a CCP or remains bilateral. Critical for EMIR clearing obligation compliance and capital treatment under Basel III.. Valid values are `cleared|bilateral|pending_clearing`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade capture record was first created in the trading platform. Part of the audit trail for trade booking and operational reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade capture record was last updated. Tracks all modifications including amendments, status changes, and data corrections.',
    `maturity_date` DATE COMMENT 'The date on which the financial instrument matures or expires. Applicable to bonds, derivatives, and term instruments. Null for perpetual or equity instruments.',
    `notional_amount` DECIMAL(18,2) COMMENT 'The principal or face value amount of the trade used for calculating cash flows, interest, and risk exposure. For derivatives, represents the reference amount on which payments are based.',
    `price` DECIMAL(18,2) COMMENT 'The executed price or rate of the trade. For bonds, represents clean price as percentage of par. For derivatives, represents the fixed rate, strike, or premium. Interpretation depends on product type.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this amendment requires re-reporting to regulatory trade repositories under EMIR, Dodd-Frank, or MiFID II. Set to true for economic amendments and material corrections.',
    `settlement_currency` STRING COMMENT 'The currency in which cash settlement will occur. May differ from trade currency for cross-currency transactions. Three-letter ISO 4217 currency code.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'The date on which the trade settles and final transfer of cash and securities occurs. Follows market convention (T+1, T+2, T+3) based on asset class and jurisdiction.',
    `trade_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the trade in trade currency. For cash instruments, equals notional × price. For derivatives, may represent premium or initial margin.',
    `trade_date` DATE COMMENT 'The date on which the trade was executed and agreed between counterparties. Critical for settlement cycle calculation and regulatory reporting.',
    `trade_reference_number` STRING COMMENT 'Internal business identifier for the trade used across front office, middle office, and back office systems. Human-readable reference for trade inquiries and reconciliation.',
    `trade_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the trade was executed, including milliseconds. Required for MiFID II transaction reporting and best execution analysis.',
    `trade_version` STRING COMMENT 'Sequential version number incremented with each amendment or lifecycle event. Version 1 represents the original trade; subsequent versions capture economic amendments, administrative corrections, novations, or compressions.',
    `usi` STRING COMMENT 'US-specific unique identifier for swap transactions required under Dodd-Frank Act reporting rules. Used for CFTC and SEC swap data repository reporting.',
    `uti` STRING COMMENT 'Globally unique identifier for OTC derivative transactions as required by EMIR and Dodd-Frank regulatory reporting. Assigned at trade inception and maintained through lifecycle events.',
    `value_date` DATE COMMENT 'The date on which the trade economically takes effect and cash flows or securities are exchanged. Used for interest accrual and funding calculations.',
    CONSTRAINT pk_capture PRIMARY KEY(`capture_id`)
) COMMENT 'Authoritative trade booking record and single system of record in the trading platform (Murex/Calypso). Represents the confirmed, booked trade after execution, capturing trade date, value date, settlement date, notional amount, price/rate, accrued interest, trade currency, settlement currency, counterparty LEI, legal entity, trading book, and booking status. Supports all asset classes and product types including cash equities, bonds, IRS, CDS, FX spot/forward/swap/NDF, OTC options, equity swaps, and swaptions with product-type-specific attributes (e.g., UTI/USI for OTC derivatives, currency pair/forward points for FX, fixed/floating legs for swaps). Maintains full amendment and versioning history as lifecycle events on the trade record, including amendment type (economic amendment, administrative correction, novation, compression), amended fields with before/after values, amendment reason, approval workflow status, approver, amendment timestamp, and regulatory re-reporting flags for EMIR/Dodd-Frank/MiFID II. Each amendment creates a versioned snapshot preserving the complete audit trail. SSOT for the confirmed trade event, its full amendment audit trail, and all product types across capital markets.';

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_position` (
    `trade_position_id` BIGINT COMMENT 'Unique identifier for the trade position record. Primary key for the trade position entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Positions are reported as of period-end for period-end position reporting and balance sheet preparation. Required for financial close and regulatory reporting.',
    `clearing_house_id` BIGINT COMMENT 'Foreign key linking to trade.clearing_house. Business justification: Cleared positions are held at a specific CCP (Central Counterparty Clearing House). Linking trade_position to clearing_house is essential for margin requirement calculation, default fund contributions',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Position-level credit exposure calculations require counterparty PD/LGD from rating models for CVA, DVA, and RWA under SA-CCR or IMM. Essential for Basel III capital.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Position currency required for FX revaluation, P&L calculation, and risk reporting. Reference currency master provides FX rates, revaluation frequency, and base currency conversion rules.',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Trade positions are held at custodian accounts. This link is essential for custody reconciliation (comparing trade system positions against custodian statements), collateral management, and securities',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Investment banking deals generate trading positions requiring deal-level P&L reporting, risk attribution, and regulatory capital allocation. Risk managers and finance teams run deal-level P&L reports ',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: Daily P&L revaluation and IFRS 9/Basel III regulatory reporting require linking trade positions to the official exchange rate used for base currency conversion. fx_rate is a plain attribute; the FK pr',
    `fund_class_id` BIGINT COMMENT 'Foreign key linking to asset.fund_class. Business justification: Positions in fund units are held at the fund class level (Class A, Class B, etc.), each with different NAV per unit, expense ratios, and investor eligibility. Position reporting, performance attributi',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund positions tracked separately from proprietary trading book positions. Essential for fund NAV calculation, risk reporting (VaR, concentration limits), regulatory reporting (AIFMD leverage calculat',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security, derivative, FX contract) for which this position is held.',
    `interest_rate_risk_position_id` BIGINT COMMENT 'Foreign key linking to treasury.interest_rate_risk_position. Business justification: IRRBB framework requires aggregating individual trade positions into interest rate risk positions. Linking trade_position to interest_rate_risk_position supports EVE/NII sensitivity reporting, ALCO re',
    `investment_valuation_id` BIGINT COMMENT 'Foreign key linking to investment.investment_valuation. Business justification: IFRS 13 fair value hierarchy reporting requires trading positions in investment banking assets to be reconciled against advisory investment valuations. Risk and finance teams use this link for indepen',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Position risk management requires issuer-level concentration monitoring for single-name limits, issuer credit exposure aggregation, and regulatory capital calculations by issuer. Direct FK enables eff',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or books this position. Used for regulatory reporting and capital allocation.',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Trade positions directly consume liquidity buffers. Linking trade_position to liquidity_position supports intraday liquidity monitoring, LCR buffer management, and ALCO reporting — treasury needs to a',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: A trade positions net exposure drives daily VM/IM margin calls under a specific margin agreement. Risk and collateral teams link positions to margin agreements for EMIR/Dodd-Frank regulatory margin r',
    `netting_set_id` BIGINT COMMENT 'Foreign key linking to collateral.netting_set. Business justification: Trade positions are grouped into netting sets for SA-CCR regulatory capital calculation, XVA (CVA/DVA) computation, and close-out netting enforceability under ISDA. A banking domain expert would consi',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Positions are subject to regulatory obligations including large position reporting (SEC Rule 13F), short position reporting (EU SSR), and capital adequacy obligations. Linking positions to obligations',
    `offering_id` BIGINT COMMENT 'Foreign key linking to investment.offering. Business justification: Trading positions in securities originated through capital markets offerings require offering-level reference for lock-up period compliance monitoring and stabilization position limits (SEC Rule 104).',
    `party_id` BIGINT COMMENT 'Reference to the counterparty with whom the position was established. Used for counterparty credit risk and exposure management.',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Trade positions are revalued using security prices for daily P&L, risk reporting, and regulatory capital (FRTB). Linking to the source price record supports valuation audit trails and IPV. trade_posit',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Basel III/FRTB regulatory capital calculation and risk-weighted asset reporting require product type classification on trade positions. Position-level product type drives RWA approach selection and FR',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Trade positions are attributed to profit centers for desk-level daily P&L reporting and FRTB capital calculations. Banking operations require direct profit center attribution on positions for manageme',
    `rate_benchmark_id` BIGINT COMMENT 'Foreign key linking to reference.rate_benchmark. Business justification: Accrued income calculation and interest rate risk reporting (DV01, PVBP) for floating rate positions require the applicable rate benchmark. FRTB GIRR risk factor bucketing also requires benchmark iden',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Positions are reviewed during regulatory exams for concentration limits, capital adequacy (Basel III), and risk limit compliance. Examiners require traceability from exam to specific positions under r',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: Securities positions are funded via repo. Linking trade_position to repo_position supports funding cost attribution to positions, collateral management, and NSFR/LCR classification — a core treasury-t',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Position-level limit monitoring is core to market risk management; positions must reference applicable limits (VaR, stress loss, concentration) for breach detection and ALCO reporting.',
    `subledger_id` BIGINT COMMENT 'Foreign key linking to ledger.subledger. Business justification: Trade positions are maintained in a trading subledger that reconciles to the GL — a core banking accounting control. Direct FK enables automated subledger-to-GL reconciliation and break identification',
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

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`mtm_valuation` (
    `mtm_valuation_id` BIGINT COMMENT 'Unique identifier for the mark-to-market valuation record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Valuations are performed as of period-end for period-end valuation, financial close, and regulatory reporting. Essential for period-end close process and audit.',
    `benchmark_rate_fixing_id` BIGINT COMMENT 'Foreign key linking to reference.benchmark_rate_fixing. Business justification: Fair value calculation for interest rate derivatives requires the specific benchmark rate fixing on the valuation date. IFRS 13 Level 2 fair value hierarchy documentation and model validation require ',
    `branch_id` BIGINT COMMENT 'Identifier of the trading desk responsible for the position, supporting organizational P&L attribution.',
    `capture_id` BIGINT COMMENT 'Reference to the trade or position being valued.',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: MTM valuations for OTC derivatives include XVA adjustments (CVA, DVA, FVA) that are counterparty-specific and governed by the ISDA Master Agreement. Linking mtm_valuation to counterparty_agreement ena',
    `exchange_rate_id` BIGINT COMMENT 'Foreign key linking to reference.exchange_rate. Business justification: IFRS 13 fair value hierarchy documentation and IPV (Independent Price Verification) require an auditable link from MTM valuations to the specific exchange rate record used. fx_rate is a plain attribut',
    `factor_id` BIGINT COMMENT 'Foreign key linking to risk.risk_factor. Business justification: MTM valuations depend on risk factors (discount curves, volatility surfaces, credit spreads) as pricing inputs. Essential for independent price verification and model risk management.',
    `fund_holding_id` BIGINT COMMENT 'Foreign key linking to asset.fund_holding. Business justification: MTM valuations are performed on specific fund holdings. The valuation record must reference the holding being valued for IFRS 13 / ASC 820 fair value hierarchy reporting, independent price verificatio',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: MTM valuation is performed at the instrument level. IFRS 13 fair value hierarchy disclosure and daily P&L reporting require linking each valuation record to the specific instrument being priced. No in',
    `investment_valuation_id` BIGINT COMMENT 'Foreign key linking to investment.investment_valuation. Business justification: IFRS 13 requires MTM valuations of investment banking assets to be reconciled against advisory team investment valuations. Independent price verification (IPV) process requires linking trading desk MT',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that holds the position, supporting regulatory reporting and capital allocation.',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: MTM valuations feed directly into margin call calculations under a specific margin agreement. The daily MTM determines VM requirements; automated margin call systems must link each valuation to its go',
    `netting_set_id` BIGINT COMMENT 'Foreign key linking to collateral.netting_set. Business justification: MTM valuations are aggregated at the netting set level for XVA desk CVA/DVA calculations and SA-CCR regulatory capital. The netting set determines which trades MTM values can be legally netted; this ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: MTM valuations are subject to fair value accounting obligations (IFRS 13, ASC 820) and regulatory capital obligations (Basel III). Linking valuations to obligations supports regulatory capital reporti',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: MTM valuation must reference the specific security price record used as input for Independent Price Verification (IPV) and audit trail. MiFID II and FRTB require documenting the price source used in f',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: MTM valuations directly feed profit center P&L reporting — a core banking management accounting requirement. Daily P&L attribution by profit center requires direct FK from MTM valuation records to pro',
    `rate_benchmark_id` BIGINT COMMENT 'Identifier of the discount curve used for present value calculations in derivative and fixed income valuations.',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: CVA/DVA/FVA stress adjustments (columns cva_adjustment, dva_adjustment, fva_adjustment on mtm_valuation) are computed under specific stress scenarios for CCAR/DFAST submissions. Linking each MTM valua',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Regulatory stress testing (CCAR/DFAST/ICAAP) produces MTM valuations as part of each run. Linking mtm_valuation to stress_test_run enables auditors and regulators to trace which stress run produced wh',
    `trade_position_id` BIGINT COMMENT 'Reference to the aggregated position being valued, if applicable.',
    `trading_book_id` BIGINT COMMENT 'Identifier of the trading book or portfolio to which the position belongs, supporting P&L aggregation and risk reporting.',
    `transaction_structure_id` BIGINT COMMENT 'Foreign key linking to investment.transaction_structure. Business justification: MTM valuations of structured products require the transaction structure to apply correct valuation methodology (WACC, DCF parameters, financing mix). IFRS 13 Level 3 fair value measurements require do',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Valuation currency validation required for fair value hierarchy compliance, IFRS reporting, and FX revaluation. Reference currency master provides rounding rules, minor units, and regulatory reporting',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Fixed income MTM valuation discounts cash flows using a yield curve. IFRS 13 and FRTB require documenting the yield curve used in fair value measurement. mtm_valuation.yield_rate is a scalar output; t',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Settlement instructions affect cash and securities balances that must be recorded in the correct accounting period for balance sheet accuracy, CSDR penalty accruals, and period-end settlement reconcil',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Settlement instructions linked to suspicious transactions are escalated to AML cases and may be blocked. AML investigators need direct traceability from AML case to the specific settlement instruction',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Settlement instructions require BIC validation for SWIFT message routing, correspondent bank connectivity, and securities settlement. Reference BIC directory provides institution details, service prof',
    `capture_id` BIGINT COMMENT 'Reference to the parent trade transaction that generated this settlement instruction.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Trade settlement requires a specific deposit account for the cash leg — debiting/crediting upon settlement. Settlement desks must identify which deposit account funds each settlement instruction. Core',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to treasury.cash_flow_forecast. Business justification: Settlement instructions represent contractual cash flows that are primary inputs to treasury cash flow forecasting. This link supports intraday liquidity monitoring and short-term cash flow forecastin',
    `collateral_asset_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_asset. Business justification: Settlement instructions for collateral delivery/receipt reference the specific collateral asset being transferred. CSDR settlement fail penalty tracking, custodian reconciliation, and collateral subst',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Trade settlement instructions must specify the custodian account for securities/cash delivery. Critical for DVP settlement processing, SWIFT MT54x message generation, and reconciliation between tradin',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Settlement instructions post cash and securities movements to specific GL accounts (nostro, DvP securities accounts). Direct FK enables automated GL posting, nostro reconciliation, and settlement acco',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: CSDR settlement discipline regime requires holiday calendar to calculate settlement fail duration, penalty amounts, and buy-in timelines. Settlement instructions must reference the applicable market h',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Settlement instructions (SWIFT MT54x) are issued for specific securities and must identify the instrument by ISIN for CSD matching and CSDR compliance. settlement_instruction has security_quantity but',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Settlement instructions are issued by a specific legal entity — required for entity-level settlement reporting, CSDR compliance, and legal entity cash/securities position reconciliation in banking ope',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Settlement counterparty LEI needed for regulatory reporting, sanctions screening, and KYC compliance. Reference LEI registry provides legal entity verification, jurisdiction, and regulatory status.',
    `liquidity_position_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_position. Business justification: Settlement instructions create contractual cash inflows/outflows that feed liquidity forecasting and LCR calculations. Required for settlement-driven liquidity forecasting, intraday liquidity monitori',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Settlement instructions for margin payments must reference the governing margin agreement to validate settlement terms (MTA, settlement currency, settlement cycle). Operations teams use this link to r',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity involved in this settlement instruction.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Settlement instructions for collateral movements (IM posting, VM delivery) are linked to the specific collateral pledge being settled. CSDR penalty tracking, settlement fail management, and collateral',
    `repo_position_id` BIGINT COMMENT 'Foreign key linking to treasury.repo_position. Business justification: Settlement instructions are generated for repo transactions tied to repo positions. Linking settlement_instruction to repo_position supports settlement efficiency, fail management for repo trades, and',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Every cross-border settlement instruction must be screened against OFAC/EU/UN sanctions lists before execution. Settlement instructions are the primary trigger for sanctions screening in trade operati',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Settlement currency drives payment routing, correspondent bank selection, and SWIFT message generation. Reference data provides settlement conventions, RTGS system codes, and currency restrictions.',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Settlement instructions should reference the trading book for operational routing (which desk/book is settling), reconciliation (matching settlements to book positions), and P&L attribution (settlemen',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Trade confirmations are tied to accounting periods for trade-date vs. settlement-date accounting under IFRS 9, period-end confirmation reconciliation, and regulatory reporting of unconfirmed trades by',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to trade.allocation. Business justification: Confirmations can be generated per allocation for allocated trades (each allocated account may receive a separate confirmation). This links confirmations to specific allocations for affirmation and ma',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Confirmation routing depends on counterparty BIC for SWIFT messaging, trade repository reporting, and affirmation platforms. Reference BIC directory provides institution connectivity and service profi',
    `capture_id` BIGINT COMMENT 'Reference to the underlying trade transaction that this confirmation documents. Links to the trade execution record in the trading system.',
    `counterparty_agreement_id` BIGINT COMMENT 'Reference to the ISDA master agreement governing the legal terms and conditions of OTC derivative transactions with this counterparty.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Trade confirmations (SWIFT MT3xx, MarkitWire, DTCC) must identify the specific instrument being confirmed. MiFID II confirmation requirements mandate instrument identification. confirmation has asset_',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Confirmations are executed by a specific legal entity — required for entity-level confirmation reporting, EMIR regulatory obligations, and legal entity-level unconfirmed trade exposure monitoring.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Confirmation counterparty LEI required for trade repository reporting, regulatory compliance, and counterparty matching. Reference registry provides legal entity name, jurisdiction, and ultimate paren',
    `margin_agreement_id` BIGINT COMMENT 'Reference to the Credit Support Annex that governs collateral posting requirements for this trade under the ISDA framework.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Confirmation currency must validate for counterparty matching, discrepancy resolution, and regulatory reporting. Reference currency master provides ISO codes and rounding rules for confirmation tolera',
    `party_id` BIGINT COMMENT 'Reference to the counterparty entity with whom this trade was executed and confirmed. Essential for counterparty risk management and exposure tracking.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: ISDA/FpML confirmation matching and EMIR regulatory reporting require product type classification on confirmations. product_type is a plain string denormalization; a proper FK enables automated confir',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Trade confirmations involving sanctioned counterparties trigger sanctions screening events. Regulatory audit trails require linking confirmations to screening outcomes to demonstrate compliance before',
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
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Trading book base currency drives P&L aggregation, VaR calculation, and FRTB regulatory capital reporting. base_currency is a plain string denormalization; a proper FK to currency ensures referential ',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Trading books require benchmark assignment for performance measurement (book P&L vs benchmark return), tracking error monitoring, benchmark-relative VaR limits, and investment mandate compliance. Stan',
    `cost_center_id` BIGINT COMMENT 'FK to ledger.cost_center',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Trading books are assigned FTP rates for internal funding cost allocation by ALCO. This link supports NIM contribution reporting, desk-level profitability, and liquidity cost allocation — a standard t',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: FRTB IMA approval, Volcker Rule compliance determination, and regulatory capital reporting require the jurisdiction governing the trading book. The regulatory_classification and ima_approval_status fi',
    `legal_entity_id` BIGINT COMMENT 'FK to ledger.legal_entity',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: A trading books aggregate positions are margined under specific margin agreements. FRTB capital reporting and internal limit monitoring require linking the trading book to its governing margin agreem',
    `monitoring_rule_id` BIGINT COMMENT 'Foreign key linking to compliance.monitoring_rule. Business justification: Trading books are governed by book-level surveillance monitoring rules (position limit monitoring, P&L threshold alerts, concentration monitoring). Linking books to monitoring rules enables automated ',
    `netting_set_id` BIGINT COMMENT 'Foreign key linking to collateral.netting_set. Business justification: A trading books positions may be grouped under a netting set for FRTB regulatory capital and SA-CCR EAD calculation. Capital adequacy reporting requires linking the trading book to its netting set to',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Trading books are subject to specific regulatory obligations (FRTB IMA/SA, Basel III capital requirements, Volcker Rule). Linking books to obligations enables automated compliance monitoring and regul',
    `parent_book_trading_book_id` BIGINT COMMENT 'Identifier of the parent trading book in the book hierarchy. Null if this is a top-level book. Used for hierarchical risk aggregation.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Trading books must operate under specific compliance policies (Volcker Rule, proprietary trading restrictions, market-making exemptions). The governing policy must be traceable from the book for regul',
    `profit_center_id` BIGINT COMMENT 'FK to ledger.profit_center',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Trading books are stress-tested under regulatory scenarios (CCAR, DFAST, EBA) for stress capital buffer calculations and recovery planning. Essential for FRTB and Pillar 2 capital.',
    `approval_status` STRING COMMENT 'Current approval status of the trading book setup or limit changes. Only approved books can be activated.. Valid values are `draft|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when this trading book or its limit framework was approved.',
    `asset_class` STRING COMMENT 'Primary asset class traded within this book. Determines applicable risk models, capital requirements, and regulatory treatment.. Valid values are `rates|credit|equity|fx|commodity|structured`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Unique identifier for the trade allocation record. Primary key for the trade allocation entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Block trade allocations must be mapped to accounting periods for accurate sub-account P&L reporting, financial close, and period-end allocation reconciliation. Banking operations require period attrib',
    `capture_id` BIGINT COMMENT 'Reference to the parent block trade that is being allocated across multiple accounts or sub-portfolios.',
    `allocation_capture_id` BIGINT COMMENT 'Reference to the underlying trade execution record from the trading system.',
    `broker_id` BIGINT COMMENT 'Reference to the broker responsible for clearing and settlement of this allocation.',
    `party_id` BIGINT COMMENT 'Reference to the custodian bank holding the securities for the allocated account, used for settlement instruction routing.',
    `allocation_executing_broker_id` BIGINT COMMENT 'Reference to the broker who executed the original block trade before allocation.',
    `allocation_give_up_broker_id` BIGINT COMMENT 'Reference to the broker receiving the give-up allocation in step-out workflows, where execution is transferred to another broker for clearing.',
    `allocation_party_id` BIGINT COMMENT 'Reference to the institutional client on whose behalf the allocation is made, used in prime brokerage and institutional trading.',
    `aml_case_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_case. Business justification: Block trade allocations to specific funds or accounts may be flagged in AML investigations (e.g., allocation manipulation, layering). Investigators need traceability from AML case to specific allocati',
    `branch_id` BIGINT COMMENT 'Reference to the trading desk responsible for the allocation, used for P&L (Profit and Loss) attribution and risk management.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Allocation currency needed for commission calculation, net settlement amount, and fund accounting. Reference currency master provides minor units, rounding rules, and settlement conventions.',
    `custodian_account_id` BIGINT COMMENT 'Foreign key linking to wealth.custodian_account. Business justification: Block trade allocations specify the custodian account for securities delivery. The allocation record must reference the custodian_account to generate settlement instructions and custody notifications.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Block trade allocations to institutional investors in IPOs/secondaries require deal linkage for IPO allocation management, greenshoe exercise tracking, allocation fairness reviews, and regulatory fili',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: An allocation distributes a block trade execution across multiple accounts, funds, or portfolios. The direct FK from allocation to execution (the specific fill being allocated) is essential for TCA (T',
    `fund_id` BIGINT COMMENT 'Reference to the investment fund receiving this allocation, used in asset management and wealth management contexts.',
    `instrument_id` BIGINT COMMENT 'Reference to the financial instrument (security, derivative, FX (Foreign Exchange) contract) being allocated.',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.mandate. Business justification: Allocations under advisory mandates (managed account trades, discretionary portfolio management) require mandate tracking for mandate compliance verification, discretionary trading authorization, suit',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Block trade allocations in fund management are distributed to specific investor accounts. The allocation must reference the investor account to determine the correct unit register entry, tax lot metho',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Allocations to specific accounts require KYC verification of the receiving party. MiFID II suitability and appropriateness requirements mandate traceability from allocation to KYC review status of the',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Allocations are made to/from legal entities — required for entity-level position reporting, regulatory capital attribution, and legal entity-level trade allocation audit trails under EMIR and MiFIR.',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Block trade allocations distribute executed trades across managed portfolios. The allocation record must reference the target managed_portfolio for P&L attribution, compliance checking against investm',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Block orders are allocated post-execution across multiple accounts/funds. The allocation should reference the original order for audit trail, order management context, and regulatory reporting (linkin',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to collateral.collateral_pledge. Business justification: Prime brokerage block trade allocations to funds/accounts require specific collateral pledges to secure the allocated position. The allocation determines which pledge covers the allocated trade, essen',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Post-trade allocation reporting, fee calculation by product type, and regulatory transaction reporting require product type classification on allocations. product_type is a plain string denormalizatio',
    `sanctions_screening_event_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_event. Business justification: Allocations to specific accounts or parties require sanctions screening. OFAC compliance and MiFID II suitability requirements mandate traceability from allocation to sanctions screening outcome befor',
    `settlement_instruction_id` BIGINT COMMENT 'Reference to the settlement instruction record specifying how this allocation will settle, including delivery versus payment (DVP) details.',
    `syndication_id` BIGINT COMMENT 'Foreign key linking to investment.investment_syndication. Business justification: Investor allocations in syndicated transactions are managed through the syndication process. Linking allocation to investment_syndication enables syndication desk to track which allocations belong to ',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading book where the allocation is recorded for regulatory capital and risk reporting under FRTB (Fundamental Review of the Trading Book).',
    `tranche_id` BIGINT COMMENT 'Foreign key linking to investment.tranche. Business justification: Syndicated loan allocations correspond to specific tranches (senior secured, mezzanine). Tranche determines allocated pricing and seniority. Loan syndication desks track allocations by tranche for lea',
    `transaction_structure_id` BIGINT COMMENT 'Foreign key linking to investment.transaction_structure. Business justification: Capital markets block trade allocations (IPOs, bond offerings) are governed by transaction structure determining Rule 144A vs Reg S eligibility, tranche seniority, and fee calculations. Allocation tea',
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

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`trade_fee` (
    `trade_fee_id` BIGINT COMMENT 'Unique identifier for the trade fee record. Primary key for the trade fee entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Fees are accrued/recognized in accounting periods for period-end accrual and revenue recognition. Essential for financial close and revenue reporting.',
    `allocation_id` BIGINT COMMENT 'Foreign key linking to trade.allocation. Business justification: Fees can be allocated across multiple accounts/funds (e.g., block trade commission allocated pro-rata). This links fees to specific allocations, allowing fee allocation and billing per account/fund.',
    `broker_id` BIGINT COMMENT 'Reference to the executing broker associated with the fee. Relevant for brokerage commission and best execution analysis.',
    `capture_id` BIGINT COMMENT 'Reference to the parent trade transaction to which this fee applies. Links fee to the underlying trade execution.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or business unit to which the fee is charged. Supports management accounting and cost allocation.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee currency validation required for accrual, invoicing, payment processing, and P&L attribution. Reference data provides currency attributes for fee calculation and cost allocation.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Trade fees (brokerage commissions, exchange fees, clearing fees) are debited from a client deposit account. Fee settlement operations require identifying the specific deposit account to charge. Bankin',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Execution fees (broker commissions, exchange fees, clearing fees) are incurred at execution time, not just at capture. This allows fee tracking per fill, which is critical for transaction cost analysi',
    `fee_arrangement_id` BIGINT COMMENT 'Reference to the master fee agreement or commission schedule governing this fee. Links to contractual terms and rate cards.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Trade fees post to specific GL accounts for automated fee accrual and GL posting. The existing plain attribute gl_account_code is a denormalization of gl_account. Direct FK enables automated GL postin',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Withholding tax calculation and stamp duty assessment on trade fees require the applicable tax jurisdiction. Cross-border fee tax reporting (CRS, FATCA) and tax treaty application depend on identifyin',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Trade fees must be attributed to a legal entity for entity-level cost reporting, transfer pricing documentation, and regulatory capital allocation. Banking operations require entity-level fee expense ',
    `managed_portfolio_id` BIGINT COMMENT 'Foreign key linking to wealth.managed_portfolio. Business justification: Trade execution fees (commissions, exchange fees, clearing fees) must be allocated to wealth portfolios for accurate net performance calculation and fee disclosure under MiFID II. Enables portfolio-le',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Fee arrangements (inducements, soft commissions, research payments) are subject to MiFID II inducement rules and other regulatory obligations. Linking fees to obligations enables automated compliance ',
    `party_id` BIGINT COMMENT 'Reference to the counterparty or broker to whom the fee is paid or from whom it is received. Links to party master for Legal Entity Identifier (LEI) and regulatory reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Trade fees are allocated to profit centers for desk-level P&L reporting and management accounting. Banking operations require profit center attribution of all fee expenses for RAROC calculations and b',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_filing. Business justification: Certain fees (inducements, research payments under MiFID II RTS 28) require regulatory disclosure filings. Traceability from trade fee to regulatory filing is required for MiFID II compliance and regu',
    `settlement_instruction_id` BIGINT COMMENT 'Foreign key linking to trade.settlement_instruction. Business justification: Settlement fees (custodian fees, CSD fees, CSDR penalties) are associated with settlement instructions. This is a missing link for post-trade fee tracking. Currently trade_fee only links to capture, b',
    `trading_book_id` BIGINT COMMENT 'Reference to the trading book or portfolio to which the fee is allocated. Supports Profit and Loss (P&L) attribution and desk-level cost analysis.',
    `underwriting_id` BIGINT COMMENT 'Foreign key linking to investment.underwriting. Business justification: Underwriting fees (management fees, selling concessions, underwriting discounts) are recorded as trade fees and must reference the underwriting agreement for IFRS 15 revenue recognition and regulatory',
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

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`counterparty_agreement` (
    `counterparty_agreement_id` BIGINT COMMENT 'Unique identifier for the counterparty trading agreement record. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Agreement base currency defines threshold amounts, minimum transfer amounts, and collateral valuation for CSA/ISDA agreements. Reference data provides FX rates and currency attributes for margin calcu',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: ISDA/CSA agreements reference counterparty credit ratings for threshold calculations, collateral triggers, and credit rating downgrade provisions. Core to bilateral credit risk management.',
    `deal_id` BIGINT COMMENT 'Foreign key linking to investment.deal. Business justification: Bespoke ISDA/CSA agreements negotiated for specific investment banking deals (e.g., M&A derivative hedges, structured finance) must be linked to the deal for deal-level legal documentation tracking, d',
    `investment_mandate_id` BIGINT COMMENT 'Foreign key linking to investment.investment_mandate. Business justification: Investment mandates require specific counterparty agreements (ISDA/CSA) to be in place before trading commences. Linking counterparty_agreement to investment_mandate enables mandate compliance checkin',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: ISDA master agreement netting enforceability opinions and Basel III credit risk mitigation recognition require the governing jurisdiction. Netting enforceability under Basel III CRR Article 295 is jur',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: EMIR/MiFID II require counterparty agreements to be backed by a current KYC record. Compliance teams must verify KYC status before executing ISDA/CSA agreements. A banking expert would expect this dir',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: KYC review of the counterparty is mandatory before executing an ISDA/CSA/GMRA agreement. The agreement lifecycle (activation, suspension, termination) depends on KYC status; regulators expect this tra',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the bank legal entity that is party to this agreement.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Agreement counterparty LEI validation required for credit risk reporting, netting set identification, and regulatory compliance. Reference registry provides legal entity details and relationship hiera',
    `party_id` BIGINT COMMENT 'Identifier of the external counterparty party to this agreement.',
    `previous_counterparty_agreement_id` BIGINT COMMENT 'Self-referencing FK on counterparty_agreement (previous_counterparty_agreement_id)',
    `risk_rating_id` BIGINT COMMENT 'Foreign key linking to customer.risk_rating. Business justification: Counterparty agreement terms (threshold amounts, minimum transfer amounts, credit triggers) are set based on the counterpartys risk rating. Credit risk teams must link the prevailing risk rating to e',
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

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`broker` (
    `broker_id` BIGINT COMMENT 'Unique identifier for the broker entity. Primary key for the broker master registry.',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Broker BIC must validate against SWIFT directory for payment routing, securities settlement, and give-up processing. Reference data provides institution details, regulatory status, and service capabil',
    `clearing_house_id` BIGINT COMMENT 'Identifier of the central counterparty (CCP) or clearing house through which this broker clears trades.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Broker commission currency validation required for cost accrual, payment processing, and commission schedule management. Reference data provides currency attributes for broker payment instructions.',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Broker credit risk management requires formal counterparty ratings for credit limit monitoring, prime brokerage exposure reporting, and Basel III counterparty credit risk capital (SA-CCR). The existin',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: MiFID II best execution reporting and broker regulatory compliance monitoring require the regulatory jurisdiction of the broker. primary_regulator is a plain string; jurisdiction FK enables automated ',
    `kyc_record_id` BIGINT COMMENT 'Foreign key linking to customer.kyc_record. Business justification: Broker due diligence requires a formal KYC record per AML regulations. broker.kyc_review_id links to compliance.kyc_review (a different product); customer.kyc_record holds the party-level KYC assessme',
    `kyc_review_id` BIGINT COMMENT 'Foreign key linking to compliance.kyc_review. Business justification: Brokers undergo KYC due diligence as counterparties before onboarding. Banks link broker entities to KYC reviews for periodic refresh, sanctions screening, and AML risk assessment - mandatory counterp',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Brokers are engaged by a specific legal entity for regulatory reporting and entity-level commission expense tracking. Banking operations require entity-level broker relationship management for regulat',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: MiFID II transaction reporting and EMIR reporting mandate broker LEI identification. Broker has no lei_registry_id currently; LEI is a mandatory field in regulatory trade reports submitted to trade re',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: Prime brokers and executing brokers operate under specific margin agreements governing client collateral requirements. Credit risk management and prime brokerage operations require linking each broker',
    `onboarding_case_id` BIGINT COMMENT 'Foreign key linking to customer.onboarding_case. Business justification: Broker onboarding is a formal bank process tracked via onboarding_case (AML screening, KYC, credit checks). Linking broker to its onboarding case allows operations teams to track onboarding completion',
    `parent_broker_id` BIGINT COMMENT 'Self-referencing FK on broker (parent_broker_id)',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Brokers are external counterparties requiring KYC/AML compliance, credit limit monitoring, sanctions screening, and regulatory reporting. Banks must maintain brokers as parties in customer domain for ',
    `aml_screening_status` STRING COMMENT 'Result of Anti-Money Laundering (AML) screening against sanctions lists and watchlists: cleared (no matches), flagged (potential match requiring review), pending (screening in progress), or not screened.. Valid values are `cleared|flagged|pending|not_screened`',
    `broker_code` STRING COMMENT 'Internal business identifier or mnemonic code assigned to the broker for operational reference and reporting purposes.',
    `broker_status` STRING COMMENT 'Current operational status of the broker relationship: active (approved for trading), inactive (not currently used), suspended (temporarily restricted), pending approval (under review), or terminated (relationship ended).. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `broker_type` STRING COMMENT 'Classification of the broker based on the primary service provided: executing broker (trade execution), prime broker (financing and custody), clearing broker (post-trade clearing), introducing broker (client referral), custodian broker (asset custody), or agency broker (agent capacity).. Valid values are `executing_broker|prime_broker|clearing_broker|introducing_broker|custodian_broker|agency_broker`',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or operational remarks related to the broker relationship.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the broker record was first created in the system, used for audit trail and data lineage purposes.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure or trading limit approved for this broker, used for risk management and exposure monitoring.',
    `credit_limit_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the credit limit is denominated.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `banking_ecm`.`trade`.`clearing_house` (
    `clearing_house_id` BIGINT COMMENT 'Primary key for clearing_house',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: SWIFT messaging for margin calls, variation margin payments, and settlement instructions to CCPs requires the BIC directory entry for the clearing house. bic_code is a plain string denormalization; FK',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Basel III CCP exposure rules (CRR Article 301-311) require rating-based risk weighting of CCP exposures. Linking clearing_house to counterparty_rating supports CCP credit risk capital calculation, QCC',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: CCP regulatory oversight, EMIR Article 25 third-country CCP recognition, and QCCP status determination require the country of the clearing house. headquarters_country is a plain string; country_id FK ',
    `haircut_schedule_id` BIGINT COMMENT 'Foreign key linking to collateral.haircut_schedule. Business justification: CCPs publish and enforce specific haircut schedules for eligible collateral posted by clearing members. Linking clearing_house to its haircut_schedule is required for pre-trade margin estimation, coll',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: EMIR Article 25 third-country CCP recognition and QCCP status for Basel III regulatory capital treatment require the regulatory jurisdiction of the clearing house. jurisdiction is a plain string denor',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: EMIR reporting and QCCP regulatory capital treatment require the LEI of the clearing house. lei_code is a plain string denormalization; FK to lei_registry provides the authoritative LEI record for reg',
    `margin_agreement_id` BIGINT COMMENT 'Foreign key linking to collateral.margin_agreement. Business justification: CCPs formalize their margin frameworks (initial margin methodology, eligible collateral, haircuts) in margin agreements with clearing members. Linking clearing_house to its governing margin agreement ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Clearing houses are subject to specific regulatory obligations (EMIR CCP requirements, Dodd-Frank DCO rules, default fund requirements). Linking clearing house records to obligations enables complianc',
    `parent_clearing_house_id` BIGINT COMMENT 'Self-referencing FK on clearing_house (parent_clearing_house_id)',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Clearing houses are subject to regulatory examination by CFTC, ESMA, and Bank of England. Linking clearing house records to regulatory exams enables exam management and traceability of examination fin',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: CCP margin call processing, variation margin calculations, and default fund contribution management require the settlement currency of the clearing house. settlement_currency is a plain string denorma',
    `address_line_1` STRING COMMENT 'Primary street address line for the clearing house headquarters.',
    `address_line_2` STRING COMMENT 'Secondary street address line for the clearing house headquarters (suite, floor, building).',
    `clearing_house_code` STRING COMMENT 'Unique external code or identifier assigned to the clearing house by regulatory or industry bodies.',
    `clearing_house_name` STRING COMMENT 'Full legal name of the clearing house organization.',
    `clearing_house_status` STRING COMMENT 'Current operational status of the clearing house in the trading and settlement ecosystem.',
    `clearing_house_type` STRING COMMENT 'Classification of the clearing house based on the asset classes and services it provides.',
    `clearing_model` STRING COMMENT 'The clearing and settlement model employed by the clearing house.',
    `connectivity_protocol` STRING COMMENT 'Primary technical connectivity protocol used for trade submission and clearing (e.g., FIX, SWIFT, proprietary API).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearing house record was first created in the system.',
    `default_fund_required` BOOLEAN COMMENT 'Indicates whether clearing members are required to contribute to a default fund or guarantee fund.',
    `effective_date` DATE COMMENT 'Date when the clearing house became operational or was added to the reference data system.',
    `email_address` STRING COMMENT 'Primary contact email address for the clearing house.',
    `headquarters_city` STRING COMMENT 'City where the clearing house headquarters is located.',
    `last_review_date` DATE COMMENT 'Date when the clearing house reference data was last reviewed and validated.',
    `margin_model` STRING COMMENT 'The margin calculation methodology used by the clearing house for risk management.',
    `membership_required` BOOLEAN COMMENT 'Indicates whether direct membership is required to clear trades through this clearing house.',
    `mic_code` STRING COMMENT 'ISO 10383 four-character Market Identifier Code uniquely identifying the clearing house in global markets.',
    `minimum_capital_requirement` DECIMAL(18,2) COMMENT 'Minimum capital requirement for clearing members in the settlement currency.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the clearing house record was last modified in the system.',
    `netting_eligible` BOOLEAN COMMENT 'Indicates whether the clearing house supports multilateral netting of trades.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and validation of clearing house reference data.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the clearing house.',
    `operating_hours` STRING COMMENT 'Standard operating hours of the clearing house, including time zone.',
    `parent_organization` STRING COMMENT 'Name of the parent company or holding entity that owns or operates the clearing house.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the clearing house.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the clearing house headquarters address.',
    `primary_regulator` STRING COMMENT 'Name of the primary regulatory body overseeing the clearing house operations.',
    `regulatory_status` STRING COMMENT 'Regulatory authorization status of the clearing house with relevant financial authorities.',
    `settlement_cycle` STRING COMMENT 'Standard settlement cycle for trades cleared through this clearing house (e.g., T+0, T+1, T+2).',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name of the clearing house for operational reference.',
    `supported_asset_classes` STRING COMMENT 'Comma-separated list of asset classes supported by the clearing house (e.g., equities, fixed income, derivatives, commodities, FX).',
    `termination_date` DATE COMMENT 'Date when the clearing house ceased operations or was decommissioned. Null if still active.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the clearing house operational time zone.',
    `trade_reporting_required` BOOLEAN COMMENT 'Indicates whether trades cleared through this clearing house must be reported to trade repositories.',
    `website_url` STRING COMMENT 'Official website URL of the clearing house.',
    CONSTRAINT pk_clearing_house PRIMARY KEY(`clearing_house_id`)
) COMMENT 'Master reference table for clearing_house. Referenced by clearing_house_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_parent_order_id` FOREIGN KEY (`parent_order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`order` ADD CONSTRAINT `fk_trade_order_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_clearing_house_id` FOREIGN KEY (`clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`execution` ADD CONSTRAINT `fk_trade_execution_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`capture` ADD CONSTRAINT `fk_trade_capture_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_clearing_house_id` FOREIGN KEY (`clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ADD CONSTRAINT `fk_trade_trade_position_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_trade_position_id` FOREIGN KEY (`trade_position_id`) REFERENCES `banking_ecm`.`trade`.`trade_position`(`trade_position_id`);
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ADD CONSTRAINT `fk_trade_mtm_valuation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ADD CONSTRAINT `fk_trade_settlement_instruction_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `banking_ecm`.`trade`.`allocation`(`allocation_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_counterparty_agreement_id` FOREIGN KEY (`counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ADD CONSTRAINT `fk_trade_confirmation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ADD CONSTRAINT `fk_trade_trading_book_parent_book_trading_book_id` FOREIGN KEY (`parent_book_trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_capture_id` FOREIGN KEY (`allocation_capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_executing_broker_id` FOREIGN KEY (`allocation_executing_broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_allocation_give_up_broker_id` FOREIGN KEY (`allocation_give_up_broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_order_id` FOREIGN KEY (`order_id`) REFERENCES `banking_ecm`.`trade`.`order`(`order_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`trade`.`allocation` ADD CONSTRAINT `fk_trade_allocation_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_allocation_id` FOREIGN KEY (`allocation_id`) REFERENCES `banking_ecm`.`trade`.`allocation`(`allocation_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_capture_id` FOREIGN KEY (`capture_id`) REFERENCES `banking_ecm`.`trade`.`capture`(`capture_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_execution_id` FOREIGN KEY (`execution_id`) REFERENCES `banking_ecm`.`trade`.`execution`(`execution_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_settlement_instruction_id` FOREIGN KEY (`settlement_instruction_id`) REFERENCES `banking_ecm`.`trade`.`settlement_instruction`(`settlement_instruction_id`);
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ADD CONSTRAINT `fk_trade_trade_fee_trading_book_id` FOREIGN KEY (`trading_book_id`) REFERENCES `banking_ecm`.`trade`.`trading_book`(`trading_book_id`);
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ADD CONSTRAINT `fk_trade_counterparty_agreement_previous_counterparty_agreement_id` FOREIGN KEY (`previous_counterparty_agreement_id`) REFERENCES `banking_ecm`.`trade`.`counterparty_agreement`(`counterparty_agreement_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_clearing_house_id` FOREIGN KEY (`clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);
ALTER TABLE `banking_ecm`.`trade`.`broker` ADD CONSTRAINT `fk_trade_broker_parent_broker_id` FOREIGN KEY (`parent_broker_id`) REFERENCES `banking_ecm`.`trade`.`broker`(`broker_id`);
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ADD CONSTRAINT `fk_trade_clearing_house_parent_clearing_house_id` FOREIGN KEY (`parent_clearing_house_id`) REFERENCES `banking_ecm`.`trade`.`clearing_house`(`clearing_house_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`trade` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `banking_ecm`.`trade` SET TAGS ('dbx_domain' = 'trade');
ALTER TABLE `banking_ecm`.`trade`.`order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Order Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Order Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Session Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `parent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Order Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `banking_ecm`.`trade`.`order` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`execution` SET TAGS ('dbx_subdomain' = 'execution_settlement');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `broker_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Markets Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Security ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Redemption Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Syndication Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `underwriting_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `best_execution_venue_rank` SET TAGS ('dbx_business_glossary_term' = 'Best Execution Venue Rank');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `capacity` SET TAGS ('dbx_business_glossary_term' = 'Execution Capacity');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `capacity` SET TAGS ('dbx_value_regex' = 'principal|agency|riskless_principal|matched_principal');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `clearing_fee` SET TAGS ('dbx_business_glossary_term' = 'Clearing Fee');
ALTER TABLE `banking_ecm`.`trade`.`execution` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
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
ALTER TABLE `banking_ecm`.`trade`.`capture` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`capture` SET TAGS ('dbx_subdomain' = 'execution_settlement');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `pledge_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Agreement ID');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `transaction_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Maturity Date');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `notional_amount` SET TAGS ('dbx_business_glossary_term' = 'Notional Amount');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Trade Price');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Re-Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_amount` SET TAGS ('dbx_business_glossary_term' = 'Trade Amount');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Execution Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `trade_version` SET TAGS ('dbx_business_glossary_term' = 'Trade Version Number');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `usi` SET TAGS ('dbx_business_glossary_term' = 'Unique Swap Identifier (USI)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `uti` SET TAGS ('dbx_business_glossary_term' = 'Unique Transaction Identifier (UTI)');
ALTER TABLE `banking_ecm`.`trade`.`capture` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` SET TAGS ('dbx_subdomain' = 'position_valuation');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Position Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Position Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `fund_class_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Class Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `interest_rate_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `investment_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_position` ALTER COLUMN `subledger_id` SET TAGS ('dbx_business_glossary_term' = 'Subledger Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` SET TAGS ('dbx_subdomain' = 'position_valuation');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `mtm_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `benchmark_rate_fixing_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Rate Fixing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Desk ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `exchange_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `factor_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Factor Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `fund_holding_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Holding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `investment_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Valuation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `rate_benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Discount Curve ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `trade_position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Book ID');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `transaction_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`mtm_valuation` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` SET TAGS ('dbx_subdomain' = 'execution_settlement');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Bic Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `collateral_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Asset Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `liquidity_position_id` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `repo_position_id` SET TAGS ('dbx_business_glossary_term' = 'Repo Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`settlement_instruction` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`confirmation` SET TAGS ('dbx_subdomain' = 'execution_settlement');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `confirmation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Confirmation Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Bic Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Notional Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`confirmation` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`trading_book` SET TAGS ('dbx_subdomain' = 'position_valuation');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book ID');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `netting_set_id` SET TAGS ('dbx_business_glossary_term' = 'Netting Set Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `parent_book_trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Trading Book ID');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `banking_ecm`.`trade`.`trading_book` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'rates|credit|equity|fx|commodity|structured');
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
ALTER TABLE `banking_ecm`.`trade`.`allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`allocation` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Allocation Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Block Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_executing_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Executing Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_give_up_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Give-Up Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `allocation_party_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `aml_case_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `custodian_account_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Collateral Pledge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `sanctions_screening_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `syndication_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Syndication Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `tranche_id` SET TAGS ('dbx_business_glossary_term' = 'Tranche Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `transaction_structure_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Structure Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reference Number');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `side` SET TAGS ('dbx_business_glossary_term' = 'Trade Side');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `side` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `banking_ecm`.`trade`.`allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `trade_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Fee Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Agreement Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `managed_portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Portfolio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Filing Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `settlement_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`trade_fee` ALTER COLUMN `underwriting_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `investment_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Counterparty Lei Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `previous_counterparty_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`counterparty_agreement` ALTER COLUMN `risk_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`broker` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Bic Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier (ID)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Record Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `kyc_review_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Review Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `onboarding_case_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Case Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `parent_broker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`broker` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Party Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` SET TAGS ('dbx_subdomain' = 'execution_settlement');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `clearing_house_id` SET TAGS ('dbx_business_glossary_term' = 'Clearing House Identifier');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `haircut_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Haircut Schedule Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `margin_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Margin Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `parent_clearing_house_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`trade`.`clearing_house` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Id (Foreign Key)');
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
