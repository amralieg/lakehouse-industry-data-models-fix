-- Schema for Domain: trading | Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:06

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `energy_utilities_ecm`.`trading` COMMENT 'Wholesale energy trading, power purchase agreements, bilateral contracts, day-ahead and real-time market participation, LMP pricing, scheduling coordinators, ancillary services procurement, and ETRM position management via OpenLink Endur. Manages market settlements, congestion revenue rights, FTR holdings, counterparty credit exposure, REC tracking, and ISO/RTO interface for energy transactions. Supports FERC market reporting and NAESB scheduling.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`trade` (
    `trade_id` BIGINT COMMENT 'Unique identifier for the wholesale energy trade transaction. Primary key for the trade entity.',
    `book_id` BIGINT COMMENT 'FK to trading.trading_book',
    `der_system_id` BIGINT COMMENT 'Foreign key linking to interconnection.der_system. Business justification: Energy trades involving DER systems as delivery sources require tracking for settlement, scheduling coordinator reporting, and ISO/RTO compliance. Critical for virtual power plant aggregation, DER mar',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Trades are priced and valued using forward LMP forecasts at delivery points. Hedging decisions, mark-to-market valuation, and trade approval workflows require linking trades to the price forecast scen',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Trades must comply with specific regulatory obligations (FERC EQR reporting, NERC reliability standards, market manipulation rules). Compliance officers trace trades to governing obligations for audit',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Physical power trades specify a pricing node for LMP-based settlement. FERC EQR reporting, trade settlement, and position management all require a valid pnode reference. lmp_pricing_node is a denormal',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: REC trading: renewable energy certificate trades must reference the originating PPA contract to verify vintage year, technology type, RPS eligibility tier, and tracking system serial numbers required ',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: Physical energy trades reference specific generation or transmission assets for delivery scheduling, settlement validation, and asset utilization tracking. Critical for reconciling financial trades wi',
    `scheduling_coordinator_id` BIGINT COMMENT 'Identifier of the Scheduling Coordinator (SC) responsible for submitting schedules to the ISO/RTO for this trade. Required for ISO/RTO market transactions.',
    `counterparty_id` BIGINT COMMENT 'FK to trading.counterparty.counterparty_id — Every trade has a counterparty. This is a fundamental master-transaction relationship required for credit exposure calculation, settlement, and FERC EQR reporting.',
    `trade_broker_counterparty_id` BIGINT COMMENT 'Identifier of the intermediary broker who facilitated the trade, if applicable. Null for direct bilateral or exchange trades.',
    `trade_counterparty_id` BIGINT COMMENT 'FK to trading.counterparty.counterparty_id — Every trade has a counterparty. This FK is essential for credit exposure calculation, ISDA netting, and FERC EQR reporting. Without it, credit risk management is impossible.',
    `ancillary_service_type` STRING COMMENT 'Type of ancillary service procured if the trade is for grid support services: regulation, spinning reserve, non-spinning reserve, voltage support, or black start. Null for energy-only trades. [ENUM-REF-CANDIDATE: regulation|spinning_reserve|non_spinning_reserve|voltage_support|black_start|frequency_response|reactive_power — promote to reference product]',
    `collateral_posted` DECIMAL(18,2) COMMENT 'Amount of collateral posted by the counterparty to secure this trade under the master agreement credit provisions.',
    `commodity` STRING COMMENT 'The energy commodity being traded: electric power, natural gas, Renewable Energy Certificate (REC), capacity, ancillary services, or Financial Transmission Right (FTR).. Valid values are `power|gas|rec|capacity|ancillary_services|ftr`',
    `confirmation_method` STRING COMMENT 'The mechanism used to confirm the trade with the counterparty: International Swaps and Derivatives Association (ISDA) agreement, broker confirmation, electronic platform, manual process, or exchange clearing.. Valid values are `isda|broker|electronic|manual|exchange`',
    `confirmation_status` STRING COMMENT 'Status of the trade confirmation workflow: unconfirmed (awaiting counterparty acknowledgment), confirmed (both parties agree), disputed (discrepancy identified), or resolved (dispute settled).. Valid values are `unconfirmed|confirmed|disputed|resolved`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Date and time when the trade was confirmed by the counterparty. Null if trade remains unconfirmed.',
    `counterparty_acknowledgment_received` BOOLEAN COMMENT 'Boolean flag indicating whether formal acknowledgment of the trade has been received from the counterparty. True if received, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the trade record was first created in the ETRM system. Used for audit trail and data lineage.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'The current credit exposure to the counterparty resulting from this trade, calculated based on mark-to-market valuation and collateral posted. Used for credit risk management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the trade price and settlement amounts.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `deal_number` STRING COMMENT 'External business identifier for the trade as recorded in the Energy Trading and Risk Management (ETRM) system. Used for cross-system reconciliation and counterparty communication.',
    `delivery_end_date` DATE COMMENT 'The final date on which physical delivery or financial settlement of the commodity is completed.',
    `delivery_point` STRING COMMENT 'Physical or financial location where the commodity is delivered. For power: Pricing Node (PNode) or hub. For gas: pipeline interconnect or city gate.',
    `delivery_start_date` DATE COMMENT 'The first date on which physical delivery or financial settlement of the commodity begins.',
    `discrepancy_details` STRING COMMENT 'Free-text description of any discrepancies identified during the confirmation process, such as quantity mismatches, price differences, or delivery point errors. Null if no discrepancies exist.',
    `execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the trade was executed in the trading system. Critical for Day-Ahead Market (DAM) and Real-Time Market (RTM) sequencing and audit trails.',
    `ferc_reporting_category` STRING COMMENT 'Classification of the trade for FERC Form 552 reporting purposes: short-term sales, long-term sales, purchases for resale, or other categories. Null if not subject to FERC reporting. [ENUM-REF-CANDIDATE: short_term_sales|long_term_sales|purchases_for_resale|transmission_services|ancillary_services|other — promote to reference product]',
    `internal_notes` STRING COMMENT 'Free-text field for internal trading desk notes, strategy rationale, or special instructions related to the trade. Not shared with counterparties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the trade record was last updated. Tracks amendments, status changes, and data corrections.',
    `market_type` STRING COMMENT 'Classification of the market in which the trade was executed: Day-Ahead Market (DAM), Real-Time Market (RTM), term contract, or spot market.. Valid values are `day_ahead|real_time|term|spot`',
    `modified_by_user` STRING COMMENT 'Identifier of the system user who last modified the trade record. Used for audit trail and accountability.',
    `price` DECIMAL(18,2) COMMENT 'Unit price of the commodity. For power: dollars per MWh. For gas: dollars per MMBtu. Represents the agreed-upon price at trade execution.',
    `quantity` DECIMAL(18,2) COMMENT 'Volume of the commodity traded. For power: Megawatt-hours (MWh). For gas: Million British Thermal Units (MMBtu). For RECs: certificate count.',
    `rec_tracking_system_code` STRING COMMENT 'Identifier from the regional REC tracking system (e.g., WREGIS, M-RETS, PJM-GATS) for REC trades. Null for non-REC trades.',
    `rec_vintage_year` STRING COMMENT 'The year in which the renewable energy was generated for Renewable Energy Certificate (REC) trades. Used for Renewable Portfolio Standard (RPS) compliance tracking. Null for non-REC trades.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this trade must be reported to regulatory authorities such as Federal Energy Regulatory Commission (FERC) or state Public Utility Commissions (PUCs). True if reporting required, False otherwise.',
    `settlement_method` STRING COMMENT 'Indicates how the trade will be settled: physical delivery of the commodity, financial settlement based on market price, or cash payment.. Valid values are `physical|financial|cash`',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the trade calculated as quantity multiplied by price. Represents the gross settlement amount before adjustments.',
    `trade_date` DATE COMMENT 'The calendar date on which the trade was executed and agreed upon by both parties.',
    `trade_status` STRING COMMENT 'Current lifecycle state of the trade: pending confirmation, confirmed by counterparty, amended after execution, cancelled before settlement, settled and closed, or voided due to error.. Valid values are `pending|confirmed|amended|cancelled|settled|voided`',
    `trade_type` STRING COMMENT 'Indicates whether the utility is buying or selling the commodity in this transaction.. Valid values are `buy|sell`',
    `transaction_category` STRING COMMENT 'Classification of the trade execution method: bilateral contract, exchange-traded, over-the-counter (OTC), Independent System Operator (ISO) or Regional Transmission Organization (RTO) market, or Power Purchase Agreement (PPA).. Valid values are `bilateral|exchange|otc|iso_rto|ppa`',
    `unit_of_measure` STRING COMMENT 'The unit in which the trade quantity is expressed: Megawatt-hour (MWh), Million British Thermal Units (MMBtu), Megawatt (MW), certificates, or rights.. Valid values are `MWh|MMBtu|MW|certificates|rights`',
    CONSTRAINT pk_trade PRIMARY KEY(`trade_id`)
) COMMENT 'Core master record for every wholesale energy trade executed by the utility, capturing bilateral, exchange-traded, and OTC transactions for power, gas, and RECs. Sourced from OpenLink Endur position management. Stores trade type (buy/sell), commodity, quantity in MWh/MMBtu, price, currency, trade date, execution timestamp, trader ID, book, counterparty, and trade status lifecycle (confirmed, amended, cancelled). Includes confirmation workflow tracking: confirmation method (ISDA, broker, electronic), confirmation status, discrepancy details, and counterparty acknowledgment. SSOT for all trade identity and confirmation state within the trading domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`trade_leg` (
    `trade_leg_id` BIGINT COMMENT 'Unique identifier for the individual trade leg within a multi-leg wholesale energy transaction. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity on the opposite side of this leg. Critical for credit exposure monitoring and settlement.',
    `trade_id` BIGINT COMMENT 'Reference to the parent wholesale energy trade transaction that this leg belongs to. A single trade may contain multiple legs representing different delivery periods, pricing structures, or settlement mechanisms.',
    `scheduling_coordinator_id` BIGINT COMMENT 'The identifier of the scheduling coordinator responsible for submitting energy schedules to the ISO/RTO for this leg. Required for physical delivery legs.',
    `to_trade_id` BIGINT COMMENT 'FK to trading.trade.trade_id — Every trade leg must reference its parent trade. This is the fundamental header→line relationship in the trading domain. Without this FK, trade legs are orphaned and cannot be aggregated to the trade ',
    `ancillary_services_included` BOOLEAN COMMENT 'Indicates whether this leg includes procurement of ancillary services such as regulation, spinning reserves, or voltage support required for grid reliability.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this trade leg was approved for execution by authorized personnel.',
    `approved_by_user` STRING COMMENT 'The username or identifier of the supervisor or risk manager who approved this trade leg for execution.',
    `booking_entity` STRING COMMENT 'The legal entity or business unit within the utility that booked this trade leg. Used for regulatory reporting and internal profit/loss attribution.',
    `collateral_requirement_amount` DECIMAL(18,2) COMMENT 'The amount of collateral required to be posted by the counterparty to secure performance on this leg, based on credit exposure and credit terms.',
    `congestion_revenue_rights_quantity` DECIMAL(18,2) COMMENT 'The quantity of Congestion Revenue Rights or Financial Transmission Rights associated with this leg, used to hedge transmission congestion costs.',
    `created_by_user` STRING COMMENT 'The username or identifier of the trader or system user who created this trade leg record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this trade leg record was first created in the Energy Trading and Risk Management (ETRM) system.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'The calculated credit exposure or mark-to-market value of this leg, used for counterparty credit risk management and collateral determination.',
    `delivery_end_date` DATE COMMENT 'The final date on which physical delivery or financial settlement obligations conclude for this leg. Used to determine the legs active period.',
    `delivery_point_hub` STRING COMMENT 'The trading hub or aggregated pricing zone for delivery. Hubs represent weighted averages of multiple PNodes and are commonly used in bilateral contracts.',
    `delivery_point_pnode` STRING COMMENT 'The specific pricing node or delivery location where physical energy is delivered or financially settled. PNodes are defined by the ISO/RTO and determine locational pricing.',
    `delivery_start_date` DATE COMMENT 'The first date on which physical delivery or financial settlement obligations begin for this leg. Critical for scheduling and settlement calculations.',
    `fixed_price` DECIMAL(18,2) COMMENT 'The predetermined price per unit for fixed-price legs. Null for floating-price legs where price is determined by market index or formula.',
    `heat_rate` DECIMAL(18,2) COMMENT 'For tolling agreements or gas-fired generation legs, the heat rate (MMBtu per MWh) used to convert fuel costs to energy pricing. Represents generation efficiency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this trade leg record was last updated or modified in the ETRM system.',
    `leg_direction` STRING COMMENT 'Indicates whether this leg represents a buy, sell, receive, or pay position from the utilitys perspective. Critical for position management and risk exposure calculation.. Valid values are `buy|sell|receive|pay`',
    `leg_sequence_number` STRING COMMENT 'Sequential ordering of this leg within the parent trade. Used to maintain the chronological or logical order of legs in complex structured products.',
    `leg_status` STRING COMMENT 'Current lifecycle status of the trade leg indicating whether it is active, pending approval, executed, settled, cancelled, or expired.. Valid values are `active|pending|executed|settled|cancelled|expired`',
    `leg_type` STRING COMMENT 'Classification of the trade leg indicating whether it represents a fixed-price obligation, floating-price exposure, physical energy delivery, financial cash settlement, option right, or swap exchange.. Valid values are `fixed|floating|physical_delivery|financial_settlement|option|swap`',
    `market_type` STRING COMMENT 'Identifies the market in which this leg was transacted: day-ahead market (DAM), real-time market (RTM), bilateral contract, forward market, or futures exchange.. Valid values are `day_ahead|real_time|bilateral|forward|futures`',
    `notional_quantity` DECIMAL(18,2) COMMENT 'The contracted volume or capacity for this leg, typically expressed in megawatt-hours (MWh) for energy transactions or megawatts (MW) for capacity products.',
    `option_exercise_style` STRING COMMENT 'Defines when the option can be exercised: American (any time before expiry), European (only at expiry), or Bermudan (specific dates). Null for non-option legs.. Valid values are `american|european|bermudan|none`',
    `option_type` STRING COMMENT 'For option legs, specifies whether this is a call option (right to buy), put option (right to sell), swaption (option on a swap), or collar (combination). Null for non-option legs.. Valid values are `call|put|swaption|collar|none`',
    `premium_amount` DECIMAL(18,2) COMMENT 'The upfront payment made for option legs. Represents the cost of acquiring the option right. Null for non-option legs.',
    `price_formula` STRING COMMENT 'Mathematical formula or index reference used to calculate floating prices. May reference LMP (Locational Marginal Price) nodes, market indices, or custom calculation logic for structured products.',
    `price_index_reference` STRING COMMENT 'External market price index or benchmark used for floating-price legs. Examples include ISO day-ahead LMP, real-time LMP, or published hub indices.',
    `price_unit_of_measure` STRING COMMENT 'The unit of measure for pricing, indicating the currency and quantity basis. Typically USD per MWh for energy or USD per MW for capacity products.. Valid values are `USD_per_MWh|USD_per_MW|USD_per_kW_month|USD_per_MMBtu`',
    `product_type` STRING COMMENT 'The type of wholesale product being traded in this leg: energy (MWh), capacity (MW), ancillary services, transmission rights, RECs, or financial instruments. [ENUM-REF-CANDIDATE: energy|capacity|ancillary_services|transmission|REC|CRR|FTR — 7 candidates stripped; promote to reference product]',
    `quantity_unit_of_measure` STRING COMMENT 'The unit of measure for the notional quantity. Common values include MWh (megawatt-hour) for energy, MW (megawatt) for capacity, and MMBtu for gas-fired generation fuel.. Valid values are `MWh|MW|GWh|kWh|MMBtu|Dth`',
    `rec_vintage_year` STRING COMMENT 'The year in which the renewable energy was generated, determining the vintage of associated RECs. Some RPS programs require specific vintage years.',
    `renewable_energy_certificate_quantity` DECIMAL(18,2) COMMENT 'The number of Renewable Energy Certificates associated with this leg. RECs represent the environmental attributes of renewable generation and may be bundled or unbundled from energy.',
    `settlement_currency` STRING COMMENT 'The currency in which financial settlement for this leg will be executed. Typically USD for North American wholesale energy markets.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `settlement_date` DATE COMMENT 'The date on which financial settlement for this leg is completed and payment is exchanged between counterparties.',
    `settlement_method` STRING COMMENT 'Indicates whether the leg settles through physical delivery of energy, financial cash settlement, or netting against other positions.. Valid values are `physical|financial|cash|netting`',
    `strike_price` DECIMAL(18,2) COMMENT 'The predetermined price at which an option can be exercised. Applicable only to option legs; null for other leg types.',
    `time_of_use_profile` STRING COMMENT 'Defines the hours during which this leg is active. Common profiles include on-peak (weekday business hours), off-peak (nights and weekends), and flat (all hours). [ENUM-REF-CANDIDATE: on_peak|off_peak|super_peak|flat|7x24|5x16|2x16H — 7 candidates stripped; promote to reference product]',
    `tolling_agreement_flag` BOOLEAN COMMENT 'Indicates whether this leg is part of a tolling agreement where one party provides fuel and the other provides generation capacity and conversion services.',
    `transmission_rights_included` BOOLEAN COMMENT 'Indicates whether this leg includes associated transmission capacity rights or Financial Transmission Rights (FTRs) for moving energy across the grid.',
    CONSTRAINT pk_trade_leg PRIMARY KEY(`trade_leg_id`)
) COMMENT 'Individual delivery leg or payment leg of a multi-leg wholesale energy trade. Captures leg type (fixed, floating, physical delivery, financial settlement), notional quantity, price formula, start and end delivery dates, delivery point (PNode/hub), and settlement currency. Supports complex structured products such as swaps, options, and tolling agreements managed in OpenLink Endur.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the energy trading position record. Primary key for the position entity.',
    `book_id` BIGINT COMMENT 'Reference to the trading book under which this position is held. Trading books organize positions by business unit, strategy, or portfolio.',
    `contract_id` BIGINT COMMENT 'Reference to the underlying Power Purchase Agreement (PPA), bilateral contract, or master trading agreement governing this position. Nullable for ISO/RTO centrally cleared positions.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity for bilateral positions or the ISO/RTO for centrally cleared positions. Used for credit exposure tracking and settlement.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical or financial delivery point (PNode, hub, zone, or interconnection point) where the commodity is delivered or settled.',
    `dr_program_id` BIGINT COMMENT 'Foreign key linking to demand.dr_program. Business justification: Trading positions track exposure to DR capacity commitments. Real business process: mark-to-market valuation of DR capacity positions for risk management and regulatory capital adequacy reporting (FER',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Position mark-to-market valuation and VaR calculations depend on forward price curves. Risk managers link positions to specific price forecast scenarios to calculate unrealized P&L and exposure metric',
    `forecast_generation_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_generation. Business justification: Positions tracking generation asset exposure require generation forecasts for valuation, especially renewable PPAs and generation hedges. Portfolio risk management and hedge accounting require generat',
    `lmp_price_id` BIGINT COMMENT 'Foreign key linking to trading.lmp_price. Business justification: Trading positions are marked-to-market using official LMP prices for the delivery point and snapshot timestamp. Linking position to the authoritative lmp_price record ensures valuation consistency and',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Trading positions require load forecasts for mark-to-market valuation, VaR calculations, and hedge effectiveness testing. Daily risk management and portfolio valuation depend on load forecast scenario',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: Trading positions for distribution-connected DER portfolios are tracked against load zones for mark-to-market valuation and risk reporting. Risk managers need load zone context to assess distribution-',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Trading positions are valued at specific pricing nodes for mark-to-market, congestion revenue right tracking, and VAR calculation. pnode_code on trading_position is a denormalized reference; a proper ',
    `portfolio_id` BIGINT COMMENT 'Reference to the trading portfolio or strategy grouping to which this position belongs. Used for portfolio-level risk aggregation and performance reporting.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Portfolio risk management: trading positions for renewable energy must reference underlying PPA contracts for mark-to-market valuation, hedge designation (ASC 815), credit exposure calculation, and Va',
    `trade_id` BIGINT COMMENT 'Reference to the originating deal or transaction in the ETRM system that created this position. Links position to trade capture and deal management.',
    `ancillary_service_type` STRING COMMENT 'Type of ancillary service if this position represents capacity or ancillary services procurement (e.g., regulation up, regulation down, spinning reserve, non-spinning reserve, voltage support). Nullable for energy-only positions.',
    `business_date` DATE COMMENT 'Business date for which this position snapshot is reported. Used for end-of-day position reconciliation and historical trend analysis.',
    `commodity_type` STRING COMMENT 'Type of energy commodity being traded. Defines the product category for the position. [ENUM-REF-CANDIDATE: power|natural_gas|coal|renewable_energy_certificate|emissions_allowance|capacity|ancillary_services — 7 candidates stripped; promote to reference product]',
    `congestion_revenue_right_flag` BOOLEAN COMMENT 'Indicates whether this position includes Congestion Revenue Rights (CRRs) or Financial Transmission Rights (FTRs) used to hedge congestion costs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system. Used for audit trail and data lineage.',
    `credit_exposure_amount` DECIMAL(18,2) COMMENT 'Current credit exposure to the counterparty for this position. Represents the potential loss if the counterparty defaults. Used for credit risk management and collateral calculations.',
    `delivery_end_date` DATE COMMENT 'End date of the delivery period for the energy commodity. Defines when physical or financial settlement concludes.',
    `delivery_start_date` DATE COMMENT 'Start date of the delivery period for the energy commodity. Defines when physical or financial settlement begins.',
    `hedge_designation` STRING COMMENT 'Accounting hedge designation for the position under GAAP or IFRS hedge accounting rules. Determines financial reporting treatment.. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `iso_rto_code` STRING COMMENT 'Code identifying the ISO or RTO market jurisdiction where the position is held. Used for market-specific settlement and reporting. [ENUM-REF-CANDIDATE: CAISO|ERCOT|PJM|MISO|NYISO|ISO_NE|SPP — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last modified. Used for change tracking and audit trail.',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'Current market value of the position based on prevailing market prices (LMP, forward curves, or settlement prices). Represents the fair value of the position at the snapshot timestamp.',
    `market_type` STRING COMMENT 'Type of energy market in which the position is held. Distinguishes between Day-Ahead Market (DAM), Real-Time Market (RTM), forward markets, bilateral contracts, and ancillary services markets.. Valid values are `day_ahead|real_time|forward|bilateral|ancillary_services`',
    `net_position_quantity` DECIMAL(18,2) COMMENT 'Net long or short position quantity for the delivery period. Positive values indicate long positions, negative values indicate short positions. Measured in MWh for power or MMBtu for gas.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Indicates whether the position is actively held, closed, or in settlement process.. Valid values are `open|closed|settled|pending_settlement|cancelled`',
    `rec_quantity` DECIMAL(18,2) COMMENT 'Quantity of Renewable Energy Certificates (RECs) associated with this position, measured in MWh or certificate units. Nullable if rec_tracking_flag is false.',
    `rec_tracking_flag` BOOLEAN COMMENT 'Indicates whether this position includes Renewable Energy Certificates (RECs) that must be tracked separately for Renewable Portfolio Standard (RPS) compliance.',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial settlement of the position. Typically USD for North American energy markets.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp when the position snapshot was captured. Used for intraday position monitoring and end-of-day valuation time-series analysis.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the net position quantity. Typically MWh (Megawatt-Hour) for power, MMBtu (Million British Thermal Units) for gas, or other commodity-specific units. [ENUM-REF-CANDIDATE: MWh|MMBtu|MW|GWh|metric_ton|allowance|certificate — 7 candidates stripped; promote to reference product]',
    `unrealized_pnl` DECIMAL(18,2) COMMENT 'Unrealized profit or loss on the position calculated as the difference between current mark-to-market value and original book value. Positive values indicate gains, negative values indicate losses.',
    `valuation_method` STRING COMMENT 'Method used to calculate the mark-to-market value of the position. Defines the pricing source and calculation approach.. Valid values are `lmp_spot|forward_curve|bilateral_price|cost_plus|index_based`',
    `value_at_risk` DECIMAL(18,2) COMMENT 'Statistical measure of potential loss exposure for the position over a defined time horizon and confidence interval. Used for risk management and regulatory capital calculations.',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'Confidence level percentage used for VaR calculation (e.g., 95.00 or 99.00). Indicates the probability that losses will not exceed the VaR amount.',
    `var_time_horizon_days` STRING COMMENT 'Time horizon in days over which the VaR exposure is calculated (e.g., 1 day, 10 days). Defines the holding period assumption for risk measurement.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Real-time and end-of-day energy trading position record aggregated by book, commodity, delivery period, and delivery point. Tracks net long/short position in MWh or MMBtu, mark-to-market (MtM) value, unrealized P&L, and value-at-risk (VaR) exposure. Captures position valuation snapshots at configurable intervals for trend analysis and intraday risk monitoring. Includes LMP reference data: Locational Marginal Price records by PNode and market interval with energy component, congestion component, and loss component ($/MWh), market type (DAM/RTM/FMM), and ISO source — used for position valuation, settlement price verification, congestion analysis, and hedging strategy support. Sourced from OpenLink Endur position management module and ISO market data feeds. Supports intraday risk monitoring, end-of-day P&L reporting, MtM valuation time-series, and FERC market reporting.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`ppa` (
    `ppa_id` BIGINT COMMENT 'Unique identifier for the power purchase agreement record. Primary key for the PPA entity.',
    `delivery_point_id` BIGINT COMMENT 'Identifier of the physical or virtual delivery point (substation, interconnection point, or pricing node) where energy is transferred under this PPA.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: PPAs specify which generation unit(s) deliver the contracted energy. Critical for PPA delivery obligation tracking, compliance reporting, and settlement reconciliation.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.asset_registry. Business justification: PPAs are contracts tied to specific generation facilities. Essential for PPA performance monitoring, capacity verification, contract compliance auditing, and renewable energy credit tracking. Role pre',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: PPAs are governed by regulatory obligations including PURPA compliance, state RPS requirements, and FERC filing mandates. Regulatory affairs teams must demonstrate PPA compliance with renewable energy',
    `counterparty_id` BIGINT COMMENT 'FK to trading.counterparty.counterparty_id — Every PPA is executed with a counterparty (generator, developer, marketer). Essential for contract management, credit exposure, and FERC reporting.',
    `scheduling_coordinator_id` BIGINT COMMENT 'Identifier of the scheduling coordinator entity responsible for submitting energy schedules and bids to the ISO/RTO on behalf of this PPA. Null for non-ISO/RTO contracts.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: PPA contracts are scoped to the service territory they serve for regulatory reporting, rate case filings, and resource adequacy compliance. Utilities must demonstrate PPAs cover load within specific s',
    `to_counterparty_id` BIGINT COMMENT 'FK to trading.counterparty.counterparty_id — Every PPA has a counterparty. Required for credit exposure aggregation and contract management.',
    `annual_energy_volume_mwh` DECIMAL(18,2) COMMENT 'Expected or contracted annual energy volume in megawatt-hours (MWh) to be delivered under this PPA. Used for performance tracking and settlement forecasting.',
    `capacity_factor_pct` DECIMAL(18,2) COMMENT 'Expected or historical capacity factor (ratio of actual output to maximum possible output) of the generation asset, expressed as a percentage. Used for performance benchmarking.',
    `collateral_posted_usd` DECIMAL(18,2) COMMENT 'Total collateral amount in USD posted by the counterparty to secure performance under this PPA, as of the most recent valuation date.',
    `contract_amendment_count` STRING COMMENT 'Total number of amendments or modifications made to the original PPA contract since execution. Used for contract version tracking.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the PPA contract. Active indicates deliveries are occurring; executed means signed but not yet delivering; terminated or expired indicates contract has ended. [ENUM-REF-CANDIDATE: draft|executed|active|suspended|terminated|expired|amended — 7 candidates stripped; promote to reference product]',
    `contract_term_years` STRING COMMENT 'Duration of the PPA contract in years, calculated from effective start to end date. Typical renewable PPAs range from 10 to 25 years.',
    `contracted_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum generation capacity in megawatts (MW) that the counterparty is obligated to make available under this PPA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PPA record was first created in the ETRM system.',
    `credit_rating_requirement` STRING COMMENT 'Minimum credit rating required of the counterparty under the PPA contract (e.g., BBB-, Investment Grade). Used for credit risk management and collateral determination.',
    `curtailment_allowed_flag` BOOLEAN COMMENT 'Indicates whether the utility has the contractual right to curtail (reduce or halt) energy deliveries under specified conditions (e.g., grid congestion, negative pricing).',
    `curtailment_compensation_rate` DECIMAL(18,2) COMMENT 'Compensation rate in USD per MWh paid to the counterparty for curtailed energy, if applicable. Null if no compensation is provided for curtailment.',
    `effective_end_date` DATE COMMENT 'Date on which the PPA contract terms expire and energy deliveries are scheduled to cease. Nullable for contracts with indefinite terms or renewal options.',
    `effective_start_date` DATE COMMENT 'Date on which the PPA contract terms become effective and energy deliveries are scheduled to commence.',
    `execution_date` DATE COMMENT 'Date on which the PPA contract was signed and became legally binding between the parties.',
    `ferc_filing_reference` STRING COMMENT 'FERC docket number or filing reference associated with this PPA, if the contract required regulatory approval or was filed under FERC jurisdiction.',
    `fixed_price_per_mwh` DECIMAL(18,2) COMMENT 'Fixed contract price in USD per megawatt-hour for energy deliveries, applicable when pricing_structure is fixed. Null for indexed or LMP-based contracts.',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the PPA contract includes a force majeure clause that excuses non-performance due to extraordinary events beyond the parties control (e.g., natural disasters, grid emergencies).',
    `iso_rto_market` STRING COMMENT 'Name of the ISO or RTO market in which this PPA operates (e.g., PJM, CAISO, ERCOT, MISO, SPP). Null for bilateral contracts outside organized markets.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the PPA contract. Null if no amendments have been made.',
    `minimum_take_obligation_mwh` DECIMAL(18,2) COMMENT 'Minimum annual energy volume in MWh that the utility is contractually obligated to purchase, regardless of actual need. Null if no minimum take obligation exists.',
    `price_escalation_rate_pct` DECIMAL(18,2) COMMENT 'Annual percentage rate at which the contract price escalates over the term of the PPA. Null if no escalation clause exists.',
    `price_index_reference` STRING COMMENT 'Name of the commodity price index or market reference used for indexed pricing (e.g., Henry Hub Natural Gas, PJM West Hub Day-Ahead LMP). Applicable when pricing_structure is indexed or lmp_based.',
    `rec_bundled_flag` BOOLEAN COMMENT 'Indicates whether Renewable Energy Certificates (RECs) are bundled with energy deliveries (true) or unbundled and sold separately (false). Applicable only to renewable PPAs.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the PPA contract includes an option for either party to renew the agreement upon expiration.',
    `settlement_frequency` STRING COMMENT 'Frequency at which energy deliveries are settled and invoiced under this PPA (e.g., monthly for most bilateral contracts, hourly for ISO/RTO market-based PPAs).. Valid values are `hourly|daily|monthly|quarterly|annual`',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the PPA contract, as specified in the termination clause.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this PPA record was last modified in the ETRM system.',
    CONSTRAINT pk_ppa PRIMARY KEY(`ppa_id`)
) COMMENT 'Power Purchase Agreement master record with integrated delivery tracking for long-term bilateral contracts for the purchase or sale of electricity from generation assets, including renewable PPAs (wind, solar, hydro) and conventional source agreements. Captures contract identity: counterparty, contracted capacity (MW), energy volume (MWh), contract term, delivery point, pricing structure (fixed, indexed, LMP-based), REC bundling flag, and FERC filing reference. Tracks delivery performance at interval granularity: scheduled MWh, actual delivered MWh, curtailment volume, delivery point, interval start/end timestamps, and settlement status for each delivery period. Supports PPA performance tracking, curtailment reconciliation, invoice generation against contracted volumes, and FERC reporting. SSOT for PPA contract identity and all delivery records within the trading domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` (
    `ppa_delivery_id` BIGINT COMMENT 'Unique identifier for the PPA delivery record. Primary key for the ppa_delivery product.',
    `delivery_point_id` BIGINT COMMENT 'Reference to the physical or virtual delivery point (PNode, pricing node, or interconnection point) where energy was delivered under the PPA. Critical for settlement and locational marginal pricing (LMP) reconciliation.',
    `der_system_id` BIGINT COMMENT 'Reference to the generation asset or facility that produced the energy delivered under this PPA interval. Links to the renewable or conventional generation resource master data.',
    `distribution_substation_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_substation. Business justification: Larger PPA facilities deliver at substation level. Substation delivery tracking is required for transmission-distribution coordination, substation capacity planning, contract settlement, and system im',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: PPA delivery shortfalls caused by generation facility outages or transmission outages must be tracked for force majeure claims, curtailment compensation calculations, and contract performance analysis',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: PPA deliveries from distributed generation specify feeder-level delivery points. Tracking feeder delivery is essential for contract settlement, curtailment management, hosting capacity monitoring, and',
    `forecast_renewable_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_renewable. Business justification: Actual PPA deliveries are compared against renewable generation forecasts for deviation analysis and settlement dispute resolution. Settlement analysts link delivery records to the forecasts used for ',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: PPA delivery records must link to the physical generation asset for settlement reconciliation, performance tracking, and invoice validation against contracted capacity. Critical for PPA administration',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: PPA deliveries to distribution-connected resources are tracked against load zones for hosting capacity management and curtailment allocation. Existing FKs cover substation and feeder; load zone provid',
    `output_telemetry_id` BIGINT COMMENT 'Foreign key linking to generation.output_telemetry. Business justification: PPA delivery records are reconciled against actual generation telemetry for settlement accuracy. Core PPA settlement process linking contracted delivery to metered generation.',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the parent PPA contract under which this delivery occurred. Links to the master PPA agreement defining commercial terms, pricing, and delivery obligations.',
    `ppa_id` BIGINT COMMENT 'FK to trading.ppa.ppa_id — PPA delivery records are the line-level detail of a PPA contract. Without this FK, delivery tracking and curtailment reconciliation against contracted volumes is impossible.',
    `ppa_settlement_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_settlement. Business justification: Settlement reconciliation: ppa_delivery tracks actual energy deliveries and deviations; must link to renewable.ppa_settlement for invoice matching, dispute resolution, payment tracking, and REC transf',
    `scheduling_coordinator_id` BIGINT COMMENT 'Reference to the scheduling coordinator entity responsible for submitting energy schedules and bids to the ISO/RTO on behalf of the PPA counterparty. Required for CAISO and other ISO/RTO markets.',
    `storm_event_id` BIGINT COMMENT 'Foreign key linking to outage.storm_event. Business justification: PPA delivery records track storm-related curtailments and force majeure events. Storm events trigger contractual provisions for excused non-delivery, affect settlement calculations for bundled RECs an',
    `actual_delivered_mwh` DECIMAL(18,2) COMMENT 'The actual quantity of energy in megawatt-hours (MWh) that was physically delivered during this interval, as measured by the ISO/RTO or metering infrastructure. Used for settlement and invoice reconciliation.',
    `ancillary_services_charge` DECIMAL(18,2) COMMENT 'The total charge for ancillary services (regulation, spinning reserves, non-spinning reserves, voltage support) allocated to this delivery interval by the ISO/RTO.',
    `congestion_charge` DECIMAL(18,2) COMMENT 'The congestion component of the locational marginal price (LMP) charged or credited for this delivery interval. Reflects transmission constraints and nodal price differences.',
    `contract_price_per_mwh` DECIMAL(18,2) COMMENT 'The contracted price per megawatt-hour (MWh) applicable to this delivery interval under the PPA. May vary by time-of-use (TOU), season, or other contract terms. Used for invoice calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this delivery record was first created in the energy trading and risk management (ETRM) system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the settlement amount. Typically USD for North American energy markets.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `curtailment_instruction_timestamp` TIMESTAMP COMMENT 'The timestamp when the curtailment instruction was issued by the ISO/RTO or grid operator. Used for compliance verification and dispute resolution.',
    `curtailment_mwh` DECIMAL(18,2) COMMENT 'The quantity of energy in megawatt-hours (MWh) that was curtailed (not delivered) during this interval due to grid constraints, economic dispatch, or ISO/RTO instructions. Calculated as scheduled minus actual delivered.',
    `curtailment_reason_code` STRING COMMENT 'The reason code explaining why energy was curtailed during this interval. Used for PPA performance analysis, force majeure claims, and curtailment credit reconciliation.. Valid values are `grid_congestion|economic_dispatch|forced_outage|maintenance|iso_instruction|environmental_limit`',
    `data_quality_flag` STRING COMMENT 'Indicates the quality and reliability of the delivery data for this interval. Estimated or missing data may require subsequent true-up settlement runs.. Valid values are `valid|estimated|missing|suspect|verified`',
    `delivery_interval_end` TIMESTAMP COMMENT 'The timestamp marking the end of the delivery interval for which energy was scheduled and delivered under the PPA. Defines the close of the measurement period.',
    `delivery_interval_start` TIMESTAMP COMMENT 'The timestamp marking the beginning of the delivery interval for which energy was scheduled and delivered under the PPA. Typically aligned with ISO/RTO market intervals (5-minute, 15-minute, or hourly).',
    `deviation_mwh` DECIMAL(18,2) COMMENT 'The net deviation in megawatt-hours (MWh) between scheduled and actual delivered energy. Positive values indicate over-delivery; negative values indicate under-delivery. Used for imbalance settlement.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this delivery interval is under dispute between the PPA counterparties. Triggers dispute resolution workflow and may delay final settlement.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for dispute on this delivery interval. May reference metering discrepancies, pricing disagreements, or curtailment credit disputes.',
    `energy_charge` DECIMAL(18,2) COMMENT 'The energy component of the locational marginal price (LMP) charged or credited for this delivery interval. Represents the marginal cost of generation.',
    `force_majeure_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a force majeure event (natural disaster, grid emergency, regulatory order) affected delivery during this interval. Used for contractual excuse and penalty waiver determination.',
    `iso_rto_code` STRING COMMENT 'The code identifying the ISO or RTO market in which this delivery occurred. Critical for market-specific settlement rules and regulatory reporting. [ENUM-REF-CANDIDATE: CAISO|ERCOT|PJM|MISO|NYISO|ISO_NE|SPP — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this delivery record was last modified in the ETRM system. Tracks settlement run updates, dispute resolution, and data quality corrections.',
    `lmp_price_per_mwh` DECIMAL(18,2) COMMENT 'The locational marginal price (LMP) in USD per megawatt-hour (MWh) at the delivery point for this interval, as published by the ISO/RTO. Used for market settlement and PPA performance benchmarking.',
    `loss_charge` DECIMAL(18,2) COMMENT 'The marginal loss component of the locational marginal price (LMP) charged or credited for this delivery interval. Reflects transmission line losses between generation and load.',
    `market_type` STRING COMMENT 'The type of energy market in which this delivery occurred. Day-ahead market (DAM) schedules are submitted one day prior; real-time market (RTM) reflects actual dispatch; bilateral contracts are direct counterparty agreements.. Valid values are `day_ahead|real_time|bilateral|ancillary_services`',
    `meter_reading_source` STRING COMMENT 'The source system or method used to obtain the actual delivered MWh measurement. SCADA provides real-time telemetry; revenue meters provide billing-quality data; ISO settlement data is the final authoritative source.. Valid values are `scada|revenue_meter|iso_settlement|estimated`',
    `rec_quantity` DECIMAL(18,2) COMMENT 'The quantity of renewable energy certificates (RECs) generated by this delivery interval, typically one REC per MWh of renewable energy delivered. Used for RPS compliance and environmental attribute tracking.',
    `rec_serial_number` STRING COMMENT 'The unique serial number or identifier assigned to the renewable energy certificate(s) associated with this delivery interval, as registered in a REC tracking system (e.g., WREGIS, M-RETS, PJM-GATS).',
    `scheduled_mwh` DECIMAL(18,2) COMMENT 'The quantity of energy in megawatt-hours (MWh) that was scheduled for delivery during this interval under the PPA contract. Represents the day-ahead or real-time schedule submitted to the ISO/RTO.',
    `settlement_run_type` STRING COMMENT 'The type of settlement run that produced this delivery record. ISO/RTO markets typically perform multiple settlement runs (initial, recalculation, final) as metering and pricing data are refined.. Valid values are `initial|recalculation_1|recalculation_2|final|true_up`',
    `source_system` STRING COMMENT 'The name of the source system that provided this delivery record. Typically OpenLink Endur for ETRM position management, ISO settlement files, or meter data management (MDM) systems.. Valid values are `openlink_endur|iso_settlement|scada|mdm|manual_entry`',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this delivery record in the source system. Used for data reconciliation and traceability back to the operational system of record.',
    CONSTRAINT pk_ppa_delivery PRIMARY KEY(`ppa_delivery_id`)
) COMMENT 'Scheduled and actual energy delivery records under a PPA contract for a given delivery interval. Captures scheduled MWh, actual delivered MWh, curtailment volume, delivery point, interval start/end timestamps, and settlement status. Supports PPA performance tracking, curtailment reconciliation, and invoice generation against contracted volumes.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`market_bid` (
    `market_bid_id` BIGINT COMMENT 'Unique identifier for the market bid record. Primary key for the market_bid product.',
    `aggregator_id` BIGINT COMMENT 'Foreign key linking to demand.aggregator. Business justification: Aggregators submit market bids for demand response capacity portfolios into ISO/RTO day-ahead and real-time markets. Bid-to-award reconciliation, credit exposure management, and FERC EQR reporting req',
    `battery_storage_asset_id` BIGINT COMMENT 'Foreign key linking to renewable.battery_storage_asset. Business justification: Battery storage systems bid into ISO markets for energy arbitrage and ancillary services. Links bids to specific battery assets for SOC management, ramp rate validation, and performance tracking.',
    `book_id` BIGINT COMMENT 'FK to trading.trading_book',
    `counterparty_id` BIGINT COMMENT 'FK to trading.counterparty',
    `delivery_point_id` BIGINT COMMENT 'FK to trading.pnode.pnode_id — Market bids are submitted for specific PNodes. Required for bid validation and market participation tracking.',
    `der_system_id` BIGINT COMMENT 'Unique identifier for the generation or demand response resource submitting the bid. Corresponds to the ISO/RTO registered resource ID.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Market bid optimization algorithms use energy price forecasts to determine optimal bid prices and quantities. Bid strategy construction requires forward price curves for expected value calculations an',
    `forecast_renewable_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_renewable. Business justification: Market bids for renewable resources require renewable-specific forecasts (P10/P50/P90) for bid curve construction. Day-ahead and real-time bidding for wind/solar assets depends on renewable forecast u',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Day-ahead and real-time market bids are informed by load forecasts to optimize dispatch strategy and avoid imbalance charges. Bid desk analysts reference load forecasts when determining bid quantities',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: Market bids for distribution-connected DER aggregations must reference load zones to validate hosting capacity constraints before submission. Utilities use this link in DER market participation workfl',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: ISO/RTO market bids must comply with market behavior rules, tariff requirements, and FERC anti-manipulation regulations. Compliance monitoring systems flag bids violating specific obligations for pre-',
    `path_id` BIGINT COMMENT 'Foreign key linking to transmission.path. Business justification: Market bids for physical energy delivery specify a transmission path for source-to-sink routing. Day-ahead and real-time market bid submission requires a valid OATT transmission path. transmission_pat',
    `planned_outage_window_id` BIGINT COMMENT 'Foreign key linking to outage.planned_outage_window. Business justification: Day-ahead and real-time market bids must reflect planned generation outage schedules. ISO/RTO market participants submit bids accounting for resource unavailability during planned maintenance for accu',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Market bids are submitted at specific pricing nodes (pnodes) for LMP-based settlement. ISO/RTO market bid submission and LMP settlement both require a valid pnode reference. pnode_code on market_bid i',
    `scheduling_coordinator_id` BIGINT COMMENT 'FK to trading.scheduling_coordinator.scheduling_coordinator_id — Market bids are submitted through a scheduling coordinator registered with the ISO/RTO. This FK establishes market participation authority and NAESB compliance.',
    `ancillary_service_type` STRING COMMENT 'The specific type of ancillary service being procured. Ancillary services are grid support services required to maintain reliability and balance supply and demand. [ENUM-REF-CANDIDATE: regulation_up|regulation_down|spinning_reserve|non_spinning_reserve|supplemental_reserve|voltage_support|black_start — 7 candidates stripped; promote to reference product]',
    `award_timestamp` TIMESTAMP COMMENT 'The timestamp when the ISO/RTO issued the market clearing award for this bid. Marks the transition from bid submission to awarded status.',
    `awarded_mw` DECIMAL(18,2) COMMENT 'The quantity of energy or capacity awarded to this bid after market clearing, measured in megawatts. May be less than bid_quantity_mw for partially awarded bids.',
    `bid_curve_segments` STRING COMMENT 'JSON or delimited representation of multi-segment bid curves, capturing incremental MW quantities and corresponding prices. Allows for non-linear supply curves reflecting marginal cost increases.',
    `bid_price_per_mwh` DECIMAL(18,2) COMMENT 'The price at which the bidder is willing to supply energy or capacity, expressed in dollars per megawatt-hour. For multi-segment bids, this represents the starting price.',
    `bid_quantity_mw` DECIMAL(18,2) COMMENT 'The total quantity of energy or capacity being offered in this bid, measured in megawatts. For energy bids, this represents the MW available for dispatch.',
    `bid_reference_number` STRING COMMENT 'External reference number assigned by the ISO/RTO or internal ETRM system (OpenLink Endur) to uniquely identify this bid submission.',
    `bid_status` STRING COMMENT 'Current lifecycle status of the bid. Tracks progression from draft through submission, ISO acceptance, market clearing award, and final settlement. [ENUM-REF-CANDIDATE: draft|submitted|accepted|rejected|partially_awarded|fully_awarded|cancelled|expired — 8 candidates stripped; promote to reference product]',
    `bid_strategy_code` STRING COMMENT 'Internal code representing the bidding strategy or algorithm used to generate this bid. Confidential business information used for strategy analysis.',
    `bid_type` STRING COMMENT 'The type of market product being bid. Energy bids are for physical power delivery; ancillary service bids are for grid support services; capacity bids are for resource adequacy; FTR and CRR bids are for financial hedging instruments.. Valid values are `energy|ancillary_service|capacity|financial_transmission_right|congestion_revenue_right`',
    `clearing_price_lmp` DECIMAL(18,2) COMMENT 'The Locational Marginal Price at which the market cleared for this bid. Represents the market-determined price for energy at the specified PNode and interval.',
    `cost_allocation_tariff` STRING COMMENT 'The tariff category to which ancillary service costs are allocated. Determines whether costs are recovered through transmission, distribution, or other rate components.. Valid values are `transmission|distribution|generation|customer`',
    `counterparty_credit_rating` STRING COMMENT 'The credit rating of the counterparty, used for credit exposure management and risk assessment in bilateral trading.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this market bid record was first created in the ETRM system. Used for audit trails and data lineage.',
    `curtailment_instructions` STRING COMMENT 'ISO/RTO instructions for curtailing or reducing the scheduled energy delivery due to transmission constraints, reliability events, or market conditions.',
    `etag_reference_number` STRING COMMENT 'The NAESB-compliant e-Tag reference number for the physical energy schedule associated with this bid. Links the market award to the transmission scheduling and tagging system.',
    `ferc_eqr_reported_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this bid has been included in the quarterly FERC EQR filing. FERC requires reporting of all wholesale electricity transactions.',
    `iso_award_reference` STRING COMMENT 'The ISO/RTO award reference number specific to ancillary service procurement. Used for settlement and cost allocation.',
    `iso_confirmation_reference` STRING COMMENT 'The confirmation or award reference number issued by the ISO/RTO after market clearing. Used for reconciliation and settlement.',
    `iso_rto_code` STRING COMMENT 'The ISO or RTO market to which this bid was submitted. Identifies the wholesale electricity market operator. [ENUM-REF-CANDIDATE: CAISO|MISO|PJM|ERCOT|NYISO|ISONE|SPP — 7 candidates stripped; promote to reference product]',
    `market_interval_end` TIMESTAMP COMMENT 'The end timestamp of the market interval for which this bid applies. Together with market_interval_start, defines the delivery window.',
    `market_interval_start` TIMESTAMP COMMENT 'The start timestamp of the market interval (typically hourly or sub-hourly) for which this bid applies. Defines the delivery period.',
    `market_type` STRING COMMENT 'The market timeframe for this bid. Day-Ahead Market (DAM) clears one day prior to delivery; Real-Time Market (RTM) clears closer to the operating hour.. Valid values are `day_ahead|real_time|hour_ahead|intraday`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this market bid record was last modified. Tracks updates to bid status, awards, schedules, or settlement data.',
    `naesb_compliant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this bid and associated scheduling comply with NAESB WEQ standards for wholesale energy transactions and e-Tag requirements.',
    `procured_mw` DECIMAL(18,2) COMMENT 'The quantity of ancillary service capacity procured through this bid, measured in megawatts. Represents the reserved capacity for grid support.',
    `procurement_price_per_mw_hr` DECIMAL(18,2) COMMENT 'The price paid for procured ancillary services, expressed in dollars per megawatt-hour. Reflects the capacity reservation cost.',
    `rec_tracking_number` STRING COMMENT 'The tracking number for Renewable Energy Certificates associated with this bid, if the energy is from renewable sources. Used for RPS compliance and environmental attribute tracking.',
    `schedule_status` STRING COMMENT 'Current status of the physical energy schedule (e-Tag). Tracks progression from submission through ISO confirmation, curtailment events, and expiration.. Valid values are `submitted|confirmed|curtailed|expired|cancelled`',
    `scheduled_mw_by_interval` STRING COMMENT 'JSON or delimited representation of scheduled MW quantities for each sub-interval within the market interval. Captures granular scheduling data for real-time dispatch.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The total financial settlement amount for this bid after market clearing and final settlement calculations. Includes energy payments, ancillary service payments, and any adjustments.',
    `settlement_date` DATE COMMENT 'The date on which financial settlement for this bid was completed by the ISO/RTO or counterparty.',
    `sink_pnode` STRING COMMENT 'The sink PNode for the scheduled energy transaction. Identifies the load or withdrawal point for the physical energy flow.',
    `source_pnode` STRING COMMENT 'The source PNode for the scheduled energy transaction. Identifies the generation or injection point for the physical energy flow.',
    `source_system` STRING COMMENT 'The name of the source system from which this bid record originated, typically OpenLink Endur ETRM or ISO/RTO market interface systems.',
    `submission_timestamp` TIMESTAMP COMMENT 'The exact timestamp when the bid was submitted to the ISO/RTO market. Critical for compliance with market submission deadlines and audit trails.',
    CONSTRAINT pk_market_bid PRIMARY KEY(`market_bid_id`)
) COMMENT 'Unified market participation record covering the complete ISO/RTO market lifecycle from bid submission through clearing award, physical energy scheduling, and ancillary service procurement. Captures DAM and RTM bid/offer submissions to ISO/RTO markets (CAISO, MISO, PJM, ERCOT, NYISO, ISO-NE) including bid type (energy, ancillary service, capacity), resource ID, PNode, bid quantity (MW), bid price ($/MWh), bid curve segments, market interval, and submission timestamp. Tracks award phase: awarded MW, clearing price (LMP), ISO confirmation reference, award interval, and market type (DAM/RTM). Tracks scheduling phase: e-Tag reference number, source/sink PNodes, transmission path, scheduled MW by interval, curtailment instructions, schedule status (submitted, confirmed, curtailed, expired), and NAESB e-Tag compliance. Covers ancillary service procurement: service type (regulation up/down, spinning reserve, non-spinning reserve, supplemental), resource ID, procured MW, procurement price ($/MW-hr), ISO award reference, and cost allocation to transmission or distribution tariff. Supports FERC EQR reporting, NAESB e-Tag compliance, ancillary service cost reporting, and complete market participation audit trail. SSOT for all ISO/RTO market participation data in the trading domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`market_award` (
    `market_award_id` BIGINT COMMENT 'Unique identifier for the ISO/RTO market clearing award record. Primary key for the market award entity.',
    `aggregator_id` BIGINT COMMENT 'Foreign key linking to demand.aggregator. Business justification: Market awards for DR capacity are issued to aggregators who manage portfolios of distributed resources. Settlement payment distribution, performance bond tracking, and ISO/RTO registration reconciliat',
    `battery_storage_asset_id` BIGINT COMMENT 'Foreign key linking to renewable.battery_storage_asset. Business justification: Battery market awards drive charge/discharge schedules. Links awards to battery assets for SOC tracking, cycle counting, degradation monitoring, and settlement validation against actual performance.',
    `der_system_id` BIGINT COMMENT 'Identifier of the generation or demand response resource that received the market award. Links to the resource master data in the generation or demand response domain.',
    `dr_event_id` BIGINT COMMENT 'Foreign key linking to demand.dr_event. Business justification: Market awards result from DR resource bids during events. Real business process: ISO settlement of DR dispatch, allocating clearing prices and payments to DR events for revenue recognition and partici',
    `energy_schedule_id` BIGINT COMMENT 'Identifier of the physical energy schedule created from this market award. Links to the scheduling and dispatch domain.',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Market awards for distributed energy resources specify feeder-level delivery. Feeder tracking is essential for DER aggregation settlement, distribution locational marginal pricing pilots, and coordina',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Market awards must track which physical generation asset was awarded capacity/energy for dispatch instructions, AGC signals, and settlement. Essential for real-time operations coordination between tra',
    `interconnection_queue_id` BIGINT COMMENT 'Foreign key linking to renewable.interconnection_queue. Business justification: Capacity market awards: capacity market awards for projects in the interconnection queue reference renewable.interconnection_queue for expected commercial operation date, generation capacity MW, deliv',
    `lmp_price_id` BIGINT COMMENT 'Foreign key linking to trading.lmp_price. Business justification: Market awards are cleared at Locational Marginal Prices published by the ISO/RTO. Each award should reference the official LMP price record for the pnode and market interval to ensure price consistenc',
    `market_participant_id` BIGINT COMMENT 'Identifier of the scheduling coordinator or market participant who submitted the bid or offer that resulted in this award.',
    `planned_outage_window_id` BIGINT COMMENT 'Foreign key linking to outage.planned_outage_window. Business justification: Market awards for capacity and ancillary services must reflect planned outage schedules. Awarded resources unavailable during planned windows trigger settlement adjustments, replacement procurement, a',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Market awards are node-specific — the awarded quantity is dispatched at a specific pricing node for LMP settlement. ISO/RTO dispatch instructions and settlement calculations require a valid pnode refe',
    `market_bid_id` BIGINT COMMENT 'Identifier of the original bid or offer submitted by the market participant that resulted in this award. Links to the bid submission record.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Market awards in ISO/RTO markets must be reported in FERC EQR quarterly transaction filings and state PUC market monitoring reports. Awards are the transactional basis for wholesale electricity regula',
    `settlement_statement_id` BIGINT COMMENT 'Identifier of the ISO/RTO settlement statement that includes this award. Used for invoice reconciliation and payment tracking.',
    `award_confirmation_number` STRING COMMENT 'Unique confirmation reference number issued by the ISO/RTO for this market award. Used for settlement reconciliation and dispute resolution.',
    `award_interval_end_timestamp` TIMESTAMP COMMENT 'End date and time of the market interval for which this award applies. Defines the end of the delivery period.',
    `award_interval_start_timestamp` TIMESTAMP COMMENT 'Start date and time of the market interval for which this award applies. Defines the beginning of the delivery period.',
    `award_status` STRING COMMENT 'Current lifecycle status of the market award. CONFIRMED = initial award issued, REVISED = award modified by ISO, CANCELLED = award voided, SETTLED = financially settled, DISPUTED = under dispute resolution.. Valid values are `CONFIRMED|REVISED|CANCELLED|SETTLED|DISPUTED`',
    `award_timestamp` TIMESTAMP COMMENT 'Date and time when the ISO/RTO issued this market award confirmation. Represents the official award notification time.',
    `award_version` STRING COMMENT 'Version number of this award record. Increments with each revision or correction issued by the ISO/RTO. Used for change tracking.',
    `awarded_quantity_mw` DECIMAL(18,2) COMMENT 'Quantity of energy or ancillary service capacity awarded to the resource for the market interval, measured in megawatts (MW). Represents the cleared MW obligation.',
    `awarded_quantity_mwh` DECIMAL(18,2) COMMENT 'Energy quantity awarded for the interval expressed in megawatt-hours (MWh). Calculated as awarded_quantity_mw multiplied by interval duration.',
    `block_dispatch_flag` BOOLEAN COMMENT 'Indicates whether this award is part of a block or all-or-nothing dispatch instruction. True = block dispatch, False = divisible award.',
    `clearing_price_per_mwh` DECIMAL(18,2) COMMENT 'Locational Marginal Price (LMP) or market clearing price at which the award was made, expressed in currency per MWh. Determines settlement value.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this market award record was first created in the ETRM system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this award record. Typically USD for US markets, CAD for Canadian markets.. Valid values are `USD|CAD|MXN`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this award is currently under dispute by the market participant. True = disputed, False = accepted.',
    `dispute_reason` STRING COMMENT 'Description of the reason for disputing this award, if dispute_flag is true. Captures the nature of the disagreement for resolution tracking.',
    `interval_duration_minutes` STRING COMMENT 'Duration of the market interval in minutes. Typically 5, 15, or 60 minutes depending on ISO/RTO market design.',
    `iso_rto_code` STRING COMMENT 'Code identifying the ISO or RTO that issued this market award. Indicates the market jurisdiction. [ENUM-REF-CANDIDATE: CAISO|ERCOT|ISONE|MISO|NYISO|PJM|SPP — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this market award record was last updated. Tracks revisions and corrections to the award data.',
    `market_type` STRING COMMENT 'Type of market in which the award was issued. DAM = Day-Ahead Market, RTM = Real-Time Market, FTR = Financial Transmission Rights, CRR = Congestion Revenue Rights, ANCILLARY = Ancillary Services Market.. Valid values are `DAM|RTM|FTR|CRR|ANCILLARY`',
    `minimum_run_time_minutes` STRING COMMENT 'Minimum continuous run time in minutes that the resource must operate if awarded, as specified in the bid parameters. Reflects operational constraints.',
    `must_run_flag` BOOLEAN COMMENT 'Indicates whether this award was issued under a reliability must-run (RMR) or similar out-of-market commitment. True = must-run, False = economic dispatch.',
    `no_load_cost` DECIMAL(18,2) COMMENT 'No-load cost in currency units for operating the resource at minimum output. Used for commitment and settlement calculations.',
    `product_type` STRING COMMENT 'Specific energy or ancillary service product awarded. ENERGY = energy commodity, REGULATION_UP/DOWN = frequency regulation, SPINNING_RESERVE = synchronized reserve, NON_SPINNING_RESERVE = supplemental reserve, REACTIVE_POWER = voltage support, BLACK_START = restoration service. [ENUM-REF-CANDIDATE: ENERGY|REGULATION_UP|REGULATION_DOWN|SPINNING_RESERVE|NON_SPINNING_RESERVE|REACTIVE_POWER|BLACK_START — 7 candidates stripped; promote to reference product]',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'Maximum rate at which the resource can change output, measured in MW per minute. Used for dispatch feasibility and scheduling.',
    `self_schedule_flag` BOOLEAN COMMENT 'Indicates whether this award resulted from a self-schedule (price-taker) bid rather than an economic (price-setter) bid. True = self-schedule, False = economic bid.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Total financial settlement amount for this award, calculated as awarded_quantity_mwh multiplied by clearing_price_per_mwh. Represents the revenue or cost obligation.',
    `settlement_run_type` STRING COMMENT 'Type of settlement calculation run that produced this award record. INITIAL = first settlement, FINAL = final settlement after meter data, RESETTLEMENT = correction run, TRUE_UP = annual reconciliation.. Valid values are `INITIAL|FINAL|RESETTLEMENT|TRUE_UP`',
    `shadow_price` DECIMAL(18,2) COMMENT 'Shadow price of the binding constraint that limited the award quantity. Represents the marginal value of relaxing the constraint.',
    `source_system` STRING COMMENT 'Name of the source system from which this award record originated. Typically the ETRM system (e.g., OpenLink Endur) or ISO/RTO interface.',
    `startup_cost` DECIMAL(18,2) COMMENT 'Startup cost in currency units associated with this award if the resource was committed from an offline state. Used for make-whole payments.',
    `trading_date` DATE COMMENT 'The operating day for which the energy or ancillary service was awarded. Represents the physical delivery date.',
    CONSTRAINT pk_market_award PRIMARY KEY(`market_award_id`)
) COMMENT 'ISO/RTO market clearing award record confirming accepted energy or ancillary service quantities for a given resource and market interval. Captures awarded MW, clearing price (LMP), market type (DAM/RTM), resource ID, PNode, award interval, and ISO confirmation reference. Drives physical scheduling and settlement obligations.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`lmp_price` (
    `lmp_price_id` BIGINT COMMENT 'Unique identifier for the LMP price record. Primary key for the LMP price data product.',
    `delivery_point_id` BIGINT COMMENT 'FK to trading.pnode.pnode_id — LMP prices are published per PNode per interval. This is the fundamental reference relationship for all price-based calculations in the trading domain.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Actual LMP prices are compared against energy price forecasts for forecast accuracy tracking and model calibration. Forecast performance evaluation and model tuning require linking actuals to forecast',
    `market_run_id` BIGINT COMMENT 'Identifier for the specific market run or market clearing execution that produced this LMP. Used to track revisions and re-runs of market settlements.',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: LMP prices are calculated at transmission pricing nodes. Node-specific LMP settlement, congestion analysis, and FTR settlement all require linking each LMP price record to its transmission pnode. No p',
    `actual_load_mw` DECIMAL(18,2) COMMENT 'Actual measured load in megawatts (MW) at this pricing node for the market interval. Used for real-time market settlement and forecast accuracy analysis.',
    `ancillary_service_flag` BOOLEAN COMMENT 'Indicates whether this LMP record includes ancillary service pricing components (regulation, spinning reserve, non-spinning reserve).',
    `congestion_status` STRING COMMENT 'Indicates whether transmission congestion was binding at this location during the market interval. BINDING = congestion constraint was active, NON_BINDING = no active congestion.. Valid values are `NONE|BINDING|NON_BINDING`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the LMP values. Typically USD for US markets, CAD for Canadian markets.. Valid values are `USD|CAD`',
    `current_record_flag` BOOLEAN COMMENT 'Indicates whether this is the current active record for the pricing node and market interval. True for current records, False for historical versions.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality status of the LMP data. VALID = verified data, ESTIMATED = calculated estimate, MISSING = data not available, SUSPECT = data flagged for review, REVISED = corrected data.. Valid values are `VALID|ESTIMATED|MISSING|SUSPECT|REVISED`',
    `iso_rto_code` STRING COMMENT 'Code identifying the ISO or RTO that published this LMP. Examples: CAISO, ERCOT, ISONE, MISO, NYISO, PJM, SPP. [ENUM-REF-CANDIDATE: CAISO|ERCOT|ISONE|MISO|NYISO|PJM|SPP — 7 candidates stripped; promote to reference product]',
    `lmp_congestion_component` DECIMAL(18,2) COMMENT 'Congestion component of the LMP in $/MWh. Represents the cost of transmission congestion between the pricing node and the reference bus.',
    `lmp_energy_component` DECIMAL(18,2) COMMENT 'Energy component of the LMP in $/MWh. Represents the marginal cost of serving the next increment of load at the reference bus.',
    `lmp_loss_component` DECIMAL(18,2) COMMENT 'Loss component of the LMP in $/MWh. Represents the marginal cost of transmission losses between the pricing node and the reference bus.',
    `lmp_total` DECIMAL(18,2) COMMENT 'Total locational marginal price in dollars per megawatt-hour ($/MWh). Sum of energy component, congestion component, and loss component.',
    `load_forecast_mw` DECIMAL(18,2) COMMENT 'Forecasted load in megawatts (MW) at this pricing node for the market interval. Used for day-ahead market clearing and price formation analysis.',
    `location_type` STRING COMMENT 'Type of location for which the LMP is calculated. GENERATOR = generation resource, LOAD = load zone, HUB = trading hub, ZONE = pricing zone, INTERFACE = transmission interface, AGGREGATE = aggregated pricing point.. Valid values are `GENERATOR|LOAD|HUB|ZONE|INTERFACE|AGGREGATE`',
    `marginal_loss_factor` DECIMAL(18,2) COMMENT 'Marginal loss factor at the pricing node. Represents the incremental transmission losses per unit of power injected or withdrawn at this location.',
    `market_date` DATE COMMENT 'The calendar date for which the LMP applies. Used for day-level aggregation and reporting.',
    `market_hour` STRING COMMENT 'The hour of the day (0-23) for which the LMP applies. Used for hourly market analysis and reporting.',
    `market_interval_end_timestamp` TIMESTAMP COMMENT 'End timestamp of the market interval for which the LMP applies. Represents the conclusion of the trading interval.',
    `market_interval_start_timestamp` TIMESTAMP COMMENT 'Start timestamp of the market interval for which the LMP applies. Represents the beginning of the trading interval (typically 5-minute or hourly intervals depending on ISO/RTO).',
    `market_run_type` STRING COMMENT 'Type of market run. INITIAL = first published results, RESETTLEMENT = revised settlement, FINAL = final binding settlement after all adjustments.. Valid values are `INITIAL|RESETTLEMENT|FINAL`',
    `market_type` STRING COMMENT 'Type of energy market for which the LMP is published. DAM = Day-Ahead Market, RTM = Real-Time Market, FMM = Fifteen-Minute Market, IDM = Intra-Day Market.. Valid values are `DAM|RTM|FMM|IDM`',
    `price_unit_of_measure` STRING COMMENT 'Unit of measure for the LMP price. Standard is dollars per megawatt-hour ($/MWh).. Valid values are `USD_PER_MWH|CAD_PER_MWH`',
    `pricing_zone_code` STRING COMMENT 'Code identifying the pricing zone or load zone to which the pricing node belongs. Used for zonal price aggregation.',
    `publication_timestamp` TIMESTAMP COMMENT 'Timestamp when the LMP data was published by the ISO/RTO. Used to track data latency and timeliness of market information.',
    `record_effective_timestamp` TIMESTAMP COMMENT 'Timestamp when this LMP record became effective in the data warehouse. Used for temporal tracking and historical analysis.',
    `record_end_timestamp` TIMESTAMP COMMENT 'Timestamp when this LMP record was superseded or expired. Null for current records. Used for slowly changing dimension Type 2 tracking.',
    `reference_bus_name` STRING COMMENT 'Name of the reference bus used for LMP calculation. The reference bus is the baseline location against which congestion and loss components are measured.',
    `scarcity_pricing_flag` BOOLEAN COMMENT 'Indicates whether scarcity pricing or operating reserve demand curve pricing was applied during this market interval. Used to identify periods of tight supply conditions.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which the LMP data was extracted. Typically the ISO/RTO market data feed or ETRM system identifier.',
    `trading_hub_flag` BOOLEAN COMMENT 'Indicates whether this pricing node is a designated trading hub. Trading hubs are commonly used reference points for bilateral contracts and financial hedging.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts (kV) at which the pricing node is located. Used for transmission planning and loss analysis.',
    CONSTRAINT pk_lmp_price PRIMARY KEY(`lmp_price_id`)
) COMMENT 'Locational Marginal Price (LMP) records published by ISO/RTO for each PNode and market interval. Captures LMP components: energy component, congestion component, and loss component ($/MWh), market type (DAM/RTM/FMM), interval timestamp, and ISO source. Used for trade valuation, settlement calculations, congestion analysis, and hedging strategy. Sourced from ISO market data feeds.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` (
    `scheduling_coordinator_id` BIGINT COMMENT 'Unique identifier for the scheduling coordinator entity registered with an ISO/RTO. Primary key for the scheduling coordinator product.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_permit. Business justification: Scheduling coordinators operating generation resources must hold environmental permits for air quality and water discharge. Compliance teams verify SC registrations align with permitted facilities to ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Scheduling coordinators have direct NERC reliability obligations (BAL, INT standards), OATT compliance requirements, and ISO/RTO tariff obligations. SC registration and ongoing operations require demo',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Scheduling coordinators in ISO/RTO markets often represent a primary generation or load asset they coordinate for. Links SC registration to the physical resource for resource adequacy tracking and mar',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Scheduling coordinators operate within specific ISO/RTO forecast zones for resource registration and scheduling. SC registration, resource allocation, and scheduling operations are fundamentally zone-',
    `ancillary_services_flag` BOOLEAN COMMENT 'Indicates whether this scheduling coordinator is authorized to bid and provide ancillary services (regulation, spinning reserve, non-spinning reserve, voltage support) in the ISO/RTO markets.',
    `business_address_line1` STRING COMMENT 'The first line of the scheduling coordinators registered business address (street number and name) on file with the ISO/RTO.',
    `business_address_line2` STRING COMMENT 'The second line of the scheduling coordinators registered business address (suite, floor, building) on file with the ISO/RTO.',
    `business_city` STRING COMMENT 'The city of the scheduling coordinators registered business address on file with the ISO/RTO.',
    `business_country_code` STRING COMMENT 'The three-letter ISO country code of the scheduling coordinators registered business address. Typically USA, CAN (Canada), or MEX (Mexico) for North American energy markets.. Valid values are `USA|CAN|MEX`',
    `business_postal_code` STRING COMMENT 'The postal code or ZIP code of the scheduling coordinators registered business address on file with the ISO/RTO.',
    `business_state_province` STRING COMMENT 'The state or province of the scheduling coordinators registered business address on file with the ISO/RTO.',
    `collateral_posted_usd` DECIMAL(18,2) COMMENT 'The total amount of financial collateral (cash, letter of credit, surety bond) posted by the scheduling coordinator with the ISO/RTO to secure market obligations and credit exposure.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this scheduling coordinator record was first created in the data system. Used for data lineage and audit trail purposes.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'The maximum credit exposure limit in USD established by the ISO/RTO for this scheduling coordinator based on creditworthiness assessment. Determines the maximum unsecured market position the SC can hold.',
    `dam_participation_flag` BOOLEAN COMMENT 'Indicates whether this scheduling coordinator is authorized and actively participates in the ISO/RTO day-ahead energy market for forward scheduling and financial hedging.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number assigned by Dun & Bradstreet to uniquely identify the scheduling coordinator entity for credit assessment and business verification purposes.. Valid values are `^[0-9]{9}$`',
    `etrm_system_code` STRING COMMENT 'The internal identifier for this scheduling coordinator in the utilitys ETRM system (e.g., OpenLink Endur). Used for linking ISO/RTO market positions to internal trading books and risk management.',
    `ferc_mbr_authorization` STRING COMMENT 'Reference to the FERC docket number or authorization identifier granting this scheduling coordinator market-based rate authority for wholesale energy sales. Required for entities selling energy at market rates rather than cost-based rates.',
    `ftr_crr_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this scheduling coordinator is eligible to hold and trade financial transmission rights or congestion revenue rights for hedging transmission congestion costs.',
    `iso_rto_affiliation` STRING COMMENT 'The ISO or RTO with which this scheduling coordinator is registered and authorized to submit schedules, bids, and participate in market operations. [ENUM-REF-CANDIDATE: CAISO|ERCOT|MISO|PJM|SPP|NYISO|ISO_NE|other — 8 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'The date of the most recent compliance audit or review conducted by the ISO/RTO or internal audit team to verify scheduling coordinator adherence to market rules and OATT requirements.',
    `last_audit_result` STRING COMMENT 'The outcome of the most recent compliance audit: passed (no issues), passed with findings (minor issues noted), failed (material non-compliance), or not applicable (no audit conducted).. Valid values are `passed|passed_with_findings|failed|not_applicable`',
    `naesb_certification_date` DATE COMMENT 'The date on which the scheduling coordinator received NAESB WEQ certification for electronic scheduling authority.',
    `naesb_certification_status` STRING COMMENT 'Indicates whether the scheduling coordinator holds current NAESB WEQ certification for electronic scheduling (e-Tag) authority. Certified status is required for submitting NERC e-Tags for interchange transactions.. Valid values are `certified|not_certified|expired|pending`',
    `nerc_company_code` STRING COMMENT 'The unique company identifier assigned by NERC for compliance reporting and reliability coordination. Used for linking scheduling coordinator activities to NERC CIP and operational standards.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, special conditions, operational notes, or historical context related to this scheduling coordinator registration and market participation.',
    `oatt_compliance_status` STRING COMMENT 'Indicates whether the scheduling coordinator is in compliance with FERC-mandated Open Access Transmission Tariff requirements for non-discriminatory transmission access and scheduling practices.. Valid values are `compliant|non_compliant|conditional|under_review`',
    `primary_contact_email` STRING COMMENT 'The primary email address for the scheduling coordinator contact used for ISO/RTO market notices, settlement statements, and operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact person responsible for scheduling coordinator operations and ISO/RTO communications.',
    `primary_contact_phone` STRING COMMENT 'The primary telephone number for the scheduling coordinator contact used for urgent market operations and real-time coordination with the ISO/RTO.',
    `registered_resource_count` STRING COMMENT 'The total number of generation and/or load resources currently registered under this scheduling coordinator for market participation and settlement purposes.',
    `registration_date` DATE COMMENT 'The date on which the scheduling coordinator was officially registered and authorized by the ISO/RTO to participate in wholesale energy markets.',
    `registration_expiration_date` DATE COMMENT 'The date on which the scheduling coordinator registration expires and must be renewed. Null if registration is perpetual subject to compliance.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the scheduling coordinator registration with the ISO/RTO. Active indicates full market participation authority; inactive indicates voluntary withdrawal; suspended indicates temporary restriction; pending_approval indicates application under review; revoked indicates termination by ISO/RTO.. Valid values are `active|inactive|suspended|pending_approval|revoked`',
    `rtm_participation_flag` BOOLEAN COMMENT 'Indicates whether this scheduling coordinator is authorized and actively participates in the ISO/RTO real-time energy market for balancing and spot transactions.',
    `sc_code` STRING COMMENT 'The externally-known unique alphanumeric code assigned by the ISO/RTO to identify this scheduling coordinator in market operations, e-Tag submissions, and settlement processes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sc_name` STRING COMMENT 'The legal business name of the scheduling coordinator entity as registered with the ISO/RTO.',
    `sc_type` STRING COMMENT 'Classification of the scheduling coordinator based on the primary role in the wholesale energy market: generator (represents generation resources), load-serving entity (represents load), marketer (third-party intermediary), trader (financial participant), aggregator (pools multiple resources), or hybrid (multiple roles).. Valid values are `generator|load_serving_entity|marketer|trader|aggregator|hybrid`',
    `scheduling_contact_email` STRING COMMENT 'The email address for the scheduling contact used for schedule confirmations, e-Tag notifications, and market bid acknowledgments.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `scheduling_contact_name` STRING COMMENT 'The full name of the designated contact person responsible for submitting energy schedules, e-Tags, and day-ahead/real-time market bids on behalf of the scheduling coordinator.',
    `scheduling_contact_phone` STRING COMMENT 'The telephone number for the scheduling contact used for real-time schedule adjustments, curtailment notifications, and emergency coordination.',
    `settlement_contact_email` STRING COMMENT 'The email address for the settlement contact used for receiving settlement statements, invoices, and payment notifications from the ISO/RTO.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `settlement_contact_name` STRING COMMENT 'The full name of the designated contact person responsible for reviewing market settlement statements, invoice reconciliation, and financial dispute resolution.',
    `settlement_contact_phone` STRING COMMENT 'The telephone number for the settlement contact used for resolving billing disputes, payment coordination, and financial reconciliation inquiries.',
    `tax_identification_number` STRING COMMENT 'The federal tax identification number (EIN for US entities, Business Number for Canadian entities) used for tax reporting and financial settlement with the ISO/RTO.',
    `total_registered_capacity_mw` DECIMAL(18,2) COMMENT 'The aggregate nameplate capacity in megawatts (MW) of all generation resources registered under this scheduling coordinator. Used for market monitoring and concentration analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this scheduling coordinator record was last modified in the data system. Used for tracking data currency and change management.',
    CONSTRAINT pk_scheduling_coordinator PRIMARY KEY(`scheduling_coordinator_id`)
) COMMENT 'Scheduling coordinator (SC) entity registered with an ISO/RTO to submit energy schedules, market bids, and settlement on behalf of the utilitys generation and load resources. Captures SC ID, ISO/RTO affiliation, registered resource list, SC type (generator, load-serving entity, marketer), OATT compliance status, NAESB scheduling certification, FERC market-based rate authorization reference, contact information, and active/inactive status. Required for ISO market participation eligibility and NAESB e-Tag scheduling authority.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` (
    `energy_schedule_id` BIGINT COMMENT 'Unique identifier for the energy schedule record. Primary key for the energy schedule entity.',
    `counterparty_id` BIGINT COMMENT 'Identifier of the counterparty entity involved in this energy schedule transaction. May be a bilateral trading partner, ISO/RTO, or scheduling coordinator.',
    `der_registry_id` BIGINT COMMENT 'Foreign key linking to renewable.der_registry. Business justification: DER scheduling: day-ahead and real-time energy schedules for DER resources must reference renewable.der_registry for point-of-interconnection identification, export/import limits, smart inverter capab',
    `dr_event_id` BIGINT COMMENT 'Foreign key linking to demand.dr_event. Business justification: Energy schedules must account for DR event curtailments. Real business process: transmission scheduling and balancing where DR events create load deviations requiring e-Tag adjustments and imbalance s',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Energy schedules are valued using energy price forecasts for settlement estimation and schedule optimization. Schedule valuation, congestion cost estimation, and transmission rights valuation require ',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.outage_event. Business justification: Energy schedules (e-Tags) are curtailed or modified when transmission/generation outages occur. NERC/NAESB coordination requires tracking which outage event caused schedule adjustments. Essential for ',
    `forecast_generation_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_generation. Business justification: E-tags and transmission schedules are created based on generation forecasts. Scheduling coordinators use generation forecasts to submit balanced schedules to ISOs/RTOs and avoid imbalance penalties. L',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Energy schedules (e-Tags) must reference the physical generation or load asset for NERC tagging requirements, balancing authority coordination, and transmission reservation validation. Mandatory for i',
    `load_id` BIGINT COMMENT 'Foreign key linking to forecast.load. Business justification: Transmission schedules must account for load forecasts at sink points to ensure adequate delivery and avoid congestion. Schedulers link schedules to load forecasts to optimize transmission path select',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: Energy schedules for distribution-connected DER aggregations are dispatched against specific load zones. Load zone hosting capacity and VVO status constrain DER scheduling. ADMS/ETRM integration requi',
    `market_participant_id` BIGINT COMMENT 'The unique identifier assigned to the market participant by the ISO/RTO for this energy schedule. Used for market settlement and reporting.',
    `planned_outage_window_id` BIGINT COMMENT 'Foreign key linking to outage.planned_outage_window. Business justification: Schedulers coordinate energy schedules with planned transmission/generation maintenance windows to avoid scheduling through de-energized facilities. Required for OASIS posting compliance and day-ahead',
    `position_id` BIGINT COMMENT 'Identifier linking this schedule to a Financial Transmission Right (FTR) position that hedges congestion risk between the source and sink nodes.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: PPA scheduling: energy schedules for PPA resources reference the contract for delivery point/pnode mapping, minimum/maximum delivery obligations, curtailment rights and compensation, and transmission ',
    `scheduling_coordinator_id` BIGINT COMMENT 'Identifier of the scheduling coordinator responsible for submitting and managing this schedule with the ISO/RTO. The SC acts as the interface between market participants and the system operator.',
    `storm_event_id` BIGINT COMMENT 'Foreign key linking to outage.storm_event. Business justification: Energy schedules are curtailed during storm events affecting transmission paths and delivery points. Scheduling coordinators track storm impacts for ISO/RTO settlement adjustments, force majeure claim',
    `trade_id` BIGINT COMMENT 'Unique identifier linking this schedule to the underlying energy trading transaction in the Energy Trading and Risk Management (ETRM) system. References the deal or position in OpenLink Endur.',
    `path_id` BIGINT COMMENT 'Identifier of the transmission path or corridor used for this energy schedule. Links to the transmission network topology and Available Transfer Capability (ATC) calculations.',
    `transmission_service_agreement_id` BIGINT COMMENT 'Identifier of the transmission service agreement under which this schedule is executed. References the OATT-compliant service reservation.',
    `ancillary_service_type` STRING COMMENT 'The type of ancillary service being scheduled, if applicable. Ancillary services support grid reliability and include regulation, reserves, and voltage support.. Valid values are `regulation_up|regulation_down|spinning_reserve|non_spinning_reserve|replacement_reserve|voltage_support`',
    `balancing_authority_code` STRING COMMENT 'The four-letter code identifying the NERC-registered Balancing Authority responsible for maintaining load-resource balance for this energy schedule.. Valid values are `^[A-Z]{4}$`',
    `comments` STRING COMMENT 'Free-text field for operational notes, special instructions, or additional context related to this energy schedule.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when this energy schedule was confirmed by the ISO/RTO or counterparty, indicating acceptance and readiness for execution.',
    `congestion_charge_usd` DECIMAL(18,2) COMMENT 'The congestion charge in US dollars associated with this energy schedule, calculated based on Locational Marginal Pricing (LMP) differences between source and sink nodes.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this energy schedule record was first created in the system. Used for audit trail and data lineage.',
    `curtailment_flag` BOOLEAN COMMENT 'Indicates whether this energy schedule has been subject to curtailment instructions from the transmission operator or ISO/RTO due to system constraints or reliability concerns.',
    `curtailment_mw` DECIMAL(18,2) COMMENT 'The megawatt amount by which this schedule has been curtailed. Represents the reduction from the originally scheduled MW due to transmission constraints or reliability directives.',
    `curtailment_reason` STRING COMMENT 'Textual explanation of the reason for schedule curtailment, such as transmission congestion, system emergency, or reliability constraint.',
    `curtailment_timestamp` TIMESTAMP COMMENT 'The date and time when the curtailment instruction was issued for this energy schedule.',
    `dynamic_schedule_flag` BOOLEAN COMMENT 'Indicates whether this is a dynamic schedule that allows real-time adjustments to scheduled MW values based on actual generation or load conditions, as opposed to a static schedule with fixed intervals.',
    `etag_reference_number` STRING COMMENT 'Unique electronic tag identifier assigned to this energy schedule for transmission system coordination and NERC compliance. The e-Tag is the industry-standard mechanism for scheduling energy transactions across transmission systems.. Valid values are `^[A-Z0-9]{10,20}$`',
    `interval_duration_minutes` STRING COMMENT 'The duration of each scheduling interval in minutes. Common values are 15, 30, or 60 minutes depending on ISO/RTO market rules.',
    `iso_rto_code` STRING COMMENT 'The code identifying the ISO or RTO jurisdiction where this energy schedule is executed. Major North American ISOs/RTOs include CAISO, ERCOT, MISO, PJM, NYISO, ISO-NE, and SPP. [ENUM-REF-CANDIDATE: CAISO|ERCOT|MISO|PJM|NYISO|ISO_NE|SPP — 7 candidates stripped; promote to reference product]',
    `loss_factor` DECIMAL(18,2) COMMENT 'The percentage factor representing energy losses during transmission from source to sink. Used to adjust scheduled quantities for line losses.',
    `modified_by` STRING COMMENT 'The username or identifier of the system user who last modified this energy schedule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this energy schedule record was last modified in the system. Used for audit trail and change tracking.',
    `number_of_intervals` STRING COMMENT 'The total count of scheduling intervals covered by this energy schedule. Calculated based on schedule duration and interval length.',
    `priority_code` STRING COMMENT 'The priority classification of this energy schedule under OATT rules. Firm schedules have higher priority than non-firm during curtailment events.. Valid values are `firm|non_firm|conditional_firm|network`',
    `rec_quantity` DECIMAL(18,2) COMMENT 'The quantity of Renewable Energy Certificates (RECs) in MWh associated with this energy schedule, if applicable. Used for renewable portfolio standard (RPS) compliance.',
    `rec_tracking_flag` BOOLEAN COMMENT 'Indicates whether this energy schedule is associated with renewable energy generation and requires Renewable Energy Certificate (REC) tracking for compliance or trading purposes.',
    `schedule_end_timestamp` TIMESTAMP COMMENT 'The date and time when the scheduled energy delivery ends. Marks the end of the last interval in the schedule.',
    `schedule_start_timestamp` TIMESTAMP COMMENT 'The date and time when the scheduled energy delivery begins. Marks the start of the first interval in the schedule.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the energy schedule indicating its operational state in the scheduling workflow. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|approved|active|curtailed|expired|cancelled|rejected — 9 candidates stripped; promote to reference product]',
    `schedule_type` STRING COMMENT 'Classification of the energy schedule indicating the nature of the transaction: bilateral contract, day-ahead market (DAM), real-time market (RTM), ancillary services, wheel-through transmission, or dynamic schedule.. Valid values are `bilateral|day_ahead_market|real_time_market|ancillary_service|wheel_through|dynamic`',
    `scheduled_mw` DECIMAL(18,2) COMMENT 'The total megawatt capacity scheduled for delivery in this energy schedule. Represents the aggregate power flow across all intervals.',
    `scheduled_mwh` DECIMAL(18,2) COMMENT 'The total energy quantity in megawatt-hours scheduled for delivery across the entire schedule period. Calculated as the sum of interval-level MWh values.',
    `scheduling_fee_usd` DECIMAL(18,2) COMMENT 'The administrative fee in US dollars charged by the ISO/RTO or scheduling coordinator for processing and managing this energy schedule.',
    `settlement_period` STRING COMMENT 'The year-month period (YYYY-MM format) for which this energy schedule will be financially settled by the ISO/RTO or counterparty.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `settlement_status` STRING COMMENT 'The current status of financial settlement for this energy schedule. Tracks progression from preliminary to final settlement and any disputes or adjustments.. Valid values are `pending|preliminary|final|disputed|adjusted`',
    `sink_pnode` STRING COMMENT 'The pricing node or location identifier where energy is delivered or withdrawn from the transmission system. Used for Locational Marginal Pricing (LMP) calculations.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `source_pnode` STRING COMMENT 'The pricing node or location identifier where energy is sourced or injected into the transmission system. Used for Locational Marginal Pricing (LMP) calculations.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when this energy schedule was submitted to the ISO/RTO or counterparty for approval and coordination.',
    `transmission_charge_usd` DECIMAL(18,2) COMMENT 'The transmission service charge in US dollars for using the transmission system to deliver energy under this schedule. Based on OATT rates.',
    `created_by` STRING COMMENT 'The username or identifier of the system user who created this energy schedule record in the ETRM system.',
    CONSTRAINT pk_energy_schedule PRIMARY KEY(`energy_schedule_id`)
) COMMENT 'Physical energy delivery schedule (e-Tag) submitted to ISO/RTO and counterparties for bilateral and market transactions. Captures schedule ID, source/sink PNodes, transmission path, scheduled MW by interval, e-Tag reference number, curtailment instructions, and schedule status (submitted, confirmed, curtailed, expired). Supports NAESB e-Tag compliance and real-time dispatch coordination.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`market_settlement` (
    `market_settlement_id` BIGINT COMMENT 'Unique identifier for the market settlement record. Primary key for all wholesale energy transaction settlements across ISO/RTO markets, bilateral OTC trades, PPA contracts, FTR congestion revenue, and capacity markets.',
    `contract_id` BIGINT COMMENT 'Reference to the underlying contract or agreement governing this settlement. Applicable for PPA settlements, bilateral contract settlements, and FTR holdings. Null for spot market settlements.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity involved in the settlement. For ISO/RTO settlements, this is the ISO/RTO organization; for bilateral trades, this is the trading counterparty; for PPA settlements, this is the power purchase agreement counterparty.',
    `dr_event_id` BIGINT COMMENT 'Foreign key linking to demand.dr_event. Business justification: Market settlements reconcile DR event performance payments. Real business process: ISO settlement statements allocating energy and capacity payments for DR dispatch, requiring event linkage for paymen',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Settlement price reconciliation compares actual LMPs to forecasted prices for variance analysis and dispute resolution. Settlement analysts link settlements to the price forecasts used for budgeting a',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: Market settlements for DER aggregations are allocated to distribution load zones for cost recovery reporting and distribution planning cost allocation. Utilities use this link in regulatory rate cases',
    `market_award_id` BIGINT COMMENT 'FK to trading.market_award.market_award_id — Settlements reconcile awarded quantities against actuals. The settlement→award FK is required for the settlement reconciliation process and dispute resolution.',
    `market_bid_id` BIGINT COMMENT 'FK to trading.market_bid.market_bid_id — ISO/RTO market settlements must link to the originating market bid/award for settlement verification and dispute resolution. Essential for DAM/RTM settlement reconciliation.',
    `market_participant_id` BIGINT COMMENT 'The unique identifier assigned by the ISO/RTO to the market participant (scheduling coordinator or qualified scheduling entity) for this settlement. Used for ISO/RTO market reconciliation.',
    `event_id` BIGINT COMMENT 'Foreign key linking to outage.event. Business justification: Market settlements include force majeure and outage-related adjustments. Unplanned events causing delivery failures require settlement recalculation with event references for dispute resolution, ISO/R',
    `planned_outage_window_id` BIGINT COMMENT 'Foreign key linking to outage.planned_outage_window. Business justification: Settlements account for planned outage impacts on delivery obligations. Scheduled maintenance windows affect capacity payments and energy delivery settlements with contractual curtailment provisions p',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Market settlements are calculated at specific pricing nodes. ISO/RTO settlement statements, congestion charge allocation, and FTR congestion revenue settlement all require node-level settlement record',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Financial settlement: market settlements for renewable resources must reference the PPA contract for contract price vs. market price comparison, REC allocation between energy and attributes, capacity ',
    `ppa_id` BIGINT COMMENT 'FK to trading.ppa.ppa_id — PPA settlements (now unified in market_settlement) must link back to the PPA contract for delivery reconciliation and invoice generation.',
    `trade_id` BIGINT COMMENT 'FK to trading.trade.trade_id — Settlement records must reference the trade they settle for reconciliation, P&L tracking, and audit trail. This is the core settlement→trade linkage in any ETRM system.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Market settlements with disputes or unusual charges trigger regulatory filings including FERC complaints, tariff interpretation requests, and cost recovery proceedings. Regulatory affairs references s',
    `tertiary_market_transaction_trade_id` BIGINT COMMENT 'Reference to the underlying energy transaction or trade record in the ETRM system that generated this settlement. Links settlement to the originating position or deal.',
    `accounting_period` STRING COMMENT 'The financial accounting period (e.g., 2024-Q1, 2024-03) to which this settlement is allocated for financial reporting purposes. Used for revenue recognition and accounts receivable/payable posting.',
    `ancillary_service_charge_amount` DECIMAL(18,2) COMMENT 'The total charges for ancillary services procured in conjunction with the energy settlement. Includes regulation, spinning reserve, non-spinning reserve, and voltage support charges as applicable.',
    `capacity_charge_amount` DECIMAL(18,2) COMMENT 'Charges for capacity obligations or capacity market settlements. Represents the cost of securing generation capacity to meet future demand, separate from energy commodity charges.',
    `congestion_charge_amount` DECIMAL(18,2) COMMENT 'The congestion component of the locational marginal price settlement. Represents the cost of transmission congestion between the generation source and the delivery point. May be positive (charge) or negative (credit).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was first created in the system. Audit trail field for data lineage and compliance.',
    `cumulative_profit_loss_amount` DECIMAL(18,2) COMMENT 'The running cumulative profit or loss for this trading position or contract through this settlement date. Calculated by summing all settlement amounts for the position from inception to current settlement. Used for mark-to-market valuation and position tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement. Typically USD for US markets or CAD for Canadian markets.. Valid values are `USD|CAD`',
    `delivery_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when energy delivery ended for the transaction being settled. For interval-based settlements, this marks the end of the settlement interval.',
    `delivery_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when energy delivery began for the transaction being settled. For interval-based settlements, this marks the beginning of the settlement interval.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this settlement is currently under dispute. True indicates an active dispute has been raised by either party; false indicates no dispute.',
    `dispute_raised_date` DATE COMMENT 'The date on which the settlement dispute was formally raised. Null if no dispute exists.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the settlement dispute. Captures the business justification for challenging the settlement calculation or amount. Null if no dispute exists.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the settlement dispute was resolved and closed. Null if dispute is still open or if no dispute exists.',
    `energy_charge_amount` DECIMAL(18,2) COMMENT 'The base energy charge calculated as settlement quantity multiplied by settlement price. Represents the core energy commodity cost before adjustments for ancillary services, congestion, losses, or uplift.',
    `ftr_congestion_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue earned or owed from financial transmission right holdings based on the locational marginal price differential between source and sink nodes. Hedges congestion cost exposure in ISO/RTO markets.',
    `gl_posting_date` DATE COMMENT 'The date on which this settlement was posted to the general ledger. Null if GL posting has not yet occurred.',
    `gl_posting_flag` BOOLEAN COMMENT 'Boolean indicator of whether this settlement has been posted to the general ledger in the ERP system. True indicates GL posting is complete; false indicates posting is pending.',
    `imbalance_charge_amount` DECIMAL(18,2) COMMENT 'Charges or credits resulting from deviations between scheduled and actual energy delivery. Calculated as the difference between day-ahead schedule and real-time delivery, settled at real-time market prices.',
    `iso_rto_code` STRING COMMENT 'The code identifying the ISO or RTO market in which the settlement occurred. Applicable only for ISO/RTO market settlements; null for bilateral and PPA settlements. [ENUM-REF-CANDIDATE: CAISO|ERCOT|MISO|PJM|NYISO|ISO-NE|SPP|AESO — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement record was most recently updated. Audit trail field for change tracking and compliance.',
    `loss_charge_amount` DECIMAL(18,2) COMMENT 'The marginal loss component of the locational marginal price settlement. Represents the cost of electrical losses incurred during transmission from generation to load.',
    `modified_by_user` STRING COMMENT 'The user identifier or system account that last modified this settlement record. Used for audit trail and accountability.',
    `netting_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustments applied during settlement netting process to reconcile multiple transactions, correct billing errors, or apply contractual netting provisions. May be positive or negative.',
    `payment_date` DATE COMMENT 'The actual date on which payment was made or received for this settlement. Null if payment is still pending.',
    `payment_due_date` DATE COMMENT 'The date by which payment for this settlement must be made or received. Determined by ISO/RTO market rules or bilateral contract payment terms.',
    `payment_status` STRING COMMENT 'Current status of the payment obligation for this settlement: pending processing, scheduled for payment, payment completed, payment received from counterparty, overdue past due date, or defaulted by counterparty.. Valid values are `pending|scheduled|paid|received|overdue|defaulted`',
    `rec_price_per_certificate` DECIMAL(18,2) COMMENT 'The unit price in dollars per renewable energy certificate. Applicable when RECs are bundled with energy settlement or traded separately. Null for non-renewable settlements.',
    `rec_quantity` DECIMAL(18,2) COMMENT 'The quantity of renewable energy certificates associated with this settlement, measured in MWh-equivalent. Applicable for renewable energy transactions and PPA settlements with REC bundling. Null for non-renewable settlements.',
    `settlement_date` DATE COMMENT 'The business date on which the settlement was calculated and finalized. Represents the principal event timestamp for this transaction header.',
    `settlement_interval_minutes` STRING COMMENT 'The duration of the settlement interval in minutes. Typically 5 minutes for real-time market settlements, 60 minutes for day-ahead market settlements, or custom intervals for bilateral contracts.',
    `settlement_price_per_mwh` DECIMAL(18,2) COMMENT 'The unit price in dollars per megawatt-hour at which the energy quantity is settled. For ISO/RTO markets, this is the locational marginal price (LMP); for bilateral trades, this is the contract price.',
    `settlement_quantity_mwh` DECIMAL(18,2) COMMENT 'The total quantity of energy settled in megawatt-hours (MWh). Represents the volume of energy delivered or received for which financial settlement is being calculated.',
    `settlement_reference_number` STRING COMMENT 'External business identifier for the settlement. May be ISO statement reference number, counterparty invoice number, or internal settlement batch identifier depending on settlement type.',
    `settlement_status` STRING COMMENT 'Current lifecycle state of the settlement record in the settlement workflow: draft calculation, pending approval, approved for payment, invoiced to/from counterparty, payment completed, under dispute, dispute resolved, or cancelled. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|invoiced|paid|disputed|resolved|cancelled — 8 candidates stripped; promote to reference product]',
    `settlement_type` STRING COMMENT 'Discriminator identifying the category of wholesale energy transaction being settled: ISO/RTO real-time market energy, ISO/RTO day-ahead market energy, ISO/RTO ancillary services, bilateral over-the-counter trade, power purchase agreement contract, financial transmission right congestion revenue, or capacity market settlement. [ENUM-REF-CANDIDATE: iso_rtm_energy|iso_dam_energy|iso_ancillary_service|bilateral_otc|ppa_contract|ftr_congestion_revenue|capacity_market — 7 candidates stripped; promote to reference product]',
    `total_settlement_amount` DECIMAL(18,2) COMMENT 'The net total settlement amount in US dollars after summing all charge components: energy, ancillary services, congestion, losses, uplift, imbalance, capacity, FTR revenue, and netting adjustments. Positive values indicate amounts owed to the utility; negative values indicate amounts payable.',
    `trade_date` DATE COMMENT 'The date on which the underlying energy transaction or trade was executed. For ISO/RTO markets, this is the operating day; for bilateral trades, this is the trade execution date.',
    `uplift_charge_amount` DECIMAL(18,2) COMMENT 'Additional charges allocated by the ISO/RTO to recover costs not captured in the energy and ancillary service prices. Includes make-whole payments, reliability unit commitment costs, and other out-of-market payments.',
    CONSTRAINT pk_market_settlement PRIMARY KEY(`market_settlement_id`)
) COMMENT 'Unified settlement record for all wholesale energy transaction types within the trading domain: ISO/RTO market settlements (DAM/RTM energy and ancillary services), bilateral OTC trade settlements, PPA contract settlements, FTR congestion revenue settlements, and capacity market settlements. Captures settlement type discriminator, settlement amount ($), quantity (MWh), settlement price, energy imbalance charges, ancillary service charges, congestion charges, loss charges, uplift charges, netting adjustments, payment due date, payment status, settlement interval, ISO statement reference or counterparty invoice reference, dispute status, dispute resolution date, and cumulative P&L tracking. For FTR settlements: congestion revenue earned/owed based on LMP differential, settlement period, and P&L against acquisition cost. Reconciled in OpenLink Endur and feeds accounts receivable/payable. SSOT for all settlement data in the trading domain. Supports FERC market reporting, bilateral contract compliance, and settlement dispute management.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`counterparty` (
    `counterparty_id` BIGINT COMMENT 'Unique identifier for the trading counterparty. Primary key for the counterparty master record.',
    `address_line_1` STRING COMMENT 'First line of the counterpartys registered business address, typically street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the counterpartys registered business address, typically suite or building information.',
    `approval_date` DATE COMMENT 'Date on which the counterparty was approved for trading by credit and legal departments.',
    `city` STRING COMMENT 'City name of the counterpartys registered business address.',
    `counterparty_status` STRING COMMENT 'Current operational status of the counterparty relationship indicating whether trading is permitted.. Valid values are `active|inactive|suspended|pending_approval|terminated`',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty based on their primary business function in energy markets.. Valid values are `generator|marketer|utility|financial_institution|municipality|cooperative`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the counterpartys primary country of operation.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the counterparty record was first created in the system.',
    `credit_rating_date` DATE COMMENT 'The date on which the current credit rating became effective. Used to track rating staleness and trigger re-evaluation.',
    `credit_rating_fitch` STRING COMMENT 'Current long-term issuer credit rating assigned by Fitch Ratings. Used for credit risk assessment and collateral determination.. Valid values are `AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC|CC|C|RD|D|NR`',
    `credit_rating_moodys` STRING COMMENT 'Current long-term issuer credit rating assigned by Moodys Investors Service. Used for credit risk assessment and collateral determination. [ENUM-REF-CANDIDATE: Aaa|Aa1|Aa2|Aa3|A1|A2|A3|Baa1|Baa2|Baa3|Ba1|Ba2|Ba3|B1|B2|B3|Caa1|Caa2|Caa3|Ca|C|NR — 22 candidates stripped; promote to reference product]',
    `credit_rating_sp` STRING COMMENT 'Current long-term issuer credit rating assigned by Standard & Poors rating agency. Used for credit risk assessment and collateral determination.. Valid values are `AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|D|NR`',
    `csa_effective_date` DATE COMMENT 'The date on which the Credit Support Annex with this counterparty became effective.',
    `csa_reference` STRING COMMENT 'Reference number or identifier for the Credit Support Annex governing collateral posting requirements for this counterparty.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business entity identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `eic_code` STRING COMMENT 'Standardized 16-character code for identifying parties in international energy markets, particularly for cross-border transactions.. Valid values are `^[0-9]{2}[A-Z0-9]{14}[A-Z]{1}$`',
    `ferc_eqr_counterparty_code` STRING COMMENT 'FERC-assigned identifier for counterparty used in Electric Quarterly Report filings for wholesale power transactions.',
    `internal_credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure amount in USD that the utility is willing to extend to this counterparty based on internal credit policy.',
    `isda_effective_date` DATE COMMENT 'The date on which the ISDA Master Agreement with this counterparty became effective.',
    `isda_master_agreement_reference` STRING COMMENT 'Reference number or identifier for the ISDA Master Agreement governing derivative transactions with this counterparty.',
    `iso_rto_participant_flag` BOOLEAN COMMENT 'Indicates whether the counterparty is a registered market participant in one or more ISO/RTO markets.',
    `jurisdiction` STRING COMMENT 'The primary legal jurisdiction or state/province where the counterparty is registered and operates, governing contract law and dispute resolution.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic credit review for this counterparty, used to trigger annual re-evaluation.',
    `legal_entity_name` STRING COMMENT 'The full legal name of the counterparty entity as registered with regulatory authorities. Used for contract execution and regulatory reporting.',
    `nerc_entity_code` STRING COMMENT 'NERC-assigned unique identifier for registered entities in the bulk electric system.',
    `nerc_registered_entity_flag` BOOLEAN COMMENT 'Indicates whether the counterparty is registered with NERC as a functional entity subject to reliability standards.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Indicates whether a payment netting agreement is in place with this counterparty, allowing offsetting of payables and receivables.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic credit review of this counterparty.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, special instructions, or historical context about the counterparty relationship.',
    `parent_company_duns` STRING COMMENT 'DUNS number of the parent company for hierarchical credit risk aggregation.. Valid values are `^[0-9]{9}$`',
    `parent_company_name` STRING COMMENT 'Legal name of the ultimate parent company or holding company for credit aggregation and consolidated risk assessment.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the counterpartys registered business address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for trading communications and confirmations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact for trading operations and contract administration.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary contact for urgent trading matters and operational coordination.',
    `short_name` STRING COMMENT 'Abbreviated or trading name used for operational reference and system displays.',
    `state_province` STRING COMMENT 'State or province code of the counterpartys registered business address.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN or SSN) for the counterparty entity used for tax reporting and 1099 generation.',
    `termination_date` DATE COMMENT 'Date on which the trading relationship with the counterparty was terminated or suspended.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the counterparty record was last modified.',
    CONSTRAINT pk_counterparty PRIMARY KEY(`counterparty_id`)
) COMMENT 'Trading counterparty master record for all entities with whom the utility executes wholesale energy trades, PPAs, capacity transactions, or ancillary service agreements. Captures legal entity name, DUNS number, EIC code (for international), FERC EQR counterparty ID, credit rating (S&P/Moodys/Fitch), credit rating date, jurisdiction, ISDA master agreement reference, CSA (Credit Support Annex) reference, netting agreement flag, and counterparty type (generator, marketer, utility, financial institution, municipality, cooperative). SSOT for counterparty identity in the trading domain.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` (
    `credit_exposure_id` BIGINT COMMENT 'Unique identifier for the counterparty credit exposure record.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Credit exposure calculations are audited for compliance with credit policies and FERC credit risk reporting requirements. Internal and external auditors test credit exposure methodology, limit complia',
    `counterparty_id` BIGINT COMMENT 'FK to trading.counterparty.counterparty_id — Credit exposure is calculated per counterparty. This is a fundamental master-detail relationship required for credit risk management and margin call processing.',
    `energy_price_id` BIGINT COMMENT 'Foreign key linking to forecast.energy_price. Business justification: Credit exposure calculations for forward contracts require energy price forecasts for mark-to-market valuation. Daily credit exposure reporting, margin call determination, and collateral management de',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to renewable.ppa_contract. Business justification: Counterparty credit: credit exposure calculations for PPA counterparties must reference renewable.ppa_contract for notional contract value, remaining term, mark-to-market exposure, collateral threshol',
    `primary_credit_counterparty_id` BIGINT COMMENT 'Identifier of the trading counterparty for which credit exposure is being tracked.',
    `to_counterparty_id` BIGINT COMMENT 'FK to trading.counterparty.counterparty_id — Credit exposure is calculated per counterparty. This FK is essential for credit limit monitoring, margin call triggers, and FERC credit reporting.',
    `collateral_posted_amount` DECIMAL(18,2) COMMENT 'Total value of collateral posted by the counterparty to secure credit exposure, including cash and letters of credit.',
    `collateral_type` STRING COMMENT 'Type of collateral instrument posted by the counterparty to mitigate credit risk.. Valid values are `cash|letter_of_credit|parent_guarantee|surety_bond|other`',
    `comments` STRING COMMENT 'Free-text field for risk management notes, special conditions, or explanations related to this credit exposure record.',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level used in the potential future exposure calculation, typically 95% or 99%.',
    `counterparty_credit_rating` STRING COMMENT 'External credit rating assigned to the counterparty by recognized rating agencies such as Moodys, S&P, or Fitch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit exposure record was first created in the system.',
    `credit_breach_flag` BOOLEAN COMMENT 'Indicator of whether the counterparty has breached their approved credit limit, triggering risk management actions.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit approved for this counterparty, representing the threshold beyond which additional trading is restricted.',
    `credit_limit_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the approved credit limit currently utilized, calculated as net exposure divided by credit limit.',
    `exposure_as_of_date` DATE COMMENT 'The business date for which this credit exposure snapshot is calculated.',
    `exposure_calculation_method` STRING COMMENT 'Methodology used to calculate potential future exposure, such as Monte Carlo simulation, historical simulation, or variance-covariance approach.. Valid values are `current_exposure|peak_exposure|monte_carlo|historical_simulation|variance_covariance`',
    `exposure_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the credit exposure is denominated.. Valid values are `^[A-Z]{3}$`',
    `exposure_status` STRING COMMENT 'Current status of the credit exposure indicating the risk management posture for this counterparty.. Valid values are `normal|watch|breach|suspended|default`',
    `ferc_reporting_flag` BOOLEAN COMMENT 'Indicator of whether this credit exposure must be included in FERC regulatory credit risk reporting.',
    `internal_credit_score` STRING COMMENT 'Internally calculated credit score for the counterparty based on proprietary risk assessment models.',
    `iso_rto_code` STRING COMMENT 'Code identifying the ISO or RTO market in which the counterparty trades, such as CAISO, ERCOT, PJM, MISO, NYISO, ISO-NE, or SPP.',
    `last_review_date` DATE COMMENT 'Date when the counterparty credit exposure was last reviewed by the credit risk management team.',
    `margin_call_due_date` DATE COMMENT 'Date by which the counterparty must satisfy the margin call by posting additional collateral.',
    `margin_call_issued_flag` BOOLEAN COMMENT 'Indicator of whether a margin call has been issued to the counterparty for this exposure date.',
    `margin_call_threshold_amount` DECIMAL(18,2) COMMENT 'Exposure threshold amount that triggers a margin call requiring the counterparty to post additional collateral.',
    `mtm_exposure_amount` DECIMAL(18,2) COMMENT 'Current mark-to-market exposure representing the replacement cost of all outstanding positions with this counterparty.',
    `net_exposure_amount` DECIMAL(18,2) COMMENT 'Net credit exposure after deducting collateral posted, representing the unsecured credit risk to the utility.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Indicator of whether a master netting agreement is in place with the counterparty, allowing offsetting of positive and negative exposures.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the counterparty credit exposure.',
    `pfe_amount` DECIMAL(18,2) COMMENT 'Estimated potential future exposure representing the maximum expected credit exposure over the life of the transactions, calculated using statistical models and market volatility.',
    `rec_tracking_flag` BOOLEAN COMMENT 'Indicator of whether this exposure includes positions in renewable energy certificates requiring separate tracking for compliance.',
    `time_horizon_days` STRING COMMENT 'Number of days over which the potential future exposure is projected, representing the expected liquidation period.',
    `total_exposure_amount` DECIMAL(18,2) COMMENT 'Total credit exposure calculated as the sum of mark-to-market exposure and potential future exposure before collateral adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit exposure record was last modified.',
    CONSTRAINT pk_credit_exposure PRIMARY KEY(`credit_exposure_id`)
) COMMENT 'Counterparty credit exposure record tracking mark-to-market exposure, potential future exposure (PFE), credit limit, collateral posted, and net exposure for each trading counterparty. Captures exposure as of date, credit limit utilization percentage, margin call threshold, collateral type (cash, letter of credit), and credit breach flag. Supports credit risk management and FERC credit reporting obligations.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`book` (
    `book_id` BIGINT COMMENT 'Unique identifier for the trading book within the Energy Trading and Risk Management (ETRM) system. Primary key.',
    `market_participant_id` BIGINT COMMENT 'Unique identifier assigned by the ISO/RTO for this trading books market participation. Used in day-ahead and real-time market bids, offers, and settlements.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Trading books are the unit of compliance for FERC market behavior rules, affiliate transaction restrictions, and ISO/RTO market manipulation prohibitions. Books must be configured to enforce specific ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Trading books are organized by ISO/RTO zone for position management and regulatory reporting. Book structure aligns with zones for risk limit management, position reporting, and market-specific compli',
    `approval_date` DATE COMMENT 'Date on which the risk committee or authorized governance body approved the creation and risk limits of this trading book.',
    `book_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the trading book for operational reference and reporting. Used in trade capture, position reporting, and regulatory filings.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `book_name` STRING COMMENT 'Full descriptive name of the trading book used for display and business communication. Examples: West Region Physical Power, Gas Hedging Portfolio, REC Trading Desk.',
    `book_status` STRING COMMENT 'Current operational status of the trading book. Active books accept new trades; suspended books are temporarily inactive; closed books are archived; pending approval books await risk committee authorization.. Valid values are `active|suspended|closed|pending_approval`',
    `book_type` STRING COMMENT 'Classification of the trading book by its primary business purpose. Physical books manage delivery obligations; financial books manage price risk; hedging books offset exposure; proprietary books capture speculative positions; structured books manage complex deals; ancillary services books manage grid support products.. Valid values are `physical|financial|hedging|proprietary|structured|ancillary_services`',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division that owns this trading book. Used for segment reporting and management accounting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `collateral_management_flag` BOOLEAN COMMENT 'Indicates whether this trading book requires active collateral management (margin calls, credit support annexes) for counterparty credit risk mitigation.',
    `commodity` STRING COMMENT 'Primary commodity or product traded within this book. Determines applicable market rules, settlement conventions, and regulatory reporting requirements. [ENUM-REF-CANDIDATE: power|natural_gas|coal|renewable_energy_credits|emissions_allowances|capacity|ancillary_services|fuel_oil — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trading book record was first created in the ETRM system. Used for audit trails and data lineage.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate credit exposure allowed across all counterparties for trades booked to this trading book, expressed in USD. Used for pre-trade credit checks.',
    `effective_date` DATE COMMENT 'Date on which this trading book became active and eligible to accept trades. Used for historical analysis and audit trails.',
    `emissions_allowance_registry_code` STRING COMMENT 'Identifier for the emissions allowance registry account (e.g., EPA CATR, RGGI COATS) associated with this trading book. Required for books trading carbon or NOx allowances.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `ferc_reporting_category` STRING COMMENT 'Federal Energy Regulatory Commission reporting category for this trading book. Determines which FERC forms and schedules apply (e.g., FERC Form 552 for wholesale power, FERC Form 2 for utilities).. Valid values are `wholesale_power|natural_gas|transmission_rights|ancillary_services|exempt`',
    `hedge_accounting_designation` STRING COMMENT 'Accounting treatment designation under ASC 815 (Derivatives and Hedging). Determines whether mark-to-market gains/losses flow through earnings or other comprehensive income.. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `internal_notes` STRING COMMENT 'Free-text field for internal operational notes, special instructions, or context about this trading book. Not visible to external parties or regulatory filings.',
    `iso_rto_code` STRING COMMENT 'Primary ISO or RTO market in which this trading book operates. Determines market rules, settlement procedures, and scheduling protocols. Non-ISO indicates bilateral or over-the-counter trading. [ENUM-REF-CANDIDATE: CAISO|ERCOT|MISO|PJM|NYISO|ISO-NE|SPP|non_iso — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this trading book record. Tracks changes to risk limits, status, or organizational assignments.',
    `master_netting_agreement_flag` BOOLEAN COMMENT 'Indicates whether trades in this book are subject to master netting agreements (e.g., ISDA, EEI) that allow offsetting of exposures across multiple transactions with the same counterparty.',
    `position_limit_quantity` DECIMAL(18,2) COMMENT 'Maximum net position quantity (long or short) allowed in this book, expressed in the commoditys standard unit of measure (MWh for power, MMBtu for gas). Enforces concentration risk controls.',
    `position_limit_uom` STRING COMMENT 'Unit of measure for the position limit quantity. Must align with the commodity type traded in this book.. Valid values are `MWh|MMBtu|tons|certificates|allowances`',
    `rec_tracking_system_code` STRING COMMENT 'Identifier for the REC tracking system registry account associated with this trading book (e.g., WREGIS, M-RETS, PJM-GATS). Required for books trading renewable energy certificates.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `region_code` STRING COMMENT 'Code representing the primary geographic region or market area for this trading book (e.g., WEST, EAST, ERCOT, MISO). Used for regional P&L reporting and market analysis.. Valid values are `^[A-Z]{2,10}$`',
    `risk_limit_var` DECIMAL(18,2) COMMENT 'Maximum allowable Value at Risk for this trading book, expressed in USD. Represents the risk appetite approved by the risk committee. Breaches trigger escalation and position reduction requirements.',
    `scheduling_coordinator_flag` BOOLEAN COMMENT 'Indicates whether this trading book acts as a Scheduling Coordinator (SC) responsible for submitting schedules and bids to the ISO/RTO on behalf of generation or load resources.',
    `settlement_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial settlements of trades in this book. Typically USD for North American energy markets.. Valid values are `^[A-Z]{3}$`',
    `termination_date` DATE COMMENT 'Date on which this trading book was closed or deactivated. Null for active books. Used for historical reporting and compliance retention.',
    `valuation_method` STRING COMMENT 'Method used to value positions in this trading book for financial reporting. Mark-to-market uses observable market prices; mark-to-model uses pricing models for illiquid products; accrual recognizes value at settlement.. Valid values are `mark_to_market|mark_to_model|accrual|lower_of_cost_or_market`',
    `var_confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level used for VaR calculation, typically 95% or 99%. Defines the probability threshold for the risk limit.',
    `var_time_horizon_days` STRING COMMENT 'Time horizon in days over which VaR is calculated, typically 1 day for daily risk monitoring or 10 days for regulatory capital calculations.',
    CONSTRAINT pk_book PRIMARY KEY(`book_id`)
) COMMENT 'Trading book master record defining the organizational unit within the ETRM system (OpenLink Endur) used to aggregate and manage related trades for P&L reporting, risk limits, and regulatory reporting. Captures book name, book type (physical, financial, hedging, proprietary), commodity, responsible trader/desk, risk limit (VaR), and FERC reporting category.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` (
    `settlement_statement_id` BIGINT COMMENT 'Primary key for settlement_statement',
    `aggregator_id` BIGINT COMMENT 'Foreign key linking to demand.aggregator. Business justification: Settlement statements are issued to aggregators for DR portfolio performance including capacity payments, energy settlements, and penalty assessments. Accounts payable processing, credit limit monitor',
    `contract_id` BIGINT COMMENT 'Identifier of the power purchase agreement or bilateral contract associated with the settlement.',
    `corrected_settlement_statement_id` BIGINT COMMENT 'Self-referencing FK on settlement_statement (corrected_settlement_statement_id)',
    `counterparty_id` BIGINT COMMENT 'Identifier of the counterparty (buyer or seller) involved in the settlement.',
    `dr_program_id` BIGINT COMMENT 'Foreign key linking to demand.dr_program. Business justification: Settlement statements reconcile financial obligations for DR program participation including capacity payments, energy credits, and performance penalties. Cost recovery filings, regulatory reporting t',
    `trade_id` BIGINT COMMENT 'Identifier of the underlying trade that this settlement statement settles.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustments (taxes, fees, penalties) applied to the gross amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement statement record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before adjustments, in settlement currency.',
    `invoice_number` STRING COMMENT 'Reference number of the invoice generated for this settlement.',
    `market_type` STRING COMMENT 'Market segment for which the settlement applies (e.g., day-ahead, real-time).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after adjustments, in settlement currency.',
    `payment_due_date` DATE COMMENT 'Date by which the net settlement amount must be paid.',
    `payment_status` STRING COMMENT 'Current payment status of the settlement.',
    `posted_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement statement was posted to the ledger.',
    `price_per_mwh` DECIMAL(18,2) COMMENT 'Settlement price applied per megawatt-hour.',
    `product_type` STRING COMMENT 'Energy product category settled by this statement.',
    `quantity_mwh` DECIMAL(18,2) COMMENT 'Energy quantity settled, expressed in megawatt-hours.',
    `remarks` STRING COMMENT 'Free‑form comments or notes related to the settlement.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this settlement statement represents a reversal of a prior settlement.',
    `settlement_date` DATE COMMENT 'Date on which the settlement transaction is considered effective.',
    `settlement_method` STRING COMMENT 'Process used to generate the settlement (automated, manual, or batch).',
    `settlement_period_end` DATE COMMENT 'End date of the settlement period covered by this statement.',
    `settlement_period_start` DATE COMMENT 'Start date of the settlement period covered by this statement.',
    `settlement_statement_status` STRING COMMENT 'Current lifecycle status of the settlement statement.',
    `settlement_version` STRING COMMENT 'Version number for the settlement statement to support amendments.',
    `source_system` STRING COMMENT 'Originating system that produced the settlement data (e.g., OpenLink Endur).',
    `statement_number` STRING COMMENT 'External reference number assigned to the settlement statement by the trading system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement statement record.',
    CONSTRAINT pk_settlement_statement PRIMARY KEY(`settlement_statement_id`)
) COMMENT 'Master reference table for settlement_statement. Referenced by settlement_statement_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `counterparty_id` BIGINT COMMENT 'Unique identifier of the counterparty organization associated with the contract.',
    `master_contract_id` BIGINT COMMENT 'Self-referencing FK on contract (master_contract_id)',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Contracts trigger specific compliance obligations: FERC affiliate transaction rules, state prudency review requirements, and ISO/RTO resource adequacy obligations. Contract type and counterparty relat',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to distribution.service_territory. Business justification: Bilateral energy supply contracts are scoped to specific service territories for load-serving obligation compliance, IRP filings, and PUC regulatory reporting. Utilities must demonstrate contracted su',
    `collateral_amount` DECIMAL(18,2) COMMENT 'Monetary collateral posted to secure the contract.',
    `collateral_currency` STRING COMMENT 'Currency of the collateral amount.',
    `contract_description` STRING COMMENT 'Free‑text description providing additional details about the contract.',
    `contract_name` STRING COMMENT 'Descriptive name of the contract for easy reference by traders and analysts.',
    `contract_number` STRING COMMENT 'External business identifier assigned to the contract, used in trading and regulatory reporting.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract (e.g., active, pending, suspended, terminated).',
    `contract_type` STRING COMMENT 'Category of the agreement such as Power Purchase Agreement, Capacity Contract, Ancillary Service, or Financial Swap.',
    `counterparty_credit_rating` STRING COMMENT 'Credit rating assigned to the counterparty (e.g., A+, BBB).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the counterparty under this contract.',
    `credit_limit_currency` STRING COMMENT 'Currency of the credit limit amount.',
    `delivery_point_code` STRING COMMENT 'Identifier of the delivery location or node in the grid.',
    `effective_end_date` DATE COMMENT 'Date on which the contract expires or terminates, if applicable.',
    `effective_start_date` DATE COMMENT 'Date on which the contract becomes legally binding and operational.',
    `ferc_reportable_flag` BOOLEAN COMMENT 'True if the contract must be reported to the Federal Energy Regulatory Commission.',
    `index_price` DECIMAL(18,2) COMMENT 'Most recent value of the price index used for the contract.',
    `index_price_currency` STRING COMMENT 'Currency of the index price, using ISO 4217 code.',
    `is_exercisable` BOOLEAN COMMENT 'True if the contract includes exercisable options (e.g., call/put).',
    `is_firm` BOOLEAN COMMENT 'Indicates whether the contract is firm (obligatory) or non‑firm (optional).',
    `is_hedge` BOOLEAN COMMENT 'True if the contract is used for hedging market exposure.',
    `is_indexed` BOOLEAN COMMENT 'True if the contract price is tied to an external index.',
    `is_renewable` BOOLEAN COMMENT 'True if the contract pertains to renewable energy generation.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction governing the contract (state, province, or country).',
    `market` STRING COMMENT 'Electricity market or ISO/RTO where the contract is executed (e.g., CAISO, ERCOT).',
    `naesb_compliance_flag` BOOLEAN COMMENT 'True if the contract complies with NAESB standards.',
    `payment_due_date` DATE COMMENT 'Standard due date for each payment cycle.',
    `payment_frequency` STRING COMMENT 'How often payments are due (e.g., monthly, quarterly).',
    `payment_terms` STRING COMMENT 'Textual description of payment conditions (e.g., net 30, net 45).',
    `price_amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the contract price per unit.',
    `price_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the contract price.',
    `pricing_type` STRING COMMENT 'Method used to calculate contract price (e.g., fixed, indexed, variable).',
    `product_type` STRING COMMENT 'Type of energy product covered (e.g., energy, capacity, ancillary service).',
    `regulatory_reporting_code` STRING COMMENT 'Code used for mandatory regulatory filings (e.g., FERC schedule code).',
    `renewal_option` STRING COMMENT 'Indicates whether the contract includes an automatic renewal clause (e.g., none, optional, mandatory).',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months when a renewal option is exercised.',
    `settlement_point_code` STRING COMMENT 'Identifier of the settlement location used for financial settlement.',
    `signed_date` DATE COMMENT 'Date the contract was signed by all parties.',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the contract is exempt from applicable taxes.',
    `termination_date` DATE COMMENT 'Actual date the contract was terminated before its scheduled end, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'Total energy volume covered by the contract.',
    `volume_unit` STRING COMMENT 'Unit of measure for the contract volume (e.g., MWh, GWh).',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master reference table for contract. Referenced by contract_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`market_participant` (
    `market_participant_id` BIGINT COMMENT 'Primary key for market_participant',
    `parent_market_participant_id` BIGINT COMMENT 'Self-referencing FK on market_participant (parent_market_participant_id)',
    `address_line1` STRING COMMENT 'First line of the participants primary address.',
    `address_line2` STRING COMMENT 'Second line of the address, if applicable.',
    `bank_account_number` STRING COMMENT 'Bank account number for settlements.',
    `bank_routing_number` STRING COMMENT 'Routing number of the settlement bank.',
    `city` STRING COMMENT 'City of the primary address.',
    `classification_code` STRING COMMENT 'Internal classification code for reporting and segmentation.',
    `compliance_status` STRING COMMENT 'Current compliance status with regulatory requirements.',
    `country` STRING COMMENT 'Three-letter ISO country code of the participants primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the market participant record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for the participant.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the participant.',
    `default_settlement_method` STRING COMMENT 'Preferred method for settling financial transactions.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier.',
    `effective_from` DATE COMMENT 'Date when the participant became active in the market.',
    `effective_until` DATE COMMENT 'Date when the participants market participation ends, if applicable.',
    `ferc_code` STRING COMMENT 'Identifier used for FERC market reporting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the participant is currently active (true) or not (false).',
    `iso_participant_code` STRING COMMENT 'Identifier assigned by the Independent System Operator.',
    `last_credit_review_date` DATE COMMENT 'Date of the most recent credit review.',
    `market_participant_code` STRING COMMENT 'Internal code used for trading system identification.',
    `market_participant_name` STRING COMMENT 'Full legal name of the market participant as registered.',
    `market_participant_status` STRING COMMENT 'Current operational status of the participant.',
    `naesb_code` STRING COMMENT 'Identifier used in NAESB reporting.',
    `notes` STRING COMMENT 'Free-text field for additional remarks or notes about the participant.',
    `participant_role` STRING COMMENT 'Primary role of the participant in market transactions.',
    `participant_type` STRING COMMENT 'Category of the participant in the electricity market.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the primary address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the participant.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `registration_number` STRING COMMENT 'Official registration number assigned by regulatory authority.',
    `reporting_entity_flag` BOOLEAN COMMENT 'True if the participant is required to submit regulatory reports.',
    `risk_category` STRING COMMENT 'Internal risk classification based on credit and exposure.',
    `settlement_currency` STRING COMMENT 'Currency used for financial settlements with the participant.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the participant.',
    `state` STRING COMMENT 'State or province of the primary address.',
    `tax_identifier` STRING COMMENT 'Tax ID used for reporting and withholding.',
    `tax_status` STRING COMMENT 'Tax status applicable to the participant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the market participant record.',
    CONSTRAINT pk_market_participant PRIMARY KEY(`market_participant_id`)
) COMMENT 'Master reference table for market_participant. Referenced by market_participant_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`portfolio` (
    `portfolio_id` BIGINT COMMENT 'Primary key for portfolio',
    `parent_portfolio_id` BIGINT COMMENT 'Self-referencing FK on portfolio (parent_portfolio_id)',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Portfolios are organized by zone for risk management and regulatory reporting. Portfolio risk reporting, position limits, and ISO/RTO-specific compliance are zone-based in organized electricity market',
    `compliance_status` STRING COMMENT 'Current compliance status of the portfolio with regulatory requirements.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the portfolio record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary values associated with the portfolio.',
    `effective_from` DATE COMMENT 'Date when the portfolio became effective.',
    `effective_until` DATE COMMENT 'Date when the portfolio expires or is terminated; null if open‑ended.',
    `is_historical` BOOLEAN COMMENT 'Indicates whether the portfolio is historical (true) or active (false).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the portfolio record.',
    `last_valuation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent portfolio valuation.',
    `market` STRING COMMENT 'Market segment in which the portfolio participates.',
    `portfolio_code` STRING COMMENT 'External business code used to reference the portfolio in contracts and reports.',
    `portfolio_description` STRING COMMENT 'Free‑text description providing additional context about the portfolio.',
    `portfolio_name` STRING COMMENT 'Human‑readable name of the portfolio.',
    `portfolio_status` STRING COMMENT 'Current lifecycle status of the portfolio.',
    `portfolio_type` STRING COMMENT 'Category indicating the nature of the portfolio.',
    `region` STRING COMMENT 'Primary geographic region associated with the portfolio.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk metric representing the portfolios risk exposure.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Monetary valuation of the portfolio at the valuation date.',
    `valuation_date` DATE COMMENT 'Date on which the portfolio valuation was performed.',
    CONSTRAINT pk_portfolio PRIMARY KEY(`portfolio_id`)
) COMMENT 'Master reference table for portfolio. Referenced by portfolio_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`market_run` (
    `market_run_id` BIGINT COMMENT 'Primary key for market_run',
    `forecast_run_id` BIGINT COMMENT 'Foreign key linking to forecast.forecast_run. Business justification: Market clearing runs (day-ahead/real-time) use specific forecast runs as inputs for load and generation. Market operations audit trail and settlement dispute resolution require linking market runs to ',
    `market_participant_id` BIGINT COMMENT 'Identifier of the primary market participant associated with the run.',
    `superseded_market_run_id` BIGINT COMMENT 'Self-referencing FK on market_run (superseded_market_run_id)',
    `ancillary_service_flag` BOOLEAN COMMENT 'True if ancillary services (e.g., regulation, spinning reserve) were priced.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the run was formally approved.',
    `approved_by` STRING COMMENT 'User name or identifier of the person who approved the run results.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the run against market rules.',
    `congestion_price_flag` BOOLEAN COMMENT 'True if congestion pricing was applied in this run.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the market run record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the overall data quality of the run.',
    `data_source_system` STRING COMMENT 'Originating system that generated the market run data (e.g., OpenLink, Eikon).',
    `end_timestamp` TIMESTAMP COMMENT 'Exact time when the market run execution finished.',
    `forecast_flag` BOOLEAN COMMENT 'Indicates whether the run is a forecast (true) or actual market outcome (false).',
    `iso_rto_code` STRING COMMENT 'Three‑letter code identifying the ISO or RTO.',
    `last_modified_by` STRING COMMENT 'User who performed the most recent update to the record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `market_date` DATE COMMENT 'The calendar date for which the market run prices apply.',
    `market_run_status` STRING COMMENT 'Current processing state of the market run.',
    `price_type` STRING COMMENT 'Type of price produced by the run (e.g., Locational Marginal Price).',
    `pricing_method` STRING COMMENT 'Methodology used to calculate market prices.',
    `region` STRING COMMENT 'Regional transmission organization or independent system operator associated with the run.',
    `regulatory_report_flag` BOOLEAN COMMENT 'Indicates whether the run data is required for regulatory reporting.',
    `run_category` STRING COMMENT 'Business categorization of the run for reporting purposes.',
    `run_code` STRING COMMENT 'System‑generated code used to reference the run in downstream systems.',
    `run_duration_minutes` STRING COMMENT 'Total elapsed time of the run in minutes.',
    `run_name` STRING COMMENT 'Human‑readable name describing the market run (e.g., "DA 2024‑05‑01").',
    `run_notes` STRING COMMENT 'Free‑form comments or observations about the run.',
    `run_priority` STRING COMMENT 'Numeric priority used to order runs when multiple are scheduled.',
    `run_result_summary` STRING COMMENT 'Brief textual summary of key outcomes from the run.',
    `run_status_reason` STRING COMMENT 'Explanation for the current status, especially when failed or cancelled.',
    `run_type` STRING COMMENT 'Category of the market run indicating the market horizon or purpose.',
    `run_version` STRING COMMENT 'Version identifier for the run logic or configuration.',
    `settlement_date` DATE COMMENT 'Date on which financial settlement for the run occurs.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact time when the market run execution began.',
    `test_run_flag` BOOLEAN COMMENT 'True if the run was executed for testing or validation purposes.',
    `total_value_usd` DECIMAL(18,2) COMMENT 'Total monetary value of the cleared energy, expressed in US dollars.',
    `total_volume_mwh` DECIMAL(18,2) COMMENT 'Aggregate energy volume cleared by the run, measured in megawatt‑hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the market run record.',
    `created_by` STRING COMMENT 'User name or identifier of the person who created the record.',
    CONSTRAINT pk_market_run PRIMARY KEY(`market_run_id`)
) COMMENT 'Master reference table for market_run. Referenced by market_run_id.';

CREATE OR REPLACE TABLE `energy_utilities_ecm`.`trading`.`delivery_point` (
    `delivery_point_id` BIGINT COMMENT 'Primary key for delivery_point',
    `aggregate_delivery_point_id` BIGINT COMMENT 'Self-referencing FK on delivery_point (aggregate_delivery_point_id)',
    `distribution_substation_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_substation. Business justification: Distribution-connected trading delivery points are physically located at distribution substations. Utilities map this for interconnection studies, DER market participation, and settlement point valida',
    `load_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.load_zone. Business justification: DER aggregation and demand response settlement require mapping trading delivery points to distribution load zones. Utilities use this link for hosting capacity validation, DER dispatch constraints, an',
    `meter_id` BIGINT COMMENT 'Unique identifier of the meter associated with the delivery point.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Delivery points are often physical substations, interconnection points, or metering locations tracked as assets for maintenance coordination, outage impact analysis, and capacity limit enforcement. Li',
    `pnode_id` BIGINT COMMENT 'Foreign key linking to transmission.pnode. Business justification: Trading delivery points map to transmission pricing nodes for LMP settlement and energy scheduling. This mapping is fundamental to ISO/RTO market operations — every metered delivery point corresponds ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to forecast.zone. Business justification: Delivery points are located within forecast zones for load forecasting and LMP forecasting. Zone-aggregated load forecasting and price forecasting require delivery point to zone mapping as fundamental',
    `address_line1` STRING COMMENT 'Primary street address of the delivery point.',
    `ancillary_service_eligible` BOOLEAN COMMENT 'True if the delivery point can provide or receive ancillary services.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity of the delivery point in megawatts.',
    `city` STRING COMMENT 'City where the delivery point is located.',
    `congestion_price_zone` STRING COMMENT 'Identifier of the congestion pricing zone applicable to the delivery point.',
    `contract_number` STRING COMMENT 'External contract identifier governing the delivery point.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the delivery point location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the delivery point record was first created in the lakehouse.',
    `data_source_system` STRING COMMENT 'Name of the operational system of record that supplied the data (e.g., OpenLink Endur).',
    `delivery_point_code` STRING COMMENT 'External code or alphanumeric identifier used in trading and settlement systems.',
    `delivery_point_description` STRING COMMENT 'Free‑form description or notes about the delivery point.',
    `delivery_point_name` STRING COMMENT 'Human‑readable name of the delivery point (e.g., "North Substation" or "Customer Site A").',
    `delivery_point_status` STRING COMMENT 'Current operational status of the delivery point.',
    `effective_from` DATE COMMENT 'Date when the delivery point became legally effective for trading.',
    `effective_until` DATE COMMENT 'Date when the delivery point ceases to be effective; null if open‑ended.',
    `is_grid_connected` BOOLEAN COMMENT 'Indicates whether the delivery point is physically connected to the transmission grid.',
    `last_meter_read_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent meter reading.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the delivery point in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the delivery point in decimal degrees.',
    `market_zone` STRING COMMENT 'ISO/RTO market zone to which the delivery point belongs.',
    `meter_reading_interval_minutes` STRING COMMENT 'Scheduled interval between meter reads.',
    `meter_type` STRING COMMENT 'Technology type of the meter.',
    `metered` BOOLEAN COMMENT 'Indicates whether the delivery point has an active meter for usage measurement.',
    `ownership_type` STRING COMMENT 'Entity that owns the delivery point.',
    `point_type` STRING COMMENT 'Category of the delivery point within the grid topology.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the delivery point location.',
    `region_code` STRING COMMENT 'Internal code representing the geographic or market region of the delivery point.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'True if the delivery point must be included in mandatory regulatory reports (e.g., FERC).',
    `settlement_point_code` STRING COMMENT 'Code used for market settlement and LMP calculations.',
    `state` STRING COMMENT 'State or province of the delivery point.',
    `tariff_code` STRING COMMENT 'Code representing the tariff schedule applied to the delivery point.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the delivery point record.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Rated voltage level of the delivery point expressed in kilovolts.',
    CONSTRAINT pk_delivery_point PRIMARY KEY(`delivery_point_id`)
) COMMENT 'Master reference table for delivery_point. Referenced by delivery_point_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_book_id` FOREIGN KEY (`book_id`) REFERENCES `energy_utilities_ecm`.`trading`.`book`(`book_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_trade_broker_counterparty_id` FOREIGN KEY (`trade_broker_counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_trade_counterparty_id` FOREIGN KEY (`trade_counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_to_trade_id` FOREIGN KEY (`to_trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_book_id` FOREIGN KEY (`book_id`) REFERENCES `energy_utilities_ecm`.`trading`.`book`(`book_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `energy_utilities_ecm`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_to_counterparty_id` FOREIGN KEY (`to_counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_book_id` FOREIGN KEY (`book_id`) REFERENCES `energy_utilities_ecm`.`trading`.`book`(`book_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_market_bid_id` FOREIGN KEY (`market_bid_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_bid`(`market_bid_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ADD CONSTRAINT `fk_trading_lmp_price_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ADD CONSTRAINT `fk_trading_lmp_price_market_run_id` FOREIGN KEY (`market_run_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_run`(`market_run_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_position_id` FOREIGN KEY (`position_id`) REFERENCES `energy_utilities_ecm`.`trading`.`position`(`position_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_market_award_id` FOREIGN KEY (`market_award_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_award`(`market_award_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_market_bid_id` FOREIGN KEY (`market_bid_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_bid`(`market_bid_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_tertiary_market_transaction_trade_id` FOREIGN KEY (`tertiary_market_transaction_trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_primary_credit_counterparty_id` FOREIGN KEY (`primary_credit_counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_to_counterparty_id` FOREIGN KEY (`to_counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ADD CONSTRAINT `fk_trading_book_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ADD CONSTRAINT `fk_trading_settlement_statement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ADD CONSTRAINT `fk_trading_settlement_statement_corrected_settlement_statement_id` FOREIGN KEY (`corrected_settlement_statement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ADD CONSTRAINT `fk_trading_settlement_statement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ADD CONSTRAINT `fk_trading_settlement_statement_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ADD CONSTRAINT `fk_trading_contract_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ADD CONSTRAINT `fk_trading_contract_master_contract_id` FOREIGN KEY (`master_contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ADD CONSTRAINT `fk_trading_market_participant_parent_market_participant_id` FOREIGN KEY (`parent_market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` ADD CONSTRAINT `fk_trading_portfolio_parent_portfolio_id` FOREIGN KEY (`parent_portfolio_id`) REFERENCES `energy_utilities_ecm`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` ADD CONSTRAINT `fk_trading_market_run_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` ADD CONSTRAINT `fk_trading_market_run_superseded_market_run_id` FOREIGN KEY (`superseded_market_run_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_run`(`market_run_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_aggregate_delivery_point_id` FOREIGN KEY (`aggregate_delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);

-- ========= TAGS =========
ALTER SCHEMA `energy_utilities_ecm`.`trading` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `energy_utilities_ecm`.`trading` SET TAGS ('dbx_domain' = 'trading');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `book_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Der System Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `scheduling_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_broker_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `collateral_posted` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `collateral_posted` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `commodity` SET TAGS ('dbx_value_regex' = 'power|gas|rec|capacity|ancillary_services|ftr');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Method');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_value_regex' = 'isda|broker|electronic|manual|exchange');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'unconfirmed|confirmed|disputed|resolved');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `counterparty_acknowledgment_received` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Acknowledgment Received Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `discrepancy_details` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Details');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `ferc_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reporting Category');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Trade Notes');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|term|spot');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Trade Price');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Trade Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `rec_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Vintage Year');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'physical|financial|cash');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Trade Value');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|amended|cancelled|settled|voided');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `trade_type` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `transaction_category` SET TAGS ('dbx_value_regex' = 'bilateral|exchange|otc|iso_rto|ppa');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|MMBtu|MW|certificates|rights');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `trade_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Leg Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `scheduling_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `ancillary_services_included` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Included');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `booking_entity` SET TAGS ('dbx_business_glossary_term' = 'Booking Entity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `collateral_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Requirement Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `collateral_requirement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `congestion_revenue_rights_quantity` SET TAGS ('dbx_business_glossary_term' = 'Congestion Revenue Rights (CRR) Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `delivery_point_hub` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Hub');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `delivery_point_pnode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Pricing Node (PNode)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `fixed_price` SET TAGS ('dbx_business_glossary_term' = 'Fixed Price');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `heat_rate` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_direction` SET TAGS ('dbx_business_glossary_term' = 'Leg Direction');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_direction` SET TAGS ('dbx_value_regex' = 'buy|sell|receive|pay');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_business_glossary_term' = 'Leg Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_value_regex' = 'active|pending|executed|settled|cancelled|expired');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_business_glossary_term' = 'Leg Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|physical_delivery|financial_settlement|option|swap');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|forward|futures');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `notional_quantity` SET TAGS ('dbx_business_glossary_term' = 'Notional Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `option_exercise_style` SET TAGS ('dbx_business_glossary_term' = 'Option Exercise Style');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `option_exercise_style` SET TAGS ('dbx_value_regex' = 'american|european|bermudan|none');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `option_type` SET TAGS ('dbx_business_glossary_term' = 'Option Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `option_type` SET TAGS ('dbx_value_regex' = 'call|put|swaption|collar|none');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `price_formula` SET TAGS ('dbx_business_glossary_term' = 'Price Formula');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_value_regex' = 'USD_per_MWh|USD_per_MW|USD_per_kW_month|USD_per_MMBtu');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|MW|GWh|kWh|MMBtu|Dth');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `rec_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Vintage Year');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `renewable_energy_certificate_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'physical|financial|cash|netting');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `strike_price` SET TAGS ('dbx_business_glossary_term' = 'Strike Price');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `time_of_use_profile` SET TAGS ('dbx_business_glossary_term' = 'Time of Use (TOU) Profile');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `tolling_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Tolling Agreement Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade_leg` ALTER COLUMN `transmission_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Transmission Rights Included');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` SET TAGS ('dbx_subdomain' = 'portfolio_operations');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `dr_program_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `forecast_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Lmp Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Load Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `business_date` SET TAGS ('dbx_business_glossary_term' = 'Business Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `congestion_revenue_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Congestion Revenue Right (CRR) Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `credit_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period End Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period Start Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) or Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MtM) Value');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|forward|bilateral|ancillary_services');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `net_position_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Position Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|closed|settled|pending_settlement|cancelled');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `rec_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Position Snapshot Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Position Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `unrealized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Profit and Loss (P&L)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'lmp_spot|forward_curve|bilateral_price|cost_plus|index_based');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `value_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level');
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon in Days');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` SET TAGS ('dbx_subdomain' = 'portfolio_operations');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `ppa_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `scheduling_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `annual_energy_volume_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Volume (Megawatt-Hours)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `capacity_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (Percent)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `contract_amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Count');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Years)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `contracted_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity (Megawatts)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `credit_rating_requirement` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Rating Requirement');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `curtailment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Allowed Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `curtailment_compensation_rate` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Compensation Rate (USD per MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `curtailment_compensation_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `ferc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Reference');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `fixed_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Fixed Price per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `fixed_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `force_majeure_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `iso_rto_market` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Market');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `minimum_take_obligation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Minimum Take Obligation (Megawatt-Hours)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `price_escalation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Rate (Percent)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `price_escalation_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `rec_bundled_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Bundled Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'hourly|daily|monthly|quarterly|annual');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` SET TAGS ('dbx_subdomain' = 'portfolio_operations');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `ppa_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Delivery ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Source ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `forecast_renewable_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Renewable Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `output_telemetry_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Output Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `ppa_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Settlement Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `scheduling_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `actual_delivered_mwh` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivered Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `ancillary_services_charge` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Charge');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `congestion_charge` SET TAGS ('dbx_business_glossary_term' = 'Congestion Charge');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `contract_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Contract Price per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `contract_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `curtailment_instruction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Instruction Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `curtailment_mwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `curtailment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `curtailment_reason_code` SET TAGS ('dbx_value_regex' = 'grid_congestion|economic_dispatch|forced_outage|maintenance|iso_instruction|environmental_limit');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|missing|suspect|verified');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `delivery_interval_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `delivery_interval_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `deviation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Deviation Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `energy_charge` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `force_majeure_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `lmp_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `loss_charge` SET TAGS ('dbx_business_glossary_term' = 'Loss Charge');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|ancillary_services');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Source');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_value_regex' = 'scada|revenue_meter|iso_settlement|estimated');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `rec_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Serial Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `scheduled_mwh` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `settlement_run_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `settlement_run_type` SET TAGS ('dbx_value_regex' = 'initial|recalculation_1|recalculation_2|final|true_up');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'openlink_endur|iso_settlement|scada|mdm|manual_entry');
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `market_bid_id` SET TAGS ('dbx_business_glossary_term' = 'Market Bid Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `battery_storage_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `book_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `forecast_renewable_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Renewable Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Path Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `planned_outage_window_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Window Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `award_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `awarded_mw` SET TAGS ('dbx_business_glossary_term' = 'Awarded Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_curve_segments` SET TAGS ('dbx_business_glossary_term' = 'Bid Curve Segments');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Bid Price per Megawatt-Hour ($/MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_quantity_mw` SET TAGS ('dbx_business_glossary_term' = 'Bid Quantity in Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Reference Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Bid Strategy Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_strategy_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `bid_type` SET TAGS ('dbx_value_regex' = 'energy|ancillary_service|capacity|financial_transmission_right|congestion_revenue_right');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `clearing_price_lmp` SET TAGS ('dbx_business_glossary_term' = 'Clearing Price - Locational Marginal Price (LMP) in $/MWh');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `cost_allocation_tariff` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Tariff');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `cost_allocation_tariff` SET TAGS ('dbx_value_regex' = 'transmission|distribution|generation|customer');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `counterparty_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `counterparty_credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `curtailment_instructions` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Instructions');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `etag_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Tag (e-Tag) Reference Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `ferc_eqr_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'FERC Electric Quarterly Report (EQR) Reported Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `iso_award_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO Award Reference for Ancillary Services');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `iso_confirmation_reference` SET TAGS ('dbx_business_glossary_term' = 'ISO Confirmation Reference Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `market_interval_end` SET TAGS ('dbx_business_glossary_term' = 'Market Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `market_interval_start` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|hour_ahead|intraday');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `naesb_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'NAESB Compliant Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `procured_mw` SET TAGS ('dbx_business_glossary_term' = 'Procured Megawatts (MW) for Ancillary Services');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `procurement_price_per_mw_hr` SET TAGS ('dbx_business_glossary_term' = 'Procurement Price per Megawatt-Hour ($/MW-hr)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `rec_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'submitted|confirmed|curtailed|expired|cancelled');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `scheduled_mw_by_interval` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Megawatts (MW) by Interval');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount in USD');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `sink_pnode` SET TAGS ('dbx_business_glossary_term' = 'Sink Pricing Node (PNode)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `source_pnode` SET TAGS ('dbx_business_glossary_term' = 'Source Pricing Node (PNode)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `market_award_id` SET TAGS ('dbx_business_glossary_term' = 'Market Award Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `battery_storage_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Asset Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `der_system_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `energy_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `interconnection_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Queue Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Lmp Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `market_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Market Participant Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `planned_outage_window_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Window Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `market_bid_id` SET TAGS ('dbx_business_glossary_term' = 'Bid Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `settlement_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Statement Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Award Confirmation Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'CONFIRMED|REVISED|CANCELLED|SETTLED|DISPUTED');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `award_version` SET TAGS ('dbx_business_glossary_term' = 'Award Version');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `awarded_quantity_mw` SET TAGS ('dbx_business_glossary_term' = 'Awarded Quantity (Megawatts - MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `awarded_quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Awarded Quantity (Megawatt-Hours - MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `block_dispatch_flag` SET TAGS ('dbx_business_glossary_term' = 'Block Dispatch Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `clearing_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Clearing Price per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `clearing_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'DAM|RTM|FTR|CRR|ANCILLARY');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `minimum_run_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Run Time (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `must_run_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Run Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `no_load_cost` SET TAGS ('dbx_business_glossary_term' = 'No-Load Cost');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `no_load_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (Megawatts per Minute - MW/min)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `self_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Schedule Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `settlement_run_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `settlement_run_type` SET TAGS ('dbx_value_regex' = 'INITIAL|FINAL|RESETTLEMENT|TRUE_UP');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `shadow_price` SET TAGS ('dbx_business_glossary_term' = 'Shadow Price');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `shadow_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `startup_cost` SET TAGS ('dbx_business_glossary_term' = 'Startup Cost');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `startup_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ALTER COLUMN `trading_date` SET TAGS ('dbx_business_glossary_term' = 'Trading Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Price ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_run_id` SET TAGS ('dbx_business_glossary_term' = 'Market Run ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `actual_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Load (MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `ancillary_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `congestion_status` SET TAGS ('dbx_business_glossary_term' = 'Congestion Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `congestion_status` SET TAGS ('dbx_value_regex' = 'NONE|BINDING|NON_BINDING');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `current_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Record Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'VALID|ESTIMATED|MISSING|SUSPECT|REVISED');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `lmp_congestion_component` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Congestion Component');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `lmp_energy_component` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Energy Component');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `lmp_loss_component` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Loss Component');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `lmp_total` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Total');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `load_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast (MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'GENERATOR|LOAD|HUB|ZONE|INTERFACE|AGGREGATE');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `marginal_loss_factor` SET TAGS ('dbx_business_glossary_term' = 'Marginal Loss Factor');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_date` SET TAGS ('dbx_business_glossary_term' = 'Market Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_hour` SET TAGS ('dbx_business_glossary_term' = 'Market Hour');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Market Interval End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_run_type` SET TAGS ('dbx_business_glossary_term' = 'Market Run Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_run_type` SET TAGS ('dbx_value_regex' = 'INITIAL|RESETTLEMENT|FINAL');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'DAM|RTM|FMM|IDM');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_value_regex' = 'USD_PER_MWH|CAD_PER_MWH');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `pricing_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `record_effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `record_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `reference_bus_name` SET TAGS ('dbx_business_glossary_term' = 'Reference Bus Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `scarcity_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Scarcity Pricing Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `trading_hub_flag` SET TAGS ('dbx_business_glossary_term' = 'Trading Hub Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Environmental Permit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `ancillary_services_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Participation Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_country_code` SET TAGS ('dbx_business_glossary_term' = 'Business Country Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Business Postal Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_state_province` SET TAGS ('dbx_business_glossary_term' = 'Business State or Province');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `business_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted (United States Dollar)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (United States Dollar)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `dam_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Day-Ahead Market (DAM) Participation Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `etrm_system_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `ferc_mbr_authorization` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Market-Based Rate (MBR) Authorization');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `ftr_crr_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) / Congestion Revenue Right (CRR) Eligibility Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `iso_rto_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Affiliation');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Result');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `last_audit_result` SET TAGS ('dbx_value_regex' = 'passed|passed_with_findings|failed|not_applicable');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `naesb_certification_date` SET TAGS ('dbx_business_glossary_term' = 'North American Energy Standards Board (NAESB) Certification Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `naesb_certification_status` SET TAGS ('dbx_business_glossary_term' = 'North American Energy Standards Board (NAESB) Certification Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `naesb_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|expired|pending');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `nerc_company_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Company Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Notes');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `oatt_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Compliance Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `oatt_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|under_review');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `registered_resource_count` SET TAGS ('dbx_business_glossary_term' = 'Registered Resource Count');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Registration Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `registration_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Registration Expiration Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Registration Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|revoked');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `rtm_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Real-Time Market (RTM) Participation Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `sc_code` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `sc_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `sc_name` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `sc_type` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `sc_type` SET TAGS ('dbx_value_regex' = 'generator|load_serving_entity|marketer|trader|aggregator|hybrid');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Contact Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `scheduling_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Settlement Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Settlement Contact Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Settlement Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `settlement_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `total_registered_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Registered Capacity (Megawatt)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `energy_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Schedule ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `der_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Der Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `forecast_generation_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Generation Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `load_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Load Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `market_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Market Participant ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `planned_outage_window_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Window Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Position ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `scheduling_coordinator_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator (SC) ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `path_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `transmission_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Agreement ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_value_regex' = 'regulation_up|regulation_down|spinning_reserve|non_spinning_reserve|replacement_reserve|voltage_support');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `balancing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority (BA) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `balancing_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Schedule Comments');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `congestion_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Congestion Charge (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `curtailment_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `curtailment_mw` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `curtailment_reason` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `curtailment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `dynamic_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Schedule Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `etag_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Tag (e-Tag) Reference Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `etag_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `loss_factor` SET TAGS ('dbx_business_glossary_term' = 'Transmission Loss Factor');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `number_of_intervals` SET TAGS ('dbx_business_glossary_term' = 'Number of Intervals');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Priority Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'firm|non_firm|conditional_firm|network');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `rec_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `schedule_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `schedule_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'bilateral|day_ahead_market|real_time_market|ancillary_service|wheel_through|dynamic');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `scheduled_mw` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Megawatts (MW)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `scheduled_mwh` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Megawatt-Hours (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `scheduling_fee_usd` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Fee (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `settlement_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|preliminary|final|disputed|adjusted');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `sink_pnode` SET TAGS ('dbx_business_glossary_term' = 'Sink Pricing Node (PNode)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `sink_pnode` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `source_pnode` SET TAGS ('dbx_business_glossary_term' = 'Source Pricing Node (PNode)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `source_pnode` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `transmission_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Transmission Charge (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `market_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Market Settlement Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `dr_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Forecast Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `market_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Market Participant Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `planned_outage_window_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Window Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `tertiary_market_transaction_trade_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `ancillary_service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `capacity_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Capacity Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `congestion_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Congestion Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `cumulative_profit_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Profit and Loss (P&L) Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `delivery_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `delivery_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `dispute_raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `energy_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `ftr_congestion_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Transmission Right (FTR) Congestion Revenue Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `gl_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `imbalance_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Imbalance Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `loss_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `netting_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Netting Adjustment Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|paid|received|overdue|defaulted');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `rec_price_per_certificate` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Price per Certificate (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Interval Duration (Minutes)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Settlement Price per Megawatt-Hour (MWh)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Settlement Quantity (Megawatt-Hours)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `total_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Settlement Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ALTER COLUMN `uplift_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Uplift Charge Amount (USD)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Approval Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|terminated');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'generator|marketer|utility|financial_institution|municipality|cooperative');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Effective Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_fitch` SET TAGS ('dbx_business_glossary_term' = 'Fitch Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_fitch` SET TAGS ('dbx_value_regex' = 'AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC|CC|C|RD|D|NR');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_fitch` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_moodys` SET TAGS ('dbx_business_glossary_term' = 'Moodys Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_moodys` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_business_glossary_term' = 'Standard & Poors (S&P) Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_value_regex' = 'AAA|AA+|AA|AA-|A+|A|A-|BBB+|BBB|BBB-|BB+|BB|BB-|B+|B|B-|CCC+|CCC|CCC-|CC|C|D|NR');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `credit_rating_sp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `csa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Effective Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `csa_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Reference');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `eic_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Identification Code (EIC)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `eic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}[A-Z0-9]{14}[A-Z]{1}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `ferc_eqr_counterparty_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Electric Quarterly Report (EQR) Counterparty Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `internal_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Limit');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `internal_credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `isda_effective_date` SET TAGS ('dbx_business_glossary_term' = 'ISDA Master Agreement Effective Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `isda_master_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'International Swaps and Derivatives Association (ISDA) Master Agreement Reference');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `iso_rto_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Participant Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `nerc_entity_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Entity Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `nerc_registered_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Registered Entity Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Notes');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `parent_company_duns` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Data Universal Numbering System (DUNS) Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `parent_company_duns` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Short Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Termination Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`counterparty` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `energy_price_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Price Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `primary_credit_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `collateral_posted_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|letter_of_credit|parent_guarantee|surety_bond|other');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `confidence_level_pct` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `counterparty_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Rating');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `credit_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Breach Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `credit_limit_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Utilization Percentage');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure As-Of Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Exposure Calculation Method');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_calculation_method` SET TAGS ('dbx_value_regex' = 'current_exposure|peak_exposure|monte_carlo|historical_simulation|variance_covariance');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `exposure_status` SET TAGS ('dbx_value_regex' = 'normal|watch|breach|suspended|default');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `ferc_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Reporting Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `internal_credit_score` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Score');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_due_date` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Due Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Issued Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Threshold Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `mtm_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `net_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `pfe_amount` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE) Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `rec_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Time Horizon Days');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `total_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Exposure Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `market_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Market Participant ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Committee Approval Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Name');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_status` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Status');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_approval');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_type` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `book_type` SET TAGS ('dbx_value_regex' = 'physical|financial|hedging|proprietary|structured|ancillary_services');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `collateral_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Management Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Effective Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `emissions_allowance_registry_code` SET TAGS ('dbx_business_glossary_term' = 'Emissions Allowance Registry ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `emissions_allowance_registry_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `ferc_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'FERC Reporting Category');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `ferc_reporting_category` SET TAGS ('dbx_value_regex' = 'wholesale_power|natural_gas|transmission_rights|ancillary_services|exempt');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Accounting Designation');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `internal_notes` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `iso_rto_code` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) or Regional Transmission Organization (RTO) Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `master_netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Netting Agreement Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `position_limit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Position Limit Quantity');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `position_limit_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `position_limit_uom` SET TAGS ('dbx_business_glossary_term' = 'Position Limit Unit of Measure');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `position_limit_uom` SET TAGS ('dbx_value_regex' = 'MWh|MMBtu|tons|certificates|allowances');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System ID');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `risk_limit_var` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Limit');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `risk_limit_var` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `scheduling_coordinator_flag` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator Flag');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Termination Date');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'mark_to_market|mark_to_model|accrual|lower_of_cost_or_market');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `var_confidence_level` SET TAGS ('dbx_business_glossary_term' = 'VaR Confidence Level Percentage');
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'VaR Time Horizon in Days');
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` SET TAGS ('dbx_subdomain' = 'trade_execution');
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ALTER COLUMN `settlement_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Statement Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ALTER COLUMN `corrected_settlement_statement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ALTER COLUMN `dr_program_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Program Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ALTER COLUMN `master_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `market_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Market Participant Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `parent_market_participant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `market_participant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `market_participant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_participant` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` SET TAGS ('dbx_subdomain' = 'portfolio_operations');
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` ALTER COLUMN `parent_portfolio_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` SET TAGS ('dbx_subdomain' = 'market_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` ALTER COLUMN `market_run_id` SET TAGS ('dbx_business_glossary_term' = 'Market Run Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` ALTER COLUMN `forecast_run_id` SET TAGS ('dbx_business_glossary_term' = 'Forecast Run Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` ALTER COLUMN `superseded_market_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` SET TAGS ('dbx_subdomain' = 'portfolio_operations');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `delivery_point_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Identifier');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `aggregate_delivery_point_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `load_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Load Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Asset Registry Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `pnode_id` SET TAGS ('dbx_business_glossary_term' = 'Pnode Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
